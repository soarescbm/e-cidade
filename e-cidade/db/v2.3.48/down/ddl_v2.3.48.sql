
---------------------------------------------------------------------------------------------
---------------------------------- INICIO FINANCEIRO -----------------------------------------
---------------------------------------------------------------------------------------------
alter table liccomissao drop column if exists l30_nomearquivo;
alter table liccomissao drop column if exists l30_arquivo;

-- remove os atributos dinamicos cadastrados
drop table if exists w_codigoatributosdinamicos;
create temp table w_codigoatributosdinamicos as select db17_cadattdinamico as codigo from db_cadattdinamicosysarquivo where db17_sysarquivo = 1260;

delete from db_cadattdinamicoatributosvalor
 where db110_db_cadattdinamicoatributos in ( select db109_sequencial
                                               from db_cadattdinamicoatributos
                                              where db109_db_cadattdinamico in (select codigo from w_codigoatributosdinamicos) );
delete from db_cadattdinamicoatributosopcoes
  where db18_cadattdinamicoatributos in ( select db109_sequencial
                                            from db_cadattdinamicoatributos
                                           where db109_db_cadattdinamico in (select codigo from w_codigoatributosdinamicos) );
delete from db_cadattdinamicoatributos where db109_db_cadattdinamico in (select codigo from w_codigoatributosdinamicos);
delete from db_cadattdinamicosysarquivo where db17_sysarquivo = 1260;
delete from db_cadattdinamico where db118_sequencial in (select codigo from w_codigoatributosdinamicos);

drop table if exists w_codigoatributosdinamicos;
create temp table w_codigoatributosdinamicos as select db17_cadattdinamico as codigo from db_cadattdinamicosysarquivo where db17_sysarquivo = 1325;

delete from db_cadattdinamicoatributosvalor
 where db110_db_cadattdinamicoatributos in ( select db109_sequencial
                                               from db_cadattdinamicoatributos
                                              where db109_db_cadattdinamico in (select codigo from w_codigoatributosdinamicos) );
delete from db_cadattdinamicoatributosopcoes
  where db18_cadattdinamicoatributos in ( select db109_sequencial
                                            from db_cadattdinamicoatributos
                                           where db109_db_cadattdinamico in (select codigo from w_codigoatributosdinamicos) );
delete from db_cadattdinamicoatributos where db109_db_cadattdinamico in (select codigo from w_codigoatributosdinamicos);
delete from db_cadattdinamicosysarquivo where db17_sysarquivo = 1325;
delete from db_cadattdinamico where db118_sequencial in (select codigo from w_codigoatributosdinamicos);

---
drop table if exists db_cadattdinamicosysarquivo;
drop sequence if exists db_cadattdinamicosysarquivo_db17_sequencial_seq;

drop table if exists liccomissaocgmcadattdinamicovalorgrupo;
drop sequence if exists liccomissaocgmcadattdinamicovalorgrupo_l15_sequencial_seq;

drop table if exists liclicitacadattdinamicovalorgrupo;
drop sequence if exists liclicitacadattdinamicovalorgrupo_l16_sequencial_seq;

alter table db_cadattdinamicoatributos drop column if exists db109_nome;

drop table if exists db_cadattdinamicoatributosopcoes;
drop sequence if exists db_cadattdinamicoatributosopcoes_db18_sequencial_seq;

alter table pctipocompratribunal drop column if exists l44_sigla;

-- Estrutura Tabela Habilitação de Fornecedores
DROP TABLE IF EXISTS pcorcamfornelichabilitacao CASCADE;
DROP SEQUENCE IF EXISTS pcorcamfornelichabilitacao_l17_sequencial_seq;

-- Campo Tipo de Condição - Tabela de Fornecedores da Liquidação
alter table pcorcamfornelic drop column if exists pc31_tipocondicao;

drop table if exists liclicitatipoevento cascade;
drop sequence if exists liclicitatipoevento_l45_sequencial_seq;

drop table if exists liclicitaeventodocumento cascade;
drop sequence if exists liclicitaeventodocumento_l47_sequencial_seq;

drop table if exists liclicitaevento;
drop sequence if exists liclicitaevento_l46_sequencial_seq;

drop table if exists liclicitatipoevento cascade;
drop sequence if exists liclicitatipoevento_l45_sequencial_seq;

drop index if exists liclicitaencerramentolicitacon_sequencial_in;
drop table if exists liclicitaencerramentolicitacon;
drop sequence if exists liclicitaencerramentolicitacon_l18_sequencial_seq;
---------------------------------------------------------------------------------------------
---------------------------------- FIM FINANCEIRO -----------------------------------------
---------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------
---------------------------------- INICIO FOLHA ---------------------------------------------
---------------------------------------------------------------------------------------------

DROP INDEX IF EXISTS cargorhrubricas_instit_in;
DROP INDEX IF EXISTS cargorhrubricas_cargo_instit_in;
DROP INDEX IF EXISTS cargorhrubricas_rubrica_instit_in;
DROP INDEX IF EXISTS funcaorhrubricas_instit_in;
DROP INDEX IF EXISTS funcaorhrubricas_rubrica_instit_in;
DROP INDEX IF EXISTS funcaorhrubricas_funcao_instit_in;

DROP TABLE IF EXISTS cargorhrubricas;
DROP TABLE IF EXISTS funcaorhrubricas;

DROP SEQUENCE IF EXISTS cargorhrubricas_rh176_sequencial_seq;
DROP SEQUENCE IF EXISTS funcaorhrubricas_rh177_sequencial_seq;

---------------------------------------------------------------------------------------------
---------------------------------- FIM FOLHA ------------------------------------------------
---------------------------------------------------------------------------------------------

