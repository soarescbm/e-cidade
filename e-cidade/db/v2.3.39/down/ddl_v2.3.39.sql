----------------------------------------------------------------------------------------------
----------------------------------------- TIME FOLHA -----------------------------------------
----------------------------------------------------------------------------------------------

drop table if exists w_assentadb_cadattdinamicovalorgrupo;
drop table if exists w_tipoassedb_cadattdinamico;

select fc_executa_ddl('create table w_assentadb_cadattdinamicovalorgrupo as
select h80_db_cadattdinamicovalorgrupo as db_cadattdinamicovalorgrupo,
       h80_assenta                     as assenta
  from assentadb_cadattdinamicovalorgrupo;');


select fc_executa_ddl('create table w_tipoassedb_cadattdinamico  as
select h79_db_cadattdinamico as db_caddinamico,
       h79_tipoassse         as tipoasse
  from tipoassedb_cadattdinamico;');

DROP TABLE IF EXISTS tipoassedb_cadattdinamico;
DROP TABLE IF EXISTS assentadb_cadattdinamicovalorgrupo;
DROP TABLE IF EXISTS tipoassefinanceiro;
DROP TABLE IF EXISTS db_formulas;

DROP SEQUENCE IF EXISTS db_formulas_db148_sequencial_seq;
DROP SEQUENCE IF EXISTS tipoassefinanceiro_rh165_sequencial_seq;

DROP TABLE IF EXISTS tipoasseexterno;
DROP TABLE IF EXISTS situacaoafastamento;

DROP SEQUENCE IF EXISTS tipoasseexterno_rh167_sequencial_seq;
DROP SEQUENCE IF EXISTS situacaoafastamento_rh166_sequencial_seq;

DROP TABLE IF EXISTS afastaassenta;

alter table rhPessoalmov drop column if exists rh02_diasgozoferias;
----------------------------------------------------------------------------------------------
--------------------------------------- FIM TIME FOLHA ---------------------------------------
----------------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------------
--------------------------------------- TRIBUTARIO ---------------------------------------
----------------------------------------------------------------------------------------------

alter table cartorio drop COLUMN if exists v82_extrajudicial;

DROP TABLE IF EXISTS certidcartorio CASCADE;
DROP TABLE IF EXISTS certidmovimentacao CASCADE;

DROP SEQUENCE IF EXISTS certidcartorio_v31_sequencial_seq;
DROP SEQUENCE IF EXISTS certidmovimentacao_v32_sequencial_seq;

DROP TABLE IF EXISTS certidcartoriorecibopaga CASCADE;
DROP SEQUENCE IF EXISTS certidcartoriorecibopaga_v33_sequencial_seq;

----------------------------------------------------------------------------------------------
--------------------------------------- FIM TRIBUTARIO ---------------------------------------
----------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------
--------------------------------------- INICIO EDUCACAO/SAUDE -----------------------------------
----------------------------------------------------------------------------------------------
-- SAÚDE
ALTER TABLE cgs_und ALTER COLUMN z01_i_familiamicroarea TYPE int4 USING (trim(z01_i_familiamicroarea::varchar))::integer;
ALTER TABLE ambulatorial.familiamicroarea ALTER COLUMN sd35_i_codigo TYPE int4 USING (trim(sd35_i_codigo::varchar))::integer;
select fc_executa_ddl('ALTER TABLE sau_prestadorvinculos RENAME COLUMN s111_procedimento TO s111_i_exame;');
select fc_executa_ddl('alter table sau_prestadorvinculos drop constraint sau_prestadorvinculos_procedimento_fk;');
select fc_executa_ddl('ALTER TABLE sau_prestadorvinculos
                         ADD CONSTRAINT sau_prestadorvinculos_exame_fk FOREIGN KEY (s111_i_exame)
                             REFERENCES sau_exames;');



DROP TABLE IF EXISTS ambulatorial.cgs_und_ext;

-------------------------------------------------------------------------------------------------
--------------------------------------- FIM EDUCACAO/SAUDE --------------------------------------
-------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------
--------------------------------------- INICIO FINANCEIRO ------------------------------------
----------------------------------------------------------------------------------------------

alter table acordoitemexecutado drop column if exists ac29_datainicial;
alter table acordoitemexecutado drop column if exists ac29_datafinal;
drop index if exists acordoitem_ordem_in;

alter table empagemovdetalhetransmissao drop column if exists e74_linhadigitavel;


----------------------------------------------------------------------------------------------
--------------------------------------- FIM FINANCEIRO ---------------------------------------
----------------------------------------------------------------------------------------------
