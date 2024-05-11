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

--Inserir Dados na Tabela Clientes
INSERT INTO Clientes
(id_cliente,
nome_cliente,
informacoes_de_contato
endereco_cliente)
VALUES
('1', 'Ana Silva', 'ana.silva@email.com', 'Rua Flores, 123');

INSERT INTO Clientes
(id_cliente, nome_cliente, informacoes_de_contato, endereco_cliente)
VALUES
('2', 'João Santos', 'joao.santos@provedor.com', 'Rua dos Pinheiros, 25'),
('3', 'Maria Fernandes', 'maria.fernandes@email.com', 'Rua Santo Antonio, 10'),
('4', 'Carlos Pereira', 'carlos.pereira@email.com', 'Av. Rio Branco, 67');

--Inserir dados em uma tabela a partir de uma consulta de outra Tabela

CREATE TABLE PedidosGold (
  id_pedido_gold INT PRIMARY KEY,
  data_do_pedido_gold DATE,
  status_gold VARCHAR (50),
  total_do_pedido_gold DECIMAL (10,2),
  cliente_gold INT,
  data_de_envio_estimada_gold DATE,
  FOREIGN KEY (cliente_gold) REFERENCES Clientes (id_cliente)
);

INSERT INTO PedidosGold
(id_pedido_gold, data_do_pedido_gold, status_gold, total_do_pedido_gold, cliente_gold, data_de_envio_estimada_gold)
SELECT
id_pedido, data_do_pedido, status, total_do_pedido, cliente, data_de_envio_estimada
FROM Pedidos
WHERE total_do_pedido >= 400;

-- FILTROS

SELECT * FROM Clientes WHERE nome_cliente > 'C';

SELECT * FROM Pedidos WHERE data_do_pedido > '2023-09-19';

SELECT * FROM Clientes WHERE Idade > 30 AND sexo <> 'Masculino';

SELECT * FROM Produtos WHERE Nome LIKE 'Computador';

SELECT * FROM Pedidos WHERE total_do_pedido >= 200 AND status = 'Pendente';

SELECT * FROM Pedidos WHERE status = 'Pendente' OR status = 'Processando';

-- Todos os pedidos NÃO pendentes
SELECT * FROM Pedidos WHERE NOT satatus = 'Pendente';

SELECT * FROM Pedidos WHERE data_de_envio_estimada BETWEEN '2023-08-01' AND '2023-09-01';

-- Ordenar
SELECT * FROM Produtos WHERE preco_de_compra BETWEEN 200 AND 600 ORDER BY nome_produto;

SELECT nome_produto, descricao, preco_de_compra FROM Produtos WHERE preco_de_compra BETWEEN 200 AND 600 ORDER BY nome_produto;

-- Ordem decrescente
SELECT * FROM Produtos WHERE preco_de_compra BETWEEN 200 AND 600 ORDER BY fornecedor DESC;

-- Ordem crescente // A sintaxe "ASC" (ascendente) é usada por padrão se não especificada
SELECT * FROM Produtos ORDER BY nome_produto ASC;

-- Apelidos para Colunas // ALIAS
SELECT informacoes_de_contato AS email_cliente FROM Clientes;

-- ALTERAR LINHAS
UPDATE Pedidos SET status = 'Enviado' WHERE status = 'Processando';

UPDATE Clientes SET informacoes_de_contato = 'j.santos@email.com',
endereco_cliente = 'Rua dos Paralelepípedos, 30'
WHERE id_cliente = 2;

-- DELETAR LINHAS
DELETE FROM Fornecedores WHERE pais_de_origem = 'Turquia';

DELETE FROM Fornecedores WHERE id > 35;

-- DELETE CASCADE // Excluir em cascata
CREATE TABLE Clientes (
  id_cliente INT PRIMARY KEY,
  nome_cliente VARCHAR (50)
);

CREATE TABLE Pedidos (
  id_pedido INT PRIMARY KEY,
  id_cliente INT,
  descricao VARCHAR (100),
  FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente) ON DELETE CASCADE
);