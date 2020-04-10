
---------------------------------------------------------------------------------------------
-------------------------------- INCIO FINANCEIRO -------------------------------------------
---------------------------------------------------------------------------------------------

delete from db_syssequencia where nomesequencia = 'classificacaocredoresempenho_cc31_sequencial_seq';
delete from db_sysforkey    where codarq = 3879 and codcam = 21601;
delete from db_sysforkey    where codarq = 3879 and codcam = 21600;
delete from db_sysprikey    where (codarq,codcam,sequen,camiden) = (3879,21599,1,21599);
delete from db_sysarqcamp   where ( codarq ,codcam ,seqarq ) = ( 3879 ,21602 ,4 );
delete from db_syscampo     where codcam = 21602 and nomecam = 'cc31_justificativa';
delete from db_sysarqcamp   where  ( codarq ,codcam ,seqarq ) = ( 3879 ,21601 ,3 );
delete from db_syscampo     where codcam = 21601 and nomecam = 'cc31_classificacaocredores';
delete from db_sysarqcamp   where ( codarq ,codcam ,seqarq ) = ( 3879 ,21600 ,2 );
delete from db_syscampo     where codcam = 21600 and nomecam = 'cc31_empempenho';
delete from db_sysarqcamp   where ( codarq ,codcam ,seqarq ) = ( 3879 ,21599 ,1 );
delete from db_syscampo     where codcam = 21599 and nomecam = 'cc31_sequencial';
delete from db_sysarqmod    where codmod = 38 and codarq = 3879;
delete from db_sysarquivo   where nomearq = 'classificacaocredoresempenho';

delete from db_syssequencia where nomesequencia = 'classificacaocredores_cc30_codigo_seq';
delete from db_sysprikey    where (codarq,codcam,sequen,camiden) = (3878,21597,1,21597);
delete from db_sysarqcamp   where ( codarq ,codcam ,seqarq ) = ( 3878 ,21598 ,2 );
delete from db_syscampo     where codcam = 21598 and nomecam = 'cc30_descricao';
delete from db_sysarqcamp   where ( codarq ,codcam ,seqarq ) = ( 3878 ,21597 ,1 );
delete from db_syscampo     where codcam = 21597 and nomecam = 'cc30_codigo';
delete from db_sysarqmod    where (codmod, codarq) = (38,3878);
delete from db_sysarquivo   where nomearq = 'classificacaocredores';

delete from db_sysarqcamp   where ( codarq ,codcam ,seqarq ) = ( 971 ,21596 ,12 );
delete from db_syscampo     where codcam = 21596 and nomecam = 'e69_localrecebimento';
delete from db_sysarqcamp   where ( codarq ,codcam ,seqarq ) = ( 971 ,21595 ,11 );
delete from db_syscampo     where codcam = 21595 and nomecam = 'e69_dtvencimento';

delete from db_menu where id_item_filho = 10177 AND modulo = 398;
delete from db_itensmenu where id_item = 10177;


delete from db_syssequencia where codsequencia = 1000530;
delete from db_syscadind where codind in (4298, 4299);
delete from db_sysindices where codind in (4298, 4299);
delete from db_sysprikey where codarq = 3883;
delete from db_sysforkey where codarq = 3883 and referen = 0;
delete from db_sysarqcamp where codarq = 3883;
delete from db_sysarqmod where codarq = 3883;
delete from db_sysforkey where codarq = 3883;
delete from db_sysarquivo where codarq = 3883;
delete from db_syscampo where codcam in (21613, 21614, 21615, 21616);

delete from db_itensfilho where id_item = 10178;
delete from db_menu where id_item_filho = 10178;
delete from db_itensmenu where id_item  = 10178;

update db_itensmenu set libcliente = 'true' where id_item = 5695;
delete from conencerramentotipo where c43_sequencial = 8;

update db_syscampo set conteudo = 'varchar(50)', tamanho = 50 where codcam = 5435;

update db_itensmenu set funcao = 'con4_inscricaorpsnaoprocessados001.php' where id_item = 9495;
update db_itensmenu set funcao = 'con4_inscricaorpsnaoprocessados001.php?lDesprocessar=true' where id_item = 9496;

update db_sysarquivo set nomearq = 'inscricaorestosapagarnaoprocessados', descricao = 'Inscrição de RP\'s não processados', rotulo = 'Inscrição de RP\'s não processados' where codarq = 3466;
delete from db_sysarqarq where codarq = 3466;
insert into db_sysarqarq values(0,3466);

delete from db_sysarqcamp where codarq = 3466;
delete from db_syscampo where codcam = 21627;
insert into db_sysarqcamp values(3466,19500,1,2341);
insert into db_sysarqcamp values(3466,19503,2,0);
insert into db_sysarqcamp values(3466,19504,3,0);
insert into db_sysarqcamp values(3466,19501,4,0);
insert into db_sysarqcamp values(3466,19502,5,0);

delete from db_menu where (id_item, id_item_filho, modulo) = (10179, 10181, 209);
delete from db_itensmenu  where id_item = 10181;
delete from db_menu where (id_item, id_item_filho, modulo) = (10179, 10180, 209);
delete from db_itensmenu where id_item = 10180;
delete from db_menu where (id_item, id_item_filho, modulo) = (9414, 10179, 209);
delete from db_itensmenu where id_item = 10179;
---------------------------------------------------------------------------------------------
-------------------------------- FIM FINANCEIRO---------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-------------------------------- INICIO CONFIGURACAO ----------------------------------------
---------------------------------------------------------------------------------------------

delete from db_sysarqcamp  where codcam = 21606;
delete from db_syscampo where codcam = 21606;

---------------------------------------------------------------------------------------------
-------------------------------- FIM CONFIGURACAO -------------------------------------------
---------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------
----------------------------------- INICIO EDUCACAO/SAUDE -----------------------------------------
---------------------------------------------------------------------------------------------------

delete from db_syscadind  where codind in (4296, 4295);
delete from db_sysindices where codind in (4296, 4295);
delete from db_sysforkey where codarq = 3881;
delete from db_sysprikey where codarq = 3881;
delete from db_sysarqcamp   where codarq = 3881;
delete from db_syssequencia where codsequencia = 1000528;
delete from db_syscampo     where codcam in (21607, 21608, 21609);
delete from db_sysarqmod    where codarq = 3881;
delete from db_sysarquivo   where codarq = 3881;

delete from db_sysarqcamp  where codarq = 2758 and codcam = 21617;
delete from db_syscampo    where codcam in (21617);

delete from db_syscampodef where codcam = 21618;
delete from db_sysarqcamp  where codcam = 21618;
delete from db_syscampo    where codcam = 21618;

insert into db_syscampo (codcam, nomecam, conteudo, descricao, valorinicial, rotulo, tamanho, nulo, maiusculo, autocompl, aceitatipo, tipoobj, rotulorel)
values (20989, 'ed320_licenca', 'bool', 'Define se uma ausência é classificada como licença.', 'false', 'Licença', 1, 'f', 'f', 'f', 5, 'text', 'Licença');

insert into db_sysarqcamp values(3540, 20989, 3, 0);

delete from db_syssequencia where codsequencia = 1000531;
delete from db_sysindices where codind in (4300,4301,4302,4303);
delete from db_syscadind where codind in (4300,4301,4302,4303);
delete from db_sysforkey where codarq = 3884;
delete from db_sysprikey where codarq = 3884;
delete from db_sysarqcamp where codarq = 3884;
delete from db_syscampodep where codcam = 21621;
delete from db_syscampodef where codcam = 21621;
delete from db_syscampo where codcam in (21619,21620,21621,21622,21623,21624,21625,21626);
delete from db_sysarqmod where codarq = 3884;
delete from db_sysarquivo where codarq = 3884;


delete from db_syssequencia where codsequencia in (1000532, 1000533);
delete from db_syscadind    where codind in (4305,4306,4304);
delete from db_sysindices   where codind in (4305,4306,4304);
delete from db_sysforkey    where codarq = 3886;
delete from db_sysprikey    where codarq in (3885, 3886);
delete from db_sysarqcamp   where codarq in (3885, 3886);
delete from db_syscampo     where codcam in (21628,21629,21630,21631,21632,21633);
delete from db_sysarqmod    where codarq in (3885, 3886);
delete from db_sysarquivo   where codarq in (3885, 3886);

delete from db_menu      where id_item_filho = 10182 AND modulo = 8167;
delete from db_itensmenu where id_item = 10182;

delete from db_sysarqcamp where codarq = 1010032;
delete from db_syscampo   where codcam = 21634;

---------------------------------------------------------------------------------------------------
----------------------------------- FIM EDUCACAO/SAUDE --------------------------------------------
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
----------------------------------- INICIO FOLHA --------------------------------------------------
---------------------------------------------------------------------------------------------------

delete from db_sysarqmod where  codarq in(3882, 3887);
delete from db_sysarqcamp where codarq in(3882, 3887);
delete from db_sysprikey where codarq  in(3882, 3887);
delete from db_sysforkey where codarq  in(3882, 3887);
delete from db_syscadind where codind in(4297, 4307);
delete from db_sysindices where codarq in(3882, 3887);
delete from db_syssequencia where codsequencia in( 1000529, 1000534);
delete from db_syscampo where codcam in(21612, 21611, 21635, 21636,21637);
delete from db_sysarquivo where codarq in(3882, 3887);
delete from db_menu where id_item_filho in(10176, 10183, 10184) AND modulo = 952;
delete from db_itensmenu where id_item in(10176, 10183, 10184);

delete from  db_sistemaexterno where db124_sequencial = 7;
---------------------------------------------------------------------------------------------------
----------------------------------- FIMFOLHA ------------------------------------------------------
---------------------------------------------------------------------------------------------------
