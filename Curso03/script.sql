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