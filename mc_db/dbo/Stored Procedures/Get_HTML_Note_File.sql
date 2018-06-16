-- =============================================
-- Author:		<MC>
-- Description:	<Get HTML file for current npte>
-- =============================================
CREATE PROCEDURE [dbo].[Get_HTML_Note_File]
	@note_id Int
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT [output_html_file]
       FROM [MedNotes].[dbo].[NOTES]
		WHERE [note_id] = @note_id
END