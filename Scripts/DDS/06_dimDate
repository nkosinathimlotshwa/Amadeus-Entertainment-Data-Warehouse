/* Object:  Table [dwh].[dimDate] */
USE [DDS];
GO

SET LANGUAGE US_ENGLISH;
SET DATEFIRST 7;
SET DATEFORMAT mdy;
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO


BEGIN TRY

    BEGIN TRANSACTION

    /* FK 1 : factCampaignResult - sendDateKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factCampaignResult_dimDate'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factCampaignResult]')
        )
        BEGIN
            ALTER TABLE [dwh].[factCampaignResult]
                DROP CONSTRAINT [fk_factCampaignResult_dimDate];
            PRINT 'FK [fk_factCampaignResult_dimDate] dropped successfully.'
        END

    /* FK 2 : factCommunicationSubscription - subscriptionStartDateKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factCommunicationSubscription_dimDate1'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factCommunicationSubscription]')
        )
        BEGIN
            ALTER TABLE [dwh].[factCommunicationSubscription]
                DROP CONSTRAINT [fk_factCommunicationSubscription_dimDate1];
            PRINT 'FK [fk_factCommunicationSubscription_dimDate1] dropped successfully.'
        END

    /* FK 3 : factCommunicationSubscription - subscriptionEndDateKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factCommunicationSubscription_dimDate2'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factCommunicationSubscription]')
        )
        BEGIN
            ALTER TABLE [dwh].[factCommunicationSubscription]
                DROP CONSTRAINT [fk_factCommunicationSubscription_dimDate2];
            PRINT 'FK [fk_factCommunicationSubscription_dimDate2] dropped successfully.'
        END

    /* FK 4 : factProductSales - salesDateKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factProductSales_dimDate'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factProductSales]')
        )
        BEGIN
            ALTER TABLE [dwh].[factProductSales]
                DROP CONSTRAINT [fk_factProductSales_dimDate];
            PRINT 'FK [fk_factProductSales_dimDate] dropped successfully.'
        END

    /* FK 5 : factSubscriptionSales - dateKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factSubscriptionSales_dimDate1'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factSubscriptionSales]')
        )
        BEGIN
            ALTER TABLE [dwh].[factSubscriptionSales]
                DROP CONSTRAINT [fk_factSubscriptionSales_dimDate1];
            PRINT 'FK [fk_factSubscriptionSales_dimDate1] dropped successfully.'
        END

    /* FK 6 : factSubscriptionSales - startDateKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factSubscriptionSales_dimDate2'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factSubscriptionSales]')
        )
        BEGIN
            ALTER TABLE [dwh].[factSubscriptionSales]
                DROP CONSTRAINT [fk_factSubscriptionSales_dimDate2];
            PRINT 'FK [fk_factSubscriptionSales_dimDate2] dropped successfully.'
        END

    /* FK 7 : factSubscriptionSales - endDateKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factSubscriptionSales_dimDate3'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factSubscriptionSales]')
        )
        BEGIN
            ALTER TABLE [dwh].[factSubscriptionSales]
                DROP CONSTRAINT [fk_factSubscriptionSales_dimDate3];
            PRINT 'FK [fk_factSubscriptionSales_dimDate3] dropped successfully.'
        END

    /* FK 8 : factSupplierPerformance - weekKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factSupplierPerformance_dimDate1'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factSupplierPerformance]')
        )
        BEGIN
            ALTER TABLE [dwh].[factSupplierPerformance]
                DROP CONSTRAINT [fk_factSupplierPerformance_dimDate1];
            PRINT 'FK [fk_factSupplierPerformance_dimDate1] dropped successfully.'
        END

    /* FK 9 : factSupplierPerformance - startDateKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[foreign_keys]
            WHERE   [name]              = N'fk_factSupplierPerformance_dimDate2'
            AND     [parent_object_id]  = OBJECT_ID(N'[dwh].[factSupplierPerformance]')
        )
        BEGIN
            ALTER TABLE [dwh].[factSupplierPerformance]
                DROP CONSTRAINT [fk_factSupplierPerformance_dimDate2];
            PRINT 'FK [fk_factSupplierPerformance_dimDate2] dropped successfully.'
        END

    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'dimDate'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[dimDate]
                DROP CONSTRAINT IF EXISTS [pk_dimDate];
            DROP TABLE [dwh].[dimDate];
            PRINT 'Table [dwh].[dimDate] dropped successfully.'
        END

    CREATE TABLE [dwh].[dimDate]
        (
            [dateKey]               INT             NOT NULL    IDENTITY(1,1),
            [date]                  CHAR(10)        NOT NULL,
            [systemDate]            CHAR(10)        NOT NULL,
            [sqlDate]               DATETIME        NOT NULL,
            [julianDate]            INT             NOT NULL,
            [day]                   TINYINT         NOT NULL,
            [dayOfTheWeek]          TINYINT         NOT NULL,
            [dayName]               VARCHAR(9)      NOT NULL,
            [dayOfTheYear]          SMALLINT        NOT NULL,
            [weekNumber]            TINYINT         NOT NULL,
            [weekDay]               TINYINT         NOT NULL,
            [month]                 TINYINT         NOT NULL,
            [monthName]             VARCHAR(9)      NOT NULL,
            [shortMonthName]        CHAR(3)         NOT NULL,
            [monthEnd]              TINYINT         NOT NULL,
            [quarter]               CHAR(2)         NOT NULL,
            [year]                  SMALLINT        NOT NULL,
            [fiscalWeek]            TINYINT         NULL,
            [fiscalPeriod]          CHAR(4)         NULL,
            [fiscalQuarter]         CHAR(3)         NULL,
            [fiscalYear]            CHAR(6)         NULL,
            [usHoliday]             TINYINT         NULL,
            [ukHoliday]             TINYINT         NULL,
            [periodEnd]             TINYINT         NULL,
            [shortDay]              TINYINT         NULL,
            [sourceSystemCode]      TINYINT         NOT NULL,
            [createTimestamp]       DATETIME        NOT NULL,
            [updateTimestamp]       DATETIME        NOT NULL,
            CONSTRAINT [pk_dimDate] PRIMARY KEY CLUSTERED
                (
                    [dateKey] ASC
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

    PRINT 'Table [dwh].[dimDate] created successfully.'

    DECLARE @StartDate  DATE = '20000101';
    DECLARE @EndDate    DATE = '20351231';

    ;WITH [seq] ([n]) AS
    (
        SELECT  [n] = [value]
        FROM    GENERATE_SERIES
                (
                    0,
                    DATEDIFF(DAY, @StartDate, @EndDate)
                )
    ),
    [dates] ([Date]) AS
    (
        SELECT  CONVERT(DATE, DATEADD(DAY, [n], @StartDate))
        FROM    [seq]
    ),
    [src] AS
    (
        SELECT
            [Date],
            [Day]               = DATEPART(DAY,         [Date]),
            [DayOfTheWeek]      = DATEPART(WEEKDAY,     [Date]),
            [DayName]           = DATENAME(WEEKDAY,     [Date]),
            [DayOfTheYear]      = DATEPART(DAYOFYEAR,   [Date]),
            [WeekNumber]        = DATEPART(WEEK,        [Date]),
            [Month]             = DATEPART(MONTH,       [Date]),
            [MonthName]         = DATENAME(MONTH,       [Date]),
            [Quarter]           = DATEPART(QUARTER,     [Date]),
            [Year]              = DATEPART(YEAR,        [Date]),

            [FiscalYearStart]   = CASE
                                    WHEN DATEPART(MONTH, [Date]) >= 9
                                    THEN DATEFROMPARTS(DATEPART(YEAR, [Date]),     9, 1)
                                    ELSE DATEFROMPARTS(DATEPART(YEAR, [Date]) - 1, 9, 1)
                                  END,

            [FiscalYearLabel]   = CASE
                                    WHEN DATEPART(MONTH, [Date]) >= 9
                                    THEN 'FY' + CAST(DATEPART(YEAR, [Date]) + 1 AS CHAR(4))
                                    ELSE 'FY' + CAST(DATEPART(YEAR, [Date])     AS CHAR(4))
                                  END
        FROM    [dates]
    ),
    [fiscal] AS
    (
        SELECT
            *,
            [FiscalWeek]    = DATEDIFF(WEEK, [FiscalYearStart], [Date]) + 1
        FROM    [src]
    ),
    [dim] AS
    (
        SELECT
            [date]              = CONVERT(CHAR(10),
                                    RIGHT('00' + CAST([Month]   AS VARCHAR(2)), 2)
                                    + '/' +
                                    RIGHT('00' + CAST([Day]     AS VARCHAR(2)), 2)
                                    + '/' +
                                    CAST([Year] AS CHAR(4))),

            [systemDate]        = CONVERT(CHAR(10),
                                    CAST([Year] AS CHAR(4))
                                    + '-' +
                                    RIGHT('00' + CAST([Month]   AS VARCHAR(2)), 2)
                                    + '-' +
                                    RIGHT('00' + CAST([Day]     AS VARCHAR(2)), 2)),

            [sqlDate]           = CONVERT(DATETIME,     [Date]),

            [julianDate]        = DATEDIFF(DAY, '19000101', [Date]),
            [day]               = CONVERT(TINYINT,      [Day]),
            [dayOfTheWeek]      = CONVERT(TINYINT,      [DayOfTheWeek]),
            [dayName]           = CONVERT(VARCHAR(9),   [DayName]),
            [dayOfTheYear]      = CONVERT(SMALLINT,     [DayOfTheYear]),
            [weekNumber]        = CONVERT(TINYINT,      [WeekNumber]),
            [weekDay]           = CONVERT(TINYINT,
                                    CASE
                                        WHEN [DayOfTheWeek] BETWEEN 2 AND 6
                                        THEN 1 ELSE 0
                                    END),
            [month]             = CONVERT(TINYINT,      [Month]),
            [monthName]         = CONVERT(VARCHAR(9),   [MonthName]),
            [shortMonthName]    = CONVERT(CHAR(3),      [MonthName]),
            [monthEnd]          = CONVERT(TINYINT,
                                    CASE
                                        WHEN MONTH(DATEADD(DAY, 1, [Date])) <> [Month]
                                        THEN 1 ELSE 0
                                    END),
            [quarter]           = CONVERT(CHAR(2), 'Q' + CAST([Quarter] AS CHAR(1))),
            [year]              = CONVERT(SMALLINT,     [Year]),
            [fiscalWeek]        = CONVERT(TINYINT,      [FiscalWeek]),
            [fiscalPeriod]      = CONVERT(CHAR(4),
                                    'P' + RIGHT('00' + CAST(
                                        CASE
                                            WHEN [FiscalWeek] <=  4 THEN  1
                                            WHEN [FiscalWeek] <=  9 THEN  2
                                            WHEN [FiscalWeek] <= 13 THEN  3
                                            WHEN [FiscalWeek] <= 17 THEN  4
                                            WHEN [FiscalWeek] <= 22 THEN  5
                                            WHEN [FiscalWeek] <= 26 THEN  6
                                            WHEN [FiscalWeek] <= 30 THEN  7
                                            WHEN [FiscalWeek] <= 35 THEN  8
                                            WHEN [FiscalWeek] <= 39 THEN  9
                                            WHEN [FiscalWeek] <= 43 THEN 10
                                            WHEN [FiscalWeek] <= 48 THEN 11
                                            ELSE                          12
                                        END AS VARCHAR(2)), 2)),
            [fiscalQuarter]     = CONVERT(CHAR(3),
                                    CASE
                                        WHEN [FiscalWeek] <= 13 THEN 'FQ1'
                                        WHEN [FiscalWeek] <= 26 THEN 'FQ2'
                                        WHEN [FiscalWeek] <= 39 THEN 'FQ3'
                                        ELSE                          'FQ4'
                                    END),
            [fiscalYear]        = CONVERT(CHAR(6),      [FiscalYearLabel]),
            [usHoliday]         = CONVERT(TINYINT,      0),
            [ukHoliday]         = CONVERT(TINYINT,      0),
            [periodEnd]         = CONVERT(TINYINT,
                                    CASE
                                        WHEN DATEDIFF(WEEK,
                                                CASE
                                                    WHEN MONTH(DATEADD(DAY, 1, [Date])) >= 9
                                                    THEN DATEFROMPARTS(YEAR(DATEADD(DAY, 1, [Date])),     9, 1)
                                                    ELSE DATEFROMPARTS(YEAR(DATEADD(DAY, 1, [Date])) - 1, 9, 1)
                                                END,
                                                DATEADD(DAY, 1, [Date])) + 1
                                            <>
                                            CASE
                                                WHEN [FiscalWeek] <=  4 THEN  1
                                                WHEN [FiscalWeek] <=  9 THEN  2
                                                WHEN [FiscalWeek] <= 13 THEN  3
                                                WHEN [FiscalWeek] <= 17 THEN  4
                                                WHEN [FiscalWeek] <= 22 THEN  5
                                                WHEN [FiscalWeek] <= 26 THEN  6
                                                WHEN [FiscalWeek] <= 30 THEN  7
                                                WHEN [FiscalWeek] <= 35 THEN  8
                                                WHEN [FiscalWeek] <= 39 THEN  9
                                                WHEN [FiscalWeek] <= 43 THEN 10
                                                WHEN [FiscalWeek] <= 48 THEN 11
                                                ELSE                          12
                                            END
                                        THEN 1 ELSE 0
                                    END),
            [shortDay]          = CONVERT(TINYINT,      0),
            [sourceSystemCode]  = CONVERT(TINYINT,      0),
            [createTimestamp]   = CONVERT(DATETIME,     GETDATE()),
            [updateTimestamp]   = CONVERT(DATETIME,     GETDATE())

        FROM    [fiscal]
    )
    INSERT INTO [dwh].[dimDate]
        (
            [date],
            [systemDate],
            [sqlDate],
            [julianDate],
            [day],
            [dayOfTheWeek],
            [dayName],
            [dayOfTheYear],
            [weekNumber],
            [weekDay],
            [month],
            [monthName],
            [shortMonthName],
            [monthEnd],
            [quarter],
            [year],
            [fiscalWeek],
            [fiscalPeriod],
            [fiscalQuarter],
            [fiscalYear],
            [usHoliday],
            [ukHoliday],
            [periodEnd],
            [shortDay],
            [sourceSystemCode],
            [createTimestamp],
            [updateTimestamp]
        )
    SELECT
            [date],
            [systemDate],
            [sqlDate],
            [julianDate],
            [day],
            [dayOfTheWeek],
            [dayName],
            [dayOfTheYear],
            [weekNumber],
            [weekDay],
            [month],
            [monthName],
            [shortMonthName],
            [monthEnd],
            [quarter],
            [year],
            [fiscalWeek],
            [fiscalPeriod],
            [fiscalQuarter],
            [fiscalYear],
            [usHoliday],
            [ukHoliday],
            [periodEnd],
            [shortDay],
            [sourceSystemCode],
            [createTimestamp],
            [updateTimestamp]
    FROM    [dim];

    PRINT 'Table [dwh].[dimDate] populated successfully.'

    /* Unique index on sqlDate - datetime lookup */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[indexes]
            WHERE   [name]      = N'IX_dimDate_sqlDate'
            AND     [object_id] = OBJECT_ID(N'[dwh].[dimDate]')
        )
        DROP INDEX [IX_dimDate_sqlDate] ON [dwh].[dimDate];

    CREATE UNIQUE NONCLUSTERED INDEX [IX_dimDate_sqlDate]
        ON  [dwh].[dimDate] ([sqlDate])
        ON  [dds_fg6];

    PRINT 'Index [IX_dimDate_sqlDate] created successfully.'


    /* Unique index on date - MM/DD/YYYY string lookup */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[indexes]
            WHERE   [name]      = N'IX_dimDate_date'
            AND     [object_id] = OBJECT_ID(N'[dwh].[dimDate]')
        )
        DROP INDEX [IX_dimDate_date] ON [dwh].[dimDate];

    CREATE UNIQUE NONCLUSTERED INDEX [IX_dimDate_date]
        ON  [dwh].[dimDate] ([date])
        ON  [dds_fg6];

    PRINT 'Index [IX_dimDate_date] created successfully.'


    /* Unique index on systemDate - YYYY-MM-DD string lookup */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[indexes]
            WHERE   [name]      = N'IX_dimDate_systemDate'
            AND     [object_id] = OBJECT_ID(N'[dwh].[dimDate]')
        )
        DROP INDEX [IX_dimDate_systemDate] ON [dwh].[dimDate];

    CREATE UNIQUE NONCLUSTERED INDEX [IX_dimDate_systemDate]
        ON  [dwh].[dimDate] ([systemDate])
        ON  [dds_fg6];

    PRINT 'Index [IX_dimDate_systemDate] created successfully.'


    /* Nonclustered index on dayOfTheWeek                      */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[indexes]
            WHERE   [name]      = N'IX_dimDate_dayOfTheWeek'
            AND     [object_id] = OBJECT_ID(N'[dwh].[dimDate]')
        )
        DROP INDEX [IX_dimDate_dayOfTheWeek] ON [dwh].[dimDate];

    CREATE NONCLUSTERED INDEX [IX_dimDate_dayOfTheWeek]
        ON  [dwh].[dimDate] ([dayOfTheWeek])
        ON  [dds_fg6];

    PRINT 'Index [IX_dimDate_dayOfTheWeek] created successfully.'

    /* FK 1 : factCampaignResult - sendDateKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factCampaignResult'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factCampaignResult]
                ADD CONSTRAINT  [fk_factCampaignResult_dimDate]
                FOREIGN KEY     ([sendDateKey])
                REFERENCES      [dwh].[dimDate] ([dateKey]);
            PRINT 'FK [fk_factCampaignResult_dimDate] recreated successfully.'
        END
    ELSE
        PRINT 'Table [dwh].[factCampaignResult] does not exist yet - FK skipped.'

    /* FK 2 : factCommunicationSubscription - subscriptionStartDateKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factCommunicationSubscription'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factCommunicationSubscription]
                ADD CONSTRAINT  [fk_factCommunicationSubscription_dimDate1]
                FOREIGN KEY     ([subscriptionStartDateKey])
                REFERENCES      [dwh].[dimDate] ([dateKey]);
            PRINT 'FK [fk_factCommunicationSubscription_dimDate1] recreated successfully.'
        END
    ELSE
        PRINT 'Table [dwh].[factCommunicationSubscription] does not exist yet - FK skipped.'

    /* FK 3 : factCommunicationSubscription - subscriptionEndDateKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factCommunicationSubscription'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factCommunicationSubscription]
                ADD CONSTRAINT  [fk_factCommunicationSubscription_dimDate2]
                FOREIGN KEY     ([subscriptionEndDateKey])
                REFERENCES      [dwh].[dimDate] ([dateKey]);
            PRINT 'FK [fk_factCommunicationSubscription_dimDate2] recreated successfully.'
        END
    ELSE
        PRINT 'Table [dwh].[factCommunicationSubscription] does not exist yet - FK skipped.'

    /* FK 4 : factProductSales - salesDateKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factProductSales'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factProductSales]
                ADD CONSTRAINT  [fk_factProductSales_dimDate]
                FOREIGN KEY     ([salesDateKey])
                REFERENCES      [dwh].[dimDate] ([dateKey]);
            PRINT 'FK [fk_factProductSales_dimDate] recreated successfully.'
        END
    ELSE
        PRINT 'Table [dwh].[factProductSales] does not exist yet - FK skipped.'

    /* FK 5 : factSubscriptionSales - dateKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factSubscriptionSales'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factSubscriptionSales]
                ADD CONSTRAINT  [fk_factSubscriptionSales_dimDate1]
                FOREIGN KEY     ([dateKey])
                REFERENCES      [dwh].[dimDate] ([dateKey]);
            PRINT 'FK [fk_factSubscriptionSales_dimDate1] recreated successfully.'
        END
    ELSE
        PRINT 'Table [dwh].[factSubscriptionSales] does not exist yet - FK skipped.'

    /* FK 6 : factSubscriptionSales - startDateKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factSubscriptionSales'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factSubscriptionSales]
                ADD CONSTRAINT  [fk_factSubscriptionSales_dimDate2]
                FOREIGN KEY     ([startDateKey])
                REFERENCES      [dwh].[dimDate] ([dateKey]);
            PRINT 'FK [fk_factSubscriptionSales_dimDate2] recreated successfully.'
        END
    ELSE
        PRINT 'Table [dwh].[factSubscriptionSales] does not exist yet - FK skipped.'

    /* FK 7 : factSubscriptionSales - endDateKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factSubscriptionSales'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factSubscriptionSales]
                ADD CONSTRAINT  [fk_factSubscriptionSales_dimDate3]
                FOREIGN KEY     ([endDateKey])
                REFERENCES      [dwh].[dimDate] ([dateKey]);
            PRINT 'FK [fk_factSubscriptionSales_dimDate3] recreated successfully.'
        END
    ELSE
        PRINT 'Table [dwh].[factSubscriptionSales] does not exist yet - FK skipped.'

    /* FK 8 : factSupplierPerformance - weekKey */
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factSupplierPerformance'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factSupplierPerformance]
                ADD CONSTRAINT  [fk_factSupplierPerformance_dimDate1]
                FOREIGN KEY     ([weekKey])
                REFERENCES      [dwh].[dimDate] ([dateKey]);
            PRINT 'FK [fk_factSupplierPerformance_dimDate1] recreated successfully.'
        END
    ELSE
        PRINT 'Table [dwh].[factSupplierPerformance] does not exist yet - FK skipped.'

    /*** FK 9 : factSupplierPerformance - startDateKey ***/
    IF EXISTS
        (
            SELECT  *
            FROM    [sys].[tables]
            WHERE   [name]      = N'factSupplierPerformance'
            AND     [schema_id] = SCHEMA_ID(N'dwh')
        )
        BEGIN
            ALTER TABLE [dwh].[factSupplierPerformance]
                ADD CONSTRAINT  [fk_factSupplierPerformance_dimDate2]
                FOREIGN KEY     ([startDateKey])
                REFERENCES      [dwh].[dimDate] ([dateKey]);
            PRINT 'FK [fk_factSupplierPerformance_dimDate2] recreated successfully.'
        END
    ELSE
        PRINT 'Table [dwh].[factSupplierPerformance] does not exist yet - FK skipped.'

    COMMIT TRANSACTION
    PRINT 'Success - [dwh].[dimDate] created and committed.'


END TRY
BEGIN CATCH

    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION

    PRINT 'Error - all changes rolled back.'
    PRINT ERROR_MESSAGE();

END CATCH
GO

SELECT TOP 5
    [dateKey],
    [date],
    [systemDate],
    [dayName],
    [monthName],
    [year],
    [fiscalWeek],
    [fiscalPeriod],
    [fiscalQuarter],
    [fiscalYear],
    [weekDay],
    [monthEnd]
FROM    [dwh].[dimDate]
ORDER BY [dateKey];
GO

SELECT
    [TotalRows]     = COUNT(*),
    [FirstDate]     = MIN([sqlDate]),
    [LastDate]      = MAX([sqlDate])
FROM    [dwh].[dimDate];
GO
