---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

delete from db_itensfilho where id_item  in (10283, 10284, 10285);
delete from db_arquivos   where codfilho in ( 5858, 5860, 5861, 5862, 5863, 5859);
delete from db_processa   where id_item  in (10283, 10284, 10285, 10282);
delete from db_menu       where id_item in (10282, 10282, 10282);
delete from db_menu       where id_item_filho = 10282 and id_item = 3470;

delete from db_menu where modulo = 1100747 and id_item_filho in (10288, 10289, 10290);
delete from db_menu where id_item_filho = 10287 AND modulo = 1100747;
delete from db_itensmenu  where id_item in (10282, 10283, 10284, 10285, 10287, 10288, 10289, 10290);

delete from db_sysprikey    where codarq = 3960;
delete from db_syssequencia where codsequencia = 1000595;
delete from db_syscadind    where codind = 4378;
delete from db_sysindices   where codind = 4378;
delete from db_sysarqcamp   where codarq = 3960;
delete from db_syscampo     where codcam in (22011, 22012);
delete from db_sysarqmod    where codarq = 3960;
delete from db_sysarquivo   where codarq = 3960;

delete from db_syssequencia where codsequencia = 1000596;
delete from db_syscadind    where codind = 4379;
delete from db_sysindices   where codind = 4379;
delete from db_sysforkey  where codarq  = 3961;
delete from db_sysprikey  where codarq  = 3961;
delete from db_sysarqcamp where codarq  = 3961;
delete from db_syscampo where codcam in (22013, 22014, 22015, 22016, 22017, 22018);
delete from db_sysarqmod  where codarq = 3961;
delete from db_sysarquivo where codarq = 3961;

delete from db_syssequencia where codsequencia = 1000597;
delete from db_syscadind    where codind = 4380;
delete from db_sysindices   where codind = 4380;
delete from db_sysforkey where codarq = 3962;
delete from db_sysprikey where codarq = 3962;
delete from db_sysarqcamp where codarq = 3962;
delete from db_syscampo where codcam in (22019, 22020, 22021);
delete from db_sysarqmod  where codarq = 3962;
delete from db_sysarquivo where codarq = 3962;

DROP TABLE IF EXISTS upx_db_sysarquivo;
DROP TABLE IF EXISTS upx_db_sysarqmod;
DROP TABLE IF EXISTS upx_db_syscampo;
DROP TABLE IF EXISTS upx_db_sysarqcamp;
DROP TABLE IF EXISTS upx_db_sysprikey;
DROP TABLE IF EXISTS upx_db_sysindices;
DROP TABLE IF EXISTS upx_db_syscadind;
DROP TABLE IF EXISTS upx_db_syssequencia;
DROP TABLE IF EXISTS upx_db_itensmenu;
DROP TABLE IF EXISTS upx_db_menu;
DROP TABLE IF EXISTS upx_db_processa;
DROP TABLE IF EXISTS upx_db_arquivos;
DROP TABLE IF EXISTS upx_db_itensfilho;


-- deleta o item de menu da base curricular e ome de rotinas de importacao
delete from db_menu where id_item_filho = 10304   AND modulo = 7159;
delete from db_menu where id_item_filho = 1100849 AND modulo = 7159;
delete from db_menu where id_item_filho = 1100850 AND modulo = 7159;
delete from db_menu where id_item_filho = 1100851 AND modulo = 7159;
delete from db_menu where id_item_filho = 1100852 AND modulo = 7159;
delete from db_itensmenu where id_item = 10304;

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------- INICIO FINANCEIRO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL FINANCEIRO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------- INICIO TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

delete from db_layoutcampos where db52_codigo = 14801;
delete from db_layoutcampos where db52_codigo = 14802;

update db_syscampo set nulo = 'false' where codcam = 8432;

delete from db_syssequencia where nomesequencia = 'aguacontratoligacao_x55_sequencial_seq';
delete from db_sysforkey    where codarq = 3968;
delete from db_sysarqcamp   where codarq = 3968;
delete from db_syscampo     where nomecam in(
  'x55_sequencial',
  'x55_aguahidromatric',
  'x55_aguacontrato'
);
delete from db_sysarqmod    where codarq = 3968;
delete from db_sysarquivo   where codarq = 3968;
delete from db_sysprikey    where codarq = 3968;

delete from db_syssequencia where nomesequencia = 'aguacontrato_x54_sequencial_seq';
delete from db_sysforkey    where codarq = 3966;
delete from db_sysarqcamp   where codarq = 3966;
delete from db_syscampo     where nomecam in(
  'x54_sequencial',
  'x54_aguabase',
  'x54_diavencimento',
  'x54_datavalidadecadastro',
  'x54_datainicial',
  'x54_datafinal',
  'x54_aguacategoriaconsumo'
);
delete from db_sysarqmod    where codarq = 3966;
delete from db_sysarquivo   where codarq = 3966;
delete from db_sysprikey    where codarq = 3966;

delete from db_menu where id_item = 10306;
delete from db_menu where id_item_filho = 10306;
delete from db_itensmenu where id_item in(10309, 10308, 10307, 10306);

-- # Agua Categoria Consumo
delete from db_syssequencia where nomesequencia = 'aguacategoriaconsumo_x13_sequencial_seq';
delete from db_sysarqcamp where codarq = 3969;
delete from db_syscampo   where nomecam in (
  'x13_sequencial',
  'x13_exercicio',
  'x13_descricao'
);
delete from db_sysarqmod    where codarq = 3969;
delete from db_sysarquivo   where codarq = 3969;
delete from db_sysprikey    where codarq = 3969;

-- # Agua Estrutura Tarifaria
delete from db_syssequencia where nomesequencia = 'aguaestruturatarifaria_x37_sequencial_seq';
delete from db_sysforkey    where codarq = 3972;
delete from db_sysarqcamp   where codarq = 3972;
delete from db_syscampo     where nomecam in (
  'x37_sequencial',
  'x37_aguaconsumotipo',
  'x37_tipoestrutura',
  'x37_valorinicial',
  'x37_valorfinal',
  'x37_valor',
  'x37_percentual',
  'x37_aguacategoriaconsumo'
);
delete from db_sysarqmod    where codarq = 3972;
delete from db_sysarquivo   where codarq = 3972;
delete from db_sysprikey    where codarq = 3972;

-- # Menu Categorias de Consumo
delete from db_menu where id_item = 10316;
delete from db_menu where id_item_filho = 10316;
delete from db_itensmenu where id_item in(10319, 10318, 10317, 10316);
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO FOLHA ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL FOLHA ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO SAUDE ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
delete from db_menu where id_item_filho = 10286 AND modulo = 6952;
delete from db_itensmenu where id_item = 10286;

delete from db_syscampodef where codcam = 17222;
delete from db_sysarqcamp where codarq = 3043 and codcam in(22005, 22006, 22007, 22009, 22010, 22030);
delete from db_syscampo where codcam in(22005, 22006, 22007, 22009, 22010, 22030);

DROP TABLE IF EXISTS w_up_5208_db_itensmenu;
DROP TABLE IF EXISTS w_up_5208_db_menu;
DROP TABLE IF EXISTS w_up_6896_db_syscampo;
DROP TABLE IF EXISTS w_up_6896_db_sysarqcamp;
DROP TABLE IF EXISTS w_up_6896_db_syscampodef;
DROP TABLE IF EXISTS w_up_6991_db_syscampo;
DROP TABLE IF EXISTS w_up_6991_db_sysarqcamp;
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL SAUDE ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------