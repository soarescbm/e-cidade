
---------------------------------------------------------------------------------------------
-------------------------------- INCIO FINANCEIRO -------------------------------------------
---------------------------------------------------------------------------------------------

-- planilha de distribuição
drop table if exists planilhadistribuicaomaterial;
drop table if exists planilhadistribuicaodepart;
drop table if exists planilhadistribuicao;

drop sequence if exists planilhadistribuicaomaterial_pd03_sequencial_seq;
drop sequence if exists planilhadistribuicaodepart_pd02_sequencial_seq;
drop sequence if exists planilhadistribuicao_pd01_sequencial_seq;
-- fim planilha de distribuição

---------------------------------------------------------------------------------------------
-------------------------------- FIM FINANCEIRO---------------------------------------------
---------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
------------------------------ INICIO EDUCAÇÃO E SAÚDE -----------------------------
------------------------------------------------------------------------------------

DROP TABLE IF EXISTS controlematriculainicial CASCADE;
DROP SEQUENCE IF EXISTS controlematriculainicial_ed135_sequencial_seq;

------------------------------------------------------------------------------------
------------------------------ FIM EDUCAÇÃO E SAÚDE --------------------------------
------------------------------------------------------------------------------------