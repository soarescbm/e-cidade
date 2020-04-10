------------------------------------------------------------------------------------
------------------------------ INICIO TRIBUTARIO -----------------------------------
------------------------------------------------------------------------------------
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10164 ,'Exclusão de Item' ,'Excluir item de uma lista' ,'cai4_excluiitemlista001.php' ,'1' ,'1' ,'Exclusão de Item de uma lista gerada' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 2211 ,10164 ,4 ,4066 );
  update db_itensmenu set descricao = 'Gera CDA a partir da lista', help = 'Gera CDA a partir da lista' where id_item = 4695;

/**
 * Inseri menu de exclusão de credito novamente
 */
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente )
     select 10167 ,'Excluir Crédito' ,'Excluir Crédito' ,'arr4_excluiCredito001.php' ,'1' ,'1' ,'Exclusão de Crédito' ,'true'
      where not exists (select 1
                          from db_itensmenu
                         where id_item = 10167 );

insert into db_menu ( id_item, id_item_filho, menusequencia, modulo )
     select 9625, 10167, 4, 1985522
      where not exists (select  1
                          from db_menu
                         where id_item       = 9625
                           and id_item_filho = 10167);
------------------------------------------------------------------------------------
------------------------------ FIM TRIBUTARIO --------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
------------------------------ INICIO FINANCEIRO -----------------------------------
------------------------------------------------------------------------------------

insert into db_menu values(5602,7760,9,398);
insert into db_itensmenu values( 10166, 'Folha de Pagamento', 'Relatórios de SLIP e Planilha originados pela Folha de Pagamento', '', '1', '1', '', '1'	);
insert into db_menu values(30,10166,449,39);
insert into db_menu values(10166,9785,1,39);
insert into db_menu values(10166,9784,2,39);

insert into db_itensmenu (id_item, descricao, help, funcao, itemativo, manutencao, desctec, libcliente) values (10168, 'Unificar / Desmembrar Notas' , 'Unificar / Desmembrar Notas Pendentes', 'pat1_bensnotaspendentes001.php', '1', '1', 'Rotina para unificar notas pendentes em um único bem ou desmembrar uma nota pendente em diversos bens.', 'true');
delete from db_menu where id_item_filho = 10168 AND modulo = 439;
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (3838, 10168, 3, 439);

alter table matestoquetipo alter column m81_descr type varchar(100);
select setval('matestoquetipo_m81_codtipo_seq', (select max(m81_codtipo) from matestoquetipo));
insert into matestoquetipo values (23, 'ENTRADA DE MATERIAL PERMANENTE', true, 5);
insert into matestoquetipo values (24, 'SAÍDA DE MATERIAL PERMANENTE', false, 5);
insert into matestoquetipo values (25, 'ENTRADA DE M.P. POR DISPENSA DE TOMBAMENTO', true, 1);
insert into matestoquetipo values (26, 'ANULAÇÃO DA ENTRADA DE M.P. POR DISPENSA DE TOMBAMENTO', false, 2);

-- planilha de distribuição
insert into db_sysarquivo values (3874, 'planilhadistribuicao', 'Armazena os dados da planilha utilizada para gerar requisições de materiais.', 'pd01', '2015-10-01', 'Planilha de Distribuição', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (13,3874);

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21583 ,'pd01_sequencial' ,'int4' ,'Código sequencial' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3874 ,21583 ,1 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21584 ,'pd01_descricao' ,'varchar(200)' ,'Descrição da planilha' ,'' ,'Descrição' ,100 ,'false' ,'true' ,'false' ,0 ,'text' ,'Descrição' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3874 ,21584 ,2 ,0 );

insert into db_sysarquivo values (3875, 'planilhadistribuicaodepart', 'Armazena os departamentos que pertencem a uma planilha de distribuição.', 'pd02', '2015-10-01', 'Departamento da Planilha de Distribuição', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (13,3875);

insert into db_sysarqarq values (3874,3875);

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21585 ,'pd02_sequencial' ,'int4' ,'Código sequencial' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3875 ,21585 ,1 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21586 ,'pd02_planilhadistribuicao' ,'int4' ,'Código sequencial' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3875 ,21586 ,2 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21587 ,'pd02_departamento' ,'int4' ,'Departamento' ,'' ,'Departamento' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Departamento' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3875 ,21587 ,3 ,0 );

insert into db_sysarquivo values (3876, 'planilhadistribuicaomaterial', 'Armazena materiais que percentem a uma planilha de distribuição.', 'pd03', '2015-10-01', 'Material da Planilha de Distribuição', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (13,3876);
insert into db_sysarqarq values (3874,3876);

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21588 ,'pd03_sequencial' ,'int4' ,'Código sequencial' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3876 ,21588 ,1 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21589 ,'pd03_planilhadistribuicao' ,'int4' ,'Planilha de distribuição' ,'' ,'Planilha de Distribuição' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Planilha de Distribuição' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3876 ,21589 ,2 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21590 ,'pd03_material' ,'int4' ,'Material' ,'' ,'Material' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Material' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3876 ,21590 ,3 ,0 );

insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3874,21583,1,21583);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3876,21588,1,21588);

insert into db_sysforkey values(3876,21589,1,3874,0);
insert into db_sysforkey values(3876,21590,1,1016,0);

insert into db_sysindices values(4291,'planilhadistribuicaomaterial_planilhadistribuicao_in',3876,'0');
insert into db_syscadind values(4291,21589,1);

insert into db_sysindices values(4292,'planilhadistribuicaomaterial_material_in',3876,'0');
insert into db_syscadind values(4292,21590,1);

insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3875,21585,1,21585);

insert into db_sysforkey values(3875,21586,1,3874,0);
insert into db_sysforkey values(3875,21587,1,154,0);

insert into db_sysindices values(4293,'planilhadistribuicaodepart_departamento_in',3875,'0');
insert into db_syscadind values(4293,21587,1);

insert into db_sysindices values(4294,'planilhadistribuicaodepart_planilhadistribuicao_in',3875,'0');
insert into db_syscadind values(4294,21586,1);

insert into db_syssequencia values(1000522, 'planilhadistribuicao_pd01_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000522 where codarq = 3874 and codcam = 21583;

insert into db_syssequencia values(1000523, 'planilhadistribuicaodepart_pd02_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000523 where codarq = 3875 and codcam = 21585;

insert into db_syssequencia values(1000524, 'planilhadistribuicaomaterial_pd03_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000524 where codarq = 3876 and codcam = 21588;

-- menus
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10169 ,'Planilha de Distribuição' ,'Planilha de Distribuição' ,'' ,'1' ,'1' ,'Planilha de Distribuição' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 32 ,10169 ,463 ,480 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10170 ,'Inclusão' ,'Inclusão' ,'mat4_planilhadistribuicao001.php?opcao=1' ,'1' ,'1' ,'Inclusão de Planilha de Distribuição' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10169 ,10170 ,1 ,480 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10171 ,'Alteração' ,'Alteração' ,'mat4_planilhadistribuicao001.php?opcao=2' ,'1' ,'1' ,'Alteração de Planilha de Distribuição' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10169 ,10171 ,2 ,480 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10172 ,'Importar' ,'Importar' ,'mat4_importarplanilhadistribuicao.php' ,'1' ,'1' ,'Importar Planilha de Distribuição' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10169 ,10172 ,3 ,480 );

-- fim planilha distribuição

-- Altera o menu do cadastro de fornecedores
delete from db_menu where id_item = 9198 and id_item_filho = 3962 and modulo = 28;
delete from db_menu where id_item = 3962 and id_item_filho in (3963, 3964, 3965) and modulo = 28;

insert into db_menu values(9198, 3963, 1, 28),
                          (9198, 3964, 2, 28),
                          (9198, 3965, 3, 28);

------------------------------------------------------------------------------------
------------------------------ FIM FINANCEIRO --------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
------------------------------ INICIO EDUCAÇÃO E SAÚDE -----------------------------
------------------------------------------------------------------------------------

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10173 ,'Ata de Matrículas' ,'Ata de Matrículas' ,'edu2_atamatricula001.php' ,'1' ,'1' ,'Emite a ata de matrículas dos alunos.' ,'false' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1101112 ,10173 ,15 ,1100747 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10174 ,'Controle de Matrícula Inicial' ,'Controle de Matrícula Inicial' ,'sec4_controlematriculainicial001.php' ,'1' ,'1' ,'Configura o controle de matrículas iniciais.' ,'false' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 3444 ,10174 ,24 ,7159 );
insert into db_sysarquivo values (3877, 'controlematriculainicial', 'Tabela de controle de matrícula inicial', 'ed135', '2015-10-06', 'Controle de Matrícula Inicial', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (61,3877);
insert into db_syscampo values(21591,'ed135_sequencial','int4','Código PK','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21592,'ed135_quantidadedias','int4','Quantidade de dias para calcular a data de corte da matrícula, baseado na data inicial do calendário.','0', 'Quantidade de Dias',3,'f','f','f',1,'text','Quantidade de Dias');
insert into db_syscampo values(21593,'ed135_anoinicial','int4','Ano de início do calendário.','0', 'Ano Inicial',4,'f','f','f',1,'text','Ano Inicial');
insert into db_syscampo values(21594,'ed135_anofinal','int4','Ano final do calendário','null', 'Ano Final',4,'t','f','f',1,'text','Ano Final');
insert into db_sysarqcamp values(3877,21591,1,0);
insert into db_sysarqcamp values(3877,21593,2,0);
insert into db_sysarqcamp values(3877,21594,3,0);
insert into db_sysarqcamp values(3877,21592,4,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3877,21591,1,21591);
insert into db_syssequencia values(1000525, 'controlematriculainicial_ed135_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000525 where codarq = 3877 and codcam = 21591;

------------------------------------------------------------------------------------
------------------------------ FIM EDUCAÇÃO E SAÚDE --------------------------------
------------------------------------------------------------------------------------
