SELECT *
FROM layoffs;

CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT layoffs_staging
SELECT *
FROM layoffs;

-- 1. remove duplicates
SELECT * 
FROM layoffs_staging;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, industry, total_laid_off, percentage_laid_off, 'date') AS row_num
FROM layoffs_staging;

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location,
industry, total_laid_off, percentage_laid_off, `date`, stage
, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte 
WHERE row_num >1;

SELECT * 
FROM layoffs_staging
WHERE company = 'Spotify';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` text,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * 
FROM layoffs_staging2
WHERE row_num >1;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location,
industry, total_laid_off, percentage_laid_off, `date`, stage
, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

DELETE
FROM layoffs_staging2
WHERE row_num =2 ;

SELECT * 
FROM layoffs_staging2;

-- 2. standardize the data
SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2 
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT `date`
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = 
	CASE
    WHEN `date` IS NOT NULL AND `date` != 'NULL' THEN STR_TO_DATE(`date`, '%m/%d/%Y')
    ELSE NULL
END;

ALTER TABLE layoffs_staging2 
MODIFY COLUMN `date`  DATE; 

-- 3. null values or blank values
-- How can i alter a table from a NULL text to a NULL format 

SELECT *
FROM layoffs_staging2
WHERE total_laid_off = 'NULL';

-- trying to alter the NULL strings to replace them with NULL values
SELECT *
FROM layoffs_staging;

-- ALTER TABLE layoffs_staging
-- MODIFY COLUMN total_laid_off VARCHAR(255) NULL;

UPDATE layoffs_staging
SET total_laid_off = NULL
WHERE total_laid_off = 'NULL';

-- i need to replicate this in the layoff_staging2
UPDATE layoffs_staging2
SET total_laid_off = NULL
WHERE total_laid_off = 'NULL';

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = 'NULL';

UPDATE layoffs_staging2
SET  percentage_laid_off = NULL
WHERE percentage_laid_off  = 'NULL';

UPDATE layoffs_staging2
SET stage = NULL
WHERE stage  = 'NULL';

UPDATE layoffs_staging2
SET funds_raised_millions = NULL
WHERE funds_raised_millions  = 'NULL';

-- columns with NULL strings: industry, total_laid_off, percentage_laid_off, stage, funds_raised_millions
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry  = '';

-- viewing industries that have a NULL value
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = ''; 

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT  t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
    -- AND t1.location = t2.location
WHERE (t1. industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1. industry IS NULL 
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_staging2
WHERE company = 'Bally%';

-- we cannot populate the NULL values in the total_laid_off and percentage_laid_off without a total_laid_off column
-- in that case if we have had that column we could have the total number of personal. We multiple the total x 
-- the percentage and populate the total_laid_off column

-- 4. remove any unnecesary columns
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE 
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2;

AlTER TABLE layoffs_staging2
DROP COLUMN row_num;

