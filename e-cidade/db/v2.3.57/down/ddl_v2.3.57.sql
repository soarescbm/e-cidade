---------------------------------------------------------------------------------------------------------------
--------------------------------------------- INICIO FINANCEIRO -----------------------------------------------
---------------------------------------------------------------------------------------------------------------
alter table liccomissao alter COLUMN l30_nomearquivo type varchar(100);
alter table acordodocumento alter COLUMN ac40_nomearquivo type varchar(100);
alter table acordodocumento alter COLUMN ac40_descricao type varchar(100);


drop table if exists planocontadetalhe;
drop table if exists importacaoplanoconta;
drop table if exists modeloplanoconta;

DROP VIEW vs_planocontas;
DROP VIEW vs_planosistema;

alter table conplano alter column c60_descr type varchar(50);

create view vs_planocontas as
  SELECT *
  FROM CONPLANO
    INNER JOIN CONSISTEMA             ON C60_CODSIS = C52_CODSIS
    INNER JOIN CONCLASS               ON C60_CODCLA = C51_CODCLA
    LEFT  JOIN CONPLANOCONTA          ON C60_CODCON = C63_CODCON and c63_ANOUSU = C60_ANOUSU
    LEFT JOIN CONPLANOREDUZ           ON C60_CODCON = C61_CODCON and C60_ANOUSU =C61_ANOUSU
    LEFT JOIN CONPLANOEXE             ON C61_ANOUSU = C62_ANOUSU and C61_REDUZ  = C62_REDUZ
    LEFT JOIN ORCTIPOREC              ON C61_CODIGO = O15_CODIGO
    LEFT JOIN DB_CONFIG               ON CODIGO     = CONPLANOREDUZ.C61_INSTIT

;

create view vs_planosistema as
  SELECT *
  FROM CONPLANOSIS
    INNER JOIN CONPLANOREF             ON C65_CODPLA = C64_CODPLA
    INNER JOIN CONPLANO                ON C60_CODCON = C65_CODCON
    INNER JOIN CONPLANOREDUZ           ON C61_CODCON = C60_CODCON
    INNER JOIN CONPLANOEXE        	ON C61_REDUZ  = C62_REDUZ
    INNER JOIN ORCTIPOREC              ON C61_CODIGO = O15_CODIGO
    LEFT OUTER JOIN CONPLANOCONTA      ON C60_CODCON = C63_CODCON
;


---------------------------------------------------------------------------------------------------------------
--------------------------------------------- FIM FINANCEIRO --------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO TRIBUTARIO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

drop table if exists agua.aguacoletorexportadadoscontrato;
drop sequence if exists agua.aguacoletorexportadadoscontrato_x57_sequencial_seq;
alter table aguacoletorexporta drop column x49_db_layouttxt;


-- EMISSÃO GERAL:
--DROP TABLE:
DROP TABLE IF EXISTS emissaogeral CASCADE;
DROP TABLE IF EXISTS emissaogeralinscricao CASCADE;
DROP TABLE IF EXISTS emissaogeralmatricula CASCADE;
DROP TABLE IF EXISTS emissaogeralregistro CASCADE;
--Criando drop sequences
DROP SEQUENCE IF EXISTS emissaogeral_tr01_sequencial_seq;
DROP SEQUENCE IF EXISTS emissaogeralinscricao_tr04_sequencial_seq;
DROP SEQUENCE IF EXISTS emissaogeralmatricula_tr03_sequencial_seq;
DROP SEQUENCE IF EXISTS emissaogeralregistro_tr02_sequencial_seq;

DROP SEQUENCE IF EXISTS emissaogeralparcelaunica_tr05_sequencial_seq;
DROP TABLE IF EXISTS emissaogeralparcelaunica CASCADE;
ALTER TABLE recibocodbar
DROP COLUMN k00_nossonumero;

drop table ocorrenciaretornocobrancaregistrada;
drop table retornocobrancaregistrada;
drop table ocorrenciacobrancaregistrada;
drop table movimentoocorrenciacobrancaregistrada;

drop sequence ocorrenciaretornocobrancaregistrada_k170_sequencial_seq;
drop sequence retornocobrancaregistrada_k168_sequencial_seq;
drop sequence ocorrenciacobrancaregistrada_k149_sequencial_seq;
drop sequence movimentoocorrenciacobrancaregistrada_k169_sequencial_seq;

----
--Remove a obrigatoriedade da coluna dv14_data_calculo da tabela diversoslancamentotaxa
----
ALTER TABLE
  diversoslancamentotaxa
ALTER COLUMN dv14_data_calculo DROP NOT NULL;
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
------------------------------------------ INICIO EDUCACAO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

alter table procedimento drop column ed40_desativado;

drop table if exists avaliacaoestruturanotapadrao cascade;
drop sequence if exists avaliacaoestruturanotapadrao_ed139_sequencial_seq;
select fc_executa_ddl('alter table formaavaliacao alter COLUMN ed37_i_escola set not null;');

select fc_executa_ddl('ALTER TABLE escola.aluno DROP COLUMN ed47_municipioestrangeiro;');

---------------------------------------------------------------------------------------------------------------
-------------------------------------------- FIM EDUCACAO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
------------------------------------------ INICIO FOLHA ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Atualiza??o da tabela rhemitecontracheque
select fc_executa_ddl('alter table pessoal.rhemitecontracheque drop column rh85_liquido ');
select fc_executa_ddl('alter table pessoal.rhemitecontracheque drop column rh85_desconto');
select fc_executa_ddl('alter table pessoal.rhemitecontracheque drop column rh85_provento');

-- Atualiza??o da tabela rhferiasconfiguracao
select fc_executa_ddl('alter table recursoshumanos.rhferiasconfiguracao rename to tipoassentamentoferias');
select fc_executa_ddl('alter table recursoshumanos.tipoassentamentoferias drop column rh168_ultimoperiodoaquisitivo');

---------------------------------------------------------------------------------------------------------------
-------------------------------------------- FIM FOLHA -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------