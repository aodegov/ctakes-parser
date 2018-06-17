-- =============================================
-- Author:		<MC>
-- Create date: <09/12/2017>
-- Description:	<Receiving data to highlight data NLP text>
-- =============================================
CREATE PROCEDURE  [dbo].[Get_Highlight_Data]
	@note_id Int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    
    SELECT
        hcc.[icd10_description] AS Nlp_Accepted
        , '' AS Nlp_Rejected 
        , nc.[condition_status_flag] As Nlp_flag
		, nc.[related_text] AS Related_text
    FROM [dbo].[NOTE_CONDITION] nc
    INNER JOIN [$(pics_db)]..[ref_icd10] hcc 
            ON nc.[condition_source_value] = hcc.[icd10_code] 
    WHERE nc.[note_id] = @note_id 

UNION

	SELECT
            '' AS Nlp_Accepted
            , hcc.[icd10_description] AS Nlp_Rejected
            , '' AS Nlp_flag
			, '' AS Related_text
    FROM [dbo].[REJECTED_DIAGNOSIS] rd
    INNER JOIN [$(pics_db)]..[ref_icd10] hcc 
            ON rd.[condition_source_value] = hcc.[icd10_code] 
    WHERE rd.[note_id] = @note_id 
END