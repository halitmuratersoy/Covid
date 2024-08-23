SELECT location, date, total_cases, new_cases, total_deaths, population
FROM CovidDeaths$
ORDER BY 1,2


-- Infection Death Rate
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS InfectedDeathRate
FROM CovidDeaths$
WHERE location LIKE 'Turkey'
ORDER BY 1,2

--Total cases over Population
SELECT location, date, population, total_cases, total_deaths
FROM CovidDeaths$
WHERE location LIKE 'Turkey'
ORDER BY 1,2

--Infection Rate
SELECT location, population, MAX(total_cases) AS TotalInfected, MAX(total_cases/population)*100 AS InfectionRate
FROM CovidDeaths$
GROUP BY location, population
ORDER BY InfectionRate DESC

--Population Death Rate
SELECT location, population, MAX(CAST(total_deaths AS INT)) AS TotalDeath, MAX(total_deaths/population)*100 AS PopulationDeathRate
FROM CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY PopulationDeathRate DESC

--CAST being used for convert the data type nvarchar to int. This provides us proper ordering
--To make continents and world overall don't show up, WHERE continent IS NOT NULL has been used
--ORDER BY 1,2 means order by first column then second column when needed

--Population Death Rate On Continent
SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeath, MAX(total_deaths/population)*100 AS PopulationDeathRate
FROM CovidDeaths$
WHERE continent IS NULL
GROUP BY location
ORDER BY TotalDeath DESC

--GLOBAL NUMBERS
SELECT date, SUM(new_cases) AS Cases, SUM(CAST(new_deaths AS INT)) AS Deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS DeathRate
FROM CovidDeaths$
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2