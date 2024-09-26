CREATE TABLE [dbo].[REF_ICD10_HCC_HIST]
(
	[Id] INT NOT NULL PRIMARY KEY,
	hcc_id int,
	hcc_code varchar(max),
	icd10_code varchar(max),
	cms_hcc_model_year int,
)
