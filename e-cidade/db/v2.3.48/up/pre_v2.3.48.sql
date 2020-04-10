
---------------------------------------------------------------------------------------------
---------------------------------- INICIO FINANCEIRO -----------------------------------------
---------------------------------------------------------------------------------------------

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10204 ,'Exportação de Dados' ,'Exportação de Dados' ,'' ,'1' ,'1' ,'Exportação de Dados do Módulo Licitação' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1818 ,10204 ,115 ,381 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10212 ,'LicitaCon TCE/RS' ,'LicitaCon TCE/RS' ,'' ,'1' ,'1' ,'Exportação de Dados para o LicitaCon TCE/RS' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10204 ,10212 ,2 ,381 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10213 ,'Geração de Arquivos' ,'Geração de Arquivos' ,'lic4_licitacon001.php' ,'1' ,'1' ,'Geração de Arquivos para o LicitaCon TCE/RS' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10212 ,10213 ,1 ,381 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10214 ,'Confirmação de Envio' ,'Confirmação de Envio' ,'lic4_licitaconencerramento001.php' ,'1' ,'1' ,'Confirmação de envio dos arquivos do LicitaCon TCE/RS' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10212 ,10214 ,2 ,381 );

insert into db_layouttxtgrupo (db56_sequencial, db56_layouttxtgrupotipo, db56_descr) values(6, 1, 'ARQUIVOS LICITACON TCE/RS');

-- PESSOAS
insert into db_layouttxt( db50_codigo ,db50_layouttxtgrupo ,db50_descr ,db50_quantlinhas ,db50_obs ) values ( 231 ,6 ,'TCE/RS - LICITACON - PESSOAS' ,0 ,'' );
insert into db_layoutlinha (db51_codigo, db51_layouttxt, db51_descr, db51_tipolinha, db51_tamlinha, db51_linhasantes, db51_linhasdepois, db51_obs, db51_separador, db51_compacta) values (791, 231, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true);
insert into db_layoutlinha (db51_codigo, db51_layouttxt, db51_descr, db51_tipolinha, db51_tamlinha, db51_linhasantes, db51_linhasdepois, db51_obs, db51_separador, db51_compacta) values (792, 231, 'REGISTRO', 3, 0, 0, 0, '', '|', true);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12753, 791, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12754, 791, 'DATA_INICIAL', 'DATA INICIAL', 1, 15, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12755, 791, 'DATA_FINAL', 'DATA FINAL', 1, 25, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12756, 791, 'DATA_GERACAO', 'DATA DE GERAÇÃO', 1, 35, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12757, 791, 'NOME_SETOR', 'NOME DO SETOR DE GOVERNO', 1, 45, '', 150, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12758, 791, 'TOTAL_REGISTROS', 'TOTAL DE REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12759, 792, 'TP_DOCUMENTO', 'TIPO DE DOCUMENTO', 1, 1, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12760, 792, 'NR_DOCUMENTO', 'NÚMERO DO DOCUMENTO', 1, 2, '', 14, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12761, 792, 'TP_PESSOA', 'TIPO DE PESSOA', 1, 16, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12762, 792, 'NM_PESSOA', 'NOME DA PESSOA', 1, 17, '', 60, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12763, 792, 'DS_OBJETO_SOCIAL', 'DESCRIÇÃO DO OBJETO SOCIAL', 1, 77, '', 60, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12764, 792, 'NR_INSCRICAO_ESTADUAL', 'NÚMERO DE INSCRIÇÃO  ESTADUAL', 1, 137, '', 30, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12765, 792, 'NR_INSCRICAO_MUNICIPAL', 'NÚMERO  DE INSCRIÇÃO  MUNICIPAL', 1, 167, '', 30, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12766, 792, 'CD_TIPO_CONSELHO_PROFISSIONAL', 'CÓDIGO  DO  CONSELHO  REGIONAL', 1, 197, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12767, 792, 'NR_CONSELHO_PROFISSIONAL', 'NÚMERO DO  CONSELHO  REGIONAL', 1, 207, '', 20, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12768, 792, 'SG_UF_CONSELHO_PROFISSIONAL', 'SIGLA DA UF DO CONSELHO REGIONAL', 1, 227, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12769, 792, 'DS_EMAIL', 'E-MAIL', 1, 229, '', 60, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12770, 792, 'DS_PAGINA_INTERNET', 'ENDEREÇO DO SITE DA PESSOA', 1, 289, '', 100, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12771, 792, 'SG_UF', 'SIGLA DA UF DO ENDEREÇO DA PESSOA', 1, 389, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12772, 792, 'CD_MUNICIPIO_IBGE', 'CÓDIGO IBGE DO MUNICÍPIO', 1, 391, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12773, 792, 'LOGRADOURO', 'NOME DO LOGRADOURO', 1, 401, '', 100, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12774, 792, 'NR_ENDERECO', 'NÚMERO DO ENDEREÇO DO LOGRADOURO', 1, 501, '', 5, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12775, 792, 'COMPLEMENTO', 'COMPLEMENTO DO ENDEREÇO', 1, 506, '', 40, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12776, 792, 'BAIRRO', 'NOME DO BAIRRO', 1, 546, '', 40, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12777, 792, 'CEP', 'NÚMERO DO CEP', 1, 586, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos (db52_codigo, db52_layoutlinha, db52_nome, db52_descr, db52_layoutformat, db52_posicao, db52_default, db52_tamanho, db52_ident, db52_imprimir, db52_alinha, db52_obs, db52_quebraapos) values (12778, 792, 'TELEFONE', 'TELEFONE', 1, 594, '', 40, false, true, 'd', '', 0);

-- MEMBROCONS
insert into db_layouttxt( db50_codigo ,db50_layouttxtgrupo ,db50_descr ,db50_quantlinhas ,db50_obs ) values ( 232 ,6 ,'TCE/RS - LICITACON - MEMBROCONS' ,0 ,'' );
insert into db_layoutlinha  values (793, 232, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true);
insert into db_layoutcampos values (12779, 793, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0);
insert into db_layoutcampos values (12780, 793, 'DATA_INICIAL', 'DATA INICIAL', 1, 15, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos values (12781, 793, 'DATA_FINAL', 'DATA FINAL', 1, 25, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos values (12782, 793, 'DATA_GERACAO', 'DATA DE GERAÇÃO', 1, 35, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos values (12783, 793, 'NOME_SETOR', 'NOME DO SETOR DE GOVERNO', 1, 45, '', 150, false, true, 'd', '', 0);
insert into db_layoutcampos values (12784, 793, 'TOTAL_REGISTROS', 'TOTAL DE REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0);

-- COMISSAO
insert into db_layouttxt( db50_codigo ,db50_layouttxtgrupo ,db50_descr ,db50_quantlinhas ,db50_obs ) values ( 233 , 6 ,'TCE/RS - LICITACON - COMISSAO' ,0 ,'' );
insert into db_layoutlinha  values (794, 233, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true);
insert into db_layoutcampos values (12785, 794, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0);
insert into db_layoutcampos values (12786, 794, 'DATA_INICIAL', 'DATA INICIAL', 1, 15, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos values (12787, 794, 'DATA_FINAL', 'DATA FINAL', 1, 25, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos values (12788, 794, 'DATA_GERACAO', 'DATA DE GERAÇÃO', 1, 35, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos values (12789, 794, 'NOME_SETOR', 'NOME DO SETOR DE GOVERNO', 1, 45, '', 150, false, true, 'd', '', 0);
insert into db_layoutcampos values (12790, 794, 'TOTAL_REGISTROS', 'TOTAL DE REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0);

insert into db_layoutlinha  values (795, 233, 'REGISTRO', 3, 0, 0, 0, '', '|', true);
insert into db_layoutcampos values (12791, 795, 'NR_COMISSAO', 'NR COMISSAO', 1, 1, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos values (12792, 795, 'ANO_COMISSAO', 'ANO COMISSAO', 1, 15, '', 4, false, true, 'd', '', 0);
insert into db_layoutcampos values (12793, 795, 'TP_COMISSAO', 'TP COMISSAO', 1, 25, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (12794, 795, 'DT_DESIGNACAO', 'DT DESIGNACAO', 1, 35, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos values (12795, 795, 'DT_INICIO_VIGENCIA', 'DT INICIO VIGENCIA', 1, 45, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos values (12796, 795, 'DT_FINAL_VIGENCIA', 'DT FINAL VIGENCIA', 1, 195, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos values (12797, 795, 'NOME_ARQUIVO_DOCUMENTO', 'NOME ARQUIVO DOCUMENTO', 13, 195, '', 100, false, true, 'd', '', 0);

insert into db_syscampo values(21704,'l30_arquivo','oid','OID do Arquivo','null', 'Arquivo',1,'t','f','f',1,'text','Arquivo');
insert into db_syscampo values(21705,'l30_nomearquivo','varchar(100)','Nome do Arquivo','', 'Nome do Arquivo',100,'t','t','f',0,'text','Nome do Arquivo');
insert into db_sysarqcamp values(1324,21705,6,0);
insert into db_sysarqcamp values(1324,21704,7,0);

delete from db_syscampodef where codcam = 7915;
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 7915 ,'1' ,'Permanente' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 7915 ,'2' ,'Especial' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 7915 ,'3' ,'Pregão' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 7915 ,'4' ,'Servidor Designado' );

insert into db_sysarquivo values
  (3900, 'db_cadattdinamicosysarquivo', 'Vinculo entre os atributos dinâmicos e a tabela do sistema.', 'db17', '2016-02-18', 'Atributos Dinâmicos Sysarquivo', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (7,3900);

insert into db_syscampo values
  ( 21706 ,'db17_sequencial' ,'int4' ,'Código Sequencial' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' ),
  ( 21707 ,'db17_sysarquivo' ,'int4' ,'Código da Tabela do Sistema' ,'' ,'Código Tabela' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código Tabela' ),
  ( 21708 ,'db17_cadattdinamico' ,'int4' ,'Código dos Atributos Dinâmicos' ,'' ,'Código Atributos' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código Atributos' );

insert into db_sysarqcamp values
  ( 3900 ,21706 ,1 ,0 ),
  ( 3900 ,21707 ,2 ,0 ),
  ( 3900 ,21708 ,3 ,0 );

insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3900,21706,1,21706);

insert into db_sysforkey values
  (3900,21707,1,140,0),
  (3900,21708,1,3162,0);

insert into db_syssequencia values(1000545, 'db_cadattdinamicosysarquivo_db17_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000545 where codarq = 3900 and codcam = 21706;

insert into db_sysindices values(4321,'db_cadattdinamicosysarquivo_sysarquivo_un',3900,'1');
insert into db_syscadind values(4321,21707,1);

insert into db_syscampo values ( 21709 ,'db109_nome' ,'varchar(100)' ,'Nome do Campo' ,'' ,'Nome do Campo' ,100 ,'true' ,'false' ,'false' ,0 ,'text' ,'Nome do Campo' );
insert into db_sysarqcamp values ( 3163 ,21709 ,7 ,0 );

update db_syscampo set conteudo = 'text', tamanho = 1  where codcam = 17882;

-- tabela de vinculo
insert into db_sysarquivo values
  (3901, 'liccomissaocgmcadattdinamicovalorgrupo', 'Valores dos Atributos Dinâmicos', 'l15', '2016-02-19', 'Valores dos Atributos Dinâmicos', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (19,3901);
insert into db_syscampo values
  ( 21710 ,'l15_sequencial' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' ),
  ( 21711 ,'l15_liccomissaocgm' ,'int4' ,'Menbro da Comissão' ,'' ,'Menbro da Comissão' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Menbro da Comissão' ),
  ( 21712 ,'l15_cadattdinamicovalorgrupo' ,'int4' ,'Grupo dos Valores' ,'' ,'Grupo dos Valores' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Grupo dos Valores' );
insert into db_sysarqcamp values
  ( 3901 ,21710 ,1 ,0 ),
  ( 3901 ,21711 ,2 ,0 ),
  ( 3901 ,21712 ,3 ,0 );

insert into db_syssequencia values(1000546, 'liccomissaocgmcadattdinamicovalorgrupo_l15_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000546 where codarq = 3901 and codcam = 21710;

insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3901,21710,1,21710);
insert into db_sysforkey values(3901,21711,1,1325,0);
insert into db_sysforkey values(3901,21712,1,3165,0);

insert into db_sysarquivo values
  (3902, 'db_cadattdinamicoatributosopcoes', 'Opções dos Atributos Dinâmicos', 'db18', '2016-02-22', 'Opções dos Atributos Dinâmicos', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (7,3902);

insert into db_syscampo values
  ( 21713 ,'db18_sequencial' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' ),
  ( 21714 ,'db18_cadattdinamicoatributos' ,'int4' ,'Atributo' ,'' ,'Atributo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Atributo' ),
  ( 21715 ,'db18_opcao' ,'varchar(50)' ,'Opção padrão do campo' ,'' ,'Opção' ,50 ,'false' ,'false' ,'false' ,0 ,'text' ,'Opção' ),
  ( 21716 ,'db18_valor' ,'varchar(200)' ,'Valor padrão do campo' ,'' ,'Valor' ,200 ,'false' ,'false' ,'false' ,0 ,'text' ,'Valor' );

insert into db_sysarqcamp values
  ( 3902 ,21713 ,1 ,0 ),
  ( 3902 ,21714 ,2 ,0 ),
  ( 3902 ,21715 ,3 ,0 ),
  ( 3902 ,21716 ,4 ,0 );

insert into db_syssequencia values(1000547, 'db_cadattdinamicoatributosopcoes_db18_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000547 where codarq = 3902 and codcam = 21713;

insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3902,21713,1,21713);
insert into db_sysforkey values(3902,21714,1,3163,0);

-- MEMCOMISSAO
insert into db_layouttxt values (234, 'TCE/RS - LICITACON - MEMCOMISSAO', 0, '', 6 );
insert into db_layoutlinha values (796, 234, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true );
insert into db_layoutlinha values (797, 234, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (12798, 796, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12799, 796, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12800, 796, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12801, 796, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12802, 796, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12803, 796, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12804, 797, 'NR_COMISSAO', 'NR_COMISSAO', 1, 1, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12805, 797, 'ANO_COMISSAO', 'ANO_COMISSAO', 1, 11, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12806, 797, 'TP_COMISSAO', 'TP_COMISSAO', 1, 15, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12807, 797, 'TP_DOCUMENTO_MEMBRO', 'TP_DOCUMENTO_MEMBRO', 1, 16, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12808, 797, 'NR_DOCUMENTO_MEMBRO', 'NR_DOCUMENTO_MEMBRO', 1, 17, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12809, 797, 'DS_CARGO', 'DS_CARGO', 13, 31, '', 60, false, true, 'e', '', 0 );
insert into db_layoutcampos values (12810, 797, 'TP_CARGO', 'TP_CARGO', 1, 91, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12811, 797, 'TP_ATRIBUICAO', 'TP_ATRIBUICAO', 1, 92, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12812, 797, 'DT_DESIGNACAO', 'DT_DESIGNACAO', 1, 93, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12813, 797, 'NR_ATO_DESIGNACAO', 'NR_ATO_DESIGNACAO', 1, 103, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12814, 797, 'ANO_ATO_DESIGNACAO', 'ANO_ATO_DESIGNACAO', 1, 113, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12815, 797, 'DT_DESTITUICAO', 'DT_DESTITUICAO', 1, 117, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12816, 797, 'NR_ATO_DESTITUICAO', 'NR_ATO_DESTITUICAO', 1, 127, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12817, 797, 'ANO_ATO_DESTITUICAO', 'ANO_ATO_DESTITUICAO', 1, 137, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12818, 797, 'NOME_ARQUIVO_DOCUMENTO', 'NOME_ARQUIVO_DOCUMENTO', 13, 141, '', 100, false, true, 'e', '', 0 );

-- tipo compra tribunal
insert into db_syscampo values
  ( 21717 ,'l44_sigla' ,'varchar(3)' ,'Sigla' ,'' ,'Sigla' ,3 ,'true' ,'false' ,'false' ,0 ,'text' ,'Sigla' );
insert into db_sysarqcamp values
  ( 3145 ,21717 ,5 ,0 );

-- LICITACAO
insert into db_layouttxt values (235, 'TCE/RS - LICITACON - LICITACAO', 0, '', 6 );
insert into db_layoutlinha values (798, 235, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (12819, 798, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12820, 798, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12821, 798, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12822, 798, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12823, 798, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12824, 798, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutlinha values (799, 235, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (12825, 799, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12826, 799, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12827, 799, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12828, 799, 'NR_COMISSAO', 'NR_COMISSAO', 1, 28, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12829, 799, 'ANO_COMISSAO', 'ANO_COMISSAO', 1, 38, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12830, 799, 'TP_COMISSAO', 'TP_COMISSAO', 1, 42, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12831, 799, 'NR_PROCESSO', 'NR_PROCESSO', 1, 43, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12832, 799, 'ANO_PROCESSO', 'ANO_PROCESSO', 1, 63, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12833, 799, 'TP_OBJETO', 'TP_OBJETO', 1, 67, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12834, 799, 'CD_TIPO_FASE_ATUAL', 'CD_TIPO_FASE_ATUAL', 1, 70, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12835, 799, 'TP_LICITACAO', 'TP_LICITACAO', 1, 73, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12836, 799, 'TP_NIVEL_JULGAMENTO', 'TP_NIVEL_JULGAMENTO', 1, 76, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12837, 799, 'DT_AUTORIZACAO_ADESAO', 'DT_AUTORIZACAO_ADESAO', 1, 77, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12838, 799, 'TP_CARACTERISTICA_OBJETO', 'TP_CARACTERISTICA_OBJETO', 1, 87, '', 2, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12839, 799, 'TP_NATUREZA', 'TP_NATUREZA', 1, 89, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12840, 799, 'TP_REGIME_EXECUCAO', 'TP_REGIME_EXECUCAO', 1, 90, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12841, 799, 'BL_PERMITE_SUBCONTRATACAO', 'BL_PERMITE_SUBCONTRATACAO', 1, 91, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12842, 799, 'TP_BENEFICIO_MICRO_EPP', 'TP_BENEFICIO_MICRO_EPP', 1, 92, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12843, 799, 'TP_FORNECIMENTO', 'TP_FORNECIMENTO', 1, 93, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12844, 799, 'TP_ATUACAO_REGISTRO', 'TP_ATUACAO_REGISTRO', 1, 94, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12845, 799, 'NR_LICITACAO_ORIGINAL', 'NR_LICITACAO_ORIGINAL', 1, 95, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12846, 799, 'ANO_LICITACAO_ORIGINAL', 'ANO_LICITACAO_ORIGINAL', 1, 115, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12847, 799, 'NR_ATA_REGISTRO_PRECO', 'NR_ATA_REGISTRO_PRECO', 1, 119, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12848, 799, 'DT_ATA_REGISTRO_PRECO', 'DT_ATA_REGISTRO_PRECO', 1, 139, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12849, 799, 'PC_TAXA_RISCO', 'PC_TAXA_RISCO', 1, 149, '', 6, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12850, 799, 'TP_EXECUCAO', 'TP_EXECUCAO', 1, 155, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12851, 799, 'TP_DISPUTA', 'TP_DISPUTA', 1, 156, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12852, 799, 'TP_PREQUALIFICACAO', 'TP_PREQUALIFICACAO', 1, 157, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12853, 799, 'BL_INVERSAO_FASES', 'BL_INVERSAO_FASES', 1, 158, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12854, 799, 'TP_RESULTADO_GLOBAL', 'TP_RESULTADO_GLOBAL', 1, 159, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12856, 799, 'CNPJ_ORGAO_GERENCIADOR', 'CNPJ_ORGAO_GERENCIADOR', 1, 161, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12857, 799, 'NM_ORGAO_GERENCIADOR', 'NM_ORGAO_GERENCIADOR', 1, 175, '', 60, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12858, 799, 'DS_OBJETO', 'DS_OBJETO', 1, 235, '', 500, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12859, 799, 'CD_TIPO_FUNDAMENTACAO', 'CD_TIPO_FUNDAMENTACAO', 1, 735, '', 8, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12860, 799, 'NR_ARTIGO', 'NR_ARTIGO', 1, 743, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12861, 799, 'DS_INCISO', 'DS_INCISO', 1, 753, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12862, 799, 'DS_LEI', 'DS_LEI', 1, 763, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12863, 799, 'DT_INICIO_INSCR_CRED', 'DT_INICIO_INSCR_CRED', 1, 773, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12864, 799, 'DT_FIM_INSCR_CRED', 'DT_FIM_INSCR_CRED', 1, 783, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12865, 799, 'DT_INICIO_VIGEN_CRED', 'DT_INICIO_VIGEN_CRED', 1, 793, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12866, 799, 'DT_FIM_VIGEN_CRED', 'DT_FIM_VIGEN_CRED', 1, 803, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12867, 799, 'VL_LICITACAO', 'VL_LICITACAO', 1, 813, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12868, 799, 'BL_ORCAMENTO_SIGILOSO', 'BL_ORCAMENTO_SIGILOSO', 1, 829, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12869, 799, 'BL_RECEBE_INSCRICAO_PER_VIG', 'BL_RECEBE_INSCRICAO_PER_VIG', 1, 830, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12870, 799, 'BL_PERMITE_CONSORCIO', 'BL_PERMITE_CONSORCIO', 1, 831, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12871, 799, 'DT_ABERTURA', 'DT_ABERTURA', 1, 832, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12872, 799, 'DT_HOMOLOGACAO', 'DT_HOMOLOGACAO', 1, 842, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12873, 799, 'DT_ADJUDICACAO', 'DT_ADJUDICACAO', 1, 852, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12874, 799, 'BL_LICIT_PROPRIA_ORGAO', 'BL_LICIT_PROPRIA_ORGAO', 1, 862, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12875, 799, 'TP_DOCUMENTO_FORNECEDOR', 'TP_DOCUMENTO_FORNECEDOR', 1, 863, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12876, 799, 'NR_DOCUMENTO_FORNECEDOR', 'NR_DOCUMENTO_FORNECEDOR', 1, 864, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12877, 799, 'TP_DOCUMENTO_VENCEDOR', 'TP_DOCUMENTO_VENCEDOR', 1, 878, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12878, 799, 'NR_DOCUMENTO_VENCEDOR', 'NR_DOCUMENTO_VENCEDOR', 1, 879, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12879, 799, 'VL_HOMOLOGADO', 'VL_HOMOLOGADO', 1, 893, '', 16, false, true, 'd', '', 0 );


insert into db_sysarquivo values
  (3903, 'liclicitacadattdinamicovalorgrupo', 'Vinculo da licitação com os atributos dinamicos', 'l16', '2016-02-23', 'Vinculo da licitação com os atributos dinamicos', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (19,3903);

insert into db_syscampo values
  ( 21718 ,'l16_sequencial' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' ),
  ( 21719 ,'l16_cadattdinamicovalorgrupo' ,'int4' ,'Grupo de Valores' ,'' ,'Grupo de Valores' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Grupo de Valores' ),
  ( 21720 ,'l16_liclicita' ,'int4' ,'Licitação' ,'' ,'Licitação' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Licitação' );

insert into db_sysarqcamp values
  ( 3903 ,21718 ,1 ,0 ),
  ( 3903 ,21719 ,2 ,0 ),
  ( 3903 ,21720 ,3 ,0 );

insert into db_syssequencia values(1000548, 'liclicitacadattdinamicovalorgrupo_l16_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000548 where codarq = 3903 and codcam = 21718;

insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3903,21718,1,21718);
insert into db_sysforkey values(3903,21719,1,3165,0);
insert into db_sysforkey values(3903,21720,1,1260,0);

-- Situacao Licitacao
insert into licsituacao values (6, 'Adjudicada', false);
insert into licsituacao values (7, 'Homologada', false);

-- Menu Lancar Valores -> Lancar Propostas
update db_itensmenu set id_item = 4686 , descricao = 'Lançar Propostas' , help = 'Lançar Propostas para Licitação' , funcao = 'lic1_lancavallic001.php' , itemativo = '1' , manutencao = '1' , desctec = 'Lançar Propostas para Licitação' , libcliente = 'true' where id_item = 4686;

  -- Menu Habilitação de Fornecedores
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10206 ,'Habilitação de Fornecedores' ,'Habilitação de Fornecedores' ,'lic4_habilitacaofornecedores001.php' ,'1' ,'1' ,'Habilitação de Fornecedores' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1818 ,10206 ,116 ,381 );

update db_menu set menusequencia = 1 where id_item = 1818 and modulo = 381 and id_item_filho = 4689;
update db_menu set menusequencia = 2 where id_item = 1818 and modulo = 381 and id_item_filho = 5478;
update db_menu set menusequencia = 3 where id_item = 1818 and modulo = 381 and id_item_filho = 4680;
update db_menu set menusequencia = 4 where id_item = 1818 and modulo = 381 and id_item_filho = 4685;
update db_menu set menusequencia = 5 where id_item = 1818 and modulo = 381 and id_item_filho = 4686;
update db_menu set menusequencia = 6 where id_item = 1818 and modulo = 381 and id_item_filho = 10206;
update db_menu set menusequencia = 7 where id_item = 1818 and modulo = 381 and id_item_filho = 147886;
update db_menu set menusequencia = 8 where id_item = 1818 and modulo = 381 and id_item_filho = 4718;
update db_menu set menusequencia = 9 where id_item = 1818 and modulo = 381 and id_item_filho = 4719;
update db_menu set menusequencia = 10 where id_item = 1818 and modulo = 381 and id_item_filho = 4750;
update db_menu set menusequencia = 11 where id_item = 1818 and modulo = 381 and id_item_filho = 5624;
update db_menu set menusequencia = 12 where id_item = 1818 and modulo = 381 and id_item_filho = 6813;
update db_menu set menusequencia = 13 where id_item = 1818 and modulo = 381 and id_item_filho = 7985;
update db_menu set menusequencia = 14 where id_item = 1818 and modulo = 381 and id_item_filho = 8056;
update db_menu set menusequencia = 15 where id_item = 1818 and modulo = 381 and id_item_filho = 8131;
update db_menu set menusequencia = 16 where id_item = 1818 and modulo = 381 and id_item_filho = 8602;
update db_menu set menusequencia = 17 where id_item = 1818 and modulo = 381 and id_item_filho = 8983;
update db_menu set menusequencia = 18 where id_item = 1818 and modulo = 381 and id_item_filho = 9401;
update db_menu set menusequencia = 19 where id_item = 1818 and modulo = 381 and id_item_filho = 10204;

-- Menu Licitacoes - Procedimentos - Licitacao - Adjudicar
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10207 ,'Adjudicar' ,'Adjudicar Licitação' ,'lic4_adjudicacaohomologacao001.php?situacao=6' ,'1' ,'1' ,'Adjudicar licitação' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 4680 ,10207 ,10 ,381 );

-- Menu Licitacoes - Procedimentos - Licitacao - Homologar
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10208 ,'Homologar' ,'Homologar Licitação' ,'lic4_adjudicacaohomologacao001.php?situacao=7' ,'1' ,'1' ,'Homologar Licitação' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 4680 ,10208 ,11 ,381 );

-- Tabela Habilitação de Fornecedores
insert into db_sysarquivo values (3904, 'pcorcamfornelichabilitacao', 'Habilitação dos Fornecedores da Licitação', 'l17', '2016-02-25', 'Habilitação dos Fornecedores da Licitação', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (19,3904);
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21721 ,'l17_sequencial' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' );

insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3904 ,21721 ,1 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21722 ,'l17_pcorcamfornelic' ,'int4' ,'Fornecedor' ,'' ,'Fornecedor' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Fornecedor' );

insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3904 ,21722 ,2 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21723 ,'l17_situacao' ,'int4' ,'Situação' ,'' ,'Situação' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Situação' );

insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21723 ,'1' ,'Habilitado' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21723 ,'2' ,'Inabilitado' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21723 ,'3' ,'Não Compareceu' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3904 ,21723 ,3 ,0 );

insert into db_syssequencia values(1000549, 'pcorcamfornelichabilitacao_l17_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000549 where codarq = 3904 and codcam = 21721;

insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3904,21721,1,21721);
insert into db_sysforkey values(3904,21722,1,1291,0);

-- Campo Tipo de Condição - Tabela de Fornecedores da Liquidação
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21728 ,'pc31_tipocondicao' ,'int4' ,'Tipo de Condição' ,'' ,'Tipo de Condição' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Tipo de Condição' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21728 ,'1' ,'Convidado e Participante' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21728 ,'2' ,'Convidado e Não Participante' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21728 ,'3' ,'Não Convidado e Participante' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 1291 ,21728 ,6 ,0 );

-- Arquivo Licitante
insert into db_layouttxt values (236, 'TCE/RS - LICITACON - LICITANTE', 0, '', 6 );
insert into db_layoutlinha values (800, 236, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true );
insert into db_layoutlinha values (801, 236, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (12880, 800, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12881, 800, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12882, 800, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12883, 800, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12884, 800, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12885, 800, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12887, 801, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'e', '', 0 );
insert into db_layoutcampos values (12888, 801, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12889, 801, 'TP_DOCUMENTO_LICITANTE', 'TP_DOCUMENTO_LICITANTE', 1, 28, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12890, 801, 'NR_DOCUMENTO_LICITANTE', 'NR_DOCUMENTO_LICITANTE', 1, 29, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12891, 801, 'TP_DOCUMENTO_REPRES', 'TP_DOCUMENTO_REPRES', 1, 43, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12892, 801, 'NR_DOCUMENTO_REPRES', 'NR_DOCUMENTO_REPRES', 1, 44, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12893, 801, 'TP_CONDICAO', 'TP_CONDICAO', 1, 58, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12894, 801, 'TP_RESULTADO_HABILITACAO', 'TP_RESULTADO_HABILITACAO', 1, 61, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12895, 801, 'BL_BENEFICIO_MICRO_EPP', 'BL_BENEFICIO_MICRO_EPP', 1, 62, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12886, 801, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'e', '', 0 );

-- DOTACAO_LIC
insert into db_layouttxt values (237, 'TCE/RS - LICITACON - DOTACAO_LIC', 0, '', 6 );
insert into db_layoutlinha values (802, 237, 'CABEÇALHO  ', 1, 0, 0, 0, '', '|', true );
insert into db_layoutlinha values (803, 237, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (12896, 802, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12897, 802, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12898, 802, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12899, 802, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12900, 802, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12901, 802, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12902, 803, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12903, 803, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12904, 803, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12905, 803, 'CD_PROJETO_ATIVIDADE', 'CD_PROJETO_ATIVIDADE', 2, 28, '', 5, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12906, 803, 'CD_RECURSO_ORCAMENTARIO', 'CD_RECURSO_ORCAMENTARIO', 1, 33, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12907, 803, 'CD_NATUREZA_DESPESA', 'CD_NATUREZA_DESPESA', 1, 37, '', 6, false, true, 'd', '', 0 );

insert into db_itensmenu values( 10209, 'Eventos', 'Eventos da Licitação', 'lic4_licitacaoeventos001.php', '1', '1', '', '1');
insert into db_itensfilho (id_item, codfilho) values(10209,1);
delete from db_menu where id_item_filho = 10209 AND modulo = 381;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1818 ,10209 ,115 ,381 );
update db_menu set menusequencia = 1 where id_item = 1818 and modulo = 381 and id_item_filho = 4689;
update db_menu set menusequencia = 2 where id_item = 1818 and modulo = 381 and id_item_filho = 5478;
update db_menu set menusequencia = 3 where id_item = 1818 and modulo = 381 and id_item_filho = 4680;
update db_menu set menusequencia = 4 where id_item = 1818 and modulo = 381 and id_item_filho = 4685;
update db_menu set menusequencia = 5 where id_item = 1818 and modulo = 381 and id_item_filho = 4686;
update db_menu set menusequencia = 6 where id_item = 1818 and modulo = 381 and id_item_filho = 10206;
update db_menu set menusequencia = 7 where id_item = 1818 and modulo = 381 and id_item_filho = 10209;
update db_menu set menusequencia = 8 where id_item = 1818 and modulo = 381 and id_item_filho = 147886;
update db_menu set menusequencia = 9 where id_item = 1818 and modulo = 381 and id_item_filho = 4718;
update db_menu set menusequencia = 10 where id_item = 1818 and modulo = 381 and id_item_filho = 4719;
update db_menu set menusequencia = 11 where id_item = 1818 and modulo = 381 and id_item_filho = 4750;
update db_menu set menusequencia = 12 where id_item = 1818 and modulo = 381 and id_item_filho = 5624;
update db_menu set menusequencia = 13 where id_item = 1818 and modulo = 381 and id_item_filho = 6813;
update db_menu set menusequencia = 14 where id_item = 1818 and modulo = 381 and id_item_filho = 7985;
update db_menu set menusequencia = 15 where id_item = 1818 and modulo = 381 and id_item_filho = 8056;
update db_menu set menusequencia = 16 where id_item = 1818 and modulo = 381 and id_item_filho = 8131;
update db_menu set menusequencia = 17 where id_item = 1818 and modulo = 381 and id_item_filho = 8602;
update db_menu set menusequencia = 18 where id_item = 1818 and modulo = 381 and id_item_filho = 8983;
update db_menu set menusequencia = 19 where id_item = 1818 and modulo = 381 and id_item_filho = 9401;
update db_menu set menusequencia = 20 where id_item = 1818 and modulo = 381 and id_item_filho = 10204;

insert into db_sysarquivo values (3916, 'liclicitatipoevento', 'Eventos da licitação', 'l45', '2016-03-01', 'Eventos da Licitação', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (19,3916);
insert into db_syscampo values(21737,'l45_sequencial','int4','Código sequencial','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21738,'l45_descricao','varchar(200)','Descrição do tipo de evento','', 'Descrição',200,'f','t','f',0,'text','Descrição');
delete from db_sysarqcamp where codarq = 3916;
insert into db_sysarqcamp values(3916,21737,1,0);
insert into db_sysarqcamp values(3916,21738,2,0);
delete from db_sysprikey where codarq = 3916;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3916,21737,1,21738);
insert into db_sysindices values(4328,'liclicitatipoevento_sequencial_in',3916,'0');
insert into db_syscadind values(4328,21737,1);
insert into db_syssequencia values(1000552, 'liclicitatipoevento_l45_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000552 where codarq = 3916 and codcam = 21737;

insert into db_sysarquivo values (3917, 'liclicitaevento', 'Eventos da Licitação', 'l46', '2016-03-01', 'Eventos da Licitação', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (19,3917);
insert into db_syscampo values(21739,'l46_sequencial','int4','Código sequencial','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21740,'l46_liclicita','int4','Código sequencial da Licitação','0', 'Código da Licitação',10,'f','f','f',1,'text','Código da Licitação');
insert into db_syscampo values(21741,'l46_fase','int4','Fase em em que se encontra a licitação.','0', 'Fase',10,'f','f','f',1,'text','Fase');
insert into db_syscampo values(21742,'l46_liclicitatipoevento','int4','Tipo de evento da licitação.','0', 'Tipo de Evento',10,'f','f','f',1,'text','Tipo de Evento');
insert into db_syscampo values(21743,'l46_dataevento','date','Data do Evento','null', 'Data do Evento',10,'f','f','f',1,'text','Data do Evento');
insert into db_syscampo values(21744,'l46_datajulgamento','date','Data do Julgamento','null', 'Data do Julgamento',10,'t','f','f',1,'text','Data do Julgamento');
insert into db_syscampo values(21745,'l46_cgm','int4','Autor','null', 'Autor',10,'t','f','f',1,'text','Autor');
insert into db_syscampo values(21746,'l46_tipopublicacao','int4','Tipo de Publicação','null', 'Tipo de Publicação',10,'t','f','f',1,'text','Tipo de Publicação');
insert into db_syscampo values(21747,'l46_descricaopublicacao','text','Descrição da Publicação','', 'Descrição da Publicação',1,'t','t','f',0,'text','Descrição da Publicação');
insert into db_syscampo values(21748,'l46_tiporesultado','int4','Tipo de Resultado','null', 'Tipo de Resultado',10,'f','f','f',1,'text','Tipo de Resultado');
delete from db_sysarqcamp where codarq = 3917;
insert into db_sysarqcamp values(3917,21739,1,0);
insert into db_sysarqcamp values(3917,21740,2,0);
insert into db_sysarqcamp values(3917,21741,3,0);
insert into db_sysarqcamp values(3917,21742,4,0);
insert into db_sysarqcamp values(3917,21743,5,0);
insert into db_sysarqcamp values(3917,21744,6,0);
insert into db_sysarqcamp values(3917,21745,7,0);
insert into db_sysarqcamp values(3917,21746,8,0);
insert into db_sysarqcamp values(3917,21747,9,0);
insert into db_sysarqcamp values(3917,21748,10,0);
delete from db_sysforkey where codarq = 3917 and referen = 0;
insert into db_sysforkey values(3917,21740,1,1260,0);
delete from db_sysforkey where codarq = 3917 and referen = 0;
insert into db_sysforkey values(3917,21742,1,3916,0);
delete from db_sysforkey where codarq = 3917 and referen = 0;
insert into db_sysforkey values(3917,21745,1,42,0);
delete from db_sysprikey where codarq = 3917;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3917,21740,1,21739);
insert into db_sysindices values(4329,'liclicitaevento_liclicita_in',3917,'0');
insert into db_syscadind values(4329,21740,1);
insert into db_syssequencia values(1000553, 'liclicitaevento_l46_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000553 where codarq = 3917 and codcam = 21739;

update db_syscampo set nomecam = 'l46_fase', conteudo = 'int4', descricao = 'Fase em em que se encontra a licitação.', valorinicial = '0', rotulo = 'Fase', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Fase' where codcam = 21741;
delete from db_syscampodep where codcam = 21741;
delete from db_syscampodef where codcam = 21741;
insert into db_syscampodef values(21741,'1','Fase Interna');
insert into db_syscampodef values(21741,'2','Edital Publicado');
insert into db_syscampodef values(21741,'3','Publicação');
insert into db_syscampodef values(21741,'4','Habilitação / Propostas');
insert into db_syscampodef values(21741,'5','Adjudicação / Homologação');

update db_syscampo set nomecam = 'l46_tiporesultado', conteudo = 'int4', descricao = 'Tipo de Resultado', valorinicial = '0', rotulo = 'Tipo de Resultado', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Tipo de Resultado' where codcam = 21748;
delete from db_syscampodep where codcam = 21748;
delete from db_syscampodef where codcam = 21748;
insert into db_syscampodef values(21748,'1','Deferido');
insert into db_syscampodef values(21748,'2','Indeferido');
insert into db_syscampodef values(21748,'3','Deferido Parcialmente');

update db_syscampo set nomecam = 'l46_tipopublicacao', conteudo = 'int4', descricao = 'Tipo de Publicação', valorinicial = '0', rotulo = 'Tipo de Publicação', nulo = 't', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Tipo de Publicação' where codcam = 21746;
delete from db_syscampodep where codcam = 21746;
delete from db_syscampodef where codcam = 21746;
insert into db_syscampodef values(21746,'1','Diário Oficial do Estado');
insert into db_syscampodef values(21746,'2','Internet');
insert into db_syscampodef values(21746,'3','Jornal');
insert into db_syscampodef values(21746,'4','Mural da Entidade');
insert into db_syscampodef values(21746,'5','Diário Oficial do Município');
insert into db_syscampodef values(21746,'6','Diário Oficial dos Municípios / RS');
insert into db_syscampodef values(21746,'7','Diário');


insert into db_syscampo values(21749,'l47_sequencial','int4','Código sequencial','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21750,'l47_liclicitaevento','int4','Eventos da Licitação','0', 'Eventos da Licitação',10,'f','f','f',1,'text','Eventos da Licitação');
insert into db_syscampo values(21751,'l47_arquivo','oid','Identificador do Arquivo','', 'Identificador do Arquivo',1,'f','f','f',1,'text','Identificador do Arquivo');
insert into db_syscampo values(21752,'l47_nomearquivo','varchar(200)','Nome do Arquivo','', 'Nome do Arquivo',200,'f','t','f',0,'text','Nome do Arquivo');
insert into db_syscampo values(21753,'l47_tipodocumento','varchar(3)','Tipo de Documento','', 'Tipo de Documento',3,'f','t','f',0,'text','Tipo de Documento');
insert into db_sysarquivo values (3918, 'liclicitaeventodocumento', 'Documentos Vinculados ao Evento da Licitação', 'l47', '2016-03-01', 'Documentos Vinculados ao Evento da Licitação', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (19,3918);
delete from db_sysarqcamp where codarq = 3918;
insert into db_sysarqcamp values(3918,21749,1,0);
insert into db_sysarqcamp values(3918,21750,2,0);
insert into db_sysarqcamp values(3918,21752,3,0);
insert into db_sysarqcamp values(3918,21751,4,0);
insert into db_sysarqcamp values(3918,21753,5,0);
delete from db_sysprikey where codarq = 3918;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3918,21749,1,21752);
delete from db_sysforkey where codarq = 3918 and referen = 0;
insert into db_sysforkey values(3918,21750,1,3917,0);
insert into db_sysindices values(4330,'liclicitaeventodocumento_liclicitaevento_in',3918,'0');
insert into db_syscadind values(4330,21750,1);
insert into db_syssequencia values(1000554, 'liclicitaeventodocumento_l47_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000554 where codarq = 3918 and codcam = 21749;



-- EVENTOS_LIC
insert into db_layouttxt values (238, 'TCE/RS - LICITACON - EVENTOS_LIC', 0, '', 6 );
insert into db_layoutlinha values (804, 238, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true );
insert into db_layoutlinha values (805, 238, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (12908, 804, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12909, 804, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12910, 804, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12911, 804, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12912, 804, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12913, 804, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12914, 805, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12915, 805, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'e', '', 0 );
insert into db_layoutcampos values (12916, 805, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12917, 805, 'SQ_EVENTO', 'SQ_EVENTO', 1, 28, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12918, 805, 'CD_TIPO_FASE', 'CD_TIPO_FASE', 1, 38, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12919, 805, 'CD_TIPO_EVENTO', 'CD_TIPO_EVENTO', 1, 41, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12920, 805, 'DT_EVENTO', 'DT_EVENTO', 1, 44, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12921, 805, 'TP_VEICULO_PUBLICACAO', 'TP_VEICULO_PUBLICACAO', 1, 54, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12922, 805, 'DS_PUBLICACAO', 'DS_PUBLICACAO', 13, 55, '', 100, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12923, 805, 'TP_DOCUMENTO_AUTOR', 'TP_DOCUMENTO_AUTOR', 1, 155, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12924, 805, 'NR_DOCUMENTO_AUTOR', 'NR_DOCUMENTO_AUTOR', 1, 156, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12925, 805, 'DT_JULGAMENTO', 'DT_JULGAMENTO', 1, 170, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12926, 805, 'TP_RESULTADO', 'TP_RESULTADO', 1, 180, '', 1, false, true, 'd', '', 0 );

-- DOCUMENTO_LIC
insert into db_layouttxt values (239, 'TCE/RS - LICITACON - DOCUMENTO_LIC', 0, '', 6 );
insert into db_layoutlinha values (806, 239, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true );
insert into db_layoutlinha values (807, 239, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (12927, 806, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12928, 806, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12929, 806, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12930, 806, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12931, 806, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12932, 806, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12933, 807, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'e', '', 0 );
insert into db_layoutcampos values (12934, 807, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'e', '', 0 );
insert into db_layoutcampos values (12935, 807, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12936, 807, 'CD_TIPO_DOCUMENTO', 'CD_TIPO_DOCUMENTO', 1, 28, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12937, 807, 'NOME_ARQUIVO_DOCUMENTO', 'NOME_ARQUIVO_DOCUMENTO', 13, 31, '', 100, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12938, 807, 'CD_TIPO_FASE', 'CD_TIPO_FASE', 1, 131, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12939, 807, 'SQ_EVENTO', 'SQ_EVENTO', 1, 134, '', 10, false, true, 'e', '', 0 );
insert into db_layoutcampos values (12940, 807, 'TP_DOCUMENTO_LICITANTE', 'TP_DOCUMENTO_LICITANTE', 1, 144, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12941, 807, 'NR_DOCUMENTO_LICITANTE', 'NR_DOCUMENTO_LICITANTE', 1, 145, '', 14, false, true, 'd', '', 0 );

insert into db_sysarquivo values (3920, 'liclicitaencerramentolicitacon', 'Armazena as licitações que já foram encerradas e enviadas ao LicitaCon.', 'l18', '2016-03-07', 'Encerramento LicitaCon', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (19,3920);
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21758 ,'l18_sequencial' ,'int4' ,'Código sequencial' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3920 ,21758 ,1 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21759 ,'l18_liclicita' ,'int4' ,'Código da licitação' ,'' ,'Licitação' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Licitação' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3920 ,21759 ,2 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21760 ,'l18_data' ,'date' ,'Data da geração do arquivo' ,'' ,'Data de Geração' ,10 ,'false' ,'false' ,'false' ,0 ,'text' ,'Data de Geração' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3920 ,21760 ,3 ,0 );
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3920,21758,1,21758);
insert into db_sysforkey values(3920,21759,1,1260,0);
insert into db_sysindices values(4331,'liclicitaencerramentolicitacon_sequencial_in',3920,'0');
insert into db_syscadind values(4331,21758,1);
insert into db_syssequencia values(1000555, 'liclicitaencerramentolicitacon_l18_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000555 where codarq = 3920 and codcam = 21758;

---------------------------------------------------------------------------------------------
---------------------------------- FIM FINANCEIRO -----------------------------------------
---------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------
------------------------------- INICIO EDUCAÇÃO/SAÚDE ---------------------------------------
---------------------------------------------------------------------------------------------

update db_itensmenu set descricao = 'Atendimentos', help = 'Atendimentos', funcao = 'sau2_atendimentomedico001.php', desctec = 'Relatório de atendimentos' where id_item = 7146;
delete from atendcadareamod where at26_id_item = 10191;
delete from db_modulos where id_item = 10191;
delete from db_itensmenu where id_item = 10191;



insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10210 ,'Cadastro Geral da Saúde' ,'Cadastro Geral da Saúde' ,'sau3_consultacgs001.php' ,'1' ,'1' ,'Consulta os dados do CGS' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 31 ,10210 ,182 ,1000004 );


---------------------------------------------------------------------------------------------
---------------------------------- FIM EDUCAÇÃO/SAÚDE ---------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
---------------------------------- INICIO FOLHA ---------------------------------------------
---------------------------------------------------------------------------------------------

insert into db_sysarquivo values (3914, 'cargorhrubricas', 'Rubricas por cargo', 'rh176', '2016-02-25', 'Rubricas por cargo', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (28,3914);
insert into db_sysarquivo values (3915, 'funcaorhrubricas', 'Rubricas por função', 'rh177', '2016-02-25', 'Rubricas por função', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (28,3915);
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21729 ,'rh176_sequencial' ,'int4' ,'Sequencial da tabela.' ,'' ,'Sequencial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Sequencial' );
delete from db_syscampodef where codcam = 21729;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3914 ,21729 ,1 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21730 ,'rh176_cargo' ,'int4' ,'Código do cargo.' ,'' ,'Cargo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Cargo' );
delete from db_syscampodef where codcam = 21730;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3914 ,21730 ,2 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21731 ,'rh176_rubrica' ,'int4' ,'Código da rubrica.' ,'' ,'Rubrica' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Rubrica' );
delete from db_syscampodef where codcam = 21731;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3914 ,21731 ,3 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21732 ,'rh176_instit' ,'int4' ,'Código da instituição.' ,'' ,'Instituição' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Instituição' );
delete from db_syscampodef where codcam = 21732;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3914 ,21732 ,4 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21733 ,'rh177_sequencial' ,'int4' ,'Sequencial da tabela.' ,'' ,'Sequencial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Sequencial' );
delete from db_syscampodef where codcam = 21733;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3915 ,21733 ,1 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21734 ,'rh177_funcao' ,'int4' ,'Código da função.' ,'' ,'Função' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Função' );
delete from db_syscampodef where codcam = 21734;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3915 ,21734 ,2 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21735 ,'rh177_rubrica' ,'int4' ,'Código da rubrica.' ,'' ,'Rubrica' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Rubrica' );
delete from db_syscampodef where codcam = 21735;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3915 ,21735 ,3 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21736 ,'rh177_instit' ,'int4' ,'Código da instituição.' ,'' ,'Instituição' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Instituição' );
delete from db_syscampodef where codcam = 21736;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3915 ,21736 ,4 ,0 );
delete from db_sysprikey where codarq = 3914;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3914,21729,1,21729);
delete from db_sysforkey where codarq = 3914 and referen = 0;
insert into db_sysforkey values(3914,21730,1,1496,0);
insert into db_sysforkey values(3914,21732,2,1496,0);
delete from db_sysforkey where codarq = 3914 and referen = 0;
insert into db_sysforkey values(3914,21731,1,1177,0);
insert into db_sysforkey values(3914,21732,2,1177,0);
delete from db_sysforkey where codarq = 3914 and referen = 0;
insert into db_sysforkey values(3914,21732,1,83,0);
insert into db_syssequencia values(1000550, 'cargorhrubricas_rh176_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000550 where codarq = 3914 and codcam = 21729;
insert into db_sysindices values(4322,'cargorhrubricas_cargo_instit',3914,'0');
insert into db_syscadind values(4322,21730,1);
insert into db_syscadind values(4322,21732,2);
insert into db_sysindices values(4323,'cargorhrubricas_rubrica_instit_in',3914,'0');
insert into db_syscadind values(4323,21731,1);
insert into db_syscadind values(4323,21732,2);
update db_sysindices set nomeind = 'cargorhrubricas_cargo_instit_in',campounico = '0' where codind = 4322;
delete from db_syscadind where codind = 4322;
insert into db_syscadind values(4322,21730,1);
insert into db_syscadind values(4322,21732,2);
insert into db_sysindices values(4324,'cargorhrubricas_instit_in',3914,'0');
insert into db_syscadind values(4324,21732,1);
delete from db_sysprikey where codarq = 3915;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3915,21733,1,21733);
delete from db_sysforkey where codarq = 3915 and referen = 0;
insert into db_sysforkey values(3915,21734,1,1174,0);
insert into db_sysforkey values(3915,21736,2,1174,0);
delete from db_sysforkey where codarq = 3915 and referen = 0;
insert into db_sysforkey values(3915,21735,1,1177,0);
insert into db_sysforkey values(3915,21736,2,1177,0);
delete from db_sysforkey where codarq = 3915 and referen = 0;
insert into db_sysforkey values(3915,21736,1,83,0);
insert into db_sysindices values(4325,'funcaorhrubricas_funcao_instit_in',3915,'0');
insert into db_syscadind values(4325,21734,1);
insert into db_syscadind values(4325,21736,2);
insert into db_sysindices values(4326,'funcaorhrubricas_rubrica_instit_in',3915,'0');
insert into db_syscadind values(4326,21735,1);
insert into db_syscadind values(4326,21736,2);
insert into db_sysindices values(4327,'funcaorhrubricas_instit_in',3915,'0');
insert into db_syscadind values(4327,21736,1);
insert into db_syssequencia values(1000551, 'funcaorhrubricas_rh177_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000551 where codarq = 3915 and codcam = 21733;

update db_sysarqcamp set codsequencia = 1000551 where codarq = 3915 and codcam = 21733;
update db_syscampo set nomecam = 'rh176_rubrica', conteudo = 'char(4)', descricao = 'Código da rubrica.', valorinicial = '', rotulo = 'Rubrica', nulo = 'f', tamanho = 4, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Rubrica' where codcam = 21731;
delete from db_syscampodep where codcam = 21731;
delete from db_syscampodef where codcam = 21731;
update db_syscampo set nomecam = 'rh177_rubrica', conteudo = 'char(4)', descricao = 'Código da rubrica.', valorinicial = '', rotulo = 'Rubrica', nulo = 'f', tamanho = 4, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Rubrica' where codcam = 21735;
delete from db_syscampodep where codcam = 21735;
delete from db_syscampodef where codcam = 21735;

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21754 ,'rh176_quantidade' ,'float8' ,'Quantidade para inicializar.' ,'' ,'Quantidade' ,15 ,'false' ,'false' ,'false' ,4 ,'text' ,'Quantidade' );
delete from db_syscampodef where codcam = 21754;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3914 ,21754 ,5 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21755 ,'rh176_valor' ,'float8' ,'Valor para inicializar.' ,'' ,'Valor' ,15 ,'false' ,'false' ,'false' ,4 ,'text' ,'Valor' );
delete from db_syscampodef where codcam = 21755;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3914 ,21755 ,6 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21756 ,'rh177_quantidade' ,'float8' ,'Quantidade para inicializar.' ,'' ,'Quantidade' ,15 ,'false' ,'false' ,'false' ,4 ,'text' ,'Quantidade' );
delete from db_syscampodef where codcam = 21756;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3915 ,21756 ,5 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21757 ,'rh177_valor' ,'float8' ,'Valor para inicializar.' ,'' ,'Valor' ,15 ,'false' ,'false' ,'false' ,4 ,'text' ,'Valor' );
delete from db_syscampodef where codcam = 21757;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3915 ,21757 ,6 ,0 );

update db_syscampo set nomecam = 'rh176_quantidade', conteudo = 'float8', descricao = 'Quantidade para inicializar.', valorinicial = '0', rotulo = 'Quantidade', nulo = 'f', tamanho = 15, maiusculo = 'f', autocompl = 'f', aceitatipo = 4, tipoobj = 'text', rotulorel = 'Quantidade' where codcam = 21754;
update db_syscampo set nomecam = 'rh176_valor', conteudo = 'float8', descricao = 'Valor para inicializar.', valorinicial = '0', rotulo = 'Valor', nulo = 'f', tamanho = 15, maiusculo = 'f', autocompl = 'f', aceitatipo = 4, tipoobj = 'text', rotulorel = 'Valor' where codcam = 21755;
update db_syscampo set nomecam = 'rh177_quantidade', conteudo = 'float8', descricao = 'Quantidade para inicializar.', valorinicial = '0', rotulo = 'Quantidade', nulo = 'f', tamanho = 15, maiusculo = 'f', autocompl = 'f', aceitatipo = 4, tipoobj = 'text', rotulorel = 'Quantidade' where codcam = 21756;
update db_syscampo set nomecam = 'rh177_valor', conteudo = 'float8', descricao = 'Valor para inicializar.', valorinicial = '0', rotulo = 'Valor', nulo = 'f', tamanho = 15, maiusculo = 'f', autocompl = 'f', aceitatipo = 4, tipoobj = 'text', rotulorel = 'Valor' where codcam = 21757;

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10211 ,'Rubricas por Função / Cargo' ,'Rubricas por Função / Cargo' ,'pes1_rubricasfuncaocargo001.php' ,'1' ,'1' ,'Rubricas por Função / Cargo' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 4374 ,10211 ,24 ,952 );

---------------------------------------------------------------------------------------------
---------------------------------- FIM FOLHA ------------------------------------------------
---------------------------------------------------------------------------------------------
