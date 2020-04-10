---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
alter table bib_parametros drop column if exists bi26_impressora;
DROP TABLE IF EXISTS idioma CASCADE;
DROP SEQUENCE IF EXISTS idioma_bi22_sequencial_seq;
alter table acervo drop column if exists  bi06_idioma;

ALTER TABLE if exists diarioresultado DROP COLUMN if exists ed73_valorreal RESTRICT;
ALTER TABLE if exists edu_parametros DROP COLUMN if exists ed233_apresentarnotaproporcional RESTRICT;
DROP TABLE if exists w_valor_real_diarioresultado;

---------------------------------------------------------------------------------------------------------------
----------------------------------------- FINAL EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO FINANCEIRO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

delete from db_layoutcampos where db52_layoutlinha in (851, 852, 853);
delete from db_layoutlinha  where db51_layouttxt = 256;
delete from db_layouttxt    where db50_codigo    = 256;

delete from db_layoutcampos where db52_layoutlinha in (854, 855, 856);
delete from db_layoutlinha  where db51_layouttxt = 257;
delete from db_layouttxt    where db50_codigo    = 257;

drop table if exists pagfornumeracao cascade;
drop sequence if exists pagfornumeracao_o152_sequencial_seq;

drop table if exists empenho.empagemovformapagamento;
drop sequence if exists empenho.empagemovformapagamento_e07_sequencial_seq;

---------------------------------------------------------------------------------------------------------------
------------------------------------------- FIM FINANCEIRO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------------- INICIO SAÚDE ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS horususuario CASCADE;
DROP SEQUENCE IF EXISTS horususuario_fa66_sequencial_seq;
---------------------------------------------------------------------------------------------------------------
--------------------------------------------- FINAL SAÚDE -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO TRIBUTARIO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
alter table cfiptu drop column if exists j18_receitacreditorecalculo,
                   drop column if exists j18_tipodebitorecalculo;


DROP SEQUENCE IF EXISTS abatimentocorrecao_k167_sequencial_seq;
DROP TABLE IF EXISTS abatimentocorrecao;

alter table abatimentoutilizacao drop if exists k157_observacao;
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FIM TRIBUTARIO -------------------------------------------------------
---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO FOLHA ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
select fc_executa_ddl('alter table rhpessoalmov drop column rh02_horasdiarias;');
select fc_executa_ddl('alter table rhpessoalmov drop column rh02_cedencia;');
select fc_executa_ddl('alter table rhpessoalmov drop column rh02_onus;');
select fc_executa_ddl('alter table rhpessoalmov drop column rh02_ressarcimento;');
select fc_executa_ddl('alter table rhpessoalmov drop column rh02_datacedencia ;');
select fc_executa_ddl('alter table rhpessoalmov drop column rh02_cnpjcedencia;');


---------------------------------------------------------------------------------------------------------------
---------------------------------------- FIM FOLHA -------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
