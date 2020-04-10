----- TRIBUTARIO ------
alter table carface drop COLUMN j38_datalancamento;

--DROP TABLE:
DROP TABLE IF EXISTS agrupamentocaracteristica CASCADE;
DROP TABLE IF EXISTS agrupamentocaracteristicavalor CASCADE;
--Criando drop sequences
DROP SEQUENCE IF EXISTS agrupamentocaracteristica_j139_sequencial_seq;
DROP SEQUENCE IF EXISTS agrupamentocaracteristicavalor_j140_sequencial_seq;

delete from iptutabelas where j121_codarq in (3770, 3771);
delete from iptucadlogcalc where j62_codigo in (109, 110, 108);

delete from db_sysfuncoesparam where db42_funcao in (168, 169, 170);
delete from db_sysfuncoes      where codfuncao   in (168, 169, 170);


--DROP TABLE:
DROP TABLE IF EXISTS mensagerialicenca CASCADE;
--Criando drop sequences
DROP SEQUENCE IF EXISTS mensagerialicenca_am14_sequencial_seq;
DROP TABLE IF EXISTS mensagerialicenca_db_usuarios CASCADE;
DROP TABLE IF EXISTS mensagerialicencaprocessado CASCADE;
--Criando drop sequences
DROP SEQUENCE IF EXISTS mensagerialicenca_db_usuarios_am16_sequencial_seq;
DROP SEQUENCE IF EXISTS mensagerialicencaprocessado_am15_sequencial_seq;

DELETE FROM cnaeanalitica WHERE q72_sequencial = 1332;
DELETE FROM cnae WHERE q71_sequencial = 2397;

DELETE FROM mensagerialicenca;

delete from db_sysfuncoesparam where db42_funcao = 171;
delete from db_sysfuncoes where codfuncao = 171;

delete from cnaeanalitica  where q72_cnae in (2396,2397,2398,2399,2400,2401,2402,2403,2404,2405,2406,2407,2409,2410,2411,2412,2413,2414,2415,2416);
delete from cnae  where q71_sequencial in (2396,2397,2398,2399,2400,2401,2402,2403,2404,2405,2406,2407,2408,2409,2410,2411,2412,2413,2414,2415,2416);
select setval ('cnae_q71_sequencial_seq', coalesce((select max(q71_sequencial) from cnae), 1));
select setval ('cnaeanalitica_q72_sequencial_seq', coalesce((select max(q72_sequencial) from cnaeanalitica), 1));
----- FIM TRIBUTARIO ------


---------------------------
-------  TIME C -----------
---------------------------

DROP TABLE IF EXISTS movimentacaoprontuario CASCADE;
DROP TABLE IF EXISTS setorambulatorial CASCADE;
ALTER TABLE prontuarios DROP COLUMN sd24_setorambulatorial ;
DROP SEQUENCE IF EXISTS movimentacaoprontuario_sd102_codigo_seq;
DROP SEQUENCE IF EXISTS setorambulatorial_sd91_codigo_seq;

DROP TABLE IF EXISTS examerequisicaoexame CASCADE;
DROP TABLE IF EXISTS requisicaoexameprontuario CASCADE;
DROP SEQUENCE IF EXISTS examerequisicaoexame_sd104_codigo_seq;
DROP SEQUENCE IF EXISTS requisicaoexameprontuario_sd103_codigo_seq;

alter table prontproced drop column sd29_sigilosa;
alter table sau_triagemavulsa drop column s152_evolucao;
create unique index  sau_triagemavulsapront_s155_pront_uin on sau_triagemavulsaprontuario (s155_i_prontuario);

DROP TABLE IF EXISTS regracalculocargahoraria CASCADE;
DROP SEQUENCE IF EXISTS regracalculocargahoraria_ed127_codigo_seq;
delete from db_viradacaditem where c33_sequencial = 33;


---------------------------
------- FIM TIME C --------
---------------------------

---------------------------
--------  TIME NFSE -------
---------------------------

DROP TABLE IF EXISTS confvencissqnvariavel CASCADE;
DROP SEQUENCE IF EXISTS confvencissqnvariavel_q144_sequencial_seq;
DROP TABLE IF EXISTS w_migracao_confvencissqnvariavel;

---------------------------
------ FIM TIME NFSE ------
---------------------------


-----------------------------
------ TIME FINANCEIRO ------
-----------------------------


delete from db_layoutcampos where db52_layoutlinha in (select db51_codigo from db_layoutlinha where db51_layouttxt = 222);
delete from db_layoutlinha where db51_layouttxt = 222;
delete from db_layouttxt where db50_codigo = 222;

----------------------------
------ FIM FINANCEIRO ------
----------------------------

-------------------------------
------ INÍCIO TIME FOLHA ------
-------------------------------

-- Tabela "tipodeficiencia"
DROP TABLE IF EXISTS tipodeficiencia CASCADE;
DROP SEQUENCE IF EXISTS tipodeficiencia_rh150_sequencial_seq;

-- Tabela "rhpessoalmov"
ALTER TABLE rhpessoalmov DROP COLUMN rh02_tipodeficiencia;

----------------------------
------ FIM TIME FOLHA ------
----------------------------
