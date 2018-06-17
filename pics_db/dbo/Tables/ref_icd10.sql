CREATE TABLE [dbo].[ref_icd10]
(
	[Id] INT NOT NULL PRIMARY KEY,
	icd10_code varchar(max),
	icd10_description varchar(max),
	in_cms_ind int,
)
