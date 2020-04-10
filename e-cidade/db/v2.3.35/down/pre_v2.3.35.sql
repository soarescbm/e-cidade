----- TRIBUTARIO ------
delete from db_sysarqcamp where codarq = 18 and codcam = 20929;
delete from db_syscampo   where codcam = 20929;

delete from db_sysarqcamp   where codarq in (3770, 3771);
delete from db_syssequencia where codsequencia in (1000429, 1000428);
delete from db_sysforkey    where codarq in (3770, 3771);
delete from db_sysprikey    where codarq in (3770, 3771);
delete from db_syscampo     where codcam in (20933,20934,20935,20936,20937,20938);
delete from db_sysarqmod    where codarq in (3770, 3771);
delete from db_sysarquivo   where codarq in (3770, 3771);
----- FIM TRIBUTARIO ------

---------------------------
------- TIME C ------------
---------------------------
delete from db_syscadind    where codind in (4148, 4149, 4150, 4151, 4152);
delete from db_sysindices   where codind in (4148, 4149, 4150, 4151, 4152);
delete from db_sysarqcamp   where codarq in (3773, 3772);
delete from db_sysarqcamp   where codarq = 1010134 and codcam = 20943;
delete from db_syssequencia where codsequencia in (1000430, 1000431);
delete from db_sysforkey    where codarq in (3772, 3773);
delete from db_sysforkey    where codarq = 1010134 and codcam = 20943;
delete from db_sysprikey    where codarq in (3773, 3772);
delete from db_syscampodef  where codcam in (20942, 20951);
delete from db_syscampo     where codcam in (20939, 20940, 20941, 20942, 20943, 20944, 20945, 20946, 20947, 20948, 20949, 20950, 20951);
delete from db_sysarqmod    where codarq in (3772, 3773);
delete from db_sysarquivo   where codarq in (3772, 3773);

delete from db_itensfilho where id_item in (10036, 10037, 10038) and codfilho in (5839, 5840, 5841, 5836, 5837, 5838);
delete from db_arquivos where codfilho in (5839, 5840, 5841, 5836, 5837, 5838);
delete from db_menu where modulo = 1000004 and id_item in (3470, 10035) and id_item_filho in (10035, 10036, 10037, 10038);
delete from db_processa where codarq = 3772 and id_item in (10035, 10036, 10037, 10038);
delete from db_itensmenu where id_item in (10035, 10036, 10037, 10038);

delete from db_menu where id_item_filho = 10039 AND modulo = 1000004;
delete from db_itensmenu where id_item = 10039;

-- Requisição de exames ---
delete from db_sysarqmod where codarq = 3776;
delete from db_sysprikey where codarq = 3776;
delete from db_sysforkey where codarq = 3776;
delete from db_syscadind where codind in (4160,4161);
delete from db_sysindices where codind in (4160,4161);
delete from db_sysarqcamp where codarq = 3776;
delete from db_syssequencia where codsequencia = 1000434;
delete from db_syscampodef where codcam in (20966,20967,20968);
delete from db_syscampo where codcam in (20966,20967,20968);
delete from db_sysarquivo where codarq = 3776;

delete from db_menu where id_item_filho = 10041 AND modulo = 1000004;
delete from db_itensmenu where id_item = 10041;

delete from db_sysarqcamp where codarq = 1006042;
delete from db_syscampo   where codcam = 20969;

insert into db_sysindices (codind, nomeind, codarq, campounico) values (2847, 'sau_triagemavulsa_s152_cbosprof_in', 3043, 0);
delete from db_sysarqcamp where codarq = 3043 and codcam = 20973;
delete from db_syscampo where codcam = 20973;
insert into db_syscadind  (codind, codcam, sequen ) values (2847, 17213, 1);

delete from db_sysarqcamp  where codarq = 3781;
delete from db_syscampodef where codcam in (20984, 20983, 20985, 20986);
delete from db_sysforkey   where codarq = 3781;
delete from db_sysprikey   where codarq = 3781;
delete from db_syssequencia where codsequencia = 1000439;
delete from db_syscadind  where codind = 4165;
delete from db_sysindices where codind = 4165;
delete from db_syscampo   where codcam in (20984, 20983, 20985, 20986);
delete from db_sysarquivo where codarq = 3781;

delete from db_menu where id_item_filho = 10046 AND modulo = 1100747;
delete from db_itensmenu where id_item = 10046;

update db_syscampo set descricao = 'Data em que foi feito o agendamento na prestadora.', rotulo = 'Data Prot./Agend.', rotulorel = 'Data Prot./Agend.' where codcam = 16398;
---------------------------
------- FIM TIME C --------
---------------------------

----- TRIBUTARIO DAEB ------

delete from db_itensmenu where id_item = 10034;
delete from db_menu where id_item_filho = 10034 AND modulo = 1985522;

----- FIM TRIBUTARIO DAEB------

---------------------------
--------  TIME NFSE -------
---------------------------

delete from db_syscadind where codind in (4153,4154,4155,4156,4157);
delete from db_sysindices where codind in (4153,4154,4155,4156,4157);
delete from db_sysarqcamp where codarq in (3774);
delete from db_syssequencia where codsequencia in (1000432);
delete from db_syscampodef where codcam in (20952,20954,20955,20959);
delete from db_syscampodep where codcam in (20952,20954,20955,20957,20958,20959);
delete from db_sysprikey where codarq in (3774);
delete from db_sysforkey where codarq in (3774);
delete from db_syscampo where codcam in (20952,20953,20954,20955,20956,20957,20958,20959);
delete from db_sysarqmod where codarq in (3774);
delete from db_sysarquivo where codarq in (3774);

-- Removido apenas o vinculo com o item principal do menu
delete from db_menu where id_item_filho = 3889 AND modulo = 40;
delete from db_menu where id_item_filho = 3890 AND modulo = 40;
delete from db_menu where id_item_filho = 3891 AND modulo = 40;

---------------------------
------ FIM TIME NFSE ------
---------------------------

-------------------------------
------ INÍCIO TIME FOLHA ------
-------------------------------
-- Alterando menus
UPDATE db_itensmenu
   SET descricao = 'Processamento Dados do Ponto',
       help      = 'Processamento Dados do Ponto'
 WHERE id_item   = 10032;


delete
  from db_menu
 where id_item       = 10042
    or id_item_filho = 10042;
delete
  from db_ìtensmenu
 where id_item       = 10042;

-- Tabela "rhpessoalmov"
delete from db_sysforkey    where codcam = 20972;
delete from db_sysarqcamp   where codcam = 20972;
delete from db_syscampo     where codcam = 20972;

-- Tabela "tipodeficiencia"
delete from db_syscadind    where codcam = 20970;
delete from db_sysindices   where codind = 4162;
delete from db_sysprikey    where codcam = 20970;
delete from db_syssequencia where codsequencia = 1000435;
delete from db_sysarqcamp   where codcam in (20970, 20971);
delete from db_syscampo     where codcam in (20970, 20971);
delete from db_sysarqmod    where codarq = 3777;
delete from db_sysarquivo   where codarq = 3777;


-- Menu
delete from db_menu      where id_item_filho = 10043;
delete from db_itensmenu where id_item = 10043;

update db_menu set menusequencia = 1  where id_item = 5106 and modulo = 952 and id_item_filho = 5098;
update db_menu set menusequencia = 2  where id_item = 5106 and modulo = 952 and id_item_filho = 5000;
update db_menu set menusequencia = 3  where id_item = 5106 and modulo = 952 and id_item_filho = 5107;
update db_menu set menusequencia = 6  where id_item = 5106 and modulo = 952 and id_item_filho = 5733;
update db_menu set menusequencia = 7  where id_item = 5106 and modulo = 952 and id_item_filho = 48643;
update db_menu set menusequencia = 8  where id_item = 5106 and modulo = 952 and id_item_filho = 228040;
update db_menu set menusequencia = 9  where id_item = 5106 and modulo = 952 and id_item_filho = 268991;
update db_menu set menusequencia = 10 where id_item = 5106 and modulo = 952 and id_item_filho = 608584;
update db_menu set menusequencia = 11 where id_item = 5106 and modulo = 952 and id_item_filho = 7761;
update db_menu set menusequencia = 12 where id_item = 5106 and modulo = 952 and id_item_filho = 8747;
update db_menu set menusequencia = 15 where id_item = 5106 and modulo = 952 and id_item_filho = 8756;
update db_menu set menusequencia = 16 where id_item = 5106 and modulo = 952 and id_item_filho = 8779;
update db_menu set menusequencia = 17 where id_item = 5106 and modulo = 952 and id_item_filho = 9847;
update db_menu set menusequencia = 18 where id_item = 5106 and modulo = 952 and id_item_filho = 9866;
update db_menu set menusequencia = 19 where id_item = 5106 and modulo = 952 and id_item_filho = 9935;

----------------------------
------ FIM TIME FOLHA ------
----------------------------
