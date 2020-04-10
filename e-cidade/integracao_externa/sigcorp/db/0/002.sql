drop language if exists plpgsql;
create language plpgsql;

-- Funcao para GRANT ou REVOKE
create or replace function fc_grant_revoke(text, text, text, text, text) returns integer as 
$$
declare
  sUsuario    alias for $2;
  sPrivilegio alias for $3; -- [ all | select,insert,update,delete ]
  sEsquema    alias for $4;
  sObjeto     alias for $5; -- [ table | view | sequence ]

  sOpcao      text;
  rObjeto     record;
  iQtd        integer;

  sPredicado  text;
begin
  iQtd := 0;

  sOpcao := upper($1); -- [ grant | revoke ]

  -- Verifica predicado para Grant nos Schemas
  if position('DELETE' in sOpcao) > 0 or
     position('UPDATE' in sOpcao) > 0 or
     position('INSERT' in sOpcao) > 0 or
     sOpcao = 'ALL' then
    sPredicado := ' all ';
  else
    sPredicado := ' usage ';
  end if;

  -- Grant/Revoke nos Schemas
  for rObjeto in
    select nspname
      from pg_namespace
     where nspname not in ('pg_catalog', 'information_schema', 'pg_toast')
       and nspname !~ '^pg_temp'
       and nspname like sEsquema
  loop
    if upper(sOpcao) = 'GRANT' then
      execute 'grant ' || sPredicado || ' on schema ' || rObjeto.nspname || ' to ' || sUsuario;
    else
      execute 'revoke ' || sPredicado || ' on schema ' || rObjeto.nspname || ' from ' || sUsuario;
    end if;
  end loop;

  -- Grant/Revoke nas Relacoes
  for rObjeto in 
    select relname,
           nspname
      from pg_class c
           join pg_namespace ns on (c.relnamespace = ns.oid) 
     where relkind in ('r','v','s') -- Relacao, View, Sequence
       --and nspname not in ('pg_catalog', 'information_schema', 'pg_toast')
       --and nspname !~ '^pg_temp'
       and nspname like sEsquema 
       and relname like sObjeto
  loop
    if upper(sOpcao) = 'GRANT' then
      --raise info 'grant % on % to %;', sPrivilegio, rObjeto.relname, sUsuario;
      execute 'grant ' || sPrivilegio || ' on ' || rObjeto.nspname || '.' || rObjeto.relname || ' to ' || sUsuario;
    else
      --raise info 'revoke % on % from %;', sPrivilegio, rObjeto.relname, sUsuario;
      execute 'revoke ' || sPrivilegio || ' on ' || rObjeto.nspname || '.' || rObjeto.relname || ' from ' || sUsuario;
    end if;
    iQtd := iQtd + 1;
  end loop;
  return iQtd;
end;
$$ 
language plpgsql;


create or replace function fc_grant(text, text, text, text) returns integer as 
$$
  select fc_grant_revoke('grant', $1, $2, $3, $4);
$$
language sql;

create or replace function fc_revoke(text, text, text, text) returns integer as 
$$
  select fc_grant_revoke('revoke', $1, $2, $3, $4);
$$
language sql;

create or replace function fc_valida_hora(char(5)) returns boolean as 
$$
  select ((cast(substr($1,1,2) as integer) between 0 and 23) and (cast(substr($1,4,2) as integer) between 0 and 59));
$$
language sql;


-- Cria Role
DROP ROLE IF EXISTS integraiss;
CREATE ROLE integraiss WITH LOGIN PASSWORD 'IntegraISS@2010';

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM integraiss;

-- Define Permissoes Objetos
SELECT fc_grant('integraiss', 'select,update', 'public', 'integra%');
SELECT fc_grant('integraiss', 'delete,insert', 'public', 'integra_recibo');
SELECT fc_grant('integraiss', 'delete,insert', 'public', 'integra_recibo_anulado');

-- Default Values
ALTER TABLE integra_recibo ALTER valor_imposto  SET DEFAULT 0;
ALTER TABLE integra_recibo ALTER valor_juros    SET DEFAULT 0;
ALTER TABLE integra_recibo ALTER valor_multa    SET DEFAULT 0;
ALTER TABLE integra_recibo ALTER valor_desconto SET DEFAULT 0;
ALTER TABLE integra_recibo ALTER valor_total    SET DEFAULT 0;

-- Check Constraints
ALTER TABLE integra_recibo ADD CONSTRAINT integra_recibo_integra_cadastro_ck    CHECK ((integra_cadastro IS NOT NULL) OR (integra_cad_empresa IS NOT NULL));
ALTER TABLE integra_recibo ADD CONSTRAINT integra_recibo_integra_cad_empresa_ck CHECK ((integra_cadastro IS NOT NULL) OR (integra_cad_empresa IS NOT NULL));

ALTER TABLE integra_recibo ADD CONSTRAINT integra_recibo_ano_competencia_ck     CHECK (ano_competencia > 1900);
ALTER TABLE integra_recibo ADD CONSTRAINT integra_recibo_mes_competencia_ck     CHECK (mes_competencia BETWEEN 1 AND 12);
ALTER TABLE integra_recibo ADD CONSTRAINT integra_recibo_valor_total_ck         CHECK ((valor_total = (valor_imposto+valor_juros+valor_multa-valor_desconto)) AND (valor_total >= 0));
ALTER TABLE integra_recibo ADD CONSTRAINT integra_recibo_tipo_boleto_ck         CHECK (tipo_boleto IN ('T', 'P'));
ALTER TABLE integra_recibo ADD CONSTRAINT integra_recibo_horaimp_ck             CHECK (fc_valida_hora(horaimp) IS TRUE);

ALTER TABLE integra_recibo_anulado ADD CONSTRAINT integra_recibo_anulado_horaimp_ck         CHECK (fc_valida_hora(horaimp) IS TRUE);

-- Dados Extra
INSERT INTO integra_tipocadastro (sequencial, descricao) VALUES (1, 'EVENTUAL FORA DO MUNICIPIO');

