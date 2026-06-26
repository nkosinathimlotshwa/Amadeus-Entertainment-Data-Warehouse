/* Object:  Table [dwh].[dimProduct] */

USE [DDS];
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO


BEGIN TRY

    BEGIN TRANSACTION

    /* FK on factProductSales */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factProductSales_dimProduct'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factProductSales]')
        )
        BEGIN
            ALTER TABLE [dwh].[factProductSales]
                DROP CONSTRAINT [fk_factProductSales_dimProduct];
            PRINT 'FK [fk_factProductSales_dimProduct] dropped successfully.'
        END

    /* FK on factSupplierPerformance */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factSupplierPerformance_dimProduct'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factSupplierPerformance]')
        )
        BEGIN
            ALTER TABLE [dwh].[factSupplierPerformance]
                DROP CONSTRAINT [fk_factSupplierPerformance_dimProduct];
            PRINT 'FK [fk_factSupplierPerformance_dimProduct] dropped successfully.'
        END

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'dimProduct'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[dimProduct]
                DROP CONSTRAINT IF EXISTS [pk_dimProduct];
            DROP TABLE [dwh].[dimProduct];
            PRINT 'Table [dwh].[dimProduct] dropped successfully.'
        END

    CREATE TABLE [dwh].[dimProduct]
        (
            [productKey]            INT             NOT NULL,
            [productCode]           VARCHAR(10)     NULL,
            [name]                  VARCHAR(50)     NULL,
            [description]           VARCHAR(100)    NULL,
            [title]                 VARCHAR(100)    NULL,
            [artist]                VARCHAR(100)    NULL,
            [productType]           VARCHAR(20)     NULL,
            [productCategory]       VARCHAR(30)     NULL,
            [format]                VARCHAR(30)     NULL,
            [media]                 VARCHAR(15)     NULL,
            [unitPrice]             SMALLMONEY      NULL,
            [unitCost]              SMALLMONEY      NULL,
            [status]                VARCHAR(15)     NULL,
            [sourceSystemCode]      TINYINT         NULL,
            [createTimestamp]       DATETIME        NULL,
            [updateTimestamp]       DATETIME        NULL,

            CONSTRAINT [pk_dimProduct] PRIMARY KEY CLUSTERED
                (
                    [productKey] ASC
                )
                WITH
                (
                    STATISTICS_NORECOMPUTE      = OFF,
                    IGNORE_DUP_KEY              = OFF,
                    OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
                )
                ON [dds_fg6]

        )
        /* Table data stored on dds_fg6 */
        ON [dds_fg6];

    PRINT 'Table [dwh].[dimProduct] created successfully.'

    /* Recreate FK on factProductSales */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factProductSales'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factProductSales]
                ADD CONSTRAINT  [fk_factProductSales_dimProduct]
                FOREIGN KEY     ([productKey])
                REFERENCES      [dwh].[dimProduct] ([productKey]);
            PRINT 'FK [fk_factProductSales_dimProduct] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factProductSales] does not exist yet.'
            PRINT 'FK [fk_factProductSales_dimProduct] will be added when fact table is created.'
        END

    /* Recreate FK on factSupplierPerformance */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factSupplierPerformance'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factSupplierPerformance]
                ADD CONSTRAINT  [fk_factSupplierPerformance_dimProduct]
                FOREIGN KEY     ([productKey])
                REFERENCES      [dwh].[dimProduct] ([productKey]);
            PRINT 'FK [fk_factSupplierPerformance_dimProduct] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factSupplierPerformance] does not exist yet.'
            PRINT 'FK [fk_factSupplierPerformance_dimProduct] will be added when fact table is created.'
        END

    /* Index on productCode */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[indexes]
            WHERE   [name]      = N'IX_dimProduct_productCode'
            AND     [object_id] = OBJECT_ID(N'[dwh].[dimProduct]')
        )
        DROP INDEX [IX_dimProduct_productCode] ON [dwh].[dimProduct];

    CREATE NONCLUSTERED INDEX [IX_dimProduct_productCode]
        ON  [dwh].[dimProduct] ([productCode])
        ON  [dds_fg6];

    PRINT 'Index [IX_dimProduct_productCode] created successfully.'


    /* Index on title */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[indexes]
            WHERE   [name]      = N'IX_dimProduct_title'
            AND     [object_id] = OBJECT_ID(N'[dwh].[dimProduct]')
        )
        DROP INDEX [IX_dimProduct_title] ON [dwh].[dimProduct];

    CREATE NONCLUSTERED INDEX [IX_dimProduct_title]
        ON  [dwh].[dimProduct] ([title])
        ON  [dds_fg6];

    PRINT 'Index [IX_dimProduct_title] created successfully.'


    /* Index on artist */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[indexes]
            WHERE   [name]      = N'IX_dimProduct_artist'
            AND     [object_id] = OBJECT_ID(N'[dwh].[dimProduct]')
        )
        DROP INDEX [IX_dimProduct_artist] ON [dwh].[dimProduct];

    CREATE NONCLUSTERED INDEX [IX_dimProduct_artist]
        ON  [dwh].[dimProduct] ([artist])
        ON  [dds_fg6];

    PRINT 'Index [IX_dimProduct_artist] created successfully.'


    /* Index on productType */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[indexes]
            WHERE   [name]      = N'IX_dimProduct_productType'
            AND     [object_id] = OBJECT_ID(N'[dwh].[dimProduct]')
        )
        DROP INDEX [IX_dimProduct_productType] ON [dwh].[dimProduct];

    CREATE NONCLUSTERED INDEX [IX_dimProduct_productType]
        ON  [dwh].[dimProduct] ([productType])
        ON  [dds_fg6];

    PRINT 'Index [IX_dimProduct_productType] created successfully.'


    /* Index on productCategory */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[indexes]
            WHERE   [name]      = N'IX_dimProduct_productCategory'
            AND     [object_id] = OBJECT_ID(N'[dwh].[dimProduct]')
        )
        DROP INDEX [IX_dimProduct_productCategory] ON [dwh].[dimProduct];

    CREATE NONCLUSTERED INDEX [IX_dimProduct_productCategory]
        ON  [dwh].[dimProduct] ([productCategory])
        ON  [dds_fg6];

    PRINT 'Index [IX_dimProduct_productCategory] created successfully.'

    COMMIT TRANSACTION
    PRINT 'Success - [dwh].[dimProduct] created and committed.'


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
WHERE       [c].[object_id] = OBJECT_ID(N'[dwh].[dimProduct]')
ORDER BY    [c].[column_id];
GO

SELECT
    [i].[name]              AS [IndexName],
    [i].[type_desc]         AS [IndexType],
    [c].[name]              AS [ColumnName]
FROM        [sys].[indexes]         AS [i]
INNER JOIN  [sys].[index_columns]   AS [ic]
    ON  [i].[object_id]     = [ic].[object_id]
    AND [i].[index_id]      = [ic].[index_id]
INNER JOIN  [sys].[columns]         AS [c]
    ON  [ic].[object_id]    = [c].[object_id]
    AND [ic].[column_id]    = [c].[column_id]
WHERE       [i].[object_id] = OBJECT_ID(N'[dwh].[dimProduct]')
AND         [i].[type]      > 0
ORDER BY    [i].[name];
GO
