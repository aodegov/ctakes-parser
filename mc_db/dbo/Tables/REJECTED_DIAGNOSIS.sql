CREATE TABLE [dbo].[REJECTED_DIAGNOSIS] (
    [rejected_condition__id] INT           NOT NULL,
    [note_id]                INT           NOT NULL,
    [condition_source_value] VARCHAR (50)  NOT NULL,
    [condition_concept_id]   INT           NULL,
    [condition_entry_date]   DATETIME      NOT NULL,
    [user_id]                INT           NOT NULL,
    [confidence]             VARCHAR (50)  NULL,
    [rejected_reason]        VARCHAR (250) NULL,
    [related_text]           VARCHAR (250) NULL,
    [related_start]          INT           NULL,
    [related_end]            INT           NULL,
    [snomed_code]            VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([rejected_condition__id] ASC)
);

