---------------------------------------------------------------------------------------------
-------------------------------- INCIO FINANCEIRO -------------------------------------------
---------------------------------------------------------------------------------------------

-- Manutenção de veículos

alter table veicmanut alter column ve62_vlrmobra type numeric,
                      alter column ve62_vlrpecas type numeric,
                      alter column ve62_medida   type numeric,
                      add column   ve62_situacao integer not null default 2,
                      add column   ve62_numero   integer not null default 0,
                      add column   ve62_anousu   integer not null default 0,
                      add column ve62_veicmotoristas integer default null references veicmotoristas(ve05_codigo);

alter table veicmanutitem alter column ve63_quant  type numeric,
                          alter column ve63_vlruni type numeric,
                          add column ve63_valortotalcomdesconto numeric not null default 0,
                          add column ve63_unidade               integer references matunid(m61_codmatunid),
                          add column ve63_tipoitem              integer not null default 1,
                          add column ve63_proximatroca numeric default null,
                          add column ve63_datanota date  default null,
                          add column ve63_numeronota varchar(10) default null;


alter table veicmanut alter column ve62_numero drop default;
alter table veicmanut alter column ve62_anousu drop default;

update veicmanut set ve62_numero = ve62_codigo,
                     ve62_anousu = extract(year from ve62_data);

update veicmanutitem set ve63_valortotalcomdesconto = ve63_vlruni * ve63_quant;

-- Procura 'Unidade', se não encontrar deixa nulo
update veicmanutitem set ve63_unidade = (select m61_codmatunid from matunid where m61_descr = 'UNIDADE' limit 1);

-- Autorização para circulação de veículos

create sequence autorizacaocirculacaoveiculo_ve13_sequencial_seq
increment 1
minvalue  1
maxvalue  9223372036854775807
start     1
cache     1;

create table autorizacaocirculacaoveiculo(
ve13_sequencial   int4 not null default nextval('autorizacaocirculacaoveiculo_ve13_sequencial_seq'),
ve13_instituicao  int4 not null,
ve13_veiculo      int4 not null,
ve13_motorista    int4 not null,
ve13_datainicial  date not null,
ve13_datafinal    date not null,
ve13_dataemissao  date not null,
ve13_observacao   text,
ve13_departamento int4 not null,
constraint autorizacaocirculacaoveiculo_sequ_pk primary key (ve13_sequencial));

alter table    autorizacaocirculacaoveiculo
add constraint autorizacaocirculacaoveiculo_instituicao_fk foreign key (ve13_instituicao)
references     db_config;

alter table    autorizacaocirculacaoveiculo
add constraint autorizacaocirculacaoveiculo_motorista_fk   foreign key (ve13_motorista)
references     veicmotoristas;

alter table    autorizacaocirculacaoveiculo
add constraint autorizacaocirculacaoveiculo_veiculo_fk     foreign key (ve13_veiculo)
references     veiculos;

alter table    autorizacaocirculacaoveiculo
add constraint autorizacaocirculacaoveiculo_departamento_fk foreign key (ve13_departamento)
references     db_depart;

create index autorizacaocirculacaoveiculo_veiculo_in on autorizacaocirculacaoveiculo(ve13_veiculo);
create index autorizacaocirculacaoveiculo_motorista_in on autorizacaocirculacaoveiculo(ve13_motorista);
create index autorizacaocirculacaoveiculo_instituicao_in on autorizacaocirculacaoveiculo(ve13_instituicao);
create index autorizacaocirculacaoveiculo_departamento_in on autorizacaocirculacaoveiculo(ve13_departamento);

alter table orcprogramahorizontetemp alter o17_valor type numeric;
update db_syscampo set tamanho = 20 where codcam = 13657;

-- Levantamento Patrimonial

create sequence levantamentopatrimonial_p13_sequencial_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create sequence levantamentopatrimonialbens_p14_sequencial_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create table levantamentopatrimonial(
p13_sequencial   int4 not null default nextval('levantamentopatrimonial_p13_sequencial_seq'),
p13_departamento int4 not null,
p13_data         date not null,
constraint levantamentopatrimonial_sequ_pk primary key (p13_sequencial));

create table levantamentopatrimonialbens(
p14_sequencial              int4        not null default nextval('levantamentopatrimonialbens_p14_sequencial_seq'),
p14_levantamentopatrimonial int4        not null,
p14_placa                   varchar(50) not null,
constraint levantamentopatrimonialbens_sequ_pk primary key (p14_sequencial));

alter table levantamentopatrimonial
add constraint levantamentopatrimonial_departamento_fk foreign key (p13_departamento)
references db_depart;

alter table levantamentopatrimonialbens
add constraint levantamentopatrimonialbens_levantamentopatrimonial_fk foreign key (p14_levantamentopatrimonial)
references levantamentopatrimonial;

create index levantamentopatrimonial_departamento_in on levantamentopatrimonial(p13_departamento);
create index levantamentopatrimonialbens_levantamentopatrimonial_in on levantamentopatrimonialbens(p14_levantamentopatrimonial);

-- Liquidação com Desconto
create sequence pagordemdescontoempanulado_e06_sequencial_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create table pagordemdescontoempanulado(
e06_sequencial		   int4 not null default 0,
e06_empanulado		   int4 not null default 0,
e06_pagordemdesconto int4  not null default 0,
constraint pagordemdescontoempanulado_empa_pk primary key(e06_empanulado));

alter table pagordemdescontoempanulado
add constraint pagordemdescontoempanulado_empanulado_fk foreign key (e06_empanulado)
references empanulado;

alter table pagordemdescontoempanulado
add constraint pagordemdescontoempanulado_pagordemdesconto_fk foreign key (e06_pagordemdesconto)
references pagordemdesconto;

create index pagordemdescontoempanulado_pagordemdesconto_in on pagordemdescontoempanulado(e06_pagordemdesconto);
create index pagordemdescontoempanulado_empanulado_in on pagordemdescontoempanulado(e06_empanulado);
create index pagordemdescontoempanulado_sequencial_in on pagordemdescontoempanulado(e06_sequencial);
---------------------------------------------------------------------------------------------
-------------------------------- FIM FINANCEIRO---------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
------------------------------ INÍCIO EDUCAÇÃO/SAÚDE ----------------------------------------
---------------------------------------------------------------------------------------------
CREATE SEQUENCE pontoparadaescolaproc_tre13_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE pontoparadaescolaproc(
tre13_sequencial   int4 NOT NULL default 0,
tre13_pontoparada  int4 NOT NULL default 0,
tre13_escolaproc   int4 default 0,
CONSTRAINT pontoparadaescolaproc_sequ_pk PRIMARY KEY (tre13_sequencial));

ALTER TABLE pontoparadaescolaproc
ADD CONSTRAINT pontoparadaescolaproc_pontoparada_fk FOREIGN KEY (tre13_pontoparada)
REFERENCES pontoparada;

ALTER TABLE pontoparadaescolaproc
ADD CONSTRAINT pontoparadaescolaproc_escolaproc_fk FOREIGN KEY (tre13_escolaproc)
REFERENCES escolaproc;

CREATE UNIQUE INDEX pontoparadaescolaproc_pontoparada_escolaproc_in ON pontoparadaescolaproc(tre13_pontoparada,tre13_escolaproc);

-- Matricula Online

CREATE SEQUENCE ciclos_mo09_codigo_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE fase_mo04_codigo_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE ciclosensino_mo14_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE vagas_mo10_codigo_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE tiporesp_mo06_codigo_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE redeorigem_mo05_codigo_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE idadeetapa_mo15_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;


CREATE TABLE ciclos(
mo09_codigo     int8 NOT NULL default 0,
mo09_status     bool NOT NULL default 'f',
mo09_dtcad      date NOT NULL default null,
mo09_descricao  varchar(100) NOT NULL ,
mo09_sigla      varchar(10)  ,
mo09_eja        bool default 'f',
CONSTRAINT ciclos_codi_pk PRIMARY KEY (mo09_codigo));

CREATE TABLE fase(
mo04_codigo     int8 NOT NULL default 0,
mo04_desc       varchar(100) NOT NULL ,
mo04_anousu     int4 NOT NULL default 0,
mo04_dtfim      date NOT NULL default null,
mo04_dtini      date NOT NULL default null,
mo04_ciclo      int8 default 0,
mo04_datacorte  date default null,
mo04_processada bool default 'f',
CONSTRAINT fase_codi_pk PRIMARY KEY (mo04_codigo));

CREATE TABLE ciclosensino(
mo14_sequencial  int4 NOT NULL default 0,
mo14_ciclo       int4 NOT NULL default 0,
mo14_ensino      int4 default 0,
CONSTRAINT ciclosensino_sequ_pk PRIMARY KEY (mo14_sequencial));

CREATE TABLE vagas(
mo10_codigo     int8 default 0,
mo10_fase       int8 default 0,
mo10_escola     int8 default 0,
mo10_ensino     int8 default 0,
mo10_serie      int8 default 0,
mo10_turno      int8 default 0,
mo10_numvagas   int4 default 0,
mo10_saldovagas int4 default 0,
CONSTRAINT vagas_codi_pk PRIMARY KEY (mo10_codigo));

-- tiporesp
CREATE TABLE tiporesp(
mo06_codigo   int4 NOT NULL default 0,
mo06_descr    varchar(100) ,
CONSTRAINT tiporesp_codi_pk PRIMARY KEY (mo06_codigo));
insert into tiporesp values (1, 'PAI');
insert into tiporesp values (2, 'MAE');
insert into tiporesp values (3, 'PROPRIO');
insert into tiporesp values (4, 'OUTROS');

 -- redeorigem
CREATE TABLE redeorigem(
mo05_codigo   int4 NOT NULL default 0,
mo05_descr    varchar(100) ,
CONSTRAINT redeorigem_codi_pk PRIMARY KEY (mo05_codigo));

-- idadeetapa
CREATE TABLE idadeetapa(
mo15_sequencial   int4 NOT NULL default 0,
mo15_etapa    int4 NOT NULL default 0,
mo15_idadeinicial   interval  ,
mo15_idadefinal   interval ,
CONSTRAINT idadeetapa_sequ_pk PRIMARY KEY (mo15_sequencial));

ALTER TABLE vagas ADD CONSTRAINT vagas_ensino_fk FOREIGN KEY (mo10_ensino) REFERENCES ensino;
ALTER TABLE vagas ADD CONSTRAINT vagas_escola_fk FOREIGN KEY (mo10_escola) REFERENCES escola;
ALTER TABLE vagas ADD CONSTRAINT vagas_turno_fk FOREIGN KEY (mo10_turno) REFERENCES turno;
ALTER TABLE vagas ADD CONSTRAINT vagas_serie_fk FOREIGN KEY (mo10_serie) REFERENCES serie;
ALTER TABLE vagas ADD CONSTRAINT vagas_fase_fk FOREIGN KEY (mo10_fase) REFERENCES fase;
ALTER TABLE fase ADD CONSTRAINT fase_ciclo_fk FOREIGN KEY (mo04_ciclo) REFERENCES ciclos;
ALTER TABLE idadeetapa ADD CONSTRAINT idadeetapa_etapa_fk FOREIGN KEY (mo15_etapa) REFERENCES serie;
ALTER TABLE ciclosensino ADD CONSTRAINT ciclosensino_ciclo_fk FOREIGN KEY (mo14_ciclo) REFERENCES ciclos;
ALTER TABLE ciclosensino ADD CONSTRAINT ciclosensino_ensino_fk FOREIGN KEY (mo14_ensino) REFERENCES ensino;


CREATE  INDEX fase_ciclo_in ON fase(mo04_ciclo);
CREATE  INDEX idadeetapa_etapa_in ON idadeetapa(mo15_etapa);
CREATE UNIQUE INDEX ciclosensino_ciclo_ensino_in ON ciclosensino(mo14_ciclo,mo14_ensino);

-- estcivil
CREATE SEQUENCE estcivil_mo07_codigo_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE estcivil(
mo07_codigo   int4 NOT NULL default 0,
mo07_descr    varchar(50) ,
CONSTRAINT estcivil_codi_pk PRIMARY KEY (mo07_codigo));

INSERT INTO estcivil VALUES ( 1, 'SOLTEIRO' );
INSERT INTO estcivil VALUES ( 2, 'CASADO' );
INSERT INTO estcivil VALUES ( 3, 'VIÚVO' );
INSERT INTO estcivil VALUES ( 4, 'DIVORCIADO' );


CREATE SEQUENCE escbairro_mo08_codigo_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE escbairro(
mo08_codigo int4 NOT NULL default 0,
mo08_escola int4 NOT NULL default 0,
mo08_bairro int4 default 0,
CONSTRAINT escbairro_codi_pk PRIMARY KEY (mo08_codigo));


ALTER TABLE escbairro ADD CONSTRAINT escbairro_escola_fk FOREIGN KEY (mo08_escola) REFERENCES escola;
ALTER TABLE escbairro ADD CONSTRAINT escbairro_bairro_fk FOREIGN KEY (mo08_bairro) REFERENCES bairro;

CREATE  INDEX escbairro_bairro_in ON escbairro(mo08_bairro);
CREATE  INDEX escbairro_escola_in ON escbairro(mo08_escola);

-- Tabela mobase
CREATE SEQUENCE mobase_mo01_codigo_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE mobase(
mo01_codigo     int4 NOT NULL default 0,
mo01_nome       varchar(70) NOT NULL ,
mo01_tipoender  varchar(10)  ,
mo01_ender      varchar(100) NOT NULL ,
mo01_numero     varchar(10)  ,
mo01_compl      varchar(20) NOT NULL ,
mo01_bairro     int4 NOT NULL default 0,
mo01_cep    varchar(20) NOT NULL ,
mo01_uf   varchar(5)  ,
mo01_municip    varchar(100) NOT NULL ,
mo01_nacion   varchar(40) NOT NULL ,
mo01_telef    varchar(12)  ,
mo01_ident    varchar(20)  ,
mo01_orgident   varchar(20)  ,
mo01_tiporesp   int4 NOT NULL default 0,
mo01_nomeresp   varchar(70)  ,
mo01_telresp    varchar(12)  ,
mo01_identresp    varchar(20)  ,
mo01_orgidresp    varchar(20)  ,
mo01_cpfresp    varchar(11)  ,
mo01_emailresp    varchar(50)  ,
mo01_certidaotipo   int4  default 0,
mo01_certidaonum    varchar(8)  ,
mo01_certidaolivro    varchar(8)  ,
mo01_certidaofolha    varchar(4)  ,
mo01_certidaocart   varchar(150)  ,
mo01_ufcartcert   int4  default 0,
mo01_muncartcert    int4  default 0,
mo01_certidaodata   date  default null,
mo01_nis    varchar(11)  ,
mo01_dtnasc   date NOT NULL default null,
mo01_ufnasc   int4  default 0,
mo01_munnasc    int4  default 0,
mo01_estciv   int4  default 0,
mo01_cpf    varchar(11)  ,
mo01_email    varchar(100)  ,
mo01_mae    varchar(70)  ,
mo01_pai    varchar(70)  ,
mo01_sexo   char(1) NOT NULL ,
mo01_telcel   varchar(12)  ,
mo01_serie    int4 NOT NULL default 0,
mo01_redeorigem   int4 NOT NULL default 0,
mo01_datacad    date NOT NULL default null,
mo01_necess   int4  default 0,
mo01_certidaomatricula    varchar(32) ,
mo01_bolsafamilia boolean default false,
mo01_responsaveltrabalhador boolean default false,
CONSTRAINT mobase_codi_pk PRIMARY KEY (mo01_codigo));

ALTER TABLE mobase ADD CONSTRAINT mobase_bairro_fk FOREIGN KEY (mo01_bairro) REFERENCES bairro;
ALTER TABLE mobase ADD CONSTRAINT mobase_tiporesp_fk FOREIGN KEY (mo01_tiporesp) REFERENCES tiporesp;
ALTER TABLE mobase ADD CONSTRAINT mobase_estciv_fk FOREIGN KEY (mo01_estciv) REFERENCES estcivil;
ALTER TABLE mobase ADD CONSTRAINT mobase_serie_fk FOREIGN KEY (mo01_serie) REFERENCES serie;
ALTER TABLE mobase ADD CONSTRAINT mobase_redeorigem_fk FOREIGN KEY (mo01_redeorigem) REFERENCES redeorigem;

CREATE  INDEX mobase_bairro_in ON mobase(mo01_bairro);
CREATE  INDEX mobase_cpfresp_in ON mobase(mo01_cpfresp);
CREATE  INDEX mobase_nome_in ON mobase(mo01_nome);
CREATE  INDEX mobase_redeorigem_in ON mobase(mo01_redeorigem);
CREATE  INDEX mobase_serie_in ON mobase(mo01_serie);


--tabela basefase
CREATE SEQUENCE basefase_mo12_codigo_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE basefase(
mo12_codigo   int4 NOT NULL default 0,
mo12_base   int4 NOT NULL default 0,
mo12_fase   int4 NOT NULL default 0,
mo12_status   bool default 'false',
CONSTRAINT basefase_codi_pk PRIMARY KEY (mo12_codigo));

ALTER TABLE basefase
ADD CONSTRAINT basefase_fase_fk FOREIGN KEY (mo12_fase)
REFERENCES fase;

ALTER TABLE basefase
ADD CONSTRAINT basefase_base_fk FOREIGN KEY (mo12_base)
REFERENCES mobase;

CREATE  INDEX basefase_fase_in ON basefase(mo12_fase);
CREATE  INDEX basefase_base_in ON basefase(mo12_base);

CREATE SEQUENCE basenecess_mo11_codigo_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE TABLE basenecess(
mo11_codigo   int4 NOT NULL default 0,
mo11_base   int4 NOT NULL default 0,
mo11_necess   int4 NOT NULL default 0,
mo11_status   bool default 'f',
CONSTRAINT basenecess_codi_pk PRIMARY KEY (mo11_codigo));
ALTER TABLE basenecess ADD CONSTRAINT basenecess_base_fk FOREIGN KEY (mo11_base) REFERENCES mobase;
ALTER TABLE basenecess ADD CONSTRAINT basenecess_necess_fk FOREIGN KEY (mo11_necess) REFERENCES necessidade;
CREATE  INDEX basenecess_necess_in ON basenecess(mo11_necess);
CREATE  INDEX basenecess_base_in ON basenecess(mo11_base);

-- tabela baseescola
CREATE SEQUENCE baseescola_mo02_codigo_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE baseescola(
mo02_codigo   int4 NOT NULL default 0,
mo02_base   int4 NOT NULL default 0,
mo02_escola   int4 NOT NULL default 0,
mo02_dtcad    date NOT NULL default null,
mo02_status   bool default 'false',
CONSTRAINT baseescola_codi_pk PRIMARY KEY (mo02_codigo));

ALTER TABLE baseescola
ADD CONSTRAINT baseescola_escola_fk FOREIGN KEY (mo02_escola)
REFERENCES escola;

ALTER TABLE baseescola
ADD CONSTRAINT baseescola_base_fk FOREIGN KEY (mo02_base)
REFERENCES mobase;

CREATE  INDEX baseescola_escola_in ON baseescola(mo02_escola);

CREATE  INDEX baseescola_base_in ON baseescola(mo02_base);

-- tabela baseescturno
CREATE SEQUENCE baseescturno_mo03_codigo_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE baseescturno(
mo03_codigo   int4 NOT NULL default 0,
mo03_baseescola   int4 NOT NULL default 0,
mo03_turno    int4 NOT NULL default 0,
mo03_dtcad    date NOT NULL default null,
mo03_status   bool NOT NULL default 'false',
mo03_opcao    int4 default 0,
CONSTRAINT baseescturno_codi_pk PRIMARY KEY (mo03_codigo));

ALTER TABLE baseescturno
ADD CONSTRAINT baseescturno_baseescola_fk FOREIGN KEY (mo03_baseescola)
REFERENCES baseescola;

ALTER TABLE baseescturno
ADD CONSTRAINT baseescturno_turno_fk FOREIGN KEY (mo03_turno)
REFERENCES turno;

CREATE  INDEX baseescturno_turno_in ON baseescturno(mo03_turno);

CREATE  INDEX baseescturno_baseescola_in ON baseescturno(mo03_baseescola);

-- tabela alocados
CREATE SEQUENCE alocados_mo13_codigo_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE alocados(
mo13_codigo   int4 NOT NULL default 0,
mo13_base   int4 NOT NULL default 0,
mo13_fase   int4 NOT NULL default 0,
mo13_baseescturno   int4 default 0,
CONSTRAINT alocados_codi_pk PRIMARY KEY (mo13_codigo));

ALTER TABLE alocados
ADD CONSTRAINT alocados_fase_fk FOREIGN KEY (mo13_fase)
REFERENCES fase;

ALTER TABLE alocados
ADD CONSTRAINT alocados_baseescturno_fk FOREIGN KEY (mo13_baseescturno)
REFERENCES baseescturno;

ALTER TABLE alocados
ADD CONSTRAINT alocados_base_fk FOREIGN KEY (mo13_base)
REFERENCES mobase;

CREATE  INDEX alocados_baseescturno_in ON alocados(mo13_baseescturno);

CREATE  INDEX alocados_fase_in ON alocados(mo13_fase);

CREATE  INDEX alocados_base_in ON alocados(mo13_base);

 insert into redeorigem values (1 , 'FEDERAL');
 insert into redeorigem values (2 , 'ESTADUAL');
 insert into redeorigem values (3 , 'MUNICIPAL');
 insert into redeorigem values (4 , 'PARTICULAR');
 insert into redeorigem values (5 , 'MST');
 insert into redeorigem values (6 , 'INCRA');
 insert into redeorigem values (7 , 'AFASTADO');
 insert into redeorigem values (8 , 'INICIAL');



CREATE SEQUENCE criteriosdesignacao_mo16_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE criteriosdesignacaoensino_mo17_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE criteriosdesignacao(
mo16_sequencial int4 NOT NULL default 0,
mo16_descricao  varchar(30) ,
CONSTRAINT criteriosdesignacao_sequ_pk PRIMARY KEY (mo16_sequencial));

CREATE TABLE criteriosdesignacaoensino(
mo17_sequencial int4 NOT NULL default 0,
mo17_criteriosdesignacao    int4 NOT NULL default 0,
mo17_ensino   int4 NOT NULL default 0,
mo17_ordem    int4 default 0,
CONSTRAINT criteriosdesignacaoensino_sequ_pk PRIMARY KEY (mo17_sequencial));

ALTER TABLE criteriosdesignacaoensino ADD CONSTRAINT criteriosdesignacaoensino_criteriosdesignacao_fk FOREIGN KEY (mo17_criteriosdesignacao) REFERENCES criteriosdesignacao;
ALTER TABLE criteriosdesignacaoensino ADD CONSTRAINT criteriosdesignacaoensino_ensino_fk FOREIGN KEY (mo17_ensino) REFERENCES ensino;

CREATE  INDEX criteriosdesignacaoensino_ensino_in ON criteriosdesignacaoensino(mo17_ensino);
CREATE  INDEX criteriosdesignacaoensino_criteriosdesignacao_in ON criteriosdesignacaoensino(mo17_criteriosdesignacao);

insert into criteriosdesignacao
  values (nextval('criteriosdesignacao_mo16_sequencial_seq'), 'DEFICIÊNCIA'),
         (nextval('criteriosdesignacao_mo16_sequencial_seq'), 'BOLSA FAMÍLIA'),
         (nextval('criteriosdesignacao_mo16_sequencial_seq'), 'IDADE MAIOR'),
         (nextval('criteriosdesignacao_mo16_sequencial_seq'), 'RESPONSÁVEL TRABALHADOR'),
         (nextval('criteriosdesignacao_mo16_sequencial_seq'), 'IDADE MENOR'),
         (nextval('criteriosdesignacao_mo16_sequencial_seq'), 'REDE DE ORIGEM');



CREATE SEQUENCE dadoscompetenciadispensacao_fa61_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE dadoscompetenciaentrada_fa62_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE dadoscompetenciasaida_fa63_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE integracaohorusenvio_fa64_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE integracaohorusenviodadoscompetencia_fa65_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE situacaohorus_fa60_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

alter table integracaohorus add  column fa59_situacaohorus integer not null;
alter table integracaohorus drop column fa59_data;
alter table integracaohorus drop column fa59_protocolo;
alter table integracaohorus add  column fa59_db_depart integer not null;

CREATE TABLE dadoscompetenciadispensacao(
fa61_sequencial   int4 NOT NULL default 0,
fa61_far_retiradaitens    int4 NOT NULL default 0,
fa61_integracaohorus    int4 NOT NULL default 0,
fa61_enviar   bool NOT NULL default 'f',
fa61_validadohorus    bool NOT NULL default 'f',
fa61_unidade    int4 NOT NULL default 0,
fa61_cnes   varchar(10) NOT NULL ,
fa61_catmat   varchar(20) NOT NULL ,
fa61_tipo   char(1) NOT NULL default 'B',
fa61_valor    numeric NOT NULL default 0,
fa61_validade   date default null,
fa61_lote   varchar(50),
fa61_quantidade   int4 NOT NULL default 0,
fa61_dispensacao    date NOT NULL default null,
fa61_cns    varchar(15),
CONSTRAINT dadoscompetenciadispensacao_sequ_pk PRIMARY KEY (fa61_sequencial));

CREATE TABLE dadoscompetenciaentrada(
fa62_sequencial   int4 NOT NULL default 0,
fa62_integracaohorus    int4 NOT NULL default 0,
fa62_matestoqueinimei   int4 NOT NULL default 0,
fa62_unidade    int4 NOT NULL default 0,
fa62_enviar   bool NOT NULL default 'f',
fa62_validadohorus    bool NOT NULL default 'f',
fa62_cnes   varchar(10) NOT NULL ,
fa62_catmat   varchar(20) NOT NULL ,
fa62_tipo   char(1) NOT NULL default 'B',
fa62_valor    numeric NOT NULL default 0,
fa62_validade   date default null,
fa62_lote   varchar(50),
fa62_quantidade   int4 NOT NULL default 0,
fa62_recebimento    date NOT NULL default null,
fa62_movimentacao   varchar(15) ,
CONSTRAINT dadoscompetenciaentrada_sequ_pk PRIMARY KEY (fa62_sequencial));

CREATE TABLE dadoscompetenciasaida(
fa63_sequencial   int4 NOT NULL default 0,
fa63_integracaohorus    int4 NOT NULL default 0,
fa63_matestoqueinimei   int4 NOT NULL default 0,
fa63_unidade    int4 NOT NULL default 0,
fa63_enviar   bool NOT NULL default 'f',
fa63_validadohorus    bool NOT NULL default 'f',
fa63_catmat   varchar(20) NOT NULL ,
fa63_cnes   varchar(10) NOT NULL ,
fa63_tipo   char(1) NOT NULL default 'B',
fa63_valor    numeric NOT NULL default 0,
fa63_lote   varchar(50)  ,
fa63_validade   date default null,
fa63_quantidade   int4 NOT NULL default 0,
fa63_data   date NOT NULL default null,
fa63_movimentacao   varchar(15) ,
CONSTRAINT dadoscompetenciasaida_sequ_pk PRIMARY KEY (fa63_sequencial));

CREATE TABLE integracaohorusenvio(
fa64_sequencial   int4 NOT NULL default 0,
fa64_protocolo    text NOT NULL ,
fa64_hora         time NOT NULL ,
fa64_data         date NOT NULL default null,
fa64_integracaohorus    int4 default 0,
CONSTRAINT integracaohorusenvio_sequ_pk PRIMARY KEY (fa64_sequencial));

CREATE TABLE integracaohorusenviodadoscompetencia(
fa65_sequencial   int4 NOT NULL default 0,
fa65_integracaohorusenvio   int4 NOT NULL default 0,
fa65_dadoscompetencia   int4 default 0,
CONSTRAINT integracaohorusenviodadoscompetencia_sequ_pk PRIMARY KEY (fa65_sequencial));

CREATE TABLE situacaohorus(
fa60_sequencial   int4 NOT NULL default 0,
fa60_descricao    varchar(30) ,
CONSTRAINT situacaohorus_sequ_pk PRIMARY KEY (fa60_sequencial));

insert into situacaohorus
     values (nextval('situacaohorus_fa60_sequencial_seq'), 'SEM DADOS'),
            (nextval('situacaohorus_fa60_sequencial_seq'), 'AGUARDANDO ENVIO'),
            (nextval('situacaohorus_fa60_sequencial_seq'), 'PARCIALMENTE ENVIADO'),
            (nextval('situacaohorus_fa60_sequencial_seq'), 'AGUARDANDO HORUS'),
            (nextval('situacaohorus_fa60_sequencial_seq'), 'INCONSISTENTE'),
            (nextval('situacaohorus_fa60_sequencial_seq'), 'CONCLUÍDO');

ALTER TABLE dadoscompetenciadispensacao ADD CONSTRAINT dadoscompetenciadispensacao_unidade_fk FOREIGN KEY (fa61_unidade) REFERENCES unidades;
ALTER TABLE dadoscompetenciadispensacao ADD CONSTRAINT dadoscompetenciadispensacao_retiradaitens_fk FOREIGN KEY (fa61_far_retiradaitens) REFERENCES far_retiradaitens;
ALTER TABLE dadoscompetenciadispensacao ADD CONSTRAINT dadoscompetenciadispensacao_integracaohorus_fk FOREIGN KEY (fa61_integracaohorus) REFERENCES integracaohorus;
ALTER TABLE dadoscompetenciaentrada ADD CONSTRAINT dadoscompetenciaentrada_unidade_fk FOREIGN KEY (fa62_unidade) REFERENCES unidades;
ALTER TABLE dadoscompetenciaentrada ADD CONSTRAINT dadoscompetenciaentrada_integracaohorus_fk FOREIGN KEY (fa62_integracaohorus) REFERENCES integracaohorus;
ALTER TABLE dadoscompetenciaentrada ADD CONSTRAINT dadoscompetenciaentrada_matestoqueinimei_fk FOREIGN KEY (fa62_matestoqueinimei) REFERENCES matestoqueinimei;
ALTER TABLE dadoscompetenciasaida ADD CONSTRAINT dadoscompetenciasaida_unidade_fk FOREIGN KEY (fa63_unidade) REFERENCES unidades;
ALTER TABLE dadoscompetenciasaida ADD CONSTRAINT dadoscompetenciasaida_integracaohorus_fk FOREIGN KEY (fa63_integracaohorus) REFERENCES integracaohorus;
ALTER TABLE dadoscompetenciasaida ADD CONSTRAINT dadoscompetenciasaida_matestoqueinimei_fk FOREIGN KEY (fa63_matestoqueinimei) REFERENCES matestoqueinimei;
ALTER TABLE integracaohorus ADD CONSTRAINT integracaohorus_situacaohorus_fk FOREIGN KEY (fa59_situacaohorus) REFERENCES situacaohorus;
ALTER TABLE integracaohorusenvio ADD CONSTRAINT integracaohorusenvio_integracaohorus_fk FOREIGN KEY (fa64_integracaohorus) REFERENCES integracaohorus;
ALTER TABLE integracaohorusenviodadoscompetencia ADD CONSTRAINT integracaohorusenviodadoscompetencia_integracaohorusenvio_fk FOREIGN KEY (fa65_integracaohorusenvio) REFERENCES integracaohorusenvio;
ALTER TABLE integracaohorus ADD CONSTRAINT integracaohorus_depart_fk FOREIGN KEY (fa59_db_depart) REFERENCES db_depart;

CREATE  INDEX dadoscompetenciadispensacao_unidade_in ON dadoscompetenciadispensacao(fa61_unidade);
CREATE  INDEX dadoscompetenciadispensacao_integracaohorus_in ON dadoscompetenciadispensacao(fa61_integracaohorus);
CREATE  INDEX dadoscompetenciadispensacao_far_retiradaitens_in ON dadoscompetenciadispensacao(fa61_far_retiradaitens);
CREATE  INDEX dadoscompetenciaentrada_unidade_in ON dadoscompetenciaentrada(fa62_unidade);
CREATE  INDEX dadoscompetenciaentrada_matestoqueinimei_in ON dadoscompetenciaentrada(fa62_matestoqueinimei);
CREATE  INDEX dadoscompetenciaentrada_integracaohorus_in ON dadoscompetenciaentrada(fa62_integracaohorus);
CREATE  INDEX dadoscompetenciasaida_unidade_in ON dadoscompetenciasaida(fa63_unidade);
CREATE  INDEX dadoscompetenciasaida_matestoqueinimei_in ON dadoscompetenciasaida(fa63_matestoqueinimei);
CREATE  INDEX dadoscompetenciasaida_integracaohorus_in ON dadoscompetenciasaida(fa63_integracaohorus);
CREATE  INDEX integracaohorusenvio_integracaohorus_in ON integracaohorusenvio(fa64_integracaohorus);
CREATE  INDEX integracaohorusenviodadoscompetencia_dadoscompetencia_in ON integracaohorusenviodadoscompetencia(fa65_dadoscompetencia);
CREATE  INDEX integracaohorusenviodadoscompetencia_integracaohorusenvio_in ON integracaohorusenviodadoscompetencia(fa65_integracaohorusenvio);

---------------------------------------------------------------------------------------------
-------------------------------- FIM EDUCAÇÃO/SAÚDE -----------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-------------------------------- INCIO TRIBUTARIO -------------------------------------------
---------------------------------------------------------------------------------------------

update db_itensmenu set descricao = 'Legista' where id_item = 6853;

---------------------------------------------------------------------------------------------
-------------------------------- FIM TRIBUTARIO----------------------------------------------
---------------------------------------------------------------------------------------------
