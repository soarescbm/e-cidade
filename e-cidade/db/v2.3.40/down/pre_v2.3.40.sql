drop table if exists db_menu_origem_3474 ;
drop table if exists db_menu_destino_3474;
---------------------------------------------------------------------------------------------
-------------------------------------- INICIO TIME FOLHA ---------------------------------------
---------------------------------------------------------------------------------------------

--Tabela para agenda de assentamentos
update db_sysarqcamp set codsequencia = 0 where codarq = 3835 and codcam = 21279;
delete from db_syssequencia where codsequencia = 1000486;
delete from db_syscadind    where codind = 4229;
delete from db_sysindices   where codind = 4229;
delete from db_sysforkey    where codarq = 3835;
delete from db_sysprikey    where codarq = 3835;
delete from db_sysarqcamp   where codarq = 3835;
delete from db_syscampo     where codcam = 21284;
delete from db_syscampo     where codcam = 21283;
delete from db_syscampo     where codcam = 21282;
delete from db_syscampo     where codcam = 21281;
delete from db_syscampo     where codcam = 21280;
delete from db_syscampo     where codcam = 21279;
delete from db_sysarqarq    where codarq = 3835;
delete from db_sysarqmod    where codmod = 29 and codarq = 3835;
delete from db_sysarquivo   where codarq = 3835;

--Coluna da tabela tipoasse para guardar se o pagamento é através de portaria ou não
delete from db_sysarqcamp  where codarq = 596 and codcam = 21285;
delete from db_syscampodef where codcam = 21285;
delete from db_syscampo    where codcam = 21285;

--Menus para agenda
delete from db_itensfilho where id_item = 10114;
delete from db_itensfilho where id_item = 10113;
delete from db_arquivos   where codfilho = 5850;
delete from db_arquivos   where codfilho = 5849;
delete from db_menu       where id_item_filho = 10114 AND modulo = 2323;
delete from db_itensmenu  where id_item = 10114;
delete from db_menu       where id_item_filho = 10113 AND modulo = 2323;
delete from db_itensmenu  where id_item = 10113;

--Menus para vinculação de portaria a assentamentos
delete from db_arquivos  where codfilho = 5851;
delete from db_menu      where id_item_filho = 10116 AND modulo = 2323;
delete from db_itensmenu where id_item = 10116;

--Remove coluna na tabela de configuração financeira de tipos de assentamentos
delete from db_sysarqcamp where codarq = 3821 and codcam = 21323;
delete from db_syscampo where codcam = 21323;

---------------------------------------------------------------------------------------------
-------------------------------------- FIM TIME FOLHA ---------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
------------------------------- INICIO TIME EDUCAÇÃO / SAÚDE --------------------------------
---------------------------------------------------------------------------------------------

delete from db_menu where id_item_filho = 10115 AND modulo = 6877;
delete from db_itensmenu  where id_item = 10115;

-- tabela medicamentos
delete from db_syscampodep where codcam = 21290;
delete from db_syscampodef where codcam = 21290;
delete from db_sysarqcamp  where codarq = 3836;
delete from db_sysprikey   where codarq = 3836;
delete from db_syssequencia where codsequencia = 1000487;
delete from db_syscampo     where codcam in (21286, 21287, 21288, 21289, 21290, 21291, 21292);
delete from db_sysarqmod    where codarq = 3836;
delete from db_sysarquivo   where codarq = 3836;

--tabela integracaohorus
delete from db_syscampodep where codcam = 21297;
delete from db_syscampodef where codcam = 21297;
delete from db_sysforkey   where codarq = 3837;
delete from db_sysprikey   where codarq = 3837;
delete from db_sysarqcamp  where codarq = 3837;
delete from db_syscampo    where codcam in (21293, 21294, 21295, 21296, 21297, 21298, 21299);
delete from db_sysarqmod   where codarq = 3837;
delete from db_sysarquivo  where codarq = 3837;
delete from db_syssequencia where codsequencia = 1000488;

-- chave tabela far_matersaude
delete from db_sysforkey  where codarq = 2104 and codcam = 21300;
delete from db_sysarqcamp where codarq = 2104 and codcam = 21300;
delete from db_syscampo   where codcam = 21300;

delete from db_sysforkey where codarq = 2367 and codcam = 21304;
delete from db_sysindices where codind = 4230;
delete from db_sysarqcamp where codarq = 2367 and codcam = 21304;
delete from db_syscampo where codcam = 21304;
update db_syscampo set nomecam = 's104_i_profissional', conteudo = 'int4', descricao = 'Profissional', valorinicial = '0', rotulo = 'Profissional', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Profissional' where codcam = 13518;

delete from  db_menu where id_item = 1818 and id_item_filho = 4296  and modulo = 1000004;
delete from  db_menu where id_item = 4296 and id_item_filho = 4606  and modulo = 1000004;

delete from db_sysprikey    where codarq in (3841, 3842, 3840);
delete from db_sysforkey    where codarq in (3841, 3842, 3840);
delete from db_syscadind    where codind in (4233, 4234, 4235, 4236, 4237, 4238, 4239);
delete from db_sysindices   where codind in (4233, 4234, 4235, 4236, 4237, 4238, 4239);
delete from db_sysarqcamp   where codarq in (3841, 3842, 3840);
delete from db_syssequencia where codsequencia in (1000492, 1000493, 1000494);
delete from db_syscampo     where codcam in (21324, 21325, 21326, 21327, 21328, 21329, 21330, 21331, 21332, 21333, 21334, 21335, 21336, 21337, 21338);
delete from db_sysarqmod    where codarq in (3840, 3841, 3842);
delete from db_sysarquivo   where codarq in (3840, 3841, 3842);

delete from db_itensfilho where id_item in (10124, 10125, 10126, 10123);
delete from db_itensmenu  where id_item in (10124, 10125, 10126, 10123);
delete from db_menu where id_item_filho in ( 10124, 10125, 10126, 10123 ) AND modulo = 1000004;
delete from db_syssequencia where codsequencia = 1000495;
delete from db_syscadind where codind in (4240,4241, 4242, 4243);
delete from db_sysindices where codarq in (3843, 4242);
delete from db_sysforkey where codarq in (3843);
delete from db_sysarqcamp where codarq = 3843;
delete from db_sysprikey where codarq = 3843;
delete from db_sysarqmod where codarq = 3843;

delete from db_syscampo where codcam in (21339,21340,21341,21342,21343,21344,21345, 21346, 21347, 21348);
delete from db_sysarquivo where codarq = 3843;


delete from db_menu where id_item_filho in(10127, 10128, 10129, 10130);
delete from db_itensmenu where id_item in(10127, 10128, 10129, 10130);

delete from db_menu where id_item_filho = 10131 AND modulo = 1000004;
delete from db_itensmenu where id_item = 10131;

---------------------------------------------------------------------------------------------
-------------------------------- FIM TIME EDUCAÇÃO / SAÚDE ----------------------------------
---------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------
-------------------------------- INCIO TRIBUTÁRIO -------------------------------------------
---------------------------------------------------------------------------------------------

delete from db_syssequencia where codsequencia = 1000489;
delete from db_sysprikey where codarq = 3838;
delete from db_sysforkey where codarq = 3838;
delete from db_sysarqcamp where codarq = 3838;
delete from db_syscampo where codcam in (21301, 21302, 21303);
delete from db_sysarqmod where codarq = 3838;
delete from db_sysarquivo where codarq = 3838;

select fc_executa_ddl('insert into db_syscampo values(20849,''am10_tipolicenca'',''int4'',''Tipo de Licença'',''0'', ''Tipo de Licença'',10,''t'',''f'',''f'',1,''text'',''Tipo de Licença'')');
select fc_executa_ddl('insert into db_sysforkey values(3751,20849,1,3750,0)');
select fc_executa_ddl('insert into db_sysarqcamp values(3751,20849,4,0)');

delete from db_sysarqcamp where codcam = 21322;
delete from db_syscampo   where codcam = 21322;

update db_sysarqcamp set codsequencia = 0 where codarq = 896 and codcam = 5685;
delete from db_syssequencia where codsequencia = 1000491;

---------------------------------------------------------------------------------------------
-------------------------------- FIM TRIBUTÁRIO ---------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-------------------------------- INCIO FINANCEIRO -------------------------------------------
---------------------------------------------------------------------------------------------

-- Removendo menus novos e reorganizando os já existentes conforme anteriormente.
delete from db_menu where id_item_filho = 9884  AND modulo = 209;
delete from db_menu where id_item_filho = 9910  AND modulo = 209;
delete from db_menu where id_item_filho = 9911  AND modulo = 209;
delete from db_menu where id_item_filho = 10118 AND modulo = 209;
delete from db_menu where id_item_filho = 10117 AND modulo = 209;
delete from db_itensmenu where id_item = 10118;
delete from db_itensmenu where id_item = 10117;

insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (9909, 9884, 1, 209);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (9909, 9910, 2, 209);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (9909, 9911, 3, 209);

delete from orcparamseqfiltropadrao where o132_orcparamrel = 152;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 152;
delete from orcparamseq where o69_codparamrel = 152;
delete from orcparamrelperiodos where o113_orcparamrel = 152;
delete from orcparamrel where o42_codparrel = 152;

delete from orcparamseqfiltropadrao where o132_orcparamrel = 153;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 153;
delete from orcparamseq where o69_codparamrel = 153;
delete from orcparamrelperiodos where o113_orcparamrel = 153;
delete from orcparamrel where o42_codparrel = 153;

delete from orcparamseqfiltropadrao where o132_orcparamrel = 154;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 154;
delete from orcparamseq where o69_codparamrel = 154;
delete from orcparamrelperiodos where o113_orcparamrel = 154;
delete from orcparamrel where o42_codparrel = 154;


delete from db_sysarqcamp where codarq = 1595 and codcam = 21349;
delete from db_syscampo where codcam = 21349;

---------------------------------------------------------------------------------------------
-------------------------------- FIM FINANCEIRO---------------------------------------------
---------------------------------------------------------------------------------------------

UPDATE db_syscampo SET conteudo = 'varchar(50)', tamanho = 50 WHERE codcam = 12267;


---------------------------------------------------------------------------------------------
--------------------------------   INICIO AGUA  ---------------------------------------------
---------------------------------------------------------------------------------------------

update db_itensmenu set descricao = 'Excluir Credito', help = 'Excluir Credito', funcao = 'arr4_excluiCredito001.php' where id_item = 9627 ;
update db_arquivos set arqfilho = 'arr4_excluiCredito001.php', descfilho = 'arr4_excluiCredito001.php' where codfilho = 5704;

---------------------------------------------------------------------------------------------
--------------------------------     FIM AGUA   ---------------------------------------------
---------------------------------------------------------------------------------------------
