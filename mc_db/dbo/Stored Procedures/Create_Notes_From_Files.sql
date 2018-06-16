-- =============================================
-- Author:		 <MC>
-- Create date:  <14-06-2018>
-- Description:	 <Creation the new notes from <input> files directory >
-- =============================================
CREATE PROCEDURE [dbo].[Create_Notes_From_Files]
	@filePath VARCHAR(1000),
	@note_type VARCHAR(20),
	@provider_id INT,
	@person_id INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @max_id INT;
	DECLARE @innerSql VARCHAR(1000);
	DECLARE  @file_name VARCHAR(500);

	DECLARE @Result TABLE
	(
		subdirectory varchar(500), 
		depth int,
		[file] int
	)

	SET @innerSql = 'EXEC xp_dirtree '''+@filePath+''', 1, 1';

	INSERT @Result EXEC (@innerSql)
		   SELECT * FROM @Result 
		   WHERE [file] != 0 AND depth = 1

	SELECT @max_id = MAX([note_id]) FROM [MedNotes].[dbo].[NOTES]

	DECLARE file_cursor CURSOR FOR   
			SELECT subdirectory FROM @Result
			WHERE [file] != 0 AND depth = 1

	OPEN file_cursor  

		FETCH NEXT FROM file_cursor   
		INTO  @file_name  

		WHILE @@FETCH_STATUS = 0  
			BEGIN  
				SET @max_id += 1;
				INSERT INTO [MedNotes].[dbo].[NOTES] VALUES (@max_id, @note_type, GetDate(), @provider_id, @person_id, 'N', @file_name, NULL, NULL)
						   -- Get the next file.  
					FETCH NEXT FROM file_cursor   
					INTO @file_name
			END   

	CLOSE file_cursor;  
	DEALLOCATE file_cursor; 

END