/* Object:  Table [dwh].[dimFormat] */
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
            WHERE   [name]              = N'fk_factSubscriptionSales_dimFormat'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factSubscriptionSales]')
        )
        BEGIN
            ALTER TABLE [dwh].[factSubscriptionSales]
                DROP CONSTRAINT [fk_factSubscriptionSales_dimFormat];
            PRINT 'FK [fk_factSubscriptionSales_dimFormat] dropped successfully.'
        END

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'dimFormat'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[dimFormat]
                DROP CONSTRAINT IF EXISTS [pk_dimFormat];
            DROP TABLE [dwh].[dimFormat];
            PRINT 'Table [dwh].[dimFormat] dropped successfully.'
        END

    CREATE TABLE [dwh].[dimFormat]
        (
            [formatKey]             INT             NOT NULL,
            [name]                  VARCHAR(30)     NULL,
            [description]           VARCHAR(50)     NULL,
            [media]                 VARCHAR(15)     NULL,
            [sourceSystemCode]      TINYINT         NOT NULL,
            [createTimestamp]       DATETIME        NOT NULL,
            [updateTimestamp]       DATETIME        NOT NULL,
            CONSTRAINT [pk_dimFormat] PRIMARY KEY CLUSTERED
                (
                    [formatKey] ASC
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

    PRINT 'Table [dwh].[dimFormat] created successfully.'

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factSubscriptionSales'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factSubscriptionSales]
                ADD CONSTRAINT  [fk_factSubscriptionSales_dimFormat]
                FOREIGN KEY     ([formatKey])
                REFERENCES      [dwh].[dimFormat] ([formatKey]);
            PRINT 'FK [fk_factSubscriptionSales_dimFormat] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factSubscriptionSales] does not exist yet.'
            PRINT 'FK [fk_factSubscriptionSales_dimFormat] will be added when fact table is created.'
        END

    COMMIT TRANSACTION
    PRINT 'Success - [dwh].[dimFormat] created and committed.'


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
WHERE       [c].[object_id] = OBJECT_ID(N'[dwh].[dimFormat]')
ORDER BY    [c].[column_id];
GO
