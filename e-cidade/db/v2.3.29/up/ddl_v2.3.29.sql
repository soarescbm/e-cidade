/**
 * Arquivo ddl up
 */
--criterioatividadeimpacto
CREATE SEQUENCE criterioatividadeimpacto_am01_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE criterioatividadeimpacto(
am01_sequencial   int4 NOT NULL default 0,
am01_descricao    varchar(50) NOT NULL,
CONSTRAINT criterioatividadeimpacto_sequ_pk PRIMARY KEY (am01_sequencial));

CREATE UNIQUE INDEX criterioatividadeimpacto_sequencial_in ON criterioatividadeimpacto(am01_sequencial);

--porteatividadeimpacto
CREATE SEQUENCE porteatividadeimpacto_am02_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE porteatividadeimpacto(
am02_sequencial   int4 NOT NULL default 0,
am02_descricao    varchar(50) ,

CONSTRAINT porteatividadeimpacto_sequ_pk PRIMARY KEY (am02_sequencial));

CREATE UNIQUE INDEX porteatividadeimpacto_sequencial_in ON porteatividadeimpacto(am02_sequencial);

--atividadeimpacto
CREATE SEQUENCE atividadeimpacto_am03_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE atividadeimpacto(
am03_sequencial   int4 NOT NULL default 0,
am03_criterioatividadeimpacto   int4 NOT NULL default 0,
am03_ramo   varchar(10) NOT NULL ,
am03_descricao    varchar(255) NOT NULL ,
am03_potencialpoluidor    varchar(20) ,
CONSTRAINT atividadeimpacto_sequ_pk PRIMARY KEY (am03_sequencial));

ALTER TABLE atividadeimpacto
ADD CONSTRAINT atividadeimpacto_criterioatividadeimpacto_fk FOREIGN KEY (am03_criterioatividadeimpacto)
REFERENCES criterioatividadeimpacto;

CREATE  INDEX atividadeimpoacto_sequencial_in ON atividadeimpacto(am03_sequencial);

--atividadeimpactoporte
CREATE SEQUENCE atividadeimpactoporte_am04_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE atividadeimpactoporte(
am04_sequencial   int4 NOT NULL default 0,
am04_atividadeimpacto   int4 NOT NULL default 0,
am04_porteatividadeimpacto    int4 default 0,
CONSTRAINT atividadeimpactoporte_sequ_pk PRIMARY KEY (am04_sequencial));

ALTER TABLE atividadeimpactoporte
ADD CONSTRAINT atividadeimpactoporte_porteatividadeimpacto_fk FOREIGN KEY (am04_porteatividadeimpacto)
REFERENCES porteatividadeimpacto;

ALTER TABLE atividadeimpactoporte
ADD CONSTRAINT atividadeimpactoporte_atividadeimpacto_fk FOREIGN KEY (am04_atividadeimpacto)
REFERENCES atividadeimpacto;

CREATE  INDEX atividadeimpactoporte_sequencial_in ON atividadeimpactoporte(am04_sequencial);
CREATE UNIQUE INDEX atividadeimpactoporte_atividadeimpacto_porteatividadeimpacto_in ON atividadeimpactoporte(am04_atividadeimpacto,am04_porteatividadeimpacto);

--empreendimento
-- Criando  sequences
CREATE SEQUENCE empreendimento_am05_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
-- TABELAS E ESTRUTURA
-- Módulo: meioambiente
CREATE TABLE empreendimento(
am05_sequencial   int4 NOT NULL default 0,
am05_nome   varchar(40)  ,
am05_nomefanta    varchar(100)  ,
am05_numero   int4 NOT NULL default 0,
am05_complemento    varchar(100),
am05_cep    varchar(8) NOT NULL ,
am05_bairro   int4 NOT NULL default 0,
am05_ruas   int4 NOT NULL default 0,
am05_cnpj   varchar(14) ,
am05_cgm    int4 default 0,
CONSTRAINT empreendimento_sequ_pk PRIMARY KEY (am05_sequencial));

-- CHAVE ESTRANGEIRA
ALTER TABLE empreendimento
ADD CONSTRAINT empreendimento_ruas_fk FOREIGN KEY (am05_ruas)
REFERENCES ruas;

ALTER TABLE empreendimento
ADD CONSTRAINT empreendimento_bairro_fk FOREIGN KEY (am05_bairro)
REFERENCES bairro;

ALTER TABLE empreendimento
ADD CONSTRAINT empreendimento_cgm_fk FOREIGN KEY (am05_cgm)
REFERENCES cgm;

-- INDICES
CREATE UNIQUE INDEX empreendimento_sequencial_in ON empreendimento(am05_sequencial);

--empreendimentoatividadeimpacto
CREATE SEQUENCE empreendimentoatividadeimpacto_am06_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE empreendimentoatividadeimpacto(
am06_sequencial   int4 NOT NULL default 0,
am06_atividadeimpacto   int4 NOT NULL default 0,
am06_empreendimento   int4 NOT NULL default 0,
am06_principal    bool default 'f',
am06_atividadeimpactoporte    int4 default 0,
CONSTRAINT empreendimentoatividadeimpacto_sequ_pk PRIMARY KEY (am06_sequencial));
-- CHAVE ESTRANGEIRA
ALTER TABLE empreendimentoatividadeimpacto
ADD CONSTRAINT empreendimentoatividadeimpacto_atividadeimpacto_fk FOREIGN KEY (am06_atividadeimpacto)
REFERENCES atividadeimpacto;

ALTER TABLE empreendimentoatividadeimpacto
ADD CONSTRAINT empreendimentoatividadeimpacto_empreendimento_fk FOREIGN KEY (am06_empreendimento)
REFERENCES empreendimento;

ALTER TABLE empreendimentoatividadeimpacto
ADD CONSTRAINT empreendimentoatividadeimpacto_atividadeimpactoporte_fk FOREIGN KEY (am06_atividadeimpactoporte)
REFERENCES atividadeimpactoporte;
-- INDICES

CREATE UNIQUE INDEX empreendimentoatividadeimpacto_sequencial_in ON empreendimentoatividadeimpacto(am06_sequencial);

--responsaveltecnico
-- Criando  sequences
CREATE SEQUENCE responsaveltecnico_am07_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE responsaveltecnico(
am07_sequencial   int4 NOT NULL default 0,
am07_empreendimento    int4 NOT NULL default 0,
am07_cgm    int4 default 0,
CONSTRAINT responsaveltecnico_sequ_pk PRIMARY KEY (am07_sequencial));
-- CHAVE ESTRANGEIRA
ALTER TABLE responsaveltecnico
ADD CONSTRAINT responsaveltecnico_cgm_fk FOREIGN KEY (am07_cgm)
REFERENCES cgm;

ALTER TABLE responsaveltecnico
ADD CONSTRAINT responsaveltecnico_empreedimento_fk FOREIGN KEY (am07_empreendimento)
REFERENCES empreendimento;
-- INDICES
CREATE UNIQUE INDEX responsaveltecnico_sequencial_in ON responsaveltecnico(am07_sequencial);

--licencaempreendimento
CREATE SEQUENCE licencaempreendimento_am08_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE licencaempreendimento(
am08_sequencial   int4 NOT NULL default 0,
am08_empreendimento   int4 NOT NULL default 0,
am08_protprocesso   int4 NOT NULL default 0,
am08_licencaanterior    int4  default 0,
am08_dataemissao    date NOT NULL default null,
am08_datavencimento   date NOT NULL default null,
am08_tipolicenca    int4 default 0,
CONSTRAINT licencaempreendimento_sequ_pk PRIMARY KEY (am08_sequencial));

ALTER TABLE licencaempreendimento
ADD CONSTRAINT licencaempreendimento_protprocesso_fk FOREIGN KEY (am08_protprocesso)
REFERENCES protprocesso;

ALTER TABLE licencaempreendimento
ADD CONSTRAINT licencaempreendimento_empreendimento_fk FOREIGN KEY (am08_empreendimento)
REFERENCES empreendimento;

CREATE UNIQUE INDEX licencaempreendimento_sequencial_in ON licencaempreendimento(am08_sequencial);

--criterioatividadeimpacto
insert into criterioatividadeimpacto values ( 1,  'Hectares (ha)');
insert into criterioatividadeimpacto values ( 2,  'Área degradada em hectares (ha)');
insert into criterioatividadeimpacto values ( 3,  'Nº de cabeças');
insert into criterioatividadeimpacto values ( 4,  'Nº de pintos/mes');
insert into criterioatividadeimpacto values ( 5,  'Nº de matrizes');
insert into criterioatividadeimpacto values ( 6,  'Área alagada em hectares (ha)');
insert into criterioatividadeimpacto values ( 7,  'Área requerida ao DNPM em hectares (ha)');
insert into criterioatividadeimpacto values ( 8,  'Área total em hectares (ha)');
insert into criterioatividadeimpacto values ( 9,  'Área útil em m²');
insert into criterioatividadeimpacto values ( 10, 'Volume total de resíduos em m³/mes');
insert into criterioatividadeimpacto values ( 11, 'Toneladas/mes');
insert into criterioatividadeimpacto values ( 12, 'Área útil em hectares');
insert into criterioatividadeimpacto values ( 13, 'Nº de operações/dia');
insert into criterioatividadeimpacto values ( 14, 'Comprimento em Km');
insert into criterioatividadeimpacto values ( 15, 'Comprimento em metro');
insert into criterioatividadeimpacto values ( 16, 'Área inundada em hectares (ha)');
insert into criterioatividadeimpacto values ( 17, 'Potência em MW');
insert into criterioatividadeimpacto values ( 18, 'População atendida em nº de habitantes');
insert into criterioatividadeimpacto values ( 19, 'Vazão afluente na ETE em m³/dia');
insert into criterioatividadeimpacto values ( 20, 'Volume em m³/dia');
insert into criterioatividadeimpacto values ( 21, 'Metro cúbico (m³)');
insert into criterioatividadeimpacto values ( 22, 'Quantidade de resíduo em toneladas/dia');
insert into criterioatividadeimpacto values ( 23, 'Quantidade de resíduo em Kg/dia');
insert into criterioatividadeimpacto values ( 24, 'Capacidade de tancagem em m³');
select setval('criterioatividadeimpacto_am01_sequencial_seq', 24);

--portoatividadeimpacto
insert into porteatividadeimpacto values ( 1, 'Mínimo'  );
insert into porteatividadeimpacto values ( 2, 'Pequeno' );
insert into porteatividadeimpacto values ( 3, 'Médio'   );
insert into porteatividadeimpacto values ( 4, 'Grande'  );
insert into porteatividadeimpacto values ( 5, 'Excepcional' );
select setval('porteatividadeimpacto_am02_sequencial_seq', 5);

/**
 * Importação das atividades
 */
insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 1, '111,3', 'IRRIGACAO SUPERFICIAL', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );

insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 1, '111,4', 'IRRIGACAO POR ASPERSAO/LOCALIZADA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );

insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 2, '111,7', 'RECUPERACAO DE AREA DEGRADADA POR IRRIGACAO', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 1, '111,92', 'FORNECIMENTO DE AGUA DE RECURSOS HIDRICOS NATURAIS SUPERFICIAIS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '112,11', 'CRIACAO DE AVES DE CORTE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '112,12', 'CRIACAO DE AVES DE POSTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '112,13', 'CRIACAO DE MATRIZES E OVOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 4, '112,14', 'INCUBATORIO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '112,21', 'CUNICULTURA E OUTROS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 5, '114,21', 'CRIACAO DE SUINOS - CICLO COMPLETO - COM MANEJO DEJETOS LIQUIDOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 5, '114,22', 'CRIACAO DE SUINOS - UNIDADE PRODUTORA DE LEITOES ATE 21 DIAS - COM MANEJO DEJETOS LIQUIDOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 5, '114,23', 'CRIACAO DE SUINOS - UNIDADE PRODUTORA DE LEITOES ATE 63 DIAS - COM MANEJO DEJETOS LIQUIDOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '114,24', 'CRIACAO DE SUINOS - TERMINACAO - COM MANEJO DEJETOS LIQUIDOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '114,25', 'CRIACAO DE SUINOS - CRECHE - COM MANEJO DEJETOS LIQUIDOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '114,26', 'CRIACAO DE SUINOS - CENTRAL DE INSEMINACAO - COM MANEJO DEJETOS LIQUIDOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 5, '114,31', 'CRIACAO DE SUINOS - CICLO COMPLETO - COM MANEJO DE DEJETOS SOBRE CAMAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 5, '114,32', 'CRIACAO DE SUINOS - UNIDADE PRODUTORA DE LEITOES ATE 21 DIAS - COM MANEJO DE DEJETOS SOBRE CAMAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 5, '114,33', 'CRIACAO DE SUINOS - UNIDADE PRODUTORA DE LEITOES ATE 63 DIAS - COM MANEJO DE DEJETOS SOBRE CAMAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '114,34', 'CRIACAO DE SUINOS - TERMINACAO - COM MANEJO DE DEJETOS SOBRE CAMAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '114,35', 'CRIACAO DE SUINOS - CRECHE - COM MANEJO DE DEJETOS SOBRE CAMAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '114,36', 'CRIACAO DE SUINOS - CENTRAL DE INSEMINACAO - COM MANEJO DE DEJETOS SOBRE CAMAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '114,9', 'CRIACAO DE OUTROS ANIMAIS DE MEDIO PORTE CONFINADOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '116,1', 'CRIACAO DE BOVINOS CONFINADOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '117,1', 'CRIACAO DE BOVINOS (SEMI-EXTENSIVO)', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 6, '119,21', 'PISCICULTURA DE ESPECIES NATIVAS PARA ENGORDA (SISTEMA INTENSIVO)', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 6, '119,22', 'PISCICULTURA DE ESPECIES EXOTICAS PARA ENGORDA (SISTEMA INTENSIVO)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 6, '119,31', 'PISCICULTURA DE ESPECIES NATIVAS (SISTEMA SEMI-INTENSIVO)', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 6, '119,32', 'PISCICUTURA DE ESPECIES EXOTICAS (SISTEMA SEMI-INTENSIVO)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 6, '119,41', 'PISCICULTURA DE ESPECIES NATIVAS (SISTEMA EXTENSIVO)', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 6, '119,42', 'PISCICULTURA DE ESPECIES EXOTICAS (SISTEMA EXTENSIVO)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '510', 'PESQUISA MINERAL', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '520', 'RECUPERACAO DE AREAS MINERADAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '531,5', 'LAVRA DE ROCHA ORNAMENTAL (GRANITO/BASALTO/TALCO/ETC) - A CEU ABERTO, COM BENEFICIAMENTO E COM RECUPERACAO DE AREA DEGRADADA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '531,6', 'LAVRA DE ROCHA PARA USO IMEDIATO NA CONSTRUCAO CIVIL - A CEU ABERTO, COM BENEFICIAMENTO E COM RECUPERACAO DE AREA DEGRADADA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '531,7', 'LAVRA DE AREIA INDUSTRIAL - A CEU ABERTO, COM BENEFICIAMENTO E COM RECUPERACAO DE AREA DEGRADADA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '532,5', 'LAVRA DE ROCHA ORNAMENTAL (GRANITO/BASALTO/TALCO/ETC) - A CEU ABERTO, SEM BENEFICIAMENTO E COM RECUPERACAO DE AREA DEGRADADA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '532,6', 'LAVRA DE ROCHA PARA USO IMEDIATO EM CONSTRUCAO CIVIL - A CEU ABERTO, SEM BENEFICIAMENTO E COM RECUPERACAO DE AREA DEGRADADA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '532,7', 'LAVRA ARTESANAL DE ROCHA PARA USO IMEDIATO EM CONSTRUCAO CIVIL - A CEU ABERTO, SEM BENEFICIAMENTO E COM RECUPERACAO DE AREA DEGRADADA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '534,2', 'LAVRA DE AREIA - A CEU ABERTO, SEM BENEFICIAMENTO, FORA DE RECURSO HIDRICO E COM RECUPERACAO DE AREA DEGRADADA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '534,3', 'LAVRA DE SAIBRO - A CEU ABERTO, SEM BENEFICIAMENTO, FORA DE RECURSO HIDRICO E COM RECUPERACAO DE AREA DEGRADADA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '534,4', 'LAVRA DE ARGILA - A CEU ABERTO, SEM BENEFICIAMENTO, FORA DE RECURSO HIDRICO E COM RECUPERACAO DE AREA DEGRADADA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1010,1', 'BENEFICIAMENTO DE MINERAIS NAO-METALICOS, COM TINGIMENTO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1010,21', 'BRITAGEM', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1030,1', 'FABRICACAO DE TELHAS/TIJOLOS/OUTROS ARTIGOS DE BARRO COZIDO, COM TINGIMENTO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1040,1', 'FABRICACAO DE MATERIAL CERAMICO EM GERAL', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1040,2', 'FABRICACAO DE ARTEFATOS DE PORCELANA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1040,3', 'FABRICACAO DE MATERIAL REFRATARIO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1051', 'FABRICACAO DE PECAS/ORNATOS/ESTRUTURAS/PRE-MOLDADOS DE CIMENTO, CONCRETO, GESSO', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1052', 'FABRICACAO DE ARGAMASSA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1053', 'USINA DE PRODUCAO DE CONCRETO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1060,1', 'ELABORACAO DE VIDRO E CRISTAL', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1060,2', 'FABRICACAO DE ARTEFATOS DE VIDRO E CRISTAL', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1061,2', 'FABRICACAO DE ARTEFATOS DE FIBRA DE VIDRO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1062', 'FABRICACAO DE ESPELHOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1110,1', 'FABRICACAO DE ACO E PRODUTOS SIDERURGICOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1110,2', 'FABRICACAO DE OUTROS METAIS E SUAS LIGAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1110,21', 'METALURGIA DOS METAIS PRECIOSOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1111,1', 'FABRICACAO DE LAMINADOS/LIGAS/ARTEFATOS DE METAIS NAO FERROSOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1111,2', 'RELAMINACAO DE METAIS NAO FERROSOS, INCLUSIVE LIGAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1111,3', 'PRODUCAO DE SOLDAS E ANODOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1112,1', 'PRODUCAO DE FUNDIDOS DE FERRO E ACO/FORJADOS/ARAMES/RELAMINADOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1112,2', 'PRODUCAO DE FUNDIDOS DE OUTROS METAIS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1112,21', 'PRODUCAO DE FUNDIDOS DE ALUMINIO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1112,22', 'PRODUCAO DE FUNDIDOS DE CHUMBO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1113', 'METALURGIA DO PO, INCLUSIVE PECAS MOLDADAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1121,1', 'FABRICACAO DE ESTRUTURAS/ ARTEFATOS/ RECIPIENTES/ OUTROS METALICOS, COM TRATAMENTO DE SUPERFICIE E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1121,2', 'FABRICACAO DE ESTRUTURAS/ ARTEFATOS/ RECIPIENTES/ OUTROS METALICOS, COM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1122', 'GALVANIZACAO A FOGO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1123,1', 'FUNILARIA, ESTAMPARIA E LATOARIA, COM TRATAMENTO DE SUPERFICIE E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1123,2', 'FUNILARIA, ESTAMPARIA E LATOARIA, COM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1123,5', 'FUNILARIA, ESTAMPARIA E LATOARIA, SEM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1124,1', 'FABRICACAO DE TELAS DE ARAME E ARTEFATOS DE ARAMADOS, COM TRATAMENTO DE SUPERFICIE E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1124,2', 'FABRICACAO DE TELAS DE ARAME E ARTEFATOS DE ARAMADOS, COM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1124,5', 'FABRICACAO DE TELAS DE ARAME E ARTEFATOS DE ARAMADOS, SEM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1125,1', 'FABRICACAO DE ARTIGOS DE CUTELARIA E FERRAMENTAS MANUAIS, COM TRATAMENTO DE SUPERFICIE E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1125,2', 'FABRICACAO DE ARTIGOS DE CUTELARIA E FERRAMENTAS MANUAIS, COM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1125,5', 'FABRICACAO DE ARTIGOS DE CUTELARIA E FERRAMENTAS MANUAIS, SEM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1130', 'TEMPERA E CEMENTACAO DE ACO, RECOZIMENTO DE ARAMES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1140', 'RECUPERACAO DE EMBALAGENS METALICAS E PLASTICAS DE PRODUTOS OU RESIDUOS NÃO PERIGOSOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1210,1', 'FABRICACAO DE MAQUINAS E APARELHOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1210,2', 'FABRICACAO DE MAQUINAS E APARELHOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1210,3', 'FABRICACAO DE MAQUINAS E APARELHOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1210,4', 'FABRICACAO DE MAQUINAS E APARELHOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1210,5', 'FABRICACAO DE MAQUINAS E APARELHOS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1210,6', 'FABRICACAO DE MAQUINAS E APARELHOS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E COM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1210,7', 'FABRICACAO DE MAQUINAS E APARELHOS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1220,1', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1220,2', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1220,3', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1220,4', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1220,5', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1220,6', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E COM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1220,7', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1221', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, COM MICROFUSAO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,1', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,2', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,3', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,4', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,5', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,6', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E COM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,7', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,8', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E SEM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1224', 'FABRICACAO DE CHASSIS PARA VEICULOS AUTOMOTORES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1310,1', 'FABRICACAO DE MATERIAL ELETRICO- ELETRONICO/EQUIPAMENTOS PARA COMUNICACAO/INFORMATICA, COM TRATAMENTO SUPERFICIE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1310,2', 'FABRICACAO DE MATERIAL ELETRICO-ELETRONICO/EQUIPAMENTOS PARA COMUNICACAO/INFORMATICA, SEM TRATAMENTO SUPERFICIE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1320', 'FABRICACAO DE PILHAS/BATERIAS E OUTROS ACUMULADORES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1321', 'RECUPERACAO DE BATERIAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1330,1', 'FABRICACAO DE APARELHOS ELETRICOS E ELETRODOMESTICOS, COM TRATAMENTO DE SUPERFICIE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1330,2', 'FABRICACAO DE APARELHOS ELETRICOS E ELETRODOMESTICOS, SEM TRATAMENTO DE SUPERFICIE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1340', 'FABRICACAO DE LAMPADAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1411,1', 'FABRICACAO, MONTAGEM E REPARACAO DE AUTOMOVEIS/CAMIONETES (INCLUSIVE CABINE DUPLA)', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1411,2', 'FABRICACAO, MONTAGEM E REPARACAO DE CAMINHOES, ONIBUS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1411,3', 'FABRICACAO, MONTAGEM E REPARACAO DE MOTOS, BICICLETAS, TRICICLOS, ETC', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1411,4', 'FABRICACAO, MONTAGEM E REPARACAO DE REBOQUES E/OU TRAILLERS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1415', 'FABRICACAO, MONTAGEM E REPARACAO DE TRATORES E MAQUINAS DE TERRAPLANAGEM', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1520,2', 'SECAGEM DE MADEIRA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1520,3', 'OUTROS BENEFICIAMENTOS E/OU TRATAMENTOS DE MADEIRA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1540', 'FABRICACAO DE ARTEFATOS/ ESTRUTURAS DE MADEIRA (EXCETO MOVEIS)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1540,1', 'FABRICACAO DE ARTEFATOS DE CORTICA', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1611,1', 'FABRICACAO DE MOVEIS DE MADEIRA/ BAMBU/ VIME/ JUNCO, COM ACESSORIOS DE METAL, COM TRATAMENTO DE SUPERFICIE E COM PINTURA (EXCETO A PINCEL)', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1611,2', 'FABRICACAO DE MOVEIS DE MADEIRA/ BAMBU/ VIME/ JUNCO, COM ACESSORIOS DE METAL, COM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1611,3', 'FABRICACAO DE MOVEIS DE MADEIRA/ BAMBU/ VIME/ JUNCO, COM ACESSORIOS DE METAL, SEM TRATAMENTO DE SUPERFICIE E COM PINTURA (EXCETO A PINCEL)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1611,4', 'FABRICACAO DE MOVEIS DE MADEIRA/ BAMBU/ VIME/ JUNCO, COM ACESSORIOS DE METAL, SEM TRATAMENTO DE SUPERFICIE E COM PINTURA A PINCEL', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1611,5', 'FABRICACAO DE MOVEIS DE MADEIRA/ BAMBU/ VIME/ JUNCO, COM ACESSORIOS DE METAL, SEM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1612,1', 'FABRICACAO DE MOVEIS DE MADEIRA/ BAMBU/ VIME/ JUNCO, SEM ACESSORIOS DE METAL, COM PINTURA (EXCETO A PINCEL)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1612,2', 'FABRICACAO DE MOVEIS DE MADEIRA/ BAMBU/ VIME/ JUNCO, SEM ACESSORIOS DE METAL, COM PINTURA A PINCEL', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1620,1', 'FABRICACAO DE MOVEIS DE METAL, COM TRATAMENTO DE SUPERFICIE E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1620,2', 'FABRICACAO DE MOVEIS DE METAL, COM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1620,3', 'FABRICACAO DE MOVEIS DE METAL, SEM TRATAMENTO DE SUPERFICIE E COM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1630,1', 'FABRICACAO DE MOVEIS MOLDADOS DE MATERIAL PLASTICO, COM TRATAMENTO DE SUPERFICIE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1630,2', 'FABRICACAO DE MOVEIS MOLDADOS DE MATERIAL PLASTICO, SEM TRATAMENTO DE SUPERFICIE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1640,1', 'FABRICACAO DE COLCHOES', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1640,2', 'FABRICACAO DE ESTOFADOS', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1710', 'FABRICACAO DE CELULOSE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1720', 'FABRICACAO DE PAPEL, PAPELAO, CARTOLINA E CARTAO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1721,1', 'FABRICACAO DE ARTEFATOS DE PAPEL/ PAPELAO/ CARTOLINA/ CARTAO, COM OPERACOES MOLHADAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1721,21', 'FABRICACAO DE ARTEFATOS DE PAPEL/ PAPELAO/ CARTOLINA/ CARTAO, COM OPERACOES SECAS, COM IMPRESSAO GRAFICA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1730', 'FABRICACAO DE ARTIGOS DIVERSOS DE FIBRA PRENSADA OU ISOLANTE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1810', 'BENEFICIAMENTO DE BORRACHA NATURAL', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1820', 'FABRICACAO DE ARTIGOS/ ARTEFATOS DIVERSOS DE BORRACHA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1820,1', 'FABRICACAO DE PNEUMATICO/ CAMARA DE AR', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1820,2', 'FABRICACAO DE LAMINADOS E FIOS DE BORRACHA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1820,3', 'FABRICACAO DE ESPUMA DE BORRACHA/ ARTEFATOS DE ESPUMA DE BORRACHA, INCLUSIVE LATEX', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1830', 'RECUPERACAO DE SUCATA DE BORRACHA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1840', 'RECONDICIONAMENTO DE PNEUMATICOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1921,11', 'CURTIMENTO DE PELES BOVINAS/ SUINAS/ CAPRINAS E EQUINAS - CURTUME COMPLETO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1921,12', 'CURTIMENTO DE PELES BOVINAS/ SUINAS/ CAPRINAS E EQUINAS - ATE WET BLUE OU ATANADO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1921,2', 'CURTIMENTO DE PELE OVINA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1922,1', 'ACABAMENTO DE COUROS, A PARTIR DE WET BLUE OU ATANADO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1922,2', 'ACABAMENTO DE COUROS, A PARTIR DE COURO SEMI-ACABADO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1930', 'FABRICACAO DE COLA ANIMAL', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1940,1', 'FABRICACAO DE OSSOS PARA CAES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2020,2', 'FABRICACAO DE CONCENTRADO AROMATICO NATURAL/ ARTIFICIAL/ SINTETICO/ MESCLA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2020,4', 'FABRICACAO DE FERTILIZANTES E AGROQUIMICOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2020,41', 'MISTURA DE FERTILIZANTES', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2020,5', 'FABRICACAO DE ALCOOL ETILICO, METANOL E SIMILARES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2021', 'FRACIONAMENTO DE PRODUTOS QUIMICOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2063', 'PRODUCAO DE RESINAS DE MADEIRA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2064', 'EXTRACAO DE TANINO VEGETAL', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2065,1', 'USINA DE ASFALTO E CONCRETO ASFALTICO, A QUENTE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2065,2', 'USINA DE ASFALTO E CONCRETO ASFALTICO, A FRIO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2068', 'MISTURA DE GRAXAS LUBRIFICANTES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2070', 'FABRICACAO DE RESINAS/ ADESIVOS/ FIBRAS/ FIOS ARTIFICIAIS E SINTETICOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2080', 'FABRICACAO DE TINTA ESMALTE/ LACA/ VERNIZ/ IMPERMEABILIZANTE/ SOLVENTE/ SECANTE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2080,1', 'FABRICACAO DE TINTA COM PROCESSAMENTO A SECO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2090', 'FABRICACAO DE COMBUSTIVEIS NAO DERIVADOS DO PETROLEO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2110', 'FABRICACAO DE PRODUTOS FARMACEUTICOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2110,1', 'FABRICACAO DE PRODUTOS DE HIGIENE PESSOAL DESCARTAVEIS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2120', 'FABRICACAO DE PRODUTOS VETERINARIOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2210', 'FABRICACAO DE PRODUTOS DE PERFUMARIA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2210,1', 'FABRICACAO DE COSMETICOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2220,1', 'FABRICACAO DE SABOES, COM EXTRACAO DE LANOLINA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2220,2', 'FABRICACAO DE SABOES, SEM EXTRACAO DE LANOLINA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2221', 'FABRICACAO DE SEBO INDUSTRIAL', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2230', 'FABRICACAO DE DETERGENTES', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2310,1', 'FABRICACAO DE ARTEFATOS DE MATERIAL PLASTICO, COM TRATAMENTO DE SUPERFICIE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2310,2', 'FABRICACAO DE ARTEFATOS DE MATERIAL PLASTICO, SEM TRATAMENTO DE SUPERFICIE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2310,21', 'FABRICACAO DE ARTEFATOS DE MATERIAL PLASTICO, SEM TRATAMENTO DE SUPERFICIE, COM IMPRESSAO GRAFICA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2310,22', 'FABRICACAO DE ARTEFATOS DE MATERIAL PLASTICO, SEM TRATAMENTO DE SUPERFICIE, SEM IMPRESSAO GRAFICA', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2320', 'FABRICACAO DE CANOS, TUBOS E CONEXOES PLASTICAS', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2330', 'FABRICACAO DE PRODUTOS ACRILICOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2340', 'FABRICACAO DE LAMINADOS PLASTICOS', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2411,1', 'BENEFICIAMENTO DE FIBRAS TEXTEIS VEGETAIS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2411,2', 'BENEFICIAMENTO DE FIBRAS TEXTEIS ARTIFICIAIS/ SINTETICAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2412,1', 'BENEFICIAMENTO DE MATERIAS TEXTEIS DE ORIGEM ANIMAL, COM LAVAGEM DE LA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2412,2', 'BENEFICIAMENTO DE MATERIAS TEXTEIS DE ORIGEM ANIMAL, SEM LAVAGEM DE LA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2420,1', 'FIACAO E/OU TECELAGEM, COM TINGIMENTO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2430,1', 'FABRICACAO DE TECIDOS ESPECIAIS, COM TINGIMENTO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2430,2', 'FABRICACAO DE TECIDOS ESPECIAIS, SEM TINGIMENTO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2510', 'FABRICACAO DE CALCADOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2511,1', 'FABRICACAO DE ARTEFATOS/COMPONENTES PARA CALCADOS, COM TRATAMENTO DE SUPERFICIE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2511,2', 'FABRICACAO DE ARTEFATOS/COMPONENTES PARA CALCADOS, SEM TRATAMENTO DE SUPERFICIE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2611,1', 'SECAGEM DE ARROZ', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2611,2', 'SECAGEM DE OUTROS GRAOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2612', 'MOAGEM DE GRAOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2612,1', 'MOINHO DE TRIGO E/OU MILHO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2612,2', 'MOINHO DE OUTROS GRAOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2613,1', 'TORREFACAO E MOAGEM DE CAFE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2614,12', 'ENGENHO DE ARROZ SEM PARBOILIZACAO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2615', 'OUTRAS OPERACOES DE BENEFICIAMENTO DE GRAOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,11', 'MATADOUROS/ ABATEDOUROS DE BOVINOS, COM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,12', 'MATADOUROS/ ABATEDOUROS DE BOVINOS, SEM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,21', 'MATADOUROS/ ABATEDOUROS DE SUINOS, COM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,22', 'MATADOUROS/ ABATEDOUROS DE SUINOS, SEM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,31', 'MATADOUROS/ ABATEDOUROS DE AVES E/OU COELHOS, COM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,32', 'MATADOUROS/ ABATEDOUROS DE AVES E/OU COELHOS, SEM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,41', 'MATADOUROS/ ABATEDOUROS DE BOVINOS E SUINOS, COM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,42', 'MATADOUROS/ ABATEDOUROS DE BOVINOS E SUINOS, SEM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,51', 'MATADOUROS/ ABATEDOUROS DE OUTROS ANIMAIS, COM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,52', 'MATADOUROS/ ABATEDOUROS DE OUTROS ANIMAIS, SEM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2622,1', 'FABRICACAO DE DERIVADOS DE ORIGEM ANIMAL E FRIGORIFICOS SEM ABATE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2622,3', 'PREPARACAO DE CONSERVAS DE CARNE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2622,5', 'BENEFICIAMENTO DE TRIPAS ANIMAIS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2623,2', 'FABRICACAO DE RACAO BALANCEADA/ FARINHA DE OSSO/ PENA/ ALIMENTOS PARA ANIMAIS, SEM COZIMENTO E/OU SEM DIGESTAO (SOMENTE MISTURA)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2624,1', 'PREPARACAO DE PESCADO/ FABRICACAO DE CONSERVAS DE PESCADO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2624,2', 'SALGAMENTO DE PESCADO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2625,1', 'BENEFICIAMENTO E INDUSTRIALIZACAO DE LEITE E SEUS DERIVADOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2625,2', 'FABRICACAO DE QUEIJOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2625,3', 'PREPARACAO DE LEITE, INCLUSIVE PASTEURIZACAO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2625,4', 'POSTO DE RESFRIAMENTO DE LEITE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2631,1', 'FABRICACAO DE ACUCAR REFINADO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2632,1', 'FABRICACAO DE DOCES EM PASTA, CRISTALIZADOS, EM BARRA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2632,2', 'FABRICACAO DE SORVETES/ BOLOS E TORTAS GELADAS/ COBERTURAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2632,3', 'FABRICACAO DE BALAS/ CARAMELOS/ PASTILHAS/ DROPES/ BOMBONS/ CHOCOLATES/ GOMAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2640', 'FABRICACAO DE MASSAS ALIMENTICIAS (INCLUSIVE PAES), BOLACHAS E BISCOITOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2652,1', 'FABRICACAO DE VINAGRE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2653', 'FABRICACAO DE FERMENTOS E LEVEDURAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2670,1', 'FABRICACAO DE PROTEINA TEXTURIZADA E HIDROLIZADA DE SOJA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2670,2', 'FABRICACAO DE PROTEINA TEXTURIZADA DE SOJA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2670,3', 'FABRICACAO DE PROTEINA HIDROLIZADA DE SOJA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2680,1', 'SELECAO E LAVAGEM DE OVOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2680,2', 'SELECAO E LAVAGEM DE FRUTAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2680,3', 'LAVAGEM DE LEGUMES E/OU VERDURAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2691', 'PREPARACAO DE REFEICOES INDUSTRIAIS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2692,1', 'FABRICACAO DE ERVA-MATE', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2693', 'FABRICACAO DE PRODUTOS DERIVADOS DA MANDIOCA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2695', 'FABRICACAO DE GELATINA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2710,1', 'FABRICACAO DE CERVEJA/ CHOPE/ MALTE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2710,2', 'FABRICACAO DE VINHOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2710,3', 'FABRICACAO DE AGUARDENTE/ LICORES/ OUTROS DESTILADOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2710,4', 'FABRICACAO DE OUTRAS BEBIDAS ALCOOLICAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2720,1', 'FABRICACAO DE REFRIGERANTES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2720,2', 'CONCENTRADORAS DE SUCO DE FRUTAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2720,3', 'FABRICACAO DE OUTRAS BEBIDAS NAO ALCOOLICAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2730', 'ENGARRAFAMENTO DE BEBIDAS, INCLUSIVE ENGARRAFAMENTO E GASEIFICACAO DE AGUA MINERAL, COM OU SEM LAVAGEM DE GARRAFAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2810', 'PREPARACAO DO FUMO/ FABRICACAO DE CIGARRO/ CHARUTO/ CIGARRILHAS/ ETC', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2820', 'CONSERVACAO DO FUMO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2910', 'CONFECCAO DE MATERIAL IMPRESSO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3001,1', 'FABRICACAO DE JOIAS/ BIJUTERIAS, COM TRATAMENTO DE SUPERFICIE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3001,2', 'FABRICACAO DE JOIAS/ BIJUTERIAS, SEM TRATAMENTO DE SUPERFICIE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3002,1', 'FABRICACAO DE ENFEITES DIVERSOS, COM TRATAMENTO DE SUPERFICIE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3002,2', 'FABRICACAO DE ENFEITES DIVERSOS, SEM TRATAMENTO DE SUPERFICIE', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3003,1', 'FABRICACAO DE INSTRUMENTOS DE PRECISAO NAO ELETRICOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3003,2', 'FABRICACAO DE APARELHOS PARA USO MEDICO, ODONTOLOGICO E CIRURGICO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3003,21', 'FABRICACAO DE APARELHOS ORTOPEDICOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3003,3', 'FABRICACAO DE APARELHOS E MATERIAIS FOTOGRAFICOS E/OU CINEMATOGRAFICOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3003,4', 'FABRICACAO DE INSTRUMENTOS MUSICAIS E FITAS MAGNETICAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3003,5', 'FABRICACAO DE EXTINTORES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3003,6', 'FABRICACAO DE OUTROS APARELHOS E INSTRUMENTOS NAO ESPECIFICADOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3004', 'FABRICACAO DE ESCOVAS, PINCEIS, VASSOURAS, ETC', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3005', 'FABRICACAO DE CORDAS/ CORDOES E CABOS', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3007,1', 'LAVANDERIA PARA ROUPAS E ARTEFATOS INDUSTRIAIS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3007,2', 'LAVANDERIA PARA ROUPAS E ARTEFATOS DE USO DOMESTICO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3008', 'FABRICACAO DE ARTIGOS ESPORTIVOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3009', 'LABORATORIO DE TESTES DE PROCESSOS/ PRODUTOS INDUSTRIAIS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3010,1', 'SERVICOS DE GALVANOPLASTIA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3010,2', 'SERVICOS DE FOSFATIZACAO/ ANODIZACAO/ DECAPAGEM/ ETC, EXCETO GALVANOPLASTIA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 10, '3114,1', 'INCORPORACAO DE RESIDUO SOLIDO INDUSTRIAL CLASSE II A EM SOLO AGRICOLA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 10, '3121,4', 'INCORPORACAO DE RESIDUO SOLIDO INDUSTRIAL CLASSE II COMO MATERIA-PRIMA E/OU CARGA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 10, '3121,5', 'APLICACAO DE RESIDUO SOLIDO INDUSTRIAL CLASSE II EM SOLO AGRICOLA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 10, '3122,1', 'PROCESSAMENTO DE RESIDUO SOLIDO INDUSTRIAL CLASSE I', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 11, '3122,2', 'PROCESSAMENTO DE RESIDUO SOLIDO INDUSTRIAL CLASSE II A', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 10, '3126', 'RECICLAGEM DE RESIDUO SOLIDO INDUSTRIAL CLASSE II', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 12, '3412', 'CEMITERIO', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 13, '3412,1', 'CREMATORIO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '3413,11', 'CAMPUS UNIVERSITARIO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '3414,11', 'LOTEAMENTO RESIDENCIAL - CONDOMINIO UNIFAMILIAR', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '3414,12', 'LOTEAMENTO RESIDENCIAL - CONDOMINIO PLURIFAMILIAR', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '3414,2', 'SITIOS DE LAZER', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '3414,3', 'DESMEMBRAMENTO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 14, '3454', 'METROPOLITANOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 15, '3457', 'OBRAS DE URBANIZACAO (MURO/ CALCADA/ ACESSO/ ETC) E VIA URBANA (ABERTURA, CONSERVAÇÃO, REPARAÇÃO OU AMPLIAÇÃO)', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 16, '3458,1', 'BARRAGENS DE SANEAMENTO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 16, '3460', 'ACUDE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 15, '3462', 'CANALIZAÇÃO PARA DRENAGEM PLUVIAL URBANA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 15, '3463', 'CANALIZACAO DE CURSOS D\'AGUA NATURAL (EXCETO ATIVIDADES AGROPECUARIAS)', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 15, '3463,1', 'RETIFICAÇÃO/DESVIO DE CURSO D´AGUA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 5 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 14, '3464,1', 'PONTES', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 14, '3464,2', 'VIADUTO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 14, '3510,22', 'TRANSMISSÃO DE ENERGIA ELÉTRICA (>34,5KV)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 17, '3510,3', 'GERACAO DE ENERGIA A PARTIR DE FONTE EOLICA', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 6, '3511,1', 'SISTEMA DE ABASTECIMENTO DE AGUA COM BARRAGEM', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 18, '3511,2', 'SISTEMA DE ABASTECIMENTO DE ÁGUA SEM BARRAGEM', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 18, '3512,1', 'SISTEMAS DE ESGOTO SANITARIO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 18, '3512,2', 'TRONCOS COLETORES E EMISSARIOS DE ESGOTO DOMESTICO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 14, '3512,3', 'REDE DE ESGOTO DOMESTICO', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 19, '3513,1', 'COLETA/ TRATAMENTO CENTRALIZADO DE EFLUENTES LIQUIDOS INDUSTRIAIS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 20, '3513,2', 'APLICAÇÃO DE EFLUENTE INDUSTRIAL TRATADO EM SOLO AGRÍCOLA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 15, '3514,1', 'LIMPEZA DE CANAIS (SEM MATERIAL MINERAL)', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 5 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 21, '3514,21', 'DESASSOREAMENTO DE CURSOS D\'AGUA CORRENTE (EXCETO DE ATIVIDADES AGROPECUARIAS)', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 5 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 22, '3541,5', 'USINAS DE COMPOSTAGEM DE RSU', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 23, '3543,12', 'ATERRO COM MICROONDAS DE RSSS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 18, '3543,22', 'CENTRAIS DE TRIAGEM SEM ATERRO DE RESIDUO SOLIDO URBANO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 23, '3543,3', 'MICROONDAS DE RSSS COM ENTREPOSTO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3545', 'CLASSIFICACAO/SELECAO DE RSU ORIUNDO DE COLETA SELETIVA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 5 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3550,2', 'RECUPERACAO DE AREA DEGRADADA POR RESIDUO SOLIDO URBANO, SEM USO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '3550,4', 'ENCERRAMENTO DE ATIVIDADES EM UNID DE DESTINACAO FINAL DE RSU', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 23, '3560,2', 'TRATAMENTO DE RESIDUOS SOLIDOS DE SERVICOS DE SAUDE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 21, '3570', 'DESTINACAO DE RESIDUOS SOLIDOS PROVENIENTES DE FOSSAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 15, '4720,1', 'ATRACADOURO/PÍER/TRAPICHE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '4720,2', 'MARINA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 15, '4720,3', 'ANCORADOURO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 14, '4730,2', 'TELEFÉRICO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '4750,1', 'DEPOSITOS DE GLP (EM BOTIJÕES, SEM MANIPULAÇÃO, CODIGO ONU 1075)', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 24, '4750,51', 'POSTO DE ABASTECIMENTO PROPRIO COM TANQUES SUBTERRANEOS (DEPOSITO DE COMBUSTIVEIS)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 5 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 24, '4750,52', 'POSTO DE ABASTECIMENTO PROPRIO COM TANQUES AEREOS (DEPOSITO DE COMBUSTIVEIS) > 15 M3', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 5 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '4751,5', 'DEPOSITO/COMERCIO DE OLEOS USADOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 5 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '6111', 'AREA DE LAZER (CAMPING/BALNEÁRIO/PARQUE TEMÁTICO)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '6112,1', 'AUTODROMO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '6112,2', 'KARTODROMO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '6112,3', 'PISTA DE MOTOCROSS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



delete from atividadeimpactoporte;
delete from atividadeimpacto;
select setval('atividadeimpacto_am03_sequencial_seq',1);
select setval('atividadeimpactoporte_am04_sequencial_seq',1);
insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 1, '111,3', 'IRRIGACAO SUPERFICIAL', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 1, '111,4', 'IRRIGACAO POR ASPERSAO/LOCALIZADA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 2, '111,7', 'RECUPERACAO DE AREA DEGRADADA POR IRRIGACAO', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 1, '111,92', 'FORNECIMENTO DE AGUA DE RECURSOS HIDRICOS NATURAIS SUPERFICIAIS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '112,11', 'CRIACAO DE AVES DE CORTE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '112,12', 'CRIACAO DE AVES DE POSTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '112,13', 'CRIACAO DE MATRIZES E OVOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 4, '112,14', 'INCUBATORIO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '112,21', 'CUNICULTURA E OUTROS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 5, '114,21', 'CRIACAO DE SUINOS - CICLO COMPLETO - COM MANEJO DEJETOS LIQUIDOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 5, '114,22', 'CRIACAO DE SUINOS - UNIDADE PRODUTORA DE LEITOES ATE 21 DIAS - COM MANEJO DEJETOS LIQUIDOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 5, '114,23', 'CRIACAO DE SUINOS - UNIDADE PRODUTORA DE LEITOES ATE 63 DIAS - COM MANEJO DEJETOS LIQUIDOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '114,24', 'CRIACAO DE SUINOS - TERMINACAO - COM MANEJO DEJETOS LIQUIDOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '114,25', 'CRIACAO DE SUINOS - CRECHE - COM MANEJO DEJETOS LIQUIDOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '114,26', 'CRIACAO DE SUINOS - CENTRAL DE INSEMINACAO - COM MANEJO DEJETOS LIQUIDOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 5, '114,31', 'CRIACAO DE SUINOS - CICLO COMPLETO - COM MANEJO DE DEJETOS SOBRE CAMAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 5, '114,32', 'CRIACAO DE SUINOS - UNIDADE PRODUTORA DE LEITOES ATE 21 DIAS - COM MANEJO DE DEJETOS SOBRE CAMAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 5, '114,33', 'CRIACAO DE SUINOS - UNIDADE PRODUTORA DE LEITOES ATE 63 DIAS - COM MANEJO DE DEJETOS SOBRE CAMAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '114,34', 'CRIACAO DE SUINOS - TERMINACAO - COM MANEJO DE DEJETOS SOBRE CAMAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '114,35', 'CRIACAO DE SUINOS - CRECHE - COM MANEJO DE DEJETOS SOBRE CAMAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '114,36', 'CRIACAO DE SUINOS - CENTRAL DE INSEMINACAO - COM MANEJO DE DEJETOS SOBRE CAMAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '114,9', 'CRIACAO DE OUTROS ANIMAIS DE MEDIO PORTE CONFINADOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '116,1', 'CRIACAO DE BOVINOS CONFINADOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 3, '117,1', 'CRIACAO DE BOVINOS (SEMI-EXTENSIVO)', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 6, '119,21', 'PISCICULTURA DE ESPECIES NATIVAS PARA ENGORDA (SISTEMA INTENSIVO)', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 6, '119,22', 'PISCICULTURA DE ESPECIES EXOTICAS PARA ENGORDA (SISTEMA INTENSIVO)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 6, '119,31', 'PISCICULTURA DE ESPECIES NATIVAS (SISTEMA SEMI-INTENSIVO)', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 6, '119,32', 'PISCICUTURA DE ESPECIES EXOTICAS (SISTEMA SEMI-INTENSIVO)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 6, '119,41', 'PISCICULTURA DE ESPECIES NATIVAS (SISTEMA EXTENSIVO)', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 6, '119,42', 'PISCICULTURA DE ESPECIES EXOTICAS (SISTEMA EXTENSIVO)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '510', 'PESQUISA MINERAL', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '520', 'RECUPERACAO DE AREAS MINERADAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '531,5', 'LAVRA DE ROCHA ORNAMENTAL (GRANITO/BASALTO/TALCO/ETC) - A CEU ABERTO, COM BENEFICIAMENTO E COM RECUPERACAO DE AREA DEGRADADA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '531,6', 'LAVRA DE ROCHA PARA USO IMEDIATO NA CONSTRUCAO CIVIL - A CEU ABERTO, COM BENEFICIAMENTO E COM RECUPERACAO DE AREA DEGRADADA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '531,7', 'LAVRA DE AREIA INDUSTRIAL - A CEU ABERTO, COM BENEFICIAMENTO E COM RECUPERACAO DE AREA DEGRADADA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '532,5', 'LAVRA DE ROCHA ORNAMENTAL (GRANITO/BASALTO/TALCO/ETC) - A CEU ABERTO, SEM BENEFICIAMENTO E COM RECUPERACAO DE AREA DEGRADADA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '532,6', 'LAVRA DE ROCHA PARA USO IMEDIATO EM CONSTRUCAO CIVIL - A CEU ABERTO, SEM BENEFICIAMENTO E COM RECUPERACAO DE AREA DEGRADADA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '532,7', 'LAVRA ARTESANAL DE ROCHA PARA USO IMEDIATO EM CONSTRUCAO CIVIL - A CEU ABERTO, SEM BENEFICIAMENTO E COM RECUPERACAO DE AREA DEGRADADA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '534,2', 'LAVRA DE AREIA - A CEU ABERTO, SEM BENEFICIAMENTO, FORA DE RECURSO HIDRICO E COM RECUPERACAO DE AREA DEGRADADA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '534,3', 'LAVRA DE SAIBRO - A CEU ABERTO, SEM BENEFICIAMENTO, FORA DE RECURSO HIDRICO E COM RECUPERACAO DE AREA DEGRADADA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 7, '534,4', 'LAVRA DE ARGILA - A CEU ABERTO, SEM BENEFICIAMENTO, FORA DE RECURSO HIDRICO E COM RECUPERACAO DE AREA DEGRADADA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1010,1', 'BENEFICIAMENTO DE MINERAIS NAO-METALICOS, COM TINGIMENTO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1010,21', 'BRITAGEM', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1030,1', 'FABRICACAO DE TELHAS/TIJOLOS/OUTROS ARTIGOS DE BARRO COZIDO, COM TINGIMENTO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1040,1', 'FABRICACAO DE MATERIAL CERAMICO EM GERAL', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1040,2', 'FABRICACAO DE ARTEFATOS DE PORCELANA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1040,3', 'FABRICACAO DE MATERIAL REFRATARIO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1051', 'FABRICACAO DE PECAS/ORNATOS/ESTRUTURAS/PRE-MOLDADOS DE CIMENTO, CONCRETO, GESSO', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1052', 'FABRICACAO DE ARGAMASSA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1053', 'USINA DE PRODUCAO DE CONCRETO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1060,1', 'ELABORACAO DE VIDRO E CRISTAL', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1060,2', 'FABRICACAO DE ARTEFATOS DE VIDRO E CRISTAL', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1061,2', 'FABRICACAO DE ARTEFATOS DE FIBRA DE VIDRO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1062', 'FABRICACAO DE ESPELHOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1110,1', 'FABRICACAO DE ACO E PRODUTOS SIDERURGICOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1110,2', 'FABRICACAO DE OUTROS METAIS E SUAS LIGAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1110,21', 'METALURGIA DOS METAIS PRECIOSOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1111,1', 'FABRICACAO DE LAMINADOS/LIGAS/ARTEFATOS DE METAIS NAO FERROSOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1111,2', 'RELAMINACAO DE METAIS NAO FERROSOS, INCLUSIVE LIGAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1111,3', 'PRODUCAO DE SOLDAS E ANODOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1112,1', 'PRODUCAO DE FUNDIDOS DE FERRO E ACO/FORJADOS/ARAMES/RELAMINADOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1112,2', 'PRODUCAO DE FUNDIDOS DE OUTROS METAIS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1112,21', 'PRODUCAO DE FUNDIDOS DE ALUMINIO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1112,22', 'PRODUCAO DE FUNDIDOS DE CHUMBO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1113', 'METALURGIA DO PO, INCLUSIVE PECAS MOLDADAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1121,1', 'FABRICACAO DE ESTRUTURAS/ ARTEFATOS/ RECIPIENTES/ OUTROS METALICOS, COM TRATAMENTO DE SUPERFICIE E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1121,2', 'FABRICACAO DE ESTRUTURAS/ ARTEFATOS/ RECIPIENTES/ OUTROS METALICOS, COM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1122', 'GALVANIZACAO A FOGO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1123,1', 'FUNILARIA, ESTAMPARIA E LATOARIA, COM TRATAMENTO DE SUPERFICIE E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1123,2', 'FUNILARIA, ESTAMPARIA E LATOARIA, COM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1123,5', 'FUNILARIA, ESTAMPARIA E LATOARIA, SEM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1124,1', 'FABRICACAO DE TELAS DE ARAME E ARTEFATOS DE ARAMADOS, COM TRATAMENTO DE SUPERFICIE E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1124,2', 'FABRICACAO DE TELAS DE ARAME E ARTEFATOS DE ARAMADOS, COM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1124,5', 'FABRICACAO DE TELAS DE ARAME E ARTEFATOS DE ARAMADOS, SEM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1125,1', 'FABRICACAO DE ARTIGOS DE CUTELARIA E FERRAMENTAS MANUAIS, COM TRATAMENTO DE SUPERFICIE E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1125,2', 'FABRICACAO DE ARTIGOS DE CUTELARIA E FERRAMENTAS MANUAIS, COM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1125,5', 'FABRICACAO DE ARTIGOS DE CUTELARIA E FERRAMENTAS MANUAIS, SEM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1130', 'TEMPERA E CEMENTACAO DE ACO, RECOZIMENTO DE ARAMES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1140', 'RECUPERACAO DE EMBALAGENS METALICAS E PLASTICAS DE PRODUTOS OU RESIDUOS NÃO PERIGOSOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1210,1', 'FABRICACAO DE MAQUINAS E APARELHOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1210,2', 'FABRICACAO DE MAQUINAS E APARELHOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1210,3', 'FABRICACAO DE MAQUINAS E APARELHOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1210,4', 'FABRICACAO DE MAQUINAS E APARELHOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1210,5', 'FABRICACAO DE MAQUINAS E APARELHOS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1210,6', 'FABRICACAO DE MAQUINAS E APARELHOS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E COM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1210,7', 'FABRICACAO DE MAQUINAS E APARELHOS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1220,1', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1220,2', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1220,3', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1220,4', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1220,5', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1220,6', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E COM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1220,7', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1221', 'FABRICACAO DE UTENSILIOS, PECAS E ACESSORIOS, COM MICROFUSAO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,1', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,2', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,3', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,4', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, COM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,5', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,6', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E COM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,7', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, COM FUNDICAO E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1222,8', 'FABRICACAO DE AUTOPECAS/MOTOPECAS, SEM TRATAMENTO SUPERFICIE INCLUSIVE TRATAMENTO TERMICO, SEM FUNDICAO E SEM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1224', 'FABRICACAO DE CHASSIS PARA VEICULOS AUTOMOTORES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1310,1', 'FABRICACAO DE MATERIAL ELETRICO- ELETRONICO/EQUIPAMENTOS PARA COMUNICACAO/INFORMATICA, COM TRATAMENTO SUPERFICIE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1310,2', 'FABRICACAO DE MATERIAL ELETRICO-ELETRONICO/EQUIPAMENTOS PARA COMUNICACAO/INFORMATICA, SEM TRATAMENTO SUPERFICIE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1320', 'FABRICACAO DE PILHAS/BATERIAS E OUTROS ACUMULADORES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1321', 'RECUPERACAO DE BATERIAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1330,1', 'FABRICACAO DE APARELHOS ELETRICOS E ELETRODOMESTICOS, COM TRATAMENTO DE SUPERFICIE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1330,2', 'FABRICACAO DE APARELHOS ELETRICOS E ELETRODOMESTICOS, SEM TRATAMENTO DE SUPERFICIE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1340', 'FABRICACAO DE LAMPADAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1411,1', 'FABRICACAO, MONTAGEM E REPARACAO DE AUTOMOVEIS/CAMIONETES (INCLUSIVE CABINE DUPLA)', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1411,2', 'FABRICACAO, MONTAGEM E REPARACAO DE CAMINHOES, ONIBUS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1411,3', 'FABRICACAO, MONTAGEM E REPARACAO DE MOTOS, BICICLETAS, TRICICLOS, ETC', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1411,4', 'FABRICACAO, MONTAGEM E REPARACAO DE REBOQUES E/OU TRAILLERS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1415', 'FABRICACAO, MONTAGEM E REPARACAO DE TRATORES E MAQUINAS DE TERRAPLANAGEM', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1520,2', 'SECAGEM DE MADEIRA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1520,3', 'OUTROS BENEFICIAMENTOS E/OU TRATAMENTOS DE MADEIRA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1540', 'FABRICACAO DE ARTEFATOS/ ESTRUTURAS DE MADEIRA (EXCETO MOVEIS)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1540,1', 'FABRICACAO DE ARTEFATOS DE CORTICA', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1611,1', 'FABRICACAO DE MOVEIS DE MADEIRA/ BAMBU/ VIME/ JUNCO, COM ACESSORIOS DE METAL, COM TRATAMENTO DE SUPERFICIE E COM PINTURA (EXCETO A PINCEL)', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1611,2', 'FABRICACAO DE MOVEIS DE MADEIRA/ BAMBU/ VIME/ JUNCO, COM ACESSORIOS DE METAL, COM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1611,3', 'FABRICACAO DE MOVEIS DE MADEIRA/ BAMBU/ VIME/ JUNCO, COM ACESSORIOS DE METAL, SEM TRATAMENTO DE SUPERFICIE E COM PINTURA (EXCETO A PINCEL)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1611,4', 'FABRICACAO DE MOVEIS DE MADEIRA/ BAMBU/ VIME/ JUNCO, COM ACESSORIOS DE METAL, SEM TRATAMENTO DE SUPERFICIE E COM PINTURA A PINCEL', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1611,5', 'FABRICACAO DE MOVEIS DE MADEIRA/ BAMBU/ VIME/ JUNCO, COM ACESSORIOS DE METAL, SEM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1612,1', 'FABRICACAO DE MOVEIS DE MADEIRA/ BAMBU/ VIME/ JUNCO, SEM ACESSORIOS DE METAL, COM PINTURA (EXCETO A PINCEL)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1612,2', 'FABRICACAO DE MOVEIS DE MADEIRA/ BAMBU/ VIME/ JUNCO, SEM ACESSORIOS DE METAL, COM PINTURA A PINCEL', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1620,1', 'FABRICACAO DE MOVEIS DE METAL, COM TRATAMENTO DE SUPERFICIE E COM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1620,2', 'FABRICACAO DE MOVEIS DE METAL, COM TRATAMENTO DE SUPERFICIE E SEM PINTURA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1620,3', 'FABRICACAO DE MOVEIS DE METAL, SEM TRATAMENTO DE SUPERFICIE E COM PINTURA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1630,1', 'FABRICACAO DE MOVEIS MOLDADOS DE MATERIAL PLASTICO, COM TRATAMENTO DE SUPERFICIE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1630,2', 'FABRICACAO DE MOVEIS MOLDADOS DE MATERIAL PLASTICO, SEM TRATAMENTO DE SUPERFICIE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1640,1', 'FABRICACAO DE COLCHOES', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1640,2', 'FABRICACAO DE ESTOFADOS', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1710', 'FABRICACAO DE CELULOSE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1720', 'FABRICACAO DE PAPEL, PAPELAO, CARTOLINA E CARTAO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1721,1', 'FABRICACAO DE ARTEFATOS DE PAPEL/ PAPELAO/ CARTOLINA/ CARTAO, COM OPERACOES MOLHADAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1721,21', 'FABRICACAO DE ARTEFATOS DE PAPEL/ PAPELAO/ CARTOLINA/ CARTAO, COM OPERACOES SECAS, COM IMPRESSAO GRAFICA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1730', 'FABRICACAO DE ARTIGOS DIVERSOS DE FIBRA PRENSADA OU ISOLANTE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1810', 'BENEFICIAMENTO DE BORRACHA NATURAL', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1820', 'FABRICACAO DE ARTIGOS/ ARTEFATOS DIVERSOS DE BORRACHA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1820,1', 'FABRICACAO DE PNEUMATICO/ CAMARA DE AR', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1820,2', 'FABRICACAO DE LAMINADOS E FIOS DE BORRACHA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1820,3', 'FABRICACAO DE ESPUMA DE BORRACHA/ ARTEFATOS DE ESPUMA DE BORRACHA, INCLUSIVE LATEX', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1830', 'RECUPERACAO DE SUCATA DE BORRACHA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1840', 'RECONDICIONAMENTO DE PNEUMATICOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1921,11', 'CURTIMENTO DE PELES BOVINAS/ SUINAS/ CAPRINAS E EQUINAS - CURTUME COMPLETO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1921,12', 'CURTIMENTO DE PELES BOVINAS/ SUINAS/ CAPRINAS E EQUINAS - ATE WET BLUE OU ATANADO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1921,2', 'CURTIMENTO DE PELE OVINA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1922,1', 'ACABAMENTO DE COUROS, A PARTIR DE WET BLUE OU ATANADO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1922,2', 'ACABAMENTO DE COUROS, A PARTIR DE COURO SEMI-ACABADO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1930', 'FABRICACAO DE COLA ANIMAL', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '1940,1', 'FABRICACAO DE OSSOS PARA CAES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2020,2', 'FABRICACAO DE CONCENTRADO AROMATICO NATURAL/ ARTIFICIAL/ SINTETICO/ MESCLA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2020,4', 'FABRICACAO DE FERTILIZANTES E AGROQUIMICOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2020,41', 'MISTURA DE FERTILIZANTES', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2020,5', 'FABRICACAO DE ALCOOL ETILICO, METANOL E SIMILARES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2021', 'FRACIONAMENTO DE PRODUTOS QUIMICOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2063', 'PRODUCAO DE RESINAS DE MADEIRA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2064', 'EXTRACAO DE TANINO VEGETAL', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2065,1', 'USINA DE ASFALTO E CONCRETO ASFALTICO, A QUENTE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2065,2', 'USINA DE ASFALTO E CONCRETO ASFALTICO, A FRIO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2068', 'MISTURA DE GRAXAS LUBRIFICANTES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2070', 'FABRICACAO DE RESINAS/ ADESIVOS/ FIBRAS/ FIOS ARTIFICIAIS E SINTETICOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2080', 'FABRICACAO DE TINTA ESMALTE/ LACA/ VERNIZ/ IMPERMEABILIZANTE/ SOLVENTE/ SECANTE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2080,1', 'FABRICACAO DE TINTA COM PROCESSAMENTO A SECO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2090', 'FABRICACAO DE COMBUSTIVEIS NAO DERIVADOS DO PETROLEO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2110', 'FABRICACAO DE PRODUTOS FARMACEUTICOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2110,1', 'FABRICACAO DE PRODUTOS DE HIGIENE PESSOAL DESCARTAVEIS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2120', 'FABRICACAO DE PRODUTOS VETERINARIOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2210', 'FABRICACAO DE PRODUTOS DE PERFUMARIA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2210,1', 'FABRICACAO DE COSMETICOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2220,1', 'FABRICACAO DE SABOES, COM EXTRACAO DE LANOLINA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2220,2', 'FABRICACAO DE SABOES, SEM EXTRACAO DE LANOLINA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2221', 'FABRICACAO DE SEBO INDUSTRIAL', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2230', 'FABRICACAO DE DETERGENTES', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2310,1', 'FABRICACAO DE ARTEFATOS DE MATERIAL PLASTICO, COM TRATAMENTO DE SUPERFICIE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2310,2', 'FABRICACAO DE ARTEFATOS DE MATERIAL PLASTICO, SEM TRATAMENTO DE SUPERFICIE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2310,21', 'FABRICACAO DE ARTEFATOS DE MATERIAL PLASTICO, SEM TRATAMENTO DE SUPERFICIE, COM IMPRESSAO GRAFICA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2310,22', 'FABRICACAO DE ARTEFATOS DE MATERIAL PLASTICO, SEM TRATAMENTO DE SUPERFICIE, SEM IMPRESSAO GRAFICA', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2320', 'FABRICACAO DE CANOS, TUBOS E CONEXOES PLASTICAS', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2330', 'FABRICACAO DE PRODUTOS ACRILICOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2340', 'FABRICACAO DE LAMINADOS PLASTICOS', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2411,1', 'BENEFICIAMENTO DE FIBRAS TEXTEIS VEGETAIS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2411,2', 'BENEFICIAMENTO DE FIBRAS TEXTEIS ARTIFICIAIS/ SINTETICAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2412,1', 'BENEFICIAMENTO DE MATERIAS TEXTEIS DE ORIGEM ANIMAL, COM LAVAGEM DE LA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2412,2', 'BENEFICIAMENTO DE MATERIAS TEXTEIS DE ORIGEM ANIMAL, SEM LAVAGEM DE LA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2420,1', 'FIACAO E/OU TECELAGEM, COM TINGIMENTO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2430,1', 'FABRICACAO DE TECIDOS ESPECIAIS, COM TINGIMENTO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2430,2', 'FABRICACAO DE TECIDOS ESPECIAIS, SEM TINGIMENTO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2510', 'FABRICACAO DE CALCADOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2511,1', 'FABRICACAO DE ARTEFATOS/COMPONENTES PARA CALCADOS, COM TRATAMENTO DE SUPERFICIE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2511,2', 'FABRICACAO DE ARTEFATOS/COMPONENTES PARA CALCADOS, SEM TRATAMENTO DE SUPERFICIE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2611,1', 'SECAGEM DE ARROZ', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2611,2', 'SECAGEM DE OUTROS GRAOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2612', 'MOAGEM DE GRAOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2612,1', 'MOINHO DE TRIGO E/OU MILHO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2612,2', 'MOINHO DE OUTROS GRAOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2613,1', 'TORREFACAO E MOAGEM DE CAFE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2614,12', 'ENGENHO DE ARROZ SEM PARBOILIZACAO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2615', 'OUTRAS OPERACOES DE BENEFICIAMENTO DE GRAOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,11', 'MATADOUROS/ ABATEDOUROS DE BOVINOS, COM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,12', 'MATADOUROS/ ABATEDOUROS DE BOVINOS, SEM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,21', 'MATADOUROS/ ABATEDOUROS DE SUINOS, COM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,22', 'MATADOUROS/ ABATEDOUROS DE SUINOS, SEM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,31', 'MATADOUROS/ ABATEDOUROS DE AVES E/OU COELHOS, COM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,32', 'MATADOUROS/ ABATEDOUROS DE AVES E/OU COELHOS, SEM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,41', 'MATADOUROS/ ABATEDOUROS DE BOVINOS E SUINOS, COM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,42', 'MATADOUROS/ ABATEDOUROS DE BOVINOS E SUINOS, SEM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,51', 'MATADOUROS/ ABATEDOUROS DE OUTROS ANIMAIS, COM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2621,52', 'MATADOUROS/ ABATEDOUROS DE OUTROS ANIMAIS, SEM FABRICACAO DE EMBUTIDOS OU INDUSTRIALIZACAO DE CARNES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2622,1', 'FABRICACAO DE DERIVADOS DE ORIGEM ANIMAL E FRIGORIFICOS SEM ABATE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2622,3', 'PREPARACAO DE CONSERVAS DE CARNE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2622,5', 'BENEFICIAMENTO DE TRIPAS ANIMAIS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2623,2', 'FABRICACAO DE RACAO BALANCEADA/ FARINHA DE OSSO/ PENA/ ALIMENTOS PARA ANIMAIS, SEM COZIMENTO E/OU SEM DIGESTAO (SOMENTE MISTURA)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2624,1', 'PREPARACAO DE PESCADO/ FABRICACAO DE CONSERVAS DE PESCADO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2624,2', 'SALGAMENTO DE PESCADO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2625,1', 'BENEFICIAMENTO E INDUSTRIALIZACAO DE LEITE E SEUS DERIVADOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2625,2', 'FABRICACAO DE QUEIJOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2625,3', 'PREPARACAO DE LEITE, INCLUSIVE PASTEURIZACAO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2625,4', 'POSTO DE RESFRIAMENTO DE LEITE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2631,1', 'FABRICACAO DE ACUCAR REFINADO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2632,1', 'FABRICACAO DE DOCES EM PASTA, CRISTALIZADOS, EM BARRA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2632,2', 'FABRICACAO DE SORVETES/ BOLOS E TORTAS GELADAS/ COBERTURAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2632,3', 'FABRICACAO DE BALAS/ CARAMELOS/ PASTILHAS/ DROPES/ BOMBONS/ CHOCOLATES/ GOMAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2640', 'FABRICACAO DE MASSAS ALIMENTICIAS (INCLUSIVE PAES), BOLACHAS E BISCOITOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2652,1', 'FABRICACAO DE VINAGRE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2653', 'FABRICACAO DE FERMENTOS E LEVEDURAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2670,1', 'FABRICACAO DE PROTEINA TEXTURIZADA E HIDROLIZADA DE SOJA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2670,2', 'FABRICACAO DE PROTEINA TEXTURIZADA DE SOJA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2670,3', 'FABRICACAO DE PROTEINA HIDROLIZADA DE SOJA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2680,1', 'SELECAO E LAVAGEM DE OVOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2680,2', 'SELECAO E LAVAGEM DE FRUTAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2680,3', 'LAVAGEM DE LEGUMES E/OU VERDURAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2691', 'PREPARACAO DE REFEICOES INDUSTRIAIS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2692,1', 'FABRICACAO DE ERVA-MATE', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2693', 'FABRICACAO DE PRODUTOS DERIVADOS DA MANDIOCA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2695', 'FABRICACAO DE GELATINA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2710,1', 'FABRICACAO DE CERVEJA/ CHOPE/ MALTE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2710,2', 'FABRICACAO DE VINHOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2710,3', 'FABRICACAO DE AGUARDENTE/ LICORES/ OUTROS DESTILADOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2710,4', 'FABRICACAO DE OUTRAS BEBIDAS ALCOOLICAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2720,1', 'FABRICACAO DE REFRIGERANTES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2720,2', 'CONCENTRADORAS DE SUCO DE FRUTAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2720,3', 'FABRICACAO DE OUTRAS BEBIDAS NAO ALCOOLICAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2730', 'ENGARRAFAMENTO DE BEBIDAS, INCLUSIVE ENGARRAFAMENTO E GASEIFICACAO DE AGUA MINERAL, COM OU SEM LAVAGEM DE GARRAFAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2810', 'PREPARACAO DO FUMO/ FABRICACAO DE CIGARRO/ CHARUTO/ CIGARRILHAS/ ETC', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2820', 'CONSERVACAO DO FUMO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '2910', 'CONFECCAO DE MATERIAL IMPRESSO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3001,1', 'FABRICACAO DE JOIAS/ BIJUTERIAS, COM TRATAMENTO DE SUPERFICIE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3001,2', 'FABRICACAO DE JOIAS/ BIJUTERIAS, SEM TRATAMENTO DE SUPERFICIE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3002,1', 'FABRICACAO DE ENFEITES DIVERSOS, COM TRATAMENTO DE SUPERFICIE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3002,2', 'FABRICACAO DE ENFEITES DIVERSOS, SEM TRATAMENTO DE SUPERFICIE', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3003,1', 'FABRICACAO DE INSTRUMENTOS DE PRECISAO NAO ELETRICOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3003,2', 'FABRICACAO DE APARELHOS PARA USO MEDICO, ODONTOLOGICO E CIRURGICO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3003,21', 'FABRICACAO DE APARELHOS ORTOPEDICOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3003,3', 'FABRICACAO DE APARELHOS E MATERIAIS FOTOGRAFICOS E/OU CINEMATOGRAFICOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3003,4', 'FABRICACAO DE INSTRUMENTOS MUSICAIS E FITAS MAGNETICAS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3003,5', 'FABRICACAO DE EXTINTORES', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3003,6', 'FABRICACAO DE OUTROS APARELHOS E INSTRUMENTOS NAO ESPECIFICADOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3004', 'FABRICACAO DE ESCOVAS, PINCEIS, VASSOURAS, ETC', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3005', 'FABRICACAO DE CORDAS/ CORDOES E CABOS', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3007,1', 'LAVANDERIA PARA ROUPAS E ARTEFATOS INDUSTRIAIS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3007,2', 'LAVANDERIA PARA ROUPAS E ARTEFATOS DE USO DOMESTICO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3008', 'FABRICACAO DE ARTIGOS ESPORTIVOS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3009', 'LABORATORIO DE TESTES DE PROCESSOS/ PRODUTOS INDUSTRIAIS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3010,1', 'SERVICOS DE GALVANOPLASTIA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3010,2', 'SERVICOS DE FOSFATIZACAO/ ANODIZACAO/ DECAPAGEM/ ETC, EXCETO GALVANOPLASTIA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 10, '3114,1', 'INCORPORACAO DE RESIDUO SOLIDO INDUSTRIAL CLASSE II A EM SOLO AGRICOLA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 10, '3121,4', 'INCORPORACAO DE RESIDUO SOLIDO INDUSTRIAL CLASSE II COMO MATERIA-PRIMA E/OU CARGA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 10, '3121,5', 'APLICACAO DE RESIDUO SOLIDO INDUSTRIAL CLASSE II EM SOLO AGRICOLA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 10, '3122,1', 'PROCESSAMENTO DE RESIDUO SOLIDO INDUSTRIAL CLASSE I', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 11, '3122,2', 'PROCESSAMENTO DE RESIDUO SOLIDO INDUSTRIAL CLASSE II A', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 10, '3126', 'RECICLAGEM DE RESIDUO SOLIDO INDUSTRIAL CLASSE II', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 12, '3412', 'CEMITERIO', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 13, '3412,1', 'CREMATORIO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '3413,11', 'CAMPUS UNIVERSITARIO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '3414,11', 'LOTEAMENTO RESIDENCIAL - CONDOMINIO UNIFAMILIAR', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '3414,12', 'LOTEAMENTO RESIDENCIAL - CONDOMINIO PLURIFAMILIAR', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '3414,2', 'SITIOS DE LAZER', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '3414,3', 'DESMEMBRAMENTO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 14, '3454', 'METROPOLITANOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 15, '3457', 'OBRAS DE URBANIZACAO (MURO/ CALCADA/ ACESSO/ ETC) E VIA URBANA (ABERTURA, CONSERVAÇÃO, REPARAÇÃO OU AMPLIAÇÃO)', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 16, '3458,1', 'BARRAGENS DE SANEAMENTO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 16, '3460', 'ACUDE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 15, '3462', 'CANALIZAÇÃO PARA DRENAGEM PLUVIAL URBANA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 15, '3463', 'CANALIZACAO DE CURSOS D\'AGUA NATURAL (EXCETO ATIVIDADES AGROPECUARIAS)', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 15, '3463,1', 'RETIFICAÇÃO/DESVIO DE CURSO D´AGUA', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 5 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 14, '3464,1', 'PONTES', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 14, '3464,2', 'VIADUTO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 14, '3510,22', 'TRANSMISSÃO DE ENERGIA ELÉTRICA (>34,5KV)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 17, '3510,3', 'GERACAO DE ENERGIA A PARTIR DE FONTE EOLICA', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 6, '3511,1', 'SISTEMA DE ABASTECIMENTO DE AGUA COM BARRAGEM', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 18, '3511,2', 'SISTEMA DE ABASTECIMENTO DE ÁGUA SEM BARRAGEM', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 18, '3512,1', 'SISTEMAS DE ESGOTO SANITARIO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 18, '3512,2', 'TRONCOS COLETORES E EMISSARIOS DE ESGOTO DOMESTICO', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 14, '3512,3', 'REDE DE ESGOTO DOMESTICO', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 19, '3513,1', 'COLETA/ TRATAMENTO CENTRALIZADO DE EFLUENTES LIQUIDOS INDUSTRIAIS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 20, '3513,2', 'APLICAÇÃO DE EFLUENTE INDUSTRIAL TRATADO EM SOLO AGRÍCOLA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 15, '3514,1', 'LIMPEZA DE CANAIS (SEM MATERIAL MINERAL)', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 5 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 21, '3514,21', 'DESASSOREAMENTO DE CURSOS D\'AGUA CORRENTE (EXCETO DE ATIVIDADES AGROPECUARIAS)', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 5 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 22, '3541,5', 'USINAS DE COMPOSTAGEM DE RSU', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 23, '3543,12', 'ATERRO COM MICROONDAS DE RSSS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 18, '3543,22', 'CENTRAIS DE TRIAGEM SEM ATERRO DE RESIDUO SOLIDO URBANO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 23, '3543,3', 'MICROONDAS DE RSSS COM ENTREPOSTO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3545', 'CLASSIFICACAO/SELECAO DE RSU ORIUNDO DE COLETA SELETIVA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 5 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '3550,2', 'RECUPERACAO DE AREA DEGRADADA POR RESIDUO SOLIDO URBANO, SEM USO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '3550,4', 'ENCERRAMENTO DE ATIVIDADES EM UNID DE DESTINACAO FINAL DE RSU', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 23, '3560,2', 'TRATAMENTO DE RESIDUOS SOLIDOS DE SERVICOS DE SAUDE', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 21, '3570', 'DESTINACAO DE RESIDUOS SOLIDOS PROVENIENTES DE FOSSAS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 15, '4720,1', 'ATRACADOURO/PÍER/TRAPICHE', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '4720,2', 'MARINA', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 15, '4720,3', 'ANCORADOURO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 14, '4730,2', 'TELEFÉRICO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '4750,1', 'DEPOSITOS DE GLP (EM BOTIJÕES, SEM MANIPULAÇÃO, CODIGO ONU 1075)', 'Baixo' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 24, '4750,51', 'POSTO DE ABASTECIMENTO PROPRIO COM TANQUES SUBTERRANEOS (DEPOSITO DE COMBUSTIVEIS)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 5 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 24, '4750,52', 'POSTO DE ABASTECIMENTO PROPRIO COM TANQUES AEREOS (DEPOSITO DE COMBUSTIVEIS) > 15 M3', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 5 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 9, '4751,5', 'DEPOSITO/COMERCIO DE OLEOS USADOS', 'Alto' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 5 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '6111', 'AREA DE LAZER (CAMPING/BALNEÁRIO/PARQUE TEMÁTICO)', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '6112,1', 'AUTODROMO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '6112,2', 'KARTODROMO', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );



insert into atividadeimpacto values ( nextval('atividadeimpacto_am03_sequencial_seq'), 8, '6112,3', 'PISTA DE MOTOCROSS', 'Médio' );

insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 1 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 2 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 3 );
insert into atividadeimpactoporte values ( nextval('atividadeimpactoporte_am04_sequencial_seq'), (select last_value from atividadeimpacto_am03_sequencial_seq), 4 );