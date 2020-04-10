/**
 * Arquivo ddl down
 */
DROP TABLE IF EXISTS criterioatividadeimpacto CASCADE;
DROP SEQUENCE IF EXISTS criterioatividadeimpacto_am01_sequencial_seq;

DROP TABLE IF EXISTS porteatividadeimpacto CASCADE;
DROP SEQUENCE IF EXISTS porteatividadeimpacto_am02_sequencial_seq;

DROP TABLE IF EXISTS atividadeimpacto CASCADE;
DROP SEQUENCE IF EXISTS atividadeimpacto_am03_sequencial_seq;

DROP TABLE IF EXISTS atividadeimpactoporte CASCADE;
DROP SEQUENCE IF EXISTS atividadeimpactoporte_am04_sequencial_seq;

DROP TABLE IF EXISTS empreendimento CASCADE;
DROP SEQUENCE IF EXISTS empreendimento_am05_sequencial_seq;

DROP TABLE IF EXISTS empreendimentoatividadeimpacto CASCADE;
DROP SEQUENCE IF EXISTS empreendimentoatividadeimpacto_am06_sequencial_seq;

DROP TABLE IF EXISTS responsaveltecnico CASCADE;
DROP SEQUENCE IF EXISTS responsaveltecnico_am07_sequencial_seq;

DROP TABLE IF EXISTS licencaempreendimento CASCADE;
DROP SEQUENCE IF EXISTS licencaempreendimento_am08_sequencial_seq;