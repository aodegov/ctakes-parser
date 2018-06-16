CREATE TABLE [dbo].[SNOMED_TO_ICD10] (
    [id]                 UNIQUEIDENTIFIER CONSTRAINT [DF_SNOWMED_TO_ICD10_id] DEFAULT (newid()) ROWGUIDCOL NOT NULL,
    [snomed_code]        VARCHAR (50)     NULL,
    [snomed_description] VARCHAR (250)    NULL,
    [icd10_code]         VARCHAR (50)     NULL,
    [icd10_description]  VARCHAR (250)    NULL,
    [model_year]         INT              NULL
);

