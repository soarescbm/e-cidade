ALTER TABLE integra_cad_atividade ALTER COLUMN descricao TYPE varchar;

ALTER TABLE integra_cad_config ADD cod_rec_iss_retido  integer;

CREATE SEQUENCE  integra_cad_config_vencimentos_sequencial_seq
       INCREMENT 1
       MINVALUE  1
       MAXVALUE  9223372036854775807
       START     1 
       CACHE     1;

CREATE TABLE integra_cad_config_vencimentos(
  sequencial       int4 NOT NULL default nextval('integra_cad_config_vencimentos_sequencial_seq'),
  ano_competencia  int4 NOT NULL,
  mes_competencia  int4 NOT NULL,
  data_vencimento  date NOT NULL,
  CONSTRAINT integra_cad_config_vencimentos_sequ_pk PRIMARY KEY (sequencial)
);

CREATE UNIQUE INDEX integra_cad_config_vencimentos_ano_competencia_mes_competencia_in ON integra_cad_config_vencimentos(ano_competencia,mes_competencia);

/**

insert into 
       integra_cad_config_vencimentos (ano_competencia,mes_competencia, data_vencimento) 
values (2010, 12, '2010-01-01'),
       (2011, 01, '2011-02-01'),
       (2011, 02, '2011-03-01'),
       (2011, 03, '2011-04-01'),
       (2011, 04, '2011-05-01'),
       (2011, 05, '2011-06-01'),
       (2011, 06, '2011-07-01'),
       (2011, 07, '2011-08-01'),
       (2011, 08, '2011-09-01'),
       (2011, 09, '2011-10-01'),
       (2011, 10, '2011-12-01'),
       (2011, 11, '2011-01-01'),
       (2011, 12, '2011-01-01'),
       (2012, 01, '2012-02-01'),
       (2012, 02, '2012-03-01'),
       (2012, 03, '2012-04-01'),
       (2012, 04, '2012-05-01'),
       (2012, 05, '2012-06-01'),
       (2012, 06, '2012-07-01'),
       (2012, 07, '2012-08-01'),
       (2012, 08, '2012-09-01'),
       (2012, 09, '2012-10-01'),
       (2012, 10, '2012-11-01'),
       (2012, 11, '2012-12-01'),
       (2012, 12, '2013-01-01');
*/