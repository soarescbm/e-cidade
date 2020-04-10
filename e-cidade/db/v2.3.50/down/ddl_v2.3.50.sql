---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------- INICIO TRIBUTARIO ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS itbiintermediador CASCADE;
DROP SEQUENCE IF EXISTS itbiintermediador_it35_sequencial_seq;

---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO FOLHA ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
alter table rhrubricas drop column if exists rh27_valorlimite;
alter table rhrubricas drop column if exists rh27_quantidadelimite;
alter table rhrubricas drop column if exists rh27_tipobloqueio;

DROP TABLE if exists avaliacaoperguntadb_formulas;
DROP SEQUENCE if exists avaliacaogruporespostacgm_eso02_sequencial_seq
;

DROP TABLE if exists avaliacaogruporespostacgm;
DROP SEQUENCE if exists avaliacaoperguntadb_formulas_eso01_sequencial_seq;

---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------- INICIO EDUCACAO/SAUDE  ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
ALTER TABLE sec_parametros DROP COLUMN if exists ed290_diasmanutencaohistorico;
