alter table matunid drop column if exists m61_codigotribunal;
alter table pcorcamval drop column if exists pc23_bdi;
alter table pcorcamval drop column if exists pc23_encargossociais;

-- Atributo dinâmico Tipo de Orçamento da Licitação
drop table if exists w_codigoatributosdinamicos;
create temp table w_codigoatributosdinamicos as
  select max(db109_sequencial)  as codigo
  from db_cadattdinamicoatributos
  where db109_db_cadattdinamico in (select db17_cadattdinamico from db_cadattdinamicosysarquivo where db17_sysarquivo = 1260)
  and db109_nome = 'tipoorcamento';

delete from db_cadattdinamicoatributosvalor
where db110_db_cadattdinamicoatributos in (select codigo from w_codigoatributosdinamicos);

delete from db_cadattdinamicoatributosopcoes
where db18_cadattdinamicoatributos in (select codigo from w_codigoatributosdinamicos);

delete from db_cadattdinamicoatributos where db109_sequencial in (select codigo from w_codigoatributosdinamicos);

-- pcorcamval data da proposta
alter table pcorcamval drop column if exists pc23_data;
alter table pcorcamval drop column if exists pc23_notatecnica;

-- licitacaoreservacotas
drop index if exists licitacaoreservacotas_liclicitemorigem_in;
drop index if exists licitacaoreservacotas_liclicitemreserva_in;
drop table if exists licitacaoreservacotas;
drop sequence if exists licitacaoreservacotas_l19_sequencial_seq;

/** LicitaCon - Contratos */

/** Acordo  - Novos Campos */
alter table acordo drop column if exists ac16_tipoinstrumento;
alter table acordo drop column if exists ac16_dependeordeminicio;

DROP TABLE IF EXISTS acordoempempenho CASCADE;
DROP SEQUENCE IF EXISTS acordoempempenho_ac54_sequencial_seq;

--DROP TABLE:



DROP TABLE IF EXISTS acordodocumentoevento cascade;
DROP TABLE IF EXISTS acordoevento cascade;
DROP TABLE IF EXISTS acordoposicaoevento cascade;

DROP SEQUENCE IF EXISTS acordodocumentoevento_ac57_sequencial_seq;
DROP SEQUENCE IF EXISTS acordoevento_ac55_sequencial_seq;
DROP SEQUENCE IF EXISTS acordoposicaoevento_ac56_sequencial_seq;


