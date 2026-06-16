/* Object:  Table [dwh].[dimCommunication] */

USE [DDS];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO


BEGIN TRY

    BEGIN TRANSACTION

    /* FK on factCampaignResult */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factCampaignResult_dimCommunication'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factCampaignResult]')
        )
        BEGIN
            ALTER TABLE [dwh].[factCampaignResult]
                DROP CONSTRAINT [fk_factCampaignResult_dimCommunication];
            PRINT 'FK [fk_factCampaignResult_dimCommunication] dropped successfully.'
        END

    /* FK on factCommunicationSubscription */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factCommunicationSubscription_dimCommunication'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factCommunicationSubscription]')
        )
        BEGIN
            ALTER TABLE [dwh].[factCommunicationSubscription]
                DROP CONSTRAINT [fk_factCommunicationSubscription_dimCommunication];
            PRINT 'FK [fk_factCommunicationSubscription_dimCommunication] dropped successfully.'
        END

    /* Drop dimCommunication if it already exists */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'dimCommunication'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[dimCommunication]
                DROP CONSTRAINT IF EXISTS [pk_dimCommunication];
            DROP TABLE [dwh].[dimCommunication];
            PRINT 'Table [dwh].[dimCommunication] dropped successfully.'
        END

    /* Create dimCommunication table on dds_fg6 */
    CREATE TABLE [dwh].[dimCommunication]
        (
            [communicationKey]      INT             NOT NULL,
            [title]                 VARCHAR(50)     NULL,
            [description]           VARCHAR(200)    NULL,
            [format]                VARCHAR(20)     NULL,
            [language]              VARCHAR(50)     NULL,
            [category]              VARCHAR(20)     NULL,
            [issuingUnit]           VARCHAR(30)     NULL,
            [issuingCountry]        CHAR(3)         NULL,
            [startDate]             DATETIME        NULL,
            [endDate]               DATETIME        NULL,
            [status]                VARCHAR(10)     NULL,
            [sourceSystemCode]      TINYINT         NOT NULL,
            [createTimestamp]       DATETIME        NOT NULL,
            [updateTimestamp]       DATETIME        NOT NULL,

            CONSTRAINT [pk_dimCommunication] PRIMARY KEY CLUSTERED
                (
                    [communicationKey] ASC
                )
                WITH
                (
                    STATISTICS_NORECOMPUTE      = OFF,
                    IGNORE_DUP_KEY              = OFF,
                    OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
                )
                ON [dds_fg6]

        )

        ON [dds_fg6];

    PRINT 'Table [dwh].[dimCommunication] created successfully.'

    /* Recreate FK on factCampaignResult */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factCampaignResult'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factCampaignResult]
                ADD CONSTRAINT  [fk_factCampaignResult_dimCommunication]
                FOREIGN KEY     ([communicationKey])
                REFERENCES      [dwh].[dimCommunication] ([communicationKey]);
            PRINT 'FK [fk_factCampaignResult_dimCommunication] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factCampaignResult] does not exist yet.'
            PRINT 'FK [fk_factCampaignResult_dimCommunication] will be added when fact table is created.'
        END

    /* Recreate FK on factCommunicationSubscription */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factCommunicationSubscription'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factCommunicationSubscription]
                ADD CONSTRAINT  [fk_factCommunicationSubscription_dimCommunication]
                FOREIGN KEY     ([communicationKey])
                REFERENCES      [dwh].[dimCommunication] ([communicationKey]);
            PRINT 'FK [fk_factCommunicationSubscription_dimCommunication] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factCommunicationSubscription] does not exist yet.'
            PRINT 'FK [fk_factCommunicationSubscription_dimCommunication] will be added when fact table is created.'
        END

    /* Commit if all steps succeeded */
    COMMIT TRANSACTION
    PRINT 'Success - [dwh].[dimCommunication] created and committed.'


END TRY
BEGIN CATCH

    /* Check @@TRANCOUNT before rollback */
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION

    PRINT 'Error - all changes rolled back.'
    PRINT ERROR_MESSAGE();

END CATCH
GO

/* Verify dimCommunication was created successfully */
SELECT
    [c].[name]              AS [ColumnName],
    [t].[name]              AS [DataType],
    [c].[max_length]        AS [MaxLength],
    [c].[is_nullable]       AS [IsNullable]
FROM        [sys].[columns]         AS [c]
INNER JOIN  [sys].[types]           AS [t]
    ON  [c].[user_type_id]  = [t].[user_type_id]
WHERE       [c].[object_id] = OBJECT_ID(N'[dwh].[dimCommunication]')
ORDER BY    [c].[column_id];
GO
