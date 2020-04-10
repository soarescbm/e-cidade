---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
select fc_executa_ddl('CREATE SEQUENCE tipoassunto_bi30_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1');

CREATE TABLE IF NOT EXISTS tipoassunto(
  bi30_sequencial int4 NOT NULL default 0,
  bi30_descricao text,
CONSTRAINT tipoassunto_sequ_pk PRIMARY KEY (bi30_sequencial));

select fc_executa_ddl('CREATE INDEX tipoassunto_descricao_in ON tipoassunto(bi30_descricao)');

select fc_executa_ddl('
CREATE SEQUENCE transferencialote_ed137_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1');

CREATE TABLE IF NOT EXISTS transferencialote (
  ed137_sequencial   int4 NOT NULL,
  ed137_escolaorigem int4 NOT NULL,
  ed137_usuario      int4 NOT NULL,
  ed137_escolarede   bool NOT NULL default 'true',
  ed137_escola       int4 NOT NULL,
  ed137_data         timestamp default now(),
  CONSTRAINT transferencialote_sequ_pk PRIMARY KEY (ed137_sequencial),
  CONSTRAINT transferencialote_escolaorigem_fk FOREIGN KEY (ed137_escolaorigem) REFERENCES escola.escola(ed18_i_codigo),
  CONSTRAINT transferencialote_usuario_fk FOREIGN KEY (ed137_usuario) REFERENCES configuracoes.db_usuarios(id_usuario)
);

select fc_executa_ddl('CREATE SEQUENCE transferencialotematricula_ed138_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1');

CREATE TABLE IF NOT EXISTS transferencialotematricula(
  ed138_sequencial          int4 NOT NULL,
  ed138_transferencialote   int4 NOT NULL,
  ed138_matricula           int4 NOT NULL,
  CONSTRAINT transferencialotematricula_sequ_pk PRIMARY KEY (ed138_sequencial),
  CONSTRAINT transferencialotematricula_matricula_fk FOREIGN KEY (ed138_matricula) REFERENCES escola.matricula(ed60_i_codigo),
  CONSTRAINT transferencialotematricula_transferencialote_fk FOREIGN KEY (ed138_transferencialote) REFERENCES transferencialote(ed137_sequencial)
);
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------- INICIO FINANCEIRO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL FINANCEIRO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------- INICIO TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

select fc_executa_ddl('
create sequence agua.aguacontrato_x54_sequencial_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;') as aguacontrato_x54_sequencial_seq;

select fc_executa_ddl('
create sequence agua.aguacontratoligacao_x55_sequencial_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;') as aguacontratoligacao_x55_sequencial_seq;

create table if not exists agua.aguacontrato(
x54_sequencial           int4 not null default nextval('aguacontrato_x54_sequencial_seq'),
x54_aguabase             int4,
x54_diavencimento        int4,
x54_datavalidadecadastro date,
x54_datainicial          date not null,
x54_datafinal            date,
x54_nis                  varchar(20),
x54_cgm                  int4 not null,
x54_aguacategoriaconsumo int4 not null,
constraint aguacontrato_sequ_pk primary key (x54_sequencial),
constraint aguacontrato_aguabase_fk foreign key (x54_aguabase) references agua.aguabase(x01_matric),
constraint aguacontrato_cgm_fk foreign key (x54_cgm) references protocolo.cgm(z01_numcgm));

create table if not exists agua.aguacontratoligacao(
x55_sequencial      int4 not null default nextval('aguacontratoligacao_x55_sequencial_seq'),
x55_aguahidromatric int4 not null,
x55_aguacontrato    int4,
constraint aguacontratoligacao_sequ_pk primary key (x55_sequencial),
constraint aguacontratoligacao_aguahidromatric_fk foreign key (x55_aguahidromatric) references agua.aguahidromatric(x04_codhidrometro),
constraint aguacontratoligacao_aguacontrato_fk foreign key (x55_aguacontrato) references agua.aguacontrato(x54_sequencial));

alter table agua.aguahidromatric alter column x04_matric drop not null;

-- # Agua Categoria Consumo
select fc_executa_ddl('
CREATE SEQUENCE agua.aguacategoriaconsumo_x13_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;') as aguacategoriaconsumo_x13_sequencial_seq;

CREATE TABLE IF NOT EXISTS agua.aguacategoriaconsumo (
x13_sequencial	int4 NOT NULL  default nextval('aguacategoriaconsumo_x13_sequencial_seq'),
x13_exercicio		int4 NOT NULL,
x13_descricao		varchar(100) NOT NUll,
CONSTRAINT aguacategoriaconsumo_sequ_pk PRIMARY KEY (x13_sequencial)
);

-- # Agua Estrutura Tarifaria
select fc_executa_ddl('
CREATE SEQUENCE agua.aguaestruturatarifaria_x37_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
') as aguaestruturatarifaria_x37_sequencial_seq;

CREATE TABLE IF NOT EXISTS  agua.aguaestruturatarifaria(
x37_sequencial		    int4 NOT NULL  default nextval('aguaestruturatarifaria_x37_sequencial_seq'),
x37_aguaconsumotipo		int4 NOT NULL ,
x37_tipoestrutura		  int4 NOT NULL ,
x37_valorinicial	  	int4  default 0,
x37_valorfinal	    	int4  default 0,
x37_valor		          float4  default 0,
x37_percentual	    	float4 default 0,
x37_aguacategoriaconsumo		int4 NOT NULL,
CONSTRAINT aguaestruturatarifaria_sequ_pk PRIMARY KEY (x37_sequencial),
CONSTRAINT aguaestruturatarifaria_aguaconsumotipo_fk FOREIGN KEY (x37_aguaconsumotipo) REFERENCES aguaconsumotipo,
CONSTRAINT aguaestruturatarifaria_aguacategoriaconsumo_fk FOREIGN KEY (x37_aguacategoriaconsumo) REFERENCES aguacategoriaconsumo
);

-- # Agua Contrato < Agua Categoria Consumo
select fc_executa_ddl('
ALTER TABLE aguacontrato
ADD CONSTRAINT aguacontrato_aguacategoriaconsumo_fk FOREIGN KEY (x54_aguacategoriaconsumo)
REFERENCES aguacategoriaconsumo;
') as alter_table_aguacontrato_aguacategoriaconsumo;
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO FOLHA ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL FOLHA ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO SAUDE ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
select fc_executa_ddl('alter table sau_triagemavulsa add column s152_perimetrocefalico int4 null');
select fc_executa_ddl('alter table sau_triagemavulsa add column s152_frequenciarespiratoria int4 null');
select fc_executa_ddl('alter table sau_triagemavulsa add column s152_frequenciacardiaca int4 null');
select fc_executa_ddl('alter table sau_triagemavulsa add column s152_dum date null');
select fc_executa_ddl('alter table sau_triagemavulsa add column s152_saturacao int4 null');
select fc_executa_ddl('alter table sau_triagemavulsa add column s152_subjetivo text null');
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL SAUDE ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO CONFIGURACAO --------------------------------------------------
---------------------------------------------------------------------------------------------------------------

-- Transformar configuracoes.db_usuariosonline em uma "Unlogged Table"
SELECT fc_executa_ddl('ALTER TABLE configuracoes.db_usuariosonline RENAME TO old_db_usuariosonline;');
SELECT fc_executa_ddl('CREATE UNLOGGED TABLE configuracoes.db_usuariosonline (LIKE configuracoes.old_db_usuariosonline INCLUDING ALL);');
SELECT fc_executa_ddl('INSERT INTO configuracoes.db_usuariosonline SELECT * FROM configuracoes.old_db_usuariosonline;');
SELECT fc_executa_ddl('DROP TABLE configuracoes.old_db_usuariosonline;');
SELECT fc_executa_ddl('ALTER INDEX configuracoes.db_usuariosonline_uol_id_idx RENAME TO usuariosonline_iduso_in;');

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL CONFIGURACAO ---------------------------------------------------
---------------------------------------------------------------------------------------------------------------