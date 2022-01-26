-- List all 'Jurassic Park' contestants who are in the 'actor' or 'actress' category, giving each of their name, year of birth, profession, category and task.
SELECT titulo_principal, nome, ano_nasc, prof, categoria, tarefa
FROM "pessoa", "partic", "prod", "profissao"
WHERE "pessoa".id_pessoa = "partic".id_pessoa and "prod".id_prod = "partic".id_prod and 
"profissao".id_pessoa = "pessoa".id_pessoa and titulo_principal LIKE '%Jurassic Park%' 
and categoria IN ('actor', 'actress');

-- List all 'Jurassic Park' contestants, except those in the 'actor' or 'actress' category, with name, year of birth, profession, category and task of each of them.
SELECT titulo_principal, nome, ano_nasc, prof, categoria, tarefa
FROM "pessoa", "partic", "prod", "profissao"
WHERE "pessoa".id_pessoa = "partic".id_pessoa and "prod".id_prod = "partic".id_prod and
"profissao".id_pessoa = "pessoa".id_pessoa and titulo_principal LIKE '%Jurassic Park%'
and categoria NOT IN ('actor', 'actress');

-- List the title and year of production of all films in which 'Tom Hanks' and 'Meg Ryan' participated simultaneously
SELECT titulo_principal, ano_prod, nome
FROM "prod", "partic", "pessoa"
WHERE "prod".id_prod = "partic".id_prod and 
"pessoa".id_pessoa = "partic".id_pessoa and 
nome LIKE '%Tom Hanks%' and nome LIKE '%Meg Ryan%';

-- List all films of the 'Action' or 'Adventure' genre in which the person 'Bruce Willis' participated as an actor, with name and year of production.
SELECT titulo_principal, ano_prod, nome
FROM "prod", "partic", "pessoa"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
categoria LIKE '%Action%' or categoria LIKE '%Adventure%' and nome LIKE '%Bruce Willis%';

-- List the name, year of birth and year of death of all directors who have directed films written by 'Dalton Trumbo' without repetition.
SELECT nome, ano_nasc, ano_morte, prof
FROM "pessoa", "prod", "partic", "profissao"
WHERE "pessoa".id_pessoa = "partic".id_pessoa and "prod".id_prod = "partic".id_prod and
"profissao".id_pessoa = "pessoa".id_pessoa and "pessoa".nome LIKE '%Dalton Trumbo%' and
"profissao".prof LIKE '%director%';

-- Select films written by Dalton Trumbo
SELECT titulo_principal
FROM "prod", "partic", "pessoa"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
"pessoa".nome LIKE '%Dalton Trumbo%';


-- List the name, alt_title and the main title of all films whose language is 'pt' produced since 2000
SELECT titulo_alt, titulo_principal
FROM "prod", "prod_alt"
WHERE "prod".id_prod = "prod_alt".id_prod and
ano_prod >= 2000 and idioma LIKE '%pt%';

-- Obter o título principal e o nome do roteirista do filme cujo "titulo_alt"  é ‘Suplício de uma Saudade’
SELECT titulo_alt, titulo_principal, nome
FROM "prod", "prod_alt", "partic", "pessoa", "profissao"
WHERE "prod".id_prod = "prod_alt".id_prod and
"prod_alt".titulo_alt LIKE '%Suplício de uma Saudade%' and
"partic".id_prod = "prod".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
"profissao".id_pessoa = "pessoa".id_pessoa and
"profissao".prof LIKE '%director%';

-- List the names of the actors in the movie 'Suplício de uma Saudade' from the titulo_alt table
SELECT titulo_alt, titulo_principal, nome as atores
FROM "prod", "prod_alt", "partic", "pessoa"
WHERE "prod".id_prod = "prod_alt".id_prod and
"prod_alt".titulo_alt LIKE '%Suplício de uma Saudade%' and
"partic".id_prod = "prod".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
categoria LIKE '%actor%';

-- List the major titles and production years of films that the person 'William Holden' participated in and that have a rating of 7 or above, in order of rating
SELECT titulo_principal, ano_prod, avaliacao, nome as atores
FROM "prod", "partic", "pessoa"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
nome LIKE '%William Holden%' and
avaliacao >= 7
ORDER BY avaliacao DESC;

-- . List the main title, titulo_alt, year of production, rating and duration in minutes of the films in which 'Toshiro Mifune' participated.
SELECT titulo_principal, titulo_alt, ano_prod, avaliacao, tempo_minutos
FROM "prod", "partic", "pessoa", "prod_alt"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
"prod_alt".id_prod = "prod".id_prod and
"pessoa".nome LIKE '%Toshiro Mifune%';

SELECT nome
FROM "pessoa"
WHERE nome LIKE '%Toshiro Mifune%';

-- Listar produções tipo_prod = "tvSeries" o titulo, o numero da temporada, o numero do episodio que ‘Bryan Cranston’ participou. Organizar a saida em ordem de ano de produção.
SELECT tipo_prod, titulo_principal, temporada, episodio, ano_prod, pessoa
FROM "prod", "partic", "pessoa", "episodio"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
"episodio".id_prod = "prod".id_prod and
nome LIKE '%Bryan Cranston%'
ORDER BY ano_prod, temporada, episodio DESC;

-- List the titles, year of production and year of ending of TV series (tvSeries) whose rating is above 8.5
SELECT titulo_principal, ano_prod, ano_fim, avaliacao
FROM "prod", "prod_alt"
WHERE "prod".id_prod = "prod_alt".id_prod and
tipo_prod LIKE '%tvSeries%' and
avaliacao >= 8.5 ORDER BY avaliacao DESC;

-- Generate the number of 'War' movies each year between 1940 and 2000 in descending order.
SELECT ano_prod, count(*) 
FROM "prod", "genero"
WHERE "prod".id_prod = "genero".id_prod and
genero LIKE '%War%' and
ano_prod >= 1940 and ano_prod <= 2000
GROUP BY ano_prod
ORDER BY count DESC;

-- Determine the number of productions in each genre, presenting the list in descending order of quantity, and only for genres with more than 100,000 productions
SELECT genero, count(*)
FROM "prod", "genero"
WHERE "prod".id_prod = "genero".id_prod
GROUP BY genero
HAVING count(*) > 100000
ORDER BY count DESC;

-- Determine the average rating of films of each genre, and present the result in descending order of rating.
SELECT genero, avg(avaliacao)
FROM "prod", "genero"
WHERE "prod".id_prod = "genero".id_prod
GROUP BY genero
ORDER BY avg DESC;

-- Determine the number of productions in each combination of production type and genre.
SELECT tipo_prod, genero, count(*)
FROM "prod", "genero"
WHERE "prod".id_prod = "genero".id_prod
GROUP BY tipo_prod, genero
ORDER BY count DESC;

-- Determine the average rating of all productions in which 'Steven Spielberg' participated.
SELECT nome, avg(avaliacao)
FROM "prod", "partic", "pessoa"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
nome LIKE '%Steven Spielberg%'
GROUP BY nome;

-- Determine the average rating of all productions whose director was 'Steven Spielberg'.
SELECT nome, prof, avg(avaliacao)
FROM "prod", "partic", "pessoa", "profissao"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
"profissao".id_pessoa = "pessoa".id_pessoa and prof LIKE '%director%' and
nome LIKE '%Steven Spielberg%'
GROUP BY nome, prof;


-- Determinar a quantidade de participantes da produção cujo título principal é ‘Toy Story’
SELECT titulo_principal, count(*)
FROM "prod", "partic", "pessoa"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
titulo_principal LIKE 'Toy Story%'
GROUP BY titulo_principal;

-- Determinar a média de idade das pessoas cuja profissão é ‘actor’ ou ‘actress’
SELECT prof, avg(ano_prod - ano_nasc)
FROM "prod", "partic", "pessoa", "profissao"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
"profissao".id_pessoa = "pessoa".id_pessoa and
(prof LIKE '%actor%' or prof LIKE '%actress%')
GROUP BY prof;


-- Determinar a pessoa cuja profissão é ‘actor’ ou ‘actress’ que tem a maior quantidade de participações em produções.
SELECT nome, prof, count(*)
FROM "prod", "partic", "pessoa", "profissao"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
"profissao".id_pessoa = "pessoa".id_pessoa and
(prof LIKE '%actor%' or prof LIKE '%actress%')
GROUP BY nome, prof
ORDER BY count DESC;

-- Qual o filme que tem a maior quantidade de pessoas registradas.
SELECT titulo_principal, count(*)
FROM "prod", "partic"
WHERE "prod".id_prod = "partic".id_prod
GROUP BY titulo_principal
ORDER BY count DESC;

-- Criar uma visão em que se possa consultar apenas actore, actress, títulos e anos dos filmes em que atuaram.


CREATE VIEW "atores_e_atri" AS
SELECT "pessoa".nome, "profissao".prof, "prod".titulo_principal, "prod".ano_prod
FROM "prod", "partic", "pessoa", "profissao"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
"profissao".id_pessoa = "pessoa".id_pessoa and
(prof LIKE '%actor%' or prof LIKE '%actress%')
ORDER BY "pessoa".nome LIMIT 100;

SELECT * FROM "atores_e_atri";
