/**
 * Arquivo ddl up
 */

/**
 *  Time Tributário
 */

alter table db_usuarios add column datatoken date;
update db_usuarios usuarios
   set datatoken = case when z01_cadast is not null then z01_cadast
                        when z01_ultalt is not null then z01_ultalt else now()::date end
                   from cgm cgm
                  inner join db_usuacgm usuacgm on usuacgm.cgmlogin = cgm.z01_numcgm
                  where usuarios.id_usuario = usuacgm.id_usuario;
update db_usuarios set datatoken = now()::date where datatoken is null;
alter table db_usuarios alter column datatoken set not null;
alter table db_usuarios alter column email type varchar(200);

/**
 *  Fim Time Tributário
 */



 /**
  * Time Financeiro
  */

  /**
   * tarefa 94752 {
   */

  CREATE SEQUENCE conlancaminstit_c02_sequencial_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

  CREATE TABLE conlancaminstit(
  c02_sequencial    int4 NOT NULL default 0,
  c02_codlan    int4 NOT NULL default 0,
  c02_instit    int4 default 0,
  CONSTRAINT conlancaminstit_sequ_pk PRIMARY KEY (c02_sequencial));

  ALTER TABLE conlancaminstit
  ADD CONSTRAINT conlancaminstit_instit_fk FOREIGN KEY (c02_instit)
  REFERENCES db_config;

  ALTER TABLE conlancaminstit
  ADD CONSTRAINT conlancaminstit_codlan_fk FOREIGN KEY (c02_codlan)
  REFERENCES conlancam;

  CREATE INDEX conlancaminstit_c02_instit_in ON conlancaminstit(c02_instit);
  CREATE INDEX conlancaminstit_c02_codlan_in ON conlancaminstit(c02_codlan);

  create unique index conlancaminstit_c02_codlan_c02_instit_in on conlancaminstit (c02_codlan, c02_instit);

  insert into conlancaminstit
    select nextval('conlancaminstit_c02_sequencial_seq'),
           c70_codlan,
           (select c61_instit from conplanoreduz where ano_usu = c61_anousu and c69_debito = c61_reduz)
     from (
      select extract(year from c70_data) as ano_usu,
             c70_codlan, (select c69_debito from conlancamval where c69_codlan = c70_codlan limit 1)
        from conlancam
      ) as lancamento_conta;

      drop index if exists contacorrentedetalheconlancamval_c28_conlancamval_in;
      create index contacorrentedetalheconlancamval_c28_conlancamval_in on contabilidade.contacorrentedetalheconlancamval(c28_conlancamval);
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

alter table lab_entrega add column la31_retiradopor varchar (100);
create temp table w_lab_entrega as select la31_i_codigo, la31_i_cgs, z01_v_nome
                                     from lab_entrega
                                    inner join cgs_und on z01_i_cgsund = la31_i_cgs;

update lab_entrega set la31_retiradopor = z01_v_nome
  from w_lab_entrega
 where lab_entrega.la31_i_codigo = w_lab_entrega.la31_i_codigo;

alter table lab_entrega alter COLUMN la31_retiradopor set not null;

-- 95325
update cgs_und
   set z01_v_mae = ' '
 where z01_v_mae is null;

alter table cgs_und alter column z01_v_mae set not null;

-- 64998
alter table basemps add column ed34_disiciplinaglobalizada bool default false;
alter table basemps add column ed34_caracterreprobatorio bool default true;
alter table basemps add column ed34_basecomum bool default true;

create table w_basempsglob as select ed34_i_codigo from basemps
                                   inner join base on ed31_i_codigo = ed34_i_base
                                   inner join basediscglob on ed89_i_codigo = ed31_i_codigo
                             where ed31_c_contrfreq = 'G'
                               and ed89_i_disciplina = ed34_i_disciplina;

update basemps
   set ed34_disiciplinaglobalizada = 'true'
  from w_basempsglob
 where w_basempsglob.ed34_i_codigo = basemps.ed34_i_codigo;

create table w_basempscaracterprobatorio as select ed34_i_codigo from basemps where ed34_c_condicao = 'OP';

update basemps
   set ed34_caracterreprobatorio = 'false'
  from w_basempscaracterprobatorio
 where w_basempscaracterprobatorio.ed34_i_codigo = basemps.ed34_i_codigo;

alter table regencia add column ed59_caracterreprobatorio bool default true;
alter table regencia add column ed59_basecomum            bool default true;

create table w_regencia as select ed59_i_codigo from regencia where ed59_c_condicao = 'OP';

update regencia
   set ed59_caracterreprobatorio = 'false'
  from w_regencia
 where w_regencia.ed59_i_codigo = regencia.ed59_i_codigo;

alter table histmpsdisc add column ed65_basecomum bool default true;

alter table histmpsdiscfora add column ed100_basecomum bool default true;

-- 94022 - BPA MAGNÉTICO
alter table lab_fechaconferencia add column la58_gerado bool default false;

 ----------------------------------------------------
 ---- TIME FOLHA DE PAGAMENTO
 ----------------------------------------------------
 ---- Tarefa: 92468
 ----------------------------------------------------

CREATE SEQUENCE rhpessoalmovcontabancaria_rh138_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE rhpessoalmovcontabancaria(
rh138_sequencial      int4 NOT NULL default 0,
rh138_rhpessoalmov    int4 NOT NULL default 0,
rh138_contabancaria   int4 NOT NULL default 0,
rh138_instit          int4 default 0,
CONSTRAINT rhpessoalmovcontabancaria_sequ_pk PRIMARY KEY (rh138_sequencial));

ALTER TABLE rhpessoalmovcontabancaria
ADD CONSTRAINT rhpessoalmovcontabancaria_contabancaria_fk FOREIGN KEY (rh138_contabancaria)
REFERENCES contabancaria;

ALTER TABLE rhpessoalmovcontabancaria
ADD CONSTRAINT rhpessoalmovcontabancaria_rhpessoalmov_instit_fk FOREIGN KEY (rh138_rhpessoalmov,rh138_instit)
REFERENCES rhpessoalmov;

CREATE UNIQUE INDEX rhpessoalmovcontabancaria_rhpessoalmov_contabancaria_in ON rhpessoalmovcontabancaria(rh138_rhpessoalmov,rh138_contabancaria);
CREATE  INDEX rhpessoalmovcontabancaria_contabancaria_in ON rhpessoalmovcontabancaria(rh138_contabancaria);
CREATE  INDEX rhpessoalmovcontabancaria_rhpessoalmov_in ON rhpessoalmovcontabancaria(rh138_rhpessoalmov);

CREATE SEQUENCE pensaocontabancaria_rh139_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE pensaocontabancaria(
rh139_sequencial    int4 NOT NULL default 0,
rh139_regist    int4 NOT NULL default 0,
rh139_numcgm    int4 NOT NULL default 0,
rh139_anousu    int4 NOT NULL default 0,
rh139_mesusu    int4 NOT NULL default 0,
rh139_contabancaria   int4 default 0,
CONSTRAINT pensaocontabancaria_sequ_pk PRIMARY KEY (rh139_sequencial));

ALTER TABLE pensaocontabancaria
ADD CONSTRAINT pensaocontabancaria_ae_mesusu_regist_numcgm_fk FOREIGN KEY (rh139_anousu,rh139_mesusu,rh139_regist,rh139_numcgm)
REFERENCES pensao;

ALTER TABLE pensaocontabancaria
ADD CONSTRAINT pensaocontabancaria_contabancaria_fk FOREIGN KEY (rh139_contabancaria)
REFERENCES contabancaria;

CREATE  INDEX pensaocontabancaria_contabancaria_in               ON pensaocontabancaria(rh139_contabancaria);
CREATE  INDEX pensaocontabancaria_numcgm_in                      ON pensaocontabancaria(rh139_numcgm);
CREATE  INDEX pensaocontabancaria_regist_in                      ON pensaocontabancaria(rh139_regist);
CREATE UNIQUE INDEX pensaocontabancaria_regist_numcgm_anousu_mesusu_contabancaria_in ON pensaocontabancaria(rh139_regist,rh139_numcgm,rh139_anousu,rh139_mesusu,rh139_contabancaria);


update pensao set r52_codbco = '000' where r52_codbco not in ( select db90_codban from db_bancos );

update rhpesbanco set rh44_codban = '000' where rh44_codban not in ( select db90_codban from db_bancos );

--
-- Migração
--
 create table w_migracao_rhpesbanco_bancoagencia as
 select nextval('bancoagencia_db89_sequencial_seq'), *
   from (
     select count( rh44_seqpes ),
            rh44_codban,
            regexp_replace(trim(rh44_agencia),   '[a-zA-Z.]', '', 'g') as rh44_agencia,
            trim(rh44_dvagencia)                                       as rh44_dvagencia
       from rhpesbanco
      where regexp_replace(trim(rh44_agencia),   '[.]', '', 'g') not in ('', '.')
        and regexp_replace(trim(rh44_conta),     '[.]', '', 'g') not in ('', '.')
      group by rh44_codban, rh44_agencia, rh44_dvagencia
      order by 2, 3
        ) as x;

insert into bancoagencia
select nextval,
       rh44_codban,
       substr(rh44_agencia,   1,5),
       substr(rh44_dvagencia, 1,1)
  from w_migracao_rhpesbanco_bancoagencia;

create table w_migracao_rhpesbanco_contabancaria as
select  nextval('contabancaria_db83_sequencial_seq'), *
  from (
    select distinct
           z01_nome,
           w_agencia.nextval  as xxx,
           regexp_replace(trim(rh44_conta), '[a-zA-Z.]', '0', 'g') as rh44_conta,
           trim(substr(rh44_dvconta, 1,1))                        as rh44_dvconta,
          case when z01_cgccpf is null then '0' else z01_cgccpf end,
           ''                 as operacao,
           1                  as tipo_conta,
           false              as conta_plano
      from rhpesbanco
           inner join rhpessoalmov                                    on rh02_seqpes              = rh44_seqpes
           inner join rhpessoal                                       on rh02_regist              = rh01_regist
           inner join cgm                                             on rh01_numcgm              = z01_numcgm
           inner join w_migracao_rhpesbanco_bancoagencia as w_agencia on w_agencia.rh44_codban    = rhpesbanco.rh44_codban
                                                                     and w_agencia.rh44_agencia   = rhpesbanco.rh44_agencia
                                                                     and w_agencia.rh44_dvagencia = rhpesbanco.rh44_dvagencia
     where regexp_replace(trim(rh44_conta), '[a-zA-Z.]', '', 'g') not in ('', '.')
       ) as x;

insert into contabancaria select * from w_migracao_rhpesbanco_contabancaria;

insert into rhpessoalmovcontabancaria
select nextval('rhpessoalmovcontabancaria_rh138_sequencial_seq'), *
  from (
    select distinct rh44_seqpes, w_conta.nextval, rh02_instit
      from rhpesbanco
           inner join rhpessoalmov                                    on rh02_seqpes              = rh44_seqpes
           inner join rhpessoal                                       on rh02_regist              = rh01_regist
           inner join cgm                                             on rh01_numcgm              = z01_numcgm
           inner join w_migracao_rhpesbanco_bancoagencia as w_agencia on w_agencia.rh44_codban    = rhpesbanco.rh44_codban
                                                                     and w_agencia.rh44_agencia   = rhpesbanco.rh44_agencia
                                                                     and w_agencia.rh44_dvagencia = rhpesbanco.rh44_dvagencia
           inner join w_migracao_rhpesbanco_contabancaria as w_conta  on w_conta.z01_nome         = cgm.z01_nome
                                                                     and w_conta.xxx              = w_agencia.nextval
                                                                     and w_conta.rh44_conta       = rhpesbanco.rh44_conta
                                                                     and w_conta.rh44_dvconta     = rhpesbanco.rh44_dvconta
                                                                     and w_conta.z01_cgccpf       = cgm.z01_cgccpf
                                                                     and w_conta.operacao         = ''
                                                                     and w_conta.tipo_conta       = 1
                                                                     and w_conta.conta_plano      = false
       ) as x;


---
-- Migração da tabela pensao
-- Tarefa 94718
---
create table w_migracao_pensao_bancoagencia as
 select nextval('bancoagencia_db89_sequencial_seq'), *
   from (
     select count(r52_regist),
            r52_codbco,
            regexp_replace(trim(r52_codage),   '[a-zA-Z.]', '0', 'g') as r52_codage,
            trim(r52_dvagencia) as r52_dvagencia
       from pensao
      where regexp_replace(trim(r52_codage),   '[a-zA-Z.]', '', 'g') not in ('', '.')
        and regexp_replace(trim(r52_conta),    '[a-zA-Z.]', '', 'g') not in ('', '.')
      group by r52_codbco, r52_codage, r52_dvagencia
      order by 2, 3
 ) as x;

insert into bancoagencia
select nextval,
       r52_codbco,
       substr(r52_codage,   1,5),
       substr(r52_dvagencia, 1,1)
  from w_migracao_pensao_bancoagencia;

create table w_migracao_pensao_contabancaria as
select  nextval('contabancaria_db83_sequencial_seq'), *
  from (
    select distinct
           z01_nome,
           w_agencia.nextval  as xxx,
           regexp_replace(trim(r52_conta),  '[a-zA-Z.]', '0', 'g') as r52_conta,
           trim(substr(r52_dvconta, 1,1))     as r52_dvconta ,
          case when z01_cgccpf is null then '0' else z01_cgccpf end,
           ''                 as operacao,
           1                  as tipo_conta,
           false              as conta_plano
      from pensao
           inner join rhpessoal                                       on r52_regist              = rh01_regist
           inner join cgm                                             on rh01_numcgm             = z01_numcgm
           inner join w_migracao_pensao_bancoagencia                  as w_agencia on w_agencia.r52_codbco = pensao.r52_codbco
                                                                     and w_agencia.r52_codage    = pensao.r52_codage
                                                                     and w_agencia.r52_dvagencia = pensao.r52_dvagencia
     where regexp_replace(trim(r52_conta), '[a-zA-Z.]', '', 'g') not in ('', '.')
       ) as x;

insert into contabancaria select * from w_migracao_pensao_contabancaria;

insert into pensaocontabancaria
select nextval('pensaocontabancaria_rh139_sequencial_seq'), x.*
  from (
    select distinct r52_regist,r52_numcgm,r52_anousu,r52_mesusu, w_conta.nextval
      from pensao
           inner join rhpessoal                                       on r52_regist              = rh01_regist
           inner join cgm                                             on rh01_numcgm              = z01_numcgm
           inner join w_migracao_pensao_bancoagencia     as w_agencia on w_agencia.r52_codbco     = pensao.r52_codbco
                                                                     and w_agencia.r52_codage     = pensao.r52_codage
                                                                     and w_agencia.r52_dvagencia  = pensao.r52_dvagencia
           inner join w_migracao_pensao_contabancaria    as w_conta   on w_conta.z01_nome         = cgm.z01_nome
                                                                     and w_conta.xxx              = w_agencia.nextval
                                                                     and w_conta.r52_conta        = pensao.r52_conta
                                                                     and w_conta.r52_dvconta      = pensao.r52_dvconta
                                                                     and w_conta.z01_cgccpf       = cgm.z01_cgccpf
                                                                     and w_conta.operacao         = ''
                                                                     and w_conta.tipo_conta       = 1
                                                                     and w_conta.conta_plano      = false
       ) as x;




/***************************************************************/
/************************* INTEGRAÇÃO **************************/
/***************************************************************/

alter table db_logsacessa add column auditoria boolean default false;

create temp table w_logsacessa as select distinct logsacessa from db_auditoria where logsacessa is not null;
create index w_logsacessa_1 on w_logsacessa(logsacessa);
analyze w_logsacessa;
update db_logsacessa set auditoria = true where exists (select 1 from w_logsacessa where logsacessa = codsequen);


/**
 * Time Tributário
 */

/**
 * Inicio Tarefa 83872
 */

alter table itbi add column it01_percentualareatransmitida float8 default 0;
alter table paritbi add column it24_cgmobrigatorio bool default 'false';
update itbi set it01_percentualareatransmitida = (it01_areatrans*100) / it01_areaterreno where it01_areatrans <= it01_areaterreno and it01_areaterreno <> 0;
/**
 * Fim Tarefa 83872
 */

/**
 * Inicio Tarefa 52990
 */

alter table parfiscal add column y32_templatealvarasanitariopermanente int4;
alter table parfiscal add column y32_templatealvarasanitarioprovisorio int4;
/**
 * Fim Tarefa 52990
 */

/**
 * Inicio Tarefa 92906
 */


ALTER TABLE itbicancela ADD COLUMN it16_id_usuario int4;
update itbicancela
   set it16_id_usuario = it01_id_usuario
  from itbi
 where it01_guia = it16_guia;
ALTER TABLE itbicancela alter column it16_id_usuario set not null;
ALTER TABLE itbicancela
 ADD CONSTRAINT itbicancela_usuario_fk FOREIGN KEY (it16_id_usuario)
 REFERENCES db_usuarios;

/**
 * Fim Tarefa 92906
 */

/**
 * Tarefa 95807
 */
delete from db_itensmenu where id_item = 380;
insert into db_itensmenu values(380, 'Manutenção de Calendário', 'Manutenção de Calendario', 'cai1_calend001.php', 1, 1, null, true);

/**
 * Fim Time Tributário
 */
