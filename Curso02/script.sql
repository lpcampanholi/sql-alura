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

-- FUNÇÕES DE DATAS

SELECT id_colaborador, STRFTIME('%Y/%m', datainicio)
FROM Licencas;

SELECT id_colaborador, JULIANDAY(datatermino) - JULIANDAY (datacontratacao) as dias_trabalhados
FROM HistoricoEmprego
WHERE DataTermino IS NOT NULL
ORDER BY dias_trabalhados DESC;

-- FUNÇÕES NUMÉRICAS

SELECT AVG(faturamento_bruto), ROUND(AVG(faturamento_bruto), 2) FROM faturamento;

SELECT CEIL(faturamento_bruto), CEIL(despesas) from faturamento;

SELECT FLOOR(faturamento_bruto), FLOOR(despesas) from faturamento;

-- FUNÇÕES DE CONVERSÃO
SELECT ('O faturamento bruto médio foi ' || CAST(ROUND (AVG(faturamento_bruto), 2) AS TEXT))
FROM faturamento;

-- CASE
SELECT id_colaborador, cargo, salario,
    CASE
        WHEN salario < 3000 THEN 'Baixo'
        WHEN salario BETWEEN 3000 AND 6000 THEN 'Médio'
        ELSE 'Alto'
    END AS categoria_salario
FROM HistoricoEmprego;

ALTER TABLE HistoricoEmprego RENAME TO CargosColaboradores;