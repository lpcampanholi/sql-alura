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

SELECT strftime('%Y/%m', v.data_venda) AS "Ano/Mes", f.nome AS nome_fornecedor, COUNT(iv.produto_id) AS Qtd_Vendas
FROM itens_venda iv
JOIN vendas v ON iv.venda_id = v.id_venda
JOIN produtos p ON iv.produto_id = p.id_produto
JOIN fornecedores f ON p.fornecedor_id = f.id_fornecedor
GROUP BY nome_fornecedor, "Ano/Mes"
ORDER BY nome_fornecedor;

-- Categorias de produtos na Black frinday