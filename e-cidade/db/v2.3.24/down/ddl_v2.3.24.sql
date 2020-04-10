/**
 * Arquivo ddl que desfaz alterações do ddl up
 */
DROP SEQUENCE IF EXISTS turmacenso_ed342_sequencial_seq;
DROP SEQUENCE IF EXISTS turmacensoturma_ed343_sequencia_seq;
DROP TABLE IF EXISTS turmacenso CASCADE;
DROP TABLE IF EXISTS turmacensoturma CASCADE;

INSERT INTO rechumanonecessidade SELECT * FROM w_rechumanonecessidade;
DROP TABLE IF EXISTS w_rechumanonecessidade;

update atividaderh
   set ed01_funcaoatividade = 0
  from w_atividaderh_docencia
 where w_atividaderh_docencia.ed01_i_codigo = atividaderh.ed01_i_codigo;
alter table atividaderh drop column ed01_funcaoatividade;
DROP TABLE IF EXISTS w_atividaderh_docencia;


delete from db_menu      where id_item_filho in (9951, 9950, 9949, 9948);
delete from db_itensmenu where id_item in (9951, 9950, 9949, 9948);

/**
 * Estrutura turmaachorarioprofissional
 */
drop index turmaachorarioprofissional_turmaac_in;
drop index turmaachorarioprofissional_funcaoatividade_in;
drop index turmaachorarioprofissional_diasemana_in;

alter table turmaachorarioprofissional drop constraint turmaachorarioprofissional_rechumano_fk;
alter table turmaachorarioprofissional drop constraint turmaachorarioprofissional_funcaoatividade_fk;
alter table turmaachorarioprofissional drop constraint turmaachorarioprofissional_diasemana_fk;
alter table turmaachorarioprofissional drop constraint turmaachorarioprofissional_turmaac_fk;
alter table turmaachorarioprofissional drop constraint turmaachorarioprofissional_sequ_pk;

drop table turmaachorarioprofissional;

drop sequence turmaachorarioprofissional_ed346_sequencial_seq;

/**
 * Estrutura turmaoutrosprofissionais
 */
drop index turmaoutrosprofissionais_turma_in;
drop index turmaoutrosprofissionais_rechumano_in;
drop index turmaoutrosprofissionais_funcaoatividade_in;

alter table turmaoutrosprofissionais drop constraint turmaoutrosprofissionais_funcaoatividade_fk;
alter table turmaoutrosprofissionais drop constraint turmaoutrosprofissionais_rechumano_fk;
alter table turmaoutrosprofissionais drop constraint turmaoutrosprofissionais_turma_fk;
alter table turmaoutrosprofissionais drop constraint turmaoutro ;rosprofissionais_sequ_pk;

drop table turmaoutrosprofissionais;

drop sequence turmaoutrosprofissionais_ed347_sequencial_seq;


update escola.turmaacativ set ed267_i_censoativcompl= '11001' where ed267_i_censoativcompl = 11009;
update escola.turmaacativ set ed267_i_censoativcompl= '12001' where ed267_i_censoativcompl = 19999;
update escola.turmaacativ set ed267_i_censoativcompl= '14003' where ed267_i_censoativcompl = 14004;
update escola.turmaacativ set ed267_i_censoativcompl= '31009' where ed267_i_censoativcompl = 39999;
update escola.turmaacativ set ed267_i_censoativcompl= '31010' where ed267_i_censoativcompl = 14201;
update escola.turmaacativ set ed267_i_censoativcompl= '41006' where ed267_i_censoativcompl = 49999;
update escola.turmaacativ set ed267_i_censoativcompl= '51001' where ed267_i_censoativcompl = 13999;
update escola.turmaacativ set ed267_i_censoativcompl= '51002' where ed267_i_censoativcompl = 13104;
update escola.turmaacativ set ed267_i_censoativcompl= '51003' where ed267_i_censoativcompl = 13101;
update escola.turmaacativ set ed267_i_censoativcompl= '51004' where ed267_i_censoativcompl = 13999;
update escola.turmaacativ set ed267_i_censoativcompl= '59999' where ed267_i_censoativcompl = 13999;
update escola.turmaacativ set ed267_i_censoativcompl= '61001' where ed267_i_censoativcompl = 14999;
update escola.turmaacativ set ed267_i_censoativcompl= '61006' where ed267_i_censoativcompl = 14202;
update escola.turmaacativ set ed267_i_censoativcompl= '61007' where ed267_i_censoativcompl = 14999;
update escola.turmaacativ set ed267_i_censoativcompl= '69999' where ed267_i_censoativcompl = 14999;
update escola.turmaacativ set ed267_i_censoativcompl= '71001' where ed267_i_censoativcompl = 71007;
update escola.turmaacativ set ed267_i_censoativcompl= '71003' where ed267_i_censoativcompl = 71007;
update escola.turmaacativ set ed267_i_censoativcompl= '71004' where ed267_i_censoativcompl = 71007;
update escola.turmaacativ set ed267_i_censoativcompl= '71006' where ed267_i_censoativcompl = 71007;
update escola.turmaacativ set ed267_i_censoativcompl= '10101' where ed267_i_censoativcompl = 10103;
update escola.turmaacativ set ed267_i_censoativcompl= '10102' where ed267_i_censoativcompl = 14106;
update escola.turmaacativ set ed267_i_censoativcompl= '10999' where ed267_i_censoativcompl = 10999;
update escola.turmaacativ set ed267_i_censoativcompl= '11101' where ed267_i_censoativcompl = 14104;
update escola.turmaacativ set ed267_i_censoativcompl= '11102' where ed267_i_censoativcompl = 14103;
update escola.turmaacativ set ed267_i_censoativcompl= '11103' where ed267_i_censoativcompl = 14102;
update escola.turmaacativ set ed267_i_censoativcompl= '11104' where ed267_i_censoativcompl = 14105;
update escola.turmaacativ set ed267_i_censoativcompl= '11105' where ed267_i_censoativcompl = 14101;
update escola.turmaacativ set ed267_i_censoativcompl= '11999' where ed267_i_censoativcompl = 14999;
update escola.turmaacativ set ed267_i_censoativcompl= '12101' where ed267_i_censoativcompl = 13201;

delete from escola.turmaacativ where ed267_i_censoativcompl in(12003,12004,12005,12006,12007,11007,11008,11007,11006,
                                                               11010,12003,12004,12005,12006,12007,22018,22019,22020,
                                                               22027,22028,22014,22021,22013,22025,22026,22022,22023,
                                                               22030,22031,22011,22015,22016);

insert into escola.turmaacativ select * from w_criacaoatividadescomplementares;
drop table w_criacaoatividadescomplementares;