-- 1.Global COVID Summary Metrics
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths,SUM(new_deaths)/SUM(new_cases)*100 AS DeathPercentage
FROM covid_deaths1_pyengine;

-- 2.COVID-19 Deaths by Continent
SELECT location, SUM(new_deaths) AS TotalDeathsCount
FROM covid_deaths1_pyengine
WHERE location in ('Europe', 'North America', 'South America', 'Asia', 'Africa', 'Oceania')
GROUP BY location
ORDER BY 2 desc;

-- 3.Country-Level Infection Rate Analysis
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX(total_cases/population)*100 AS PercentPopulationInfected
FROM covid_deaths1_pyengine
GROUP BY location, population
ORDER BY 4 desc;

-- 4.Time-Series Infection Progression by Country
SELECT location, population, date, MAX(total_cases) AS HighestInfectionCount, MAX(total_cases/population)*100 AS PercentPopulationInfected
FROM covid_deaths1_pyengine
GROUP BY location, population, date
ORDER BY 5 desc;
