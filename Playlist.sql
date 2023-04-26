------------------------------------------------------------------
-- Criando as tabelas do banco

DROP table Artista Cascade;
DROP table Gravadora Cascade;
DROP table Playlist Cascade;
DROP table Musica Cascade;
DROP table Musica_Artista Cascade;
DROP table Usuario Cascade;
DROP table Playlist_Musica Cascade;

CREATE TABLE Artista
(
  cod_autor INT NOT NULL,
  nome VARCHAR(50) NOT NULL,
  PRIMARY KEY (cod_autor)
);

CREATE TABLE Gravadora
(
  nome VARCHAR(50) NOT NULL,
  id_gravadora INT NOT NULL,
  endereco VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_gravadora)
);

CREATE TABLE Musica
(
  cod_musica INT NOT NULL,
  titulo VARCHAR(50) NOT NULL,
  id_gravadora INT NOT NULL,
  PRIMARY KEY (cod_musica),
  FOREIGN KEY (id_gravadora) REFERENCES Gravadora(id_gravadora)
);

CREATE TABLE Usuario
(
  id_usuario INT NOT NULL,
  nome VARCHAR(50)  NOT NULL,  
  PRIMARY KEY (id_usuario)
  
);

CREATE TABLE Playlist
(
  id_playlist INT NOT NULL,
  nome VARCHAR(50) NOT NULL,
  descricao VARCHAR(50) NOT NULL,
  id_usu INT NOT NULL,
  PRIMARY KEY (id_playlist),
  FOREIGN KEY (id_usu) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Musica_Artista
(
  cod_musica INT NOT NULL,
  cod_artista INT NOT NULL,
  PRIMARY KEY (cod_musica, cod_artista),
  FOREIGN KEY (cod_musica) REFERENCES Musica(cod_musica),
  FOREIGN KEY (cod_artista) REFERENCES Artista(cod_autor)
);

CREATE TABLE Playlist_Musica
(
  id_playlist INT NOT NULL,
  cod_musica INT NOT NULL,
  PRIMARY KEY (id_playlist, cod_musica),
  FOREIGN KEY (id_playlist) REFERENCES Playlist(id_playlist),
  FOREIGN KEY (cod_musica) REFERENCES Musica(cod_musica)
);

------------------------------------------------------------------
--- povoando o banco 

INSERT INTO public.usuario(id_usuario, nome)
	VALUES (10, 'Ana'), (11,'Bruno');

INSERT INTO public.artista(
            cod_autor, nome)
    VALUES (10, 'Engenheiros do Hawai');

INSERT INTO public.artista(
            cod_autor, nome)
    VALUES (11, 'Coldplay');

 INSERT INTO public.artista(
            cod_autor, nome)
    VALUES (12, 'Marisa Monte');

INSERT INTO public.gravadora(
            nome, id_gravadora, endereco)
    VALUES ('Som Livre', 1, 'Av. Itinerante, 10'), ('Max Discos', 2, 'Rua Pedro I, 20');

INSERT INTO public.musica(
            cod_musica, id_gravadora, titulo)
    VALUES (10, 1, 'Infinita Highway'), (21, 2, 'The Scientist'), (22,2,'Vilarejo');

INSERT INTO public.musica_artista(
            cod_musica, cod_artista)
    VALUES (10, 10), (22,12), (21,11) ;

INSERT INTO public.playlist(
            id_playlist, id_usu, nome, descricao)
    VALUES 
    (1, 10, 'Variadas', 'Minhas preferidas'), 
    (2, 11, 'Nacionais', 'Músicas do Brasil');

INSERT INTO public.playlist_musica(
            id_playlist, cod_musica)
    VALUES (1,10), (1,21), (2,10),(2,22);

-- Questão 01 ------------------------------------------------------------------

INSERT INTO Artista (cod_autor, nome)
    VALUES
        (13, 'Digo ou Não Digo'),
        (14, 'Meu Amor É Seu');

INSERT INTO Gravadora (nome, id_gravadora, endereco)
     VALUES
        ('Believe Music', 3, ' Av. das Américas, 7935');

INSERT INTO Musica (cod_musica, titulo, id_gravadora)
    VALUES
        (30, 'Foi Bom, Mas Foi Ontem', 3),
        (31, 'Se for amor', 3),
        (32, 'Não Aceito Mais', 3),
        (33, 'Meu pedaço de pecado', 3),
        (40, 'Dengo', 3),
        (41, 'Eu tenho a senha', 3),
        (42, 'Frio e Calculista', 3),
        (43, 'Amando Você', 3),
        (44, 'Se Não Valorizar', 3);

INSERT INTO Musica_Artista (cod_musica, cod_artista)
    VALUES
        (30, 14),
        (31, 14),
        (32, 14),
        (33, 14),
        (40, 13),
        (41, 13),
        (42, 13),
        (43, 13),
        (44, 13);

-- Questão 02 ------------------------------------------------------------------

INSERT INTO Playlist_Musica (id_playlist, cod_musica)
    VALUES
        (1, 30),
        (1, 31),
        (1, 40),
        (1, 41),
        (1, 42),
        (1, 43),
        (1, 44),
        (2, 30),
        (2, 31);

-- Questão 03 ------------------------------------------------------------------

SELECT Musica.titulo
FROM musica
WHERE cod_musica = 10;

-- Questão 04 ------------------------------------------------------------------

SELECT m1.cod_musica, m1.titulo, a1.nome as artista, g1.nome as gravadora
FROM musica_artista ma1
INNER JOIN musica m1 on ma1.cod_musica = m1.cod_musica
INNER JOIN artista a1 on ma1.cod_artista = a1.cod_autor
INNER JOIN gravadora g1 on m1.id_gravadora = g1.id_gravadora
WHERE titulo = 'Infinita Highway';

-- Questão 05 ------------------------------------------------------------------

SELECT titulo
FROM musica;

-- Questão 06 ------------------------------------------------------------------

SELECT m1.titulo, g1.nome as gravadora
FROM musica m1
INNER JOIN gravadora g1 on m1.id_gravadora = g1.id_gravadora;

-- Questão 07 ------------------------------------------------------------------

SELECT playlist.nome, descricao
FROM playlist
INNER JOIN usuario u on playlist.id_usu = u.id_usuario
WHERE u.nome like 'Ana';

-- Questão 08 ------------------------------------------------------------------

SELECT titulo
FROM musica
WHERE titulo like 'A%';

-- Questão 09 ------------------------------------------------------------------

SELECT titulo
FROM musica
WHERE titulo like '____a';

-- Questão 10 ------------------------------------------------------------------

SELECT cod_autor, nome
FROM artista
WHERE cod_autor between 3 and 10;

-- Questão 11 ------------------------------------------------------------------

SELECT m1.titulo as titulo, g1.nome as gravadora
FROM playlist_musica pm1
INNER JOIN Musica m1 on pm1.cod_musica = m1.cod_musica
INNER JOIN Gravadora g1 on m1.id_gravadora = g1.id_gravadora
INNER JOIN playlist p1 on pm1.id_playlist = p1.id_playlist
INNER JOIN usuario u on p1.id_usu = u.id_usuario
WHERE u.nome = 'Bruno';

-- Questão 12 ------------------------------------------------------------------

SELECT distinct a1.nome as artistas
FROM playlist_musica pm1
INNER JOIN musica m1 on pm1.cod_musica = m1.cod_musica
INNER JOIN musica_artista ma1 on m1.cod_musica = ma1.cod_musica
INNER JOIN artista a1 on a1.cod_autor = ma1.cod_artista
INNER JOIN playlist p1 on pm1.id_playlist = p1.id_playlist
INNER JOIN usuario u1 on p1.id_usu = u1.id_usuario
WHERE u1.nome = 'Ana';

-- Questão 13 ------------------------------------------------------------------

SELECT m.titulo
FROM playlist_musica pm1
INNER JOIN musica m on pm1.cod_musica = m.cod_musica
INNER JOIN playlist p on pm1.id_playlist = p.id_playlist
INNER JOIN usuario u on p.id_usu = u.id_usuario
WHERE u.nome = 'Ana'
INTERSECT
SELECT m1.titulo
FROM playlist_musica pm2
INNER JOIN musica m1 on pm2.cod_musica = m1.cod_musica
INNER JOIN playlist p1 on pm2.id_playlist = p1.id_playlist
INNER JOIN usuario u1 on p1.id_usu = u1.id_usuario
WHERE u1.nome = 'Bruno';

-- Questão 14 ------------------------------------------------------------------

SELECT musica.cod_musica as cod, musica.titulo as titulo
FROM musica
WHERE NOT EXISTS (
    SELECT *
    FROM playlist_musica
    WHERE cod_musica = musica.cod_musica
);

-- Questão 15 ------------------------------------------------------------------

SELECT a1.nome
FROM artista a1
INNER JOIN musica_artista ma on a1.cod_autor = ma.cod_artista
INNER JOIN playlist_musica pm on ma.cod_musica = pm.cod_musica
WHERE pm.id_playlist = 1
EXCEPT
SELECT a2.nome
FROM artista a2
INNER JOIN musica_artista ma1 on a2.cod_autor = ma1.cod_artista
INNER JOIN playlist_musica p2 on ma1.cod_musica = p2.cod_musica
WHERE p2.id_playlist = 2