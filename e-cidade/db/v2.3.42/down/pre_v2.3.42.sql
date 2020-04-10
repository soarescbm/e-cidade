select fc_executa_ddl('insert into db_menu (id_item,  id_item_filho, menusequencia , modulo) values (    1818 ,          9793 ,            34 ,    952);');
select fc_executa_ddl('insert into db_menu (id_item,  id_item_filho, menusequencia , modulo) values (      29 ,          9788 ,           255 ,    952);');
select fc_executa_ddl('insert into db_menu (id_item,  id_item_filho, menusequencia , modulo) values (    9790 ,          9791 ,             1 ,    952);');
select fc_executa_ddl('insert into db_menu (id_item,  id_item_filho, menusequencia , modulo) values (    9790 ,          9792 ,             2 ,    952);');
select fc_executa_ddl('insert into db_menu (id_item,  id_item_filho, menusequencia , modulo) values (    9793 ,          9794 ,             1 ,    952);');
select fc_executa_ddl('insert into db_menu (id_item,  id_item_filho, menusequencia , modulo) values (    9788 ,          9789 ,             1 ,    952);');
select fc_executa_ddl('insert into db_menu (id_item,  id_item_filho, menusequencia , modulo) values (    9788 ,          9827 ,             3 ,    952);');
select fc_executa_ddl('insert into db_menu (id_item,  id_item_filho, menusequencia , modulo) values (    9788 ,          9790 ,             2 ,    952);');
select fc_executa_ddl('insert into db_menu (id_item,  id_item_filho, menusequencia , modulo) values (    9793 ,          9795 ,             2 ,    952);');
delete from db_menu where id_item_filho in(9788, 9788, 9827, 9789, 9790, 9791, 9792) AND modulo = 2323;
delete from db_menu where id_item_filho = 9794 AND modulo = 2323;
delete from db_menu where id_item_filho = 9795 AND modulo = 2323;
delete from db_menu where id_item_filho = 9795 AND modulo = 952;
delete from db_menu where id_item_filho  in(10156, 10157, 10158) AND modulo = 2323;
delete from db_itensmenu   where id_item in(10157, 10156, 10158);

-- tabela tipoassentamentoferias
delete from db_syscadind where codind in(4288, 4287);
delete from db_sysindices where codind in(4288, 4287);
delete from db_syssequencia where codsequencia = 1000520;
delete from db_sysprikey where codarq = 3872;
delete from db_sysforkey where codarq = 3872;
delete from db_sysarqcamp where  codarq = 3872;
delete from db_syscampo where codcam in(21573, 21574,21575);
delete from db_sysarqmod where codarq = 3872;
delete from db_sysarquivo where codarq = 3872;


-- tabela rhferiasperiodoassentamento
delete from db_syscadind where codind in(4289, 4290);
delete from db_sysindices where codind in(4289, 4290);
delete from db_syssequencia where codsequencia = 1000521;
delete from db_sysprikey where codarq = 3873;
delete from db_sysforkey where codarq = 3873;
delete from db_sysarqcamp where  codarq = 3873;
delete from db_syscampo where codcam in(21576, 21577,21578);
delete from db_sysarqmod where codarq = 3873;
delete from db_sysarquivo where codarq = 3873;
delete from db_menu where id_item_filho = 9788 AND modulo = 2323;

-- Criação dos menus para Processamento de Férias e Rubricas para escala de férias
delete from db_menu where id_item_filho in (10159, 10160);
delete from db_itensmenu where id_item in (10159, 10160);

--Criação do campo para a rubrica de escala de ferias
delete from db_sysarqcamp where codcam  = 21582;
delete from db_syscampo where codcam = 21582;
