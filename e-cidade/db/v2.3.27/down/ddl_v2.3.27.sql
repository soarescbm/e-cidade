/**
 * TIME B {
 */

/* {73195 - INICIO} */
/* {73195 - FIM} */

/**
 * } TIME B
 */

/**
 * TIME C - INICIO
 */

/* { 95317 - INICIO} */

ALTER TABLE IF EXISTS sau_triagemavulsaagravo DROP CONSTRAINT sau_triagemavulsaagravo_cid_fk;
ALTER TABLE IF EXISTS sau_triagemavulsaagravo DROP CONSTRAINT sau_triagemavulsaagravo_triagemavulsa_fk;
DROP SEQUENCE IF EXISTS sau_triagemavulsaagravo_s167_sequencial_seq;
DROP TABLE IF EXISTS sau_triagemavulsaagravo CASCADE;

/* { 95317 - FIM} */

/* { 94085B - INICIO} */
alter table aprovconselho drop column ed253_avaliacaoconselho;
alter table aprovconselho drop column ed253_alterarnotafinal;
/* { 94085B - FIM} */

/* {96026 - INICIO } */
alter table escola drop column ed18_codigoreferencia;
/* {96026 - FIM }*/

/**
 * TIME C - FIM
 */

 /**
 * TIME FOLHA
 */
alter table afasta drop constraint afasta_rhpessoal_fk;
alter table afasta add column r45_login varchar(8);

alter table if exists rhpessoal drop column rh01_reajusteparidade;

/**
 * Time Financeiro - OBN
 */
drop table empempenhofinalidadepagamentofundeb;
drop sequence empempenhofinalidadepagamentofundeb_e152_sequencial_seq;

drop table slipfinalidadepagamentofundeb;
drop sequence slipfinalidadepagamentofundeb_e153_sequencial_seq;

drop table empagegeraobn;
drop sequence empagegeraobn_e138_sequencial_seq;

drop table empagemovdetalhetransmissao;
drop sequence empagemovdetalhetransmissao_e74_sequencial_seq;

drop table empagemovtipotransmissao;
drop sequence empagemovtipotransmissao_e25_sequencial_seq;

drop table obnnumeracao;
drop sequence obnnumeracao_o150_sequencial_seq;

alter table caiparametro drop constraint caiparametro_orctiporecfundeb_fk;

alter table caiparametro drop column k29_orctiporecfundeb;
/**
 * Time Financeiro - FIM
 */