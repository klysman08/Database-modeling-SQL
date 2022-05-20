-- criar tabela CLIENTE, colunas CODCLI, NOME, E-MAIL, CODCLI chave primaria 
CREATE TABLE CLIENTE (
    CODCLI INTEGER NOT NULL PRIMARY KEY,
    NOME VARCHAR(50) NOT NULL,
    EMAIL VARCHAR(50) NOT NULL
);

-- criar tabela PRODUTO, colunas CP, NOMEPROD, DESCRI_PROD, CP como chave primaria
CREATE TABLE PRODUTO (
    CP INTEGER NOT NULL PRIMARY KEY,
    NOMEPROD VARCHAR(50) NOT NULL,
    DESCRI_PROD VARCHAR(150) NOT NULL
);

-- criar tabela VENDA, colunas CODCLI, CP, DATA, QUANT, VALOR e CODCLI referencia tabela CLIENTE(CODCLI) e CP referencia tabela PRODUTO(CP)
CREATE TABLE VENDA (
    CODCLI INTEGER NOT NULL,
    CP INTEGER NOT NULL,
    DATA DATE NOT NULL,
    QUANT INTEGER NOT NULL,
    VALOR FLOAT NOT NULL CHECK (VALOR >= 100),
    FOREIGN KEY (CODCLI) REFERENCES CLIENTE(CODCLI) ON DELETE CASCADE,
    FOREIGN KEY (CP) REFERENCES PRODUTO(CP) ON DELETE CASCADE
);

-- criar tabela CAT_COMP, colunas CATEG, DESCR_CATEGORIA, CATEG como chave primaria
CREATE TABLE CAT_COMP (
    CATEG VARCHAR(50) NOT NULL PRIMARY KEY,
    DESCR_CATEGORIA VARCHAR(50) NOT NULL
);
-- criar tabela COMPONENTE, colunas CAMPO, DESCR, CATEG, QUANT_ESTOQUE, CUSTO, FORN e COMPO como chave primaria
CREATE TABLE COMPONENTE (
    CAMPO INTEGER NOT NULL PRIMARY KEY,
    DESCR VARCHAR(150) NOT NULL,
    CATEG VARCHAR(50) NOT NULL,
    QUANT_ESTOQUE INTEGER NOT NULL,
    CUSTO FLOAT NOT NULL,
    FORN VARCHAR(50) NOT NULL,
    FOREIGN KEY (CATEG) REFERENCES CAT_COMP(CATEG)
);


-- criar tabela FORNEC, colunas CNPJ, RAZAO_SOCIAL, TELEFONE, URL, CNPJ como chave primaria
CREATE TABLE FORNEC (
    CNPJ INTEGER NOT NULL PRIMARY KEY,
    RAZAO_SOCIAL VARCHAR(50) NOT NULL,
    TELEFONE VARCHAR(50) NOT NULL,
    URL VARCHAR(50) NOT NULL
);

-- criar tabela COMP_PROD, colunas CP, CAMPO, QUANT. CP e CAMPO como chave estrangeira da tabela PORDUTO(CP) e COMPONENTE(CAMPO)
CREATE TABLE COMP_PROD (
    CP INTEGER NOT NULL,
    CAMPO INTEGER NOT NULL,
    QUANT INTEGER NOT NULL,
    FOREIGN KEY (CP) REFERENCES PRODUTO(CP) ON DELETE CASCADE,
    FOREIGN KEY (CAMPO) REFERENCES COMPONENTE(CAMPO) ON DELETE CASCADE
);


-- Listar o nome do cliente, data da venda, nome dos produtos e quantidade dos produtos que tiveram mais de 100 unidades vendidas para o mesmo cliente.
SELECT nome, data, nomeprod, quant
FROM cliente, venda, produto
WHERE cliente.codcli = venda.codcli
AND produto.cp = venda.cp
AND quant > 100;

-- listar os dados do produto "SENSOR_UV" da tabela PRODUTO, dados da tabela COMP_PROD e dados da tabela COMPONENTE
SELECT nomeprod, comp_prod.cp, comp_prod.campo, comp_prod.quant, componente.descr, componente.quant_estoque
FROM produto, comp_prod, componente
WHERE produto.cp = comp_prod.cp
AND componente.campo = comp_prod.campo
AND nomeprod = "SENSOR_UV"
ORDER BY cp ASC;

-- listar, sem repetições, o cp e descri_prod que usam componentes da categ= "OPTOELETRÔNICOS”"
SELECT DISTINCT produto.cp, descri_prod
FROM produto, comp_prod, componente
WHERE produto.cp = comp_prod.cp
AND componente.campo = comp_prod.campo
AND componente.categ = "OPTOELETRÔNICOS"
GROUP BY cp, descri_prod;

-- listar o custo total para produzir cada produto
SELECT nomeprod, SUM(custo * quant)
FROM produto, comp_prod, componente
WHERE produto.cp = comp_prod.cp
AND componente.campo = comp_prod.campo
GROUP BY nomeprod
HAVING SUM(custo * quant) > 100;



-- Calcular e apresentar o custo médio os componentes para cada categoria (categ e descr_categoria)
SELECT cat_comp.categ, descr_categoria, SUM(custo * quant) / SUM(quant) as Media
FROM cat_comp, componente, comp_prod
WHERE cat_comp.categ = componente.categ
AND componente.campo = comp_prod.campo
GROUP BY cat_comp.categ, descr_categoria;


-- aumentar os valores de custo em 10% de todos os componentes onde categ = "SEMICOND"
UPDATE componente
SET custo = custo * 1.1
WHERE categ = "SEMICOND";

-- Reduzir os valores de custo em 5% de todos os componentes exeto onde categ = "SEMICOND"
UPDATE componente
SET custo = custo * 0.95
WHERE categ != "SEMICOND";

-- Remover o produto onde cp = 37711321
DELETE FROM produto
WHERE cp = 37711321;

-- listar os cp e as quant total de cada produto vendido no ano de 2021, incluindo aqueles sem vendas
SELECT cp, SUM(quant)
FROM venda
WHERE YEAR(data) = 2021
GROUP BY cp
ORDER BY SUM(quant) DESC;


