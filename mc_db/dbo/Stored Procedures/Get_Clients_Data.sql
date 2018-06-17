-- =============================================
-- Author:		<MC>
-- Create date: <11/10/2017>
-- Description:	<Retrive clients data>
-- =============================================
CREATE PROCEDURE [Get_Clients_Data]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT 
		  DISTINCT client_id, client_name 
	FROM [$(pics_db)]..[client]
END