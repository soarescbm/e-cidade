/**
 * Arquivo ddl da versão 2.3.25
 */

/*
 *
 * TIME Tributário
 *
 *
 */

alter table rharqbanco add column rh34_parametrotransmissaoheader varchar(2) default null;
alter table rharqbanco add column rh34_parametrotransmissaolote   varchar(2) default null;
alter table rharqbanco add column rh34_codigocompromisso          varchar(4) default null;

ALTER TABLE parissqn ADD COLUMN q60_templatebaixaalvaranormal  int4 default null;
ALTER TABLE parissqn ADD COLUMN q60_templatebaixaalvaraoficial int4 default null;

alter table numpref add column k03_toleranciacredito  numeric(15,2) default 0;

-- Criando  sequences

CREATE SEQUENCE tabdesccadban_k114_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- TABELAS E ESTRUTURA

-- Módulo: arrecadacao
CREATE TABLE tabdesccadban(
k114_sequencial   int8 NOT NULL default 0,
k114_tabdesc    int8 NOT NULL default 0,
k114_codban   int8 default 0,
CONSTRAINT tabdesccadban_sequ_pk PRIMARY KEY (k114_sequencial));



-- CHAVE ESTRANGEIRA 

ALTER TABLE tabdesccadban
ADD CONSTRAINT tabdesccadban_codban_fk FOREIGN KEY (k114_codban)
REFERENCES cadban;

ALTER TABLE tabdesccadban
ADD CONSTRAINT tabdesccadban_tabdesc_fk FOREIGN KEY (k114_tabdesc)
REFERENCES tabdesc;


  
-- INDICES 

CREATE  INDEX tabdesccadban_codban_in ON tabdesccadban(k114_codban);
CREATE  INDEX tabdesccadban_tabdesc_in ON tabdesccadban(k114_tabdesc);

insert into histcalc values (507, 'PGTO TAXA BANCARIA','');

/*
 *
 * FIM TIME Tributário
 *
 *
 */

/**
 * TIME B
 */

  -- mensageriaacordodb_usuario
  CREATE SEQUENCE mensageriaacordodb_usuario_ac52_sequencial_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

  CREATE TABLE mensageriaacordodb_usuario(
  ac52_sequencial   int4 NOT NULL default 0,
  ac52_db_usuarios    int4 NOT NULL default 0,
  ac52_dias   int4 default 0,
  CONSTRAINT mensageriaacordodb_usuario_sequ_pk PRIMARY KEY (ac52_sequencial));

  ALTER TABLE mensageriaacordodb_usuario
  ADD CONSTRAINT mensageriaacordodb_usuario_usuarios_fk FOREIGN KEY (ac52_db_usuarios)
  REFERENCES db_usuarios;

  CREATE  INDEX mensageriaacordodb_usuario_db_usuarios_in ON mensageriaacordodb_usuario(ac52_db_usuarios);

  -- mensageriaacordo
  CREATE SEQUENCE mensageriaacordo_ac51_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
  CREATE TABLE mensageriaacordo(
    ac51_sequencial  int4 NOT NULL default 0,
    ac51_assunto     varchar(100) NOT NULL ,
    ac51_mensagem    text ,
    CONSTRAINT mensageriaacordo_sequ_pk PRIMARY KEY (ac51_sequencial)
  );

  insert into mensageriaacordo values(
    nextval('mensageriaacordo_ac51_sequencial_seq'),
    'Contrato [numero]/[ano] irá vencer',
    'O contrato [numero]/[ano] irá vencer em [dias] dias.<br />Vigência: [data_inicial] - [data_final]'
  ); 

  -- mensageriaacordoprocessados
  CREATE SEQUENCE mensageriaacordoprocessados_ac53_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
  CREATE TABLE mensageriaacordoprocessados(
    ac53_sequencial                  int4 NOT NULL default 0,
    ac53_mensageriaacordodb_usuarios int4 NOT NULL default 0,
    ac53_acordo                      int4 default 0,
    CONSTRAINT mensageriaacordoprocessados_sequ_pk PRIMARY KEY (ac53_sequencial)
  );
  ALTER TABLE mensageriaacordoprocessados ADD CONSTRAINT mensageriaacordoprocessados_usuarios_fk FOREIGN KEY (ac53_mensageriaacordodb_usuarios) REFERENCES mensageriaacordodb_usuario;
  ALTER TABLE mensageriaacordoprocessados ADD CONSTRAINT mensageriaacordoprocessados_acordo_fk FOREIGN KEY (ac53_acordo) REFERENCES acordo;
  CREATE INDEX mensageriaacordoprocessados_ac53_mensageriaacordodb_usuarios_in ON mensageriaacordoprocessados(ac53_mensageriaacordodb_usuarios);
  CREATE INDEX mensageriaacordoprocessados_ac53_acordo_in ON mensageriaacordoprocessados(ac53_acordo);
  
	
	CREATE SEQUENCE placaixaprocesso_k144_sequencial_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1;
	
	CREATE SEQUENCE slipprocesso_k145_sequencial_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1;
	
	CREATE SEQUENCE pagordemprocesso_e03_sequencial_seq
	INCREMENT 1
	MINVALUE 1
	MAXVALUE 9223372036854775807
	START 1
	CACHE 1;
	
	CREATE TABLE placaixaprocesso(
	k144_sequencial   int4 NOT NULL default 0,
	k144_placaixa   int4 NOT NULL default 0,
	k144_numeroprocesso   varchar(15) ,
	CONSTRAINT placaixaprocesso_sequ_pk PRIMARY KEY (k144_sequencial));
	
	
	CREATE TABLE slipprocesso(
	k145_sequencial   int4 NOT NULL default 0,
	k145_slip   int4 NOT NULL default 0,
	k145_numeroprocesso   varchar(15) ,
	CONSTRAINT slipprocesso_sequ_pk PRIMARY KEY (k145_sequencial));
	
	CREATE TABLE pagordemprocesso(
	e03_sequencial    int4 NOT NULL default 0,
	e03_pagordem    int4 NOT NULL default 0,
	e03_numeroprocesso    varchar(15) ,
	CONSTRAINT pagordemprocesso_sequ_pk PRIMARY KEY (e03_sequencial));
	
	
	ALTER TABLE placaixaprocesso
	ADD CONSTRAINT placaixaprocesso_placaixa_fk FOREIGN KEY (k144_placaixa)
	REFERENCES placaixa;
	
	ALTER TABLE slipprocesso
	ADD CONSTRAINT slipprocesso_slip_fk FOREIGN KEY (k145_slip)
	REFERENCES slip;
	
	ALTER TABLE pagordemprocesso
	ADD CONSTRAINT pagordemprocesso_pagordem_fk FOREIGN KEY (e03_pagordem)
	REFERENCES pagordem;
	
	CREATE  INDEX placaixaprocesso_placaixa_in ON placaixaprocesso(k144_placaixa);
	CREATE  INDEX slipprocesso_slip_in ON slipprocesso(k145_slip);
	CREATE  INDEX pagordemprocesso_pagordem_in ON pagordemprocesso(e03_pagordem);

	
CREATE SEQUENCE empnotaprocesso_e04_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE empnotaprocesso(
e04_sequencial    int4 NOT NULL default 0,
e04_empnota   int4 NOT NULL default 0,
e04_numeroprocesso    varchar(15) ,
CONSTRAINT empnotaprocesso_sequ_pk PRIMARY KEY (e04_sequencial));

ALTER TABLE empnotaprocesso
ADD CONSTRAINT empnotaprocesso_empnota_fk FOREIGN KEY (e04_empnota)
REFERENCES empnota;

CREATE  INDEX empnotaprocesso_empnota_in ON empnotaprocesso(e04_empnota);
	
	

 
/**
 * FIM TIME B
 */

/*
 *
 * TIME C
 *
 *
 */

alter table escoladiretor ALTER COLUMN ed254_i_atolegal DROP not null;
alter table edu_relatmodel add column ed217_brasao int default 1 not null;


/**
 * T91754
 */
CREATE SEQUENCE rechumanomovimentacao_ed118_sequencial_seq  INCREMENT 1 MINVALUE 1  MAXVALUE 9223372036854775807 START 1 CACHE 1;

alter table rechumanohoradisp add ed33_rechumanoescola int4 NOT NULL default 0;
alter table rechumanohoradisp add ed33_ativo  bool default 't';

create table w_rechumanohoradisp as select ed33_i_codigo,
                                           ed33_i_diasemana,
                                           ed33_i_periodo,
                                           ed33_i_rechumano as old,
                                           ed75_i_codigo    as new
                                      from rechumanohoradisp
                                     inner join rechumanoescola on rechumanoescola.ed75_i_rechumano = rechumanohoradisp.ed33_i_rechumano;

update rechumanohoradisp
   set ed33_rechumanoescola = new
  from w_rechumanohoradisp
 where rechumanohoradisp.ed33_i_codigo = w_rechumanohoradisp.ed33_i_codigo;

ALTER TABLE rechumanohoradisp DROP COLUMN ed33_i_rechumano;

CREATE TABLE rechumanomovimentacao(
  ed118_sequencial int4 NOT NULL default 0,
  ed118_escola     int4 NOT NULL default 0,
  ed118_rechumano  int4 NOT NULL default 0,
  ed118_usuario    int4 NOT NULL default 0,
  ed118_data       date NOT NULL default null,
  ed118_hora       varchar(5) NOT NULL ,
  ed118_resumo     text ,
  CONSTRAINT rechumanomovimentacao_sequ_pk PRIMARY KEY (ed118_sequencial)
);

ALTER TABLE rechumanohoradisp     ADD CONSTRAINT rechumanohoradisp_rechumanoescola_fk FOREIGN KEY (ed33_rechumanoescola) REFERENCES rechumanoescola;
ALTER TABLE rechumanomovimentacao ADD CONSTRAINT rechumanomovimentacao_rechumano_fk FOREIGN KEY (ed118_rechumano) REFERENCES rechumano;
ALTER TABLE rechumanomovimentacao ADD CONSTRAINT rechumanomovimentacao_escola_fk FOREIGN KEY (ed118_escola) REFERENCES escola;
ALTER TABLE rechumanomovimentacao ADD CONSTRAINT rechumanomovimentacao_usuario_fk FOREIGN KEY (ed118_usuario) REFERENCES db_usuarios;

CREATE INDEX rechumanomovimentacao_usuario_in   ON rechumanomovimentacao(ed118_usuario);
CREATE INDEX rechumanomovimentacao_rechumano_in ON rechumanomovimentacao(ed118_rechumano);
CREATE INDEX rechumanomovimentacao_escola_in    ON rechumanomovimentacao(ed118_escola);

/**
 * T93234
 */
-- lab_requiitem
alter table lab_requiitem add column la21_observacao text;

/*
 *
 * FIM TIME C
 *
 *
 */
 
 /*
 *
 * INICIO TIME D
 * T 93849
 *
 */
ALTER TABLE issqn.ativid ADD COLUMN q03_tributacao_municipio BOOLEAN DEFAULT FALSE;

/*
 *
 * FIM TIME D
 *
 *
 */
