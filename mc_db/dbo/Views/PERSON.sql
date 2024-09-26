CREATE VIEW dbo.PERSON
AS
SELECT        p.person_id, p.MRN, p.DOB, p.first_name, p.last_name, c.client_id, p.gender, p.race_concept_id
FROM            [$(pics_db)].dbo.person AS p INNER JOIN
                         [$(pics_db)].dbo.client AS c ON c.client_id = p.client_id
GO
