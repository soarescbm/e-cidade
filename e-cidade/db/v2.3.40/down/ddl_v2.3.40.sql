----------------------------------------------------------------------------------------------
----------------------------------------- TIME FOLHA -----------------------------------------
----------------------------------------------------------------------------------------------

select fc_executa_ddl('ALTER TABLE tipoasse DROP COLUMN h12_pagacomportaria;');

DROP TABLE IF EXISTS agendaassentamento;

DROP SEQUENCE IF EXISTS agendaassentamento_h82_sequencial_seq;

--Remove coluna na tabela de configuração financeira de tipos de assentamentos
ALTER TABLE tipoassefinanceiro DROP column IF EXISTS rh165_datainicio;

----------------------------------------------------------------------------------------------
--------------------------------------- FIM TIME FOLHA ---------------------------------------
----------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------
-------------------------------- INICIO TIME EDUCAÇÃO / SAÚDE -------------------------------
---------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS descartemedicamento;

ALTER TABLE far_matersaude drop column fa01_medicamentos;
DROP TABLE IF EXISTS integracaohorus CASCADE;
DROP TABLE IF EXISTS medicamentos CASCADE;
DROP SEQUENCE IF EXISTS integracaohorus_fa59_codigo_seq;
DROP SEQUENCE IF EXISTS medicamentos_fa58_codigo_seq;

drop index prontprofatend_rhcbo_in;
ALTER TABLE prontprofatend DROP CONSTRAINT prontprofatend_rhcbo_fk;
alter table prontprofatend drop COLUMN s104_rhcbo;


DROP TABLE IF EXISTS matmaterconteudomaterial CASCADE;
DROP TABLE IF EXISTS administracaomedicamento CASCADE;
DROP TABLE IF EXISTS prontuarioadministracaomedicamento CASCADE;
DROP SEQUENCE IF EXISTS matmaterconteudomaterial_m08_codigo_seq;
DROP SEQUENCE IF EXISTS administracaomedicamento_sd105_codigo_seq;
DROP SEQUENCE IF EXISTS prontuarioadministracaomedicamento_sd106_codigo_seq;
DROP SEQUENCE IF EXISTS descartemedicamento_sd107_sequencial_seq;


---------------------------------------------------------------------------------------------
-------------------------------- FIM TIME EDUCAÇÃO / SAÚDE ----------------------------------
---------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------
-------------------------------- INICIO TRIBUTÁRIO ------------------------------------------
---------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS condicionantetipolicenca CASCADE;
DROP SEQUENCE IF EXISTS condicionantetipolicenca_am17_sequencial_seq;

alter table condicionante add am10_tipolicenca int4 default 0;

ALTER TABLE condicionante
ADD CONSTRAINT condicionante_tipolicenca_fk FOREIGN KEY (am10_tipolicenca)
REFERENCES tipolicenca;

ALTER TABLE condicionante DROP COLUMN if exists am10_vinculatodasatividades;

DROP SEQUENCE IF EXISTS zonas_j50_zona_seq;

---------------------------------------------------------------------------------------------
-------------------------------- FIM TRIBUTÁRIO  --------------------------------------------
---------------------------------------------------------------------------------------------

ALTER TABLE db_relatorio ALTER COLUMN db63_nomerelatorio TYPE VARCHAR(50);

alter table veicretirada drop column ve60_passageiro;