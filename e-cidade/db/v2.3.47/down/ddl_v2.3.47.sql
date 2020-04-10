--
-- Versão: $Id: ddl_v2.3.47.sql,v 1.8 2016/01/26 11:57:56 dbtales.baz Exp $
--

-------------------------------------------------------------------------------------------------
-------------------------------- Folha de Pagamento (Pessoal/RH) --------------------------------
-------------------------------------------------------------------------------------------------

--DROP column/foreign keys from cfpess
ALTER TABLE cfpess
  drop column if exists r11_tabelavaloresrra;

--DROP TABLE:
DROP TABLE IF EXISTS lancamentorra CASCADE;
DROP TABLE IF EXISTS lancamentorraloteregistroponto CASCADE;
DROP TABLE IF EXISTS tipoassefinanceirorra CASCADE;
DROP TABLE IF EXISTS assentamentorra CASCADE;
DROP TABLE IF EXISTS db_faixavalores CASCADE;
DROP TABLE IF EXISTS db_tabelavalores CASCADE;
DROP TABLE IF EXISTS db_tabelavalorestipo CASCADE;
DROP TABLE IF EXISTS faixavaloresirrf CASCADE;
--Criando drop sequences
DROP SEQUENCE IF EXISTS lancamentorra_rh173_sequencial_seq;
DROP SEQUENCE IF EXISTS lancamentorraloteregistroponto_rh174_sequencial_seq;
DROP SEQUENCE IF EXISTS tipoassefinanceirorra_rh172_sequencial_seq;
DROP SEQUENCE IF EXISTS assentamentorra_h83_sequencial_seq;
DROP SEQUENCE IF EXISTS db_faixavalores_db150_sequencial_seq;
DROP SEQUENCE IF EXISTS db_tabelavalores_db149_sequencial_seq;
DROP SEQUENCE IF EXISTS db_tabelavalorestipo_db151_sequencial_seq;
DROP SEQUENCE IF EXISTS faixavaloresirrf_rh175_sequencial_seq;

delete from assenta where h16_assent in (select h12_codigo from tipoasse where h12_natureza = 3);
delete from tipoasse where h12_natureza = 3;
delete from naturezatipoassentamento where rh159_sequencial = 3;

---------------------------------------------------------------------------------------------
-------------------------------- INICIO TRIBUTARIO ------------------------------------------
---------------------------------------------------------------------------------------------

alter table pardiv drop column v04_cobrarjurosmultacda;

---------------------------------------------------------------------------------------------
---------------------------------- FIM TRIBUTARIO -------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
----------------------------------- INICIO EDUCACAO/SAUDE -----------------------------------------
---------------------------------------------------------------------------------------------------

select fc_executa_ddl('DROP TABLE IF EXISTS cadenderestadosistema CASCADE;');
select fc_executa_ddl('DROP SEQUENCE IF EXISTS cadenderestadosistema_db300_sequencial_seq;');

---------------------------------------------------------------------------------------------------
------------------------------------- FIM EDUCACAO/SAUDE ------------------------------------------
---------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------
-------------------------------- INICIO CONFIGURACAO ----------------------------------------
---------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS db_pluginmodulos;
DROP SEQUENCE IF EXISTS db_pluginmodulos_db152_sequencial_seq;

alter table if exists db_pluginitensmenu drop column if exists db146_uid;
alter table if exists db_pluginmodulos   drop column if exists db152_uid;
---------------------------------------------------------------------------------------------
---------------------------------- FIM CONFIGURACAO -----------------------------------------
---------------------------------------------------------------------------------------------
