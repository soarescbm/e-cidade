---------------------------------------------------------------------------------------------
------------------------------- INICIO TIME EDUCACAO / SAUDE --------------------------------
---------------------------------------------------------------------------------------------

-- DADOS DO dml_98785.sql
alter table escola alter ed18_i_cnpj            type varchar(14);
alter table escola alter ed18_i_cnpj            set default 'null';
alter table escola alter ed18_i_cnpjprivada     type varchar(14);
alter table escola alter ed18_i_cnpjprivada     set default 'null';
alter table escola alter ed18_i_cnpjmantprivada type varchar(14);
alter table escola alter ed18_i_cnpjmantprivada set default 'null';

CREATE SEQUENCE controlematriculainicial_ed135_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE TABLE controlematriculainicial(
ed135_sequencial     int4 NOT NULL default 0,
ed135_anoinicial     int4 NOT NULL default 0,
ed135_anofinal       int4 DEFAULT NULL,
ed135_quantidadedias int4 NOT NULL default 0,
CONSTRAINT controlematriculainicial_sequ_pk PRIMARY KEY (ed135_sequencial));

---------------------------------------------------------------------------------------------
--------------------------------- FIM TIME EDUCACAO / SAUDE ---------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-------------------------------- INCIO FINANCEIRO -------------------------------------------
---------------------------------------------------------------------------------------------

-- planilha de distribuição
create sequence planilhadistribuicao_pd01_sequencial_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create sequence planilhadistribuicaodepart_pd02_sequencial_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create sequence planilhadistribuicaomaterial_pd03_sequencial_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create table planilhadistribuicao(
pd01_sequencial int4         not null default nextval('planilhadistribuicao_pd01_sequencial_seq'),
pd01_descricao  varchar(200) not null,
constraint planilhadistribuicao_sequ_pk primary key (pd01_sequencial));

create table planilhadistribuicaodepart(
pd02_sequencial           int4 not null default nextval('planilhadistribuicaodepart_pd02_sequencial_seq'),
pd02_planilhadistribuicao int4 not null,
pd02_departamento         int4 not null,
constraint planilhadistribuicaodepart_sequ_pk primary key (pd02_sequencial));

create table planilhadistribuicaomaterial(
pd03_sequencial           int4 not null default nextval('planilhadistribuicaomaterial_pd03_sequencial_seq'),
pd03_planilhadistribuicao int4 not null,
pd03_material             int4 not null,
constraint planilhadistribuicaomaterial_sequ_pk primary key (pd03_sequencial));

alter table    planilhadistribuicaodepart
add constraint planilhadistribuicaodepart_planilhadistribuicao_fk foreign key (pd02_planilhadistribuicao)
references     planilhadistribuicao;

alter table    planilhadistribuicaodepart
add constraint planilhadistribuicaodepart_departamento_fk foreign key (pd02_departamento)
references     db_depart;

alter table    planilhadistribuicaomaterial
add constraint planilhadistribuicaomaterial_planilhadistribuicao_fk foreign key (pd03_planilhadistribuicao)
references     planilhadistribuicao;

alter table    planilhadistribuicaomaterial
add constraint planilhadistribuicaomaterial_material_fk foreign key (pd03_material)
references     matmater;

create index planilhadistribuicaodepart_planilhadistribuicao_in on planilhadistribuicaodepart(pd02_planilhadistribuicao);
create index planilhadistribuicaodepart_departamento_in on planilhadistribuicaodepart(pd02_departamento);
create index planilhadistribuicaomaterial_material_in on planilhadistribuicaomaterial(pd03_material);
create index planilhadistribuicaomaterial_planilhadistribuicao_in on planilhadistribuicaomaterial(pd03_planilhadistribuicao);
-- fim planilha de distribuição

---------------------------------------------------------------------------------------------
-------------------------------- FIM FINANCEIRO---------------------------------------------
---------------------------------------------------------------------------------------------
