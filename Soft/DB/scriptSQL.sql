-- Gera��o de Modelo f�sico
-- Sql ANSI 2003 - brModelo.



CREATE TABLE Cliente (
ID Integer PRIMARY KEY,
Telefone varchar(15),
Idade integer,
Nome varchar(100)
)

CREATE SEQUENCE id_cliente START 1;

