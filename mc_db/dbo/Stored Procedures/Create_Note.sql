-- =============================================
-- Author:		<MC>
-- Create date: <12/21/2017>
-- Description:	<Create new Note from windows service data>
-- =============================================
CREATE PROCEDURE [dbo].[Create_Note]
	@note_type VARCHAR(20),
	@provider_id INT,
	@person_id INT,
	@input_file VARCHAR(255)
AS
BEGIN

SET NOCOUNT ON;

	DECLARE @new_note_Id INT
    SELECT @new_note_Id = ISNULL(MAX([note_id]),0)+1 FROM NOTES

	INSERT INTO [dbo].[NOTES]
           ([note_id]
           ,[note_type]
           ,[note_date]
           ,[issued_by_provider_id]
           ,[person_id]
           ,[note_status_type]
           ,[input_file])
    VALUES
           ( @new_note_Id
           , @note_type
           , GETDATE()
           ,@provider_id
           ,@person_id
           ,'N'
           ,@input_file)
END