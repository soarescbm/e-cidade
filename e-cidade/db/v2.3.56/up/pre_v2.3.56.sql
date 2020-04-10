---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO TRIBUTARIO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
--Inserções da tabela grupotaxadiversos
insert into db_sysarquivo select 3971, 'grupotaxadiversos', 'Agrupa várias taxas para gerar o mesmo débito.', 'y118', '2016-09-22', 'Grupo de Taxas de Diversos', 0, 'f', 'f', 't', 't' from db_sysarquivo where not exists (select 1 from db_sysarquivo where codarq = 3971) limit 1;

delete from db_sysarqmod where codarq = 3971;
insert into db_sysarqmod values (25,3971);

insert into db_syscampo select 22046,'y118_sequencial','int8','Sequencial da tabela','0', 'Sequencial',19,'f','f','f',1,'text','Sequencial' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 22046) limit 1;
insert into db_syscampo select 22047,'y118_descricao','varchar(100)','Descrição do grupo de taxas.','', 'Descrição',100,'f','t','f',0,'text','Descrição' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 22047) limit 1;
insert into db_syscampo select 22048,'y118_inflator','varchar(5)','Código do inflator','', 'Código Inflator',5,'f','t','f',0,'text','Código Inflator' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 22048) limit 1;
insert into db_syscampo select 22050,'y118_procedencia','int4','Procedência do débito','0', 'Procedência',19,'f','f','f',1,'text','Procedência' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 22050) limit 1;

delete from db_sysarqcamp where codarq = 3971;
insert into db_sysarqcamp values(3971,22046,1,0);
insert into db_sysarqcamp values(3971,22047,2,0);
insert into db_sysarqcamp values(3971,22048,3,0);
insert into db_sysarqcamp values(3971,22050,5,0);

delete from db_sysprikey where codarq = 3971;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3971,22046,1,22046);

delete from db_sysforkey where codarq = 3971;
insert into db_sysforkey values(3971,22048,1,81,0);
insert into db_sysforkey values(3971,22050,1,374,0);

insert into db_sysindices select 4381,'grupotaxadiversos_procedencia_in',3971,'0' from db_sysindices where not exists (select 1 from db_sysindices where codind = 4381) limit 1;
insert into db_sysindices select 4382,'grupotaxadiversos_inflator_in',3971,'0' from db_sysindices where not exists (select 1 from db_sysindices where codind = 4382) limit 1;

delete from db_syscadind where codind IN (4381,4382);
insert into db_syscadind values(4381,22050,1);
insert into db_syscadind values(4382,22048,1);

insert into db_syssequencia select 1000603, 'grupotaxadiversos_y118_sequencial_seq', 1, 1, 9223372036854775807, 1, 1 from db_syssequencia where not exists (select 1 from db_syssequencia where codsequencia = 1000603) limit 1;
update db_sysarqcamp set codsequencia = 1000603 where codarq = 3971 and codcam = 22046;
--Ajuste na chave estrangeira de inflatores
update db_sysindices set nomeind = 'grupotaxadiversos_inflator_in',campounico = '0' where codind = 4382;
delete from db_syscadind where codind = 4382;
insert into db_syscadind values(4382,22048,1);
delete from db_sysforkey where codarq = 3971 and referen = 81;
insert into db_sysforkey values(3971,22048,1,80,0);
delete from db_sysarqcamp where codarq = 3971;
insert into db_sysarqcamp values(3971,22046,1,1000603);
insert into db_sysarqcamp values(3971,22047,2,0);
insert into db_sysarqcamp values(3971,22048,3,0);
insert into db_sysarqcamp values(3971,22050,4,0);
update db_syscampo set nomecam = 'y118_inflator', conteudo = 'varchar(5)', descricao = 'Código do inflator', valorinicial = '', rotulo = 'Código Inflator', nulo = 'f', tamanho = 5, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Código Inflator' where codcam = 22048;
delete from db_syscampodep where codcam = 22048;
delete from db_syscampodef where codcam = 22048;

--Inserções da tabela taxadiversos
insert into db_sysarquivo select 3973, 'taxadiversos', 'Taxas diversas.', 'y119', '2016-09-22', 'Taxas Diversas', 0, 'f', 'f', 't', 't' from db_sysarquivo where not exists (select 1 from db_sysarquivo where codarq = 3973) limit 1;
insert into db_sysarqmod select 25, 3973 from db_sysarqmod where not exists(select 1 from db_sysarqmod where codmod = 25 and codarq = 3973) limit 1;

insert into db_syscampo select 22051,'y119_sequencial','int4','Sequencial da tabela','0', 'Sequencial',19,'f','f','f',1,'text','Sequencial' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 22051) limit 1;
insert into db_syscampo select 22052,'y119_grupotaxadiversos','int4','Grupo de taxas','0', 'Grupo',19,'f','f','f',1,'text','Grupo' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 22052) limit 1;
insert into db_syscampo select 22053,'y119_natureza','text','Natureza da taxa','', 'Natureza',1,'f','t','f',0,'text','Natureza' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 22053) limit 1;
insert into db_syscampo select 22054,'y119_formula','int4','Fórmula da taxa','0', 'Fórmula',19,'f','f','f',1,'text','Fórmula' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 22054) limit 1;
insert into db_syscampo select 22055,'y119_unidade','varchar(50)','Unidade para cálculo da taxa','', 'Unidade',50,'f','t','f',0,'text','Unidade' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 22055) limit 1;
insert into db_syscampo select 22056,'y119_tipo_periodo','char(1)','Tipo do período se aberto, sem data final ou fixo','', 'Tipo de Período',1,'f','t','f',0,'text','Tipo de Período' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 22056) limit 1;
insert into db_syscampo select 22125,'y119_tipo_calculo','char(1)','Tipo de cálculo, Geral ou Único. Se uma taxa geral será recalculada anualmente, se única ser calculada apenas no lançamento.','', 'Tipo de Cálculo',1,'f','t','f',0,'text','Tipo de Cálculo' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 22125) limit 1;
update db_syscampo set nomecam = 'y119_natureza', conteudo = 'text', descricao = 'Natureza da taxa', valorinicial = '', rotulo = 'Natureza', nulo = 'f', tamanho = 100, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Natureza' where codcam = 22053;

delete from db_sysarqcamp where codarq = 3973;
insert into db_sysarqcamp values(3973,22051,1,0);
insert into db_sysarqcamp values(3973,22052,2,0);
insert into db_sysarqcamp values(3973,22053,3,0);
insert into db_sysarqcamp values(3973,22054,4,0);
insert into db_sysarqcamp values(3973,22055,5,0);
insert into db_sysarqcamp values(3973,22056,6,0);
insert into db_sysarqcamp values(3973,22125,7,0);

delete from db_sysprikey where codarq = 3973;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3973,22051,1,22051);

delete from db_sysforkey where codarq = 3973;
insert into db_sysforkey values(3973,22052,1,3971,0);
insert into db_sysforkey values(3973,22054,1,3820,0);

insert into db_sysindices select 4383,'taxadiversos_grupotaxadiversos_in',3973,'0' from db_sysindices where not exists (select 1 from db_sysindices where codind = 4383) limit 1;
insert into db_sysindices select 4384,'taxadiversos_formula_in',3973,'0' from db_sysindices where not exists (select 1 from db_sysindices where codind = 4384) limit 1;

delete from db_syscadind where codind IN (4383, 4384);
insert into db_syscadind values(4383,22052,1);
insert into db_syscadind values(4384,22054,1);

insert into db_syssequencia select 1000604, 'taxadiversos_y119_sequencial_seq', 1, 1, 9223372036854775807, 1, 1 from db_syssequencia where not exists (select 1 from db_syssequencia where codsequencia = 1000604) limit 1;
update db_sysarqcamp set codsequencia = 1000604 where codarq = 3973 and codcam = 22051;

--Inserções da tabela lancamentotaxadiversos
insert into db_sysarquivo select 3974, 'lancamentotaxadiversos', 'Tabela para lançamento das taxas', 'y120', '2016-09-23', 'Lançamento de Taxas diversas', 0, 'f', 'f', 't', 't' where not exists (select 1 from db_sysarquivo where codarq = 3974);
insert into db_sysarqmod select 25, 3974 from db_sysarqmod where not exists(select 1 from db_sysarqmod where codmod = 25 and codarq = 3974) limit 1;

insert into db_syscampo select 22057,'y120_sequencial','int4','Sequencial da tabela','0', 'Sequencial',19,'f','f','f',1,'text','Sequencial' where not exists (select 1 from db_syscampo where codcam = 22057);
insert into db_syscampo select 22058,'y120_cgm','int4','Cgm ao qual a taxa será vinculada.','0', 'CGM',19,'f','f','f',1,'text','CGM' where not exists (select 1 from db_syscampo where codcam = 22058);
insert into db_syscampo select 22059,'y120_taxadiversos','int4','Taxa diversa que será calculada','0', 'Taxa',19,'f','f','f',1,'text','Taxa' where not exists (select 1 from db_syscampo where codcam = 22059);
insert into db_syscampo select 22060,'y120_unidade','float8','Quantidade de unidades para ser calculada a taxa','0', 'Unidade',19,'f','f','f',4,'text','Unidade' where not exists (select 1 from db_syscampo where codcam = 22060);
insert into db_syscampo select 22079, 'y120_periodo', 'float8', 'Período para cálculo da taxa', '0', 'Período', 19, 't', 'f', 'f', 4, 'text', 'Período'  where not exists (select 1 from db_syscampo where codcam = 22079);
insert into db_syscampo select 22061,'y120_datainicio','date','Data de início','null', 'Data de Início',10,'f','f','f',1,'text','Data de Início' where not exists (select 1 from db_syscampo where codcam = 22061);
insert into db_syscampo select 22062,'y120_datafim','date','Data de fim','null', 'Data de fim',10,'f','f','f',1,'text','Data de fim' where not exists (select 1 from db_syscampo where codcam = 22062);
insert into db_syscampo select 22124,'y120_issbase','int4','Código da Inscrição Municipal do CGM.','0', 'Inscrição Municipal',10,'t','f','f',1,'text','Inscrição Municipal' where not exists (select 1 from db_syscampo where codcam = 22124);
update db_syscampo set nomecam = 'y120_datainicio', conteudo = 'date', descricao = 'Data de início', valorinicial = 'null', rotulo = 'Data de Início', nulo = 't', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Data de Início' where codcam = 22061;
update db_syscampo set nomecam = 'y120_datafim', conteudo = 'date', descricao = 'Data de fim', valorinicial = 'null', rotulo = 'Data de fim', nulo = 't', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Data de fim' where codcam = 22062;
update db_syscampo set nomecam = 'y120_periodo', conteudo = 'float8', descricao = 'Período para cálculo da taxa', valorinicial = '0', rotulo = 'Período', nulo = 't', tamanho = 19, maiusculo = 'f', autocompl = 'f', aceitatipo = 4, tipoobj = 'text', rotulorel = 'Período' where codcam = 22079;
update db_syscampo set nomecam = 'y120_cgm', conteudo = 'int4', descricao = 'Cgm ao qual a taxa será vinculada.', valorinicial = '0', rotulo = 'CGM', nulo = 't', tamanho = 19, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'CGM' where codcam = 22058;

delete from db_sysarqcamp where codarq = 3974;
insert into db_sysarqcamp values(3974,22057,1,1000605);
insert into db_sysarqcamp values(3974,22058,2,0);
insert into db_sysarqcamp values(3974,22059,3,0);
insert into db_sysarqcamp values(3974,22060,4,0);
insert into db_sysarqcamp values(3974,22079,5,0);
insert into db_sysarqcamp values(3974,22061,6,0);
insert into db_sysarqcamp values(3974,22062,7,0);
insert into db_sysarqcamp values(3974,22124,8,0);

delete from db_sysprikey where codarq = 3974;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3974,22057,1,22057);

delete from db_sysforkey where codarq = 3974;
insert into db_sysforkey values(3974,22058,1,42,0);
insert into db_sysforkey values(3974,22059,1,3973,0);
insert into db_sysforkey values(3974,22124,1,41,0);

insert into db_sysindices select 4385,'lancamentotaxadiversos_cgm_in',3974,'0' where not exists (select 1 from db_sysindices where codind = 4385);
insert into db_sysindices select 4386,'lancamentotaxadiversos_taxadiversos_in',3974,'0' where not exists (select 1 from db_sysindices where codind = 4386);
insert into db_sysindices select 4389,'lancamentotaxadiversos_issbase_in',3974,'0' where not exists (select 1 from db_sysindices where codind = 4389);

delete from db_syscadind where codind IN (4385,4386,4389);
insert into db_syscadind values(4385,22058,1);
insert into db_syscadind values(4386,22059,1);
insert into db_syscadind values(4389,22124,1);

insert into db_syssequencia select 1000605, 'lancamentotaxadiversos_y120_sequencial_seq', 1, 1, 9223372036854775807, 1, 1 where not exists (select 1 from db_syssequencia where codsequencia = 1000605);
update db_sysarqcamp set codsequencia = 1000605 where codarq = 3974 and codcam = 22057;

--Inserções da tabela taxavaloresreferencia
insert into db_sysarquivo select 3975, 'taxavaloresreferencia', 'Tabela para armazenar os valores de referência das taxas diversas.', 'y121', '2016-09-23', 'Valores de Referência das taxas', 0, 'f', 't', 't', 't' where not exists (select 1 from db_sysarquivo where codarq = 3975);
insert into db_sysarqmod select 25, 3975 from db_sysarqmod where not exists(select 1 from db_sysarqmod where codmod = 25 and codarq = 3975) limit 1;

insert into db_syscampo select 22070,'y121_sequencial','int4','Sequencial da tabela','0', 'Sequencial',19,'f','f','f',1,'text','Sequencial' where not exists (select 1 from db_syscampo where codcam = 22070);
insert into db_syscampo select 22071,'y121_descricao','varchar(100)','Descrição do valor de referência da taxa','', 'Descrição',100,'f','t','f',0,'text','Descrição' where not exists (select 1 from db_syscampo where codcam = 22071);
insert into db_syscampo select 22072,'y121_valor','float8','Valor base de referência para a taxa','0', 'Valor Base',19,'f','f','f',4,'text','Valor Base' where not exists (select 1 from db_syscampo where codcam = 22072);
insert into db_syscampo select 22091 ,'y121_data_base' ,'date' ,'Data para atualização do valor base das taxas.' ,'' ,'Data Base' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Data Base' where not exists (select 1 from db_syscampo where codcam = 22091) limit 1;

delete from db_sysarqcamp where codarq = 3975;

insert into db_sysindices select 4388, 'taxavaloresreferencia_descricao_un', 3975, '1'  where not exists(select 1 from db_sysindices where codind = 4388 limit 1);
insert into db_syscadind select 4388, 22071, 1 from db_syscadind where not exists(select 1 from db_syscadind where codind = 4388 and codcam = 22071 and sequen = 1) limit 1;

insert into db_sysarqcamp values(3975,22070,1,0);
insert into db_sysarqcamp values(3975,22071,2,0);
insert into db_sysarqcamp values(3975,22072,3,0);
insert into db_sysarqcamp values(3975,22091,4,0);

delete from db_sysprikey where codarq = 3975;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3975,22070,1,22070);

insert into db_syssequencia select 1000606, 'taxavaloresreferencia_y121_sequencial_seq', 1, 1, 9223372036854775807, 1, 1 where not exists (select 1 from db_syssequencia where codsequencia = 1000606);
update db_sysarqcamp set codsequencia = 1000606 where codarq = 3975 and codcam = 22070;

--- diversoslancamentotaxa
insert into db_sysarquivo select 3978, 'diversoslancamentotaxa', 'Guarda os Débitos de Diversos lançados para um Taxa', 'dv14', '2016-10-04', 'Diversos Lançados', 0, 'f', 't', 't', 't' where not exists (select 1 from db_sysarquivo where codarq = 3978) limit 1;

delete from db_sysarqmod where codarq = 3978;
insert into db_sysarqmod values (27,3978);

insert into db_syscampo select 22087, 'dv14_sequencial', 'int4', 'Identificador da Ligação', '', 'Código', 10, 'false', 'false', 'false', 1, 'text', 'Código' where not exists (select 1 from db_syscampo where codcam = 22087) limit 1;
insert into db_syscampo select 22088, 'dv14_diversos', 'int4', 'Código do diversos', '', 'Código do Diverso', 10, 'false', 'false', 'false', 1, 'text', 'Código do Diverso' where not exists (select 1 from db_syscampo where codcam = 22088) limit 1;
insert into db_syscampo select 22089, 'dv14_lancamentotaxadiversos', 'int4', 'Sequencial da tabela.', '', 'Código do Lançamento', 19, 'false', 'false', 'false', 1, 'text', 'Código do Lançamento' where not exists (select 1 from db_syscampo where codcam = 22089) limit 1;
insert into db_syscampo select 22094 ,'dv14_data_calculo' ,'date' ,'Data do Cálculo geral da taxa de diversos.' ,'' ,'Data do Cálculo' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Data do Cálculo' where not exists (select 1 from db_syscampo where codcam = 22094) limit 1;

delete from db_syscampodep where codcam IN (22087,22088,22089,22094);
insert into db_syscampodep (codcam, codcampai) values (22088, 3470);
insert into db_syscampodep (codcam, codcampai) values (22089, 22057);

delete from db_sysarqcamp where codarq = 3978;
insert into db_sysarqcamp (codarq, codcam, seqarq, codsequencia) values (3978, 22087, 1, 0);
insert into db_sysarqcamp (codarq, codcam, seqarq, codsequencia) values (3978, 22088, 2, 0);
insert into db_sysarqcamp (codarq, codcam, seqarq, codsequencia) values (3978, 22089, 3, 0);
insert into db_sysarqcamp (codarq, codcam, seqarq, codsequencia) values (3978, 22094, 4, 0);

delete from db_sysprikey where codarq = 3978;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3978,22087,1,22089);

delete from db_sysforkey where codarq = 3978;
insert into db_sysforkey values(3978, 22088, 1, 372, 0);
insert into db_sysforkey values(3978, 22089, 1, 3974, 0);

insert into db_syssequencia select 1000609, 'diversoslancamentotaxa_dv14_sequencial_seq', 1, 1, 9223372036854775807, 1, 1 where not exists (select 1 from db_syssequencia where codsequencia = 1000609) limit 1;
update db_sysarqcamp set codsequencia = 1000609 where codarq = 3978 and codcam = 22087;

--Inclusão de menus
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) select 10310 ,'Taxas' ,'Cadastro de Taxas diversas' ,'' ,'1' ,'1' ,'Menu para cadastro de grupo de taxas e de taxas diversas' ,'true' where not exists (select 1 from db_itensmenu where id_item = 10310);
delete from db_menu where id_item_filho = 10310 AND modulo = 277;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 29 ,10310 ,271 ,277 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) select 10311 ,'Grupos' ,'Grupos de Taxas diversas' ,'fis1_grupotaxadiversos001.php' ,'1' ,'1' ,'Menu para agrupamento de taxas diversas' ,'true' where not exists (select 1 from db_itensmenu where id_item = 10311);
delete from db_menu where id_item_filho = 10311 AND modulo = 277;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10310 ,10311 ,1 ,277 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) select 10312 ,'Natureza' ,'Taxas diversas' ,'fis1_taxadiversos001.php' ,'1' ,'1' ,'Menu para cadastro de taxas diversas' ,'true' where not exists (select 1 from db_itensmenu where id_item = 10312);
delete from db_menu where id_item_filho = 10312 AND modulo = 277;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10310 ,10312 ,2 ,277 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) select 10313 ,'Taxas' ,'Inclusão e cálculo de taxas' ,'' ,'1' ,'1' ,'Menu para inclusão de uma taxas para um CGM e cálculo geral de taxas' ,'true' where not exists (select 1 from db_itensmenu where id_item = 10313);
delete from db_menu where id_item_filho = 10313 AND modulo = 277;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1818 ,10313 ,115 ,277 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) select 10314 ,'Lançamento' ,'Lançar uma taxa' ,'fis4_lancamentotaxadiversos.php' ,'1' ,'1' ,'Menu para lança uma taxa para um contribuinte.' ,'true' where not exists (select 1 from db_itensmenu where id_item = 10314);
delete from db_menu where id_item_filho = 10314 AND modulo = 277;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10313 ,10314 ,1 ,277 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) select 10315 ,'Cálculo Geral' ,'Cálculo geral de taxas' ,'fis4_calculotaxadiversos.php' ,'1' ,'1' ,'Menu para cálculo geral de taxas.' ,'true' where not exists (select 1 from db_itensmenu where id_item = 10315);
delete from db_menu where id_item_filho = 10315 AND modulo = 277;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10313 ,10315 ,2 ,277 );

-- Início módulo Água
drop table if exists w_agua_db_sysarquivo;
create temporary table w_agua_db_sysarquivo   as select * from db_sysarquivo   limit 0;

drop table if exists w_agua_db_sysarqmod;
create temporary table w_agua_db_sysarqmod    as select * from db_sysarqmod    limit 0;

drop table if exists w_agua_db_syscampo;
create temporary table w_agua_db_syscampo     as select * from db_syscampo     limit 0;

drop table if exists w_agua_db_sysarqcamp;
create temporary table w_agua_db_sysarqcamp   as select * from db_sysarqcamp   limit 0;

drop table if exists w_agua_db_sysprikey;
create temporary table w_agua_db_sysprikey    as select * from db_sysprikey    limit 0;

drop table if exists w_agua_db_syssequencia;
create temporary table w_agua_db_syssequencia as select * from db_syssequencia limit 0;

drop table if exists w_agua_db_sysforkey;
create temporary table w_agua_db_sysforkey    as select * from db_sysforkey    limit 0;

drop table if exists w_agua_db_itensmenu;
create temporary table w_agua_db_itensmenu    as select * from db_itensmenu    limit 0;

drop table if exists w_agua_db_menu;
create temporary table w_agua_db_menu         as select * from db_menu         limit 0;

insert into w_agua_db_sysarquivo values (3977, 'aguaisencaocgm', 'Isenções para utilização no cálculo de água.', 'x56', '2016-10-03', 'Isenções por CGM', 0, 'f', 'f', 'f', 'f' );
insert into w_agua_db_sysarqmod values (43,3977);

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22080 ,'x56_sequencial' ,'int4' ,'Código da isenção' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3977 ,22080 ,1 ,0 );

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22081 ,'x56_aguaisencaotipo' ,'int4' ,'Código do Tipo de Isenção' ,'' ,'Tipo de Isenção' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Tipo de Isenção' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3977 ,22081 ,2 ,0 );

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22082 ,'x56_cgm' ,'int4' ,'CGM' ,'' ,'Nome/Razão Social' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Nome/Razão Social' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3977 ,22082 ,3 ,0 );

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22083 ,'x56_datainicial' ,'date' ,'Data Inicial de vigência da isenção' ,'' ,'Data Inicial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Data Inicial' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3977 ,22083 ,4 ,0 );

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22084 ,'x56_datafinal' ,'date' ,'Data Final de vigência da isenção' ,'' ,'Data Final' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Data Final' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3977 ,22084 ,5 ,0 );

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22085 ,'x56_processo' ,'varchar(30)' ,'Número do Processo' ,'' ,'Número do Processo' ,30 ,'true' ,'false' ,'false' ,0 ,'text' ,'Número do Processo' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3977 ,22085 ,6 ,0 );

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22086 ,'x56_observacoes' ,'text' ,'Observações' ,'' ,'Observações' ,10 ,'true' ,'false' ,'false' ,0 ,'text' ,'Observações' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3977 ,22086 ,7 ,0 );

insert into w_agua_db_syssequencia values(1000608, 'aguaisencaocgm_x56_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update w_agua_db_sysarqcamp set codsequencia = 1000608 where codarq = 3977 and codcam = 22080;

insert into w_agua_db_sysprikey (codarq,codcam,sequen,camiden) values(3977,22080,1,22080);

insert into w_agua_db_sysforkey values(3977,22081,1,1435,0);
insert into w_agua_db_sysforkey values(3977,22082,1,42,0);

insert into w_agua_db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10320 ,'Isenções por CGM' ,'Isenções por CGM' ,'' ,'1' ,'1' ,'Isenções por CGM' ,'true' );
insert into w_agua_db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 3332 ,10320 ,25 ,4555 );

insert into w_agua_db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10321 ,'Inclusão' ,'Inclusão' ,'agu4_aguaisencaocgm.php?iOpcao=1' ,'1' ,'1' ,'Inclusão de isenção por CGM' ,'true' );
insert into w_agua_db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10320 ,10321 ,1 ,4555 );

insert into w_agua_db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10322 ,'Alteração' ,'Alteração' ,'agu4_aguaisencaocgm.php?iOpcao=2' ,'1' ,'1' ,'Alteração de isenção por CGM' ,'true' );
insert into w_agua_db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10320 ,10322 ,2 ,4555 );

insert into w_agua_db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10323 ,'Exclusão' ,'Exclusão' ,'agu4_aguaisencaocgm.php?iOpcao=3' ,'1' ,'1' ,'Exclusão de isenção por CGM' ,'true' );
insert into w_agua_db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10320 ,10323 ,3 ,4555 );

-- Água: Cadastro de Economias
insert into w_agua_db_sysarquivo
  values (3983, 'aguacontratoeconomia', 'Agua Contrato Economia', 'x38', '2016-10-10', 'Agua Contrato Economia', 0, 'f', 'f', 'f', 'f' );

insert into w_agua_db_sysarqmod
  values (43, 3983);

insert into w_agua_db_syscampo
  values ( 22113 ,'x38_sequencial' ,'int4' ,'Código da Economia' ,'' ,'Código da Economia ' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código da Economia ' ),
         ( 22114 ,'x38_aguacontrato' ,'int4' ,'Código do Contrato' ,'' ,'Código do Contrato' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código do Contrato' ),
         ( 22115 ,'x38_cgm' ,'int4' ,'Nome/Razão Social' ,'' ,'Nome/Razão Social' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Nome/Razão Social' ),
         ( 22116 ,'x38_aguacategoriaconsumo' ,'int4' ,'Categoria de Consumo' ,'' ,'Categoria de Consumo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Categoria de Consumo' ),
         ( 22117 ,'x38_datavalidadecadastro' ,'date' ,'Data de Validade do Cadastro' ,'' ,'Data de Validade do Cadastro' ,10 ,'true' ,'false' ,'false' ,0 ,'text' ,'Data de Validade do Cadastro' ),
         ( 22118 ,'x38_nis' ,'varchar(20)' ,'Número de Identificação Social' ,'' ,'Número de Identificação Social' ,20 ,'true' ,'false' ,'false' ,0 ,'text' ,'Número de Identificação Social' );

insert into w_agua_db_sysarqcamp
  values ( 3983 ,22113 ,1 ,0 ),
         ( 3983 ,22114 ,2 ,0 ),
         ( 3983 ,22115 ,3 ,0 ),
         ( 3983 ,22116 ,4 ,0 ),
         ( 3983 ,22117 ,5 ,0 ),
         ( 3983 ,22118 ,6 ,0 );

insert into w_agua_db_syssequencia
  values (1000613, 'aguacontratoeconomia_x38_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update w_agua_db_sysarqcamp set codsequencia = 1000613 where codarq = 3983 and codcam = 22113;

insert into w_agua_db_sysprikey
  values (3983, 22113, 1, 22113);

insert into w_agua_db_sysforkey
  values (3983, 22114, 1, 3966, 0),
         (3983, 22115, 1, 42, 0),
         (3983, 22116, 1, 3969, 0);

-- Água: Tipos de Contrato
insert into w_agua_db_sysarquivo
  values (3985, 'aguatipocontrato', 'Tipo de Contrato', 'x39', '2016-10-11', 'Tipo de Contrato', 0, 'f', 'f', 'f', 'f' );

insert into w_agua_db_sysarqmod
  values (43, 3985);

insert into w_agua_db_syscampo
  values ( 22119 ,'x39_sequencial' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' ),
         ( 22120 ,'x39_descricao' ,'varchar(100)' ,'Descrição' ,'' ,'Descrição' ,100 ,'false' ,'false' ,'false' ,0 ,'text' ,'Descrição' );

insert into w_agua_db_sysarqcamp
  values ( 3985 ,22119 ,1 ,0 ),
         ( 3985 ,22120 ,2 ,0 );

insert into w_agua_db_itensmenu
  values ( 10326 ,'Cadastro de Tipos de Contrato' ,'Cadastro de Tipos de Contrato' ,'' ,'1' ,'1' ,'Cadastro de Tipos de Contrato' ,'true' ),
         ( 10327 ,'Inclusão' ,'Inclusão de Tipo de Contrato' ,'agu1_aguatipocontrato.php?iOpcao=1' ,'1' ,'1' ,'Inclusão de Tipo de Contrato' ,'true' ),
         ( 10328 ,'Alteração' ,'Alteração de Tipo de Contrato' ,'agu1_aguatipocontrato.php?iOpcao=2' ,'1' ,'1' ,'Alteração de Tipo de Contrato' ,'true' ),
         ( 10329 ,'Exclusão' ,'Exclusão de Tipo de Contrato' ,'agu1_aguatipocontrato.php?iOpcao=3' ,'1' ,'1' ,'Exclusão de Tipo de Contrato' ,'true' );

insert into w_agua_db_menu
  values ( 3470 ,10326 ,42 ,4555 ),
         ( 10326 ,10327 ,1 ,4555 ),
         ( 10326 ,10328 ,2 ,4555 ),
         ( 10326 ,10329 ,3 ,4555 );

-- Água: Contrato
update db_syscampo set nulo = 'true' where codcam = 22074;

insert into w_agua_db_syscampo
  values ( 22122 ,'x54_condominio' ,'bool' ,'Contrato de Condomínio' ,'' ,'Condomínio' ,1 ,'true' ,'false' ,'false' ,5 ,'text' ,'Condomínio' ),
         ( 22123 ,'x54_aguatipocontrato' ,'int4' ,'Tipo de Contrato' ,'' ,'Tipo de Contrato' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Tipo de Contrato' );

insert into w_agua_db_sysarqcamp
  values ( 3966 ,22122 ,10 ,0 ),
         ( 3966 ,22123 ,11 ,0 );

insert into w_agua_db_sysforkey
  values (3966, 22123, 1, 3985, 0);

insert into w_agua_db_syssequencia
  values (1000614, 'aguatipocontrato_x39_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update w_agua_db_sysarqcamp set codsequencia = 1000614 where codarq = 3985 and codcam = 22119;

insert into w_agua_db_sysprikey
  values (3985, 22119, 1, 22119);

insert into db_itensmenu
  select * from w_agua_db_itensmenu    where not exists(select 1 from db_itensmenu where w_agua_db_itensmenu.id_item = db_itensmenu.id_item);

insert into db_menu
  select * from w_agua_db_menu         where not exists(select 1 from db_menu where w_agua_db_menu.id_item = db_menu.id_item and w_agua_db_menu.id_item_filho = db_menu.id_item_filho);

insert into db_sysarquivo
  select * from w_agua_db_sysarquivo   where not exists(select 1 from db_sysarquivo where w_agua_db_sysarquivo.codarq = db_sysarquivo.codarq);

insert into db_sysarqmod
  select * from w_agua_db_sysarqmod    where not exists(select 1 from db_sysarqmod where db_sysarqmod.codarq = w_agua_db_sysarqmod.codarq);

insert into db_syscampo
  select * from w_agua_db_syscampo     where not exists(select 1 from db_syscampo where db_syscampo.codcam = w_agua_db_syscampo.codcam);

insert into db_sysarqcamp
  select * from w_agua_db_sysarqcamp   where not exists(select 1 from db_sysarqcamp where db_sysarqcamp.codcam = w_agua_db_sysarqcamp.codcam);

insert into db_sysprikey
  select * from w_agua_db_sysprikey    where not exists(select 1 from db_sysprikey where db_sysprikey.codcam = w_agua_db_sysprikey.codcam);

insert into db_syssequencia
  select * from w_agua_db_syssequencia where not exists(select 1 from db_syssequencia where db_syssequencia.codsequencia = w_agua_db_syssequencia.codsequencia);

insert into db_sysforkey
  select * from w_agua_db_sysforkey    where not exists(select 1 from db_sysforkey where db_sysforkey.codcam = w_agua_db_sysforkey.codcam);
-- Fim módulo Água

-- Cobrança registrada
select fc_executa_ddl($$
  insert into db_layouttxt values (263, 'CNAB240 FEBRABAN V087', 0, 'Arquivo CNAB240 Padrão versão 087', 1 );
  insert into db_layoutlinha values (868, 263, 'HEADER DE LOTE', 2, 240, 0, 0, '', '', false );
  insert into db_layoutlinha values (867, 263, 'HEADER DE ARQUIVO', 1, 240, 0, 0, '', '', false );
  insert into db_layoutlinha values (869, 263, 'TRAILER DO LOTE', 4, 240, 0, 0, '', '', false );
  insert into db_layoutlinha values (872, 263, 'SEGMENTO Q', 3, 240, 0, 0, '', '', false );
  insert into db_layoutlinha values (873, 263, 'SEGMENTO R', 3, 240, 0, 0, '', '', false );
  insert into db_layoutlinha values (870, 263, 'TRAILER DO ARQUIVO', 5, 240, 0, 0, '', '', false );
  insert into db_layoutlinha values (871, 263, 'SEGMENTO P', 3, 240, 0, 0, '', '', false );
  insert into db_layoutcampos values (14852, 867, 'codigo_banco', 'CÓDIGO DO BANCO NA COMPENSAÇÃO', 2, 1, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14853, 867, 'lote', 'LOTE DO SERVIÇO', 2, 4, '0000', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14854, 867, 'tipo_registro', 'TIPO DE REGISTRO', 2, 8, '0', 1, true, true, 'e', '', 0 );
  insert into db_layoutcampos values (14855, 867, 'exclusivo_febraban_1', 'USO EXCLUSIVO FEBRABAN', 13, 9, '', 9, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14856, 867, 'tipo_inscricao', 'TIPO DE INSCRIÇÃO DA EMPRESA', 2, 18, '', 1, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14857, 867, 'numero_inscricao', 'NÚMERO DE INSCRIÇÃO DA EMPRESA', 2, 19, '', 14, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14858, 867, 'codigo_convenio_banco', 'CÓDIGO DO CONVENIO NO BANCO', 13, 33, '', 20, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14859, 867, 'codigo_agencia', 'AGÊNCIA MANTENEDORA DA CONTA', 2, 53, '', 5, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14860, 867, 'dv_agencia', 'DÍGITO VERIFICADOR DA AGÊNCIA', 2, 58, '', 1, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14861, 867, 'exclusivo_banco_1', 'CAMPO DE USO DO BANCO', 13, 59, '', 14, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14862, 867, 'nome_empresa', 'NOME DA EMPRESA', 13, 73, '', 30, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14863, 867, 'nome_banco', 'NOME DO BANCO', 13, 103, '', 30, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14864, 867, 'exclusivo_febraban_2', 'USO EXCLUSIVO FEBRABAN', 13, 133, '', 10, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14865, 867, 'codigo_remessa', 'CÓDIGO DA REMESSA / RETORNO', 2, 143, '', 1, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14866, 867, 'data_geracao', 'DATA DE GERAÇÃO DO ARQUIVO', 13, 144, '', 8, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14867, 867, 'hora_geracao', 'HORA DE GERAÇÃO DO ARQUIVO', 13, 152, '', 6, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14868, 867, 'numero_sequencial', 'NÚMERO SEQUENCIAL DO ARQUIVO', 2, 158, '', 6, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14869, 867, 'versao_layout', 'NÚMERO DA VERSÃO DO LAYOUT', 2, 164, '087', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14870, 867, 'densidade_arquivo', 'DENSIDADE DE GRAVAÇÃO DO ARQUIVO', 2, 167, '', 5, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14871, 867, 'uso_reservado_banco', 'USO RESERVADO DO BANCO', 13, 172, '', 20, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14872, 867, 'uso_reservado_empresa', 'USO RESERVADO DA EMPRESA', 13, 192, '', 20, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14873, 867, 'exclusivo_febraban_3', 'USO EXCLUSIVO FEBRABAN', 13, 212, '', 29, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14874, 868, 'codigo_banco', 'CÓDIGO DO BANCO', 2, 1, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14875, 868, 'lote', 'LOTE DE SERVIÇO', 2, 4, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14876, 868, 'tipo_registro', 'TIPO DE REGISTRO', 2, 8, '1', 1, true, true, 'e', '', 0 );
  insert into db_layoutcampos values (14877, 868, 'tipo_operacao', 'TIPO DE OPERAÇÃO', 13, 9, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14878, 868, 'tipo_servico', 'TIPO DE SERVIÇO', 2, 10, '01', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14879, 868, 'exclusivo_febraban_1', 'USO EXCLUSIVO FEBRABAN', 13, 12, '', 2, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14880, 868, 'versao_layout', 'NÚMERO DA VERSÃO DO LAYOUT', 2, 14, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14881, 868, 'exclusivo_febraban_2', 'USO EXCLUSIVO FEBRABAN', 13, 17, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14882, 868, 'tipo_inscricao', 'TIPO DE INSCRIÇÃO DA EMPRESA', 2, 18, '', 1, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14883, 868, 'numero_inscricao', 'NÚMERO DA INSCRIÇÃO DA EMPRESA', 2, 19, '', 15, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14884, 868, 'codigo_convenio_banco', 'CÓDIGO DO CONVÊNIO DO BANCO', 13, 34, '', 20, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14885, 868, 'codigo_agencia', 'AGÊNCIA MANTENEDORA DA CONTA', 2, 54, '', 5, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14886, 868, 'dv_agencia', 'DÍGITO VERIFICADOR DA AGÊNCIA', 13, 59, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14887, 868, 'exclusivo_banco_1', 'USO EXCLUSIVO DO BANCO', 13, 60, '', 14, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14888, 868, 'nome_empresa', 'NOME DA EMPRESA', 13, 74, '', 30, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14889, 868, 'mensagem1', 'MENSAGEM 1', 13, 104, '', 40, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14890, 868, 'mensagem2', 'MENSAGEM 2', 13, 144, '', 40, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14891, 868, 'numero_remessa', 'NÚEMRO DA REMESSA / RETORNO', 2, 184, '', 8, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14892, 868, 'data_geracao', 'DATA DE GRAVAÇÃO REMESSA / RETORNO', 13, 192, '', 8, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14893, 868, 'data_credito', 'DATA DO CRÉDITO', 13, 200, '', 8, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14894, 868, 'exclusivo_febraban_3', 'USO EXCLUSIVO FEBRABAN', 13, 208, '', 33, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14895, 869, 'codigo_banco', 'CÓDIGO DO BANCO NA COMPENSAÇÃO', 2, 1, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14896, 869, 'lote', 'LOTE DO SERVIÇO', 2, 4, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14897, 869, 'tipo_registro', 'TIPO DE REGISTRO', 2, 8, '5', 1, true, true, 'e', '', 0 );
  insert into db_layoutcampos values (14898, 869, 'exclusivo_febraban_1', 'USO EXCLUSIVO FEBRABAN', 13, 9, '', 9, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14899, 869, 'quantidade_registros', 'QUANTIDADE DE REGISTROS', 2, 18, '', 6, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14900, 869, 'exclusivo_febraban_2', 'USO EXCLUSIVO FEBRABAN', 13, 24, '', 217, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14901, 870, 'codigo_banco', 'CÓDIGO DO BANCO NA COMPENSAÇÃO', 2, 1, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14902, 870, 'lote', 'LOTE DE SERVIÇO', 2, 4, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14903, 870, 'tipo_registro', 'TIPO DE REGISTRO', 2, 8, '9', 1, true, true, 'e', '', 0 );
  insert into db_layoutcampos values (14904, 870, 'exclusivo_febraban_1', 'USO EXCLUSIVO FEBRABAN', 13, 9, '', 9, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14905, 870, 'quantidade_lotes', 'QUANTIDADE DE LOTES DO ARQUIVO', 2, 18, '', 6, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14906, 870, 'quantidade_registros', 'QUANTIDADE DE REGISTROS DO ARQUIVO', 2, 24, '', 6, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14907, 870, 'exclusivo_febraban_2', 'USO EXCLUSIVO FEBRABAN', 13, 30, '', 6, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14908, 870, 'exclusivo_febraban_3', 'USO EXCLUSIVO FEBRABAN', 13, 36, '', 205, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14909, 871, 'codigo_banco', 'CÓDIGO DO BANCO NA COMPOSIÇÃO', 2, 1, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14910, 871, 'lote', 'LOTE DO SERVIÇO', 2, 4, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14911, 871, 'tipo_registro', 'TIPO DE REGISTRO', 2, 8, '3', 1, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14912, 871, 'sequencial_registro', 'SEQUENCIAL DO REGISTRO NO LOTE', 2, 9, '', 5, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14913, 871, 'segmento', 'CÓDIGO DO SEGMENTO DO REGISTRO', 1, 14, 'P', 1, true, true, 'd', '', 0 );
  insert into db_layoutcampos values (14914, 871, 'exclusivo_febraban_1', 'USO EXCLUSIVO FEBRABAN', 13, 15, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14915, 871, 'codigo_movimento', 'CÓDIGO DO MOVIMENTO', 2, 16, '', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14916, 871, 'codigo_agencia', 'CÓDIGO DA AGÊNCIA MANTENEDORA DA CONTA', 2, 18, '', 5, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14917, 871, 'dv_agencia', 'DÍGITO VERIFICADOR DA AGÊNCIA', 13, 23, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14918, 871, 'exclusivo_banco_1', 'USO EXCLUSIVO DO BANCO', 13, 24, '', 14, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14919, 871, 'exclusivo_banco_2', 'USO EXCLUSIVO DO BANCO', 13, 38, '', 20, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14920, 871, 'codigo_carteira', 'CÓDIGO DA CARTEIRA', 2, 58, '', 1, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14921, 871, 'forma_cadastramento', 'FORMA DE CADASTRAMENTO DO TÍTULO NO BANC', 2, 59, '', 1, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14922, 871, 'tipo_documento', 'TIPO DE DOCUMENTO', 1, 60, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14929, 871, 'dv_agencia_cobradora', 'DÍGITO VERIFICADOR DA AGÊNCIA ENCARREGAD', 13, 106, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14949, 872, 'codigo_banco', 'CÓDIGO DO BANCO NA COMPENSAÇÃO', 2, 1, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14951, 872, 'tipo_registro', 'TIPO DE REGISTRO', 2, 8, '3', 1, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14953, 872, 'segmento', 'CÓDIGO SEGMENTO DO REGISTRO', 1, 14, 'Q', 1, true, true, 'd', '', 0 );
  insert into db_layoutcampos values (14954, 872, 'exclusivo_febraban_1', 'USO EXCLUSIVO FEBRABAN', 13, 15, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14955, 872, 'codigo_movimento', 'CÓDIGO DO MOVIMENTO REMESSA', 2, 16, '', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14956, 872, 'tipo_inscricao_sacado', 'TIPO DE INSCRIÇÃO DO SACADO', 2, 18, '', 1, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14957, 872, 'numero_inscricao_sacado', 'NÚMERO DE INCRIÇÃO DO SACADO', 2, 19, '', 15, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14931, 871, 'aceite_titulo', 'IDENTIFICAÇÃO DE TÍTULO ACEITO/NÃO ACEIT', 1, 109, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14932, 871, 'data_emissao_titulo', 'DATA DE EMISSÃO DO TÍTULO', 1, 110, '', 8, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14933, 871, 'codigo_juros', 'CÓDIGO DO JUROS DE MORA', 1, 118, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14934, 871, 'data_juros', 'DATA DO JUROS DE MORA', 1, 119, '', 8, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14935, 871, 'taxa_juros', 'JUROS DE MORA POR DIA / TAXA', 1, 127, '', 15, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14936, 871, 'codigo_desconto', 'CÓDIGO DO DESCONTO 1', 1, 142, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14937, 871, 'data_desconto', 'DATA DO DESCONTO 1', 1, 143, '', 8, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14950, 872, 'lote', 'LOTE DE SERVIÇO', 2, 4, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14952, 872, 'sequencial_registro', 'NÚMERO SEQUENCIAL DO REGISTRO NO LOTE', 2, 9, '', 5, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14938, 871, 'valor_desconto', 'DESCONTO 1 VALOR/PERCENTUAL A SER CONCED', 2, 151, '', 15, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14939, 871, 'valor_iof', 'VALOR DO IOF A SER RECOLHIDO', 2, 166, '', 15, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14940, 871, 'valor_abatimento', 'VALOR DO ABATIMENTO', 2, 181, '', 15, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14941, 871, 'uso_empresa', 'IDENTIFICAÇÃO DO TÍTULO NA EMPRESA', 13, 196, '', 25, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14942, 871, 'codigo_protesto', 'CÓDIGO PARA PROTESTO', 2, 221, '', 1, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14943, 871, 'prazo_protesto', 'NÚMERO DE DIAS PARA PROTESTO', 2, 222, '', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14944, 871, 'codigo_baixa_devolucao', 'CÓDIGO PARA BAIXA/DEVOLUÇÃO', 2, 224, '', 1, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14945, 871, 'prazo_baixa_devolucao', 'NÚMERO DE DIAS PARA BAIXA/DEVOLUÇÃO', 2, 225, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14946, 871, 'codigo_moeda', 'CÓDIGO DA MOEDA', 1, 228, '', 2, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14947, 871, 'exclusivo_banco_3', 'USO EXCLUSIVO DO BANCO', 2, 230, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14948, 871, 'exclusivo_febraban_2', 'USO EXCLUSIVO FEBRABAN', 13, 240, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14958, 872, 'nome_sacado', 'NOME DO SACADO', 13, 34, '', 40, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14960, 872, 'bairro_sacado', 'BAIRRO DO SACADO', 13, 114, '', 15, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14961, 872, 'cep_sacado', 'CEP DO SACADO', 1, 129, '', 5, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14962, 872, 'sufixo_cep_sacado', 'SUFIXO DO CEP DO SACADO', 1, 134, '', 3, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14963, 872, 'cidade_sacado', 'CIDADE DO SACADO', 13, 137, '', 15, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14964, 872, 'uf_sacado', 'UF DO SACADO', 1, 152, '', 2, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14965, 872, 'tipo_inscricao_sacador', 'TIPO DE INSCRIÇÃO DO SACADOR', 1, 154, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14966, 872, 'numero_inscricao_sacador', 'NÚMERO DE INSCRIÇÃO DO SACADOR', 1, 155, '', 15, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14967, 872, 'nome_sacador', 'NOME DO SACADOR', 13, 170, '', 40, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14968, 872, 'codigo_banco_correspondente', 'CÓDIGO DO BANCO CORRESPONDENTE NA COMPEN', 2, 210, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14969, 872, 'nosso_numero', 'NOSSO NÚMERO BANCO CORRESPONDENTE', 13, 213, '', 20, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14970, 872, 'exclusivo_febraban_2', 'USO EXCLUSIVO FEBRABAN', 13, 233, '', 8, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14971, 873, 'codigo_banco', 'CÓDIGO DO BANCO NA COMPENSAÇÃO', 2, 1, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14972, 873, 'lote', 'LOTE DE SERVIÇO', 2, 4, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14959, 872, 'endereco_sacado', 'ENDEREÇO DO SACADO', 13, 74, '', 40, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14924, 871, 'distribuicao_bloqueto', 'IDENTIFICAÇÃO DA DISTRIBUIÇÃO', 1, 62, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14925, 871, 'documento_cobranca', 'NÚMERO DO DOCUMENTO DE COBRANÇA', 13, 63, '', 15, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14928, 871, 'codigo_agencia_cobradora', 'CÓDIGO DA AGÊNCIA ENCARREGADA DA COBRANÇ', 2, 101, '', 5, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14923, 871, 'emissao_bloqueto', 'IDENTIFICAÇÃO DA EMISSÃO DO BLOQUETO', 13, 61, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14926, 871, 'vencimento_titulo', 'DATA DE VENCIMENTO DO TÍTULO', 1, 78, '', 8, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14927, 871, 'valor_titulo', 'VALOR DO TÍTULO', 2, 86, '', 15, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14930, 871, 'especie_titulo', 'ESPÉCIE DO TÍTULO', 2, 107, '', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14973, 873, 'tipo_registro', 'TIPO DE REGISTRO', 2, 8, '3', 1, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14975, 873, 'segmento', 'CÓDIGO DO SEGMENTO DO REGISTRO', 1, 14, 'R', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14976, 873, 'exclusivo_febraban_1', 'USO EXCLUSIVO FEBRABAN', 13, 15, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14977, 873, 'codigo_movimento', 'CÓDIGO DO MOVIMENTO REMESSA', 2, 16, '', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14974, 873, 'sequencial_registro', 'NÚMERO SEQUENCIAL DO REGISTRO NO LOTE', 2, 9, '', 5, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14978, 873, 'codigo_desconto_2', 'CÓDIGO DO DESCONTO 2', 2, 18, '', 1, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14979, 873, 'data_desconto_2', 'DATA DO DESCONTO 2', 1, 19, '', 8, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14980, 873, 'valor_desconto_2', 'VALOR / PERCENTUAL A SER CONCEDIDO', 2, 27, '', 15, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14981, 873, 'codigo_desconto_3', 'CÓDIGO DO DESCONTO 3', 2, 42, '', 1, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14982, 873, 'data_desconto_3', 'DATA DO DESCONTO 3', 1, 43, '', 8, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14983, 873, 'valor_desconto_3', 'VALOR / PERCENTUAL A SER CONCEDIDO', 2, 51, '', 15, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14984, 873, 'codigo_multa', 'CÓDIGO DA MULTA', 2, 66, '', 1, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14985, 873, 'data_multa', 'DATA DA MULTA', 1, 67, '', 8, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14986, 873, 'valor_multa', 'VALOR / PERCENTUAL A SER APLICADO', 2, 75, '', 15, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (14987, 873, 'informacao_sacado', 'INFORMAÇÃO AO SACADO', 13, 90, '', 10, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14988, 873, 'mensagem_3', 'MENSAGEM 3', 13, 100, '', 40, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14989, 873, 'mensagem_4', 'MENSAGEM 4', 13, 140, '', 40, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (14990, 873, 'exclusivo_febraban_2', 'USO EXCLUSIVO FEBRABAN', 13, 180, '', 61, false, true, 'd', '', 0 );
$$);

select fc_executa_ddl($$
  insert into db_sysarquivo values
    (3979, 'reciboregistra', 'Recibos que devem ser registrados através da cobrança registrada', 'k146', '2016-10-07', 'ReciboRegistra', 0, 'f', 'f', 'f', 'f' );
  insert into db_sysarqmod
    values (5,3979);
$$);

select fc_executa_ddl($$
  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
    values ( 22092 ,'k146_numpre' ,'int4' ,'Numpre' ,'' ,'Numpre' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Numpre' ),
           ( 22093 ,'k146_convenio' ,'int4' ,'Convenio' ,'' ,'Convenio' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Convenio' );

  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia )
    values ( 3979 ,22092 ,1 ,0 ),
           ( 3979 ,22093 ,2 ,0 );

  insert into db_sysforkey
    values (3979,22093,1,2185,0);

  insert into db_sysindices
    values (4387,'reciboregistra_numpre_in',3979,'0');

  insert into db_syscadind
    values (4387,22092,1);
$$);

select fc_executa_ddl($$
  insert into db_sysarquivo
    values (3981, 'remessacobrancaregistrada', 'Remessas geradas de Cobrança Registrada', 'k147', '2016-10-07', 'RemessaCobrancaRegistrada', 0, 'f', 'f', 'f', 'f' );

  insert into db_sysarqmod
    values (5,3981);
$$);

select fc_executa_ddl($$
  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
    values ( 22100 ,'k147_sequencial' ,'int4' ,'Sequencial' ,'' ,'Sequencial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Sequencial' ),
           ( 22101 ,'k147_instit' ,'int4' ,'Intituição' ,'' ,'Intituição' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Intituição' ),
           ( 22102 ,'k147_convenio' ,'int4' ,'Convênio' ,'' ,'Convênio' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Convênio' ),
           ( 22103 ,'k147_sequencialremessa' ,'int4' ,'Sequencial Remessa' ,'' ,'Sequencial Remessa' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Sequencial Remessa' ),
           ( 22104 ,'k147_dataemissao' ,'date' ,'Data de Emissão' ,'' ,'Data de Emissão' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Data de Emissão' ),
           ( 22105 ,'k147_horaemissao' ,'char(5)' ,'Hora da Emissão' ,'' ,'Hora da Emissão' ,5 ,'false' ,'true' ,'false' ,0 ,'text' ,'Hora da Emissão' );

  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia )
    values ( 3981 ,22100 ,1 ,0 ),
           ( 3981 ,22101 ,2 ,0 ),
           ( 3981 ,22102 ,3 ,0 ),
           ( 3981 ,22103 ,4 ,0 ),
           ( 3981 ,22104 ,5 ,0 ),
           ( 3981 ,22105 ,6 ,0 );

  insert into db_syssequencia
    values (1000610, 'remessacobrancaregistrada_k147_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);

  update db_sysarqcamp set codsequencia = 1000610 where codarq = 3981 and codcam = 22100;

  insert into db_sysprikey (codarq,codcam,sequen,camiden)
    values (3981,22100,1,22100);

  insert into db_sysforkey
    values (3981,22102,1,2185,0);
$$);

select fc_executa_ddl($$
  insert into db_sysarquivo
    values (3982, 'remessacobrancaregistradarecibo', 'Recibo vinculado a remessa gerada para cobrança registrada', 'k148', '2016-10-07', 'RemessaCobrancaRegistradaRecibo', 0, 'f', 'f', 'f', 'f' );

  insert into db_sysarqmod
    values (5,3982);
$$);

select fc_executa_ddl($$
  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
    values ( 22107 ,'k148_sequencial' ,'int4' ,'Sequencial' ,'' ,'Sequencial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Sequencial' ),
           ( 22108 ,'k148_remessacobrancaregistrada' ,'int4' ,'Remessa Cobrança Registrada' ,'' ,'Remessa Cobrança Registrada' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Remessa Cobrança Registrada' ),
           ( 22109 ,'k148_numpre' ,'int4' ,'Numpre' ,'' ,'Numpre' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Numpre' );

  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia )
    values ( 3982 ,22107 ,1 ,0 ),
           ( 3982 ,22108 ,2 ,0 ),
           ( 3982 ,22109 ,3 ,0 );

  insert into db_syssequencia
    values (1000611, 'remessacobrancaregistradarecibo_k148_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);

  update db_sysarqcamp set codsequencia = 1000611 where codarq = 3982 and codcam = 22107;

  insert into db_sysprikey (codarq,codcam,sequen,camiden)
    values (3982,22107,1,22107);

  insert into db_sysforkey
    values (3982,22108,1,3981,0);
$$);

select fc_executa_ddl($$
  insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10324 ,'Cobrança Registrada' ,'Cobrança Registrada para Recibos' ,'' ,'1' ,'1' ,'Menu para Recibos emitidos com o convênio de Cobrança Registrada.' ,'true' );
  insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 32 ,10324 ,474 ,1985522 );
  insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10325 ,'Exportação' ,'Exportação de Cobrança Registrada' ,'arr4_cobrancaregistradaexportacao001.php' ,'1' ,'1' ,'Exportação dos dados de Recibos emitidos com o convênio de Cobrança Registrada' ,'true' );
  insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10324 ,10325 ,1 ,1985522 );
$$);

-- Libera o menu da cobrança registrada para os clientes
update db_itensmenu set libcliente = true where id_item = 10325;

select fc_executa_ddl($$
  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
    values ( 22121 ,'ar13_contabancaria' ,'int4' ,'Conta Bancária' ,'null' ,'Conta Bancária' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Conta Bancária' );

  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia )
    values ( 2186 ,22121 ,11 ,0 );

  insert into db_sysforkey
    values (2186, 22121, 1, 2740, 0);
$$);

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
----------------------------------------- INICIO EDUCACAO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

drop table if exists upx_db_syscampo;
drop table if exists upx_db_sysarqcamp;

create temporary table upx_db_syscampo as select * from db_syscampo limit 0;
insert into upx_db_syscampo
     values (22090,'ed01_atividadeescolar','bool','Profissional possui alguma atividade escolar sem ser um regente. ','f', 'Atividade Escolar sem Regência',1,'f','f','f',5,'text','Atividade Escolar sem Regência');


insert into db_syscampo
select * from upx_db_syscampo
 where not exists ( select 1 from db_syscampo where db_syscampo.codcam = upx_db_syscampo.codcam);

create temporary table upx_db_sysarqcamp as select * from db_sysarqcamp limit 0;
insert into upx_db_sysarqcamp
       values (1010095, 22090, 10, 0);

insert into db_sysarqcamp
  select * from upx_db_sysarqcamp
   where not exists ( select 1 from db_sysarqcamp where db_sysarqcamp.codcam = upx_db_sysarqcamp.codcam);

update db_syscampo set descricao = 'Filiação 1', rotulo = 'Filiação 1', rotulorel = 'Filiação 1' where codcam = 1008900;
update db_syscampo set descricao = 'Filiação 2', rotulo = 'Filiação 2', rotulorel = 'Filiação 2' where codcam = 1008899;



create temporary table upx_db_itensmenu as select * from db_itensmenu limit 0;
insert into upx_db_itensmenu values ( 10330 ,'Linha' ,'Linha' ,'tre2_linha001.php' ,'1' ,'1' ,'Imprime os dados da linha.
Itinerário, ponto de paradas...' ,'true' );

insert into db_itensmenu
select * from upx_db_itensmenu
 where not exists ( select 1 from db_itensmenu where db_itensmenu.id_item = upx_db_itensmenu.id_item);

create temporary table upx_db_menu      as select * from db_menu limit 0;
insert into upx_db_menu values ( 30 ,10330 ,458 ,7147 );

insert into db_menu
  select * from upx_db_menu
   where not exists(select 1 from db_menu where upx_db_menu.id_item = db_menu.id_item and upx_db_menu.id_item_filho = db_menu.id_item_filho);

---------------------------------------------------------------------------------------------------------------
----------------------------------------- INICIO EDUCACAO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
------------------------------------------- INICIO FOLHA ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
insert into db_sysarquivo select 3980, 'pontosalariodatalimite', 'Tabela que irá vincular um evento do ponto de salário a um período inicial e final', 'rh183', '2016-10-07', 'pontosalariodatalimite', 0, 'f', 't', 't', 't'  where not exists(select 1 from db_sysarquivo where codarq = 3980);
insert into db_sysarqmod  select 28,3980 where not exists(select 1 from db_sysarqmod where codmod = 28 and codarq = 3980);
insert into db_syscampo   select 22112,'rh183_sequencial','int4','Código sequencial da tabela','0', 'Código',20,'f','f','t',1,'text','Código' where not exists(select 1 from db_syscampo where codcam = 22112);
insert into db_syscampo   select 22095,'rh183_rubrica','varchar(5)','Rubrica que terá uma tada de inicio e fim','', 'Rubrica',5,'t','f','f',0,'text','Rubrica' where not exists(select 1 from db_syscampo where codcam = 22095);
insert into db_syscampo   select 22110,'rh183_quantidade','int4','Quantidade da Rubrica','0', 'Quantidade',20,'f','f','f',1,'text','Quantidade' where not exists(select 1 from db_syscampo where codcam = 22110);
insert into db_syscampo   select 22111,'rh183_valor','float4','Valor da rubrica','0', 'Valor',10,'f','f','f',4,'text','Valor' where not exists(select 1 from db_syscampo where codcam = 22111);
insert into db_syscampo   select 22096,'rh183_datainicio','date','Data de inicio da rubrica','null', 'Data Início',20,'f','f','f',1,'text','Data Início' where not exists(select 1 from db_syscampo where codcam = 22096);
insert into db_syscampo   select 22097,'rh183_datafim','date','Data final da rubrica','null', 'Data Final',20,'f','f','f',1,'text','Data Final' where not exists(select 1 from db_syscampo where codcam = 22097);
insert into db_syscampo   select 22098,'rh183_matricula','int4','Matrícula do Servidor','0', 'Matrícula',20,'f','f','f',1,'text','Matrícula' where not exists(select 1 from db_syscampo where codcam = 22098);
insert into db_syscampo   select 22099,'rh183_instituicao','int4','Instituição ao qual a rubrica e o periodo estão vinculados','0', 'Instituição',4,'f','f','f',1,'text','Instituição' where not exists(select 1 from db_syscampo where codcam = 22099);

insert into db_syssequencia select 1000612, 'pontosalariodatalimite_rh183_sequencial_seq', 1, 1, 9223372036854775807, 1, 1 where not exists(select 1 from db_syssequencia where codsequencia = 1000612);
update db_sysarqcamp set codsequencia = 1000612 where codarq = 3980 and codcam = 22112;

insert into db_sysarqcamp select 3980,22112,1,1000612 where not exists(select 1 from db_sysarqcamp where codcam = 22112);
insert into db_sysarqcamp select 3980,22110,5,0 where not exists(select 1 from db_sysarqcamp where codcam = 22110);
insert into db_sysarqcamp select 3980,22111,6,0 where not exists(select 1 from db_sysarqcamp where codcam = 22111);
insert into db_sysarqcamp select 3980,22095,1,0 where not exists(select 1 from db_sysarqcamp where codcam = 22095);
insert into db_sysarqcamp select 3980,22096,2,0 where not exists(select 1 from db_sysarqcamp where codcam = 22096);
insert into db_sysarqcamp select 3980,22097,3,0 where not exists(select 1 from db_sysarqcamp where codcam = 22097);
insert into db_sysarqcamp select 3980,22098,4,0 where not exists(select 1 from db_sysarqcamp where codcam = 22098);
insert into db_sysarqcamp select 3980,22099,5,0 where not exists(select 1 from db_sysarqcamp where codcam = 22099);

insert into db_sysforkey  select 3980,22095,1,1177,0 where not exists(select 1 from db_sysforkey where codcam = 22095);
insert into db_sysforkey  select 3980,22099,2,1177,0 where not exists(select 1 from db_sysforkey where codcam = 22099);
insert into db_syscampo   select 22106,'rh27_periodolancamento','bool','informa se a rubrica poderá ser lançada nos pontos por um período especifico.','f', 'Período de Lançamento',1,'f','f','f',5,'text','Período de Lançamento' where not exists(select 1 from db_syscampo where codcam = 22106);
insert into db_sysarqcamp select 1177,22106,30,0 where not exists(select 1 from db_sysarqcamp where codcam = 22106);
insert into db_sysprikey  select 3980,22112,1,22112 where not exists(select 1 from db_sysprikey where codarq = 3980);

---------------------------------------------------------------------------------------------------------------
--------------------------------------------- FIM FOLHA -------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
------------------------------------------- INICIO CONFIGURACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

  -- avaliacaotipo
    insert into avaliacaotipo select 6 ,'Questionario DBSeller' where not exists (select 1 from avaliacaotipo where db100_sequencial = 6);
  --

  -- avaliacaoquestionariointerno
    insert into db_sysarquivo select 3964, 'avaliacaoquestionariointerno', 'Tabela de questionários gerados pela dbseller', 'db170', '2016-09-05', 'avaliacaoquestionariointerno', 0, 'f', 'f', 'f', 'f' where not exists(select 1 from db_sysarquivo where codarq = 3964);
    insert into db_sysarqmod  select 7,3964 where not exists(select 1 from db_sysarqmod where codarq = 3964);
    insert into db_syscampo   select 22024,'db170_sequencial','int4','Código sequencial','0', 'Cadastro sequencial',10,'f','f','f',1,'text','Cadastro sequencial' where not exists(select 1 from db_syscampo where codcam = 22024);
    insert into db_syscampo   select 22025,'db170_avaliacao','int4','Código da Avaliação','0', 'Código da Avaliação',10,'f','f','f',1,'text','Código da Avaliação' where not exists(select 1 from db_syscampo where codcam = 22025);
    insert into db_syscampo   select 22023,'db170_transmitido','bool','Determina se a avaliação foi transmitida.','f', 'Transmitido',1,'f','f','f',5,'text','Transmitido' where not exists(select 1 from db_syscampo where codcam = 22023);
    insert into db_syscampo   select 22022,'db170_ativo','bool','Determina se a avaliação foi transmitida.','f', 'Ativo',1,'f','f','f',5,'text','Ativo' where not exists(select 1 from db_syscampo where codcam = 22022);
    insert into db_syscampo   select 22045,'db170_codigo','int4','Codigo do Questionario Externo','0', 'Codigo do Questionario Externo',10,'t','f','f',1,'text','Codigo do Questionario Externo' where not exists(select 1 from db_syscampo where codcam = 22045);

    insert into db_syssequencia select 1000598, 'avaliacaoquestionariointerno_db170_sequencial_seq', 1, 1, 9223372036854775807, 1, 1 where not exists(select 1 from db_syssequencia where codsequencia = 1000598);

    insert into db_sysarqcamp select 3964,22024,1,1000598 where not exists(select 1 from db_sysarqcamp where codcam = 22024);
    insert into db_sysarqcamp select 3964,22025,2,0 where not exists(select 1 from db_sysarqcamp where codcam = 22025);
    insert into db_sysarqcamp select 3964,22023,3,0 where not exists(select 1 from db_sysarqcamp where codcam = 22023);
    insert into db_sysarqcamp select 3964,22022,4,0 where not exists(select 1 from db_sysarqcamp where codcam = 22022);
    insert into db_sysarqcamp select 3964,22045,5,0 where not exists(select 1 from db_sysarqcamp where codcam = 22045);

    insert into db_sysforkey select 3964,22025,1,2980,0 where not exists(select 1 from db_sysforkey where codcam = 22025);
    insert into db_sysprikey select 3964,22024,1,22024 where not exists(select 1 from db_sysprikey where codarq = 3964);
  --

  -- avaliacaoquestionariointernomenu

    insert into db_sysarquivo select 3965, 'avaliacaoquestionariointernomenu', 'Tabela de vinculo das avaliações geradas pela dbseller com os menus que serão exibidas', 'db171', '2016-09-05', 'avaliacaoquestionariointernomenu', 0, 'f', 'f', 'f', 'f' where not exists(select 1 from db_sysarquivo where codarq = 3965);
    insert into db_sysarqmod  select 7,3965 where not exists(select 1 from db_sysarqmod where codarq = 3965);
    insert into db_syscampo   select 22027,'db171_sequencial','int4','Código sequencial','0', 'Cadastro sequencial',10,'f','f','f',1,'text','Cadastro sequencial' where not exists(select 1 from db_syscampo where codcam = 22027);
    insert into db_syscampo   select 22028,'db171_questionario','int4','Código do Questionário interno','0', 'Questionário Interno',10,'f','f','f',1,'text','Questionário Interno' where not exists(select 1 from db_syscampo where codcam = 22028);
    insert into db_syscampo   select 22026,'db171_menu', 'int4', 'Código do Menu', '0', 'Código do Menu', 10, 'f','f','f',1,'text','Código do Menu' where not exists(select 1 from db_syscampo where codcam = 22026);
    insert into db_syscampo   select 22029,'db171_modulo','int4','Código do Módulo','0', 'Código do Módulo',10,'f','f','f',1,'text','Código do Módulo' where not exists(select 1 from db_syscampo where codcam = 22029);

    insert into db_syssequencia select 1000599, 'avaliacaoquestionariointernomenu_db171_sequencial_seq', 1, 1, 9223372036854775807, 1, 1 where not exists(select 1 from db_syssequencia where codsequencia = 1000599);

    insert into db_sysarqcamp select 3965,22027,1,1000599 where not exists(select 1 from db_sysarqcamp where codcam = 22027);
    insert into db_sysarqcamp select 3965,22028,2,0 where not exists(select 1 from db_sysarqcamp where codcam = 22028);
    insert into db_sysarqcamp select 3965,22026,3,0 where not exists(select 1 from db_sysarqcamp where codcam = 22026);
    insert into db_sysarqcamp select 3965,22029,4,0 where not exists(select 1 from db_sysarqcamp where codcam = 22029);

    insert into db_sysforkey select 3965,22028,1,3964,0 where not exists(select 1 from db_sysforkey where codcam = 22028);
    insert into db_sysprikey select 3965,22027,1,22027  where not exists(select 1 from db_sysprikey where codarq = 3965);
  --

  -- itens de menu

    insert into db_itensmenu select 10267 ,'Cadastro de Questionários' ,'Cadastro de Questionários' ,'' ,'1' ,'1' ,'Cadastros de Questionários' ,'false' where not exists(select 1 from db_itensmenu where id_item = 10267);
    insert into db_menu select 32 ,10267 ,473 ,1 where not exists(select 1 from db_menu where id_item_filho = 10267 AND modulo = 1);
    insert into db_itensmenu select 10268 ,'Inclusão' ,'Novo Questionário' ,'con4_questionario001.php' ,'1' ,'1' ,'Cadastro de questionários que serão enviados aos usuários do sistema' ,'false' where not exists(select 1 from db_itensmenu where id_item = 10268);
    insert into db_menu select 10267 ,10268 ,1 ,1 where not exists(select 1 from db_menu where id_item_filho = 10268 AND modulo = 1);
    insert into db_itensmenu select 10269 ,'Alteração' ,'Alteração de Questionário' ,'con4_questionario002.php' ,'1' ,'1' ,'Alteração de Questionários' ,'false' where not exists(select 1 from db_itensmenu where id_item = 10269);
    insert into db_menu select 10267 ,10269 ,2 ,1 where not exists(select 1 from db_menu where id_item_filho = 10269 AND modulo = 1);
  --
---------------------------------------------------------------------------------------------------------------
--------------------------------------------- FIM CONFIGURACAO -------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
