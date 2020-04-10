/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME A INICIO
 * --------------------------------------------------------------------------------------------------------------------
 */

-- Tarefa 86645 / Geração RAIS
alter table cfpess add column r11_sistemacontroleponto int4 default null;

DROP TABLE IF EXISTS rhdirfparametros CASCADE;
DROP SEQUENCE IF EXISTS rhdirfparametros_rh132_sequencial_seq;

CREATE SEQUENCE rhdirfparametros_rh132_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE rhdirfparametros(
rh132_sequencial    int4 NOT NULL  default nextval('rhdirfparametros_rh132_sequencial_seq'),
rh132_anobase   int4 NOT NULL ,
rh132_valorminimo   float8 NOT NULL default 0,
rh132_codigoarquivo   varchar(10) ,
CONSTRAINT rhdirfparametros_sequ_pk PRIMARY KEY (rh132_sequencial));

insert into rhdirfparametros values (nextval('rhdirfparametros_rh132_sequencial_seq'), 2013, 25661.70, 'F8UCL6S');

/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME A FIM
 * --------------------------------------------------------------------------------------------------------------------
 */