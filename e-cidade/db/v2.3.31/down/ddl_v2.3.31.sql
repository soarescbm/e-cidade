/**
 * Alteração para tabela pensao
 */

drop table IF EXISTS folhapensao cascade;

drop table if exists rhhistoricopensao cascade;

alter table pensao drop column if exists r52_sequencial, 
                   drop column if exists r52_pagasuplementar, 
                   drop column if exists r52_valorsuplementar,
                   drop CONSTRAINT if exists pensao_sequ_pk;


alter table pensao drop constraint if exists pensao_ae_me_reg_num_pk cascade;
alter table pensao add CONSTRAINT pensao_ae_me_reg_num_pk PRIMARY KEY (r52_anousu, r52_mesusu, r52_regist, r52_numcgm);

drop index    if exists pensao_anousu_mesusu_regist_numcgm_in cascade;
drop index    if exists rhhistoricopensao_pensao_in;
drop index    if exists rhhistoricopensao_rhfolhapagamento_in;
drop sequence if exists pensao_r52_sequencial_seq;
drop sequence if exists rhhistoricopensao_rh145_sequencial_seq;

ALTER TABLE pensaocontabancaria
ADD CONSTRAINT pensaocontabancaria_ae_mesusu_regist_numcgm_fk FOREIGN KEY (rh139_anousu, rh139_mesusu, rh139_regist, rh139_numcgm)
REFERENCES pensao(r52_anousu, r52_mesusu, r52_regist, r52_numcgm);

ALTER TABLE pensaoretencao
ADD CONSTRAINT pensaoretencao_ae_mesusu_regist_numcgm_fk FOREIGN KEY (rh77_anousu, rh77_mesusu, rh77_regist, rh77_numcgm)
REFERENCES pensao(r52_anousu, r52_mesusu, r52_regist, r52_numcgm);



/**
 * Criação da tabela folhapagamentogeracao
 */

DROP INDEX IF EXISTS pensao_anousu_mesusu_regist_numcgm_in;
DROP INDEX IF EXISTS folhapagamentogeracao_rhfolhapagamento_in;
DROP INDEX IF EXISTS folhapagamentogeracao_sequencial_in;

DROP TABLE IF EXISTS folhapagamentogeracao CASCADE;
DROP SEQUENCE IF EXISTS folhapagamentogeracao_rh146_sequencial_seq;

/**
 * Atualiza a ultima folha de pagamento para aberta, 
 * pois na migração da release 2.3.28 ela foi migrada como fechada.
 */
update rhfolhapagamento set rh141_aberto = true where rh141_sequencial = (select  max(rh141_sequencial) from rhfolhapagamento);