-- Crie um modelo ER completo para cada uma das situações a seguir:
-- 1.  A empresa XYZ pretende armazenar os dados sobre os seus projetos e sobre os funcionários lotados nesses projetos. Cada projeto possui uma sigla e um nome. A sigla de um projeto o identifica unicamente em relação a outros projetos. Cada funcionário tem um código de matrícula, um CPF e um nome. Além disso, um funcionário pode estar lotado em vários projetos, bem como um projeto pode contar com a participação de vários funcionários. Baseado nessas informações, modele o Diagrama Entidade-Relacionamento (DER) para o problema proposto.

-- 2.  Uma concessionária que trabalha com venda de veículos deseja criar uma base de dados para o seu negócio. Essa base deve atender aos seguintes requisitos:
-- a)  Para qualquer veículo, devemos saber o número do chassi, número da placa, cor, ano de fabricação, quilometragem, marca e modelo.
-- b)  Sobre marca e modelo, basta sabermos seus códigos e nomes.
-- c)  Todo carro pertence a um modelo e este modelo pertence a uma marca.
-- d)  Uma pessoa pode assumir um dos seguintes papéis em relação a concessionária: corretor ou comprador.
-- e)  Sobre o comprador do veículo, tem-se CPF, nome, estado civil e, se for casado, os dados do cônjuge (como nome e CPF). 
-- f)  Sobre os corretores, tem-se número da matrícula, nome e data de admissão.
-- g)  Um corretor negocia com um comprador a venda de um veículo. Sobre a venda são necessárias as seguintes informações: data, valor da venda e valor da comissão do corretor.

-- 3.  Os alunos da Disciplina de FBD do Curso de CC foram convidados para projetar o banco de dados que será utilizado para gerenciar as atividades realizadas durante o evento WTISC 2018. Para isso, crie um DER capaz de representar os seguintes requisitos:
-- a) Cada atividade do evento possui: código, descrição, quantidade máxima de participantes e valor.
-- b) Há dois tipos de pessoas no evento: participantes e ministrantes de atividades. 
-- c)  Todas essas pessoas possuem os seguintes atributos em comum: cpf, nome, data de nascimento, endereço, telefone e email. 
-- d) O endereço é composto de rua, número, complemento, bairro, cidade, UF e CEP. 
-- e) É possível cadastrar vários telefones para uma mesma pessoa.
-- f)   Cada participante do evento pode realizar várias atividades. Além disso, cada participante está vinculado a uma única instituição. Uma instituição tem um código, uma sigla e um nome.
-- g)   Cada atividade só pode ter um único ministrante.
-- h) É necessário armazenar a data de pagamento em que cada participante pagou cada uma de suas atividades. Um único participante pode pagar cada uma de suas atividades em datas diferentes.

-- 4.  Crie um DER para representar os dados da empresa Xing-Ling de Quixadá que tem seus dados organizados da seguinte forma:
-- a)  Cada funcionário trabalha em um único departamento da empresa e possui: matrícula, cpf, nome, endereço, telefone e email.
-- b)  Funcionários são diretamente chefiados por um único supervisor que também é um funcionário. É possível haver mais de um supervisor em um mesmo departamento.
-- c)  Um departamento possui no mínimo 5 funcionários, onde somente um deles é o gerente do departamento. O gerente do departamento também é um funcionário. Além disso, cada departamento possui um código e um nome.
-- d)  Os dependentes dos funcionários devem possuir como atributos: id, nome e data de nascimento. 
-- e)  O salário de um empregado é calculado com base nos seus diversos vencimentos. Para cada tipo de vencimento, existe uma descrição e o valor correspondente.

-- 5.  Você foi chamado para criar o Diagrama de Entidade-Relacionamento de uma rede de lojas baseado nas informações a seguir.
-- a)  Cada loja cadastrada no sistema deve possuir um CNPJ, uma sigla e um nome.
-- b)  O sistema deve permitir o cadastro de dois tipos de clientes: pessoa física e pessoa jurídica. É necessário registrar nome, endereço e telefone de todos os clientes. Cada cliente pessoa física deve ter cadastrado seu CPF. Já os clientes que são pessoas jurídicas devem ter seus CNPJs armazenados.
-- c)  Cada produto vendido pela loja tem um código que o identifica unicamente, um nome, um valor e uma categoria, que identifica o tipo de produto vendido pela loja. 
-- d)  Cada categoria de produto possui um identificador único e um nome.
-- e)  Cada compra é realizada em uma data específica por um único cliente em uma determinada loja. Além disso, cada compra tem vários itens. Cada item de compra possui informações sobre o produto, a quantidade comprada daquele produto e o valor unitário do produto comprado.

-- * Nota: onde lê "modelo ER" leia-se "modelo relacional" onde lê, "diagrama ER ou DER" leia-se esquema relacional.

-- ATVD 1

Table projects {
  id varchar [pk]
  name varchar
}

Table employees {
  id int [pk]
  cpf varchar
  name varchar
}

Table project_employees {
  id int [pk]
  project_id varchar [ref: > projects.id]
  employee_id int [ref: > employees.id]
}

-- ATVD 2

CREATE TABLE Atividade (
  codigo INT PRIMARY KEY,
  descricao VARCHAR(255) NOT NULL,
  qtd_max_participantes INT NOT NULL,
  valor DECIMAL(10,2) NOT NULL
);

CREATE TABLE Pessoa (
  cpf VARCHAR(11) PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  data_nascimento DATE NOT NULL,
  email VARCHAR(255) NOT NULL
);

CREATE TABLE Endereco (
  id INT PRIMARY KEY,
  rua VARCHAR(255) NOT NULL,
  numero INT NOT NULL,
  complemento VARCHAR(255),
  bairro VARCHAR(255) NOT NULL,
  cidade VARCHAR(255) NOT NULL,
  uf CHAR(2) NOT NULL,
  cep VARCHAR(8) NOT NULL,
  cpf_pessoa VARCHAR(11) NOT NULL,
  FOREIGN KEY (cpf_pessoa) REFERENCES Pessoa (cpf)
);

CREATE TABLE Telefone (
  id INT PRIMARY KEY,
  numero VARCHAR(20) NOT NULL,
  cpf_pessoa VARCHAR(11) NOT NULL,
  FOREIGN KEY (cpf_pessoa) REFERENCES Pessoa (cpf)
);

CREATE TABLE Participante (
  cpf_pessoa VARCHAR(11) PRIMARY KEY,
  id_instituicao INT NOT NULL,
  FOREIGN KEY (cpf_pessoa) REFERENCES Pessoa (cpf)
);

CREATE TABLE Instituicao (
  id INT PRIMARY KEY,
  sigla VARCHAR(20) NOT NULL,
  nome VARCHAR(255) NOT NULL
);

CREATE TABLE Realizacao (
  cpf_participante VARCHAR(11) NOT NULL,
  codigo_atividade INT NOT NULL,
  data_pagamento DATE NOT NULL,
  PRIMARY KEY (cpf_participante, codigo_atividade),
  FOREIGN KEY (cpf_participante) REFERENCES Participante (cpf_pessoa),
  FOREIGN KEY (codigo_atividade) REFERENCES Atividade (codigo)
);

CREATE TABLE Ministrante (
  cpf_pessoa VARCHAR(11) PRIMARY KEY,
  FOREIGN KEY (cpf_pessoa) REFERENCES Pessoa (cpf)
);

ALTER TABLE Atividade
  ADD COLUMN cpf_ministrante VARCHAR(11) NOT NULL,
  ADD CONSTRAINT fk_ministrante FOREIGN KEY (cpf_ministrante) REFERENCES Ministrante (cpf_pessoa);


-- ATVD 3

Table atividade {
  codigo int [pk]
  descricao varchar
  qtd_max_participantes int
  valor numeric
}

Table pessoa {
  cpf varchar [pk]
  nome varchar
  data_nascimento date
  endereco_id int [ref: < endereco.id]
  email varchar
}

Table telefone {
  id int [pk]
  numero varchar
  pessoa_cpf varchar [ref: < pessoa.cpf]
}

Table instituicao {
  codigo int [pk]
  sigla varchar
  nome varchar
}

Table participante {
  pessoa_cpf varchar [pk, ref: > pessoa.cpf]
  instituicao_codigo int [ref: < instituicao.codigo]
}

Table ministrante {
  pessoa_cpf varchar [pk, ref: > pessoa.cpf]
}

Table endereco {
  id int [pk]
  rua varchar
  numero varchar
  complemento varchar
  bairro varchar
  cidade varchar
  uf varchar
  cep varchar
}

Table pagamento {
  atividade_codigo int [ref: > atividade.codigo]
  participante_cpf varchar [ref: > participante.pessoa_cpf]
  data_pagamento date
}

-- ATVD 4

Table Funcionario {
  Matricula int [pk]
  CPF varchar(11) [unique]
  Nome varchar(50)
  Endereco varchar(100)
  Telefone varchar(15)
  Email varchar(100)
  idSupervisor int
  idDepartamento int
}

Table Departamento {
  idDepartamento int [pk]
  Codigo varchar(5) [unique]
  Nome varchar(50)
  idGerente int
}

Table Supervisor {
  idSupervisor int [pk]
  idFuncionario int
}

Table Dependente {
  idDependente int [pk]
  idFuncionario int
  Nome varchar(50)
  DataNascimento date
}

Table Vencimento {
  idVencimento int [pk]
  Descricao varchar(50)
  Valor decimal(10,2)
}

Ref: Funcionario.idSupervisor > Supervisor.idSupervisor
Ref: Funcionario.idDepartamento > Departamento.idDepartamento
Ref: Departamento.idGerente > Funcionario.Matricula
Ref: Dependente.idFuncionario > Funcionario.Matricula
Ref: Vencimento.idVencimento > Funcionario.Matricula


-- ATVD 5

Table loja {
  CNPJ varchar [pk]
  sigla varchar
  nome varchar
}

Table cliente {
  id int [pk]
  nome varchar
  endereco varchar
  telefone varchar
}

Table pessoa_fisica {
  cpf varchar [pk]
  cliente_id int [unique]
}

Table pessoa_juridica {
  cnpj varchar [pk]
  cliente_id int [unique]
}

Table produto {
  codigo int [pk]
  nome varchar
  valor decimal
  categoria_id int
}

Table categoria {
  id int [pk]
  nome varchar
}

Table compra {
  id int [pk]
  data date
  cliente_id int
  loja_cnpj varchar
}

Table item_compra {
  id int [pk]
  quantidade int
  valor_unitario decimal
  compra_id int
  produto_codigo int
}

Ref: compra.cliente_id > cliente.id
Ref: compra.loja_cnpj > loja.CNPJ
Ref: item_compra.compra_id > compra.id
Ref: item_compra.produto_codigo > produto.codigo
Ref: produto.categoria_id > categoria.id
