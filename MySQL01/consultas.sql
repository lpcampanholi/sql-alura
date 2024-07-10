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

SELECT p.nome AS proprietario, COUNT(h.hospedagem_id) AS qtd_hospedagens_ativas
FROM hospedagens h
JOIN proprietarios p ON h.proprietario_id = p.proprietario_id
WHERE h.ativo = 1
GROUP BY h.proprietario_id
ORDER BY qtd_hospedagens_ativas DESC
LIMIT 10;

-- Proprietários com hospedagens inativas na plataforma

SELECT p.nome AS proprietario, COUNT(h.hospedagem_id) AS qtd_hospedagens_inativas
FROM hospedagens h
JOIN proprietarios p ON h.proprietario_id = p.proprietario_id
WHERE h.ativo = 0
GROUP BY h.proprietario_id
ORDER BY qtd_hospedagens_inativas DESC;

-- Meses com maior e menor demanda de aluguel

SELECT
YEAR(data_inicio) AS ano,
MONTH(data_inicio) AS mes,
COUNT(*) AS total_alugueis
FROM alugueis
GROUP BY ano, mes
ORDER BY total_alugueis DESC;

-- Adicionar Colunas a Tabela

ALTER TABLE proprietarios
ADD COLUMN qtd_hospedagens INT;

-- Alterar nome da Tabela "alugueis" para "reservas"

ALTER TABLE alugueis RENAME TO reservas;

-- Alterar nome do campo "aluguel_id" para "reserva_id"

ALTER TABLE reservas RENAME COLUMN aluguel_id TO reserva_id;

-- Deletar coluna de uma Tabela

ALTER TABLE proprietarios DROP COLUMN qtd_hospedagens;

-- Atualizar Dados

UPDATE hospedagens SET ativo = 1 WHERE hospedagem_id IN ('1', '10', '100');

UPDATE proprietarios SET contato = 'daniela_120@email.com' WHERE proprietario_id = '1009';

-- Deletar Dados

DELETE FROM avaliacoes WHERE hospedagem_id IN ("1000", "1001");

DELETE FROM reservas WHERE hospedagem_id IN ("1000", "1001");

DELETE FROM hospedagens WHERE hospedagem_id IN ("10000", "1001");
