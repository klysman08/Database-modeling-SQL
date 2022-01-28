-- List all 'Jurassic Park' contestants who are in the 'actor' or 'actress' category, giving each of their name, year of birth, profession, category and task.
SELECT titulo_principal, nome, ano_nasc, prof, categoria, tarefa
FROM "pessoa", "partic", "prod", "profissao"
WHERE "pessoa".id_pessoa = "partic".id_pessoa and "prod".id_prod = "partic".id_prod and 
"profissao".id_pessoa = "pessoa".id_pessoa and titulo_principal LIKE '%Jurassic Park%' 
and categoria IN ('actor', 'actress');

-- Listar os nomes e anos de nascimento de todas as pessoas envolvidas em produções cujo primeiro nome é ‘Jennifer’.
SELECT titulo_principal, nome, ano_nasc
FROM "pessoa", "partic", "prod"
WHERE "pessoa".id_pessoa = "partic".id_pessoa and "prod".id_prod = "partic".id_prod and
nome LIKE '%Jennifer%' and ano_nasc is not null;

-- Selecionar todos os filmes (movie) produzidos no ano de 1939 e listar seu título principal e ano de produção
SELECT titulo_principal, ano_prod
FROM "prod"
WHERE ano_prod = 1939;

-- Listar o título e o ano de produção de todos os filmes dos quais participaram simultaneamente ‘Tom Hanks’ e ‘Meg Ryan’ 
-- (ou seja, que foram produzidos simultaneamente por ambos).
SELECT titulo_principal, ano_prod
FROM "prod", "partic", "pessoa" 
WHERE "prod".id_prod = "partic".id_prod and "pessoa".id_pessoa = "partic".id_pessoa and
nome LIKE '%Tom Hanks%' and nome LIKE '%Meg Ryan%';



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
SELECT DISTINCT titulo_principal, nome, ano_nasc, ano_morte, nome, prof
FROM "pessoa", "prod", "partic", "profissao"
WHERE "pessoa".id_pessoa = "partic".id_pessoa and "prod".id_prod = "partic".id_prod and
"profissao".id_pessoa = "pessoa".id_pessoa and "pessoa".nome LIKE '%Dalton Trumbo%' and
"profissao".prof LIKE '%writer%';

-- Listar todos os filmes do gênero ‘Action’ ou ‘Adventure’ dos quais participou como ator a pessoa ‘Bruce Willis’, apresentando nome e ano de produção.
SELECT titulo_principal, ano_prod, nome, categoria
FROM "prod", "partic", "pessoa"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and nome LIKE '%Bruce Willis%' and
categoria LIKE '%Action%' or categoria LIKE '%Adventure%'; 


-- listar filmes que %Dalton Trumbo%' foi writer e o nome dos diretores desses Filmes
SELECT DISTINCT titulo_principal, nome, ano_nasc, ano_morte, nome, prof
FROM "pessoa", "prod", "partic", "profissao"
WHERE "pessoa".id_pessoa = "partic".id_pessoa and "prod".id_prod = "partic".id_prod and
"profissao".id_pessoa = "pessoa".id_pessoa and "pessoa".nome LIKE '%Dalton Trumbo%' and
"profissao".prof LIKE '%writer%';




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
SELECT DISTINCT tipo_prod, genero, count(*)
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

-- Determinar a produção (título principal, ano de produção) que tem a maior quantidade de atores registrados e num_votos maior que 10000
SELECT titulo_principal, ano_prod, count(*)
FROM "prod", "partic", "pessoa"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
num_votos > 1000
GROUP BY titulo_principal, ano_prod
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


-- Listar as pessoas que participaram de movie ou tvSeries na decada de 1990 em ordem alfabética.
SELECT nome, prof, titulo_principal, ano_prod
FROM "prod", "partic", "pessoa", "profissao"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
"profissao".id_pessoa = "pessoa".id_pessoa and
(prof LIKE '%actor%' or prof LIKE '%actress%') and
ano_prod >= 1990 and ano_prod <= 1999
ORDER BY nome;

-- Listar as pessoas que participaram de movie, tvSeries ( temporada e episodio ) na decada de 1990 em ordem alfabética.
SELECT nome, prof, tipo_prod, titulo_principal, ano_prod, temporada, episodio
FROM "prod", "partic", "pessoa", "profissao", "episodio"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
"profissao".id_pessoa = "pessoa".id_pessoa and
"episodio".id_prod = "prod".id_prod and
(prof LIKE '%actor%' or prof LIKE '%actress%') and
ano_prod >= 1990 and ano_prod <= 1999
ORDER BY nome;

-- Listar o título_principal, titulo_alt, ano_prod, avaliacao e tempo_minutos dos titulo_principal ‘Toshiro Mifune’ partipou.
SELECT titulo_principal, titulo_alt, ano_prod, avaliacao, tempo_minutos
FROM "prod", "partic", "pessoa", "prod_alt"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
"prod_alt".id_prod = "prod".id_prod and
nome LIKE '%Toshiro Mifune%'
ORDER BY ano_prod;




-- Listar as pessoas que participaram de movie com avaliação acima de 8.5, mas não de TvSeries, na década de 1990 em ordem do ano de nascimento 
SELECT nome, ano_nasc, prof, titulo_principal, ano_prod
FROM "prod", "partic", "pessoa", "profissao"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
"profissao".id_pessoa = "pessoa".id_pessoa and
(prof LIKE '%actor%' or prof LIKE '%actress%') and
ano_prod >= 1990 and ano_prod <= 1999 and
avaliacao >= 8.5 and tipo_prod != 'tvSeries'
ORDER BY ano_nasc DESC;

-- Listar as pessoas que participaram simultaneamente, na mesma produção, como roteirista (tabela autor), como diretor (tabela diretor) e como ator (tabela partic, categoria ‘actor’ ou ‘actress’).
SELECT nome, prof, titulo_principal, ano_prod
FROM "prod", "partic", "pessoa", "profissao", "diretor", "autor"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
"profissao".id_pessoa = "pessoa".id_pessoa and
"diretor".id_prod = "prod".id_prod and
"autor".id_prod = "prod".id_prod and
(prof LIKE '%director%' or prof LIKE '%writer%') and
(prof LIKE '%actor%' or prof LIKE '%actress%')
ORDER BY nome;

--Determinar a produção (título principal, ano de produção) que tem a maior quantidade de diretores
SELECT titulo_principal, ano_prod, count(*)
FROM "prod", "diretor"
WHERE "prod".id_prod = "diretor".id_prod AND
num_votos >= 10000
GROUP BY titulo_principal, ano_prod
ORDER BY count DESC;

-- Determinar a produção (título principal, ano de produção) que tem a maior quantidade de roteiristas (autores).
SELECT titulo_principal, ano_prod, count(*)
FROM "prod", "autor"
WHERE "prod".id_prod = "autor".id_prod IS NOT NULL
GROUP BY titulo_principal, ano_prod
ORDER BY count DESC;

-- Determinar a produção (título principal, ano de produção) que tem a maior quantidade de roteiristas (autores) com avaliações maiores que 100000.
SELECT titulo_principal, ano_prod, count(*)
FROM "prod", "autor"
WHERE "prod".id_prod = "autor".id_prod and
num_votos >= 10000
GROUP BY titulo_principal, ano_prod
ORDER BY count DESC;


-- Determinar a produção do tipo ‘tvSeries’ ou ‘tvMiniSeries’ que tem a maior quantidade de episódios.
SELECT titulo_original, count(*)
FROM "prod", "episodio"
WHERE "prod".id_prod = "episodio".id_prod_principal and
(tipo_prod = 'tvSeries' or tipo_prod = 'tvMiniSeries')
GROUP BY titulo_original
ORDER BY count DESC;

-- Determinar a produção do tipo ‘tvSeries’ ou ‘tvMiniSeries’ que tem a menor quantidade de episódios.
SELECT titulo_original, count(*)
FROM "prod", "episodio"
WHERE "prod".id_prod = "episodio".id_prod_principal and
(tipo_prod = 'tvSeries' or tipo_prod = 'tvMiniSeries')
GROUP BY titulo_original
ORDER BY count ASC;

-- Determinar a duração média, mínima e máxima dos episódios de ‘tvSeries’.
SELECT titulo_original, avg(tempo_minutos) as avg, min(tempo_minutos), max(tempo_minutos)
FROM "prod", "episodio"
WHERE "prod".id_prod = "episodio".id_prod and tempo_minutos IS NOT NULL
GROUP BY titulo_original
ORDER BY avg DESC ;

-- Determinar a duração média, mínima e máxima dos episódios de ‘tvSeries’ com valores not NULL
SELECT avg(tempo_minutos), min(tempo_minutos), max(tempo_minutos)
FROM "prod", "episodio"
WHERE "prod".id_prod = "episodio".id_prod and
tempo_minutos is not NULL and tipo_prod LIKE '&tvSeries%'
GROUP BY titulo_principal
ORDER BY avg DESC ;


-- Determinar o personagem que com mais actors ou actress registrados.
SELECT categoria, personagem, count(*)
FROM "partic"
WHERE categoria LIKE '%actor%' or categoria LIKE '%actress%' and personagem IS NOT NULL
GROUP BY categoria, personagem
ORDER BY count DESC;


-- Determinar a serie que teva mais temporadas.
SELECT titulo_principal, count(*)
FROM "prod", "episodio"
WHERE "prod".id_prod = "episodio".id_prod_principal 
GROUP BY titulo_principal
order by count DESC;


-- Determinar a produção do tipo ‘movie’ que tem duração mais longa. 
SELECT titulo_principal, MAX (tempo_minutos)
FROM "prod"
WHERE tipo_prod = 'movie' and num_votos >= 10000
GROUP BY titulo_principal;


-- Determinar o total de votos apurados para avaliação dos filmes (movie) de cada gênero, e apresentar o resultado em ordem decrescente desse total.
SELECT genero, sum(num_votos)
FROM "prod", "genero"
WHERE "prod".id_prod = "genero".id_prod and
tipo_prod = 'movie' and num_votos >= 10000
GROUP BY genero
ORDER BY sum DESC;

-- Determinar a quantidade de produções por idioma


-- trocar valor null em idioma por 'en'
UPDATE "prod_alt"
SET idioma = 'en'
WHERE idioma is NULL;

SELECT idioma, count(*)
FROM "prod_alt"
GROUP BY idioma 
order by count DESC;


-- Determinar a produção do tipo ‘tvSeries’ ou ‘tvMiniSeries’ que tem a menor quantidade de episódios.
SELECT titulo_principal, count(*)
FROM "prod", "episodio"
WHERE "prod".id_prod = "episodio".id_prod and
tipo_prod = 'tvSeries' or tipo_prod = 'tvMiniSeries'
GROUP BY titulo_principal
ORDER BY count ASC;


-- Listar as pessoas que são simultaneamente roteirista (tabela autor), como diretor (tabela diretor) e como ator (tabela partic, categoria ‘actor’ ou ‘actress’) para o mesmo titulo_principal usando a função JOIN
SELECT "autor".nome_autor, "diretor".nome_diretor, "partic".personagem
FROM "autor", "diretor", "partic"
WHERE "autor".id_autor = "partic".id_autor and
"diretor".id_diretor = "partic".id_diretor and
"partic".categoria LIKE '%actor%' or "partic".categoria LIKE '%actress%' and
"partic".titulo_principal = 'The Godfather'
ORDER BY "autor".nome_autor, "diretor".nome_diretor, "partic".personagem;


-- Criar uma View para consultar apenas "actor" e "actress" e os título_principal e anos dos filmes (movie) em que atuaram
CREATE VIEW "view_partic" AS
SELECT "partic".personagem, "prod".titulo_principal, "prod".ano_prod
FROM "partic", "prod"
WHERE "partic".id_prod = "prod".id_prod and
"partic".categoria LIKE '%actor%' or "partic".categoria LIKE '%actress%'
ORDER BY "partic".personagem, "prod".ano_prod;

SELECT * FROM "view_partic"


CREATE VIEW "atores_e_atri" AS
SELECT "pessoa".nome, "profissao".prof, "prod".titulo_principal, "prod".ano_prod
FROM "prod", "partic", "pessoa", "profissao"
WHERE "prod".id_prod = "partic".id_prod and
"pessoa".id_pessoa = "partic".id_pessoa and
"profissao".id_pessoa = "pessoa".id_pessoa and
(prof LIKE '%actor%' or prof LIKE '%actress%')
ORDER BY "pessoa".nome LIMIT 100;

SELECT * FROM "atores_e_atri";

-- Criar uma view para os dados id_prod, título_principal, ano_prod e nome do diretor
CREATE VIEW "view_director2" AS
SELECT "prod".id_prod, "prod".titulo_principal, "prod".ano_prod, "pessoa".nome
FROM "prod", "diretor", "pessoa"
WHERE "prod".id_prod = "diretor".id_prod and
"pessoa".id_pessoa = "diretor".id_pessoa 
ORDER BY "prod".titulo_principal LIMIT 100;

SELECT * FROM "view_director2";



-- Alterar titulo_principal para incluir "TV episodio" para os elementos tipo_prod = 'tvSeries' e tipo_prod = 'tvMiniSeries'
UPDATE "prod"
SET titulo_principal = 'TV episodio'
WHERE tipo_prod = 'tvSeries' or tipo_prod = 'tvMiniSeries';

-- Alterar titulo_principal para incluir depois da string o texto "TV episodio"  para os elementos tipo_prod = 'tvSeries' e tipo_prod = 'tvMiniSeries'
UPDATE "prod"
SET titulo_principal = CONCAT(titulo_principal, ' TV episodio')
WHERE tipo_prod = 'tvSeries' or tipo_prod = 'tvMiniSeries';

SELECT titulo_principal, tipo_prod
FROM "prod"
WHERE titulo_principal LIKE '% TV episodio%' LIMIT 100;


-- Excluir as pessoas com mais de 120 anos de idade em 2021 e que não tenham data de morte registrada
DELETE FROM "pessoa"
WHERE (ano_morte - ano_nasc) > 120 and ano_morte is null and ano_nasc = 2021;


-- incluir dados da tabela pessoa ( id_pessoa, nome = Klsyman, ano_nasc = 1994, ano_morte = null)
INSERT INTO "pessoa" (id_pessoa, nome, ano_nasc, ano_morte)
VALUES ('gk0050085', 'Klsyman', 1994, null);

SELECT * FROM "pessoa"
WHERE nome LIKE '%Klsyman%';

--  criar registro em uma produção como “actor” da pessoa %Klysman%.
SELECT * FROM "prod"
WHERE titulo_principal LIKE '%Matrix%';
INSERT INTO "partic" (id_prod, id_pessoa, seq , categoria, personagem)
VALUES ('tt0133093', 'nk0050085','8', 'actor', 'The tired student');

SELECT * FROM partic
WHERE id_prod = 'tt0133093';

SELECT id_prod, titulo_principal, nome, ano_nasc, prof, personagem
FROM "pessoa", "partic", "prod", "profissao"
WHERE "pessoa".id_pessoa = "partic".id_pessoa and "prod".id_prod = "partic".id_prod and 
"profissao".id_pessoa = "pessoa".id_pessoa and id_prod = 'tt0133023';

-- Listar todos os atores de id_prod = 'tt0133093', titulo_principal, ano_prod, nome  e personagem
SELECT "pessoa".nome, "prod".titulo_principal, "prod".ano_prod, "partic".personagem
FROM "pessoa", "partic", "prod"
WHERE "pessoa".id_pessoa = "partic".id_pessoa and "prod".id_prod = "partic".id_prod and
"partic".categoria LIKE '%actor%' and "prod".id_prod = 'tt0133093'
ORDER BY "pessoa".nome, "prod".ano_prod, "partic".personagem;


