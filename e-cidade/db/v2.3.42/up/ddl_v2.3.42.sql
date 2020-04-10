CREATE SEQUENCE rhferiasperiodoassentamento_rh169_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


CREATE SEQUENCE tipoassentamentoferias_rh168_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


-- TABELAS E ESTRUTURA

-- Módulo: recursoshumanos
CREATE TABLE rhferiasperiodoassentamento(
rh169_sequencial		int4 NOT NULL default 0,
rh169_rhferiasperiodo		int4 NOT NULL default 0,
rh169_assenta		int4 default 0,
CONSTRAINT rhferiasperiodoassentamento_rhfe_pk PRIMARY KEY (rh169_sequencial));


-- Módulo: recursoshumanos
CREATE TABLE tipoassentamentoferias(
rh168_sequencial		int4 NOT NULL default 0,
rh168_tipoassentamentoferias		int4  default 0,
rh168_tipoassentamentoabono		int4 default 0,
CONSTRAINT tipoassentamentoferias_sequ_pk PRIMARY KEY (rh168_sequencial));



-- CHAVE ESTRANGEIRA
ALTER TABLE rhferiasperiodoassentamento
ADD CONSTRAINT rhferiasperiodoassentamento_assenta_fk FOREIGN KEY (rh169_assenta)
REFERENCES assenta;

ALTER TABLE rhferiasperiodoassentamento
ADD CONSTRAINT rhferiasperiodoassentamento_rhferiasperiodo_fk FOREIGN KEY (rh169_rhferiasperiodo)
REFERENCES rhferiasperiodo;

ALTER TABLE tipoassentamentoferias
ADD CONSTRAINT tipoassentamentoferias_tipoassentamentoferias_fk FOREIGN KEY (rh168_tipoassentamentoferias)
REFERENCES tipoasse;

-- INDICES
CREATE  INDEX rhferiasperiodoassentamento_assenta_in ON rhferiasperiodoassentamento(rh169_assenta);
CREATE  INDEX rhferiasperiodoassentamento_rhferiasperiodo_in ON rhferiasperiodoassentamento(rh169_rhferiasperiodo);
CREATE  INDEX tipoassentamentoferias_assenta_abono_in ON tipoassentamentoferias(rh168_tipoassentamentoabono);
CREATE  INDEX tipoassentamentoferias_assenta_ferias_in ON tipoassentamentoferias(rh168_tipoassentamentoferias);

alter table rhferiasperiodo drop rh110_periodoespecificoinicial;
alter table rhferiasperiodo drop rh110_periodoespecificofinal;

alter table cfpess add column r11_rubricaescalaferias varchar(4);