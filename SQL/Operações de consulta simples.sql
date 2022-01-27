-- Selecionando a média das avaliações dos filmes em função do ano de lançamento.
SELECT ano_prod, AVG (avaliacao)
FROM prod
WHERE ano_prod > 1990
GROUP BY ano_prod
HAVING AVG (avaliacao) > 6.5 LIMIT 10;

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
SELECT DISTINCT prod.titulo_principal, pessoa.nome AS ator_principal, prod.ano_prod
FROM "prod", "partic", "pessoa"
WHERE "prod".id_prod = "partic".id_prod and "pessoa".id_pessoa = "partic".id_pessoa and nome LIKE '%Tom Hanks%' and ano_prod IN ('2000', '1999');

SELECT DISTINCT prod.titulo_principal, pessoa.nome AS ator_principal, prod.ano_prod
FROM prod join partic on prod.id_prod = partic.id_prod join pessoa on pessoa.id_pessoa = partic.id_pessoa
WHERE pessoa.nome LIKE '%Tom Hanks%' and prod.ano_prod IN ('2000', '1999');

SELECT ano_prod, COUNT(*) as num_filmes
FROM prod GROUP BY ano_prod HAVING COUNT(*) > 60000 ORDER BY ano_prod DESC;

--Filmes que Tom Hanks participou e ano de produção agrupados com mais de 5 participações.
SELECT  pessoa.nome, prod.ano_prod, COUNT(prod.ano_prod)
FROM prod left join partic on prod.id_prod = partic.id_prod join pessoa on pessoa.id_pessoa = partic.id_pessoa
WHERE pessoa.nome LIKE '%Tom Hanks%' 
GROUP BY prod.ano_prod, pessoa.nome
HAVING COUNT(prod.ano_prod) > 5;

--Criando uma tabela temporaria com WITH para generos de filmes Action e Drama unindo as tabelas 
WITH 
action_genero AS (SELECT * FROM genero WHERE genero.genero LIKE '%Action%'),
drama_genero AS (SELECT * FROM genero WHERE genero.genero LIKE '%Drama%')
SELECT *
FROM action_genero 

UNION 

SELECT *
FROM drama_genero LIMIT 100; 


select count(*)
from pessoa
where ano_nasc is null
and ano_morte is null