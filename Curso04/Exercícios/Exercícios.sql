-- 01 - Qual é o número de Clientes que existem na base de dados ?

SELECT COUNT(id_cliente) AS Qtd_Clientes
FROM clientes;

-- 02 - Quantos produtos foram vendidos no ano de 2022 ?

SELECT COUNT(iv.produto_id) AS Qtd_Produtos_Vendidos
FROM vendas v
JOIN itens_venda iv ON v.id_venda = iv.venda_id
WHERE strftime('%Y', v.data_venda) = '2022';

-- 03 - Qual a categoria que mais vendeu em 2022 ?

SELECT c.nome_categoria AS Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
FROM vendas v
JOIN itens_venda iv ON v.id_venda = iv.venda_id
JOIN produtos p ON iv.produto_id = p.id_produto
JOIN categorias c ON p.categoria_id = c.id_categoria
WHERE strftime('%Y', v.data_venda) = '2022'
GROUP BY Categoria
ORDER BY Qtd_Vendas DESC
LIMIT 1;

-- 04 - Qual o primeiro ano disponível na base ?

SELECT MIN(strftime('%Y', data_venda)) FROM vendas

-- 05 - Qual o nome do fornecedor que mais vendeu no primeiro ano disponível na base ?

WITH QtdVendasFornecedores2020 AS
(
  SELECT f.nome AS Fornecedor, COUNT(iv.produto_id) AS Qtd_Produtos_Vendidos
  FROM vendas v
  JOIN itens_venda iv ON v.id_venda = iv.venda_id
  JOIN produtos p ON iv.produto_id = p.id_produto
  JOIN fornecedores f ON p.fornecedor_id = f.id_fornecedor
  WHERE strftime('%Y', v.data_venda) = (SELECT MIN(strftime('%Y', data_venda)) FROM vendas)
  GROUP BY Fornecedor
  ORDER BY Qtd_Produtos_Vendidos DESC
)
SELECT * FROM QtdVendasFornecedores2020
LIMIT 1;

-- 06 - Quanto ele vendeu no primeiro ano disponível na base de dados ?

SELECT f.nome AS Fornecedor, COUNT(iv.produto_id) AS Qtd_Produtos_Vendidos
FROM vendas v
JOIN itens_venda iv ON v.id_venda = iv.venda_id
JOIN produtos p ON iv.produto_id = p.id_produto
JOIN fornecedores f ON p.fornecedor_id = f.id_fornecedor
WHERE strftime('%Y', v.data_venda) = (SELECT MIN(strftime('%Y', data_venda)) FROM vendas)
GROUP BY Fornecedor
ORDER BY Qtd_Produtos_Vendidos DESC
LIMIT 1;

-- 07 - Quais as duas categorias que mais venderam no total de todos os anos ?

SELECT c.nome_categoria AS Categoria, COUNT(iv.produto_id) AS Qtd_Produtos_Vendidos
FROM itens_venda iv
JOIN produtos p ON iv.produto_id = p.id_produto
JOIN categorias c ON p.categoria_id = c.id_categoria
GROUP BY Categoria
ORDER BY Qtd_Produtos_Vendidos DESC
LIMIT 2;

-- 08 - Crie uma tabela comparando as vendas ao longo do tempo das duas categorias que mais venderam no total de todos os anos.

SELECT "Ano/Mês",
SUM(CASE WHEN Categoria = 'Eletrônicos' THEN Qtd_Vendas ELSE 0 END) AS Eletrônicos,
SUM(CASE WHEN Categoria = 'Vestuário' THEN Qtd_Vendas ELSE 0 END) AS Vestuário
FROM(
  SELECT strftime('%Y/%m', v.data_venda) AS "Ano/Mês", c.nome_categoria AS Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
  FROM itens_venda iv
  JOIN vendas v ON v.id_venda = iv.venda_id
  JOIN PRODUTOS p ON p.id_produto = iv.produto_id
  JOIN CATEGORIAS c ON c.id_categoria = p.categoria_id
  WHERE Categoria IN ('Eletrônicos', 'Vestuário')
  GROUP BY "Ano/Mês", Categoria
  ORDER BY "Ano/Mês", Categoria
)
GROUP BY "Ano/Mês"
;

-- 09 - Calcule a porcentagem de vendas por categorias no ano de 2022.

WITH Total_Vendas_2022 AS (
  SELECT COUNT(*) AS Total_Vendas
  FROM itens_venda iv
  JOIN vendas v ON v.id_venda = iv.venda_id
  WHERE strftime('%Y', v.data_venda) = '2022'
),
Vendas_Por_Categorias_2022 AS (
  SELECT c.nome_categoria AS Categoria, COUNT(iv.produto_id) AS Qtd_Vendas
  FROM vendas v
  JOIN itens_venda iv ON v.id_venda = iv.venda_id
  JOIN produtos p ON iv.produto_id = p.id_produto
  JOIN categorias c ON p.categoria_id = c.id_categoria
  WHERE strftime('%Y', v.data_venda) = '2022'
  GROUP BY Categoria
  ORDER BY Qtd_Vendas DESC
)
SELECT vc.Categoria, vc.Qtd_Vendas, ROUND(100.0*vc.Qtd_Vendas/tv.Total_Vendas, 2) || '%' AS Porcentagem
FROM Total_Vendas_2022 tv, Vendas_Por_Categorias_2022 vc
;

-- 10 - Crie uma métrica mostrando a porcentagem de vendas a mais que a melhor categoria tem em relação a pior no ano de 2022.