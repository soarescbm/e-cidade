---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO FINANCEIRO ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

select fc_executa_ddl('insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21841 ,\'ac07_datainicio\' ,\'date\' ,\'Data de Início\' ,\'\' ,\'Data de Início\' ,10 ,\'true\' ,\'false\' ,\'false\' ,1 ,\'text\' ,\'Data de Início\')');
select fc_executa_ddl('insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 2831 ,21841 ,5 ,0 );');
select fc_executa_ddl('insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21842 ,\'ac07_datatermino\' ,\'date\' ,\'Data de Término\' ,\'\' ,\'Data de Término\' ,10 ,\'true\' ,\'false\' ,\'false\' ,1 ,\'text\' ,\'Data de Término\');');
select fc_executa_ddl('insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 2831 ,21842 ,6 ,0 );');
select fc_executa_ddl('insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21843 ,\'ac26_tipooperacao\' ,\'int4\' ,\'Tipo de Operação\' ,\'\' ,\'Tipo de Operação\' ,10 ,\'true\' ,\'false\' ,\'false\' ,1 ,\'text\' ,\'Tipo de Operação\' );');
select fc_executa_ddl('insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21843 , \'1\' ,\'Acréscimo de Valor por Aumento de Quantitativo\' );');
select fc_executa_ddl('insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21843 , \'2\' ,\'Acréscimo de valor por inclusão de Itens novos\' );');
select fc_executa_ddl('insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21843 , \'3\' ,\'Reajustamento de Preços\' );');
select fc_executa_ddl('insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21843 , \'4\' ,\'Redução de Valor por Supressão de Itens\' );');
select fc_executa_ddl('insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21843 , \'5\' ,\'Redução de Valor por Supressão de Quantitativo\' );');
select fc_executa_ddl('insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 2930 ,21843 ,10 ,0 );');

select fc_executa_ddl('insert into acordoposicaotipo values (7, \'Alteração de Dotação\');');
select fc_executa_ddl('insert into acordoposicaotipo values (8, \'Supressão de Quantidade/Valor\')');

select fc_executa_ddl('insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10227 ,\'Supressão de Quantidade/Valor\' ,\'Supressão de Quantidade/Valor\' ,\'ac04_aditamentosupressaovalor001.php\' ,\'1\' ,\'1\' ,\'Supressão de Quantidade/Valor\' ,\'true\' );');
select fc_executa_ddl('insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8568 ,10227 ,6 ,8251 );');

update acordocomissaotipomembro set ac42_descricao = 'Gestor' where ac42_sequencial = 1;

-- Controle de contratos encerrados
select fc_executa_ddl('insert into db_sysarquivo values (3933, \'acordoencerramentolicitacon\', \'Controle do encerramento de contratos para o LicitaCon.\', \'ac58\', \'2016-04-15\', \'Encerramento de Contratos\', 0, \'f\', \'f\', \'f\', \'f\' );');
select fc_executa_ddl('insert into db_sysarqmod values (69,3933);');
select fc_executa_ddl('insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21845 ,\'ac58_sequencial\' ,\'int4\' ,\'Código\' ,\'\' ,\'Código\' ,10 ,\'false\' ,\'false\' ,\'false\' ,1 ,\'text\' ,\'Código\' );');
select fc_executa_ddl('insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3933 ,21845 ,1 ,0 );');
select fc_executa_ddl('insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21846 ,\'ac58_acordo\' ,\'int4\' ,\'Acordo\' ,\'\' ,\'Acordo\' ,10 ,\'false\' ,\'false\' ,\'false\' ,1 ,\'text\' ,\'Acordo\' );');
select fc_executa_ddl('insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3933 ,21846 ,2 ,0 );');
select fc_executa_ddl('insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21847 ,\'ac58_data\' ,\'date\' ,\'Data\' ,\'\' ,\'Data\' ,10 ,\'false\' ,\'false\' ,\'false\' ,0 ,\'text\' ,\'Data\' );');
select fc_executa_ddl('insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3933 ,21847 ,3 ,0 );');
select fc_executa_ddl('insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3933,21845,1,21845);');
select fc_executa_ddl('insert into db_sysforkey values(3933,21846,1,2828,0);');
select fc_executa_ddl('insert into db_syssequencia values(1000565, \'acordoencerramentolicitacon_ac58_sequencial_seq\', 1, 1, 9223372036854775807, 1, 1);');
select fc_executa_ddl('update db_sysarqcamp set codsequencia = 1000565 where codarq = 3933 and codcam = 21845;');
select fc_executa_ddl('update db_layoutcampos set db52_layoutformat = 13 where db52_codigo = 13148;');

-- Campo Ano do Exercício na Tabela acordoempempenho
select fc_executa_ddl('insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21848 ,\'ac54_ano\' ,\'int4\' ,\'Exercício\' ,\'\' ,\'Exercício\' ,4 ,\'true\' ,\'false\' ,\'false\' ,1 ,\'text\' ,\'Exercício\' );');
select fc_executa_ddl('insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3926 ,21848 ,5 ,0);');

-- Campo Unidade da autorização de empenho
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21868 ,'e55_matunid' ,'int4' ,'Unidade' ,'null' ,'Unidade' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Unidade' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 811 ,21868 ,10 ,0 );
insert into db_sysforkey values(811,21868,1,1017,0);

select fc_executa_ddl(
  'insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10236 ,\'Disponibilidade Financeira\' ,\'Relatório de Disponibilidade Financeira\' ,\'con2_disponibilidadefinanceira001.php\' ,\'1\' ,\'1\' ,\'Disponibilidade Financeira\' ,\'true\' );
  delete from db_menu where id_item_filho = 10236 AND modulo = 209;
  insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 9581 ,10236 ,3 ,209 );'
);

-- Relatório Demonstração das Mutações do Patrimônio Líquido
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10237 ,'Dem. das Mutações do Pat. Líquido' ,'Dem. das Mutações do Pat. Líquido' ,'con2_relatoriomutacoespatrimonioliquido001.php' ,'1' ,'1' ,'Dem. das Mutações do Pat. Líquido' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 9882 ,10237 ,9 ,209 );

insert into orcparamrel (o42_codparrel, o42_descrrel, o42_orcparamrelgrupo) values(161, 'DEMONSTRAÇÃO DAS MUTAÇÕES DO PATRIMÔNIO LÍQUIDO', 1);

insert into orcparamseqcoluna values(207, 2016, 'Pat. Social / Capital Social', 1, null, 'capital_social');
insert into orcparamseqcoluna values(208, 2016, 'Adiantamento para Futuro Aumento de Capital (AFAC)', 1, null, 'afac');
insert into orcparamseqcoluna values(209, 2016, 'Reserva  de Capital', 1, null, 'reserva_capital' );
insert into orcparamseqcoluna values(210, 2016, 'Ajustes de Avaliação Patrimonial', 1, null, 'avaliacao_patrimonial');
insert into orcparamseqcoluna values(211, 2016, 'Reservas de Lucros', 1, null, 'reserva_lucros');
insert into orcparamseqcoluna values(212, 2016, 'Demais Reservas', 1, null, 'demais_reservas');
insert into orcparamseqcoluna values(213, 2016, 'Resultados Acumulados', 1, null, 'resultados_acumulados');
insert into orcparamseqcoluna values(214, 2016, 'Acões / Cotas em Tesouraria', 1, null, 'acoes_cotas_tesouraria');

insert into orcparamrelperiodos values(nextval('orcparamrelperiodos_o113_sequencial_seq'), 1, 161);

insert into orcparamseq values (161, 1, 'Saldos Iniciais', 1, 1, 1, false, false, false, false, false, 'Saldos Iniciais', true, false, 1, 1, '', false, 0);
insert into orcparamseq values (161, 2, 'Ajustes de exercícios anteriores', 1, 1, 1, false, false, false, false, false, 'Ajustes de exercícios anteriores', true, false, 2, 1, '', false, 0);
insert into orcparamseq values (161, 3, 'Aumento de Capital', 1, 1, 1, false, false, false, false, false, 'Aumento de Capital', true, false, 3, 1, '', false, 0);
insert into orcparamseq values (161, 4, 'Resgate / Reemissão de Ações e Cotas', 1, 1, 1, false, false, false, false, false, 'Resgate / Reemissão de Ações e Cotas', true, false, 4, 1, '', false, 0);
insert into orcparamseq values (161, 5, 'Juros sobre o capital próprio', 1, 1, 1, false, false, false, false, false, 'Juros sobre o capital próprio', true, false, 5, 1, '', false, 0);
insert into orcparamseq values (161, 6, 'Resultado do exercício', 1, 1, 1, false, false, false, false, false, 'Resultado do exercício', true, false, 6, 1, '', false, 0);
insert into orcparamseq values (161, 7, 'Ajustes de avaliação patrimonial', 1, 1, 1, false, false, false, false, false, 'Ajustes de avaliação patrimonial', true, false, 7, 1, '', false, 0);
insert into orcparamseq values (161, 8, 'Constituição / Reversão de reservas', 1, 1, 1, false, false, false, false, false, 'Constituição / Reversão de reservas', true, false, 8, 1, '', false, 0);
insert into orcparamseq values (161, 9, 'Dividendos a distribuir (R$ ...por ação)', 1, 1, 1, false, false, false, false, false, 'Dividendos a distribuir (R$ ...por ação)', true, false, 9, 1, '', false, 0);
insert into orcparamseq values (161, 10, 'Saldos Finais', 1, 1, 1, false, false, false, false, false, 'Saldos Finais', false, true, 10, 1, '', false, 0);

insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 1, 161, 207, 1, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 1, 161, 208, 2, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 1, 161, 209, 3, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 1, 161, 210, 4, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 1, 161, 211, 5, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 1, 161, 212, 6, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 1, 161, 213, 7, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 1, 161, 214, 8, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 2, 161, 207, 1, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 2, 161, 208, 2, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 2, 161, 209, 3, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 2, 161, 210, 4, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 2, 161, 211, 5, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 2, 161, 212, 6, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 2, 161, 213, 7, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 2, 161, 214, 8, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 3, 161, 207, 1, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 3, 161, 208, 2, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 3, 161, 209, 3, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 3, 161, 210, 4, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 3, 161, 211, 5, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 3, 161, 212, 6, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 3, 161, 213, 7, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 3, 161, 214, 8, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 4, 161, 207, 1, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 4, 161, 208, 2, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 4, 161, 209, 3, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 4, 161, 210, 4, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 4, 161, 211, 5, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 4, 161, 212, 6, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 4, 161, 213, 7, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 4, 161, 214, 8, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 5, 161, 207, 1, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 5, 161, 208, 2, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 5, 161, 209, 3, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 5, 161, 210, 4, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 5, 161, 211, 5, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 5, 161, 212, 6, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 5, 161, 213, 7, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 5, 161, 214, 8, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 6, 161, 207, 1, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 6, 161, 208, 2, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 6, 161, 209, 3, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 6, 161, 210, 4, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 6, 161, 211, 5, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 6, 161, 212, 6, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 6, 161, 213, 7, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 6, 161, 214, 8, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 7, 161, 207, 1, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 7, 161, 208, 2, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 7, 161, 209, 3, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 7, 161, 210, 4, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 7, 161, 211, 5, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 7, 161, 212, 6, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 7, 161, 213, 7, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 7, 161, 214, 8, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 8, 161, 207, 1, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 8, 161, 208, 2, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 8, 161, 209, 3, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 8, 161, 210, 4, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 8, 161, 211, 5, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 8, 161, 212, 6, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 8, 161, 213, 7, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 8, 161, 214, 8, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 9, 161, 207, 1, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 9, 161, 208, 2, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 9, 161, 209, 3, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 9, 161, 210, 4, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 9, 161, 211, 5, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 9, 161, 212, 6, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 9, 161, 213, 7, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 9, 161, 214, 8, 1, '');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 10, 161, 207, 1, 1, 'L[1]->capital_social + L[2]->capital_social + L[3]->capital_social + L[4]->capital_social + L[5]->capital_social + L[6]->capital_social + L[7]->capital_social + L[8]->capital_social + L[9]->capital_social');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 10, 161, 208, 2, 1, 'L[1]->afac + L[2]->afac + L[3]->afac + L[4]->afac + L[5]->afac + L[6]->afac + L[7]->afac + L[8]->afac + L[9]->afac');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 10, 161, 209, 3, 1, 'L[1]->reserva_capital + L[2]->reserva_capital + L[3]->reserva_capital + L[4]->reserva_capital + L[5]->reserva_capital + L[6]->reserva_capital + L[7]->reserva_capital + L[8]->reserva_capital + L[9]->reserva_capital');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 10, 161, 210, 4, 1, 'L[1]->avaliacao_patrimonial + L[2]->avaliacao_patrimonial + L[3]->avaliacao_patrimonial + L[4]->avaliacao_patrimonial + L[5]->avaliacao_patrimonial + L[6]->avaliacao_patrimonial + L[7]->avaliacao_patrimonial + L[8]->avaliacao_patrimonial + L[9]->avaliacao_patrimonial');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 10, 161, 211, 5, 1, 'L[1]->reserva_lucros + L[2]->reserva_lucros + L[3]->reserva_lucros + L[4]->reserva_lucros + L[5]->reserva_lucros + L[6]->reserva_lucros + L[7]->reserva_lucros + L[8]->reserva_lucros + L[9]->reserva_lucros');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 10, 161, 212, 6, 1, 'L[1]->demais_reservas + L[2]->demais_reservas + L[3]->demais_reservas + L[4]->demais_reservas + L[5]->demais_reservas + L[6]->demais_reservas + L[7]->demais_reservas + L[8]->demais_reservas + L[9]->demais_reservas');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 10, 161, 213, 7, 1, 'L[1]->resultados_acumulados + L[2]->resultados_acumulados + L[3]->resultados_acumulados + L[4]->resultados_acumulados + L[5]->resultados_acumulados + L[6]->resultados_acumulados + L[7]->resultados_acumulados + L[8]->resultados_acumulados + L[9]->resultados_acumulados');
insert into orcparamseqorcparamseqcoluna values (nextval('orcparamseqorcparamseqcoluna_o116_sequencial_seq'), 10, 161, 214, 8, 1, 'L[1]->acoes_cotas_tesouraria + L[2]->acoes_cotas_tesouraria + L[3]->acoes_cotas_tesouraria + L[4]->acoes_cotas_tesouraria + L[5]->acoes_cotas_tesouraria + L[6]->acoes_cotas_tesouraria + L[7]->acoes_cotas_tesouraria + L[8]->acoes_cotas_tesouraria + L[9]->acoes_cotas_tesouraria');

---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO FOLHA ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

insert into db_sysarquivo values (3936, 'rhconsignacaobancolayout', 'Vinculo dos layouts com banco', 'rh178', '2016-05-02', 'Vinculo dos layouts com banco', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (28,3936);
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21859 ,'rh178_sequencial' ,'int4' ,'Codigo' ,'' ,'Codigo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Codigo' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3936 ,21859 ,1 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21860 ,'rh178_db_banco' ,'varchar(10)' ,'Banco' ,'' ,'Banco' ,10 ,'false' ,'true' ,'false' ,0 ,'text' ,'Banco' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3936 ,21860 ,2 ,0 );
insert into db_syssequencia values(1000570, 'rhconsignacaobancolayout_rh178_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000570 where codarq = 3936 and codcam = 21859;
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21861 ,'rh178_layout' ,'int4' ,'Layout' ,'' ,'Layout' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Layout' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3936 ,21861 ,3 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21862 ,'rh178_rubrica' ,'char(4)' ,'Rubrica' ,'' ,'Rubrica' ,4 ,'false' ,'true' ,'false' ,0 ,'text' ,'Rubrica' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3936 ,21862 ,4 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21863 ,'rh178_instit' ,'int4' ,'Instituiçao' ,'' ,'Instituiçao' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Instituiçao' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3936 ,21863 ,5 ,0 );

insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3936,21859,1,21859);
insert into db_sysforkey values(3936,21860,1,1185,0);
insert into db_sysforkey values(3936,21861,1,1553,0);
insert into db_sysforkey values(3936,21862,1,1177,0);
insert into db_sysforkey values(3936,21863,2,1177,0);
insert into db_sysindices values(4346,'rhconsignacaobancolayout_banco_in',3936,'0');
insert into db_syscadind values(4346,21860,1);
insert into db_sysindices values(4347,'rhconsignacaobancolayout_layout_in',3936,'0');
insert into db_syscadind values(4347,21861,1);
insert into db_sysindices values(4348,'rhconsignacaobancolayout_rubrica_in',3936,'0');
insert into db_syscadind values(4348,21862,1);

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21869 ,'rh151_arquivo' ,'oid' ,'Conteudo do Arquivo' ,'' ,'Conteudo do Arquivo' ,1 ,'true' ,'false' ,'false' ,1 ,'text' ,'Conteudo do Arquivo' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3785 ,21869 ,8 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21870 ,'rh151_banco' ,'varchar(10)' ,'Banco' ,'' ,'Banco' ,10 ,'true' ,'false' ,'false' ,0 ,'text' ,'Banco' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3785 ,21870 ,9 ,0 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10231 ,'Configuração Consignados' ,'Configuraçao Consignados' ,'pes4_configurararquivoconsignado001.php' ,'1' ,'1' ,'Configuraçao das consignaçoes em folha' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 3516 ,10231 ,14 ,952 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10232 ,'Consignados' ,'Importaçao dos arquivos de consignados' ,'' ,'1' ,'1' ,'Importaçao dos arquivos de consignados' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 5106 ,10232 ,18 ,952 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10234 ,'Importar Arquivo' ,'Importar dados do arquivo ' ,'pes4_importararquivoconsignado001.php' ,'1' ,'1' ,'Importar dados do arquivo ' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10232 ,10234 ,1 ,952 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10235 ,'Exportar Arquivo' ,'Exportar os dados do arquivo para a caixa' ,'pes4_exportararquivoconsignado001.php' ,'1' ,'1' ,'Exportar os dados do arquivo para a caixa' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10232 ,10235 ,3 ,952 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10238 ,'Conferência de Dados' ,'Conferência de Dados' ,'pes4_conferenciaconsignados001.php' ,'1' ,'1' ,'Conferência de Dados' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10232 ,10238 ,2 ,952 );

update db_layouttxt set db50_codigo = 1 , db50_layouttxtgrupo = 1 , db50_descr = 'BANRISUL BLV' , db50_quantlinhas = 0 , db50_obs = '' where db50_codigo = 1;
insert into db_layouttxt( db50_codigo ,db50_layouttxtgrupo ,db50_descr ,db50_quantlinhas ,db50_obs ) values ( 254 ,2 ,'CONSIGNADO CAIXA' ,0 ,'' );
insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 836 ,254 ,'HEADER' ,1 ,150 ,0 ,0 ,'' ,'' ,'0' );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13212 ,836 ,'codigo_do_registro' ,'CODIGO DO REGISTRO' ,2 ,1 ,'1' ,1 ,'t' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13213 ,836 ,'codigo_convenente' ,'CODIGO CONVENENTE' ,2 ,2 ,'' ,5 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13214 ,836 ,'dv_convenente' ,'DV-CONVENENTE' ,2 ,7 ,'' ,1 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13215 ,836 ,'n_extrato_convenente' ,'Nº EXTRATO CONVENENTE' ,2 ,8 ,'' ,3 ,'f' ,'t' ,'e' ,'' ,0 );
update db_layoutcampos set db52_codigo = 13214 , db52_layoutlinha = 836 , db52_nome = 'dv_convenente' , db52_descr = 'DV-CONVENENTE' , db52_layoutformat = 2 , db52_posicao = 7 , db52_default = '' , db52_tamanho = 1 , db52_ident = 't' , db52_imprimir = 't' , db52_alinha = 'e' , db52_obs = '' , db52_quebraapos = 0 where db52_codigo = 13214;
update db_layoutcampos set db52_posicao = db52_posicao+0 where db52_layoutlinha = 836 and db52_posicao >= 7 and db52_codigo <> 13214;
update db_layoutcampos set db52_codigo = 13214 , db52_layoutlinha = 836 , db52_nome = 'dv_convenente' , db52_descr = 'DV-CONVENENTE' , db52_layoutformat = 2 , db52_posicao = 7 , db52_default = '' , db52_tamanho = 1 , db52_ident = 't' , db52_imprimir = 't' , db52_alinha = 'e' , db52_obs = '' , db52_quebraapos = 0 where db52_codigo = 13214;
update db_layoutcampos set db52_posicao = db52_posicao+0 where db52_layoutlinha = 836 and db52_posicao >= 7 and db52_codigo <> 13214;
update db_layoutcampos set db52_codigo = 13215 , db52_layoutlinha = 836 , db52_nome = 'n_extrato_convenente' , db52_descr = 'Nº EXTRATO CONVENENTE' , db52_layoutformat = 2 , db52_posicao = 8 , db52_default = '' , db52_tamanho = 3 , db52_ident = 't' , db52_imprimir = 't' , db52_alinha = 'e' , db52_obs = '' , db52_quebraapos = 0 where db52_codigo = 13215;
update db_layoutcampos set db52_codigo = 13213 , db52_layoutlinha = 836 , db52_nome = 'codigo_convenente' , db52_descr = 'CODIGO CONVENENTE' , db52_layoutformat = 2 , db52_posicao = 2 , db52_default = '' , db52_tamanho = 5 , db52_ident = 't' , db52_imprimir = 't' , db52_alinha = 'e' , db52_obs = '' , db52_quebraapos = 0 where db52_codigo = 13213;
update db_layoutcampos set db52_posicao = db52_posicao+0 where db52_layoutlinha = 836 and db52_posicao >= 2 and db52_codigo <> 13213;
update db_layoutcampos set db52_codigo = 13213 , db52_layoutlinha = 836 , db52_nome = 'codigo_convenente' , db52_descr = 'CODIGO CONVENENTE' , db52_layoutformat = 2 , db52_posicao = 2 , db52_default = '' , db52_tamanho = 5 , db52_ident = 'f' , db52_imprimir = 't' , db52_alinha = 'e' , db52_obs = '' , db52_quebraapos = 0 where db52_codigo = 13213;
update db_layoutcampos set db52_posicao = db52_posicao+0 where db52_layoutlinha = 836 and db52_posicao >= 2 and db52_codigo <> 13213;
update db_layoutcampos set db52_codigo = 13214 , db52_layoutlinha = 836 , db52_nome = 'dv_convenente' , db52_descr = 'DV-CONVENENTE' , db52_layoutformat = 2 , db52_posicao = 7 , db52_default = '' , db52_tamanho = 1 , db52_ident = 'f' , db52_imprimir = 't' , db52_alinha = 'e' , db52_obs = '' , db52_quebraapos = 0 where db52_codigo = 13214;
update db_layoutcampos set db52_posicao = db52_posicao+0 where db52_layoutlinha = 836 and db52_posicao >= 7 and db52_codigo <> 13214;
update db_layoutcampos set db52_codigo = 13215 , db52_layoutlinha = 836 , db52_nome = 'n_extrato_convenente' , db52_descr = 'Nº EXTRATO CONVENENTE' , db52_layoutformat = 2 , db52_posicao = 8 , db52_default = '' , db52_tamanho = 3 , db52_ident = 'f' , db52_imprimir = 't' , db52_alinha = 'e' , db52_obs = '' , db52_quebraapos = 0 where db52_codigo = 13215;
update db_layoutcampos set db52_posicao = db52_posicao+0 where db52_layoutlinha = 589 and db52_posicao >= 1 and db52_codigo <> 1000000;
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13216 ,836 ,'dv_extrato_corrente' ,'DV EXTRATO CONVENENTE' ,2 ,11 ,'' ,1 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13217 ,836 ,'nome_convenente' ,'NOME CONVENENTE' ,2 ,12 ,'' ,35 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13218 ,836 ,'identificacao_do_sistema' ,'IDENTIFICAÇÃO DO SISTEMA' ,1 ,47 ,'SIAPX' ,9 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13219 ,836 ,'agencia_responsavel_centralizadora' ,'AGENCIA_RESPONSAVEL_(CENTRALIZADORA)' ,2 ,56 ,'' ,4 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13220 ,836 ,'identificacao_operacao' ,'IDENTIFICAÇÃO OPERAÇÃO' ,1 ,60 ,'CONSIGNAÇÕES' ,12 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13221 ,836 ,'codigo_remessa_retorno' ,'CÓDIGO REMESSA/RETORNO' ,2 ,72 ,'1' ,1 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13222 ,836 ,'nome_remessa_retorno' ,'NOME REMESSA RETORNO' ,1 ,73 ,'Remessa' ,7 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13223 ,836 ,'data_vencimento_extrato' ,'DATA VENCIMENTO EXTRATO' ,4 ,80 ,'' ,8 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13224 ,836 ,'data_geracao_remessa' ,'DATA GERAÇÃO REMESSA' ,4 ,88 ,'' ,8 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13225 ,836 ,'data_geracao_retorno' ,'DATA GERAÇÃO RETORNO' ,4 ,96 ,'' ,8 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13226 ,836 ,'campo_reservado' ,'CAMPO RESERVADO' ,1 ,104 ,'' ,47 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 837 ,254 ,'DETALHE' ,2 ,150 ,0 ,0 ,'' ,'' ,'0' );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13227 ,837 ,'codigo_do_registro' ,'CODIGO DO REGISTRO' ,1 ,1 ,'2' ,1 ,'t' ,'t' ,'d' ,'' ,0 );
update db_layoutlinha set db51_codigo = 837 , db51_layouttxt = 254 , db51_descr = 'DETALHE' , db51_tipolinha = 3 , db51_tamlinha = 150 , db51_linhasantes = 0 , db51_linhasdepois = 0 , db51_obs = '' , db51_separador = '' , db51_compacta = '0' where db51_codigo = 837;
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13228 ,837 ,'codigo_convenente' ,'CODIGO_CONVENENTE' ,2 ,2 ,'' ,5 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13229 ,837 ,'dv_convenente' ,'DV CONVENENTE' ,2 ,7 ,'' ,1 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13230 ,837 ,'n_extrato_convenente' ,'Nº EXTRATO CONVENENTE' ,2 ,8 ,'' ,3 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13231 ,837 ,'dv_extrato_convenente' ,'DV-EXTRATO CONVENENTE' ,2 ,11 ,'' ,1 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13232 ,837 ,'n_sequencial' ,'Nº SEQUENCIAL' ,2 ,12 ,'' ,5 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13233 ,837 ,'prazo_vencimento_contrato' ,'PRAZO VENCIMENTO CONTRATO' ,2 ,17 ,'' ,3 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13234 ,837 ,'prazo_remanescente' ,'PRAZO REMANESCENTE' ,2 ,20 ,'' ,3 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13235 ,837 ,'n_contrato' ,'Nº CONTRATO' ,2 ,23 ,'' ,18 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13236 ,837 ,'n_prestacao' ,'Nº PRESTAÇÃO' ,2 ,41 ,'' ,18 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13237 ,837 ,'n_matricula' ,'Nº MATRÍCULA' ,1 ,59 ,'' ,12 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13238 ,837 ,'nome_cliente' ,'NOME CLIENTE' ,1 ,71 ,'' ,35 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13239 ,837 ,'valor_prestacao' ,'VALOR PRESTAÇÃO' ,2 ,106 ,'' ,17 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13240 ,837 ,'codigo_ocorrencia_processamento' ,'CODIGO OCORRÊNCIA PROCESSAMENTO' ,2 ,123 ,'' ,2 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13241 ,837 ,'n_conta_corrente' ,'Nº CONTA CORRENTE' ,2 ,125 ,'' ,16 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13242 ,837 ,'cpf' ,'CPF' ,1 ,141 ,'' ,14 ,'f' ,'t' ,'d' ,'' ,0 );
update db_layoutcampos set db52_codigo = 13236 , db52_layoutlinha = 837 , db52_nome = 'n_prestacao' , db52_descr = 'Nº PRESTAÇÃO' , db52_layoutformat = 2 , db52_posicao = 41 , db52_default = '' , db52_tamanho = 2 , db52_ident = 'f' , db52_imprimir = 't' , db52_alinha = 'e' , db52_obs = '' , db52_quebraapos = 0 where db52_codigo = 13236;
update db_layoutcampos set db52_posicao = db52_posicao+-16 where db52_layoutlinha = 837 and db52_posicao >= 41 and db52_codigo <> 13236;
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13243 ,837 ,'campo_reservado' ,'CAMPO RESERVADO' ,1 ,139 ,'' ,12 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 838 ,254 ,'REGISTRO' ,5 ,150 ,0 ,0 ,'' ,'' ,'1' );
update db_layoutlinha set db51_codigo = 837 , db51_layouttxt = 254 , db51_descr = 'DETALHE' , db51_tipolinha = 3 , db51_tamlinha = 150 , db51_linhasantes = 0 , db51_linhasdepois = 0 , db51_obs = '' , db51_separador = '' , db51_compacta = '0' where db51_codigo = 837;
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13244 ,838 ,'codigo_do_registro' ,'CODIGO_DO_REGISTRO' ,2 ,1 ,'3' ,1 ,'t' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13245 ,838 ,'codigo_convenente' ,'CÓDIGO CONVENENTE' ,2 ,2 ,'' ,5 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13246 ,838 ,'dv_convenente' ,'DV CONVENENTE' ,2 ,7 ,'' ,1 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13247 ,838 ,'n_extrato_convenente' ,'Nº EXTRATO CONVENENTE' ,2 ,8 ,'' ,3 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13248 ,838 ,'dv_extrato_convenente' ,'DV-EXTRATO CONVENENTE' ,2 ,11 ,'' ,1 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13249 ,838 ,'quantidade_registro' ,'QUANTIDADE REGISTRO' ,2 ,12 ,'' ,5 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13250 ,838 ,'valor_total_expectativa' ,'VALOR TOTAL EXPECTATIVA' ,2 ,17 ,'' ,17 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13251 ,838 ,'valor_total_rejeicoes' ,'VALOR TOTAL REJEIÇÕES' ,2 ,34 ,'' ,17 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13252 ,838 ,'valor_total_acatados' ,'VALOR TOTAL ACATADOS' ,2 ,51 ,'' ,17 ,'f' ,'t' ,'e' ,'' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13253 ,838 ,'campo_reservado' ,'CAMPO RESERVADO' ,2 ,68 ,'' ,83 ,'f' ,'t' ,'e' ,'' ,0 );


insert into pessoal.rhconsignadomotivo values (8, 'EXCLUIDO');
insert into pessoal.rhconsignadomotivo values (9, 'SALDO INSUFICIENTE');



select fc_executa_ddl('ALTER TABLE avaliacaopergunta ADD COLUMN db103_tipo int4  default 1 NOT NULL');
select fc_executa_ddl('ALTER TABLE avaliacaopergunta ADD COLUMN db103_mascara  varchar(40)');

select fc_executa_ddl('insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values
  ( 21839 ,''db103_tipo'' ,''int4'' ,''Tipo de dado para criação do formulário.'' ,'''' ,''Tipo'' ,5 ,''false'' ,''false'' ,''false'' ,1 ,''text'' ,''Tipo'' ),
  ( 21840 ,''db103_mascara'' ,''varchar(40)'' ,''Máscara para geração do formulário.'' ,'''' ,''Máscara'' ,40 ,''true'' ,''true'' ,''false'' ,0 ,''text'' ,''Máscara'' );');
                              
select fc_executa_ddl('insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values
  ( 2983 ,21839 , 9 ,0 ),     
  ( 2983 ,21840 ,10 ,0 );');  
                                                                                                                                                                                         
select fc_executa_ddl('insert into db_sysforkey values(3923,21791,1,2983,0);');
select fc_executa_ddl('insert into db_sysforkey values(3923,21790,1,3820,0);');

select fc_executa_ddl('ALTER TABLE avaliacaoperguntadb_formulas
  ADD CONSTRAINT db_formulas_fk
  FOREIGN KEY (eso01_db_formulas) REFERENCES db_formulas;');

select fc_executa_ddl('ALTER TABLE avaliacaoperguntadb_formulas
  ADD CONSTRAINT avaliacaopergunta_fk
  FOREIGN KEY (eso01_avaliacaopergunta) REFERENCES avaliacaopergunta;');

--
-- avaliacaotipo;
--
select fc_executa_ddl('INSERT INTO avaliacaotipo values(5, \'eSocial\');');

--
-- avaliacao;
--
select fc_executa_ddl('INSERT INTO avaliacao VALUES (3000008, 5, \'eSocial S2100\', \'\', true, \'esocial_s2100\')');


--
-- Data for Name: avaliacaogrupopergunta; Type: TABLE DATA; Schema: habitacao; Owner: postgres
--
select fc_executa_ddl('INSERT INTO avaliacaogrupopergunta 
  (db102_sequencial, db102_avaliacao, db102_descricao, db102_identificador) 
  VALUES 
  (3000036, 3000008, \'Dados de Nascimento\', \'dados_nascimento\'),
  (3000037, 3000008, \'Registro de Indentidade Civil (RIC)\', \'registro_identidade\'),
  (3000038, 3000008, \'Carteira de Trabalho (CTPS)\', \'carteira_trabalho\'),
  (3000039, 3000008, \'Registro Geral (RG)\', \'registro_geral\'),
  (3000040, 3000008, \'Registro Nacional Estrangeiro (RNE)\', \'registro_naciona_estrangeiro\'),
  (3000041, 3000008, \'Órgão de Classe (OC)\', \'orgao_classe\'),
  (3000042, 3000008, \'Carteira Nacional de Habilitação (CNH)\', \'carteira_nacional_habilitacao\'),
  (3000043, 3000008, \'Endereço\', \'endereco\'),
  (3000044, 3000008, \'Trabalhador Estrangeiro (caso seja estrangeiro)\', \'trabalhador_estrangeiro\'),
  (3000045, 3000008, \'Trabalhador com deficiência(caso possua)\', \'trabalhador_deficiencia\'),
  (3000046, 3000008, \'Informações de Readaptação(caso possua)\', \'informacoes_readaptacao\'),
  (3000047, 3000008, \'Dependente 1 (Sal. Família e/ou IRRF)\', \'dependente1\'),
  (3000048, 3000008, \'Dependente 2 (Sal. Família e/ou IRRF)\', \'dependente2\'),
  (3000049, 3000008, \'Dependente 3 (Sal. Família e/ou IRRF)\', \'dependente3\'),
  (3000050, 3000008, \'Dependente 4 (Sal. Família e/ou IRRF)\', \'dependente4\'),
  (3000051, 3000008, \'Dependente 5 (Sal. Família e/ou IRRF)\', \'dependente5\'),
  (3000052, 3000008, \'Dependente 6 (Sal. Família e/ou IRRF)\', \'dependente6\'),
  (3000053, 3000008, \'Dependente 7 (Sal. Família e/ou IRRF)\', \'dependente7\'),
  (3000054, 3000008, \'Dependente 8 (Sal. Família e/ou IRRF)\', \'dependente8\'),
  (3000055, 3000008, \'Dependente 9 (Sal. Família e/ou IRRF)\', \'dependente9\'),
  (3000056, 3000008, \'Dependente 10 (Sal. Família e/ou IRRF)\', \'dependente10\'),
  (3000057, 3000008, \'Aposentadoria\', \'aposentadoria\'),
  (3000058, 3000008, \'Informações de Contato\', \'informacoes_contato\'),
  (3000059, 3000008, \'Vínculo de Trabalho\', \'vinculo_trabalho\'),
  (3000060, 3000008, \'Celetista\', \'celetista\'),
  (3000061, 3000008, \'Estatutário\', \'estatutario\'),
  (3000062, 3000008, \'Contrato temporário\', \'contrato_temporario\'),
  (3000063, 3000008, \'Dados do Vínculo\', \'dados_vinculo\'),
  (3000064, 3000008, \'Remuneração\', \'remuneracao\'),
  (3000065, 3000008, \'Local de Trabalho\', \'local_trabalho\'),
  (3000066, 3000008, \'Horário Contratual\', \'horario_contratual\'),
  (3000067, 3000008, \'Filiação Sindical\', \'filiacao_sindical\'),
  (3000035, 3000008, \'Dados Pessoais\', \'dados_pessoais\');');


--
-- Data for Name: avaliacaopergunta; Type: TABLE DATA; Schema: habitacao; Owner: postgres
--
select fc_executa_ddl('INSERT INTO avaliacaopergunta 
  (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao, db103_obrigatoria, db103_ativo, db103_ordem, db103_identificador, db103_tipo, db103_mascara) 
VALUES 
  (3000232, 1, 3000044, \'Classificação da Condição\', false, true, 2, \'classificacao_condicao\', 6, \'\'),
  (3000231, 1, 3000046, \'Readaptado\', false, true, 2, \'readaptado\', 1, \'\'),
  (3000233, 1, 3000047, \'Qualidade do Dependente:\', true, true, 1, \'qualidade_dependente_1\', 6, \'\'),
  (3000235, 1, 3000047, \'Tipo de Dependente:\', true, true, 2, \'tipo_dependente_1\', 1, \'\'),
  (3000236, 1, 3000044, \'Casado com brasileiro\', false, true, 3, \'casado_brasileiro\', 1, \'\'),
  (3000237, 1, 3000044, \'Tem filhos brasileiros\', false, true, 4, \'filhos_brasileiros\', 1, \'\'),
  (3000238, 1, 3000045, \'Indicar se é portador de Deficiência\', false, true, 1, \'portador_deficiencia\', 1, \'\'),
  (3000239, 3, 3000045, \'Que tipo de Deficiência\', false, true, 2, \'tipo_deficiencia\', 1, \'\'),
  (3000240, 2, 3000047, \'Nome do Dependente:\', true, true, 3, \'nome_dependente_1\', 1, \'\'),
  (3000241, 2, 3000047, \'Data de Nascimento do Dependente:\', true, true, 4, \'data_nascimento_dependente_1\', 5, \'\'),
  (3000243, 2, 3000047, \'CPF do dependente (Obrigatório para maiores de 16 anos):\', false, true, 5, \'cpf_dependente_1\', 4, \'\'),
  (3000244, 1, 3000046, \'Reabilitado(INSS)\', false, true, 1, \'reabilitado\', 1, \'\'),
  (3000245, 1, 3000057, \'Por qual regime previdenciário?\', false, true, 3, \'por_qual_regime_previdenciario\', 6, \'\'),
  (3000246, 2, 3000044, \'Data da chegada ao Brasil\', false, true, 1, \'data_chegada_brasil\', 5, \'\'),
  (3000247, 2, 3000043, \'País\', true, true, 8, \'pais_endereco\', 1, \'\'),
  (3000248, 1, 3000057, \'Recebe aposentadoria especial (professor ou por exposição a agentes nocivos)?\', true, true, 2, \'aposentadoria_especial\', 6, \'\'),
  (3000249, 2, 3000043, \'Município\', true, true, 5, \'municipio\', 1, \'\'),
  (3000250, 1, 3000057, \'Recebe benefício de aposentadoria por contribuição ou idade?\', true, true, 1, \'aposentadoria_contribuicao_idade\', 6, \'\'),
  (3000251, 2, 3000043, \'CEP\', true, true, 6, \'cep\', 2, \'\'),
  (3000258, 2, 3000043, \'UF\', true, true, 7, \'endereco_uf\', 1, \'\'),
  (3000261, 2, 3000058, \'Email:\', false, true, 4, \'email\', 1, \'\'),
  (3000263, 2, 3000043, \'Complemento\', false, true, 3, \'complemento\', 1, \'\'),
  (3000266, 2, 3000058, \'Email alternativo:\', false, true, 5, \'email_alternativo\', 1, \'\'),
  (3000270, 2, 3000043, \'Bairro\', false, true, 4, \'bairro\', 1, \'\'),
  (3000272, 2, 3000058, \'Telefone Residencial:\', false, true, 1, \'telefone_residencial\', 6, \'\'),
  (3000273, 2, 3000043, \'Nome do Logradouro\', true, true, 1, \'nome_logradouro\', 1, \'\'),
  (3000274, 2, 3000058, \'Telefone Celular:\', false, true, 2, \'telefone_celular\', 6, \'\'),
  (3000275, 2, 3000058, \'Telefone alternativo (caso possua mais de um número)\', false, true, 3, \'telefone_alternativo\', 6, \'\'),
  (3000276, 2, 3000043, \'Número\', true, true, 2, \'numero\', 6, \'\'),
  (3000277, 2, 3000059, \'Matrícula ou CGM\', true, true, 1, \'matricula\', 6, \'\'),
  (3000278, 2, 3000042, \'Data de Expedição\', false, true, 2, \'cnh_data_expedicao\', 5, \'\'),
  (3000279, 1, 3000059, \'Regime de Trabalho\', true, true, 2, \'regime_trabalho\', 6, \'\'),
  (3000280, 2, 3000042, \'UF\', true, true, 1, \'cnh_uf\', 1, \'\'),
  (3000281, 2, 3000042, \'Data Validade\', true, true, 3, \'cnh_data_validade\', 5, \'\'),
  (3000282, 1, 3000059, \'Regime Previdenciário:\', true, true, 3, \'regime_previdenciario\', 6, \'\'),
  (3000288, 2, 3000042, \'Data da primeira habilitação\', false, true, 5, \'cnh_data_primeira_habilitacao\', 5, \'\'),
  (3000289, 2, 3000036, \'Munícipio de Nascimento\', false, true, 2, \'municipio_nascimento\', 1, \'\'),
  (3000291, 2, 3000042, \'Categoria CNH\', true, true, 6, \'cnh_categoria\', 1, \'\'),
  (3000292, 2, 3000036, \'País\', true, true, 4, \'pais\', 1, \'\'),
  (3000293, 1, 3000060, \'Optante pelo FGTS:\', true, true, 8, \'fgts\', 6, \'\'),
  (3000294, 2, 3000036, \'Nome da Mãe\', false, true, 5, \'nome_mae\', 1, \'\'),
  (3000295, 2, 3000041, \'Data de Validade\', false, true, 4, \'oc_data_validade\', 5, \'\'),
  (3000296, 2, 3000036, \'Nome do Pai\', false, true, 6, \'nome_pai\', 1, \'\'),
  (3000297, 1, 3000063, \'Duração do contrato de trabalho:\', true, true, 4, \'duracao_contrato_trabalho\', 1, \'\'),
  (3000298, 2, 3000042, \'Número do Registro da CNH\', true, true, 1, \'cnh_numero_registro_cnh\', 6, \'\'),
  (3000299, 2, 3000038, \'Número da CTPS\', true, true, 1, \'numero_ctps\', 6, \'\'),
  (3000300, 2, 3000038, \'Série\', true, true, 2, \'serie\', 6, \'\'),
  (3000301, 2, 3000040, \'Data Expedição\', false, true, 3, \'rne_data_expedicao\', 5, \'\'),
  (3000302, 2, 3000062, \'Data da contratação:\', true, true, 1, \'data_contratacao\', 5, \'\'),
  (3000303, 2, 3000041, \'Número do Órgão Classe\', true, true, 1, \'numero_orgao_classe\', 1, \'\'),
  (3000304, 2, 3000041, \'Órgão Emissor\', true, true, 2, \'oc_orgao_emissor\', 1, \'\'),
  (3000305, 2, 3000038, \'UF\', true, true, 3, \'ctps_uf\', 1, \'\'),
  (3000306, 2, 3000060, \'CNPJ do Sindicato da Categoria Profissional:\', false, true, 7, \'cnpj_sindicato_profissional\', 3, \'\'),
  (3000330, 1, 3000048, \'Qualidade do Dependente:\', true, true, 1, \'qualidade_dependente_2\', 6, \'\'),
  (3000307, 2, 3000062, \'Data prevista para o término da contratação:\', false, true, 2, \'data_prevista_termino_contratacao\', 5, \'\'),
  (3000308, 2, 3000041, \'Data de Expedição\', false, true, 3, \'oc_data_expedicao\', 5, \'\'),
  (3000309, 2, 3000037, \'Número do RIC\', true, true, 1, \'numero_ric\', 6, \'\'),
  (3000310, 2, 3000037, \'Órgão Emissor\', true, true, 2, \'orgao_emissor\', 1, \'\'),
  (3000311, 2, 3000060, \'Data base da Revisão Geral Anual (Preenchimento pelo Município):\', false, true, 6, \'data_base_revisao_geral\', 5, \'\'),
  (3000312, 1, 3000062, \'Motivo da contratação (preenchimento pelo Município):\', false, true, 3, \'motivo_contratacao\', 1, \'\'),
  (3000313, 2, 3000037, \'Data da Expedição\', false, true, 3, \'data_expedicao\', 5, \'\'),
  (3000314, 2, 3000039, \'Número do RG\', true, true, 1, \'numero_rg\', 1, \'\'),
  (3000315, 2, 3000040, \'Número do RNE\', false, true, 1, \'numero_rne\', 1, \'\'),
  (3000316, 2, 3000040, \'Órgão Emissor\', false, true, 2, \'rne_orgao_emissor\', 1, \'\'),
  (3000317, 2, 3000039, \'Órgão Emissor\', true, true, 2, \'rg_orgao_emissor\', 1, \'\'),
  (3000318, 2, 3000060, \'Data da Admissão\', true, true, 1, \'data_admissao\', 5, \'\'),
  (3000319, 2, 3000062, \'Identificação do trabalhador substituído (preenchimento pelo Munícipio):\', false, true, 4, \'identificacao_trabalhador_substituido\', 6, \'\'),
  (3000320, 2, 3000039, \'Data Expedição\', false, true, 3, \'rg_data_expedicao\', 5, \'\'),
  (3000321, 1, 3000061, \'Indicativo de Provimento\', true, true, 1, \'indicativo_provimento\', 6, \'\'),
  (3000322, 1, 3000061, \'Tipo de Provimento\', true, true, 2, \'tipo_provimento\', 1, \'\'),
  (3000323, 2, 3000061, \'Data da Nomeação:\', true, true, 3, \'data_nomeacao\', 5, \'\'),
  (3000328, 2, 3000061, \'Data da Posse:\', true, true, 4, \'data_posse\', 5, \'\'),
  (3000329, 2, 3000061, \'Data do Exercício:\', true, true, 5, \'data_exercicio\', 5, \'\'),
  (3000324, 1, 3000060, \'Tipo de Admissão:\', true, true, 2, \'tipo_admissao\', 6, \'\'),
  (3000325, 1, 3000060, \'Indicativo de Admissão:\', true, true, 3, \'indicativo_admissao\', 6, \'\'),
  (3000326, 1, 3000060, \'Regime de Jornada de Trabalho\', true, true, 4, \'regime_jornada_trabalho\', 6, \'\'),
  (3000327, 1, 3000060, \'Natureza da Atividade:\', true, true, 5, \'natureza_atividade\', 1, \'\'),
  (3000331, 1, 3000048, \'Tipo de Dependente:\', true, true, 2, \'tipo_dependente_2\', 1, \'\'),
  (3000332, 2, 3000048, \'Nome do Dependente:\', true, true, 3, \'nome_dependente_2\', 1, \'\'),
  (3000333, 2, 3000048, \'Data de Nascimento do Dependente:\', true, true, 4, \'data_nascimento_dependente_2\', 5, \'\'),
  (3000334, 2, 3000048, \'CPF do dependente (Obrigatório para maiores de 16 anos):\', false, true, 5, \'cpf_dependente_2\', 4, \'\'),
  (3000335, 1, 3000049, \'Qualidade do Dependente:\', true, true, 1, \'qualidade_dependente_3\', 6, \'\'),
  (3000336, 1, 3000049, \'Tipo de Dependente:\', true, true, 2, \'tipo_dependente_3\', 1, \'\'),
  (3000337, 2, 3000049, \'Nome do Dependente:\', true, true, 3, \'nome_dependente_3\', 1, \'\'),
  (3000338, 2, 3000049, \'Data de Nascimento do Dependente:\', true, true, 4, \'data_nascimento_dependente_3\', 5, \'\'),
  (3000339, 2, 3000049, \'CPF do dependente (Obrigatório para maiores de 16 anos):\', false, true, 5, \'cpf_dependente_3\', 4, \'\'),
  (3000340, 1, 3000050, \'Qualidade do Dependente:\', true, true, 1, \'qualidade_dependente_4\', 6, \'\'),
  (3000341, 1, 3000050, \'Tipo de Dependente:\', true, true, 2, \'tipo_dependente_4\', 1, \'\'),
  (3000342, 2, 3000050, \'Nome do Dependente:\', true, true, 3, \'nome_dependente__4\', 1, \'\'),
  (3000343, 2, 3000050, \'Data de Nascimento do Dependente:\', true, true, 4, \'data_nascimento_dependente_4\', 5, \'\'),
  (3000344, 2, 3000050, \'CPF do dependente (Obrigatório para maiores de 16 anos):\', false, true, 5, \'cpf_dependente_4\', 4, \'\'),
  (3000345, 1, 3000051, \'Qualidade do Dependente:\', true, true, 1, \'qualidade_dependente_5\', 6, \'\'),
  (3000346, 1, 3000051, \'Tipo de Dependente:\', true, true, 2, \'tipo_dependente_5\', 1, \'\'),
  (3000347, 2, 3000051, \'Nome do Dependente:\', true, true, 3, \'nome_dependente_5\', 1, \'\'),
  (3000226, 2, 3000035, \'Nome\', true, true, 1, \'nome\', 1, \'\'),
  (3000227, 2, 3000035, \'CPF\', true, true, 2, \'cpf\', 4, \'\'),
  (3000228, 2, 3000035, \'PIS/PASEP/NIS\', true, true, 3, \'pis_pasep_nis\', 6, \'\'),
  (3000229, 1, 3000035, \'Sexo\', true, true, 4, \'sexo\', 1, \'\'),
  (3000230, 1, 3000035, \'Raça/Cor\', true, true, 5, \'raca_cor\', 1, \'\'),
  (3000234, 2, 3000067, \'CNPJ do Sindicado\', false, true, 1, \'cnpj_sindicato\', 3, \'\'),
  (3000242, 2, 3000066, \'Quantidade média de horas (preenchimento pelo Município)\', false, true, 1, \'quantidade_media_horas\', 6, \'\'),
  (3000252, 1, 3000066, \'Tipos de jornada:\', true, true, 2, \'tipos_jornada\', 6, \'\'),
  (3000253, 1, 3000035, \'Estado Civil:\', true, true, 6, \'estado_civil\', 1, \'\'),
  (3000254, 2, 3000066, \'Informações diárias do horário contratual:\', true, true, 3, \'informacoes_diarias_horario_contratual\', 6, \'\'),
  (3000255, 2, 3000066, \'Segunda-feira:\', false, true, 4, \'segunda_feira\', 9, \'\'),
  (3000256, 2, 3000066, \'Terça-feira:\', false, true, 5, \'terca_feira\', 9, \'\'),
  (3000257, 2, 3000066, \'Quarta-feira:\', false, true, 6, \'quarta_feira\', 9, \'\'),
  (3000259, 1, 3000035, \'Grau Instrução:\', true, true, 7, \'grau_instrucao\', 1, \'\'),
  (3000260, 2, 3000066, \'Domingo:\', false, true, 10, \'domingo\', 9, \'\'),
  (3000262, 2, 3000066, \'Dia variável:\', false, true, 11, \'dia_variavel\', 9, \'\'),
  (3000264, 2, 3000066, \'Quinta-feira:\', false, true, 7, \'quinta_feira\', 9, \'\'),
  (3000265, 2, 3000066, \'Sexta-feira:\', false, true, 8, \'sexta_feira\', 9, \'\'),
  (3000267, 2, 3000066, \'Sábado:\', false, true, 9, \'sabado\', 9, \'\'),
  (3000268, 2, 3000065, \'Lotação:\', false, true, 1, \'lotacao\', 1, \'\'),
  (3000269, 2, 3000065, \'Endereço (se fora da sede da Prefeitura):\', false, true, 2, \'endereco\', 1, \'\'),
  (3000271, 2, 3000064, \'Remuneração\', true, true, 1, \'remuneracao\', 8, \'\'),
  (3000283, 1, 3000064, \'Unidade de Pagamento:\', true, true, 2, \'unidade_pagamento\', 1, \'\'),
  (3000284, 2, 3000063, \'Nome e código do Cargo:\', false, true, 1, \'nome_codigo_cargo\', 1, \'\'),
  (3000285, 2, 3000063, \'Nome e código da Função\', false, true, 2, \'nome_codigo_funcao\', 1, \'\'),
  (3000286, 1, 3000063, \'Código da Categoria:\', true, true, 3, \'codigo_categoria\', 1, \'\'),
  (3000287, 2, 3000036, \'Data de Nascimento\', true, true, 1, \'data_nascimento\', 5, \'\'),
  (3000290, 2, 3000036, \'UF\', false, true, 3, \'uf\', 1, \'\'),
  (3000348, 2, 3000051, \'Data de Nascimento do Dependente:\', true, true, 4, \'data_nascimento_dependente_5\', 5, \'\'),
  (3000349, 2, 3000051, \'CPF do dependente (Obrigatório para maiores de 16 anos):\', false, true, 5, \'cpf_dependente_5\', 4, \'\'),
  (3000350, 1, 3000052, \'Qualidade do Dependente:\', true, true, 1, \'qualidade_dependente_6\', 6, \'\'),
  (3000351, 1, 3000052, \'Tipo de Dependente:\', true, true, 2, \'tipo_dependente_6\', 1, \'\'),
  (3000352, 2, 3000052, \'Nome do Dependente:\', true, true, 3, \'nome_dependente_6\', 1, \'\'),
  (3000353, 2, 3000052, \'Data de Nascimento do Dependente:\', true, true, 4, \'data_nascimento_dependente_6\', 5, \'\'),
  (3000354, 2, 3000052, \'CPF do dependente (Obrigatório para maiores de 16 anos):\', false, true, 5, \'cpf_dependente_6\', 4, \'\'),
  (3000355, 1, 3000053, \'Qualidade do Dependente:\', true, true, 1, \'qualidade_dependente_7\', 6, \'\'),
  (3000356, 1, 3000053, \'Tipo de Dependente:\', true, true, 2, \'tipo_dependente_7\', 1, \'\'),
  (3000357, 2, 3000053, \'Nome do Dependente:\', true, true, 3, \'nome_dependente__7\', 1, \'\'),
  (3000358, 2, 3000053, \'Data de Nascimento do Dependente:\', true, true, 4, \'data_nascimento_dependente_7\', 5, \'\'),
  (3000359, 2, 3000053, \'CPF do dependente (Obrigatório para maiores de 16 anos):\', false, true, 5, \'cpf_dependente_7\', 4, \'\'),
  (3000360, 1, 3000054, \'Qualidade do Dependente:\', true, true, 1, \'qualidade_dependente_8\', 6, \'\'),
  (3000361, 1, 3000054, \'Tipo de Dependente:\', true, true, 2, \'tipo_dependente_8\', 1, \'\'),
  (3000362, 2, 3000054, \'Nome do Dependente:\', true, true, 3, \'nome_dependente_8\', 1, \'\'),
  (3000363, 2, 3000054, \'Data de Nascimento do Dependente:\', true, true, 4, \'data_nascimento_dependente_8\', 5, \'\'),
  (3000364, 2, 3000054, \'CPF do dependente (Obrigatório para maiores de 16 anos):\', false, true, 5, \'cpf_dependente_8\', 4, \'\'),
  (3000365, 1, 3000055, \'Qualidade do Dependente:\', true, true, 1, \'qualidade_dependente_9\', 6, \'\'),
  (3000366, 1, 3000055, \'Tipo de Dependente:\', true, true, 2, \'tipo_dependente_9\', 1, \'\'),
  (3000367, 2, 3000055, \'Nome do Dependente:\', true, true, 3, \'nome_dependente_9\', 1, \'\'),
  (3000368, 2, 3000055, \'Data de Nascimento do Dependente:\', true, true, 4, \'data_nascimento_dependente_9\', 5, \'\'),
  (3000369, 2, 3000055, \'CPF do dependente (Obrigatório para maiores de 16 anos):\', false, true, 5, \'cpf_dependente_9\', 4, \'\'),
  (3000370, 1, 3000056, \'Qualidade do Dependente:\', true, true, 1, \'qualidade_dependente_10\', 6, \'\'),
  (3000371, 1, 3000056, \'Tipo de Dependente:\', true, true, 2, \'tipo_dependente_10\', 1, \'\'),
  (3000372, 2, 3000056, \'Nome do Dependente:\', true, true, 3, \'nome_dependente__10\', 1, \'\'),
  (3000373, 2, 3000056, \'Data de Nascimento do Dependente:\', true, true, 4, \'data_nascimento_dependente_10\', 5, \'\'),
  (3000374, 2, 3000056, \'CPF do dependente (Obrigatório para maiores de 16 anos):\', false, true, 5, \'cpf_dependente_10\', 4, \'\');');

--
-- Data for Name: avaliacaoperguntaopcao; Type: TABLE DATA; Schema: habitacao; Owner: postgres
select fc_executa_ddl('INSERT INTO avaliacaoperguntaopcao 
  (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto, db104_identificador, db104_peso) 
VALUES
  (3001097, 3000236, \'Sim\', false, \'filhos_sim\', 0),
  (3000919, 3000226, NULL, true, \'nome_2\', 0),
  (3000920, 3000227, NULL, true, \'cpf_2\', 0),
  (3000921, 3000228, NULL, true, \'pis_pasep_nis_2\', 0),
  (3000922, 3000229, \'Feminino\', false, \'feminino\', 0),
  (3000923, 3000229, \'Masculino\', false, \'masculino\', 0),
  (3000924, 3000230, \'Branca\', false, \'branca\', 0),
  (3000925, 3000230, \'Negra\', false, \'negra\', 0),
  (3000926, 3000230, \'Parda\', false, \'parda\', 0),
  (3000927, 3000230, \'Amarela\', false, \'amarela\', 0),
  (3000928, 3000230, \'Indígena\', false, \'indigena\', 0),
  (3000929, 3000230, \'Não informado\', false, \'nao_informado\', 0),
  (3000930, 3000234, NULL, true, \'cnpj_sindicato_2\', 0),
  (3000931, 3000242, NULL, true, \'quantidade_media_horas_2\', 0),
  (3000932, 3000252, \'Jornada semanal com apenas um horário padrão por dia da semana e folga fixa\', false, \'jornada_semananal_padrao_semana_folga_fixa\', 0),
  (3000933, 3000253, \'Solteiro/União Estável\', false, \'solteiro\', 0),
  (3000934, 3000253, \'Casado\', false, \'casado\', 0),
  (3000935, 3000252, \'Demais tipos de jornada (escala, turno de revezamento, permutas, horários rotativos) Nesse caso, descrever o tipo de jornada. (Exemplo: escala, 12 x 36):\'\'\', true, \'demais_tipos_jornada\', 0),
  (3000936, 3000253, \'Divorciado\', false, \'divorciado\', 0),
  (3000937, 3000253, \'Separado\', false, \'separado\', 0),
  (3000938, 3000253, \'Viúvo\', false, \'viuvo\', 0),
  (3000939, 3000254, NULL, true, \'informacoes_diarias_horario_contratual_2\', 0),
  (3000940, 3000255, NULL, true, \'segunda_feira_2\', 0),
  (3000941, 3000256, NULL, true, \'terca_feira_2\', 0),
  (3000942, 3000257, NULL, true, \'quarta_feira_2\', 0),
  (3000943, 3000264, NULL, true, \'quinta_feira_2\', 0),
  (3000944, 3000265, NULL, true, \'sexta_feira_2\', 0),
  (3000945, 3000267, NULL, true, \'sabado_2\', 0),
  (3000946, 3000260, NULL, true, \'domingo_2\', 0),
  (3000947, 3000262, NULL, true, \'dia_variavel_2\', 0),
  (3000948, 3000259, \'Analfabeto, inclusive o que, embora tenha recebido instrução, não se alfabetizou\', false, \'analfabeto\', 0),
  (3000949, 3000268, NULL, true, \'lotacao_2\', 0),
  (3000950, 3000269, NULL, true, \'endereco_2\', 0),
  (3000951, 3000271, NULL, true, \'remuneracao_2\', 0),
  (3000952, 3000283, \'Por hora\', false, \'por_hora\', 0),
  (3000953, 3000283, \'Por dia\', false, \'por_dia\', 0),
  (3000954, 3000283, \'Por semana\', false, \'por_semana\', 0),
  (3000955, 3000283, \'Por quinzena\', false, \'por_quinzena\', 0),
  (3000956, 3000283, \'Por mês\', false, \'por_mes\', 0),
  (3000957, 3000283, \'Por tarefa\', false, \'por_tarefa\', 0),
  (3000958, 3000283, \'Não aplicável (no caso de salário exclusivamente variável)\', false, \'nao_aplicavel\', 0),
  (3000959, 3000259, \'Até o 5º ano incompleto do Ensino Fundamental (antiga 4º série) ou que se tenha alfabetizado sem ter frequentado escola regular\', false, \'quinto_ano_oncompleto\', 0),
  (3000960, 3000259, \'5º ano completodo Ensino Fundamental\', false, \'ano_completo_ensino_fundamental\', 0),
  (3000961, 3000259, \'Do 6º ao 9º do Ensino Fundamental Incompleto(antiga 5º a 8º série)\', false, \'ensino_fundamental_incompleto\', 0),
  (3000962, 3000284, NULL, true, \'nome_codigo_cargo_2\', 0),
  (3000963, 3000285, NULL, true, \'nome_codigo_funcao_2\', 0),
  (3000964, 3000259, \'Ensino Fundamental Completo\', false, \'ensino_fundamental_completo\', 0),
  (3000965, 3000259, \'Ensino Médio Incompleto\', false, \'ensino_medio_incompleto\', 0),
  (3000966, 3000286, \'101 - Empregado regido pela CLT, inclusive o estabilizado (com FGTS)\', false, \'empregado_clt\', 0),
  (3000967, 3000259, \'Ensino Médio Completo\', false, \'ensino_medio_completo\', 0),
  (3000968, 3000286, \'301 - Servidor público titular de cargo efetivo\', false, \'servidor_efetivo\', 0),
  (3000969, 3000286, \'302 - Servidor público ocupante de cargo exclusivo em comissão\', false, \'servidor_cargo_exclusivo_comissao\', 0),
  (3000970, 3000286, \'303 - Agente público\', false, \'agente_publico\', 0),
  (3000971, 3000259, \'Educação Superior Incompleta\', false, \'educacao_superior_incompleta\', 0),
  (3000972, 3000286, \'305- Servidor público indicado para conselho ou órgão representativo, na condição de representante do governo, órgão ou entidade da administração pública\', false, \'servidor_publico__conselho_representante_governo\', 0),
  (3000973, 3000259, \'Educação Superior Completa\', false, \'educacao_superior_completa\', 0),
  (3000974, 3000259, \'Pós-graduação Completa\', false, \'pos_graduacao_completa\', 0),
  (3000975, 3000286, \'306 - Servidor contratado por prazo determinado, na forma do art. 37, IX, da CR.\', false, \'servidor_contratado\', 0),
  (3000976, 3000259, \'Mestrado Completo\', false, \'mestrado_completo\', 0),
  (3000977, 3000259, \'Doutorado Completo\', false, \'doutorado_completo\', 0),
  (3000978, 3000286, \'309 - Agente público\', false, \'agente_publico_309\', 0),
  (3000979, 3000286, \'701 - Contribuinte individual ( Autônomo)\', false, \'contribuinte_individual_autonomo\', 0),
  (3000980, 3000287, NULL, true, \'data_nascimento_2\', 0),
  (3000981, 3000289, NULL, true, \'municipio_nascimento_2\', 0),
  (3000982, 3000286, \'711 - Contribuinte individual Transportador Autônomo (com base reduzida)\', false, \'contribuinte_individual_transportador_autonomo\', 0),
  (3000983, 3000290, NULL, true, \'uf_2\', 0),
  (3000984, 3000292, NULL, true, \'pais_2\', 0),
  (3000985, 3000286, \'741 - Contribuinte individual - Microempreendedor Individual\', false, \'contribuinte_individual_microempreendedor\', 0),
  (3000986, 3000294, NULL, true, \'nome_mae_2\', 0),
  (3000987, 3000286, \'771 - Membro do Conselho Tutelar\', false, \'membro_conselho_tutelar\', 0),
  (3000988, 3000286, \'901 - Estagiário\', false, \'estagiario\', 0),
  (3000989, 3000296, NULL, true, \'nome_pai_2\', 0),
  (3000990, 3000286, \'410 - Trabalhador Cedido (quando o Município é o cessionário - que recebe)\', false, \'trabalhador_cedido\', 0),
  (3000991, 3000297, \'Prazo indeterminado\', false, \'prazo_indeterminado\', 0),
  (3000992, 3000299, NULL, true, \'numero_ctps_2\', 0),
  (3000993, 3000297, \'Prazo determinado\', false, \'prazo_determinado\', 0),
  (3000994, 3000300, NULL, true, \'serie_2\', 0),
  (3000995, 3000302, NULL, true, \'data_contratacao_2\', 0),
  (3000996, 3000305, NULL, true, \'ctps_uf_2\', 0),
  (3000997, 3000307, NULL, true, \'data_prevista_termino_contratacao_2\', 0),
  (3000998, 3000309, NULL, true, \'numero_ric_2\', 0),
  (3000999, 3000310, NULL, true, \'orgao_emissor_2\', 0),
  (3001000, 3000313, NULL, true, \'data_expedicao_2\', 0),
  (3001001, 3000312, \'Necessidade transitória de substituição de seu pessoal regular\', false, \'necessidade_transitoria_susbstituicao_pessoal\', 0),
  (3001002, 3000314, NULL, true, \'numero_rg_2\', 0),
  (3001003, 3000312, \'Acréscimo extaordinário de serviços\', false, \'acrescimo_extraordinario_servicos\', 0),
  (3001004, 3000317, NULL, true, \'rg_orgao_emissor_2\', 0),
  (3001005, 3000319, NULL, true, \'identificacao_trabalhador_substituido_2\', 0),
  (3001006, 3000320, NULL, true, \'rg_data_expedicao_2\', 0),
  (3001007, 3000321, \'Normal\', false, \'normal\', 0),
  (3001008, 3000321, \'Decorrente de Decisão Judicial\', false, \'decorrente_decisao_judicial\', 0),
  (3001009, 3000321, \'Tomou posse mas não entrou em exercício\', false, \'posse_nao_exercicio\', 0),
  (3001010, 3000322, \'Nomeação em cargo efetivo\', false, \'nomeacao_cargo_efetivo\', 0),
  (3001011, 3000322, \'Nomeação em cargo em comissão\', false, \'nomeacao_cargo_comissao\', 0),
  (3001012, 3000322, \'Incorporação (militar)\', false, \'incorporacao\', 0),
  (3001013, 3000322, \'Matrícula (militar)\', false, \'matricula\', 0),
  (3001014, 3000322, \'Reinclusão (militar)\', false, \'reinclusao\', 0),
  (3001015, 3000322, \'Outros não relacionados acima. Nesse caso, qual:\', true, \'outros_qual\', 0),
  (3001016, 3000323, NULL, true, \'data_nomeacao_2\', 0),
  (3001017, 3000328, NULL, true, \'data_posse_2\', 0),
  (3001018, 3000329, NULL, true, \'data_exercicio_2\', 0),
  (3001019, 3000318, NULL, true, \'data_admissao_2\', 0),
  (3001020, 3000324, \'Admissão\', false, \'admissao\', 0),
  (3001021, 3000324, \'Transferência de empresa do mesmo grupo econômico\', false, \'transferencia_empresa_mesmo_grupo_economico\', 0),
  (3001022, 3000324, \'Transferência de empresa consorciada ou de consórcio\', false, \'transferencia_empresa_consorciada_consorcio\', 0),
  (3001023, 3000324, \'Transferência por motivo de sucessão, incorporação, cisão ou fusão\', false, \'transferencia_sucessao_incorporacao_cisao_fusao\', 0),
  (3001024, 3000325, \'Normal\', false, \'admissao_normal\', 0),
  (3001025, 3000325, \'Decorrente de Ação Fiscal\', false, \'decorrente_acao_fiscal\', 0),
  (3001026, 3000325, \'Decorrente de Ação Judicial\', false, \'decorrente_acao_judicial\', 0),
  (3001027, 3000326, \'Submetido a horário de trabalho\', false, \'submetido_horario_trabalho\', 0),
  (3001028, 3000326, \'Atividade externa especificada no art. 62, I, da CLT\', false, \'atividade_externa\', 0),
  (3001029, 3000326, \'Funções especificadas no inciso II do art. 62, da CLT\', false, \'funcoes_especificadas\', 0),
  (3001030, 3000327, \'Trabalho Urbano\', false, \'trabalho_urbano\', 0),
  (3001031, 3000327, \'Trabalho Rural (Obs: Empregado rural é que exerce atividade agro-econômico, na agricultura ou na pecurária)\', false, \'trabalho_rural\', 0),
  (3001032, 3000311, NULL, true, \'data_base_revisao_geral_2\', 0),
  (3001033, 3000315, NULL, true, \'numero_rne_2\', 0),
  (3001034, 3000316, NULL, true, \'rne_orgao_emissor_2\', 0),
  (3001035, 3000301, NULL, true, \'rne_data_expedicao_2\', 0),
  (3001036, 3000303, NULL, true, \'numero_orgao_classe_2\', 0),
  (3001037, 3000304, NULL, true, \'oc_orgao_emissor_2\', 0),
  (3001038, 3000306, NULL, true, \'cnpj_sindicato_profissional_2\', 0),
  (3001039, 3000308, NULL, true, \'oc_data_expedicao_2\', 0),
  (3001040, 3000295, NULL, true, \'fgts_2\', 0),
  (3001041, 3000293, NULL, true, \'oc_data_validade_2\', 0),
  (3001042, 3000293, \'Sim ( obrigatoriamente se admitido depois de 04/10/88.\', false, \'optante_sim\', 0),
  (3001043, 3000293, \'Não\', false, \'optante_nao\', 0),
  (3001044, 3000298, NULL, true, \'cnh_numero_registro_cnh_2\', 0),
  (3001045, 3000277, NULL, true, \'matricula_2\', 0),
  (3001046, 3000278, NULL, true, \'cnh_data_expedicao_2\', 0),
  (3001047, 3000279, \'CLT - Consolidação das Leis do Trabalho\', false, \'clt\', 0),
  (3001048, 3000280, NULL, true, \'cnh_uf_2\', 0),
  (3001049, 3000279, \'RJP - Regime Jurídico Próprio\', false, \'rjp\', 0),
  (3001050, 3000281, NULL, true, \'cnh_data_validade_2\', 0),
  (3001051, 3000282, \'RGPS - Regime Geral de Previdência Social (INSS)\', false, \'rgps\', 0),
  (3001052, 3000282, \'RPPS - Regime Próprio de Previdência Social no Brasil (Fundo)\', false, \'rpps\', 0),
  (3001053, 3000282, \'RPPE - Regime Próprio de Previd&#7869;ncia Social no Exterior\', false, \'rppe\', 0),
  (3001054, 3000288, NULL, true, \'cnh_data_primeira_habilitacao_2\', 0),
  (3001055, 3000291, NULL, true, \'cnh_categoria_2\', 0),
  (3001056, 3000272, NULL, true, \'telefone_residencial_2\', 0),
  (3001057, 3000273, NULL, true, \'nome_logradouro_2\', 0),
  (3001058, 3000274, NULL, true, \'telefone_celular_2\', 0),
  (3001059, 3000275, NULL, true, \'telefone_alternativo_2\', 0),
  (3001060, 3000276, NULL, true, \'numero_2\', 0),
  (3001061, 3000261, NULL, true, \'email_2\', 0),
  (3001062, 3000263, NULL, true, \'complemento_2\', 0),
  (3001063, 3000266, NULL, true, \'email_alternativo_2\', 0),
  (3001064, 3000270, NULL, true, \'bairro_2\', 0),
  (3001065, 3000249, NULL, true, \'municipio_2\', 0),
  (3001066, 3000250, \'Sim\', false, \'aposentadoria_sim\', 0),
  (3001067, 3000251, NULL, true, \'cep_2\', 0),
  (3001068, 3000250, \'Não\', false, \'aposentadoria_nao\', 0),
  (3001069, 3000258, NULL, true, \'endereco_uf_2\', 0),
  (3001070, 3000247, NULL, true, \'pais_endereco_2\', 0),
  (3001071, 3000248, \'Sim\', false, \'aposentadoria_especial_sim\', 0),
  (3001072, 3000248, \'Não\', false, \'aposentadoria_especial_nao\', 0),
  (3001073, 3000245, \'RGPS (INSS)\', false, \'rgps_inss\', 0),
  (3001074, 3000245, \'RPPS (Fundo de Previdência)\', false, \'rpps_fundo\', 0),
  (3001075, 3000246, NULL, true, \'data_chegada_brasil_2\', 0),
  (3001076, 3000232, \'Visto Permanente\', false, \'visto_permanente\', 0),
  (3001077, 3000232, \'Visto Temporário\', false, \'visto_temporario\', 0),
  (3001078, 3000232, \'Asilado\', false, \'asilado\', 0),
  (3001080, 3000232, \'Refugiado\', false, \'refugiado\', 0),
  (3001082, 3000232, \'Solicitante de Refúgio\', false, \'solicitante_refugio\', 0),
  (3001083, 3000232, \'Residente em país fronteiriço ao Brasil\', false, \'residente_pais_fronteirico_brasil\', 0),
  (3001084, 3000232, \'Deficiente físico e com mais de 51 anos\', false, \'deficiente_fisico_51_anos\', 0),
  (3001087, 3000232, \'Com residência provisória e anistiado, em situação irregular\', false, \'residencia_provisoria_anistiado\', 0),
  (3001089, 3000232, \'Permanência no Brasil em razão de filhos ou cônjuge brasileiros\', false, \'permanencia_brasil_razao_filhos_conjuge_brasileiro\', 0),
  (3001091, 3000232, \'Beneficiado pelo acordo entre países do Mercosul\', false, \'beneficiado_pelo_acordo_paises_mercosul\', 0),
  (3001093, 3000232, \'Dependente de agente diplomático e/ou consular de países que mantém convênio de reciprocidade para o exercício de atividade remnerada no Brasil\', false, \'depentende_agente_diplomatico_paises_convenio\', 0),
  (3001094, 3000232, \'Beneficiado pelo Tratado de Amizade, Cooperação e Consulta entre a República Federativa do Brasil e a República Portuguesa\', false, \'beneficiado_tratado_amizade\', 0),
  (3001095, 3000238, \'Sim\', false, \'sim\', 0),
  (3001096, 3000238, \'Não\', false, \'nao\', 0),
  (3001098, 3000236, \'Não\', false, \'filhos_nao\', 0),
  (3001102, 3000237, \'Sim\', false, \'portador_sim\', 0),
  (3001104, 3000237, \'Não\', false, \'portador_nao\', 0),
  (3001108, 3000239, \'Física\', false, \'fisica\', 0),
  (3001109, 3000239, \'Visual\', false, \'visual\', 0),
  (3001111, 3000239, \'Auditiva\', false, \'auditiva\', 0),
  (3001112, 3000239, \'Mental\', false, \'mental\', 0),
  (3001114, 3000239, \'Intelectual\', false, \'intelectual\', 0),
  (3001116, 3000244, \'Sim\', false, \'reabilitado_sim\', 0),
  (3001117, 3000244, \'Não\', false, \'reabilitado_nao\', 0),
  (3001118, 3000231, \'Sim\', false, \'readaptado_sim\', 0),
  (3001119, 3000231, \'Não\', false, \'readaptado_nao\', 0),
  (3001081, 3000233, \'Imposto de Renda\', false, \'imposto_renda_001\', 0),
  (3001079, 3000233, \'Salário Família\', false, \'salario_familia_001\', 0),
  (3001107, 3000235, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, com idade até 24 anos, se ainda estiver cursando estabelecimento de nível superior ou escola técnica de 2º grau, desde que tenha detido sua guarda judicial até os 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_001\', 0),
  (3001106, 3000235, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, até 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_21_001\', 0),
  (3001105, 3000235, \'Ex-cônjuge que receba pensão de alimentos\', false, \'ex_conjuge_001\', 0),
  (3001103, 3000235, \'A pessoa absolutamente incapaz, da qual seja tutor ou curador\', false, \'pessoa_incapaz_001\', 0),
  (3001101, 3000235, \'Menor pobre, até 21 (vinte e um) anos, que crie e eduque e do qual detenha a guarda judicial\', false, \'menor_pobre_001\', 0),
  (3001100, 3000235, \'Pais, avós e bisavós\', false, \'pais_avos_bisavos_001\', 0),
  (3001099, 3000235, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'irmao_neto_bisneto_incapacitado_001\', 0),
  (3001092, 3000235, \'Filho(a) ou enteado(a) em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'filho_incapacitado_001\', 0),
  (3001090, 3000235, \'Filho(a) ou enteado(a) universitário(a) ou cursando escola técnica de 2º grau, até 24 (vinte e quatro) anos\', false, \'filho_24_001\', 0),
  (3001088, 3000235, \'Filho(a) ou enteado(a) até 21 (vinte e um) anos\', false, \'filho_21_001\', 0),
  (3001086, 3000235, \'Companheiro(a) com o(a) qual tenha filho ou viva há mais de 5 (cinco) anos\', false, \'companheiro_001\', 0),
  (3001085, 3000235, \'Cônjuge\', false, \'conjuge_001\', 0),
  (3001110, 3000240, NULL, true, \'nome_dependente_2_001\', 0),
  (3001113, 3000241, NULL, true, \'data_nascimento_dependente_2_001\', 0),
  (3001115, 3000243, NULL, true, \'cpf_dependente_2_001\', 0),
  (3001120, 3000330, \'Imposto de Renda\', false, \'imposto_renda_002\', 0),
  (3001121, 3000330, \'Salário Família\', false, \'salario_familia_002\', 0),
  (3001122, 3000331, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, com idade até 24 anos, se ainda estiver cursando estabelecimento de nível superior ou escola técnica de 2º grau, desde que tenha detido sua guarda judicial até os 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_002\', 0),
  (3001123, 3000331, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, até 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_21_002\', 0),
  (3001124, 3000331, \'Ex-cônjuge que receba pensão de alimentos\', false, \'ex_conjuge_002\', 0),
  (3001125, 3000331, \'A pessoa absolutamente incapaz, da qual seja tutor ou curador\', false, \'pessoa_incapaz_002\', 0),
  (3001126, 3000331, \'Menor pobre, até 21 (vinte e um) anos, que crie e eduque e do qual detenha a guarda judicial\', false, \'menor_pobre_002\', 0),
  (3001127, 3000331, \'Pais, avós e bisavós\', false, \'pais_avos_bisavos_002\', 0),
  (3001128, 3000331, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'irmao_neto_bisneto_incapacitado_002\', 0),
  (3001129, 3000331, \'Filho(a) ou enteado(a) em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'filho_incapacitado_002\', 0),
  (3001130, 3000331, \'Filho(a) ou enteado(a) universitário(a) ou cursando escola técnica de 2º grau, até 24 (vinte e quatro) anos\', false, \'filho_24_002\', 0),
  (3001131, 3000331, \'Filho(a) ou enteado(a) até 21 (vinte e um) anos\', false, \'filho_21_002\', 0),
  (3001132, 3000331, \'Companheiro(a) com o(a) qual tenha filho ou viva há mais de 5 (cinco) anos\', false, \'companheiro_002\', 0),
  (3001133, 3000331, \'Cônjuge\', false, \'conjuge_002\', 0),
  (3001134, 3000332, NULL, true, \'nome_dependente_2_002\', 0),
  (3001135, 3000333, NULL, true, \'data_nascimento_dependente_2_002\', 0),
  (3001136, 3000334, NULL, true, \'cpf_dependente_2_002\', 0),
  (3001137, 3000335, \'Imposto de Renda\', false, \'imposto_renda_003\', 0),
  (3001138, 3000335, \'Salário Família\', false, \'salario_familia_003\', 0),
  (3001139, 3000336, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, com idade até 24 anos, se ainda estiver cursando estabelecimento de nível superior ou escola técnica de 2º grau, desde que tenha detido sua guarda judicial até os 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_003\', 0),
  (3001140, 3000336, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, até 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_21_003\', 0),
  (3001141, 3000336, \'Ex-cônjuge que receba pensão de alimentos\', false, \'ex_conjuge_003\', 0),
  (3001142, 3000336, \'A pessoa absolutamente incapaz, da qual seja tutor ou curador\', false, \'pessoa_incapaz_003\', 0),
  (3001143, 3000336, \'Menor pobre, até 21 (vinte e um) anos, que crie e eduque e do qual detenha a guarda judicial\', false, \'menor_pobre_003\', 0),
  (3001144, 3000336, \'Pais, avós e bisavós\', false, \'pais_avos_bisavos_003\', 0),
  (3001145, 3000336, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'irmao_neto_bisneto_incapacitado_003\', 0),
  (3001146, 3000336, \'Filho(a) ou enteado(a) em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'filho_incapacitado_003\', 0),
  (3001147, 3000336, \'Filho(a) ou enteado(a) universitário(a) ou cursando escola técnica de 2º grau, até 24 (vinte e quatro) anos\', false, \'filho_24_003\', 0),
  (3001148, 3000336, \'Filho(a) ou enteado(a) até 21 (vinte e um) anos\', false, \'filho_21_003\', 0),
  (3001149, 3000336, \'Companheiro(a) com o(a) qual tenha filho ou viva há mais de 5 (cinco) anos\', false, \'companheiro_003\', 0),
  (3001150, 3000336, \'Cônjuge\', false, \'conjuge_003\', 0),
  (3001151, 3000337, NULL, true, \'nome_dependente_2_003\', 0),
  (3001152, 3000338, NULL, true, \'data_nascimento_dependente_2_003\', 0),
  (3001153, 3000339, NULL, true, \'cpf_dependente_2_003\', 0),
  (3001154, 3000340, \'Imposto de Renda\', false, \'imposto_renda_004\', 0),
  (3001155, 3000340, \'Salário Família\', false, \'salario_familia_004\', 0),
  (3001156, 3000341, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, com idade até 24 anos, se ainda estiver cursando estabelecimento de nível superior ou escola técnica de 2º grau, desde que tenha detido sua guarda judicial até os 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_004\', 0),
  (3001157, 3000341, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, até 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_21_004\', 0),
  (3001158, 3000341, \'Ex-cônjuge que receba pensão de alimentos\', false, \'ex_conjuge_004\', 0),
  (3001159, 3000341, \'A pessoa absolutamente incapaz, da qual seja tutor ou curador\', false, \'pessoa_incapaz_004\', 0),
  (3001160, 3000341, \'Menor pobre, até 21 (vinte e um) anos, que crie e eduque e do qual detenha a guarda judicial\', false, \'menor_pobre_004\', 0),
  (3001161, 3000341, \'Pais, avós e bisavós\', false, \'pais_avos_bisavos_004\', 0),
  (3001162, 3000341, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'irmao_neto_bisneto_incapacitado_004\', 0),
  (3001163, 3000341, \'Filho(a) ou enteado(a) em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'filho_incapacitado_004\', 0),
  (3001164, 3000341, \'Filho(a) ou enteado(a) universitário(a) ou cursando escola técnica de 2º grau, até 24 (vinte e quatro) anos\', false, \'filho_24_004\', 0),
  (3001165, 3000341, \'Filho(a) ou enteado(a) até 21 (vinte e um) anos\', false, \'filho_21_004\', 0),
  (3001166, 3000341, \'Companheiro(a) com o(a) qual tenha filho ou viva há mais de 5 (cinco) anos\', false, \'companheiro_004\', 0),
  (3001167, 3000341, \'Cônjuge\', false, \'conjuge_004\', 0),
  (3001168, 3000342, NULL, true, \'nome_dependente_2_004\', 0),
  (3001169, 3000343, NULL, true, \'data_nascimento_dependente_2_004\', 0),
  (3001170, 3000344, NULL, true, \'cpf_dependente_2_004\', 0),
  (3001171, 3000345, \'Imposto de Renda\', false, \'imposto_renda_005\', 0),
  (3001172, 3000345, \'Salário Família\', false, \'salario_familia_005\', 0),
  (3001173, 3000346, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, com idade até 24 anos, se ainda estiver cursando estabelecimento de nível superior ou escola técnica de 2º grau, desde que tenha detido sua guarda judicial até os 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_005\', 0),
  (3001174, 3000346, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, até 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_21_005\', 0),
  (3001175, 3000346, \'Ex-cônjuge que receba pensão de alimentos\', false, \'ex_conjuge_005\', 0),
  (3001176, 3000346, \'A pessoa absolutamente incapaz, da qual seja tutor ou curador\', false, \'pessoa_incapaz_005\', 0),
  (3001177, 3000346, \'Menor pobre, até 21 (vinte e um) anos, que crie e eduque e do qual detenha a guarda judicial\', false, \'menor_pobre_005\', 0),
  (3001178, 3000346, \'Pais, avós e bisavós\', false, \'pais_avos_bisavos_005\', 0),
  (3001179, 3000346, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'irmao_neto_bisneto_incapacitado_005\', 0),
  (3001180, 3000346, \'Filho(a) ou enteado(a) em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'filho_incapacitado_005\', 0),
  (3001181, 3000346, \'Filho(a) ou enteado(a) universitário(a) ou cursando escola técnica de 2º grau, até 24 (vinte e quatro) anos\', false, \'filho_24_005\', 0),
  (3001182, 3000346, \'Filho(a) ou enteado(a) até 21 (vinte e um) anos\', false, \'filho_21_005\', 0),
  (3001183, 3000346, \'Companheiro(a) com o(a) qual tenha filho ou viva há mais de 5 (cinco) anos\', false, \'companheiro_005\', 0),
  (3001184, 3000346, \'Cônjuge\', false, \'conjuge_005\', 0),
  (3001185, 3000347, NULL, true, \'nome_dependente_2_005\', 0),
  (3001186, 3000348, NULL, true, \'data_nascimento_dependente_2_005\', 0),
  (3001187, 3000349, NULL, true, \'cpf_dependente_2_005\', 0),
  (3001188, 3000350, \'Imposto de Renda\', false, \'imposto_renda_006\', 0),
  (3001189, 3000350, \'Salário Família\', false, \'salario_familia_006\', 0),
  (3001190, 3000351, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, com idade até 24 anos, se ainda estiver cursando estabelecimento de nível superior ou escola técnica de 2º grau, desde que tenha detido sua guarda judicial até os 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_006\', 0),
  (3001191, 3000351, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, até 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_21_006\', 0),
  (3001192, 3000351, \'Ex-cônjuge que receba pensão de alimentos\', false, \'ex_conjuge_006\', 0),
  (3001193, 3000351, \'A pessoa absolutamente incapaz, da qual seja tutor ou curador\', false, \'pessoa_incapaz_006\', 0),
  (3001194, 3000351, \'Menor pobre, até 21 (vinte e um) anos, que crie e eduque e do qual detenha a guarda judicial\', false, \'menor_pobre_006\', 0),
  (3001195, 3000351, \'Pais, avós e bisavós\', false, \'pais_avos_bisavos_006\', 0),
  (3001196, 3000351, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'irmao_neto_bisneto_incapacitado_006\', 0),
  (3001197, 3000351, \'Filho(a) ou enteado(a) em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'filho_incapacitado_006\', 0),
  (3001198, 3000351, \'Filho(a) ou enteado(a) universitário(a) ou cursando escola técnica de 2º grau, até 24 (vinte e quatro) anos\', false, \'filho_24_006\', 0),
  (3001199, 3000351, \'Filho(a) ou enteado(a) até 21 (vinte e um) anos\', false, \'filho_21_006\', 0),
  (3001200, 3000351, \'Companheiro(a) com o(a) qual tenha filho ou viva há mais de 5 (cinco) anos\', false, \'companheiro_006\', 0),
  (3001201, 3000351, \'Cônjuge\', false, \'conjuge_006\', 0),
  (3001202, 3000352, NULL, true, \'nome_dependente_2_006\', 0),
  (3001203, 3000353, NULL, true, \'data_nascimento_dependente_2_006\', 0),
  (3001204, 3000354, NULL, true, \'cpf_dependente_2_006\', 0),
  (3001205, 3000355, \'Imposto de Renda\', false, \'imposto_renda_007\', 0),
  (3001206, 3000355, \'Salário Família\', false, \'salario_familia_007\', 0),
  (3001207, 3000356, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, com idade até 24 anos, se ainda estiver cursando estabelecimento de nível superior ou escola técnica de 2º grau, desde que tenha detido sua guarda judicial até os 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_007\', 0),
  (3001208, 3000356, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, até 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_21_007\', 0),
  (3001209, 3000356, \'Ex-cônjuge que receba pensão de alimentos\', false, \'ex_conjuge_007\', 0),
  (3001210, 3000356, \'A pessoa absolutamente incapaz, da qual seja tutor ou curador\', false, \'pessoa_incapaz_007\', 0),
  (3001211, 3000356, \'Menor pobre, até 21 (vinte e um) anos, que crie e eduque e do qual detenha a guarda judicial\', false, \'menor_pobre_007\', 0),
  (3001212, 3000356, \'Pais, avós e bisavós\', false, \'pais_avos_bisavos_007\', 0),
  (3001213, 3000356, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'irmao_neto_bisneto_incapacitado_007\', 0),
  (3001214, 3000356, \'Filho(a) ou enteado(a) em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'filho_incapacitado_007\', 0),
  (3001215, 3000356, \'Filho(a) ou enteado(a) universitário(a) ou cursando escola técnica de 2º grau, até 24 (vinte e quatro) anos\', false, \'filho_24_007\', 0),
  (3001216, 3000356, \'Filho(a) ou enteado(a) até 21 (vinte e um) anos\', false, \'filho_21_007\', 0),
  (3001217, 3000356, \'Companheiro(a) com o(a) qual tenha filho ou viva há mais de 5 (cinco) anos\', false, \'companheiro_007\', 0),
  (3001218, 3000356, \'Cônjuge\', false, \'conjuge_007\', 0),
  (3001219, 3000357, NULL, true, \'nome_dependente_2_007\', 0),
  (3001220, 3000358, NULL, true, \'data_nascimento_dependente_2_007\', 0),
  (3001221, 3000359, NULL, true, \'cpf_dependente_2_007\', 0),
  (3001222, 3000360, \'Imposto de Renda\', false, \'imposto_renda_008\', 0),
  (3001223, 3000360, \'Salário Família\', false, \'salario_familia_008\', 0),
  (3001224, 3000361, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, com idade até 24 anos, se ainda estiver cursando estabelecimento de nível superior ou escola técnica de 2º grau, desde que tenha detido sua guarda judicial até os 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_008\', 0),
  (3001225, 3000361, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, até 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_21_008\', 0),
  (3001226, 3000361, \'Ex-cônjuge que receba pensão de alimentos\', false, \'ex_conjuge_008\', 0),
  (3001227, 3000361, \'A pessoa absolutamente incapaz, da qual seja tutor ou curador\', false, \'pessoa_incapaz_008\', 0),
  (3001228, 3000361, \'Menor pobre, até 21 (vinte e um) anos, que crie e eduque e do qual detenha a guarda judicial\', false, \'menor_pobre_008\', 0),
  (3001229, 3000361, \'Pais, avós e bisavós\', false, \'pais_avos_bisavos_008\', 0),
  (3001230, 3000361, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'irmao_neto_bisneto_incapacitado_008\', 0),
  (3001231, 3000361, \'Filho(a) ou enteado(a) em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'filho_incapacitado_008\', 0),
  (3001232, 3000361, \'Filho(a) ou enteado(a) universitário(a) ou cursando escola técnica de 2º grau, até 24 (vinte e quatro) anos\', false, \'filho_24_008\', 0),
  (3001233, 3000361, \'Filho(a) ou enteado(a) até 21 (vinte e um) anos\', false, \'filho_21_008\', 0),
  (3001234, 3000361, \'Companheiro(a) com o(a) qual tenha filho ou viva há mais de 5 (cinco) anos\', false, \'companheiro_008\', 0),
  (3001235, 3000361, \'Cônjuge\', false, \'conjuge_008\', 0),
  (3001236, 3000362, NULL, true, \'nome_dependente_2_008\', 0),
  (3001237, 3000363, NULL, true, \'data_nascimento_dependente_2_008\', 0),
  (3001238, 3000364, NULL, true, \'cpf_dependente_2_008\', 0),
  (3001239, 3000365, \'Imposto de Renda\', false, \'imposto_renda_009\', 0),
  (3001240, 3000365, \'Salário Família\', false, \'salario_familia_009\', 0),
  (3001241, 3000366, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, com idade até 24 anos, se ainda estiver cursando estabelecimento de nível superior ou escola técnica de 2º grau, desde que tenha detido sua guarda judicial até os 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_009\', 0),
  (3001242, 3000366, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, até 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_21_009\', 0),
  (3001243, 3000366, \'Ex-cônjuge que receba pensão de alimentos\', false, \'ex_conjuge_009\', 0),
  (3001244, 3000366, \'A pessoa absolutamente incapaz, da qual seja tutor ou curador\', false, \'pessoa_incapaz_009\', 0),
  (3001245, 3000366, \'Menor pobre, até 21 (vinte e um) anos, que crie e eduque e do qual detenha a guarda judicial\', false, \'menor_pobre_009\', 0),
  (3001246, 3000366, \'Pais, avós e bisavós\', false, \'pais_avos_bisavos_009\', 0),
  (3001247, 3000366, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'irmao_neto_bisneto_incapacitado_009\', 0),
  (3001248, 3000366, \'Filho(a) ou enteado(a) em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'filho_incapacitado_009\', 0),
  (3001249, 3000366, \'Filho(a) ou enteado(a) universitário(a) ou cursando escola técnica de 2º grau, até 24 (vinte e quatro) anos\', false, \'filho_24_009\', 0),
  (3001250, 3000366, \'Filho(a) ou enteado(a) até 21 (vinte e um) anos\', false, \'filho_21_009\', 0),
  (3001251, 3000366, \'Companheiro(a) com o(a) qual tenha filho ou viva há mais de 5 (cinco) anos\', false, \'companheiro_009\', 0),
  (3001252, 3000366, \'Cônjuge\', false, \'conjuge_009\', 0),
  (3001253, 3000367, NULL, true, \'nome_dependente_2_009\', 0),
  (3001254, 3000368, NULL, true, \'data_nascimento_dependente_2_009\', 0),
  (3001255, 3000369, NULL, true, \'cpf_dependente_2_009\', 0),
  (3001256, 3000370, \'Imposto de Renda\', false, \'imposto_renda_010\', 0),
  (3001257, 3000370, \'Salário Família\', false, \'salario_familia_010\', 0),
  (3001258, 3000371, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, com idade até 24 anos, se ainda estiver cursando estabelecimento de nível superior ou escola técnica de 2º grau, desde que tenha detido sua guarda judicial até os 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_010\', 0),
  (3001259, 3000371, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, até 21 (vinte e um) anos\', false, \'irmao_neto_bisneto_21_010\', 0),
  (3001260, 3000371, \'Ex-cônjuge que receba pensão de alimentos\', false, \'ex_conjuge_010\', 0),
  (3001261, 3000371, \'A pessoa absolutamente incapaz, da qual seja tutor ou curador\', false, \'pessoa_incapaz_010\', 0),
  (3001262, 3000371, \'Menor pobre, até 21 (vinte e um) anos, que crie e eduque e do qual detenha a guarda judicial\', false, \'menor_pobre_010\', 0),
  (3001263, 3000371, \'Pais, avós e bisavós\', false, \'pais_avos_bisavos_010\', 0),
  (3001264, 3000371, \'Irmão(ã), neto(a) ou bisneto(a) sem arrimo dos pais, do(a) qual detenha a guarda judicial, em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'irmao_neto_bisneto_incapacitado_010\', 0),
  (3001265, 3000371, \'Filho(a) ou enteado(a) em qualquer idade, quando incapacitado física e/ou mentalmente para o trabalho\', false, \'filho_incapacitado_010\', 0),
  (3001266, 3000371, \'Filho(a) ou enteado(a) universitário(a) ou cursando escola técnica de 2º grau, até 24 (vinte e quatro) anos\', false, \'filho_24_010\', 0),
  (3001267, 3000371, \'Filho(a) ou enteado(a) até 21 (vinte e um) anos\', false, \'filho_21_010\', 0),
  (3001268, 3000371, \'Companheiro(a) com o(a) qual tenha filho ou viva há mais de 5 (cinco) anos\', false, \'companheiro_010\', 0),
  (3001269, 3000371, \'Cônjuge\', false, \'conjuge_010\', 0),
  (3001270, 3000372, NULL, true, \'nome_dependente_2_010\', 0),
  (3001271, 3000373, NULL, true, \'data_nascimento_dependente_2_010\', 0),
  (3001272, 3000374, NULL, true, \'cpf_dependente_2_010\', 0);');

UPDATE db_itensmenu set libcliente = true where  id_item = 10218;
UPDATE db_itensmenu set libcliente = false where  id_item = 10219;

-- Altera rótulo do campo de vínculo entre pergunta e grupo
update db_syscampo set descricao = 'Avaliação Grupo Pergunta', rotulo = 'Avaliação Grupo Pergunta', rotulorel = 'Avaliação Grupo Pergunta' where codcam = 16916;

-- Ajusta o nome do módulo eSocial e seus menus corretamente
update db_itensmenu set descricao='eSocial', help='eSocial', desctec='Módulo de integração com o eSocial.' where id_item = 10216;
update db_itensmenu set help='Inclui um formulário do eSocial', desctec='Menu para manutenção dos formulários do eSocial.' where id_item = 10222;
update db_itensmenu set help='Altera um formulário do eSocial', desctec='Menu para manutenção dos formulários do eSocial.' where id_item = 10223;
update db_itensmenu set help='Exclui um formulário do eSocial', desctec='Menu para manutenção dos formulários do eSocial.' where id_item = 10224;
update db_modulos set nome_modulo='eSocial', descr_modulo='eSocial' where id_item = 10216;
update db_sysmodulo set descricao='Módulo para o eSocial' where codmod = 81;
update db_sysarquivo set descricao='Tabela que vincula uma resposta de uma pergunta do eSocial para o servidor.' where codarq = 3924;



---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

insert into db_syscampo values(21844,'ed10_censocursoprofiss','int4','Representa o curso profissionalizante de acordo com a tabela do censo.','null', 'Curso Profissionalizante',10,'t','f','f',1,'text','Curso Profissionalizante');
insert into db_sysarqcamp values(1010045,21844,8,0);
insert into db_sysforkey values(1010045,21844,1,2349,0);
insert into db_sysindices values(4343,'ensino_censocursoprofiss_in',1010045,'0');
insert into db_syscadind values(4343,21844,1);
update db_syscampo set nomecam = 'ed18_latitude', conteudo = 'varchar(20)', descricao = 'Latitude', valorinicial = '', rotulo = 'Latitude', nulo = 't', tamanho = 20, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Latitude' where codcam = 18917;
update db_syscampo set nomecam = 'ed18_longitude', conteudo = 'varchar(20)', descricao = 'Longitude', valorinicial = '', rotulo = 'Longitude', nulo = 't', tamanho = 20, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Longitude' where codcam = 18918;


select setval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq', (select max(ed313_sequencial) from avaliacaoperguntaopcaolayoutcampo));

-- Vinculos dos campos da avaliacao da Formacao do RecHumano com o registro 50 do censo 2015
insert into avaliacaoperguntaopcaolayoutcampo
        (ed313_sequencial, ed313_ano, ed313_db_layoutcampo, ed313_avaliacaoperguntaopcao, ed313_layoutvalorcampo )
 values ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12127, 3000073, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12129, 3000074, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12131, 3000075, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12133, 3000076, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12134, 3000077, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12135, 3000078, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12136, 3000079, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12141, 3000080, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12143, 3000081, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12145, 3000082, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12147, 3000127, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12148, 3000084, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12150, 3000114, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12151, 3000115, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12152, 3000116, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12153, 3000117, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12155, 3000118, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12156, 3000119, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12158, 3000120, 1),
        ( nextval('avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq'), 2015, 12159, 3000121, 1);

-- Ajusta o valor padrão dos campos de múltipla escolha para o registro 10 do CENSO 2015
update avaliacaoperguntaopcaolayoutcampo
  set ed313_layoutvalorcampo = '1'
  where ed313_db_layoutcampo in (
    12269, 12275, 12281, 12284, 12288, 12289, 12291, 12294, 12297, 12299, 12301, 12303, 12304, 12306, 12310, 12313, 12347, 12277, 12320, 12322, 12325, 12328, 12333, 12336, 12339, 12340, 12341, 12342, 12344, 12361, 12170, 12172, 12174, 12176, 12178, 12181, 12183, 12187, 12247, 12248, 12250, 12377, 12378, 12379, 12350, 12351, 12352, 12353, 12354, 12355, 12356, 12357, 12358, 12359, 12360, 12255, 12257, 12260, 12262, 12264, 12266, 12214, 12218, 12223, 12228, 12231, 12234, 12237, 12241, 12245, 12316, 12185, 12362
  ) and ed313_ano = 2015;

-- Ajusta o valor padrão do campo Água consumida pelos Alunos (NÃO FILTRADA) para o registro 10 do CENSO 2015
update avaliacaoperguntaopcaolayoutcampo set ed313_layoutvalorcampo = '1' where ed313_avaliacaoperguntaopcao = 3000099 and ed313_ano = 2015;

 -- Ajusta o valor padrão do campo Água consumida pelos Alunos (FILTRADA) para o registro 10 do CENSO 2015
update avaliacaoperguntaopcaolayoutcampo set ed313_layoutvalorcampo = '2' where ed313_avaliacaoperguntaopcao = 3000100 and ed313_ano = 2015;

---------------------------------------------------------------------------------------------------------------
------------------------------------------- INICIO SAUDE ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10230 ,'Passagens' ,'Passagens' ,'tfd1_passagensdestino001.php' ,'1' ,'1' ,'Cadastro de passagens do TFD por destino.' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8323 ,10230 ,12 ,8322 );
insert into db_sysarquivo values (3934, 'passagemdestino', 'Armazena os vínculos de valor de uma passagem para um destino do TFD.', 'tf37', '2016-04-29', 'Passagem / Destino', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (70,3934);
insert into db_syscampo values(21849,'tf37_sequencial','int4','Código sequencial da tabela.','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21850,'tf37_valor','float8','Valor da passagem para o destino.','0', 'Valor da Passagem',10,'f','f','f',4,'text','Valor da Passagem');
insert into db_syscampo values(21851,'tf37_destino','int4','Destino referente ao valor da passagem.','0', 'Destino',10,'f','f','f',1,'text','Destino');
insert into db_sysarqcamp values(3934,21849,1,0);
insert into db_sysarqcamp values(3934,21850,2,0);
insert into db_sysarqcamp values(3934,21851,3,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3934,21849,1,21851);
insert into db_sysforkey values(3934,21851,1,2859,0);
insert into db_sysindices values(4344,'passagemdestino_destino_in',3934,'1');
insert into db_syscadind values(4344,21851,1);
insert into db_syssequencia values(1000568, 'passagemdestino_tf37_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000568 where codarq = 3934 and codcam = 21849;

insert into db_syscampo values(21852,'tf17_tiposaida','int4','Tipo de saída agendada.','0', 'Tipo de Saída',10,'f','f','f',1,'text','Tipo de Saída');
insert into db_syscampodef values(21852,'1','Veículo');
insert into db_syscampodef values(21852,'2','Transporte Coletivo');
insert into db_sysarqcamp values(2873,21852,9,0);

insert into db_sysarquivo values (3935, 'agendasaidapassagemdestino', 'Guarda os valores da passagem de uma agenda de saída para um destino', 'tf38', '2016-05-02', 'Passagem de destino da agenda de saída', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (70,3935);
insert into db_syscampo values(21855,'tf38_sequencial','int4','Código sequencial da tabela.','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21856,'tf38_agendasaida','int4','Agenda de saída com os valores da passagem.','0', 'Agenda de Saída',10,'f','f','f',1,'text','Agenda de Saída');
insert into db_syscampo values(21857,'tf38_valorunitario','float8','Valor unitário da passagem para a agenda e destino.','0', 'Valor Unitário',10,'f','f','f',4,'text','Valor Unitário');
insert into db_syscampo values(21866,'tf38_cgs','int4','CGS do passageiro.','0', 'CGS',10,'f','f','f',1,'text','CGS');
insert into db_syscampo values(21867,'tf38_fica','bool','Controla se o passageiro fica ou não no destino.','f', 'Fica',1,'f','f','f',5,'text','Fica');
insert into db_sysarqcamp values(3935,21855,1,0);
insert into db_sysarqcamp values(3935,21856,2,0);
insert into db_sysarqcamp values(3935,21857,3,0);
insert into db_sysarqcamp values(3935,21866,4,0);
insert into db_sysarqcamp values(3935,21867,5,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3935,21855,1,21856);
insert into db_sysforkey values(3935,21856,1,2873,0);
insert into db_sysforkey values(3935,21866,1,1010144,0);
insert into db_sysindices values(4350,'agendasaidapassagemdestino_agendasaida_cgs_in',3935,'1');
insert into db_syscadind values(4350,21856,1);
insert into db_syscadind values(4350,21866,2);
insert into db_syssequencia values(1000569, 'agendasaidapassagemdestino_tf38_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000569 where codarq = 3935 and codcam = 21855;

insert into db_tipodoc values (5025, 'DECLARAÇÃO DE COMPARECIMENTO');
insert into db_documentopadrao( db60_coddoc ,db60_descr ,db60_tipodoc ,db60_instit ) values ( 252 ,'DECLARAÇÃO DE COMPARECIMENTO' ,5025 ,1 );
insert into db_paragrafopadrao( db61_codparag ,db61_descr ,db61_texto ,db61_alinha ,db61_inicia ,db61_espaco ,db61_alinhamento ,db61_altura ,db61_largura ,db61_tipo ) values ( 549 ,'TÍTULO DA DECLARAÇÃO DE COMPARECIMENTO' ,'DECLARAÇÃO DE COMPARECIMENTO' ,0 ,0 ,1 ,'J' ,0 ,0 ,1 );
insert into db_docparagpadrao( db62_coddoc ,db62_codparag ,db62_ordem ) values ( 252 ,549 ,1 );
insert into db_paragrafopadrao( db61_codparag ,db61_descr ,db61_texto ,db61_alinha ,db61_inicia ,db61_espaco ,db61_alinhamento ,db61_altura ,db61_largura ,db61_tipo ) values ( 550 ,'CORPO DA DECLARAÇÃO DE COMPARECIMENTO' ,'Declaro que Sr.(a) #$nomePaciente# permaneceu na #$nomeUnidade# no dia #$dataAtendimento# #$horario# #$observacao# ' ,0 ,0 ,1 ,'J' ,0 ,0 ,1 );
insert into db_docparagpadrao( db62_coddoc ,db62_codparag ,db62_ordem ) values ( 252 ,550 ,2 );

-- cadastro do layout e seus registros
select fc_executa_ddl('
  insert into db_layouttxt( db50_codigo ,db50_layouttxtgrupo ,db50_descr ,db50_quantlinhas ,db50_obs ) values ( 255 ,2 ,\'CENSO 2016\' ,0 ,\'CENSO 2016\' );
  insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 840 ,255 ,\'REGISTRO 00\' ,3 ,0 ,0 ,0 ,\'Dados de identificação da escola\' ,\'|\' ,\'0\' );
  insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 841 ,255 ,\'REGISTRO 10\' ,3 ,0 ,0 ,0 ,\'Caracterização e infra estrutura\' ,\'|\' ,\'0\' );
  insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 842 ,255 ,\'REGISTRO 20\' ,3 ,0 ,0 ,0 ,\'Cadastro de turma\' ,\'|\' ,\'0\' );
  insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 843 ,255 ,\'REGISTRO 30\' ,3 ,0 ,0 ,0 ,\'Cadastro de Docente - identificação\' ,\'|\' ,\'0\' );
  insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 844 ,255 ,\'REGISTRO 40\' ,3 ,0 ,0 ,0 ,\'Cadastro de Docente - Documentos e Endereço\' ,\'|\' ,\'0\' );
  insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 845 ,255 ,\'REGISTRO 50\' ,3 ,0 ,0 ,0 ,\'Cadastro de Docente - Dados Variáveis\' ,\'|\' ,\'0\' );
  insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 846 ,255 ,\'REGISTRO 51\' ,3 ,0 ,0 ,0 ,\'Cadastro de docente - dados de docência\' ,\'|\' ,\'0\' );
  insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 847 ,255 ,\'REGISTRO 60\' ,3 ,0 ,0 ,0 ,\'Cadastro de Aluno - Identificação\' ,\'|\' ,\'0\' );
  insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 848 ,255 ,\'REGISTRO 70\' ,3 ,0 ,0 ,0 ,\'Cadastro de Aluno - Documentos e Endereço\' ,\'|\' ,\'0\' );
  insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 849 ,255 ,\'REGISTRO 80\' ,3 ,0 ,0 ,0 ,\'Cadastro de Aluno - Vínculo(matrícula)\' ,\'|\' ,\'0\' );
  insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 850 ,255 ,\'REGISTRO 99\' ,3 ,0 ,0 ,0 ,\'fim de arquivo\' ,\'|\' ,\'0\' );
');

-- cadastro registro 00
select fc_executa_ddl('
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13281 ,840 ,\'tipo_registro\' ,\'TIPO DE REGISTRO\' ,14 ,1 ,\'00\' ,2 ,\'t\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13295 ,840 ,\'codigo_escola_inep\' ,\'CÓDIGO DE ESCOLA - INEP\' ,14 ,3 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13300 ,840 ,\'numero_cpf_gestor_escolar\' ,\'NÚMERO DO CPF DO GESTOR ESCOLAR\' ,14 ,11 ,\'\' ,11 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13305 ,840 ,\'nome_gestor_escolar\' ,\'NOME DO GESTOR ESCOLAR\' ,14 ,22 ,\'\' ,100 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13310 ,840 ,\'cargo_gestor_escolar\' ,\'CARGO DO GESTOR ESCOLAR\' ,14 ,122 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13314 ,840 ,\'endereco_eletronico_gestor_escolar\' ,\'ENDEREÇO ELETRÔNICO DO GESTOR ESCOLAR\' ,14 ,123 ,\'\' ,50 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13316 ,840 ,\'situacao_funcionamento\' ,\'SITUAÇÃO DE FUNCIONAMENTO\' ,14 ,173 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13321 ,840 ,\'data_inicio_ano_letivo\' ,\'DATA DE INÍCIO DO ANO LETIVO\' ,14 ,174 ,\'\' ,10 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13325 ,840 ,\'data_termino_ano_letivo\' ,\'DATA DE TÉRMINO DO ANO LETIVO\' ,14 ,184 ,\'\' ,10 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13333 ,840 ,\'nome_escola\' ,\'NOME DA ESCOLA\' ,14 ,194 ,\'\' ,100 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13338 ,840 ,\'latitude\' ,\'LATITUDE\' ,14 ,294 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13340 ,840 ,\'longitude\' ,\'LONGITUDE\' ,14 ,314 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13344 ,840 ,\'cep\' ,\'CEP\' ,14 ,334 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13348 ,840 ,\'endereco\' ,\'ENDEREÇO\' ,14 ,342 ,\'\' ,100 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13351 ,840 ,\'endereco_numero\' ,\'ENDEREÇO NÚMERO\' ,14 ,442 ,\'\' ,10 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13354 ,840 ,\'complemento_endereco\' ,\'COMPLEMENTO\' ,14 ,452 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13355 ,840 ,\'bairro\' ,\'BAIRRO\' ,14 ,472 ,\'\' ,50 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13359 ,840 ,\'uf\' ,\'UF\' ,14 ,522 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13361 ,840 ,\'municipio\' ,\'MUNICÍPIO\' ,14 ,524 ,\'\' ,7 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13365 ,840 ,\'distrito\' ,\'DISTRITO\' ,14 ,531 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13368 ,840 ,\'ddd\' ,\'DDD\' ,14 ,533 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13371 ,840 ,\'telefone\' ,\'TELEFONE\' ,14 ,535 ,\'\' ,9 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13376 ,840 ,\'telefone_publico_1\' ,\'TELEFONE PÚBLICO\' ,14 ,544 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13379 ,840 ,\'telefone_publico_2\' ,\'OUTRO TELEFONE DE CONTATO\' ,14 ,552 ,\'\' ,9 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13384 ,840 ,\'fax\' ,\'FAX\' ,14 ,561 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13385 ,840 ,\'endereco_eletronico\' ,\'ENDEREÇO ELETRÔNICO\' ,14 ,569 ,\'\' ,50 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13387 ,840 ,\'codigo_orgao_regional_ensino\' ,\'CÓDIGO DO ÓRGÃO REGIONAL DE ENSINO\' ,14 ,619 ,\'\' ,5 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13399 ,840 ,\'dependencia_administrativa\' ,\'DEPENDÊNCIA ADMINISTRATIVA\' ,14 ,624 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13401 ,840 ,\'localizacao_zona_escola\' ,\'LOCALIZAÇÃO/ZONA DA ESCOLA\' ,14 ,625 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13404 ,840 ,\'categoria_escola_privada\' ,\'CATEGORIA DA ESCOLA PRIVADA\' ,14 ,626 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13409 ,840 ,\'conveniada_poder_publico\' ,\'CONVENIADA COM O PODER PÚBLICO\' ,14 ,627 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13412 ,840 ,\'mant_esc_privada_empresa_grupo_empresarial_pes_fis\' ,\'MANTENEDORA - EMPRESA, GRUPOS EMPRESARIA\' ,14 ,628 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13415 ,840 ,\'mant_esc_privada_sidicatos_associacoes_cooperativa\' ,\'MANTENEDORA - SINDICATOS DE TRABALHADORE\' ,14 ,629 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13417 ,840 ,\'mant_esc_privada_ong_internacional_nacional_oscip\' ,\'MANTENEDORA - ORGANIZAÇÃO NÃO GOVERNAMEN\' ,14 ,630 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13418 ,840 ,\'mant_esc_privada_instituicoes_sem_fins_lucrativos\' ,\'MANTENEDORA - INSTITUIÇÕES SEM FINS LUCR\' ,14 ,631 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13419 ,840 ,\'sistema_s_sesi_senai_sesc_outros\' ,\'SISTEMA S\' ,14 ,632 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13420 ,840 ,\'cnpj_mantenedora_principal_escola_privada\' ,\'CNPJ DA MANTENEDORA PRINCIPAL DA ESCOLA\' ,14 ,633 ,\'\' ,14 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13423 ,840 ,\'cnpj_escola_privada\' ,\'CNPJ DA ESCOLA PRIVADA\' ,14 ,647 ,\'\' ,14 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13431 ,840 ,\'regulamentacao_autorizacao_conselho_orgao\' ,\'REGULAMENTAÇÃO/AUTORIZAÇÃO NO CONSELHO\' ,14 ,661 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13432 ,840 ,\'unidade_vinculada_escola_educacao_basica\' ,\'UNIDADE VINCULADA A ESCOLA DE EDUCAÇÃO\' ,14 ,662 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13433 ,840 ,\'codigo_escola_sede\' ,\'CÓDIGO DA ESCOLA SEDE\' ,14 ,663 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13436 ,840 ,\'codigo_ies\' ,\'CÓDIGO DA IES\' ,14 ,671 ,\'\' ,14 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
');

-- cadastro registro 10
select fc_executa_ddl('
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13258 ,841 ,\'tipo_registro\' ,\'TIPO DE REGISTRO\' ,14 ,1 ,\'10\' ,2 ,\'t\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13259 ,841 ,\'codigo_escola_inep\' ,\'CÓDIGO DA ESCOLA - INEP\' ,14 ,3 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13262 ,841 ,\'local_funcionamento_escola_predio_escolar\' ,\'LOCAL DE FUNCIONAMENTO - PRÉDIO ESCOLA\' ,14 ,11 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13263 ,841 ,\'local_funcionamento_escola_templo_igreja\' ,\'LOCAL DE FUNCIONAMENTO - TEMPLO/IGREJA\' ,14 ,12 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13265 ,841 ,\'local_funcionamento_escola_salas_empresas\' ,\'LOCAL DE FUNCIONAMENTO - SALA DE EMPRESA\' ,14 ,13 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13268 ,841 ,\'local_funcionamento_escola_casa_professor\' ,\'LOCAL FUNCIONAMENTO - CASA DO PROFESSOR\' ,14 ,14 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13270 ,841 ,\'local_funcionamento_escola_salas_outras_escolas\' ,\'LOCAL DE FUNCIONAMENTO - SALA OUTRA ESCO\' ,14 ,15 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13275 ,841 ,\'local_funcionamento_escola_galpao_rancho_paiol_bar\' ,\'LOCAL FUNCIONAMENTO - GALPÃO/RANCHO\' ,14 ,16 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13279 ,841 ,\'local_funcionamento_escola_un_internacao_socio\' ,\'LOCAL FUNCIONAMENTO - UNIDADE SOCIOEDUCA\' ,14 ,17 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13280 ,841 ,\'local_funcionamento_escola_unidade_prisional\' ,\'LOCAL FUNCIONAMENTO - UNIDADE PRISIONAL\' ,14 ,18 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13282 ,841 ,\'local_funcionamento_escola_outros\' ,\'LOCAL FUNCIONAMENTO - OUTROS\' ,14 ,19 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13284 ,841 ,\'forma_ocupacao_predio\' ,\'FORMA DE OCUPAÇÃO DO PRÉDIO\' ,14 ,20 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13285 ,841 ,\'predio_compartilhado_outra_escola\' ,\'PRÉDIO COMPARTILHADO COM OUTRA ESCOLA\' ,14 ,21 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13287 ,841 ,\'codigo_escola_compartilha_1\' ,\'CÓDIGO DA ESCOLA A QUAL COMPARTILHA 1\' ,14 ,22 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13288 ,841 ,\'codigo_escola_compartilha_2\' ,\'CÓDIGO DA ESCOLA A QUAL COMPARTILHA 2\' ,14 ,30 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13296 ,841 ,\'codigo_escola_compartilha_3\' ,\'CÓDIGO DA ESCOLA A QUAL COMPARTILHA 3\' ,14 ,38 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13298 ,841 ,\'codigo_escola_compartilha_4\' ,\'CÓDIGO DA ESCOLA A QUAL COMPARTILHA 4\' ,14 ,46 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13299 ,841 ,\'codigo_escola_compartilha_5\' ,\'CÓDIGO DA ESCOLA A QUAL COMPARTILHA 5\' ,14 ,54 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13303 ,841 ,\'codigo_escola_compartilha_6\' ,\'CÓDIGO DA ESCOLA A QUAL COMPARTILHA 6\' ,14 ,62 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13306 ,841 ,\'agua_consumida_alunos\' ,\'ÁGUA CONSUMIDA PELOS ALUNOS\' ,14 ,70 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13309 ,841 ,\'abastecimento_agua_rede_publica\' ,\'ABASTECIMENTO ÁGUA - REDE PÚBLICA\' ,14 ,71 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13311 ,841 ,\'abastecimento_agua_poco_artesiano\' ,\'ABASTECIMENTO ÁGUA - POÇO ARTESIANO\' ,14 ,72 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13312 ,841 ,\'abastecimento_agua_cacimba_cisterna_poco\' ,\'ABASTECIMENTO ÁGUA - CACIMBA/CISTERNA\' ,14 ,73 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13317 ,841 ,\'abastecimento_agua_fonte_rio_igarape_riacho_correg\' ,\'ABASTECIMENTO ÁGUA - FONTE/RIO/IGARAPÉ\' ,14 ,74 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13320 ,841 ,\'abastecimento_agua_inexistente\' ,\'ABASTECIMENTO ÁGUA - INEXISTENTE\' ,14 ,75 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13322 ,841 ,\'abastecimento_energia_eletrica_rede_publica\' ,\'ABASTECIMENTO ENERGIA - REDE PÚBLICA\' ,14 ,76 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13324 ,841 ,\'abastecimento_energia_eletrica_gerador\' ,\'ABASTECIMENTO ENERGIA - GERADOR\' ,14 ,77 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13328 ,841 ,\'abastecimento_energia_eletrica_outros_alternativa\' ,\'ABASTECIMENTO ENERGIA - OUTROS\' ,14 ,78 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13329 ,841 ,\'abastecimento_energia_eletrica_inexistente\' ,\'ABASTECIMENTO ENERGIA - INEXISTENTE\' ,14 ,79 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13331 ,841 ,\'esgoto_sanitario_rede_publica\' ,\'ESGOTO SANITÁRIO - REDE PÚBLICA\' ,14 ,80 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13332 ,841 ,\'esgoto_sanitario_fossa\' ,\'ESGOTO SANITÁRIO - FOSSA\' ,14 ,81 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13335 ,841 ,\'esgoto_sanitario_inexistente\' ,\'ESGOTO SANITÁRIO - INEXISTENTE\' ,14 ,82 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13337 ,841 ,\'destinacao_lixo_coleta_periodica\' ,\'DESTINAÇÃO LIXO - COLETA PERIÓDICA\' ,14 ,83 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13343 ,841 ,\'destinacao_lixo_queima\' ,\'DESTINAÇÃO LIXO - QUEIMA\' ,14 ,84 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13346 ,841 ,\'destinacao_lixo_joga_outra_area\' ,\'DESTINAÇÃO LIXO - JOGA EM OUTRA ÁREA\' ,14 ,85 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13347 ,841 ,\'destinacao_lixo_recicla\' ,\'DESTINAÇÃO LIXO - RECICLA\' ,14 ,86 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13349 ,841 ,\'destinacao_lixo_enterra\' ,\'DESTINAÇÃO LIXO - ENTERRA\' ,14 ,87 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13353 ,841 ,\'destinacao_lixo_outros\' ,\'DESTINAÇÃO LIXO - OUTROS\' ,14 ,88 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13356 ,841 ,\'dependencias_existentes_escola_sala_diretoria\' ,\'DEPENDÊNCIAS - SALA DA DIRETORA\' ,14 ,89 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13357 ,841 ,\'dependencias_existentes_escola_sala_professores\' ,\'DEPENDÊNCIAS - SALA DE PROFESSORES\' ,14 ,90 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13360 ,841 ,\'dependencias_existentes_escola_sala_secretaria\' ,\'DEPENDÊNCIAS - SALA DE SECRETARIA\' ,14 ,91 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13363 ,841 ,\'dependencias_existentes_escola_laboratorio_informa\' ,\'DEPENDÊNCIAS - LABORATÓRIO INFORMÁTICA\' ,14 ,92 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13367 ,841 ,\'dependencias_existentes_escola_laboratorio_ciencia\' ,\'DEPENDÊNCIAS - LABORATÓRIO DE CIÊNCIAS\' ,14 ,93 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13370 ,841 ,\'dependencias_existentes_escola_sala_recursos_multi\' ,\'DEPENDÊNCIAS - SALA RECURSOS MULTIFUNCIO\' ,14 ,94 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13373 ,841 ,\'dependencias_existentes_escola_quadra_esporte_cobe\' ,\'DEPENDÊNCIAS - QUADRA ESPORTE COBERTA\' ,14 ,95 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13375 ,841 ,\'dependencias_existentes_escola_quadra_esporte_desc\' ,\'DEPENDÊNCIAS - QUADRA ESPORTE DESCOBERTA\' ,14 ,96 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13377 ,841 ,\'dependencias_existentes_escola_cozinha\' ,\'DEPENDÊNCIAS - COZINHA\' ,14 ,97 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13381 ,841 ,\'dependencias_existentes_escola_biblioteca\' ,\'DEPENDÊNCIAS - BIBLIOTECA\' ,14 ,98 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13383 ,841 ,\'dependencias_existentes_escola_sala_leitura\' ,\'DEPENDÊNCIAS - SALA DE LEITURA\' ,14 ,99 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13388 ,841 ,\'dependencias_existentes_escola_parque_infantil\' ,\'DEPENDÊNCIAS - PARQUE INFANTIL\' ,14 ,100 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13389 ,841 ,\'dependencias_existentes_escola_bercario\' ,\'DEPENDÊNCIAS - BERÇÁRIO\' ,14 ,101 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13391 ,841 ,\'dependencias_existentes_escola_banheiro_fora_predi\' ,\'DEPENDÊNCIAS - BANHEIRO FORA DO PRÉDIO\' ,14 ,102 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13392 ,841 ,\'dependencias_existentes_escola_banheiro_dentro_pre\' ,\'DEPENDÊNCIAS - BANHEIRO DENTRO DO PRÉDIO\' ,14 ,103 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13394 ,841 ,\'dependencias_existentes_escola_banheiro_educ_infan\' ,\'DEPENDÊNCIAS - BANHEIRO EDUCAÇÃO INFANT\' ,14 ,104 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13395 ,841 ,\'dependencias_existentes_escola_banheiro_alunos_def\' ,\'DEPENDÊNCIAS - BANHEIRO DEFICIÊNCIA\' ,14 ,105 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13396 ,841 ,\'dependencias_existentes_escola_dep_vias_alunos_def\' ,\'DEPENDÊNCIAS - VIAS ADEQUADAS DEFICIÊNC\' ,14 ,106 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13397 ,841 ,\'dependencias_existentes_escola_banheiro_chuveiro\' ,\'DEPENDÊNCIAS - BANHEIRO COM CHUVEIRO\' ,14 ,107 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13398 ,841 ,\'dependencias_existentes_escola_refeitorio\' ,\'DEPENDÊNCIAS - REFEITÓRIO\' ,14 ,108 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13403 ,841 ,\'dependencias_existentes_escola_despensa\' ,\'DEPENDÊNCIAS - DESPENSA\' ,14 ,109 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13405 ,841 ,\'dependencias_existentes_escola_almoxarifado\' ,\'DEPENDÊNCIAS - ALMOXARIFADO\' ,14 ,110 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13407 ,841 ,\'dependencias_existentes_escola_auditorio\' ,\'DEPENDÊNCIAS - AUDITÓRIO\' ,14 ,111 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13410 ,841 ,\'dependencias_existentes_escola_patio_coberto\' ,\'DEPENDÊNCIAS - PÁTIO COBERTO\' ,14 ,112 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13413 ,841 ,\'dependencias_existentes_escola_patio_descoberto\' ,\'DEPENDÊNCIAS - PÁTIO DESCOBERTO\' ,14 ,113 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13414 ,841 ,\'dependencias_existentes_escola_alojamento_aluno\' ,\'DEPENDÊNCIAS - ALOJAMENTO DE ALUNO\' ,14 ,114 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13416 ,841 ,\'dependencias_existentes_escola_alojamento_professo\' ,\'DEPENDÊNCIAS - ALOJAMENTO DE PROFESSOR\' ,14 ,115 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13421 ,841 ,\'dependencias_existentes_escola_area_verde\' ,\'DEPENDÊNCIAS - ÁREA VERDE\' ,14 ,116 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13422 ,841 ,\'dependencias_existentes_escola_lavanderia\' ,\'DEPENDÊNCIAS - LAVANDERIA\' ,14 ,117 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13424 ,841 ,\'dependencias_existentes_escola_nenhuma_relacionada\' ,\'DEPENDÊNCIAS - NENHUMA DAS RELACIONADAS\' ,14 ,118 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13425 ,841 ,\'numero_salas_aula_existentes_escola\' ,\'NÚMERO DE SALAS DE AULA EXISTENTES\' ,14 ,119 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13426 ,841 ,\'numero_salas_usadas_como_salas_aula\' ,\'SALAS UTILIZADAS COMO SALA DE AULA\' ,14 ,123 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13427 ,841 ,\'equipamentos_existentes_escola_televisao\' ,\'EQUIPAMENTOS - APARELHO DE TELEVISÃO\' ,14 ,127 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13428 ,841 ,\'equipamentos_existentes_escola_videocassete\' ,\'EQUIPAMENTOS - VIDEOCASSETE\' ,14 ,131 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13429 ,841 ,\'equipamentos_existentes_escola_dvd\' ,\'EQUIPAMENTOS - APARELHO DE DVD\' ,14 ,135 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13430 ,841 ,\'equipamentos_existentes_escola_antena_parabolica\' ,\'EQUIPAMENTOS - ANTENA PARABÓLICA\' ,14 ,139 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13442 ,841 ,\'equipamentos_existentes_escola_copiadora\' ,\'EQUIPAMENTOS - COPIADORA\' ,14 ,143 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13444 ,841 ,\'equipamentos_existentes_escola_retroprojetor\' ,\'EQUIPAMENTOS - RETROPROJETOR\' ,14 ,147 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13445 ,841 ,\'equipamentos_existentes_escola_impressora\' ,\'EQUIPAMENTOS - IMPRESSORA\' ,14 ,151 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13447 ,841 ,\'equipamentos_existentes_escola_aparelho_som\' ,\'EQUIPAMENTOS - APARELHO DE SOM\' ,14 ,155 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13448 ,841 ,\'equipamentos_existentes_escola_projetor_datashow\' ,\'EQUIPAMENTOS - PROJETOR MULTIMÍDIA\' ,14 ,159 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13449 ,841 ,\'equipamentos_existentes_escola_fax\' ,\'EQUIPAMENTOS - FAX\' ,14 ,163 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13450 ,841 ,\'equipamentos_existentes_escola_maquina_fotografica\' ,\'EQUIPAMENTOS - MÁQUINA FOTOGRÁFICA\' ,14 ,167 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13451 ,841 ,\'equipamentos_existentes_escola_computador\' ,\'EQUIPAMENTOS - COMPUTADORES\' ,14 ,171 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13452 ,841 ,\'equipamentos_impressora_multifuncional\' ,\'EQUIPAMENTOS - IMPRESSORA MULTIFUNCIONAL\' ,14 ,175 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13453 ,841 ,\'quantidade_computadores_uso_administrativo\' ,\'QUANTIDADE DE COMPUTADORES USO ADMINISTR\' ,14 ,179 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13454 ,841 ,\'quantidade_computadores_uso_alunos\' ,\'QUANTIDADE DE COMPUTADORES USO ALUNO\' ,14 ,183 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13455 ,841 ,\'acesso_internet\' ,\'ACESSO À INTERNET\' ,14 ,187 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13456 ,841 ,\'banda_larga\' ,\'BANDA LARGA\' ,14 ,188 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13457 ,841 ,\'total_funcionarios_prof_aux_assistentes_monitores\' ,\'TOTAL DE FUNCIONÁRIOS DA ESCOLA\' ,14 ,189 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13459 ,841 ,\'alimentacao_escolar_aluno\' ,\'ALIMENTAÇÃO ESCOLAR PARA OS ALUNOS\' ,14 ,193 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13460 ,841 ,\'atendimento_educacional_especializado\' ,\'ATENDIMENTO EDUCACIONAL ESPECIALIZADO\' ,14 ,194 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13462 ,841 ,\'atividade_complementar\' ,\'ATIVIDADE COMPLEMENTAR\' ,14 ,195 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13464 ,841 ,\'modalidade_ensino_regular\' ,\'MODALIDADE - ENSINO REGULAR\' ,14 ,196 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13465 ,841 ,\'modalidade_educacao_especial_modalidade_substutiva\' ,\'MODALIDADE - EDUCAÇÃO ESPECIAL\' ,14 ,197 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13467 ,841 ,\'modalidade_educacao_jovens_adultos\' ,\'MODALIDADE - EDUCAÇÃO DE JOVENS E ADULTO\' ,14 ,198 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13468 ,841 ,\'modalidade_educacao_profissional\' ,\'MODALIDADE - EDUCAÇÃO PROFISSIONAL\' ,14 ,199 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13470 ,841 ,\'ensino_fundamental_organizado_ciclos\' ,\'ENSINO FUNDAMENTAL ORGANIZADO EM CICLOS\' ,14 ,200 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13471 ,841 ,\'localizacao_diferenciada_escola\' ,\'LOCALIZAÇÃO DIFERENCIADA DA ESCOLA\' ,14 ,201 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13472 ,841 ,\'materiais_didaticos_especificos_nao_utiliza\' ,\'MATERIAL ESPECÍFICOS - NÃO UTILIZA\' ,14 ,202 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13473 ,841 ,\'materiais_didaticos_especificos_quilombola\' ,\'MATERIAL ESPECÍFICOS - QUILOMBOLA\' ,14 ,203 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13475 ,841 ,\'materiais_didaticos_especificos_indigena\' ,\'MATERIAL ESPECÍFICOS - INDÍGENA\' ,14 ,204 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13477 ,841 ,\'educacao_indigena\' ,\'EDUCAÇÃO INDÍGENA\' ,14 ,205 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13478 ,841 ,\'lingua_ensino_ministrado_lingua_indigena\' ,\'LÍNGUA MINISTRADA - LÍNGUA INDÍGENA\' ,14 ,206 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13479 ,841 ,\'lingua_ensino_ministrada_lingua_portuguesa\' ,\'LÍNGUA MINISTRADA - LÍNGUA PORTUGUESA\' ,14 ,207 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13480 ,841 ,\'codigo_lingua_indigena\' ,\'CÓDIGO DA LÍNGUA INDÍGENA\' ,14 ,208 ,\'\' ,5 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13482 ,841 ,\'escola_cede_espaco_turma_brasil_alfabetizado\' ,\'ESCOLA CEDE ESPAÇO TURMAS BRASIL ALFABET\' ,14 ,213 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13484 ,841 ,\'escola_abre_finais_semanas_comunidade\' ,\'ESCOLA ABRE AOS FINAIS DE SEMANA\' ,14 ,214 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13485 ,841 ,\'escola_formacao_alternancia\' ,\'ESCOLA COM PROPOSTA PEDAGÓGICA DE FORMAÇ\' ,14 ,215 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
');

-- cadastro registro 20
select fc_executa_ddl('
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13254 ,842 ,\'tipo_registro\' ,\'TIPO DE REGISTRO\' ,14 ,1 ,\'20\' ,2 ,\'t\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13255 ,842 ,\'codigo_escola_inep\' ,\'CÓDIGO INEP DA ESCOLA\' ,14 ,3 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13256 ,842 ,\'codigo_turma_inep\' ,\'CÓDIGO INEP TURMA\' ,14 ,11 ,\'\' ,10 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13257 ,842 ,\'codigo_turma_entidade_escola\' ,\'CÓDIGO DA TURMA\' ,14 ,21 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13260 ,842 ,\'nome_turma\' ,\'NOME DA TURMA\' ,14 ,41 ,\'\' ,80 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13261 ,842 ,\'mediacao_didatico_pedagogica\' ,\'TIPO DE MEDIAÇÃO DIDÁTICO PEDAGÓGICA\' ,14 ,121 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13264 ,842 ,\'horario_turma_horario_inicial_hora\' ,\'HORÁRIO DA TURMA - HORA INICIAL\' ,14 ,122 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13266 ,842 ,\'horario_turma_horario_inicial_minuto\' ,\'HORÁRIO DA TURMA - H. INICIAL MINUTO\' ,14 ,124 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13267 ,842 ,\'horario_turma_horario_final_hora\' ,\'HORÁRIO DA TURMA - H. FINAL - HORA\' ,14 ,126 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13269 ,842 ,\'horario_turma_horario_final_minuto\' ,\'HORÁRIO DA TURMA - H. FINAL MINUTO\' ,14 ,128 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13271 ,842 ,\'dia_semana_domingo\' ,\'DIA DA SEMANA - DOMINGO\' ,14 ,130 ,\'\' ,1 ,\'f\' ,\'t\' ,\'e\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13272 ,842 ,\'dia_semana_segunda\' ,\'DIA DA SEMANA - SEGUNDA FEIRA\' ,14 ,131 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13273 ,842 ,\'dia_semana_terca\' ,\'DIA DA SEMANA - TERÇA FEIRA\' ,14 ,132 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13274 ,842 ,\'dia_semana_quarta\' ,\'DIA DA SEMANA - QUARTA FEIRA\' ,14 ,133 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13276 ,842 ,\'dia_semana_quinta\' ,\'DIA DA SEMANA - QUINTA FEIRA\' ,14 ,134 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13277 ,842 ,\'dia_semana_sexta\' ,\'DIA DA SEMANA - SEXTA FEIRA\' ,14 ,135 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13278 ,842 ,\'dia_semana_sabado\' ,\'DIA DA SEMANA - SÁBADO\' ,14 ,136 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13283 ,842 ,\'tipo_atendimento\' ,\'TIPO DE ATENDIMENTO\' ,14 ,137 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13286 ,842 ,\'turma_participante_mais_educacao_ensino_medio_inov\' ,\'TURMA PARTICIPANTE PROG. MAIS EDUCACAO\' ,14 ,138 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'Turma participante do Programa Mais Educação/Ensino Médio Inovador\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13289 ,842 ,\'codigo_tipo_atividade_complementar_1\' ,\'CÓDIGO DO TIPO DE ATIVIDADE 1\' ,14 ,139 ,\'\' ,5 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13290 ,842 ,\'codigo_tipo_atividade_complementar_2\' ,\'CÓDIGO DO TIPO DE ATIVIDADE 2\' ,14 ,144 ,\'\' ,5 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13291 ,842 ,\'codigo_tipo_atividade_complementar_3\' ,\'CÓDIGO DO TIPO DE ATIVIDADE 3\' ,14 ,149 ,\'\' ,5 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13292 ,842 ,\'codigo_tipo_atividade_complementar_4\' ,\'CÓDIGO DO TIPO DE ATIVIDADE 4\' ,14 ,154 ,\'\' ,5 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13293 ,842 ,\'codigo_tipo_atividade_complementar_5\' ,\'CÓDIGO DO TIPO DE ATIVIDADE 5\' ,14 ,159 ,\'\' ,5 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13294 ,842 ,\'codigo_tipo_atividade_complementar_6\' ,\'CÓDIGO DO TIPO DE ATIVIDADE 6\' ,14 ,164 ,\'\' ,5 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13297 ,842 ,\'aee_ensino_sistema_braille\' ,\'ENSINO DO SISTEMA BRAILLE\' ,14 ,169 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13301 ,842 ,\'aee_ensino_uso_recursos_opticos_nao_opticos\' ,\'ENSINO DO USO DE RECURSOS ÓPTICOS\' ,14 ,170 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13302 ,842 ,\'aee_estrategias_desenvolvimento_processos_mentais\' ,\'AEE ESTRAT. P DESENV. DE PROC. MENTAIS\' ,14 ,171 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13304 ,842 ,\'aee_tecnicas_orientacao_mobilidade\' ,\'TÉCNICAS DE ORIENTAÇÃO E MOBILIDADE\' ,14 ,172 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13307 ,842 ,\'aee_ensino_lingua_brasileira_sinais_libras\' ,\'AEE ENS. LINGUA BRAS. DE SINAIS - LIBRAS\' ,14 ,173 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13308 ,842 ,\'aee_ensino_comunicacao_alternativa_aumentativa\' ,\'AEE ENS. DE USO COMUNIC. ALTERNATIVA CAA\' ,14 ,174 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13313 ,842 ,\'aee_estrategia_enriquecimento_curricular\' ,\'AEE ESTRAT. P/ ENRIQUECIMENTO CURRICULAR\' ,14 ,175 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13315 ,842 ,\'aee_ensino_uso_soroban\' ,\'ENSINO DO USO DO SOROBAN\' ,14 ,176 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13318 ,842 ,\'aee_ensino_usabilidade_funcionalidades_informatica\' ,\'AEE USABILIDADE INFORMATICA ACESSIVEL\' ,14 ,177 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13319 ,842 ,\'aee_ensino_lingua_portuguesa_modalidade_escrita\' ,\'AEE ENSINO LINGUA PORTUGUESA MODALIDADE\' ,14 ,178 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13323 ,842 ,\'aee_estrategias_autonomia_ambiente_escolar\' ,\'AEE ESTRATEGIAS PARA AUTONOMIA AMBIENTE\' ,14 ,179 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13326 ,842 ,\'modalidade_turma\' ,\'MODALIDADE\' ,14 ,180 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13327 ,842 ,\'etapa_ensino_turma\' ,\'ETAPA DE ENSINO\' ,14 ,181 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13330 ,842 ,\'codigo_curso_educacao_profissional\' ,\'CÓDIGO CURSO TÉCNICO\' ,14 ,183 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13334 ,842 ,\'disciplinas_turma_quimica\' ,\'DISCIPLINAS - 1 - QUÍMICA\' ,14 ,191 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13336 ,842 ,\'disciplinas_turma_fisica\' ,\'DISCIPLINAS - 2 - FÍSICA\' ,14 ,192 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13339 ,842 ,\'disciplinas_turma_matematica\' ,\'DISCIPLINAS - 3 - MATEMÁTICA\' ,14 ,193 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13341 ,842 ,\'disciplinas_turma_biologia\' ,\'DISCIPLINAS - 4 - BIOLOGIA\' ,14 ,194 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13342 ,842 ,\'disciplinas_turma_ciencias\' ,\'DISCIPLINAS - 5 - CIÊNCIAS\' ,14 ,195 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13345 ,842 ,\'disciplinas_turma_lingua_literatura_portuguesa\' ,\'DISCIPLINAS - 6 - LÍNGUA PORTUGUESA\' ,14 ,196 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13350 ,842 ,\'disciplinas_lingua_literatura_estrangeira_inglesa\' ,\'DISCIPLINAS - 7 - LINGUA INGLESA\' ,14 ,197 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13352 ,842 ,\'disciplinas_lingua_literatura_estrangeira_espanhol\' ,\'DISCIPLINAS - 8 - LÍNGUA ESPANHOLA\' ,14 ,198 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13358 ,842 ,\'disciplinas_lingua_literatura_estrangeira_frances\' ,\'DISCIPLINAS - 30 - LÍNGUA FRANCÊSA\' ,14 ,199 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13362 ,842 ,\'disciplinas_lingua_literatura_estrangeira_outra\' ,\'DISCIPLINAS - 9 - LÍNGUA OUTRA\' ,14 ,200 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13364 ,842 ,\'disciplinas_turma_artes\' ,\'DISCIPLINAS - 10 - ARTES\' ,14 ,201 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13366 ,842 ,\'disciplinas_turma_educacao_fisica\' ,\'DISCIPLINAS - 11 - EDUCAÇÃO FÍSICA\' ,14 ,202 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13369 ,842 ,\'disciplinas_turma_historia\' ,\'DISCIPLINAS - 12 - HISTÓRIA\' ,14 ,203 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13372 ,842 ,\'disciplinas_turma_geografia\' ,\'DISCIPLINAS - 13 - GEOGRAFIA\' ,14 ,204 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13374 ,842 ,\'disciplinas_turma_filosofia\' ,\'DISCIPLINAS - 14 - FILOSOFIA\' ,14 ,205 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13378 ,842 ,\'disciplinas_turma_estudos_sociais\' ,\'DISCIPLINAS - 28 - ESTUDOS SOCIAIS\' ,14 ,206 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13380 ,842 ,\'disciplinas_turma_sociologia\' ,\'DISCIPLINAS - 29 - SOCIOLOGIA\' ,14 ,207 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13382 ,842 ,\'disciplinas_turma_informatica_computacao\' ,\'DISCIPLINAS - 16 - INFORMÁTICA/COMPUTAÇÃ\' ,14 ,208 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13386 ,842 ,\'disciplinas_turma_disciplinas_profissionalizantes\' ,\'DISCIPLINAS 17 - PROFISSIONALIZANTE\' ,14 ,209 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13390 ,842 ,\'disciplinas_turma_voltadas_atendimento_necessidade\' ,\'DISCIPLINA VOLTADAS A ATEND. NECESSIDADE\' ,14 ,210 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13393 ,842 ,\'disciplinas_turma_voltadas_diversidade_sociocultur\' ,\'DISCIPLINA VOLTADAS DIVERSIDADE SOCIOCUL\' ,14 ,211 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13400 ,842 ,\'disciplinas_turma_libras\' ,\'DISCIPLINAS - 23 - LIBRAS\' ,14 ,212 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13402 ,842 ,\'disciplinas_turma_disciplinas_pedagogicas\' ,\'DISCIPLINAS - 25 - PEDAGÓGICAS\' ,14 ,213 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13406 ,842 ,\'disciplinas_turma_ensino_religioso\' ,\'DISCIPLINAS - 26 - ENSINO RELIGIOSO\' ,14 ,214 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13408 ,842 ,\'disciplinas_turma_lingua_indigena\' ,\'DISCIPLINAS - 27 - LÍNGUA INDÍGENA\' ,14 ,215 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13411 ,842 ,\'disciplinas_turma_outras\' ,\'DISCIPLINAS - 99 - OUTRAS\' ,14 ,216 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
');

-- cadastro registro 30
select fc_executa_ddl('
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13438 ,843 ,\'tipo_registro\' ,\'TIPO DE REGISTRO \' ,14 ,1 ,\'30\' ,2 ,\'t\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13439 ,843 ,\'codigo_escola_inep\' ,\'CÓDIGO DE ESCOLA - INEP\' ,14 ,3 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13440 ,843 ,\'identificacao_unica_docente_inep\' ,\'IDENTIFICAÇÃO ÚNICA DO DOCENTE INEP\' ,14 ,11 ,\'\' ,12 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13441 ,843 ,\'codigo_docente_entidade_escola\' ,\'CÓDIGO DO DOCENTE NA ENTIDADE/ESCOLA\' ,14 ,23 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13443 ,843 ,\'nome_completo\' ,\'NOME COMPLETO\' ,14 ,43 ,\'\' ,100 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13446 ,843 ,\'email\' ,\'E-MAIL\' ,14 ,143 ,\'\' ,100 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13458 ,843 ,\'numero_identificacao_social_nis\' ,\'NÚMERO DE IDENTIFICAÇÃO SOCIAL (NIS)\' ,14 ,243 ,\'\' ,11 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13461 ,843 ,\'data_nascimento\' ,\'DATA DE NASCIMENTO\' ,14 ,254 ,\'\' ,10 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13463 ,843 ,\'sexo\' ,\'SEXO\' ,14 ,264 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13466 ,843 ,\'cor_raca\' ,\'COR/RAÇA\' ,14 ,265 ,\'0\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13469 ,843 ,\'filiacao\' ,\'FILIAÇÃO\' ,14 ,266 ,\'0\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13474 ,843 ,\'filiacao_1\' ,\'FILIAÇÃO 1\' ,14 ,267 ,\'\' ,100 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13476 ,843 ,\'filiacao_2\' ,\'FILIAÇÃO 2\' ,14 ,367 ,\'\' ,100 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13481 ,843 ,\'nacionalidade_docente\' ,\'NACIONALIDADE DO PROFISSIONAL ESCOLAR\' ,14 ,467 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'Nacionalidade do Profissional escolar em sala de Aula\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13483 ,843 ,\'pais_origem\' ,\'PAÍS DE ORIGEM\' ,14 ,468 ,\'\' ,3 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13486 ,843 ,\'uf_nascimento\' ,\'UF DE NASCIMENTO\' ,14 ,471 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13487 ,843 ,\'municipio_nascimento\' ,\'MUNICÍPIO DE NASCIMENTO\' ,14 ,473 ,\'\' ,7 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13488 ,843 ,\'docente_deficiencia\' ,\'PROFISSIONAL ESCOLAR COM DEFICIÊNCIA\' ,14 ,480 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'Profissional escolar com deficiência e Tipos de deficiência\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13490 ,843 ,\'tipos_deficiencia_cegueira\' ,\'TIPO DE DEFICIÊNCIA - CEGUEIRA\' ,14 ,481 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13492 ,843 ,\'tipos_deficiencia_baixa_visao\' ,\'TIPO DE DEFICIÊNCIA - BAIXA VISÃO\' ,14 ,482 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13494 ,843 ,\'tipos_deficiencia_surdez\' ,\'TIPO DE DEFICIÊNCIA - SURDEZ\' ,14 ,483 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13495 ,843 ,\'tipos_deficiencia_auditiva\' ,\'TIPO DE DEFICIÊNCIA - AUDITIVA\' ,14 ,484 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13496 ,843 ,\'tipos_deficiencia_surdocegueira\' ,\'TIPO DE DEFICIÊNCIA - SURDOCEGUEIRA\' ,14 ,485 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13507 ,843 ,\'tipos_deficiencia_fisica\' ,\'TIPO DE DEFICIÊNCIA - FÍSICA\' ,14 ,486 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13508 ,843 ,\'tipos_deficiencia_intelectual\' ,\'TIPO DE DEFICIÊNCIA - INTELECTUAL\' ,14 ,487 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13509 ,843 ,\'tipos_deficiencia_multipla\' ,\'TIPO DE DEFICIÊNCIA - MÚLTIPLA\' ,14 ,488 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
');

-- cadastro registro 40
select fc_executa_ddl('
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13489 ,844 ,\'tipo_registro\' ,\'TIPO DE REGISTRO\' ,14 ,1 ,\'40\' ,2 ,\'t\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13491 ,844 ,\'codigo_escola_inep\' ,\'CÓDIGO DA ESCOLA - INEP\' ,14 ,3 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13493 ,844 ,\'identificacao_unica_docente_inep\' ,\'IDENTIFICAÇÃO ÚNICA DO DOCENTE INEP\' ,14 ,11 ,\'\' ,12 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13497 ,844 ,\'codigo_docente_entidade_escola\' ,\'CÓDIGO DO DOCENTE ENTIDADE/ESCOLA\' ,14 ,23 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13498 ,844 ,\'numero_cpf\' ,\'NÚMERO DO CPF\' ,14 ,43 ,\'\' ,11 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13499 ,844 ,\'localizacao_zona_residencia\' ,\'LOCALIZAÇÃO/ZONA DA RESIDÊNCIA\' ,14 ,54 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13500 ,844 ,\'cep\' ,\'CEP\' ,14 ,55 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13501 ,844 ,\'endereco\' ,\'ENDEREÇO\' ,14 ,63 ,\'\' ,100 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13502 ,844 ,\'numero_endereco\' ,\'NÚMERO DO ENDEREÇO\' ,14 ,163 ,\'\' ,10 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13503 ,844 ,\'complemento\' ,\'COMPLEMENTO\' ,14 ,173 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13504 ,844 ,\'bairro\' ,\'BAIRRO\' ,14 ,193 ,\'\' ,50 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13505 ,844 ,\'uf\' ,\'UF\' ,14 ,243 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13506 ,844 ,\'municipio\' ,\'MUNICÍPIO\' ,14 ,245 ,\'\' ,7 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
');

-- cadastro registro 50
select fc_executa_ddl('
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13530 ,845 ,\'tipo_registro\' ,\'TIPO DE REGISTRO\' ,14 ,1 ,\'50\' ,2 ,\'t\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13532 ,845 ,\'codigo_escola_inep\' ,\'CÓDIGO DA ESCOLA - INEP\' ,14 ,3 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13533 ,845 ,\'identificacao_unica_docente\' ,\'IDENTIFICAÇÃO ÚNICA DO DOCENTE(INEP\' ,14 ,11 ,\'\' ,12 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13534 ,845 ,\'codigo_docente_entidade_escola\' ,\'CÓDIGO DO DOCENTE NA ENTIDADE/ESCOLA\' ,14 ,23 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13535 ,845 ,\'escolaridade\' ,\'ESCOLARIDADE\' ,14 ,43 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13536 ,845 ,\'situacao_curso_superior_1\' ,\'SITUAÇÃO DO CURSO SUPERIOR 1\' ,14 ,44 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13538 ,845 ,\'formacao_complementacao_pedagogica_1\' ,\'FORMAÇÃO/COMPLEMENTAÇÃO PEDAGÓGICA 1\' ,14 ,45 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13540 ,845 ,\'codigo_curso_superior_1\' ,\'CÓDIGO DO CURSO SUPERIOR 1\' ,14 ,46 ,\'\' ,6 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13542 ,845 ,\'ano_inicio_curso_superior_1\' ,\'ANO DE INÍCIO DO CURSO SUPERIOR 1\' ,14 ,52 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13544 ,845 ,\'ano_conclusao_curso_superior_1\' ,\'ANO DE CONCLUSÃO DO CURSO SUPERIOR 1\' ,14 ,56 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13545 ,845 ,\'instituicao_curso_superior_1\' ,\'INSTITUIÇÃO DO CURSO SUPERIOR 1\' ,14 ,60 ,\'\' ,7 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13547 ,845 ,\'situacao_curso_superior_2\' ,\'SITUAÇÃO DO CURSO SUPERIOR 2\' ,14 ,67 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13549 ,845 ,\'formacao_complementacao_pedagogica_2\' ,\'FORMAÇÃO/COMPLEMENTAÇÃO PEDAGÓGIGA 2\' ,14 ,68 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13551 ,845 ,\'codigo_curso_superior_2\' ,\'CÓDIGO DO CURSO SUPERIOR 2\' ,14 ,69 ,\'\' ,6 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13555 ,845 ,\'ano_inicio_curso_superior_2\' ,\'ANO DE INÍCIO DO CURSO SUPERIOR 2\' ,14 ,75 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13557 ,845 ,\'ano_conclusao_curso_superior_2\' ,\'ANO DE CONCLUSÃO DO CURSO SUPERIOR 2\' ,14 ,79 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13560 ,845 ,\'instituicao_curso_superior_2\' ,\'INSTITUIÇÃO DO CURSO SUPERIOR 2\' ,14 ,83 ,\'\' ,7 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13562 ,845 ,\'situacao_curso_superior_3\' ,\'SITUAÇÃO DO CURSO SUPERIOR 3\' ,14 ,90 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13564 ,845 ,\'formacao_complementacao_pedagogica_3\' ,\'FORMAÇÃO/COMPLEMENTAÇÃO PEDAGÓGICA 3\' ,14 ,91 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13566 ,845 ,\'codigo_curso_superior_3\' ,\'CÓDIGO DO CURSO SUPERIOR 3\' ,14 ,92 ,\'\' ,6 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13567 ,845 ,\'ano_inicio_curso_superior_3\' ,\'ANO DE INÍCIO DO CURSO SUPERIOR 3\' ,14 ,98 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13570 ,845 ,\'ano_conclusao_curso_superior_3\' ,\'ANO DE CONCLUSÃO DO CURSO SUPERIOR 3\' ,14 ,102 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13574 ,845 ,\'instituicao_curso_superior_3\' ,\'INSTITUIÇÃO DO CURSO SUPERIOR 3\' ,14 ,106 ,\'\' ,7 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13577 ,845 ,\'pos_graduacao_especializacao\' ,\'PÓS GRADUAÇÃO - ESPECIALIZAÇÃO\' ,14 ,113 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13584 ,845 ,\'pos_graduacao_mestrado\' ,\'PÓS GRADUAÇÃO - MESTRADO\' ,14 ,114 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13585 ,845 ,\'pos_graduacao_doutorado\' ,\'PÓS GRADUAÇÃO DOUTORADO\' ,14 ,115 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13587 ,845 ,\'pos_graduacao\' ,\'PÓS GRADUAÇÃO\' ,14 ,116 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13589 ,845 ,\'especifico_creche_0_3_anos\' ,\'ESPECÍFICO PARA CRECHE DE 0 A 3 ANOS\' ,14 ,117 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13591 ,845 ,\'especifico_pre_escola_4_5_anos\' ,\'ESPECÍFICO PARA PRÉ-ESCOLA DE 4 A 5 ANOS\' ,14 ,118 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13592 ,845 ,\'especifico_anos_iniciais_ensino_fundamental\' ,\'ESPECÍFICO PARA ANOS INICIAIS ENSINO FUN\' ,14 ,119 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13594 ,845 ,\'especifico_anos_finais_ensino_fundamental\' ,\'ESPECÍFICO PARA ANOS FINAIS DO ENS FUNDA\' ,14 ,120 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13595 ,845 ,\'especifico_ensino_medio\' ,\'ESPECÍFICO PARA ENSINO MÉDIO\' ,14 ,121 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13596 ,845 ,\'especifico_eja\' ,\'ESPECÍFICO PARA EDUCAÇÃO JOVENS ADULTOS\' ,14 ,122 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13598 ,845 ,\'especifico_educacao_especial\' ,\'ESPECÍFICO PARA EDUCAÇÃO ESPECIAL\' ,14 ,123 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13600 ,845 ,\'especifico_educacao_indigena\' ,\'ESPECÍFICO PARA EDUCAÇÃO INDÍGENA\' ,14 ,124 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13602 ,845 ,\'especifico_educacao_campo\' ,\'ESPECÍFICO PARA EDUCAÇÃO DO CAMPO\' ,14 ,125 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13605 ,845 ,\'especifico_educacao_ambiental\' ,\'ESPECÍFICO PARA EDUCAÇÃO AMBIENTAL\' ,14 ,126 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13606 ,845 ,\'especifico_educacao_direitos_humanos\' ,\'ESPECÍFICO PARA EDUCAÇÃO EM DIREITOS HUM\' ,14 ,127 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13608 ,845 ,\'genero_diversidade_sexual\' ,\'GÊNERO E DIVERSIDADE SEXUAL\' ,14 ,128 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13610 ,845 ,\'direitos_crianca_adolescente\' ,\'DIREITOS DE CRIANÇA E ADOLESCENTE\' ,14 ,129 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13612 ,845 ,\'educ_relacoes_etnicorraciais_his_cult_afro_brasil\' ,\'EDUC PARA ETNIA HIS CUL AFRO BRASILEIRA\' ,14 ,130 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13615 ,845 ,\'outros\' ,\'OUTROS\' ,14 ,131 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13616 ,845 ,\'nenhum\' ,\'NENHUM\' ,14 ,132 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
');


-- cadastro registro 51
select fc_executa_ddl('
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13510 ,846 ,\'tipo_registro\' ,\'TIPO DE REGISTRO \' ,14 ,1 ,\'51\' ,2 ,\'t\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13511 ,846 ,\'codigo_escola_inep\' ,\'CÓDIGO DA ESCOLA - INEP\' ,14 ,3 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13512 ,846 ,\'identificacao_unica_inep\' ,\'IDENTIFICAÇÃO ÚNICA(INEP) PROFISSIONAL\' ,14 ,11 ,\'\' ,12 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13513 ,846 ,\'codigo_docente_entidade_escola\' ,\'CÓDIGO DO PROFISSIONAL ESCOLAR EM SALA\' ,14 ,23 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'Código do Profissional escolar em sala de Aula na Entidade/Escola\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13514 ,846 ,\'codigo_turma_inep\' ,\'CÓDIGO DA TURMA NO INEP\' ,14 ,43 ,\'\' ,10 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13515 ,846 ,\'codigo_turma_entidade_escola\' ,\'CÓDIGO DA TURMA NA ENTIDADE/ESCOLA\' ,14 ,53 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13516 ,846 ,\'funcao_exerce_escola_turma\' ,\'FUNÇÃO QUE EXERCE NA ESCOLA/TURMA\' ,14 ,73 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13517 ,846 ,\'situacao_funcional_contratacao_vinculo\' ,\'SITUAÇÃO FUNCIONAL/REGIME DE CONTRATAÇÃO\' ,14 ,74 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'Situação Funcional/ Regime de contratação/Tipo de Vínculo\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13518 ,846 ,\'codigo_disciplina_1\' ,\'CÓDIGO DA DISCIPLINA 1\' ,14 ,75 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13519 ,846 ,\'codigo_disciplina_2\' ,\'CÓDIGO DA DISCIPLINA 2\' ,14 ,77 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13520 ,846 ,\'codigo_disciplina_3\' ,\'CÓDIGO DA DISCIPLINA 3\' ,14 ,79 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13521 ,846 ,\'codigo_disciplina_4\' ,\'CÓDIGO DA DISCIPLINA 4\' ,14 ,81 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13522 ,846 ,\'codigo_disciplina_5\' ,\'CÓDIGO DA DISCIPLINA 5\' ,14 ,83 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13523 ,846 ,\'codigo_disciplina_6\' ,\'CÓDIGO DA DISCIPLINA 6\' ,14 ,85 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13524 ,846 ,\'codigo_disciplina_7\' ,\'CÓDIGO DA DISCIPLINA 7\' ,14 ,87 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13525 ,846 ,\'codigo_disciplina_8\' ,\'CÓDIGO DA DISCIPLINA 8\' ,14 ,89 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13526 ,846 ,\'codigo_disciplina_9\' ,\'CÓDIGO DA DISCIPLINA 9\' ,14 ,91 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13527 ,846 ,\'codigo_disciplina_10\' ,\'CÓDIGO DA DISCIPLINA 10\' ,14 ,93 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13528 ,846 ,\'codigo_disciplina_11\' ,\'CÓDIGO DA DISCIPLINA \' ,14 ,95 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13529 ,846 ,\'codigo_disciplina_12\' ,\'CÓDIGO DA DISCIPLINA 12\' ,14 ,97 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13531 ,846 ,\'codigo_disciplina_13\' ,\'CÓDIGO DA DISCIPLINA 13\' ,14 ,99 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
');

-- cadastro registro 60
select fc_executa_ddl('
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13553 ,847 ,\'tipo_registro\' ,\'TIPO DE REGISTRO\' ,14 ,1 ,\'60\' ,2 ,\'t\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13559 ,847 ,\'codigo_escola_inep\' ,\'CÓDIGO DA ESCOLA - INEP\' ,14 ,3 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13563 ,847 ,\'identificacao_unica_aluno\' ,\'IDENTIFICAÇÃO ÚNICA DO ALUNO (INEP)\' ,14 ,11 ,\'\' ,12 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13568 ,847 ,\'codigo_aluno_entidade_escola\' ,\'CÓDIGO DO ALUNO NA ENTIDADE/ESCOLA\' ,14 ,23 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13572 ,847 ,\'nome_completo\' ,\'NOME COMPLETO\' ,14 ,43 ,\'\' ,100 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13575 ,847 ,\'data_nascimento\' ,\'DATA DE NASCIMENTO\' ,14 ,143 ,\'\' ,10 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13580 ,847 ,\'sexo\' ,\'SEXO\' ,14 ,153 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13582 ,847 ,\'cor_raca\' ,\'COR/RAÇA\' ,14 ,154 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13586 ,847 ,\'filiacao\' ,\'FILIAÇÃO\' ,14 ,155 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13588 ,847 ,\'filiacao_1\' ,\'FILIAÇÃO 1\' ,14 ,156 ,\'\' ,100 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13590 ,847 ,\'filiacao_2\' ,\'FILIAÇÃO 2\' ,14 ,256 ,\'\' ,100 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13593 ,847 ,\'nacionalidade_aluno\' ,\'NACIONALIDADE DO ALUNO\' ,14 ,356 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13601 ,847 ,\'pais_origem\' ,\'PAÍS DE ORIGEM\' ,14 ,357 ,\'\' ,3 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13604 ,847 ,\'uf_nascimento\' ,\'UF DE NASCIMENTO\' ,14 ,360 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13613 ,847 ,\'municipio_nascimento\' ,\'MUNICÍPIO DE NASCIMENTO\' ,14 ,362 ,\'\' ,7 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13617 ,847 ,\'alunos_deficiencia_transtorno_desenv_superdotacao\' ,\'TRANSTORNO DESENVOLVIMENTO OU SUPERDOTAÇ\' ,14 ,369 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13619 ,847 ,\'tipos_defic_transtorno_cegueira\' ,\'TRANSTORNO DESENV/SUPERDOTAÇÃO CEGUEIRA\' ,14 ,370 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13622 ,847 ,\'tipos_defic_transtorno_baixa_visao\' ,\'TRANSTORNO DESENV/SUPERDOTAÇÃO BAIXA VIS\' ,14 ,371 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13624 ,847 ,\'tipos_defic_transtorno_surdez\' ,\'TRANSTORNO DESENV/SUPERDOTAÇÃO SURDEZ\' ,14 ,372 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13626 ,847 ,\'tipos_defic_transtorno_auditiva\' ,\'TRANSTORNO DESENV/SUPERDOTAÇÃO DEF AUDIT\' ,14 ,373 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13629 ,847 ,\'tipos_defic_transtorno_surdocegueira\' ,\'TRANSTORNO DESENV/SUPERDOTAÇÃO SURDOCEGU\' ,14 ,374 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13630 ,847 ,\'tipos_defic_transtorno_def_fisica\' ,\'TRANSTORNO DESENV/SUPERDOTAÇÃO DEF FISIC\' ,14 ,375 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13631 ,847 ,\'tipos_defic_transtorno_def_intelectual\' ,\'TRANSTORNO DESENV/SUPERDOT DEF INTELECTU\' ,14 ,376 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13632 ,847 ,\'tipos_defic_transtorno_def_multipla\' ,\'TRANSTORNO DESENV/SUPERDOT DEF MULTÍPLA\' ,14 ,377 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13633 ,847 ,\'tipos_defic_transtorno_def_autismo_infantil\' ,\'TRANSTORNO DESENV/SUPERDOT DEF AUTIS INF\' ,14 ,378 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13635 ,847 ,\'tipos_defic_transtorno_def_asperger\' ,\'TRANSTORNO DESENV/SUPERDOT DEF ASPERGER\' ,14 ,379 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13637 ,847 ,\'tipos_defic_transtorno_def_sindrome_rett\' ,\'TRANSTORNO DESENV/SUPERDOT DEF RETT\' ,14 ,380 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13639 ,847 ,\'tipos_defic_transtorno_desintegrativo_infancia\' ,\'TRANSTORNO DESENV/SUPERDOT DESINT INFANC\' ,14 ,381 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13640 ,847 ,\'tipos_defic_transtorno_altas_habilidades\' ,\'TRANSTORNO DESENV/SUPERDOT ALTAS HABILID\' ,14 ,382 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13642 ,847 ,\'recurso_auxilio_ledor\' ,\'RECURSO AUXILIO LEDOR\' ,14 ,383 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13646 ,847 ,\'recurso_auxilio_transcricao\' ,\'RECURSO AUXILIO LEDOR\' ,14 ,384 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13649 ,847 ,\'recurso_auxilio_interprete\' ,\'RECURSO AUXILIO INTERPRETE\' ,14 ,385 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13650 ,847 ,\'recurso_auxilio_interprete_libras\' ,\'RECURSO AUXILIO INTERPRETE LIBRAS\' ,14 ,386 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13651 ,847 ,\'recurso_auxilio_leitura_labial\' ,\'RECURSO AUXILIO LEITURA LABIAL\' ,14 ,387 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13653 ,847 ,\'recurso_auxilio_prova_ampliada_16\' ,\'RECURSO AUXILIO PROVA AMPLIADA 16\' ,14 ,388 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13654 ,847 ,\'recurso_auxilio_prova_ampliada_20\' ,\'RECURSO AUXILIO PROVA AMPLIADA 20\' ,14 ,389 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13656 ,847 ,\'recurso_auxilio_prova_ampliada_24\' ,\'RECURSO AUXILIO PROVA AMPLIADA 24\' ,14 ,390 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13671 ,847 ,\'recurso_auxilio_prova_braille\' ,\'RECURSO AUXILIO PROVA BRAILLE\' ,14 ,391 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13672 ,847 ,\'recurso_auxilio_nenhum\' ,\'RECURSO AUXILIO NENHUM\' ,14 ,392 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
');

-- cadastro registro 70
select fc_executa_ddl('
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13539 ,848 ,\'tipo_registro\' ,\'TIPO DE REGISTRO\' ,14 ,1 ,\'70\' ,2 ,\'t\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13541 ,848 ,\'codigo_escola_inep\' ,\'CÓDIGO DE ESCOLA - INEP\' ,14 ,3 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13543 ,848 ,\'identificacao_unica_aluno\' ,\'IDENTIFICAÇÃO ÚNICA DO ALUNO (INEP)\' ,14 ,11 ,\'\' ,12 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13546 ,848 ,\'codigo_aluno_entidade\' ,\'CÓDIGO DO ALUNO NA ENTIDADE/ESCOLA\' ,14 ,23 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13548 ,848 ,\'numero_identidade\' ,\'NÚMERO DA IDENTIDADE\' ,14 ,43 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13550 ,848 ,\'orgao_emissor_identidade\' ,\'ÓRGÃO EMISSOR DA IDENTIDADE\' ,14 ,63 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13552 ,848 ,\'uf_identidade\' ,\'UF DA IDENTIDADE\' ,14 ,65 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13569 ,848 ,\'data_expedicao_identidade\' ,\'DATA DE EXPEDIÇÃO DA IDENTIDADE\' ,14 ,67 ,\'\' ,10 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13571 ,848 ,\'certidao_civil\' ,\'CERTIDÃO CIVIL\' ,14 ,77 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13573 ,848 ,\'tipo_certidao_civil\' ,\'TIPO DE CERTIDÃO CIVIL\' ,14 ,78 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13576 ,848 ,\'numero_termo\' ,\'NÚMERO DO TERMO\' ,14 ,79 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13578 ,848 ,\'folha\' ,\'FOLHA\' ,14 ,87 ,\'\' ,4 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13579 ,848 ,\'livro\' ,\'LIVRO\' ,14 ,91 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13581 ,848 ,\'data_emissao_certidao\' ,\'DATA DE EMISSÃO DA CERTIDÃO\' ,14 ,99 ,\'\' ,10 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13583 ,848 ,\'uf_cartorio\' ,\'UF DO CARTÓRIO\' ,14 ,109 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13597 ,848 ,\'municipio_cartorio\' ,\'MUNICÍPIO DO CARTÓRIO\' ,14 ,111 ,\'\' ,7 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13599 ,848 ,\'codigo_cartorio\' ,\'CÓDIGO DO CARTÓRIO\' ,14 ,118 ,\'\' ,6 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13603 ,848 ,\'numero_matricula\' ,\'NÚMERO DA MATRÍCULA - CERTIDÃO NOVA\' ,14 ,124 ,\'\' ,32 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13607 ,848 ,\'numero_cpf\' ,\'NÚMERO DO CPF\' ,14 ,156 ,\'\' ,11 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13609 ,848 ,\'documento_estrangeiro_passaporte\' ,\'DOCUMENTO ESTRANGEIRO/PASSAPORTE\' ,14 ,167 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13611 ,848 ,\'numero_identificacao_social\' ,\'NÚMERO DE IDENTIFICAÇÃO SOCIAL (NIS)\' ,14 ,187 ,\'\' ,11 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13614 ,848 ,\'localizacao_zona_residencia\' ,\'LOCALIZAÇÃO / ZONA DE RESIDÊNCIA\' ,14 ,198 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13618 ,848 ,\'cep\' ,\'CEP\' ,14 ,199 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13620 ,848 ,\'endereco\' ,\'ENDEREÇO\' ,14 ,207 ,\'\' ,100 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13621 ,848 ,\'numero\' ,\'NÚMERO\' ,14 ,307 ,\'\' ,10 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13623 ,848 ,\'complemento\' ,\'COMPLEMENTO\' ,14 ,317 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13625 ,848 ,\'bairro\' ,\'BAIRRO\' ,14 ,337 ,\'\' ,50 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13627 ,848 ,\'uf\' ,\'UF\' ,14 ,387 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13628 ,848 ,\'municipio\' ,\'MUNICÍPIO\' ,14 ,389 ,\'\' ,7 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
');

-- cadastro registro 80
select fc_executa_ddl('
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13636 ,849 ,\'tipo_registro\' ,\'TIPO DE REGISTRO\' ,14 ,1 ,\'80\' ,2 ,\'t\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13638 ,849 ,\'codigo_escola_inep\' ,\'CÓDIGO DA ESCOLA - INEP\' ,14 ,3 ,\'\' ,8 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13641 ,849 ,\'identificacao_unica_aluno\' ,\'IDENTIFICAÇÃO ÚNICA DO ALUNO( INEP )\' ,14 ,11 ,\'\' ,12 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13643 ,849 ,\'codigo_aluno_entidade_escola\' ,\'CÓDIGO DO ALUNO NA ENTIDADE/ESCOLA\' ,14 ,23 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13644 ,849 ,\'codigo_turma_inep\' ,\'CÓDIGO DA TURMA NO INEP\' ,14 ,43 ,\'\' ,10 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13645 ,849 ,\'codigo_turma_entidade_escola\' ,\'CÓDIGO DA TURMA NA ENTIDADE/ESCOLA\' ,14 ,53 ,\'\' ,20 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13647 ,849 ,\'codigo_matricula_aluno\' ,\'CÓDIGO DA MATRÍCULA DO ALUNO\' ,14 ,73 ,\'\' ,12 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13648 ,849 ,\'turma_unificada\' ,\'TURMA UNIFICADA\' ,14 ,85 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13652 ,849 ,\'codigo_etapa_multi_etapa\' ,\'ALUNO NA TURMA MULTIETAPA EJA NORMAL/PRO\' ,14 ,86 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13655 ,849 ,\'recebe_escolarizacao_outro_espaco\' ,\'RECEBE ESCOLARIZAÇÃO EM OUTRO ESPAÇO\' ,14 ,88 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13657 ,849 ,\'transporte_escolar_publico\' ,\'TRANSPORTE ESCOLAR PÚBLICO\' ,14 ,89 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13658 ,849 ,\'poder_publico_transporte_escolar\' ,\'PODER PÚBLICO RESPONSÁVEL PELO TRANSPORT\' ,14 ,90 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13659 ,849 ,\'rodoviario_vans_kombi\' ,\'RODOVIÁRIO - VANS/KOMBI\' ,14 ,91 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13660 ,849 ,\'rodoviario_microonibus\' ,\'RODOVIARIO - MICROÔNIBUS\' ,14 ,92 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13661 ,849 ,\'rodoviario_onibus\' ,\'RODOVIARIO ÔNIBUS\' ,14 ,93 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13662 ,849 ,\'rodoviario_bicicleta\' ,\'RODOVIARIO BICICLETA\' ,14 ,94 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13663 ,849 ,\'rodoviario_tracao_animal\' ,\'RODOVIARIO TRAÇÃO ANIMAL\' ,14 ,95 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13664 ,849 ,\'rodoviario_outro\' ,\'RODOVIARIO OUTRO\' ,14 ,96 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13665 ,849 ,\'aquaviario_embarcacao_5_pessoas\' ,\'AQUAVIARIO EMBARCACAO CAPACIDADE PARA 5\' ,14 ,97 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13666 ,849 ,\'aquaviario_embarcacao_5_a_15_pessoas\' ,\'AQUAVIARIO EMBARCACAO CAPACIDADE 5 A 15\' ,14 ,98 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13667 ,849 ,\'aquaviario_embarcacao_15_a_35_pessoas\' ,\'AQUAVIARIO EMBARCACAO CAPACIDADE 15 A 35\' ,14 ,99 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13668 ,849 ,\'aquaviario_embarcacao_mais_de_35_pessoas\' ,\'AQUAVIARIO EMBARCACAO CAPACIDADE + 35 PE\' ,14 ,100 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13669 ,849 ,\'ferroviario_trem_metro\' ,\'FERROVIÁRIO TREM/METRÔ\' ,14 ,101 ,\'\' ,1 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13670 ,849 ,\'forma_ingresso_aluno_escola_federal\' ,\'FORMA INGRESSO ALUNO ESCOLA FEDERAL\' ,14 ,102 ,\'\' ,2 ,\'f\' ,\'t\' ,\'d\' ,\'\' ,0 );
');

-- cadastro registro 99
select fc_executa_ddl('
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos ) values ( 13634 ,850 ,\'tipo_registro\' ,\'TIPO DE REGISTRO\' ,14 ,1 ,\'99\' ,2 ,\'t\' ,\'t\' ,\'d\' ,\'\' ,0 );
');

-- adicionado vinculos dos campos do layout do registro 50 com avaliação 3000002 - CENSO RECURSO HUMANO
select fc_executa_ddl('
 select setval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\', (select max(ed313_sequencial) from avaliacaoperguntaopcaolayoutcampo));
 insert into avaliacaoperguntaopcaolayoutcampo
        (ed313_sequencial, ed313_ano, ed313_db_layoutcampo, ed313_avaliacaoperguntaopcao, ed313_layoutvalorcampo )
 values ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13592, 3000079, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13594, 3000080, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13589, 3000077, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13596, 3000082, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13595, 3000081, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13591, 3000078, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13585, 3000075, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13577, 3000073, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13584, 3000074, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13587, 3000076, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13610, 3000118, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13612, 3000119, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13605, 3000115, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13602, 3000114, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13606, 3000116, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13598, 3000127, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13600, 3000084, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13608, 3000117, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13616, 3000121, 1),
        ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13615, 3000120, 1);
');

-- Ajustado vínculos dos campos do layout do registro 10 para 2016
select fc_executa_ddl('
insert into avaliacaoperguntaopcaolayoutcampo
        (ed313_sequencial, ed313_ano, ed313_db_layoutcampo, ed313_avaliacaoperguntaopcao, ed313_layoutvalorcampo )
values ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13262, 3000039, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13263, 3000040, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13265, 3000041, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13268, 3000042, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13270, 3000043, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13275, 3000044, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13279, 3000045, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13280, 3000560, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13282, 3000046, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13284, 3000047, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13284, 3000048, 2),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13284, 3000049, 3),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13285, 3000097, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13285, 3000098, 0),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13287, 3000571, \'\'),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13288, 3000572, \'\'),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13296, 3000576, \'\'),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13298, 3000573, \'\'),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13299, 3000574, \'\'),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13303, 3000575, \'\'),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13306, 3000099, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13306, 3000100, 2),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13309, 3000088, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13311, 3000089, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13312, 3000090, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13317, 3000091, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13320, 3000092, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13322, 3000093, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13324, 3000094, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13328, 3000095, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13329, 3000096, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13331, 3000050, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13332, 3000051, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13335, 3000052, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13337, 3000067, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13343, 3000068, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13346, 3000069, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13347, 3000070, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13349, 3000071, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13353, 3000072, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13356, 3000000, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13357, 3000001, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13360, 3000017, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13363, 3000002, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13367, 3000003, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13370, 3000004, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13373, 3000005, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13375, 3000006, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13377, 3000007, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13381, 3000008, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13383, 3000009, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13388, 3000010, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13389, 3000011, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13391, 3000012, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13392, 3000013, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13394, 3000014, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13395, 3000015, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13396, 3000126, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13397, 3000018, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13398, 3000019, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13403, 3000020, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13405, 3000021, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13407, 3000022, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13410, 3000023, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13413, 3000024, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13414, 3000025, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13416, 3000026, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13421, 3000027, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13422, 3000028, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13424, 3000016, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13425, 3000103, \'\'),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13426, 3000104, \'\'),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13427, 3000056, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13428, 3000057, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13429, 3000058, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13430, 3000059, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13442, 3000060, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13444, 3000061, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13445, 3000062, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13447, 3000063, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13448, 3000064, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13449, 3000065, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13450, 3000066, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13451, 3000032, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13452, 3000579, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13453, 3000033, \'\'),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13454, 3000113, \'\'),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13455, 3000035, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13455, 3000036, 0),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13456, 3000037, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13456, 3000038, 0),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13459, 3000101, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13459, 3000102, 0),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13460, 3000108, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13460, 3000109, 2),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13460, 3000110, 0),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13462, 3000105, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13462, 3000106, 0),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13462, 3000107, 2),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13470, 3000111, 0),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13470, 3000112, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13472, 3000053, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13473, 3000054, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13475, 3000055, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13482, 3000122, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13482, 3000123, 0),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13484, 3000124, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13484, 3000125, 0),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13485, 3000561, 1),
       ( nextval(\'avaliacaoperguntaopcaolayoutcampo_ed313_sequencial_seq\'), 2016, 13485, 3000562, 0);
');
