DROP DATABASE IF EXISTS staging;
CREATE DATABASE staging;
USE staging;

CREATE TABLE maddison_indicators (
    country_iso3 VARCHAR(3) NOT NULL,
    country_name VARCHAR(20) NOT NULL,
    indicator_code VARCHAR(6) NOT NULL,
    indicator_name VARCHAR(35) NOT NULL,
    year INT NOT NULL,
    value DOUBLE
);

CREATE TABLE historical_events (
    year INT NOT NULL,
    country_iso3 VARCHAR(3) NOT NULL,
    country_name VARCHAR(20) NOT NULL,
    event VARCHAR(110) NOT NULL,
    category VARCHAR(25) NOT NULL,
    economic_impact VARCHAR(40)
);

CREATE TABLE wdi_indicators (
    country_iso3 VARCHAR(3) NOT NULL,
    country_name VARCHAR(20) NOT NULL,
    indicator_code VARCHAR(25) NOT NULL,
    indicator_name VARCHAR(75) NOT NULL,
    year INT NOT NULL,
    value DOUBLE NOT NULL
);
