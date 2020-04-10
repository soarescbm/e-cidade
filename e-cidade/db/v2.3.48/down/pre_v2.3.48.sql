

---------------------------------------------------------------------------------------------
---------------------------------- INICIO FINANCEIRO -----------------------------------------
---------------------------------------------------------------------------------------------

delete from db_menu where id_item_filho in (10204, 10212, 10213, 10214, 10205) AND modulo = 381;
delete from db_itensmenu where id_item in (10204, 10212, 10213, 10214, 10205);

delete from db_layoutcampos   where db52_layoutlinha in(791, 792, 793, 794, 795);
delete from db_layoutlinha    where db51_layouttxt in (231, 232, 233);
delete from db_layouttxt      where db50_codigo in (231, 232, 233);

delete from db_sysarqcamp where codarq = 1324 and codcam in (21705, 21704);
delete from db_syscampodef where codcam = 7915;
delete from db_syscampo where codcam in (21704, 21705);

delete from db_syscadind where codind = 4321;
delete from db_sysindices where codind = 4321;
delete from db_sysforkey where codarq = 3900;
delete from db_sysprikey where codarq = 3900;
delete from db_sysarqcamp where codarq = 3900;
delete from db_syssequencia where codsequencia = 1000545;
delete from db_syscampo where codcam in (21706, 21707, 21708);
delete from db_sysarqmod where codarq = 3900;
delete from db_sysarquivo where codarq = 3900;

delete from db_sysarqcamp where codarq = 3163 and codcam = 21709;
delete from db_syscampodef where codcam = 21709;
delete from db_syscampo where codcam = 21709;

delete from db_syscampodef where codcam in (21710, 21711, 21712);
delete from db_sysprikey where codarq = 3901;
delete from db_sysforkey where codarq = 3901;
delete from db_sysarqcamp where codarq = 3901;
delete from db_syssequencia where codsequencia = 1000546;
delete from db_syscampo where codcam in (21710, 21711, 21712);
delete from db_sysarqmod where codarq = 3901;
delete from db_sysarquivo where codarq = 3901;

delete from db_sysforkey where codarq = 3902;
delete from db_sysprikey where codarq = 3902;
delete from db_sysarqcamp where codarq = 3902;
delete from db_syssequencia where codsequencia = 1000547;
delete from db_syscampodef where codcam in (21716, 21713, 21714, 21715);
delete from db_syscampo where codcam in (21713, 21714, 21715, 21716);
delete from db_sysarqmod where codarq = 3902;
delete from db_sysarquivo where codarq = 3902;

delete from db_layoutcampos where db52_layoutlinha in (796,797);
delete from db_layoutlinha where db51_layouttxt in (234);
delete from db_layouttxt where db50_codigo in (234);

delete from db_syscampodef where codcam = 21717;
delete from db_sysarqcamp where codarq = 3145 and codcam = 21717;
delete from db_syscampo where codcam = 21717;

-- LICITACAO
delete from db_layoutcampos where db52_layoutlinha in (798,799);
delete from db_layoutlinha where db51_layouttxt in (235);
delete from db_layouttxt where db50_codigo in (235);

delete from db_syscampodef where codcam in(21718, 21719, 21720);
delete from db_sysprikey where codarq = 3903;
delete from db_sysforkey where codarq = 3903;
delete from db_sysarqcamp where codarq = 3903;
delete from db_syssequencia where codsequencia = 1000548;
delete from db_syscampo where codcam in (21718, 21719, 21720);
delete from db_sysarqmod where codarq = 3903;
delete from db_sysarquivo where codarq = 3903;

-- Situacao Licitacao
update liclicita set l20_licsituacao = 1 where l20_licsituacao in (6,7);
update liclicitasituacao set l11_licsituacao = 1 where l11_licsituacao in (6,7);

delete from licsituacao where l08_sequencial = 6;
delete from licsituacao where l08_sequencial = 7;

-- Menu Habilitação de Fornecedores
delete from db_menu where id_item = 1818 and id_item_filho = 10206;
delete from db_itensmenu where id_item = 10206;

-- Menu Licitacoes - Procedimentos - Licitacao - Adjudicar
delete from db_menu where id_item_filho = 10207 AND modulo = 381;
delete from db_itensmenu where id_item = 10207;

-- Menu Licitacoes - Procedimentos - Licitacao - Homologar
delete from db_menu where id_item_filho = 10208 AND modulo = 381;
delete from db_itensmenu where id_item = 10208;

-- Tabela Habilitação de Fornecedores
delete from db_sysforkey where codarq = 3904 and codcam = 21722;
delete from db_sysprikey where codarq = 3904 and codcam = 21721;

delete from db_syssequencia where codsequencia = 1000549;
delete from db_sysarqcamp where codarq = 3904 and codcam = 21723;
delete from db_syscampodef where codcam = 21723;

delete from db_syscampo where codcam = 21723;
delete from db_sysarqcamp where codarq = 3904 and codcam = 21722;
delete from db_syscampodef where codcam = 21722;

delete from db_syscampo where codcam = 21722;
delete from db_sysarqcamp where codarq = 3904 and codcam = 21721;
delete from db_syscampodef where codcam = 21721;

delete from db_syscampo where codcam = 21721;
delete from db_sysarqmod where codmod = 19 and codarq = 3904;
delete from db_sysarquivo where codarq = 3904;

-- Arquivo Licitante
delete from db_layoutcampos where db52_layoutlinha in (800,801);
delete from db_layoutlinha where db51_layouttxt in (236);
delete from db_layouttxt where db50_codigo in (236);

-- Campo Tipo de Condição - Tabela de Fornecedores da Liquidação
delete from db_sysarqcamp where codarq = 1291 and codcam = 21728;
delete from db_syscampodef where codcam = 21728;
delete from db_syscampo where codcam = 21728;

-- DOTACAO_LIC
delete from db_layoutcampos where db52_layoutlinha in (802,803);
delete from db_layoutlinha where db51_layouttxt in (237);
delete from db_layouttxt where db50_codigo in (237);

-- EVENTOS_LIC
delete from db_layoutcampos where db52_layoutlinha in (804,805);
delete from db_layoutlinha where db51_layouttxt in (238);
delete from db_layouttxt where db50_codigo in (238);

-- DOCUMENTO_LIC
delete from db_layoutcampos where db52_layoutlinha in (806,807);
delete from db_layoutlinha where db51_layouttxt in (239);
delete from db_layouttxt where db50_codigo in (239);

-- deixar para o final
delete from db_layouttxtgrupo where db56_sequencial = 6;


delete from db_menu where id_item_filho = 10209 AND modulo = 381;
delete from db_itensfilho where id_item = 10209;
delete from db_itensmenu where id_item = 10209;

delete from db_sysarqcamp where codsequencia = 1000552 and codarq = 3916 and codcam = 21737;
delete from db_syssequencia where codsequencia = 1000552;
delete from db_syscadind where codind = 4328 and codcam = 21737;
delete from db_sysindices where codind = 4328 and codarq = 3916;
delete from db_sysprikey where codarq = 3916;
delete from db_sysarqcamp where codarq = 3916;
delete from db_syscampo where codcam in (21737,21738);
delete from db_sysarqmod where codarq = 3916;
delete from db_sysarquivo where codarq = 3916;

delete from db_sysarqcamp where  codsequencia = 1000553 and codarq = 3917 and codcam = 21739;
delete from db_syssequencia where codsequencia = 1000553;
delete from db_syscadind where codind = 4329 and codcam = 21740;
delete from db_sysindices where codind = 4329;
delete from db_sysforkey where codarq = 3917;

delete from db_syscampodep where codcam = 21741;
delete from db_syscampodef where codcam = 21741;

delete from db_syscampodep where codcam = 21748;
delete from db_syscampodef where codcam = 21748;

delete from db_syscampodep where codcam = 21746;
delete from db_syscampodef where codcam = 21746;

delete from db_sysprikey where codarq = 3917;
delete from db_sysarqcamp where codarq = 3917;
delete from db_syscampo where codcam in (21739,21740,21741,21742,21743,21744,21745,21746,21747,21748);
delete from db_sysarqmod where codarq = 3917;
delete from db_sysarquivo where codarq = 3917;

delete from db_sysarqcamp where codsequencia = 1000554 and codarq = 3918 and codcam = 21749;
delete from db_syssequencia where codsequencia = 1000554;
delete from db_syscadind where codcam = 21750;
delete from db_sysindices where codarq = 3918;
delete from db_sysprikey where codarq = 3918;
delete from db_sysarqcamp where codarq = 3918;
delete from db_sysforkey where codarq = 3918;
delete from db_syscampo where codcam in (21749,21750,21751,21752,21753);
delete from db_sysarqmod where codarq = 3918;
delete from db_sysarquivo where codarq = 3918;

delete from db_syscadind    where (codind, codcam, sequen) = (4331, 21758, 1);
delete from db_syssequencia where codsequencia = 1000555;
delete from db_sysindices   where nomeind = 'liclicitaencerramentolicitacon_sequencial_in';
delete from db_sysforkey    where codarq = 3920;
delete from db_sysprikey    where codarq = 3920;
delete from db_sysarqcamp   where codarq = 3920;
delete from db_syscampo     where codcam in (21760, 21759, 21758);
delete from db_sysarqmod    where codarq = 3920;
delete from db_sysarquivo   where codarq = 3920;

---------------------------------------------------------------------------------------------
---------------------------------- FIM FINANCEIRO -----------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
------------------------------- INICIO EDUCAÇÃO/SAÚDE ---------------------------------------
---------------------------------------------------------------------------------------------

update db_itensmenu set descricao = 'Atendimento Médico', help = 'Atendimento Médico', funcao = 'sau2_atendimentomedico000.php', desctec = 'Relatório de Atendimento Médico' where id_item = 7146;

delete from db_menu      where id_item_filho = 10210 AND modulo = 1000004;
delete from db_itensmenu where id_item = 10210;
---------------------------------------------------------------------------------------------
---------------------------------- FIM EDUCAÇÃO/SAÚDE ---------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
---------------------------------- INICIO FOLHA ---------------------------------------------
---------------------------------------------------------------------------------------------

delete from db_sysarqmod where codarq in(3914, 3915);

delete from db_syscampodef where codcam in(21729, 21730, 21731, 21732, 21733, 21734, 21735, 21736, 21754, 21755, 21756, 21757);
delete from db_sysarqcamp where codcam in(21729, 21730, 21731, 21732, 21733, 21734, 21735, 21736, 21754, 21755, 21756, 21757);

delete from db_sysprikey where codarq in(3914, 3915);
delete from db_sysforkey where codarq in(3914, 3915);

delete from db_sysindices where codarq in(3914, 3915);
delete from db_syscadind where codcam in(21730, 21731, 21732, 21734, 21735, 21736, 21754, 21755, 21756, 21757);

delete from db_syssequencia where codsequencia in (1000551, 1000550);

delete from db_syscampo where codcam in(21729, 21730, 21731, 21732, 21733, 21734, 21735, 21736, 21754, 21755, 21756, 21757);

delete from db_sysarquivo where codarq in(3914, 3915);

delete from db_menu where id_item_filho = 10211;
delete from db_itensmenu where id_item = 10211;
---------------------------------------------------------------------------------------------
---------------------------------- FIM FOLHA ------------------------------------------------
---------------------------------------------------------------------------------------------



delete from db_menu where id_item_filho = 10210 AND modulo = 1000004;
