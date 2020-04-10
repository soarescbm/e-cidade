

---------------------------------------------------------------------------------------------------------------
--------------------------------------------- INICIO FINANCEIRO -----------------------------------------------
---------------------------------------------------------------------------------------------------------------

update db_itensmenu set descricao = 'A partir de 2015' where  id_item = 10118;

update sliptipooperacao set k152_descricao = 'Outras Movimentações Extras - Recebimento' where k152_sequencial = 7;
update sliptipooperacao set k152_descricao = 'Outras Movimentações Extras - Estorno Recebimento' where k152_sequencial = 8;
update sliptipooperacao set k152_descricao = 'Outras Movimentações Extras - Pagamento' where k152_sequencial = 9;
update sliptipooperacao set k152_descricao = 'Outras Movimentações Extras - Estorno Pagamento' where k152_sequencial = 10;

update db_itensmenu set libcliente = false where id_item in (9079,3742,3743,3744,3745,3972,3974,3985,4541,3975,96,95 ,110,7652);
update db_itensmenu set descricao = 'Cadastro de Transações' where id_item = 9256;
update db_itensmenu set descricao = 'Planilha de Lançamento' where id_item = 9419;
update db_itensmenu set descricao = 'Alteração de Estrutural' where id_item = 9860;

update db_layoutcampos set db52_tamanho = 200 where db52_codigo in (12797, 12818, 13148);

insert into db_layouttxt select 264, 'TCE/RS - LICITACON - LICITACAO 1.3', 0 ,'', 6 where not exists (select 1 from db_layouttxt where db50_codigo = 264);
insert into db_layoutlinha select 874 ,264 ,'CABEÇALHO' ,1 ,0 ,0 ,0 ,'' ,'' ,'0' where not exists (select 1 from db_layoutlinha where db51_codigo = 874);
insert into db_layoutlinha select 875 ,264 ,'REGISTRO' ,3 ,0 ,0 ,0 ,'' ,'' ,'0' where not exists (select 1 from db_layoutlinha where db51_codigo = 875);
insert into db_layoutcampos select 14991 ,874 ,'CNPJ' ,'CNPJ' ,1 ,1 ,'' ,14 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 14991);
insert into db_layoutcampos select 14992 ,874 ,'DATA_INICIAL' ,'DATA_INICIAL' ,1 ,15 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 14992);
insert into db_layoutcampos select 14993 ,874 ,'DATA_FINAL' ,'DATA_FINAL' ,1 ,25 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 14993);
insert into db_layoutcampos select 14994 ,874 ,'DATA_GERACAO' ,'DATA_GERACAO' ,1 ,35 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 14994);
insert into db_layoutcampos select 14995 ,874 ,'NOME_SETOR' ,'NOME_SETOR' ,1 ,45 ,'' ,150 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 14995);
insert into db_layoutcampos select 14996 ,874 ,'TOTAL_REGISTROS' ,'TOTAL_REGISTROS' ,1 ,195 ,'' ,15 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 14996);
insert into db_layoutcampos select 14997 ,875 ,'NR_LICITACAO' ,'NR_LICITACAO' ,1 ,1 ,'' ,20 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 14997);
insert into db_layoutcampos select 14998 ,875 ,'ANO_LICITACAO' ,'ANO_LICITACAO' ,1 ,21 ,'' ,4 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 14998);
insert into db_layoutcampos select 14999 ,875 ,'CD_TIPO_MODALIDADE' ,'CD_TIPO_MODALIDADE' ,1 ,25 ,'' ,3 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 14999);
insert into db_layoutcampos select 15000 ,875 ,'NR_COMISSAO' ,'NR_COMISSAO' ,1 ,28 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15000);
insert into db_layoutcampos select 15001 ,875 ,'ANO_COMISSAO' ,'ANO_COMISSAO' ,1 ,38 ,'' ,4 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15001);
insert into db_layoutcampos select 15002 ,875 ,'TP_COMISSAO' ,'TP_COMISSAO' ,1 ,42 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15002);
insert into db_layoutcampos select 15003 ,875 ,'NR_PROCESSO' ,'NR_PROCESSO' ,1 ,43 ,'' ,20 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15003);
insert into db_layoutcampos select 15004 ,875 ,'ANO_PROCESSO' ,'ANO_PROCESSO' ,1 ,63 ,'' ,4 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15004);
insert into db_layoutcampos select 15005 ,875 ,'TP_OBJETO' ,'TP_OBJETO' ,1 ,67 ,'' ,3 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15005);
insert into db_layoutcampos select 15006 ,875 ,'CD_TIPO_FASE_ATUAL' ,'CD_TIPO_FASE_ATUAL' ,1 ,70 ,'' ,3 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15006);
insert into db_layoutcampos select 15007 ,875 ,'TP_LICITACAO' ,'TP_LICITACAO' ,1 ,73 ,'' ,3 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15007);
insert into db_layoutcampos select 15008 ,875 ,'TP_NIVEL_JULGAMENTO' ,'TP_NIVEL_JULGAMENTO' ,1 ,76 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15008);
insert into db_layoutcampos select 15009 ,875 ,'DT_AUTORIZACAO_ADESAO' ,'DT_AUTORIZACAO_ADESAO' ,1 ,77 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15009);
insert into db_layoutcampos select 15010 ,875 ,'TP_CARACTERISTICA_OBJETO' ,'TP_CARACTERISTICA_OBJETO' ,1 ,87 ,'' ,2 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15010);
insert into db_layoutcampos select 15011 ,875 ,'TP_NATUREZA' ,'TP_NATUREZA' ,1 ,89 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15011);
insert into db_layoutcampos select 15012 ,875 ,'TP_REGIME_EXECUCAO' ,'TP_REGIME_EXECUCAO' ,1 ,90 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15012);
insert into db_layoutcampos select 15013 ,875 ,'BL_PERMITE_SUBCONTRATACAO' ,'BL_PERMITE_SUBCONTRATACAO' ,1 ,91 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15013);
insert into db_layoutcampos select 15014 ,875 ,'TP_BENEFICIO_MICRO_EPP' ,'TP_BENEFICIO_MICRO_EPP' ,1 ,92 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15014);
insert into db_layoutcampos select 15015 ,875 ,'TP_FORNECIMENTO' ,'TP_FORNECIMENTO' ,1 ,93 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15015);
insert into db_layoutcampos select 15016 ,875 ,'TP_ATUACAO_REGISTRO' ,'TP_ATUACAO_REGISTRO' ,1 ,94 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15016);
insert into db_layoutcampos select 15017 ,875 ,'NR_LICITACAO_ORIGINAL' ,'NR_LICITACAO_ORIGINAL' ,1 ,95 ,'' ,20 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15017);
insert into db_layoutcampos select 15018 ,875 ,'ANO_LICITACAO_ORIGINAL' ,'ANO_LICITACAO_ORIGINAL' ,1 ,115 ,'' ,4 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15018);
insert into db_layoutcampos select 15019 ,875 ,'NR_ATA_REGISTRO_PRECO' ,'NR_ATA_REGISTRO_PRECO' ,1 ,119 ,'' ,20 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15019);
insert into db_layoutcampos select 15020 ,875 ,'DT_ATA_REGISTRO_PRECO' ,'DT_ATA_REGISTRO_PRECO' ,1 ,139 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15020);
insert into db_layoutcampos select 15021 ,875 ,'PC_TAXA_RISCO' ,'PC_TAXA_RISCO' ,1 ,149 ,'' ,6 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15021);
insert into db_layoutcampos select 15022 ,875 ,'TP_EXECUCAO' ,'TP_EXECUCAO' ,1 ,155 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15022);
insert into db_layoutcampos select 15023 ,875 ,'TP_DISPUTA' ,'TP_DISPUTA' ,1 ,156 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15023);
insert into db_layoutcampos select 15024 ,875 ,'TP_PREQUALIFICACAO' ,'TP_PREQUALIFICACAO' ,1 ,157 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15024);
insert into db_layoutcampos select 15025 ,875 ,'BL_INVERSAO_FASES' ,'BL_INVERSAO_FASES' ,1 ,158 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15025);
insert into db_layoutcampos select 15026 ,875 ,'TP_RESULTADO_GLOBAL' ,'TP_RESULTADO_GLOBAL' ,1 ,159 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15026);
insert into db_layoutcampos select 15027 ,875 ,'TP_RESULTADO_LICITACAO' ,'TP_RESULTADO_LICITACAO' ,1 ,160 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15027);
insert into db_layoutcampos select 15028 ,875 ,'CNPJ_ORGAO_GERENCIADOR' ,'CNPJ_ORGAO_GERENCIADOR' ,1 ,161 ,'' ,14 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15028);
insert into db_layoutcampos select 15029 ,875 ,'NM_ORGAO_GERENCIADOR' ,'NM_ORGAO_GERENCIADOR' ,1 ,175 ,'' ,60 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15029);
insert into db_layoutcampos select 15030 ,875 ,'DS_OBJETO' ,'DS_OBJETO' ,1 ,235 ,'' ,500 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15030);
insert into db_layoutcampos select 15031 ,875 ,'CD_TIPO_FUNDAMENTACAO' ,'CD_TIPO_FUNDAMENTACAO' ,1 ,735 ,'' ,8 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15031);
insert into db_layoutcampos select 15032 ,875 ,'NR_ARTIGO' ,'NR_ARTIGO' ,1 ,743 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15032);
insert into db_layoutcampos select 15033 ,875 ,'DS_INCISO' ,'DS_INCISO' ,1 ,753 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15033);
insert into db_layoutcampos select 15034 ,875 ,'DS_LEI' ,'DS_LEI' ,1 ,763 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15034);
insert into db_layoutcampos select 15035 ,875 ,'DT_INICIO_INSCR_CRED' ,'DT_INICIO_INSCR_CRED' ,1 ,773 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15035);
insert into db_layoutcampos select 15036 ,875 ,'DT_FIM_INSCR_CRED' ,'DT_FIM_INSCR_CRED' ,1 ,783 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15036);
insert into db_layoutcampos select 15037 ,875 ,'DT_INICIO_VIGEN_CRED' ,'DT_INICIO_VIGEN_CRED' ,1 ,793 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15037);
insert into db_layoutcampos select 15038 ,875 ,'DT_FIM_VIGEN_CRED' ,'DT_FIM_VIGEN_CRED' ,1 ,803 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15038);
insert into db_layoutcampos select 15039 ,875 ,'VL_LICITACAO' ,'VL_LICITACAO' ,1 ,813 ,'' ,16 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15039);
insert into db_layoutcampos select 15040 ,875 ,'BL_ORCAMENTO_SIGILOSO' ,'BL_ORCAMENTO_SIGILOSO' ,1 ,829 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15040);
insert into db_layoutcampos select 15041 ,875 ,'BL_RECEBE_INSCRICAO_PER_VIG' ,'BL_RECEBE_INSCRICAO_PER_VIG' ,1 ,830 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15041);
insert into db_layoutcampos select 15042 ,875 ,'BL_PERMITE_CONSORCIO' ,'BL_PERMITE_CONSORCIO' ,1 ,831 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15042);
insert into db_layoutcampos select 15043 ,875 ,'DT_ABERTURA' ,'DT_ABERTURA' ,1 ,832 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15043);
insert into db_layoutcampos select 15044 ,875 ,'DT_HOMOLOGACAO' ,'DT_HOMOLOGACAO' ,1 ,842 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15044);
insert into db_layoutcampos select 15045 ,875 ,'DT_ADJUDICACAO' ,'DT_ADJUDICACAO' ,1 ,852 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15045);
insert into db_layoutcampos select 15046 ,875 ,'BL_LICIT_PROPRIA_ORGAO' ,'BL_LICIT_PROPRIA_ORGAO' ,1 ,862 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15046);
insert into db_layoutcampos select 15047 ,875 ,'TP_DOCUMENTO_FORNECEDOR' ,'TP_DOCUMENTO_FORNECEDOR' ,1 ,863 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15047);
insert into db_layoutcampos select 15048 ,875 ,'NR_DOCUMENTO_FORNECEDOR' ,'NR_DOCUMENTO_FORNECEDOR' ,1 ,864 ,'' ,14 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15048);
insert into db_layoutcampos select 15049 ,875 ,'TP_DOCUMENTO_VENCEDOR' ,'TP_DOCUMENTO_VENCEDOR' ,1 ,878 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15049);
insert into db_layoutcampos select 15050 ,875 ,'NR_DOCUMENTO_VENCEDOR' ,'NR_DOCUMENTO_VENCEDOR' ,1 ,879 ,'' ,14 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15050);
insert into db_layoutcampos select 15051 ,875 ,'VL_HOMOLOGADO' ,'VL_HOMOLOGADO' ,1 ,893 ,'' ,16 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15051);
insert into db_layoutcampos select 15052 ,875 ,'BL_GERA_DESPESA' ,'BL_GERA_DESPESA' ,1 ,909 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15052);
insert into db_layoutcampos select 15053 ,875 ,'DS_OBSERVACAO' ,'DS_OBSERVACAO' ,1 ,910 ,'' ,500 ,'f' ,'t' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15053);

update db_layoutcampos set db52_posicao = db52_posicao-1 where db52_layoutlinha = 875 and db52_posicao >= 160 and db52_codigo <> 15027;
delete from db_layoutcampos where db52_codigo = 15027;

update db_layoutlinha set db51_codigo = 874 , db51_layouttxt = 264 , db51_descr = 'CABEÇALHO' , db51_tipolinha = 1 , db51_tamlinha = 0 , db51_linhasantes = 0 , db51_linhasdepois = 0 , db51_obs = '' , db51_separador = '|' , db51_compacta = '1' where db51_codigo = 874;
update db_layoutlinha set db51_codigo = 875 , db51_layouttxt = 264 , db51_descr = 'REGISTRO' , db51_tipolinha = 3 , db51_tamlinha = 0 , db51_linhasantes = 0 , db51_linhasdepois = 0 , db51_obs = '' , db51_separador = '|' , db51_compacta = '1' where db51_codigo = 875;

-- Cadastrando novas opções para o Tipo de Fundamentação
insert into db_cadattdinamicoatributosopcoes select nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), (select db109_sequencial from db_cadattdinamicoatributos where db109_nome = 'codigofundamentacao'), 'A24I', 'Art. 24, inc. I, da Lei nº 8.666/93' where not exists (select 1 from db_cadattdinamicoatributosopcoes where db18_cadattdinamicoatributos = (select db109_sequencial from db_cadattdinamicoatributos where db109_nome = 'codigofundamentacao') and db18_opcao = 'A24I');
insert into db_cadattdinamicoatributosopcoes select nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), (select db109_sequencial from db_cadattdinamicoatributos where db109_nome = 'codigofundamentacao'), 'A24II', 'Art. 24, inc. II, da Lei nº 8.666/93' where not exists (select 1 from db_cadattdinamicoatributosopcoes where db18_cadattdinamicoatributos = (select db109_sequencial from db_cadattdinamicoatributos where db109_nome = 'codigofundamentacao') and db18_opcao = 'A24II');

-- Cadastrando nova opção para o tipo de benefício para mepp.
insert into db_cadattdinamicoatributosopcoes select nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), (select db109_sequencial from db_cadattdinamicoatributos where db109_nome = 'tipobeneficiomicroepp'), 'C', 'Cotas para ME/EPP' where not exists (select 1 from db_cadattdinamicoatributosopcoes where db18_cadattdinamicoatributos = (select db109_sequencial from db_cadattdinamicoatributos where db109_nome = 'tipobeneficiomicroepp') and db18_opcao = 'C');

-- Dicionário de dados
update db_syscampo set conteudo = 'text', tamanho = 1 where codcam = 21705;
update db_syscampo set conteudo = 'text', tamanho = 1 where codcam = 18492;

select fc_executa_ddl('
  insert into db_layouttxt( db50_codigo ,db50_layouttxtgrupo ,db50_descr ,db50_quantlinhas ,db50_obs ) values ( 271 ,6 ,\'TCE/RS - LICITACON - LOTE V1.3\' ,0 ,\'\' );
  insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 881 ,271 ,\'CABEÇALHO\' ,1 ,0 ,0 ,0 ,\'\' ,\'|\' ,true );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15080 ,881 ,\'CNPJ\' ,\'CNPJ\' ,1 ,1 ,\'\' ,14 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15081 ,881 ,\'DATA_INICIAL\' ,\'DATA_INICIAL\' ,1 ,15 ,\'\' ,10 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15082 ,881 ,\'DATA_FINAL\' ,\'DATA_FINAL\' ,1 ,25 ,\'\' ,10 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15083 ,881 ,\'DATA_GERACAO\' ,\'DATA_GERACAO\' ,1 ,35 ,\'\' ,10 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15084 ,881 ,\'NOME_SETOR\' ,\'NOME_SETOR\' ,1 ,45 ,\'\' ,150 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15085 ,881 ,\'TOTAL_REGISTROS\' ,\'TOTAL_REGISTROS\' ,1 ,195 ,\'\' ,15 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 882 ,271 ,\'REGISTRO\' ,3 ,0 ,0 ,0 ,\'\' ,\'|\' ,true );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15086 ,882 ,\'NR_LICITACAO\' ,\'NR_LICITACAO\' ,1 ,1 ,\'\' ,20 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15087 ,882 ,\'ANO_LICITACAO\' ,\'ANO_LICITACAO\' ,1 ,21 ,\'\' ,4 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15088 ,882 ,\'CD_TIPO_MODALIDADE\' ,\'CD_TIPO_MODALIDADE\' ,1 ,25 ,\'\' ,3 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15089 ,882 ,\'NR_LOTE\' ,\'NR_LOTE\' ,1 ,28 ,\'\' ,10 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15090 ,882 ,\'DS_LOTE\' ,\'DS_LOTE\' ,13 ,38 ,\'\' ,500 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15091 ,882 ,\'VL_ESTIMADO\' ,\'VL_ESTIMADO\' ,1 ,538 ,\'\' ,16 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15092 ,882 ,\'VL_HOMOLOGADO\' ,\'VL_HOMOLOGADO\' ,1 ,554 ,\'\' ,16 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15093 ,882 ,\'TP_RESULTADO_LOTE\' ,\'TP_RESULTADO_LOTE\' ,1 ,570 ,\'\' ,1 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15094 ,882 ,\'TP_DOCUMENTO_VENCEDOR\' ,\'TP_DOCUMENTO_VENCEDOR\' ,1 ,571 ,\'\' ,1 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15095 ,882 ,\'NR_DOCUMENTO_VENCEDOR\' ,\'NR_DOCUMENTO_VENCEDOR\' ,1 ,572 ,\'\' ,14 ,\'false\' ,\'true\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15096 ,882 ,\'TP_DOCUMENTO_FORNECEDOR\' ,\'TP_DOCUMENTO_FORNECEDOR\' ,1 ,586 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
  insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 15097 ,882 ,\'NR_DOCUMENTO_FORNECEDOR\' ,\'NR_DOCUMENTO_FORNECEDOR\' ,1 ,587 ,\'\' ,14 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
');

-- Cadastro do leiaute ITEM.TXT 1.3
insert into db_layouttxt select 273 , 'TCE/RS - LICITACON - ITEM 1.3' ,0 ,'', 6 where not exists (select 1 from db_layouttxt where db50_codigo = 273);
insert into db_layoutlinha select 884 ,273 ,'CABEÇALHO' ,1 ,0 ,0 ,0 ,'' ,'|' ,'1' where not exists (select 1 from db_layoutlinha where db51_codigo = 884);
insert into db_layoutcampos select 15130, 884 ,'CNPJ' ,'CNPJ' ,1 ,1 ,'' ,14 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15130);
insert into db_layoutcampos select 15131, 884 ,'DATA_INICIAL' ,'DATA_INICIAL' ,1 ,15 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15131);
insert into db_layoutcampos select 15132, 884 ,'DATA_FINAL' ,'DATA_FINAL' ,1 ,25 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15132);
insert into db_layoutcampos select 15133, 884 ,'DATA_GERACAO' ,'DATA_GERACAO' ,1 ,35 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15133);
insert into db_layoutcampos select 15134, 884 ,'NOME_SETOR' ,'NOME_SETOR' ,1 ,45 ,'' ,150 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15134);
insert into db_layoutcampos select 15135, 884 ,'TOTAL_REGISTROS' ,'TOTAL_REGISTROS' ,1 ,195 ,'' ,15 ,'false' ,'true' ,'d' ,'' ,0 where not exists (select 1 from db_layoutcampos where db52_codigo = 15135);
insert into db_layoutlinha select 885, 273 ,'REGISTRO' ,3 ,0 ,0 ,0 ,'' ,'|' ,'1' where not exists (select 1 from db_layoutlinha where db51_codigo = 885);
insert into db_layoutcampos select 15136, 885 ,'NR_LICITACAO' ,'NR_LICITACAO' ,1 ,1 ,'' ,20 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15136);
insert into db_layoutcampos select 15137, 885 ,'ANO_LICITACAO' ,'ANO_LICITACAO' ,1 ,21 ,'' ,4 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15137);
insert into db_layoutcampos select 15138, 885 ,'CD_TIPO_MODALIDADE' ,'CD_TIPO_MODALIDADE' ,1 ,25 ,'' ,3 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15138);
insert into db_layoutcampos select 15139, 885 ,'NR_LOTE' ,'NR_LOTE' ,1 ,28 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15139);
insert into db_layoutcampos select 15140, 885 ,'NR_ITEM' ,'NR_ITEM' ,1 ,38 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15140);
insert into db_layoutcampos select 15141, 885 ,'NR_ITEM_ORIGINAL' ,'NR_ITEM_ORIGINAL' ,1 ,48 ,'' ,20 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15141);
insert into db_layoutcampos select 15142, 885 ,'DS_ITEM' ,'DS_ITEM' ,13 ,68 ,'' ,300 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15142);
insert into db_layoutcampos select 15143, 885 ,'QT_ITENS' ,'QT_ITENS' ,1 ,368 ,'' ,12 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15143);
insert into db_layoutcampos select 15144, 885 ,'SG_UNIDADE_MEDIDA' ,'SG_UNIDADE_MEDIDA' ,1 ,380 ,'' ,5 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15144);
insert into db_layoutcampos select 15145, 885 ,'VL_UNITARIO_ESTIMADO' ,'VL_UNITARIO_ESTIMADO' ,1 ,385 ,'' ,16 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15145);
insert into db_layoutcampos select 15146, 885 ,'VL_TOTAL_ESTIMADO' ,'VL_TOTAL_ESTIMADO' ,1 ,401 ,'' ,16 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15146);
insert into db_layoutcampos select 15147, 885 ,'DT_REF_VALOR_ESTIMADO' ,'DT_REF_VALOR_ESTIMADO' ,1 ,417 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15147);
insert into db_layoutcampos select 15148, 885 ,'PC_BDI_ESTIMADO' ,'PC_BDI_ESTIMADO' ,1 ,427 ,'' ,6 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15148);
insert into db_layoutcampos select 15149, 885 ,'PC_ENCARGOS_SOCIAIS_ESTIMADO' ,'PC_ENCARGOS_SOCIAIS_ESTIMADO' ,1 ,433 ,'' ,7 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15149);
insert into db_layoutcampos select 15150, 885 ,'CD_FONTE_REFERENCIA' ,'CD_FONTE_REFERENCIA' ,1 ,440 ,'' ,20 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15150);
insert into db_layoutcampos select 15151, 885 ,'DS_FONTE_REFERENCIA' ,'DS_FONTE_REFERENCIA' ,13 ,460 ,'' ,60 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15151);
insert into db_layoutcampos select 15152, 885 ,'TP_RESULTADO_ITEM' ,'TP_RESULTADO_ITEM' ,1 ,520 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15152);
insert into db_layoutcampos select 15153, 885 ,'VL_UNITARIO_HOMOLOGADO' ,'VL_UNITARIO_HOMOLOGADO' ,1 ,521 ,'' ,16 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15153);
insert into db_layoutcampos select 15154, 885 ,'VL_TOTAL_HOMOLOGADO' ,'VL_TOTAL_HOMOLOGADO' ,1 ,537 ,'' ,16 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15154);
insert into db_layoutcampos select 15155, 885 ,'PC_BDI_HOMOLOGADO' ,'PC_BDI_HOMOLOGADO' ,1 ,553 ,'' ,6 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15155);
insert into db_layoutcampos select 15156, 885 ,'PC_ENCARGOS_SOCIAIS_HOMOLOGADO' ,'PC_ENCARGOS_SOCIAIS_HOMOLOGADO' ,1 ,559 ,'' ,6 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15156);
insert into db_layoutcampos select 15157, 885 ,'TP_ORCAMENTO' ,'TP_ORCAMENTO' ,1 ,565 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15157);
insert into db_layoutcampos select 15158, 885 ,'CD_TIPO_FAMILIA' ,'CD_TIPO_FAMILIA' ,1 ,566 ,'' ,3 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15158);
insert into db_layoutcampos select 15159, 885 ,'CD_TIPO_SUBFAMILIA' ,'CD_TIPO_SUBFAMILIA' ,1 ,569 ,'' ,3 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15159);
insert into db_layoutcampos select 15160, 885 ,'TP_DOCUMENTO_VENCEDOR' ,'TP_DOCUMENTO_VENCEDOR' ,1 ,572 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15160);
insert into db_layoutcampos select 15161, 885 ,'NR_DOCUMENTO_VENCEDOR' ,'NR_DOCUMENTO_VENCEDOR' ,1 ,573 ,'' ,14 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15161);
insert into db_layoutcampos select 15164, 885 ,'TP_DOCUMENTO_VENCEDOR' ,'TP_DOCUMENTO_VENCEDOR' ,1 ,587 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15164);
update db_layoutcampos set db52_codigo = 15164 , db52_layoutlinha = 885 , db52_nome = 'TP_DOCUMENTO_FORNECEDOR' , db52_descr = 'TP_DOCUMENTO_FORNECEDOR' , db52_layoutformat = 1 , db52_posicao = 587 , db52_default = '' , db52_tamanho = 1 , db52_ident = 'f' , db52_imprimir = 't' , db52_alinha = 'd' , db52_obs = '' , db52_quebraapos = 0 where db52_codigo = 15164;
insert into db_layoutcampos select 15168 ,885 ,'NR_DOCUMENTO_FORNECEDOR' ,'NR_DOCUMENTO_FORNECEDOR' ,1 ,588 ,'' ,14 ,'f' ,'t' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo = 15168);

-- Atualizando DS_ITEM da ITEM.TXT 1.2 e 1.3
update db_layoutcampos set db52_codigo = 15142 , db52_layoutlinha = 885 , db52_nome = 'DS_ITEM' , db52_descr = 'DS_ITEM' , db52_layoutformat = 13 , db52_posicao = 68 , db52_default = '' , db52_tamanho = 500 , db52_ident = 'f' , db52_imprimir = 't' , db52_alinha = 'd' , db52_obs = '' , db52_quebraapos = 0 where db52_codigo = 15142;
update db_layoutcampos set db52_posicao = db52_posicao+200 where db52_layoutlinha = 885 and db52_posicao >= 68 and db52_codigo <> 15142;
update db_layoutcampos set db52_codigo = 12970 , db52_layoutlinha = 811 , db52_nome = 'DS_ITEM' , db52_descr = 'DS_ITEM' , db52_layoutformat = 13 , db52_posicao = 68 , db52_default = '' , db52_tamanho = 500 , db52_ident = 'f' , db52_imprimir = 't' , db52_alinha = 'd' , db52_obs = '' , db52_quebraapos = 0 where db52_codigo = 12970;
update db_layoutcampos set db52_posicao = db52_posicao+200 where db52_layoutlinha = 811 and db52_posicao >= 68 and db52_codigo <> 12970;

-- Atualizando tamanho do campo NOME_ARQUIVO_DOCUMENTO do arquivo DOCUMENTO_LIC.TXT
update db_layoutcampos set db52_codigo = 12937 , db52_layoutlinha = 807 , db52_nome = 'NOME_ARQUIVO_DOCUMENTO' , db52_descr = 'NOME_ARQUIVO_DOCUMENTO' , db52_layoutformat = 13 , db52_posicao = 31 , db52_default = '' , db52_tamanho = 200 , db52_ident = 'f' , db52_imprimir = 't' , db52_alinha = 'd' , db52_obs = '' , db52_quebraapos = 0 where db52_codigo = 12937;
update db_layoutcampos set db52_posicao = db52_posicao+100 where db52_layoutlinha = 807 and db52_posicao >= 31 and db52_codigo <> 12937;

-- Cadastro do leiaute CONTRATO.TXT 1.3
insert into db_layouttxt select 275 ,'TCE/RS - LICITACON - CONTRATOS 1.3' ,0 ,'', 6 where not exists (select 1 from db_layouttxt where db50_codigo  = 275 );
insert into db_layoutlinha select 886 ,275 ,'CABEÇALHO' ,1 ,0 ,0 ,0 ,'' ,'|' ,'1' where not exists (select 1 from db_layoutlinha where db51_codigo  = 886);
insert into db_layoutlinha select 887 ,275 ,'REGISTRO' ,3 ,0 ,0 ,0 ,'' ,'|' ,'1' where not exists (select 1 from db_layoutlinha where db51_codigo  = 887);
insert into db_layoutcampos select 15251 ,886 ,'CNPJ' ,'CNPJ' ,1 ,1 ,'' ,14 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15251);
insert into db_layoutcampos select 15252 ,886 ,'DATA_INICIAL' ,'DATA_INICIAL' ,1 ,15 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15252);
insert into db_layoutcampos select 15253 ,886 ,'DATA_FINAL' ,'DATA_FINAL' ,1 ,25 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15253);
insert into db_layoutcampos select 15254 ,886 ,'DATA_GERACAO' ,'DATA_GERACAO' ,1 ,35 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15254);
insert into db_layoutcampos select 15255 ,886 ,'NOME_SETOR' ,'NOME_SETOR' ,1 ,45 ,'' ,150 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15255);
insert into db_layoutcampos select 15256 ,886 ,'TOTAL_REGISTROS' ,'TOTAL_REGISTROS' ,1 ,195 ,'' ,15 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15256);
insert into db_layoutcampos select 15257 ,887 ,'NR_LICITACAO' ,'NR_LICITACAO' ,1 ,1 ,'' ,20 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15257);
insert into db_layoutcampos select 15258 ,887 ,'ANO_LICITACAO' ,'ANO_LICITACAO' ,1 ,21 ,'' ,4 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15258);
insert into db_layoutcampos select 15259 ,887 ,'CD_TIPO_MODALIDADE' ,'CD_TIPO_MODALIDADE' ,1 ,25 ,'' ,3 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15259);
insert into db_layoutcampos select 15260 ,887 ,'NR_CONTRATO' ,'NR_CONTRATO' ,1 ,28 ,'' ,20 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15260);
insert into db_layoutcampos select 15261 ,887 ,'ANO_CONTRATO' ,'ANO_CONTRATO' ,1 ,48 ,'' ,4 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15261);
insert into db_layoutcampos select 15262 ,887 ,'TP_INSTRUMENTO' ,'TP_INSTRUMENTO' ,1 ,52 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15262);
insert into db_layoutcampos select 15263 ,887 ,'NR_PROCESSO' ,'NR_PROCESSO' ,1 ,53 ,'' ,20 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15263);
insert into db_layoutcampos select 15264 ,887 ,'ANO_PROCESSO' ,'ANO_PROCESSO' ,1 ,73 ,'' ,4 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15264);
insert into db_layoutcampos select 15265 ,887 ,'TP_DOCUMENTO_CONTRATADO' ,'TP_DOCUMENTO_CONTRATADO' ,1 ,77 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15265);
insert into db_layoutcampos select 15266 ,887 ,'NR_DOCUMENTO_CONTRATADO' ,'NR_DOCUMENTO_CONTRATADO' ,1 ,78 ,'' ,14 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15266);
insert into db_layoutcampos select 15267 ,887 ,'DT_INICIO_VIGENCIA' ,'DT_INICIO_VIGENCIA' ,1 ,92 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15267);
insert into db_layoutcampos select 15268 ,887 ,'DT_FINAL_VIGENCIA' ,'DT_FINAL_VIGENCIA' ,1 ,102 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15268);
insert into db_layoutcampos select 15269 ,887 ,'VL_CONTRATO' ,'VL_CONTRATO' ,1 ,112 ,'' ,16 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15269);
insert into db_layoutcampos select 15270 ,887 ,'DT_ASSINATURA' ,'DT_ASSINATURA' ,1 ,128 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15270);
insert into db_layoutcampos select 15271 ,887 ,'BL_GARANTIA' ,'BL_GARANTIA' ,1 ,138 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15271);
insert into db_layoutcampos select 15272 ,887 ,'NR_DIAS_PRAZO' ,'NR_DIAS_PRAZO' ,1 ,139 ,'' ,5 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15272);
insert into db_layoutcampos select 15273 ,887 ,'DS_OBJETO' ,'DS_OBJETO' ,1 ,144 ,'' ,500 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15273);
insert into db_layoutcampos select 15274 ,887 ,'NR_CONTRATO_ORIGINAL' ,'NR_CONTRATO_ORIGINAL' ,1 ,644 ,'' ,20 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15274);
insert into db_layoutcampos select 15275 ,887 ,'BL_INICIO_DEPENDE_OI' ,'BL_INICIO_DEPENDE_OI' ,1 ,664 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15275);
insert into db_layoutcampos select 15276 ,887 ,'DS_JUSTIFICATIVA' ,'DS_JUSTIFICATIVA' ,1 ,665 ,'' ,300 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15276);
insert into db_layoutcampos select 15277 ,887 ,'CNPJ_CONSORCIO' ,'CNPJ_CONSORCIO' ,1 ,965 ,'' ,14 ,'false' ,'true' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15277);
insert into db_layoutcampos select 15278 ,887 ,'CNPJ_ORGAO_GERENCIADOR' ,'CNPJ_ORGAO_GERENCIADOR' ,1 ,979 ,'' ,14 ,'f' ,'t' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15278);
insert into db_layoutcampos select 15279 ,887 ,'BL_GERA_DESPESA' ,'BL_GERA_DESPESA' ,1 ,993 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15279);
insert into db_layoutcampos select 15280 ,887 ,'DS_OBSERVACAO' ,'DS_OBSERVACAO' ,1 ,994 ,'' ,500 ,'f' ,'t' ,'d' ,'' ,0  where not exists (select 1 from db_layoutcampos where db52_codigo  = 15280);

select fc_executa_ddl($$
insert into db_sysarquivo values (3993, 'modeloplanoconta', 'Modelos do Plano de Contas', 'c94', '2016-11-25', 'Modelos do Plano de Contas', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (32,3993);
insert into db_syscampo values(22181,'c94_sequencial','int4','Código sequencial','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(22182,'c94_nome','varchar(100)','Nome','', 'Nome',100,'f','t','f',0,'text','Nome');
insert into db_syscampo values(22183,'c94_exercicio','int4','Exercício','0', 'Exercício',4,'f','f','f',1,'text','Exercício');
delete from db_sysarqcamp where codarq = 3993;
insert into db_sysarqcamp values(3993,22181,1,0);
insert into db_sysarqcamp values(3993,22182,2,0);
insert into db_sysarqcamp values(3993,22183,3,0);
insert into db_syssequencia values(1000622, 'modeloplanoconta_c94_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000622 where codarq = 3993 and codcam = 22181;
delete from db_sysprikey where codarq = 3993;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3993,22181,1,22182);
insert into db_sysindices values(4393,'modeloplanoconta_sequencial_in',3993,'0');
insert into db_syscadind values(4393,22181,1);
insert into db_sysarquivo values (3994, 'planocontadetalhe', 'planocontadetalhe', 'c95', '2016-11-25', 'planocontadetalhe', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (32,3994);
insert into db_syscampo values(22184,'c95_sequencial','int4','Código','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(22185,'c95_modeloplanoconta','int4','Modelos do Plano de Contas','0', 'Modelos do Plano de Contas',10,'f','f','f',1,'text','Modelos do Plano de Contas');
insert into db_syscampo values(22186,'c95_estrutural','varchar(25)','Estrutural','', 'Estrutural',25,'f','t','f',0,'text','Estrutural');
insert into db_syscampo values(22187,'c95_titulo','varchar(200)','Título','', 'Título',200,'f','t','f',0,'text','Título');
insert into db_syscampo values(22188,'c95_funcao','text','Função','', 'Função',1,'f','t','f',0,'text','Função');
insert into db_syscampo values(22189,'c95_naturezasaldo','int4','Natureza do Saldo','0', 'Natureza do Saldo',10,'f','f','f',1,'text','Natureza do Saldo');
insert into db_syscampo values(22190,'c95_analitica','bool','Conta Analítica','f', 'Conta Analítica',1,'f','f','f',5,'text','Conta Analítica');
insert into db_syscampo values(22191,'c95_sistema','int4','Sistema','0', 'Sistema',10,'f','f','f',1,'text','Sistema');
insert into db_syscampo values(22192,'c95_indicadorsuperavit','varchar(1)','Indicador de Superavit','N', 'Indicador de Superavit',10,'t','f','f',1,'text','Indicador de Superavit');
insert into db_syscampo values(22212,'c95_excluir','bool','Indica se é para excluir ou não a conta.','f', 'Excluir',1,'f','f','f',5,'text','Excluir');
insert into db_sysarqcamp values(3994,22212,10,0);
delete from db_sysarqcamp where codarq = 3994;
insert into db_sysarqcamp values(3994,22184,1,0);
insert into db_sysarqcamp values(3994,22185,2,0);
insert into db_sysarqcamp values(3994,22186,3,0);
insert into db_sysarqcamp values(3994,22187,4,0);
insert into db_sysarqcamp values(3994,22188,5,0);
insert into db_sysarqcamp values(3994,22189,6,0);
insert into db_sysarqcamp values(3994,22190,7,0);
insert into db_sysarqcamp values(3994,22191,8,0);
insert into db_sysarqcamp values(3994,22192,9,0);
insert into db_sysarqcamp values(3994,22212,10,0);
delete from db_sysprikey where codarq = 3994;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3994,22186,1,22187);
delete from db_sysprikey where codarq = 3994;
delete from db_sysprikey where codarq = 3994;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3994,22184,1,22187);
delete from db_sysforkey where codarq = 3994 and referen = 0;
insert into db_sysforkey values(3994,22185,1,3994,0);
insert into db_syssequencia values(1000623, 'planocontadetalhe_c95_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000623 where codarq = 3994 and codcam = 22184;
delete from db_sysforkey where codarq = 3994 and referen = 0;
insert into db_sysforkey values(3994,22191,1,3269,0);
insert into db_sysindices values(4394,'planocontadetalhe_modeloplanoconta_in',3994,'0');
insert into db_syscadind values(4394,22185,1);

insert into db_sysarquivo values (3995, 'importacaoplanoconta', 'importacaoplanoconta', 'c96', '2016-11-25', 'importacaoplanoconta', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (32,3995);
insert into db_syscampo values(22193,'c96_sequencial','int4','Codigo','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(22194,'c96_modeloplanoconta','int4','Modelos do Plano de Contas','0', 'Modelos do Plano de Contas',10,'f','f','f',1,'text','Modelos do Plano de Contas');
insert into db_syscampo values(22195,'c96_data','date','Data do processamento','null', 'Data de Processamento',10,'f','f','f',1,'text','Data de Processamento');
delete from db_sysarqcamp where codarq = 3995;
insert into db_sysarqcamp values(3995,22193,1,0);
insert into db_sysarqcamp values(3995,22194,2,0);
insert into db_sysarqcamp values(3995,22195,3,0);
delete from db_sysprikey where codarq = 3995;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3995,22193,1,22195);
delete from db_sysforkey where codarq = 3995 and referen = 0;
insert into db_sysforkey values(3995,22194,1,3993,0);
insert into db_sysindices values(4395,'importacaoplanoconta_modeloplanoconta',3995,'0');
insert into db_syscadind values(4395,22194,1);
insert into db_syssequencia values(1000624, 'importacaoplanoconta_c96_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000624 where codarq = 3995 and codcam = 22193;

$$);

insert into db_itensmenu select 10339, 'Atualizar', 'Atualização Plano de Contas PCASP', 'con1_importacaopcasp001.php', '1', '1', 'Atualização do Plano de Contas PCASP', 'true' where not exists (select 1 from db_itensmenu where id_item = 10339);
insert into db_menu select 9068, 10339, 5, 209 where not exists (select 1 from db_menu where (id_item, id_item_filho, modulo) = (9068, 10339, 209));

select fc_executa_ddl($$
  insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10340 ,'Atualização do Plano de Contas' ,'Atualização do Plano de Contas' ,'con2_importacaopcasp001.php' ,'1' ,'1' ,'Emite um relatório demonstrando informações gerais da importação de um plano de contas.' ,'true' );
  insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 3331 ,10340 ,49 ,209 );
$$);

---------------------------------------------------------------------------------------------------------------
--------------------------------------------- FIM FINANCEIRO --------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO TRIBUTARIO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

select fc_executa_ddl($$
  insert into db_layouttxtgrupo values (7, 1, 'AGUA TARIFA - EXPORT./IMPORT. COLETORES');

  insert into db_layouttxt values (265, 'SITUACOES DE LEITURA', 0, '', 7 );
  insert into db_layoutlinha values (876, 265, 'REGISTRO', 3, 50, 0, 0, '', '', false );
  insert into db_layoutcampos values (15054, 876, 'codigo', 'CODIGO DA SITUACAO', 1, 1, '', 5, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15056, 876, 'descricao', 'DESCRICAO DA SITUACAO', 1, 6, '', 40, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15057, 876, 'regra', 'REGRA DA SITUACAO', 1, 46, '', 5, false, true, 'e', '', 0 );

  insert into db_layouttxt values (266, 'CATEGORIA DE CONSUMO', 9, 'Informações das estruturas tarifárias que formam as categorias de consumo.', 7 );
  insert into db_layoutlinha values (877, 266, 'REGISTRO', 3, 176, 0, 0, '', '', false );
  insert into db_layoutcampos values (15055, 877, 'codigo', 'CÓDIGO', 2, 1, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15058, 877, 'descricao', 'DESCRIÇÃO', 1, 11, '', 100, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15059, 877, 'exercicio', 'EXERCÍCIO', 2, 111, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15060, 877, 'faixa_inicial', 'FAIXA INICIAL', 2, 115, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15061, 877, 'faixa_final', 'FAIXA FINAL', 2, 125, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15062, 877, 'valor', 'VALOR DA FAIXA', 1, 135, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15063, 877, 'valor_tarifa_agua', 'TARIFA BÁSICA DE ÁGUA', 1, 147, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15064, 877, 'valor_tarifa_esgoto', 'TARIFA BÁSICA DE ESGOTO', 1, 159, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15065, 877, 'percentual_esgoto', 'PERCENTUAL DE ESGOTO (CONSUMO)', 2, 171, '', 6, false, true, 'e', '', 0 );

  insert into db_layouttxt values (267, 'LEITURISTAS', 0, '', 7 );
  insert into db_layoutlinha values (878, 267, 'REGISTRO', 3, 140, 0, 0, '', '', false );
  insert into db_layoutcampos values (15066, 878, 'codigo', 'CODIGO DO LEITURISTA', 1, 1, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15067, 878, 'nome', 'NOME DO LEITURISTA', 1, 11, '', 40, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15068, 878, 'senha', 'SENHA DO LEITURISTA', 1, 51, '', 40, false, true, 'd', '', 0 );

  insert into db_layouttxt values (268, 'ECONOMIAS', 1, '', 7 );
  insert into db_layoutlinha values (879, 268, 'REGISTRO', 3, 34, 0, 0, '', '', false );
  insert into db_layoutcampos values (15069, 879, 'codigo_contrato', 'CÓDIGO DO CONTRATO', 1, 11, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15071, 879, 'codigo_matricula', 'CÓDIGO DA MATRÍCULA', 1, 1, '', 10, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15072, 879, 'codigo_categoria_consumo', 'CATEGORIA DE CONSUMO', 1, 21, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15073, 879, 'quantidade_economias', 'QUANTIDADE DE ECONOMIAS', 1, 31, '', 4, false, true, 'e', '', 0 );

  insert into db_layouttxt values (269, 'ISENÇÕES', 0, '', 7 );
  insert into db_layoutlinha values (880, 269, 'REGISTRO', 3, 146, 0, 0, '', '', false );
  insert into db_layoutcampos values (15074, 880, 'codigo', 'CÓDIGO', 1, 1, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15075, 880, 'descricao', 'DESCRIÇÃO', 1, 11, '', 100, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15076, 880, 'tipo_isencao', 'TIPO', 1, 111, '', 10, false, true, 'e', '', 0 );

  insert into db_layouttxt values (272, 'ROTAS E LEITURAS', 0, '', 7 );
  insert into db_layoutlinha values (883, 272, 'REGISTROS', 3, 2582, 0, 0, '', '', false );
  insert into db_layoutcampos values (15101, 883, 'ano', 'ANO DE REFERENCIA', 1, 31, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15102, 883, 'mes', 'MES DE REFERENCIA', 1, 35, '', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15103, 883, 'codigo_contrato', 'CODIGO DO CONTRATO', 1, 37, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15104, 883, 'codigo_cobranca', 'CODIGO DE COBRANCA (NUMNOV)', 1, 47, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15105, 883, 'codigo_matricula', 'CODIGO DA MATRICULA', 1, 57, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15106, 883, 'nome_responsavel', 'NOME RESPONSAVEL NO CONTRATO', 1, 67, '', 70, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15107, 883, 'documento_responsavel', 'DOCUMENTO DO RESPONSAVEL NO CONTRATO', 1, 137, '', 14, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15108, 883, 'codigo_logradouro', 'CODIGO DO LOGRADOURO', 1, 151, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15109, 883, 'tipo_logradouro', 'CODIGO DO TIPO DE LOGRADOURO', 1, 161, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15110, 883, 'nome_logradouro', 'NOME DO LOGRADOURO', 1, 165, '', 40, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15111, 883, 'numero', 'NUMERO DO IMOVEL', 1, 205, '', 5, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15112, 883, 'letra', 'LETRA DO IMOVEL', 1, 210, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15113, 883, 'complemento', 'COMPLEMENTO DO IMOVEL', 1, 211, '', 30, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15114, 883, 'bairro', 'BAIRRO DO IMOVEL', 1, 241, '', 40, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15115, 883, 'cidade', 'CIDADE DO IMOVEL', 1, 281, '', 40, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15116, 883, 'estado', 'ESTADO DO IMOVEL', 1, 321, '', 2, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15117, 883, 'zona', 'ZONA FISCAL DO IMOVEL', 1, 323, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15118, 883, 'quadra', 'QUADRA DO IMOVEL', 1, 326, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15119, 883, 'economias', 'NUMERO DE ECONOMIAS', 1, 330, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15120, 883, 'codigo_categoria_consumo', 'CODIGO DA CATEGORIA DE CONSUMO', 1, 333, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15121, 883, 'descricao_categoria_consumo', 'DESCRICAO DA CATEGORIA DE CONSUMO', 1, 343, '', 40, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15122, 883, 'codigo_hidrometro', 'CODIGO DO HIDROMETRO', 1, 383, '', 20, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15287, 883, 'codigo_tipo_isencao', 'CODIGO DO TIPO DE ISENCAO', 1, 403, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15123, 883, 'dt_leitura_atual', 'DATA DA LEITURA ATUAL', 1, 413, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15124, 883, 'dt_leitura_anterior', 'DATA DA LEITURA ANTERIOR', 1, 423, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15125, 883, 'consumo', 'ULTIMO CONSUMO REGISTRADO', 1, 433, '', 8, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15126, 883, 'dias_leitura', 'DIAS ENTRE A ULTIMA LEITURA', 1, 441, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15288, 883, 'dt_vencimento', 'DATA DE VENCIMENTO', 1, 445, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15127, 883, 'valor_acrescimo', 'VALOR DE ACRECIMO', 1, 455, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15128, 883, 'valor_desconto', 'VALOR DE DESCONTO', 1, 467, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15129, 883, 'valor_total', 'VALOR TOTAL DAS TARIFAS', 1, 479, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15162, 883, 'leitura_1_ano', 'ANO DE REFERENCIA', 1, 491, '', 4, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15163, 883, 'leitura_1_mes', 'MES DE REFERENCIA', 1, 495, '', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15165, 883, 'leitura_1_situacao', 'SITUACAO DA LEITURA', 1, 497, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15166, 883, 'leitura_1_leitura', 'LEITURA', 1, 500, '', 7, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15167, 883, 'leitura_1_consumo', 'CONSUMO', 1, 507, '', 7, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15169, 883, 'leitura_1_dias', 'DIAS ENTRE LEITURAS', 1, 514, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15170, 883, 'leitura_2_ano', 'ANO DE REFERENCIA', 1, 518, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15171, 883, 'leitura_2_mes', 'MES DE REFERENCIA', 1, 522, '', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15172, 883, 'leitura_2_situacao', 'SITUACAO DA LEITURA', 1, 524, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15173, 883, 'leitura_2_leitura', 'LEITURA', 1, 527, '', 7, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15174, 883, 'leitura_2_consumo', 'CONSUMO', 1, 534, '', 7, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15175, 883, 'leitura_2_dias', 'DIAS ENTRE LEITURAS', 1, 541, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15176, 883, 'leitura_3_ano', 'ANO DE REFERENCIA', 1, 545, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15177, 883, 'leitura_3_mes', 'MES DE REFERENCIA', 1, 549, '', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15178, 883, 'leitura_3_situacao', 'SITUACAO DA LEITURA', 1, 551, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15179, 883, 'leitura_3_leitura', 'LEITURA', 1, 554, '', 7, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15180, 883, 'leitura_3_consumo', 'CONSUMO', 1, 561, '', 7, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15181, 883, 'leitura_3_dias', 'DIAS ENTRE LEITURAS', 1, 568, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15182, 883, 'leitura_4_ano', 'ANO DE REFERENCIA', 1, 572, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15183, 883, 'leitura_4_mes', 'MES DE REFERENCIA', 1, 576, '', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15184, 883, 'leitura_4_situacao', 'SITUACAO DA LEITURA', 1, 578, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15185, 883, 'leitura_4_leitura', 'LEITURA', 1, 581, '', 7, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15186, 883, 'leitura_4_consumo', 'CONSUMO', 1, 588, '', 7, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15187, 883, 'leitura_4_dias', 'DIAS ENTRE LEITURAS', 1, 595, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15188, 883, 'leitura_5_ano', 'ANO DE REFERENCIA', 1, 599, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15189, 883, 'leitura_5_mes', 'MES DE REFERENCIA', 1, 603, '', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15190, 883, 'leitura_5_situacao', 'SITUACAO DA LEITURA', 1, 605, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15191, 883, 'leitura_5_leitura', 'LEITURA', 1, 608, '', 7, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15192, 883, 'leitura_5_consumo', 'CONSUMO', 1, 615, '', 7, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15193, 883, 'leitura_5_dias', 'DIAS ENTRE LEITURAS', 1, 622, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15281, 883, 'leitura_6_ano', 'ANO DE REFERENCIA', 1, 626, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15282, 883, 'leitura_6_mes', 'MES DE REFERENCIA', 1, 630, '', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15283, 883, 'leitura_6_situacao', 'SITUACAO DA LEITURA', 1, 632, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15284, 883, 'leitura_6_leitura', 'LEITURA', 1, 635, '', 7, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15285, 883, 'leitura_6_consumo', 'CONSUMO', 1, 642, '', 7, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15286, 883, 'leitura_6_dias', 'DIAS ENTRE LEITURAS', 1, 649, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15194, 883, 'titulo_receita_1', 'TITULO DA TABELA DE RECEITA', 1, 653, '', 60, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15195, 883, 'receita_1_codigo', 'CODIGO DA RECEITA', 1, 713, '', 8, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15196, 883, 'receita_1_descricao', 'DESCRICAO DA RECEITA', 1, 721, '', 17, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15197, 883, 'receita_1_parcela', 'PARCELA DA RECEITA', 1, 738, '', 9, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15198, 883, 'receita_1_valor', 'VALOR DO DEBITO', 1, 747, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15199, 883, 'receita_1_numpre', 'NUMPRE RECEITA', 1, 759, '', 14, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15200, 883, 'receita_2_codigo', 'CODIGO DA RECEITA', 1, 773, '', 8, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15201, 883, 'receita_2_descricao', 'DESCRICAO DA RECEITA', 1, 781, '', 17, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15202, 883, 'receita_2_parcela', 'PARCELA DA RECEITA', 1, 798, '', 9, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15203, 883, 'receita_2_valor', 'VALOR DO DEBITO', 1, 807, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15204, 883, 'receita_2_numpre', 'NUMPRE DA RECEITA', 1, 819, '', 14, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15205, 883, 'receita_3_codigo', 'CODIGO DA RECEITA', 1, 833, '', 8, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15206, 883, 'receita_3_descricao', 'DESCRICAO DA RECEITA', 1, 841, '', 17, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15207, 883, 'receita_3_parcela', 'PARCELA DA RECEITA', 1, 858, '', 9, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15208, 883, 'receita_3_valor', 'VALOR DO DEBITO', 1, 867, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15209, 883, 'receita_3_numpre', 'NUMPRE DA RECEITA', 1, 879, '', 14, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15210, 883, 'receita_4_codigo', 'CODIGO DA RECEITA', 1, 893, '', 8, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15211, 883, 'receita_4_descricao', 'DESCRICAO DA RECEITA', 1, 901, '', 17, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15212, 883, 'receita_4_parcela', 'PARCELA DA RECEITA', 1, 918, '', 9, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15213, 883, 'receita_4_valor', 'VALOR DO DEBITO', 1, 927, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15214, 883, 'receita_4_numpre', 'NUMPRE DA RECEITA', 1, 939, '', 14, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15215, 883, 'titulo_receita_2', 'TITULO DA TABELA DE RECEITA', 1, 953, '', 60, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15216, 883, 'receita_5_codigo', 'CODIGO DA RECEITA', 1, 1013, '', 8, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15217, 883, 'receita_5_descricao', 'DESCRICAO DA RECEITA', 1, 1021, '', 17, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15218, 883, 'receita_5_parcela', 'PARCELA DA RECEITA', 1, 1038, '', 9, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15219, 883, 'receita_5_valor', 'VALOR DO DEBITO', 1, 1047, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15220, 883, 'receita_5_numpre', 'NUMPRE DA RECEITA', 1, 1059, '', 14, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15221, 883, 'receita_6_codigo', 'CODIGO DA RECEITA', 1, 1073, '', 8, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15222, 883, 'receita_6_descricao', 'DESCRICAO DA RECEITA', 1, 1081, '', 17, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15223, 883, 'receita_6_parcela', 'PARCELA DA RECEITA', 1, 1098, '', 9, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15224, 883, 'receita_6_valor', 'VALOR DO DEBITO', 1, 1107, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15225, 883, 'receita_6_numpre', 'NUMPRE DA RECEITA', 1, 1119, '', 14, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15226, 883, 'receita_7_codigo', 'CODIGO DA RECEITA', 1, 1133, '', 8, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15227, 883, 'receita_7_descricao', 'DESCRICAO DA RECEITA', 1, 1141, '', 17, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15228, 883, 'receita_7_parcela', 'PARCELA DA RECEITA', 1, 1158, '', 9, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15229, 883, 'receita_7_valor', 'VALOR DO DEBITO', 1, 1167, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15230, 883, 'receita_7_numpre', 'NUMPRE DA RECEITA', 1, 1179, '', 14, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15231, 883, 'receita_8_codigo', 'CODIGO DA RECEITA', 1, 1193, '', 8, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15232, 883, 'receita_8_descricao', 'DESCRICAO DA RECEITA', 1, 1201, '', 17, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15233, 883, 'receita_8_parcela', 'PARCELA DA RECEITA', 1, 1218, '', 9, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15234, 883, 'receita_8_valor', 'VALOR DO DEBITO', 1, 1227, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15235, 883, 'receita_8_numpre', 'NUMPRE DA RECEITA', 1, 1239, '', 14, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15236, 883, 'aviso1', 'AVISO', 1, 1253, '', 70, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15237, 883, 'aviso2', 'AVISO', 1, 1323, '', 70, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15238, 883, 'aviso3', 'AVISO', 1, 1393, '', 70, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15239, 883, 'aviso4', 'AVISO', 1, 1463, '', 70, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15240, 883, 'aviso5', 'AVISO', 1, 1533, '', 70, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15241, 883, 'aviso6', 'AVISO', 1, 1603, '', 453, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15242, 883, 'msg1', 'MENSAGEM', 1, 2056, '', 70, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15243, 883, 'msg2', 'MENSAGEM', 1, 2126, '', 70, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15244, 883, 'msg3', 'MENSAGEM', 1, 2196, '', 70, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15245, 883, 'msg4', 'MENSAGEM', 1, 2266, '', 70, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15246, 883, 'msg5', 'MENSAGEM', 1, 2336, '', 70, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15247, 883, 'msg6', 'MENSAGEM', 1, 2406, '', 70, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15248, 883, 'imprime_conta', 'IMPRIMIR CONTA', 1, 2476, '', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15249, 883, 'codigo_coletor', 'CODIGO DO COLETOR', 1, 2478, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15250, 883, 'aviso_leiturista', 'AVISO LEITURISTA', 1, 2481, '', 200, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15098, 883, 'codigo', 'CODIGO DA LEITURA', 1, 1, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15099, 883, 'codigo_leiturista', 'CODIGO DO LEITURISTA', 1, 11, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15100, 883, 'codigo_rota', 'CODIGO DA ROTA', 1, 21, '', 10, false, true, 'e', '', 0 );
$$);

-- aguacoletorexportadadoscontrato
select fc_executa_ddl($$
  insert into db_sysarquivo values (3992, 'aguacoletorexportadadoscontrato', 'Dados do contrato.', 'x57', '2016-11-22', 'Dados do Contrato Exportação Coletores', 0, 'f', 'f', 'f', 'f' );
  insert into db_sysarqmod values (43,3992);

  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22171 ,'x57_sequencial' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' );
  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3992 ,22171 ,1 ,0 );

  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22173 ,'x57_aguacontrato' ,'int4' ,'Contrato' ,'' ,'Contrato' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Contrato' );
  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3992 ,22173 ,3 ,0 );

  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22174 ,'x57_aguacategoriaconsumo' ,'int4' ,'Categoria de Consumo' ,'' ,'Categoria de Consumo' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Categoria de Consumo' );
  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3992 ,22174 ,4 ,0 );

  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22175 ,'x57_aguaisencaocgm' ,'int4' ,'Isenção' ,'' ,'Isenção' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Isenção' );
  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3992 ,22175 ,5 ,0 );

  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22176 ,'x57_aguacoletorexportadados' ,'int4' ,'Matrícula Exportada' ,'' ,'Matrícula Exportada' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Matrícula Exportada' );
  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3992 ,22176 ,6 ,0 );

  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22211 ,'x57_cgm' ,'int4' ,'CGM' ,'' ,'Nome/Razão Social' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Nome/Razão Social' );
  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3992 ,22211 ,6 ,0 );

  insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3992,22171,1,22171);

  insert into db_sysforkey values(3992,22173,1,3966,0);
  insert into db_sysforkey values(3992,22175,1,3977,0);
  insert into db_sysforkey values(3992,22174,1,3969,0);
  insert into db_sysforkey values(3992,22176,1,2703,0);
  insert into db_sysforkey values(3992,22211,1,42,0);

  insert into db_syssequencia values(1000621, 'aguacoletorexportadadoscontrato_x57_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
  update db_sysarqcamp set codsequencia = 1000621 where codarq = 3992 and codcam = 22171;

  -- aguacoletorexporta
  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22178 ,'x49_db_layouttxt' ,'int4' ,'Layout do arquivo.' ,'' ,'Layout' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Layout' );
  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 2701 ,22178 ,7 ,0 );
  insert into db_sysforkey values(2701,22178,1,1553,0);

  -- Layout de importação
  insert into db_layouttxt values (276, 'IMPORTAÇÃO', 1, '', 7 );
  insert into db_layoutlinha values (888, 276, 'REGISTRO', 3, 454, 0, 0, '', '', false );
  insert into db_layoutcampos values (15289, 888, 'codigo_exportacao', 'CÓDIGO DA LEITURA', 1, 1, '', 8, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15290, 888, 'codigo_rota', 'CÓDIGO DA ROTA', 1, 9, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15291, 888, 'codigo_leiturista', 'CÓDIGO DO LEITURISTA', 1, 19, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15292, 888, 'codigo_contrato', 'CÓDIGO DO CONTRATO', 1, 29, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15293, 888, 'codigo_matricula', 'CÓDIGO DA MATRÍCULA', 1, 39, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15294, 888, 'numero_hidrometro', 'NÚMERO DO HIDRÔMETRO', 1, 49, '', 20, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15295, 888, 'data_leitura_atual', 'DATA DA LEITURAL ATUAL', 1, 69, '', 10, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15296, 888, 'data_leitura_anterior', 'DATA DA LEITURA ANTERIOR', 1, 79, '', 10, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15297, 888, 'consumo_atual', 'CONSUMO ATUAL', 1, 89, '', 8, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15298, 888, 'dias_entre_leituras', 'DIAS ENTRE LEITURAS', 1, 97, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15299, 888, 'media_consumo_dia', 'MÉDIA DE CONSUMO AO DIA', 1, 101, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15300, 888, 'data_vencimento', 'DATA DE VENCIMENTO', 1, 111, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15301, 888, 'valor_desconto', 'VALOR DE DESCONTO', 1, 121, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15302, 888, 'valor_total', 'VALOR TOTAL', 1, 133, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15303, 888, 'valor_agua', 'VALOR DE ÁGUA', 1, 145, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15304, 888, 'valor_esgoto', 'VALOR DE ESGOTO', 1, 157, '', 12, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15305, 888, 'mes_leitura', 'MÊS DA LEITURA', 1, 169, '', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15306, 888, 'situacao_leitura', 'SITUAÇÃO DA LEITURA', 1, 171, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15307, 888, 'leitura', 'LEITURA', 1, 174, '', 10, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15308, 888, 'consumo', 'CONSUMO', 1, 184, '', 8, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15309, 888, 'ultimo_dia_leitura', 'DIA DA ÚLTIMA LEITURA', 1, 192, '', 10, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15310, 888, 'conta_emitida', 'CONTA EMITIDA?', 1, 202, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15311, 888, 'observacao_leiturista', 'OBSERVAÇÃO DO LEITURISTA', 1, 203, '', 70, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15312, 888, 'linha_digitavel', 'LINHA DIGITÁVEL', 1, 273, '', 70, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15314, 888, 'codigo_barras', 'CÓDIGO DE BARRAS', 1, 343, '', 70, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15315, 888, 'leitura_coletada', 'LEITURA COLETADA', 1, 413, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15316, 888, 'hidrometro_virou', 'HIDRÔMETRO VIROU', 1, 414, '', 1, false, true, 'd', '', 0 );
$$);

-- Menu do relatório de taxas
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente )
     select 10337 ,'Taxas' ,'Taxas' ,'fis2_taxadiversos001.php' ,'1' ,'1' ,'Relatório referente as taxas lançadas.' ,'true'
      where not exists (select 1 from db_itensmenu where id_item = 10337);
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo )
     select 30 ,10337 ,459 ,277
      where not exists(select 1 from db_menu where id_item = 30 and id_item_filho = 10337);

-- EMISSÃO GERAL

select fc_executa_ddl($$
  insert into db_sysarquivo values (3986, 'emissaogeral', 'Tabela que registra as informações das Emissões Gerais do Sistema', 'tr01', '2016-11-04', 'Emissao Geral', 0, 'f', 'f', 'f', 'f' );
  insert into db_sysarqmod values (46,3986);
  insert into db_sysarquivo values (3987, 'emissaogeralregistro', 'Tabela que salva as informações dos registros gerados nas Emissões Gerais no Sistema', 'tr02', '2016-11-04', 'Emissao Geral Registro', 0, 'f', 'f', 'f', 'f' );
  insert into db_sysarqmod values (46,3987);
  insert into db_sysarquivo values (3988, 'emissaogeralmatricula', 'Tabela que vincula os registros das Emissões Gerais do Sistemas com as suas matrículas, quando necessário.', 'tr03', '2016-11-04', 'Emissao Geral Matrícula', 0, 'f', 'f', 'f', 'f' );
  insert into db_sysarqmod values (46,3988);
  insert into db_sysarquivo values (3989, 'emissaogeralinscricao', 'Tabela que vincula os registros das Emissões Gerais do Sistemas com as suas inscrições, quando necessário.', 'tr04', '2016-11-04', 'Emissão Geral Inscrição', 0, 'f', 'f', 'f', 'f' );
  insert into db_sysarqmod values (46,3989);
  insert into db_syscampo values(22126,'tr01_sequencial','int4','Código Sequencial da Emissão Geral','0', 'Código da Emissão Geral',10,'f','f','f',1,'text','Código da Emissão Geral');
  insert into db_syscampo values(22127,'tr01_data','date','Data da Emissão da Emissão Geral','null', 'Data Emissão',10,'f','f','f',1,'text','Data Emissão');
  insert into db_syscampo values(22128,'tr01_usuario','int4','Usuário que processou a Emissão Geral','0', 'Usuário',10,'f','f','f',1,'text','Usuário');
  insert into db_syscampo values(22129,'tr01_tipoemissao','int4','Tipo de Emissão Geral','0', 'Tipo de Emissão',2,'f','f','f',1,'text','Tipo de Emissão');
  insert into db_syscampo values(22130,'tr01_instit','int4','Instituição','0', 'Instituição',10,'f','f','f',1,'text','Instituição');
  insert into db_syscampo values(22131,'tr01_convenio','int4','Convênio da Emissão Geral','0', 'Convênio',10,'t','f','f',1,'text','Convênio');
  insert into db_syscampo values(22132,'tr01_hora','char(5)','Hora da Emissão Geral','', 'Hora da Emissão',5,'f','t','f',0,'text','Hora da Emissão');
  insert into db_syscampo values(22160,'tr01_parametros','text','Parâmetros','','Parâmetros' ,1 ,'true' ,'false' ,'false' ,0 ,'text' ,'Parâmetros');
  insert into db_syscampo values(22133,'tr02_sequencial','int4','Código do Registro Emissão Geral','0', 'Código do Registro',10,'f','f','f',1,'text','Código do Registro');
  insert into db_syscampo values(22134,'tr02_emissaogeral','int4','Código da Emissão Geral','0', 'Código da Emissão Geral',10,'f','f','f',1,'text','Código da Emissão Geral');
  insert into db_syscampo values(22135,'tr02_numcgm','int4','CGM vinculado ao registro da Emissão Geral','0', 'CGM',10,'f','f','f',1,'text','CGM');
  insert into db_syscampo values(22136,'tr02_numpre','int4','Numpre do registro','0', 'Numpre',8,'f','f','f',1,'text','Numpre');
  insert into db_syscampo values(22138,'tr02_parcela','int4','Parcela do registro gerado na Emissão Geral','0', 'Parcela',10,'f','f','f',1,'text','Parcela');
  insert into db_syscampo values(22139,'tr02_situacao','int4','Situação do registro em relação a Emissão Geral(vide regra de Negócio da Emissão Geral a que se refere).','0', 'Situação',2,'f','f','f',1,'text','Situação');
  insert into db_syscampo values(22140,'tr03_sequencial','int4','Código do Registro da Emissão Geral','0', 'Código do Registro',10,'f','f','f',1,'text','Código do Registro');
  insert into db_syscampo values(22141,'tr03_emissaogeral','int4','Código da Emissão Geral','0', 'Código da Emissão Geral',10,'f','f','f',1,'text','Código da Emissão Geral');
  insert into db_syscampo values(22142,'tr03_emissaogeralregistro','int4','Código do Registro','0', 'Código do Registro',10,'f','f','f',1,'text','Código do Registro');
  insert into db_syscampo values(22143,'tr03_matric','int4','Matrícula vinculada ao registro','0', 'Matrícula',10,'f','f','f',1,'text','Matrícula');
  insert into db_syscampo values(22144,'tr04_sequencial','int4','Código Sequencial da tabela de vínculo do Registro com a Inscrição','0', 'Código Sequencial',10,'f','f','f',1,'text','Código Sequencial');
  insert into db_syscampo values(22145,'tr04_emissaogeralregistro','int4','Código da Emissão Geral','0', 'Código da Emissão Geral',10,'f','f','f',1,'text','Código da Emissão Geral');
  insert into db_syscampo values(22146,'tr04_inscr','int4','Inscrição vinculada ao Registro','0', 'Inscrição',10,'f','f','f',1,'text','Inscrição');
  insert into db_sysarqcamp values(3986,22126,1,0);
  insert into db_sysarqcamp values(3986,22127,2,0);
  insert into db_sysarqcamp values(3986,22128,3,0);
  insert into db_sysarqcamp values(3986,22129,4,0);
  insert into db_sysarqcamp values(3986,22130,5,0);
  insert into db_sysarqcamp values(3986,22131,6,0);
  insert into db_sysarqcamp values(3986,22132,7,0);
  insert into db_sysarqcamp values(3986,22160,8,0);
  insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3986,22126,1,22126);
  insert into db_sysarqcamp values(3987,22133,1,0);
  insert into db_sysarqcamp values(3987,22134,2,0);
  insert into db_sysarqcamp values(3987,22135,3,0);
  insert into db_sysarqcamp values(3987,22136,4,0);
  insert into db_sysarqcamp values(3987,22138,5,0);
  insert into db_sysarqcamp values(3987,22139,6,0);
  insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3987,22133,1,22134);
  insert into db_sysforkey values(3986,22128,1,109,0);
  insert into db_sysforkey values(3986,22130,1,83,0);
  insert into db_sysforkey values(3986,22131,1,2185,0);
  insert into db_syssequencia values(1000615, 'emissaogeral_tr01_sequencial_seq', 1, 1, 9223372036854775807, 1, 1 );
  update db_sysarqcamp set codsequencia = 1000615 where codarq = 3986 and codcam = 22126;
  insert into db_syssequencia values(1000616, 'emissaogeralregistro_tr02_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
  update db_sysarqcamp set codsequencia = 1000616 where codarq = 3987 and codcam = 22133;
  insert into db_sysforkey values(3987,22134,1,3986,0);
  insert into db_sysforkey values(3987,22135,1,42,0);
  insert into db_sysarqcamp values(3988,22140,1,0);
  insert into db_sysarqcamp values(3988,22142,2,0);
  insert into db_sysarqcamp values(3988,22143,3,0);
  insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3988,22140,1,22143);
  insert into db_sysforkey values(3988,22142,1,3987,0);
  insert into db_sysforkey values(3988,22143,1,27,0);
  insert into db_syssequencia values(1000617, 'emissaogeralmatricula_tr03_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
  update db_sysarqcamp set codsequencia = 1000617 where codarq = 3988 and codcam = 22140;
  insert into db_sysarqcamp values(3989,22144,1,0);
  insert into db_sysarqcamp values(3989,22145,2,0);
  insert into db_sysarqcamp values(3989,22146,3,0);
  insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3989,22144,1,22146);
  insert into db_sysforkey values(3989,22145,1,3987,0);
  insert into db_sysforkey values(3989,22146,1,41,0);
  insert into db_syssequencia values(1000618, 'emissaogeralinscricao_tr04_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
  update db_sysarqcamp set codsequencia = 1000618 where codarq = 3989 and codcam = 22144;
$$);

select fc_executa_ddl($$
  insert into db_sysarquivo values (3991, 'emissaogeralparcelaunica', 'Parcela Única usada na emissão geral', 'tr05', '2016-11-16', 'Parcela Única', 0, 'f', 'f', 'f', 'f' );
  insert into db_sysarqmod values (46,3991);
  insert into db_syscampo values(22155,'tr05_sequencial','int4','Código sequencial do vínculo entre Parcela Única e Emissão geral','0', 'Parcela Única',10,'f','f','f',1,'text','Parcela Única');
  insert into db_syscampo values(22156,'tr05_emissaogeral','int4','Código da Emissão Geral','0', 'Emissão Geral',10,'f','f','f',1,'text','Emissão Geral');
  insert into db_syscampo values(22157,'tr05_dataoperacao','date','Data de Operação da Parcela única','null', 'Data de Operação',10,'f','f','f',0,'text','Data de Operação');
  insert into db_syscampo values(22158,'tr05_datavencimento','date','Data de Vencimento da Parcela Única','null', 'Data de Vencimento',10,'f','f','f',1,'text','Data de Vencimento');
  insert into db_syscampo values(22159,'tr05_percentual','int4','Percentual de desconto da Parcela Única usada na Emissão Geral','0', 'Percentual',10,'f','f','f',1,'text','Percentual');
  delete from db_sysarqcamp where codarq = 3991;
  insert into db_sysarqcamp values(3991,22155,1,0);
  insert into db_sysarqcamp values(3991,22156,2,0);
  insert into db_sysarqcamp values(3991,22157,3,0);
  insert into db_sysarqcamp values(3991,22158,4,0);
  insert into db_sysarqcamp values(3991,22159,5,0);
  insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3991,22155,1,22155);
  insert into db_syssequencia values(1000620, 'emissaogeralparcelaunica_tr05_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
  update db_sysarqcamp set codsequencia = 1000620 where codarq = 3991 and codcam = 22155;
  delete from db_sysforkey where codarq = 3991 and referen = 0;
  insert into db_sysforkey values(3991,22156,1,3986,0);

  insert into db_syscampo values(22164,'k00_nossonumero','varchar(20)','Nosso Número','0', 'Nosso Número',10,'t','f','f',0,'text','Nosso Número');
  delete from db_sysarqcamp where codarq = 1575;
  insert into db_sysarqcamp values(1575,361,1,0);
  insert into db_sysarqcamp values(1575,9206,2,0);
  insert into db_sysarqcamp values(1575,9207,3,0);
  insert into db_sysarqcamp values(1575,22164,4,0);

  insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10336 ,'Emissão Geral de IPTU' ,'Emissão Geral de IPTU' ,'cad4_emiteiptuNovo.php' ,'1' ,'1' ,'Emissão Geral de IPTU' ,'true' );
  insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 32 ,10336 ,475 ,578 );
  update db_itensmenu set id_item = 1576 , descricao = 'Emissão Geral de IPTU' , help = 'Emissão Geral de IPTU' , funcao = 'cad4_emiteiptu.php' , itemativo = '1' , manutencao = '1' , desctec = 'Gera layout dos carnes de iptu.' , libcliente = 'false' where id_item = 1576;
$$);

select fc_executa_ddl($$
  insert into db_layoutlinha values (889, 263, 'SEGMENTO T', 3, 240, 0, 0, '', '', false );
  insert into db_layoutcampos values (15317, 889, 'banco', 'CÓDIGO DO BANCO NA COMPENSAÇÃO', 2, 1, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15318, 889, 'lote_servico', 'LOTE DE SERVIÇO', 2, 4, '', 4, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15319, 889, 'tipo_registro', 'TIPO DE REGISTRO', 1, 8, '3', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15320, 889, 'sequencial', 'NÚMERO SEQUÊNCIAL DO REGISTRO NO LOTE', 2, 9, '', 5, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15321, 889, 'segmento', 'CÓDIGO SEGMENTO DO REGISTRO DETALHE', 1, 14, 'T', 1, true, true, 'd', '', 0 );
  insert into db_layoutcampos values (15322, 889, 'exclusivo_febraban', 'USO EXCLUSIVO FEBRABAN', 1, 15, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15323, 889, 'codigo_movimento', 'CÓDIGO MOVIMENTO RETORNO', 1, 16, '', 2, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15324, 889, 'codigo_agencia', 'CÓDIGO DA AGÊNCIA', 2, 18, '', 5, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15325, 889, 'dv_agencia', 'DÍGITO VERIFICADOR AGÊNCIA', 1, 23, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15326, 889, 'uso_exclusivo_banco', 'USO EXCLUSIVO DO BANCO', 1, 24, '', 34, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15327, 889, 'codigo_carteira', 'CÓDIGO DA CARTEIRA', 1, 58, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15328, 889, 'uso_exclusivo_banco_1', 'USO EXCLUSIVO DO BANCO', 1, 59, '', 15, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15329, 889, 'data_vencimento', 'DATA DE VENCIMENTO', 1, 74, '', 8, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15330, 889, 'valor', 'VALOR NOMINAL DO TÍTULO', 1, 82, '', 15, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15331, 889, 'codigo_banco', 'CÓDIGO DO BANCO', 2, 97, '', 3, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15332, 889, 'codigo_agencia_cobranca', 'CÓDIGO DA AGÊNCIA COBR/RECEB', 1, 100, '', 5, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15333, 889, 'dv_agencia_cobranca', 'DÍGITO VERIFICADOR DA AGÊNCIA DA COBR', 1, 105, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15334, 889, 'identificacao_titulo', 'IDENTIFICAÇÃO DO TÍTULO NA EMPRESA', 1, 106, '', 25, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15335, 889, 'codigo_moeda', 'CÓDIGO DA MOEDA', 2, 131, '', 2, false, true, 'e', '', 0 );
  insert into db_layoutcampos values (15336, 889, 'tipo_inscricao', 'TIPO DE INSCRIÇÃO DO SACADO', 1, 133, '', 1, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15337, 889, 'numero_inscricao', 'NÚMERO DE INSCRIÇÃO DO SACADO', 1, 134, '', 15, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15338, 889, 'nome', 'NOME DO SACADO', 1, 149, '', 40, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15339, 889, 'uso_exclusivo_febraban_1', 'USO EXCLUSIVO FEBRABAN', 1, 189, '', 10, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15340, 889, 'valor_tarifa', 'VALOR DAS TARIFAS/CUSTAS', 1, 199, '', 15, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15341, 889, 'motivo', 'MOTIVO DA OCORRÊNCIA', 1, 214, '', 10, false, true, 'd', '', 0 );
  insert into db_layoutcampos values (15342, 889, 'uso_exclusivo_febraban_2', 'USO EXCLUSIVO DA FEBRABAN', 1, 224, '', 17, false, true, 'd', '', 0 );
$$);

select fc_executa_ddl($$
  insert into db_sysarquivo
    values (3999, 'movimentoocorrenciacobrancaregistrada', 'Movimento da Ocorrência da Cobrança Registrada', 'k169', '2016-11-28', 'Movimento da Ocorrência da Cobrança Registrada', 0, 'f', 'f', 'f', 'f' );
  insert into db_sysarqmod values (5,3999);

  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
    values ( 22204 ,'k169_sequencial' ,'int4' ,'Sequencial' ,'' ,'Sequencial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Sequencial' ),
           ( 22205 ,'k169_codigo' ,'varchar(2)' ,'Código do Movimento' ,'' ,'Código do Movimento' ,2 ,'false' ,'true' ,'false' ,0 ,'text' ,'Código do Movimento' ),
           ( 22206 ,'k169_descricao' ,'varchar(500)' ,'Descrição' ,'' ,'Descrição' ,500 ,'false' ,'true' ,'false' ,0 ,'text' ,'Descrição' );

  insert into db_syssequencia values(1000627, 'movimentoocorrenciacobrancaregistrada_k169_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);

  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia )
    values ( 3999 ,22204 ,1 ,1000627 ),
           ( 3999 ,22205 ,2 ,0 ),
           ( 3999 ,22206 ,3 ,0 );

  insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3999,22204,1,22204);
$$);


select fc_executa_ddl($$
  insert into db_sysarquivo
    values (3997, 'ocorrenciacobrancaregistrada', 'Ocorrências do Retorno do Arquivo de Cobrança Registrada', 'k149', '2016-11-28', 'Ocorrência Cobranca Registrada', 0, 'f', 'f', 'f', 'f' );
  insert into db_sysarqmod values (5,3997);

  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
    values ( 22196 ,'k149_sequencial' ,'int4' ,'Sequencial' ,'' ,'Sequencial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Sequencial' ),
           ( 22197 ,'k149_banco' ,'varchar(10)' ,'Código do Banco' ,'' ,'Código do Banco' ,10 ,'false' ,'true' ,'false' ,0 ,'text' ,'Código do Banco' ),
           ( 22198 ,'k149_codigo' ,'varchar(2)' ,'Código da Ocorrência' ,'' ,'Código da Ocorrência' ,2 ,'false' ,'true' ,'false' ,0 ,'text' ,'Código da Ocorrência' ),
           ( 22199 ,'k149_descricao' ,'text' ,'Descrição' ,'' ,'Descrição da Ocorrência' ,1 ,'false' ,'false' ,'false' ,0 ,'text' ,'Descrição da Ocorrência' ),
           ( 22207 ,'k149_movimento' ,'int4' ,'Movimento' ,'' ,'Movimento' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Movimento' );

  insert into db_syssequencia values(1000625, 'ocorrenciacobrancaregistrada_k149_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);

  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia )
    values ( 3997 ,22196 ,1 ,1000625 ),
           ( 3997 ,22197 ,2 ,0 ),
           ( 3997 ,22198 ,3 ,0 ),
           ( 3997 ,22199 ,4 ,0 ),
           ( 3997 ,22207 ,5 ,0 );

  insert into db_sysprikey (codarq,codcam,sequen,camiden)
    values (3997,22196,1,22196);

  insert into db_sysforkey
    values (3997,22197,1,1185,0),
           (3997,22207,1,3999,0);
$$);

select fc_executa_ddl($$
  insert into db_sysarquivo
    values (3998, 'retornocobrancaregistrada', 'Retorno do Arquivo de Cobrança Registrada', 'k168', '2016-11-28', 'Retorno Cobrança Registrada', 0, 'f', 'f', 'f', 'f' );
  insert into db_sysarqmod values (5,3998);

  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
    values ( 22200 ,'k168_sequencial' ,'int4' ,'Sequencial' ,'' ,'Sequencial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Sequencial' ),
           ( 22201 ,'k168_numpre' ,'int4' ,'Numpre do Recibo' ,'' ,'Numpre' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Numpre' );

  insert into db_syssequencia values(1000626, 'retornocobrancaregistrada_k168_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);

  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia )
    values ( 3998 ,22200 ,1 ,1000626 ),
           ( 3998 ,22201 ,2 ,0 );

  insert into db_sysprikey (codarq,codcam,sequen,camiden)
    values (3998,22200,1,22200);
$$);

select fc_executa_ddl($$
  insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente )
    values ( 10338 ,'Retorno Cobrança Registrada' ,'Retorno Cobrança Registrada' ,'arr2_retornocobrancaregistrada001.php' ,'1' ,'1' ,'Relatório do retorno da cobrança registrada' ,'true' );
  insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo )
    values ( 30 ,10338 ,460 ,1985522 );
$$);

select fc_executa_ddl($$
  insert into db_sysarquivo
    values (4000, 'ocorrenciaretornocobrancaregistrada', 'Vínculo entre o retorno da cobrança registrada e a ocorrência', 'k170', '2016-11-29', 'Ocorrência Retorno Cobrança Registrada', 0, 'f', 'f', 'f', 'f' );
  insert into db_sysarqmod values (5,4000);

  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
    values ( 22208 ,'k170_sequencial' ,'int4' ,'Sequêncial' ,'' ,'Sequêncial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Sequêncial' ),
           ( 22209 ,'k170_retornocobrancaregistrada' ,'int4' ,'Retorno Cobrança Registrada' ,'' ,'Retorno Cobrança Registrada' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Retorno Cobrança Registrada' ),
           ( 22210 ,'k170_ocorrenciacobrancaregistrada' ,'int4' ,'Ocorrência Cobrança Registrada' ,'' ,'Ocorrência Cobrança Registrada' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Ocorrência Cobrança Registrada' );

  insert into db_syssequencia values(1000628, 'ocorrenciaretornocobrancaregistrada_k170_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);

  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia )
    values ( 4000 ,22208 ,1 ,1000628 ),
           ( 4000 ,22209 ,2 ,0 ),
           ( 4000 ,22210 ,3 ,0 );

  insert into db_sysprikey (codarq,codcam,sequen,camiden)
    values(4000,22208,1,22208);

  insert into db_sysforkey
    values (4000,22210,1,3997,0),
           (4000,22209,1,3998,0);
$$);

----
--Adicionando NOT NULL no campo dv14_data_calculo da tabela
----
UPDATE db_syscampo SET nulo = false WHERE codcam = 22094;
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
------------------------------------------ INICIO EDUCACAO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------


drop table if exists upx_db_sysarquivo;
drop table if exists upx_db_sysarqmod;
drop table if exists upx_db_sysprikey;
drop table if exists upx_db_sysforkey;
drop table if exists upx_db_syssequencia;
drop table if exists upx_db_sysindices;
drop table if exists upx_db_syscadind;
drop table if exists upx_db_syscampo;
drop table if exists upx_db_sysarqcamp;


create temporary table upx_db_sysarquivo   as select * from db_sysarquivo   limit 0;
create temporary table upx_db_sysarqmod    as select * from db_sysarqmod    limit 0;
create temporary table upx_db_sysprikey    as select * from db_sysprikey    limit 0;
create temporary table upx_db_sysforkey    as select * from db_sysforkey    limit 0;
create temporary table upx_db_syssequencia as select * from db_syssequencia limit 0;
create temporary table upx_db_sysindices   as select * from db_sysindices   limit 0;
create temporary table upx_db_syscadind    as select * from db_syscadind    limit 0;
create temporary table upx_db_syscampo as select * from db_syscampo limit 0;
create temporary table upx_db_sysarqcamp as select * from db_sysarqcamp limit 0;


insert into upx_db_sysarquivo values (3990, 'avaliacaoestruturanotapadrao', 'Configuração da Nota na secretaria de educação.', 'ed139', '2016-11-10', 'Configuração da Nota', 0, 'f', 'f', 'f', 'f' );
insert into upx_db_sysarqmod values (1008004,3990);

insert into upx_db_syscampo
values (22147,'ed40_desativado','bool','Se o procedimento de avaliação esta desativado.','f', 'Desativado',1,'f','f','f',5,'text','Desativado'),
       (22148,'ed139_sequencial','int4','Código','0', 'Código',10,'f','f','f',1,'text','Código'),
       (22149,'ed139_db_estrutura','int4','Estrutural da nota','0', 'Estrutural',10,'f','f','f',1,'text','Estrutural'),
       (22150,'ed139_ativo','bool','Se a configuração esta ativa.','f', 'Ativo',1,'f','f','f',5,'text','Ativo'),
       (22151,'ed139_arredondamedia','bool','Se deve arredondar a média.','f', 'Arredonda média',1,'f','f','f',5,'text','Arredonda média'),
       (22152,'ed139_regraarredondamento','int4','Se houver, usa a regra de arredondamento aplicada. ','0', 'Regra de arredondamento',10,'t','f','f',1,'text','Regra de arredondamento'),
       (22153,'ed139_observacao','varchar(300)','Observação','', 'Observação',300,'t','t','f',0,'text','Observação'),
       (22154,'ed139_ano','int4','Ano que a configuração é aplicada','0', 'Ano',10,'f','f','f',1,'text','Ano'),
       (22180,'ed47_municipioestrangeiro','varchar(255)','Município de um aluno estrangeiro.','', 'Localidade',255,'t','t','f',0,'text','Localidade');

insert into upx_db_sysarqcamp
values (1010074,22147,7,0),
       (3990,22148,1,0),
       (3990,22149,2,0),
       (3990,22150,3,0),
       (3990,22151,4,0),
       (3990,22152,5,0),
       (3990,22153,6,0),
       (3990,22154,7,0),
       (1010051,22180,72,0);

insert into upx_db_sysprikey values(3990,22148,1,22148);
insert into upx_db_sysforkey
values (3990,22149,1,898,0),
       (3990,22152,1,3368,0);

insert into upx_db_syssequencia values(1000619, 'avaliacaoestruturanotapadrao_ed139_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);

insert into upx_db_sysindices
values (4390,'avaliacaoestruturanotapadrao_db_estrutura_in',3990,'0'),
       (4391,'avaliacaoestruturanotapadrao_regraarredondamento_in',3990,'0'),
       (4392,'avaliacaoestruturanotapadrao_ano_in',3990,'0');


insert into upx_db_syscadind
values (4390,22149,1),
       (4391,22152,1),
       (4392,22154,1);

insert into db_sysarquivo
select * from upx_db_sysarquivo
 where not exists ( select 1 from db_sysarquivo where db_sysarquivo.codarq = upx_db_sysarquivo.codarq);

insert into db_sysarqmod
select * from upx_db_sysarqmod
 where not exists ( select 1 from db_sysarqmod where db_sysarqmod.codarq = upx_db_sysarqmod.codarq);

insert into db_syscampo
select * from upx_db_syscampo
 where not exists ( select 1 from db_syscampo where db_syscampo.codcam = upx_db_syscampo.codcam);

insert into db_sysarqcamp
  select * from upx_db_sysarqcamp
   where not exists ( select 1 from db_sysarqcamp where db_sysarqcamp.codcam = upx_db_sysarqcamp.codcam);

insert into db_sysprikey
select * from upx_db_sysprikey
 where not exists( select 1 from db_sysprikey where db_sysprikey.codarq = upx_db_sysprikey.codarq and db_sysprikey.codcam = upx_db_sysprikey.codcam);

insert into db_sysforkey
select * from upx_db_sysforkey
 where not exists( select 1 from db_sysforkey where db_sysforkey.codarq = upx_db_sysforkey.codarq and db_sysforkey.codcam = upx_db_sysforkey.codcam);

insert into db_syssequencia
select * from upx_db_syssequencia
 where not exists( select 1 from db_syssequencia where db_syssequencia.codsequencia = upx_db_syssequencia.codsequencia);

insert into db_sysindices
select * from upx_db_sysindices
 where not exists( select 1 from db_sysindices where db_sysindices.codind = upx_db_sysindices.codind);

insert into db_syscadind
select * from upx_db_syscadind
 where not exists( select 1 from db_syscadind where db_syscadind.codind = upx_db_syscadind.codind);

update db_sysarqcamp set codsequencia = 1000619 where codarq = 3990 and codcam = 22148;

drop table if exists upx_db_itensmenu;
drop table if exists upx_db_menu;

create temporary table upx_db_itensmenu as select * from db_itensmenu limit 0;
create temporary table upx_db_menu      as select * from db_menu limit 0;

insert into upx_db_itensmenu
values ( 10331 ,'Ativar / Desativar' ,'Ativar / Desativar Precedimento de avaliacao' ,'edu1_desativarprocedimento001.php' ,'1' ,'1' ,'Ativar / Desativar Precedimento de avaliacao' ,'true' ),
       ( 10332 ,'Configuração da Nota' ,'Configuração da Nota' ,'' ,'1' ,'1' ,'Configura o estrutural da nota' ,'true' ),
       ( 10333 ,'Inclusão' ,'Inclusão' ,'edu4_configuraestruturanota001.php?db_opcao=1' ,'1' ,'1' ,'Inclui a configuração da nota' ,'true' ),
       ( 10334 ,'Alteração' ,'Alteração' ,'edu4_configuraestruturanota001.php?db_opcao=2' ,'1' ,'1' ,'Altera a configuração da nota' ,'true' ),
       ( 10335 ,'Exclusão' ,'Exclusão' ,'edu4_configuraestruturanota001.php?db_opcao=3' ,'1' ,'1' ,'Exclui a configuração da nota' ,'true' );

insert into upx_db_menu
values ( 1100865 ,10331 ,4 ,1100747 ),
       ( 1100791 ,1100857 ,19 ,7159 ),
       ( 1100857 ,1100858 ,4 ,7159 ),
       ( 1100857 ,1100859 ,5 ,7159 ),
       ( 1100857 ,1100860 ,6 ,7159 ),
       ( 3470 ,1100865 ,43 ,7159 ),
       ( 1100865 ,1100866 ,5 ,7159 ),
       ( 1100865 ,1100867 ,6 ,7159 ),
       ( 9081 ,10332 ,4 ,7159 ),
       ( 10332 ,10333 ,1 ,7159 ),
       ( 10332 ,10334 ,2 ,7159 ),
       ( 10332 ,10335 ,3 ,7159 ),
       ( 1100865 ,10331 ,7 ,7159 );

insert into db_itensmenu
  select * from upx_db_itensmenu
   where not exists ( select 1 from db_itensmenu where db_itensmenu.id_item = upx_db_itensmenu.id_item);

insert into db_menu
  select * from upx_db_menu
   where not exists ( select 1 from db_menu
                       where db_menu.id_item       = upx_db_menu.id_item
                         and db_menu.id_item_filho = upx_db_menu.id_item_filho
                         and db_menu.modulo        = upx_db_menu.modulo
                    );

update db_syscampo set nulo = 't'  where codcam = 1009219;
delete from db_syscampodep where codcam = 1009219;
delete from db_syscampodef where codcam = 1009219;

---------------------------------------------------------------------------------------------------------------
-------------------------------------------- FIM EDUCACAO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
------------------------------------------ INICIO FOLHA ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

-- Atualização da tabela rhemitecontracheque
insert into db_syscampo select 22161,'rh85_liquido ','float8','Valor liquido do comprovante de pagamento','0', 'Valor Líquido',20,'t','f','f',4,'text','Valor Líquido'   where 22161 not in (select codcam from db_syscampo);
insert into db_syscampo select 22162,'rh85_desconto','float8','Valor total de desconto para o comprovante de pagamento','0', 'Valor Desconto',20,'t','f','f',4,'text','Valor Desconto' where 22162 not in (select codcam from db_syscampo);
insert into db_syscampo select 22163,'rh85_provento','float8','Valor total de proventos no comprovante de pagamento.','0', 'Total Provento',20,'t','f','f',4,'text','Total Provento'   where 22163 not in (select codcam from db_syscampo);

insert into db_sysarqcamp select 2563,22161,11,0 where 22161 not in (select codcam from db_sysarqcamp);
insert into db_sysarqcamp select 2563,22162,12,0 where 22162 not in (select codcam from db_sysarqcamp);
insert into db_sysarqcamp select 2563,22163,13,0 where 22163 not in (select codcam from db_sysarqcamp);


-- Atualização da tabela rhferiasconfiguracao
update db_sysarquivo set nomearq = 'rhferiasconfiguracao', descricao = 'Tabela com as configurações de assentamentos e período aquisitivo para as férias do RH', sigla = 'rh168', dataincl = '2016-11-24', rotulo = 'Tabela de configuração para Férias', tipotabela = 0, naolibclass = 'f', naolibfunc = 'f', naolibprog = 'f', naolibform = 'f' where codarq = 3872;
insert into db_syscampo select 22179,'rh168_ultimoperiodoaquisitivo','bool','Informa se no cadastro de férias será exibido apenas o último período aquisitivo ou os períodos ainda com algum saldo a ser pago.','f', 'Último Período Aquisitivo',1,'f','f','f',5,'text','Último Período Aquisitivo' where not exists (select 1 from db_syscampo where codcam = 22179);
insert into db_sysarqcamp select 3872,22179,4,0 where not exists (select 1 from db_sysarqcamp where codcam = 22179);


-- Atualizaçõa do nome do menu.
update db_itensmenu set descricao = 'Configurações de Férias' where id_item = '10156';

---------------------------------------------------------------------------------------------------------------
-------------------------------------------- FIM FOLHA -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
