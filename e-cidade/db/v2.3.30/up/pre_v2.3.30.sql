/**
 * Arquivo pre up
 */
----------------------------------------------------
---- TIME FOLHA DE PAGAMENTO
----------------------------------------------------
---- Tarefa: 97163
----------------------------------------------------
UPDATE db_syscampo
SET descricao = 'Identifica o tipo de contagem de tempo do assentamento, visto que o intervalo entre as mesmas datas podem ser contados de maneira diferente.',
    rotulo    = 'Tipo de efetividade',
    rotulorel = 'Tipo de efetividade'
WHERE codcam = 4508;

----------------------------------------------------
---- TIME FOLHA DE PAGAMENTO
----------------------------------------------------
---- Tarefa: 96909
----------------------------------------------------


-- Criação de menus folha suplementar
INSERT INTO db_itensmenu (id_item, descricao, help, funcao, itemativo, manutencao, desctec, libcliente)
VALUES (9972, 'Manutenção da Folha Suplementar', 'Manutenção da Folha Suplementar',                 '',                                         '1', '1', 'Menu que irá agrupar todos os submenus da rotina de Manutenção da Folha Suplementar.', 'true'),
       (9973, 'Abertura',                        'Abertura de Folha Suplementar',                   'pes4_aberturasuplementar001.php',          '1', '1', 'Abertura de Folha Suplementar',                                                        'true' ),
       (9974, 'Fechamento',                      'Fechamento da Folha Suplementar',                 'pes4_fechamentosuplementar001.php',        '1', '1', 'Fechamento da Folha Suplementar',                                                      'true' ),
       (9975, 'Cancelar Abertura',               'Cancelamento da Abertura da Folha Suplementar',   'pes4_cancelaaberturasuplementar001.php',   '1', '1', 'Cancelamento da Abertura da Folha Suplementar',                                        'true' ),
       (9976, 'Cancelar Fechamento',             'Cancelamento do Fechamento da Folha Suplementar', 'pes4_cancelafechamentosuplementar001.php', '1', '1', 'Cancelamento do Fechamento da Folha Suplementar',                                      'true' );

-- Organização de menus folha suplementar
INSERT INTO db_menu (id_item, id_item_filho, menusequencia, modulo)
VALUES (1818, 9972, 102, 952),
       (9972, 9973, 1,   952),
       (9972, 9974, 2,   952),
       (9972, 9975, 3,   952),
       (9972, 9976, 4,   952);

-- Atualizando posição dos menus folha suplementar
UPDATE db_menu SET menusequencia = 1  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5016;
UPDATE db_menu SET menusequencia = 2  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 9767;
UPDATE db_menu SET menusequencia = 3  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5050;
UPDATE db_menu SET menusequencia = 4  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5047;
UPDATE db_menu SET menusequencia = 5  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5112;
UPDATE db_menu SET menusequencia = 6  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5156;
UPDATE db_menu SET menusequencia = 7  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 4504;
UPDATE db_menu SET menusequencia = 8  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 9958;
UPDATE db_menu SET menusequencia = 9  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 9959;
UPDATE db_menu SET menusequencia = 10 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 9972;
UPDATE db_menu SET menusequencia = 11 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5036;
UPDATE db_menu SET menusequencia = 12 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5005;
UPDATE db_menu SET menusequencia = 13 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 4755;
UPDATE db_menu SET menusequencia = 14 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5106;
UPDATE db_menu SET menusequencia = 15 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5110;
UPDATE db_menu SET menusequencia = 16 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 8815;
UPDATE db_menu SET menusequencia = 17 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5204;
UPDATE db_menu SET menusequencia = 18 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5280;
UPDATE db_menu SET menusequencia = 19 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5305;
UPDATE db_menu SET menusequencia = 20 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5234;
UPDATE db_menu SET menusequencia = 21 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5136;
UPDATE db_menu SET menusequencia = 22 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 3516;
UPDATE db_menu SET menusequencia = 23 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 331384;
UPDATE db_menu SET menusequencia = 24 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 782400;
UPDATE db_menu SET menusequencia = 25 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5196;
UPDATE db_menu SET menusequencia = 26 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 7150;
UPDATE db_menu SET menusequencia = 27 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 7570;
UPDATE db_menu SET menusequencia = 28 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 7684;
UPDATE db_menu SET menusequencia = 29 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 8679;
UPDATE db_menu SET menusequencia = 30 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 8806;
UPDATE db_menu SET menusequencia = 31 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 8827;
UPDATE db_menu SET menusequencia = 32 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 9514;
UPDATE db_menu SET menusequencia = 33 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 9793;

-- Alteração de labels
UPDATE db_itensmenu SET descricao = 'Salário / Suplementar', help = 'Salário / Suplementar', desctec = 'Salário / Suplementar' WHERE id_item = 4506;
UPDATE db_itensmenu SET descricao = 'Salário / Suplementar', help = 'Salário / Suplementar', desctec = 'Salário / Suplementar' WHERE id_item = 4514;


/**
 * TRIBUTÁRIO
 */
--autolevanta
insert into db_sysarquivo values (3746, 'autolevanta', 'Vínculo entre as tabelas \'auto\' e \'levata\'', 'y117', '2014-10-14', 'Auto/Levanta', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (25,3746);
insert into db_syscampo values(20813,'y117_auto','int4','Auto de Infração','0', 'Auto de Infração',10,'f','f','f',1,'text','Auto de Infração');
insert into db_syscampo values(20814,'y117_levanta','int4','Levantamento','0', 'Levantamento',10,'f','f','f',1,'text','Levantamento');
insert into db_syscampo values(20815,'y117_sequencial','int4','Auto/Levanta','0', 'Auto/Levanta',10,'f','f','f',1,'text','Auto/Levanta');
delete from db_sysarqcamp where codarq = 3746;
insert into db_sysarqcamp values(3746,20815,1,0);
insert into db_sysarqcamp values(3746,20813,2,0);
insert into db_sysarqcamp values(3746,20814,3,0);
delete from db_sysprikey where codarq = 3746;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3746,20815,1,20814);
delete from db_sysforkey where codarq = 3746 and referen = 0;
insert into db_sysforkey values(3746,20813,1,699,0);
delete from db_sysforkey where codarq = 3746 and referen = 0;
insert into db_sysforkey values(3746,20814,1,709,0);
insert into db_sysindices values(4128,'autolevanta_sequencial_in',3746,'1');
insert into db_syscadind values(4128,20815,1);
insert into db_sysindices values(4130,'autolevanta_auto_levanta_in',3746,'1');
insert into db_syscadind values(4130,20813,1);
insert into db_syscadind values(4130,20814,2);

insert into db_syssequencia values(1000407, 'autolevanta_y117_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000407 where codarq = 3746 and codcam = 20815;

insert into db_syscampo values(20812,'y45_percentual','bool','Campo que informa o tipo de valor informado','f', 'Percentual',10,'f','f','f',5,'text','Percentual');
delete from db_sysarqcamp where codarq = 682;
insert into db_sysarqcamp values(682,20812,6,0);

update db_itensmenu set id_item = 4116 , descricao = 'Exportação' , help = 'Exportação' , funcao = 'fis4_importalevan001.php' , itemativo = '1' , manutencao = '1' , desctec = 'Procedimento >> Levantamento >> Exporta' , libcliente = 'true' where id_item = 4116;
delete from db_menu where id_item_filho = 4116 AND modulo = 277;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 2494 ,4116 ,4 ,277 );

insert into db_syscampo values(20824,'y32_templateautoinfracao','int4','Template padrão do Auto de Infração','0', 'Modelo do Auto',10,'t','f','f',1,'text','Modelo do Auto');
insert into db_sysarqcamp values(1103,20824,23,0);
insert into db_sysforkey values(1103,20824,1,2552,0);

--Template tipo e padrão
insert into db_documentotemplatetipo(db80_sequencial, db80_descricao) values(51, 'Auto de Infração');
insert into db_documentotemplatepadrao( db81_sequencial ,db81_templatetipo ,db81_nomearquivo ,db81_descricao ) values ( 54 , 51, 'documentos/templates/fiscal/auto_de_infracao.sxw', 'Auto de Infração' );

--setorlocvalor
select fc_executa_ddl('insert into db_sysarquivo values (3747, \'setorlocvalor\', \'setorlocvalor\', \'j05\', \'2014-10-20\', \'setorlocvalor\', 0, \'f\', \'f\', \'f\', \'f\' );');
select fc_executa_ddl('insert into db_sysarqmod values (2,3747);');
select fc_executa_ddl('insert into db_syscampo values(20820,\'j05_sequencial\',\'int4\',\'Sequencial da tanela setorlocvalor\',\'0\', \'Sequencial setorlocvalor\',11,\'f\',\'f\',\'f\',1,\'text\',\'Código\');');
select fc_executa_ddl('insert into db_syscampo values(20821,\'j05_setorloc\',\'int4\',\'Setor localização\',\'0\', \'Setor localização\',11,\'f\',\'f\',\'f\',1,\'text\',\'Setor localização\');');
select fc_executa_ddl('insert into db_syscampo values(20822,\'j05_anousu\',\'int4\',\'Anousu setorlocvalor\',\'0\', \'Ano\',11,\'f\',\'f\',\'f\',1,\'text\',\'Ano\');');
select fc_executa_ddl('insert into db_syscampo values(20823,\'j05_valor\',\'float8\',\'Valor\',\'0\', \'Valor\',11,\'f\',\'f\',\'f\',4,\'text\',\'Valor\');');
select fc_executa_ddl('delete from db_sysprikey where codarq = 3747;');
select fc_executa_ddl('insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3747,20820,1,20821);');
select fc_executa_ddl('insert into db_syssequencia values(1000408, \'setorlocvalor_j05_sequencial_seq\', 1, 1, 9223372036854775807, 1, 1);');
select fc_executa_ddl('update db_sysarqcamp set codsequencia = 1000408 where codarq = 3747 and codcam = 20820;');
select fc_executa_ddl('delete from db_sysarqcamp where codarq = 3747;');
select fc_executa_ddl('insert into db_sysarqcamp values(3747,20820,1,1000408);');
select fc_executa_ddl('insert into db_sysarqcamp values(3747,20821,2,0);');
select fc_executa_ddl('insert into db_sysarqcamp values(3747,20822,3,0);');
select fc_executa_ddl('insert into db_sysarqcamp values(3747,20823,4,0);');
select fc_executa_ddl('insert into db_sysindices values(4131,\'setorlocvalor_setorloc_in\',3747,\'1\');');
select fc_executa_ddl('insert into db_syscadind values(4131,20821,1);');
select fc_executa_ddl('delete from db_sysforkey where codarq = 3747 and referen = 0;');
select fc_executa_ddl('insert into db_sysforkey values(3747,20821,1,1495,0);');

 /**
 * FIM TRIBUTÁRIO
 */

----------------------------------------------------
---- TIME C {
----------------------------------------------------

----------------------------------------------------
---- Tarefa: 95125
----------------------------------------------------
insert into db_syscampo values(20756,'ed17_duracao','varchar(5)','Duração do período.','', 'Duração',5,'f','t','f',0,'text','Duração');
insert into db_sysarqcamp values(1010040,20756,7,0);

insert into db_sysarquivo values (3735, 'horarioescola', 'Cadastro dos horários da escola.', 'ed123', '2014-09-24', 'Horário da Escola', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (1008004,3735);
insert into db_syscampo values(20759,'ed123_sequencial','int4','Código do Horário da Escola','0', 'Código do Horário da Escola',10,'f','f','f',1,'text','Código do Horário da Escola');
insert into db_syscampo values(20760,'ed123_turnoreferencia','int4','Turno de Referência. 1 - Manhã 2 - Tarde 3 - Noite','0', 'Turno de Referência',10,'f','f','f',1,'text','Turno de Referência');
insert into db_syscampodef values(20760,'1','Manhã');
insert into db_syscampodef values(20760,'2','Tarde');
insert into db_syscampodef values(20760,'3','Noite');
insert into db_syscampo values(20761,'ed123_escola','int8','Código da Escola','0', 'Código da Escola',20,'f','f','f',1,'text','Código da Escola');
insert into db_syscampo values(20762,'ed123_horainicio','varchar(5)','Horário Inicial','', 'Horário Inicial',5,'f','t','f',0,'text','Horário Inicial');
insert into db_syscampo values(20763,'ed123_horafim','varchar(5)','Horário Final','', 'Horário Final',5,'f','t','f',0,'text','Horário Final');
insert into db_sysarqcamp values(3735,20759,1,0);
insert into db_sysarqcamp values(3735,20760,2,0);
insert into db_sysarqcamp values(3735,20761,3,0);
insert into db_sysarqcamp values(3735,20762,4,0);
insert into db_sysarqcamp values(3735,20763,5,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3735,20759,1,20760);
insert into db_sysforkey values(3735,20761,1,1010031,0);
insert into db_syssequencia values(1000397, 'horarioescola_ed123_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000397 where codarq = 3735 and codcam = 20759;
insert into db_sysindices values(4116,'horarioescola_escola_turnoreferencia_in',3735,'1');
insert into db_syscadind values(4116,20761,1);
insert into db_syscadind values(4116,20760,2);

update db_itensmenu set id_item = 1100897 , descricao = 'Funções/Atividades' , help = 'Funções/Atividades' , funcao = 'edu1_atividaderh001.php' , itemativo = '1' , manutencao = '1' , desctec = 'Cadastro de Funções/Atividades' , libcliente = 'true' where id_item = 1100897;

insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8170 ,1045399 ,14 ,8167 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8323 ,1045399 ,10 ,8322 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8482 ,1045399 ,3 ,8481 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1045399 ,1045410 ,4 ,8167 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1045399 ,1045410 ,5 ,8322 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1045399 ,1045410 ,6 ,8481 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1045399 ,1045411 ,7 ,8167 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1045399 ,1045411 ,8 ,8322 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1045399 ,1045411 ,9 ,8481 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1045399 ,1045412 ,10 ,8167 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1045399 ,1045412 ,11 ,8322 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1045399 ,1045412 ,12 ,8481 );

delete from db_sysindices where codind = 3411;
delete from db_sysindices where codind = 3410;


update db_syscampo set maiusculo = 't' where codcam = 19796;

----------------------------------------------------
--- Tarefa 10678
----------------------------------------------------
update db_itensmenu set libcliente = false where id_item = 8449;

----------------------------------------------------
--- Tarefa 92193
----------------------------------------------------
update db_syscampo
   set nomecam = 'ed62_percentualfrequencia',
       conteudo = 'float8',
       descricao = 'Percentual de frequência',
       valorinicial = '0',
       rotulo = 'Percentual de Frequência',
       nulo = 't',
       tamanho = 10,
       maiusculo = 'f',
       autocompl = 'f',
       aceitatipo = 4,
       tipoobj = 'text',
       rotulorel = 'Percentual de Frequência'
 where codcam = 20294;

delete from db_syscampodep where codcam = 20294;
delete from db_syscampodef where codcam = 20294;
insert into db_syscampo values(20819,'ed99_percentualfrequencia','float8','Percentual de Frequência','0', 'Percentual de Frequência',10,'t','f','f',4,'text','Percentual de Frequência');
delete from db_sysarqcamp where codarq = 1010157;
insert into db_sysarqcamp values(1010157,1009008,1,1000231);
insert into db_sysarqcamp values(1010157,1009009,2,0);
insert into db_sysarqcamp values(1010157,1009010,3,0);
insert into db_sysarqcamp values(1010157,1009011,4,0);
insert into db_sysarqcamp values(1010157,1009012,5,0);
insert into db_sysarqcamp values(1010157,1009013,6,0);
insert into db_sysarqcamp values(1010157,1009014,7,0);
insert into db_sysarqcamp values(1010157,1009015,8,0);
insert into db_sysarqcamp values(1010157,1009016,9,0);
insert into db_sysarqcamp values(1010157,1009017,10,0);
insert into db_sysarqcamp values(1010157,1009018,11,0);
insert into db_sysarqcamp values(1010157,1009019,12,0);
insert into db_sysarqcamp values(1010157,14633,13,0);
insert into db_sysarqcamp values(1010157,19693,14,0);
insert into db_sysarqcamp values(1010157,20370,15,0);
insert into db_sysarqcamp values(1010157,20819,16,0);

----------------------------------------------------
---- } FIM TIME C
----------------------------------------------------

----------------------------------------------------
---- TIME FINANCEIRO
----------------------------------------------------
---- Tarefa: 97055
----------------------------------------------------
insert into db_syscampo     values(20753,'pc80_tipoprocesso','int4','Tipo de Processo','1', 'Tipo de Processo',1,'t','f','f',1,'text','Tipo de Processo');
insert into db_syscampodef  values(20753,'1','Item');
insert into db_syscampodef  values(20753,'2','Lote');
insert into db_sysarqcamp   values(1042,20753,7,0);

insert into db_sysarquivo   values (3736, 'processocompralote', 'Tabela que armazena as informações do lote no processo de compra.', 'pc68', '2014-09-24', 'Lote', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod    values (12,3736);
insert into db_syscampo     values(20764,'pc68_sequencial','int4','Identificador único.','0', 'Sequencial',10,'f','f','f',1,'text','Sequencial');
insert into db_syscampo     values(20765,'pc68_pcproc','int8','Este campo identifica o processo de compra.','0', 'Processo de Compra',10,'f','f','f',1,'text','Processo de Compra');
insert into db_syscampo     values(20766,'pc68_nome','varchar(100)','Nome do Lote','', 'Nome do Lote',100,'f','t','f',0,'text','Nome do Lote');
insert into db_sysarqcamp   values(3736,20764,1,0);
insert into db_sysarqcamp   values(3736,20766,2,0);
insert into db_sysarqcamp   values(3736,20765,3,0);
insert into db_sysprikey    values(3736,20764,1,20764);
insert into db_sysforkey    values(3736,20765,1,1042,0);
insert into db_sysindices   values(4115,'processocompralote_sequencial_in',3736,'0');
insert into db_syscadind    values(4115,20764,1);
insert into db_syssequencia values(1000398, 'processocompralote_pc68_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000398 where codarq = 3736 and codcam = 20764;

insert into db_sysarquivo   values (3738, 'processocompraloteitem', 'Vínculo entre o lote e item no processo de compra ', 'pc69', '2014-09-24', 'Lote e Item', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod    values (12,3738);
insert into db_syscampo     values (20768,'pc69_sequencial','int4','Identificador único.','0', 'Sequencial',10,'f','f','f',1,'text','Sequencial');
insert into db_syscampo     values (20771,'pc69_processocompralote','int4','Vínculo com a tabela do lote do processo de compra.','','Lote do Processo de Compra',10,'false','false','false',1,'text','Lote do Processo de Compra');
insert into db_syscampo     values (20772,'pc69_pcprocitem','int8','Vínculo com a tabela de item do processo de compra.','','Item do Processo de Compra',10,'false','false','false',1,'text','Item do Processo de Compra');
insert into db_sysarqcamp   values (3738,20768,1,0);
insert into db_sysarqcamp   values (3738,20771,2,0);
insert into db_sysarqcamp   values (3738,20772,3,0);
insert into db_sysprikey    values(3738,20768,1,20768);
insert into db_sysforkey    values(3738,20771,1,3736,0);
insert into db_sysforkey    values(3738,20772,1,1043,0);
insert into db_sysindices   values(4117,'processocompraloteitem_sequencial_in',3738,'0');
insert into db_syscadind    values(4117,20768,1);
insert into db_syssequencia values(1000399, 'processocompraloteitem_pc69_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000399 where codarq = 3738 and codcam = 20768;


update db_itensmenu set descricao = 'Alteração', funcao = 'com4_processocompra001.php?acao=2' where id_item = 5025;
update db_itensmenu set descricao = 'Exclusão', funcao = 'com4_processocompra001.php?acao=3' where id_item = 4201;
update db_syscampo set rotulo = 'Item' where codcam = 5549;

update db_syscampo set rotulo = 'Descrição do Departamento', rotulorel = 'Descrição do Departamento' where codcam = 815;
update db_syscampo set rotulo = 'Data'                     , rotulorel = 'Data'                      where codcam = 6381;
update db_syscampo set rotulo = 'Processo de Compras'      , rotulorel = 'Processo de Compras'       where codcam = 6380;
update db_syscampo set rotulo = 'Número da Solicitação'    , rotulorel = 'Número da Solicitação'     where codcam = 5542;

update db_itensmenu set descricao = 'Etiquetas', help = 'Etiquetas', funcao = '', itemativo = '1', desctec = 'Etiquetas', libcliente = '1' where id_item = 4250;
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9982 ,'Manual' ,'Etiquetas para Processos' ,'pro4_impetiqueta001.php' ,'1' ,'1' ,'Etiquetas para Processos' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 4250 ,9982 ,1 ,604 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9983 ,'Processos do Sistema' ,'Etiquetas para Processos' ,'pro2_etiquetaprocesso001.php' ,'1' ,'1' ,'Etiquetas para Processos' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 4250 ,9983 ,2 ,604 );

update db_syscampo set rotulo = 'Código do Orçamento',                    rotulorel = 'Código do Orçamento'                    where codcam = 5512;
update db_syscampo set rotulo = 'Código do Orçamento',                    rotulorel = 'Código do Orçamento'                    where codcam = 5509;
update db_syscampo set rotulo = 'Prazo Limite para Entrega do Orçamento', rotulorel = 'Prazo Limite para Entrega do Orçamento' where codcam = 5510;
update db_syscampo set rotulo = 'Hora Limite para Entrega do Orçamento',  rotulorel = 'Hora Limite para Entrega do Orçamento'  where codcam = 5511;
update db_syscampo set rotulo = 'Validade do Orçamento',                  rotulorel = 'Validade do Orçamento'                  where codcam = 10963;
update db_syscampo set rotulo = 'Prazo de Entrega do Produto',            descricao = 'Prazo de Entrega do Produto'            where codcam = 10962;

update db_itensmenu
   set descricao = 'Solicitação de Compras'
 where id_item = 3485;

----------------------------------------------------
---- Tarefa: 97148
----------------------------------------------------
delete from db_sysforkey where codarq = 3404 and referen = 3173;
delete from db_sysarqcamp where codcam in (19161);
delete from db_syscampo where codcam in (19161);

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
  values ( 20818 ,'m04_materialestoquegrupo' ,'int4' ,'Grupo' ,'' ,'Grupo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Grupo' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3404 ,20818 ,3 ,0 );
insert into db_sysforkey values(3404,20818,1,3174,0);

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente )
     values ( 9990 ,'Legais' ,'Relatórios Legais' ,'' ,'1' ,'1' ,'Relatórios Legais' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 30 ,9990 ,439 ,480 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente )
     values ( 9991 ,'Modelo XXI - Bens em Almoxarifado' ,'Modelo XXI - Bens em Almoxarifado' ,'mat2_bensalmoxarifado001.php' ,'1' ,'1' ,'Modelo XXI - Bens em Almoxarifado' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 9990 ,9991 ,1 ,480 );

delete from db_syscadind where codind = 3511;
delete from db_sysindices where codind = 3511;

insert into db_sysindices values(4129,'materialtipogrupovinculo_materialtipogrupo_in',3404,'1');
insert into db_syscadind values(4129,19160,1);
insert into db_syscadind values(4129,20818,2);

insert into db_tipodoc( db08_codigo ,db08_descr )
     values ( 5014 ,'ASSINATURA MODELO XXI - BENS EM ALMOXARI' );

insert into db_documentopadrao( db60_coddoc ,db60_descr ,db60_tipodoc ,db60_instit )
     select nextval('db_documentopadrao_db60_coddoc_seq'), 'MODELO XXI - BENS EM ALMOXARIFADO', 5014, codigo from db_config;

drop table if exists db_paragrafopadrao_97148;
create temp table db_paragrafopadrao_97148 as select nextval('db_paragrafopadrao_db61_codparag_seq') as sequencial, codigo from db_config;

insert into db_paragrafopadrao( db61_codparag ,db61_descr ,db61_texto ,db61_alinha ,db61_inicia ,db61_espaco ,db61_alinhamento ,db61_altura ,db61_largura ,db61_tipo )
     select sequencial, 'MODELO XXI' ,'$oPdf->cell($nWidth*0.6, 5, \"Responsável pelos Bens em Almoxarifado\", \'L\'); $oPdf->cell($oPdf->getAvailWidth(), 5, \"Cargo\", \'R\', 1); $oPdf->cell($nWidth*0.6, 5, \"responsavel_bens\", \'L:R:B\'); $oPdf->cell($oPdf->getAvailWidth(), 5, \"responsavel_cargo\", \'R:B\', 1); $oPdf->cell($nWidth*0.3, 5, \"Matrícula\", \'L\'); $oPdf->cell($nWidth*0.2, 5, \"Data\"); $oPdf->cell($nWidth*0.5, 5, \"Assinatura\", \'R\', 1); $oPdf->cell($nWidth*0.3, 5, \"matricula\", \'L:R:B\'); $oPdf->cell($nWidth*0.2, 5, \"data\", \'R:B\'); $oPdf->cell($nWidth*0.5, 5, \"assinatura\", \'R:B\', 1); $this->oPdf->cell($nWidth, 1, \"\", \"R:L:B\", 1); $oPdf->cell($nWidth*0.6, 5, \"Responsável pela Conferência\", \'L\'); $oPdf->cell($oPdf->getAvailWidth(), 5, \"Cargo\", \'R\', 1); $oPdf->cell($nWidth*0.6, 5, \"responsavel_conferencia\", \'L:R:B\'); $oPdf->cell($oPdf->getAvailWidth(), 5, \"responsavel_cargo\", \'R:B\', 1); $oPdf->cell($nWidth*0.3, 5, \"Matrícula\", \'L\'); $oPdf->cell($nWidth*0.2, 5, \"Data\"); $oPdf->cell($nWidth*0.5, 5, \"Assinatura\", \'R\', 1); $oPdf->cell($nWidth*0.3, 5, \"matricula\", \'L:R:B\'); $oPdf->cell($nWidth*0.2, 5, \"data\", \'R:B\'); $oPdf->cell($nWidth*0.5, 5, \"assinatura\", \'R:B\', 1); $this->oPdf->cell($nWidth, 1, \"\", \"R:L:B\", 1); $oPdf->cell($nWidth*0.6, 5, \"Responsável pelo Visto\", \'L\'); $oPdf->cell($oPdf->getAvailWidth(), 5, \"Cargo\", \'R\', 1); $oPdf->cell($nWidth*0.6, 5, \"responsavel_visto\", \'L:R:B\'); $oPdf->cell($oPdf->getAvailWidth(), 5, \"responsavel_cargo\", \'R:B\', 1); $oPdf->cell($nWidth*0.3, 5, \"Matrícula\", \'L\'); $oPdf->cell($nWidth*0.2, 5, \"Data\"); $oPdf->cell($nWidth*0.5, 5, \"Assinatura\", \'R\', 1); $oPdf->cell($nWidth*0.3, 5, \"matricula\", \'L:R:B\'); $oPdf->cell($nWidth*0.2, 5, \"data\", \'R:B\'); $oPdf->cell($nWidth*0.5, 5, \"cargo\", \'R:B\', 1);' ,0 ,0 ,1 ,'J' ,0 ,0 ,3
       from db_paragrafopadrao_97148;

insert into db_docparagpadrao( db62_coddoc ,db62_codparag ,db62_ordem )
     select db60_coddoc, db_paragrafopadrao_97148.sequencial, db60_instit
       from db_documentopadrao inner join db_paragrafopadrao_97148 on db_paragrafopadrao_97148.codigo = db60_instit where db60_tipodoc = 5014;

delete from db_menu where id_item_filho = 9347 AND modulo = 439;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 9990 ,9347 ,1 ,480 );

update db_itensmenu set descricao = 'Modelo XX - Bens em Almoxarifado' , help = 'Modelo XX - Bens em Almoxarifado', desctec = 'Modelo XX - Bens em Almoxarifado' where id_item = 9347;
update db_itensmenu set descricao = 'Modelo XI - Arrolamento das Existências' , help = 'Modelo XI - Bens Patrimoniais - Arrolamento das Existências', desctec = 'Modelo XI - Bens Patrimoniais - Arrolamento das Existências' where id_item = 9341;
update db_itensmenu set descricao = 'Modelo XII - Dem. da Movimentação' , help = 'Modelo XII - Demonstrativo da Movimentação' , desctec = 'Modelo XII - Demonstrativo da Movimentação' where id_item = 9342;

update db_syscampo set maiusculo = 't' where codcam = 19158;

update db_syscampo set descricao = 'Código Sequencial', rotulo = 'Código', rotulorel = 'Código' where codcam = 17969;

----------------------------------------------------
---- Tarefa: 97115
----------------------------------------------------
update db_itensmenu set funcao = '', help = 'Mapa das propostas do orçamento' , desctec = 'Mapa das propostas do orçamento.' where id_item = 5013;
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9984    ,'Por Item' ,'Imprimir o mapa de proposta do orçamento por item' ,'com2_mapaorc001.php' ,'1' ,'1' ,'A tela serve para imprimir o mapa de proposta do orçamento por item.' ,'true' );
insert into db_menu      ( id_item ,id_item_filho ,menusequencia ,modulo )                                values ( 5013 ,9984 ,1 ,28 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9985    ,'Por Lote' ,'Imprimir o mapa de proposta do orçamento por lote' ,'com2_mapaorcamentolote001.php' ,'1' ,'1' ,'A tela serve para imprimir o mapa de proposta do orçamento por lote.' ,'true' );
insert into db_menu      ( id_item ,id_item_filho ,menusequencia ,modulo )                                values ( 5013 ,9985 ,2 ,28 );

----------------------------------------------------
---- Tarefa: 97140
----------------------------------------------------
update db_itensmenu set funcao = '', descricao = 'Delib. 200/96 - TCE RJ' , help = 'Delib. 200/96 - TCE RJ' , desctec = 'Delib. 200/96 - TCE RJ'  where id_item = 9433;
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9986 ,'Anexo I' ,'Gerar Anexo I do Relatório Conciliação Bancária TCE/RJ' ,'cai2_anexosdeliberacao20096.php?anexo=1' ,'1' ,'1' ,'O usuário vai poder gerar PDF do anexo I do relatório conciliação bancária TCE/RJ.' ,'true' );
insert into db_menu      ( id_item ,id_item_filho ,menusequencia ,modulo )                                values ( 9433 ,9986 ,2 ,39 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9987 ,'Anexo II' ,'Gerar Anexo II do Relatório Conciliação Bancária TCE/RJ' ,'cai2_anexosdeliberacao20096.php?anexo=2' ,'1' ,'1' ,'O usuário vai poder gerar PDF do anexo II do relatório conciliação bancária TCE/RJ.' ,'true' );
insert into db_menu      ( id_item ,id_item_filho ,menusequencia ,modulo )                                values ( 9433 ,9987 ,3 ,39 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9988 ,'Anexo III' ,'Gerar Anexo III do Relatório Conciliação Bancária TCE/RJ' ,'cai2_anexosdeliberacao20096.php?anexo=3' ,'1' ,'1' ,'O usuário vai poder gerar PDF do anexo III do relatório conciliação bancária TCE/RJ.' ,'true' );
insert into db_menu      ( id_item ,id_item_filho ,menusequencia ,modulo )                                values ( 9433 ,9988 ,4 ,39 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9989 ,'Modelo 6' ,'Gerar o Modelo 6 do Relatório Conciliação Bancária TCE/RJ' ,'cai2_modelo6delibtcerj001.php' ,'1' ,'1' ,'O usuário vai poder gerar PDF do modelo 6 do relatório conciliação bancária TCE/RJ.' ,'true' );
insert into db_menu      ( id_item ,id_item_filho ,menusequencia ,modulo )                                values ( 9433 ,9989 ,1 ,39 );

