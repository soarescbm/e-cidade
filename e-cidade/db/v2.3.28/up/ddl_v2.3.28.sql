/**
 * Arquivo ddl up
 */

----------------------------------------------------
---- TIME FOLHA DE PAGAMENTO
----------------------------------------------------
---- Tarefa: 93695
----------------------------------------------------

CREATE SEQUENCE rubricadescontoconsignado_rh140_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE rubricadescontoconsignado(
rh140_sequencial    int8 NOT NULL default 0,
rh140_rubric    char(4),
rh140_instit    int4 NOT NULL default 0,
rh140_ordem   int4 default 0,
CONSTRAINT rubricadescontoconsignado_sequ_pk PRIMARY KEY (rh140_sequencial));

CREATE UNIQUE INDEX rubricadescontoconsignado_rubric_in ON rubricadescontoconsignado(rh140_rubric);

--Adicionando coluna baseconsignada na tabela cfpess para adicionar base à margem
ALTER TABLE cfpess ADD COLUMN r11_baseconsignada char(4);

----------------------------------------------------
---- Tarefa: 96769
----------------------------------------------------

ALTER TABLE db_config ALTER COLUMN db21_tipopoder SET default 6;
ALTER TABLE contabancaria alter COLUMN db83_dvconta type varchar(2);

----------------------------------------------------
---- Tarefa: 96909 - Folha Complementar
----------------------------------------------------

CREATE SEQUENCE rhfolhapagamento_rh141_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE SEQUENCE rhtipofolha_rh142_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE SEQUENCE rhhistoricocalculo_rh143_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1 CACHE 1;

CREATE SEQUENCE rhhistoricoponto_rh144_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1 CACHE 1;

CREATE TABLE rhfolhapagamento(
rh141_sequencial    int4 NOT NULL default 0,
rh141_codigo        int4 NOT NULL default 0,
rh141_anoref        int4 NOT NULL default 0,
rh141_mesref        int4 NOT NULL default 0,
rh141_anousu        int4 NOT NULL default 0,
rh141_mesusu        int4 NOT NULL default 0,
rh141_instit        int4 NOT NULL default 0,
rh141_tipofolha     int4 NOT NULL default 0,
rh141_aberto        bool NOT NULL default 't',
rh141_descricao     text,
CONSTRAINT rhfolhapagamento_sequ_pk PRIMARY KEY (rh141_sequencial));

CREATE TABLE rhtipofolha(
rh142_sequencial int4 NOT NULL default 0,
rh142_descricao varchar(100) ,
CONSTRAINT rhtipofolha_sequ_pk PRIMARY KEY (rh142_sequencial));

-- Insere valores para a tabela thtipofolha
insert into rhtipofolha values(1, 'Salário');
insert into rhtipofolha values(2, 'Rescisão');
insert into rhtipofolha values(3, 'Complementar');
insert into rhtipofolha values(4, 'Adiantamento');
insert into rhtipofolha values(5, '13º Salário');

CREATE TABLE rhhistoricocalculo(
rh143_sequencial      int4 NOT NULL default 0,
rh143_regist		      int4      NOT NULL default 0,
rh143_folhapagamento  int4 NOT NULL default 0,
rh143_rubrica         char(4) NOT NULL ,
rh143_quantidade      float8 default 0,
rh143_valor           float8 default 0,
rh143_tipoevento      int4 default 0,
CONSTRAINT rhhistoricocalculo_sequ_pk PRIMARY KEY (rh143_sequencial));

CREATE TABLE rhhistoricoponto(
rh144_sequencial    int4 NOT NULL default 0,
rh144_regist		int4 NOT NULL default 0,
rh144_folhapagamento    int4 NOT NULL default 0,
rh144_rubrica   char(4) NOT NULL ,
rh144_quantidade    float8 default 0,
rh144_valor   float8 default 0,
CONSTRAINT rhhistoricoponto_sequ_pk PRIMARY KEY (rh144_sequencial));

ALTER TABLE rhfolhapagamento
ADD CONSTRAINT rhfolhapagamento_tipofolha_fk FOREIGN KEY (rh141_tipofolha)
REFERENCES rhtipofolha;

ALTER TABLE rhhistoricocalculo
ADD CONSTRAINT rhhistoricocalculo_folhapagamento_fk FOREIGN KEY (rh143_folhapagamento)
REFERENCES rhfolhapagamento;

ALTER TABLE rhhistoricoponto
ADD CONSTRAINT rhhistoricoponto_folhapagamento_fk FOREIGN KEY (rh144_folhapagamento)
REFERENCES rhfolhapagamento;

CREATE  INDEX rhfolhapagamento_sequencial_in ON rhfolhapagamento(rh141_sequencial);
CREATE  INDEX rhhistoricocalculo_folhapagamento_in ON rhhistoricocalculo(rh143_folhapagamento);
CREATE  INDEX rhhistoricocalculo_regist_in                               ON rhhistoricocalculo(rh143_regist);
CREATE  INDEX rhhistoricoponto_folhapagamento_in ON rhhistoricoponto(rh144_folhapagamento);
CREATE  INDEX rhhistoricoponto_regist_in                                 ON rhhistoricoponto(rh144_regist);
CREATE  UNIQUE INDEX rhfolhapagamento_sequencial_anousu_mesusu_instit_in ON rhfolhapagamento(rh141_sequencial,rh141_anousu,rh141_mesusu,rh141_instit);

---------------------
-- T96970
---------------------
alter table cfpess add column r11_abonoprevidencia varchar(4);

----------------------------------------------------------------
-- Migração Complementar
----------------------------------------------------------------
/**
 * CRia os dados do ponto
 */
create table w_migracao_rhfolhapagamento as
select distinct r48_anousu,
                r48_mesusu,
                r48_semest,
                r48_instit
  from gerfcom
     inner join pontocom on r47_regist = r48_regist
                        and r47_anousu = r48_anousu
                        and r47_mesusu = r48_mesusu
order by r48_anousu asc,
         r48_mesusu asc,
         r48_semest asc;

/**
 * Cria uma folha de pagamento para cada competencia e "semest" da tabela do ponto
 */
insert into rhfolhapagamento
select nextval('rhfolhapagamento_rh141_sequencial_seq'),
       r48_semest,
       r48_anousu,
       r48_mesusu,
       r48_anousu,
       r48_mesusu,
       r48_instit,
       3,
       false,
       'Folha complementar número: ' || r48_semest || ' da competência: ' || r48_anousu || '/' || r48_mesusu || ' gerada automaticamente.'
  from w_migracao_rhfolhapagamento
  order by r48_anousu asc,
           r48_mesusu asc,
           r48_semest asc;

/**
 * Resgata o sequencial da ultima folha de pagamento de cada competencia
 */

create table w_ultimafolhadecadacompetencia as
select max(rh141_codigo) as ultimafolha,
                           rh141_anousu,
                           rh141_mesusu,
                           rh141_instit
  from rhfolhapagamento
group by rh141_anousu,rh141_mesusu, rh141_instit;

/**
 * Lança os registros do histórico do ponto
 */
insert into rhhistoricoponto
  (rh144_sequencial,rh144_regist,rh144_folhapagamento,rh144_rubrica,rh144_quantidade,rh144_valor)
select nextval('rhhistoricoponto_rh144_sequencial_seq'),
       r47_regist,
       rhfolhapagamento.rh141_sequencial,
       r47_rubric,
       r47_quant,
       r47_valor
  from pontocom
  inner join w_ultimafolhadecadacompetencia on w_ultimafolhadecadacompetencia.rh141_anousu = r47_anousu
                                           and w_ultimafolhadecadacompetencia.rh141_mesusu = r47_mesusu
                                           and w_ultimafolhadecadacompetencia.rh141_instit = r47_instit
  inner join rhfolhapagamento               on w_ultimafolhadecadacompetencia.rh141_mesusu = rhfolhapagamento.rh141_mesusu
                                           and w_ultimafolhadecadacompetencia.rh141_anousu = rhfolhapagamento.rh141_anousu
                                           and w_ultimafolhadecadacompetencia.rh141_instit = rhfolhapagamento.rh141_instit
                                           and w_ultimafolhadecadacompetencia.ultimafolha  = rhfolhapagamento.rh141_codigo
order by rh141_sequencial;

/**
 * Lança os registros do histórico do ponto
 */
insert into rhhistoricocalculo
select nextval('rhhistoricocalculo_rh143_sequencial_seq'),
       r48_regist,
       rhfolhapagamento.rh141_sequencial,
       r48_rubric,
       r48_quant,
       r48_valor,
       r48_pd
  from gerfcom
inner join rhfolhapagamento                 on  r48_anousu      = rh141_anousu
                                           and  r48_mesusu      = rh141_mesusu
                                           and  r48_instit      = rh141_instit
                                           and  rh141_codigo    = r48_semest
                                           and  rh141_tipofolha = 3
order by rh141_sequencial;

----------------------------------------------------
---- TIME FINANCEIRO
---- PATRIMONIAL
----------------------------------------------------

CREATE SEQUENCE conlancamordem_c03_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE conlancamordem(
c03_sequencial  int4 NOT NULL  default nextval('conlancamordem_c03_sequencial_seq'),
c03_codlan      int4 NOT NULL ,
c03_ordem       int4 NOT NULL,
CONSTRAINT conlancamordem_sequ_pk PRIMARY KEY (c03_sequencial));

ALTER TABLE conlancamordem
ADD CONSTRAINT conlancamordem_codlan_fk FOREIGN KEY (c03_codlan)
REFERENCES conlancam;

CREATE  INDEX conlancamordem_c03_codlan_in ON conlancamordem(c03_codlan);

ALTER SEQUENCE conlancamordem_c03_sequencial_seq restart;
INSERT INTO conlancamordem
SELECT nextval('conlancamordem_c03_sequencial_seq'), c70_codlan, currval('conlancamordem_c03_sequencial_seq')
FROM conlancam ORDER BY c70_codlan;

alter table contacorrentedetalhe add column c19_estrutural varchar(15) default null,
                                 add column c19_orcdotacao int4 default null,
                                 add column c19_orcdotacaoanousu int4 default null,
                                 add constraint contacorrentedetalhe_ae_orcdotacao_fk foreign key (c19_orcdotacaoanousu, c19_orcdotacao) references orcdotacao,
                                 drop constraint contacorrentedetalhe_tipo,
                                 add constraint contacorrentedetalhe_tipo check (
                                    case
                                        when c19_contacorrente = 1 then
                                        case
                                            when c19_contabancaria is not null
                                              or c19_numemp is not null
                                              or c19_numcgm is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_acordo is not null
                                              or c19_estrutural is not null
                                              or c19_orcdotacao is not null
                                              or c19_orcdotacaoanousu is not null then false
                                            else true
                                        end
                                        when c19_contacorrente = 2 then
                                        case
                                            when c19_orctiporec is not null
                                              or c19_concarpeculiar is not null
                                              or c19_numemp is not null
                                              or c19_numcgm is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_acordo is not null
                                              or c19_estrutural is not null
                                              or c19_orcdotacao is not null
                                              or c19_orcdotacaoanousu is not null then false
                                            else true
                                        end
                                        when c19_contacorrente = 3 then
                                        case
                                            when c19_orctiporec is not null
                                              or c19_concarpeculiar is not null
                                              or c19_numemp is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_contabancaria is not null
                                              or c19_acordo is not null
                                              or c19_estrutural is not null
                                              or c19_orcdotacao is not null
                                              or c19_orcdotacaoanousu is not null then false
                                            else true
                                        end
                                        when c19_contacorrente = 19 then
                                        case
                                            when c19_orctiporec is not null
                                              or c19_concarpeculiar is not null
                                              or c19_contabancaria is not null
                                              or c19_acordo is not null
                                              or c19_estrutural is not null
                                              or c19_orcdotacao is not null
                                              or c19_orcdotacaoanousu is not null then false
                                            else true
                                        end
                                        when c19_contacorrente = 25 then
                                        case
                                            when c19_orctiporec is not null
                                              or c19_concarpeculiar is not null
                                              or c19_contabancaria is not null
                                              or c19_numemp is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_estrutural is not null
                                              or c19_orcdotacao is not null
                                              or c19_orcdotacaoanousu is not null then false
                                            else true
                                        end
                                        when c19_contacorrente = 100 then
                                          case
                                            when c19_concarpeculiar is not null
                                              or c19_contabancaria is not null
                                              or c19_numemp is not null
                                              or c19_numcgm is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_acordo is not null
                                              or c19_orcdotacao is not null
                                              or c19_orcdotacaoanousu is not null then false
                                            else true
                                          end
                                        when c19_contacorrente = 101 then
                                          case
                                            when c19_concarpeculiar is not null
                                              or c19_contabancaria is not null
                                              or c19_numemp is not null
                                              or c19_numcgm is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_acordo is not null then false
                                            else true
                                          end
                                        when c19_contacorrente = 102 then
                                          case
                                            when c19_concarpeculiar is not null
                                              or c19_contabancaria is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_acordo is not null then false
                                            else true
                                          end
                                        when c19_contacorrente = 103 then
                                          case
                                            when c19_concarpeculiar is not null
                                              or c19_contabancaria is not null
                                              or c19_numemp is not null
                                              or c19_numcgm is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_acordo is not null
                                              or c19_estrutural is not null
                                              or c19_orcdotacao is not null
                                              or c19_orcdotacaoanousu is not null then false
                                            else true
                                          end
                                        when c19_contacorrente = 104 then
                                          case
                                            when c19_orctiporec is not null
                                              or c19_concarpeculiar is not null
                                              or c19_contabancaria is not null
                                              or c19_numemp is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_acordo is not null
                                              or c19_estrutural is not null
                                              or c19_orcdotacao is not null
                                              or c19_orcdotacaoanousu is not null then false
                                            else true
                                          end
                                        when c19_contacorrente = 105 then
                                          case
                                            when c19_orctiporec is not null
                                              or c19_concarpeculiar is not null
                                              or c19_numemp is not null
                                              or c19_numcgm is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_acordo is not null
                                              or c19_estrutural is not null
                                              or c19_orcdotacao is not null
                                              or c19_orcdotacaoanousu is not null then false
                                            else true
                                          end
                                        when c19_contacorrente = 106 then
                                          case
                                            when c19_concarpeculiar is not null
                                              or c19_contabancaria is not null
                                              or c19_numcgm is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_acordo is not null then false
                                            else true
                                          end
                                        when c19_contacorrente = 107 then
                                          case
                                            when c19_orctiporec is not null
                                              or c19_concarpeculiar is not null
                                              or c19_contabancaria is not null
                                              or c19_numcgm is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_estrutural is not null
                                              or c19_orcdotacao is not null
                                              or c19_orcdotacaoanousu is not null then false
                                            else true
                                          end
                                        when c19_contacorrente = 108 then
                                          case
                                            when c19_orctiporec is not null
                                              or c19_concarpeculiar is not null
                                              or c19_contabancaria is not null
                                              or c19_numemp is not null
                                              or c19_numcgm is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_estrutural is not null
                                              or c19_orcdotacao is not null
                                              or c19_orcdotacaoanousu is not null then false
                                            else true
                                          end
                                        else null::boolean
                                    end);

----------------------------------------------------
---- TIME FINANCEIRO
---- PATRIMONIAL
---- EDUCACAO
----------------------------------------------------
---- Tarefa: 95483
----------------------------------------------------

ALTER TABLE cgs_und add column z01_codigoibge varchar(50);

----------------------------------------------------
---- Tarefa: 95540
----------------------------------------------------
alter table taxa alter COLUMN ar36_perc     type numeric(15,2);
alter table taxa alter COLUMN ar36_perc     type double precision;
alter table taxa alter COLUMN ar36_valor    type numeric(15,2);
alter table taxa alter COLUMN ar36_valor    type double precision;
alter table taxa alter COLUMN ar36_valormin type numeric(15,2);
alter table taxa alter COLUMN ar36_valormin type double precision;
alter table taxa alter COLUMN ar36_valormax type numeric(15,2);
alter table taxa alter COLUMN ar36_valormax type double precision;

-------------------------------------------------------------------------------
--                                INTEGRACAO                                 --
-------------------------------------------------------------------------------

-- Criando  sequences
CREATE SEQUENCE db_releasenotes_db147_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- Módulo: configuracoes
CREATE TABLE db_releasenotes(
db147_sequencial    int4 NOT NULL  default nextval('db_releasenotes_db147_sequencial_seq'),
db147_nomearquivo   varchar(255) NOT NULL ,
db147_db_versao   int4 NOT NULL ,
db147_id_usuario    int8 ,
CONSTRAINT db_releasenotes_sequ_pk PRIMARY KEY (db147_sequencial));

-- CHAVE ESTRANGEIRA
ALTER TABLE db_releasenotes
ADD CONSTRAINT db_releasenotes_versao_fk FOREIGN KEY (db147_db_versao)
REFERENCES db_versao;

ALTER TABLE db_releasenotes
ADD CONSTRAINT db_releasenotes_usuario_fk FOREIGN KEY (db147_id_usuario)
REFERENCES db_usuarios;

-- INDICES
CREATE  INDEX db_releasenotes_db_versao_in ON db_releasenotes(db147_db_versao);
CREATE  INDEX db_releasenotes_id_usuario_in ON db_releasenotes(db147_id_usuario);

-------------------------------------------------------------------------------
--                            FIM INTEGRACAO                                 --
-------------------------------------------------------------------------------

-- Tributário
update db_itensmenu set libcliente = false where id_item = 289582;




----------------------------------------------------
---- TIME C
---- SAUDE
----------------------------------------------------
---- Tarefa: 95051
----------------------------------------------------
alter table lab_tiporeferenciaalnumerico ADD COLUMN la30_casasdecimaisapresentacao int default null;

DROP TABLE IF EXISTS w_lab_resultadonum, w_lab_tiporeferenciaalnumerico, bkp_original_lab_resultadonum, bkp_original_lab_tiporeferenciaalnumerico;
create table bkp_original_lab_resultadonum as select * from lab_resultadonum;
create table bkp_original_lab_tiporeferenciaalnumerico as select * from lab_tiporeferenciaalnumerico;

create temp table w_lab_resultadonum as
select la41_i_codigo as codigo,
       la41_i_result,
       la41_f_valor::numeric as valor,
       la41_valorpercentual,
       la41_faixaescolhida
  from lab_resultadonum;

create temp table w_lab_tiporeferenciaalnumerico as
select
       la30_i_codigo as codigo,
       la30_i_valorref,
       la30_f_normalmin::numeric as normalmin,
       la30_f_normalmax::numeric as normalmax,
       la30_c_calculavel,
       la30_f_absurdomin::numeric as absurdomin,
       la30_f_absurdomax::numeric as absurdomax,
       la30_casasdecimaisapresentacao
 from lab_tiporeferenciaalnumerico;


alter table lab_resultadonum alter column la41_f_valor type double precision;

alter table lab_tiporeferenciaalnumerico alter column la30_f_normalmin  type double precision;
alter table lab_tiporeferenciaalnumerico alter column la30_f_normalmax  type double precision;
alter table lab_tiporeferenciaalnumerico alter column la30_f_absurdomin type double precision;
alter table lab_tiporeferenciaalnumerico alter column la30_f_absurdomax type double precision;

update lab_resultadonum
   set la41_f_valor = valor
  from w_lab_resultadonum
 where la41_i_codigo = codigo;


update lab_tiporeferenciaalnumerico
   set la30_f_normalmin  = normalmin,
       la30_f_normalmax  = normalmax,
       la30_f_absurdomin = absurdomin,
       la30_f_absurdomax = absurdomax
  from w_lab_tiporeferenciaalnumerico
 where lab_tiporeferenciaalnumerico.la30_i_codigo = codigo;
