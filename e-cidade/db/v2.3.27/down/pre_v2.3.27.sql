/**
 * TIME B
 */


/**
 * TIME C - INICIO
 */
/* { 95317 - INICIO} */

delete from db_syssequencia where codsequencia = 1000382 and nomesequencia = 'sau_triagemavulsaagravo_s167_sequencial_seq';
delete from db_sysforkey    where codarq = 3722;
delete from db_sysprikey    where codarq = 3722;
delete from db_sysarqcamp   where codarq = 3722;
delete from db_syscampo     where codcam = 20678;
delete from db_syscampo     where codcam = 20679;
delete from db_syscampo     where codcam = 20680;
delete from db_syscampo     where codcam = 20681;
delete from db_syscampo     where codcam = 20682;
delete from db_sysarqmod    where codarq = 3722;
delete from db_sysarquivo   where codarq = 3722;

delete from db_menu      where id_item_filho = 9956 AND modulo = 1000004;
delete from db_itensmenu where id_item = 9956;

/* { 95317 - FIM} */

/* {94085} */
delete from db_docparagpadrao  where db62_coddoc   = 225 and db62_codparag = 520;
delete from db_paragrafopadrao where db61_codparag = 520;
delete from db_documentopadrao where db60_coddoc   = 225;
delete from db_tipodoc         where db08_codigo   = 5013;
/* {94085} fim */

/* { 94085B - INICIO} */
delete from db_sysarqcamp  where codarq = 2175;
delete from db_syscampo    where codcam = 20684;
delete from db_syscampodef where codcam = 20683;
delete from db_syscampo    where codcam = 20683;
/* { 94085B - FIM} */

/* {96026 - INICIO}*/
delete from db_sysarqcamp where codarq = 1010031;
delete from db_syscampo   where codcam = 20689;
/* {96026 - FIM}*/

/* {95317} - INICIO */
update db_itensmenu set id_item = 8635 , descricao = 'Triagem Avulsa' , help = 'Triagem Avulsa' , funcao = 'sau4_sau_triagemavulsa001.php' , itemativo = '1' , manutencao = '1' , desctec = 'Triagem avulsa.' , libcliente = 'true' where id_item = 8635;
/* {95317} - FIM*/

/**
 * TIME C - FIM
 */


/*
 * TIME FOLHA
 */
--
-- Tarefa 91675 - Parametrização do arquivo bancário
--
--HEADER ARQUIVO
update db_layoutcampos set db52_default = '' where db52_codigo = 521;
update db_layoutcampos set db52_default = '' where db52_codigo = 516;
update db_layoutcampos set db52_default = '' where db52_codigo = 509;
update db_layoutcampos set db52_default = '' where db52_codigo = 621;
update db_layoutcampos set db52_default = '' where db52_codigo = 619;
update db_layoutcampos set db52_default = '' where db52_codigo = 495;
update db_layoutcampos set db52_default = '' where db52_codigo = 494;

--Detalhe B
update db_layoutcampos set db52_default = '' where db52_codigo = 599;
update db_layoutcampos set db52_default = '' where db52_codigo = 598;
update db_layoutcampos set db52_default = '' where db52_codigo = 597;
update db_layoutcampos set db52_default = '' where db52_codigo = 596;
update db_layoutcampos set db52_default = '' where db52_codigo = 595;
update db_layoutcampos set db52_default = '' where db52_codigo = 579;

--Header Lote
update db_layoutcampos set db52_default = '' where db52_codigo = 524;

--Detalhe A
update db_layoutcampos set db52_default = ''  where db52_codigo = 558;
update db_layoutcampos set db52_default = '' where db52_codigo = 552;

--Trailer Lote
update db_layoutcampos set db52_default = ''    where db52_codigo = 602;
update db_layoutcampos set db52_default = '' where db52_codigo = 633;

--Trailer Arquivo
update db_layoutcampos set db52_default = '' where db52_codigo = 617;
update db_layoutcampos set db52_default = ''    where db52_codigo = 611;

--Tabela Afasta
delete from db_sysarqcamp where codarq = 525 and codcam = 14489 and seqarq = 11 and codsequencia = 0;
delete from db_sysforkey where codarq = 525 and codcam = 3635 and sequen = 1 and referen = 1153 and tipoobjrel = 0;

  --73953
delete from db_sysarqcamp where codarq = 1153;
delete from db_syscampo   where codcam = 20685;

--Relatorio Reajuste Paridade
delete from db_relatorio where db63_sequencial = 28;

delete from db_itensmenu where id_item = 9957;
delete from db_menu where id_item_filho = 9957 AND modulo = 952;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 2456 ,9957 ,35 ,952 );


update db_itensmenu set libcliente = true where id_item = 4109;

-- Nome do campo pesquisa #73953
update db_syscampo set rotulo = 'Cod. Instituição', rotulorel = 'Cod. Instituição' where codcam = 9906;

/* Menus Desativados devido a solicitacao da ISSUE #829 no redmine */
update db_itensmenu set libcliente = true where id_item in(268994, 4070, 5735, 94, 4398, 3973, 3999, 3843, 4204, 3506, 3772);

/**
 * Time financeiro - OBN
 */
alter table errobanco drop column e92_empagetipotransmissao;

delete from db_sysarqcamp where codcam = 20690;
delete from db_sysforkey where codcam = 20690;
delete from db_syscampo where codcam = 20690;

drop table if exists finalidadepagamentofundeb;
drop sequence if exists finalidadepagamentofundeb_e151_sequencial_seq;

drop table if exists empagetipotransmissao;
drop sequence if exists empagetipotransmissao_e57_sequencial_seq;

/**
 * Time Financeiro - FIM
 */
