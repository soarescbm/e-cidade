---------------------------------------------------------------------------------------------
-------------------------------- INCIO FINANCEIRO -------------------------------------------
---------------------------------------------------------------------------------------------

drop table if exists classificacaocredoresempenho;
drop table if exists classificacaocredores;
drop sequence if exists classificacaocredoresempenho_cc31_sequencial_seq;
drop sequence if exists classificacaocredores_cc30_codigo_seq;

alter table empnota drop column if EXISTS e69_dtvencimento;
alter table empnota drop column if EXISTS e69_localrecebimento;

drop table if exists empagemovjustificativa;
drop sequence if exists empagemovjustificativa_e09_sequencial_seq;

delete from vinculoeventoscontabeis where c115_conhistdocinclusao between 2007 and 2020;
delete from conhistdoc where c53_coddoc between 2007 and 2020 ;


ALTER TABLE conhistdoc ALTER COLUMN c53_descr TYPE VARCHAR(50);

ALTER TABLE IF EXISTS inscricaorestosapagar RENAME TO inscricaorestosapagarnaoprocessados;
ALTER TABLE IF EXISTS inscricaorestosapagarnaoprocessados DROP COLUMN c107_tipo;
alter table inscricaorestosapagarnaoprocessados rename CONSTRAINT inscricaorestosapagar_instit_fk to inscricaorestosapagarnaoprocessados_instit_fk ;
alter table inscricaorestosapagarnaoprocessados rename CONSTRAINT inscricaorestosapagar_usuario_fk to inscricaorestosapagarnaoprocessados_usuario_fk;
alter table inscricaorestosapagarnaoprocessados rename CONSTRAINT inscricaorestosapagar_sequ_pk to inscricaorestosapagarnaoprocessados_sequ_pk;
alter index IF EXISTS inscricaorestosapagar_instit_in rename to inscricaorestosapagarnaoprocessados_instit_in;
alter index IF EXISTS inscricaorestosapagar_usuario_in rename to inscricaorestosapagarnaoprocessados_usuario_in;
ALTER SEQUENCE IF EXISTS inscricaorestosapagar_c107_sequencial_seq RENAME TO inscricaorestosapagarnaoprocessados_c107_sequencial_seq;

alter table IF EXISTS conlancaminscrestosapagar rename to conlancaminscrestosapagarnaoprocessados;
alter table IF EXISTS conlancaminscrestosapagarnaoprocessados rename column  c108_inscricaorestosapagar to c108_inscricaorestosapagarnaoprocessados;
alter table conlancaminscrestosapagarnaoprocessados rename CONSTRAINT conlancaminscrestosapagar_codlan_fk to conlancaminscrestosapagarnaoprocessados_codlan_fk;
alter table conlancaminscrestosapagarnaoprocessados rename CONSTRAINT conlancaminscrestosapagar_inscricaorestosapagarna to conlancaminscrestosapagarnaoprocessados_inscricaorestosapagarna;
alter table conlancaminscrestosapagarnaoprocessados rename CONSTRAINT conlancaminscrestosapagar_sequ_pk to conlancaminscrestosapagarnaoprocessados_sequ_pk;
alter index IF EXISTS conlancaminscrestosapagar_codlan_in rename to conlancaminscrestosapagarnaoprocessados_codlan_in;
alter index IF EXISTS conlancaminscrestosapagar_inscricaorestosapagarna rename to conlancaminscrestosapagarnaoprocessados_inscricaorestosapagarna;
ALTER SEQUENCE IF EXISTS conlancaminscrestosapagar_c108_sequencial_seq rename to conlancaminscrestosapagarnaoprocessados_c108_sequencial_seq;
---------------------------------------------------------------------------------------------
-------------------------------- FIM FINANCEIRO---------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-------------------------------- INICIO CONFIGURACAO ----------------------------------------
---------------------------------------------------------------------------------------------

alter table db_usuarios drop column dataexpira;

---------------------------------------------------------------------------------------------
-------------------------------- FIM CONFIGURACAO -------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
----------------------------------- INICIO EDUCACAO/SAUDE -----------------------------------------
---------------------------------------------------------------------------------------------------

ALTER TABLE diarioavaliacaoalternativa DROP CONSTRAINT diarioavaliacaoalternativa_diario_fk;
ALTER TABLE diarioavaliacaoalternativa DROP CONSTRAINT diarioavaliacaoalternativa_procavalalternativa_fk;
DROP SEQUENCE IF EXISTS diarioavaliacaoalternativa_ed136_sequencial_seq;
DROP TABLE IF EXISTS diarioavaliacaoalternativa CASCADE;

alter table lab_exame add column la08_t_diagnostico text;
alter table lab_exame drop column la08_observacao;


alter table tipoausencia add column ed320_licenca boolean default false;
update tipoausencia set ed320_licenca = true where ed320_tipo = 2;
alter table tipoausencia drop column ed320_tipo;

DROP TABLE IF EXISTS rechumanoausente CASCADE;
DROP SEQUENCE IF EXISTS rechumanoausente_ed348_sequencial_seq;

DROP TABLE IF EXISTS medicamentoslaboratorio CASCADE;
DROP TABLE IF EXISTS medicamentoslaboratoriorequiitem CASCADE;
DROP SEQUENCE IF EXISTS medicamentoslaboratorio_la43_sequencial_seq;
DROP SEQUENCE IF EXISTS medicamentoslaboratoriorequiitem_la44_sequencial_seq;

ALTER TABLE justificativa DROP COLUMN ed06_abreviatura;

update tipohoratrabalho set ed128_abreviatura = 'NORMAL' where ed128_codigo = 1;

---------------------------------------------------------------------------------------------------
----------------------------------- FIM EDUCACAO/SAUDE --------------------------------------------
---------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------
----------------------------------- INICIO FOLHA --------------------------------------------------
---------------------------------------------------------------------------------------------------

DROP SEQUENCE IF EXISTS tipoassecontrolediasmes_rh170_sequencial_seq;
DROP table IF EXISTS tipoassecontrolediasmes;
DROP TABLE IF EXISTS codigoclienterefeisul CASCADE;
DROP SEQUENCE IF EXISTS codigoclienterefeisul_rh171_sequencial_seq;

---------------------------------------------------------------------------------------------------
----------------------------------- FIMFOLHA ------------------------------------------------------
---------------------------------------------------------------------------------------------------