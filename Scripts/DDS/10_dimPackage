/* Object:  Table [dwh].[dimPackage] */
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
            WHERE   [name]              = N'fk_factSubscriptionSales_dimPackage'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factSubscriptionSales]')
        )
        BEGIN
            ALTER TABLE [dwh].[factSubscriptionSales]
                DROP CONSTRAINT [fk_factSubscriptionSales_dimPackage];
            PRINT 'FK [fk_factSubscriptionSales_dimPackage] dropped successfully.'
        END

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'dimPackage'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[dimPackage]
                DROP CONSTRAINT IF EXISTS [pk_dimPackage];
            DROP TABLE [dwh].[dimPackage];
            PRINT 'Table [dwh].[dimPackage] dropped successfully.'
        END

    CREATE TABLE [dwh].[dimPackage]
        (
            [packageKey]            INT             NOT NULL,
            [name]                  VARCHAR(30)     NOT NULL,
            [description]           VARCHAR(100)    NULL,
            [packageType]           VARCHAR(15)     NULL,
            [packagePrice]          SMALLMONEY      NULL,
            [sourceSystemCode]      TINYINT         NULL,
            [createTimestamp]       DATETIME        NULL,
            [updateTimestamp]       DATETIME        NULL,
            CONSTRAINT [pk_dimPackage] PRIMARY KEY CLUSTERED
                (
                    [packageKey] ASC
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

    PRINT 'Table [dwh].[dimPackage] created successfully.'

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factSubscriptionSales'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factSubscriptionSales]
                ADD CONSTRAINT  [fk_factSubscriptionSales_dimPackage]
                FOREIGN KEY     ([packageKey])
                REFERENCES      [dwh].[dimPackage] ([packageKey]);
            PRINT 'FK [fk_factSubscriptionSales_dimPackage] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factSubscriptionSales] does not exist yet.'
            PRINT 'FK [fk_factSubscriptionSales_dimPackage] will be added when fact table is created.'
        END

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[indexes]
            WHERE   [name]      = N'IX_dimPackage_name'
            AND     [object_id] = OBJECT_ID(N'[dwh].[dimPackage]')
        )
        DROP INDEX [IX_dimPackage_name] ON [dwh].[dimPackage];

    CREATE NONCLUSTERED INDEX [IX_dimPackage_name]
        ON  [dwh].[dimPackage] ([name])
        ON  [dds_fg6];

    PRINT 'Index [IX_dimPackage_name] created successfully.'

    COMMIT TRANSACTION
    PRINT 'Success - [dwh].[dimPackage] created and committed.'


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
WHERE       [c].[object_id] = OBJECT_ID(N'[dwh].[dimPackage]')
ORDER BY    [c].[column_id];
GO
