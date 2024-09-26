-- =============================================
-- Author:		<MC>
-- Create date: <09/12/2017>
-- Description:	<Receiving stored "Unidentified added dianosis" data>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Unidentified_Data]
	@note_id Int
AS
BEGIN

SET NOCOUNT ON;

    SELECT
	     nc.[condition_source_value] 
        ,nc.[how_identified]
		,icd10.[icd10_description]
		,nc.[related_text]
		,nc.[related_start]
		,nc.[related_end]
    FROM [dbo].[NOTE_CONDITION] nc
	INNER JOIN [$(pics_db)]..[ref_icd10] icd10
		ON icd10.icd10_code = nc.condition_source_value
    WHERE [condition_status_flag] = 'U' 
        AND [note_id] = @note_id
END