-------------------------------------------------
-- Criando e setando esquema
create schema app;
set schema 'app';
-------------------------------------------------
-- Criando tabela 'usuario'
create table app.usuario
(
	id_u serial primary key,
	email varchar(50) unique not null,
	nome varchar(70) not null,
	cidade varchar(30),
	bio varchar(300),
	genero char(1) not null,
	data_nasc date not null,
	idade integer check (idade >= 18) not null
);
-------------------------------------------------

-------------------------------------------------
-- Criando tabela 'hobbies'
create table app.hobbies
(
	id_hobbie serial primary key,
	descricao varchar(30) unique
);
-------------------------------------------------

-------------------------------------------------
-- Criando tabela 'user_hobies'
create table app.user_hobbies
(
	id_u integer,
	id_h integer,
	primary key(id_u,id_h)
);
-- Alterando tabela para referenciar chaves primárias
alter table user_hobbies
add constraint user_hobbies_user_fk
foreign key (id_u) references usuario(id_u);

alter table user_hobbies
add constraint user_hobbies_hobbie_fk
foreign key (id_h) references hobbies(id_hobbie);
-------------------------------------------------

-------------------------------------------------
--Criando tabela 'curtidas'
create table app.curtidas
(
	id_u integer,
	id_u_curtiu integer,
	primary key (id_u, id_u_curtiu)
);
-- Alterando tabela para referenciar chaves primárias
alter table app.curtidas
add constraint id_u_fk
foreign key (id_u) references app.usuario(id_u);

alter table app.curtidas
add constraint id_u_curtiu_fk
foreign key (id_u_curtiu) references app.usuario(id_u);
-------------------------------------------------

-------------------------------------------------
-- Criando tabela 'chat'
create table app.chat
(
	id_emissor integer,
	id_receptor integer,
	mensagem varchar(2000),
	data_hora timestamp
);
-- Alterando tabela para referenciar chaves primárias
alter table app.chat
add constraint user_emissor_fk
foreign key (id_emissor) references app.usuario(id_u);

alter table app.chat
add constraint user_receptor_fk
foreign key (id_receptor) references app.usuario(id_u);
-------------------------------------------------

-------------------------------------------------
-- Criando tabela 'match'
create table app.match
(
	id_u1 integer,
	id_u2 integer,
	data timestamp,
	primary key(id_u1, id_u2)
);
-- Alterando tabela para referenciar chaves primárias
alter table app.match
add constraint id_u1_fk
foreign key(id_u1) references app.usuario(id_u);

alter table app.match
add constraint id_u2_fk
foreign key(id_u2) references app.usuario(id_u);
-------------------------------------------------

-------------------------------------------------
-- Inserindo na tabela 'usuario'
insert into usuario
(email, nome, bio, genero, data_nasc, idade)
values ('joao@gmail.com', 'João', 'Engenheiro de software', 'M', '1990-05-10', 31);

insert into usuario
(email, nome, bio, genero, data_nasc, idade)
values ('maria@yahoo.com', 'Maria', 'Estudante de medicina', 'F', '2000-02-20', 23);

insert into usuario
(email, nome, bio, genero, data_nasc, idade)
values ('carlos@hotmail.com', 'Carlos', 'Advogado trabalhista', 'M', '1985-11-15', 38);

insert into usuario
(email, nome, bio, genero, data_nasc, idade)
values ('ana@gmail.com', 'Ana', 'Professora de matemática', 'F', '1995-08-08', 27);

insert into usuario
(email, nome, bio, genero, data_nasc, idade)
values ('pedro@outlook.com', 'Pedro', 'Desenvolvedor front-end', 'M', '1992-04-25', 30);

insert into usuario
(email, nome, bio, genero, data_nasc, idade)
values ('gal@gmail.com', 'Gal', 'Cantora', 'F', '1999-03-10', 24);

insert into usuario
(email, nome, bio, genero, data_nasc, idade)
values ('carla@gmail.com', 'Carla', 'Designer gráfica', 'F', '1993-09-12', 29);

insert into usuario
(email, nome, bio, genero, data_nasc, idade)
values ('felipe@gmail.com', 'Felipe', 'Estudante de engenharia civil', 'M', '1998-07-17', 24);

insert into usuario
(email, nome, bio, genero, data_nasc, idade)
values ('lucas@hotmail.com', 'Lucas', 'Analista de sistemas', 'M', '1990-12-05', 31);

insert into usuario
(email, nome, bio, genero, data_nasc, idade)
values ('mariana@outlook.com', 'Mariana', 'Estudante de direito', 'F', '2002-03-25', 21);

insert into usuario
(email, nome, bio, genero, data_nasc, idade)
values ('paulo@yahoo.com', 'Paulo', 'Médico veterinário', 'M', '1988-06-30', 33);

insert into usuario
(email, nome, bio, genero, data_nasc, idade)
values ('beatriz@hotmail.com', 'Beatriz', 'Professora de português', 'F', '1991-11-22', 30);

insert into usuario
(email, nome, bio, genero, data_nasc, idade)
values ('leonardo@gmail.com', 'Leonardo', 'Analista de marketing', 'M', '1996-04-18', 27);
-------------------------------------------------

-------------------------------------------------
-- Inserindo na tabela de 'curtidas'
insert into curtidas (id_u, id_u_curtiu) values
(1, 2),
(3, 1),
(4, 2),
(5, 3),
(6, 4),
(7, 5),
(8, 6),
(9, 7),
(10, 8),
(11, 9),
(12, 10),
(1, 3),
(4, 6),
(10, 12),
(10, 4),
(2, 4),
(9, 4),
(3, 4),
(4, 3),
(4, 10);
-------------------------------------------------

-------------------------------------------------
-- Inserindo na tabela 'hobbies'
insert into hobbies (descricao)
values
('Culinaria'),
('Fotografia'),
('Praia'),
('Jogos de tabuleiro'),
('Artesanato'),
('Cinema'),
('Esportes'),
('Balada'),
('Leitura'),
('Dança');
-------------------------------------------------
-- Inserindo na tabela 'user_hobbies'
insert into user_hobbies (id_u, id_h) values
    (5, 3),
    (2, 6),
    (8, 2),
    (7, 1),
    (4, 5),
    (1, 4),
    (6, 2),
    (3, 6),
    (9, 3),
    (7, 5),
    (5, 1),
    (2, 4),
    (8, 6),
    (1, 2),
    (6, 4),
    (10, 5),
    (7, 8);
-------------------------------------------------

-------------------------------------------------
-- Inserindo na tabela 'chat'
insert into chat (id_emissor, id_receptor, mensagem, data_hora)
values
    (4, 2, 'Oi, tudo bem?', '2023-04-01 14:31:52'),
    (2, 4, 'Sim, e você?', '2023-04-01 14:32:45'),
    (4, 2, 'Estou bem também, obrigado. Você é daqui?', '2023-04-01 14:32:59'),
    (2, 4, 'Não, sou de outra cidade. E você?', '2023-04-01 14:33:32'),
    (4, 2, 'Sou daqui sim. E aí, já conhece algum lugar legal?', '2023-04-01 14:33:58');
-------------------------------------------------

-------------------------------------------------
-- Inserindo na tabela 'match'
insert into app.match (id_u1, id_u2, data)
select c1.id_u, c2.id_u, current_timestamp
from app.curtidas c1
inner join app.curtidas c2
    on c1.id_u = c2.id_u_curtiu
    and c1.id_u_curtiu = c2.id_u
where c1.id_u < c2.id_u
and not exists(
    select 1
    from app.match m
    where (m.id_u1 = c1.id_u
        AND m.id_u2 = c2.id_u)
        OR (m.id_u1= c2.id_u
        AND m.id_u2= c1.id_u)
);
-------------------------------------------------

-------------------------------------------------
-- +++++++++++++++++++++++++++++++++++++++++++ --
-------------------------------------------------

-------------------------------------------------
-- Selecionando nome de todos os curtidos e curtidas
select u1.nome as Curtido, u2.nome as Curtiu
from app.curtidas c1
inner join app.usuario u1 on c1.id_u = u1.id_u
inner join app.usuario u2 on c1.id_u_curtiu = u2.id_u;

-- Selecionado id de todos que deram match na ana
select u.id_u as match_ana
from app.match m
inner join usuario u on u.id_u = m.id_u2
where m.id_u1 in (
    select id_u
    from app.usuario
    where nome like 'A__'
)
union
select u.id_u as match_ana
from app.match m
inner join usuario u on u.id_u = m.id_u1
where m.id_u2 in (
    select id_u
    from app.usuario
    where nome like 'A__'
);

-- Selecionando o nome de cada usuário com a pessoa que lhe deu match
select u1.nome as Pessoa1_match, u2.nome as Pessoa2_match
from app.match m
inner join app.usuario u1 on m.id_u1 = u1.id_u
inner join app.usuario u2 on m.id_u2 = u2.id_u;

-- Selecionando todas as pessoas que nasceram entre 2000 e 2005
select id_u, nome
from app.usuario
where data_nasc
    between '2000-01-01' and '2005-12-31';

-- Selecionando o nome dos hobies das pessoas que nasceram entre 2000 e 2005
select uh.id_u as usuario, h.descricao as hobbies_gen
from app.user_hobbies uh
inner join hobbies h on uh.id_h = h.id_hobbie
where uh.id_u in (
    select id_u
    from app.usuario
    where data_nasc
        between '2000-01-01' and '2005-12-31'
);

-- Selecionar os dados das pessoas que curtem praia e balada
select usuario.id_u, nome, data_nasc, genero, user_hobbies.id_h
from usuario, user_hobbies
where app.user_hobbies.id_u = usuario.id_u
  and (app.user_hobbies.id_h = 3 or app.user_hobbies.id_h = 8);

-- Selecionar as últimas mensagens da Ana
select mensagem, u1.nome as emissor, u2.nome as receptor
from app.chat c
inner join usuario u1 on u1.id_u = c.id_emissor
inner join usuario u2 on u2.id_u = c.id_receptor
where c.id_receptor = 4 or c.id_emissor = 4
  and (data_hora >=
       date_trunc('day', to_date('2023-04-05', 'YYYY-MM-DD') - interval '7 days'))
order by data_hora;