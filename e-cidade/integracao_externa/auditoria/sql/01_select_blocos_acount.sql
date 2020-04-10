-- SELECT PARA MIGRACAO
-- Á
select x.id_acount,
       trim(c.nomemod) as esquema,
       trim(a.nomearq) as tabela,
       case x.actipo
         when 'A' then 'U'
         when 'E' then 'D'
         else 'I'
       end                    as operacao,
       'db_auditoria_'||
         trim(to_char(extract(year  from to_timestamp(y.datahr)), '0000')) || 
         trim(to_char(extract(month from to_timestamp(y.datahr)), '00')) as particao,
       fc_xid_current()       as transacao,
       to_timestamp(y.datahr) as datahora_sessao,
       to_timestamp(y.datahr) as datahora_servidor,
       extract(year from to_timestamp(y.datahr)) || extract(month from to_timestamp(y.datahr)) as anomes,
       z.login,
       pkey_nome_campo,
       pkey_valor,
       --array_accum(quote_literal(trim(w.nomecam))) as mudancas_nome_campo,
       array_accum((trim(w.nomecam))) as mudancas_nome_campo,

       --array_accum( quote_literal(case x.actipo when 'E' then y.contatu else y.contant end) ) as mudancas_valor_antigo,
       array_accum( nullif((case x.actipo when 'E' then y.contatu else y.contant end), '') ) as mudancas_valor_antigo,
       --array_accum( quote_literal(case x.actipo when 'E' then y.contant else y.contatu end) ) as mudancas_valor_novo,
       array_accum( nullif((case x.actipo when 'E' then y.contant else y.contatu end), '') ) as mudancas_valor_novo,

       l.codsequen,
       (select min(i.id_instit)
          from db_userinst i
         where i.id_usuario = y.id_usuario) as instit
  from (select id_acount,
               actipo,
               array_accum(distinct trim(nomecam)) as pkey_nome_campo,
               array_accum(distinct campotext)     as pkey_valor
          from only db_acountkey_migra a
               join db_syscampo b on b.codcam = a.id_codcam
         /*where a.id_acount between {$acount_ini} and {$acount_fim}*/
         where a.id_acount = $1
         group by id_acount, actipo) as x
       join db_acount_migra y  on y.id_acount   =  x.id_acount
                              and trim(contant) <> trim(contatu)
       join db_syscampo   w on w.codcam     = y.codcam
       join db_sysarquivo a on a.codarq     = y.codarq
       join db_sysarqmod  b on b.codarq     = y.codarq
       join db_sysmodulo  c on c.codmod     = b.codmod
       join db_usuarios   z on z.id_usuario = y.id_usuario
       left join db_acountacesso_migra l on l.id_acount = y.id_acount
 group by 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 16, 17;

