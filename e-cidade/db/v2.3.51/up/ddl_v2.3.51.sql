---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO FINANCEIRO ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

select fc_executa_ddl('alter table acordocomissaomembro add ac07_datainicio date');
select fc_executa_ddl('alter table acordocomissaomembro add ac07_datatermino date');

select fc_executa_ddl('alter table acordoposicao add ac26_tipooperacao integer');

-- Controle de contratos encerrados
select fc_executa_ddl('create sequence acordos.acordoencerramentolicitacon_ac58_sequencial_seq increment 1 minvalue 1 maxvalue 9223372036854775807 start 1 cache 1;');
select fc_executa_ddl('create table acordos.acordoencerramentolicitacon(
ac58_sequencial   int4 not null default nextval(\'acordoencerramentolicitacon_ac58_sequencial_seq\'),
ac58_acordo       int4 not null,
ac58_data         date,
constraint acordoencerramentolicitacon_sequ_pk primary key (ac58_sequencial));');
select fc_executa_ddl('alter table acordoencerramentolicitacon
add constraint acordoencerramentolicitacon_acordo_fk foreign key (ac58_acordo)
references acordo;');

-- Campo Ano do Exercício na Tabela acordoempempenho
select fc_executa_ddl('alter table acordoempempenho add column ac54_ano int4 default null;');

alter table empautitem add column e55_matunid int4 default null;
alter table empautitem add constraint empautitem_matunid_fk foreign key (e55_matunid) references matunid;

drop table if exists bkp_contacorrenteduplicados;
drop table if exists bkp_de_para_contacorrente;
update contacorrentedetalhe
   set c19_contacorrente = 1
  from conplanoreduz, conplano
 where c61_codcon = c60_codcon
   and c61_anousu = c60_anousu
   and c61_reduz  = c19_reduz
   and c19_contacorrente = 103
   and c60_anousu = 2016
   and c60_estrut ilike '82111%'
   and exists (select 1 from db_config where upper(uf) = 'RS');

update contacorrentedetalhe
   set c19_concarpeculiar = '000'
 where c19_contacorrente = 1
   and c19_concarpeculiar is null;

create table bkp_contacorrenteduplicados
    as select min(c19_sequencial) as primeiro_sequencial,
       c19_orctiporec,
       c19_concarpeculiar,
       c19_reduz,
       count(*)
  from contacorrentedetalhe
       inner join conplanoreduz on conplanoreduz.c61_reduz = contacorrentedetalhe.c19_reduz
                               and conplanoreduz.c61_anousu = contacorrentedetalhe.c19_conplanoreduzanousu
       inner join conplano  on conplano.c60_codcon = conplanoreduz.c61_codcon
                           and conplano.c60_anousu = conplanoreduz.c61_anousu
 where c19_contacorrente = 1
   and c19_conplanoreduzanousu = 2016
   and c60_estrut ilike '82111%'
 group by c19_orctiporec,c19_concarpeculiar, c19_reduz, c19_instit having count(*) > 1;

create table bkp_de_para_contacorrente
    as select c.c19_sequencial as sequencial_errado,
              bkp.primeiro_sequencial
         from contacorrentedetalhe c
              inner join bkp_contacorrenteduplicados bkp  on bkp.c19_orctiporec = c.c19_orctiporec
                                                         and bkp.c19_concarpeculiar::varchar = c.c19_concarpeculiar::varchar
                                                         and bkp.c19_reduz = c.c19_reduz
                                                         and c.c19_sequencial <> bkp.primeiro_sequencial
                                                         and c.c19_conplanoreduzanousu = 2016 ;

update contacorrentedetalheconlancamval
   set c28_contacorrentedetalhe = bkp.primeiro_sequencial
  from bkp_de_para_contacorrente as bkp
 where bkp.sequencial_errado = contacorrentedetalheconlancamval.c28_contacorrentedetalhe;

delete from contacorrentesaldo where c29_contacorrentedetalhe in (select sequencial_errado from bkp_de_para_contacorrente);
delete from contacorrentedetalhe where c19_sequencial in (select sequencial_errado from bkp_de_para_contacorrente);

---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO FOLHA ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE rhconsignacaobancolayout_rh178_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


CREATE TABLE rhconsignacaobancolayout(
  rh178_sequencial		int4 NOT NULL  default nextval('rhconsignacaobancolayout_rh178_sequencial_seq'),
  rh178_db_banco		varchar(10) NOT NULL ,
  rh178_layout		int4 NOT NULL ,
  rh178_rubrica		char(4) NOT NULL ,
  rh178_instit		int4 ,
  CONSTRAINT rhconsignacaobancolayout_sequ_pk PRIMARY KEY (rh178_sequencial));



ALTER TABLE rhconsignacaobancolayout
ADD CONSTRAINT rhconsignacaobancolayout_banco_fk FOREIGN KEY (rh178_db_banco)
REFERENCES db_bancos;

ALTER TABLE rhconsignacaobancolayout
ADD CONSTRAINT rhconsignacaobancolayout_layout_fk FOREIGN KEY (rh178_layout)
REFERENCES db_layouttxt;

ALTER TABLE rhconsignacaobancolayout
ADD CONSTRAINT rhconsignacaobancolayout_rubrica_instit_fk FOREIGN KEY (rh178_rubrica,rh178_instit)
REFERENCES rhrubricas;

CREATE  INDEX rhconsignacaobancolayout_rubrica_in ON rhconsignacaobancolayout(rh178_rubrica);
CREATE  INDEX rhconsignacaobancolayout_layout_in ON rhconsignacaobancolayout(rh178_layout);
CREATE  INDEX rhconsignacaobancolayout_banco_in ON rhconsignacaobancolayout(rh178_db_banco);

alter table rhconsignadomovimento add rh151_arquivo oid;
alter table rhconsignadomovimento add rh151_banco varchar(10);

alter table rhconsignadomovimentoservidor alter rh152_regist type varchar;

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
insert into funcaoatividade values (5, 'Docente titular - coordenador de tutoria(de módulo ou disciplina) - EAD', true);
insert into funcaoatividade values (6, 'Docente tutor - (de módulo ou disciplina)', true);

alter table ensino add column ed10_censocursoprofiss int4 default null;
alter table ensino add constraint ensino_censocursoprofiss_fk foreign key (ed10_censocursoprofiss) references censocursoprofiss;
create index ensino_censocursoprofiss_in on ensino(ed10_censocursoprofiss);
alter table escola alter COLUMN ed18_latitude type varchar(20), alter COLUMN ed18_longitude type varchar(20);

---------------------------------------------------------------------------------------------------------------
------------------------------------------- INICIO SAUDE ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
CREATE SEQUENCE agendasaidapassagemdestino_tf38_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE SEQUENCE passagemdestino_tf37_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE agendasaidapassagemdestino(
tf38_sequencial    int4 NOT NULL default 0,
tf38_agendasaida   int4 NOT NULL default 0,
tf38_valorunitario real NOT NULL default 0,
tf38_cgs           int4 NOT NULL default 0,
tf38_fica          bool default 'f',
CONSTRAINT agendasaidapassagemdestino_sequ_pk PRIMARY KEY (tf38_sequencial));

CREATE TABLE passagemdestino(
tf37_sequencial int4 NOT NULL default 0,
tf37_valor      real NOT NULL default 0,
tf37_destino    int4 default 0,
CONSTRAINT passagemdestino_sequ_pk PRIMARY KEY (tf37_sequencial));

ALTER TABLE agendasaidapassagemdestino
ADD CONSTRAINT agendasaidapassagemdestino_cgs_fk FOREIGN KEY (tf38_cgs)
REFERENCES cgs_und;

ALTER TABLE agendasaidapassagemdestino
ADD CONSTRAINT agendasaidapassagemdestino_agendasaida_fk FOREIGN KEY (tf38_agendasaida)
REFERENCES tfd_agendasaida;

ALTER TABLE passagemdestino
ADD CONSTRAINT passagemdestino_destino_fk FOREIGN KEY (tf37_destino)
REFERENCES tfd_destino;

CREATE UNIQUE INDEX agendasaidapassagemdestino_agendasaida_cgs_in ON agendasaidapassagemdestino(tf38_agendasaida, tf38_cgs);
CREATE UNIQUE INDEX passagemdestino_destino_in ON passagemdestino(tf37_destino);

alter table tfd_agendasaida add column tf17_tiposaida int4 default 1 not null;