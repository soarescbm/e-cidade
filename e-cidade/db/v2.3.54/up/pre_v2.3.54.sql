---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

select fc_executa_ddl('insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10252 ,\'Escolas da Rede\' ,\'Atestado para alunos da Rede\' ,\'\' ,\'1\' ,\'1\' ,\'Gera um atestado para alunos da Rede.\' ,\'true\' )');
select fc_executa_ddl('delete from db_menu where id_item_filho = 10252 AND modulo = 1100747');
select fc_executa_ddl('insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1101103 ,10252 ,3 ,1100747 )');
select fc_executa_ddl('insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10253 ,\'Outras Escolas\' ,\'Atestado para alunos de fora da Rede.\' ,\'edu4_atestadovagafora001.php\' ,\'1\' ,\'1\' ,\'Gera um atestado para alunos de fora da Rede.\' ,\'true\' )');
select fc_executa_ddl('delete from db_menu where id_item_filho = 10253 AND modulo = 1100747');
select fc_executa_ddl('insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1101103 ,10253 ,4 ,1100747 )');

select fc_executa_ddl('delete from db_menu where id_item_filho = 6981 AND modulo = 1100747');
select fc_executa_ddl('insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10252 ,6981 ,1 ,1100747 )');

select fc_executa_ddl('delete from db_menu where id_item_filho = 6982 AND modulo = 1100747');
select fc_executa_ddl('insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10252 ,6982 ,2 ,1100747 )');

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------- INICIO FINANCEIRO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

update db_syscampo set rotulo = 'Número do Processo', rotulorel = 'Número do Processo' where nomecam = 'ac16_numeroprocesso';

insert into db_sysarquivo select 3954, 'empnotasuspensao', 'Informações referentes as notas de liquidação suspensas das listas de classificação de credores.', 'cc36', '2016-08-03', 'Suspensão de Nota de Liquidação', 0, 'f', 'f', 'f', 'f' where not exists(select 1 from db_sysarquivo where codarq = 3954);
insert into db_sysarqmod select 38, 3954 where not exists (select 1 from db_sysarqmod where (codmod, codarq) = (38,3954));

insert into db_syscampo select 21966 ,'cc36_sequencial' ,'int4' ,'Código' ,'' ,'Codigo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Codigo' where not exists (select 1 from db_syscampo where codcam = 21966);
insert into db_sysarqcamp select 3954 ,21966 ,1 ,0 where not exists (select 1 from db_sysarqcamp where (codarq, codcam, seqarq) = (3954 ,21966 ,1));

insert into db_syscampo select 21967 ,'cc36_empnota' ,'int4' ,'Nota de Liquidação' ,'' ,'Nota de Liquidação' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Nota de Liquidação' where not exists (select 1 from db_syscampo where codcam = 21967 );
insert into db_sysarqcamp select 3954 ,21967 ,2 ,0  where not exists (select 1 from db_sysarqcamp where (codarq, codcam, seqarq) = (3954 ,21967 ,2));

insert into db_syscampo select 21968 ,'cc36_justificativasuspensao' ,'text' ,'Justificativa de Suspensão' ,'' ,'Justificativa de Suspensão' ,1 ,'false' ,'false' ,'false' ,0 ,'text' ,'Justificativa de Suspensão' where not exists (select 1 from db_syscampo where codcam = 21968 );
insert into db_sysarqcamp select 3954 ,21968 ,3 ,0 where not exists (select 1 from db_sysarqcamp where (codarq, codcam, seqarq) = (3954 ,21968 ,3));

insert into db_syscampo select 21969 ,'cc36_datasuspensao' ,'date' ,'Data de Suspensão' ,'' ,'Data de Suspensão' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Data de Suspensão' where not exists (select 1 from db_syscampo where codcam = 21969);
insert into db_sysarqcamp select 3954 ,21969 ,4 ,0 where not exists (select 1 from db_sysarqcamp where (codarq, codcam, seqarq) = (3954 ,21969 ,4));

insert into db_syscampo select 21970 ,'cc36_justificativaretorno' ,'text' ,'Justificativa de Retorno' ,'' ,'Justificativa de Retorno' ,1 ,'true' ,'false' ,'false' ,0 ,'text' ,'Justificativa de Retorno' where not exists (select 1 from db_syscampo where codcam = 21970);
insert into db_sysarqcamp select 3954 ,21970 ,5 ,0 where not exists (select 1 from db_sysarqcamp where (codarq, codcam, seqarq) = (3954 ,21970 ,5));

insert into db_syscampo select 21971 ,'cc36_dataretorno' ,'date' ,'Data de Retorno' ,'' ,'Data de Retorno' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Data de Retorno' where not exists (select 1 from db_syscampo where codcam = 21971);
insert into db_sysarqcamp select 3954 ,21971 ,6 ,0 where not exists (select 1 from db_sysarqcamp where (codarq, codcam, seqarq) = (3954 ,21971 ,6));

insert into db_sysprikey select 3954,21966,1,21966 where not exists (select 1 from db_sysprikey where (codarq, codcam, sequen) = (3954,21966,1));

insert into db_syssequencia select 1000589, 'empnotasuspensao_cc36_sequencial_seq', 1, 1, 9223372036854775807, 1, 1 where not exists (select 1 from db_syssequencia  where codsequencia = 1000589);
update db_sysarqcamp set codsequencia = 1000589 where codarq = 3954 and codcam = 21966;

insert into db_sysforkey select 3954,21967,1,971,0 where not exists (select 1 from db_sysforkey where (codarq, codcam, sequen, referen) = (3954,21967,1,971));

insert into db_itensmenu select 10254 ,'Suspensão da Classificação de Credores' ,'Suspensão da Classificação de Credores' ,'emp4_suspensaopagamentonota001.php' ,'1' ,'1' ,'Suspensão da Classificação de Credores' ,'true' where not exists (select 1 from db_itensmenu where id_item = 10254);
insert into db_menu select 32 ,10254 ,471 ,398 where not exists (select 1 from db_menu where (id_item, id_item_filho, modulo) = (32 ,10254 , 398));

insert into db_itensmenu select 10262, 'Notas de Liquidação Suspensas', 'Notas de Liquidação Suspensas', 'cai3_notaliquidacaosuspensa001.php', '1', '1', 'Nota de Liquidação Suspensas', '1'	where not exists (select 1 from db_itensmenu where id_item = 10262);
insert into db_itensfilho select 10262,1 where not exists (select 1 from db_itensfilho where (id_item, codfilho) = (10262,1));
insert into db_menu select 30,10262,453,39 where not exists (select 1 from db_menu where (id_item, id_item_filho, modulo) = (30,10262,39));


select fc_executa_ddl('
  update db_itensmenu set descricao = \'Reprocessar Saldo de Contas\', help = \'Reprocessa o saldo das contas correntes já existentes\', funcao = \'con4_reprocessacontacorrente001.php\', itemativo = \'1\', desctec = \'Reprocessa o saldo das contas correntes já existentes\', libcliente = \'1\' where id_item = 9683;
  delete from db_itensfilho where id_item = 9683;
  insert into db_itensfilho values(9683,1);
  insert into db_itensmenu values( 10265, \'Processar\', \'Cria novas contas correntes\', \'con4_processarcontacorrente001.php\', \'1\', \'1\', \'\', true );
  insert into db_itensfilho (id_item, codfilho) values(10265,1);
  delete from db_menu where id_item_filho = 10265 AND modulo = 209;
  insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 9680 ,10265 ,3 ,209 );
');

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL FINANCEIRO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------- INICIO TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21959 ,'k170_valor' ,'float4' ,'Valor Compensado' ,'' ,'k170_valor' ,10 ,'false' ,'false' ,'false' ,4 ,'text' ,'k170_valor' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3859 ,21959 ,7 ,0 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10256 ,'Compensação' ,'Compensação' ,'arr4_compensarCredito001.php' ,'1' ,'1' ,'Compensação' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 9625 ,10256 ,5 ,1985522 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10263 ,'Relatório de Compensações' ,'Relatório de Compensações' ,'arr2_relatoriocompensacoes001.php' ,'1' ,'1' ,'Relatório de Compensações' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 30 ,10263 ,454 ,1985522 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10264 ,'Relatório de Devoluções' ,'Relatório de Devoluções' ,'arr2_relatoriodevolucoes001.php' ,'1' ,'1' ,'Relatório de Devoluções' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 30 ,10264 ,455 ,1985522 );

update db_syscampo set aceitatipo = 4 where codcam = 192;

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO FOLHA ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

--Menus e Dic Dados da tarefa de concessão de direitos
select fc_executa_ddl('update db_syscampo set nulo = true where codcam = 21801');
select fc_executa_ddl('update db_syscampo set nulo = true where codcam = 21802;');
select fc_executa_ddl('insert into db_syscampo values (21954,\'h82_formulaprorrogafim\',\'int4\',\'Formula que calcula data final do afastamento, contando a prorrogação da data fina por faltas, licenças, etc\',\'0\', \'Fórmula de Prorrogação do Fim\',10,\'t\',\'f\',\'f\',1,\'text\',\'Fórmula de Prorrogação do Fim\');');
select fc_executa_ddl('insert into db_sysarqcamp values(3835,21954,9,0)');

select fc_executa_ddl('insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10250 ,\'Concessão de Direitos\' ,\'Concessão de Direitos\' ,\'\' ,\'1\' ,\'1\' ,\'Concessão de Direitos\' ,\'true\' );');
select fc_executa_ddl('delete from db_menu where id_item_filho = 10250 AND modulo = 2323;');
select fc_executa_ddl('insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 32 ,10250 ,470 ,2323 );');
select fc_executa_ddl('update db_itensmenu set id_item = 10114 , descricao = \'Processamento\', help = \'Processamento\' where id_item = 10114;');
select fc_executa_ddl('delete from db_menu where id_item_filho = 10114 AND modulo = 2323;');
select fc_executa_ddl('insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10250 ,10114 ,1 ,2323 );');
select fc_executa_ddl('update db_itensmenu set id_item = 10113 , descricao = \'Parâmetros\' , help = \'Parâmetros\' where id_item = 10113;');
select fc_executa_ddl('delete from db_menu where id_item_filho = 10113 AND modulo = 2323;');
select fc_executa_ddl('insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10250 ,10113 ,2 ,2323 );');

select fc_executa_ddl('insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10251 ,\'Previsão de Direitos\' ,\'Previsão de Direitos\' ,\'rec2_previsaodedireitos001.php\' ,\'1\' ,\'1\' ,\'Previsão de Direitos\' ,\'true\' );');
select fc_executa_ddl('delete from db_menu where id_item_filho = 10251 AND modulo = 2323;');
select fc_executa_ddl('insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 30 ,10251 ,452 ,2323 );');
update db_syscampo set conteudo = 'float4' where codcam = 20927;


--Menu Evento financeiro Automático
insert into db_itensmenu select 10255 ,'Evento Financeiro Automático' ,'Configuração de Eventos Financeiros Automáticos' ,'pes4_eventofinanceiroautomatico001.php' ,'1' ,'1' ,'Configuração dos Eventos financeiros que devem ser lançados automaticamente em um determinado mês.' ,'true' from db_itensmenu where not exists (select 1 from db_itensmenu where id_item = 10255) limit 1;
insert into db_menu select 3516 ,10255 ,15 ,952 from db_menu where not exists (select 1 from db_menu where id_item_filho = 10255) limit 1;

-- Tabela eventofinanceiroautomatico
insert into db_sysarquivo select 3955, 'eventofinanceiroautomatico', 'Tabela que armazena os dados de configuração para eventos financeiros automaticos', 'rh181', '2016-08-04', 'Evento Financeiro Automatico', 0, 'f', 'f', 'f', 'f' from db_sysarquivo where not exists (select 1 from db_sysarquivo where codarq = 3955) limit 1;
insert into db_sysarqmod select 28,3955 from db_sysarqmod where not exists (select 1 from db_sysarqmod where codarq = 3955) limit 1;
insert into db_syscampo select 21972,'rh181_sequencial','int4','Sequencial da configuração dos eventos financeiros automaticos','0', 'Sequêncial',10,'f','f','t',1,'text','Sequêncial' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 21972) limit 1;
insert into db_syscampo select 21973,'rh181_descricao','varchar(56)','Descrição do evento financeiro automatico','', 'Descrição',56,'f','f','f',0,'text','Descrição' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 21973) limit 1;
insert into db_syscampo select 21974,'rh181_rubrica','varchar(4)','Rubrica a ser lançado no pondo de salário','', 'Rubrica',4,'f','f','f',3,'text','Rubrica' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 21974) limit 1;
insert into db_syscampo select 21975,'rh181_mes','int4','Mês de lançamento do evento financeiro','0', 'Mês',2,'f','f','f',1,'text','Mês' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 21975) limit 1;
insert into db_syscampo select 21976,'rh181_selecao','int4','Seleção para qual deve ser lançado o evento financeiro','0', 'Seleção',10,'f','f','f',1,'text','Seleção' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 21976) limit 1;
insert into db_syscampo select 21977,'rh181_instituicao','int4','Instituição a qual esta configuração pertence','0', 'Instituição',20,'f','f','f',1,'text','Instituição' from db_syscampo where not exists (select 1 from db_syscampo where codcam = 21977) limit 1;
insert into db_sysarqcamp select 3955,21972,1,0 from db_sysarqcamp where not exists (select 1 from db_sysarqcamp where codcam = 21972) limit 1;
insert into db_sysarqcamp select 3955,21973,2,0 from db_sysarqcamp where not exists (select 1 from db_sysarqcamp where codcam = 21973) limit 1;
insert into db_sysarqcamp select 3955,21974,3,0 from db_sysarqcamp where not exists (select 1 from db_sysarqcamp where codcam = 21974) limit 1;
insert into db_sysarqcamp select 3955,21975,4,0 from db_sysarqcamp where not exists (select 1 from db_sysarqcamp where codcam = 21975) limit 1;
insert into db_sysarqcamp select 3955,21976,5,0 from db_sysarqcamp where not exists (select 1 from db_sysarqcamp where codcam = 21976) limit 1;
insert into db_sysarqcamp select 3955,21977,6,0 from db_sysarqcamp where not exists (select 1 from db_sysarqcamp where codcam = 21977) limit 1;
insert into db_sysprikey (codarq,codcam,sequen,camiden) select 3955,21972,1,21972 from db_sysprikey where not exists (select 1 from db_sysprikey where codarq = 3955) limit 1;
insert into db_sysindices select 4372,'eventofinanceiroautomatico_rubrica_mes_selecao_instituicao_un',3955,'1' from db_sysindices where not exists (select 1 from db_sysindices where codind = 4372) limit 1;
insert into db_syscadind select 4372,21974,1 from db_syscadind where not exists(select 1 from db_syscadind where codcam = 21974) limit 1;
insert into db_syscadind select 4372,21975,2 from db_syscadind where not exists(select 1 from db_syscadind where codcam = 21975) limit 1;
insert into db_syscadind select 4372,21976,3 from db_syscadind where not exists(select 1 from db_syscadind where codcam = 21976) limit 1;
insert into db_syscadind select 4372,21977,4 from db_syscadind where not exists(select 1 from db_syscadind where codcam = 21977) limit 1;
insert into db_sysforkey select 3955,21976,1,591,0 from db_sysforkey where not exists (select 1 from db_sysforkey where codcam = 21976 and referen = 591) limit 1;
insert into db_sysforkey select 3955,21977,2,591,0 from db_sysforkey where not exists (select 1 from db_sysforkey where codcam = 21977 and referen = 591) limit 1;
insert into db_sysforkey select 3955,21977,1,83,0 from db_sysforkey where not exists (select 1 from db_sysforkey where codcam = 21977 and referen = 83) limit 1;
insert into db_sysforkey select 3955,21974,1,1177,0 from db_sysforkey where not exists (select 1 from db_sysforkey where codcam = 21974 and referen = 1177) limit 1;
insert into db_sysforkey select 3955,21977,2,1177,0 from db_sysforkey where not exists (select 1 from db_sysforkey where codcam = 21977 and referen = 1177) limit 1;
insert into db_syssequencia select 1000590, 'eventofinanceiroautomatico_rh181_sequencial_seq', 1, 1, 9223372036854775807, 1, 1 from db_syssequencia where not exists (select 1 from db_syssequencia where codsequencia = 1000590) limit 1;
update db_sysarqcamp set codsequencia = 1000590 where codarq = 3955 and codcam = 21972;


--
-- Melhoria para consignados
-- Menus
update db_itensmenu set id_item = 10232 , descricao = 'Manutenção de Empréstimos Consignados' where id_item = 10232;
delete from db_menu where id_item_filho = 10232;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values (1818, 10232, 10, 952);

insert into db_itensmenu select 10257 ,'Convênios' ,'Outras integrações de consignados' ,'' ,'1' ,'1' ,'Outras integrações de consignados, exemplo: consignet e e-consig' ,'true' from db_itensmenu where not exists (select 1 from db_itensmenu where id_item = 10257) limit 1;
delete from db_menu where id_item_filho = 10257 AND modulo = 952;
insert into db_menu select 10232 ,10257 ,5 ,952 from db_menu where not exists (select 1 from db_menu where id_item = 10232 and id_item_filho = 10257 and menusequencia = 5 and modulo = 952) limit 1;
delete from db_menu where id_item_filho = 10049 AND modulo = 952;
insert into db_menu select 10257, 10049, 1, 952 from db_menu where not exists (select 1 from db_menu where id_item = 10257 and id_item_filho = 10049 and menusequencia = 1 and modulo = 952) limit 1;
delete from db_menu where id_item_filho = 9866 AND modulo = 952;
insert into db_menu select 10257, 9866, 2, 952 from db_menu where not exists (select 1 from db_menu where id_item = 10257 and id_item_filho = 9866 and menusequencia = 2 and modulo = 952) limit 1;

insert into db_itensmenu select 10258 ,'Gestão de Consignados' ,'Gestão de Consignados' ,'' ,'1' ,'1' ,'Menu para a gerência/gestão de contratos consignados que não são realizados via importação de arquivo.' ,'true' from db_itensmenu where not exists (select 1 from db_itensmenu where id_item = 10258) limit 1;
delete from db_menu where id_item_filho = 10258 AND modulo = 952;
insert into db_menu select 10232, 10258, 6, 952 from db_menu where not exists (select 1 from db_menu where id_item = 10232 and id_item_filho = 10258 and menusequencia = 6 and modulo = 952) limit 1;
insert into db_itensmenu select 10259 ,'Manutenção de Contratos' ,'Manutenção de Contratos' ,'pes4_manutencaocontratosconsignados.php' ,'1' ,'1' ,'Rotina para gerenciar manualmente a inclusão de descontos consignados.' ,'true' from db_itensmenu where not exists (select 1 from db_itensmenu where id_item = 10259) limit 1;
delete from db_menu where id_item_filho = 10259 AND modulo = 952;
insert into db_menu select 10258, 10259, 1, 952 from db_menu where not exists (select 1 from db_menu where id_item = 10258 and id_item_filho = 10259 and menusequencia = 1 and modulo = 952) limit 1;
delete from db_menu where id_item_filho = 10238 AND modulo = 952;
insert into db_menu select 10258, 10238, 2, 952 from db_menu where not exists (select 1 from db_menu where id_item = 10258 and id_item_filho = 10238 and menusequencia = 2 and modulo = 952) limit 1;

insert into db_itensmenu select 10260 ,'Arquivos' ,'Importação de arquivos consignados' ,'' ,'1' ,'1' ,'Importação de arquivos consignados' ,'true' from db_itensmenu where not exists (select 1 from db_itensmenu where id_item = 10260) limit 1;
delete from db_menu where id_item_filho = 10260 AND modulo = 952;
insert into db_menu select 10232, 10260, 7, 952 from db_menu where not exists (select 1 from db_menu where id_item = 10232 and id_item_filho = 10260 and menusequencia = 7 and modulo = 952) limit 1;
delete from db_menu where id_item_filho = 10234 AND modulo = 952;
insert into db_menu select 10260, 10234, 1, 952 from db_menu where not exists (select 1 from db_menu where id_item = 10260 and id_item_filho = 10234 and menusequencia = 1 and modulo = 952) limit 1;
update db_itensmenu set id_item = 10235 , descricao = 'Exportar' where id_item = 10235;
delete from db_menu where id_item_filho = 10235 AND modulo = 952;
insert into db_menu select 10260, 10235, 2, 952 from db_menu where not exists (select 1 from db_menu where id_item = 10260 and id_item_filho = 10235 and menusequencia = 2 and modulo = 952) limit 1;

insert into db_itensmenu select 10261 ,'Parâmetros' ,'Parâmetros' ,'' ,'1' ,'1' ,'Parâmetros de configuração para importação de arquivos, rubrica layout e banco são configurados.' ,'true' from db_itensmenu where not exists (select 1 from db_itensmenu where id_item = 10261) limit 1;
delete from db_menu where id_item_filho = 10261 AND modulo = 952;
insert into db_menu select 10232, 10261, 8, 952 from db_menu where not exists (select 1 from db_menu where id_item = 10232 and id_item_filho = 10261 and menusequencia = 8 and modulo = 952) limit 1;
delete from db_menu where id_item_filho = 10231 AND modulo = 952;
insert into db_menu select 10261, 10231, 1, 952 from db_menu where not exists (select 1 from db_menu where id_item = 10261 and id_item_filho = 10231 and menusequencia = 1 and modulo = 952) limit 1;


update db_itensmenu set id_item = 10232 , descricao = 'Consignados' where id_item = 10232;
delete from db_menu where id_item_filho IN (10032, 10066, 10059);
delete from db_menu where id_item_filho IN (10232, 9866, 10049, 10238, 10234, 10235, 10231);

insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (5106, 10049, 17, 952);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (5106, 10232, 18, 952);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (5106,  9866, 15, 952);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (10232, 10234, 1, 952);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (10232, 10238, 2, 952);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (10232, 10235, 3, 952);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (1818, 10032, 105, 952);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (1818, 10059, 106, 952);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (1818, 10066, 107, 952);
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (3516, 10231, 14, 952);

insert into db_itensmenu select 10270,'Manutenção de Empréstimos Consignados','Rotina para manutenção de empréstimos consignados.','','1','1','Rotina para manutenção de empréstimos consignados.','true' from db_itensmenu where NOT EXISTS (select 1 from db_itensmenu where id_item = 10270) limit 1;
delete from db_menu where id_item_filho = 10270 AND modulo = 952;
insert into db_menu (id_item, id_item_filho, menusequencia, modulo ) values (1818, 10270, 10, 952);

insert into db_itensmenu select 10271,'Consignet','Rotinas de arquivos de consignação para DB1','','1','1','Menu com as rotinas de geração, importação e exportação de arquivos para o consignet da empresa DB1','true' from db_itensmenu where NOT EXISTS (select 1 from db_itensmenu where id_item = 10271) limit 1;
delete from db_menu where id_item_filho = 10271 AND modulo = 952;
insert into db_menu (id_item, id_item_filho, menusequencia, modulo ) values (10257, 10271, 3, 952);

insert into db_itensmenu select 10272,'E-Consig','E-Consig','','1','1','Menu criado para geração de arquivo do e-consig','true' from db_itensmenu where NOT EXISTS (select 1 from db_itensmenu where id_item = 10272) limit 1;
delete from db_menu where id_item_filho = 10272 AND modulo = 952;
insert into db_menu (id_item, id_item_filho, menusequencia, modulo ) values (10257, 10272, 4, 952);

insert into db_itensmenu select 10273,'Conferência de Dados','Conferência de Dados','pes4_conferenciaconsignados001.php','1','1','Conferência de Dados','true' from db_itensmenu where NOT EXISTS (select 1 from db_itensmenu where id_item = 10273) limit 1;
delete from db_menu where id_item_filho = 10273 AND modulo = 952;
insert into db_menu (id_item, id_item_filho, menusequencia, modulo ) values (10258, 10273, 3, 952);

insert into db_itensmenu select 10274,'Importar','Importar dados do arquivo','pes4_importararquivoconsignado001.php','1','1','Importar dados do arquivo','true' from db_itensmenu where NOT EXISTS (select 1 from db_itensmenu where id_item = 10274) limit 1;
delete from db_menu where id_item_filho = 10274 AND modulo = 952;
insert into db_menu (id_item, id_item_filho, menusequencia, modulo ) values (10260, 10274, 3, 952);

insert into db_itensmenu select 10275,'Exportar','Exportar os dados do arquivo','pes4_exportararquivoconsignado001.php','1','1','Exportar os dados do arquivo','true' from db_itensmenu where NOT EXISTS (select 1 from db_itensmenu where id_item = 10275) limit 1;
delete from db_menu where id_item_filho = 10275 AND modulo = 952;
insert into db_menu (id_item, id_item_filho, menusequencia, modulo ) values (10260, 10275, 4, 952);

insert into db_itensmenu select 10276,'Configuração Consignados','Configuração Consignados','pes4_configurararquivoconsignado001.php','1','1','Configuraçao das consignaçoes em folha','true' from db_itensmenu where NOT EXISTS (select 1 from db_itensmenu where id_item = 10276) limit 1;
delete from db_menu where id_item_filho = 10276 AND modulo = 952;
insert into db_menu (id_item, id_item_filho, menusequencia, modulo ) values (10261, 10276, 2, 952);

delete from db_menu where id_item_filho = 10257 AND modulo = 952;
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (10270, 10257, 1, 952);
delete from db_menu where id_item_filho = 10258 AND modulo = 952;
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (10270, 10258, 2, 952);
delete from db_menu where id_item_filho = 10260 AND modulo = 952;
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (10270, 10260, 3, 952);
delete from db_menu where id_item_filho = 10261 AND modulo = 952;
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (10270, 10261, 4, 952);

insert into db_itensmenu select 10277,'Processamento de Dados do Ponto','Processamento de Dados do Ponto','pes4_processamentodadosponto001.php','1','1','Rotina responsavél pelo lançamento dos dados nas tabelas do ponto.','true' from db_itensmenu where NOT EXISTS (select 1 from db_itensmenu where id_item = 10277) limit 1;
delete from db_menu where id_item_filho = 10277 AND modulo = 952;
insert into db_menu (id_item ,id_item_filho,menusequencia, modulo) values (4504, 10277, 6, 952);
insert into db_itensmenu select 10278,'Registros do Ponto em Lote','Lançar rubricas em lote','','1','1','Menu para lançamento de rúbricas em lote, lançamento pode ser feito por rúbrica ou por servidor.','true' from db_itensmenu where NOT EXISTS (select 1 from db_itensmenu where id_item = 10278) limit 1;
delete from db_menu where id_item_filho = 10278 AND modulo = 952;
insert into db_menu (id_item ,id_item_filho,menusequencia, modulo) values (4504, 10278, 7, 952);
insert into db_itensmenu select 10279,'Manutenção do Lote','Manutenção do Lote','pes4_manutencaolotesinicio001.php','1','1','Menu para criar e fechar lotes e lancar, alterar e excluir registros de um lote. Registro seria um lançamento do ponto.','true' from db_itensmenu where NOT EXISTS (select 1 from db_itensmenu where id_item = 10279) limit 1;
delete from db_menu where id_item_filho = 10279 AND modulo = 952;
insert into db_menu (id_item ,id_item_filho,menusequencia, modulo) values (10278, 10279, 1, 952);
insert into db_itensmenu select 10280,'Processar Lote','Processar Lote','pes4_processamento_loteregistroponto.php','1','1','Menu utilizado para confirmar, cancelar, excluir um lote de registros do ponto.','true' from db_itensmenu where NOT EXISTS (select 1 from db_itensmenu where id_item = 10280) limit 1;
delete from db_menu where id_item_filho = 10280 AND modulo = 952;
insert into db_menu (id_item ,id_item_filho,menusequencia, modulo) values (10278, 10280, 2, 952);
insert into db_itensmenu select 10281,'Lançamento de Assentamentos no Ponto','Lançamento de Assentamentos no Ponto','pes4_assentaloteregistroponto001.php','1','1','Menu utilizado para selecionar os assentamentos que serão pagos.','true' from db_itensmenu where NOT EXISTS (select 1 from db_itensmenu where id_item = 10281) limit 1;
delete from db_menu where id_item_filho = 10281 AND modulo = 952;
insert into db_menu (id_item ,id_item_filho,menusequencia, modulo) values (4504, 10281, 8, 952);

update db_itensmenu set funcao = funcao||'?menuDepreciado=true' where id_item IN (10061,10032,10060,10234,10235,10231,10238,10066);



--TABELA
insert into db_sysarquivo select 3956, 'rhconsignadomovimentomanual', 'Tabela para guardar os contratos consignados incluídos manualmente sem rotina de importação', 'rh182', '2016-08-11', 'rhconsignadomovimentomanual', 0, 'f', 'f', 'f', 'f' from db_sysarquivo where NOT EXISTS (select 1 from db_sysarquivo where codarq = 3956) limit 1;
delete from db_sysarqmod where codmod = 28 and codarq = 3956;
insert into db_sysarqmod values (28,3956);
insert into db_syscampo select 21869,'rh151_arquivo','oid','Conteudo do Arquivo','','Conteudo do Arquivo',1,'true','false','false',1,'text','Conteudo do Arquivo' from db_syscampo where NOT EXISTS (select 1 from db_syscampo where codcam = 21869) limit 1;
insert into db_syscampo select 21870,'rh151_banco','varchar(10)','Banco','','Banco',10,'true','false','false',0,'text','Banco' from db_syscampo where NOT EXISTS (select 1 from db_syscampo where codcam = 21870) limit 1;
insert into db_syscampo select 21978,'rh182_rhconsignadomovimento','int4','Sequencial da tabela rhconsignadomovimento','0', 'Sequencial Contrato',19,'f','f','f',1,'text','Sequencial Contrato' from db_syscampo where NOT EXISTS (select 1 from db_syscampo where codcam = 21978) limit 1;
insert into db_syscampo select 21979,'rh182_rhconsignadomovimentoservidor','int4','Sequencial da tabela rhconsignadomovimentoservidor','0', 'Sequencial da Parcela',19,'f','f','f',1,'text','Sequencial da Parcela' from db_syscampo where NOT EXISTS (select 1 from db_syscampo where codcam = 21979) limit 1;
insert into db_syscampo select 21980,'rh182_processado','bool','Campo que determina se a parcela foi ou não processada.','f', 'Flag de processamento',1,'f','f','f',5,'text','Flag de processamento' from db_syscampo where NOT EXISTS (select 1 from db_syscampo where codcam = 21980) limit 1;
insert into db_syscampo select 21981,'rh182_ano','int4','Ano da competência','0', 'Ano da competência',4,'f','f','f',1,'text','Ano da competência' from db_syscampo where NOT EXISTS (select 1 from db_syscampo where codcam = 21981) limit 1;
insert into db_syscampo select 21982,'rh182_mes','int4','Mês da competência','0', 'Mês da competência',2,'f','f','f',1,'text','Mês da competência' from db_syscampo where NOT EXISTS (select 1 from db_syscampo where codcam = 21982) limit 1;
insert into db_syscampo select 21983,'rh182_sequencial','int4','Sequencial da tabela para falicitar manutenção','0', 'Sequencial',19,'f','f','f',1,'text','Sequencial' from db_syscampo where NOT EXISTS (select 1 from db_syscampo where codcam = 21983) limit 1;
insert into db_syscampodef select 21980,'0','' from db_syscampodef where NOT EXISTS (select 1 from db_syscampodef where codcam = 21980) limit 1;
delete from db_sysarqcamp where codarq = 3956;
insert into db_sysarqcamp values(3956,21983,1,0);
insert into db_sysarqcamp values(3956,21978,2,0);
insert into db_sysarqcamp values(3956,21979,3,0);
insert into db_sysarqcamp values(3956,21980,4,0);
insert into db_sysarqcamp values(3956,21981,5,0);
insert into db_sysarqcamp values(3956,21982,6,0);
delete from db_sysprikey where codarq = 3956 and codcam = 21983 and sequen = 1;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3956,21983,1,21983);
delete from db_sysforkey where codarq = 3956;
insert into db_sysforkey values(3956,21978,1,3785,0);
insert into db_sysforkey values(3956,21979,1,3786,0);
insert into db_sysindices select 4374,'rhconsignadomovimentomanual_un_in',3956,'1' from db_sysindices where NOT EXISTS (select 1 from db_sysindices where codind = 4374) limit 1;
delete from db_syscadind where codind = 4374;
insert into db_syscadind values(4374,21978,1);
insert into db_syscadind values(4374,21979,2);
insert into db_syscadind values(4374,21981,3);
insert into db_syscadind values(4374,21982,4);
insert into db_syssequencia select 1000591, 'rhconsignadomovimentomanual_rh182_sequencial_seq', 1, 1, 9223372036854775807, 1, 1 from db_syssequencia where NOT EXISTS (select 1 from db_syssequencia where codsequencia = 1000591) limit 1;
update db_sysarqcamp set codsequencia = 1000591 where codarq = 3956 and codcam = 21983;

insert into db_syscampo select 21984,'rh151_tipoconsignado','char(1)','Informa se o tipo de consignado é de origem de importação de arquivo ou incluído manualmente.','', 'Tipo do Consignado',1,'t','t','f',0,'text','Tipo do Consignado' from db_syscampo where NOT EXISTS (select 1 from db_syscampo where codcam = 21984) limit 1;
insert into db_syscampo select 21985,'rh151_consignadoorigem','int4','Campo utilizado para referenciar quem é o consignado que deu origem a este, utilizado em casos de refinanciamentos e portabilidades.','0', 'Código do consignado de origem',19,'t','f','f',1,'text','Código do consignado de origem' from db_syscampo where NOT EXISTS (select 1 from db_syscampo where codcam = 21985) limit 1;
insert into db_syscampo select 21986,'rh151_situacao','char(1)','Informa se é um consignado normal, ou refinanciamento ou portabilidade ou se foi cancelado.','', 'Situação do consignado',1,'t','t','f',0,'text','Situação do consignado' from db_syscampo where NOT EXISTS (select 1 from db_syscampo where codcam = 21986) limit 1;
delete from db_sysarqcamp where codarq = 3785;
insert into db_sysarqcamp values(3785,21005,1,1000441);
insert into db_sysarqcamp values(3785,21006,2,0);
insert into db_sysarqcamp values(3785,21007,3,0);
insert into db_sysarqcamp values(3785,21008,4,0);
insert into db_sysarqcamp values(3785,21009,5,0);
insert into db_sysarqcamp values(3785,21010,6,0);
insert into db_sysarqcamp values(3785,21011,7,0);
insert into db_sysarqcamp values(3785,21869,8,0);
insert into db_sysarqcamp values(3785,21870,9,0);
insert into db_sysarqcamp values(3785,21984,10,0);
insert into db_sysarqcamp values(3785,21985,11,0);
insert into db_sysarqcamp values(3785,21986,12,0);

insert into db_sysarquivo
     values (3950, 'atolegalprevidencia', 'Atos legais cadastrados para previdência com base no Siprev.', 'rh179', '2016-07-13', 'Ato Legal da Previdência', 0, 'f', 'f', 'f', 'f' ),
            (3951, 'atolegalprevidenciainssirf', 'Vínculo do ato legal com uma previdência', 'rh180', '2016-07-13', 'Previdência do Ato Legal', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod
     values (28,3950),
            (28,3951);
insert into db_syscampo
     values (21941,'rh179_sequencial','int4','Código do Ato Legal','0', 'Código do Ato Legal',10,'f','f','f',1,'text','Código do Ato Legal'),
            (21942,'rh179_descricao','varchar(60)','Descrição do Ato Legal.','', 'Descrição',60,'f','t','f',0,'text','Descrição'),
            (21943,'rh180_sequencial','int4','Código sequencial de atolegalprevidenciainssirf','0', 'Código',10,'f','f','f',1,'text','Código'),
            (21950,'rh180_instituicao','int4','Código da Instituição','0', 'Código da Instituição',10,'f','f','f',1,'text','Código da Instituição'),
            (21944,'rh180_inssirf','int4','Código de vínculo da tabela inssirf','0', 'INSSIRF',10,'f','f','f',1,'text','INSSIRF'),
            (21945,'rh180_atolegal','int4','Código referente a tabela atolegalprevidencia','0', 'Ato Legal',10,'f','f','f',1,'text','Ato Legal'),
            (21946,'rh180_numero','int8','Número do Ato','0', 'Número do Ato',10,'f','f','f',1,'text','Número do Ato'),
            (21947,'rh180_ano','int4','Ano do Ato Legal','0', 'Ano',10,'f','f','f',1,'text','Ano'),
            (21948,'rh180_datapublicacao','date','Data de Publicação do Ato Legal','null', 'Data de Publicação',10,'f','f','f',1,'text','Data de Publicação'),
            (21949,'rh180_datainiciovigencia','date','Data de Início de Vigência do Ato Legal','null', 'Data de Início de Vigência',10,'f','f','f',1,'text','Data de Início de Vigência'),
            (21955,'h36_tempocontribuicaorgps','int4','Tipo de assentamento para o tempo de contribuição do RGPS na integração com o SIPREV.','0', 'Tempo de Contribuição RGPS',10,'t','f','f',1,'text','Tempo de Contribuição RGPS'),
            (21956,'h36_tempocontribuicaorpps','int4','Tipo de assentamento para o tempo de contribuição do RPPS na integração com o SIPREV.','0', 'Tempo de Contribuição RPPS',10,'t','f','f',1,'text','Tempo de Contribuição RPPS'),
            (21957,'h36_temposficticios','int4','Tipo de assentamento para os tempos fictícios na integração com o SIPREV.','0', 'Tempos Fictícios',10,'t','f','f',1,'text','Tempos Fictícios'),
            (21958,'h36_temposemcontribuicao','int4','Tipo de assentamento para o tempo sem contribuição na integração com o SIPREV.','0', 'Tempo sem Contribuição',10,'t','f','f',1,'text','Tempo sem Contribuição'),
            (21963,'r11_basefgintegral','int4','Base Função Gratificada Integral','0', 'Base Função Gratificada Integral',10,'t','f','f',1,'text','Base Função Gratificada Integral'),
            (21964,'r11_basefgparcial','int4','Base Função Gratificada Parcial','0', 'Base Função Gratificada Parcial',10,'t','f','f',1,'text','Base Função Gratificada Parcial');
insert into db_syssequencia
     values (1000585, 'atolegalprevidencia_rh179_sequencial_seq', 1, 1, 9223372036854775807, 1, 1),
            (1000586, 'atolegalprevidenciainssirf_rh180_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
insert into db_sysarqcamp
     values (3950,    21941,    1,      1000585),
            (3950,    21942,    2,      0),
            (3951,    21943,    1,      1000586),
            (3951,    21950,    2,      0),
            (3951,    21944,    3,      0),
            (3951,    21945,    4,      0),
            (3951,    21946,    5,      0),
            (3951,    21947,    6,      0),
            (3951,    21948,    7,      0),
            (3951,    21949,    8,      0),
            (2117,    21955,    8,      0),
            (2117,    21956,    9,      0),
            (2117,    21957,    10,     0),
            (536,     21963,    97,     0),
            (536,     21964,    98,     0),
            (2117,    21958,    11,     0);
insert into db_sysprikey (codarq,codcam,sequen,camiden)
    values (3950,21941,1,21942),
           (3951,21943,1,21944);
insert into db_sysforkey
     values (2117,21955,1,596,0),
            (2117,21956,1,596,0),
            (2117,21957,1,596,0),
            (2117,21958,1,596,0),
            (3951,21944,1,561,0),
            (3951,21950,2,561,0),
            (3951,21945,1,3950,0);
insert into db_sysindices
     values (4366,'rhparam_tempocontribuicaorgps_in',2117,'0'),
            (4367,'rhparam_tempocontribuicaorpps_in',2117,'0'),
            (4368,'rhparam_temposficticios_in',2117,'0'),
            (4369,'rhparam_temposemcontribuicao_in',2117,'0'),
            (4364,'atolegalprevidenciainssirf_atolegal_in',3951,'0'),
            (4363,'atolegalprevidenciainssirf_inssirf_instituicao_in',3951,'1');
insert into db_syscadind
     values (4366,21955,1),
            (4367,21956,1),
            (4368,21957,1),
            (4369,21958,1),
            (4363,21944,1),
            (4364,21945,1),
            (4363,21950,2);
update db_itensmenu set descricao = 'SIPREV' WHERE id_item = 8747;
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL FOLHA ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO SAUDE ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
insert into db_syscampo
     select 21987,'z01_registromunicipio','bool','Controla se o CGS é do município','t', 'CGS do Município',1,'f','f','f',5,'text','CGS do Município'
       from db_syscampo
      where not exists(select 1 from db_syscampo where nomecam = 'z01_registromunicipio') limit 1;

insert into db_sysarqcamp
     select 1010144, 21987, 80, 0
       from db_sysarqcamp
      where not exists(select 1 from db_sysarqcamp where codarq = 1010144 and codcam = 21987) limit 1;
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL SAUDE ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
