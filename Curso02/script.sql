-- Limitar a 5 Registros
SELECT * FROM HistoricoEmprego
ORDER BY salario DESC
LIMIT 5;

-- Para pular os primeiros 10 registros e retornar os seguintes 10
SELECT * FROM Colaboradores
LIMIT 10 OFFSET 10;

SELECT * FROM HistoricoEmprego
WHERE DataTermino ISNULL
ORDER BY salario DESC
LIMIT 5;