-- Análise da Dívida Internacional (World Bank Data)
-- By Giovanna Francisco

-- Visão Geral: Quantos países distintos possuem registros de dívida? 

SELECT count(DISTINCT country_name) AS total_distinct_countries

FROM public.international_debt;

-- Análise de Risco: Qual país possui a maior dívida externa acumulada?

SELECT country_name,
       SUM(debt) AS total_debt
	
FROM public.international_debt
	
GROUP BY country_name
	
ORDER BY total_debt DESC

LIMIT 1;

-- Top 5 países mais endividados

SELECT country_name,
       ROUND(SUM(debt), 2) AS total_debt
	
FROM public.international_debt
	
GROUP BY country_name
	
ORDER BY total_debt DESC

LIMIT 5;


-- Análise de Menor Exposição: Qual país tem a menor dívida?

SELECT country_name,
       SUM(debt) AS total_debt
	
FROM public.international_debt
	
GROUP BY country_name
	
ORDER BY total_debt ASC
	
LIMIT 1;

-- Indicador de Repagamento: Qual o menor valor registrado?

SELECT country_name,
       indicator_name,
       debt AS lowest_repayment

FROM public.international_debt

WHERE indicator_code = 'DT.AMT.DLXF.CD'

ORDER BY debt ASC;

LIMIT 1;

-- Qual a média de dívida por país?

SELECT ROUND(AVG(total_debt), 2) AS avg_debt

FROM (SELECT sum(debt) as total_debt
        FROM public.international_debt
        GROUP BY country_name) AS subquery_avg;