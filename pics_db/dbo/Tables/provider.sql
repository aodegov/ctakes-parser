CREATE TABLE [dbo].[provider]
(
	provider_id INT NOT NULL PRIMARY KEY,
	NPI_id int,
	first_name varchar(max),
	last_name varchar(max),
	full_name varchar(max),
	status_flag char(1),
)
