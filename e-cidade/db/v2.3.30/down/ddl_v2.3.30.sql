/**
 * Arquivo ddl down
 */

----------------------------------------------------
---- TIME FOLHA DE PAGAMENTO
----------------------------------------------------
---- Tarefa: 96909
----------------------------------------------------

-- Delete de valor para a tabela thtipofolha
DELETE FROM rhtipofolha WHERE rh142_sequencial = 6;

DROP TABLE IF EXISTS w_migracao_rhfolhapagamento_salario;
DROP TABLE IF EXISTS w_ultimafolhadecadacompetencia_salario;

/**
 * TRIBUTÁRIO
 */
DROP TABLE IF EXISTS setorlocvalor;
DROP TABLE IF EXISTS autolevanta CASCADE;
DROP SEQUENCE IF EXISTS autolevanta_y117_sequencial_seq;

ALTER TABLE fiscalprocrec drop COLUMN y45_percentual;

alter table parfiscal drop column y32_templatealvarasanitariopermanente;

/**
 * FIM TRIBUTÁRIO
 */

----------------------------------------------------
---- TIME C
----------------------------------------------------

----------------------------------------------------
---- Tarefa: 95125
----------------------------------------------------

ALTER TABLE periodoescola drop column ed17_duracao;

DROP SEQUENCE IF EXISTS horarioescola_ed123_sequencial_seq;
DROP TABLE IF EXISTS horarioescola;

create index alunocensotipotransporte_aluno_in on alunocensotipotransporte( ed311_aluno );
create index alunocensotipotransporte_censotipotransporte_in on alunocensotipotransporte( ed311_censotipotransporte );

----------------------------------------------------
--- Tarefa 92193
----------------------------------------------------
alter table historicomps alter COLUMN ed62_percentualfrequencia type numeric(5,2);
alter table historicompsfora drop column ed99_percentualfrequencia;

----------------------------------------------------
---- } FIM TIME C
----------------------------------------------------

----------------------------------------------------
---- TIME FINANCEIRO
----------------------------------------------------
---- Tarefa: 97055
----------------------------------------------------

DROP TABLE IF EXISTS processocompralote CASCADE;
DROP TABLE IF EXISTS processocompraloteitem CASCADE;

DROP SEQUENCE IF EXISTS processocompralote_pc68_sequencial_seq;
DROP SEQUENCE IF EXISTS processocompraloteitem_pc69_sequencial_seq;

ALTER TABLE pcproc
DROP COLUMN pc80_tipoprocesso;

----------------------------------------------------
---- Tarefa: 97148
----------------------------------------------------
drop index materialtipogrupovinculo_materialtipogrupo_in;
alter table materialtipogrupovinculo add column m04_db_estruturavalor int4;

update materialtipogrupovinculo set m04_db_estruturavalor = (select m65_db_estruturavalor from materialestoquegrupo where m65_sequencial = m04_materialestoquegrupo);

alter table materialtipogrupovinculo
      drop column m04_materialestoquegrupo,
      alter column m04_db_estruturavalor set not null,
      add constraint materialtipogrupovinculo_db_estruturavalor_fk foreign key (m04_db_estruturavalor) references db_estruturavalor;
create unique index materialtipogrupovinculo_materialtipogrupo_in on materialtipogrupovinculo (m04_materialtipogrupo);
----------------------------------------------------
----------------------------------------------------