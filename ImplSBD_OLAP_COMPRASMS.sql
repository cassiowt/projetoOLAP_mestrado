-- Banco de Dados de Compras, modelagem OLAP MS SQL Server
--  para exercícios em aula e extra-classe.
-- escrito por Duncan Ruiz em Agosto de 2015
-- corrigido para acertar definição da hierarquia de DIM_CLIENTE e a criacao de DIM_TEMPO

create table DIM_CURSO				-- hierarquia
(Denominacao varchar(50) not null,  --   |
 Curso char(5) primary key 			--   V
 );
 insert into DIM_CURSO					
  Select distinct						
        cur.Denominacao as Denominacao,   
		cur.Curso as Curso
  FROM Cursos cur ;

create table DIM_CLIENTE 			-- hierarquias (2)
(Genero char(1) not null,			--    |
 Idade numeric(2) not null,			--           |
 Nome varchar(70) not null,			--    |      
 Cliente numeric(8) primary key		--    V      V
);
insert into DIM_CLIENTE
  Select distinct 	
    	cli.Genero as Genero,
    	year(getdate()) - year(cli.DataNasc) as Idade,
    	cli.Nome as Nome,
     	cli.Cliente as Cliente
  FROM Clientes cli ;

create table DIM_FABRICANTE				-- hierarquia 
(Pais varchar(50) not null,				--  	|
 Cidade varchar(50) not null,			--		|
 NomeFabricante varchar(50) not null,	--		|
 Fabricante numeric(4) primary key		--		V
);
insert into DIM_FABRICANTE
  Select distinct
		fab.Pais as Pais,
		fab.Cidade as Cidade,
    	fab.NomeFabricante as NomeFabricante,
    	fab.Fabricante as Fabricante
    FROM Fabricantes fab;

create table DIM_PRODUTO				-- hierarquia
(AnoFabric numeric(4) not null,			--		|
 Denominacao varchar(70) not null,		--		|
 Produto numeric(5) primary key			--		V
);
insert into DIM_PRODUTO
  Select distinct
    	pro.AnoFabric as AnoFabric,
		pro.Denominacao as Denominacao,
    	pro.Produto as Produto
    FROM Produtos pro ;

create table DIM_LOJA				--	hierarquia
(NomeLoja varchar(25) not null,		--		|
IDLoja numeric(2) primary key		--		V
);
insert into DIM_LOJA
  Select distinct 	
		loj.NomeLoja as NomeLoja,
        loj.IDLoja as IDLoja
  FROM Lojas loj;

create table DIM_VENDEDOR			--  hierarquia
(NomeVendedor varchar(25) not null,	--		|
 IDVendedor numeric(3) primary key	--		V
);
insert into DIM_VENDEDOR
  Select distinct	
    	vend.NomeVendedor as NomeVendedor,
        vend.IDVendedor as IDVendedor
   FROM Vendedores Vend;
  
CREATE TABLE DIM_TEMPO(
	[PK_Data] [datetime] NOT NULL,
	[Data_Nome] [nvarchar](50) NULL,
	[Ano] [datetime] NULL,
	[Ano_Nome] [nvarchar](50) NULL,
	[Semestre] [datetime] NULL,
	[Semestre_Nome] [nvarchar](50) NULL,
	[Trimestre] [datetime] NULL,
	[Trimestre_Nome] [nvarchar](50) NULL,
	[Mês] [datetime] NULL,
	[Mês_Nome] [nvarchar](50) NULL,
	[Semana] [datetime] NULL,
	[Semana_Nome] [nvarchar](50) NULL,
	[Dia_Do_Ano] [int] NULL,
	[Dia_Do_Ano_Nome] [nvarchar](50) NULL,
	[Dia_Do_Semestre] [int] NULL,
	[Dia_Do_Semestre_Nome] [nvarchar](50) NULL,
	[Dia_Do_Trimestre] [int] NULL,
	[Dia_Do_Trimestre_Nome] [nvarchar](50) NULL,
	[Dia_Do_Mês] [int] NULL,
	[Dia_Do_Mês_Nome] [nvarchar](50) NULL,
	[Dia_Da_Semana] [int] NULL,
	[Dia_Da_Semana_Nome] [nvarchar](50) NULL,
	[Semana_Do_Ano] [int] NULL,
	[Semana_Do_Ano_Nome] [nvarchar](50) NULL,
	[Mês_Do_Ano] [int] NULL,
	[Mês_Do_Ano_Nome] [nvarchar](50) NULL,
	[Mês_Do_Semestre] [int] NULL,
	[Mês_Do_Semestre_Nome] [nvarchar](50) NULL,
	[Mês_Do_Trimestre] [int] NULL,
	[Mês_Do_Trimestre_Nome] [nvarchar](50) NULL,
	[Trimestre_Do_Ano] [int] NULL,
	[Trimestre_Do_Ano_Nome] [nvarchar](50) NULL,
	[Trimestre_Do_Semestre] [int] NULL,
	[Trimestre_Do_Semestre_Nome] [nvarchar](50) NULL,
	[Semestre_Do_Ano] [int] NULL,
	[Semestre_Do_Ano_Nome] [nvarchar](50) NULL,
 CONSTRAINT [PK_DimTempo] PRIMARY KEY CLUSTERED ([PK_Data] ASC));
insert into DIM_TEMPO 
select * from [DATAPOA].[dbo].[DIM_TEMPO];
  
create table FATO_COMPRAS
(Quantidade numeric(3) not null,
 ValorTotal numeric(8,2),
 Curso char(5) references DIM_CURSO,
 Cliente numeric(8) references DIM_CLIENTE, 
 Produto numeric(5) references DIM_PRODUTO, 
 Fabricante numeric(4) references DIM_FABRICANTE, 
 Datacompra datetime references DIM_TEMPO,
 IDLoja numeric(2) references DIM_LOJA,
 IDVendedor numeric(3) references DIM_VENDEDOR,
primary key (Curso, Cliente, Produto, Fabricante, Datacompra, IDLoja, IDVendedor)
);
insert into FATO_COMPRAS
SELECT distinct
    	itens.quantidade as Quantidade,
    	itens.valortotal as ValorTotal,
    	cli.Curso as Curso,
    	com.Cliente as Cliente,
    	itens.Produto AS Produto,
		pro.Fabricante as Fabricante,
    	com.DataCompra as Datacompra,
    	com.IDLoja as IDLoja,
    	com.IDVendedor as IDVendedor
  FROM  Compras com INNER JOIN itens 
  ON com.NroPedido = itens.NroPedido
  INNER JOIN Clientes cli on com.Cliente = cli.Cliente
  INNER JOIN Produtos pro on itens.Produto = pro.Produto;
