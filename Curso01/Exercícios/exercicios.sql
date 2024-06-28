/*

1) Crie uma tabela chamada funcionarios com as seguintes colunas: id (int, chave primária), nome (varchar(100)), departamento (varchar(100)) e salario (float). Em seguida, insira os seguintes registros de funcionários na tabela:

ID: 1, Nome: Heitor Vieira, Departamento: Financeiro, Salário: 4959.22
ID: 2, Nome: Daniel Campos, Departamento: Vendas, Salário: 3884.44
ID: 3, Nome: Luiza Dias, Departamento: TI, Salário: 8205.78
ID: 4, Nome: Davi Lucas Moraes, Departamento: Financeiro, Salário: 8437.02
ID: 5, Nome: Pietro Cavalcanti, Departamento: TI, Salário: 4946.88
ID: 6, Nome: Evelyn da Mata, Departamento: Vendas, Salário: 5278.88
ID: 7, Nome: Isabella Rocha, Departamento: Marketing, Salário: 4006.03
ID: 8, Nome: Sra. Manuela Azevedo, Departamento: Vendas, Salário: 6101.88
ID: 9, Nome: Brenda Cardoso, Departamento: TI, Salário: 8853.34
ID: 10, Nome: Danilo Souza, Departamento: TI, Salário: 8242.14
2) Selecione todos os campos de todos os registros na tabela funcionarios.

3) Na tabela funcionarios, selecione os nomes dos funcionários que trabalham no departamento de "Vendas".

4) Selecione os funcionários da tabela funcionarios cujo salário seja maior que 5000.

5) Na tabela funcionarios, selecione todos os departamentos distintos.

6) Atualize o salário dos funcionários do departamento de "TI" para 7500 na tabela funcionarios.

7) Delete da tabela funcionarios todos os registros de funcionários que ganham menos de 4000.

8) Selecione os nomes e salários dos funcionários que trabalham no departamento de "Vendas" e cujo salário seja maior ou igual a 6000.

9) Crie uma tabela chamada projetos com as colunas: id_projeto (int, chave primária), nome_projeto (varchar(100)), id_gerente (int, referência a id na tabela funcionarios). Insira 3 registros na tabela projetos e, em seguida, selecione todos os projetos cujo id_gerente seja igual a 2.

10) Remova a tabela funcionarios do banco de dados.

*/

-- 1
CREATE TABLE Funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome_funcionario VARCHAR (100),
    departamento VARCHAR (100),
    salario FLOAT
);

-- 2
INSERT INTO Funcionarios (id_funcionario, nome_funcionario, departamento, salario) VALUES
(1, 'Heitor Vieira', 'Financeiro', 4959.22 ),
(2, 'Daniel Campos', 'Vendas', 3884.44),
(3, 'Luiza Dias', 'TI', 8205.78),
(4, 'Davi Lucas Moraes', 'Financeiro', 8437.02),
(5, 'Pietro Cavalcanti', 'TI', 4946.88),
(6, 'Evelyn da Mata', 'Vendas', 5278.88 ),
(7, 'Isabella Rocha', 'Marketing', 4006.03),
(8, 'Sra. Manuela Azevedo', 'Vendas', 6101.88),
(9, 'Brenda Cardoso', 'TI', 8853.34),
(10, 'Danilo Souza', 'TI', 8242.14);

-- 3
SELECT * FROM Funcionarios WHERE departamento = 'Vendas';

-- 4
SELECT * FROM Funcionarios WHERE salario > 5000;

-- 5
SELECT DISTINCT departamento FROM Funcionarios;

-- 6
UPDATE Funcionarios SET salario = 7500 WHERE departamento = 'TI';

-- 7
DELETE FROM Funcionarios WHERE salario < 4000;

-- 8
SELECT nome_funcionario, salario FROM Funcionarios WHERE departamento = 'Vendas' AND salario >= 6000;

-- 9
CREATE TABLE Projetos (
    id_projeto INT PRIMARY KEY,
    nome_projeto VARCHAR (100),
    id_gerente INT,
    FOREIGN KEY (id_gerente) REFERENCES Funcionarios(id_funcionario)
);

INSERT INTO Projetos (id_projeto, nome_projeto, id_gerente) VALUES
(1, 'React', 2),
(2, 'Angular', 2),
(3, 'Vue', 3);

SELECT * FROM Projetos WHERE id_gerente = 2;

-- 10
DROP TABLE Funcionarios;