DROP SEQUENCE IF EXISTS integra_cadastro_sequencial_seq CASCADE;
CREATE SEQUENCE integra_cadastro_sequencial_seq;
SELECT setval('integra_cadastro_sequencial_seq', (SELECT max(sequencial) FROM integra_cadastro));
ALTER TABLE integra_cadastro ALTER sequencial SET DEFAULT nextval('integra_cadastro_sequencial_seq');

DROP SEQUENCE IF EXISTS integra_recibo_sequencial_seq CASCADE;
CREATE SEQUENCE integra_recibo_sequencial_seq;
SELECT setval('integra_recibo_sequencial_seq', (SELECT max(sequencial) FROM integra_recibo));
ALTER TABLE integra_recibo ALTER sequencial SET DEFAULT nextval('integra_recibo_sequencial_seq');

DROP SEQUENCE IF EXISTS integra_recibo_anulado_sequencial_seq CASCADE;
CREATE SEQUENCE integra_recibo_anulado_sequencial_seq;
SELECT setval('integra_recibo_anulado_sequencial_seq', (SELECT max(sequencial) FROM integra_recibo_anulado));
ALTER TABLE integra_recibo_anulado ALTER sequencial SET DEFAULT nextval('integra_recibo_anulado_sequencial_seq');
