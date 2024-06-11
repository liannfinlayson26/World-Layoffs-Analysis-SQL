-- Explotartory Data Analysis Layoffs

SELECT *
FROM layoffs_staging2;

-- In one day one company had

-- This query was not returning the value of the max integer because the column was text
-- Once converted the max total laid off in one day of 12k.
-- One company laid off 100% of the company. 1 means 100%

SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- Convert the text column to an integer column
ALTER TABLE layoffs_staging2
MODIFY COLUMN total_laid_off INTEGER;

-- Recognizing which companies are 100% laid off
-- Katerra is the company with the most laid off people 2,434
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC; 

-- Funds raised in millions getting the wrong output in query
-- Convert the text column to an integer column
ALTER TABLE layoffs_staging2
MODIFY COLUMN funds_raised_millions INTEGER;

-- Once data converted to integer format it throws the right output
-- You could see here that companies like Britishvolt and Quibi got funds by 2.4B and 1.8B 

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- The companies in DESC order for most laid-offs
-- In here we can see that amazon got 18150, google 12000

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- what is the range of dates 
-- from covid three years later
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- what industry got hit the hardest?
-- consumer and retail, maybe for the pandemic?
-- least got hit manufacturing, fin-tech, aerospace, energy
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- most country with laid offs united states with 256559 people
-- country with least laid offs poland.
-- note: panama is not in this database.

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- we could see this data also by year
-- 2022 160K laid off
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;

-- in the stage that the company is at. Seed is companies that are starting. 
-- Series A starting also. 
-- Post-IPO or listed shares are shares that are available for trading on public stock exchanges
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- percentage laid off is not a good estimate because we dont have the full percentage of people working in the company

SELECT company, SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- rolling sum early sum of laids offs

-- this is the rolling total for every month in the year 2020, 2021,2022 and 2023
SELECT SUBSTRING(`date`,6,2) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `MONTH`
ORDER BY `MONTH` ASC;

-- to separate the dates we could use the substring from 1 to 7
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC;

-- with a CTE we could accomplish the rolling sum of the years
-- the total off is the delta rolling total - the month before
WITH Rolling_total AS
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off
,SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_total;

-- how many people are these companies laying by year?
SELECT company,YEAR(`date`) ,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

-- highest company in total laid off comes first
-- all the 2022, 2023 are going to be at the same partition
-- filter the top 5 companies by year

-- first CTE Company_Year: we give it a rank
-- Second CTE Company_Year_Rank: we want to filter the rank so we create a second CTE 

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company,YEAR(`date`) ,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <=5;
