--
-- Versão: $Id: pre_v2.3.47.sql,v 1.10 2016/01/28 13:26:51 dbrenan.silva Exp $
--

/****************************************************************************************************************
 * =====================================  Folha de Pagamento (Pessoal/RH) ===================================== *
 ****************************************************************************************************************/
---------------------------
--Cálculo de RRA pra DIRF--
---------------------------
delete from db_sysprikey    where codarq       in (3889, 3890, 3891, 3892, 3893, 3894, 3895, 3896);
delete from db_syssequencia where codsequencia in (1000535, 1000536, 1000537, 1000538, 1000539, 1000540, 1000541, 1000542);
delete from db_syscampodep  where codcam       in (21664, 21647, 21648, 21649, 21650, 21651, 21652, 21653, 21655, 21656, 21657, 21658, 21659, 21660, 21661, 21662, 21663,21665, 21667, 21668, 21669, 21685, 21670, 21671, 21672, 21673, 21674, 21674, 21675, 21676, 21677, 21678, 21678, 21679, 21680, 21681, 21682);
delete from db_sysarqcamp   where codarq = 536 and codcam = 21698;
delete from db_sysarqcamp   where codarq       in (3889, 3890, 3891, 3892, 3893, 3894, 3895, 3896);
delete from db_syscadind    where codcam       in (21664, 21647, 21648, 21649, 21650, 21651, 21652, 21653, 21655, 21656, 21657, 21658, 21659, 21660, 21661, 21662, 21663,21665, 21667, 21668, 21669, 21685, 21670, 21671, 21672, 21673, 21674, 21674, 21675, 21676, 21677, 21678, 21678, 21679, 21680, 21681, 21682, 21648);
delete from db_sysindices   where codarq       in (3889, 3890, 3891, 3892, 3893, 3894, 3895, 3896);
delete from db_sysforkey    where codarq = 536 and codcam = 21698;
delete from db_sysforkey    where codarq       in (3889, 3890, 3891, 3892, 3893, 3894, 3895, 3896);
delete from db_syscampo     where codcam       in (21664, 21647, 21648, 21649, 21650, 21651, 21652, 21653, 21655, 21656, 21657, 21658, 21659, 21660, 21661, 21662, 21663,21665, 21667, 21668, 21669, 21685, 21670, 21671, 21672, 21673, 21674, 21674, 21675, 21676, 21677, 21678, 21678, 21679, 21680, 21681, 21682, 21698, 21703);
delete from db_sysarqmod    where codarq       in (3889, 3890, 3891, 3892, 3893, 3894, 3895, 3896);
delete from db_sysarquivo   where codarq       in (3889, 3890, 3891, 3892, 3893, 3894, 3895, 3896);

delete from tipoasse where h12_natureza = 3;
delete from naturezatipoassentamento where rh159_sequencial = 3;

delete from db_menu      where id_item_filho in (10200, 10201, 10202, 10203) AND modulo = 952;
delete from db_itensmenu where id_item in (10200, 10201, 10202, 10203);

---------------------------------------------------------------------------------------------
-------------------------------- INICIO TRIBUTARIO ------------------------------------------
---------------------------------------------------------------------------------------------
update db_itensmenu set descricao = 'Incluir Unica Individual' where  id_item = 9065;
update db_itensmenu set descricao = 'Incluir Unica Geral'      where  id_item = 9066;

delete from db_menu where id_item_filho = 10195;
delete from db_menu where id_item_filho = 10196;
delete from db_menu where id_item_filho = 10197;
delete from db_menu where id_item_filho = 10198;

delete from db_itensmenu where id_item in (10195, 10196, 10197, 10198);

/**
 * Garantindo que não haverá problema com o DOWN
 */
delete from db_menu where (id_item, id_item_filho, menusequencia, modulo) in ( ( 9062, 9065, 2, 1985522 ), ( 9062, 9066, 3, 1985522 )) ;

insert into db_menu ( id_item, id_item_filho, menusequencia, modulo ) values ( 9062, 9065, 2, 1985522 ), ( 9062, 9066, 3, 1985522 );

delete from vistretornocalc where y04_codmsg = 25;

select fc_executa_ddl('insert into db_syscampo values(19156, \'j43_iptuendergrupo\', \'int4\', \'Grupo de endereço de entrega\', 0, \'Grupo de endereço de entrega\', 10, \'t\', \'f\',\'f\', 1, \'text\', \'Grupo de endereço de entrega\')');
select fc_executa_ddl('insert into db_sysarqcamp values (32, 19156, 11, 0)');
select fc_executa_ddl('insert into db_sysforkey values(32, 19156,1,3402,0)');

delete from iptucadlogcalc where j62_codigo = 114;

delete from db_sysarqcamp where codarq = 358;

delete from db_syscampo where codcam = 21701;

-------------------------------------------------------------------------------------------
---------------------------------- FIM TRIBUTARIO -------------------------------------------
---------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------
----------------------------------- INICIO EDUCACAO/SAUDE -----------------------------------------
---------------------------------------------------------------------------------------------------

select fc_executa_ddl('delete from db_syscadind    where codind in (4317, 4318);');
select fc_executa_ddl('delete from db_sysindices   where codind in (4317, 4318);');
select fc_executa_ddl('delete from db_sysforkey    where codarq = 3899;');
select fc_executa_ddl('delete from db_sysprikey    where codarq = 3899;');
select fc_executa_ddl('delete from db_sysarqcamp   where codarq = 3899;');
select fc_executa_ddl('delete from db_syssequencia where codsequencia = 1000544;');
select fc_executa_ddl('delete from db_syscampo     where codcam in (21691, 21692, 21693, 21694);');
select fc_executa_ddl('delete from db_sysarqmod    where codarq = 3899;');
select fc_executa_ddl('delete from db_sysarquivo   where codarq = 3899;');

select fc_executa_ddl('delete from db_sistemaexterno where db124_sequencial = 8;');

delete from db_docparagpadrao where db62_coddoc = 251;
delete from db_paragrafopadrao where db61_codparag in (546,547,548);
delete from db_documentopadrao where db60_coddoc = 251;
delete from db_tipodoc where db08_codigo = 5024;
---------------------------------------------------------------------------------------------------
------------------------------------- FIM EDUCACAO/SAUDE ------------------------------------------
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-------------------------------- INICIO CONFIGURACAO ----------------------------------------
---------------------------------------------------------------------------------------------

delete from db_sysarqcamp where codarq = 3898;
delete from db_syscampodef where codcam = 21686;
delete from db_syscampodef where codcam = 21687;
delete from db_syscampodef where codcam = 21688;
delete from db_sysarqmod where codarq = 3898;

delete from db_sysprikey where codarq = 3898;
delete from db_sysforkey where codarq = 3898;

delete from db_syscampo where codcam in (21686 ,21687 ,21688);
delete from db_syssequencia where codsequencia = 1000543;

delete from db_syscadind where codind in (4315, 4316);
delete from  db_sysindices where codind in (4315, 4316);

delete from db_sysarquivo where codarq = 3898;

delete from db_sysarqcamp where codcam = 21696;
delete from db_syscampo where codcam = 21696;

delete from db_sysarqcamp where codcam = 21697;
delete from db_syscampo where codcam = 21697;
---------------------------------------------------------------------------------------------
---------------------------------- FIM CONFIGURACAO -----------------------------------------
---------------------------------------------------------------------------------------------