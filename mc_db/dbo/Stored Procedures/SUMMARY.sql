
-- =============================================
-- Author:		<MC>
-- Create date: <11/13/2017>
-- Description:	<Receiving Summary data>
-- =============================================

CREATE PROCEDURE [dbo].[SUMMARY]
AS
BEGIN

	SET NOCOUNT ON;

        SELECT
                    nt.[note_id],
				    nt.note_date AS NoteDate,
                    CASE 
			        WHEN nt.[note_status_type] = 'I' THEN 'In progress'
			        WHEN nt.[note_status_type] = 'C' THEN 'Complete'
			        WHEN nt.[note_status_type] = 'N' THEN 'Not processed'
		            END AS Status,
					ISNULL(ps.client_id, -1) AS clientId,
		            ISNULL(ps.MRN,'') AS MRN,
		            CASE WHEN ps.last_name IS NULL THEN '' ELSE ps.last_name + ', ' END + ISNULL(ps.first_name,'') AS PersonName,
		            FORMAT (ps.DOB, 'd', 'en-US' ) + ' (' + CONVERT(NVARCHAR(3), FLOOR(DATEDIFF(day,ps.DOB,GETDATE())/365.00 )) + ')' AS DOB,
		            nt.note_type,
		            ISNUll(pr.first_name,'') + ' ' + ISNUll(pr.last_name,'') AS Provider,
		            0 AS DxFound,
		            0 AS DxAccepted,
		            0 AS DxRejected,
		            0 AS DxAdded,
					(SELECT '[' + STUFF((
						SELECT DISTINCT
							',{"hcc_code":' + '"' + ISNULL(hcc.[hcc_code],'Unknown') + '"'
							+ ',"dx_code":' + '"' + mn_icd.[icd10_code] + '"'
							+ ',"description":' + '"' + mn_icd.[icd10_description]+ '"'
							+'}'

						FROM dbo.[SNOMED_TO_ICD10] mn_icd
							INNER JOIN [NOTE_CONDITION] nc ON mn_icd.[icd10_code] = nc.[condition_source_value] 
								   AND nc.note_id = nt.[note_id] 
								   AND nc.condition_status_flag = 'A' 
							LEFT JOIN dbo.[V_REF_ICD_HCC_CODE] hcc ON hcc.[icd_code] = mn_icd.[icd10_code] 

						FOR XML PATH(''), TYPE
					).value('.', 'varchar(max)'), 1, 1, '') + ']') AS InnerData
            INTO #Tmp_Summary
            FROM [NOTES] nt
	            INNER JOIN dbo.[PERSON] ps ON nt.person_id = ps.person_id
	            LEFT JOIN dbo.[PROVIDER] pr ON nt.issued_by_provider_id = pr.provider_id
            ORDER BY PersonName 

            SELECT [note_id], [condition_status_flag], COUNT([condition_status_flag]) AS cnt
            INTO #Tmp_Valid_Flag
            FROM dbo.[NOTE_CONDITION]
	        GROUP BY [note_id], [condition_status_flag]
            ORDER BY [note_id]

			SELECT [note_id], COUNT([note_id]) AS cnt
            INTO #Tmp_Rejected_Flag
            FROM dbo.[REJECTED_DIAGNOSIS]
	        GROUP BY [note_id]
            ORDER BY [note_id]

            UPDATE #Tmp_Summary 
		        SET 
			        DxFound = ISNULL((SELECT SUM(cnt) FROM #Tmp_Valid_Flag tfl WHERE  tsm.[note_id] = tfl.[note_id] AND tfl.[condition_status_flag] IN ('N','A') ),0),
			        DxAccepted = ISNULL((SELECT cnt FROM #Tmp_Valid_Flag tfl WHERE  tsm.[note_id] = tfl.[note_id] AND tfl.[condition_status_flag] = 'A' ),0),
			        DxRejected = ISNULL((SELECT cnt FROM #Tmp_Rejected_Flag tfl WHERE  tsm.[note_id] = tfl.[note_id]),0),
			        DxAdded = ISNULL((SELECT cnt FROM #Tmp_Valid_Flag tfl WHERE  tsm.[note_id] = tfl.[note_id] AND tfl.[condition_status_flag] = 'U' ),0)
	        FROM #Tmp_Summary tsm


            SELECT Status, MRN, PersonName, DOB, note_type, Provider, DxFound, DxAccepted, 
				   DxRejected, DxAdded, ISNULL(InnerData,''), NoteDate, note_id, clientId
            FROM #Tmp_Summary
END


-- CREATE PROCEDURE dbo.Get_Patient_Documents