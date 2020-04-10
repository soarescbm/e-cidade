CREATE SEQUENCE integra_recibo_detalhe_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

GRANT USAGE on SEQUENCE integra_recibo_detalhe_sequencial_seq TO integraiss;

CREATE TABLE integra_recibo_detalhe(
sequencial                       int4 NOT NULL default nextval('integra_recibo_detalhe_sequencial_seq'),
integra_recibo_detalhe_origem    int4 NULL ,
integra_recibo                   int4,
ano_competencia_origem           int4,
mes_competencia_origem           int4,
valor                            numeric(15,2),
historico                        varchar(255),
tipo_lancamento                  char(1) default 'I',
CONSTRAINT integra_recibo_detalhe_sequ_pk PRIMARY KEY (sequencial));

ALTER TABLE integra_recibo_detalhe 
  ADD CONSTRAINT integra_recibo_detalhe_tipo_lancamento_chk         
      CHECK (tipo_lancamento IN ('I', 'J', 'M', 'C'));

ALTER TABLE integra_recibo_detalhe 
  ADD CONSTRAINT integra_recibo_detalhe_integra_recibo_fk FOREIGN KEY (integra_recibo)
 REFERENCES integra_recibo;

CREATE INDEX integra_recibo_detalhe_recibo_detalhe_in ON integra_recibo_detalhe(integra_recibo);


ALTER TABLE integra_recibo_detalhe ADD CONSTRAINT integra_recibo_detalhe_integra_recibo_origem_fk FOREIGN KEY (integra_recibo_detalhe_origem)
REFERENCES integra_recibo_detalhe;

CREATE INDEX integra_recibo_detalhe_recibo_detalhe_origem_in ON integra_recibo_detalhe(integra_recibo_detalhe_origem);


alter table integra_cadastro       add idcontribuinte     integer; -- Solictado pelo Andre Ortega da Empresa WebISS
alter table integra_recibo         add idguiarecolhimento integer; -- Solictado pelo Andre Ortega da Empresa WebISS
alter table integra_recibo_detalhe add idguiarecolhimento integer; -- Solictado pelo Andre Ortega da Empresa WebISS
alter table integra_recibo_detalhe add idlancamento       integer; -- Solictado pelo Andre Ortega da Empresa WebISS
alter table integra_recibo_detalhe add numpre             integer;
alter table integra_recibo_detalhe add numpar             integer;

SELECT fc_grant('integraiss', 'delete, insert, select', 'public', 'integra_recibo_detalhe');
