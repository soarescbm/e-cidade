---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO FOLHA ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
TRUNCATE avaliacaoperguntadb_formulas;
DELETE FROM db_formulas WHERE db148_nome = 'CODIGO_CGM' OR db148_nome LIKE 'ESOCIAL_%';

--Menus para formulári de preenchimento das informações do empregador
delete from db_menu where id_item_filho = 10244 AND modulo = 10216;
delete from db_itensmenu where id_item = 10244;

delete from db_sysforkey where codarq = 3943;
delete from db_sysprikey where codarq = 3943;
delete from db_sysarqcamp where codarq = 3943;
delete from db_syssequencia where codsequencia = 1000578;

delete from db_syscampo where codcam in (21904, 21905, 21906);

delete from db_sysarqarq where codarq = 3943;
delete from db_sysarqmod where codarq = 3943;
delete from db_sysarquivo where codarq = 3943;

delete from avaliacaoperguntaopcao where db104_sequencial between 3001274 and 3001369;
delete from avaliacaopergunta      where db103_sequencial between 3000375 and 3000417;
delete from avaliacaogrupopergunta where db102_avaliacao = 3000009;
delete from avaliacao              where db101_sequencial= 3000009;
delete from db_menu where id_item_filho =  437509 and id_item = 2458 and modulo = 952;
---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO SAÚDE ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
delete from db_itensmenu    where id_item = 10239;
delete from db_sysarqcamp   where codarq in (3937,3938);

delete from db_sysforkey    where codcam in (21871, 21872, 21873, 21874, 21875, 21876);
delete from db_sysprikey    where codcam in (21871, 21872, 21873, 21874, 21875, 21876);

delete from db_sysprikey    where codcam in (21871, 21872, 21873, 21874, 21875, 21876);
delete from db_sysindices   where codarq in (3937,3938);
delete from db_sysforkey    where codcam in (21871, 21872, 21873, 21874, 21875, 21876);
delete from db_syscadind    where codcam in (21871, 21872, 21873, 21874, 21875, 21876);

delete from db_syssequencia where codsequencia in (1000571,1000572);
delete from db_syscampodep  where codcam in (21871, 21872, 21873, 21874, 21875, 21876);
delete from db_syscampo     where codcam in (21871, 21872, 21873, 21874, 21875, 21876);
delete from db_sysarqmod    where codarq in (3937,3938);
delete from db_sysarquivo   where codarq in (3937,3938);

delete from db_menu where id_item_filho in (10239, 1045399);

insert into db_menu(id_item, id_item_filho, menusequencia, modulo )
  values
  (8170, 1045399, 14, 8167   ),
  (8323, 1045399, 10, 8322   ),
  (8482, 1045399, 3,  8481   ),
  (3470, 1045399, 1,  6952   ),
  (3470, 1045399, 5,  1000004);

delete from caddocumentoatributo where db45_caddocumento in( 3000000, 3000001, 3000002, 3000003, 3000004, 3000005 );
delete from caddocumento         where db44_sequencial   in( 3000000, 3000001, 3000002, 3000003, 3000004, 3000005 );
delete from cadtipodocumento     where db123_sequencial = 3;

delete from db_sysarqcamp where codarq = 1010144 and codcam = 21901;
delete from db_syscampo   where codcam = 21901;

update db_syscampo set nomecam = 'z01_v_cxpostal', conteudo = 'varchar(20)', descricao = 'Caixa Postal', valorinicial = '', rotulo = 'Caixa Postal', nulo = 't', tamanho = 20, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Caixa Postal' where codcam = 11209;

---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO FINANCEIRO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
delete from db_sysforkey where codarq in (3939, 3940, 3941, 3942);
delete from db_sysprikey where codarq in (3939, 3940, 3941, 3942);
delete from db_syssequencia where codsequencia in (1000574, 1000575, 1000576, 1000577);
delete from db_sysarqcamp where codarq in (3939, 3940, 3941, 3942);
delete from db_sysarqcamp where codcam in (21895, 21896, 21897, 21898, 21899, 21900);
delete from db_syscampodef where codcam = 21895;
delete from db_syscampo where codcam in (21877, 21878, 21879, 21883, 21885, 21886, 21887, 21888, 21889, 21890, 21891,21892, 21893, 21894,
                                         21895, 21896, 21897, 21898, 21899, 21900);
delete from db_sysarqmod where codmod = 38 and codarq in (3939, 3940, 3941, 3942);
delete from db_sysarquivo where codarq in (3939, 3940, 3941, 3942);
delete from db_menu where id_item_filho = 10240 AND modulo = 398;
delete from db_menu where id_item_filho = 10241 AND modulo = 398;
delete from db_menu where id_item_filho = 10242 AND modulo = 398;
delete from db_menu where id_item_filho = 10243 AND modulo = 398;
delete from db_itensmenu where id_item = 10240;
delete from db_itensmenu where id_item = 10241;
delete from db_itensmenu where id_item = 10242;
delete from db_itensmenu where id_item = 10243;
delete from db_itensmenu where id_item = 10245;

delete from db_menu where id_item_filho = 10246 AND modulo = 381;
delete from db_itensmenu where id_item = 10246;


select fc_executa_ddl('
  delete from db_sysforkey where codarq = 3944;
  delete from db_sysprikey where codarq = 3944;
  delete from db_sysindices where codarq = 3944;
  delete from db_syscadind where codcam in (21907, 21908, 21909);
  delete from db_syssequencia where codsequencia in (1000579);
  delete from db_sysarqcamp where codarq in (3944);
  delete from db_sysarqcamp where codcam in (21907, 21908, 21909);
  delete from db_syscampodef where codcam in (21907, 21908, 21909);
  delete from db_syscampo where codcam in (21907, 21908, 21909);
  delete from db_sysarqmod where codmod = 4 and codarq in (3944);
  delete from db_sysarquivo where codarq in (3944);
');