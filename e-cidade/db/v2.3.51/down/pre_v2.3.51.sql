---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO FOLHA ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------


delete from db_sysforkey    where codarq = 3936;
delete from db_sysprikey    where codarq = 3936;
delete from db_syssequencia where codsequencia = 1000570;
delete from db_sysarqmod    where codarq = 3936;
delete from db_sysindices   where codarq = 3936;
delete from db_syscadind    where codcam in (21839, 21840, 21859, 21860, 21861, 21862, 21863, 21869, 21870);
delete from db_syscampodep  where codcam in (21839, 21840, 21859, 21860, 21861, 21862, 21863, 21869, 21870);
delete from db_sysarqcamp   where codcam in (21839, 21840, 21859, 21860, 21861, 21862, 21863, 21869, 21870);
delete from db_syscampo     where codcam in (21839, 21840, 21859, 21860, 21861, 21862, 21863, 21869, 21870);
delete from db_sysarquivo where codarq in (3936);
delete from db_menu where id_item_filho in(10231, 10232, 10233, 10234, 10235, 10238);
delete from db_itensmenu where id_item in(10231,10232, 10233,10234, 10235,10238);

delete from db_layoutcampos where db52_layoutlinha in(836,837, 838);
delete from db_layoutlinha  where db51_layouttxt in(254);
delete from db_layouttxt  where db50_codigo in(254);
delete from pessoal.rhconsignadomotivo where rh154_sequencial in (8, 9);
---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO FINANCEIRO ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

select fc_executa_ddl('delete from db_syscampodef where codcam = 21843;');
select fc_executa_ddl('delete from db_sysarqcamp where codcam in(21841, 21842, 21843)');
select fc_executa_ddl('delete from db_syscampo where codcam in(21841, 21842, 21843)');
DELETE from acordoposicaotipo where ac27_sequencial in(7,8);
delete from db_menu where id_item_filho = 10226 AND modulo = 8251;
delete from db_menu where id_item_filho = 10227 AND modulo = 8251;
delete from db_itensmenu where id_item in(10226, 10227);

delete from db_syssequencia where nomesequencia = 'acordoencerramentolicitacon_ac58_sequencial_seq';
delete from db_sysarqcamp   where codarq = 3933;
delete from db_sysforkey    where codarq = 3933;
delete from db_sysprikey    where codarq = 3933;
delete from db_syscampo     where codcam in(21845, 21846, 21847);
delete from db_sysarqmod    where codarq = 3933;
delete from db_acount       where codarq = 3933;
delete from db_sysarquivo   where codarq = 3933;

-- Campo Ano do Exercício na Tabela acordoempempenho
select fc_executa_ddl('delete from db_sysarqcamp where codarq = 3926 and codcam = 21848;');
select fc_executa_ddl('delete from db_syscampo   where codcam = 21848;');

-- Campo Unidade da autorização de empenho
delete from db_sysforkey where codcam = 21868 and codarq = 811;
delete from db_sysarqcamp where codcam = 21868;
delete from db_syscampo where codcam = 21868;

delete from db_menu where id_item_filho = 10236 AND modulo = 209;
delete from db_itensmenu where id_item = 10236;

-- Configuração do relatório Demonstração das Mutações do Patrimônio Líquido
delete from db_menu      where id_item_filho = 10237;
delete from db_itensmenu where id_item       = 10237;

delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 161;
delete from orcparamseq                  where o69_codparamrel  = 161;
delete from orcparamrelperiodos          where o113_orcparamrel = 161;
delete from orcparamseqcoluna            where o115_sequencial in(207, 208, 209, 210, 211, 212, 213, 214);
delete from orcparamrel                  where o42_codparrel    = 161;

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

delete from db_syscadind  where codind = 4343;
delete from db_sysindices where codind = 4343;
delete from db_sysforkey  where codcam = 21844;
delete from db_sysarqcamp where codcam = 21844;
delete from db_syscampo   where codcam = 21844;
update db_syscampo set nomecam = 'ed18_latitude', conteudo = 'varchar(10)', descricao = 'Latitude', valorinicial = '', rotulo = 'Latitude', nulo = 't', tamanho = 20, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Latitude' where codcam = 18917;
update db_syscampo set nomecam = 'ed18_longitude', conteudo = 'varchar(10)', descricao = 'Longitude', valorinicial = '', rotulo = 'Longitude', nulo = 't', tamanho = 20, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Longitude' where codcam = 18918;

delete from avaliacaoperguntaopcaolayoutcampo where ed313_ano = 2015 and ed313_db_layoutcampo in (12127, 12129, 12131, 12133, 12134, 12135, 12136, 12141, 12143, 12145, 12147, 12148, 12150, 12151, 12152, 12153, 12155, 12156, 12158, 12159);

update avaliacaoperguntaopcaolayoutcampo
  set ed313_layoutvalorcampo = '0'
  where ed313_db_layoutcampo in (
    12269, 12275, 12281, 12284, 12288, 12289, 12291, 12294, 12297, 12299, 12301, 12303, 12304, 12306, 12310, 12313, 12347, 12277, 12320, 12322, 12325, 12328, 12333, 12336, 12339, 12340, 12341, 12342, 12344, 12361, 12170, 12172, 12174, 12176, 12178, 12181, 12183, 12187, 12247, 12248, 12250, 12377, 12378, 12379, 12350, 12351, 12352, 12353, 12354, 12355, 12356, 12357, 12358, 12359, 12360, 12255, 12257, 12260, 12262, 12264, 12266, 12214, 12218, 12223, 12228, 12231, 12234, 12237, 12241, 12245, 12316, 12185, 12362
  ) and ed313_ano = 2015;

update avaliacaoperguntaopcaolayoutcampo set ed313_layoutvalorcampo = '0' where ed313_avaliacaoperguntaopcao = 3000099 and ed313_ano = 2015;
update avaliacaoperguntaopcaolayoutcampo set ed313_layoutvalorcampo = '1' where ed313_avaliacaoperguntaopcao = 3000100 and ed313_ano = 2015;

---------------------------------------------------------------------------------------------------------------
------------------------------------------- INICIO SAUDE ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
delete from db_menu         where id_item = 8323 and id_item_filho = 10230;
delete from db_itensmenu    where id_item = 10230;

delete from db_syssequencia where codsequencia = 1000568;
delete from db_syscadind    where codind = 4344 and codcam = 21851 and sequen = 1;
delete from db_sysindices   where codind = 4344;
delete from db_sysforkey    where codarq = 3934;
delete from db_sysprikey    where codarq = 3934;
delete from db_sysarqcamp   where codarq = 3934;
delete from db_syscampo     where codcam in( 21849, 21850, 21851 );
delete from db_sysarqmod    where codmod = 70 and codarq = 3934;
delete from db_sysarquivo   where codarq = 3934;

delete from db_sysarqcamp  where codarq = 2873 and seqarq = 9;
delete from db_syscampodef where codcam = 21852;
delete from db_syscampo    where codcam = 21852;

delete from db_syssequencia where codsequencia = 1000569;
delete from db_syscadind    where codind = 4350 and codcam = 21856 and sequen = 1;
delete from db_syscadind    where codind = 4350 and codcam = 21866 and sequen = 2;
delete from db_sysindices   where codind = 4350;
delete from db_sysforkey    where codarq = 3935;
delete from db_sysprikey    where codarq = 3935;
delete from db_sysarqcamp   where codarq = 3935;
delete from db_syscampo     where codcam in( 21855, 21856, 21857, 21866, 21867 );
delete from db_sysarqmod    where codmod = 70 and codarq = 3935;
delete from db_sysarquivo   where codarq = 3935;

delete from db_docparagpadrao where db62_coddoc = 252;
delete from db_paragrafopadrao where db61_codparag in (549, 550);
delete from db_documentopadrao where db60_coddoc = 252;
delete from db_tipodoc where db08_codigo = 5025;