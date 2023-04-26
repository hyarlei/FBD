-- Definir o esquema padrão
SET SCHEMA 'bilheteria';

-- Criar a tabela FILME
CREATE TABLE FILME(
    CODIGO SERIAL PRIMARY KEY,
    TITULO VARCHAR(100) NOT NULL,
    SINOPSE TEXT,
    DURACAO_MIN INTEGER NOT NULL,
    CLASSIFICACAO VARCHAR(10)
);

-- Criar a tabela SALA
CREATE TABLE SALA(
    NUMERO SERIAL PRIMARY KEY,
    QTD_POLTRONAS INTEGER
);

-- Criar a tabela POLTRONA
CREATE TABLE POLTRONA(
    ID SERIAL PRIMARY KEY,
    NUMERO_SALA INTEGER,
    COD_POLTRONA VARCHAR(3),
    CONSTRAINT poltrona_sala_fk FOREIGN KEY(NUMERO_SALA) REFERENCES SALA(NUMERO)
);

-- Criar a tabela SESSAO
CREATE TABLE SESSAO(
    COD_SESSAO SERIAL PRIMARY KEY,
    DT DATE,
    HORARIO INTEGER,
    DIM CHAR(2),
    LINGUAGEM VARCHAR(20),
    SALA_NUM INTEGER,
    FILME_CODIGO INTEGER,
    UNIQUE(DT,HORARIO,SALA_NUM),
    FOREIGN KEY (SALA_NUM) REFERENCES SALA(NUMERO),
    FOREIGN KEY (FILME_CODIGO) REFERENCES FILME(CODIGO)
);

-- Criar a tabela BILHETE
CREATE TABLE BILHETE (
  COD_SESSAO INTEGER REFERENCES SESSAO (COD_SESSAO),
  ID_POLTRONA INTEGER REFERENCES POLTRONA (ID),
  VALOR NUMERIC(5,2),
  PRIMARY KEY (COD_SESSAO, ID_POLTRONA),
  CONSTRAINT bilhete_sessao_fk FOREIGN KEY (COD_SESSAO) REFERENCES SESSAO(COD_SESSAO),
  CONSTRAINT bilhete_poltrona_fk FOREIGN KEY (ID_POLTRONA) REFERENCES POLTRONA(ID)
);

-- Criar a tabela GENERO
CREATE TABLE GENERO (
    ID_GENERO SERIAL PRIMARY KEY,
    NOME_GENERO VARCHAR(50)
);

-- Criar a tabela FILME_GENERO
CREATE TABLE FILME_GENERO (
    ID_FILME INTEGER,
    ID_GENERO INTEGER,
    PRIMARY KEY(ID_FILME, ID_GENERO),
    FOREIGN KEY(ID_FILME) REFERENCES FILME(CODIGO),
    FOREIGN KEY(ID_GENERO) REFERENCES GENERO(ID_GENERO)
);

-- Inserir dados nas tabelas
INSERT INTO FILME (TITULO, SINOPSE, DURACAO_MIN, CLASSIFICACAO) 
VALUES 
    ('Aventura na Floresta', 'Um grupo de amigos decide explorar uma floresta desconhecida...', 120, 'Livre'),
    ('Caminhos Cruzados', ' Duas pessoas com trajetórias de vida bem diferentes...', 90, '14 anos'),
    ('O Preço do Poder', 'Em um mundo onde a corrupção impera...', 150, '16 anos'),
    ('O Mistério do Casarão', ' Uma família se muda para um casarão antigo...', 110, '12 anos'),
    ('Aventuras no Espaço', 'Uma equipe de astronautas embarca em uma missão ...', 100, 'Livre');

-- Inserir dados nas tabelas
INSERT INTO
    SALA (QTD_POLTRONAS)
VALUES
    (100),
    (50),
    (150),
    (200),
    (75);

-- Inserir dados nas tabelas
INSERT INTO POLTRONA (NUMERO_SALA, COD_POLTRONA)
SELECT
s.numero,
CONCAT(LEAST(ASCII('A')+((p.id-1)%26), ASCII('Z')),
FLOOR((p.id-1)/26)+1) AS cod_poltrona
FROM
sala s
JOIN generate_series(1, s.qtd_poltronas) p(id) ON true;

-- Inserir dados nas tabelas
INSERT INTO SESSAO (DT, HORARIO, DIM, LINGUAGEM, SALA_NUM, FILME_CODIGO)
VALUES
('2023-04-15', 14, '2D', 'Dublado', 1, 1),
('2023-04-15', 17, '2D', 'Legendado', 2, 2),
('2023-04-16', 14, '2D', 'Legendado', 3, 3),
('2023-04-16', 19, '3D', 'Dublado', 4, 4),
('2023-04-16', 22, '2D', 'Dublado', 5, 5);

-- Inserir dados nas tabelas
INSERT INTO GENERO (NOME_GENERO)
VALUES
('Ação'),
('Comédia'),
('Drama'),
('Terror'),
('Ficção científica');

-- Inserir dados nas tabelas
INSERT INTO FILME_GENERO (ID_FILME, ID_GENERO)
VALUES
(1, 1),
(1, 5),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Inserir dados nas tabelas
INSERT INTO BILHETE (COD_SESSAO, ID_POLTRONA, VALOR)
VALUES
(1, 1, 20.00),
(1, 2, 20.00),
(1, 3, 20.00),
(2, 1, 15.00),
(2, 2, 15.00),
(3, 1, 25.00),
(3, 2, 25.00),
(3, 3, 25.00),
(4, 1, 30.00),
(4, 2, 30.00),
(4, 3, 30.00),
(5, 1, 18.00),
(5, 2, 18.00);

-- Verificar os dados das tabelas
SELECT * FROM FILME;
SELECT * FROM SALA;
SELECT * FROM POLTRONA;
SELECT * FROM SESSAO;
SELECT * FROM GENERO;
SELECT * FROM FILME_GENERO;
SELECT * FROM BILHETE;
