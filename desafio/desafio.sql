CREATE TABLE Alunos (
  id_aluno INT PRIMARY KEY,
  nome_aluno VARCHAR (250),
  data_de_nascimento DATE,
  genero VARCHAR (50),
  endereco VARCHAR (250),
  telefone_de_contato VARCHAR (100),
  email VARCHAR (100)
);

CREATE TABLE Professores (
  id_professor INT PRIMARY KEY,
  nome_professor VARCHAR (250),
  genero VARCHAR (50),
  telefone_de_contato VARCHAR (100),
  email VARCHAR (100)
);

CREATE TABLE Disciplinas (
  id_disciplina INT PRIMARY KEY,
  nome_disciplina VARCHAR (100),
  descricao VARCHAR (250),
  carga_horaria INT,
  id_professor INT,
  FOREIGN KEY (id_professor) REFERENCES Professores (id_professor)
);

CREATE TABLE Turmas (
  id_turma INT PRIMARY KEY,
  nome_turma VARCHAR (50),
  ano_letivo INT,
  id_professor_orientador INT,
  FOREIGN KEY (id_professor_orientador) REFERENCES Professores (id_professor)    
);

CREATE TABLE Turmas_Disciplinas (
  id_turma INT,
  id_disciplina INT,
  FOREIGN KEY (id_turma) REFERENCES Turmas (id_turma),
  FOREIGN KEY (id_disciplina) REFERENCES Disciplinas (id_disciplina)
);

CREATE TABLE Turmas_Alunos (
  id_turma INT,
  id_disciplina INT,
  FOREIGN KEY (id_turma) REFERENCES Turmas (id_turma),
  FOREIGN KEY (id_disciplina) REFERENCES Disciplina (id_disciplina)
);