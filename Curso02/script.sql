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
