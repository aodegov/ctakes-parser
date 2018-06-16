-- =============================================
-- Author:		<MC>
-- Create date: <12.09.2017>
-- Description:	<Receiving NLP data>
-- =============================================
CREATE PROCEDURE [dbo].[Get_NLP_Data]
	@note_id Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	 SELECT * FROM (

		SELECT
				[note_condition__id] AS Valid_Condition_Id
				, -1 AS Rej_Condition_Id
				, CASE nc.[condition_status_flag]
					WHEN 'N' THEN 'Found'
					WHEN 'A' THEN 'Accepted'
					END AS Status
				, nc.[confidence] 
				, nc.[condition_source_value]  AS ICD10
				, hcc.[icd10_description]
				, '' AS Rej_Reason 
				, nc.[related_text]
				, nc.[related_start]
				, nc.[related_end]
				, nc.[snomed_code]
			FROM [MedNotes].[dbo].[NOTE_CONDITION] nc
			INNER JOIN [pics]..[ref_icd10] hcc 
					ON nc.[condition_source_value] = hcc.[icd10_code] 
			WHERE nc.[note_id] = @note_id AND [condition_status_flag] != 'U' 

		UNION

		SELECT
				-1 AS Valid_Condition_Id
				, [rejected_condition__id] AS Rej_Condition_Id
				, 'Rejected' AS Status
				, rd.[confidence] 
				, rd.[condition_source_value]  AS ICD10
				, hcc.[icd10_description]
				, rd.[rejected_reason] AS Rej_Reason
				, rd.[related_text]
				, rd.[related_start]
				, rd.[related_end]
				, rd.[snomed_code]
			FROM [MedNotes].[dbo].[REJECTED_DIAGNOSIS] rd
			INNER JOIN [pics]..[ref_icd10] hcc 
					ON rd.[condition_source_value] = hcc.[icd10_code] 
			WHERE rd.[note_id] = @note_id 

		)AS Union_TBL

		ORDER BY related_start

END