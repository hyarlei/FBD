 Os alunos da Disciplina de FBD do Curso de CC foram convidados para projetar o banco de dados que será utilizado para gerenciar as atividades realizadas durante o evento WTISC 2018. Para isso, crie um DER capaz de representar os seguintes requisitos:
a) Cada atividade do evento possui: código, descrição, quantidade máxima de participantes e valor.
b) Há dois tipos de pessoas no evento: participantes e ministrantes de atividades. 
c)  Todas essas pessoas possuem os seguintes atributos em comum: cpf, nome, data de nascimento, endereço, telefone e email. 
d) O endereço é composto de rua, número, complemento, bairro, cidade, UF e CEP. 
e) É possível cadastrar vários telefones para uma mesma pessoa.
f)   Cada participante do evento pode realizar várias atividades. Além disso, cada participante está vinculado a uma única instituição. Uma instituição tem um código, uma sigla e um nome.
g)   Cada atividade só pode ter um único ministrante.
h) É necessário armazenar a data de pagamento em que cada participante pagou cada uma de suas atividades. Um único participante pode pagar cada uma de suas atividades em datas diferentes.

Table atividade {
  codigo INT PK 
  descricao VARCHAR
  qtd_max_participantes INT
  valor DECIMAL(10,2)
}

Table pessoa {
  cpf VARCHAR PK
  nome VARCHAR
  data_nascimento DATE
  rua VARCHAR
  numero INT
  complemento VARCHAR
  bairro VARCHAR
  cidade VARCHAR
  uf VARCHAR(2)
  cep VARCHAR(8)
}

Table telefone {
  id_telefone INT PK
  cpf_pessoa VARCHAR FK
  
