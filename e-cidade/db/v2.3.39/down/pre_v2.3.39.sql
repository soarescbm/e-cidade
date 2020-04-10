
------------------------------------------------------------------------------------
------------------------------ INICIO TIME C ---------------------------------------
------------------------------------------------------------------------------------
-- EDUCAÇÃO
delete from db_menu where id_item_filho = 10084 AND modulo = 1100747;
delete from db_menu where id_item_filho = 10084 AND modulo = 7159;
delete from db_itensmenu where id_item  = 10084;

-- SAÚDE
update db_itensmenu set id_item = 7221 , descricao = 'Prestadores' , help = 'Cadastro de Prestadores' , itemativo = '1' , manutencao = '1' , desctec = 'Cadastro de Prestadores.' , libcliente = 'false' where id_item = 7221;
update db_itensmenu set id_item = 7222 , descricao = 'Inclusão' , help = 'Inclusão de Sau_prestadores' , funcao = 'sau1_sau_prestadores000.php?op=1' , itemativo = '1' , manutencao = '1' , desctec = 'Inclusão de Sau_prestadores' , libcliente = 'false' where id_item = 7222;
update db_itensmenu set id_item = 7223 , descricao = 'Alteração' , help = 'Alteração de Sau_prestadores' , funcao = 'sau1_sau_prestadores000.php?op=2' , itemativo = '1' , manutencao = '1' , desctec = 'Alteração de Sau_prestadores' , libcliente = 'false' where id_item = 7223;
update db_itensmenu set id_item = 7224 , descricao = 'Exclusão' , help = 'Exclusão de Sau_prestadores' , funcao = 'sau1_sau_prestadores000.php?op=3' , itemativo = '1' , manutencao = '1' , desctec = 'Exclusão de Sau_prestadores' , libcliente = 'false' where id_item = 7224;
update db_itensmenu set id_item = 7233 , descricao = 'Agendamento de Exames' , help = 'Agendamento de Exames' , funcao = 'sau4_sau_agendaexames001.php' , itemativo = '1' , manutencao = '1' , desctec = 'Agendamento de Exames.' , libcliente = 'false' where id_item = 7233;

update db_syscampo set nomecam = 's111_i_exame', conteudo = 'int4', descricao = 'Código do exame.', valorinicial = '0', rotulo = 'Exame', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Exame' where codcam = 13568;
delete from db_sysforkey where codarq = 2374 and codcam = 13568;
delete from db_sysindices where codind = 4226;
delete from db_syscadind where codind = 4226 and codcam = 13568;
update db_syscampo set nomecam = 's113_c_encaminhamento', conteudo = 'varchar(10)', descricao = 'Encaminhamento', valorinicial = '', rotulo = 'Encaminhamento', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Encaminhamento' where codcam = 14323;

-------------------------------------------------------------------------------------
-------------------------------- FIM TIME C -----------------------------------------
-------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------
-------------------------------------- INICIO TIME FOLHA ---------------------------------------
---------------------------------------------------------------------------------------------
delete from db_syscadind   where codind in (4220, 4221);
delete from db_sysindices  where codind in (4220, 4221);

delete from db_sysforkey   where codarq in (3819, 3818, 3820, 3821 );
delete from db_sysprikey   where codarq in (3819, 3818, 3820, 3821 );
delete from db_sysarqcamp  where codarq in (3819, 3818, 3820, 3821 );
delete from db_syscampodef where codcam in (21215, 21212,21211, 21210, 21208, 21207, 21206, 21205, 21204, 21222, 21221, 21220, 21219, 21218, 21217);
delete from db_syscampodep where codcam in (21215, 21212,21211, 21210, 21208, 21207, 21206, 21205, 21204, 21222, 21221, 21220, 21219, 21218, 21217);
delete from db_syscampo    where codcam in (21215, 21212,21211, 21210, 21208, 21207, 21206, 21205, 21204, 21222, 21221, 21220, 21219, 21218, 21217,21258,21259);
delete from db_sysarqmod   where codarq in (3819, 3818, 3820, 3821);
delete from db_processa    where codarq in (3819, 3818, 3820, 3821);
delete from db_sysarquivo  where codarq in (3819, 3818, 3820, 3821);

delete from db_syssequencia where codsequencia in(1000475, 1000476) ;
--Menu
delete from db_menu       where id_item_filho in ( 10088, 10087, 10086, 10085, 10093  );
delete from db_itensfilho where id_item       in ( 10088, 10087, 10086, 10093);
delete from db_arquivos   where arqfilho      in ( 'db_frmdb_formulas.php',
                                                   'func_db_formulas.php',
                                                   'db_func_db_formulas.php',
                                                   'con1_db_formulas003.php',
                                                   'con1_db_formulas002.php',
                                                   'con1_db_formulas001.php');
delete from db_itensmenu  where id_item       in ( 10088, 10087, 10086, 10085,10093);

update db_itensmenu set descricao = 'Lançamento de Substituição no Ponto', help = 'Lançamento de Substituição no Ponto', desctec = 'Menu utilizado para selecionar os assentamentos de substituição que serão pagos', libcliente = '1' where id_item = 10066;


--Tabelas de situação de afastamentos e vinculação de tipo de assentamentos e códigos sefip, situação funcionário
delete from db_syssequencia where codsequencia = 1000485;
delete from db_syssequencia where codsequencia = 1000484;

delete from db_syscadind where codind = 4225;

delete from db_sysindices where codind = 4225;

delete from db_sysforkey where codarq = 3833;
delete from db_sysforkey where codarq = 3834;

delete from db_sysprikey where codarq = 3833;
delete from db_sysprikey where codarq = 3832;

delete from db_sysarqcamp where codarq = 3833;
delete from db_sysarqcamp where codarq = 3832;
delete from db_sysarqcamp where codarq = 3834;

delete from db_syscampodep where codcam = 21269;
delete from db_syscampodef where codcam = 21269;
delete from db_syscampodep where codcam = 21270;
delete from db_syscampodef where codcam = 21270;

delete from db_syscampo where codcam = 21274;
delete from db_syscampo where codcam = 21273;
delete from db_syscampo where codcam = 21272;
delete from db_syscampo where codcam = 21271;
delete from db_syscampo where codcam = 21270;
delete from db_syscampo where codcam = 21269;
delete from db_syscampo where codcam = 21268;
delete from db_syscampo where codcam = 21265;
delete from db_syscampo where codcam = 21264;
delete from db_syscampo where codcam = 21275;
delete from db_syscampo where codcam = 21276;

delete from db_sysarqmod where codmod = 28 and codarq = 3833;
delete from db_sysarqmod where codmod = 28 and codarq = 3832;
delete from db_sysarqmod where codmod = 29 and codarq = 3834;

delete from db_sysarquivo where codarq = 3833;
delete from db_sysarquivo where codarq = 3832;
delete from db_sysarquivo where codarq = 3834;

delete from db_menu where id_item = 10093;
delete from db_itensfilho where id_item = 10093;
delete from db_itensmenu where id_item = 10111;
delete from db_itensmenu where id_item = 10110;
delete from db_itensmenu where id_item = 10093;

delete from  db_sysarqcamp  where codcam = 21277;
delete from db_syscampodef  where codcam = 21277;
delete from  db_syscampodep where codcam = 21277;
delete from  db_syscampo    where codcam = 21277;

---------------------------------------------------------------------------------------------
-------------------------------------- FIM TIME FOLHA ---------------------------------------
---------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
---------------------------------- INICIO FINANCEIRO -----------------------------------
----------------------------------------------------------------------------------------

update db_itensmenu set funcao = 'far2_distribuicao001.php?lmater=true' where id_item = 8614;

-- Fluxo sde Caixa - DCASP
delete from orcparamseqfiltropadrao where o132_orcparamrel = 150;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 150;
delete from orcparamseq where o69_codparamrel = 150;
delete from orcparamrelperiodos where o113_orcparamrel = 150;
delete from orcparamrel where o42_codparrel = 150;

-- Balanco Patrimonial - DCASP
delete from orcparamseqfiltropadrao where o132_orcparamrel = 151;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 151;
delete from orcparamseq where o69_codparamrel = 151;
delete from orcparamrelperiodos where o113_orcparamrel = 151;
delete from orcparamrel where o42_codparrel = 151;

-- Execução de Acordo
delete from db_sysarqcamp where codarq = 2942 and codcam in (21266, 21267);
delete from db_syscampo where codcam in (21266, 21267);

-- Linha digitável
delete from db_sysarqcamp where codarq = 3595 and codcam = 21278;
delete from db_syscampo where codcam = 21278;

----------------------------------------------------------------------------------------
---------------------------------- FIM FINANCEIRO --------------------------------------
----------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------
-------------------------------------- TRIBUTARIO ---------------------------------------
---------------------------------------------------------------------------------------------

delete from db_sysarqcamp where codarq = 3207 and codcam = 21216;
delete from db_syscampo where codcam = 21216;
delete from db_menu where id_item_filho = 10089 AND modulo = 81;
delete from db_menu where id_item_filho = 10090 AND modulo = 81;
delete from db_menu where id_item_filho = 10091 AND modulo = 81;
delete from db_menu where id_item_filho = 10092 AND modulo = 81;
delete from db_itensmenu where id_item in (10089, 10090, 10091, 10092);
update db_itensmenu set funcao = 'jur1_cartorio001.php' where id_item = 8864;
update db_itensmenu set funcao = 'jur1_cartorio002.php' where id_item = 8865;
update db_itensmenu set funcao = 'jur1_cartorio003.php' where id_item = 8866;

delete from db_syssequencia where codsequencia in (1000479, 1000478);
delete from db_sysindices   where codind in (4222);
delete from db_syscadind    where codind in (4222);
delete from db_sysforkey    where codarq in (3824, 3822);
delete from db_sysprikey    where codarq in (3824, 3822);
delete from db_sysarqcamp   where codarq in (3824, 3822);
delete from db_syscampo     where codcam in (21232, 21233, 21234, 21235, 21229, 21230, 21231);
delete from db_syscampodep  where codcam in (21232, 21233, 21234, 21235, 21229, 21230, 21231);
delete from db_syscampodef  where codcam in (21232, 21233, 21234, 21235, 21229, 21230, 21231);
delete from db_sysarqmod    where codarq in (3824, 3822);
delete from db_sysarquivo   where codarq in (3824, 3822);

delete from db_menu where id_item_filho in (10099, 10098, 10096);
delete from db_itensmenu where id_item in (10099, 10098, 10096);

delete from db_syssequencia where codsequencia = 1000481;
delete from db_sysforkey where codarq = 3828;
delete from db_sysprikey where codarq = 3828;
delete from db_sysarqcamp where codarq = 3828;
delete from db_syscampodep where codcam in (21248, 21244, 21245);
delete from db_syscampodef where codcam in (21248, 21244, 21245);
delete from db_syscampo where codcam in (21248, 21244, 21245);
delete from db_sysarqmod where codarq = 3828;
delete from db_sysarquivo where codarq = 3828;

delete from db_sysarqcamp where codcam = 21261;
delete from db_syscampo where   codcam = 21261;

delete from db_menu where id_item_filho in (10112);
delete from db_itensmenu where id_item in (10112);

---------------------------------------------------------------------------------------------
-------------------------------------- FIM TRIBUTARIO ---------------------------------------
---------------------------------------------------------------------------------------------