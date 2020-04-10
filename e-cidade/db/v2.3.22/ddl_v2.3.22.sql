/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME C INICIO
 * --------------------------------------------------------------------------------------------------------------------
 */

-- Tarefa 83899
ALTER TABLE aluno ADD COLUMN ed47_cartaosus varchar(15);

-- Tarefa 88397
ALTER TABLE linhatransportepontoparadaaluno ADD COLUMN tre12_linhatransportehorarioveiculo int not null;

ALTER TABLE linhatransportepontoparadaaluno
ADD CONSTRAINT linhatransportepontoparadaaluno_linhatransportehorarioveiculo_fk FOREIGN KEY (tre12_linhatransportehorarioveiculo)
REFERENCES linhatransportehorarioveiculo;

-- Tarefa 88386
DROP INDEX mer_infaluno_aluno_data_in;

/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME C FIM
 * --------------------------------------------------------------------------------------------------------------------
 */


/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME B INICIO
 * --------------------------------------------------------------------------------------------------------------------
 */

-- Tarefa 77814


CREATE OR REPLACE FUNCTION recreate_views(run_me text, views text[])
  RETURNS void
AS  $$
DECLARE
  view_defs text[];
  view_schemas text[];
  i integer;
  def text;
  schema text;
BEGIN
  for i in array_lower(views,1) .. array_upper(views,1) loop
    select definition, schemaname into def, schema from pg_views where viewname = views[i];
    view_defs[i] := def;
    view_schemas[i] := schema;
    IF def IS NOT NULL THEN
        EXECUTE 'DROP VIEW ' || schema || '.' || views[i];
    END IF;
end loop;   

    EXECUTE run_me;

for i in reverse array_upper(views,1) .. array_lower(views,1) loop
    IF view_defs[i] IS NOT NULL THEN
        def = 'CREATE OR REPLACE VIEW ' || view_schemas[i] || '.' || views[i] || ' AS ' || view_defs[i];
        EXECUTE def;
    END IF;
end loop;
END
$$
LANGUAGE plpgsql;

select recreate_views('ALTER TABLE cgm ALTER COLUMN z01_telef  TYPE varchar(20),ALTER COLUMN z01_telcon TYPE varchar(20),ALTER COLUMN z01_celcon TYPE varchar(20),ALTER COLUMN z01_telcel TYPE varchar(20), ALTER COLUMN z01_fax  TYPE varchar(20);', array_accum(viewname)) from pg_views where definition ilike '%z01_telef%' or definition ilike '%z01_telcon%' or definition ilike '%z01_celcon%' or definition ilike '%z01_telcel%' or definition ilike '%z01_fax%';
ALTER TABLE cgmalt ALTER COLUMN z05_telef  TYPE varchar(20),ALTER COLUMN z05_telcon TYPE varchar(20),ALTER COLUMN z05_celcon TYPE varchar(20),ALTER COLUMN z05_telcel TYPE varchar(20), ALTER COLUMN z05_fax  TYPE varchar(20);

/**
 * --------------------------------------------------------------------------------------------------------------------
 * TIME B FIM
 * --------------------------------------------------------------------------------------------------------------------
 */

/**
 * Cálculo de iptu paty do alferes
 */
create sequence caractercaracter_j138_sequencial_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create table caractercaracter (
  j138_sequencial integer default nextval('caractercaracter_j138_sequencial_seq'),
  j138_caracterorigem integer,
  j138_caracterdestino integer,
  j138_pontuacao numeric,
  j138_aliquota numeric default 0,
  j138_valor numeric default 0,
  j138_anousu integer,
  constraint caracterponto_sequencial_pk primary key (j138_sequencial),
  constraint caracterponto_caracterorigem_fk foreign key (j138_caracterorigem) references caracter(j31_codigo),
  constraint caracterponto_caracterdestino_fk foreign key (j138_caracterdestino) references caracter(j31_codigo)
);
