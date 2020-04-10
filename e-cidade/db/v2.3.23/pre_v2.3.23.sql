/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME B INICIO
 * --------------------------------------------------------------------------------------------------------------------
 */
CREATE SEQUENCE acordoclassificacao_ac46_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;
CREATE TABLE acordoclassificacao(
ac46_sequencial   int4 default 0,
ac46_descricao    varchar(100) not null,
CONSTRAINT acordoclassificacao_sequ_pk PRIMARY KEY (ac46_sequencial));
CREATE  INDEX acordoclassificacao_sequencial_seq ON acordoclassificacao(ac46_sequencial);
/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME B FIM
 * --------------------------------------------------------------------------------------------------------------------
 */


/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME C INICIO
 * --------------------------------------------------------------------------------------------------------------------
 */
CREATE SEQUENCE tiposanguineo_sd100_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE tiposanguineo(
sd100_sequencial int8 not null,
sd100_tipo varchar(3) not null,
CONSTRAINT tiposanguineo_sequ_pk PRIMARY KEY (sd100_sequencial));
/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME C FIM
 * --------------------------------------------------------------------------------------------------------------------
 */

/**
* ----------------------------------------------------------------------------------------------------------------------
* TIME INTEGRACAO
*-----------------------------------------------------------------------------------------------------------------------
*/
alter table atendimento.atendcadareamod set schema configuracoes;
alter table atendimento.atendcadarea set schema configuracoes;

