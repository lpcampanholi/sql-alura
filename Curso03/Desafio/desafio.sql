-- Consulta 1: Buscar o nome do professor e a turma que ele é orientador

SELECT p.Nome_Professor, d.Nome_Disciplina, td.ID_Turma
FROM Turma_Disciplinas td
JOIN Disciplinas d ON d.ID_Disciplina = td.ID_Disciplina
JOIN Professores p ON d.ID_Professor = p.ID_Professor;

-- Consulta 2: Retornar o nome e a nota do aluno que possui a melhor nota na disciplina de Matemática

SELECT a.Nome_Aluno, d.Nome_Disciplina, n.Nota
FROM Notas n
JOIN Alunos a ON n.ID_Aluno = a.ID_Aluno
JOIN Disciplinas d ON n.ID_Disciplina = d.ID_Disciplina
WHERE d.Nome_Disciplina = 'Matemática'
ORDER BY n.Nota DESC
LIMIT 1;

-- Consulta 3: Identificar o total de alunos por turma

SELECT ID_Turma, COUNT(ID_Turma) AS TotalAlunos
FROM Turma_Alunos
GROUP BY ID_Turma;

-- Consulta 4: Listar os Alunos e as disciplinas em que estão matriculados

SELECT a.Nome_Aluno, d.Nome_Disciplina
FROM Turma_Alunos ta
JOIN Alunos a ON ta.ID_Aluno = a.ID_Aluno
JOIN Turma_Disciplinas td ON ta.ID_Turma = td.ID_Turma 
JOIN Disciplinas d ON td.ID_Disciplina = d.ID_Disciplina;

-- Consulta 5: Criar uma view que apresenta o nome, a disciplina e a nota dos alunos

CREATE VIEW ViewNotasDosAlunos AS
SELECT a.Nome_Aluno, d.Nome_Disciplina, n.Nota
FROM Notas n
JOIN Alunos a ON n.ID_Aluno = a.ID_Aluno
JOIN Disciplinas d ON n.ID_Disciplina = d.ID_Disciplina;
