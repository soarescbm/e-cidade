set schema 'transparencia';

create sequence acordos_id_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create table acordos(
  id integer default nextval('acordos_id_seq'),
  situacao character varying(100),
  numero character varying(50),
  anousu integer,
  data_assinatura date,
  contratado character varying(40),
  data_inicio date,
  data_fim date,
  objeto text,
  instituicao_id integer,
  comissao character varying(100),
  lei character varying(60),
  grupo character varying(100),
  quantidade_renovacao numeric(20,2),
  unidade_tempo_renovacao integer,
  numero_processo character varying(60),
  peridodo_comercial boolean,
  quantidade_vigencia numeric(20,2),
  unidade_tempo_vigencia integer,
  constraint acordos_id_pk primary key(id),
  constraint acordos_instituicao_id_fk foreign key(instituicao_id) references instituicoes(id)
);

create sequence acordo_aditamentos_id_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create table acordo_aditamentos(
  id integer default nextval('acordo_aditamentos_id_seq'),
  acordo_id integer,
  posicao_tipo character varying(50),
  numero integer,
  situacao character varying(100),
  data date,
  emergencial boolean,
  observacao text,
  numero_aditamento character varying(20),
  constraint acordo_aditamentos_id_pk primary key(id),
  constraint acordo_aditamentos_acordo_fk foreign key(acordo_id) references acordos
);

create sequence acordo_aditamento_itens_id_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create table acordo_aditamento_itens(
  id integer default nextval('acordo_aditamento_itens_id_seq'),
  acordo_aditamento_id integer,
  material character varying(80),
  quantidade integer,
  valor_unitario numeric(20,2),
  valor_total numeric(20,2),
  elemento integer,
  ordem integer,
  unidade character varying(80),
  resumo text,
  tipo_controle integer,
  constraint acordo_aditamento_itens_id_pk primary key(id),
  constraint acordo_aditamento_itens_acordo_aditamentos_fk foreign key(acordo_aditamento_id) references acordo_aditamentos
);

create sequence acordo_documentos_id_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create table acordo_documentos(
  id integer default nextval('acordo_documentos_id_seq'),
  acordo_id integer,
  nome text,
  descricao character varying(300),
  arquivo oid,
  constraint acordo_documentos_id_pk primary key(id),
  constraint acordo_documentos_acordos_fk foreign key(acordo_id) references acordos
);

create sequence acordo_empenhos_id_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create table acordo_empenhos(
  id integer default nextval('acordo_empenhos_id_seq'),
  acordo_id integer,
  empenho_id integer,
  constraint acordo_empenhos_id_pk primary key(id),
  constraint acordo_empenhos_acordos_fk foreign key(acordo_id) references acordos,
  constraint acordo_empenhos_empenhos_fk foreign key(empenho_id) references empenhos
);