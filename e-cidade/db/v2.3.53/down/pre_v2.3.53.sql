---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
delete from db_sysarqcamp where codcam = 21910;
delete from db_syscampo where codcam = 21910;

delete from db_syscadind    where codcam = 21926;
delete from db_sysindices   where codind = 4362;
delete from db_syssequencia where codsequencia = 1000583;
delete from db_sysprikey    where codarq = 3948;
delete from db_sysforkey    where codarq = 3948;
delete from db_sysarqmod    where codarq = 3948;
delete from db_sysarqcamp   where codarq = 3948;
delete from db_syscampodep  where codcam in (21925, 21926);
delete from db_syscampodef  where codcam in (21925, 21926);
delete from db_syscampo     where codcam in (21925, 21926);
delete from db_sysarquivo   where codarq = 3948;

delete from db_sysarqcamp where codcam = 21927;
delete from db_sysforkey  where codcam = 21927;
delete from db_syscampo   where codcam = 21927;

delete from db_sysarqcamp where codcam = 21939;
delete from db_sysarqcamp where codcam = 21940;
delete from db_syscampo   where codcam = 21939;
delete from db_syscampo   where codcam = 21940;

---------------------------------------------------------------------------------------------------------------
----------------------------------------- FINAL EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO FINANCEIRO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
delete from db_sysarqmod  where codarq in (3945, 3952);
delete from db_sysarqcamp where codarq in (3945, 3952);
delete from db_syscadind  where codind in (4359, 4365);
delete from db_sysprikey  where codarq in (3945, 3952);
delete from db_sysforkey  where codarq in (3945, 3952);

delete from db_sysindices where codind in (4359, 4365);
delete from db_syssequencia where codsequencia in (1000580, 1000587) ;
delete from db_syscampodef where codcam in (21953);
delete from db_syscampo where codcam in (21911, 21912, 21913, 21922, 21951, 21952, 21953);
delete from db_sysarquivo where codarq in (3945, 3952);

delete from db_menu where id_item = 4343 and id_item_filho = 10249;
delete from db_itensfilho where id_item = 10249;
delete from db_itensmenu where id_item = 10249;

delete from db_errobanco where e78_errobanco in (select e92_sequencia from errobanco where e92_empagetipotransmissao = 3);
delete from errobanco where e92_sequencia between 115 and 266;

delete from empagemovtipotransmissao where e25_empagetipotransmissao = 3;
delete from empagetipotransmissao where e57_sequencial = 3;


---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL FINANCEIRO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------------- INICIO SAÚDE ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
delete from db_itensmenu where id_item in(10247, 10248);
delete from db_menu where id_item_filho in(10247, 10248);
update db_itensmenu set descricao = 'Exportação Hórus' where id_item = 10115;
delete from db_syscadind where codind = 4360;
delete from db_sysindices where codind = 4360;
delete from db_syssequencia where codsequencia = 1000581;
delete from db_sysforkey where codarq = 3946;
delete from db_sysprikey where codarq = 3946;
delete from db_sysarqcamp where codarq = 3946;
delete from db_syscampo where codcam in(21914, 21915, 21916, 21917);
delete from db_sysarqmod where codarq = 3946;
delete from db_sysarquivo where codarq = 3946;
---------------------------------------------------------------------------------------------------------------
--------------------------------------------- FINAL SAÚDE -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO TRIBUTARIO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
delete from db_sysforkey where codarq = 153 and codcam in (21918, 21919);
delete from db_sysarqcamp where codarq = 153 and codcam in (21918, 21919);
delete from db_syscampo where codcam in (21918, 21919);

update iptucadlogcalc set j62_erro = true where j62_codigo = 27;

delete from db_sysprikey where codarq = 3949;
delete from db_sysarqcamp where codarq = 3949 and codcam = 21928;
delete from db_syscampodef where codcam = 21928;
delete from db_syscampo where codcam = 21928;

delete from db_sysarqcamp where codarq = 3949 and codcam = 21929;
delete from db_syscampodef where codcam = 21929;
delete from db_syscampo where codcam = 21929;

delete from db_syscampodef where codcam = 21930;
delete from db_sysarqcamp where codarq = 3949 and codcam = 21930;
delete from db_syscampo where codcam = 21930;

delete from db_syscampodef where codcam = 21931;
delete from db_sysarqcamp where codarq = 3949 and codcam = 21931;
delete from db_syscampo where codcam = 21931;

delete from db_syscampodef where codcam = 21932;
delete from db_sysarqcamp where codarq = 3949 and codcam = 21932;
delete from db_sysforkey where codarq = 3949 and referen = 0;
delete from db_sysforkey where codarq = 3949 and codcam = 21932;
delete from db_syscampo where codcam = 21932;

delete from db_syssequencia where codsequencia = 1000584;
delete from db_sysarqmod where codmod = 54 and codarq = 3949;
delete from db_sysarquivo where codarq = 3949;


---------------------------------------------------------------------------------------------------------------
---------------------------------------- FIM TRIBUTARIO -------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO FOLHA ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
delete from db_layoutcampos where db52_codigo in (13751, 13752, 13753, 13754, 13755, 13756, 13757);

delete from db_sysarqcamp where codcam in(21933,21934,21935,21936,21937,21938);
delete from db_syscampodef where codcam in (21934, 21935, 21936);
delete from db_syscampo where codcam in (21933,21934,21935,21936,21937,21938);
update db_syscampo set nulo = false where codcam = 21801;
update db_syscampo set nulo = false where codcam = 21802;
delete from db_sysarqcamp where codcam = 21954;
delete from  db_syscampo where codcam = 21954;
delete from db_menu where id_item_filho in(10250, 10114, 10113, 10251) AND modulo = 2323;


update db_itensmenu set descricao = 'Autorização de Assentamentos' , help = 'Autorização de Assentamentos' where id_item = 10114;
update db_itensmenu set descricao = 'Agenda de Assentamentos' , help = 'Agenda de Assentamentos' where id_item = 10113;
delete from db_itensmenu where id_item in(10250, 10251);
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FIM FOLHA ------------------------------------------------------------