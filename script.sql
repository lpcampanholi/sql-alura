-- Trazer os dados da tabela fornecedores
SELECT * FROM tabelafornecedores;

SELECT * FROM tabelafornecedores WHERE país_de_origem = 'China';

-- Busca dados únicos, elimina duplicatas
SELECT DISTINCT cliente FROM tabelapedidos;

CREATE TABLE tabelaclientes (
    ID_Cliente INT PRIMARY KEY,
    Nome_Cliente VARCHAR (250),
    Informacoes_de_Contato VARCHAR (250)
);

CREATE DATABASE BibliotecaDB;

CREATE SCHEMA LivroSchema;

-- Alterar Tabela, adicionar Coluna
ALTER TABLE tabelaclientes
ADD Endereco_cliente VARCHAR (250);

-- Apaga Tabela
DROP TABLE tabelaclientes;

-- Alterar Tabela, apagar Coluna
ALTER TABLE estudantes
DROP COLUMN Idade;