alter table matunid    add column m61_codigotribunal varchar(5) default null;
alter table pcorcamval add column pc23_bdi numeric;
alter table pcorcamval add column pc23_encargossociais numeric;

-- Atributo dinâmico Tipo de Orçamento da Licitação
insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), (select db17_cadattdinamico from db_cadattdinamicosysarquivo where db17_sysarquivo = 1260), null, 'Tipo de Orçamento', '', 1, 'tipoorcamento');

insert into db_cadattdinamicoatributosopcoes values
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'E', 'Mão-de-Obra e Material'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'M', 'Material'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'O', 'Mão-de-Obra'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'S', 'Serviço');

-- pcorcamval data proposta
alter table pcorcamval add column pc23_data date default null;

update pcorcamval
   set pc23_data = pc20_dtate
  from pcorcamitem
       inner join pcorcam on pc22_codorc = pc20_codorc
 where pc23_orcamitem = pc22_orcamitem
   and pc23_data is null
   and extract(year from pc20_dtate) = 2016;

alter table pcorcamval add column pc23_notatecnica numeric;
alter table pcorcamval alter column pc23_valor type numeric;
alter table pcorcamval alter column pc23_quant type numeric;
alter table pcorcamval alter column pc23_vlrun type numeric;

-- licitacaoreservacotas
create sequence licitacaoreservacotas_l19_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE licitacaoreservacotas(
l19_sequencial    int4 NOT NULL default nextval('licitacaoreservacotas_l19_sequencial_seq'),
l19_liclicitemorigem    int4 NOT NULL,
l19_liclicitemreserva   int4 NOT NULL,
CONSTRAINT licitacaoreservacotas_sequ_pk PRIMARY KEY (l19_sequencial));

ALTER TABLE licitacaoreservacotas
ADD CONSTRAINT licitacaoreservacotas_liclicitemorigem_fk FOREIGN KEY (l19_liclicitemorigem)
REFERENCES liclicitem;

ALTER TABLE licitacaoreservacotas
ADD CONSTRAINT licitacaoreservacotas_liclicitemreserva_fk FOREIGN KEY (l19_liclicitemreserva)
REFERENCES liclicitem;

CREATE INDEX licitacaoreservacotas_liclicitemorigem_in ON licitacaoreservacotas(l19_liclicitemorigem);
CREATE INDEX licitacaoreservacotas_liclicitemreserva_in ON licitacaoreservacotas(l19_liclicitemreserva);

/** LicitaCon - Contratos */

/** Acordo  - Novos Campos */
alter table acordo add column ac16_tipoinstrumento int4 default 2;
alter table acordo add column ac16_dependeordeminicio boolean default false;

create SEQUENCE  acordoempempenho_ac54_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE acordoempempenho(
  ac54_sequencial		int4 NOT NULL  default nextval('acordoempempenho_ac54_sequencial_seq'),
  ac54_acordo		int4 NOT NULL ,
  ac54_empempenho		int4 ,
  ac54_numerolicitacao varchar,
  CONSTRAINT acordoempempenho_sequ_pk PRIMARY KEY (ac54_sequencial));


ALTER TABLE acordoempempenho
ADD CONSTRAINT acordoempempenho_acordo_fk FOREIGN KEY (ac54_acordo)
REFERENCES acordo;

ALTER TABLE acordoempempenho
ADD CONSTRAINT acordoempempenho_empempenho_fk FOREIGN KEY (ac54_empempenho)
REFERENCES empempenho;

CREATE  INDEX acordoempempenho_empempenho_in ON acordoempempenho(ac54_empempenho);
CREATE  INDEX acordoempempenho_acordo_in ON acordoempempenho(ac54_acordo);


-- Criando  sequences
CREATE SEQUENCE acordodocumentoevento_ac57_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


CREATE SEQUENCE acordoevento_ac55_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


CREATE SEQUENCE acordoposicaoevento_ac56_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


-- TABELAS E ESTRUTURA

-- Módulo: acordos
CREATE TABLE acordodocumentoevento(
  ac57_sequencial		int4 NOT NULL  default nextval('acordodocumentoevento_ac57_sequencial_seq'),
  ac57_acordoevento		int4 NOT NULL ,
  ac57_acordodocumento		int4 NOT NULL ,
  ac57_tipodocumento		int4 ,
  CONSTRAINT acordodocumentoevento_sequ_pk PRIMARY KEY (ac57_sequencial));


-- Módulo: acordos
CREATE TABLE acordoevento(
  ac55_sequencial		int4 NOT NULL  default nextval('acordoevento_ac55_sequencial_seq'),
  ac55_tipoevento		int4 NOT NULL ,
  ac55_acordo		int4 NOT NULL ,
  ac55_data		date NOT NULL ,
  ac55_veiculocomunicacao		int4  ,
  ac55_numeroprocesso		varchar(50)  ,
  ac55_anoprocesso		int4  ,
  ac55_descricaopublicacao		varchar(100) ,
  CONSTRAINT acordoevento_sequ_pk PRIMARY KEY (ac55_sequencial));


-- Módulo: acordos
CREATE TABLE acordoposicaoevento(
  ac56_sequencial		int4 NOT NULL  default nextval('acordoposicaoevento_ac56_sequencial_seq'),
  ac56_acordoevento		int4 NOT NULL ,
  ac56_acordoposicao		int4 ,
  CONSTRAINT acordoposicaoevento_sequ_pk PRIMARY KEY (ac56_sequencial));




-- CHAVE ESTRANGEIRA


ALTER TABLE acordodocumentoevento
ADD CONSTRAINT acordodocumentoevento_acordoevento_fk FOREIGN KEY (ac57_acordoevento)
REFERENCES acordoevento;

ALTER TABLE acordodocumentoevento
ADD CONSTRAINT acordodocumentoevento_acordodocumento_fk FOREIGN KEY (ac57_acordodocumento)
REFERENCES acordodocumento;

ALTER TABLE acordoevento
ADD CONSTRAINT acordoevento_acordo_fk FOREIGN KEY (ac55_acordo)
REFERENCES acordo;

ALTER TABLE acordoposicaoevento
ADD CONSTRAINT acordoposicaoevento_acordoevento_fk FOREIGN KEY (ac56_acordoevento)
REFERENCES acordoevento;

ALTER TABLE acordoposicaoevento
ADD CONSTRAINT acordoposicaoevento_acordoposicao_fk FOREIGN KEY (ac56_acordoposicao)
REFERENCES acordoposicao;




-- INDICES


CREATE  INDEX acordodocumentoevento_documento_in ON acordodocumentoevento(ac57_acordodocumento);

CREATE  INDEX acordodocumentoevento_evento_in ON acordodocumentoevento(ac57_acordoevento);

CREATE  INDEX acordoevento_acordo_in ON acordoevento(ac55_acordo);

CREATE  INDEX acordoposicaoevento_acordoevento_in ON acordoposicaoevento(ac56_acordoevento);

CREATE  INDEX acordoposicaoevento_acordoposicao_in ON acordoposicaoevento(ac56_acordoposicao);
