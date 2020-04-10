----------------------------------------------------------------------------------------------
----------------------------------------- TIME FOLHA -----------------------------------------
----------------------------------------------------------------------------------------------

--Deleta as tabelas de backup caso as mesmas existam
drop table if exists w_tipoassedb_cadattdinamico;
drop table if exists w_assentadb_cadattdinamicovalorgrupo;

--Cria a tabela de bachup dos dados para serem restaurados caso o plugin precise ser desinstalado e instalado novamente
select fc_executa_ddl('create table w_tipoassedb_cadattdinamico          as select * from plugins.tipoassedb_cadattdinamico;');
select fc_executa_ddl('create table w_assentadb_cadattdinamicovalorgrupo as select * from plugins.assentadb_cadattdinamicovalorgrupo;');

--Deleta as tabelas tipoassedb_cadattdinamico e assentadb_cadattdinamicovalorgrupo
drop table if exists plugins.tipoassedb_cadattdinamico;
drop table if exists plugins.assentadb_cadattdinamicovalorgrupo;


-- Módulo: recursoshumanos
CREATE TABLE assentadb_cadattdinamicovalorgrupo(
h80_db_cadattdinamicovalorgrupo   int4 NOT NULL default 0,
h80_assenta   int4 default 0,
CONSTRAINT assentadb_cadattdinamicovalorgrupo_asse_cada_pk PRIMARY KEY (h80_assenta,h80_db_cadattdinamicovalorgrupo));


-- Módulo: recursoshumanos
CREATE TABLE tipoassedb_cadattdinamico(
h79_db_cadattdinamico   int4 NOT NULL ,
h79_tipoasse   int4 ,
CONSTRAINT tipoassedb_cadattdinamico_cada_tipo_pk PRIMARY KEY (h79_db_cadattdinamico,h79_tipoasse));

-- CHAVE ESTRANGEIRA
ALTER TABLE assentadb_cadattdinamicovalorgrupo
ADD CONSTRAINT assentadb_cadattdinamicovalorgrupo_cadattdinamicovalorgrupo_fk FOREIGN KEY (h80_db_cadattdinamicovalorgrupo)
REFERENCES db_cadattdinamicovalorgrupo;

ALTER TABLE assentadb_cadattdinamicovalorgrupo
  ADD CONSTRAINT assentadb_cadattdinamicovalorgrupo_assenta_fk FOREIGN KEY (h80_assenta)
REFERENCES assenta;

ALTER TABLE tipoassedb_cadattdinamico
        ADD CONSTRAINT tipoassedb_cadattdinamico_cadattdinamico_fk FOREIGN KEY (h79_db_cadattdinamico)
REFERENCES db_cadattdinamico;

ALTER TABLE tipoassedb_cadattdinamico
        ADD CONSTRAINT tipoassedb_cadattdinamico_tipoasse_fk FOREIGN KEY (h79_tipoasse)
REFERENCES tipoasse;

-- INDICES

CREATE  INDEX assentadb_cadattdinamicovalorgrupo_assenta_in ON assentadb_cadattdinamicovalorgrupo(h80_assenta);

select fc_executa_ddl('delete from w_assentadb_cadattdinamicovalorgrupo where assenta not in (select h16_codigo from assenta);');
select fc_executa_ddl('insert into tipoassedb_cadattdinamico select * from w_tipoassedb_cadattdinamico;');
select fc_executa_ddl('insert into assentadb_cadattdinamicovalorgrupo select * from w_assentadb_cadattdinamicovalorgrupo;');

drop table if exists w_assentadb_cadattdinamicovalorgrupo;
drop table if exists w_tipoassedb_cadattdinamico;
-- Módulo: configuracoes

CREATE SEQUENCE db_formulas_db148_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE db_formulas(
db148_sequencial	 int4 NOT NULL  default nextval('db_formulas_db148_sequencial_seq'),
db148_nome		     varchar(40) NOT NULL ,
db148_descricao		 text NOT NULL ,
db148_formula		   text ,
db148_ambiente     boolean NOT NULL default false,
CONSTRAINT db_formulas_sequ_pk PRIMARY KEY (db148_sequencial));

CREATE UNIQUE INDEX db_formulas_u_in on db_formulas(db148_nome);


-- Tipode Assentamento
-- Criando  sequences
CREATE SEQUENCE tipoassefinanceiro_rh165_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
-- TABELAS E ESTRUTURA

-- Módulo: pessoal
CREATE TABLE tipoassefinanceiro(
rh165_sequencial    int4 NOT NULL  default nextval('tipoassefinanceiro_rh165_sequencial_seq'),
rh165_tipoasse    int4 NOT NULL default 0,
rh165_rubric    char(4) NOT NULL ,
rh165_instit    int4 NOT NULL default 0,
rh165_db_formulas   int4 NOT NULL ,
rh165_tipolancamento    int4 NOT NULL default 1,
rh165_mesusu    int4 NOT NULL default 0,
rh165_anousu    int4 default 0,
CONSTRAINT tipoassefinanceiro_sequ_pk PRIMARY KEY (rh165_sequencial));

-- CHAVE ESTRANGEIRA
ALTER TABLE tipoassefinanceiro
ADD CONSTRAINT tipoassefinanceiro_tipoasse_fk FOREIGN KEY (rh165_tipoasse)
REFERENCES tipoasse;

ALTER TABLE tipoassefinanceiro
ADD CONSTRAINT tipoassefinanceiro_formulas_fk FOREIGN KEY (rh165_db_formulas)
REFERENCES db_formulas;

ALTER TABLE tipoassefinanceiro
ADD CONSTRAINT tipoassefinanceiro_rubric_instit_fk FOREIGN KEY (rh165_rubric,rh165_instit)
REFERENCES rhrubricas;

CREATE SEQUENCE situacaoafastamento_rh166_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE SEQUENCE tipoasseexterno_rh167_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE situacaoafastamento(
  rh166_sequencial       int4 NOT NULL default nextval('situacaoafastamento_rh166_sequencial_seq'),
  rh166_descricao        varchar(60) NOT NULL,
  CONSTRAINT situacaoafastamento_seq_pk PRIMARY KEY (rh166_sequencial));

CREATE TABLE tipoasseexterno(
  rh167_sequencial             int4 NOT NULL default nextval('tipoasseexterno_rh167_sequencial_seq'),
  rh167_anousu                 int4 not null,
  rh167_mesusu                 int4 not null,
  rh167_codmovsefip            varchar(2) not null,
  rh167_tipoasse               int4 not null,
  rh167_situacaoafastamento    int4 not null,
  rh167_instit                 int4 not null,
  CONSTRAINT tipoasseexterno_seq_pk PRIMARY KEY (rh167_sequencial));

ALTER TABLE tipoasseexterno
  ADD CONSTRAINT tipoasseexterno_codmovsefip_fk FOREIGN KEY (rh167_anousu, rh167_mesusu, rh167_codmovsefip)
  REFERENCES codmovsefip;

ALTER TABLE tipoasseexterno
  ADD CONSTRAINT tipoasseexterno_tipoasse_fk FOREIGN KEY (rh167_tipoasse)
  REFERENCES tipoasse;

ALTER TABLE tipoasseexterno
  ADD CONSTRAINT tipoasseexterno_situacaoafastamento_fk FOREIGN KEY (rh167_situacaoafastamento)
  REFERENCES situacaoafastamento;

ALTER TABLE tipoasseexterno
  ADD CONSTRAINT tipoasseexterno_instit_fk FOREIGN KEY (rh167_instit)
  REFERENCES db_config;

CREATE UNIQUE INDEX tipoasseexterno_un_in ON tipoasseexterno (rh167_anousu, rh167_mesusu, rh167_codmovsefip, rh167_tipoasse, rh167_situacaoafastamento, rh167_instit);

INSERT INTO situacaoafastamento VALUES (2, 'Afastado sem remuneração');
INSERT INTO situacaoafastamento VALUES (3, 'Afastado acidente de trabalho +15 dias');
INSERT INTO situacaoafastamento VALUES (4, 'Afastado serviço militar');
INSERT INTO situacaoafastamento VALUES (5, 'Afastado licença gestante');
INSERT INTO situacaoafastamento VALUES (6, 'Afastado doença +15 dias');
INSERT INTO situacaoafastamento VALUES (7, 'Licença sem vencimento, cessão sem ônus');
INSERT INTO situacaoafastamento VALUES (8, 'Afastado doença +30 dias');

SELECT setval('situacaoafastamento_rh166_sequencial_seq', 8);

CREATE TABLE afastaassenta(
h81_assenta   int4 NOT NULL default 0,
h81_afasta    int4 NOT NULL default 0);

ALTER TABLE afastaassenta
ADD CONSTRAINT afastaassenta_afasta_fk FOREIGN KEY (h81_afasta)
REFERENCES afasta;

ALTER TABLE afastaassenta
ADD CONSTRAINT afastaassenta_assenta_fk FOREIGN KEY (h81_assenta)
REFERENCES assenta;


alter table rhpessoalmov add column rh02_diasgozoferias int4 NOT NULL default 30;
update rhpessoalmov set rh02_diasgozoferias = 30 where rh02_diasgozoferias is null;

----------------------------------------------------------------------------------------------
--------------------------------------- FIM TIME FOLHA ---------------------------------------
----------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------
--------------------------------------- TRIBUTARIO  ---------------------------------------
----------------------------------------------------------------------------------------------

alter table cartorio add v82_extrajudicial bool default 'f';

CREATE SEQUENCE certidcartorio_v31_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE SEQUENCE certidmovimentacao_v32_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- TABELAS E ESTRUTURA

-- Módulo: divida
CREATE TABLE certidcartorio(
v31_sequencial    int4 NOT NULL default 0,
v31_certid    int4 NOT NULL default 0,
v31_cartorio    int4 default 0,
CONSTRAINT certidcartorio_sequ_pk PRIMARY KEY (v31_sequencial));

-- Módulo: divida
CREATE TABLE certidmovimentacao(
v32_sequencial    int4 NOT NULL default 0,
v32_certidcartorio    int4 NOT NULL default 0,
v32_datamovimentacao    date NOT NULL default null,
v32_tipo    int4 default 0,
CONSTRAINT certidmovimentacao_sequ_pk PRIMARY KEY (v32_sequencial));

-- CHAVE ESTRANGEIRA

ALTER TABLE certidcartorio
ADD CONSTRAINT certidcartorio_cartorio_fk FOREIGN KEY (v31_cartorio)
REFERENCES cartorio;

ALTER TABLE certidcartorio
ADD CONSTRAINT certidcartorio_certid_fk FOREIGN KEY (v31_certid)
REFERENCES certid;

ALTER TABLE certidmovimentacao
ADD CONSTRAINT certidmovimentacao_certidcartorio_fk FOREIGN KEY (v32_certidcartorio)
REFERENCES certidcartorio;

-- INDICES

CREATE UNIQUE INDEX certidcartorio_certid_cartorio_in ON certidcartorio(v31_certid,v31_cartorio);

CREATE SEQUENCE certidcartoriorecibopaga_v33_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- Módulo: divida
CREATE TABLE certidcartoriorecibopaga(
v33_sequencial    int4 NOT NULL default 0,
v33_certidcartorio    int4 NOT NULL default 0,
v33_numnov    int4 default 0,
CONSTRAINT certidcartoriorecibopaga_sequ_pk PRIMARY KEY (v33_sequencial));

ALTER TABLE certidcartoriorecibopaga
ADD CONSTRAINT certidcartoriorecibopaga_certidcartorio_fk FOREIGN KEY (v33_certidcartorio)
REFERENCES certidcartorio;


----------------------------------------------------------------------------------------------
--------------------------------------- FIM TRIBUTARIO ---------------------------------------
----------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------
--------------------------------------- INICIO FINANCEIRO ---------------------------------------
-------------------------------------------------------------------------------------------------

alter table matestoqueitem   alter column m71_quant type numeric;
alter table matestoqueitem   alter column m71_quantatend type numeric;
alter table matestoqueinimei alter column m82_quant type numeric;
alter table empprestaitem    alter column e46_valor type numeric;

update conplano
   set c60_identificadorfinanceiro = 'N'
 where not exists (select 1 from conplanoreduz where c60_codcon = c61_codcon and c60_anousu = c61_anousu)
   and c60_anousu >= 2014
   and c60_identificadorfinanceiro <> 'N';


-- Execuçao de Itens do Acordo
alter table acordoitemexecutado add column ac29_datainicial date;
alter table acordoitemexecutado add column ac29_datafinal date;

update acordoitemexecutado
   set ac29_datainicial = ac38_datainicial,
       ac29_datafinal   = ac38_datafinal
  from acordoitemexecutadoperiodo
 where ac29_sequencial = ac38_acordoitemexecutado;


alter table acordoitemexecutado alter column ac29_quantidade type numeric;
alter table acordoitemexecutado alter column ac29_valor      type numeric;

create index acordoitem_ordem_in on acordoitem(ac20_ordem);

-- Linha Digitável OBN
alter table empagemovdetalhetransmissao add column e74_linhadigitavel varchar(100);
alter table acordoitem alter column ac20_quantidade type numeric;

----------------------------------------------------------------------------------------------
--------------------------------------- FIM FINANCEIRO ---------------------------------------
----------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------
--------------------------------------- INICIO EDUCACAO/SAUDE --------------------------------
----------------------------------------------------------------------------------------------
-- SAÚDE
ALTER TABLE cgs_und ALTER COLUMN z01_i_familiamicroarea TYPE varchar(30);
ALTER TABLE ambulatorial.familiamicroarea ALTER COLUMN sd35_i_codigo TYPE varchar(30);

ALTER TABLE sau_prestadorvinculos RENAME COLUMN s111_i_exame TO s111_procedimento;
alter table sau_prestadorvinculos drop constraint sau_prestadorvinculos_exame_fk;
ALTER TABLE sau_prestadorvinculos
  ADD CONSTRAINT sau_prestadorvinculos_procedimento_fk FOREIGN KEY (s111_procedimento)
      REFERENCES sau_procedimento;

select fc_executa_ddl('
CREATE TABLE ambulatorial.cgs_und_ext
(
  z01_i_id serial NOT NULL,
  z01_i_cgsund integer NOT NULL,

  z01_b_faleceu boolean,
  z01_d_falecimento date,
  z01_b_descnomemae boolean,
  z01_i_naturalidade integer DEFAULT 0,
  z01_i_paisorigem integer,

  z01_v_municnasc character varying(40),
  z01_v_ufnasc character varying(2),
  z01_codigoibgenasc character varying(50),
  z01_i_codocupacao integer DEFAULT 0,
  z01_i_escolaridade integer,
  z01_i_cgm integer,
  z01_i_cge integer,
  z01_i_cidadao integer,
  z01_b_inativo boolean NOT NULL DEFAULT false,

  CONSTRAINT z01_i_id_pkey PRIMARY KEY (z01_i_id)
)
WITH (
  OIDS=TRUE
);
');
-- ALTER TABLE ambulatorial.cgs_und_ext ADD CONSTRAINT cgs_und_ext_i_pais_fk FOREIGN KEY (z01_i_paisorigem) REFERENCES plugins.paises (cod) ON DELETE NO ACTION;
select fc_executa_ddl('ALTER TABLE ambulatorial.cgs_und_ext ADD CONSTRAINT cgs_und_ext_i_cgsund_fk FOREIGN KEY (z01_i_cgsund) REFERENCES ambulatorial.cgs_und (z01_i_cgsund) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE;');


-------------------------------------------------------------------------------------------------
--------------------------------------- FIM EDUCACAO/SAUDE --------------------------------------
-------------------------------------------------------------------------------------------------

delete from orcparamseqfiltropadrao where o132_orcparamrel = 151 and o132_orcparamseq in (50, 51, 54, 55);

insert into orcparamseqfiltropadrao values(nextval('orcparamelementospadrao_o132_sequencial_seq'), 151, 50, 2015, '<?xml version="1.0" encoding="ISO-8859-1"?><filter><contas><conta estrutural="100000000000000" indicador="F" nivel="1" exclusao="false" /><conta estrutural="111120000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="112120000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="112220000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="112420000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="112520000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="112620000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="112920000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="121120000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="122120000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="122920000000000" indicador="F" nivel="5" exclusao="true" /></contas><orgao operador="in" valor="" id="orgao"/><unidade operador="in" valor="" id="unidade"/><funcao operador="in" valor="" id="funcao"/><subfuncao operador="in" valor="" id="subfuncao"/><programa operador="in" valor="" id="programa"/><projativ operador="in" valor="" id="projativ"/><recurso operador="in" valor="" id="recurso"/><recursocontalinha numerolinha="" id="recursocontalinha"/><observacao valor=""/><desdobrarlinha valor="false"/></filter>');
insert into orcparamseqfiltropadrao values(nextval('orcparamelementospadrao_o132_sequencial_seq'), 151, 51, 2015, '<?xml version="1.0" encoding="ISO-8859-1"?><filter><contas><conta estrutural="100000000000000" indicador="P" nivel="1" exclusao="false" /><conta estrutural="111120000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="112120000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="112220000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="112420000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="112520000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="112620000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="112920000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="121120000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="122120000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="122920000000000" indicador="P" nivel="5" exclusao="true" /></contas><orgao operador="in" valor="" id="orgao"/><unidade operador="in" valor="" id="unidade"/><funcao operador="in" valor="" id="funcao"/><subfuncao operador="in" valor="" id="subfuncao"/><programa operador="in" valor="" id="programa"/><projativ operador="in" valor="" id="projativ"/><recurso operador="in" valor="" id="recurso"/><recursocontalinha numerolinha="" id="recursocontalinha"/><observacao valor=""/><desdobrarlinha valor="false"/></filter>');
insert into orcparamseqfiltropadrao values(nextval('orcparamelementospadrao_o132_sequencial_seq'), 151, 54, 2015, '<?xml version="1.0" encoding="ISO-8859-1"?><filter><contas><conta estrutural="210000000000000" indicador="F" nivel="2" exclusao="false" /><conta estrutural="220000000000000" indicador="F" nivel="2" exclusao="false" /><conta estrutural="622130100000000" nivel="" exclusao="false" /><conta estrutural="622130500000000" nivel="" exclusao="false" /><conta estrutural="631100000000000" nivel="" exclusao="false" /><conta estrutural="211220000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="211420000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="214120000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="214220000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="214320000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="221420000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="224120000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="224220000000000" indicador="F" nivel="5" exclusao="true" /><conta estrutural="224320000000000" indicador="F" nivel="5" exclusao="true" /></contas><orgao operador="in" valor="" id="orgao"/><unidade operador="in" valor="" id="unidade"/><funcao operador="in" valor="" id="funcao"/><subfuncao operador="in" valor="" id="subfuncao"/><programa operador="in" valor="" id="programa"/><projativ operador="in" valor="" id="projativ"/><recurso operador="in" valor="" id="recurso"/><recursocontalinha numerolinha="" id="recursocontalinha"/><observacao valor=""/><desdobrarlinha valor="false"/></filter>');
insert into orcparamseqfiltropadrao values(nextval('orcparamelementospadrao_o132_sequencial_seq'), 151, 55, 2015, '<?xml version="1.0" encoding="ISO-8859-1"?><filter><contas><conta estrutural="210000000000000" indicador="P" nivel="2" exclusao="false" /><conta estrutural="220000000000000" indicador="P" nivel="2" exclusao="false" /><conta estrutural="211220000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="211420000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="214120000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="214220000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="214320000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="221420000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="224120000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="224220000000000" indicador="P" nivel="5" exclusao="true" /><conta estrutural="224320000000000" indicador="P" nivel="5" exclusao="true" /></contas><orgao operador="in" valor="" id="orgao"/><unidade operador="in" valor="" id="unidade"/><funcao operador="in" valor="" id="funcao"/><subfuncao operador="in" valor="" id="subfuncao"/><programa operador="in" valor="" id="programa"/><projativ operador="in" valor="" id="projativ"/><recurso operador="in" valor="" id="recurso"/><recursocontalinha numerolinha="" id="recursocontalinha"/><observacao valor=""/><desdobrarlinha valor="false"/></filter>');

update orcparamseqfiltropadrao set o132_filtro = '<?xml version="1.0" encoding="ISO-8859-1"?>
<filter>
 <contas>
  <conta estrutural="111120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="112120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="112220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="112420000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="112520000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="112620000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="112920000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="121120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="122120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="122920000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="100000000000000" nivel="1" exclusao="false" indicador="F"/>
 </contas>
 <orgao operador="in" valor="" id="orgao"/>
 <unidade operador="in" valor="" id="unidade"/>
 <funcao operador="in" valor="" id="funcao"/>
 <subfuncao operador="in" valor="" id="subfuncao"/>
 <programa operador="in" valor="" id="programa"/>
 <projativ operador="in" valor="" id="projativ"/>
 <recurso operador="in" valor="" id="recurso"/>
 <recursocontalinha numerolinha="" id="recursocontalinha"/>
 <observacao valor=""/>
 <desdobrarlinha valor="false"/>
</filter>' where o132_orcparamrel = 151 and o132_orcparamseq = 50;


update orcparamseqfiltropadrao set o132_filtro = '<?xml version="1.0" encoding="ISO-8859-1"?>
<filter>
 <contas>
  <conta estrutural="111120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="112120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="112220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="112420000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="112520000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="112620000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="112920000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="121120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="122120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="122920000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="100000000000000" nivel="1" exclusao="false" indicador="P"/>
 </contas>
 <orgao operador="in" valor="" id="orgao"/>
 <unidade operador="in" valor="" id="unidade"/>
 <funcao operador="in" valor="" id="funcao"/>
 <subfuncao operador="in" valor="" id="subfuncao"/>
 <programa operador="in" valor="" id="programa"/>
 <projativ operador="in" valor="" id="projativ"/>
 <recurso operador="in" valor="" id="recurso"/>
 <recursocontalinha numerolinha="" id="recursocontalinha"/>
 <observacao valor=""/>
 <desdobrarlinha valor="false"/>
</filter>' where o132_orcparamrel = 151 and o132_orcparamseq = 51;

update orcparamseqfiltropadrao set o132_filtro = '<?xml version="1.0" encoding="ISO-8859-1"?>
<filter>
 <contas>
  <conta estrutural="622130100000000" nivel="" exclusao="false" indicador=""/>
  <conta estrutural="622130500000000" nivel="" exclusao="false" indicador=""/>
  <conta estrutural="631100000000000" nivel="" exclusao="false" indicador=""/>
  <conta estrutural="211220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="211420000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="214120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="214220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="214320000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="221420000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="224120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="224220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="224320000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="231220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="232020000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="233120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="233220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="233320000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="233420000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="233920000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235320000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235420000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235520000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235620000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235720000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235820000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235920000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="236120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="236920000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="237120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="237220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="239120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="239220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="210000000000000" nivel="2" exclusao="false" indicador="F"/>
  <conta estrutural="220000000000000" nivel="2" exclusao="false" indicador="F"/>
 </contas>
 <orgao operador="in" valor="" id="orgao"/>
 <unidade operador="in" valor="" id="unidade"/>
 <funcao operador="in" valor="" id="funcao"/>
 <subfuncao operador="in" valor="" id="subfuncao"/>
 <programa operador="in" valor="" id="programa"/>
 <projativ operador="in" valor="" id="projativ"/>
 <recurso operador="in" valor="" id="recurso"/>
 <recursocontalinha numerolinha="" id="recursocontalinha"/>
 <observacao valor=""/>
 <desdobrarlinha valor="false"/>
</filter>' where o132_orcparamrel = 151 and o132_orcparamseq = 54;

update orcparamseqfiltropadrao set o132_filtro = '<?xml version="1.0" encoding="ISO-8859-1"?>
<filter>
 <contas>
  <conta estrutural="211220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="211420000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="214120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="214220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="214320000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="221420000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="224120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="224220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="224320000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="231220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="232020000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="233120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="233220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="233320000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="233420000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="233920000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235320000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235420000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235520000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235620000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235720000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235820000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="235920000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="236120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="236920000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="237120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="237220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="239120000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="239220000000000" nivel="" exclusao="true" indicador=""/>
  <conta estrutural="210000000000000" nivel="2" exclusao="false" indicador="P"/>
  <conta estrutural="220000000000000" nivel="2" exclusao="false" indicador="P"/>
 </contas>
 <orgao operador="in" valor="" id="orgao"/>
 <unidade operador="in" valor="" id="unidade"/>
 <funcao operador="in" valor="" id="funcao"/>
 <subfuncao operador="in" valor="" id="subfuncao"/>
 <programa operador="in" valor="" id="programa"/>
 <projativ operador="in" valor="" id="projativ"/>
 <recurso operador="in" valor="" id="recurso"/>
 <recursocontalinha numerolinha="" id="recursocontalinha"/>
 <observacao valor=""/>
 <desdobrarlinha valor="false"/>
</filter>' where o132_orcparamrel = 151 and o132_orcparamseq = 55;

delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 150 and o116_codseq = 90;

insert into orcparamseqorcparamseqcoluna values
   (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 177, 1, 17, 'L[62]->vlrexatual+L[63]->vlrexatual+L[64]->vlrexatual+L[65]->vlrexatual+L[66]->vlrexatual+L[67]->vlrexatual+L[68]->vlrexatual+L[69]->vlrexatual+L[70]->vlrexatual+L[71]->vlrexatual+L[72]->vlrexatual+L[73]->vlrexatual+L[74]->vlrexatual+L[75]->vlrexatual+L[76]->vlrexatual+L[77]->vlrexatual+L[78]->vlrexatual+L[79]->vlrexatual+L[80]->vlrexatual+L[81]->vlrexatual+L[82]->vlrexatual+L[83]->vlrexatual+L[84]->vlrexatual+L[85]->vlrexatual+L[86]->vlrexatual+L[87]->vlrexatual+L[88]->vlrexatual+L[89]->vlrexatual')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 177, 1, 18, 'L[62]->vlrexatual+L[63]->vlrexatual+L[64]->vlrexatual+L[65]->vlrexatual+L[66]->vlrexatual+L[67]->vlrexatual+L[68]->vlrexatual+L[69]->vlrexatual+L[70]->vlrexatual+L[71]->vlrexatual+L[72]->vlrexatual+L[73]->vlrexatual+L[74]->vlrexatual+L[75]->vlrexatual+L[76]->vlrexatual+L[77]->vlrexatual+L[78]->vlrexatual+L[79]->vlrexatual+L[80]->vlrexatual+L[81]->vlrexatual+L[82]->vlrexatual+L[83]->vlrexatual+L[84]->vlrexatual+L[85]->vlrexatual+L[86]->vlrexatual+L[87]->vlrexatual+L[88]->vlrexatual+L[89]->vlrexatual')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 177, 1, 19, 'L[62]->vlrexatual+L[63]->vlrexatual+L[64]->vlrexatual+L[65]->vlrexatual+L[66]->vlrexatual+L[67]->vlrexatual+L[68]->vlrexatual+L[69]->vlrexatual+L[70]->vlrexatual+L[71]->vlrexatual+L[72]->vlrexatual+L[73]->vlrexatual+L[74]->vlrexatual+L[75]->vlrexatual+L[76]->vlrexatual+L[77]->vlrexatual+L[78]->vlrexatual+L[79]->vlrexatual+L[80]->vlrexatual+L[81]->vlrexatual+L[82]->vlrexatual+L[83]->vlrexatual+L[84]->vlrexatual+L[85]->vlrexatual+L[86]->vlrexatual+L[87]->vlrexatual+L[88]->vlrexatual+L[89]->vlrexatual')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 177, 1, 20, 'L[62]->vlrexatual+L[63]->vlrexatual+L[64]->vlrexatual+L[65]->vlrexatual+L[66]->vlrexatual+L[67]->vlrexatual+L[68]->vlrexatual+L[69]->vlrexatual+L[70]->vlrexatual+L[71]->vlrexatual+L[72]->vlrexatual+L[73]->vlrexatual+L[74]->vlrexatual+L[75]->vlrexatual+L[76]->vlrexatual+L[77]->vlrexatual+L[78]->vlrexatual+L[79]->vlrexatual+L[80]->vlrexatual+L[81]->vlrexatual+L[82]->vlrexatual+L[83]->vlrexatual+L[84]->vlrexatual+L[85]->vlrexatual+L[86]->vlrexatual+L[87]->vlrexatual+L[88]->vlrexatual+L[89]->vlrexatual')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 177, 1, 21, 'L[62]->vlrexatual+L[63]->vlrexatual+L[64]->vlrexatual+L[65]->vlrexatual+L[66]->vlrexatual+L[67]->vlrexatual+L[68]->vlrexatual+L[69]->vlrexatual+L[70]->vlrexatual+L[71]->vlrexatual+L[72]->vlrexatual+L[73]->vlrexatual+L[74]->vlrexatual+L[75]->vlrexatual+L[76]->vlrexatual+L[77]->vlrexatual+L[78]->vlrexatual+L[79]->vlrexatual+L[80]->vlrexatual+L[81]->vlrexatual+L[82]->vlrexatual+L[83]->vlrexatual+L[84]->vlrexatual+L[85]->vlrexatual+L[86]->vlrexatual+L[87]->vlrexatual+L[88]->vlrexatual+L[89]->vlrexatual')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 177, 1, 22, 'L[62]->vlrexatual+L[63]->vlrexatual+L[64]->vlrexatual+L[65]->vlrexatual+L[66]->vlrexatual+L[67]->vlrexatual+L[68]->vlrexatual+L[69]->vlrexatual+L[70]->vlrexatual+L[71]->vlrexatual+L[72]->vlrexatual+L[73]->vlrexatual+L[74]->vlrexatual+L[75]->vlrexatual+L[76]->vlrexatual+L[77]->vlrexatual+L[78]->vlrexatual+L[79]->vlrexatual+L[80]->vlrexatual+L[81]->vlrexatual+L[82]->vlrexatual+L[83]->vlrexatual+L[84]->vlrexatual+L[85]->vlrexatual+L[86]->vlrexatual+L[87]->vlrexatual+L[88]->vlrexatual+L[89]->vlrexatual')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 177, 1, 23, 'L[62]->vlrexatual+L[63]->vlrexatual+L[64]->vlrexatual+L[65]->vlrexatual+L[66]->vlrexatual+L[67]->vlrexatual+L[68]->vlrexatual+L[69]->vlrexatual+L[70]->vlrexatual+L[71]->vlrexatual+L[72]->vlrexatual+L[73]->vlrexatual+L[74]->vlrexatual+L[75]->vlrexatual+L[76]->vlrexatual+L[77]->vlrexatual+L[78]->vlrexatual+L[79]->vlrexatual+L[80]->vlrexatual+L[81]->vlrexatual+L[82]->vlrexatual+L[83]->vlrexatual+L[84]->vlrexatual+L[85]->vlrexatual+L[86]->vlrexatual+L[87]->vlrexatual+L[88]->vlrexatual+L[89]->vlrexatual')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 177, 1, 24, 'L[62]->vlrexatual+L[63]->vlrexatual+L[64]->vlrexatual+L[65]->vlrexatual+L[66]->vlrexatual+L[67]->vlrexatual+L[68]->vlrexatual+L[69]->vlrexatual+L[70]->vlrexatual+L[71]->vlrexatual+L[72]->vlrexatual+L[73]->vlrexatual+L[74]->vlrexatual+L[75]->vlrexatual+L[76]->vlrexatual+L[77]->vlrexatual+L[78]->vlrexatual+L[79]->vlrexatual+L[80]->vlrexatual+L[81]->vlrexatual+L[82]->vlrexatual+L[83]->vlrexatual+L[84]->vlrexatual+L[85]->vlrexatual+L[86]->vlrexatual+L[87]->vlrexatual+L[88]->vlrexatual+L[89]->vlrexatual')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 177, 1, 25, 'L[62]->vlrexatual+L[63]->vlrexatual+L[64]->vlrexatual+L[65]->vlrexatual+L[66]->vlrexatual+L[67]->vlrexatual+L[68]->vlrexatual+L[69]->vlrexatual+L[70]->vlrexatual+L[71]->vlrexatual+L[72]->vlrexatual+L[73]->vlrexatual+L[74]->vlrexatual+L[75]->vlrexatual+L[76]->vlrexatual+L[77]->vlrexatual+L[78]->vlrexatual+L[79]->vlrexatual+L[80]->vlrexatual+L[81]->vlrexatual+L[82]->vlrexatual+L[83]->vlrexatual+L[84]->vlrexatual+L[85]->vlrexatual+L[86]->vlrexatual+L[87]->vlrexatual+L[88]->vlrexatual+L[89]->vlrexatual')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 177, 1, 26, 'L[62]->vlrexatual+L[63]->vlrexatual+L[64]->vlrexatual+L[65]->vlrexatual+L[66]->vlrexatual+L[67]->vlrexatual+L[68]->vlrexatual+L[69]->vlrexatual+L[70]->vlrexatual+L[71]->vlrexatual+L[72]->vlrexatual+L[73]->vlrexatual+L[74]->vlrexatual+L[75]->vlrexatual+L[76]->vlrexatual+L[77]->vlrexatual+L[78]->vlrexatual+L[79]->vlrexatual+L[80]->vlrexatual+L[81]->vlrexatual+L[82]->vlrexatual+L[83]->vlrexatual+L[84]->vlrexatual+L[85]->vlrexatual+L[86]->vlrexatual+L[87]->vlrexatual+L[88]->vlrexatual+L[89]->vlrexatual')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 177, 1, 27, 'L[62]->vlrexatual+L[63]->vlrexatual+L[64]->vlrexatual+L[65]->vlrexatual+L[66]->vlrexatual+L[67]->vlrexatual+L[68]->vlrexatual+L[69]->vlrexatual+L[70]->vlrexatual+L[71]->vlrexatual+L[72]->vlrexatual+L[73]->vlrexatual+L[74]->vlrexatual+L[75]->vlrexatual+L[76]->vlrexatual+L[77]->vlrexatual+L[78]->vlrexatual+L[79]->vlrexatual+L[80]->vlrexatual+L[81]->vlrexatual+L[82]->vlrexatual+L[83]->vlrexatual+L[84]->vlrexatual+L[85]->vlrexatual+L[86]->vlrexatual+L[87]->vlrexatual+L[88]->vlrexatual+L[89]->vlrexatual')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 177, 1, 28, 'L[62]->vlrexatual+L[63]->vlrexatual+L[64]->vlrexatual+L[65]->vlrexatual+L[66]->vlrexatual+L[67]->vlrexatual+L[68]->vlrexatual+L[69]->vlrexatual+L[70]->vlrexatual+L[71]->vlrexatual+L[72]->vlrexatual+L[73]->vlrexatual+L[74]->vlrexatual+L[75]->vlrexatual+L[76]->vlrexatual+L[77]->vlrexatual+L[78]->vlrexatual+L[79]->vlrexatual+L[80]->vlrexatual+L[81]->vlrexatual+L[82]->vlrexatual+L[83]->vlrexatual+L[84]->vlrexatual+L[85]->vlrexatual+L[86]->vlrexatual+L[87]->vlrexatual+L[88]->vlrexatual+L[89]->vlrexatual')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 178, 2, 17, 'L[62]->vlrexanter+L[63]->vlrexanter+L[64]->vlrexanter+L[65]->vlrexanter+L[66]->vlrexanter+L[67]->vlrexanter+L[68]->vlrexanter+L[69]->vlrexanter+L[70]->vlrexanter+L[71]->vlrexanter+L[72]->vlrexanter+L[73]->vlrexanter+L[74]->vlrexanter+L[75]->vlrexanter+L[76]->vlrexanter+L[77]->vlrexanter+L[78]->vlrexanter+L[79]->vlrexanter+L[80]->vlrexanter+L[81]->vlrexanter+L[82]->vlrexanter+L[83]->vlrexanter+L[84]->vlrexanter+L[85]->vlrexanter+L[86]->vlrexanter+L[87]->vlrexanter+L[88]->vlrexanter+L[89]->vlrexanter')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 178, 2, 18, 'L[62]->vlrexanter+L[63]->vlrexanter+L[64]->vlrexanter+L[65]->vlrexanter+L[66]->vlrexanter+L[67]->vlrexanter+L[68]->vlrexanter+L[69]->vlrexanter+L[70]->vlrexanter+L[71]->vlrexanter+L[72]->vlrexanter+L[73]->vlrexanter+L[74]->vlrexanter+L[75]->vlrexanter+L[76]->vlrexanter+L[77]->vlrexanter+L[78]->vlrexanter+L[79]->vlrexanter+L[80]->vlrexanter+L[81]->vlrexanter+L[82]->vlrexanter+L[83]->vlrexanter+L[84]->vlrexanter+L[85]->vlrexanter+L[86]->vlrexanter+L[87]->vlrexanter+L[88]->vlrexanter+L[89]->vlrexanter')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 178, 2, 19, 'L[62]->vlrexanter+L[63]->vlrexanter+L[64]->vlrexanter+L[65]->vlrexanter+L[66]->vlrexanter+L[67]->vlrexanter+L[68]->vlrexanter+L[69]->vlrexanter+L[70]->vlrexanter+L[71]->vlrexanter+L[72]->vlrexanter+L[73]->vlrexanter+L[74]->vlrexanter+L[75]->vlrexanter+L[76]->vlrexanter+L[77]->vlrexanter+L[78]->vlrexanter+L[79]->vlrexanter+L[80]->vlrexanter+L[81]->vlrexanter+L[82]->vlrexanter+L[83]->vlrexanter+L[84]->vlrexanter+L[85]->vlrexanter+L[86]->vlrexanter+L[87]->vlrexanter+L[88]->vlrexanter+L[89]->vlrexanter')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 178, 2, 20, 'L[62]->vlrexanter+L[63]->vlrexanter+L[64]->vlrexanter+L[65]->vlrexanter+L[66]->vlrexanter+L[67]->vlrexanter+L[68]->vlrexanter+L[69]->vlrexanter+L[70]->vlrexanter+L[71]->vlrexanter+L[72]->vlrexanter+L[73]->vlrexanter+L[74]->vlrexanter+L[75]->vlrexanter+L[76]->vlrexanter+L[77]->vlrexanter+L[78]->vlrexanter+L[79]->vlrexanter+L[80]->vlrexanter+L[81]->vlrexanter+L[82]->vlrexanter+L[83]->vlrexanter+L[84]->vlrexanter+L[85]->vlrexanter+L[86]->vlrexanter+L[87]->vlrexanter+L[88]->vlrexanter+L[89]->vlrexanter')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 178, 2, 21, 'L[62]->vlrexanter+L[63]->vlrexanter+L[64]->vlrexanter+L[65]->vlrexanter+L[66]->vlrexanter+L[67]->vlrexanter+L[68]->vlrexanter+L[69]->vlrexanter+L[70]->vlrexanter+L[71]->vlrexanter+L[72]->vlrexanter+L[73]->vlrexanter+L[74]->vlrexanter+L[75]->vlrexanter+L[76]->vlrexanter+L[77]->vlrexanter+L[78]->vlrexanter+L[79]->vlrexanter+L[80]->vlrexanter+L[81]->vlrexanter+L[82]->vlrexanter+L[83]->vlrexanter+L[84]->vlrexanter+L[85]->vlrexanter+L[86]->vlrexanter+L[87]->vlrexanter+L[88]->vlrexanter+L[89]->vlrexanter')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 178, 2, 22, 'L[62]->vlrexanter+L[63]->vlrexanter+L[64]->vlrexanter+L[65]->vlrexanter+L[66]->vlrexanter+L[67]->vlrexanter+L[68]->vlrexanter+L[69]->vlrexanter+L[70]->vlrexanter+L[71]->vlrexanter+L[72]->vlrexanter+L[73]->vlrexanter+L[74]->vlrexanter+L[75]->vlrexanter+L[76]->vlrexanter+L[77]->vlrexanter+L[78]->vlrexanter+L[79]->vlrexanter+L[80]->vlrexanter+L[81]->vlrexanter+L[82]->vlrexanter+L[83]->vlrexanter+L[84]->vlrexanter+L[85]->vlrexanter+L[86]->vlrexanter+L[87]->vlrexanter+L[88]->vlrexanter+L[89]->vlrexanter')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 178, 2, 23, 'L[62]->vlrexanter+L[63]->vlrexanter+L[64]->vlrexanter+L[65]->vlrexanter+L[66]->vlrexanter+L[67]->vlrexanter+L[68]->vlrexanter+L[69]->vlrexanter+L[70]->vlrexanter+L[71]->vlrexanter+L[72]->vlrexanter+L[73]->vlrexanter+L[74]->vlrexanter+L[75]->vlrexanter+L[76]->vlrexanter+L[77]->vlrexanter+L[78]->vlrexanter+L[79]->vlrexanter+L[80]->vlrexanter+L[81]->vlrexanter+L[82]->vlrexanter+L[83]->vlrexanter+L[84]->vlrexanter+L[85]->vlrexanter+L[86]->vlrexanter+L[87]->vlrexanter+L[88]->vlrexanter+L[89]->vlrexanter')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 178, 2, 24, 'L[62]->vlrexanter+L[63]->vlrexanter+L[64]->vlrexanter+L[65]->vlrexanter+L[66]->vlrexanter+L[67]->vlrexanter+L[68]->vlrexanter+L[69]->vlrexanter+L[70]->vlrexanter+L[71]->vlrexanter+L[72]->vlrexanter+L[73]->vlrexanter+L[74]->vlrexanter+L[75]->vlrexanter+L[76]->vlrexanter+L[77]->vlrexanter+L[78]->vlrexanter+L[79]->vlrexanter+L[80]->vlrexanter+L[81]->vlrexanter+L[82]->vlrexanter+L[83]->vlrexanter+L[84]->vlrexanter+L[85]->vlrexanter+L[86]->vlrexanter+L[87]->vlrexanter+L[88]->vlrexanter+L[89]->vlrexanter')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 178, 2, 25, 'L[62]->vlrexanter+L[63]->vlrexanter+L[64]->vlrexanter+L[65]->vlrexanter+L[66]->vlrexanter+L[67]->vlrexanter+L[68]->vlrexanter+L[69]->vlrexanter+L[70]->vlrexanter+L[71]->vlrexanter+L[72]->vlrexanter+L[73]->vlrexanter+L[74]->vlrexanter+L[75]->vlrexanter+L[76]->vlrexanter+L[77]->vlrexanter+L[78]->vlrexanter+L[79]->vlrexanter+L[80]->vlrexanter+L[81]->vlrexanter+L[82]->vlrexanter+L[83]->vlrexanter+L[84]->vlrexanter+L[85]->vlrexanter+L[86]->vlrexanter+L[87]->vlrexanter+L[88]->vlrexanter+L[89]->vlrexanter')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 178, 2, 26, 'L[62]->vlrexanter+L[63]->vlrexanter+L[64]->vlrexanter+L[65]->vlrexanter+L[66]->vlrexanter+L[67]->vlrexanter+L[68]->vlrexanter+L[69]->vlrexanter+L[70]->vlrexanter+L[71]->vlrexanter+L[72]->vlrexanter+L[73]->vlrexanter+L[74]->vlrexanter+L[75]->vlrexanter+L[76]->vlrexanter+L[77]->vlrexanter+L[78]->vlrexanter+L[79]->vlrexanter+L[80]->vlrexanter+L[81]->vlrexanter+L[82]->vlrexanter+L[83]->vlrexanter+L[84]->vlrexanter+L[85]->vlrexanter+L[86]->vlrexanter+L[87]->vlrexanter+L[88]->vlrexanter+L[89]->vlrexanter')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 178, 2, 27, 'L[62]->vlrexanter+L[63]->vlrexanter+L[64]->vlrexanter+L[65]->vlrexanter+L[66]->vlrexanter+L[67]->vlrexanter+L[68]->vlrexanter+L[69]->vlrexanter+L[70]->vlrexanter+L[71]->vlrexanter+L[72]->vlrexanter+L[73]->vlrexanter+L[74]->vlrexanter+L[75]->vlrexanter+L[76]->vlrexanter+L[77]->vlrexanter+L[78]->vlrexanter+L[79]->vlrexanter+L[80]->vlrexanter+L[81]->vlrexanter+L[82]->vlrexanter+L[83]->vlrexanter+L[84]->vlrexanter+L[85]->vlrexanter+L[86]->vlrexanter+L[87]->vlrexanter+L[88]->vlrexanter+L[89]->vlrexanter')
  ,(nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 90, 150, 178, 2, 28, 'L[62]->vlrexanter+L[63]->vlrexanter+L[64]->vlrexanter+L[65]->vlrexanter+L[66]->vlrexanter+L[67]->vlrexanter+L[68]->vlrexanter+L[69]->vlrexanter+L[70]->vlrexanter+L[71]->vlrexanter+L[72]->vlrexanter+L[73]->vlrexanter+L[74]->vlrexanter+L[75]->vlrexanter+L[76]->vlrexanter+L[77]->vlrexanter+L[78]->vlrexanter+L[79]->vlrexanter+L[80]->vlrexanter+L[81]->vlrexanter+L[82]->vlrexanter+L[83]->vlrexanter+L[84]->vlrexanter+L[85]->vlrexanter+L[86]->vlrexanter+L[87]->vlrexanter+L[88]->vlrexanter+L[89]->vlrexanter');
