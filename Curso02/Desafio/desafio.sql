-- Consulta 1: Retornar a média de Notas dos Alunos em história.

SELECT AVG(Nota) AS media_historia FROM Notas
WHERE id_disciplina = 2;

-- Consulta 2: Retornar as informações dos alunos cujo Nome começa com 'A'.

SELECT * from Alunos
WHERE Nome_Aluno LIKE 'A%';

-- Consulta 3: Buscar apenas os alunos que fazem aniversário em fevereiro.

SELECT * from Alunos
WHERE STRFTIME('%m', Data_Nascimento) = '02';

-- Consulta 4: Realizar uma consulta que calcula a idade dos Alunos.

SELECT Nome,
(STRFTIME('%Y', 'now') - STRFTIME('%Y', Data_Nascimento)) -
(STRFTIME('%m-%d', 'now') < STRFTIME('%m-%d', Data_Nascimento)) AS idade
FROM Alunos;

-- Consulta 5: Retornar se o aluno está ou não aprovado. Aluno é considerado aprovado se a sua nota foi igual ou maior que 6.

SELECT id_aluno, ROUND(AVG(Nota), 2) AS media,
  CASE
    WHEN AVG(Nota) < 6 THEN 'Repovado'
    WHEN AVG(Nota) >= 6 THEN 'Aprovado'
    ELSE 'Não classificado'
  END AS Aprovacao
FROM Notas
GROUP BY id_aluno;