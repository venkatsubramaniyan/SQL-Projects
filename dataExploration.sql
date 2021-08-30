select top 10 * from PortfolioProjects..CovidDeaths
order by 3,4

select top 10 * from PortfolioProjects..CovidVaccinations
order by 3,4

select * from PortfolioProjects..CovidDeaths
order by 3,4

---select data

select  [location],[date] ,total_cases,new_cases,total_deaths,[population]
from PortfolioProjects..CovidDeaths
order by 1,2

---total_cases by location

select location,coalesce(sum(new_cases),0) as total_case
from PortfolioProjects..CovidDeaths
group by [location]
order by [location] asc

--total case by count in descending order

select location,coalesce(sum(new_cases),0) as total_case
from PortfolioProjects..CovidDeaths
group by [location]
order by total_case desc



---total cases and total death counts in location

select location,coalesce(max(total_cases),0) as Total_Case ,coalesce(max(total_deaths),0) as Total_deaths
from PortfolioProjects..CovidDeaths
group by [location]
order by [location]

select location,coalesce(max(total_cases),0) as Total_Case,coalesce(max(total_deaths),0) as Total_deaths , coalesce(round (((max(total_deaths)/max(total_cases))* 100),2),0) as Death_Percentage
from PortfolioProjects..CovidDeaths
group by [location]
order by [location]


---total deaths and new deaths by country

select [location],total_cases,total_deaths , (total_deaths/total_cases)*100 as death_percentage
from PortfolioProjects..CovidDeaths
order by 1,2
 



---what percentage of population got covid


select [location],[date],total_cases, [population], ((total_cases/[population])*100) as Covid_Percentage
from PortfolioProjects..CovidDeaths
--where [location] like '%states%'
order by 1,2


-- highest infection rate compared to population

select  [location] ,population, max(total_cases) as highest_infection_count ,max((total_cases)/([population]))*100 as percentage_population_infection
from PortfolioProjects..CovidDeaths
group by [location],population
order by percentage_population_infection desc



-- highest death count per population

select  [location] ,population, max(total_deaths) as highest_death_rate ,max((total_deaths)/([population]))*100 as highest_death_per_population
from PortfolioProjects..CovidDeaths
group by [location],population
order by highest_death_per_population desc

---countries with highest eath rate

select  [location] ,population, cast(max(total_deaths) as int) as highest_death_rate 
from PortfolioProjects..CovidDeaths
where  continent is not null
group by [location],population
order by highest_death_rate  desc



select  continent , cast(max(total_deaths) as int) as highest_death_rate 
from PortfolioProjects..CovidDeaths
where  continent is  not null
group by continent
order by highest_death_rate  desc


select * from PortfolioProjects..CovidDeaths
order by 3,4

--total case in the world

select sum(new_cases) as total_cases
from PortfolioProjects..CovidDeaths


--total deaths in the world

select sum(deaths_by_country) as deaths_in_world
from (select coalesce(max(total_deaths),0) as deaths_by_country
from PortfolioProjects..CovidDeaths
group by [location]) Total_deaths



select sum(new_cases) Total_cases ,(select sum(deaths_by_country) as deaths_in_world
from (select coalesce(max(total_deaths),0) as deaths_by_country
from PortfolioProjects..CovidDeaths
group by [location]) Total_deaths) Total_deaths
from PortfolioProjects..CovidDeaths


---death percentage  on affected people in the world


select Total_cases,Total_deaths, (Total_deaths/Total_cases)* 100 as death_percentage from (select sum(new_cases) Total_cases ,(select sum(deaths_by_country) as deaths_in_world
from (select coalesce(max(total_deaths),0) as deaths_by_country
from PortfolioProjects..CovidDeaths
group by [location]) Total_deaths) Total_deaths
from PortfolioProjects..CovidDeaths) a


-- checking the data consistency

select count(1) 
from PortfolioProjects..CovidDeaths
where total_deaths>total_cases


select sum(new_cases)
from PortfolioProjects..CovidDeaths


select sum(tc) as total_cases from (select coalesce(max(total_cases),0) as tc
from PortfolioProjects..CovidDeaths
group by location) a


select sum(cast((new_deaths) as int)) as total_deaths
from PortfolioProjects..CovidDeaths


select * 
from PortfolioProjects..CovidVaccinations

select * 
from 
PortfolioProjects..CovidDeaths CD join PortfolioProjects..CovidVaccinations CV
on CD.location=CV.location and CD.date=CV.date


--total population vs total vaccinations

select CD.continent,CD.location,CD.population,CV.new_vaccinations 
from 
PortfolioProjects..CovidDeaths CD join PortfolioProjects..CovidVaccinations CV
on CD.location=CV.location and CD.date=CV.date
where CD.continent is not null
order by 1,2





























