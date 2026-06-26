/* Object:  Table [dwh].[dimSupplier] */
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
            WHERE   [name]              = N'fk_factSupplierPerformance_dimSupplier'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factSupplierPerformance]')
        )
        BEGIN
            ALTER TABLE [dwh].[factSupplierPerformance]
                DROP CONSTRAINT [fk_factSupplierPerformance_dimSupplier];
            PRINT 'FK [fk_factSupplierPerformance_dimSupplier] dropped successfully.'
        END

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'dimSupplier'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[dimSupplier]
                DROP CONSTRAINT IF EXISTS [pk_dimSupplier];
            DROP TABLE [dwh].[dimSupplier];
            PRINT 'Table [dwh].[dimSupplier] dropped successfully.'
        END

    CREATE TABLE [dwh].[dimSupplier]
        (
            [supplierKey]           INT             NOT NULL,
            [supplierCode]          VARCHAR(12)     NULL,
            [accountNumber]         INT             NULL,
            [shortName]             VARCHAR(30)     NULL,
            [fullName]              VARCHAR(50)     NULL,
            [address1]              VARCHAR(50)     NULL,
            [address2]              VARCHAR(50)     NULL,
            [address3]              VARCHAR(50)     NULL,
            [address4]              VARCHAR(50)     NULL,
            [city]                  VARCHAR(50)     NULL,
            [state]                 VARCHAR(40)     NULL,
            [zipcode]               VARCHAR(10)     NULL,
            [country]               VARCHAR(50)     NULL,
            [phoneNumber]           VARCHAR(20)     NULL,
            [status]                VARCHAR(10)     NULL,
            [emailAddress]          VARCHAR(200)    NULL,
            [website]               VARCHAR(100)    NULL,
            [contactName]           VARCHAR(100)    NULL,
            [contactTitle]          VARCHAR(50)     NULL,
            [effectiveTimestamp]    DATETIME        NULL,
            [expiryTimestamp]       DATETIME        NULL,
            [isCurrent]             TINYINT         NULL,
            [sourceSystemCode]      TINYINT         NULL,
            [createTimestamp]       DATETIME        NULL,
            [updateTimestamp]       DATETIME        NULL,

            CONSTRAINT [pk_dimSupplier] PRIMARY KEY CLUSTERED
                (
                    [supplierKey] ASC
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

    PRINT 'Table [dwh].[dimSupplier] created successfully.'

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factSupplierPerformance'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factSupplierPerformance]
                ADD CONSTRAINT  [fk_factSupplierPerformance_dimSupplier]
                FOREIGN KEY     ([supplierKey])
                REFERENCES      [dwh].[dimSupplier] ([supplierKey]);
            PRINT 'FK [fk_factSupplierPerformance_dimSupplier] recreated successfully.'
        END
    ELSE
        BEGIN
            PRINT 'Table [dwh].[factSupplierPerformance] does not exist yet.'
            PRINT 'FK [fk_factSupplierPerformance_dimSupplier] will be added when fact table is created.'
        END

    COMMIT TRANSACTION
    PRINT 'Success - [dwh].[dimSupplier] created and committed.'


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
WHERE       [c].[object_id] = OBJECT_ID(N'[dwh].[dimSupplier]')
ORDER BY    [c].[column_id];
GO
