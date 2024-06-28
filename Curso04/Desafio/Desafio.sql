-- Consulta 1: Retorne todas as disciplinas

SELECT * FROM Disciplinas;

-- Consulta 2: Retorne os alunos que estão aprovados na disciplina de matemática

SELECT n.nota, a.Nome_Aluno
FROM Notas n 
JOIN Disciplinas d ON n.ID_Disciplina = d.ID_Disciplina
JOIN Alunos a ON n.ID_Aluno = a.ID_Aluno
WHERE d.nome_disciplina = 'Matemática' AND n.Nota > 6.0;

-- Consulta 3: Identificar o total de disciplinas por turma

SELECT t.ID_Turma, t.Nome_Turma, COUNT(td.ID_Disciplina) AS Qtd_Disciplinas, d.Nome_Disciplina
FROM Turmas t
JOIN Turma_Disciplinas td ON t.ID_Turma = td.ID_Turma
JOIN Disciplinas d ON td.ID_Disciplina = d.ID_Disciplina
GROUP BY t.ID_Turma

-- Consulta 4: Porcentagem dos alunos que estão aprovados

WITH Qtd_Alunos_Aprovados AS (
  SELECT COUNT(ID_Aluno) AS qtd_aprovados
  FROM (
    SELECT ID_Aluno, ROUND(AVG(Nota), 2) AS Media
    FROM Notas
    GROUP BY ID_Aluno
    HAVING Media >= 6.0
  )
), Qtd_Alunos AS (
SELECT COUNT(*) AS qtd_alunos
FROM (SELECT DISTINCT ID_Aluno FROM Notas)
)
SELECT ap.qtd_aprovados AS Alunos_Aprovados,
qtda.qtd_alunos AS Total_Alunos,
ROUND(100.0*ap.qtd_aprovados/qtda.qtd_alunos, 2) || '%' AS Porcentagem
FROM Qtd_Alunos_Aprovados ap, Qtd_Alunos qtda
;

-- Consulta 5: Porcentagem dos alunos que estão aprovados por disciplina

WITH Qtd_Alunos_Aprovados_Por_Disciplina AS (
  SELECT COUNT(ID_Aluno) AS qtd_aprovados
  FROM (
    SELECT ID_Aluno, ID_Disciplina, ROUND(AVG(Nota), 2) AS Media
    FROM Notas
    GROUP BY ID_Aluno, ID_Disciplina
    HAVING Media >= 6.0
  )
), Qtd_Alunos_Notas AS (
  SELECT COUNT(*) AS alunos_totais FROM (SELECT DISTINCT ID_Aluno, ID_Disciplina FROM Notas)
)
SELECT qaapd.qtd_aprovados AS Alunos_Aprovados,
qan.alunos_totais as Alunos_Totais,
ROUND(100.0 * qaapd.qtd_aprovados / qan.alunos_totais, 2) || '%' as Porcentagem 
FROM Qtd_Alunos_Aprovados_Por_Disciplina qaapd, Qtd_Alunos_Notas qan
;