alter TABLE transparencia.empenhos               add column datavencimento DATE;
alter TABLE transparencia.empenhos               add column classificacaocredores_codigo INT;
alter TABLE transparencia.empenhos               add column justificativa TEXT DEFAULT null;

alter TABLE transparencia.empenhos_movimentacoes add column localrecebimento TEXT DEFAULT null;
alter TABLE transparencia.empenhos_movimentacoes add column nota TEXT DEFAULT null;
alter TABLE transparencia.empenhos_movimentacoes add column op INT;
alter TABLE transparencia.empenhos_movimentacoes add column datavencimento DATE;

CREATE SEQUENCE transparencia.classificacao_credores_id_seq;

CREATE TABLE transparencia.classificacao_credores (

  id INTEGER NOT NULL DEFAULT nextval('classificacao_credores_id_seq'),
  codigo INTEGER NOT NULL,
  descricao TEXT NOT NULL,
  CONSTRAINT classificacao_credores_id_pk PRIMARY KEY (id)
);

CREATE SEQUENCE transparencia.classificacao_credores_movimentacoes_id_seq;

CREATE TABLE transparencia.classificacao_credores_movimentacoes (

  id INTEGER NOT NULL DEFAULT nextval('classificacao_credores_movimentacoes_id_seq'),
  empenhos_movimentacoes_id INTEGER NOT NULL,
  justificativa TEXT DEFAULT null,
  CONSTRAINT classificacao_credores_movimentacoes_id_pk PRIMARY KEY (id)
);


COMMENT ON TABLE  classificacao_credores                  IS 'Classificação dos Credores';
COMMENT ON COLUMN classificacao_credores.id               IS 'ID da Classificação do Credor';
COMMENT ON COLUMN classificacao_credores.codigo           IS 'Codigo da Classificação do Credor';
COMMENT ON COLUMN classificacao_credores.descricao        IS 'Descrição da Classificação do Credor';

COMMENT ON TABLE  classificacao_credores_movimentacoes                  IS 'Movimentações da Classificação de Credores';
COMMENT ON COLUMN classificacao_credores_movimentacoes.justificativa    IS 'Justificativa da Ordem Cronológica';

COMMENT ON COLUMN empenhos.datavencimento                 IS 'Data de vencimento do empenho';
COMMENT ON COLUMN empenhos.classificacaocredores_codigo   IS 'Código da lista de Classificação de Credores';
COMMENT ON COLUMN empenhos.justificativa                  IS 'Justificativa da Ordem Cronológica';

-- COMMENT ON COLUMN empenhos_movimentacoes.justificativa    IS 'Justificativa da Ordem Cronológica';
COMMENT ON COLUMN empenhos_movimentacoes.localrecebimento IS 'Local de recebimento do pagamento';
COMMENT ON COLUMN empenhos_movimentacoes.datavencimento   IS 'Data de vencimento da nota do empenho';
COMMENT ON COLUMN empenhos_movimentacoes.nota             IS 'Código da Nota da Movimentação do empenho';
COMMENT ON COLUMN empenhos_movimentacoes.op               IS 'Número da Operação da Movimentação do empenho';
