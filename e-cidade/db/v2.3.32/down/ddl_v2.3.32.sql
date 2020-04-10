----------------------------------------------------
---- TIME C
----------------------------------------------------

----------------------------------------------------
---- Tarefa: A1023
----------------------------------------------------

ALTER TABLE regencia DROP COLUMN ed59_procedimento;

----------------------------------------------------
---- Tarefa: 10658
----------------------------------------------------
alter table tfd_veiculodestino add column tf18_c_localsaida varchar(50);
----------------------------------------------------
---- FIM TIME C
----------------------------------------------------

----------------------------------------------------
---- TRIBUTARIO
----------------------------------------------------
delete from iptucadlogcalc where j62_codigo in (106, 107);

delete from iptucadtaxaexe     where j08_db_sysfuncoes = 165;
delete from db_sysfuncoesparam where db42_funcao       = 165;
delete from db_sysfuncoes      where codfuncao         = 165;

--DROP TABLE:
DROP TABLE IF EXISTS condicionante CASCADE;
DROP TABLE IF EXISTS condicionanteatividadeimpacto CASCADE;
DROP TABLE IF EXISTS tipolicenca CASCADE;
--Criando drop sequences
DROP SEQUENCE IF EXISTS condicionante_am10_sequencial_seq;
DROP SEQUENCE IF EXISTS condicionanteatividadeimpacto_am11_sequencial_seq;
DROP SEQUENCE IF EXISTS tipolicenca_am09_sequencial_seq;

DROP TABLE IF EXISTS parecertecnico CASCADE;
DROP TABLE IF EXISTS parecertecnicocondicionante CASCADE;
--Criando drop sequences
DROP SEQUENCE IF EXISTS parecertecnico_am08_sequencial_seq;
DROP SEQUENCE IF EXISTS parecertecnicocondicionante_am12_sequencial_seq;

DROP SEQUENCE IF EXISTS licencaempreendimento_am08_sequencial_seq;
CREATE SEQUENCE licencaempreendimento_am08_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

DROP TABLE IF EXISTS licencaempreendimento CASCADE;
--Criando drop sequences
DROP SEQUENCE IF EXISTS licencaempreendimento_am13_sequencial_seq;


CREATE TABLE IF NOT EXISTS licencaempreendimento(
am08_sequencial   int4 NOT NULL default 0,
am08_empreendimento   int4 NOT NULL default 0,
am08_protprocesso   int4 NOT NULL default 0,
am08_licencaanterior    int4  default 0,
am08_dataemissao    date NOT NULL default null,
am08_datavencimento   date NOT NULL default null,
am08_tipolicenca    int4 default 0,
CONSTRAINT licencaempreendimento_sequ_pk PRIMARY KEY (am08_sequencial));

ALTER TABLE licencaempreendimento
DROP CONSTRAINT IF EXISTS licencaempreendimento_protprocesso_fk;

ALTER TABLE licencaempreendimento
ADD CONSTRAINT licencaempreendimento_protprocesso_fk FOREIGN KEY (am08_protprocesso)
REFERENCES protprocesso;

ALTER TABLE licencaempreendimento
DROP CONSTRAINT IF EXISTS licencaempreendimento_empreendimento_fk;

ALTER TABLE licencaempreendimento
ADD CONSTRAINT licencaempreendimento_empreendimento_fk FOREIGN KEY (am08_empreendimento)
REFERENCES empreendimento;

DROP INDEX IF EXISTS licencaempreendimento_sequencial_in;
CREATE UNIQUE INDEX licencaempreendimento_sequencial_in ON licencaempreendimento(am08_sequencial);



----------------------------------------------------
---- FIM TRIBUTARIO
----------------------------------------------------

----------------------------------------------------
---- FOLHA
----------------------------------------------------

delete from rhfolhapagamento where rh141_tipofolha in (2,5,4);

--97262
DROP TABLE IF EXISTS econsigmotivo CASCADE;
DROP SEQUENCE IF EXISTS econsigmotivo_rh147_sequencial_seq;
DROP INDEX IF EXISTS econsigmotivo_sequencial_in;

ALTER TABLE econsigmovimentoservidor
DROP COLUMN rh134_econsigmotivo;

ALTER TABLE econsigmovimentoservidor
DROP CONSTRAINT IF EXISTS econsigmovimentoservidor_econsigmotivo_fk;

----------------------------------------------------
---- Relatório Importação
----------------------------------------------------
ALTER TABLE econsigmovimento
DROP COLUMN IF EXISTS rh133_relatorio;
----------------------------------------------------
---- Insere as referências econsig
----------------------------------------------------
ALTER TABLE econsigmovimentoservidor
ADD CONSTRAINT econsigmovimentoservidor_regist_fk
FOREIGN KEY (rh134_regist) REFERENCES rhpessoal(rh01_regist);

ALTER TABLE econsigmovimentoservidorrubrica
ADD CONSTRAINT econsigmovimentoservidorrubrica_rubrica_instit_fk
FOREIGN KEY (rh135_rubrica, rh135_instit) REFERENCES rhrubricas(rh27_rubric, rh27_instit);

----------------------------------------------------
---- Remove campo nome na econsig
----------------------------------------------------
ALTER TABLE econsigmovimentoservidor DROP COLUMN IF EXISTS rh134_nome;
----------------------------------------------------
---- FIM FOLHA
----------------------------------------------------

----------------------------------------------------
---- INICIO FINANCEIRO / PATRIMONIAL
----------------------------------------------------

alter table solicitaregistropreco drop column if exists pc54_formacontrole;
alter table liclicita drop l20_formacontroleregistropreco;
alter table pcorcamval drop pc23_percentualdesconto;

/**
 * 97317 - Encerramento do Exercicio
 */
drop table if exists regraencerramentonaturezaorcamentaria cascade;
drop sequence if exists regraencerramentonaturezaorcamentaria_c117_sequencial_seq;

alter table solicitaanulada drop column if exists pc67_processoadministrativo;

----------------------------------------------------
---- FIM FINANCEIRO / PATRIMONIAL
----------------------------------------------------