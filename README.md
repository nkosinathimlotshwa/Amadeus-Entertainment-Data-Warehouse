# Amadeus Entertainment Data Warehouse

## Project Overview

This project implements an **NDS + DDS hybrid data warehouse architecture** for Amadeus Entertainment, a global entertainment retailer specialising in music, films, and audio books, operating across 8 online stores and 96 offline stores in the US, Germany, France, UK, Spain, Australia, Japan, and India.

Built as a hands-on learning project based on the Apress textbook **"Building a Data Warehouse with Examples in SQL Server"** by Vincent Rainardi (2007), upgraded and modernised for **Microsoft SQL Server 2022** and localised for **South Africa**.

---

## Architecture

The data warehouse is split into two main layers:

**NDS (Normalized Data Store)** — the master data store. Holds the complete history of every transaction ever recorded and every past version of master data (customers, products, stores), normalized into 3NF. Uses both natural keys (from source systems) and surrogate keys (data warehouse). Only updated by ETL — never queried directly by users.

**DDS (Dimensional Data Store)** — the star schema layer that end users and reports query. Fact tables are built from NDS transaction tables, dimension tables from NDS master tables.

```
Source Systems (WebTower9, Jupiter ERP, Jade, SupplyNet)
        ↓
    Stage Database
        ↓
NDS — Normalized Data Store (full history, master data)
        ↓
DDS — Dimensional Data Store (star schema)
        ↓
Reports & Analytics
```

---

## DDS Star Schema

```
              [dwh].[dimDate]
                    │
                    │ salesDateKey / sendDateKey
                    │
[dwh].[dimCustomer]─┼─[dwh].[dimProduct]
      customerKey   │      productKey
                    │
       [dwh].[factProductSales]
       [dwh].[factCampaignResult]
                    │
               storeKey / channelKey
                    │
            [dwh].[dimStore]
```

### Dimension Tables

| Table | Description | SCD Type |
|---|---|---|
| `dimDate` | Calendar and fiscal date attributes | Static |
| `dimProduct` | Music, film and audio book catalogue | Type 1 |
| `dimCustomer` | Customer demographics and preferences | Type 2 |
| `dimStore` | Online and offline store details | Type 1 |

### Fact Tables

| Table | Description | Grain |
|---|---|---|
| `factProductSales` | Product sales transactions | One row per order line |
| `factCampaignResult` | Marketing campaign response metrics | One row per campaign, date, customer |

---

## Technical Stack

| Component | Technology |
|---|---|
| Database Platform | Microsoft SQL Server 2022 |
| Database IDE | SQL Server Management Studio (SSMS) |
| Architecture | NDS + DDS Hybrid |
| Schema | Star Schema |
| Language | T-SQL |

---

## SQL Server 2022 Features Used

- `GENERATE_SERIES` for date dimension population
- `DROP CONSTRAINT IF EXISTS` syntax
- Modern `sys` catalog views throughout
- `TRY/CATCH` transaction handling with `@@TRANCOUNT`
- Window functions for date calculations

---

## Database Configuration

The DDS is spread across six filegroups simulating an enterprise multi-disk configuration:

| Filegroup | Contents |
|---|---|
| `dds_fg2` | factProductSales table data |
| `dds_fg4` | factProductSales indexes, factCampaignResult PK |
| `dds_fg5` | factCampaignResult table data |
| `dds_fg6` | Dimension tables and factCampaignResult indexes |

> For this development environment, all filegroups are simulated on a single laptop drive under `C:\disk\data1-6\`, replicating the enterprise multi-disk structure at a small scale.

---

## South African Localisation

- Fiscal year follows the **March to February** SA standard
- Date format set to **DD/MM/YYYY**
- Week starts **Monday** per ISO standard
- Language set to **British English**

---

## Coding Standards

- `USE [database]` declared at the top of every script
- `SET ANSI_NULLS ON` and `SET QUOTED_IDENTIFIER ON` on every script
- Square brackets `[ ]` around all object names
- Schema prefix `[dwh]` on all objects
- `BEGIN TRY / BEGIN CATCH` with `@@TRANCOUNT` on all scripts
- `BEGIN TRANSACTION` inside `BEGIN TRY` block
- FK constraints dropped before table recreation and restored after
- Verification query at the end of every script
- Comments explain the WHY not just the WHAT
- camelCase naming convention for tables and columns

---

## Project Structure

```
01_Database_Creation/
    01_Create_DDS_Database.sql
    02_Create_NDS_Database.sql
    03_Create_Stage_Database.sql
    04_Create_Meta_Database.sql

02_Tables/
    01_dimDate.sql
    02_dimProduct.sql
    03_dimCustomer.sql
    04_dimStore.sql
    05_factProductSales.sql
    06_factCampaignResult.sql

03_Indexes/
04_ETL/
05_Stored_Procedures/
06_Views/
07_Security/
08_Documentation/
```

---

## Status

| Object | Status |
|---|---|
| DDS Database Creation | ✅ Complete |
| NDS Database Creation | ✅ Complete |
| Stage Database Creation | ✅ Complete |
| Meta Database Creation | ✅ Complete |
| dimDate | ✅ Complete |
| dimProduct | ✅ Complete |
| dimCustomer | ✅ Complete |
| dimStore | ✅ Complete |
| factProductSales | ✅ Complete |
| factCampaignResult | ✅ Complete |
| dimCampaign | ⏳ Upcoming |
| dimCommunication | ⏳ Upcoming |
| dimChannel | ⏳ Upcoming |
| dimDeliveryStatus | ⏳ Upcoming |
| NDS Tables | 🔄 In Progress |
| ETL Processes | ⏳ Upcoming |

---

## Learning Objectives

- Enterprise data warehouse design and architecture
- Physical database design including filegroups and storage planning
- Dimensional modelling — star schema, fact and dimension tables
- Slowly Changing Dimensions — SCD Type 1 and Type 2
- Professional T-SQL coding standards
- SQL Server 2022 features and best practices
