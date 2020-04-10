  
/*=======================    TIME B =============================
 * =========================== Paralisacao de Contratos =========
 */

CREATE SEQUENCE acordoparalisacao_ac47_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE SEQUENCE acordoparalisacaoacordomovimentacao_ac48_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE SEQUENCE acordoparalisacaoperiodo_ac49_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE acordoparalisacao(
ac47_sequencial   int4 default 0,
ac47_acordo       int4 not null,
ac47_datainicio   date not null,
ac47_datafim      date default null,
CONSTRAINT acordoparalisacao_sequ_pk PRIMARY KEY (ac47_sequencial));


CREATE TABLE acordoparalisacaoacordomovimentacao(
ac48_sequencial   int4 default 0,
ac48_acordoparalisacao int4  ,
ac48_acordomovimentacao int4 , 
CONSTRAINT acordoparalisacaoacordomovimentacao_sequ_pk PRIMARY KEY (ac48_sequencial));

CREATE TABLE acordoparalisacaoperiodo(
ac49_sequencial           int4 default 0,
ac49_acordoparalisacao    int4,
ac49_acordoposicaoperiodo int4,
ac49_tipoperiodo          int4,
CONSTRAINT acordoparalisacaoperiodo_sequ_pk PRIMARY KEY (ac49_sequencial));



ALTER TABLE acordoparalisacao
ADD CONSTRAINT acordoparalisacao_acordo_fk FOREIGN KEY (ac47_acordo)
REFERENCES acordo;

ALTER TABLE acordoparalisacaoacordomovimentacao
ADD CONSTRAINT acordoparalisacaoacordomovimentacao_acordoparalisacao_fk FOREIGN KEY (ac48_acordoparalisacao)
REFERENCES acordoparalisacao;

ALTER TABLE acordoparalisacaoacordomovimentacao
ADD CONSTRAINT acordoparalisacaoacordomovimentacao_acordomovimentacao_fk FOREIGN KEY (ac48_acordomovimentacao)
REFERENCES acordomovimentacao;

ALTER TABLE acordoparalisacaoperiodo
ADD CONSTRAINT acordoparalisacaoperiodo_acordoparalisacao_fk FOREIGN KEY (ac49_acordoparalisacao)
REFERENCES acordoparalisacao;

ALTER TABLE acordoparalisacaoperiodo
ADD CONSTRAINT acordoparalisacaoperiodo_acordoposicaoperiodo_fk FOREIGN KEY (ac49_acordoposicaoperiodo)
REFERENCES acordoposicaoperiodo;


CREATE  INDEX acordoparalisacao_acordo_in ON acordoparalisacao(ac47_acordo);
CREATE  INDEX acordoparalisacao_sequencial_in ON acordoparalisacao(ac47_sequencial);
CREATE  INDEX acordoparalisacaoacordomovimentacao_acordomovimentacao_in ON acordoparalisacaoacordomovimentacao(ac48_acordomovimentacao);
CREATE  INDEX acordoparalisacaoacordomovimentacao_acordoparalisacao_in ON acordoparalisacaoacordomovimentacao(ac48_acordoparalisacao);
CREATE  INDEX acordoparalisacaoacordomovimentacao_sequencial_in ON acordoparalisacaoacordomovimentacao(ac48_sequencial);
CREATE  INDEX acordoparalisacaoperiodo_acordoposicaoperiodo_in ON acordoparalisacaoperiodo(ac49_acordoposicaoperiodo);
CREATE  INDEX acordoparalisacaoperiodo_acordoparalisacao_in ON acordoparalisacaoperiodo(ac49_acordoparalisacao);
CREATE  INDEX acordoparalisacaoperiodo_sequencial_in ON acordoparalisacaoperiodo(ac49_sequencial);

alter table acordo add column  ac16_acordoclassificacao integer default 1;

ALTER TABLE acordo
ADD CONSTRAINT acordo_acordoclassificacao_fk FOREIGN KEY (ac16_acordoclassificacao)
REFERENCES acordoclassificacao;

CREATE  INDEX acordo_acordoclassificacao_in ON acordo(ac16_acordoclassificacao);

-- tarefa 89734 {
  ALTER TABLE acordo ADD COLUMN ac16_numeroacordo INT4 DEFAULT 0;
  ALTER TABLE acordo ADD COLUMN ac16_valor     NUMERIC DEFAULT 0;

  update acordo 
     set ac16_valor = valor
    from (select ac16_sequencial as codigo, sum(ac20_valortotal) as valor
            from acordo
                 inner join acordoposicao on ac26_acordo = ac16_sequencial
                 inner join acordoitem on ac20_acordoposicao = ac26_sequencial
           where ac26_situacao = 1
        group by ac16_sequencial) as w_valor_acordo_89734
   where ac16_sequencial = codigo;

  CREATE FUNCTION corrigi_numeracao_contrato(iAnoUsu integer, iInstituicao integer) RETURNS integer AS $$
  DECLARE
    rAcordo RECORD;
    iNumero INTEGER := 0;
  BEGIN
    FOR rAcordo IN SELECT ac16_sequencial FROM acordo WHERE ac16_anousu = iAnoUsu AND ac16_instit = iInstituicao ORDER BY ac16_sequencial LOOP
      iNumero := iNumero + 1;
      UPDATE acordo SET ac16_numeroacordo = iNumero WHERE ac16_sequencial = rAcordo.ac16_sequencial;
    END LOOP;
    RETURN iNumero;
  END;
  $$ LANGUAGE plpgsql;

  select corrigi_numeracao_contrato(ac16_anousu, ac16_instit) from acordo group by ac16_anousu, ac16_instit;
  drop function corrigi_numeracao_contrato(integer, integer);

  CREATE UNIQUE INDEX acordo_numeroacordo_anousu_instit_in ON acordo(ac16_numeroacordo, ac16_anousu, ac16_instit);
-- }
  
/*
 *======================  FIM TIME B ===================================
 */  

/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME C INICIO
 * --------------------------------------------------------------------------------------------------------------------
 */

 -- Tarefa 90547
 ALTER TABLE aluno ADD COLUMN ed47_tiposanguineo int8 default null;
 ALTER TABLE aluno ADD CONSTRAINT aluno_tiposanguineo_fk FOREIGN KEY (ed47_tiposanguineo) REFERENCES tiposanguineo;

 -- Tarefa 80619
CREATE SEQUENCE criterioavaliacao_ed338_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1; 
CREATE SEQUENCE criterioavaliacaodisciplina_ed339_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1; 
CREATE SEQUENCE criterioavaliacaoperiodoavaliacao_ed340_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1; 
CREATE SEQUENCE criterioavaliacaoturma_ed341_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1; 

CREATE TABLE criterioavaliacao (
  ed338_sequencial int4 default 0,
  ed338_descricao  varchar(150) not null,
  ed338_abreviatura varchar(20) not null,
  ed338_ordem int4 default null,
  ed338_escola int4 not null,
  CONSTRAINT criterioavaliacao_sequ_pk PRIMARY KEY (ed338_sequencial)
);


CREATE TABLE criterioavaliacaodisciplina (
  ed339_sequencial int4 not null,
  ed339_criterioavaliacao int4 not null,
  ed339_disciplina int4 not null,
  CONSTRAINT criterioavaliacaodisciplina_sequ_pk PRIMARY KEY (ed339_sequencial)
);


CREATE TABLE criterioavaliacaoperiodoavaliacao (
  ed340_sequencial int4 not null,
  ed340_criterioavaliacao int4 not null,
  ed340_periodoavaliacao int4 not null,
  CONSTRAINT criterioavaliacaoperiodoavaliacao_sequ_pk PRIMARY KEY (ed340_sequencial)
);

CREATE TABLE criterioavaliacaoturma (
  ed341_sequencial int4 not null,
  ed341_criterioavaliacao int4 not null,
  ed341_turma int4 not null,
  CONSTRAINT criterioavaliacaoturma_sequ_pk PRIMARY KEY (ed341_sequencial)
);

ALTER TABLE criterioavaliacao ADD CONSTRAINT criterioavaliacaoturma_escola_fk FOREIGN KEY (ed338_escola) REFERENCES escola;
ALTER TABLE criterioavaliacaodisciplina ADD CONSTRAINT criterioavaliacaodisciplina_criterioavaliacao_fk FOREIGN KEY (ed339_criterioavaliacao) REFERENCES criterioavaliacao;
ALTER TABLE criterioavaliacaodisciplina ADD CONSTRAINT criterioavaliacaodisciplina_disciplina_fk FOREIGN KEY (ed339_disciplina) REFERENCES disciplina;
ALTER TABLE criterioavaliacaoperiodoavaliacao ADD CONSTRAINT criterioavaliacaoperiodoavaliacao_criterioavaliacao_fk FOREIGN KEY (ed340_criterioavaliacao) REFERENCES criterioavaliacao;
ALTER TABLE criterioavaliacaoperiodoavaliacao ADD CONSTRAINT criterioavaliacaoperiodoavaliacao_periodoavaliacao_fk FOREIGN KEY (ed340_periodoavaliacao) REFERENCES periodoavaliacao;
ALTER TABLE criterioavaliacaoturma ADD CONSTRAINT criterioavaliacaoturma_criterioavaliacao_fk FOREIGN KEY (ed341_criterioavaliacao) REFERENCES criterioavaliacao;
ALTER TABLE criterioavaliacaoturma ADD CONSTRAINT criterioavaliacaoturma_turma_fk FOREIGN KEY (ed341_turma) REFERENCES turma;


CREATE INDEX criterioavaliacaodisciplina_disciplina_in ON criterioavaliacaodisciplina(ed339_disciplina);
CREATE INDEX criterioavaliacaodisciplina_criterioavaliacao_in ON criterioavaliacaodisciplina(ed339_criterioavaliacao);
CREATE INDEX criterioavaliacaoperiodoavaliacao_periodoavaliacao_in ON criterioavaliacaoperiodoavaliacao(ed340_periodoavaliacao);
CREATE INDEX criterioavaliacaoperiodoavaliacao_criterioavaliacao_in ON criterioavaliacaoperiodoavaliacao(ed340_criterioavaliacao);
CREATE INDEX criterioavaliacaoturma_turma_in ON criterioavaliacaoturma(ed341_turma);
CREATE INDEX criterioavaliacaoturma_criterioavaliacao_in ON criterioavaliacaoturma(ed341_criterioavaliacao);

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

--87964

DROP TABLE if EXISTS w_87964_lote; 
CREATE TABLE w_87964_lote AS SELECT j34_idbql, j34_totcon FROM lote; 
UPDATE lote SET j34_totcon = round(j34_totcon,2);

--74216

CREATE SEQUENCE rhfundamentacaolegal_rh137_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE rhfundamentacaolegal(
rh137_sequencial    int4 NOT NULL default 0,
rh137_tipodocumentacao    int4 NOT NULL default 0,
rh137_numero    int4 NOT NULL default 0,
rh137_datainicio    date  default null,
rh137_datafim   date  default null,
rh137_descricao   text ,
CONSTRAINT rhfundamentacaolegal_sequ_pk PRIMARY KEY (rh137_sequencial));

ALTER TABLE rhrubricas
      ADD COLUMN rh27_rhfundamentacaolegal   int4 default 0;

-- 68921
ALTER TABLE configdbpref RENAME COLUMN w13_exigecpfcnpj TO w13_exigecpfcnpjmatricula;
ALTER TABLE configdbpref    ADD COLUMN w13_exigecpfcnpjinscricao boolean;

insert into db_confmensagem select 'alvara_cab_cpfcnpj',mens,alinhamento,instit from db_confmensagem where cod = 'alvara_cab';
insert into db_confmensagem select 'imovel_cab_cpfcnpj',mens,alinhamento,instit from db_confmensagem where cod = 'imovel_cab';
insert into db_confmensagem select 'alvara_rod_cpfcnpj',mens,alinhamento,instit from db_confmensagem where cod = 'alvara_rod';

-- 88594

DROP TABLE if EXISTS w_88594_rhgeracaofolhareg; 
CREATE TABLE w_88594_rhgeracaofolhareg AS SELECT rh104_sequencial, rh104_seqpes, rh104_instit, rh104_rhgeracaofolha,
                                                 rh104_vlrsalario, rh104_vlrliquido, rh104_vlrprovento, rh104_vlrdesconto 
                                            FROM rhgeracaofolhareg; 

alter table rhgeracaofolhareg alter COLUMN rh104_vlrsalario  type double precision;      
alter table rhgeracaofolhareg alter COLUMN rh104_vlrliquido  type double precision;
alter table rhgeracaofolhareg alter COLUMN rh104_vlrprovento type double precision;
alter table rhgeracaofolhareg alter COLUMN rh104_vlrdesconto type double precision;

UPDATE rhgeracaofolhareg SET rh104_vlrsalario  = round(rh104_vlrsalario,2),
                             rh104_vlrliquido  = round(rh104_vlrliquido,2),
                             rh104_vlrprovento = round(rh104_vlrprovento,2),
                             rh104_vlrdesconto = round(rh104_vlrdesconto,2);

-- 43916
ALTER TABLE cfiptu ADD COLUMN j18_templatecertidaoisencao int4 default null;

--91664

ALTER TABLE itbinome ALTER COLUMN it03_compl  TYPE varchar(100);

/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME A FIM
 * --------------------------------------------------------------------------------------------------------------------
 */


/**
 * Plugins
 */
create schema plugins;
create user plugin;

grant all on schema plugins to plugin;
select fc_grant_revoke('grant', 'plugin', 'select', '%', '%');