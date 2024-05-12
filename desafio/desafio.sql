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