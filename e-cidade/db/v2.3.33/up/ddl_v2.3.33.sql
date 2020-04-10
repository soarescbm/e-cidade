
----------------------------
--- Time C - INICIO
----------------------------

-- 82709
create sequence diarioregracalculo_ed125_codigo_seq increment 1 minvalue 1 maxvalue 9223372036854775807 start 1 cache 1;
create sequence regracalculo_ed126_codigo_seq increment 1 minvalue 1 maxvalue 9223372036854775807 start 1 cache 1;

create table diarioregracalculo (
ed125_codigo int4 not null default 0,
ed125_ordemperiodo int4 not null default 0,
ed125_diario int4 not null default 0,
ed125_regracalculo int4 default 0,
constraint diarioregracalculo_codi_pk primary key (ed125_codigo));

create table regracalculo (
ed126_codigo int4 not null default 0,
ed126_descricao varchar(100) ,
constraint regracalculo_codi_pk primary key (ed126_codigo));

alter table diarioregracalculo add constraint diarioregracalculo_regracalculo_fk foreign key (ed125_regracalculo) references regracalculo;
alter table diarioregracalculo add constraint diarioregracalculo_diario_fk foreign key (ed125_diario) references diario;
create index diarioregracalculo_regracalculo_in on diarioregracalculo(ed125_regracalculo);
create index diarioregracalculo_diario_in on diarioregracalculo(ed125_diario);

insert into regracalculo values (nextval('regracalculo_ed126_codigo_seq'), 'CALCULAR PROPORCIONALIDADE');

alter table procresultado add column ed43_proporcionalidade boolean default false;
alter table procavaliacao add column ed41_julgamenoravaliacao boolean default false;
