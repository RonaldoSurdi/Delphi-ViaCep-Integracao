CREATE TABLE pessoa (
	idpessoa bigserial NOT NULL,
	flnatureza int2 NOT NULL,
	dsdocumento varchar(20) NOT NULL,
	nmprimeiro varchar(100) NOT NULL,
	nmsegundo varchar(100) NOT NULL,
	dtregistro date NULL,
	CONSTRAINT pessoa_pk PRIMARY KEY (idpessoa)
);
CREATE TABLE endereco (
	idendereco bigserial NOT NULL,
	idpessoa int8 NOT NULL,
	dscep varchar(15) NOT NULL,
	CONSTRAINT endereco_pk PRIMARY KEY (idendereco),
	CONSTRAINT endereco_fk_pessoa FOREIGN KEY (idpessoa) REFERENCES pessoa(idpessoa) ON DELETE cascade
);
CREATE TABLE endereco_integracao (
	idendereco bigserial NOT NULL,
	nmcidade varchar(100) NULL,
	nmbairro varchar(50) NULL,
	nmlogradouro varchar(100) NULL,
	dscomplemento varchar(100) NULL,
	CONSTRAINT enderecointegracao_pk PRIMARY KEY (idendereco),
	CONSTRAINT enderecointegracao_fk_endereco FOREIGN KEY (idendereco) REFERENCES endereco(idendereco) ON DELETE cascade
);