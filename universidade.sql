create schema universidade;

-- criação das tabelas --

create table universidade.Professor (nome varchar(30), siape int, categoria varchar, salario real, cod_depto int
	CONSTRAINT ck_categoria CHECK (categoria::text = ANY (ARRAY['Adjunto II'::character varying, 'Adjunto I'::character varying, 'Assistente I'::character varying]::text[]))
);

create table universidade.Disciplina (nome varchar(30), cod_disciplina serial, carga_horaria int);

create table universidade.Departamento (nome_depto varchar(30), numero_depto serial);

create table universidade.Ministra (siape int, cod_disciplina int, periodo varchar(6));

-- criação das restrições de chave e chave estrangeira --

alter table universidade.Professor add constraint pk_prof primary key  (siape);

alter table universidade.Disciplina add constraint pk_disc primary key  (cod_disciplina);

alter table universidade.Departamento add constraint pk_dept primary key  (numero_depto);

alter table universidade.Ministra add constraint pk_min primary key  (siape, cod_disciplina, periodo);

alter table universidade.Professor add constraint fk_prof_dep foreign key (cod_depto) references universidade.Departamento(numero_depto);

alter table universidade.Ministra add constraint fk_min_prof foreign key (siape) references universidade.Professor(siape);

alter table universidade.Ministra add constraint fk_min_disc foreign key (cod_disciplina) references universidade.Disciplina(cod_disciplina);

-- inserções -- 
insert into universidade.Departamento (nome_depto) values ('Computação'), ('Sistemas de Informação'), ('Redes'), ('Eng. Computação'), ('Design Digital');

insert into universidade.Professor values
	('Ricardo Silva', 124, 'Adjunto I', 2000.00, 1),
	('João Fernando', 134, 'Adjunto II', 3000.00, 1),
	('Claudia Sales', 144, 'Adjunto II', 3000.00, 2),
	('Marcelo Antonio', 154, 'Adjunto I', 2000.00, 3),
	('Paulo Cesar', 164, 'Adjunto I', 2500.00, 4),
	('Cristina Oliveira', 174, 'Assistente I', 1500.00, 1),
	('Aparecida Souza', 184, 'Adjunto I', 2500.00, 5),
	('Joana Maria', 194, 'Adjunto I', 2500.00, 4),
	('Denis Maia', 204, 'Adjunto I', 2500.00, 5);

insert into universidade.Disciplina (nome , carga_horaria) values
	('Fundamentos de Bancos de Dados', 64),
	('Teoria da Computação', 64),
	('Autômatos e Linguagens Formais', 60),
	('Redes de alta velocidade', 86),
	('Mineração de Dados', 86),
	('Teoria Geral dos Sistemas', 30),
	('Programação para desing', 86),
	('Programação linear', 86);


insert into universidade.Ministra (siape , cod_disciplina, periodo) values
	(124, 1, '2013.1'),
	(124, 1, '2013.2'),
	(124, 1, '2014.1'),
	(134, 2, '2015.1'),
	(144, 3, '2015.1'),
	(154, 4, '2015.1'),
	(164, 5, '2015.1'),
	(174, 6, '2015.1'),
	(194, 7, '2015.1'),
	(204, 8, '2015.1');

-- consultas --

-- 1. Recupere a média de salário dos professores de cada departamento. Apresente o nome do
-- departamento e a média salarial. Ordene o resultado em ordem crescente por média.

SELECT d.nome_depto, AVG(p.salario) AS media_salarial
FROM universidade.Professor p
JOIN universidade.Departamento d ON p.cod_depto = d.numero_depto
GROUP BY d.nome_depto
ORDER BY media_salarial;


-- 2. Recupere o nome dos departamentos cuja média salarial dos professores é maior ou igual a
-- 2500.

SELECT d.nome_depto
FROM universidade.Professor p
JOIN universidade.Departamento d ON p.cod_depto = d.numero_depto
GROUP BY d.nome_depto
HAVING AVG(p.salario) >= 2500;

-- 3. Para cada professor, obtenha o nome e a a quantidade de disciplinas ministradas por ele.
-- Retorne inclusive os professores que não ministraram disciplinas. Ordene o resultado em
-- ordem decrescente por quantidade.

SELECT p.nome, COUNT(m.cod_disciplina) AS quantidade_disciplinas
FROM universidade.Professor p
LEFT JOIN universidade.Ministra m ON p.siape = m.siape
GROUP BY p.nome
ORDER BY quantidade_disciplinas DESC;


-- 4. Obtenha a carga-horária ofertada por período.

SELECT m.periodo, SUM(d.carga_horaria) AS carga_horaria
FROM Ministra m

SELECT periodo, SUM(carga_horaria) AS carga_horaria_total
FROM universidade.Disciplina
GROUP BY periodo;


-- 5. Obtenha para cada professor, seu nome e a carga horária ministrada por período.

SELECT p.nome, m.periodo, SUM(d.carga_horaria) AS carga_horaria_ministrada
FROM universidade.Professor p
LEFT JOIN universidade.Ministra m ON p.siape = m.siape
LEFT JOIN universidade.Disciplina d ON m.cod_disciplina = d.cod_disciplina
GROUP BY p.nome, m.periodo;


-- 6. Obtenha o nome do departamento e a soma dos salários por departamento.

SELECT d.nome_depto, SUM(p.salario) AS soma_salarios
FROM universidade.Professor p
JOIN universidade.Departamento d ON p.cod_depto = d.numero_depto
GROUP BY d.nome_depto;

-- 7. Obtenha o nome do departamento e a quantidade de professores em cada departamento.

SELECT d.nome_depto, COUNT(p.siape) AS quantidade_professores
FROM universidade.Professor p
JOIN universidade.Departamento d ON p.cod_depto = d.numero_depto
GROUP BY d.nome_depto;

-- 8. Apresente para o professor que teve carga-horária maior que a média, o nome do professor e
-- do seu departamento. (Utilize consultas aninhadas).

SELECT p.nome, d.nome_depto
FROM universidade.Professor p
JOIN universidade.Departamento d ON p.cod_depto = d.numero_depto
WHERE p.carga_horaria > (SELECT AVG(carga_horaria) FROM universidade.Professor);

-- 9. Apresente para o professor que teve carga-horária maior que a média do seu departamento, o
-- nome do professor e do seu departamento. (Utilize consultas aninhadas).

SELECT p.nome, d.nome_depto
FROM universidade.Professor p
JOIN universidade.Departamento d ON p.cod_depto = d.numero_depto
WHERE p.siape IN (
    SELECT m.siape
    FROM universidade.Ministra m
    JOIN universidade.Disciplina d ON m.cod_disciplina = d.cod_disciplina
    GROUP BY m.siape
    HAVING SUM(d.carga_horaria) > (
        SELECT AVG(d.carga_horaria)
        FROM universidade.Disciplina d
        WHERE d.cod_disciplina IN (
            SELECT m.cod_disciplina
            FROM universidade.Ministra m
            WHERE m.siape = p.siape
        )
    )
);

-- 10. Recupere os professores que nunca ministraram a disciplina de código 1 (Utilize IN/NOT
-- IN).

SELECT p.nome
FROM universidade.Professor p
WHERE p.siape NOT IN (
    SELECT m.siape
    FROM universidade.Ministra m
    WHERE m.cod_disciplina = 1
);


-- 11. Apresente os dados do professor (inclusive o nome do seu departamento) que ministrou o
-- maior número de disciplinas (Utilize o operador ALL).

SELECT p.nome, d.nome_depto
FROM universidade.Professor p
JOIN universidade.Departamento d ON p.cod_depto = d.numero_depto
WHERE (SELECT COUNT(*) FROM universidade.Ministra m WHERE m.siape = p.siape) = ALL(SELECT COUNT(*) FROM universidade.Ministra GROUP BY siape);

-- 12. Apresente os dados do professor (inclusive o nome do seu departamento) que teve a maior
-- carga horária em algum semestre (Utilize o operador ALL).

SELECT p.nome, d.nome_depto
FROM universidade.Professor p
JOIN universidade.Departamento d ON p.cod_depto = d.numero_depto
WHERE p.carga_horaria = ALL(SELECT MAX(p2.carga_horaria) FROM universidade.Professor p2);


-- 13. Obtenha o departamento que tem professor que não ministrou disciplina em 2013.1. (Utilize
-- os operadores IN ou NOT IN )

SELECT d.nome_depto
FROM universidade.Departamento d
WHERE d.numero_depto IN (
    SELECT p.cod_depto
    FROM universidade.Professor p
    WHERE p.siape NOT IN (
        SELECT m.siape
        FROM universidade.Ministra m
        WHERE m.periodo = '2013.1'
    )
);


-- 14. Obtenha as disciplinas que nunca foram ministradas (Utilize IN ou NOT IN).

SELECT d.nome
FROM universidade.Disciplina d
WHERE d.cod_disciplina NOT IN (SELECT m.cod_disciplina FROM universidade.Ministra m);

-- 15. Recupere o nome dos professores e o nome do departamento de todos os professores que
-- não ministraram disciplinas em 2013.1. (Utilize os operadores EXISTS ou NOT EXISTS)

SELECT p.nome, d.nome_depto
FROM universidade.Professor p
JOIN universidade.Departamento d ON p.cod_depto = d.numero_depto
WHERE NOT EXISTS (SELECT * FROM universidade.Ministra m WHERE m.siape = p.siape AND m.periodo = '2013.1');

	


		




