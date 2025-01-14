-- Estudando o Banco de Dados

SELECT * FROM categorias;
SELECT * FROM marcas;
select * from fornecedores;
SELECT * FROM produtos LIMIT 100;
SELECT * FROM vendas LIMIT 500;
SELECT * FROM clientes LIMIT 500;
SELECT * FROM itens_venda LIMIT 500;

-- Selecionar a quantidade total de registros em cada Tabela
SELECT COUNT(*) as Qtd, 'Categorias' as Tabela FROM categorias
UNION ALL
SELECT COUNT(*) as Qtd, 'Clientes' as Tabela FROM clientes
UNION ALL
SELECT COUNT(*) as Qtd, 'Fornecedores' as Tabela FROM fornecedores
UNION ALL
SELECT COUNT(*) as Qtd, 'ItensVenda' as Tabela FROM itens_venda
UNION ALL
SELECT COUNT(*) as Qtd, 'Marcas' as Tabela FROM marcas
UNION ALL
SELECT COUNT(*) as Qtd, 'Produtos' as Tabela FROM produtos
UNION ALL
SELECT COUNT(*) as Qtd, 'Vendas' as Tabela FROM vendas;

-- TRATAMENTO DE DADOS

BEGIN TRANSACTION;

UPDATE produtos
SET preco =
  CASE
  WHEN nome_produto = 'Bola de Futebol' AND preco < 20 THEN 20
  WHEN nome_produto = 'Bola de Futebol' AND preco > 100 THEN 100
  WHEN nome_produto = 'Chocolate' AND preco < 10 THEN 10
  WHEN nome_produto = 'Chocolate' AND preco > 50 THEN 50
  WHEN nome_produto = 'Celular' AND preco < 80 THEN 80
  WHEN nome_produto = 'Celular' AND preco > 5000 THEN 5000
  WHEN nome_produto = 'Livro de Ficção' AND preco < 10 THEN 10
  WHEN nome_produto = 'Livro de Ficção' AND preco > 200 THEN 200
  WHEN nome_produto = 'Camisa' AND preco < 80 THEN 80
  WHEN nome_produto = 'Camisa' AND preco > 200 THEN 200
  ELSE preco
  END
WHERE categoria_id IN (1, 2, 3, 4, 5);

SELECT * FROM produtos;

COMMIT;

-- AMOSTRAGEM

SELECT * FROM vendas LIMIT 100;

-- ANOS DAS VENDAS
SELECT DISTINCT(strftime('%Y', data_venda)) AS Ano
FROM vendas
ORDER BY Ano;

-- QUANTIDADE DE VENDAS POR ANO
SELECT strftime('%Y', data_venda) AS Ano, COUNT(*) AS total_Vendas
FROM vendas
GROUP BY Ano
ORDER BY Ano;

-- QUANTIDADE DE VENDAS POR MÊS
SELECT strftime('%Y', data_venda) AS Ano, strftime('%m', data_venda) AS Mes, COUNT(*) AS total_Vendas
FROM vendas
GROUP BY Ano, Mes
ORDER BY Ano;

-- QUANTIDADE DE VENDAS NOS MESES: JAN, NOV, DEZ
SELECT strftime('%Y', data_venda) AS Ano, strftime('%m', data_venda) AS Mes, COUNT(*) AS total_Vendas
FROM vendas
WHERE Mes IN ('01', '11', '12')
GROUP BY Ano, Mes
ORDER BY Ano;

-- Papel dos fornecedores na Black Friday

SELECT strftime('%Y/%m', v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
FROM itens_venda iv
JOIN vendas v ON iv.venda_id = v.id_venda
JOIN produtos p ON iv.produto_id = p.id_produto
JOIN fornecedores f ON p.fornecedor_id = f.id_fornecedor
WHERE strftime('%m', v.data_venda) = '11'
GROUP BY Nome_Fornecedor, "Ano/Mes"
ORDER BY "Ano/Mes", Qtd_Vendas DESC;

-- Categorias de produtos na Black Frinday

SELECT strftime('%Y', v.data_venda) AS Ano, c.nome_categoria AS Nome_Categoria, COUNT(iv.produto_id) AS QtdVendas
FROM itens_venda iv
JOIN vendas v ON iv.venda_id = v.id_venda
JOIN produtos p ON iv.produto_id = p.id_produto
JOIN categorias c ON p.categoria_id = c.id_categoria
WHERE strftime('%m', v.data_venda) = '11'
GROUP BY c.nome_categoria, Ano
ORDER BY Ano, QtdVendas DESC;


-- Soma das Vendas (mostrar que os dados estão atualizados)

SELECT SUM(Qtd_Vendas)
FROM (
  SELECT strftime('%Y/%m', v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
  FROM itens_venda iv
  JOIN vendas v ON iv.venda_id = v.id_venda
  JOIN produtos p ON iv.produto_id = p.id_produto
  JOIN fornecedores f ON p.fornecedor_id = f.id_fornecedor
  GROUP BY Nome_Fornecedor, "Ano/Mes"
  ORDER BY "Ano/Mes", Qtd_Vendas DESC
);

SELECT COUNT(venda_id) FROM itens_venda;

-- Performace da NebulaNetworks (fornecedor)

SELECT strftime('%Y/%m', v.data_venda) AS "Ano/Mes", COUNT(iv.produto_id) AS Qtd_Vendas
FROM itens_venda iv
JOIN vendas v ON iv.venda_id = v.id_venda
JOIN produtos p ON iv.produto_id = p.id_produto
JOIN fornecedores f ON p.fornecedor_id = f.id_fornecedor
WHERE f.nome = 'NebulaNetworks'
GROUP BY f.nome, "Ano/Mes"
ORDER BY "Ano/Mes";

-- Comparação entre Fornecedores (Nebula Networks, HorizonDistributors e AstroSupply)

SELECT "Ano/Mes",
SUM (CASE WHEN Nome_Fornecedor = 'NebulaNetworks' THEN Qtd_Vendas ELSE 0 END) AS Qtd_Vendas_NebulaNetworks,
SUM (CASE WHEN Nome_Fornecedor = 'HorizonDistributors' THEN Qtd_Vendas ELSE 0 END) AS Qtd_Vendas_HorizonDistributors,
SUM (CASE WHEN Nome_Fornecedor = 'AstroSupply' THEN Qtd_Vendas ELSE 0 END) AS Qtd_Vendas_AstroSupply
FROM (
  SELECT strftime('%Y/%m', v.data_venda) AS "Ano/Mes", f.nome AS Nome_Fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
  FROM itens_venda iv
  JOIN vendas v ON iv.venda_id = v.id_venda
  JOIN produtos p ON iv.produto_id = p.id_produto
  JOIN fornecedores f ON p.fornecedor_id = f.id_fornecedor
  WHERE Nome_Fornecedor IN ('NebulaNetworks', 'HorizonDistributors', 'AstroSupply')
  GROUP BY Nome_Fornecedor, "Ano/Mes"
  ORDER BY "Ano/Mes", Qtd_Vendas
)
GROUP BY "Ano/Mes";


-- Porcentagem das Categorias

SELECT Nome_Categoria, Qtd_Vendas, ROUND(100.0*Qtd_Vendas/(SELECT COUNT(*) FROM itens_venda), 2) || '%' AS Porcentagem
FROM (
  SELECT c.nome_categoria AS Nome_Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
  FROM itens_venda iv
  JOIN produtos p ON iv.produto_id = p.id_produto
  JOIN categorias c ON p.categoria_id = c.id_categoria
  GROUP BY c.nome_categoria
  ORDER BY Qtd_Vendas DESC
)
;

-- Porcentagem das Marcas

SELECT Nome_Marca, Qtd_Vendas, ROUND(100.0*Qtd_Vendas/(SELECT COUNT(*) FROM itens_venda), 2) AS Porcentagem
FROM (
  SELECT m.nome AS Nome_Marca, COUNT(iv.venda_id) AS Qtd_Vendas
  FROM itens_venda iv
  JOIN produtos p ON iv.produto_id = p.id_produto
  JOIN marcas m ON p.marca_id = m.id_marca
  GROUP BY Nome_Marca
)
ORDER BY Porcentagem DESC;


-- Soma das Porcentagens (Retorno: 100%)

SELECT SUM(Porcentagem)
FROM (
  SELECT Nome_Marca, Qtd_Vendas, ROUND(100.0*Qtd_Vendas/(SELECT COUNT(*) FROM itens_venda), 2) AS Porcentagem
  FROM (
    SELECT m.nome AS Nome_Marca, COUNT(iv.venda_id) AS Qtd_Vendas
    FROM itens_venda iv
    JOIN produtos p ON iv.produto_id = p.id_produto
    JOIN marcas m ON p.marca_id = m.id_marca
    GROUP BY Nome_Marca
  )
)
;

-- Porcentagem dos Fornecedores

SELECT Nome_Fornecedor, ROUND(100.0*Qtd_Vendas/(SELECT COUNT(*) FROM itens_venda), 2) AS Porcentagem
FROM (
  SELECT f.nome AS Nome_Fornecedor, COUNT(iv.venda_id) AS Qtd_Vendas
  FROM itens_venda iv
  JOIN produtos p ON iv.produto_id = p.id_produto
  JOIN fornecedores f ON p.fornecedor_id = f.id_fornecedor
  GROUP BY Nome_Fornecedor
)
ORDER BY Porcentagem DESC;


-- Vendas gerais por meses do ano

SELECT strftime('%Y/%m', data_venda) AS "Ano/Mes", COUNT(*) AS Qtd_Vendas
FROM vendas
GROUP BY "Ano/Mes"
ORDER BY "Ano/Mes";


SELECT Mes,
SUM (CASE WHEN Ano = '2020' THEN Qtd_Vendas ELSE 0 END) AS '2020',
SUM (CASE WHEN Ano = '2021' THEN Qtd_Vendas ELSE 0 END) AS '2021',
SUM (CASE WHEN Ano = '2022' THEN Qtd_Vendas ELSE 0 END) AS '2022',
SUM (CASE WHEN Ano = '2023' THEN Qtd_Vendas ELSE 0 END) AS '2023'
FROM (
  SELECT strftime('%m', data_venda) AS Mes, strftime('%Y', data_venda) AS Ano, COUNT(*) AS Qtd_Vendas
  FROM vendas
  GROUP BY Mes, Ano
  ORDER BY Mes
)
GROUP BY Mes
;

-- Métricas

SELECT AVG(Qtd_Vendas) AS Média_Qtd_Vendas
FROM (
  SELECT COUNT(*) AS Qtd_Vendas, strftime('%Y', v.data_venda) AS Ano
  FROM vendas v
  WHERE strftime('%m', v.data_venda) = '11' AND Ano != '2022'
  GROUP BY Ano
)
;


SELECT Qtd_Vendas AS Qtd_Vendas_Atual
FROM (
  SELECT COUNT(*) AS Qtd_Vendas, strftime('%Y', v.data_venda) AS Ano
  FROM vendas v
  WHERE strftime('%m', v.data_venda) = '11' AND Ano = '2022'
  GROUP BY Ano
)
;


WITH Media_Vendas_Anteriores AS
  (SELECT AVG(Qtd_Vendas) AS Media_Qtd_Vendas
  FROM (
    SELECT COUNT(*) AS Qtd_Vendas, strftime('%Y', v.data_venda) AS Ano
    FROM vendas v
    WHERE strftime('%m', v.data_venda) = '11' AND Ano != "2022"
    GROUP BY Ano
  )),
Vendas_Atual AS
  (SELECT Qtd_Vendas AS Qtd_Vendas_Atual
  FROM (
    SELECT COUNT(*) AS Qtd_Vendas, strftime('%Y', v.data_venda) AS Ano
    FROM vendas v
    WHERE strftime('%m', v.data_venda) = "11" AND Ano = "2022"
    GROUP BY Ano
  ))
SELECT
mva.Media_Qtd_Vendas,
va.Qtd_Vendas_Atual,
ROUND((va.Qtd_Vendas_Atual - mva.Media_Qtd_Vendas)/mva.Media_Qtd_Vendas *100.0, 2) || '%' AS Porcentagem
FROM Vendas_Atual va, Media_Vendas_Anteriores mva
;