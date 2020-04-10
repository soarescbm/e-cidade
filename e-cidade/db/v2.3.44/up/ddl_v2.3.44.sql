---------------------------------------------------------------------------------------------
-------------------------------- INCIO FINANCEIRO -------------------------------------------
---------------------------------------------------------------------------------------------

create sequence classificacaocredores_cc30_codigo_seq
increment 1
minvalue  1
maxvalue  9223372036854775807
start     1
cache     1;

create sequence classificacaocredoresempenho_cc31_sequencial_seq
increment 1
minvalue  1
maxvalue  9223372036854775807
start     1
cache     1;

create table classificacaocredores(
cc30_codigo    int4         not null default nextval('classificacaocredores_cc30_codigo_seq'),
cc30_descricao varchar(100) not null,
constraint classificacaocredores_codi_pk primary key (cc30_codigo));

create table classificacaocredoresempenho(
cc31_sequencial            int4 not null default nextval('classificacaocredoresempenho_cc31_sequencial_seq'),
cc31_empempenho            int4 not null,
cc31_classificacaocredores int4 not null,
cc31_justificativa         text,
constraint classificacaocredoresempenho_sequ_pk primary key (cc31_sequencial));

alter table classificacaocredoresempenho
add constraint classificacaocredoresempenho_empempenho_fk foreign key (cc31_empempenho)
references empempenho;

alter table classificacaocredoresempenho
add constraint classificacaocredoresempenho_classificacaocredores_fk foreign key (cc31_classificacaocredores)
references classificacaocredores;

alter table empnota
  add column e69_dtvencimento     date default null,
  add column e69_localrecebimento text default null;

insert into classificacaocredores values(1, 'Recursos Vinculados');
insert into classificacaocredores values(2, 'Pequeno Valor');
insert into classificacaocredores values(3, 'Materiais e Serviços');
insert into classificacaocredores values(4, 'Dispensa');
select setval('classificacaocredores_cc30_codigo_seq', 4);



CREATE SEQUENCE empagemovjustificativa_e09_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1;

CREATE TABLE empagemovjustificativa(
e09_sequencial		int4 NOT NULL default 0,
e09_codnota		int4 NOT NULL default 0,
e09_codmov		int4 NOT NULL default 0,
e09_justificativa		text ,
CONSTRAINT empagemovjustificativa_codm_pk PRIMARY KEY (e09_codmov));

ALTER TABLE empagemovjustificativa
ADD CONSTRAINT empagemovjustificativa_codnota_fk FOREIGN KEY (e09_codnota)
REFERENCES empnota;

ALTER TABLE empagemovjustificativa
ADD CONSTRAINT empagemovjustificativa_codmov_fk FOREIGN KEY (e09_codmov)
REFERENCES empagemov;

CREATE  INDEX empagemovjustificativa_codnota_in ON empagemovjustificativa(e09_codnota);
CREATE  INDEX empagemovjustificativa_codmov_in ON empagemovjustificativa(e09_codmov);

ALTER TABLE conhistdoc ALTER COLUMN c53_descr TYPE VARCHAR(100);
insert into conhistdoc values (2007, 'INSCRIÇÃO DE RP NÃO PROCESSADOS - EXERCÍCIOS ANTERIORES', 2000);
insert into conhistdoc values (2008, 'ESTORNO DE INSCRIÇÃO DE RP NÃO PROCESSADOS - EXERCÍCIOS ANTERIORES', 2001);
insert into conhistdoc values (2009, 'INSCRIÇÃO DE RESTOS A PAGAR PROCESSADOS ', 2000);
insert into conhistdoc values (2010, 'ESTORNO DE INSCRIÇÃO DE RP PROCESSADOS', 2001) ;
insert into conhistdoc values (2011, 'INSCRIÇÃO DE RP PROCESSADOS - EXERCÍCIOS ANTERIORES', 2000);
insert into conhistdoc values (2012, 'ESTORNO DE INSCRIÇÃO DE RP PROCESSADOS - EXERCÍCIOS ANTERIORES', 2001);


insert into conhistdoc values (2013, upper('Abertura da Receita Bruta inicial do Orçamento'), 2000);
insert into conhistdoc values (2014, upper('ESTORNO da Abertura da Receita Bruta inicial do Orçamento'), 2001);
insert into conhistdoc values (2015, upper('Abertura das Deduções de Receita para o FUNDEB'), 2000);
insert into conhistdoc values (2016, upper('ESTORNO da Abertura das Deduções de Receita para o FUNDEB'), 2001);
insert into conhistdoc values (2017, upper('Abertura das Deduções de Receita por Renúncia'), 2000);
insert into conhistdoc values (2018, upper('ESTORNO da Abertura das Deduções de Receita por Renúncia'), 2001);
insert into conhistdoc values (2019, upper('Abertura das demais Deduções de Receitas'), 2000);
insert into conhistdoc values (2020, upper('ESTORNO da Abertura das demais Deduções de Receitas'), 2001);


insert into vinculoeventoscontabeis
     values (nextval('vinculoeventoscontabeis_c115_sequencial_seq'), 2007, 2008),
            (nextval('vinculoeventoscontabeis_c115_sequencial_seq'), 2009, 2010),
            (nextval('vinculoeventoscontabeis_c115_sequencial_seq'), 2011, 2012),
            (nextval('vinculoeventoscontabeis_c115_sequencial_seq'), 2013, 2014),
            (nextval('vinculoeventoscontabeis_c115_sequencial_seq'), 2015, 2016),
            (nextval('vinculoeventoscontabeis_c115_sequencial_seq'), 2017, 2018),
            (nextval('vinculoeventoscontabeis_c115_sequencial_seq'), 2019, 2020);



ALTER TABLE if EXISTS inscricaorestosapagarnaoprocessados RENAME TO inscricaorestosapagar;
ALTER TABLE if EXISTS inscricaorestosapagar ADD COLUMN c107_tipo int default 1 NOT NULL;
alter table inscricaorestosapagar rename CONSTRAINT inscricaorestosapagarnaoprocessados_instit_fk to inscricaorestosapagar_instit_fk;
alter table inscricaorestosapagar rename CONSTRAINT inscricaorestosapagarnaoprocessados_usuario_fk to inscricaorestosapagar_usuario_fk;
alter table inscricaorestosapagar rename CONSTRAINT inscricaorestosapagarnaoprocessados_sequ_pk to inscricaorestosapagar_sequ_pk;
alter index IF EXISTS inscricaorestosapagarnaoprocessados_instit_in  rename to inscricaorestosapagar_instit_in;
alter index IF EXISTS inscricaorestosapagarnaoprocessados_usuario_in rename to inscricaorestosapagar_usuario_in;
ALTER SEQUENCE IF EXISTS inscricaorestosapagarnaoprocessados_c107_sequencial_seq RENAME TO inscricaorestosapagar_c107_sequencial_seq;

alter table IF EXISTS conlancaminscrestosapagarnaoprocessados rename to conlancaminscrestosapagar;
alter table IF EXISTS conlancaminscrestosapagar rename column     c108_inscricaorestosapagarnaoprocessados to c108_inscricaorestosapagar;
alter table conlancaminscrestosapagar rename CONSTRAINT conlancaminscrestosapagarnaoprocessados_codlan_fk  to conlancaminscrestosapagar_codlan_fk;
alter table conlancaminscrestosapagar rename CONSTRAINT conlancaminscrestosapagarnaoprocessados_inscricaorestosapagarna to conlancaminscrestosapagar_inscricaorestosapagarna;
alter table conlancaminscrestosapagar rename CONSTRAINT conlancaminscrestosapagarnaoprocessados_sequ_pk to conlancaminscrestosapagar_sequ_pk;
alter index IF EXISTS conlancaminscrestosapagarnaoprocessados_codlan_in rename to conlancaminscrestosapagar_codlan_in;
alter index IF EXISTS conlancaminscrestosapagarnaoprocessados_inscricaorestosapagarna rename to conlancaminscrestosapagar_inscricaorestosapagarna;
ALTER SEQUENCE IF EXISTS conlancaminscrestosapagarnaoprocessados_c108_sequencial_seq rename to conlancaminscrestosapagar_c108_sequencial_seq;
---------------------------------------------------------------------------------------------
-------------------------------- FIM FINANCEIRO---------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-------------------------------- INICIO CONFIGURACAO ----------------------------------------
---------------------------------------------------------------------------------------------

alter table db_usuarios add column dataexpira date  default null;

---------------------------------------------------------------------------------------------
-------------------------------- FIM CONFIGURACAO -------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
----------------------------------- INICIO EDUCACAO/SAUDE -----------------------------------------
---------------------------------------------------------------------------------------------------

CREATE SEQUENCE diarioavaliacaoalternativa_ed136_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE diarioavaliacaoalternativa(
ed136_sequencial    int4 NOT NULL default 0,
ed136_diario    int4 NOT NULL default 0,
ed136_procavalalternativa   int4 default 0,
CONSTRAINT diarioavaliacaoalternativa_sequ_pk PRIMARY KEY (ed136_sequencial));

ALTER TABLE diarioavaliacaoalternativa ADD CONSTRAINT diarioavaliacaoalternativa_diario_fk FOREIGN KEY (ed136_diario) REFERENCES diario;
ALTER TABLE diarioavaliacaoalternativa ADD CONSTRAINT diarioavaliacaoalternativa_procavalalternativa_fk FOREIGN KEY (ed136_procavalalternativa) REFERENCES procavalalternativa;

CREATE  INDEX diarioavaliacaoalternativa_procavalalternativa_in ON diarioavaliacaoalternativa(ed136_procavalalternativa);
CREATE  INDEX diarioavaliacaoalternativa_diario_in ON diarioavaliacaoalternativa(ed136_diario);

alter table lab_exame drop column la08_t_diagnostico;
alter table lab_exame add column la08_observacao text;

alter table tipoausencia add column ed320_tipo int4 not null default 1;
update tipoausencia set ed320_tipo = 2 where ed320_licenca is true;
alter table tipoausencia drop column ed320_licenca;

CREATE SEQUENCE rechumanoausente_ed348_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE rechumanoausente(
ed348_sequencial		int4 NOT NULL default 0,
ed348_rechumano		  int4 NOT NULL default 0,
ed348_tipoausencia	int4 NOT NULL default 0,
ed348_usuario		    int4 NOT NULL default 0,
ed348_inicio		    date NOT NULL default null,
ed348_final		      date,
ed348_observacao		text,
ed348_escola		    int4 default 0,
CONSTRAINT rechumanoausente_sequ_pk PRIMARY KEY (ed348_sequencial));

ALTER TABLE rechumanoausente
ADD CONSTRAINT rechumanoausente_usuario_fk FOREIGN KEY (ed348_usuario)
REFERENCES db_usuarios;

ALTER TABLE rechumanoausente
ADD CONSTRAINT rechumanoausente_escola_fk FOREIGN KEY (ed348_escola)
REFERENCES escola;

ALTER TABLE rechumanoausente
ADD CONSTRAINT rechumanoausente_rechumano_fk FOREIGN KEY (ed348_rechumano)
REFERENCES rechumano;

ALTER TABLE rechumanoausente
ADD CONSTRAINT rechumanoausente_tipoausencia_fk FOREIGN KEY (ed348_tipoausencia)
REFERENCES tipoausencia;

CREATE  INDEX rechumanoausente_escola_in ON rechumanoausente(ed348_escola);
CREATE  INDEX rechumanoausente_usuario_in ON rechumanoausente(ed348_usuario);
CREATE  INDEX rechumanoausente_tipoausencia_in ON rechumanoausente(ed348_tipoausencia);
CREATE  INDEX rechumanoausente_rechumano_in ON rechumanoausente(ed348_rechumano);

insert into rechumanoausente select * from docenteausencia;
select setval('rechumanoausente_ed348_sequencial_seq', (select max(ed348_sequencial) from rechumanoausente));


CREATE SEQUENCE medicamentoslaboratorio_la43_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE medicamentoslaboratoriorequiitem_la44_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE medicamentoslaboratorio(
la43_sequencial    int4 NOT NULL default 0,
la43_nome    varchar(50) NOT NULL ,
la43_abreviatura    varchar(3) ,
CONSTRAINT medicamentoslaboratorio_sequ_pk PRIMARY KEY (la43_sequencial));

CREATE TABLE medicamentoslaboratoriorequiitem(
la44_sequencial    int4 NOT NULL default 0,
la44_medicamentoslaboratorio    int4 NOT NULL default 0,
la44_requiitem    int4 default 0,
CONSTRAINT medicamentoslaboratoriorequiitem_sequ_pk PRIMARY KEY (la44_sequencial));

ALTER TABLE medicamentoslaboratoriorequiitem ADD CONSTRAINT medicamentoslaboratoriorequiitem_medicamentoslaboratorio_fk FOREIGN KEY (la44_medicamentoslaboratorio) REFERENCES medicamentoslaboratorio;
ALTER TABLE medicamentoslaboratoriorequiitem ADD CONSTRAINT medicamentoslaboratoriorequiitem_requiitem_fk FOREIGN KEY (la44_requiitem) REFERENCES lab_requiitem;

CREATE UNIQUE INDEX medicamentoslaboratorio_abreviatura_in ON medicamentoslaboratorio(la43_abreviatura);
CREATE  INDEX medicamentoslaboratoriorequiitem_requiitem_in ON medicamentoslaboratoriorequiitem(la44_requiitem);
CREATE  INDEX medicamentoslaboratoriorequiitem_medicamentoslaboratorio_in ON medicamentoslaboratoriorequiitem(la44_medicamentoslaboratorio);

ALTER TABLE justificativa ADD COLUMN ed06_abreviatura varchar(3);
UPDATE justificativa SET ed06_abreviatura = 'AMP';
ALTER TABLE justificativa ALTER COLUMN ed06_abreviatura SET NOT NULL;

update tipohoratrabalho set ed128_abreviatura = 'H' where ed128_codigo = 1;

---------------------------------------------------------------------------------------------------
----------------------------------- FIM EDUCACAO/SAUDE --------------------------------------------
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
----------------------------------- INICIO FOLHA --------------------------------------------------
---------------------------------------------------------------------------------------------------



CREATE SEQUENCE tipoassecontrolediasmes_rh170_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE tipoassecontrolediasmes(
rh170_sequencial		int4 NOT NULL default 0,
rh170_tipoasse		int4 NOT NULL default 0,
CONSTRAINT tipoassecontrolediasmes_sequ_pk PRIMARY KEY (rh170_sequencial));


ALTER TABLE tipoassecontrolediasmes
ADD CONSTRAINT tipoassecontrolediasmes_tipoasse_fk FOREIGN KEY (rh170_tipoasse)
REFERENCES tipoasse;


CREATE  INDEX tipoassecontrolediasmes_tipoasse_in ON tipoassecontrolediasmes(rh170_tipoasse);
update db_formulas set db148_formula = 'select fc_dias_no_mes_folha(([ANO_COMPETENCIA]), ([MES_COMPETENCIA]), exists(select 1 from tipoassecontrolediasmes inner join assenta on h16_assent = rh170_tipoasse where h16_assent=[CODIGO_ASSENTAMENTO]))' where db148_nome = 'DIAS_MES_COMPETENCIA_ATUAL';


CREATE SEQUENCE codigoclienterefeisul_rh171_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


CREATE TABLE codigoclienterefeisul(
  rh171_sequencial		int4 NOT NULL ,
  rh171_instit		int4 NOT NULL default 0,
  rh171_codigocliente		int4 default 0,
 CONSTRAINT codigoclienterefeisul_sequ_pk PRIMARY KEY (rh171_sequencial));


ALTER TABLE codigoclienterefeisul
ADD CONSTRAINT codigoclienterefeisul_instit_fk FOREIGN KEY (rh171_instit)
REFERENCES db_config;


CREATE UNIQUE INDEX codigoclienterefeisul_instit ON codigoclienterefeisul(rh171_instit);


---------------------------------------------------------------------------------------------------
----------------------------------- FIMFOLHA ------------------------------------------------------
---------------------------------------------------------------------------------------------------