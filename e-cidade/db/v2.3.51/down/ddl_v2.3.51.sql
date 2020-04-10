---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO FOLHA ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
ALTER TABLE avaliacaopergunta DROP COLUMN IF EXISTS db103_tipo;
ALTER TABLE avaliacaopergunta DROP COLUMN IF EXISTS db103_mascara ;
DROP TABLE IF EXISTS rhconsignacaobancolayout CASCADE;
DROP SEQUENCE IF EXISTS rhconsignacaobancolayout_rh178_sequencial_seq;

alter table rhconsignadomovimento drop column if exists rh151_arquivo;
alter table rhconsignadomovimento drop column if exists rh151_banco;


---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO FINANCEIRO ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
select fc_executa_ddl('alter table acordocomissaomembro drop ac07_datainicio');
select fc_executa_ddl('alter table acordocomissaomembro drop ac07_datatermino');
select fc_executa_ddl('alter table acordoposicao drop ac26_tipooperacao');

drop table if exists acordoencerramentolicitacon;
drop sequence if exists acordoencerramentolicitacon_ac58_sequencial_seq;

-- Campo Ano do Exercício na Tabela acordoempempenho
select fc_executa_ddl('alter table acordoempempenho drop column if exists ac54_ano;');

-- Campo Unidade da autorização de empenho
alter table empautitem drop constraint if exists empautitem_matunid_fk;
alter table empautitem drop column if exists e55_matunid;

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
delete from funcaoatividade where ed119_sequencial in (5,6);
drop index if exists ensino_censocursoprofiss_in;
alter table ensino drop column if exists ed10_censocursoprofiss;
alter table escola alter COLUMN ed18_latitude type varchar(10), alter COLUMN ed18_longitude type varchar(10);

---------------------------------------------------------------------------------------------------------------
------------------------------------------- INICIO SAUDE ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS agendasaidapassagemdestino CASCADE;
DROP TABLE IF EXISTS passagemdestino CASCADE;

DROP SEQUENCE IF EXISTS agendasaidapassagemdestino_tf38_sequencial_seq;
DROP SEQUENCE IF EXISTS passagemdestino_tf37_sequencial_seq;

alter table tfd_agendasaida drop column tf17_tiposaida;