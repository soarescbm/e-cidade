

/**
 * Alteração para tabela pensao
 */

--DROP TABLE:
--Criando drop sequences
DROP SEQUENCE IF EXISTS pensao_r52_sequencial_seq;
DROP SEQUENCE IF EXISTS rhhistoricopensao_rh145_sequencial_seq;

-- Criando  sequences
CREATE SEQUENCE pensao_r52_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


CREATE SEQUENCE rhhistoricopensao_rh145_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

alter table pensao drop constraint if exists pensao_ae_me_reg_num_pk cascade;

alter table pensao add column r52_sequencial       int4 NOT NULL default nextval('pensao_r52_sequencial_seq'), 
                   add column r52_pagasuplementar  bool NOT NULL default 'false', 
                   add column r52_valorsuplementar float8 default 0,
                   add CONSTRAINT pensao_sequ_pk PRIMARY KEY (r52_sequencial);

CREATE UNIQUE INDEX pensao_anousu_mesusu_regist_numcgm_in ON pensao(r52_anousu,r52_mesusu,r52_regist,r52_numcgm);

ALTER TABLE pensaocontabancaria
ADD CONSTRAINT pensaocontabancaria_ae_mesusu_regist_numcgm_fk FOREIGN KEY (rh139_anousu, rh139_mesusu, rh139_regist, rh139_numcgm)
REFERENCES pensao(r52_anousu, r52_mesusu, r52_regist, r52_numcgm);

ALTER TABLE pensaoretencao
ADD CONSTRAINT pensaoretencao_ae_mesusu_regist_numcgm_fk FOREIGN KEY (rh77_anousu, rh77_mesusu, rh77_regist, rh77_numcgm)
REFERENCES pensao(r52_anousu, r52_mesusu, r52_regist, r52_numcgm);


CREATE TABLE rhhistoricopensao(
rh145_sequencial    int4 NOT NULL  default nextval('rhhistoricopensao_rh145_sequencial_seq'),
rh145_pensao        int4 NOT NULL ,
rh145_valor       float8 NOT NULL ,
rh145_rhfolhapagamento    int4 ,
CONSTRAINT rhhistoricopensao_sequ_pk PRIMARY KEY (rh145_sequencial));

ALTER TABLE rhhistoricopensao
ADD CONSTRAINT rhhistoricopensao_rhfolhapagamento_fk FOREIGN KEY (rh145_rhfolhapagamento)
REFERENCES rhfolhapagamento;

ALTER TABLE rhhistoricopensao
ADD CONSTRAINT rhhistoricopensao_pensao_fk FOREIGN KEY (rh145_pensao)
REFERENCES pensao;

CREATE  INDEX rhhistoricopensao_pensao_in ON rhhistoricopensao(rh145_pensao);
CREATE  INDEX rhhistoricopensao_rhfolhapagamento_in ON rhhistoricopensao(rh145_rhfolhapagamento);

/**
 * Criação da tabela folhapagamentogeracao
 */

DROP TABLE IF EXISTS folhapagamentogeracao CASCADE;
DROP SEQUENCE IF EXISTS folhapagamentogeracao_rh146_sequencial_seq;

CREATE SEQUENCE folhapagamentogeracao_rh146_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE folhapagamentogeracao(
rh146_sequencial		int4 NOT NULL  default nextval('folhapagamentogeracao_rh146_sequencial_seq'),
rh146_folhapagamento		int4 ,
CONSTRAINT folhapagamentogeracao_sequ_pk PRIMARY KEY (rh146_sequencial));

ALTER TABLE folhapagamentogeracao
ADD CONSTRAINT folhapagamentogeracao_folhapagamento_fk FOREIGN KEY (rh146_folhapagamento)
REFERENCES rhfolhapagamento;

CREATE  INDEX folhapagamentogeracao_rhfolhapagamento_in ON folhapagamentogeracao(rh146_folhapagamento);
CREATE  INDEX folhapagamentogeracao_sequencial_in ON folhapagamentogeracao(rh146_sequencial);

