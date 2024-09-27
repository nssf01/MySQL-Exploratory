-- Data Cleaning

SELECT 
    *
FROM
    layoffs;
    
-- 1. Remove Duplicates
-- 2.Standardize the Data
-- 3. Null Values OR Blank Values
-- 4. Remove Any Column

CREATE TABLE layoffs_staging LIKE layoffs;


SELECT 
    *
FROM
    layoffs_staging;
    
INSERT layoffs_staging
SELECT *
FROM layoffs;    
    
 SELECT *,
 row_number() OVER (PARTITION BY company,industry,total_laid_off,percentage_laid_off,`date`) as row_num
    
FROM
    layoffs_staging;	
    
WITH duplicate_cte AS
(SELECT *,
 row_number() OVER (PARTITION BY company,location, industry,total_laid_off,percentage_laid_off,`date`,stage, country,funds_raised_millions) as row_num
    
FROM
    layoffs_staging
)  

select *
from duplicate_cte
where row_num > 1;




    CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT 
    *
FROM
    layoffs_staging2;
    
    
INSERT INTO layoffs_staging2
SELECT *,
 row_number() OVER (PARTITION BY company,location, industry,total_laid_off,percentage_laid_off,`date`,stage, country,funds_raised_millions) as row_num
    
FROM
    layoffs_staging;   
    
    SELECT 
    *
FROM
    layoffs_staging2
    where row_num > 1;
    
    
DELETE   
FROM
    layoffs_staging2
    where row_num > 1;
    
    
     SELECT 
    *
FROM
    layoffs_staging2
 ;
 
 
 -- Standardizing Data

select company, TRIM(company)
from layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);


select *
from layoffs_staging2
where industry like 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
where industry like 'Crypto%';

select Distinct industry
from layoffs_staging2
order by 1;


select Distinct location
from layoffs_staging2
order by 1;


select Distinct country
from layoffs_staging2
where country like 'United States%';


select *
from layoffs_staging2
where country like 'United States%';


select *
from layoffs_staging2;


select `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
from layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

select *
from layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

select *
from layoffs_staging2;


select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

UPDATE layoffs_staging2
SET industry = null
where industry = '';

select *
from layoffs_staging2
where industry is null
or industry = '';


select *
from layoffs_staging2
where company = 'Airbnb';

select t1.industry,t2.industry
from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
where (t1.industry is null or t1.industry = '')
and t2.industry is not null
;


UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company
SET t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null;


Select *
from layoffs_staging2;
 
 select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

DELETE
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

SELECT *
from layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP column row_num;



 