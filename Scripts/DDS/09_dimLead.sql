/* Object: Table [dwh].[dimLead] */
USE [DDS];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO


BEGIN TRY

    BEGIN TRANSACTION

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factSubscriptionSales_dimLead'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factSubscriptionSales]')
        )
        BEGIN
            ALTER TABLE [dwh].[factSubscriptionSales]
                DROP CONSTRAINT [fk_factSubscriptionSales_dimLead];
            PRINT 'FK [fk_factSubscriptionSales_dimLead] dropped successfully.'
        END

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'dimLead'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[dimLead]
                DROP CONSTRAINT IF EXISTS [pk_dimLead];
            DROP TABLE [dwh].[dimLead];
            PRINT 'Table [dwh].[dimLead] dropped successfully.'
        END

    CREATE TABLE [dwh].[dimLead]
        (
            [leadKey]               INT             NOT NULL,
            [name]                  VARCHAR(30)     NOT NULL,
            [source]                VARCHAR(50)     NULL,
            [leadUrl]               VARCHAR(100)    NULL,
            [leadTimestamp]         DATETIME        NULL,
            [sourceSystemCode]      TINYINT         NOT NULL,
            [createTimestamp]       DATETIME        NOT NULL,
            [updateTimestamp]       DATETIME        NOT NULL,
            CONSTRAINT [pk_dimLead] PRIMARY KEY CLUSTERED
                (
                    [leadKey] ASC
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

    PRINT 'Table [dwh].[dimLead] created successfully.'

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factSubscriptionSales'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factSubscriptionSales]
                ADD CONSTRAINT  [fk_factSubscriptionSales_dimLead]
                FOREIGN KEY     ([leadKey])
                REFERENCES      [dwh].[dimLead] ([leadKey]);
            PRINT 'FK [fk_factSubscriptionSales_dimLead] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factSubscriptionSales] does not exist yet.'
            PRINT 'FK [fk_factSubscriptionSales_dimLead] will be added when fact table is created.'
        END

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[indexes]
            WHERE   [name]      = N'IX_dimLead_name'
            AND     [object_id] = OBJECT_ID(N'[dwh].[dimLead]')
        )
        DROP INDEX [IX_dimLead_name] ON [dwh].[dimLead];

    CREATE NONCLUSTERED INDEX [IX_dimLead_name]
        ON  [dwh].[dimLead] ([name])
        ON  [dds_fg6];

    PRINT 'Index [IX_dimLead_name] created successfully.'

    COMMIT TRANSACTION
    PRINT 'Success - [dwh].[dimLead] created and committed.'


END TRY
BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION

    PRINT 'Error - all changes rolled back.'
    PRINT ERROR_MESSAGE();

END CATCH
GO

SELECT
    [c].[name]              AS [ColumnName],
    [t].[name]              AS [DataType],
    [c].[max_length]        AS [MaxLength],
    [c].[is_nullable]       AS [IsNullable]
FROM        [sys].[columns]         AS [c]
INNER JOIN  [sys].[types]           AS [t]
    ON  [c].[user_type_id]  = [t].[user_type_id]
WHERE       [c].[object_id] = OBJECT_ID(N'[dwh].[dimLead]')
ORDER BY    [c].[column_id];
GO
