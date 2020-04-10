---------------------------------------------------------------------------------------------
-------------------------------- INCIO FINANCEIRO -------------------------------------------
---------------------------------------------------------------------------------------------

-- empnota
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21595 ,'e69_dtvencimento' ,'date' ,'Data limite para pagamento' ,'' ,'Data de Vencimento' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Data de Vencimento' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 971 ,21595 ,11 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21596 ,'e69_localrecebimento' ,'text' ,'Local de recebimento da nota fiscal' ,'' ,'Local de Recebimento' , 200 ,'true' ,'true' ,'false' ,0 ,'text' ,'Local de Recebimento' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 971 ,21596 ,12 ,0 );

-- classificacaocredores
insert into db_sysarquivo values (3878, 'classificacaocredores', 'Listas de Classificação de Credores', 'cc30', '2015-10-19', 'Classificação de Credores', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (38,3878);
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21597 ,'cc30_codigo' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3878 ,21597 ,1 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21598 ,'cc30_descricao' ,'varchar(100)' ,'Descrição' ,'' ,'Descrição' ,100 ,'false' ,'true' ,'false' ,0 ,'text' ,'Descrição' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3878 ,21598 ,2 ,0 );
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3878,21597,1,21597);
insert into db_syssequencia values(1000526, 'classificacaocredores_cc30_codigo_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000526 where codarq = 3878 and codcam = 21597;

-- classificacaocredoresempenho
insert into db_sysarquivo values (3879, 'classificacaocredoresempenho', 'Ligação entre o empenho e uma lista de classificação de credores.', 'cc31', '2015-10-19', 'Empenho da Classificação de Credores', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (38,3879);
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21599 ,'cc31_sequencial' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3879 ,21599 ,1 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21600 ,'cc31_empempenho' ,'int4' ,'Empenho' ,'' ,'Empenho' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Empenho' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3879 ,21600 ,2 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21601 ,'cc31_classificacaocredores' ,'int4' ,'Lista de Classificação de Credores' ,'' ,'Lista de Classificação de Credores' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Lista de Classificação de Credores' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3879 ,21601 ,3 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21602 ,'cc31_justificativa' ,'text' ,'Justificativa' ,'' ,'Justificativa' ,1 ,'true' ,'true' ,'false' ,0 ,'text' ,'Justificativa' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3879 ,21602 ,4 ,0 );
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3879,21599,1,21599);
insert into db_sysforkey values(3879,21600,1,889,0);
insert into db_sysforkey values(3879,21601,1,3878,0);
insert into db_syssequencia values(1000527, 'classificacaocredoresempenho_cc31_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000527 where codarq = 3879 and codcam = 21599;


insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10177 ,'Manutenção da Lista de Classificação de Credores' ,'Manutenção da Lista de Classificação de Credores' ,'emp4_manutencaoclassificacaocredor001.php' ,'1' ,'1' ,'Manutenção da Lista de Classificação de Credores' ,'true' );
delete from db_menu where id_item_filho = 10177 AND modulo = 398;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 32 ,10177 ,465 ,398 );



insert into db_syscampo values(21613,'e09_sequencial','int4','Código','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21614,'e09_codnota','int4','Código da Nota','0', 'Código da Nota',10,'f','f','f',1,'text','Código da Nota');
insert into db_syscampo values(21615,'e09_codmov','int4','Código do Movimento','0', 'Código do Movimento',10,'f','f','f',1,'text','Código do Movimento');
insert into db_syscampo values(21616,'e09_justificativa','text','Justificativa','', 'Justificativa',1,'f','t','f',0,'text','Justificativa');
insert into db_sysarquivo values (3883, 'empagemovjustificativa', 'Justificativa do pagamento feito fora de ordem.', 'e09', '2015-10-27', 'empagemovjustificativa', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (38,3883);
delete from db_sysarqcamp where codarq = 3883;
insert into db_sysarqcamp values(3883,21613,1,0);
insert into db_sysarqcamp values(3883,21614,2,0);
insert into db_sysarqcamp values(3883,21615,3,0);
insert into db_sysarqcamp values(3883,21616,4,0);
delete from db_sysforkey where codarq = 3883 and referen = 0;
insert into db_sysforkey values(3883,21614,1,971,0);
delete from db_sysforkey where codarq = 3883 and referen = 0;
insert into db_sysforkey values(3883,21615,1,995,0);
delete from db_sysprikey where codarq = 3883;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3883,21615,1,21613);
insert into db_sysindices values(4298,'empagemovjustificativa_codmov_in',3883,'0');
insert into db_syscadind values(4298,21615,1);
insert into db_sysindices values(4299,'empagemovjustificativa_codnota_in',3883,'0');
insert into db_syscadind values(4299,21614,1);
insert into db_syssequencia values(1000530, 'empagemovjustificativa_e09_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000530 where codarq = 3883 and codcam = 21613;


insert into db_itensmenu values( 10178, 'Lista de Classificação de Credores', 'Empenhos por lista de classificação de credores', 'emp2_empenhoslistaclassificacao001.php', '1', '1', '', '1'	);
insert into db_itensfilho (id_item, codfilho) values(10178,1);
insert into db_menu values(30,10178,450,39);

update db_itensmenu set libcliente = 'false' where id_item in (5695, 4831);
insert into conencerramentotipo values (8, 'Implantação de Saldos');

update db_syscampo set conteudo = 'varchar(100)', tamanho = 100 where codcam = 5435;
delete from db_syscampodep where codcam = 5435;
delete from db_syscampodef where codcam = 5435;

update db_itensmenu set funcao = 'con4_inscricaorpsnaoprocessados001.php?iTipo=1' where id_item = 9495;
update db_itensmenu set funcao = 'con4_inscricaorpsnaoprocessados001.php?lDesprocessar=true&iTipo=1' where id_item = 9496;

update db_sysarquivo set nomearq = 'inscricaorestosapagar', descricao = 'Inscrição de RP\'s', rotulo = 'Inscrição de RP\'s' where codarq = 3466;
delete from db_sysarqarq where codarq = 3466;
insert into db_sysarqarq values(0,3466);
insert into db_syscampo values(21627,'c107_tipo','int8','Tipo de RP','1', 'Tipo de RP',1,'f','f','f',1,'text','Tipo de RP');
delete from db_sysarqcamp where codarq = 3466;
insert into db_sysarqcamp values(3466,19500,1,2341);
insert into db_sysarqcamp values(3466,19503,2,0);
insert into db_sysarqcamp values(3466,19504,3,0);
insert into db_sysarqcamp values(3466,19501,4,0);
insert into db_sysarqcamp values(3466,19502,5,0);
insert into db_sysarqcamp values(3466,21627,6,0);

insert into db_itensmenu (id_item, descricao, help, funcao, itemativo, manutencao, desctec, libcliente) values (10179, 'Inscrição de RP''s Processados', 'Inscrição de RP''s Processados', '', '1','1', 'Menu para as operações de processar e desprocessar inscrições de RP''s processados' ,'true');
delete from db_menu where id_item_filho = 10179 AND modulo = 209;
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (9414, 10179, 4, 209);
insert into db_itensmenu (id_item, descricao, help, funcao, itemativo, manutencao, desctec, libcliente) values (10180, 'Processar', 'Processar inscrição de RP''s processados', 'con4_inscricaorpsnaoprocessados001.php?iTipo=2', '1', '1', 'Processar inscrição de RP''s processados', 'true');
delete from db_menu where id_item_filho = 10180 AND modulo = 209;
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (10179, 10180, 1, 209);
insert into db_itensmenu (id_item, descricao, help, funcao, itemativo, manutencao, desctec, libcliente) values (10181, 'Desprocessar', 'Desprocessar inscrição de RP''s processados', 'con4_inscricaorpsnaoprocessados001.php?lDesprocessar=true&iTipo=2', '1', '1', 'Desprocessar inscrição de RP''s processados', 'true');
delete from db_menu where id_item_filho = 10181 AND modulo = 209;
insert into db_menu (id_item, id_item_filho, menusequencia, modulo) values (10179, 10181, 2, 209);

update db_itensmenu set descricao = 'Inscrição de RP''s Não Processados', help = 'Inscrição de RP''s Não Processados' where id_item = 9492;
---------------------------------------------------------------------------------------------
-------------------------------- FIM FINANCEIRO---------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-------------------------------- INICIO CONFIGURACAO ----------------------------------------
---------------------------------------------------------------------------------------------

insert into db_syscampo values(21606,'dataexpira','date','Data de expiração do usuário','null', 'Data de Expiração',10,'t','f','f',1,'text','Data de Expiração');
insert into db_sysarqcamp values(109,21606,10,0);

---------------------------------------------------------------------------------------------
-------------------------------- FIM CONFIGURACAO -------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
----------------------------------- INICIO EDUCACAO/SAUDE -----------------------------------------
---------------------------------------------------------------------------------------------------

insert into db_sysarquivo values (3881, 'diarioavaliacaoalternativa', 'Diario Avaliação Alternativa', 'ed136', '2015-10-20', 'Diario Avaliação Alternativa', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (1008004,3881);
insert into db_syscampo
     values (21607,'ed136_sequencial','int4','Código sequencial','0', 'Código',10,'f','f','f',1,'text','Código'),
            (21608,'ed136_diario','int4','Diário do aluno','0', 'Diário',10,'f','f','f',1,'text','Diário'),
            (21609,'ed136_procavalalternativa','int4','Avaliação Alternativa a ser aplicado para o aluno','0', 'Avaliação Alternativa',10,'f','f','f',1,'text','Avaliação Alternativa');
insert into db_sysarqcamp
     values (3881,21607,1,0),
            (3881,21608,2,0),
            (3881,21609,3,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3881,21607,1,21607);
insert into db_sysforkey
     values (3881,21608,1,1010118,0),
            (3881,21609,1,3023,0);
insert into db_sysindices
     values (4295,'diarioavaliacaoalternativa_diario_in',3881,'0'),
            (4296,'diarioavaliacaoalternativa_procavalalternativa_in',3881,'0');
insert into db_syscadind
     values (4295,21608,1),
            (4296,21609,1);
insert into db_syssequencia values(1000528, 'diarioavaliacaoalternativa_ed136_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000528 where codarq = 3881 and codcam = 21607;


delete from db_sysarqcamp  where codarq = 2758 and codcam = 15747;
delete from db_syscampodef where codcam = 15747;
delete from db_syscampodep where codcam = 15747;
delete from db_syscampo    where codcam = 15747;

insert into db_syscampo values(21617,'la08_observacao','text','Observação do exame','', 'Observação',1,'t','t','f',0,'text','Observação');
insert into db_sysarqcamp values(2758,21617,15,0);


delete from db_sysarqcamp where codcam = 20989;
delete from db_syscampo   where codcam = 20989;

insert into db_syscampo values(21618,'ed320_tipo','int4','Tipo','1', 'Tipo',10,'f','f','f',1,'text','Tipo de Ausência');
insert into db_syscampodef values(21618,'1','Nenhum');
insert into db_syscampodef values(21618,'2','Licença');
insert into db_syscampodef values(21618,'3','Falta Abonada');
insert into db_syscampodef values(21618,'4','Falta Não Justificada');

insert into db_sysarqcamp values(3540,21618,3,0);

insert into db_sysarquivo values (3884, 'rechumanoausente', 'Tabela de Ausência Recursos Humanos', 'ed348', '2015-11-06', 'Tabela de Ausência Recursos Humanos', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (1008004,3884);
insert into db_syscampo values(21619,'ed348_sequencial','int4','Sequencial da tabela','0', 'Sequencial',10,'f','f','f',1,'text','Sequencial');
insert into db_syscampo values(21620,'ed348_rechumano','int4','Vínculo com cadastro de um recurso humano','0', 'Recursos Humanos',10,'f','f','f',1,'text','Recursos Humanos');
insert into db_syscampo values(21621,'ed348_tipoausencia','int4','Tipos de ausência','0', 'Tipo de Ausência',10,'f','f','f',1,'text','Tipo de Ausência');
insert into db_syscampo values(21622,'ed348_usuario','int4','Usuário do sistema','0', 'Usuário',10,'f','f','f',1,'text','Usuário');
insert into db_syscampo values(21623,'ed348_inicio','date','Data de Início da ausência','null', 'Data de Início',10,'f','f','f',1,'text','Data de Início');
insert into db_syscampo values(21624,'ed348_final','date','Data final da ausência','null', 'Data Final',10,'t','f','f',1,'text','Data Final');
insert into db_syscampo values(21625,'ed348_observacao','text','Observação','', 'Observação',1,'t','t','f',0,'text','Observação');
insert into db_syscampo values(21626,'ed348_escola','int4','Escola','0', 'Escola',10,'f','f','f',1,'text','Escola');

insert into db_sysarqcamp values(3884,21619,1,0);
insert into db_sysarqcamp values(3884,21620,2,0);
insert into db_sysarqcamp values(3884,21621,3,0);
insert into db_sysarqcamp values(3884,21622,4,0);
insert into db_sysarqcamp values(3884,21623,5,0);
insert into db_sysarqcamp values(3884,21624,6,0);
insert into db_sysarqcamp values(3884,21625,7,0);
insert into db_sysarqcamp values(3884,21626,8,0);

insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3884,21619,1,21619);
insert into db_sysforkey values(3884,21626,1,1010031,0);
insert into db_sysforkey values(3884,21620,1,1010087,0);
insert into db_sysforkey values(3884,21621,1,3540,0);
insert into db_sysforkey values(3884,21622,1,109,0);

insert into db_sysindices values(4300,'rechumanoausente_rechumano_in',3884,'0');
insert into db_syscadind values(4300,21620,1);
insert into db_sysindices values(4301,'rechumanoausente_tipoausencia_in',3884,'0');
insert into db_syscadind values(4301,21621,1);
insert into db_sysindices values(4302,'rechumanoausente_usuario_in',3884,'0');
insert into db_syscadind values(4302,21622,1);
insert into db_sysindices values(4303,'rechumanoausente_escola_in',3884,'0');
insert into db_syscadind values(4303,21626,1);
insert into db_syssequencia values(1000531, 'rechumanoausente_ed348_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000531 where codarq = 3884 and codcam = 21619;

insert into db_sysarquivo
     values (3885, 'medicamentoslaboratorio', 'Medicamentos do Laboratorio', 'la43', '2015-11-10', 'Medicamentos do Laboratorio', 0, 'f', 'f', 'f', 'f' ),
            (3886, 'medicamentoslaboratoriorequiitem', 'Medicamentos utilizados no exame', 'la44', '2015-11-10', 'Medicamentos utilizados no exame', 0, 'f', 'f', 'f', 'f' );

insert into db_sysarqmod
     values (67,3885),
            (67,3886);

insert into db_syscampo
     values (21628,'la43_sequencial','int4','Código','0', 'Código',10,'f','f','f',1,'text','Código'),
            (21629,'la43_nome','varchar(50)','Nome','', 'Nome',50,'f','t','f',0,'text','Nome'),
            (21630,'la43_abreviatura','varchar(3)','Abreviatura do medicamento','', 'Abreviatura',3,'f','t','f',0,'text','Abreviatura'),
            (21631,'la44_sequencial','int4','Código','0', 'Código',10,'f','f','f',1,'text','Código'),
            (21632,'la44_medicamentoslaboratorio','int4','Medicamento utilizado','0', 'Medicamento',10,'f','f','f',1,'text','Medicamento'),
            (21633,'la44_requiitem','int4','Exame da requisição','0', 'Exame',10,'f','f','f',1,'text','Exame');

insert into db_sysarqcamp
     values (3885,21628,1,0),
            (3885,21629,2,0),
            (3885,21630,3,0),
            (3886,21631,1,0),
            (3886,21632,2,0),
            (3886,21633,3,0);

insert into db_sysprikey (codarq, codcam, sequen, camiden)
     values (3885,21628,1,21629),
            (3886,21631,1,21631);

insert into db_sysforkey
     values (3886,21632,1,3885,0),
            (3886,21633,1,2771,0);

insert into db_sysindices
     values (4304,'medicamentoslaboratorio_abreviatura_in',3885,'1'),
            (4305,'medicamentoslaboratoriorequiitem_medicamentoslaboratorio_in',3886,'0'),
            (4306,'medicamentoslaboratoriorequiitem_requiitem_in',3886,'0');

insert into db_syscadind
     values (4305, 21632, 1),
            (4306, 21633, 1),
            (4304, 21630, 1);

insert into db_syssequencia
     values (1000532, 'medicamentoslaboratorio_la43_sequencial_seq', 1, 1, 9223372036854775807, 1, 1),
            (1000533, 'medicamentoslaboratoriorequiitem_la44_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000532 where codarq = 3885 and codcam = 21628;
update db_sysarqcamp set codsequencia = 1000533 where codarq = 3886 and codcam = 21631;

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10182 ,'Medicamentos' ,'Cadastro de Medicamentos' ,'lab1_medicamento001.php' ,'1' ,'1' ,'Cadastro de medicamentos para serem utilizados no exame' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8170 ,10182 ,16 ,8167 );

insert into db_syscampo values(21634,'ed06_abreviatura','varchar(3)','Abreviação da justificativa','', 'Abreviatura',3,'f','t','f',0,'text','Abreviatura');
insert into db_sysarqcamp values (1010032, 21634, 5, 0);

---------------------------------------------------------------------------------------------------
----------------------------------- FIM EDUCACAO/SAUDE --------------------------------------------
---------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------
----------------------------------- INICIO FOLHA --------------------------------------------------
---------------------------------------------------------------------------------------------------
insert into db_sysarquivo values (3882, 'tipoassecontrolediasmes', 'Controla quais tipos de assentamentos utilizam os dias dos meses.', 'rh170', '2015-10-23', 'Controle de dias dos assentamentos', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (28,3882);
insert into db_syscampo values(21611,'rh170_sequencial','int4','Sequencial','0', 'Sequencial',10,'f','f','f',1,'text','Sequencial');
insert into db_syscampo values(21612,'rh170_tipoasse','int4','Tipo do Assentamento','0', 'Tipo do Assentamento',10,'f','f','f',1,'text','Tipo do Assentamento');
delete from db_sysarqcamp where codarq = 3882;
insert into db_sysarqcamp values(3882,21611,1,0);
insert into db_sysarqcamp values(3882,21612,2,0);
delete from db_sysprikey where codarq = 3882;
delete from db_sysforkey where codarq = 3882 and referen = 0;
insert into db_sysforkey values(3882,21612,1,596,0);
insert into db_sysindices values(4297,'tipoassecontrolediasmes_tipoasse_in',3882,'0');
insert into db_syscadind values(4297,21612,1);
insert into db_syssequencia values(1000529, 'tipoassecontrolediasmes_rh170_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000529 where codarq = 3882 and codcam = 21611;
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10176 ,'Assentamentos com Controle de Dias no Mês' ,'Assentamentos com Controle de Dias no Mês' ,'pes4_controlediasassentamento.php' ,'1' ,'1' ,'Configura os assentamentos que possuem os cálculos com base nos dias do mês.' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10093 ,10176 ,3 ,952 );
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3882,21611,1,21612);
insert into db_sistemaexterno values (7, 'REFEISUL');

insert into db_sysarquivo values (3887, 'codigoclienterefeisul', 'Configuração do código do cliente do refeisul', 'rh171', '2015-11-16', 'Configuração do refeisul', 1, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (28,3887);
insert into db_syscampo values(21635,'rh171_sequencial','int4','Codigo Sequencial','Sequencial', 'Sequencial',10,'f','f','f',1,'text','Sequencial');
insert into db_syscampo values(21636,'rh171_instit','int4','Instituiçao','0', 'Instituiçao',10,'f','f','f',1,'text','Instituição');
insert into db_syscampo values(21637,'rh171_codigocliente','int4','Código Empresa','0', 'Código Empresa',10,'f','f','f',1,'text','Código Empresa');
delete from db_sysarqcamp where codarq = 3887;
insert into db_sysarqcamp values(3887,21635,1,0);
insert into db_sysarqcamp values(3887,21636,2,0);
insert into db_sysarqcamp values(3887,21637,3,0);
delete from db_sysprikey where codarq = 3887;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3887,21635,1,21637);
delete from db_sysforkey where codarq = 3887 and referen = 0;
insert into db_sysforkey values(3887,21636,1,83,0);
insert into db_sysindices values(4307,'codigoclienterefeisul_instit',3887,'1');
insert into db_syscadind values(4307,21636,1);
insert into db_syssequencia values(1000534, 'codigoclienterefeisul_rh171_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000534 where codarq = 3887 and codcam = 21635;

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10183 ,'Refeisul' ,'Refeisul' ,'pes4_codigoclienterefeisul001.php' ,'1' ,'1' ,'Configuração do código do cliente Refeisul' ,'true' );
delete from db_menu where id_item_filho = 10183 AND modulo = 952;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 3516 ,10183 ,12 ,952 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10184 ,'Geração Arquivo Refeisul' ,'Geração Arquivo Refeisul' ,'pes4_geracaparquivorefeisul001.php' ,'1' ,'1' ,'Geração Arquivo Refeisul' ,'true' );
delete from db_menu where id_item_filho = 10184 AND modulo = 952;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 5000 ,10184 ,7 ,952 );

---------------------------------------------------------------------------------------------------
----------------------------------- FIMFOLHA ------------------------------------------------------
---------------------------------------------------------------------------------------------------