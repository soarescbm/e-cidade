insert into db_versao (db30_codver, db30_codversao, db30_codrelease, db30_data, db30_obs)  values (358, 3, 42, '2015-09-28', 'Tarefas: 98686');/**
 * Realiza o tratamento das variavéis para a função db_fxxx.
 *
 * @param {integer} iMatricula      Matricula do servidor;
 * @param {integer} iAnoCompetencia Ano da competência;
 * @param {integer} iMesCompetencia Mês da competência;
 * @param {integer} iInstituicao    Instituição;
 *
 * @return variaveis calculadas pela funcao db_fxxx
 */
create or replace function fc_variaveis_matricula( 
  iMatricula      integer, 
  iAnoCompetencia integer, 
  iMesCompetencia integer,
  iInstituicao    integer,

  OUT F001        float4,
  OUT F002        float4,
  OUT F003        date,
  OUT F004        numeric,
  OUT F005        numeric,
  OUT F006        numeric,
  OUT F006_CLT    numeric,
  OUT F008        float4,
  OUT F009        numeric,
  OUT F007        float8,
  OUT F010        float8,
  OUT F011        float4,
  OUT F012        numeric,
  OUT F013        numeric,
  OUT F014        numeric,
  OUT F015        float4,
  OUT F022        numeric,
  OUT F024        float4,
  OUT F025        numeric,
  OUT F026        varchar(12) 
)                 
                  
returns record as 

$$
declare

begin


  F001     := 0; 
  F002     := 0; 
  F003     := null;    
  F004     := 0; 
  F005     := 0; 
  F006     := 0; 
  F006_CLT := 0; 
  F008     := 0; 
  F009     := 0; 
  F007     := 0; 
  F010     := 0; 
  F011     := 0; 
  F012     := 0; 
  F013     := 0; 
  F014     := 0; 
  F015     := 0; 
  F022     := 0; 
  F024     := 0; 
  F025     := 0; 
  F026     := '            '; 

select cast( trim(substr(funcao ,1,11))   as float4),    
       cast( trim(substr(funcao ,12,11))  as float4),    
       cast( trim(substr(funcao ,23,11))  as date),                  
       cast( trim(substr(funcao ,34,11))  as numeric),
       cast( trim(substr(funcao ,45,11))  as numeric),
       cast( trim(substr(funcao ,56,11))  as numeric),
       cast( trim(substr(funcao ,67,11))  as numeric),
       cast( trim(substr(funcao ,78,11))  as float4),
       cast( trim(substr(funcao ,89,11))  as numeric),
       cast( trim(substr(funcao ,100,11)) as float8),
       cast( trim(substr(funcao ,111,11)) as float8),
       cast( trim(substr(funcao ,122,11)) as float4),
       cast( trim(substr(funcao ,133,11)) as numeric),
       cast( trim(substr(funcao ,144,11)) as numeric),
       cast( trim(substr(funcao ,155,11)) as numeric),
       cast( trim(substr(funcao ,166,11)) as float4),
       cast( trim(substr(funcao ,177,11)) as numeric),
       cast( trim(substr(funcao ,188,11)) as float4),
       cast( trim(substr(funcao ,199,11)) as numeric)
  into
       F001,
       F002,
       F003,
       F004,
       F005,
       F006,
       F006_CLT,
       F008,
       F009,
       F007,
       F010,
       F011,
       F012,
       F013,
       F014,
       F015,
       F022,
       F024,
       F025
  from db_fxxx(
    iMatricula, 
    iAnoCompetencia, 
    iMesCompetencia, 
    iInstituicao
  ) as funcao;
   
  return;
end;
$$
language 'plpgsql';insert into db_versaoant (db31_codver,db31_data) values (358, current_date);
select setval ('db_versaousu_db32_codusu_seq',(select max (db32_codusu) from db_versaousu));
select setval ('db_versaousutarefa_db28_sequencial_seq',(select max (db28_sequencial) from db_versaousutarefa));
select setval ('db_versaocpd_db33_codcpd_seq',(select max (db33_codcpd) from db_versaocpd));
select setval ('db_versaocpdarq_db34_codarq_seq',(select max (db34_codarq) from db_versaocpdarq));create table bkp_db_permissao_20150928_100900 as select * from db_permissao;
create temp table w_perm_filhos as 
select distinct 
       i.id_item        as filho, 
       p.id_usuario     as id_usuario, 
       p.permissaoativa as permissaoativa, 
       p.anousu         as anousu, 
       p.id_instit      as id_instit, 
       m.modulo         as id_modulo  
  from db_itensmenu i  
       inner join db_menu      m  on m.id_item_filho = i.id_item 
       inner join db_permissao p  on p.id_item       = m.id_item_filho 
                                 and p.id_modulo     = m.modulo 
 where coalesce(i.libcliente, false) is true;

create index w_perm_filhos_in on w_perm_filhos(filho);

create temp table w_semperm_pai as 
select distinct m.id_item       as pai, m.id_item_filho as filho 
  from db_itensmenu i 
       inner join db_menu            m  on m.id_item   = i.id_item 
       left  outer join db_permissao p  on p.id_item   = m.id_item 
                                       and p.id_modulo = m.modulo 
 where p.id_item is null 
   and coalesce(i.libcliente, false) is true;
create index w_semperm_pai_in on w_semperm_pai(filho);
insert into db_permissao (id_usuario,id_item,permissaoativa,anousu,id_instit,id_modulo) 
select distinct wf.id_usuario, wp.pai, wf.permissaoativa, wf.anousu, wf.id_instit, wf.id_modulo 
  from w_semperm_pai wp 
       inner join w_perm_filhos wf on wf.filho = wp.filho 
       where not exists (select 1 from db_permissao p 
                    where p.id_usuario = wf.id_usuario 
                      and p.id_item    = wp.pai 
                      and p.anousu     = wf.anousu 
                      and p.id_instit  = wf.id_instit 
                      and p.id_modulo  = wf.id_modulo); 
delete from db_permissao
 where not exists (select a.id_item 
                     from db_menu a 
                    where a.modulo = db_permissao.id_modulo 
                      and (a.id_item       = db_permissao.id_item or 
                           a.id_item_filho = db_permissao.id_item) );
delete from db_itensfilho    
 where not exists (select 1 from db_arquivos where db_arquivos.codfilho = db_itensfilho.codfilho);

CREATE FUNCTION acerta_permissao_hierarquia() RETURNS varchar AS $$ 

 declare  

   i integer default 1; 

   BEGIN 

  while i < 5 loop   

    insert into db_permissao select distinct 
                                 db_permissao.id_usuario, 
                                 db_menu.id_item, 
                                 db_permissao.permissaoativa, 
                                 db_permissao.anousu, 
                                 db_permissao.id_instit, 
                                 db_permissao.id_modulo 
                            from db_permissao 
                                 inner join db_menu on db_menu.id_item_filho = db_permissao.id_item 
                                                   and db_menu.modulo        = db_permissao.id_modulo 
                           where not exists ( select 1 
                                                from db_permissao as p 
                                               where p.id_item    = db_menu.id_item 
                                                 and p.id_usuario = db_permissao.id_usuario 
                                                 and p.anousu     = db_permissao.anousu 
                                                 and p.id_instit  = db_permissao.id_instit 
                                                 and p.id_modulo  = db_permissao.id_modulo );

  i := i+1; 

 end loop;

return 'Processo concluido com sucesso!';
END; 
$$ LANGUAGE 'plpgsql' ;

select acerta_permissao_hierarquia();
drop function acerta_permissao_hierarquia();create or replace function fc_executa_ddl(text) returns boolean as $$ 
  declare  
    sDDL     alias for $1;
    lRetorno boolean default true;
  begin   
    begin 
      EXECUTE sDDL;
    exception 
      when others then 
        raise info 'Error Code: % - %', SQLSTATE, SQLERRM;
        lRetorno := false;
    end;  
    return lRetorno;
  end; 
  $$ language plpgsql ;

  select fc_executa_ddl('ALTER TABLE '||quote_ident(table_schema)||'.'||quote_ident(table_name)||' ENABLE TRIGGER ALL;') 
  from information_schema.tables 
   where table_schema not in ('pg_catalog', 'pg_toast', 'information_schema')
     and table_schema !~ '^pg_temp'
     and table_type = 'BASE TABLE'
   order by table_schema, table_name;

                                                                                                       
SELECT CASE WHEN EXISTS (SELECT 1 FROM pg_authid WHERE rolname = 'dbseller')                           
  THEN fc_grant('dbseller', 'select', '%', '%') ELSE -1 END;                                           
SELECT CASE WHEN EXISTS (SELECT 1 FROM pg_authid WHERE rolname = 'plugin')                             
  THEN fc_grant('plugin', 'select', '%', '%') ELSE -1 END;                                             
SELECT fc_executa_ddl('GRANT CREATE ON TABLESPACE '||spcname||' TO dbseller;')                         
  FROM pg_tablespace                                                                                   
 WHERE spcname !~ '^pg_' AND EXISTS (SELECT 1 FROM pg_authid WHERE rolname = 'dbseller');              
                                                                                                       
  delete from db_versaoant where not exists (select 1 from db_versao where db30_codver = db31_codver); 
  delete from db_versaousu where not exists (select 1 from db_versao where db30_codver = db32_codver); 
  delete from db_versaocpd where not exists (select 1 from db_versao where db30_codver = db33_codver); 
                                                                                                       
select fc_schemas_dbportal();