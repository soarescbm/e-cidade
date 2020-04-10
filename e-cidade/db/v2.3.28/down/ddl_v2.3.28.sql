/**
 * Arquivo ddl down
 */

----------------------------------------------------
---- TIME FOLHA DE PAGAMENTO
----------------------------------------------------
---- Tarefa: 93695
----------------------------------------------------

DROP TABLE IF EXISTS rubricadescontoconsignado CASCADE;
DROP SEQUENCE IF EXISTS rubricadescontoconsignado_rh140_sequencial_seq;

ALTER TABLE cfpess DROP CONSTRAINT if exists cfpess_anousu_mesusu_baseconsignada_instit_fk;
ALTER TABLE  cfpess DROP COLUMN if exists r11_baseconsignada;


----------------------------------------------------
---- Tarefa: 96769
----------------------------------------------------

ALTER TABLE db_config ALTER COLUMN db21_tipopoder SET default 0;
ALTER TABLE contabancaria alter COLUMN db83_dvconta type varchar(1);

DROP TABLE if exists conlancamordem;
DROP SEQUENCE if exists conlancamordem_c03_sequencial_seq;


----------------------------------------------------
---- Tarefa: 96909 - Folha Complementar
----------------------------------------------------

DROP TABLE IF EXISTS rhhistoricoponto CASCADE;
DROP SEQUENCE IF EXISTS rhhistoricoponto_rh144_sequencial_seq;

DROP TABLE IF EXISTS rhhistoricocalculo CASCADE;
DROP SEQUENCE IF EXISTS rhhistoricocalculo_rh143_sequencial_seq;

DROP TABLE IF EXISTS rhfolhapagamento CASCADE;
DROP SEQUENCE IF EXISTS rhfolhapagamento_rh141_sequencial_seq;

DROP TABLE IF EXISTS rhtipofolha CASCADE;
DROP SEQUENCE IF EXISTS rhtipofolha_rh142_sequencial_seq;

---------------------
-- T96970
---------------------
alter table cfpess drop column r11_abonoprevidencia;

----------------------------------------------------------------
-- Migração Complementar
----------------------------------------------------------------

DROP TABLE IF EXISTS w_migracao_rhfolhapagamento CASCADE;
DROP TABLE IF EXISTS w_ultimafolhadecadacompetencia CASCADE;

----------------------------------------------------
---- TIME FINANCEIRO
----------------------------------------------------
---- Tarefa:
----------------------------------------------------

drop table if exists conlancamordem;
drop sequence if exists conlancamordem_c03_sequencial_seq;

alter table contacorrentedetalhe drop constraint contacorrentedetalhe_ae_orcdotacao_fk,
                                 drop constraint contacorrentedetalhe_tipo,
                                 drop column c19_estrutural,
                                 drop column c19_orcdotacao,
                                 drop column c19_orcdotacaoanousu,
                                 add constraint contacorrentedetalhe_tipo check (
                                    case
                                        when c19_contacorrente = 1 then
                                        case
                                            when c19_contabancaria is not null
                                              or c19_numemp is not null
                                              or c19_numcgm is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_acordo is not null then false
                                            else true
                                        end
                                        when c19_contacorrente = 2 then
                                        case
                                            when c19_orctiporec is not null
                                              or c19_concarpeculiar is not null
                                              or c19_numemp is not null
                                              or c19_numcgm is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_acordo is not null then false
                                            else true
                                        end
                                        when c19_contacorrente = 3 then
                                        case
                                            when c19_orctiporec is not null
                                              or c19_concarpeculiar is not null
                                              or c19_numemp is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null
                                              or c19_contabancaria is not null
                                              or c19_acordo is not null then false
                                            else true
                                        end
                                        when c19_contacorrente = 19 then
                                        case
                                            when c19_orctiporec is not null
                                              or c19_concarpeculiar is not null
                                              or c19_contabancaria is not null
                                              or c19_acordo is not null then false
                                            else true
                                        end
                                        when c19_contacorrente = 25 then
                                        case
                                            when c19_orctiporec is not null
                                              or c19_concarpeculiar is not null
                                              or c19_contabancaria is not null
                                              or c19_numemp is not null
                                              or c19_orcunidadeanousu is not null
                                              or c19_orcunidadeorgao is not null
                                              or c19_orcunidadeunidade is not null
                                              or c19_orcorgaoanousu is not null
                                              or c19_orcorgaoorgao is not null then false
                                            else true
                                        end
                                        else null::boolean
                                    end);


----------------------------------------------------
---- TIME FINANCEIRO
---- PATRIMONIAL
---- EDUCACAO
----------------------------------------------------
---- Tarefa: 95483
----------------------------------------------------

ALTER TABLE cgs_und drop column if exists z01_codigoibge;

----------------------------------------------------
---- Tarefa: 95540
----------------------------------------------------
alter table taxa alter COLUMN ar36_perc type real;
alter table taxa alter COLUMN ar36_valor type real;
alter table taxa alter COLUMN ar36_valormin type real;
alter table taxa alter COLUMN ar36_valormax type real;


-------------------------------------------------------------------------------
--                                INTEGRACAO                                 --
-------------------------------------------------------------------------------

DROP TABLE IF EXISTS db_releasenotes CASCADE;
DROP SEQUENCE IF EXISTS db_releasenotes_db147_sequencial_seq;

-------------------------------------------------------------------------------
--                            FIM INTEGRACAO                                 --
-------------------------------------------------------------------------------




----------------------------------------------------
---- TIME C
---- SAUDE
----------------------------------------------------
---- Tarefa: 95051
----------------------------------------------------
alter table lab_tiporeferenciaalnumerico DROP COLUMN IF EXISTS la30_casasdecimaisapresentacao;

DROP TABLE IF EXISTS w_lab_resultadonum, w_lab_tiporeferenciaalnumerico, bkp_original_lab_resultadonum, bkp_original_lab_tiporeferenciaalnumerico;

alter table lab_resultadonum alter column la41_f_valor                  type float4;
alter table lab_tiporeferenciaalnumerico alter column la30_f_normalmin  type float4;
alter table lab_tiporeferenciaalnumerico alter column la30_f_normalmax  type float4;
alter table lab_tiporeferenciaalnumerico alter column la30_f_absurdomin type float4;
alter table lab_tiporeferenciaalnumerico alter column la30_f_absurdomax type float4;
