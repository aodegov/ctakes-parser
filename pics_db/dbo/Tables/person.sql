CREATE TABLE [dbo].[person]
(
	person_id INT NOT NULL PRIMARY KEY,
	MRN int null,
	DOB datetime2 null,
	first_name varchar(max),
	last_name varchar(max),
	gender char(1),
	race_concept_id int,
	client_id int,
)
