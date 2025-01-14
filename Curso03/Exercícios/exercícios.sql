
-- 1. Traga todos os dados da cliente Maria Silva.

SELECT * FROM clientes WHERE nome = 'Maria Silva';

-- 2. Busque o ID do pedidov e o ID do cliente dos pedidos onde o status esteja como entregue.

SELECT id, idcliente
FROM pedidos
WHERE status = 'Entregue';

-- 3. Retorne todos os produtos onde o preço seja maior que 10 e menor que 15.

SELECT * FROM produtos WHERE preco > 10 AND preco < 15;

-- 4. Busque o nome e cargo dos colaboradores que foram contratados entre 2022-01-01 e 2022-06-31.

SELECT nome, cargo
FROM colaboradores
WHERE datacontratacao BETWEEN '2022-01-01' AND '2022-06-31'
ORDER BY datacontratacao;

-- 5. Recupere o nome do cliente que fez o primeiro pedido.

SELECT nome
FROM clientes
WHERE id = (
  SELECT idcliente
  FROM pedidos
  ORDER BY datahorapedido ASC
);

-- 6. Liste os produtos que nunca foram pedidos.

INSERT INTO produtos (id, nome, descricao, preco, categoria) VALUES
(31, 'Barra de chocolate', 'Uma barra suculenta e saborosa', 12.0, 'Doces'),
(32, 'Biscoito recheado', 'Biscoito crocante com recheio de creme', 8.5, 'Biscoitos'),
(33, 'Suco de laranja', 'Suco natural de laranja', 5.0, 'Bebidas'),
(34, 'Chá verde', 'Chá verde natural', 7.0, 'Bebidas'),
(35, 'Café moído', 'Café moído premium', 15.0, 'Bebidas'),
(36, 'Cereal matinal', 'Cereal integral com frutas', 10.0, 'Cereais'),
(37, 'Leite condensado', 'Leite condensado cremoso', 6.5, 'Laticínios'),
(38, 'Queijo mussarela', 'Queijo mussarela fresco', 20.0, 'Laticínios'),
(39, 'Iogurte natural', 'Iogurte natural sem açúcar', 4.5, 'Laticínios'),
(40, 'Pão de forma', 'Pão de forma integral', 5.5, 'Padaria'),
(41, 'Manteiga', 'Manteiga sem sal', 9.0, 'Padaria');

SELECT p.id, p.nome
FROM produtos p
LEFT JOIN itensdepedidos ip ON p.id = ip.idproduto
WHERE ip.idproduto IS NULL;

SELECT nome
FROM produtos
WHERE id NOT IN (
  SELECT idProduto
  FROM ItensPedido);

-- 7. Liste os nomes dos clientes que fizeram pedidos entre 2023-01-01 e 2023-12-31.

SELECT DISTINCT p.id, c.nome, p.datahorapedido
FROM pedidos p
JOIN clientes c ON p.idcliente = c.id
WHERE p.datahorapedido BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY p.datahorapedido;

-- 8. Recupere os nomes dos produtos que estão em menos de 15 pedidos.

SELECT pr.nome NomeProduto, COUNT(pr.nome) qtdPorPedido
FROM pedidos p
JOIN itensdepedidos ip ON p.id = ip.idpedido
JOIN produtos pr ON ip.idproduto = pr.id
GROUP BY NomeProduto
HAVING qtdPorPedido < 15;

-- 9. Liste os produtos e o ID do pedido que foram realizados pelo cliente "Pedro Alves" ou pela cliente "Ana Rodrigues".

SELECT p.id, c.nome, pr.nome
FROM pedidos p
JOIN itensdepedidos ip ON ip.idpedido = p.id
JOIN produtos pr ON ip.idproduto = pr.id
JOIN clientes c ON p.idcliente = c.id
WHERE c.nome IN ('Pedro Alves', 'Ana Rodrigues')
ORDER BY c.nome;

-- 10. Recupere o nome e o ID do cliente que mais comprou(valor) no Serenatto.

SELECT c.id, c.nome, SUM(ip.quantidade * ip.precounitario) AS ValorTotal
FROM pedidos p
JOIN itensdepedidos ip ON ip.idpedido = p.id
JOIN clientes c ON p.idcliente = c.id
GROUP BY c.id, c.nome
ORDER BY ValorTotal DESC
LIMIT 1;