-- =============================================
-- Author:		<MC>
-- Create date: <12/20/2017>
-- Description:	<Get ICD 10 data by the SNOMED codes>
-- =============================================
CREATE PROCEDURE [dbo].[Get_ICD10_By_SNOMED]
    @SNOMED_LST dbo.[SnomedCodesList] READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT DISTINCT
       [snomed_code]
      ,[snomed_description]
      ,[icd10_code]
      ,[icd10_description]
	FROM [dbo].[SNOMED_TO_ICD10]
		WHERE 
				[snomed_code] IN (SELECT lst.[Code] FROM @SNOMED_LST lst)
			AND
				[icd10_code] IS NOT NULL
END