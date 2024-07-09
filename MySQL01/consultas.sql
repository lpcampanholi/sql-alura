SELECT * FROM alugueis;
SELECT * FROM avaliacoes;
SELECT * FROM clientes;
SELECT * FROM enderecos;
SELECT * FROM hospedagns;
SELECT * FROM proprietarios;

-- Quais são as hospedagens mais bem avaliadas? avaliacao = 4 ou 5

SELECT * FROM avaliacoes WHERE nota >= 4

SELECT nota, COUNT(*) AS qtd
FROM avaliacoes
GROUP BY nota
ORDER BY nota;

-- Quais hospedagens são do tipo hotel e estão ativas

SELECT * FROM hospedagens WHERE tipo = "hotel" AND ativo = 1;

-- Média de gasto por cliente

SELECT cliente_id AS cliente, AVG(preco_total) AS ticket_media
FROM alugueis
GROUP BY cliente_id;

-- Média de dias de aluguel

SELECT cliente_id, AVG(DATEDIFF(data_fim, data_inicio)) AS media_dias_estadia
FROM alugueis
GROUP BY cliente_id
ORDER BY media_dias_estadia DESC;


-- Exercício

SELECT produto_id, AVG(preco_venda) AS preco_medio
FROM vendas
WHERE data_venda BETWEEN DATE_SUB(CURDATE(), INTERVAL 1 YEAR) AND CURDATE()
GROUP BY produto_id;


-- Top 10 proprietários com mais hospedagens ativas na plataforma

SELECT proprietario_id AS proprietario, COUNT(hospedagem_id) AS qtd_hospedagens
FROM hospedagens
WHERE ativo = 1
GROUP BY proprietario_id
ORDER BY qtd_hospedagens
LIMIT 10;
