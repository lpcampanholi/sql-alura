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

-- JOINS

SELECT c.nome, p.id, p.datahorapedido
FROM clientes c
INNER JOIN pedidos p
ON c.id = p.idcliente;

SELECT p.id, c.nome, p.datahorapedido, p.status
FROM pedidos p
LEFT JOIN clientes c
ON p.idcliente = c.id;

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

-- leftb join

