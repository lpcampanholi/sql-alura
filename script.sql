-- Cláusulas


-- Trazer os dados da tabela fornecedores
SELECT * FROM Fornecedores;


SELECT * FROM Fornecedores WHERE pais_de_origem = 'China';


-- Busca dados únicos, elimina duplicatas
SELECT DISTINCT cliente FROM Pedidos;


CREATE DATABASE BibliotecaDB;


CREATE SCHEMA LivroSchema;


-- Alterar Tabela, adicionar Coluna
ALTER TABLE Clientes
ADD endereco_cliente VARCHAR (250);


-- Apaga Tabela
DROP TABLE Clientes;


-- Alterar Tabela, apagar Coluna
ALTER TABLE Estudantes
DROP COLUMN idade;


CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    nome_cliente VARCHAR (250),
    informacoes_de_contato VARCHAR (250),
    endereco_cliente VARCHAR (250)
);


CREATE TABLE Categorias (
  id_categoria INT PRIMARY KEY,
  nome_categoria VARCHAR (250),
  descricao_categoria TEXT
);


-- Criar tabela com chaves estrangeiras
CREATE TABLE Produtos (
  id_produto INT PRIMARY KEY,
  nome_produto VARCHAR (250),
  descricao TEXT,
  categoria INT,
  preco_de_compra DECIMAL (10,2),
  unidade VARCHAR (50),
  fornecedor INT,
  data_de_inclusao DATE,
  FOREIGN KEY (categoria) REFERENCES Categorias (id_categoria),
  FOREIGN KEY (fornecedor) REFERENCES Fornecedores (id_fornecedor)
);


-- Adicionar coluna com chave estrangeira a uma tabela
ALTER TABLE Produtos
ADD COLUMN fk_fornecedor INTEGER 
REFERENCES Fornecedores(id_fornecedor);


INSERT INTO Clientes
(id_cliente,
nome_cliente,
informacoes_de_contato
endereco_cliente)
VALUES
('1', 'Ana Silva', 'ana.silva@email.com', 'Rua Flores, 123')


INSERT INTO Clientes
