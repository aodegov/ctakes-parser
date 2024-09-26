CREATE TABLE [dbo].[REF_HCC_HIST]
(
	hcc_id INT NOT NULL PRIMARY KEY,
	cms_hcc_model_year int,
	hcc_code varchar(max),
	community_ra_score float,
)
