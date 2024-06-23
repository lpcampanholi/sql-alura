-- UNION 
SELECT rua, bairro, cidade, estado, cep FROM colaboradores
UNION 
SELECT rua, bairro, cidade, estado, cep FROM fornecedores;

-- UNION ALL
SELECT nome, rua, bairro, cidade, estado, cep FROM colaboradores
UNION ALL
SELECT nome, rua, bairro, cidade, estado, cep FROM fornecedores;

-- SUBCONSULTAS
SELECT nome
FROM clientes
WHERE id = (
  SELECT idcliente
  FROM pedidos
  WHERE datahorapedido = '2023-01-02 08:15:00'
);

SELECT nome
FROM clientes
WHERE id IN (
  SELECT idcliente
  FROM pedidos
  WHERE strftime('%m', datahorapedido = '01')
);

SELECT nome, preco
FROM produtos
GROUP BY nome, preco
HAVING preco > (SELECT AVG(preco) FROM produtos);

-- INNER JOIN

SELECT c.nome, p.id, p.datahorapedido
FROM clientes c
INNER JOIN pedidos p
ON c.id = p.idcliente;

SELECT p.id, c.nome, p.datahorapedido, p.status
FROM pedidos p
LEFT JOIN clientes c
ON p.idcliente = c.id;

-- RIGHT JOIN

SELECT pr.nome, ip.idproduto, ip.idpedido
FROM itensdepedidos ip
RIGHT JOIN produtos pr
ON pr.id = ip.idproduto;

SELECT pr.nome, x.idproduto, x.idpedido
FROM(
  SELECT ip.idpedido, ip.idproduto
  FROM pedidos p
  JOIN itensdepedidos ip
  ON p.id = ip.idpedido
  WHERE strftime('%m', p.datahorapedido) = '10') x
RIGHT JOIN produtos pr
ON pr.id = x.idproduto;

-- Exercício

SELECT c.nome, p.id
FROM clientes c
LEFT JOIN pedidos p
ON c.id = p.IDcliente
WHERE p.IDcliente IS NULL;

-- LEFT JOIN

SELECT c.nome, p.id
FROM clientes c
LEFT JOIN pedidos p
ON c.id = p.idcliente
WHERE p.id IS NULL;

SELECT c.nome, x.id
FROM clientes c
LEFT JOIN
(
  SELECT p.id, p.idcliente
  FROM pedidos p
  WHERE strftime('%m', p.DataHoraPedido) = '09') x
ON c.id = x.idcliente
WHERE x.idcliente IS NULL;

-- FULL JOIN
SELECT c.nome, p.id
FROM clientes c
FULL JOIN pedidos p
ON c.id = p.idcliente
WHERE p.id IS NULL;

-- ---

SELECT p.id, pr.nome, ip.quantidade, pr.preco, ip.precounitario
from pedidos p
JOIN itensdepedidos ip ON p.id = ip.idpedido
JOIN produtos pr ON pr.id = ip.idproduto;

-- Total do faturamento por pedido

SELECT p.id, c.nome, p.datahorapedido, SUM(ip.precounitario) AS ValorTotalPedido
FROM clientes c
JOIN pedidos p ON c.id = p.idcliente
JOIN itensdepedidos ip ON p.id = ip.idpedido
GROUP BY p.id, c.nome;

-- Total do faturamento de cada cliente

SELECT c.nome, count(c.nome) QuantidadeDePedidos, SUM(ip.precounitario) SomaPorCliente
FROM clientes c
JOIN pedidos p ON c.id = p.idcliente
JOIN itensdepedidos ip ON p.id = ip.idpedido
GROUP BY c.nome
ORDER BY SomaPorCliente DESC;

-- VIEWS

CREATE VIEW ViewTelefonesClientes AS
SELECT nome, telefone FROM clientes;

CREATE VIEW ViewValorTotalPedido AS
SELECT p.id, c.nome, p.datahorapedido, SUM(ip.precounitario) AS ValorTotalPedido
FROM clientes c
JOIN pedidos p ON c.id = p.idcliente
JOIN itensdepedidos ip ON p.id = ip.idpedido
GROUP BY p.id, c.nome;

CREATE VIEW ViewValorTotalPorCliente AS
SELECT c.nome, count(c.nome) QuantidadeDePedidos, SUM(ip.precounitario) SomaPorCliente
FROM clientes c
JOIN pedidos p ON c.id = p.idcliente
JOIN itensdepedidos ip ON p.id = ip.idpedido
GROUP BY c.nome
ORDER BY SomaPorCliente DESC;

SELECT * FROM ViewTelefonesClientes;

SELECT * FROM ViewValorTotalPedido;

SELECT * FROM ViewValorTotalPorCliente;

SELECT * FROM ViewValorTotalPedido
where valortotalpedido > 10 AND valortotalpedido < 14;

SELECT * FROM ViewValorTotalPedido
WHERE strftime('%m', datahorapedido) = '08';

DROP VIEW ViewTelefonesClientes;

-- TRIGGER

CREATE TABLE Faturamentodiario (
  Dia DATE,
  FaturamentoTotal DECIMAL (10,2)
  );

CREATE TRIGGER CalculaFaturamentoDiario
AFTER INSERT ON itensdepedidos
FOR EACH ROW
BEGIN
  DELETE FROM Faturamentodiario;
  INSERT INTO Faturamentodiario (Dia, faturamentototal)
  SELECT DATE(p.datahorapedido) AS Dia, SUM(ip.precounitario) AS FaturamentoDiário
  FROM pedidos p
  JOIN itensdepedidos ip
  ON p.id = ip.idpedido
  GROUP BY Dia
  ORDER BY Dia;
END;

SELECT * FROM Faturamentodiario;

-- Testando o TRIGGER

INSERT INTO pedidos (ID, idcliente, datahorapedido, status)
VALUES (451, 27, '2023-10-07 14:30:00', 'Em Andamento');

INSERT INTO itensdepedidos (idpedido, idproduto, quantidade, precounitario)
VALUES (451, 14, 1, 6.0),
       (451, 13, 1, 7.0);

-- Valida chaves estrangeiras / Faz o Cascade funcionar
PRAGMA foreign_keys = ON;

-- Atualizando dados

UPDATE produtos SET preco = 13.0 WHERE id = 31;

UPDATE produtos SET descricao = 'Croissant recheado com amêndoas' WHERE id = 28;

-- Excluindo dados

PRAGMA foreign_keys = ON;

INSERT INTO pedidos (ID, idcliente, datahorapedido, status)
VALUES (451, 27, '2023-10-07 14:30:00', 'Em Andamento');

INSERT INTO itensdepedidos (idpedido, idproduto, quantidade, precounitario)
VALUES (451, 14, 1, 6.0),
       (451, 13, 1, 7.0);

SELECT * FROM clientes WHERE ID = 27;
SELECT * FROM pedidos WHERE idcliente = 27;
SELECT * FROM itensdepedidos WHERE idpedido = 451;

DELETE FROM clientes WHERE ID = 27;

-- TRANSAÇÕES

-- Começar Transação
BEGIN TRANSACTION;

SELECT * FROM clientes;

SELECT * FROM pedidos;

UPDATE pedidos SET status = 'Concluído' WHERE status = 'Em andamento';

DELETE FROM clientes;

--Voltar
ROLLBACK;

-- Confirmar comandos
COMMIT;
