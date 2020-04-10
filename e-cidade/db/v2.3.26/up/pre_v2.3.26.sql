/**
 * Arquivo pre (up)
 */


/**
 * TIME B
 */


update db_itensmenu set id_item = 9952 , descricao = 'Ficha financeira' , help = 'Ficha financeira' , funcao = 'mat2_fichafinanceira001.php' , itemativo = '1' , manutencao = '1' , desctec = 'Ficha financeira' , libcliente = 'true' where id_item = 9952;
insert into db_itensmenu values( 9952, 'Ficha financeira', 'Ficha financeira', 'mat2_fichafinanceira001.php', '1', '1', 'Ficha financeira', '1'  );
insert into db_itensfilho (id_item, codfilho) values(9952,1);
delete from db_menu where id_item_filho = 9952;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8787 ,9952 ,19 ,480 );
update db_itensmenu set id_item = 9952 , descricao = 'Ficha financeira' , help = 'Ficha financeira' , funcao = 'mat2_fichafinanceira001.php' , itemativo = '1' , manutencao = '1' , desctec = 'Ficha financeira' , libcliente = 'false' where id_item = 9952;

/* 93465 { */

  create table w_menus_93465 as
  select
    id_item_filho as id_menu,
    (select libcliente from db_itensmenu where db_itensmenu.id_item = db_menu.id_item_filho) as libcliente
    from db_menu
   where id_item = 29
     and modulo = 209
    and id_item_filho not in(3355, 3363, 9068, 3695, 9072, 3558);

  update db_itensmenu set libcliente = true
   where id_item in(select w_menus_93465.id_menu from  w_menus_93465);

  create table w_permissao_93465 as
    select * from db_permissao where id_item in(select w_menus_93465.id_menu from w_menus_93465);
  delete from db_permissao where id_item in(select w_menus_93465.id_menu from w_menus_93465);

  insert into db_itensmenu (id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9954 ,'Rotinas adminstrativas' ,'Rotinas administrativas' ,'' ,'1' ,'1' ,'Rotinas administrativas.' ,'true' );
  insert into db_menu (id_item ,id_item_filho ,menusequencia ,modulo ) values (29, 9954, 256, 209 );

  update db_menu set id_item = 9954 where id_item_filho in(select w_menus_93465.id_menu from w_menus_93465);


  update db_syscampo set tamanho = 10 where codcam in (5220, 6293 );


/* } */


  insert into conhistdoc(c53_coddoc, c53_descr, c53_tipo) values
    (212, 'REGISTRO DE ENTRADA DE MATERIAL VIA RP', 200),
    (213, 'ESTORNO REGISTRO DE ENTRADA DE MATERIAL VIA RP', 201)
  ;

  insert into vinculoeventoscontabeis VALUES(108, 212, 213);


  insert into conhistdoc(c53_coddoc, c53_descr, c53_tipo) values
    (39, 'LIQUIDAÇÃO RP MATERIAL ALMOX', 20),
    (40, 'ESTORNO LIQUIDAÇÃO RP MATERIAL ALMOX', 21)
  ;

  insert into vinculoeventoscontabeis VALUES(109, 39, 40);


/**
 * FIM TIME B
 */



/**
 * Time C
 */

-- Tarefa 92375
insert into db_impressora values (14, 1, 'DARUMA DR700', 'DR700', 'DARUMA');
insert into db_impressora values (15, 1, 'BEMATECH 4200', '4200', 'BEMATECH');
insert into db_modeloimpressao values(2, 4, 14, 'COMPROVANTE DE MEDICAMENTOS PADRAO');
insert into db_modeloimpressao values(3, 4, 15, 'COMPROVANTE DE MEDICAMENTOS PADRAO');


update avaliacaopergunta
   set db103_descricao = 'Dependências Existentes na Escola'
 where db103_sequencial = 3000000;


-- Tarefa 94961
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8325 ,1101027 ,2 ,8481 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8172 ,1101027 ,1 ,8322 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 31 ,1101027 ,177 ,6952 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 3333 ,1101027 ,20 ,6877 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8484 ,1101027 ,1 ,9053 );

update db_menu set menusequencia = 1 where id_item = 31 and modulo = 6952 and id_item_filho = 1101027;
update db_menu set menusequencia = 2 where id_item = 31 and modulo = 6952 and id_item_filho = 7059;
update db_menu set menusequencia = 1 where id_item = 3333 and modulo = 6877 and id_item_filho = 1101027;
update db_menu set menusequencia = 2 where id_item = 3333 and modulo = 6877 and id_item_filho = 6947;
update db_menu set menusequencia = 1 where id_item = 3491 and modulo = 8167 and id_item_filho = 1101027;
update db_menu set menusequencia = 2 where id_item = 3491 and modulo = 8167 and id_item_filho = 8352;
update db_menu set menusequencia = 1 where id_item = 8325 and modulo = 8481 and id_item_filho = 1101027;
update db_menu set menusequencia = 2 where id_item = 8325 and modulo = 8481 and id_item_filho = 8694;
update db_menu set menusequencia = 1 where id_item = 31 and modulo = 1000004 and id_item_filho = 1101027;
update db_menu set menusequencia = 2 where id_item = 31 and modulo = 1000004 and id_item_filho = 8106;
update db_menu set menusequencia = 3 where id_item = 31 and modulo = 1000004 and id_item_filho = 8813;

-- 94091
update db_itensmenu
   set funcao = 'lab4_entregaresultadonovo001.php'
where id_item = 8350;

update db_itensmenu set descricao = 'Emissão/Reemissão de Resultado', help = 'Emissão/Reemissão de Resultado', desctec = 'Emissão/Reemissão de Resultado' where id_item = 8349;


-- 94950
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 3470 ,8451 ,29 ,6952 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 3470 ,8451 ,30 ,1000004 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 3470 ,8451 ,31 ,6877 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 9049 ,8451 ,2 ,9053 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8170 ,8451 ,13 ,8167 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8323 ,8451 ,9 ,8322 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8482 ,8451 ,2 ,8481 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8452 ,4 ,6952 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8452 ,5 ,1000004 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8452 ,6 ,6877 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8452 ,7 ,9053 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8452 ,8 ,8167 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8452 ,9 ,8322 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8452 ,10 ,8481 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8453 ,11 ,6952 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8453 ,12 ,1000004 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8453 ,13 ,6877 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8453 ,14 ,9053 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8453 ,15 ,8167 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8453 ,16 ,8322 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8453 ,17 ,8481 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8454 ,18 ,6952 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8454 ,19 ,1000004 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8454 ,20 ,6877 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8454 ,21 ,9053 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8454 ,22 ,8167 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8454 ,23 ,8322 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8451 ,8454 ,24 ,8481 );

--93766
update db_itensmenu
   set id_item = 1537148 ,
       descricao = 'Inclusão' ,
       help = 'Inclusão de Sau_procedimento' ,
       funcao = 'sau1_sau_procedimento001.php' ,
       itemativo = '1' ,
       manutencao = '1' ,
       desctec = 'Inclusão de Sau_procedimento' ,
       libcliente = 'false'
 where id_item = 1537148;
update db_itensmenu
   set id_item = 1548421 ,
       descricao = 'Exclusão' ,
       help = 'Exclusão de Procedimento' ,
       funcao = 'sau1_sau_procedimento003.php' ,
       itemativo = '1' ,
       manutencao = '1' ,
       desctec = 'Exclusão de Procedimento' ,
       libcliente = 'false'
 where id_item = 1548421;

-- 95325
update db_syscampo
   set nomecam = 'z01_v_mae',
       conteudo = 'varchar(40)',
       descricao = 'Mãe',
       valorinicial = '',
       rotulo = 'Mãe',
       nulo = 'f',
       tamanho = 40,
       maiusculo = 't',
       autocompl = 'f',
       aceitatipo = 0,
       tipoobj = 'text',
       rotulorel = 'Mãe'
 where codcam = 11248;
delete from db_syscampodep where codcam = 11248;
delete from db_syscampodef where codcam = 11248;

update db_syscampo
   set nomecam = 'z01_d_nasc',
       conteudo = 'date',
       descricao = 'Nascimento',
       valorinicial = 'null',
       rotulo = 'Nascimento',
       nulo = 'f',
       tamanho = 10,
       maiusculo = 'f',
       autocompl = 'f',
       aceitatipo = 1,
       tipoobj = 'text',
       rotulorel = 'Nascimento'
 where codcam = 1008859;
delete from db_syscampodep where codcam = 1008859;
delete from db_syscampodef where codcam = 1008859;

-- 64998

-- Aterar o valor default de: P = Horas - Aula
update db_syscampo
  set nomecam      = 'ed31_c_medfreq',
      conteudo     = 'char(1)',
      descricao    = 'D = Freqûencia por Dias Letivos P = Frequência por Horas - Aula',
      valorinicial = '',
      rotulo       = 'Frequência',
      nulo         = 'f',
      tamanho      = 1,
      maiusculo    = 't',
      autocompl    = 'f',
      aceitatipo   = 0,
      tipoobj      = 'select',
      rotulorel    = 'Frequência'
  where codcam     = 1008363;
delete from db_syscampodep where codcam = 1008363;
delete from db_syscampodef where codcam = 1008363;
insert into db_syscampodef values(1008363,'D','DIAS LETIVOS');
insert into db_syscampodef values(1008363,'P','HORAS - AULA');

-- Adicionar campos na basemps
insert into db_syscampo values(20657,'ed34_caracterreprobatorio','bool','Define se disciplina possui Carácter Reprobatório','true','Carácter Reprobatório',1,'f','f','f',5,'text','Carácter Reprobatório');
insert into db_syscampo values(20659,'ed34_disiciplinaglobalizada','bool','Define se é uma Disciplina Globalizada','false', 'Disciplina Globalizada',1,'f','f','f',5,'text','Disciplina Globalizada');
insert into db_syscampo values(20660,'ed34_basecomum','bool','Define se a disciplina pertence a Base Comum Nacional','true', 'Base Comum',1,'f','f','f',5,'text','Base Comum');

delete from db_sysarqcamp where codarq = 1010061;
insert into db_sysarqcamp values(1010061,1008368,1,1000124);
insert into db_sysarqcamp values(1010061,1008393,2,0);
insert into db_sysarqcamp values(1010061,1008369,3,0);
insert into db_sysarqcamp values(1010061,1008370,4,0);
insert into db_sysarqcamp values(1010061,1008372,5,0);
insert into db_sysarqcamp values(1010061,1008371,6,0);
insert into db_sysarqcamp values(1010061,1008373,7,0);
insert into db_sysarqcamp values(1010061,14691,8,0);
insert into db_sysarqcamp values(1010061,20320,9,0);
insert into db_sysarqcamp values(1010061,20657,10,0);
insert into db_sysarqcamp values(1010061,20659,11,0);
insert into db_sysarqcamp values(1010061,20660,12,0);

update db_syscampo set nomecam = 'ed34_i_qtdperiodo', conteudo = 'int4', descricao = 'Quantidade de Horas - Aula', valorinicial = '0', rotulo = 'Quantidade de Horas - Aula', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Quantidade de Horas - Aula' where codcam = 1008372;

-- Adicionar campos na regencia
insert into db_syscampo values(20661,'ed59_caracterreprobatorio','bool','Define se regência possui Carácter Reprobatório','true', 'Carácter Reprobatório',1,'f','f','f',5,'text','Carácter Reprobatório');
insert into db_syscampo values(20662,'ed59_basecomum','bool','Define se regência é uma Base Comum Nacional','true', 'Base Comum',1,'f','f','f',5,'text','Base Comum');

delete from db_sysarqcamp where codarq = 1010084;
insert into db_sysarqcamp values(1010084,1008498,1,1000146);
insert into db_sysarqcamp values(1010084,1008499,2,0);
insert into db_sysarqcamp values(1010084,1008500,3,0);
insert into db_sysarqcamp values(1010084,1008501,4,0);
insert into db_sysarqcamp values(1010084,1008502,5,0);
insert into db_sysarqcamp values(1010084,1008504,6,0);
insert into db_sysarqcamp values(1010084,1008505,7,0);
insert into db_sysarqcamp values(1010084,1008506,8,0);
insert into db_sysarqcamp values(1010084,1008503,9,0);
insert into db_sysarqcamp values(1010084,14692,10,0);
insert into db_sysarqcamp values(1010084,15222,11,0);
insert into db_sysarqcamp values(1010084,20321,12,0);
insert into db_sysarqcamp values(1010084,20661,13,0);
insert into db_sysarqcamp values(1010084,20662,14,0);

update db_syscampo set nomecam = 'ed59_i_qtdperiodo', conteudo = 'int4', descricao = 'Quantidade Horas - Aula', valorinicial = '0', rotulo = 'Quantidade Horas - Aula', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Quantidade Horas - Aula' where codcam = 1008501;

-- Adicionar campos na histmpsdisc
insert into db_syscampo values(20663,'ed65_basecomum','bool','Define se a disciplina é uma Base Comum Nacional','true', 'Base Comum',1,'f','f','f',5,'text','Base Comum');

delete from db_sysarqcamp where codarq = 1010133;
insert into db_sysarqcamp values(1010133,1008779,1,1000210);
insert into db_sysarqcamp values(1010133,1008780,2,0);
insert into db_sysarqcamp values(1010133,1008781,3,0);
insert into db_sysarqcamp values(1010133,1008782,4,0);
insert into db_sysarqcamp values(1010133,1008783,5,0);
insert into db_sysarqcamp values(1010133,1008784,6,0);
insert into db_sysarqcamp values(1010133,1008785,7,0);
insert into db_sysarqcamp values(1010133,1008786,8,0);
insert into db_sysarqcamp values(1010133,1008787,9,0);
insert into db_sysarqcamp values(1010133,14823,10,0);
insert into db_sysarqcamp values(1010133,19694,11,0);
insert into db_sysarqcamp values(1010133,19792,12,0);
insert into db_sysarqcamp values(1010133,20322,13,0);
insert into db_sysarqcamp values(1010133,20663,14,0);

-- Adicionar campo na histmpsdiscfora
insert into db_syscampo values(20664,'ed100_basecomum','bool','Define se disciplina é da Base Comum Nacional','true', 'Base Comum',1,'f','f','f',5,'text','Base Comum');

delete from db_sysarqcamp where codarq = 1010159;
insert into db_sysarqcamp values(1010159,1009020,1,1000232);
insert into db_sysarqcamp values(1010159,1009021,2,0);
insert into db_sysarqcamp values(1010159,1009022,3,0);
insert into db_sysarqcamp values(1010159,1009023,4,0);
insert into db_sysarqcamp values(1010159,1009024,5,0);
insert into db_sysarqcamp values(1010159,1009025,6,0);
insert into db_sysarqcamp values(1010159,1009026,7,0);
insert into db_sysarqcamp values(1010159,1009027,8,0);
insert into db_sysarqcamp values(1010159,1009028,9,0);
insert into db_sysarqcamp values(1010159,14824,10,0);
insert into db_sysarqcamp values(1010159,19695,11,0);
insert into db_sysarqcamp values(1010159,20323,12,0);
insert into db_sysarqcamp values(1010159,20664,13,0);

-- 94022 - BPA MAGNÉTICO
insert into db_syscampo values(20670,'la58_gerado','bool','Verifica se BPA Magnético já foi gerado.','false', 'Gerado',1,'f','f','f',5,'text','Gerado');
delete from db_sysarqcamp where codarq = 3182;
insert into db_sysarqcamp values(3182,18003,1,2087);
insert into db_sysarqcamp values(3182,18004,2,0);
insert into db_sysarqcamp values(3182,18005,3,0);
insert into db_sysarqcamp values(3182,20670,4,0);

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9955 ,'Reabrir Competência' ,'Reabrir Competência' ,'lab4_reabrirfechamento001.php' ,'1' ,'1' ,'Reabrir Competência' ,'true' );
delete from db_menu where id_item_filho = 9955 AND modulo = 8167;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8752 ,9955 ,3 ,8167 );

update db_itensmenu
   set id_item = 8457 , descricao = 'Gerar Arquivo' , help = 'Gerar Arquivo' , funcao = 'lab4_geraarquivobpamagnetico001.php' , itemativo = '1' , manutencao = '1' , desctec = 'bpa magnetico' , libcliente = 'true'
 where id_item = 8457;

update db_itensmenu set libcliente = false where id_item = 6976;
update db_itensmenu set descricao = 'Gerar Arquivo' where id_item = 9825;

 /**
 * FIM Time C
 */


/**
 *  Time Tributário
 */

-- Cadastro de Usuários
insert into db_syscampo values(20639,'datatoken','date','Data da criação do token enviado para o e-mail do usuário','now()::date', 'Data de Criação do token',10,'f','f','f',0,'text','Data de Criação do token');
insert into db_sysarqcamp values(109,20639,9,0);
update db_syscampo set nomecam = 'usuarioativo', conteudo = 'char(1)', descricao = 'Tipos de situação 0 - Inativo 1 - Ativo 2 - Bloqueado 3 - Aguardando ativação', valorinicial = '0', rotulo = 'Situação', nulo = 'f', tamanho = 1, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Situação' where codcam = 573;

-- Skin Default
insert into db_itensmenu values( 9953, 'Manutenção de Parâmetros', 'Manutenção de Parâmetros', 'con4_parametros001.php', '1', '1', 'Manutenção de Parâmetros', '1');
insert into db_itensfilho (id_item, codfilho) values(9953,1008693);
insert into db_menu values(32,9953,450,1);


--94091 - Entrega Resultado
insert into db_syscampo values(20643,'la31_retiradopor','varchar(100)','Quem esta retirando o medicamento.','', 'Retirado por',100,'f','t','f',0,'text','Retirado por');
insert into db_sysarqcamp values(2892,20643,9,0);



/**
 *  Fim Time Tributário
 */

/**
 * TIME B - INICIO
 */
insert into db_sysarquivo values (3718, 'conlancaminstit', 'Tabela de vinculo entre o lançamento e a instituição', 'c02', '2014-05-30', 'Instituição do lançamento', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (32,3718);
insert into db_syscampo values(20640,'c02_sequencial','int4','Sequencial da tabela conlancaminstit','0', 'Sequencial',10,'f','f','f',1,'text','Sequencial');
insert into db_syscampo values(20641,'c02_codlan','int4','Código do lançamento contábil.','0', 'Lançamento contábil',10,'f','f','f',1,'text','Lançamento contábil');
insert into db_syscampo values(20642,'c02_instit','int4','Instituição do lançamento contábil.','0', 'Instituição do lançamento',10,'f','f','f',1,'text','Instituição do lançamento');
delete from db_sysarqcamp where codarq = 3718;
insert into db_sysarqcamp values(3718,20640,1,0);
insert into db_sysarqcamp values(3718,20641,2,0);
insert into db_sysarqcamp values(3718,20642,3,0);
delete from db_sysprikey where codarq = 3718;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3718,20640,1,20640);
delete from db_sysforkey where codarq = 3718 and referen = 0;
insert into db_sysforkey values(3718,20641,1,760,0);
delete from db_sysforkey where codarq = 3718 and referen = 0;
insert into db_sysforkey values(3718,20642,1,83,0);
insert into db_sysindices values(4086,'conlancaminstit_c02_codlan_in',3718,'0');
insert into db_syscadind values(4086,20641,1);
insert into db_sysindices values(4087,'conlancaminstit_c02_instit_in',3718,'0');
insert into db_syscadind values(4087,20642,1);
insert into db_syssequencia values(1000378, 'conlancaminstit_c02_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000378 where codarq = 3718 and codcam = 20640;


/**
 * TIME B - FIM
 */



/**
 *  Time Folha
 */

  insert into db_sysarquivo values (3719, 'rhpessoalmovcontabancaria', 'Tabela de vinculo da conta bancaria do pessoal.', 'rh138', '2014-06-05', 'Cadastro de conta bancaria pessoal', 0, 'f', 'f', 'f', 'f' );
  insert into db_sysarqmod values (28,3719);
  insert into db_syscampo values(20644,'rh138_sequencial','int4','Sequencial da tabela rhpessoalmovcontabancaria','0', 'Sequencial',10,'f','f','f',1,'text','Sequencial');
  insert into db_syscampo values(20645,'rh138_rhpessoalmov','int4','Chave estrangeira da tabela rhpessoalmov','0', 'Pessoalmov',10,'f','f','f',1,'text','Pessoalmov');
  insert into db_syscampo values(20646,'rh138_contabancaria','int4','Chave estrangeira da tabela contabancaria.','0', 'Conta Bancaria',10,'f','f','f',1,'text','Conta Bancaria');
  insert into db_syscampo values(20647,'rh138_instit','int4','Insituição para chave estrangeira da rhpessoalmov.','0', 'Insituição',10,'f','f','f',1,'text','Insituição');
  delete from db_sysarqcamp where codarq = 3719;
  insert into db_sysarqcamp values(3719,20644,1,0);
  insert into db_sysarqcamp values(3719,20645,2,0);
  insert into db_sysarqcamp values(3719,20646,3,0);
  insert into db_sysarqcamp values(3719,20647,4,0);
  delete from db_sysprikey where codarq = 3719;
  insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3719,20644,1,20644);
  delete from db_sysforkey where codarq = 3719;
  insert into db_sysforkey values(3719,20645,1,1158,0);
  insert into db_sysforkey values(3719,20647,2,1158,0);
  insert into db_sysforkey values(3719,20646,1,2740,0);
  insert into db_syssequencia values(1000379, 'rhpessoalmovcontabancaria_rh138_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
  update db_sysarqcamp set codsequencia = 1000379 where codarq = 3719 and codcam = 20644;
  insert into db_sysindices values(4088,'rhpessoalmovcontabancaria_rhpessoalmov_in',3719,'0');
  insert into db_syscadind values(4088,20645,1);
  insert into db_sysindices values(4089,'rhpessoalmovcontabancaria_contabancaria_in',3719,'0');
  insert into db_syscadind values(4089,20646,1);
  insert into db_sysindices values(4090,'rhpessoalmovcontabancaria_rhpessoalmov_contabancaria_in',3719,'0');
  insert into db_syscadind values(4090,20645,1);
  insert into db_syscadind values(4090,20646,2);
  update db_sysindices set nomeind = 'rhpessoalmovcontabancaria_rhpessoalmov_contabancaria_in',campounico = '1' where codind = 4090;
  delete from db_syscadind where codind = 4090;
  insert into db_syscadind values(4090,20645,1);
  insert into db_syscadind values(4090,20646,2);

  insert into db_sysarquivo values (3721, 'pensaocontabancaria', 'Tabela de ligao, pensao com contabancaria', 'rh139', '2014-06-23', 'pensaocontabancaria', 0, 'f', 't', 't', 't' );
  insert into db_sysarqmod values (28,3721);
  insert into db_syscampo values(20671,'rh139_sequencial','int4','Sequencial da tabela pensaocontabancaria','0', 'Sequencial',10,'f','f','f',1,'text','Sequencial');
  insert into db_syscampo values(20672,'rh139_regist','int4','Chave estrangeira da tabela penso.','0', 'Regist',10,'f','f','f',1,'text','Regist');
  insert into db_syscampo values(20673,'rh139_numcgm','int4','Chave estrangeira da tabela pensao','0', 'Nmero CGM',10,'f','f','f',1,'text','Nmero CGM');
  insert into db_syscampo values(20675,'rh139_anousu','int4','Campo ano, chave estrangeira da tabela pensao.','0', 'Ano',10,'f','f','f',1,'text','Ano');
  insert into db_syscampo values(20676,'rh139_mesusu','int4','Campo mes, Chave estrangeira da tabela pensao','0', 'Ms',10,'f','f','f',1,'text','Ms');
  insert into db_syscampo values(20677,'rh139_contabancaria','int4','Chave estrangeira da tabela contabancria','0', 'Conta Bancria',10,'f','f','f',1,'text','Conta Bancria');
  delete from db_sysarqcamp where codarq = 3721;
  insert into db_sysarqcamp values(3721,20671,1,0);
  insert into db_sysarqcamp values(3721,20672,2,0);
  insert into db_sysarqcamp values(3721,20673,3,0);
  insert into db_sysarqcamp values(3721,20675,4,0);
  insert into db_sysarqcamp values(3721,20676,5,0);
  insert into db_sysarqcamp values(3721,20677,6,0);
  delete from db_sysprikey where codarq = 3721;
  insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3721,20671,1,20671);
  delete from db_sysforkey where codarq = 3721 and referen = 0;
  insert into db_sysforkey values(3721,20675,1,570,0);
  insert into db_sysforkey values(3721,20676,2,570,0);
  insert into db_sysforkey values(3721,20672,3,570,0);
  insert into db_sysforkey values(3721,20673,4,570,0);
  delete from db_sysforkey where codarq = 3721 and referen = 0;
  insert into db_sysforkey values(3721,20677,1,2740,0);
  insert into db_syssequencia values(1000381, 'pensaocontabancaria_rh139_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
  update db_sysarqcamp set codsequencia = 1000381 where codarq = 3721 and codcam = 20671;
  insert into db_sysindices values(4092,'pensaocontabancaria_regist_contabancaria_in',3721,'1');
  insert into db_syscadind values(4092,20672,1);
  insert into db_syscadind values(4092,20677,2);
  insert into db_sysindices values(4093,'pensaocontabancaria_regist_in',3721,'0');
  insert into db_syscadind values(4093,20672,1);
  insert into db_sysindices values(4094,'pensaocontabancaria_numcgm_in',3721,'0');
  insert into db_syscadind values(4094,20673,1);
  insert into db_sysindices values(4095,'pensaocontabancaria_contabancaria_in',3721,'0');
  insert into db_syscadind values(4095,20677,1);
  delete from db_sysindices where codind = 4092;
  delete from db_syscadind where  codind = 4092;
  insert into db_sysindices values(4096,'pensaocontabancaria_regist_numcgm_anousu_mesusu_contabancaria_in',3721,'1');
  insert into db_syscadind values(4096,20672,1);
  insert into db_syscadind values(4096,20673,2);
  insert into db_syscadind values(4096,20675,3);
  insert into db_syscadind values(4096,20676,4);
  insert into db_syscadind values(4096,20677,5);

  update db_syscampo set nomecam = 'db90_codban',
                         conteudo = 'varchar(10)',
                         descricao = 'Código do Banco FEBRABAN',
                         valorinicial = '',
                         rotulo = 'Código do Banco FEBRABAN',
                         nulo = 'f',
                         tamanho = 10,
                         maiusculo = 'f',
                         autocompl = 'f',
                         aceitatipo = 1,
                         tipoobj = 'text',
                         rotulorel = 'Código do Banco FEBRABAN'
   where codcam = 7148;
  delete from db_syscampodep where codcam = 7148;
  delete from db_syscampodef where codcam = 7148;

  update db_syscampo set nomecam = 'db90_digban',
                         conteudo = 'varchar(2)',
                         descricao = 'Digito Verificador do Codigo do Banco do Banco a ser apresentado nos boletos bancários',
                         valorinicial = '',
                         rotulo = 'DV do Banco',
                         nulo = 't',
                         tamanho = 2,
                         maiusculo = 't',
                         autocompl = 'f',
                         aceitatipo = 0,
                         tipoobj = 'text',
                         rotulorel = 'DV do Banco'
  where codcam = 11724;
delete from db_syscampodep where codcam = 11724;
delete from db_syscampodef where codcam = 11724;

update db_syscampo set nomecam = 'db89_sequencial',
                       conteudo = 'int4',
                       descricao = 'Sequencial',
                       valorinicial = '0',
                       rotulo = 'Sequencial',
                       nulo = 'f',
                       tamanho = 10,
                       maiusculo = 'f',
                       autocompl = 'f',
                       aceitatipo = 1,
                       tipoobj = 'text',
                       rotulorel = 'Sequencial'
where codcam = 12534;
delete from db_syscampodep where codcam = 12534;
delete from db_syscampodef where codcam = 12534;

update db_syscampo set nomecam = 'db83_sequencial',
                       conteudo = 'int4',
                       descricao = 'Codigo sequencial da conta bancaria',
                       valorinicial = '0',
                       rotulo = 'Sequencial',
                       nulo = 'f',
                       tamanho = 10,
                       maiusculo = 'f',
                       autocompl = 'f',
                       aceitatipo = 1,
                       tipoobj = 'text',
                       rotulorel = 'Sequencial'
where codcam = 15622;
delete from db_syscampodep where codcam = 15622;
delete from db_syscampodef where codcam = 15622;

update db_syscampo set nomecam = 'db83_descricao',
                       conteudo = 'varchar(100)',
                       descricao = 'Descrição da Conta',
                       valorinicial = '',
                       rotulo = 'Descrição',
                       nulo = 'f',
                       tamanho = 100,
                       maiusculo = 't',
                       autocompl = 'f',
                       aceitatipo = 0,
                       tipoobj = 'text',
                       rotulorel = 'Descrição'
where codcam = 15623;
delete from db_syscampodep where codcam = 15623;
delete from db_syscampodef where codcam = 15623;

update db_syscampo set nomecam = 'db83_bancoagencia',
                       conteudo = 'int4',
                       descricao = 'Codigo da Agencia',
                       valorinicial = '0',
                       rotulo = 'Agência',
                       nulo = 'f',
                       tamanho = 10,
                       maiusculo = 'f',
                       autocompl = 'f',
                       aceitatipo = 1,
                       tipoobj = 'text',
                       rotulorel = 'Agência'
where codcam = 15624;
delete from db_syscampodep where codcam = 15624;
delete from db_syscampodef where codcam = 15624;

update db_syscampo set nomecam = 'db83_conta',
                       conteudo = 'varchar(15)',
                       descricao = 'Conta',
                       valorinicial = '',
                       rotulo = 'Conta',
                       nulo = 'f',
                       tamanho = 15,
                       maiusculo = 'f',
                       autocompl = 'f',
                       aceitatipo = 1,
                       tipoobj = 'text',
                       rotulorel = 'Conta'
where codcam = 15625;
delete from db_syscampodep where codcam = 15625;
delete from db_syscampodef where codcam = 15625;

update db_syscampo set nomecam = 'db83_dvconta',
                       conteudo = 'varchar(1)',
                       descricao = 'Digito da Conta',
                       valorinicial = '',
                       rotulo = 'DV da Conta',
                       nulo = 'f',
                       tamanho = 1,
                       maiusculo = 't',
                       autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'DV da Conta' where codcam = 15626;
delete from db_syscampodep where codcam = 15626;
delete from db_syscampodef where codcam = 15626;

update db_syscampo set nomecam = 'db83_tipoconta',
                       conteudo = 'int4',
                       descricao = 'Tipo Conta',
                       valorinicial = '0',
                       rotulo = 'Tipo de Conta',
                       nulo = 't',
                       tamanho = 1,
                       maiusculo = 'f',
                       autocompl = 'f',
                       aceitatipo = 1,
                       tipoobj = 'text',
                       rotulorel = 'Tipo de Conta'
where codcam = 15643;
delete from db_syscampodep where codcam = 15643;
delete from db_syscampodef where codcam = 15643;
insert into db_syscampodef values(15643,'1','Conta');
insert into db_syscampodef values(15643,'2','Conta Poupança');

update db_syscampo set nomecam = 'db89_codagencia',
                       conteudo = 'varchar(5)',
                       descricao = 'Código da Agência',
                       valorinicial = '',
                       rotulo = 'Agência',
                       nulo = 'f',
                       tamanho = 5,
                       maiusculo = 't',
                       autocompl = 'f',
                       aceitatipo = 0,
                       tipoobj = 'text',
                       rotulorel = 'Agência'
where codcam = 12536;
delete from db_syscampodep where codcam = 12536;
delete from db_syscampodef where codcam = 12536;

update db_syscampo set nomecam = 'db89_digito',
                       conteudo = 'varchar(2)',
                       descricao = 'Digito',
                       valorinicial = '',
                       rotulo = 'DV da Agência',
                       nulo = 'f',
                       tamanho = 2,
                       maiusculo = 't',
                       autocompl = 'f',
                       aceitatipo = 0,
                       tipoobj = 'text',
                       rotulorel = 'DV da Agência'
where codcam = 12537;
delete from db_syscampodep where codcam = 12537;
delete from db_syscampodef where codcam = 12537;  
update db_syscampo set rotulo = 'Descrição' where codcam = '7105';


/**
 *  Fim Time Folha
 */

/**
 * Time Tributário
 */

/**
 * Inicio Tarefa 83872
 */

insert into db_syscampo values(20656,'it24_cgmobrigatorio','bool','Campo para ativar validação de CGM.','false', 'CGM Obrigatório Transmitente/Adquirente',1,'f','f','f',5,'text','CGM Obrigatório Transmitente/Adquirente');
insert into db_sysarqcamp values(2362,20656,13,0);
insert into db_syscampo values(20658,'it01_percentualareatransmitida','float8','Campo para armazenar o percentual da área transmitida.','0', 'Percentual Área Transmitida',10,'f','f','f',4,'text','Percentual Área Transmitida');
insert into db_sysarqcamp values(792,20658,18,0);
update db_syscampo set conteudo = 'float8' where codcam = 13541;
update db_syscampo set conteudo = 'float8' where codcam = 13542;

/**
 * Fim Tarefa 83872
 */

/**
 * Inicio Tarefa 52990
 */

insert into db_syscampo values(20669,'y32_templatealvarasanitariopermanente','int4','Template Padrão Alvará Sanitário Permanente','0', 'Template Padrão Alvará Sanitário Permanente',10,'t','f','f',1,'text','Template Padrão Alvará San. Permanente');
insert into db_syscampo values(20668,'y32_templatealvarasanitarioprovisorio','int4','Template Padrão Alvará Sanitário Provisório','0', 'Template Padrão Alvará Sanitário Provisório',10,'t','f','f',1,'text','Template Padrão Alvará San. Provisório');
insert into db_sysarqcamp values(1103,20669,21,0);
insert into db_sysarqcamp values(1103,20668,22,0);
insert into db_documentotemplatetipo(db80_sequencial, db80_descricao) values(47, 'ALVARÁ SANITÁRIO');
insert into db_documentotemplatepadrao( db81_sequencial ,db81_templatetipo ,db81_nomearquivo ,db81_descricao ) values ( 50 ,47 ,'documentos/templates/fiscal/alvara_sanitario.sxw' ,'ALVARÁ SANITÁRIO' );

/**
 * Fim Tarefa 52990
 */

/**
 * Inicio Tarefa 92906
 */

insert into db_syscampo values(20666,'it16_id_usuario','int4','Campo para identificar o usuário que está cadastrando as informações.','0', 'Identificador do Usuário',10,'f','f','f',1,'text','Identificador do Usuário');
insert into db_sysarqcamp values(906,20666,4,0);
insert into db_sysforkey values(906,20666,1,109,0);
insert into db_sysindices values(4091,'itbicancela_id_usuario_in',906,'0');
insert into db_syscadind values(4091,20666,1);

/**
 * Fim Tarefa 92906
 */

/**
 * Fim Time Tributário
 */


/** ACERTOS POS FECHAMENTO **/
update db_itensmenu set libcliente = true where id_item = 9952;

update db_itensmenu set funcao = 'lab4_fechacompetencia001.php' where id_item = 8456;
