/**
 * db/v2.3.56/down/ddl_v2.3.56.sql - $Id: ddl_v2.3.56.sql,v 1.24 2016/10/31 19:34:30 dbmauricio Exp $
 */
---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO TRIBUTARIO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
-- Exclusões da tabela diversoslancamentotaxa
DROP TABLE IF EXISTS diversoslancamentotaxa;
DROP SEQUENCE IF EXISTS diversoslancamentotaxa_dv14_sequencial_seq;

--Exclusões da tabela lancamentotaxadiversos
DROP TABLE IF EXISTS fiscal.lancamentotaxadiversos;
DROP SEQUENCE IF EXISTS fiscal.lancamentotaxadiversos_y120_sequencial_seq;

--Exclusões da tabela taxadiversos
DROP TABLE IF EXISTS fiscal.taxadiversos;
DROP SEQUENCE IF EXISTS fiscal.taxadiversos_y119_sequencial_seq;

--Exclusões da tabela grupotaxadiversos
DROP TABLE IF EXISTS fiscal.grupotaxadiversos;
DROP SEQUENCE IF EXISTS fiscal.grupotaxadiversos_y118_sequencial_seq;

--Exclusões da tabela taxavaloresreferencia
DROP TABLE IF EXISTS fiscal.taxavaloresreferencia;
DROP SEQUENCE IF EXISTS fiscal.taxavaloresreferencia_y121_sequencial_seq;

-- Água: Contrato
alter table agua.aguacontrato drop column if exists x54_condominio;
alter table agua.aguacontrato drop column if exists x54_aguatipocontrato;
alter table agua.aguacontrato alter column x54_aguacategoriaconsumo set not null;

-- Água: Tipos de Contrato
drop table if exists agua.aguatipocontrato;
drop sequence if exists agua.aguatipocontrato_x39_sequencial_seq;

-- Água: Cadastro de Economias
drop table if exists agua.aguacontratoeconomia;
drop sequence if exists agua.aguacontratoeconomia_x38_sequencial_seq;

-- Água: Isenções
drop table if exists agua.aguaisencaocgm;
drop sequence if exists agua.aguaisencaocgm_x56_sequencial_seq;

-- Cobrança Registrada
drop table if exists caixa.reciboregistra cascade;
drop table if exists caixa.remessacobrancaregistradarecibo cascade;
drop table if exists caixa.remessacobrancaregistrada cascade;

drop sequence if exists caixa.remessacobrancaregistrada_k147_sequencial_seq;
drop sequence if exists caixa.remessacobrancaregistradarecibo_k148_sequencial_seq;

select fc_executa_ddl($$
  alter table conveniocobranca drop column ar13_contabancaria;
$$);

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
----------------------------------------- INICIO EDUCACAO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
------------------------------------------- FIM EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
----------------------------------------- INICIO FOLHA --------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS pontosalariodatalimite CASCADE;
DROP SEQUENCE IF EXISTS pontosalariodatalimite_rh183_sequencial_seq;
ALTER TABLE rhrubricas drop column if exists rh27_periodolancamento;
---------------------------------------------------------------------------------------------------------------
------------------------------------------- FIM FOLHA ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
------------------------------------------- INICIO CONFIGURACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

  -- avaliacaoquestionarioiterno
    DROP TABLE IF EXISTS configuracoes.avaliacaoquestionariointerno CASCADE;
    DROP SEQUENCE IF EXISTS configuracoes.avaliacaoquestionariointerno_db170_sequencial_seq;
  --

  -- avaliacaoquestionariomenu
    DROP TABLE IF EXISTS configuracoes.avaliacaoquestionariointernomenu CASCADE;
    DROP SEQUENCE IF EXISTS configuracoes.avaliacaoquestionariointernomenu_db171_sequencial_seq;
  --
  select fc_executa_ddl('ALTER TABLE avaliacaopergunta ALTER COLUMN db103_descricao TYPE varchar(200);');
---------------------------------------------------------------------------------------------------------------
--------------------------------------------- FIM CONFIGURACAO -------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
