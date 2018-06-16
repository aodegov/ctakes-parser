CREATE TABLE [dbo].[NOTES] (
    [note_id]               INT           NOT NULL,
    [note_type]             VARCHAR (20)  NOT NULL,
    [note_date]             DATETIME      NOT NULL,
    [issued_by_provider_id] INT           NULL,
    [person_id]             INT           NOT NULL,
    [note_status_type]      VARCHAR (1)   NOT NULL,
    [input_file]            VARCHAR (255) NULL,
    [process_date]          DATETIME      NULL,
    [output_html_file]      VARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([note_id] ASC)
);

