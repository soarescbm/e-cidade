CREATE SEQUENCE transparencia.bens_id_seq;

CREATE TABLE transparencia.bens (
  id                      INTEGER NOT NULL DEFAULT nextval('bens_id_seq'),
  placa                   TEXT DEFAULT '',
  baixa                   TEXT DEFAULT '',
  codigo                  INTEGER NOT NULL,
  orgao_id                INTEGER NOT NULL,
  situacao                TEXT DEFAULT '',
  bem_tipo_id             INTEGER NOT NULL,
  bem_tipo_depreciacao_id INTEGER,
  bem_aquisicao_tipo_id   INTEGER NOT NULL,
  departamento_id         INTEGER NOT NULL,
  departamento_divisao_id INTEGER DEFAULT NULL,
  pessoa_id               INTEGER NOT NULL,
  descricao               TEXT NOT NULL,
  exercicio               INTEGER NOT NULL,
  unidade_id              INTEGER,
  observacao              TEXT DEFAULT '',
  valor_atual             numeric(20,2),
  valor_residual          numeric(20,2),
  data_aquisicao          DATE NOT NULL,
  instituicao_id          INTEGER NOT NULL,
  valor_aquisicao         numeric(20,2),
  tipo_depreciacao        TEXT DEFAULT '',
  valor_depreciavel       numeric(20,2),
  bem_classificacao_id     INTEGER,
  CONSTRAINT bens_id_pk PRIMARY KEY (id)
);

COMMENT ON TABLE  bens                    IS 'Tabela de bens do patrimonio';
COMMENT ON COLUMN bens.id                 IS 'ID do bem do patrimonio';
COMMENT ON COLUMN bens.codigo             IS 'Codigo da bem patrimonio';
COMMENT ON COLUMN bens.orgao_id           IS 'ID do orgao do bem patrimonio';
COMMENT ON COLUMN bens.descricao          IS 'Descrição do bem patrimonio';
COMMENT ON COLUMN bens.pessoa_id          IS 'ID do fornecedor, utiliza o cgm';
COMMENT ON COLUMN bens.valor_atual        IS 'Valo atual do patrimonio';
COMMENT ON COLUMN bens.data_aquisicao     IS 'Data da aquisicao do bem do patrimonio';
COMMENT ON COLUMN bens.valor_aquisicao    IS 'Valor da aquisicao do patrimonio';
COMMENT ON COLUMN bens.valor_depreciavel  IS 'Valor depreciavel do patrimonio';

CREATE SEQUENCE transparencia.bem_tipos_id_seq;

CREATE TABLE transparencia.bem_tipos (

  id INTEGER NOT NULL DEFAULT nextval('bem_tipos_id_seq'),
  descricao TEXT DEFAULT null,
  CONSTRAINT bem_tipos_id_pk PRIMARY KEY (id)
);

CREATE SEQUENCE transparencia.bem_classificacoes_id_seq;

CREATE TABLE transparencia.bem_classificacoes (

  id INTEGER NOT NULL DEFAULT nextval('bem_classificacoes_id_seq'),
  codigo INTEGER NOT NULL,
  descricao TEXT DEFAULT null,
  CONSTRAINT bem_classificacoes_id_pk PRIMARY KEY (id)
);


CREATE SEQUENCE transparencia.bem_aquisicao_tipos_id_seq;

CREATE TABLE transparencia.bem_aquisicao_tipos (

  id INTEGER NOT NULL DEFAULT nextval('bem_aquisicao_tipos_id_seq'),
  descricao TEXT DEFAULT null,
  CONSTRAINT bem_aquisicao_tipos_id_pk PRIMARY KEY (id)
);

CREATE SEQUENCE transparencia.departamento_id_seq;

CREATE TABLE transparencia.departamentos (

  id INTEGER NOT NULL DEFAULT nextval('departamento_id_seq'),
  descricao TEXT DEFAULT null,
  CONSTRAINT departamento_id_pk PRIMARY KEY (id)
);

CREATE SEQUENCE transparencia.departamento_divisoes_id_seq;

CREATE TABLE transparencia.departamento_divisoes (

  id INTEGER NOT NULL DEFAULT nextval('departamento_divisoes_id_seq'),
  descricao TEXT DEFAULT null,
  CONSTRAINT departamento_divisoes_id_pk PRIMARY KEY (id)
);

CREATE SEQUENCE transparencia.bem_tipo_depreciacoes_id_seq;

CREATE TABLE transparencia.bem_tipo_depreciacoes (

  id INTEGER NOT NULL DEFAULT nextval('bem_tipo_depreciacoes_id_seq'),
  descricao TEXT DEFAULT null,
  CONSTRAINT bem_tipo_depreciacoes_id_pk PRIMARY KEY (id)
);


CREATE SEQUENCE transparencia.veiculos_id_seq;

CREATE TABLE transparencia.veiculos (

  id INTEGER NOT NULL DEFAULT nextval('veiculos_id_seq'),
  codigo INTEGER,
  placa TEXT NOT NULL,
  data_aquisicao DATE,
  exercicio INTEGER NOT NULL,
  instituicao_id INTEGER NOT NULL,
  veiculo_utilizacao_id INTEGER NOT NULL,
  departamento_id INTEGER NOT NULL,
  ano_fabricacao INTEGER NOT NULL,
  ano_modelo INTEGER NOT NULL,
  marca_id INTEGER NOT NULL,
  modelo_id INTEGER NOT NULL,
  procedencia TEXT DEFAULT 'NULL',
  potencia TEXT DEFAULT '',
  combustivel TEXT DEFAULT '',
  veiculo_tipo_id INTEGER NOT NULL,
  cor TEXT DEFAULT '',
  categoria TEXT DEFAULT '',
  situacao TEXT DEFAULT '',

  CONSTRAINT veiculos_id_pk PRIMARY KEY (id)
);

CREATE SEQUENCE transparencia.marcas_id_seq;

CREATE TABLE transparencia.marcas (

  id INTEGER NOT NULL DEFAULT nextval('marcas_id_seq'),
  descricao TEXT NOT NULL,
  CONSTRAINT marcas_id_pk PRIMARY KEY (id)
);

CREATE SEQUENCE transparencia.modelos_id_seq;

CREATE TABLE transparencia.modelos (

  id INTEGER NOT NULL DEFAULT nextval('modelos_id_seq'),
  descricao TEXT NOT NULL,
  CONSTRAINT modelos_id_pk PRIMARY KEY (id)
);

CREATE SEQUENCE transparencia.veiculo_tipos_id_seq;

CREATE TABLE transparencia.veiculo_tipos (

  id INTEGER NOT NULL DEFAULT nextval('veiculo_tipos_id_seq'),
  descricao TEXT NOT NULL,
  CONSTRAINT veiculo_tipos_id_pk PRIMARY KEY (id)
);


CREATE SEQUENCE transparencia.veiculo_utilizacoes_id_seq;

CREATE TABLE transparencia.veiculo_utilizacoes (

  id INTEGER NOT NULL DEFAULT nextval('veiculo_utilizacoes_id_seq'),
  codigo INTEGER NOT NULL,
  descricao TEXT NOT NULL,
  CONSTRAINT veiculo_utilizacoes_id_pk PRIMARY KEY (id)
);