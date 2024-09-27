-- Exploratory Data Analysis


select *
from layoffs_staging2;


select MAX(total_laid_off), MAX(percentage_laid_off)
from layoffs_staging2;


select *
from layoffs_staging2
WHERE percentage_laid_off = 1
order by funds_raised_millions DESC;


select COMPANY, SUM(total_laid_off)
from layoffs_staging2
GROUP BY company
order by 2 DESC;


select MAX(`date`), MIN(`date`)
from layoffs_staging2;



select industry, SUM(total_laid_off)
from layoffs_staging2
GROUP BY industry
order by 2 DESC;



select country, SUM(total_laid_off)
from layoffs_staging2
GROUP BY country
order by 2 DESC;



select YEAR(`date`), SUM(total_laid_off)
from layoffs_staging2
GROUP BY YEAR(`date`)
order by 1 DESC;



select stage, SUM(total_laid_off)
from layoffs_staging2
GROUP BY stage
order by 2 DESC;



select COMPANY, AVG(percentage_laid_off)
from layoffs_staging2
GROUP BY company
order by 2 DESC;



select substring(`date`, 1, 7) AS `Month`, SUM(total_laid_off)
from layoffs_staging2
where substring(`date`, 1, 7) is not null
group by `Month`
order by 1 asc;



WITH Rolling_Total AS 
(select substring(`date`, 1, 7) AS `Month`, SUM(total_laid_off) as total_off
from layoffs_staging2
where substring(`date`, 1, 7) is not null
group by `Month`
order by 1 asc
)

select `Month`, total_off, sum(total_off) over(order by `Month`) as rolling_total
from Rolling_Total;
 
 
select COMPANY, SUM(total_laid_off)
from layoffs_staging2
GROUP BY company
order by 2 DESC;


select COMPANY, YEAR(`date`), SUM(total_laid_off)
from layoffs_staging2
GROUP BY company, YEAR(`date`)
order by 3 DESC;



WITH Company_Year(company, years, total_laid_off) as 
(select COMPANY, YEAR(`date`), SUM(total_laid_off)
from layoffs_staging2
GROUP BY company, YEAR(`date`)
),
 Company_Year_Rank as 

(select *,
dense_rank() OVER(partition by years order by total_laid_off desc) as Ranking
from Company_Year
where years is not null
)

Select * 
from Company_Year_Rank
where Ranking <= 5;
