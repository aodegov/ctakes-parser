CREATE VIEW dbo.PROVIDER
AS
SELECT DISTINCT provider_id, NPI_id, first_name, last_name, status_flag
FROM            pics.dbo.provider AS provider_1
GO

