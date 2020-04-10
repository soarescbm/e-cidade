---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO SAÚDE ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
DROP TABLE    IF EXISTS cgs_unddocumento CASCADE;
DROP TABLE    IF EXISTS cgs_undendereco     CASCADE;

DROP SEQUENCE IF EXISTS cgs_unddocumento_sd108_sequencial_seq;
DROP SEQUENCE IF EXISTS cgs_undendereco_sd109_sequencial_seq;

alter table cgs_und drop column if exists z01_orgaoemissoridentidade;
alter table cgs_und alter COLUMN z01_v_cxpostal type varchar(20);

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------- INICIO FINANCEIRO ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS classificacaocredoreselemento CASCADE;
DROP SEQUENCE IF EXISTS classificacaocredoreselemento_cc32_sequencial_seq;
DROP TABLE IF EXISTS classificacaocredoresrecurso CASCADE;
DROP SEQUENCE IF EXISTS classificacaocredoresrecurso_cc33_sequencial_seq;
DROP TABLE IF EXISTS classificacaocredorestipocompra CASCADE;
DROP SEQUENCE IF EXISTS classificacaocredorestipocompra_cc34_sequencial_seq;
DROP TABLE IF EXISTS classificacaocredoresevento CASCADE;
DROP SEQUENCE IF EXISTS classificacaocredoresevento_cc35_sequencial_seq;

ALTER TABLE classificacaocredores DROP COLUMN if exists cc30_diasvencimento;
ALTER TABLE classificacaocredores DROP COLUMN if exists cc30_contagemdias;
ALTER TABLE classificacaocredores DROP COLUMN if exists cc30_valorinicial;
ALTER TABLE classificacaocredores DROP COLUMN if exists cc30_valorfinal;
ALTER TABLE classificacaocredores DROP COLUMN if exists cc30_dispensa;
ALTER TABLE classificacaocredores DROP COLUMN if exists cc30_ordem;

alter table empautpresta DROP CONSTRAINT empautoriza_empautpresta_fk;
alter table empautpresta DROP CONSTRAINT empprestatip_empautpresta_fk;
drop index  empautpresta_autori_in;

DROP TABLE IF EXISTS cgmestrangeiro CASCADE;
DROP SEQUENCE IF EXISTS cgmestrangeiro_z09_sequencial_seq;

---------------------------------------------------------------------------------------------------------------------------
------------------------------------------------ INICIO FOLHA -------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS avaliacaogruporespostacgm;
DROP SEQUENCE IF EXISTS avaliacaogruporespostacgm_eso03_sequencial_seq;


---------------------------------------------------------------------------------------
---------------------------------- INICIO EDUCAÇÃO ------------------------------------
---------------------------------------------------------------------------------------
delete from censoregradisc  where ed272_ano = 2016;
delete from censoetapamediacaodidaticopedagogica where ed131_ano = 2016;
delete from censoinstsuperior where ed257_i_codigo in (12899, 10251, 13728, 13764, 14158, 14718, 15500, 15562, 16602, 16782, 16849, 16918, 16948, 17025, 17091, 17115, 17118, 17289, 17348, 17355, 17382, 17394, 17400, 17403, 17420, 17460, 17558, 17563, 17565, 17590, 17593, 17598, 17608, 17622, 17628, 17662, 17670, 17672, 17674, 17701, 17731, 17749, 17763, 17816, 17828, 17831, 17850, 17854, 18010, 18019, 18023, 18067, 18075, 18114, 18133, 18165, 18257, 18288, 19500, 19501, 19512, 19578, 19588, 19739, 19862, 20478, 21095, 21206);
