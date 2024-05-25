-- 1. Selecione os primeiros 5 registros da tabela clientes, ordenando-os pelo nome em ordem crescente.

SELECT * FROM Clientes
ORDER BY nome
LIMIT 5;

-- 2. Encontre todos os produtos na tabela produtos que não têm uma descrição associada (suponha que a coluna de descrição possa ser nula).

SELECT * FROM Prodrutos
WHERE descricao IS NULL;

-- 3. Liste os funcionários cujo nome começa com 'A' e termina com 's' na tabela funcionarios.

SELECT * FROM funcionarios
WHERE Nome LIKE'%s' AND Nome LIKE 'A%';

-- 4.Exiba o departamento e a média salarial dos funcionários em cada departamento na tabela funcionarios, agrupando por departamento, apenas para os departamentos cuja média salarial é superior a $5000.

SELECT departamento, AVG(salario) AS media_salarial
FROM funcionarios
GROUP BY departamento
HAVING AVG(salario) > 5000;

-- 5. Selecione todos os clientes da tabela clientes e concatene o primeiro e o último nome, além de calcular o comprimento total do nome completo.

SELECT (nome || ' ' || sobrenome) AS nome_completo, LENGTH(nome || ' ' || sobrenome) AS comprimento_nome FROM clientes;

-- 6. Para cada venda na tabela vendas, exiba o ID da venda, a data da venda e a diferença em dias entre a data da venda e a data atual.