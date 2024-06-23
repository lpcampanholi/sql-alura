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

UPDATE produtos SET preco = 200 WHERE nome_produto LIKE '%chocolate%' AND preco > 200;

SELECT * FROM produtos
WHERE nome_produto LIKE '%chocolate%';

COMMIT;

