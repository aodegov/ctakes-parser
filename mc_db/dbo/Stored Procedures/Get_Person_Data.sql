
-- =============================================
-- Author:		<MC>
-- Create date: <12.09.2017>
-- Description:	<Receiving person data by id>
-- =============================================
CREATE PROCEDURE [dbo].[Get_Person_Data]
	@note_id Int
AS
BEGIN

SET NOCOUNT ON;

    SELECT TOP 1
		   nt.[person_id],
		   ISNULL(pd.full_name, 'Unknown') AS ProviderName,
		   ISNULL(ps.MRN,'') AS MRN,
		   CASE WHEN ps.last_name IS NULL THEN '' ELSE ps.last_name + ', ' END + ISNULL(ps.first_name,'') AS PersonName,
		   FORMAT (ps.DOB, 'd', 'en-US' ) AS DOB,
		   CONVERT(NVARCHAR(3), FLOOR(DATEDIFF(day,ps.DOB,GETDATE())/365.00 )) AS Age,
		   ISNULL(ps.gender,'') AS Gender,
		   ISNULL(ct.concept_name,'Unknown') AS Race,
		   FORMAT (nt.[note_date], 'd', 'en-US' ) AS NoteDate
	 FROM [dbo].[NOTES] AS nt
		 INNER JOIN [dbo].[PERSON] AS ps 
			ON nt.person_id = ps.person_id
		 LEFT JOIN [$(pics_db)]..[provider] AS pd
			ON nt.issued_by_provider_id = pd.provider_id
		 LEFT JOIN [$(cdm)]..[concept] AS ct
			ON ps.race_concept_id = ct.concept_id
	 WHERE nt.[note_id] = @note_id

END