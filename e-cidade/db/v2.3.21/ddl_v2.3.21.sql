-- Criando  sequences
CREATE SEQUENCE db_plugin_db145_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


-- TABELAS E ESTRUTURA

-- Módulo: configuracoes
CREATE TABLE db_plugin(
db145_sequencial    int4 NOT NULL default 0,
db145_nome    varchar(200) NOT NULL ,
db145_label   varchar(200) NOT NULL ,
db145_situacao    bool ,
CONSTRAINT db_plugin_sequ_pk PRIMARY KEY (db145_sequencial));




-- Criando  sequences
CREATE SEQUENCE db_pluginitensmenu_db146_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


-- TABELAS E ESTRUTURA

-- Módulo: configuracoes
CREATE TABLE db_pluginitensmenu(
db146_sequencial    int4 NOT NULL  default nextval('db_pluginitensmenu_db146_sequencial_seq'),
db146_db_plugin   int4 NOT NULL default 0,
db146_db_itensmenu    int4 default 0,
CONSTRAINT db_pluginitensmenu_sequ_pk PRIMARY KEY (db146_sequencial));




-- CHAVE ESTRANGEIRA


ALTER TABLE db_pluginitensmenu
ADD CONSTRAINT db_pluginitensmenu_plugin_fk FOREIGN KEY (db146_db_plugin)
REFERENCES db_plugin;

ALTER TABLE db_pluginitensmenu
ADD CONSTRAINT db_pluginitensmenu_itensmenu_fk FOREIGN KEY (db146_db_itensmenu)
REFERENCES db_itensmenu;


-- INDICES


CREATE  INDEX db_plugin_db146_db_itensmenu_in ON db_pluginitensmenu(db146_db_itensmenu);

CREATE  INDEX db_plugin_db146_db_plugin_in ON db_pluginitensmenu(db146_db_plugin);

/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME C INICIO
 * --------------------------------------------------------------------------------------------------------------------
 */

-- Tarefa 87471
ALTER TABLE regraarredondamento
ADD COLUMN ed316_casasdecimaisarredondamento int4 DEFAULT 1 NOT NULL;

select nextval('regraarredondamento_ed316_sequencial_seq');

-- Tarefa 80922
alter table turmaturno rename TO turmaturnoadicional;

CREATE SEQUENCE ensinoinfantil_ed117_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE ensinoinfantil(
ed117_sequencial int4 NOT NULL default nextval('ensinoinfantil_ed117_sequencial_seq'),
ed117_ensino int4 ,
CONSTRAINT ensinoinfantil_sequ_pk PRIMARY KEY (ed117_sequencial));

ALTER TABLE ensinoinfantil ADD CONSTRAINT ensinoinfantil_ensino_fk FOREIGN KEY (ed117_ensino) REFERENCES ensino;
CREATE UNIQUE INDEX ensinoinfantil_ensino_in ON ensinoinfantil(ed117_ensino);


CREATE SEQUENCE matriculaturnoreferente_ed337_codigo_seq INCREMENT 1  MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE turmaturnoreferente_ed336_codigo_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE matriculaturnoreferente(
  ed337_codigo int4 NOT NULL default 0,
  ed337_matricula int4 NOT NULL default 0,
  ed337_turmaturnoreferente int4 NOT NULL default 0
);

CREATE TABLE turmaturnoreferente(
ed336_codigo  int4 NOT NULL default 0,
ed336_turma  int4 NOT NULL default 0,
ed336_turnoreferente  int4 NOT NULL default 0,
ed336_vagas  int4 default 0,
CONSTRAINT turmaturnoreferente_codi_pk PRIMARY KEY (ed336_codigo));

ALTER TABLE turmaturnoreferente ADD CONSTRAINT turmaturnoreferente_turma_fk FOREIGN KEY (ed336_turma) REFERENCES turma;
ALTER TABLE matriculaturnoreferente ADD CONSTRAINT matriculaturnoreferente_matricula_fk FOREIGN KEY (ed337_matricula) REFERENCES matricula;
ALTER TABLE matriculaturnoreferente ADD CONSTRAINT matriculaturnoreferente_turmaturnoreferente_fk FOREIGN KEY (ed337_turmaturnoreferente) REFERENCES turmaturnoreferente;

CREATE INDEX matriculaturnoreferente_matricula_turmaturnoreferente_in ON matriculaturnoreferente(ed337_matricula,ed337_turmaturnoreferente);
CREATE INDEX turmaturnoreferente_turma_in ON turmaturnoreferente(ed336_turma);

insert into turmaturnoreferente
select nextval('turmaturnoreferente_ed336_codigo_seq'), ed57_i_codigo, ed231_i_referencia, ed57_i_numvagas
  from turma
 inner join turno          on ed15_i_codigo = ed57_i_turno
 inner join turnoreferente on ed231_i_turno = ed15_i_codigo;


insert into matriculaturnoreferente
select nextval('matriculaturnoreferente_ed337_codigo_seq'), ed60_i_codigo, ed336_codigo
  from matricula
 inner join turmaturnoreferente on ed336_turma = ed60_i_turma;

alter table turma drop column ed57_i_numvagas;
alter table turma drop column ed57_i_nummatr;

/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME C FIM
 * --------------------------------------------------------------------------------------------------------------------
 */
 
/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME A INICIO
 * --------------------------------------------------------------------------------------------------------------------
 */

-- Tarefa 84718 / Geração E-CONSIG
create sequence econsigmovimento_rh133_sequencia_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create sequence econsigmovimentoservidor_rh134_sequencial_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create sequence econsigmovimentoservidorrubrica_rh135_sequencial_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create table econsigmovimento(
rh133_sequencial    int4 not null default 0,
rh133_ano   int4 not null ,
rh133_mes   int4 not null ,
rh133_nomearquivo   varchar(100) not null ,
rh133_instit int4,
constraint econsigmovimento_sequencial_pk primary key (rh133_sequencial));

create table econsigmovimentoservidor(
rh134_sequencial    int4 not null  default nextval('econsigmovimentoservidor_rh134_sequencial_seq'),
rh134_econsigmovimento    int4 not null ,
rh134_regist    int4 ,
constraint econsigmovimentoservidor_sequencial_pk primary key (rh134_sequencial));

create table econsigmovimentoservidorrubrica(
rh135_sequencial    int4 not null  default nextval('econsigmovimentoservidorrubrica_rh135_sequencial_seq'),
rh135_econsigmovimentoservidor    int4 not null ,
rh135_rubrica   varchar(4) not null ,
rh135_instit int4,
rh135_valor   float4,
constraint econsigmovimentoservidorrubrica_sequencial_pk primary key (rh135_sequencial));

alter table econsigmovimento
add constraint econsigmovimento_instit_fk foreign key (rh133_instit)
references db_config;

alter table econsigmovimentoservidor
add constraint econsigmovimentoservidor_econsigmovimento_fk foreign key (rh134_econsigmovimento)
references econsigmovimento;

alter table econsigmovimentoservidor
add constraint econsigmovimentoservidor_regist_fk foreign key (rh134_regist)
references rhpessoal;

alter table econsigmovimentoservidorrubrica
add constraint econsigmovimentoservidorrubrica_econsigmovimentoservidor_fk foreign key (rh135_econsigmovimentoservidor)
references econsigmovimentoservidor;

alter table econsigmovimentoservidorrubrica
add constraint econsigmovimentoservidorrubrica_instit_fk foreign key (rh135_instit)
references db_config;

alter table econsigmovimentoservidorrubrica
add constraint econsigmovimentoservidorrubrica_rubrica_instit_fk foreign key (rh135_rubrica,rh135_instit)
references rhrubricas;

create  index econsigmovimento_sequencial_in on econsigmovimento(rh133_sequencial);

CREATE SEQUENCE obrasalvarahistorico_ob35_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE obrasalvarahistorico(
ob35_sequencial   int4 NOT NULL  default nextval('obrasalvarahistorico_ob35_sequencial_seq'),
ob35_codobra    int4 NOT NULL ,
ob35_datainicial    date NOT NULL ,
ob35_datafinal    date ,
CONSTRAINT obrasalvarahistorico_sequ_pk PRIMARY KEY (ob35_sequencial));

ALTER TABLE obrasalvarahistorico
ADD CONSTRAINT obrasalvarahistorico_codobra_fk FOREIGN KEY (ob35_codobra)
REFERENCES obras;

CREATE UNIQUE INDEX obrasalvarahistorico_sequencial_in ON obrasalvarahistorico(ob35_sequencial);
  
ALTER TABLE obrasalvara
ADD COLUMN ob04_dataexpedicao date default null;

/**
 * Migracao da coluna ob04_dataexpedicao.
 */
update obrasalvara set ob04_dataexpedicao = obrasalvara.ob04_data;

/**
 * Adicionado campo de AnoUsu e Instit na tabela rhcontasrec
 */
ALTER TABLE rhcontasrec
ADD COLUMN rh41_instit int4 NOT NULL default 0;

ALTER TABLE rhcontasrec
ADD COLUMN rh41_anousu int4 NOT NULL default 0;

/*
  Migracao da tabela antiga.
  Faz backup depois atualiza os valores
 */
CREATE TABLE w_rhcontasrec AS
SELECT *
FROM rhcontasrec;

UPDATE rhcontasrec
SET rh41_anousu = novo.c61_anousu,
    rh41_instit = novo.c61_instit
FROM
  (SELECT rh41_conta,
          rh41_codigo,
          max(c61_anousu) AS c61_anousu,
          max(c61_instit) AS c61_instit
   FROM rhcontasrec
   INNER JOIN saltes ON rh41_conta = k13_conta
   INNER JOIN conplanoreduz ON k13_reduz = c61_reduz
   WHERE c61_anousu <= 2014
   GROUP BY rh41_conta,
            rh41_codigo) AS novo
WHERE rhcontasrec.rh41_conta = novo.rh41_conta
  AND rhcontasrec.rh41_codigo = novo.rh41_codigo;
/*
  Fim migracao
 */
ALTER TABLE rhcontasrec
ADD CONSTRAINT rhcontasrec_instit_fk FOREIGN KEY (rh41_instit)
REFERENCES db_config;

drop index rhcontasrec_codigo_in;
create unique index  rhcontasrec_codigo_instit_anousu_in on rhcontasrec(rh41_codigo, rh41_instit, rh41_anousu);
CREATE  INDEX rhcontasrec_rh41_instit_in ON rhcontasrec(rh41_instit);
CREATE  INDEX rhcontasrec_rh41_conta_in ON rhcontasrec(rh41_conta);
alter table rhcontasrec drop CONSTRAINT rhcontasrec_cont_codi_pk;

alter table rhcontasrec add constraint "rhcontasrec_cont_codi_pk" PRIMARY KEY (rh41_conta, rh41_codigo, rh41_instit, rh41_anousu);


-- Tarefa 73379 - Vistorias
-- Criando  sequences
CREATE SEQUENCE tabativportetipcalc_q143_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- Módulo: issqn
CREATE TABLE tabativportetipcalc(
q143_sequencial   int4 NOT NULL  default nextval('tabativportetipcalc_q143_sequencial_seq'),
q143_ativid   int4 NOT NULL default 0,
q143_issporte   int8 NOT NULL default 0,
q143_tipcalc    int4 default 0,
CONSTRAINT tabativportetipcalc_sequ_pk PRIMARY KEY (q143_sequencial));

-- CHAVE ESTRANGEIRA
ALTER TABLE tabativportetipcalc
ADD CONSTRAINT tabativportetipcalc_issporte_fk FOREIGN KEY (q143_issporte)
REFERENCES issporte;

ALTER TABLE tabativportetipcalc
ADD CONSTRAINT tabativportetipcalc_ativid_fk FOREIGN KEY (q143_ativid)
REFERENCES ativid;

ALTER TABLE tabativportetipcalc
ADD CONSTRAINT tabativportetipcalc_tipcalc_fk FOREIGN KEY (q143_tipcalc)
REFERENCES tipcalc;

-- INDICES
CREATE  INDEX tabativportetipcalc_tipcalc_in ON tabativportetipcalc(q143_tipcalc);

CREATE  INDEX tabativportetipcalc_issporte_in ON tabativportetipcalc(q143_issporte);

CREATE  INDEX tabativportetipcalc_ativid_in ON tabativportetipcalc(q143_ativid);

ALTER TABLE parfiscal 
ADD COLUMN y32_utilizacalculoporteatividade   bool default 'f';


-- Tarefa 85514 - Portaria Assintauras
DROP TABLE IF EXISTS portariaassinatura CASCADE;
DROP SEQUENCE IF EXISTS portariaassinatura_rh136_sequencial_seq;


CREATE SEQUENCE portariaassinatura_rh136_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


alter table portaria add column h31_portariaassinatura    int4 default null;


-- Módulo: recursoshumanos
CREATE TABLE portariaassinatura(
rh136_sequencial    int4 NOT NULL  default nextval('portariaassinatura_rh136_sequencial_seq'),
rh136_nome    varchar(100) NOT NULL ,
rh136_cargo   varchar(200) NOT NULL ,
rh136_amparo    text ,
CONSTRAINT portariaassinatura_sequ_pk PRIMARY KEY (rh136_sequencial));

-- CHAVE ESTRANGEIRA

ALTER TABLE portaria
ADD CONSTRAINT portaria_portariaassinatura_fk FOREIGN KEY (h31_portariaassinatura)
REFERENCES portariaassinatura;


-- INDICES


CREATE  INDEX portaria_portariaassinatura_in ON portaria(h31_portariaassinatura);

/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME A FIM
 * --------------------------------------------------------------------------------------------------------------------
 */



CREATE SEQUENCE tiporeferenciaalnumericofaixaidade_la59_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


CREATE SEQUENCE tiporeferenciaalnumericosexo_la60_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


CREATE SEQUENCE tiporeferenciacalculo_la61_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


CREATE TABLE tiporeferenciaalnumericofaixaidade(
la59_sequencial		int4 NOT NULL default 0,
la59_tiporeferencialnumerico		int4 NOT NULL default 0,
la59_periodoinicial	interval	  default null,
la59_periodofinal		interval  ,
CONSTRAINT tiporeferenciaalnumericofaixaidade_sequ_pk PRIMARY KEY (la59_sequencial));


-- Módulo: laboratorio
CREATE TABLE tiporeferenciaalnumericosexo(
  la60_sequencial		int4 NOT NULL default 0,
  la60_tiporeferencialnumerico		int4 NOT NULL default 0,
  la60_sexo		char(1),
  CONSTRAINT tiporeferenciaalnumericosexo_sequ_pk PRIMARY KEY (la60_sequencial));


-- Módulo: laboratorio
CREATE TABLE tiporeferenciacalculo(
  la61_sequencial		int4 NOT NULL default 0,
  la61_tiporeferencialnumerico		int4 NOT NULL default 0,
  la61_atributobase		int4 NOT NULL default 0,
  la61_tipocalculo		int4  NOT NULL default 0,
  CONSTRAINT tiporeferenciacalculo_sequ_pk PRIMARY KEY (la61_sequencial));


alter table  lab_resultadonum add la41_valorpercentual float default null;
alter table  lab_resultadonum add la41_faixaescolhida  integer;
alter table  lab_resultado    add la52_diagnostico     text;

ALTER TABLE tiporeferenciaalnumericofaixaidade
ADD CONSTRAINT tiporeferenciaalnumericofaixaidade_tiporeferencialnumerico_fk FOREIGN KEY (la59_tiporeferencialnumerico)
REFERENCES lab_tiporeferenciaalnumerico;

ALTER TABLE tiporeferenciaalnumericosexo
ADD CONSTRAINT tiporeferenciaalnumericosexo_tiporeferencialnumerico_fk FOREIGN KEY (la60_tiporeferencialnumerico)
REFERENCES lab_tiporeferenciaalnumerico;

ALTER TABLE tiporeferenciacalculo
ADD CONSTRAINT tiporeferenciacalculo_atributobase_fk FOREIGN KEY (la61_atributobase)
REFERENCES lab_atributo;

ALTER TABLE tiporeferenciacalculo
ADD CONSTRAINT tiporeferenciacalculo_tiporeferencialnumerico_fk FOREIGN KEY (la61_tiporeferencialnumerico)
REFERENCES lab_tiporeferenciaalnumerico;

ALTER TABLE lab_tiporeferenciaalnumerico ADD CONSTRAINT lab_tiporeferencialnumerico_valorref_fk FOREIGN KEY (la30_i_valorref)
references lab_valorreferencia;

CREATE  INDEX tiporeferenciaalnumericofaixaidade_referencia_in ON tiporeferenciaalnumericofaixaidade(la59_tiporeferencialnumerico);

CREATE  INDEX tiporeferenciaalnumericosexo_referencia_in ON tiporeferenciaalnumericosexo(la60_tiporeferencialnumerico);

CREATE  INDEX tiporeferenciacalculo_atributo_in ON tiporeferenciacalculo(la61_atributobase);

CREATE  INDEX tiporeferenciacalculo_referencia_in ON tiporeferenciacalculo(la61_tiporeferencialnumerico);

CREATE  INDEX lab_tiporeferenciaalnumerico_valorref_in on lab_tiporeferenciaalnumerico(la30_i_valorref);

