/**
 * Arquivo ddl que desfaz alteracoes do ddl up
 */
/**
 *  Time Tributário
 */
alter table db_usuarios drop column datatoken;
alter table db_usuarios alter column email type varchar(50);

/**
 * Tarefa 95807
 */
delete from db_itensmenu where id_item = 380;

/**
 *  Fim Time Tributário
 */

 /**
  * Time Financeiro
  */

  /**
   * tarefa 94752 {
   */

  drop sequence conlancaminstit_c02_sequencial_seq;
  drop table  conlancaminstit;
  drop index contacorrentedetalheconlancamval_c28_conlancamval_in;

  /**
   * }
   */

   /* 93465 { */


   /* } */

 /**
  * Fim Time Financeiro
  */


/**
 * Inicio Time C
 */

 --94091 - Entrega Resultado
alter table lab_entrega drop column la31_retiradopor;

-- 95325
alter table cgs_und alter column z01_v_mae drop not null;

update cgs_und
   set z01_v_mae = null
 where z01_v_mae = ' ';

-- 64998
alter table basemps drop column ed34_disiciplinaglobalizada;
alter table basemps drop column ed34_caracterreprobatorio;
alter table basemps drop column ed34_basecomum;

alter table regencia drop column ed59_caracterreprobatorio;
alter table regencia drop column ed59_basecomum;

alter table histmpsdisc drop column ed65_basecomum;
alter table histmpsdiscfora drop column ed100_basecomum;

drop table if exists w_basempsglob;
drop table if exists w_basempscaracterprobatorio;
drop table if exists w_regencia;

-- 94022 - BPA MAGNÉTICO
alter table lab_fechaconferencia drop column la58_gerado;

/**
 * Fim Time C
 */

----------------------------------------------------
---- TIME FOLHA DE PAGAMENTO
----------------------------------------------------
---- Tarefa 92468
----------------------------------------------------
create temp table down_migracao_contabancaria as
select distinct contabancaria.*
  from contabancaria
 inner join rhpessoalmovcontabancaria on db83_sequencial = rh138_contabancaria;


create temp table down_migracao_rhpessoalmovcontabancaria as
select * from rhpessoalmovcontabancaria;

delete from rhpessoalmovcontabancaria;

delete from contabancaria
 using down_migracao_rhpessoalmovcontabancaria
 where db83_sequencial = rh138_contabancaria;

delete from bancoagencia
 using down_migracao_contabancaria
 where db89_sequencial = db83_bancoagencia;

drop table if exists w_migracao_rhpesbanco_bancoagencia;
drop table if exists w_migracao_rhpesbanco_contabancaria;
drop table if exists down_migracao_contabancaria;
drop table if exists down_migracao_rhpessoalmovcontabancaria;

drop sequence if exists rhpessoalmovcontabancaria_rh138_sequencial_seq;
drop table if exists rhpessoalmovcontabancaria;
drop index if exists rhpessoalmovcontabancaria_rhpessoalmov_contabancaria_in;
drop index if exists rhpessoalmovcontabancaria_contabancaria_in;
drop index if exists rhpessoalmovcontabancaria_rhpessoalmov_in;

drop sequence if exists pensaocontabancaria_rh139_sequencial_seq;
drop table if exists pensaocontabancaria;
drop index if exists pensaocontabancaria_contabancaria_in;
drop index if exists pensaocontabancaria_numcgm_in;
drop index if exists pensaocontabancaria_regist_in;
drop index if exists pensaocontabancaria_regist_contabancaria_in;


create temp table down_migracao_pensaocontabancaria as
select * from pensaocontabancaria;

delete from pensaocontabancaria;

delete from contabancaria
 using down_migracao_pensaocontabancaria
 where db83_sequencial = rh139_contabancaria;

delete from bancoagencia
 using down_migracao_pensao_contabancaria
 where db89_sequencial = db83_bancoagencia;

drop table if exists w_migracao_pensao_bancoagencia;
drop table if exists w_migracao_pensao_contabancaria;
drop table if exists down_migracao_pensao_contabancaria;
drop table if exists down_migracao_pensaocontabancaria;

drop sequence if exists pensaocontabancaria_rh139_sequencial_seq;
drop table if exists pensaocontabancaria;
drop index if exists pensaocontabancaria_contabancaria_in;
drop index if exists pensaocontabancaria_numcgm_in;
drop index if exists pensaocontabancaria_regist_in;
drop index if exists pensaocontabancaria_regist_contabancaria_in;

/***************************************************************/
/************************* INTEGRAÇÃO **************************/
/***************************************************************/

alter table db_logsacessa drop column auditoria;
/**
 * Time Tributário
 */

/**
 * Inicio Tarefa 83872
 */

alter table itbi drop column it01_percentualareatransmitida;
alter table paritbi drop column it24_cgmobrigatorio;

/**
 * Fim Tarefa 83872
 */

/**
 * Inicio Tarefa 52990
 */

alter table parfiscal drop column y32_templatealvarasanitariopermanente;
alter table parfiscal drop column y32_templatealvarasanitarioprovisorio;

/**
 * Fim Tarefa 52990
 */

/**
 * Inicio Tarefa 92906
 */

ALTER TABLE itbicancela DROP CONSTRAINT itbicancela_usuario_fk;
ALTER TABLE itbicancela DROP COLUMN it16_id_usuario;

/**
 * Fim Tarefa 92906
 */

/**
 * Fim Time Tributário
 */
