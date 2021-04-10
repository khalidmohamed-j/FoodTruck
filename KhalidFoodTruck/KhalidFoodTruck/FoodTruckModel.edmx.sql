
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 03/23/2021 13:33:51
-- Generated from EDMX file: C:\Users\khali\Documents\Classes\Winter 2021\ISIT 310 - Enterprise Data Applications\013 - Azure\KhalidFoodTruck\KhalidFoodTruck\FoodTruckModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [FoodTruckNew];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_FoodTypeFoodTruck]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[FoodTrucks] DROP CONSTRAINT [FK_FoodTypeFoodTruck];
GO
IF OBJECT_ID(N'[dbo].[FK_LocationFoodTruckLocation]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[FoodTruckLocations] DROP CONSTRAINT [FK_LocationFoodTruckLocation];
GO
IF OBJECT_ID(N'[dbo].[FK_FoodTruckFoodTruckLocation]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[FoodTruckLocations] DROP CONSTRAINT [FK_FoodTruckFoodTruckLocation];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FoodTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[FoodTypes];
GO
IF OBJECT_ID(N'[dbo].[FoodTrucks]', 'U') IS NOT NULL
    DROP TABLE [dbo].[FoodTrucks];
GO
IF OBJECT_ID(N'[dbo].[Locations]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Locations];
GO
IF OBJECT_ID(N'[dbo].[FoodTruckLocations]', 'U') IS NOT NULL
    DROP TABLE [dbo].[FoodTruckLocations];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'FoodTypes'
CREATE TABLE [dbo].[FoodTypes] (
    [FoodTypeID] int IDENTITY(1,1) NOT NULL,
    [FoodTypeName] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'FoodTrucks'
CREATE TABLE [dbo].[FoodTrucks] (
    [FoodTruckID] int IDENTITY(1,1) NOT NULL,
    [FoodTruckName] nvarchar(max)  NOT NULL,
    [FoodTruckPlateNumber] nvarchar(max)  NOT NULL,
    [FoodTypeID] int  NOT NULL,
    [FoodType_FoodTypeID] int  NOT NULL
);
GO

-- Creating table 'Locations'
CREATE TABLE [dbo].[Locations] (
    [LocationID] int IDENTITY(1,1) NOT NULL,
    [LocationName] nvarchar(max)  NOT NULL,
    [LocationAddress] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'FoodTruckLocations'
CREATE TABLE [dbo].[FoodTruckLocations] (
    [FoodTruckLocationID] int IDENTITY(1,1) NOT NULL,
    [FoodTruckLocationDay] nvarchar(max)  NOT NULL,
    [LocationID] int  NOT NULL,
    [FoodTruckID] int  NOT NULL,
    [Location_LocationID] int  NOT NULL,
    [FoodTruck_FoodTruckID] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [FoodTypeID] in table 'FoodTypes'
ALTER TABLE [dbo].[FoodTypes]
ADD CONSTRAINT [PK_FoodTypes]
    PRIMARY KEY CLUSTERED ([FoodTypeID] ASC);
GO

-- Creating primary key on [FoodTruckID] in table 'FoodTrucks'
ALTER TABLE [dbo].[FoodTrucks]
ADD CONSTRAINT [PK_FoodTrucks]
    PRIMARY KEY CLUSTERED ([FoodTruckID] ASC);
GO

-- Creating primary key on [LocationID] in table 'Locations'
ALTER TABLE [dbo].[Locations]
ADD CONSTRAINT [PK_Locations]
    PRIMARY KEY CLUSTERED ([LocationID] ASC);
GO

-- Creating primary key on [FoodTruckLocationID] in table 'FoodTruckLocations'
ALTER TABLE [dbo].[FoodTruckLocations]
ADD CONSTRAINT [PK_FoodTruckLocations]
    PRIMARY KEY CLUSTERED ([FoodTruckLocationID] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [FoodType_FoodTypeID] in table 'FoodTrucks'
ALTER TABLE [dbo].[FoodTrucks]
ADD CONSTRAINT [FK_FoodTypeFoodTruck]
    FOREIGN KEY ([FoodType_FoodTypeID])
    REFERENCES [dbo].[FoodTypes]
        ([FoodTypeID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_FoodTypeFoodTruck'
CREATE INDEX [IX_FK_FoodTypeFoodTruck]
ON [dbo].[FoodTrucks]
    ([FoodType_FoodTypeID]);
GO

-- Creating foreign key on [Location_LocationID] in table 'FoodTruckLocations'
ALTER TABLE [dbo].[FoodTruckLocations]
ADD CONSTRAINT [FK_LocationFoodTruckLocation]
    FOREIGN KEY ([Location_LocationID])
    REFERENCES [dbo].[Locations]
        ([LocationID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_LocationFoodTruckLocation'
CREATE INDEX [IX_FK_LocationFoodTruckLocation]
ON [dbo].[FoodTruckLocations]
    ([Location_LocationID]);
GO

-- Creating foreign key on [FoodTruck_FoodTruckID] in table 'FoodTruckLocations'
ALTER TABLE [dbo].[FoodTruckLocations]
ADD CONSTRAINT [FK_FoodTruckFoodTruckLocation]
    FOREIGN KEY ([FoodTruck_FoodTruckID])
    REFERENCES [dbo].[FoodTrucks]
        ([FoodTruckID])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_FoodTruckFoodTruckLocation'
CREATE INDEX [IX_FK_FoodTruckFoodTruckLocation]
ON [dbo].[FoodTruckLocations]
    ([FoodTruck_FoodTruckID]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------