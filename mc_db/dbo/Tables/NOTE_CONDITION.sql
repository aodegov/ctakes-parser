CREATE TABLE [dbo].[NOTE_CONDITION] (
    [note_condition__id]     INT           NOT NULL,
    [note_id]                INT           NOT NULL,
    [condition_source_value] VARCHAR (50)  NOT NULL,
    [condition_concept_id]   INT           NULL,
    [condition_entry_date]   DATETIME      NOT NULL,
    [user_id]                INT           NOT NULL,
    [condition_status_flag]  VARCHAR (1)   NULL,
    [confidence]             VARCHAR (50)  NULL,
    [how_identified]         VARCHAR (150) NULL,
    [related_text]           VARCHAR (250) NULL,
    [related_start]          INT           NULL,
    [related_end]            INT           NULL,
    [snomed_code]            VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([note_condition__id] ASC)
);

