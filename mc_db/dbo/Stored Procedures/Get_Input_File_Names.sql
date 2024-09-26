-- =============================================
-- Author:		<MC>
-- Create date: <01/04/2018>
-- Description:	<get the names of the input files>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Input_File_Names]

AS	
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT DISTINCT
		 [note_id]
		,[input_file]
	FROM [dbo].[NOTES]
		WHERE [process_date] IS NULL
END