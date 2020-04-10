
------------------------------------------------------------------------------------
---------------------------------- TIME C ------------------------------------------
------------------------------------------------------------------------------------
delete from avaliacaoperguntaopcaolayoutcampo where ed313_sequencial in (847, 848, 849, 850, 851, 852, 853, 854, 855, 856, 857, 858, 859, 860, 861, 862, 863, 864, 865, 866, 867, 868, 869, 871, 872, 873, 874, 875, 876, 877, 878, 879, 880, 881, 882, 883, 884, 885, 886, 887, 888, 889, 890, 891, 892, 893, 894, 895, 896, 897, 898, 899, 900, 901, 902, 903, 904, 905, 906, 907, 908, 909, 910, 911, 912, 913, 914, 915, 916, 917, 918, 919, 922, 923, 924, 925, 926, 927, 928, 929, 930, 931, 932, 933, 934, 935, 936, 937, 938, 939, 940, 941, 942, 943, 944, 945, 946, 947, 948, 949, 950, 951, 952, 953, 954, 955, 956, 957, 958, 959);
delete from db_layoutcampos where db52_layoutlinha in (734, 735, 736, 737, 738, 739, 740, 741, 742, 743);
delete from db_layoutlinha  where db51_layouttxt = 226;
delete from db_layouttxt    where db50_codigo    = 226;

-- Estrutura dicionario de dados
delete from db_syscadind   where codind in (4183, 4184, 4185, 4186, 4187, 4188, 4189, 4190);
delete from db_sysindices  where codind in (4183, 4184, 4185, 4186, 4187, 4188, 4189, 4190);
delete from db_sysforkey   where codarq = 1010045 and codcam = 21056;
delete from db_sysforkey   where codarq = 2457    and codcam = 21111;
delete from db_sysforkey   where codarq in (3792, 3793, 3794, 3795, 3796);
delete from db_sysprikey   where codarq in (3792, 3793, 3794, 3795, 3796);
delete from db_sysarqcamp  where codcam in (21044, 21047, 21048, 21050, 21051, 21052, 21053, 21056, 21058, 21059, 21060, 21061, 21065, 21066, 21067, 21068, 21071, 21072, 21073, 21074, 21111, 21121, 21122, 21123, 21124 );
delete from db_syscampodef where codcam in (21044, 21047, 21048, 21050, 21051, 21052, 21053, 21056, 21058, 21059, 21060, 21061, 21065, 21066, 21067, 21068, 21071, 21072, 21073, 21074, 21111, 21121, 21122, 21123, 21124 );
delete from db_syscampo    where codcam in (21044, 21047, 21048, 21050, 21051, 21052, 21053, 21056, 21058, 21059, 21060, 21061, 21065, 21066, 21067, 21068, 21071, 21072, 21073, 21074, 21111, 21121, 21122, 21123, 21124 );

delete from db_syssequencia where codsequencia in (1000447, 1000448, 1000449, 1000450, 1000451);
delete from db_sysarqmod where codarq in (3792, 3793, 3794, 3795, 3796);
delete from db_sysarquivo where codarq in (3792, 3793, 3794, 3795, 3796);

delete from db_sysprikey where codarq = 2413;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(2413,13780,1,13780);


update db_syscampo set nomecam = 'ed266_c_regular', conteudo = 'char(1)', descricao = 'Regular', valorinicial = '', rotulo = 'Regular', nulo = 'f', tamanho = 1, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Regular' where codcam = 13782;
update db_syscampo set nomecam = 'ed266_c_especial', conteudo = 'char(1)', descricao = 'Especial', valorinicial = '', rotulo = 'Especial', nulo = 'f', tamanho = 1, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Especial' where codcam = 13783;
update db_syscampo set nomecam = 'ed266_c_eja', conteudo = 'char(1)', descricao = 'EJA', valorinicial = '', rotulo = 'EJA', nulo = 'f', tamanho = 1, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'EJA' where codcam = 13784;

delete from avaliacaoperguntaopcao where db104_sequencial = 3000579;

-- tipohoratrabalho
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
     values ( 21032 ,'ed128_escola' ,'int4' ,'Escola vinculada' ,'' ,'Escola' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Escola' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia )
     values ( 3789 ,21032 ,6 ,0 );

insert into db_sysindices values(4170,'tipohoratrabalho_descricao_escola_in',3789,'1');
insert into db_sysindices values(4171,'tipohoratrabalho_abreviatura_escola_in',3789,'1');
insert into db_syscadind values(4170,21028,1);
insert into db_syscadind values(4170,21032,2);
insert into db_syscadind values(4171,21029,1);
insert into db_syscadind values(4171,21032,2);
insert into db_sysforkey values(3789,21032,1,1010031,0);
delete from db_sysindices  where codind in (4202, 4203);
delete from db_syscadind   where codind in (4202, 4203);

update db_menu set modulo = 1100747 where id_item_filho = 10054 AND modulo = 7159;

-- tamanho nome
update db_syscampo set nomecam = 'z01_v_nome',  conteudo = 'varchar(40)', tamanho = 40 where codcam = 1008845;
update db_syscampo set nomecam = 'z01_v_mae',   conteudo = 'varchar(40)', tamanho = 40 where codcam = 11248;
update db_syscampo set nomecam = 'z01_c_pis',   conteudo = 'char(10)',    tamanho = 10 where codcam = 11654;
update db_syscampo set nomecam = 's128_v_nome', conteudo = 'varchar(40)', tamanho = 40 where codcam = 15475;
update db_syscampo set nomecam = 'z01_v_email', conteudo = 'varchar(40)', tamanho = 40 where codcam = 1008858;

-- campo cnpj na unidade
delete from db_sysarqcamp where codcam = 21136;
delete from db_syscampo   where codcam = 21136;


-- consulta pedido tfd
delete from db_menu      where id_item_filho = 10062 AND modulo = 8322;
delete from db_itensmenu where id_item = 10062;

-- Label dos campos da UPS
update db_syscampo set nomecam = 'sd02_i_cidade', conteudo = 'int4', descricao = 'Código da Cidade IBGE', valorinicial = '0', rotulo = 'Cod. IBGE', nulo = 't', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Cod. IBGE' where codcam = 100046;
update db_syscampo set nomecam = 'sd02_i_regiao', conteudo = 'int4', descricao = 'Código da região da Unidade', valorinicial = '0', rotulo = 'Cod. Região', nulo = 't', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Cod. Região' where codcam = 100045;
update db_syscampo set nomecam = 'sd02_i_distrito', conteudo = 'int4', descricao = 'Código do distrito da Unidade', valorinicial = '0', rotulo = 'Cod. Distrito', nulo = 't', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Cod. Distrito' where codcam = 100044;
update db_syscampo set nomecam = 'sd02_v_microreg', conteudo = 'varchar(6)', descricao = 'Código da Microregião de Saúde', valorinicial = '', rotulo = 'Micror Região', nulo = 't', tamanho = 6, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Micror Região' where codcam = 11390;
update db_syscampo set nomecam = 'sd02_v_distadmin', conteudo = 'varchar(4)', descricao = 'Código do Módulo Assistencial (Conforme o plano Diretor de Regionalização do Estado/Município).', valorinicial = '', rotulo = 'Módulo Assitencial', nulo = 't', tamanho = 4, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Módulo Assitencial' where codcam = 11392;

delete from db_menu where id_item_filho = 10063 AND modulo = 8322;
delete from db_itensmenu where id_item = 10063;

delete from db_menu where id_item_filho = 10064 AND modulo = 8322;
delete from db_itensmenu where id_item = 10064;

delete from db_sysarqcamp  where codarq = 1010091;
delete from db_syscampo    where codcam = 21140;

------------------------------------------------------------------------------------
------------------------------ FIM TIME C ------------------------------------------
------------------------------------------------------------------------------------


-------------------------------
------ INÍCIO TIME FOLHA ------
-------------------------------
--Desfazendo alterações na tabela rhpreponto excluindo campo, sequencia e chave primária
delete from db_sysarqcamp where codarq = 3766;
insert into db_sysarqcamp values(3766,20923,1,0);
insert into db_sysarqcamp values(3766,20924,2,0);
insert into db_sysarqcamp values(3766,20925,3,0);
insert into db_sysarqcamp values(3766,20926,4,0);
insert into db_sysarqcamp values(3766,20927,5,0);
insert into db_sysarqcamp values(3766,20928,6,0);
delete from db_syssequencia where codsequencia = 1000455;
delete from db_sysprikey where codarq = 3766;
delete from db_syscampo where codcam = 21132;
delete from db_syscampo where codcam = 21107;

delete from db_syscampodep where codcam = 21100;

--Excluindo indices
delete from db_syscadind where codind = 4191;
delete from db_syscadind where codind = 4197;
delete from db_syscadind where codind = 4205;
delete from db_sysindices where codind = 4191;
delete from db_sysindices where codind = 4197;
delete from db_sysindices where codind = 4205;

--Excluindo chaves estrangeiras
delete from db_sysforkey where codarq = 3801;
delete from db_sysforkey where codarq = 3798;
delete from db_sysforkey where codarq = 3804;

--Excluindo chaves primárias
delete from db_sysprikey where codarq = 3798;
delete from db_sysprikey where codarq = 3801;
delete from db_sysprikey where codarq = 3804;

--Excluindo sequencias
delete from db_syssequencia where codsequencia = 1000452;
delete from db_syssequencia where codsequencia = 1000457;
delete from db_syssequencia where codsequencia = 1000461;

--Excluindo valor default dos campos
delete from db_syscampodef where codcam = 21100 ;

--Excluindo vinculações dos campos à tabela
delete from db_sysarqcamp where codarq = 3798;
delete from db_sysarqcamp where codarq = 3801;
delete from db_sysarqcamp where codarq = 3804;

--Excluindo campos da tabela
delete from db_syscampo where codcam = 21100;
delete from db_syscampo where codcam = 21097;
delete from db_syscampo where codcam = 21095;
delete from db_syscampo where codcam = 21091;
delete from db_syscampo where codcam = 21089;
delete from db_syscampo where codcam = 21125;
delete from db_syscampo where codcam = 21126;
delete from db_syscampo where codcam = 21117;
delete from db_syscampo where codcam = 21116;
delete from db_syscampo where codcam = 21114;
delete from db_syscampo where codcam = 21131;
delete from db_syscampo where codcam = 21130;
delete from db_syscampo where codcam = 21129;

--Exclindo tabelas
delete from db_sysarqmod where codmod = 28 and codarq = 3798;
delete from db_sysarqmod where codmod = 28 and codarq = 3801;
delete from db_sysarqmod where codmod = 28 and codarq = 3804;
delete from db_sysarquivo where codarq = 3798;
delete from db_sysarquivo where codarq = 3801;
delete from db_sysarquivo where codarq = 3804;

----------- Menus para a rotina de processamento de registros do ponto em lote -----------------
--Desvincúla os itens de menu ao menu
delete from db_menu where id_item = 10059 and id_item_filho = 10061 AND modulo = 952;
delete from db_menu where id_item = 10059 and id_item_filho = 10060 AND modulo = 952;
delete from db_menu where id_item = 1818  and id_item_filho = 10059 AND modulo = 952;
--Exclui itens de menu
delete from db_itensmenu where id_item = 10061;
delete from db_itensmenu where id_item = 10060;
delete from db_itensmenu where id_item = 10059;
-------------------------------
------- FIM TIME FOLHA --------
-------------------------------


------------------------------------------------------------------------------------
------------------------------ TRIBUTARIO ------------------------------------------
------------------------------------------------------------------------------------

delete from db_menu where id_item_filho = 10056;
delete from db_menu where id_item = 10056;
delete from db_itensmenu where id_item in (10056, 10057, 10058);
delete from db_syssequencia where codsequencia in (1000453, 1000454, 1000456, 1000458, 1000459);
delete from db_syscadind   where codind in (4192, 4193, 4194, 4195, 4196, 4198, 4199, 4201);
delete from db_sysindices  where codind in (4192, 4193, 4194, 4195, 4196, 4198, 4199, 4201);
delete from db_sysforkey   where codarq in (3791, 3797, 3799, 3800, 3802);
delete from db_sysprikey   where codarq in (3791, 3797, 3799, 3800, 3802);
delete from db_sysarqcamp  where codarq in (3791, 3797, 3799, 3800, 3802);
delete from db_syscampodef where codcam in (21049,21054,21055,21057,21062,21063,21064,21069,21070,21075,21076);
delete from db_syscampo    where codcam in (21049,21054,21055,21057,21062,21063,21064,21069,21070,21075,21076);
delete from db_syscampodef where codcam in (21077,21078,21079,21080,21081,21082,21083,21084,21085,21086,21087,21088,21090,21092,21093,21094,21096,21098,21099,21101,21102,21103,21104,21105,21106);
delete from db_syscampo    where codcam in (21077,21078,21079,21080,21081,21082,21083,21084,21085,21086,21087,21088,21090,21092,21093,21094,21096,21098,21099,21101,21102,21103,21104,21105,21106);
delete from db_syscampodef where codcam in (21108,21109,21110);
delete from db_syscampo    where codcam in (21108,21109,21110);
delete from db_syscampodef where codcam in (21112,21113,21115);
delete from db_syscampo    where codcam in (21112,21113,21115);
delete from db_syscampodef where codcam in (21118,21119,21120);
delete from db_syscampo    where codcam in (21118,21119,21120);
delete from db_sysarqmod where codarq  in (3791, 3797, 3799, 3800, 3802);
delete from db_sysarquivo where codarq in (3791, 3797, 3799, 3800, 3802);
delete from db_syssequencia where codsequencia = 1000462;
delete from db_sysforkey where codarq = 3805;
delete from db_sysprikey where codarq = 3805;
delete from db_sysindices where codind = 4206;
delete from db_syscadind where codind = 4206;
delete from db_sysarqcamp where codarq = 3805;
delete from db_syscampo where codcam in ( 21133,21134,21135);
delete from db_sysarqmod where codarq = 3805;
delete from db_sysarquivo where codarq = 3805;

--Layout Arquivo retencao
delete from db_layoutcampos where db52_layoutlinha in (744, 745, 746);
delete from db_layoutlinha  where db51_layouttxt = 227;
delete from db_layouttxt    where db50_codigo    = 227;

delete from db_syssequencia where codsequencia = 1000463;
delete from db_syscadind where codind in (4207, 4208);
delete from db_sysindices where codind in (4207, 4208);
delete from db_sysforkey where codarq = 3806;
delete from db_sysprikey where codarq = 3806;
delete from db_sysarqcamp where codarq = 3806;
delete from db_syscampo where codcam in (21137,21138,21139);
delete from db_sysarqmod where codarq = 3806;
delete from db_sysarquivo where codarq = 3806;

/**
 * Meio Ambiente
 */
update db_syscampo set nomecam = 'am01_descricao', conteudo = 'varchar(50)', descricao = 'Critérios de medição de atividade de impacto local', valorinicial = '', rotulo = 'Critério de Medição', nulo = 'f', tamanho = 50, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Critério de Medição' where codcam = 20755;
delete from db_sysarqcamp where codarq = 3741;
delete from db_sysforkey where codarq = 3741 and referen = 0;

----------------------------------------------------------------------------------------
------------------------------ FIM TRIBUTARIO ------------------------------------------
----------------------------------------------------------------------------------------

--- Financeiro
-- Tarefa 97872
update db_itensmenu
   set descricao = 'Manutenção de Permissões da Despesa',
       help = 'Manutenção de Permissões da Despesa',
       desctec = 'Manutenção de Permissões da Despesa'
 where id_item = 3474;


 update db_syscampo
   set descricao = 'Localizador de Gastos',
       rotulo    = 'Localizador de Gastos',
       rotulorel = 'Localizador de Gastos'
 where codcam    = 14520;

 update db_itensmenu
   set descricao = 'Subtítulo / Localizador de Gastos',
       help      = 'Subtítulo / Localizador de Gastos',
       desctec   = 'Subtítulo / Localizador de Gastos'
 where id_item   = 7259;