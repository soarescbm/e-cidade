set schema 'transparencia';

/**
 * Licitacao INICIO
 */
CREATE SEQUENCE licitacoes_id_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

create table licitacoes (
  id                     integer not null default nextval('licitacoes_id_seq'),
  instituicao_id         integer not null,
  tipocompra             varchar(50) not null,
  numero                 integer not null,
  datacriacao            date not null,
  horacriacao            varchar(5) not null,
  dataabertura           date not null,
  datapublicacao         date,
  horaabertura           varchar(5) not null,
  local                  text not null,
  objeto                 text not null,
  processoadministrativo varchar not null,
  situacao               varchar(20) not null,
  edital                 varchar (20) not null,
  anousu                 integer not null,
CONSTRAINT licitacoes_id_pk PRIMARY KEY (id));

ALTER TABLE licitacoes
ADD CONSTRAINT licitacoes_instituicao_id_fk FOREIGN KEY (instituicao_id)
REFERENCES instituicoes;

CREATE INDEX licitacoes_instituicao_id_in ON licitacoes(instituicao_id);

/**
 * ITENS LICITACAO - INICIO
 */

CREATE SEQUENCE licitacoes_itens_id_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

create table licitacoes_itens (
id             integer not null default nextval('licitacoes_itens_id_seq'),
licitacao_id   integer not null,
material       varchar(100) not null,
quantidade     numeric not null,
valor          numeric,
resumo         text,
fornecedor     varchar(200) not null,
unidade_medida varchar(20) not null,
CONSTRAINT licitacoes_itens_id_pk PRIMARY KEY (id));

create index licitacoes_itens_licitacao_id_in on licitacoes_itens(licitacao_id);

ALTER TABLE licitacoes_itens
ADD CONSTRAINT licitacoes_itens_licitacao_id_fk FOREIGN KEY (licitacao_id)
REFERENCES licitacoes;

/**
 * DOCUMENTOS INICIO
 */
CREATE SEQUENCE licitacoes_documentos_id_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

create table licitacoes_documentos (
id           integer not null default nextval('licitacoes_documentos_id_seq'),
licitacao_id integer not null,
tipo         integer not null,
documento    oid     not null,
nome         varchar(200) not null,
CONSTRAINT licitacoes_documentos_id_pk PRIMARY KEY (id));

ALTER TABLE licitacoes_documentos
ADD CONSTRAINT licitacoes_documentos_licitacao_id_fk FOREIGN KEY (licitacao_id)
REFERENCES licitacoes;

create index licitacoes_documentos_licitacao_id_in on licitacoes_documentos(licitacao_id);
