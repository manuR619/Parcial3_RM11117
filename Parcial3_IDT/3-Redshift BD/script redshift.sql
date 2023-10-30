CREATE TABLE DIM_Aerolinea(
	AerolineaKey int IDENTITY(1,1) NOT NULL sortkey distkey,
	AerolineaID varchar(15) NOT NULL,
	Descripcion varchar(100) NOT NULL,
	CONSTRAINT [PK_Aerolinea_AerolineaKey] PRIMARY KEY (AerolineaKey)
	)diststyle key


CREATE TABLE DIM_Aeropuerto(
	AeropuertoKey int IDENTITY(1,1) NOT NULL sortkey distkey,
	AeropuertoID varchar(15) NOT NULL,
	NombreAeropuerto varchar(100) NOT NULL,
	CONSTRAINT [PK_Aeropuerto_AeropuertoKey] PRIMARY KEY(AeropuertoKey)
	)diststyle key


CREATE TABLE DIM_Ciudad(
	CiudadKey int IDENTITY(1,1) NOT NULL sortkey distkey,
	CiudadID varchar(15) NOT NULL,
	NombreCiudad varchar(100) NOT NULL,
	Estado varchar(100) NOT NULL,
	CONSTRAINT [PK_Ciudad_CiudadKey] PRIMARY KEY (CiudadKey)
	)diststyle key



CREATE TABLE DIM_Vuelo(
	VueloKey int IDENTITY(1,1) NOT NULL sortkey distkey,
	VueloID varchar(100) NOT NULL,
	FechaVuelo datetime NULL,
	Origen varchar(100) NOT NULL,
	Destino varchar(100) NOT NULL,
	CONSTRAINT [PK_Vuelo_VueloKey] PRIMARY KEY (VueloKey)
	)diststyle key


CREATE TABLE DIM_Fecha(
    FechaKey int not null sortkey distkey,
    FechaCompleta datetime null,
    anio int null,
    Trimestre int null,
    Mes int null,
    DiaDeMes int null,
    DiaDeSemana int null,
	CONSTRAINT [PK_Fecha_FechaKey] PRIMARY KEY (FechaKey)
)diststyle key



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
)diststyle key
distkey (VueloKey)