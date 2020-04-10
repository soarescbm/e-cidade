----------------------------------------------------
---- TIME C
----------------------------------------------------

----------------------------------------------------
---- Tarefa: 1023
----------------------------------------------------
delete from db_sysforkey where codarq  = 1010084;
delete from db_sysarqcamp where codarq = 1010084 and codcam = 20826;
delete from db_syscampo where codcam   = 20826;
delete from db_menu where id_item_filho = 9993 AND modulo = 1100747;
DELETE from db_itensmenu where id_item = 9993;

update db_itensmenu set descricao = 'Diário de Classe', help = 'Diário de Classe', libcliente = '1' where id_item = 1100958;
update db_itensmenu set descricao = 'Diário de Classe (Novo)', help = 'Diário de Classe (Novo)', libcliente = '1' where id_item = 9941;

----------------------------------------------------
---- Tarefa: 10658
----------------------------------------------------
insert into  db_syscampo
         (codcam, nomecam, conteudo, descricao, rotulo, tamanho, nulo, maiusculo, autocompl, aceitatipo, tipoobj, rotulorel)
  values (16415, 'tf18_c_localsaida', 'varchar(50)',  'Local da saída do veículo.', 'Local da Saída', 50, true, true, false, 0, 'text', 'Local da Saída' );
insert into db_sysarqcamp values(2874, 16415, 9, 0);
update db_itensmenu set libcliente = true where id_item = 8437;

----------------------------------------------------
---- Tarefa: 102508
----------------------------------------------------
update db_syscampo set rotulorel = 'Ínicio', rotulo = 'Ínicio' where codcam = 12510;


----------------------------------------------------
---- FIM TIME C
----------------------------------------------------



/**
 * [FINANCEIRO - INICIO]
 */
 -- 97192
delete from db_menu where id_item_filho = 9992;
delete from db_itensfilho where id_item = 9992 and codfilho = 1;
delete from db_itensmenu where id_item  = 9992;

-- 77216
delete from db_menu where id_item_filho = 9994 AND modulo = 209;
delete from db_itensmenu where id_item = 9994;


UPDATE orcparamseqorcparamseqcoluna
   SET o116_orcparamseqcoluna = 155
 WHERE o116_orcparamseqcoluna = 35
   and o116_codseq in(30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 63, 64, 64, 65, 66, 67, 68, 69, 70)
   and o116_codparamrel = 124
   and o116_periodo in (11, 13);

-- 97248
delete from db_menu where id_item_filho = 9996 AND modulo = 209;
delete from db_menu where id_item_filho = 9995 AND modulo = 209;
delete from db_itensmenu where id_item in(9996, 9995);

drop table if exists db_paragrafopadrao_97248;
create temp table db_paragrafopadrao_97248 as select db62_codparag as paragrafo from db_docparagpadrao where db62_coddoc in (select db60_coddoc from db_documentopadrao where db60_tipodoc = 5015);

delete from db_docparagpadrao where db62_coddoc in (select db60_coddoc from db_documentopadrao where db60_tipodoc = 5015);
delete from db_paragrafopadrao where db61_codparag in (select paragrafo from db_paragrafopadrao_97248);
delete from db_documentopadrao where db60_tipodoc = 5015;
delete from db_tipodoc where db08_codigo = 5015;


delete from db_menu where id_item_filho in (10004, 10005);
delete from db_itensmenu where id_item in (10004, 10005);
update db_menu set id_item = 7941 where id_item_filho in (7942, 7943, 7962) and id_item = 10004;

delete from db_menu where id_item_filho = 10014 AND modulo = 28;
delete from db_menu where id_item_filho = 10015 AND modulo = 28;
delete from db_menu where id_item_filho = 10016 AND modulo = 28;

delete from db_itensmenu where id_item in (10014,10015, 10016);

delete from db_menu where id_item_filho = 10010 AND modulo = 28;

update db_menu set id_item = 7962, menusequencia=3  where id_item_filho in (7968) and id_item = 7941;
update db_menu set id_item = 7962, menusequencia=4  where id_item_filho in (7969) and id_item = 7941;
delete from db_itensfilho where id_item in (10006, 10007, 10008, 10009, 10010);
delete from db_itensmenu where id_item in (10006, 10007, 10008, 10009, 10010);

delete from db_menu where id_item = 10008; /*delete que faltou para down do up do financeiro*/

delete from db_menu where id_item = 10005;

/* Menus > Abertura Registro de Preço (inclusao/alteracao/exclusao) */
delete from db_menu where id_item = 10006;
delete from db_itensfilho where id_item in (10011, 10012, 10013);
delete from db_itensmenu where id_item in (10011, 10012, 10013);

delete from db_sysarqcamp where codcam in(20855, 20854);
delete from db_syscampodef where codcam in(20855, 20854);
delete from  db_syscampo where codcam in(20855, 20854);

delete from db_sysarqcamp where codarq = 2679 and codcam = 20853;
delete from db_syscampo where codcam = 20853;

delete from db_menu where id_item_filho in (10021, 10020);
delete from db_itensfilho where id_item in (10021, 10020);
delete from db_itensmenu where id_item in (10021, 10020);

/**
 * 97317 - Encerramento do exercicio
 */

delete from vinculoeventoscontabeis where c115_conhistdocinclusao in (1008, 1009, 1010);
delete from conencerramentotipo where c43_sequencial in (6,7);
delete from conhistdoc where c53_coddoc in (1008, 1009, 1010);

delete from db_menu where id_item = 4197 and id_item_filho = 10022;
delete from db_itensmenu where id_item = 10022;

delete from db_sysprikey where codarq = 3756;
delete from db_sysarqcamp where codarq = 3756;
delete from db_syssequencia where codsequencia = 1000419;
delete from db_syscampo where codcam in (20874, 20875, 20876, 20877, 20878);
delete from db_sysarqmod where codarq = 3756;
delete from db_sysarquivo where codarq = 3756;

delete from db_sysarqcamp where codarq = 3020 and codcam = 20879;
delete from db_syscampo where codcam = 20879;

delete from db_menu where id_item_filho = 10023;
delete from db_itensfilho where id_item = 10023;
delete from db_itensmenu where id_item = 10023;

/**
 * [FINANCEIRO - FIM]
 */

----------------------------------------------------
---- FOLHA
----------------------------------------------------

-- 96909
DELETE FROM db_menu      WHERE id_item_filho IN (9997, 9999, 10017) AND modulo = 952;
DELETE FROM db_itensmenu WHERE id_item       IN (9997, 9999, 10017);

update db_menu set menusequencia =  1 where id_item = 1818 and modulo = 952 and id_item_filho = 5016;
update db_menu set menusequencia =  2 where id_item = 1818 and modulo = 952 and id_item_filho = 9767;
update db_menu set menusequencia =  3 where id_item = 1818 and modulo = 952 and id_item_filho = 5050;
update db_menu set menusequencia =  4 where id_item = 1818 and modulo = 952 and id_item_filho = 5047;
update db_menu set menusequencia =  5 where id_item = 1818 and modulo = 952 and id_item_filho = 5112;
update db_menu set menusequencia =  6 where id_item = 1818 and modulo = 952 and id_item_filho = 5156;
update db_menu set menusequencia =  7 where id_item = 1818 and modulo = 952 and id_item_filho = 4504;
update db_menu set menusequencia =  8 where id_item = 1818 and modulo = 952 and id_item_filho = 9958;
update db_menu set menusequencia =  9 where id_item = 1818 and modulo = 952 and id_item_filho = 9959;
update db_menu set menusequencia = 10 where id_item = 1818 and modulo = 952 and id_item_filho = 9972;
update db_menu set menusequencia = 11 where id_item = 1818 and modulo = 952 and id_item_filho = 5036;
update db_menu set menusequencia = 12 where id_item = 1818 and modulo = 952 and id_item_filho = 5005;
update db_menu set menusequencia = 13 where id_item = 1818 and modulo = 952 and id_item_filho = 4755;
update db_menu set menusequencia = 14 where id_item = 1818 and modulo = 952 and id_item_filho = 5106;
update db_menu set menusequencia = 15 where id_item = 1818 and modulo = 952 and id_item_filho = 5110;
update db_menu set menusequencia = 16 where id_item = 1818 and modulo = 952 and id_item_filho = 8815;
update db_menu set menusequencia = 17 where id_item = 1818 and modulo = 952 and id_item_filho = 5204;
update db_menu set menusequencia = 18 where id_item = 1818 and modulo = 952 and id_item_filho = 5280;
update db_menu set menusequencia = 19 where id_item = 1818 and modulo = 952 and id_item_filho = 5305;
update db_menu set menusequencia = 20 where id_item = 1818 and modulo = 952 and id_item_filho = 5234;
update db_menu set menusequencia = 21 where id_item = 1818 and modulo = 952 and id_item_filho = 5136;
update db_menu set menusequencia = 22 where id_item = 1818 and modulo = 952 and id_item_filho = 3516;
update db_menu set menusequencia = 23 where id_item = 1818 and modulo = 952 and id_item_filho = 331384;
update db_menu set menusequencia = 24 where id_item = 1818 and modulo = 952 and id_item_filho = 782400;
update db_menu set menusequencia = 25 where id_item = 1818 and modulo = 952 and id_item_filho = 5196;
update db_menu set menusequencia = 26 where id_item = 1818 and modulo = 952 and id_item_filho = 7150;
update db_menu set menusequencia = 27 where id_item = 1818 and modulo = 952 and id_item_filho = 7570;
update db_menu set menusequencia = 28 where id_item = 1818 and modulo = 952 and id_item_filho = 7684;
update db_menu set menusequencia = 29 where id_item = 1818 and modulo = 952 and id_item_filho = 8679;
update db_menu set menusequencia = 30 where id_item = 1818 and modulo = 952 and id_item_filho = 8806;
update db_menu set menusequencia = 31 where id_item = 1818 and modulo = 952 and id_item_filho = 8827;
update db_menu set menusequencia = 32 where id_item = 1818 and modulo = 952 and id_item_filho = 9514;
update db_menu set menusequencia = 33 where id_item = 1818 and modulo = 952 and id_item_filho = 9793;

--97262
delete from db_syscadind    where codcam = 20869;
delete from db_sysindices   where codarq = 3755;
delete from db_sysprikey    where codarq = 3755;
delete from db_sysarqcamp   where codarq = 3755;
delete from db_syssequencia where codsequencia = 1000418;
delete from db_syscampodef  where codcam in (20869, 20870);
delete from db_syscampo     where codcam in (20869, 20870);
delete from db_sysarqmod    where codarq = 3755;
delete from db_sysarqarq    where codarq = 3755;
delete from db_sysarquivo   where codarq = 3755;

delete from db_sysforkey    where codcam = 20871;
delete from db_sysarqcamp   where codcam = 20871;
delete from db_syscampodef  where codcam = 20871;
delete from db_syscampo     where codcam = 20871;
----------------------------------------------------
---- Layout do arquivo de retorno do e-consig
----------------------------------------------------
delete from db_layoutcampos where db52_layoutlinha = 723;
delete from db_layoutlinha  where db51_codigo      = 723;
delete from db_layouttxt    where db50_codigo      = 220;
----------------------------------------------------
---- Relatório Importação
----------------------------------------------------
delete from db_sysarqcamp   where codcam = 20873;
delete from db_syscampo     where codcam = 20873;

----------------------------------------------------
---- Menu Relatório de Impotacao
----------------------------------------------------
delete from db_menu      where id_item_filho = 10019;
delete from db_itensfilho where id_item = 10019;
delete from db_itensmenu where id_item = 10019;

----------------------------------------------------
---- Insere as referências econsig
----------------------------------------------------
insert into db_sysforkey values (3676,20449,1,1153,0);
insert into db_sysforkey values (3677,20452,1,1177,0);
insert into db_sysforkey values (3677,20453,2,1177,0);

----------------------------------------------------
---- Remove campo nome na econsig
----------------------------------------------------
delete from db_sysarqcamp where codcam = 20880;
delete from db_syscampo   where codcam = 20880;


-----
-- Alteração Labels
-----
update db_syscampo set nomecam = 'r11_anousu', conteudo = 'int4', descricao = 'Ano do Exercício', valorinicial = '0', rotulo = 'Ano do Exercício', nulo = 'f', tamanho = 4, maiusculo = 'f', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Ano do Exercício' where codcam = 3758;
update db_syscampo set nomecam = 'r11_mesusu', conteudo = 'int4', descricao = 'Mês do Exercício', valorinicial = '0', rotulo = 'Mês do Exercício', nulo = 'f', tamanho = 2, maiusculo = 'f', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Mês do Exercício' where codcam = 3759;

----------------------------------------------------
---- FIM FOLHA
----------------------------------------------------

----------------------------------------------------
---- TRIBUTARIO
----------------------------------------------------

delete from db_menu where id_item_filho = 10003 AND modulo = 7808;
delete from db_menu where id_item_filho = 10002 AND modulo = 7808;
delete from db_menu where id_item_filho = 10001 AND modulo = 7808;
delete from db_menu where id_item_filho = 10000 AND modulo = 7808;
delete from db_syscadind where codind = 4137;
delete from db_sysindices where codind = 4137;
delete from db_sysforkey where codarq = 3752;
delete from db_sysforkey where codarq = 3752;
delete from db_sysprikey where codarq = 3752;
delete from db_sysarqcamp where codarq = 3752;
delete from db_syscampodef where codcam = 20850;
delete from db_syscampodep where codcam = 20850;
delete from db_sysforkey where codarq = 3751;
delete from db_sysprikey where codarq = 3751;
delete from db_sysarqcamp where codarq = 3751;
delete from db_sysforkey where codarq = 3744;
delete from db_sysprikey where codarq = 3750;
delete from db_sysarqcamp where codarq = 3750;
delete from db_syssequencia where codsequencia in ( 1000412,  1000413, 1000414 );
delete from db_syscampo where codcam in (20844, 20845);
delete from db_syscampo where codcam in (20846, 20847, 20848, 20849);
delete from db_syscampo where codcam in (20850, 20851, 20852);
delete from db_sysarqmod where codarq in ( 3750, 3751, 3752 );
delete from db_sysarquivo where codarq in ( 3750, 3751, 3752 );

delete from db_menu where id_item_filho in ( 10000, 10001, 10002, 10003 ) AND modulo = 7808;
delete from db_itensmenu where id_item in ( 10000, 10001, 10002, 10003 );

delete from db_syssequencia where codsequencia = 1000416;
delete from db_sysforkey  where codarq = 3754;
delete from db_sysprikey  where codarq = 3754;
delete from db_sysarqcamp where codarq = 3754;
delete from db_syscampo where codcam in (20863, 20864, 20865);
delete from db_sysarqmod where codarq  = 3754;
delete from db_sysarquivo where codarq = 3754;

delete from db_sysarqcamp where codarq = 3753;
delete from db_syssequencia where codsequencia = 1000415;
delete from db_sysforkey where codarq = 3753;
delete from db_syscampo where codcam in (20862, 20861, 20860, 20859);
delete from db_sysarqmod where codarq = 3753;
delete from db_sysarquivo where codarq = 3753;
delete from db_sysarqcamp where codcam in (20856, 20857, 20858, 20872);
delete from db_syscampo   where codcam in (20856, 20857, 20858, 20872);
update db_sysindices set nomeind = 'licencaempreendimento_sequencial_in',campounico = '1' where codind = 4126;
update db_syscampo set nomecam = 'am08_licencaanterior', conteudo = 'int4', descricao = 'Código da Licença Anterior a ser prorrogada ou renovada', valorinicial = '0', rotulo = 'Parecer Anterior', nulo = 't', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Licença Anterior' where codcam = 20808;
update db_sysarquivo set nomearq = 'licencaempreendimento', descricao = 'Cadastro de Emissao de Licenças', sigla = 'am08', dataincl = '2014-11-18', rotulo = 'Cadastro de Emissao de Licenças', tipotabela = 0, naolibclass = 'f', naolibfunc = 'f', naolibprog = 'f', naolibform = 'f' where codarq = 3744;

delete from db_menu where id_item = 30 and id_item_filho = 9981  and menusequencia = 440 and modulo = 7808;
delete from db_menu where id_item = 32 and id_item_filho = 10018 and menusequencia = 451 and modulo = 7808;
delete from db_itensmenu where id_item  = 10018;

delete from db_documentotemplatepadrao where db81_sequencial in ( 55, 56, 57 );
delete from db_documentotemplatetipo   where db80_sequencial in ( 52, 53, 54 );

update db_syscampo set nomecam = 'am08_sequencial', conteudo = 'int4', descricao = 'Cod. Licença', valorinicial = '0', rotulo = 'Cod. Licença', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Cod. Licença' where codcam = 20805;

----------------------------------------------------
---- FIM TRIBUTARIO
----------------------------------------------------