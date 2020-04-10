DROP SEQUENCE IF EXISTS rhferiasperiodoassentamento_rh169_sequencial_seq;
DROP SEQUENCE IF EXISTS tipoassentamentoferias_rh168_sequencial_seq;

drop table if exists rhferiasperiodoassentamento;
drop table if exists tipoassentamentoferias;

alter table rhferiasperiodo add  rh110_periodoespecificoinicial date;
alter table rhferiasperiodo add  rh110_periodoespecificofinal date;
alter table cfpess drop column r11_rubricaescalaferias;
