---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

delete from db_menu where id_item_filho = 6981 AND modulo = 1100747;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1101103 ,6981 ,7 ,1100747 );

delete from db_menu where id_item_filho = 6982 AND modulo = 1100747;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1101103 ,6982 ,8 ,1100747 );

delete from db_menu where id_item_filho = 10252 AND modulo = 1100747;
delete from db_itensmenu where id_item = 10252;
delete from db_menu where id_item_filho = 10253 AND modulo = 1100747;
delete from db_itensmenu where id_item = 10253;

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------- INICIO FINANCEIRO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

delete from db_menu         where id_item_filho = 10254;
delete from db_itensmenu    where id_item = 10254;

delete from db_sysforkey    where codarq = 3954;
delete from db_syssequencia where nomesequencia = 'empnotasuspensao_cc36_sequencial_seq';
delete from db_sysprikey    where codarq = 3954;
delete from db_sysarqcamp   where codarq = 3954;
delete from db_syscampo     where codcam in(21966, 21967, 21968, 21969, 21970, 21971);
delete from db_sysarqmod    where codarq = 3954;
delete from db_sysarquivo   where codarq = 3954;

delete from db_itensfilho where id_item = 10262;
delete from db_itensmenu where id_item = 10262;
delete from db_menu  where id_item_filho = 10262;

delete from db_menu where id_item_filho = 10265;
delete from db_itensfilho where id_item = 10265;
delete from db_itensmenu where id_item = 10265;

---------------------------------------------------------------------------------------------------------------
--------------------------------------- FIM FINANCEIRO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------- INICIO TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

delete from db_sysarqcamp where codarq = 3859 and codcam = 21959;
delete from db_syscampo where codcam = 21959;

delete from db_menu where id_item_filho = 10256 and modulo = 1985522 and id_item = 9625;
delete from db_itensmenu where id_item = 10256;

delete from db_menu where id_item_filho = 10263 AND modulo = 1985522;
delete from db_itensmenu where id_item = 10263;

delete from db_itensmenu where id_item = 10264;
delete from db_menu where id_item_filho = 10264 AND modulo = 1985522;

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO FOLHA ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

-- Menu Evento financeiro Automático
delete from db_menu where id_item_filho = 10255 AND modulo = 952;
delete from db_itensmenu where id_item = 10255;

-- Tabela eventofinanceiroautomatico
delete from db_sysprikey where codarq = 3955;
delete from db_sysforkey where codarq = 3955;
delete from db_syscadind where codind = 4372;
delete from db_sysindices where codind = 4372;
delete from db_sysarqcamp where codarq = 3955;
delete from db_syscampo where codcam in (21972,21973,21974,21975,21976,21977);
delete from db_syssequencia where codsequencia = 1000590;
delete from db_sysarqmod where codarq = 3955;
delete from db_sysarquivo where codarq = 3955;

--
-- Melhoria para consignados
-- Menus
update db_itensmenu set id_item = 10232 , descricao = 'Consignados' where id_item = 10232;
delete from db_menu where id_item_filho IN (10032, 10066, 10059);
delete from db_menu where id_item_filho IN (10232, 9866, 10049, 10238, 10234, 10235, 10231);
delete from db_menu where id_item_filho IN (10257, 10258, 10259, 10260, 10261) OR id_item IN (10257, 10258, 10259, 10260, 10261);
delete from db_itensmenu where id_item IN (10257, 10258, 10259, 10260, 10261);

insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (5106, 10049, 17, 952);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (5106, 10232, 18, 952);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (5106,  9866, 15, 952);

insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (10232, 10234, 1, 952);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (10232, 10238, 2, 952);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (10232, 10235, 3, 952);

insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (1818, 10032, 105, 952);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (1818, 10059, 106, 952);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (1818, 10066, 107, 952);

insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (3516, 10231, 14, 952);

delete from db_menu where id_item_filho IN (10257, 10258, 10260, 10261) OR id_item IN (10257, 10258, 10260, 10261, 10270);
delete from db_itensmenu where id_item IN (10270, 10271, 10272, 10273, 10274, 10275, 10276);

delete from db_menu where id_item_filho IN (10277, 10278, 10279, 10280, 10281) OR id_item IN (10277, 10278, 10279, 10280, 10281);
delete from db_itensmenu where id_item IN (10277, 10278, 10279, 10280, 10281);

update db_itensmenu set funcao = regexp_replace(funcao::varchar, '(.*\.php).*', '\\1') where id_item IN (10061,10032,10060,10234,10235,10231,10238,10066);


--TABELA
delete from db_syscadind where codind = 4374;
delete from db_sysindices where codind = 4374;
delete from db_sysforkey where codarq = 3956;
delete from db_sysprikey where codarq = 3956;
delete from db_syssequencia where codsequencia = 1000591;
delete from db_sysarqcamp where codarq = 3956;
delete from db_syscampodef where codcam = 21980;
delete from db_syscampo where codcam IN (21978, 21979, 21980, 21981, 21982, 21983);
delete from db_sysarqmod where codarq = 3956;
delete from db_sysarquivo where codarq = 3956;

delete from db_sysarqcamp where codarq = 3785 and codcam IN (21984, 21985, 21986);
delete from db_syscampo where codcam IN (21984, 21985, 21986);

delete from db_syscadind where codcam in (21955, 21956, 21957, 21958, 21944, 21945, 21950);
delete from db_sysindices where codind in (4366, 4367, 4368, 4369, 4364, 4363);
delete from db_sysforkey where codcam in (21955, 21956, 21957, 21958, 21944, 21945, 21950);
delete from db_sysprikey where codcam in (21941, 21943);
delete from db_sysarqcamp
      where codcam in (21941, 21942, 21943, 21950, 21944, 21945, 21946, 21947, 21948, 21949, 21955, 21956, 21957, 21963, 21964, 21958);
delete from db_syssequencia where codsequencia in (1000585, 1000586);
delete from db_syscampo
      where codcam in(21941, 21942, 21943, 21950, 21944, 21945, 21946, 21947, 21948, 21949, 21955, 21956, 21957, 21958, 21963, 21964);
delete from db_sysarqmod where codmod = 28 and codarq in(3950 ,3951);
delete from db_sysarquivo where codarq in(3950, 3951);
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL FOLHA ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO SAUDE ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
delete from db_sysarqcamp where codarq = 1010144 and codcam = 21987;
delete from db_syscampo where codcam = 21987;
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL SAUDE ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------