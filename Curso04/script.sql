SELECT * FROM categorias;
SELECT * FROM produtos;
SELECT * FROM vendas;
SELECT * FROM clientes;

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
