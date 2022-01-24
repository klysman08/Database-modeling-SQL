-- Selecionando a média das avaliações dos filmes em função do ano de lançamento.
SELECT ano_prod, AVG (avaliacao)
FROM prod
WHERE ano_prod > 1990
GROUP BY ano_prod
HAVING AVG (avaliacao) < 6.5 LIMIT 10;

-- Selecionando filmes com titulo de produção contendo a string new e ano de produção maior que 1990
SELECT titulo_principal, avaliacao
FROM "prod"
WHERE ano_prod > 1990 and titulo_principal LIKE '%new%'

--Select all movies (movie) produced in the year 1939 and list their title main and year of production.
SELECT titulo_principal, ano_prod
FROM "prod"
WHERE ano_prod = 1939;

--List the names and birth years of all persons involved in productions whose first name is 'Jennifer'.
SELECT nome, ano_nasc
FROM "pessoa"
WHERE nome LIKE '%Jennifer%';

--Select all films (movie) that featured 'Tom Hanks' in the 1990s, and list their title, year of production and duration in minutes.
SELECT titulo_principal, ano_prod, tempo_minutos
FROM "prod"
WHERE ano_prod > 1989 and ano_prod < 2000 and titulo_principal LIKE '%Tom Hanks%';

--Filmes que Tom Hanks participou e ano de produção.
SELECT titulo_principal, nome, ano_prod
FROM "prod", "partic", "pessoa"
WHERE "prod".id_prod = "partic".id_prod and "pessoa".id_pessoa = "partic".id_pessoa and nome LIKE '%Tom Hanks%';

-- FIlmes com Tom Hanks e ano de produção somente em 2000 e 1999;
SELECT DISTINCT titulo_principal, nome, ano_prod
FROM "prod", "partic", "pessoa"
WHERE "prod".id_prod = "partic".id_prod and "pessoa".id_pessoa = "partic".id_pessoa and nome LIKE '%Tom Hanks%' and ano_prod IN ('2000', '1999');