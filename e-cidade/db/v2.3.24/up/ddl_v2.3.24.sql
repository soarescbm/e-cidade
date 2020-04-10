/**
 * Arquivo ddl da versão 2.3.24
 */
CREATE SEQUENCE turmacenso_ed342_sequencial_seq INCREMENT 1 MINVALUE 1  MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE turmacensoturma_ed343_sequencia_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE turmacenso(
ed342_sequencial int4 NOT NULL default 0,
ed342_censoetapa int4 NOT NULL default 0,
ed342_nome varchar(80) ,
CONSTRAINT turmacenso_sequ_pk PRIMARY KEY (ed342_sequencial));

CREATE TABLE turmacensoturma(
ed343_sequencia int4 NOT NULL default 0,
ed343_turmacenso int4 NOT NULL default 0,
ed343_turma int4 NOT NULL default 0,
ed343_principal bool default 'f',
CONSTRAINT turmacensoturma_sequ_pk PRIMARY KEY (ed343_sequencia));

ALTER TABLE turmacenso ADD CONSTRAINT turmacenso_censoetapa_fk FOREIGN KEY (ed342_censoetapa) REFERENCES censoetapa;
ALTER TABLE turmacensoturma ADD CONSTRAINT turmacensoturma_turma_fk FOREIGN KEY (ed343_turma) REFERENCES turma;
ALTER TABLE turmacensoturma ADD CONSTRAINT turmacensoturma_turmacenso_fk FOREIGN KEY (ed343_turmacenso)  REFERENCES turmacenso;

CREATE INDEX turmacenso_censoetapa_in ON turmacenso(ed342_censoetapa);
CREATE INDEX turmacensoturma_turma_in ON turmacensoturma(ed343_turma);
CREATE INDEX turmacensoturma_turmacenso_in ON turmacensoturma(ed343_turmacenso);

CREATE TABLE w_rechumanonecessidade AS SELECT * FROM rechumanonecessidade WHERE ed310_necessidade > 108;
DELETE FROM rechumanonecessidade WHERE ed310_necessidade > 108;

alter table atividaderh add column ed01_funcaoatividade int not null default 0;
alter table atividaderh add constraint atividaderh_funcaoatividade_fk foreign key (ed01_funcaoatividade) references funcaoatividade;
create table w_atividaderh_docencia as
       select ed01_i_codigo
         from atividaderh
        where ed01_c_docencia = 'S';

update atividaderh
   set ed01_funcaoatividade = 1
  from w_atividaderh_docencia
 where w_atividaderh_docencia.ed01_i_codigo = atividaderh.ed01_i_codigo;


/**
 * Estrutura turmaachorarioprofissional
 */
CREATE SEQUENCE turmaachorarioprofissional_ed346_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE turmaachorarioprofissional(
ed346_sequencial       int4 NOT NULL default 0,
ed346_turmaac          int4 NOT NULL default 0,
ed346_funcaoatividade  int4 NOT NULL default 0,
ed346_rechumano        int4 NOT NULL default 0,
ed346_diasemana        int4 NOT NULL default 0,
ed346_horainicial      char(5) NOT NULL ,
ed346_horafinal        char(5) ,
CONSTRAINT turmaachorarioprofissional_sequ_pk PRIMARY KEY (ed346_sequencial));

ALTER TABLE turmaachorarioprofissional
ADD CONSTRAINT turmaachorarioprofissional_turmaac_fk FOREIGN KEY (ed346_turmaac)
REFERENCES turmaac;

ALTER TABLE turmaachorarioprofissional
ADD CONSTRAINT turmaachorarioprofissional_diasemana_fk FOREIGN KEY (ed346_diasemana)
REFERENCES diasemana;

ALTER TABLE turmaachorarioprofissional
ADD CONSTRAINT turmaachorarioprofissional_funcaoatividade_fk FOREIGN KEY (ed346_funcaoatividade)
REFERENCES funcaoatividade;

ALTER TABLE turmaachorarioprofissional
ADD CONSTRAINT turmaachorarioprofissional_rechumano_fk FOREIGN KEY (ed346_rechumano)
REFERENCES rechumano;

CREATE  INDEX turmaachorarioprofissional_diasemana_in ON turmaachorarioprofissional(ed346_diasemana);

CREATE  INDEX turmaachorarioprofissional_funcaoatividade_in ON turmaachorarioprofissional(ed346_funcaoatividade);

CREATE  INDEX turmaachorarioprofissional_turmaac_in ON turmaachorarioprofissional(ed346_turmaac);

/**
 * Estrutura turmaoutrosprofissionais
 */
CREATE SEQUENCE turmaoutrosprofissionais_ed347_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE turmaoutrosprofissionais(
ed347_sequencial       int4 NOT NULL default 0,
ed347_turma            int4 NOT NULL default 0,
ed347_rechumano        int4 NOT NULL default 0,
ed347_funcaoatividade  int4 default 0,
CONSTRAINT turmaoutrosprofissionais_sequ_pk PRIMARY KEY (ed347_sequencial));

ALTER TABLE turmaoutrosprofissionais
ADD CONSTRAINT turmaoutrosprofissionais_turma_fk FOREIGN KEY (ed347_turma)
REFERENCES turma;

ALTER TABLE turmaoutrosprofissionais
ADD CONSTRAINT turmaoutrosprofissionais_rechumano_fk FOREIGN KEY (ed347_rechumano)
REFERENCES rechumano;

ALTER TABLE turmaoutrosprofissionais
ADD CONSTRAINT turmaoutrosprofissionais_funcaoatividade_fk FOREIGN KEY (ed347_funcaoatividade)
REFERENCES funcaoatividade;

CREATE  INDEX turmaoutrosprofissionais_funcaoatividade_in ON turmaoutrosprofissionais(ed347_funcaoatividade);
CREATE  INDEX turmaoutrosprofissionais_rechumano_in ON turmaoutrosprofissionais(ed347_rechumano);
CREATE  INDEX turmaoutrosprofissionais_turma_in ON turmaoutrosprofissionais(ed347_turma);

create table w_criacaoatividadescomplementares as  select * From turmaacativ where ed267_i_censoativcompl in(11003, 11004,12002,22001,22002, 22003, 22005, 22006, 22008);
insert into turmaacativ select nextval('turmaacativ_ed267_i_codigo_seq'), ed267_i_turmaac, ed133_i_codigo from turmaacativ, censoativcompl where ed267_i_censoativcompl = 12002 and ed133_i_codigo in(12003,12004,12005,12006,12007);
insert into turmaacativ select nextval('turmaacativ_ed267_i_codigo_seq'), ed267_i_turmaac, ed133_i_codigo from turmaacativ, censoativcompl where ed267_i_censoativcompl = 11003 and ed133_i_codigo in(11007,11008,11007);
insert into turmaacativ select nextval('turmaacativ_ed267_i_codigo_seq'), ed267_i_turmaac, ed133_i_codigo from turmaacativ, censoativcompl where ed267_i_censoativcompl = 11004 and ed133_i_codigo in(11006,11010);
insert into turmaacativ select nextval('turmaacativ_ed267_i_codigo_seq'), ed267_i_turmaac, ed133_i_codigo from turmaacativ, censoativcompl where ed267_i_censoativcompl = 12002 and ed133_i_codigo in(12003,12004,12005,12006,12007);
insert into turmaacativ select nextval('turmaacativ_ed267_i_codigo_seq'), ed267_i_turmaac, ed133_i_codigo from turmaacativ, censoativcompl where ed267_i_censoativcompl = 22001 and ed133_i_codigo in(22018,22019);
insert into turmaacativ select nextval('turmaacativ_ed267_i_codigo_seq'), ed267_i_turmaac, ed133_i_codigo from turmaacativ, censoativcompl where ed267_i_censoativcompl = 22002 and ed133_i_codigo in(22020,22027);
insert into turmaacativ select nextval('turmaacativ_ed267_i_codigo_seq'), ed267_i_turmaac, ed133_i_codigo from turmaacativ, censoativcompl where ed267_i_censoativcompl = 22003 and ed133_i_codigo in(22028,22014,22021,22013,22025);
insert into turmaacativ select nextval('turmaacativ_ed267_i_codigo_seq'), ed267_i_turmaac, ed133_i_codigo from turmaacativ, censoativcompl where ed267_i_censoativcompl = 22005 and ed133_i_codigo in(22026,22022,22023);
insert into turmaacativ select nextval('turmaacativ_ed267_i_codigo_seq'), ed267_i_turmaac, ed133_i_codigo from turmaacativ, censoativcompl where ed267_i_censoativcompl = 22006 and ed133_i_codigo in(22030,22031);
insert into turmaacativ select nextval('turmaacativ_ed267_i_codigo_seq'), ed267_i_turmaac, ed133_i_codigo from turmaacativ, censoativcompl where ed267_i_censoativcompl = 22008 and ed133_i_codigo in(22011,22015,22016);

delete from turmaacativ where ed267_i_censoativcompl in(11003, 11004,12002,22001,22002, 22003, 22005, 22006, 22008);

update escola.turmaacativ set ed267_i_censoativcompl= '11009' where ed267_i_censoativcompl = 11001;
update escola.turmaacativ set ed267_i_censoativcompl= '19999' where ed267_i_censoativcompl = 12001;
update escola.turmaacativ set ed267_i_censoativcompl= '14004' where ed267_i_censoativcompl = 14003;
update escola.turmaacativ set ed267_i_censoativcompl= '39999' where ed267_i_censoativcompl = 31009;
update escola.turmaacativ set ed267_i_censoativcompl= '14201' where ed267_i_censoativcompl = 31010;
update escola.turmaacativ set ed267_i_censoativcompl= '49999' where ed267_i_censoativcompl = 41006;
update escola.turmaacativ set ed267_i_censoativcompl= '13999' where ed267_i_censoativcompl = 51001;
update escola.turmaacativ set ed267_i_censoativcompl= '13104' where ed267_i_censoativcompl = 51002;
update escola.turmaacativ set ed267_i_censoativcompl= '13101' where ed267_i_censoativcompl = 51003;
update escola.turmaacativ set ed267_i_censoativcompl= '13999' where ed267_i_censoativcompl = 51004;
update escola.turmaacativ set ed267_i_censoativcompl= '13999' where ed267_i_censoativcompl = 59999;
update escola.turmaacativ set ed267_i_censoativcompl= '14999' where ed267_i_censoativcompl = 61001;
update escola.turmaacativ set ed267_i_censoativcompl= '14202' where ed267_i_censoativcompl = 61006;
update escola.turmaacativ set ed267_i_censoativcompl= '14999' where ed267_i_censoativcompl = 61007;
update escola.turmaacativ set ed267_i_censoativcompl= '14999' where ed267_i_censoativcompl = 69999;
update escola.turmaacativ set ed267_i_censoativcompl= '71007' where ed267_i_censoativcompl = 71001;
update escola.turmaacativ set ed267_i_censoativcompl= '71007' where ed267_i_censoativcompl = 71003;
update escola.turmaacativ set ed267_i_censoativcompl= '71007' where ed267_i_censoativcompl = 71004;
update escola.turmaacativ set ed267_i_censoativcompl= '71007' where ed267_i_censoativcompl = 71006;
update escola.turmaacativ set ed267_i_censoativcompl= '10103' where ed267_i_censoativcompl = 10101;
update escola.turmaacativ set ed267_i_censoativcompl= '14106' where ed267_i_censoativcompl = 10102;
update escola.turmaacativ set ed267_i_censoativcompl= '10999' where ed267_i_censoativcompl = 10999;
update escola.turmaacativ set ed267_i_censoativcompl= '14104' where ed267_i_censoativcompl = 11101;
update escola.turmaacativ set ed267_i_censoativcompl= '14103' where ed267_i_censoativcompl = 11102;
update escola.turmaacativ set ed267_i_censoativcompl= '14102' where ed267_i_censoativcompl = 11103;
update escola.turmaacativ set ed267_i_censoativcompl= '14105' where ed267_i_censoativcompl = 11104;
update escola.turmaacativ set ed267_i_censoativcompl= '14101' where ed267_i_censoativcompl = 11105;
update escola.turmaacativ set ed267_i_censoativcompl= '14999' where ed267_i_censoativcompl = 11999;
update escola.turmaacativ set ed267_i_censoativcompl= '13201' where ed267_i_censoativcompl = 12101;