-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.
-- Banco de Dados - prof. Duncan
--
-- Este é o banco de dados de uma cadeia de lojas (cursos, clientes, fabricantes, 
--   produtos, lojas, vendedores, compras e itens)
--
-- Este arquivo contem a criacao das tabelas e a insercao de registros em numero
-- suficiente para as diversas questoes da aula pratica.
--
-- No arquivo estao indicados os pontos onde devem ser feitas as quebras no
-- copy/paste do Notepad (Bloco de Notas) para o sqlplus
--

CREATE TABLE Fabricantes (
Fabricante numeric(4) not null PRIMARY KEY,
NomeFabricante varchar(50) not null,
Cidade varchar(50) not null,
Pais varchar(50) not null
);

CREATE TABLE Produtos (
Produto numeric(5) PRIMARY KEY,
-- Integridade de domínio: numeric(5) tipo numerico com ateh 5 posicoes
-- Integridade de Entidade: Primary key
Fabricante numeric(4) not null references Fabricantes,
AnoFabric numeric(4) not null,
Denominacao varchar(70) not null,
-- Integridade de valor nulo: not null <-- preenchimento obrigatorio
Estoque numeric(4),
-- Integridade de valor nulo: null <-- preenchimento opcional
Preco numeric(8,2) not null
);

CREATE TABLE Lojas (
IDLoja numeric(2) PRIMARY KEY,
NomeLoja varchar(25) not null,
Endereco varchar(200) not null
);

CREATE TABLE Cursos (
Curso char(5) not null PRIMARY KEY,
Denominacao varchar(50) not null,
DataCriacao datetime not null
);

CREATE TABLE Clientes (
Cliente numeric(8) PRIMARY KEY,
Nome varchar(70) not null,
Genero char(1) not null,
DataNasc datetime not null,
Curso char(5) not null references Cursos
);

CREATE TABLE Vendedores (
IDVendedor numeric(3) PRIMARY KEY,
NomeVendedor varchar(25) not null
);

CREATE TABLE Compras (
NroPedido numeric(6) not null PRIMARY KEY,
DataCompra datetime not null,
Cliente numeric(8) REFERENCES Clientes,
IDLoja numeric(2) REFERENCES Lojas,
IDVendedor numeric(3) REFERENCES Vendedores
);

CREATE TABLE itens (
quantidade numeric(3) not null,
valortotal numeric(8,2) not null,
-- Integridade de dominio: numeric(8,2) <-- numerico com 8 posicoes, e as 2 últimas são depois da virgula
Produto numeric(5) not null REFERENCES Produtos,
-- Integridade referencial: foreign key de produto para Produtos
NroPedido numeric(6) not null REFERENCES Compras,
PRIMARY KEY(Produto, NroPedido)
);

-- ---------------------corte -----------------------

--                               12345678901234567890
Insert into Fabricantes values(1001,'CAMPUS','Rio de Janeiro','Brasil');
Insert into Fabricantes values(1002,'PEARSON','London','United Kingdom');
Insert into Fabricantes values(1003,'PRENTICEHALL','Upple Saddle River','United States');
Insert into Fabricantes values(1004,'MORGANKAUFFMAN','Burlington','United States');
Insert into Fabricantes values(1005,'JOHNWILEY','Hoboken','United States');
Insert into Fabricantes values(1006,'ADDISONWESLEY','Boston','United States');
Insert into Fabricantes values(1007,'MITPRESS','Cambridge','United States');

Insert into produtos values(250,1001, 2007,'SILBERSCHATZ, A., KORTH, H., SUDARSHAN, S. Sistema de Bancos de Dados',13,70.00);
Insert into produtos values(251,1002, 2006,'ELSMARI, R., NAVATHE, S.B. Sistemas de Banco de Dados',24,50.00);
Insert into produtos values(252,1001, 2007,'DATE, C.J. Introdução a Sistemas de Bancos de Dados',6,75.00);
Insert into produtos values(256,1003, 2007,'ULLMAN, J., WIDOM, J. A first course in database systems',4,40.00);
Insert into produtos values(257,1002, 1996,'BOWMAN, J.; EMERSON, S.; DARNOVSKY, M. The Practical SQL Handbook ',6,68.80);
Insert into produtos values(258,1001, 1997,'INMON, W.H. Como construir o Data Warehouse',5,40.80);
Insert into produtos values(266,1004, 2006,'HAN, J. Data Mining: Concepts and Techniques',7,120.50);
Insert into produtos values(267,1003, 2000,'LEYMANN, F. ROLLER, D. Production workflow : concepts and techniques',7,110.00);
Insert into produtos values(268,1005, 2002,'KIMBALL, R. et al.The data warehouse lifecycle toolkit',8,150.00);
Insert into produtos values(285,1006, 2007,'TAN, P. N. STEINBACH, M. KUMAR, V. Introduction to data mining',14,90.00);
Insert into produtos values(286,1007, 2002,'AALST, W.v.d. HEE, K.v. Workflow management',4,140.00);

Insert into lojas values(1,'Loja L-1','Av. da Azenha, 600, Porto Alegre');
Insert into lojas values(2,'Loja L-2','Av. Nilo Pecanha, 3500, Porto Alegre');

Insert into Cursos values('ADMIN','Bacharelado em Administracao','1970/01/01');
Insert into Cursos values('CCOMP','Bacharelado em Ciencia da Computacao','1995/08/01');
Insert into Cursos values('SINFO','Bacharelado em Sistemas de Informacao','2003/03/01');

Insert into clientes values(3106842,'Joana Medeiros','F','1989/05/16','ADMIN');
Insert into clientes values(4103839,'Eduardo Medeiros','M','1992/10/23','CCOMP');
Insert into clientes values(4108293,'Marcelo Medeiros','M','1993/01/24','SINFO');
Insert into clientes values(4112046,'Tiago Medeiros','M','1992/12/15','SINFO');
Insert into clientes values(4112192,'Vanessa Medeiros','F','1992/02/25','CCOMP');
Insert into clientes values(4201018,'Carla Medeiros','F','1994/04/01','CCOMP');
Insert into clientes values(4206067,'Rogerio Medeiros','M','1993/07/17','SINFO');
Insert into clientes values(5280018,'Solange Medeiros','F','1988/09/30','SINFO');
Insert into clientes values(5280023,'Marcelo Medeiros','M','1991/11/07','SINFO');
Insert into clientes values(5280027,'Katia Medeiros','F','1995/08/26','CCOMP');
Insert into clientes values(6104543,'Marcos Medeiros','M','1989/05/13','ADMIN');

Insert into vendedores values(1,'Ana Maria Braga');
Insert into vendedores values(2,'Sergio Cintra');
Insert into vendedores values(3,'Carlos Alberto');
Insert into vendedores values(4,'Arlindo Afonso');
Insert into vendedores values(5,'Carina Bacchi');
Insert into vendedores values(6,'Dorvalino Brito');
Insert into vendedores values(7,'Eduardo Pereira');
Insert into vendedores values(8,'Humberto Branco');
Insert into vendedores values(9,'Euclides Fraga');

Insert into compras values(100001,'2011-03-02',4108293,1,1);
Insert into compras values(100002,'2011-03-02',4112046,1,1);
Insert into compras values(100003,'2011-03-02',4112192,1,1);
Insert into compras values(100004,'2011-03-03',4103839,1,1);
Insert into compras values(100005,'2011-03-03',5280023,1,1);
Insert into compras values(100006,'2011-03-03',4112046,1,2);
Insert into compras values(100007,'2011-03-03',4112192,1,3);
Insert into compras values(100008,'2011-03-03',4108293,1,5);
Insert into compras values(100009,'2011-03-03',4108293,2,2);
Insert into compras values(100010,'2011-03-04',3106842,1,1);
Insert into compras values(100011,'2011-03-04',4206067,1,1);
Insert into compras values(100012,'2011-03-04',4103839,1,3);
Insert into compras values(100013,'2011-03-04',4112192,1,5);
Insert into compras values(100014,'2011-03-04',4108293,1,8);
Insert into compras values(100015,'2011-03-04',4112046,1,8);
Insert into compras values(100016,'2011-03-05',4201018,1,1);
Insert into compras values(100017,'2011-03-05',5280027,1,1);
Insert into compras values(100018,'2011-03-05',5280023,1,5);
Insert into compras values(100019,'2011-03-05',4108293,1,7);
Insert into compras values(100020,'2011-03-05',4112046,1,7);
Insert into compras values(100021,'2011-03-05',4103839,1,8);
Insert into compras values(100022,'2011-03-05',4112192,1,8);
Insert into compras values(100023,'2011-03-05',5280018,2,1);
Insert into compras values(100024,'2011-03-05',3106842,2,5);
Insert into compras values(100025,'2011-03-05',4206067,2,5);
Insert into compras values(100026,'2011-03-06',5280027,1,1);
Insert into compras values(100027,'2011-03-06',4112046,1,4);
Insert into compras values(100028,'2011-03-06',4201018,1,4);
Insert into compras values(100029,'2011-03-06',5280018,1,5);
Insert into compras values(100030,'2011-03-06',4112192,1,7);
Insert into compras values(100031,'2011-03-06',4108293,1,9);
Insert into compras values(100032,'2011-03-06',4206067,2,2);
Insert into compras values(100033,'2011-03-06',4201018,2,6);

Insert into itens values(1, 60.20,250,100001);
Insert into itens values(1, 60.20,250,100002);
Insert into itens values(1, 60.20,250,100003);
Insert into itens values(1, 60.20,250,100004);
Insert into itens values(1, 38.08,256,100008);
Insert into itens values(1, 40.10,251,100006);
Insert into itens values(1, 38.08,256,100006);
Insert into itens values(1, 40.10,251,100007);
Insert into itens values(1, 38.08,256,100007);
Insert into itens values(1, 60.20,250,100005);
Insert into itens values(1, 40.10,251,100009);
Insert into itens values(1, 60.20,250,100010);
Insert into itens values(2, 80.00,251,100012);
Insert into itens values(1, 38.08,256,100012);
Insert into itens values(1, 40.10,258,100014);
Insert into itens values(1, 40.10,258,100015);
Insert into itens values(2, 75.05,256,100013);
Insert into itens values(1, 60.20,250,100011);
Insert into itens values(1, 40.10,258,100021);
Insert into itens values(1, 75.05,252,100019);
Insert into itens values(1, 68.80,257,100019);
Insert into itens values(1, 68.80,257,100020);
Insert into itens values(2, 80.00,258,100022);
Insert into itens values(1, 60.20,250,100016);
Insert into itens values(1, 58.08,286,100018);
Insert into itens values(1, 60.20,250,100017);
Insert into itens values(3, 99.90,256,100024);
Insert into itens values(1, 38.08,256,100025);
Insert into itens values(2, 110.00,250,100023);
Insert into itens values(1, 110.00,267,100031);
Insert into itens values(1, 120.50,266,100031);
Insert into itens values(1, 75.05,252,100027);
Insert into itens values(1, 120.50,266,100027);
Insert into itens values(1, 75.05,252,100030);
Insert into itens values(1, 68.80,257,100030);
Insert into itens values(2, 75.05,251,100028);
Insert into itens values(1, 58.08,286,100029);
Insert into itens values(1, 60.20,250,100026);
Insert into itens values(1, 38.08,256,100033);
Insert into itens values(1, 40.10,251,100032);

commit;

