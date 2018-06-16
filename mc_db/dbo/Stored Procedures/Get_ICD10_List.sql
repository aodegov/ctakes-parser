-- =============================================
-- Author:		<MC>
-- Create date: <09/12/2017>
-- Description:	<ICD10 codes and descriptions for drop down list in "Unidentified added dianosis" table>
-- =============================================
CREATE PROCEDURE [dbo].[Get_ICD10_List]
	@note_id INT,
	@query_val VARCHAR(25)
AS
BEGIN

	SET NOCOUNT ON;

    SELECT
	                 [icd10_code]
                    ,[icd10_description]
    FROM [pics]..[ref_icd10]
		WHERE 
			[icd10_code] NOT IN (SELECT [condition_source_value] 
								   FROM [MedNotes].[dbo].[NOTE_CONDITION] 
										WHERE [note_id] = @note_id 
											AND [condition_status_flag] != 'U')
        AND   
            [icd10_code] NOT IN (SELECT [condition_source_value] 
									FROM [MedNotes].[dbo].[REJECTED_DIAGNOSIS] 
										WHERE [note_id] = @note_id)
        AND 
			in_cms_ind = 1

		AND ([icd10_code] LIKE'%' + @query_val + '%' OR [icd10_description] LIKE'%' + @query_val + '%')
END