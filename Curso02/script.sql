-- Limitar a 5 Registros
SELECT * FROM HistoricoEmprego
ORDER BY salario DESC
LIMIT 5;

-- Para pular os primeiros 10 registros e retornar os seguintes 10
SELECT * FROM Colaboradores
LIMIT 10 OFFSET 10;

-- IS NULL / NOT NULL
SELECT * FROM HistoricoEmprego
WHERE DataTermino IS NULL
ORDER BY salario DESC
LIMIT 5;

-- %
SELECT * FROM Treinamento
WHERE Curso LIKE 'O poder%';

SELECT * FROM Treinamento
WHERE Curso LIKE '%realizar%';

SELECT * FROM Colaboradores
WHERE Nome LIKE 'Isadora%';

-- AND
SELECT * FROM HistoricoEmprego
WHERE Cargo = 'Professor' AND
datatermino NOT NULL;

-- OR
SELECT * FROM HistoricoEmprego
WHERE Cargo = 'Oftalmologista' OR
Cargo = 'Dermatologista';

-- IN / NOT IN
SELECT * FROM HistoricoEmprego
WHERE Cargo IN ('Oftalmologista', 'Dermatologista', 'Professor');

SELECT * FROM HistoricoEmprego
WHERE Cargo NOT IN ('Oftalmologista', 'Dermatologista', 'Professor');

SELECT * FROM Treinamento
WHERE (Curso LIKE '%O direito%' and Instituicao = 'da Rocha')
OR (Curso LIKE 'O conforto%' AND Instituicao = 'das Neves');

SELECT * FROM livros
WHERE (genero LIKE '%ficção científica%' OR genero LIKE '%fantasia%')
AND ano_publicacao > 2000
AND editora IS NULL
ORDER BY ano_publicacao DESC
LIMIT 20;

-- MIN / MAX
SELECT mes, MAX(faturamento_bruto) FROM faturamento;

-- SUM
SELECT SUM(numero_novos_clientes) AS 'Novos clientes 2023' FROM faturamento
WHERE mes LIKE '%2023';

-- AVG (AVERAGE = MÉDIA)
SELECT AVG(despesas) FROM faturamento;

SELECT AVG(lucro_liquido) FROM faturamento;

-- COUNT 
SELECT COUNT(*) FROM HistoricoEmprego
WHERE datatermino NOT NULL;

SELECT COUNT(*) FROM Licencas
WHERE tipolicenca = 'férias';

-- GROUP BY 
SELECT parentesco, COUNT(*) FROM Dependentes
GROUP BY parentesco;

SELECT instituicao, COUNT(curso)
FROM Treinamento
GROUP BY instituicao
HAVING COUNT(curso) > 2;

-- FUNÇÕES DE STRINGS

SELECT nome, LENGTH(cpf) qtd
FROM Colaboradores
WHERE qtd != 11;

SELECT COUNT(*), LENGTH(cpf) qtd
FROM Colaboradores
WHERE qtd = 11;

SELECT ('A pessoa colaboradora ' || nome || ' de CPF ' || cpf || ' possui o seguinte endereço: ' || endereco) AS texto
FROM Colaboradores;

-- UPPER / LOWER para Strings

SELECT id_colaborador, STRFTIME('%Y/%m', datainicio)
FROM Licencas;

SELECT id_colaborador, JULIANDAY(datatermino) - JULIANDAY (datacontratacao) as dias_trabalhados
FROM HistoricoEmprego
WHERE DataTermino IS NOT NULL
ORDER BY dias_trabalhados DESC;