/* =====================================================================  
	 -Modelo Dimensional
	 -Datawarehouse de Proyeccion de vuelos
	 -Parcial 3
	 -RM11117
====================================================================== */
USE master
GO
IF DB_ID('DWVuelos') IS NOT NULL
BEGIN
     ALTER DATABASE  DWVuelos SET SINGLE_USER WITH ROLLBACK IMMEDIATE
  DROP DATABASE DWVuelos
END
GO
CREATE DATABASE DWVuelos
GO

USE DWVuelos
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* =====================================================================  
	 Dimension Aerolinea
====================================================================== */

DROP TABLE IF EXISTS DIM_Aerolinea 

CREATE TABLE DIM_Aerolinea(
	AerolineaKey int IDENTITY(1,1) NOT NULL,
	AerolineaID varchar(15) NOT NULL,
	Descripcion varchar(100) NOT NULL,
	CONSTRAINT [PK_Aerolinea_AerolineaKey] PRIMARY KEY (AerolineaKey)
	)

/* =====================================================================  
	 Dimension Aeropuerto
====================================================================== */
GO

DROP TABLE IF EXISTS DIM_Aeropuerto

CREATE TABLE DIM_Aeropuerto(
	AeropuertoKey int IDENTITY(1,1) NOT NULL,
	AeropuertoID varchar(15) NOT NULL,
	NombreAeropuerto varchar(100) NOT NULL,
	CONSTRAINT [PK_Aeropuerto_AeropuertoKey] PRIMARY KEY(AeropuertoKey)
	)

/* =====================================================================  
	 Dimension Aeropuerto
====================================================================== */
GO

DROP TABLE IF EXISTS DIM_Ciudad

CREATE TABLE DIM_Ciudad(
	CiudadKey int IDENTITY(1,1) NOT NULL,
	CiudadID varchar(15) NOT NULL,
	NombreCiudad varchar(100) NOT NULL,
	Estado varchar(100) NOT NULL,
	CONSTRAINT [PK_Ciudad_CiudadKey] PRIMARY KEY (CiudadKey)
	)

/* =====================================================================  
	 Dimension Vuelos
====================================================================== */
GO

DROP TABLE IF EXISTS DIM_Vuelo

CREATE TABLE DIM_Vuelo(
	VueloKey int IDENTITY(1,1) NOT NULL,
	VueloID varchar(100) NOT NULL,
	FechaVuelo datetime NULL,
	Origen varchar(100) NOT NULL,
	Destino varchar(100) NOT NULL,
	CONSTRAINT [PK_Vuelo_VueloKey] PRIMARY KEY (VueloKey)
	)

/* =====================================================================  
	 Dimension Fecha
====================================================================== */
GO

DROP TABLE IF EXISTS DIM_Fecha

CREATE TABLE DIM_Fecha(
    FechaKey int not null,
    FechaCompleta smalldatetime null,
    anio smallint null,
    Trimestre tinyint null,
    Mes tinyint null,
    DiaDeMes tinyint null,
    DiaDeSemana tinyint null,
    CONSTRAINT [PK_Fecha_FechaKey] PRIMARY KEY (FechaKey)
)

/* =====================================================================  
	 Fact Table Proyeccion de vuelos
====================================================================== */

GO

DROP TABLE IF EXISTS FACT_Proyeccion_Vuelos

CREATE TABLE FACT_Proyeccion_Vuelos(
	AerolineaKey int NOT NULL,
	AeropuertoKey int NOT NULL,
	CiudadKey int NOT NULL,
	VueloKey int NOT NULL,
	FechaKey int NOT NULL,
	VuelosCancelados smallint NOT NULL,
    VuelosDesviados smallint NOT NULL,
    VuelosRetrasados smallint NOT NULL,
    LLegadaRetrasada smallint NOT NULL,
    RetrasoPorClima smallint NOT NULL,
    RetrasoPorSeguridad smallint NOT NULL,
    CarrierDelayed smallint NOT NULL,
    AvionRetrasado smallint NOT NULL,
	CONSTRAINT [FK_FACT_AerolineaKey] FOREIGN KEY (AerolineaKey) REFERENCES DIM_Aerolinea(AerolineaKey),
	CONSTRAINT [FK_FACT_AeropuertoKey] FOREIGN KEY (AeropuertoKey) REFERENCES DIM_Aeropuerto(AeropuertoKey),
	CONSTRAINT [FK_FACT_CiudadKey] FOREIGN KEY (CiudadKey) REFERENCES DIM_Ciudad(CiudadKey),
	CONSTRAINT [FK_FACT_VueloKey] FOREIGN KEY (VueloKey) REFERENCES DIM_Vuelo(VueloKey),
	CONSTRAINT [FK_FACT_FechaKey] FOREIGN KEY (FechaKey) REFERENCES DIM_Fecha(FechaKey)
)
