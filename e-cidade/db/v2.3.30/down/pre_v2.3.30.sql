/**
 * Arquivo pre down
 */
----------------------------------------------------
---- TIME FOLHA DE PAGAMENTO
----------------------------------------------------
---- Tarefa: 97163
----------------------------------------------------
UPDATE db_syscampo
SET descricao = 'Tipo de efetividade',
    rotulo    = 'Tipo de efetividade',
    rotulorel = 'Tipo de efetividade'
WHERE codcam = 4508;

----------------------------------------------------
---- TIME FOLHA DE PAGAMENTO
----------------------------------------------------
---- Tarefa: 96909
----------------------------------------------------

-- Atualizando posição dos menus retirando folha suplementar
UPDATE db_menu SET menusequencia = 1  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5016;
UPDATE db_menu SET menusequencia = 2  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 9767;
UPDATE db_menu SET menusequencia = 3  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5050;
UPDATE db_menu SET menusequencia = 4  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5047;
UPDATE db_menu SET menusequencia = 5  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5112;
UPDATE db_menu SET menusequencia = 6  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5156;
UPDATE db_menu SET menusequencia = 7  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 4504;
UPDATE db_menu SET menusequencia = 8  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 9958;
UPDATE db_menu SET menusequencia = 9  WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 9959;
UPDATE db_menu SET menusequencia = 10 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5036;
UPDATE db_menu SET menusequencia = 11 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5005;
UPDATE db_menu SET menusequencia = 12 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 4755;
UPDATE db_menu SET menusequencia = 13 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5106;
UPDATE db_menu SET menusequencia = 14 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5110;
UPDATE db_menu SET menusequencia = 15 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 8815;
UPDATE db_menu SET menusequencia = 16 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5204;
UPDATE db_menu SET menusequencia = 17 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5280;
UPDATE db_menu SET menusequencia = 18 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5305;
UPDATE db_menu SET menusequencia = 19 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5234;
UPDATE db_menu SET menusequencia = 20 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5136;
UPDATE db_menu SET menusequencia = 21 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 3516;
UPDATE db_menu SET menusequencia = 22 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 331384;
UPDATE db_menu SET menusequencia = 23 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 782400;
UPDATE db_menu SET menusequencia = 24 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 5196;
UPDATE db_menu SET menusequencia = 25 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 7150;
UPDATE db_menu SET menusequencia = 26 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 7570;
UPDATE db_menu SET menusequencia = 27 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 7684;
UPDATE db_menu SET menusequencia = 28 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 8679;
UPDATE db_menu SET menusequencia = 29 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 8806;
UPDATE db_menu SET menusequencia = 30 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 8827;
UPDATE db_menu SET menusequencia = 31 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 9514;
UPDATE db_menu SET menusequencia = 32 WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 9793;

-- Deletando posição do menu folha suplementar
DELETE FROM db_menu WHERE id_item = 1818 AND modulo = 952 AND id_item_filho = 9972;
DELETE FROM db_menu WHERE id_item = 9972 AND modulo = 952 AND id_item_filho IN (9973, 9974, 9975, 9976);

-- Delete de menus folha suplementar
DELETE FROM db_itensmenu WHERE id_item IN (9972, 9973, 9974, 9975, 9976);

-- Alteração de labels
UPDATE db_itensmenu SET descricao = 'Salário', help = 'Salário', desctec = 'Salário' WHERE id_item = 4506;
UPDATE db_itensmenu SET descricao = 'Salário', help = 'Salário', desctec = 'Salário' WHERE id_item = 4514;

/**
 * TRIBUTÁRIO
 */
--autolevanta
delete from db_syscadind    where codind = 4128;
delete from db_sysindices   where codind = 4128;
delete from db_syscadind    where codind = 4130;
delete from db_sysindices   where codind = 4130;
delete from db_syssequencia where codsequencia = 1000407;
delete from db_sysprikey    where codarq = 3746;
delete from db_sysforkey    where codarq = 3746;
delete from db_sysarqcamp   where codarq = 3746;
delete from db_syscampodef  where codcam in ( 20813, 20814, 20815 );
delete from db_syscampodep  where codcam in ( 20813, 20814, 20815 );
delete from db_syscampo     where codcam in ( 20813, 20814, 20815 );
delete from db_sysarqmod    where codmod = 25 and codarq = 3746;
delete from db_sysarquivo   where codarq = 3746;

delete from db_syscampodef  where codcam in ( 20812 );
delete from db_syscampodep  where codcam in ( 20812 );
delete from db_sysarqcamp   where codcam in ( 20812 );
delete from db_syscampo     where codcam in ( 20812 );

delete from db_syscampo     where codcam = 20824;
delete from db_sysarqcamp   where codcam = 20824;
delete from db_sysforkey    where codcam = 20824 and referen = 0;

delete from db_documentotemplatepadrao where db81_sequencial = 54;
delete from db_documentotemplatetipo   where db80_sequencial = 51;

--setorlocvalor
select fc_executa_ddl('delete from db_syscadind    where codind       = 4131;');
select fc_executa_ddl('delete from db_sysindices   where codind       = 4131;');
select fc_executa_ddl('delete from db_syssequencia where codsequencia = 1000408;');
select fc_executa_ddl('delete from db_sysprikey    where codarq       = 3747;');
select fc_executa_ddl('delete from db_sysforkey    where codarq       = 3747;');
select fc_executa_ddl('delete from db_sysarqcamp   where codarq       = 3747;');
select fc_executa_ddl('delete from db_syscampodef  where codcam       = 20760;');
select fc_executa_ddl('delete from db_syscampo     where codcam       in(20820,20821,20822,20823);');
select fc_executa_ddl('delete from db_sysarqmod    where codarq       = 3747;');
select fc_executa_ddl('delete from db_sysarquivo   where codarq       = 3747;');

 /**
 * FIM TRIBUTÁRIO
 */

----------------------------------------------------
---- TIME C
----------------------------------------------------

----------------------------------------------------
---- Tarefa: 95125
----------------------------------------------------
delete from db_sysarqcamp where codarq = 1010040 and codcam = 20756;
delete from db_syscampo   where codcam = 20756;

delete from db_syscadind    where codind       = 4116;
delete from db_sysindices   where codind       = 4116;
delete from db_syssequencia where codsequencia = 1000397;
delete from db_sysprikey    where codarq       = 3735;
delete from db_sysforkey    where codarq       = 3735;
delete from db_sysarqcamp   where codarq       = 3735;
delete from db_syscampodef  where codcam       = 20760;
delete from db_syscampo     where codcam       in(20759,20760,20761,20762,20763);
delete from db_sysarqmod    where codarq       = 3735;
delete from db_sysarquivo   where codarq       = 3735;

update db_itensmenu set id_item = 1100897 , descricao = 'Atividades' , help = 'Atividades' , funcao = 'edu1_atividaderh001.php' , itemativo = '1' , manutencao = '1' , desctec = 'Cadastro de Atividades' , libcliente = 'true' where id_item = 1100897;

delete from db_menu where id_item_filho = 1045399 AND modulo = 8167;
delete from db_menu where id_item_filho = 1045399 AND modulo = 8322;
delete from db_menu where id_item_filho = 1045399 AND modulo = 8481;
delete from db_menu where id_item_filho = 1045410 AND modulo = 8167;
delete from db_menu where id_item_filho = 1045410 AND modulo = 8322;
delete from db_menu where id_item_filho = 1045410 AND modulo = 8481;
delete from db_menu where id_item_filho = 1045411 AND modulo = 8167;
delete from db_menu where id_item_filho = 1045411 AND modulo = 8322;
delete from db_menu where id_item_filho = 1045411 AND modulo = 8481;
delete from db_menu where id_item_filho = 1045412 AND modulo = 8167;
delete from db_menu where id_item_filho = 1045412 AND modulo = 8322;
delete from db_menu where id_item_filho = 1045412 AND modulo = 8481;

insert into db_sysindices values( 3410, 'alunocensotipotransporte_aluno_in', 3362, '0' );
insert into db_sysindices values( 3411, 'alunocensotipotransporte_censotipotransporte_in', 3362, '0' );

update db_syscampo set maiusculo = 'f' where codcam = 19796;

----------------------------------------------------
--- Tarefa 10678
----------------------------------------------------
update db_itensmenu set libcliente = true where id_item = 8449;

----------------------------------------------------
--- Tarefa 92193
----------------------------------------------------
update db_syscampo
   set nomecam = 'ed62_percentualfrequencia',
       conteudo = 'int4',
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

DELETE FROM db_sysarqcamp where codarq = 1010157 and codcam = 20819;
DELETE FROM db_syscampo where codcam = 20819;

----------------------------------------------------
---- } FIM TIME C
----------------------------------------------------

----------------------------------------------------
---- TIME FINANCEIRO
----------------------------------------------------
---- Tarefa: 97055
----------------------------------------------------
delete from db_sysarqcamp   where codarq       = 1042 and codcam = 20753;
delete from db_syscampodef  where codcam       = 20753;
delete from db_syscampo     where codcam       = 20753;

delete from db_syssequencia where codsequencia = 1000399;
delete from db_syscadind    where codind       = 4117;
delete from db_sysindices   where codind       = 4117;
delete from db_sysforkey    where codarq       = 3738;
delete from db_sysprikey    where codarq       = 3738;
delete from db_sysarqcamp   where codarq       = 3738;
delete from db_syscampo     where codcam       in(20768,20771,20772);
delete from db_sysarqmod    where codarq       = 3738;
delete from db_sysarquivo   where codarq       = 3738;

delete from db_syssequencia where codsequencia = 1000398;
delete from db_syscadind    where codind       = 4115;
delete from db_sysindices   where codind       = 4115;
delete from db_sysforkey    where codarq       = 3736;
delete from db_sysprikey    where codarq       = 3736;
delete from db_sysarqcamp   where codarq       = 3736;
delete from db_syscampo     where codcam       in(20764,20765,20766);
delete from db_sysarqmod    where codarq       = 3736;
delete from db_sysarquivo   where codarq       = 3736;

update db_itensmenu set descricao = 'Alteração', funcao = 'com1_pcprocalt002.php' where id_item = 5025;
update db_itensmenu set descricao = 'Exclusão', funcao = 'com1_pcproc003.php' where id_item = 4201;

update db_syscampo set rotulo = 'Descrição departamento'       , rotulorel = 'Descrição departamento'        where codcam = 815;
update db_syscampo set rotulo = 'Data do Processo de Compras'  , rotulorel = 'Data do Processo de Compras'   where codcam = 6381;
update db_syscampo set rotulo = 'Código do Processo de Compras', rotulorel = 'Código do Processo de Compras' where codcam = 6380;
update db_syscampo set rotulo = 'numero da solicitacao'        , rotulorel = 'numero da solicitacao'         where codcam = 5542;

update db_itensmenu set descricao = 'Etiquetas Para Processos', help = 'Etiquetas Para Processos', funcao = 'pro4_impetiqueta001.php', itemativo = '1', desctec = 'Etiquetas Para Processos', libcliente = '1' where id_item = 4250;
delete from db_menu where id_item_filho = 9983 AND modulo = 604;
delete from db_menu where id_item_filho = 9982 AND modulo = 604;
delete from db_itensmenu where id_item in(9982, 9983);

update db_syscampo set rotulo = 'Código do orçamento',                    rotulorel = 'Código do orçamento '                    where codcam = 5512;
update db_syscampo set rotulo = 'Código do orçamento',                    rotulorel = 'Código do orçamento '                    where codcam = 5509;
update db_syscampo set rotulo = 'Prazo limite para entrega do orçamento', rotulorel = 'Prazo limite para entrega do orçamento'  where codcam = 5510;
update db_syscampo set rotulo = 'Hora limite para entrega do orçamento',  rotulorel = 'Hora limite para entrega do orçamento'   where codcam = 5511;
update db_syscampo set rotulo = 'Validade do Orcamento',                  rotulorel = 'Validade do Orcamento'                   where codcam = 10963;
update db_syscampo set rotulo = 'Prazo de Entrega de Produto',            descricao = 'Prazo de Entrega de Produto'             where codcam = 10962;

update db_itensmenu
   set descricao = 'Cadastro de Solicitações'
 where id_item = 3485;

----------------------------------------------------
---- Tarefa: 97148
----------------------------------------------------
delete from db_sysforkey where codarq = 3404 and referen = 3174;
delete from db_sysarqcamp where codcam in (20818);
delete from db_syscampo where codcam in (20818);

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
  values ( 19161 ,'m04_db_estruturavalor' ,'int4' ,'Grupo' ,'' ,'Grupo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Grupo' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3404 ,19161 ,3 ,0 );
insert into db_sysforkey values(3404,19161,1,3173,0);

delete from db_menu where id_item_filho = 9990 AND modulo = 480;
delete from db_menu where id_item_filho = 9991 AND modulo = 480;

delete from db_itensmenu where id_item in (9990, 9991);

delete from db_syscadind where codind = 4129;
delete from db_sysindices where codind = 4129;

insert into db_sysindices values(3511,'materialtipogrupovinculo_materialtipogrupo_in',3404,'1');
insert into db_syscadind values(3511,19160,1);

drop table if exists db_docparagpadrao_97148;
create temp table db_docparagpadrao_97148 as select db62_codparag as paragrafo from db_docparagpadrao where db62_coddoc in (select db60_coddoc from db_documentopadrao where db60_tipodoc = 5014);

delete from db_docparagpadrao where db62_coddoc in (select db60_coddoc from db_documentopadrao where db60_tipodoc = 5014);
delete from db_paragrafopadrao where db61_codparag in (select paragrafo from db_docparagpadrao_97148);
delete from db_documentopadrao where db60_tipodoc = 5014;
delete from db_tipodoc where db08_codigo = 5014;

delete from db_menu where id_item_filho = 9347 AND modulo = 480;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 9990 ,9347 ,3 ,439 );

update db_itensmenu set descricao = 'Anexo XX - Bens em Almoxarifado' , help = 'Anexo XX - Bens em Almoxarifado', desctec = 'Anexo XX - Bens em Almoxarifado' where id_item = 9347;
update db_itensmenu set descricao = 'Anexo XI - Arrolamento das Existências' , help = 'Anexo XI - Bens Patrimoniais - Arrolamento das Existências', desctec = 'Anexo XI - Bens Patrimoniais - Arrolamento das Existências' where id_item = 9341;
update db_itensmenu set descricao = 'Anexo XII - Dem. da Movimentação' , help = 'Anexo XII - Demonstrativo da Movimentação' , desctec = 'Anexo XII - Demonstrativo da Movimentação' where id_item = 9342;

update db_syscampo set maiusculo = 'f' where codcam = 19158;

update db_syscampo set descricao = 'Código Sequencial', rotulo = 'Código Sequencial', rotulorel = 'Código Sequencial' where codcam = 17969;

----------------------------------------------------
---- Tarefa: 97115
----------------------------------------------------
update db_itensmenu set funcao = 'com2_mapaorc001.php', help = '' , desctec = '' where id_item = 5013;
delete from db_menu      where id_item_filho = 9984 AND modulo = 28;
delete from db_menu      where id_item_filho = 9985 AND modulo = 28;
delete from db_itensmenu where id_item = 9984;
delete from db_itensmenu where id_item = 9985;

----------------------------------------------------
---- Tarefa: 97140
----------------------------------------------------
update db_itensmenu set funcao = 'cai2_modelo6delibtcerj001.php', descricao = 'Modelo 6 - Delib. 200/96 - TCE RJ' , help = 'Modelo 6 - Delib. 200/96 - TCE RJ' , desctec = 'Modelo 6 - Delib. 200/96 - TCE RJ' where id_item = 9433;
delete from db_menu      where id_item_filho = 9986 AND modulo = 39;
delete from db_menu      where id_item_filho = 9987 AND modulo = 39;
delete from db_menu      where id_item_filho = 9988 AND modulo = 39;
delete from db_menu      where id_item_filho = 9989 AND modulo = 39;
delete from db_itensmenu where id_item = 9986;
delete from db_itensmenu where id_item = 9987;
delete from db_itensmenu where id_item = 9988;
delete from db_itensmenu where id_item = 9989;

----------------------------------------------------
----------------------------------------------------
