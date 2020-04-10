/**
 * Tributário
 */
--zonassetorvalor
delete from iptutabelas    where j121_codarq = 3783;

delete from db_sysarqmod   where codarq = 3783;
delete from db_sysarqarq   where codarq = 3783;
delete from db_sysarqcamp  where codcam in (20996, 20997, 20998, 20999, 21001, 21000);
delete from db_syscampodef where codcam in (20996, 20997, 20998, 20999, 21001, 21000);

delete from db_sysforkey   where codarq = 3783;
delete from db_sysprikey   where codarq = 3783;

delete from db_syscadind   where codind = 4166;
delete from db_sysindices  where codind = 4166;

delete from db_syscampo    where codcam in (20996, 20997, 20998, 20999, 21001, 21000);
delete from db_sysarquivo  where codarq = 3783;
/**
 * Fim Tributário
 */

------------------------------------------
------------------- TIME C ---------------
------------------------------------------
update db_syscampo set descricao = 'Descrição', rotulo = 'Descrição' where codcam = 12513;
update db_syscampo set descricao = 'Descrição', rotulo = 'Descrição' where codcam = 1008526;

update db_itensmenu set funcao = 'sau2_agendamento001.php' where id_item = 7072;

delete from db_sysarqcamp where codcam = 20989;
delete from db_syscampo   where codcam = 20989;

delete from db_sysarqcamp where codcam = 21004;
delete from db_syscampo   where codcam = 21004;

-------------------------------------------------------
------------- TAREFA TIPO HORA INICIO -----------------
-------------------------------------------------------

delete from db_syssequencia where codsequencia in (1000445, 1000446);
delete from db_syscadind    where codind in (4170, 4171, 4172, 4173, 4174, 4175, 4176, 4177, 4178, 4179, 4180, 4181, 4182);
delete from db_sysindices   where codind in (4170, 4171, 4172, 4173, 4174, 4175, 4176, 4177, 4178, 4179, 4180, 4181, 4182);
delete from db_sysforkey    where codarq in (3789, 3790);
delete from db_sysprikey    where codarq in (3789, 3790);
delete from db_sysforkey    where codcam in (21040, 21041);
delete from db_sysarqcamp   where codcam in ( 21027, 21028, 21029, 21030, 21031, 21032, 21033, 21034, 21035, 21036, 21037, 21038, 21039, 21040, 21041, 21042, 21043);
delete from db_syscampodef  where codcam in ( 21027, 21028, 21029, 21030, 21031, 21032, 21033, 21034, 21035, 21036, 21037, 21038, 21039, 21040, 21041, 21042, 21043);
delete from db_syscampo     where codcam in ( 21027, 21028, 21029, 21030, 21031, 21032, 21033, 21034, 21035, 21036, 21037, 21038, 21039, 21040, 21041, 21042, 21043);
delete from db_sysarqmod    where codarq in (3789, 3790);
delete from db_sysarquivo   where codarq in (3789, 3790);

-- Item de menu
delete from db_menu      where id_item_filho = 10054 AND modulo = 1100747;
delete from db_itensmenu where id_item = 10054;
-------------------------------------------------------
-------------- TAREFA TIPO HORA FIM -------------------
-------------------------------------------------------

------------------------------------------
--------------- FIM TIME C ---------------
------------------------------------------


--- Financeiro ---
--- Tarefa 97594
drop table if exists db_paragrafopadrao_97594;
create temp table db_paragrafopadrao_97594 as select db62_codparag as paragrafo from db_docparagpadrao where db62_coddoc in (select db60_coddoc from db_documentopadrao where db60_tipodoc = 5019);

delete from db_docparagpadrao where db62_coddoc in (select db60_coddoc from db_documentopadrao where db60_tipodoc = 5019);
delete from db_paragrafopadrao where db61_codparag in (select paragrafo from db_paragrafopadrao_97594);
delete from db_documentopadrao where db60_tipodoc = 5019;
delete from db_tipodoc where db08_codigo = 5019;

--
delete from db_menu where id_item_filho = 10047 AND modulo = 439;
delete from db_itensmenu where id_item = 10047;


-- Anexo I

delete from orcparamseqfiltropadrao where o132_orcparamrel = 145;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 145;
delete from orcparamseq where o69_codparamrel = 145;
delete from orcparamrelperiodos where o113_orcparamrel = 145;
delete from orcparamrel where o42_codparrel = 145;

-- Anexo VI
delete from orcparamseqfiltropadrao where o132_orcparamrel = 146;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 146;
delete from orcparamseq where o69_codparamrel = 146;
delete from orcparamrelperiodos where o113_orcparamrel = 146;
delete from orcparamrel where o42_codparrel = 146;

-- Anexo VIII
delete from orcparamseqfiltropadrao where o132_orcparamrel = 147;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 147;
delete from orcparamseq where o69_codparamrel = 147;
delete from orcparamrelperiodos where o113_orcparamrel = 147;
delete from orcparamrel where o42_codparrel = 147;

-- Anexo IV
delete from orcparamseqfiltropadrao where o132_orcparamrel = 148;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 148;
delete from orcparamseq where o69_codparamrel = 148;
delete from orcparamrelperiodos where o113_orcparamrel = 148;
delete from orcparamrel where o42_codparrel = 148;

-- Anexo XII
delete from orcparamseqfiltropadrao where o132_orcparamrel = 149;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 149;
delete from orcparamseq where o69_codparamrel = 149;
delete from orcparamrelperiodos where o113_orcparamrel = 149;
delete from orcparamrel where o42_codparrel = 149;

--- Relatorios do RREO

delete from orcparamseqcoluna where o115_sequencial in (185, 186, 187, 188, 189);

-------------------------------
------ INÍCIO TIME FOLHA ------
-------------------------------
delete from db_sysarqcamp where codarq = 1158 and codcam = 20987 and seqarq = 26;
delete from db_syscampo where codcam = 20987;

delete from db_syscampodef where codcam = 20988;
delete from db_sysarqcamp  where codarq = 536 and codcam = 20988 and seqarq = 87;
delete from db_syscampo where codcam = 20988;

delete from db_menu where id_item_filho = 10048 AND modulo = 952;
delete from db_itensmenu where id_item = 10048;

--Itens de menu dos consignados (Consignet)
delete from db_menu where id_item_filho = 10053 AND modulo = 952;
delete from db_menu where id_item_filho = 10052 AND modulo = 952;
delete from db_menu where id_item_filho = 10051 AND modulo = 952;
delete from db_menu where id_item_filho = 10050 AND modulo = 952;
delete from db_menu where id_item_filho = 10049 AND modulo = 952;
delete from db_itensmenu where id_item = 10053;
delete from db_itensmenu where id_item = 10052;
delete from db_itensmenu where id_item = 10051;
delete from db_itensmenu where id_item = 10050;
delete from db_itensmenu where id_item = 10049;

--Indices, sequencias, chaves primárias e estrangeiras vinculações de campos para os consignados (Consignet)
delete from db_syscadind where codind = 4169 and codcam = 21025;
delete from db_syscadind where codind = 4168 and codcam = 21005;
delete from db_syssequencia where codsequencia = 1000444;
delete from db_syssequencia where codsequencia = 1000443;
delete from db_syssequencia where codsequencia = 1000442;
delete from db_syssequencia where codsequencia = 1000441;
delete from db_sysindices where codind = 4169;
delete from db_sysindices where codind = 4168;
delete from db_sysforkey where codarq = 3787;
delete from db_sysforkey where codarq = 3786;
delete from db_sysforkey where codarq = 3785;
delete from db_sysprikey where codarq = 3788;
delete from db_sysprikey where codarq = 3787;
delete from db_sysprikey where codarq = 3786;
delete from db_sysprikey where codarq = 3785;
delete from db_sysarqcamp where codarq = 3788;
delete from db_sysarqcamp where codarq = 3787;
delete from db_sysarqcamp where codarq = 3786;
delete from db_sysarqcamp where codarq = 3785;

--Valores default dos campos
delete from db_syscampodef where codcam = 21022;
delete from db_syscampodef where codcam = 21016;

--Campos das tabelas para os consignados (Consignet)
delete from db_syscampo where codcam = 21026;
delete from db_syscampo where codcam = 21025;
delete from db_syscampo where codcam = 21024;
delete from db_syscampo where codcam = 21023;
delete from db_syscampo where codcam = 21022;
delete from db_syscampo where codcam = 21021;
delete from db_syscampo where codcam = 21020;
delete from db_syscampo where codcam = 21019;
delete from db_syscampo where codcam = 21018;
delete from db_syscampo where codcam = 21017;
delete from db_syscampo where codcam = 21016;
delete from db_syscampo where codcam = 21015;
delete from db_syscampo where codcam = 21014;
delete from db_syscampo where codcam = 21013;
delete from db_syscampo where codcam = 21012;
delete from db_syscampo where codcam = 21011;
delete from db_syscampo where codcam = 21010;
delete from db_syscampo where codcam = 21009;
delete from db_syscampo where codcam = 21008;
delete from db_syscampo where codcam = 21007;
delete from db_syscampo where codcam = 21006;
delete from db_syscampo where codcam = 21005;

--Vinculações das tabelas dos consignados (Consignet) ao módulo pessoal
delete from db_sysarqmod where codmod = 28 and codarq = 3788;
delete from db_sysarqmod where codmod = 28 and codarq = 3787;
delete from db_sysarqmod where codmod = 28 and codarq = 3786;
delete from db_sysarqmod where codmod = 28 and codarq = 3785;

--Tabelas dos consignados (consignet)
delete from db_sysarquivo where codarq = 3788;
delete from db_sysarquivo where codarq = 3787;
delete from db_sysarquivo where codarq = 3786;
delete from db_sysarquivo where codarq = 3785;

---- Cadastro de layout para o consignet ----
---------------------------------------------
--Excluindo os campos do layout do arquivo de margens, de importação e de retorno
delete from db_layoutcampos where db52_codigo = 11964 and db52_layoutlinha = 733;
delete from db_layoutcampos where db52_codigo = 11963 and db52_layoutlinha = 733;
delete from db_layoutcampos where db52_codigo = 11962 and db52_layoutlinha = 733;
delete from db_layoutcampos where db52_codigo = 11961 and db52_layoutlinha = 733;
delete from db_layoutcampos where db52_codigo = 11960 and db52_layoutlinha = 733;
delete from db_layoutcampos where db52_codigo = 11959 and db52_layoutlinha = 733;
delete from db_layoutcampos where db52_codigo = 11958 and db52_layoutlinha = 733;
delete from db_layoutcampos where db52_codigo = 11957 and db52_layoutlinha = 733;
delete from db_layoutcampos where db52_codigo = 11956 and db52_layoutlinha = 733;
delete from db_layoutcampos where db52_codigo = 11955 and db52_layoutlinha = 733;
delete from db_layoutcampos where db52_codigo = 11954 and db52_layoutlinha = 732;
delete from db_layoutcampos where db52_codigo = 11953 and db52_layoutlinha = 732;
delete from db_layoutcampos where db52_codigo = 11952 and db52_layoutlinha = 732;
delete from db_layoutcampos where db52_codigo = 11951 and db52_layoutlinha = 732;
delete from db_layoutcampos where db52_codigo = 11950 and db52_layoutlinha = 732;
delete from db_layoutcampos where db52_codigo = 11948 and db52_layoutlinha = 732;
delete from db_layoutcampos where db52_codigo = 11947 and db52_layoutlinha = 731;
delete from db_layoutcampos where db52_codigo = 11946 and db52_layoutlinha = 731;
delete from db_layoutcampos where db52_codigo = 11945 and db52_layoutlinha = 731;
delete from db_layoutcampos where db52_codigo = 11944 and db52_layoutlinha = 731;
delete from db_layoutcampos where db52_codigo = 11943 and db52_layoutlinha = 731;
delete from db_layoutcampos where db52_codigo = 11942 and db52_layoutlinha = 731;
delete from db_layoutcampos where db52_codigo = 11941 and db52_layoutlinha = 731;
delete from db_layoutcampos where db52_codigo = 11940 and db52_layoutlinha = 731;
delete from db_layoutcampos where db52_codigo = 11939 and db52_layoutlinha = 731;
delete from db_layoutcampos where db52_codigo = 11938 and db52_layoutlinha = 731;
delete from db_layoutcampos where db52_codigo = 11937 and db52_layoutlinha = 731;
delete from db_layoutcampos where db52_codigo = 11936 and db52_layoutlinha = 731;
--Excluindo o layout de linha do arquivo de margens, de importação e de retorno
delete from db_layoutlinha where db51_codigo = 733 and db51_layouttxt = 225;
delete from db_layoutlinha where db51_codigo = 732 and db51_layouttxt = 224;
delete from db_layoutlinha where db51_codigo = 731 and db51_layouttxt = 223;
--Excluindo o layout do arquivo de margens, de importação e de retorno
delete from db_layouttxt where db50_codigo = 225 and db50_layouttxtgrupo = 1;
delete from db_layouttxt where db50_codigo = 224 and db50_layouttxtgrupo = 1;
delete from db_layouttxt where db50_codigo = 223 and db50_layouttxtgrupo = 1;

-------------------------------
------- FIM TIME FOLHA --------
-------------------------------