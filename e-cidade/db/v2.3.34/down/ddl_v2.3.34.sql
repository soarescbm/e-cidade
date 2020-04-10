------
-- [FINANCEIRO - INICIO]
------

-- 97342
alter table empprestatip drop column if exists e44_naturezaevento;
alter table emppresta drop column if exists e45_processoadministrativo;
alter table emppresta drop column if exists e45_datalimiteaplicacao;
------
-- [FINANCEIRO - FIM]
------


------
-- [FOLHA - INICIO]
------

DROP TABLE IF EXISTS w_migracao_reajusteparidade CASCADE;

CREATE TEMP TABLE w_migracao_reajusteparidade as SELECT distinct
       rh01_regist,
       rh01_instit,
       rh01_numcgm,
       rh01_reajusteparidade
  from rhpessoal;

alter table rhpessoal drop column rh01_reajusteparidade;
alter table rhpessoal add COLUMN rh01_reajusteparidade bool default false;

UPDATE rhpessoal set rh01_reajusteparidade = (select  CASE WHEN rh01_reajusteparidade = 2 then true
                                                           ELSE false
                                                       END
                                                from w_migracao_reajusteparidade
                                               where rhpessoal.rh01_regist = w_migracao_reajusteparidade.rh01_regist);

DROP TABLE IF EXISTS rhreajusteparidade CASCADE;
DROP SEQUENCE IF EXISTS rhreajusteparidade_rh148_sequencial_seq;

alter table rhpespadrao drop column rh03_padraoprev;

-- Comparativo de Férias
alter table cfpess drop column if exists r11_compararferias;
alter table cfpess drop column if exists r11_baseferias;
alter table cfpess drop column if exists r11_basesalario;

-- DESMIGRAÇÃO FUNDAMENTAÇÃO LEGAL
-- Retorna o antigo sequencial
select fc_executa_ddl ('UPDATE rhrubricas SET rh27_rhfundamentacaolegal = migracao.antiga_sequence
                          FROM (
                            SELECT new.rh137_sequencial AS nova_sequence,
                                   old.rh137_sequencial AS antiga_sequence
                              FROM rhfundamentacaolegal new
                                   INNER JOIN rhfundamentacaolegal old ON old.rh137_instituicao = 1
                                                                      AND old.rh137_descricao   = new.rh137_descricao
                             WHERE new.rh137_instituicao > 1
                          ) AS migracao
                          WHERE rh27_rhfundamentacaolegal = migracao.nova_sequence');

-- Limpa as fundamentações legais migradas
select fc_executa_ddl ('DELETE FROM rhfundamentacaolegal WHERE rh137_instituicao != 1');

-- Campo para vinculação de instituição à fundamentação legal
ALTER TABLE rhfundamentacaolegal DROP CONSTRAINT if exists rhfundamentacaolegal_instituicao_fk;
alter table rhfundamentacaolegal drop column if exists rh137_instituicao;

/**
 * Criação da Tabela rhpreponto
 */
drop table IF EXISTS rhpreponto;

------
-- [FOLHA - FIM]
------

------
-- [TRIBUTARIO - INICIO]
------
alter table vistexec  alter COLUMN y11_compl type varchar(20);
alter table vistlocal alter COLUMN y10_compl type varchar(20);

delete from db_sysfuncoesparam where db42_funcao in ( 163, 164, 166, 167 );
delete from db_sysfuncoes      where codfuncao   in ( 163, 164, 166, 167 );

alter table empreendimento drop COLUMN if exists am05_areatotal;

delete from iptutabelas where j121_codarq = 3698;
------
-- [TRIBUTARIO - FIM]
------

------
-- [TIME C - INICIO]
------

alter table sau_triagemavulsa ALTER COLUMN s152_i_pressaosistolica  set not null;
alter table sau_triagemavulsa ALTER COLUMN s152_i_pressaodiastolica set not null;
alter table sau_triagemavulsa ALTER COLUMN s152_i_cintura           set not null;
alter table sau_triagemavulsa ALTER COLUMN s152_n_peso              set not null;
alter table sau_triagemavulsa ALTER COLUMN s152_i_altura            set not null;
alter table sau_triagemavulsa ALTER COLUMN s152_i_glicemia          set not null;
alter table sau_triagemavulsa ALTER COLUMN s152_i_pressaosistolica  SET DEFAULT 0;
alter table sau_triagemavulsa ALTER COLUMN s152_i_pressaodiastolica SET DEFAULT 0;
alter table sau_triagemavulsa ALTER COLUMN s152_i_cintura           SET DEFAULT 0;
alter table sau_triagemavulsa ALTER COLUMN s152_n_peso              SET DEFAULT 0;
alter table sau_triagemavulsa ALTER COLUMN s152_i_altura            SET DEFAULT 0;
alter table sau_triagemavulsa ALTER COLUMN s152_i_glicemia          SET DEFAULT 0;

-- TAREFA 104640

DROP TABLE if exists motivoalta CASCADE;
DROP TABLE if exists prontuariosmotivoalta CASCADE;
DROP SEQUENCE if exists motivoalta_sd01_codigo_seq;
DROP SEQUENCE if exists prontuariosmotivoalta_sd25_codigo_seq;

DROP TABLE IF EXISTS classificacaorisco CASCADE;
DROP TABLE IF EXISTS prontuariosclassificacaorisco CASCADE;
DROP SEQUENCE IF EXISTS classificacaorisco_sd78_codigo_seq;
DROP SEQUENCE IF EXISTS prontuariosclassificacaorisco_sd101_codigo_seq;

------
-- [TIME C - FIM]
------
