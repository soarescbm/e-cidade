

----------------------------
--- Time C - INICIO
----------------------------

-- 82709
DROP TABLE IF EXISTS diarioregracalculo;
DROP TABLE IF EXISTS regracalculo;
DROP SEQUENCE IF EXISTS diarioregracalculo_ed125_codigo_seq;
DROP SEQUENCE IF EXISTS regracalculo_ed126_codigo_seq;

alter table procresultado drop column ed43_proporcionalidade;
alter table procavaliacao drop column ed41_julgamenoravaliacao;
----------------------------
--- Time C - FIM
----------------------------
