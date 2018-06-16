-- =============================================
-- Author:		<MC>
-- Create date: <1/29/2018>
-- Description:	<To get the documents by the patient id>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Patient_Documents]
	-- Add the parameters for the stored procedure here
	@person_id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT output_html_file,
		   FORMAT (process_date, 'd', 'en-US' )
	FROM  [MedNotes].[dbo].[NOTES]
	WHERE person_id = @person_id 
	ORDER BY process_date DESC
END