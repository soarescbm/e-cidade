-- Licitacon - LOTE
insert into db_layouttxt values (240, 'TCE/RS - LICITACON - LOTE', 0, '', 6 );

insert into db_layoutlinha values (808, 240, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (12942, 808, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12943, 808, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12944, 808, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12945, 808, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12946, 808, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12947, 808, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );

insert into db_layoutlinha values (809, 240, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (12948, 809, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12949, 809, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12950, 809, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12951, 809, 'NR_LOTE', 'NR_LOTE', 1, 28, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12952, 809, 'DS_LOTE', 'DS_LOTE', 13, 38, '', 500, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12953, 809, 'VL_ESTIMADO', 'VL_ESTIMADO', 1, 538, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12954, 809, 'VL_HOMOLOGADO', 'VL_HOMOLOGADO', 1, 554, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12955, 809, 'TP_RESULTADO_LOTE', 'TP_RESULTADO_LOTE', 1, 570, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12956, 809, 'TP_DOCUMENTO_VENCEDOR', 'TP_DOCUMENTO_VENCEDOR', 1, 571, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12957, 809, 'NR_DOCUMENTO_VENCEDOR', 'NR_DOCUMENTO_VENCEDOR', 1, 572, '', 14, false, true, 'd', '', 0 );

-- ITEM
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21766 ,'m61_codigotribunal' ,'varchar(5)' ,'Código do Tribunal' ,'' ,'Código do Tribunal' ,5 ,'true' ,'false' ,'false' ,0 ,'text' ,'Código do Tribunal' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 1017 ,21766 ,6 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21769 ,'pc23_bdi' ,'float4' ,'BDI Estimado' ,'0' ,'BDI Estimado' ,6 ,'true' ,'false' ,'false' ,4 ,'text' ,'BDI Estimado' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 863 ,21769 ,9 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21770 ,'pc23_encargossociais' ,'float4' ,'Encargos Sociais Estimado' ,'0' ,'Encargos Sociais Estimado' ,7 ,'true' ,'false' ,'false' ,4 ,'text' ,'Encargos Sociais Estimado' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 863 ,21770 ,10 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21784 ,'pc23_data' ,'date' ,'Data da Proposta' ,'' ,'Data da Proposta' ,10 ,'true' ,'false' ,'false' ,0 ,'text' ,'Data da Proposta' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 863 ,21784 ,11 ,0 );

-- Licitacon - ITEM
insert into db_layouttxt values (241, 'TCE/RS - LICITACON - ITEM', 0, '', 6 );

insert into db_layoutlinha values (810, 241, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true);
insert into db_layoutlinha values (811, 241, 'REGISTRO', 3, 0, 0, 0, '', '|', true );

insert into db_layoutcampos values (12958, 810, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12959, 810, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12960, 810, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12961, 810, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12962, 810, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12963, 810, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12964, 811, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12965, 811, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12966, 811, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12967, 811, 'NR_LOTE', 'NR_LOTE', 1, 28, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12968, 811, 'NR_ITEM', 'NR_ITEM', 1, 38, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12969, 811, 'NR_ITEM_ORIGINAL', 'NR_ITEM_ORIGINAL', 1, 48, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12970, 811, 'DS_ITEM', 'DS_ITEM', 13, 68, '', 300, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12971, 811, 'QT_ITENS', 'QT_ITENS', 1, 368, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12972, 811, 'SG_UNIDADE_MEDIDA', 'SG_UNIDADE_MEDIDA', 1, 380, '', 5, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12973, 811, 'VL_UNITARIO_ESTIMADO', 'VL_UNITARIO_ESTIMADO', 1, 385, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12974, 811, 'VL_TOTAL_ESTIMADO', 'VL_TOTAL_ESTIMADO', 1, 401, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12975, 811, 'DT_REF_VALOR_ESTIMADO', 'DT_REF_VALOR_ESTIMADO', 1, 417, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12976, 811, 'PC_BDI_ESTIMADO', 'PC_BDI_ESTIMADO', 1, 427, '', 6, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12977, 811, 'PC_ENCARGOS_SOCIAIS_ESTIMADO', 'PC_ENCARGOS_SOCIAIS_ESTIMADO', 1, 433, '', 7, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12978, 811, 'CD_FONTE_REFERENCIA', 'CD_FONTE_REFERENCIA', 1, 440, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12979, 811, 'DS_FONTE_REFERENCIA', 'DS_FONTE_REFERENCIA', 13, 460, '', 60, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12980, 811, 'TP_RESULTADO_ITEM', 'TP_RESULTADO_ITEM', 1, 520, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12981, 811, 'VL_UNITARIO_HOMOLOGADO', 'VL_UNITARIO_HOMOLOGADO', 1, 521, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12982, 811, 'VL_TOTAL_HOMOLOGADO', 'VL_TOTAL_HOMOLOGADO', 1, 537, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12983, 811, 'PC_BDI_HOMOLOGADO', 'PC_BDI_HOMOLOGADO', 1, 553, '', 6, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12984, 811, 'PC_ENCARGOS_SOCIAIS_HOMOLOGADO', 'PC_ENCARGOS_SOCIAIS_HOMOLOGADO', 1, 559, '', 6, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12985, 811, 'TP_ORCAMENTO', 'TP_ORCAMENTO', 1, 565, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12986, 811, 'CD_TIPO_FAMILIA', 'CD_TIPO_FAMILIA', 1, 566, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12988, 811, 'TP_DOCUMENTO_VENCEDOR', 'TP_DOCUMENTO_VENCEDOR', 1, 572, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12987, 811, 'CD_TIPO_SUBFAMILIA', 'CD_TIPO_SUBFAMILIA', 1, 569, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12989, 811, 'NR_DOCUMENTO_VENCEDOR', 'NR_DOCUMENTO_VENCEDOR', 1, 573, '', 14, false, true, 'd', '', 0 );

-- LOTE PROPOSTAS - LICITACON
insert into db_layouttxt values (242, 'TCE/RS - LICITACON - LOTE PROPOSTAS', 0, '', 6 );
insert into db_layoutlinha values (813, 242, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true );
insert into db_layoutlinha values (814, 242, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (12990, 813, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12991, 813, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12992, 813, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12993, 813, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12994, 813, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12995, 813, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12996, 814, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12997, 814, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12998, 814, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (12999, 814, 'TP_DOCUMENTO_LICITANTE', 'TP_DOCUMENTO_LICITANTE', 1, 28, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13000, 814, 'NR_DOCUMENTO_LICITANTE', 'NR_DOCUMENTO_LICITANTE', 1, 29, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13001, 814, 'NR_LOTE', 'NR_LOTE', 1, 43, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13003, 814, 'VL_TOTAL_LOTE', 'VL_TOTAL_LOTE', 1, 59, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13005, 814, 'DT_HOMOLOGACAO', 'DT_HOMOLOGACAO', 1, 91, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13002, 814, 'PC_DESCONTO', 'PC_DESCONTO', 1, 53, '', 6, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13004, 814, 'VL_NOTA_TECNICA', 'VL_NOTA_TECNICA', 1, 75, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13006, 814, 'TP_RESULTADO_PROPOSTA', 'TP_RESULTADO_PROPOSTA', 1, 101, '', 1, false, true, 'd', '', 0 );

/* PROPOSTAS - LICITACON */
insert into db_layouttxt values (243, 'TCE/RS - LICITACON - PROPOSTAS', 0, '', 6 );
insert into db_layoutlinha values (815, 243, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true);
insert into db_layoutcampos values (13007, 815, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13008, 815, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13009, 815, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13010, 815, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13011, 815, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13012, 815, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutlinha values (816, 243, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (13013, 816, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13014, 816, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 1, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13015, 816, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 1, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13016, 816, 'TP_DOCUMENTO_LICITANTE', 'TP_DOCUMENTO_LICITANTE', 1, 1, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13017, 816, 'NR_DOCUMENTO_LICITANTE', 'NR_DOCUMENTO_LICITANTE', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13018, 816, 'DT_PROPOSTA', 'DT_PROPOSTA', 1, 1, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13019, 816, 'TP_RESULTADO_PROPOSTA', 'TP_RESULTADO_PROPOSTA', 1, 1, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13020, 816, 'VL_TOTAL_PROPOSTA', 'VL_TOTAL_PROPOSTA', 1, 1, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13021, 816, 'PC_DESCONTO', 'PC_DESCONTO', 1, 1, '', 6, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13022, 816, 'VL_NOTA_TECNICA', 'VL_NOTA_TECNICA', 1, 1, '', 8, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13023, 816, 'DT_HOMOLOGACAO', 'DT_HOMOLOGACAO', 1, 1, '', 10, false, true, 'd', '', 0 );

insert into db_syscampo values(21785,'pc23_notatecnica','float4','Valor da nota técnica informada para o LICITACON','0', 'Nota Técnica',8,'t','f','f',4,'text','Nota Técnica');
delete from db_sysarqcamp where codarq = 863;
insert into db_sysarqcamp values(863,6378,1,0);
insert into db_sysarqcamp values(863,5517,2,0);
insert into db_sysarqcamp values(863,5518,3,0);
insert into db_sysarqcamp values(863,6456,4,0);
insert into db_sysarqcamp values(863,6831,5,0);
insert into db_sysarqcamp values(863,7645,6,0);
insert into db_sysarqcamp values(863,9205,7,0);
insert into db_sysarqcamp values(863,20855,8,0);
insert into db_sysarqcamp values(863,21769,9,0);
insert into db_sysarqcamp values(863,21770,10,0);
insert into db_sysarqcamp values(863,21784,11,0);
insert into db_sysarqcamp values(863,21785,12,0);

update pctipocompratribunal set l44_sigla = 'CPC' where l44_sequencial = 54;
update pctipocompratribunal set l44_sigla = 'LEI' where l44_sequencial = 55;
update pctipocompratribunal set l44_sigla = 'MAI' where l44_sequencial = 56;

/* Itens de Menu - Reserva de Cotas / Tratamento Diferenciado */
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10215 ,'Reserva de Cotas' ,'Reserva de Cotas' ,'lic4_tratamentodiferenciado001.php' ,'1' ,'1' ,'Reserva de Cotas para ME/EPP' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1818 ,10215 ,115 ,381 );

/* Reorganização dos Itens de Menu - Procedimentos */
update db_menu set menusequencia = 1 where id_item = 1818 and modulo = 381 and id_item_filho = 4689;
update db_menu set menusequencia = 2 where id_item = 1818 and modulo = 381 and id_item_filho = 5478;
update db_menu set menusequencia = 3 where id_item = 1818 and modulo = 381 and id_item_filho = 4680;
update db_menu set menusequencia = 4 where id_item = 1818 and modulo = 381 and id_item_filho = 4685;
update db_menu set menusequencia = 5 where id_item = 1818 and modulo = 381 and id_item_filho = 10215;
update db_menu set menusequencia = 6 where id_item = 1818 and modulo = 381 and id_item_filho = 4686;
update db_menu set menusequencia = 7 where id_item = 1818 and modulo = 381 and id_item_filho = 10206;
update db_menu set menusequencia = 8 where id_item = 1818 and modulo = 381 and id_item_filho = 10209;
update db_menu set menusequencia = 9 where id_item = 1818 and modulo = 381 and id_item_filho = 9401;
update db_menu set menusequencia = 10 where id_item = 1818 and modulo = 381 and id_item_filho = 147886;
update db_menu set menusequencia = 11 where id_item = 1818 and modulo = 381 and id_item_filho = 4718;
update db_menu set menusequencia = 12 where id_item = 1818 and modulo = 381 and id_item_filho = 4719;
update db_menu set menusequencia = 13 where id_item = 1818 and modulo = 381 and id_item_filho = 8983;
update db_menu set menusequencia = 14 where id_item = 1818 and modulo = 381 and id_item_filho = 4750;
update db_menu set menusequencia = 15 where id_item = 1818 and modulo = 381 and id_item_filho = 5624;
update db_menu set menusequencia = 16 where id_item = 1818 and modulo = 381 and id_item_filho = 6813;
update db_menu set menusequencia = 17 where id_item = 1818 and modulo = 381 and id_item_filho = 7985;
update db_menu set menusequencia = 18 where id_item = 1818 and modulo = 381 and id_item_filho = 8056;
update db_menu set menusequencia = 19 where id_item = 1818 and modulo = 381 and id_item_filho = 8131;
update db_menu set menusequencia = 20 where id_item = 1818 and modulo = 381 and id_item_filho = 8602;
update db_menu set menusequencia = 21 where id_item = 1818 and modulo = 381 and id_item_filho = 10204;

/* Reorganização dos Itens de Menu - Procedimentos -> Licitação */
update db_menu set menusequencia = 1 where id_item = 4680 and modulo = 381 and id_item_filho = 4681;
update db_menu set menusequencia = 2 where id_item = 4680 and modulo = 381 and id_item_filho = 4682;
update db_menu set menusequencia = 3 where id_item = 4680 and modulo = 381 and id_item_filho = 4683;
update db_menu set menusequencia = 4 where id_item = 4680 and modulo = 381 and id_item_filho = 147887;
update db_menu set menusequencia = 5 where id_item = 4680 and modulo = 381 and id_item_filho = 228030;
update db_menu set menusequencia = 6 where id_item = 4680 and modulo = 381 and id_item_filho = 9853;
update db_menu set menusequencia = 7 where id_item = 4680 and modulo = 381 and id_item_filho = 7318;
update db_menu set menusequencia = 8 where id_item = 4680 and modulo = 381 and id_item_filho = 289573;
update db_menu set menusequencia = 9 where id_item = 4680 and modulo = 381 and id_item_filho = 9360;
update db_menu set menusequencia = 10 where id_item = 4680 and modulo = 381 and id_item_filho = 10207;
update db_menu set menusequencia = 11 where id_item = 4680 and modulo = 381 and id_item_filho = 10208;

/* ITEM PROPOSTAS - LICITACON*/
insert into db_layouttxt values ( 244 ,'TCE/RS - LICITACON - ITEM PROPOSTAS' ,0 ,'',6  );
insert into db_layoutlinha values (817 ,244 ,'CABEÇALHO' ,1 ,0 ,0 ,0 ,'' ,'|' , true);
insert into db_layoutcampos values ( 13024 ,817 ,'CNPJ' ,'CNPJ' ,1 ,1 ,'' ,14 ,'false' ,'true' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13025 ,817 ,'DATA_INICIAL' ,'DATA_INICIAL' ,1 ,15 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13026 ,817 ,'DATA_FINAL' ,'DATA_FINAL' ,1 ,25 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13027 ,817 ,'DATA_GERACAO' ,'DATA_GERACAO' ,1 ,35 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13028 ,817 ,'NOME_SETOR' ,'NOME_SETOR' ,1 ,45 ,'' ,150 ,'false' ,'true' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13029 ,817 ,'TOTAL_REGISTROS' ,'TOTAL_REGISTROS' ,1 ,195 ,'' ,15 ,'false' ,'true' ,'d' ,'' ,0 );

insert into db_layoutlinha values ( 819 ,244 ,'REGISTRO' ,3 ,0 ,0 ,0 ,'' ,'|' , true);
insert into db_layoutcampos values ( 13041 ,819 ,'NR_LICITACAO' ,'NR_LICITACAO' ,1 ,1 ,'' ,20 ,'false' ,'true' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13042 ,819 ,'ANO_LICITACAO' ,'ANO_LICITACAO' ,1 ,21 ,'' ,4 ,'false' ,'true' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13043 ,819 ,'CD_TIPO_MODALIDADE' ,'CD_TIPO_MODALIDADE' ,1 ,25 ,'' ,3 ,'false' ,'true' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13044 ,819 ,'TP_DOCUMENTO_LICITANTE' ,'TP_DOCUMENTO_LICITANTE' ,1 ,28 ,'' ,1 ,'false' ,'true' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13045 ,819 ,'NR_DOCUMENTO_LICITANTE' ,'NR_DOCUMENTO_LICITANTE' ,1 ,29 ,'' ,14 ,'false' ,'true' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13046 ,819 ,'NR_LOTE' ,'NR_LOTE' ,1 ,43 ,'' ,10 ,'false' ,'true' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13052 ,819 ,'NR_ITEM' ,'NR_ITEM' ,1 ,53 ,'' ,10 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13053 ,819 ,'PC_BDI' ,'PC_BDI' ,1 ,63 ,'' ,6 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13054 ,819 ,'PC_DESCONTO' ,'PC_DESCONTO' ,1 ,69 ,'' ,6 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13055 ,819 ,'PC_ENCARGOS_SOCIAIS' ,'PC_ENCARGOS_SOCIAIS' ,1 ,75 ,'' ,6 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13056 ,819 ,'VL_UNITARIO' ,'VL_UNITARIO' ,1 ,81 ,'' ,16 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13057 ,819 ,'VL_TOTAL_ITEM' ,'VL_TOTAL_ITEM' ,1 ,97 ,'' ,16 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13058 ,819 ,'VL_NOTA_TECNICA' ,'VL_NOTA_TECNICA' ,1 ,113 ,'' ,16 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13059 ,819 ,'DT_HOMOLOGACAO' ,'DT_HOMOLOGACAO' ,1 ,129 ,'' ,10 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutcampos values ( 13060 ,819 ,'TP_RESULTADO_PROPOSTA' ,'TP_RESULTADO_PROPOSTA' ,1 ,139 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 );

-- Tabela de Reserva de Cotas da Licitação
insert into db_sysarquivo values (3922, 'licitacaoreservacotas', 'Reserva de Cotas', 'l19', '2016-03-23', 'Reserva de Cotas', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (19, 3922);
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21786 ,'l19_sequencial' ,'int4' ,'Sequencial' ,'0' ,'Sequencial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Sequencial' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3922 ,21786 ,1 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21787 ,'l19_liclicitemorigem' ,'int4' ,'Item de Origem' ,'0' ,'Item de Origem' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Item de Origem' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3922 ,21787 ,2 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21788 ,'l19_liclicitemreserva' ,'int4' ,'Item Reservado' ,'' ,'Item Reservado' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Item Reservado' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3922 ,21788 ,3 ,0 );
insert into db_sysforkey values(3922,21787,1,1261,0);
insert into db_sysforkey values(3922,21788,1,1261,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3922,21786,1,21787);
insert into db_syssequencia values(1000557, 'licitacaoreservacotas_l19_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000557 where codarq = 3922 and codcam = 21786;
insert into db_sysindices values(4332,'licitacaoreservacotas_liclicitemorigem_in',3922,'0');
insert into db_syscadind values(4332,21787,1);
insert into db_sysindices values(4333,'licitacaoreservacotas_liclicitemreserva_in',3922,'0');
insert into db_syscadind values(4333,21788,1);

-- Layout alteração contratos
insert into db_layouttxt values (245, 'TCE/RS - LICITACON - ALTERACAO CONTRATOS', 0, '', 6 );
insert into db_layoutlinha values (820, 245, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true );
insert into db_layoutlinha values (821, 245, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (13061, 820, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13062, 820, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13063, 820, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13064, 820, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13065, 820, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13066, 820, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13067, 821, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13068, 821, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13069, 821, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13070, 821, 'NR_CONTRATO', 'NR_CONTRATO', 1, 28, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13071, 821, 'ANO_CONTRATO', 'ANO_CONTRATO', 1, 48, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13072, 821, 'TP_INSTRUMENTO', 'TP_INSTRUMENTO', 1, 52, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13073, 821, 'SQ_EVENTO', 'SQ_EVENTO', 1, 53, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13074, 821, 'CD_TIPO_OPERACAO', 'CD_TIPO_OPERACAO', 1, 63, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13075, 821, 'DS_OUTRA_OPERACAO', 'DS_OUTRA_OPERACAO', 1, 66, '', 60, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13076, 821, 'NR_DIAS_NOVO_PRAZO', 'NR_DIAS_NOVO_PRAZO', 1, 126, '', 5, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13077, 821, 'VL_ACRESCIMO', 'VL_ACRESCIMO', 1, 131, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13078, 821, 'VL_REDUCAO', 'VL_REDUCAO', 1, 147, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13079, 821, 'PC_ACRESCIMO', 'PC_ACRESCIMO', 1, 163, '', 6, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13080, 821, 'PC_REDUCAO', 'PC_REDUCAO', 1, 169, '', 6, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13081, 821, 'TP_REGIME_EXECUCAO_NOVO', 'TP_REGIME_EXECUCAO_NOVO', 1, 175, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13082, 821, 'TP_FORNECIMENTO_NOVO', 'TP_FORNECIMENTO_NOVO', 1, 176, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13083, 821, 'DS_JUSTIFICATIVA', 'DS_JUSTIFICATIVA', 1, 177, '', 200, false, true, 'd', '', 0 );

-- Layout item contratos
insert into db_layouttxt values (246, 'TCE/RS - LICITACON - ITEM CONTRATOS', 0, '', 6 );
insert into db_layoutlinha values (822, 246, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true );
insert into db_layoutlinha values (823, 246, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (13084, 822, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13085, 822, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13086, 822, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13087, 822, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13088, 822, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13089, 822, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13090, 823, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13091, 823, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13092, 823, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13093, 823, 'NR_CONTRATO', 'NR_CONTRATO', 1, 28, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13094, 823, 'ANO_CONTRATO', 'ANO_CONTRATO', 1, 48, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13095, 823, 'TP_INSTRUMENTO', 'TP_INSTRUMENTO', 1, 52, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13096, 823, 'NR_LOTE', 'NR_LOTE', 1, 53, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13097, 823, 'NR_ITEM', 'NR_ITEM', 1, 63, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13098, 823, 'QT_ITENS', 'QT_ITENS', 1, 73, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13099, 823, 'VL_ITEM', 'VL_ITEM', 1, 89, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13100, 823, 'VL_TOTAL_ITEM', 'VL_TOTAL_ITEM', 1, 105, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13101, 823, 'PC_BDI', 'PC_BDI', 1, 121, '', 6, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13102, 823, 'PC_ENCARGOS_SOCIAIS', 'PC_ENCARGOS_SOCIAIS', 1, 127, '', 6, false, true, 'd', '', 0 );

-- Layout lote contratos
insert into db_layouttxt values (247, 'TCE/RS - LICITACON - LOTE CONTRATOS', 0, '', 6 );
insert into db_layoutlinha values (824, 247, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true );
insert into db_layoutlinha values (825, 247, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (13103, 824, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13104, 824, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13105, 824, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13106, 824, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13107, 824, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13108, 824, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13109, 825, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13110, 825, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13111, 825, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13112, 825, 'NR_CONTRATO', 'NR_CONTRATO', 1, 28, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13113, 825, 'ANO_CONTRATO', 'ANO_CONTRATO', 1, 48, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13114, 825, 'TP_INSTRUMENTO', 'TP_INSTRUMENTO', 1, 52, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13115, 825, 'NR_LOTE', 'NR_LOTE', 1, 53, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13116, 825, 'VL_LOTE', 'VL_LOTE', 1, 63, '', 16, false, true, 'd', '', 0 );

-- Layout responsaveis contratos
insert into db_layouttxt values (249, 'TCE/RS - LICITACON - RESPONSAVEL_CON', 0, '', 6 );
insert into db_layoutlinha values (826, 249, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true );
insert into db_layoutlinha values (827, 249, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (13126, 827, 'NR_CONTRATO', 'NR_CONTRATO', 1, 28, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13117, 826, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13118, 826, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13119, 826, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13120, 826, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13121, 826, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13122, 826, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13123, 827, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13124, 827, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13125, 827, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13127, 827, 'ANO_CONTRATO', 'ANO_CONTRATO', 1, 48, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13128, 827, 'TP_INSTRUMENTO', 'TP_INSTRUMENTO', 1, 52, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13129, 827, 'TP_DOCUMENTO_RESPONSAVEL', 'TP_DOCUMENTO_RESPONSAVEL', 1, 53, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13130, 827, 'NR_DOCUMENTO_RESPONSAVEL', 'NR_DOCUMENTO_RESPONSAVEL', 1, 54, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13131, 827, 'TP_RESPONSAVEL', 'TP_RESPONSAVEL', 1, 68, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13132, 827, 'DT_INICIO_RESP', 'DT_INICIO_RESP', 1, 69, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13133, 827, 'DT_FINAL_RESP', 'DT_FINAL_RESP', 1, 79, '', 10, false, true, 'd', '', 0 );

-- Layout documentos de contratos
insert into db_layouttxt values (250, 'TCE/RS - LICITACON - DOCUMENTOS CONTRATO', 0, '', 6 );
insert into db_layoutlinha values (828, 250, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true );
insert into db_layoutlinha values (829, 250, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (13134, 828, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13135, 828, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13136, 828, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13137, 828, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13138, 828, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13139, 828, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13140, 829, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13141, 829, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13142, 829, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13143, 829, 'NR_CONTRATO', 'NR_CONTRATO', 1, 28, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13144, 829, 'ANO_CONTRATO', 'ANO_CONTRATO', 1, 48, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13145, 829, 'TP_INSTRUMENTO', 'TP_INSTRUMENTO', 1, 52, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13146, 829, 'SQ_EVENTO', 'SQ_EVENTO', 1, 53, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13147, 829, 'CD_TIPO_DOCUMENTO', 'CD_TIPO_DOCUMENTO', 1, 63, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13148, 829, 'NOME_ARQUIVO_DOCUMENTO', 'NOME_ARQUIVO_DOCUMENTO', 1, 66, '', 100, false, true, 'd', '', 0 );

-- Layout eventos de contratos
insert into db_layouttxt values (251, 'TCE/RS - LICITACON - EVENTOS DE CONTRATO', 0, '', 6 );
insert into db_layoutlinha values (830, 251, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true );
insert into db_layoutlinha values (831, 251, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (13149, 830, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13150, 830, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13151, 830, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13152, 830, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13153, 830, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13154, 830, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13155, 831, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13156, 831, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13157, 831, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13158, 831, 'NR_CONTRATO', 'NR_CONTRATO', 1, 28, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13159, 831, 'ANO_CONTRATO', 'ANO_CONTRATO', 1, 48, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13160, 831, 'TP_INSTRUMENTO', 'TP_INSTRUMENTO', 1, 52, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13161, 831, 'SQ_EVENTO', 'SQ_EVENTO', 1, 53, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13162, 831, 'CD_TIPO_EVENTO', 'CD_TIPO_EVENTO', 1, 63, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13163, 831, 'DT_EVENTO', 'DT_EVENTO', 1, 66, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13164, 831, 'TP_VEICULO_PUBLICACAO', 'TP_VEICULO_PUBLICACAO', 1, 76, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13165, 831, 'DS_PUBLICACAO', 'DS_PUBLICACAO', 1, 77, '', 100, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13166, 831, 'NR_REGISTRO', 'NR_REGISTRO', 1, 177, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13167, 831, 'NR_PROCESSO', 'NR_PROCESSO', 1, 197, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13168, 831, 'ANO_PROCESSO', 'ANO_PROCESSO', 1, 217, '', 4, false, true, 'd', '', 0 );

-- Layout dotacao orcamentaria de contratos
insert into db_layouttxt values (252, 'TCE/RS - LICITACON - DOTACAO CONTRATOS', 0, '', 6 );
insert into db_layoutlinha values (832, 252, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true );
insert into db_layoutlinha values (833, 252, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (13169, 832, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13170, 832, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13171, 832, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13172, 832, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13173, 832, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13174, 832, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13175, 833, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13176, 833, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13177, 833, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13178, 833, 'NR_CONTRATO', 'NR_CONTRATO', 1, 28, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13179, 833, 'ANO_CONTRATO', 'ANO_CONTRATO', 1, 48, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13180, 833, 'TP_INSTRUMENTO', 'TP_INSTRUMENTO', 1, 52, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13181, 833, 'CD_PROJETO_ATIVIDADE', 'CD_PROJETO_ATIVIDADE', 1, 53, '', 5, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13182, 833, 'CD_RECURSO_ORCAMENTARIO', 'CD_RECURSO_ORCAMENTARIO', 1, 58, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13183, 833, 'CD_NATUREZA_DESPESA', 'CD_NATUREZA_DESPESA', 1, 62, '', 6, false, true, 'd', '', 0 );

-- Layout contratos LICITACON
insert into db_layouttxt values (253, 'TCE/RS - LICITACON - CONTRATOS', 0, '', 6 );
insert into db_layoutlinha values (834, 253, 'CABEÇALHO', 1, 0, 0, 0, '', '|', true );
insert into db_layoutlinha values (835, 253, 'REGISTRO', 3, 0, 0, 0, '', '|', true );
insert into db_layoutcampos values (13184, 834, 'CNPJ', 'CNPJ', 1, 1, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13185, 834, 'DATA_INICIAL', 'DATA_INICIAL', 1, 15, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13186, 834, 'DATA_FINAL', 'DATA_FINAL', 1, 25, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13187, 834, 'DATA_GERACAO', 'DATA_GERACAO', 1, 35, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13188, 834, 'NOME_SETOR', 'NOME_SETOR', 1, 45, '', 150, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13189, 834, 'TOTAL_REGISTROS', 'TOTAL_REGISTROS', 1, 195, '', 15, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13190, 835, 'NR_LICITACAO', 'NR_LICITACAO', 1, 1, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13191, 835, 'ANO_LICITACAO', 'ANO_LICITACAO', 1, 21, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13192, 835, 'CD_TIPO_MODALIDADE', 'CD_TIPO_MODALIDADE', 1, 25, '', 3, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13193, 835, 'NR_CONTRATO', 'NR_CONTRATO', 1, 28, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13194, 835, 'ANO_CONTRATO', 'ANO_CONTRATO', 1, 48, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13195, 835, 'TP_INSTRUMENTO', 'TP_INSTRUMENTO', 1, 52, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13196, 835, 'NR_PROCESSO', 'NR_PROCESSO', 1, 53, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13197, 835, 'ANO_PROCESSO', 'ANO_PROCESSO', 1, 73, '', 4, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13198, 835, 'TP_DOCUMENTO_CONTRATADO', 'TP_DOCUMENTO_CONTRATADO', 1, 77, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13199, 835, 'NR_DOCUMENTO_CONTRATADO', 'NR_DOCUMENTO_CONTRATADO', 1, 78, '', 14, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13200, 835, 'DT_INICIO_VIGENCIA', 'DT_INICIO_VIGENCIA', 1, 92, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13201, 835, 'DT_FINAL_VIGENCIA', 'DT_FINAL_VIGENCIA', 1, 102, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13202, 835, 'VL_CONTRATO', 'VL_CONTRATO', 1, 112, '', 16, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13203, 835, 'DT_ASSINATURA', 'DT_ASSINATURA', 1, 128, '', 10, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13204, 835, 'BL_GARANTIA', 'BL_GARANTIA', 1, 138, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13205, 835, 'NR_DIAS_PRAZO', 'NR_DIAS_PRAZO', 1, 139, '', 5, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13206, 835, 'DS_OBJETO', 'DS_OBJETO', 1, 144, '', 500, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13207, 835, 'NR_CONTRATO_ORIGINAL', 'NR_CONTRATO_ORIGINAL', 1, 644, '', 20, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13208, 835, 'BL_INICIO_DEPENDE_OI', 'BL_INICIO_DEPENDE_OI', 1, 664, '', 1, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13209, 835, 'DS_JUSTIFICATIVA', 'DS_JUSTIFICATIVA', 1, 665, '', 300, false, true, 'd', '', 0 );
insert into db_layoutcampos values (13210, 835, 'CNPJ_CONSORCIO', 'CNPJ_CONSORCIO', 1, 965, '', 14, false, true, 'd', '', 0 );

update liclicitatipoevento set l45_descricao = 'DOCUMENTOS' where l45_sequencial = 23;

/** LicitaCon - Contratos */

/** Acordo  - Novos Campos */
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21795 ,'ac16_tipoinstrumento' ,'int4' ,'Tipo de Instrumento do Acordo' ,'' ,'Tipo de Instrumento' ,4 ,true ,'false' ,'false' ,1 ,'text' ,'Tipo de Instrumento' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 2828 ,21795 ,28 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21796 ,'ac16_dependeordeminicio' ,'bool' ,'Depende da Ordem de Início' ,'' ,'Depende da Ordem de Início' ,1 ,true ,'false' ,'false' ,5 ,'text' ,'Depende da Ordem de Início' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 2828 ,21796 ,29 ,0 );

--acordoempempenho

insert into db_sysarquivo values (3926, 'acordoempempenho', 'Empenhos do contrato', 'ac54', '2016-04-05', 'Empenhos do contrato', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (69,3926);
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21797 ,'ac54_sequencial' ,'int4' ,'Cï¿½digo' ,'' ,'Cï¿½digo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Cï¿½digo' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3926 ,21797 ,1 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21798 ,'ac54_acordo' ,'int4' ,'Contrato' ,'' ,'Contrato' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Contrato' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3926 ,21798 ,2 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21799 ,'ac54_empempenho' ,'int4' ,'Empenho' ,'' ,'Empenho' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Empenho' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3926 ,21799 ,3 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21800 ,'ac54_numerolicitacao' ,'varchar(50)' ,'Número Licitação' ,'' ,'Número Licitação' ,50 ,'true' ,'false' ,'false' ,0 ,'text' ,'Número Licitação' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3926 ,21800 ,4 ,0 );
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3926,21797,1,21798);
insert into db_sysforkey values(3926,21798,1,2828,0);
insert into db_sysforkey values(3926,21799,1,889,0);
insert into db_sysindices values(4336,'acordoempempenho_acordo_in',3926,'0');
insert into db_syscadind values(4336,21798,1);
insert into db_sysindices values(4337,'acordoempempenho_empempenho_in',3926,'0');
insert into db_syscadind values(4337,21799,1);
insert into db_syssequencia values(1000560, 'acordoempempenho_ac54_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000560 where codarq = 3926 and codcam = 21797;

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10221 ,'Vincular Contrato com Empenhos' ,'Vincular Contrato com Empenhos' ,'ac4_vincularempenhoo001.php' ,'1' ,'1' ,'Vincular Contrato com Empenhos' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8289 ,10221 ,8 ,8251 );

insert into db_sysarquivo values (3927, 'acordoevento', 'Eventos do Acordo', 'ac55', '2016-04-08', 'Eventos do Acordo', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (69,3927);
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21821 ,'ac55_tipoevento' ,'int4' ,'Tipo do Evento' ,'' ,'Evento' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Evento' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3927 ,21821 ,2 ,0 );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21821 ,'1' ,'Anulação por determinação judicial' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21821 ,'2' ,'Anulação de ofício' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21821 ,'3' ,'Apostila' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21821 ,'4' ,'Encerramento de Contrato' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21821 ,'5' ,'Ordem de início' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21821 ,'6' ,'Publicação' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21821 ,'7' ,'Retorno dos efeitos do contrato' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21821 ,'8' ,'Rescisão' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21821 ,'9' ,'Suspensão por cautelar' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21821 ,'10' ,'Suspensão por determinação judicial' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21821 ,'11' ,'Suspensão de ofício' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21821 ,'12' ,'Termo aditivo' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21821 ,'13' ,'Termo de recebimentondefinitivo' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21821 ,'14' ,'Termo de recebimento provisório' );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21822 ,'ac55_sequencial' ,'int4' ,'Sequencial' ,'' ,'Sequencial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Sequencial' );
delete from db_syscampodef where codcam = 21822;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3927 ,21822 ,1 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21823 ,'ac55_acordo' ,'int4' ,'Acordo' ,'' ,'Acordo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Acordo' );
delete from db_syscampodef where codcam = 21823;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3927 ,21823 ,3 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21824 ,'ac55_data' ,'date' ,'Data do Evento' ,'' ,'Data do Evento' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Data do Evento' );
delete from db_syscampodef where codcam = 21824;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3927 ,21824 ,4 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21825 ,'ac55_veiculocomunicacao' ,'int4' ,'Veículo de Comunicação' ,'' ,'Veículo de Comunicação' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Veículo de Comunicação' );
delete from db_syscampodef where codcam = 21825;
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21825 ,'1' ,'Diário Oficial do Estado' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21825 ,'2' ,'Internet' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21825 ,'3' ,'Jornal' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21825 ,'4' ,'Mural da Entidade' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21825 ,'5' ,'Diário Oficial do Município' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21825 ,'6' ,'Diário Oficial dos Municípios/RS' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21825 ,'7' ,'Diário Oficial da União' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3927 ,21825 ,5 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21826 ,'ac55_numeroprocesso' ,'varchar(50)' ,'Número do Processo' ,'' ,'Número do Processo' ,50 ,'true' ,'false' ,'false' ,0 ,'text' ,'Número do Processo' );
delete from db_syscampodef where codcam = 21826;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3927 ,21826 ,6 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21827 ,'ac55_anoprocesso' ,'int4' ,'Ano do Processo' ,'' ,'Ano do Processo' ,4 ,'true' ,'false' ,'false' ,1 ,'text' ,'Ano do Processo' );
delete from db_syscampodef where codcam = 21827;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3927 ,21827 ,7 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21828 ,'ac55_descricaopublicacao' ,'varchar(100)' ,'Descrição da Publicação' ,'' ,'Descrição da Publicação' ,100 ,'true' ,'false' ,'false' ,0 ,'text' ,'Descrição da Publicação' );
delete from db_syscampodef where codcam = 21828;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3927 ,21828 ,8 ,0 );
delete from db_sysprikey where codarq = 3927;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3927,21822,1,21823);
delete from db_sysforkey where codarq = 3927 and referen = 0;
insert into db_sysforkey values(3927,21823,1,2828,0);
insert into db_sysindices values(4338,'acordoevento_acordo_in',3927,'0');
insert into db_syscadind values(4338,21823,1);
insert into db_syssequencia values(1000561, 'acordoevento_ac55_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000561 where codarq = 3927 and codcam = 21822;


insert into db_sysarquivo values (3928, 'acordoposicaoevento', 'Posição do acordo/evento', 'ac56', '2016-04-08', 'Posição do acordo/evento', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (69,3928);
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21829 ,'ac56_sequencial' ,'int4' ,'Sequencial' ,'' ,'Sequencial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Sequencial' );
delete from db_syscampodef where codcam = 21829;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3928 ,21829 ,1 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21830 ,'ac56_acordoevento' ,'int4' ,'Evento' ,'' ,'Evento' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Evento' );
delete from db_syscampodef where codcam = 21830;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3928 ,21830 ,2 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21831 ,'ac56_acordoposicao' ,'int4' ,'Posiçao do Acordo' ,'' ,'Posiçao do Acordo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Posiçao do Acordo' );
delete from db_syscampodef where codcam = 21831;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3928 ,21831 ,3 ,0 );
insert into db_syssequencia values(1000562, 'acordoposicaoevento_ac56_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000562 where codarq = 3928 and codcam = 21829;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3928,21829,1,21831);
insert into db_sysforkey values(3928,21830,1,3927,0);
insert into db_sysforkey values(3928,21831,1,2930,0);
insert into db_sysindices values(4339,'acordoposicaoevento_acordoposicao_in',3928,'0');
insert into db_syscadind values(4339,21831,1);
insert into db_sysindices values(4340,'acordoposicaoevento_acordoevento_in',3928,'0');
insert into db_syscadind values(4340,21830,1);

insert into db_sysarquivo values (3929, 'acordodocumentoevento', 'acordodocumentoevento', 'ac57', '2016-04-08', 'Documentos dos acordos', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (69,3929);
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21832 ,'ac57_sequencial' ,'int4' ,'Sequencial' ,'' ,'Sequencial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Sequencial' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3929 ,21832 ,1 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21833 ,'ac57_acordoevento' ,'int4' ,'Evento' ,'' ,'Evento' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Evento' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3929 ,21833 ,2 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21834 ,'ac57_acordodocumento' ,'int4' ,'Documento' ,'' ,'Documento' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Documento' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3929 ,21834 ,3 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21835 ,'ac57_tipodocumento' ,'int4' ,'Tipo do Documento' ,'' ,'Tipo do Documento' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Tipo do Documento' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'1' ,'Anulação de ofício' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'2' ,'Anulação por determinação judicial' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'3' ,'Apostilamento' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'4' ,'Contrato' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'5' ,'Ordem de início' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'6' ,'Outros documentos' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'7' ,'Planilha Modelo de Aditivo' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'8' ,'Retorno dos efeitos do contrato' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'9' ,'Súmula do contrato' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'10' ,'Suspensão cautelar' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'11' ,'Suspensão de ofício' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'12' ,'Suspensão por determinação judicial' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'13' ,'Termo aditivo' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'14' ,'Termo de recebimento Definitivo' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'15' ,'Termo de recebimento Provisório' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21835 ,'16' ,'Termo de rescisão' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3929 ,21835 ,4 ,0 );
insert into db_syssequencia values(1000563, 'acordodocumentoevento_ac57_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000563 where codarq = 3929 and codcam = 21832;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3929,21832,1,21834);
insert into db_sysforkey values(3929,21833,1,3927,0);
insert into db_sysforkey values(3929,21834,1,3267,0);
insert into db_sysindices values(4341,'acordodocumentoevento_evento_in',3929,'0');
insert into db_syscadind values(4341,21833,1);
insert into db_sysindices values(4342,'acordodocumentoevento_documento_in',3929,'0');
insert into db_syscadind values(4342,21834,1);

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10225 ,'Eventos' ,'Eventos dos acordos' ,'con4_acordoeventos001.php' ,'1' ,'1' ,'Eventos dos acordos' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8289 ,10225 ,9 ,8251 );

update db_cadattdinamicoatributosopcoes set db18_valor = 'Obras e Serviços de Engenharia' where db18_cadattdinamicoatributos = (select db109_sequencial from db_cadattdinamicoatributos where db109_nome = 'tipoobjeto' limit 1) and db18_opcao = 'OSE';