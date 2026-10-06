DROP DATABASE IF EXISTS ProjectDW;
CREATE DATABASE ProjectDW;
USE ProjectDW;

CREATE TABLE dim_country (
    country_key    INT AUTO_INCREMENT,
    iso3_code      CHAR(3),
    country_name   VARCHAR(20),
    country_group  VARCHAR(25),
    PRIMARY KEY (country_key),
    UNIQUE (iso3_code)
);

CREATE TABLE dim_time (
    time_key  INT AUTO_INCREMENT,
    year      INT,
    decade    INT,
    PRIMARY KEY (time_key),
    UNIQUE (year)
);

CREATE TABLE dim_sector (
    sector_key   INT AUTO_INCREMENT,
    sector_name  VARCHAR(50),
    broad_sector VARCHAR(50),
    PRIMARY KEY (sector_key)
);

CREATE TABLE fact_economy (
	country_key     INT,
	time_key        INT,
	gdp             DOUBLE,
	gdp_per_capita  DOUBLE,
	gdp_growth_pct  DOUBLE,
	exports_pct_gdp DOUBLE,
	imports_pct_gdp DOUBLE,
	PRIMARY KEY (country_key, time_key),
	FOREIGN KEY (country_key) REFERENCES dim_country(country_key),
	FOREIGN KEY (time_key)    REFERENCES dim_time(time_key)
);

CREATE TABLE fact_society (
	country_key      INT,
	time_key         INT,
	population       DOUBLE,
	gni_per_capita   DOUBLE,
	life_expectancy  DOUBLE,
	urban_pop_pct    DOUBLE,
	PRIMARY KEY (country_key, time_key),
	FOREIGN KEY (country_key) REFERENCES dim_country(country_key),
	FOREIGN KEY (time_key)    REFERENCES dim_time(time_key)
);

CREATE TABLE fact_sector (
	country_key         INT,
	time_key            INT,
	sector_key          INT,
	value_added_pct_gdp DOUBLE,
	value_added_usd     DOUBLE,
	employment_pct      DOUBLE,
	PRIMARY KEY (country_key, time_key, sector_key),
	FOREIGN KEY (country_key) REFERENCES dim_country(country_key),
	FOREIGN KEY (time_key)    REFERENCES dim_time(time_key),
	FOREIGN KEY (sector_key)  REFERENCES dim_sector(sector_key)
);

CREATE TABLE bridge_event (
	event_key           INT AUTO_INCREMENT,
	country_key         INT,
	time_key            INT,
	event               VARCHAR(110),
	category            VARCHAR(100),
	economic_impact     VARCHAR(40),
	PRIMARY KEY (event_key),
	FOREIGN KEY (country_key) REFERENCES dim_country(country_key),
	FOREIGN KEY (time_key)    REFERENCES dim_time(time_key),
	UNIQUE (country_key, time_key, event)
);
