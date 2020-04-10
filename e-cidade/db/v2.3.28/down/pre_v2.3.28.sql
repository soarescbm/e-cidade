/**
 * Arquivo pre down
 */

----------------------------------------------------
---- TIME FOLHA DE PAGAMENTO
----------------------------------------------------
---- Tarefa: 93695
----------------------------------------------------

delete from db_sysarqcamp   where codarq = 3724;
delete from db_sysforkey    where codarq = 3724;
delete from db_syscadind    where codind = 4099;
delete from db_sysindices   where codind = 4099;
delete from db_sysprikey    where codarq = 3724;
delete from db_syssequencia where codsequencia = 1000384;
delete from db_syscampo     where codcam in (20691,20692,20693,20694);
delete from db_sysarqmod    where codarq = 3724;
delete from db_sysarquivo   where codarq = 3724;

--Removendo campo baseconsignada na tabela cfpess
delete from db_sysforkey    where codarq = 536 and referen = 530 and codcam in (20695,3758,3759,9892);
delete from db_sysarqcamp   where codarq = 536 and codcam = 20695;
delete from db_syscampo     where codcam = 20695;
delete from db_sysarqcamp   where codcam = 17759;
delete from db_syscampodef  where codcam = 17759;

----------------------------------------------------
---- Tarefa: 96909 - Folha Complementar
----------------------------------------------------

--Alteração de Labels
update db_syscampo set rotulo = 'Código da Rubrica' where codcam = 7104;

--Folha Pagamento
delete from db_syscadind where codind = 4105;
delete from db_sysindices where codind = 4105;
delete from db_syscadind where codind = 4104;
delete from db_sysindices where codind = 4104;
delete from db_syssequencia where codsequencia = 1000390;
delete from db_sysforkey where codarq = 3727;
delete from db_sysprikey where codarq = 3727;
delete from db_sysarqcamp where codarq = 3727;
delete from db_syscampo where codcam in (20706,20707,20708,20709,20710,20711,20712,20713,20714);
delete from db_sysarqmod where codarq = 3727;
delete from db_sysarquivo where codarq = 3727;

--Tipo Folha
delete from db_syssequencia where codsequencia = 1000389;
delete from db_sysprikey where codarq = 3728;
delete from db_sysarqcamp where codarq = 3728;
delete from db_syscampodef where codcam = 20716;
delete from db_syscampo where codcam in (20715,20716,20717);
delete from db_sysarqmod where codarq = 3728;
delete from db_sysarquivo where codarq = 3728;

--Historico Ponto
delete from db_syscadind    where codind in (4108,4110);
delete from db_sysindices   where codind in (4108,4110);
delete from db_syssequencia where codsequencia = 1000391;
delete from db_sysforkey    where codarq = 3730;
delete from db_sysprikey    where codarq = 3730;
delete from db_sysarqcamp   where codcam in (20723,20724,20725,20726,20727,20731,20735);
delete from db_syscampo     where codcam in (20723,20724,20725,20726,20727,20731,20735);
delete from db_sysarqmod    where codarq = 3730;
delete from db_sysarquivo   where codarq = 3730;

--Historico Calculo
delete from db_syscadind    where codind in (4107, 4109);
delete from db_sysindices   where codind in (4107, 4109);
delete from db_syssequencia where codsequencia = 1000392;
delete from db_sysforkey where codarq = 3729;
delete from db_sysprikey where codarq = 3729;
delete from db_sysarqcamp where codarq = 3729;
delete from db_syscampo     where codcam in (20718,20719,20720,20721,20722,20730);
delete from db_sysarqmod where codarq = 3729;
delete from db_sysarquivo where codarq = 3729;

--Criação de Menus
update db_menu set menusequencia = 1 where id_item = 1818 and modulo = 952 and id_item_filho = 5016;
update db_menu set menusequencia = 2 where id_item = 1818 and modulo = 952 and id_item_filho = 9767;
update db_menu set menusequencia = 3 where id_item = 1818 and modulo = 952 and id_item_filho = 5050;
update db_menu set menusequencia = 4 where id_item = 1818 and modulo = 952 and id_item_filho = 5047;
update db_menu set menusequencia = 5 where id_item = 1818 and modulo = 952 and id_item_filho = 5112;
update db_menu set menusequencia = 6 where id_item = 1818 and modulo = 952 and id_item_filho = 5156;
update db_menu set menusequencia = 7 where id_item = 1818 and modulo = 952 and id_item_filho = 4504;
update db_menu set menusequencia = 8 where id_item = 1818 and modulo = 952 and id_item_filho = 5036;
update db_menu set menusequencia = 9 where id_item = 1818 and modulo = 952 and id_item_filho = 5005;
update db_menu set menusequencia = 10 where id_item = 1818 and modulo = 952 and id_item_filho = 4755;
update db_menu set menusequencia = 11 where id_item = 1818 and modulo = 952 and id_item_filho = 5106;
update db_menu set menusequencia = 12 where id_item = 1818 and modulo = 952 and id_item_filho = 5110;
update db_menu set menusequencia = 13 where id_item = 1818 and modulo = 952 and id_item_filho = 8815;
update db_menu set menusequencia = 14 where id_item = 1818 and modulo = 952 and id_item_filho = 5204;
update db_menu set menusequencia = 15 where id_item = 1818 and modulo = 952 and id_item_filho = 5280;
update db_menu set menusequencia = 16 where id_item = 1818 and modulo = 952 and id_item_filho = 5305;
update db_menu set menusequencia = 17 where id_item = 1818 and modulo = 952 and id_item_filho = 5234;
update db_menu set menusequencia = 18 where id_item = 1818 and modulo = 952 and id_item_filho = 5136;
update db_menu set menusequencia = 19 where id_item = 1818 and modulo = 952 and id_item_filho = 3516;
update db_menu set menusequencia = 20 where id_item = 1818 and modulo = 952 and id_item_filho = 331384;
update db_menu set menusequencia = 21 where id_item = 1818 and modulo = 952 and id_item_filho = 782400;
update db_menu set menusequencia = 22 where id_item = 1818 and modulo = 952 and id_item_filho = 5196;
update db_menu set menusequencia = 23 where id_item = 1818 and modulo = 952 and id_item_filho = 7150;
update db_menu set menusequencia = 24 where id_item = 1818 and modulo = 952 and id_item_filho = 7570;
update db_menu set menusequencia = 25 where id_item = 1818 and modulo = 952 and id_item_filho = 7684;
update db_menu set menusequencia = 26 where id_item = 1818 and modulo = 952 and id_item_filho = 8679;
update db_menu set menusequencia = 27 where id_item = 1818 and modulo = 952 and id_item_filho = 8806;
update db_menu set menusequencia = 28 where id_item = 1818 and modulo = 952 and id_item_filho = 8827;
update db_menu set menusequencia = 29 where id_item = 1818 and modulo = 952 and id_item_filho = 9514;
update db_menu set menusequencia = 30 where id_item = 1818 and modulo = 952 and id_item_filho = 9793;

delete from db_menu where id_item = 1818 and modulo = 952 and id_item_filho = 9958;
delete from db_itensmenu where id_item = 9958;

delete from db_menu where id_item = 1818 and modulo = 952 and id_item_filho = 9959;
delete from db_itensmenu where id_item = 9959;

delete from db_menu where id_item = 9958 and modulo = 952 and id_item_filho = 9960;
delete from db_itensmenu where id_item = 9960;

delete from db_menu where id_item = 9958 and modulo = 952 and id_item_filho = 9961;
delete from db_itensmenu where id_item = 9961;

delete from db_menu where id_item = 9958 and modulo = 952 and id_item_filho = 9962;
delete from db_itensmenu where id_item = 9962;

delete from db_menu where id_item = 9958 and modulo = 952 and id_item_filho = 9963;
delete from db_itensmenu where id_item = 9963;

delete from db_menu where id_item = 9959 and modulo = 952 and id_item_filho = 9964;
delete from db_itensmenu where id_item = 9964;

delete from db_menu where id_item = 9959 and modulo = 952 and id_item_filho = 9965;
delete from db_itensmenu where id_item = 9965;

--Validação do campo regist alterado.

update db_syscampo set aceitatipo = 0 where codcam = 4325;
update db_syscampo set aceitatipo = 0 where codcam = 7024;

---------------------
-- T96970
---------------------
delete from db_sysarqcamp where codcam = 20737;
delete from db_syscampodef where codcam = 20737;
delete from db_syscampo where codcam = 20737;

----------------------------------------------------
---- Tarefa: Acerto Redmine Issue: 102184
----------------------------------------------------
update db_syscampo set nomecam = 'rh02_seqpes', conteudo = 'int4', descricao = 'Sequência do cadastro de pessoal.', valorinicial = '0', rotulo = 'Sequência', nulo = 'f', tamanho = 6, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Sequência' where codcam = 7021;

----------------------------------------------------
---- TIME FINANCEIRO {
----------------------------------------------------

delete from db_sysarqcamp where codarq = 3726;
delete from db_sysarqarq where codarq = 3726;
delete from db_sysforkey where codarq = 3726;
delete from db_syscadind  where codind = 4103;
delete from db_sysindices where codind = 4103;
delete from db_sysprikey where codarq = 3726;
delete from db_syssequencia where codsequencia in (1000386, 1000387);
delete from db_syscampo where codcam in (20702, 20703, 20704, 20705);
delete from db_sysarqmod where codarq = 3726;
delete from db_sysarquivo where codarq = 3726;
delete from contacorrente where c17_sequencial in(100, 101, 102, 103, 104, 105, 106, 107, 108);

delete from db_sysforkey where codarq = 3492 and codcam = 20734 and sequen = 1 and referen = 758;
delete from db_sysforkey where codarq = 3492 and codcam = 20733 and sequen = 2 and referen = 758;

delete from db_sysarqcamp where codarq = 3492 and codcam = 20732 and seqarq = 17;
delete from db_sysarqcamp where codarq = 3492 and codcam = 20733 and seqarq = 18;
delete from db_sysarqcamp where codarq = 3492 and codcam = 20734 and seqarq = 19;

delete from db_syscampo where codcam in (20732, 20733, 20734);



delete from db_itensfilho where id_item in(9970, 9969, 9968);

delete from db_menu where id_item in (9971, 9969);
delete from db_menu where id_item_filho = 9971;
delete from db_itensmenu where id_item in (9971,9970,9969);

delete from db_itensfilho where id_item = 9967 and codfilho = 1;
delete from db_menu where id_item = 6819 and id_item_filho = 9966;
delete from db_menu where id_item = 9966 and id_item_filho = 9967;
delete from db_itensmenu where id_item in (9966, 9967);

delete from db_itensfilho where id_item = 9968 and codfilho = 1;
delete from db_menu where id_item = 9966 and id_item_filho = 9968;
delete from db_itensmenu where id_item = 9968;

/* tipodespacho INICIO */

delete from db_syscadind where codind = 4112;
delete from db_sysindices where codind = 4112;
delete from db_sysprikey where codarq = 3732;
delete from db_syssequencia where codsequencia = 1000394;
delete from db_sysarqcamp where codarq = 3732;
delete from db_syscampodef where codcam = 20747;
delete from db_syscampo where codcam in (20746, 20747);
delete from db_syscampodef where codcam = 20746;
delete from db_sysarqmod where codarq = 3732;
delete from db_sysarquivo where codarq = 3732;

delete from db_sysforkey where codcam = 20751 and codarq = 1059;
delete from db_sysarqcamp where codarq = 1059 and codcam = 20751;
delete from db_syscampo where codcam = 20751;

alter table procandamint drop column p78_tipodespacho;
drop table tipodespacho;
drop sequence tipodespacho_p100_sequencial_seq;

/* procandamint - fim */

update db_syscampo set nomecam = 'm40_codigo', conteudo = 'int8', descricao = 'Código Requisição', valorinicial = '0', rotulo = 'Código da Requisição', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Código da Requisição' where codcam = 6865;
update db_syscampo set nomecam = 'm42_codigo', conteudo = 'int8', descricao = 'Código Atendimento', valorinicial = '0', rotulo = 'Código de Atendimento', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Código de Atendimento' where codcam = 6876;
update db_syscampo set nomecam = 'm40_login', conteudo = 'int4', descricao = 'Cód. usuário', valorinicial = '0', rotulo = 'Usuário', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Cod. Usuário' where codcam = 6868;
update db_syscampo set nomecam = 'id_usuario', conteudo = 'int4', descricao = 'codigo do usuario', valorinicial = '0', rotulo = 'Cod Usuário', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Cod. Usuário' where codcam = 568;
update db_syscampo set nomecam = 'login', conteudo = 'varchar(20)', descricao = 'login do usuario', valorinicial = '', rotulo = 'login do usuario', nulo = 'f', tamanho = 20, maiusculo = 'f', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'login do usuario' where codcam = 571;

----------------------------------------------------
---- } FIM TIME FINANCEIRO
----------------------------------------------------

----------------------------------------------------
---- TIME C
----------------------------------------------------
update db_sysarqmod set codmod = 1008004 where codmod = 1000004 and codarq = 2556;

update db_syscampo set nomecam = 's103_c_emitirfaa', conteudo = 'char(1)', descricao = 'Gerar FA automatica', valorinicial = 'N', rotulo = 'Gerar FA automatica', nulo = 'f', tamanho = 1, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Gerar FA automatica' where codcam = 14590;
update db_syscampo set nomecam = 's103_i_todacomp', conteudo = 'int4', descricao = 'Campo para que o usuário selecione se deseja apresentar os procedimento com a última competência ou não. 2-NÃO(default) 1-SIM', valorinicial = '0', rotulo = 'Apresentar Todas Competência', nulo = 'f', tamanho = 1, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Apresentar Todas Competência' where codcam = 18471;

----------------------------------------------------
---- Tarefa: 995483
----------------------------------------------------

delete from db_sysarqcamp where codarq = 1010144 and codcam = 20729;
delete from db_syscampo   where codcam = 20729;

update db_syscampo set aceitatipo = 2                   where codcam = 1008854;
update db_syscampo set aceitatipo = 0, maiusculo = true where codcam = 1008857;
update db_syscampo set aceitatipo = 0, maiusculo = true where codcam = 1008864;


----------------------------------------------------
---- Tarefa: 95540
----------------------------------------------------
update db_itensmenu set libcliente = true where id_item in (8887, 8888, 8889, 8890, 8891, 8892, 8893, 8894);
update db_syscampo set conteudo = 'float4' where codcam in (18218, 18219, 18220, 18221);



delete from db_listadump where db54_tabela = 'grupotaxa';

ALTER TABLE grupotaxa DISABLE TRIGGER ALL;
DELETE FROM grupotaxa;
insert into grupotaxa values  (1, 1, 'CUSTAS PROCESSUAIS');

ALTER TABLE grupotaxa ENABLE TRIGGER ALL;

select setval('grupotaxa_ar37_sequencial_seq', 1);

----------------------------------------------------
---- SAUDE
----------------------------------------------------
---- Tarefa: 95051
----------------------------------------------------
delete from db_sysarqcamp where codarq = 2905 and codcam = 20738;
delete from db_syscampo where codcam = 20738;
  
----------------------------------------------------
---- Tarefa: 96976
----------------------------------------------------
update db_syscampo set nomecam = 'h50_confobs', conteudo = 'int4', descricao = 'Conforme Observação', valorinicial = '0', rotulo = 'Conforme observação', nulo = 't', tamanho = 1, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'select', rotulorel = 'Conforme observação' where codcam = 10853;
update db_syscampo set nomecam = 'h50_minimopontos', conteudo = 'int4', descricao = 'Mínino de pontos para aprovação.', valorinicial = '0', rotulo = 'Mínimo de Pontos', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Mínimo de Pontos' where codcam = 10942;

-------------------------------------------------------------------------------
--                                INTEGRACAO                                 --
-------------------------------------------------------------------------------

delete from db_sysarqcamp where codarq = 3725;
delete from db_sysarqarq where codarq = 3725;
delete from db_sysforkey where codarq = 3725;
delete from db_syscadind  where codind in (4101, 4102);
delete from db_sysindices where codind in (4101, 4102);
delete from db_sysprikey where codarq = 3725;
delete from db_syssequencia where codsequencia = 1000385;
delete from db_syscampo where codcam in (20696, 20697, 20698, 20699);
delete from db_sysarqmod where codarq = 3725;
delete from db_sysarquivo where codarq = 3725;
