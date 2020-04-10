------------------------------------------------------------------------------------
------------------------------ INICIO TRIBUTARIO -----------------------------------
------------------------------------------------------------------------------------
delete from db_menu where id_item_filho = 10164 AND modulo = 4066;
delete from db_itensmenu where id_item = 10164;
------------------------------------------------------------------------------------
------------------------------ FIM TRIBUTARIO --------------------------------------
------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------
------------------------------- INICIO TIME EDUCACAO / SAUDE --------------------------------
---------------------------------------------------------------------------------------------

-- DADOS DO dml_98788.sql
delete from db_menu where id_item_filho = 7998 AND modulo = 6952;
delete from db_menu where id_item_filho = 7998 AND modulo = 6877;
delete from db_menu where id_item_filho = 7998 AND modulo = 8167;
delete from db_menu where id_item_filho = 7998 AND modulo = 8322;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 3470 ,7998 ,34 ,6952 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 3470 ,7998 ,35 ,6877 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8170 ,7998 ,15 ,8167 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8323 ,7998 ,11 ,8322 );

-- DADOS DO dml_98785.sql
update db_syscampo set nomecam = 'ed18_i_cnpj', conteudo = 'varchar(14)', descricao = 'CNPJ', valorinicial = 'null', rotulo = 'CNPJ', nulo = 't', tamanho = 14, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'CNPJ' where codcam = 12619;
delete from db_syscampodep where codcam = 12619;
delete from db_syscampodef where codcam = 12619;
update db_syscampo set nomecam = 'ed18_i_cnpjmantprivada', conteudo = 'varchar(14)', descricao = 'CNPJ Mantenedora Privada', valorinicial = 'null', rotulo = 'CNPJ Mantenedora Privada', nulo = 't', tamanho = 14, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'CNPJ Mantenedora Privada' where codcam = 17985;
delete from db_syscampodep where codcam = 17985;
delete from db_syscampodef where codcam = 17985;
update db_syscampo set nomecam = 'ed18_i_cnpjprivada', conteudo = 'varchar(14)', descricao = 'CNPJ da Escola Privada', valorinicial = 'null', rotulo = 'CNPJ da Escola Privada', nulo = 't', tamanho = 14, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'CNPJ da Escola Privada' where codcam = 13455;
delete from db_syscampodep where codcam = 13455;
delete from db_syscampodef where codcam = 13455;

delete from db_sysprikey    where codarq        = 3877;
delete from db_sysarqcamp   where codarq        = 3877;
delete from db_syscampo     where codcam in (21594, 21591, 21592, 21593);
delete from db_sysarqmod    where codarq        = 3877;
delete from db_sysarquivo   where codarq        = 3877;
delete from db_menu         where id_item_filho = 10173 AND modulo = 1100747;
delete from db_menu         where id_item_filho = 10174 AND modulo = 7159;
delete from db_itensmenu    where id_item in (10173, 10174);
delete from db_syssequencia where codsequencia  = 1000525;

------------------------------------------------------------------------------------
--------------------------------- FIM TIME EDUCACAO / SAUDE ------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
------------------------------ INICIO FINANCEIRO -----------------------------------
------------------------------------------------------------------------------------

delete from db_menu where id_item = 5602  and id_item_filho = 7760;
delete from db_menu where id_item = 30    and id_item_filho = 10166;
delete from db_menu where id_item = 10166 and id_item_filho = 9785;
delete from db_menu where id_item = 10166 and id_item_filho = 9784;
delete from db_itensmenu where id_item = 10166;

delete from db_menu where id_item_filho = 10168 AND modulo = 439;
delete from db_itensmenu where id_item = 10168;


select setval('matestoquetipo_m81_codtipo_seq', (select max(m81_codtipo) from matestoquetipo));
delete from matestoquetipo where m81_codtipo in (23,24,25,26);
alter table matestoquetipo alter column m81_descr type varchar(40);

-- planilha de distribuição
delete from db_syssequencia where nomesequencia = 'planilhadistribuicaomaterial_pd03_sequencial_seq';
delete from db_syssequencia where nomesequencia = 'planilhadistribuicaodepart_pd02_sequencial_seq';
delete from db_syssequencia where nomesequencia = 'planilhadistribuicao_pd01_sequencial_seq';

delete from db_syscadind where (codind, codcam, sequen) = (4294,21586,1);
delete from db_sysindices where nomeind = 'planilhadistribuicaodepart_planilhadistribuicao_in';

delete from db_syscadind where (codind, codcam, sequen) = (4293,21587,1);
delete from db_sysindices where nomeind = 'planilhadistribuicaodepart_departamento_in';

delete from db_sysforkey where (codarq, codcam, sequen, referen) = (3875,21587,1,154);
delete from db_sysforkey where (codarq, codcam, sequen, referen) = (3875,21586,1,3874);

delete from db_sysprikey where (codarq,codcam,sequen,camiden) = (3875,21585,1,21585);

delete from db_syscadind where (codind, codcam, sequen) = (4292,21590,1);
delete from db_sysindices where nomeind = 'planilhadistribuicaomaterial_material_in';

delete from db_syscadind where (codind, codcam, sequen) = (4291,21589,1);
delete from db_sysindices where nomeind = 'planilhadistribuicaomaterial_planilhadistribuicao_in';

delete from db_sysforkey where (codarq, codcam, sequen, referen) = (3876,21589,1,3874);
delete from db_sysforkey where (codarq, codcam, sequen, referen) = (3876,21590,1,1016);

delete from db_sysprikey where (codarq,codcam,sequen,camiden) = (3874,21583,1,21583);
delete from db_sysprikey where (codarq,codcam,sequen,camiden) = (3876,21588,1,21588);

delete from db_sysarqcamp where ( codarq ,codcam ,seqarq) = ( 3876 ,21590 ,3 );
delete from db_syscampo where codcam = 21590 and nomecam = 'pd03_material';

delete from db_sysarqcamp where ( codarq ,codcam ,seqarq) = ( 3876 ,21589 ,2);
delete from db_syscampo where codcam = 21589 and nomecam = 'pd03_planilhadistribuicao';

delete from db_sysarqcamp where ( codarq ,codcam ,seqarq ) = ( 3876 ,21588 ,1 );
delete from db_syscampo where codcam = 21588 and nomecam = 'pd03_sequencial';

delete from db_sysarqarq where codarq = 3876 and codarqpai = 3874;
delete from db_sysarqmod where codmod = 13 and codarq = 3876;
delete from db_sysarquivo where codarq = 3876 and nomearq = 'planilhadistribuicaomaterial';

delete from db_sysarqcamp where ( codarq ,codcam ,seqarq ) = ( 3875 ,21587 ,3);
delete from db_syscampo where ( codcam ,nomecam ) = ( 21587 ,'pd02_departamento');

delete from db_sysarqcamp where ( codarq ,codcam ,seqarq ) = ( 3875 ,21586 ,2 );
delete from db_syscampo where ( codcam ,nomecam ) = ( 21586 ,'pd02_planilhadistribuicao');

delete from db_sysarqcamp where ( codarq ,codcam ,seqarq ) = ( 3875 ,21585 ,1 );
delete from db_syscampo where ( codcam ,nomecam ) = ( 21585 ,'pd02_sequencial');

delete from db_sysarqarq where codarq = 3875 and codarqpai = 3874;
delete from db_sysarqmod where codmod = 13 and codarq = 3875;
delete from db_sysarquivo where codarq = 3875 and nomearq = 'planilhadistribuicaodepart';

delete from db_sysarqcamp where  ( codarq ,codcam ,seqarq ) = ( 3874 ,21584 ,2 );
delete from db_syscampo where ( codcam ,nomecam) = ( 21584 ,'pd01_descricao');

delete from db_sysarqcamp where ( codarq ,codcam ,seqarq ) = ( 3874 ,21583 ,1 );
delete from db_syscampo where ( codcam ,nomecam) = ( 21583 ,'pd01_sequencial');

delete from db_sysarqmod where codmod = 13 and codarq = 3874;
delete from db_sysarquivo where codarq = 3874 and nomearq = 'planilhadistribuicao';

-- menus
delete from db_menu where( id_item ,id_item_filho ,menusequencia ,modulo ) = ( 10169 ,10170 ,1 ,480 );
delete from db_itensmenu where id_item = 10170;

delete from db_menu where ( id_item ,id_item_filho ,menusequencia ,modulo ) = ( 10169 ,10171 ,2 ,480 );
delete from db_itensmenu where id_item = 10171;

delete from db_menu where ( id_item ,id_item_filho ,menusequencia ,modulo ) = ( 10169 ,10172 ,3 ,480 );
delete from db_itensmenu where id_item = 10172;

delete from db_menu where ( id_item ,id_item_filho ,menusequencia ,modulo ) = ( 32 ,10169 ,463 ,480 );
delete from db_itensmenu where id_item = 10169;

-- fim planilha distribuição

delete from db_menu where (id_item, id_item_filho, menusequencia, modulo) = (9198, 3963, 1, 28);
delete from db_menu where (id_item, id_item_filho, menusequencia, modulo) = (9198, 3964, 2, 28);
delete from db_menu where (id_item, id_item_filho, menusequencia, modulo) = (9198, 3965, 3, 28);

insert into db_menu values(3962, 3964, 2, 28);
insert into db_menu values(3962, 3965, 3, 28);
insert into db_menu values(3962, 3963, 1, 28);

insert into db_menu values(9198, 3962, 1, 28);

------------------------------------------------------------------------------------
------------------------------ FIM FINANCEIRO --------------------------------------
------------------------------------------------------------------------------------
