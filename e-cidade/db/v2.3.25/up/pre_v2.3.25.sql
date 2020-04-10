/**
 * Arquivo pre da nova versao
 */

/*
 *
 * TIME Tributário
 *
 */

 insert into db_syscampo values (20555,'selectTipoCompromisso','varchar(2)','Tipo de Compromisso','','Tipo de Compromisso','2','false','true','false','0','text','Tipo de Compromisso'),
                                (20556,'rh34_parametrotransmissaoheader','varchar(2)','Parâmetro Transmissão Header do Arquivo','','Parâmetro Transmissão Header do Arquivo','2','true','true','false','0','text','Parâmetro Transmissão Header do Arquivo'),
                                (20557,'rh34_parametrotransmissaolote','varchar(2)','Parâmetro Transmissão Header do Lote','','Parâmetro Transmissão Header do Lote','2','true','true','false','0','text','Parâmetro Transmissão Header do Lote'),
                                (20558,'rh34_codigocompromisso','varchar(4)','Código do Compromisso(header do lote)','','Código do Compromisso ','4','true','true','false','0','text','Código do Compromisso ');

 insert into db_syscampodef values (20555,01,'Pagamento a Fornecedor'),
                                   (20555,02,'Pagamento de Salários'),
                                   (20555,03,'Autopagamento'),
                                   (20555,06,'Salário Ampliação de Base'),
                                   (20555,11,'Débito em conta');

 insert into db_sysarqcamp values (1212, 20556, 13, 0),
                                  (1212, 20557, 14, 0),
                                  (1212, 20558, 15, 0);

 update db_modulos set nome_modulo = 'Dívida Ativa',       descr_modulo = 'Dívida Ativa'       where id_item = 81;
 update db_modulos set nome_modulo = 'Orçamento',          descr_modulo = 'Orçamento'          where id_item = 116;
 update db_modulos set nome_modulo = 'Licitações',         descr_modulo = 'Licitações'         where id_item = 381;
 update db_modulos set nome_modulo = 'Site',               descr_modulo = 'Site'               where id_item = 420;
 update db_modulos set nome_modulo = 'Ipasem',             descr_modulo = 'Ipasem'             where id_item = 576;
 update db_modulos set nome_modulo = 'Veículos',           descr_modulo = 'Veículos'           where id_item = 633;
 update db_modulos set nome_modulo = 'Água',               descr_modulo = 'Água'               where id_item = 4555;
 update db_modulos set nome_modulo = 'Biblioteca',         descr_modulo = 'Biblioteca'         where id_item = 1100625;
 update db_modulos set nome_modulo = 'Prefeitura On-line', descr_modulo = 'Prefeitura On-line' where id_item = 394;
 update db_modulos set nome_modulo = 'SAMU',               descr_modulo = 'SAMU'               where id_item = 9101;
 update db_modulos set nome_modulo = 'Escola',             descr_modulo = 'Escola'             where id_item = 1100747;
 update db_modulos set nome_modulo = 'Matrícula On-line',  descr_modulo = 'Matrícula On-line'  where id_item = 2000112;
 update db_modulos set nome_modulo = 'Patrimônio',         descr_modulo = 'Patrimônio'         where id_item = 439;

--Tarefa 93126 - Certidão Baixa
update db_itensmenu set id_item = 6996 , descricao = 'Geral' , help = 'Configuração dos Parâmetros Gerais do ISSQN' , funcao = 'iss1_parissqn002.php' , itemativo = '1' , manutencao = '1' , desctec = 'Configuração dos Parâmetros Gerais do ISSQN' , libcliente = 'true' where id_item = 6996;
delete from db_menu where id_item = 32 and id_item_filho = 2334 and modulo = 40;

insert into db_syscampo values(20592,'q60_templatebaixaalvaranormal','int4','Certidão de Baixa de Alvará Normal','0', 'Certidão de Baixa de Alvará Normal',5,'t','f','f',1,'text','Certidão de Baixa de Alvará Normal');
insert into db_syscampo values(20593,'q60_templatebaixaalvaraoficial','int4','Certidão de Baixa de Alvará Oficial','0', 'Certidão de Baixa de Alvará Oficial',5,'t','f','f',1,'text','Certidão de Baixa de Alvará Oficial');

insert into db_sysarqcamp values(664,20592,28,0);
insert into db_sysarqcamp values(664,20593,29,0);

insert into db_documentotemplatetipo values(46, 'BAIXA DE INSCRIÇÃO');
insert into db_documentotemplatepadrao values(42,46,'CERTIDÃO DE BAIXA DE INSCRIÇÃO','documentos/templates/issqn/issqn_certidao_baixa_inscricao.sxw');

/*
 *  Inicio Tarefa 93560
 */
-- Tolerância de Crédito
insert into db_syscampo values(20614,'k03_toleranciacredito','float8','Valor mínimo para gerar crédito .','0', 'Tolerância para Crédito',10,'f','f','f',4,'text','Tolerância para Crédito');
insert into db_sysarqcamp values(318,20614,38,0);

-- Geração pagamento taxa bancária

insert into db_sysarquivo values (3716, 'tabdesccadban', 'Tabela de ligação com as tabelas cadban e tabdesc', 'k114', '2014-05-21', 'Desconto Conta Bancária', 0, 'f', 't', 't', 't' );
insert into db_sysarqmod values (54,3716);
insert into db_syscampo values(20630,'k114_sequencial','int8','Código sequencial da tabela tabdesccadban','0', 'Código sequencial',10,'f','f','f',1,'text','Código sequencial');
insert into db_syscampo values(20631,'k114_tabdesc','int8','Vinculação com a tabela tabdesc','0', 'Código de Desconto',10,'f','f','f',1,'text','Código de Desconto');
insert into db_syscampo values(20632,'k114_codban','int8','Código da conta que será vinculada','0', 'Código da conta que será vinculada',10,'f','f','f',1,'text','Código da conta que será vinculada');
insert into db_sysarqcamp values(3716,20630,1,0);
insert into db_sysarqcamp values(3716,20631,2,0);
insert into db_sysarqcamp values(3716,20632,3,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3716,20630,1,20630);
insert into db_sysforkey values(3716,20632,1,116,0);
insert into db_sysforkey values(3716,20631,1,79,0);
insert into db_sysindices values(4083,'tabdesccadban_tabdesc_in',3716,'0');
insert into db_syscadind values(4083,20631,1);
insert into db_sysindices values(4084,'tabdesccadban_codban_in',3716,'0');
insert into db_syscadind values(4084,20632,1);
insert into db_syssequencia values(1000376, 'tabdesccadban_k114_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000376 where codarq = 3716 and codcam = 20630;
/*
 *  Fim Tarefa 93560
 */

 /*
  *
  * FIM TIME Tributário
  *
  */


  /*
  *
  * TIME B
  *
  */


  update db_itensmenu set libcliente = false where id_item in (9533, 5262);


  -- Menus Mensageria
  insert into db_itensmenu values( 9945, 'Mensageria', 'Mensageria', '', '1', '1', 'Rotina de mensageria', '1'  );
  insert into db_itensmenu values( 9946, 'Acordo (mensageria)', 'Parametros do modulo acordo', '', '1', '1', 'Parametros do modulo acordo para mensageria', '1' );
  insert into db_itensmenu values( 9947, 'Acordos a Vencer', 'Acordos a Vencer', 'con4_acordovencer001.php', '1', '1', '', '1'  );
  insert into db_itensfilho (id_item, codfilho) values(9947,1);
  insert into db_menu values(32,9945,449,1);
  insert into db_menu values(9945,9946,1,1);
  insert into db_menu values(9946,9947,1,1);
  update db_itensmenu set descricao = 'Acordo', help = 'Parametros do modulo acordo', funcao = '', itemativo = '1', desctec = 'Parametros do modulo acordo para mensageria', libcliente = '0' where id_item = 9946;
  delete from db_itensfilho where id_item = 9946;
  update db_itensmenu set descricao = 'Acordos a Vencer', help = 'Acordos a Vencer', funcao = 'con4_acordovencer001.php', itemativo = '1', desctec = '', libcliente = '0' where id_item = 9947;
  delete from db_itensfilho where id_item = 9947;
  insert into db_itensfilho values(9947,1);

  -- mensageriaacordo
  insert into db_sysarquivo values (3701, 'mensageriaacordo', 'Parâmetros de mensageria para os acordos.', 'ac51', '2014-05-13', 'Mensageria acordo', 0, 'f', 'f', 'f', 'f' );
  insert into db_sysarqmod values (69,3701);
  insert into db_syscampo values(20573,'ac51_sequencial','int4','PK da tabela mensageriaacordo','0', 'Sequencial',10,'f','f','f',1,'text','Sequencial');
  insert into db_syscampo values(20574,'ac51_assunto','varchar(100)','Assunto padrão das mensagens dos acordos a vencer.','', 'Assunto',100,'f','f','f',0,'text','Assunto');
  insert into db_syscampo values(20575,'ac51_mensagem','text','Mensagem padrão dos acordos a vencer.','', 'Mensagem',1,'f','f','f',0,'text','Mensagem');
  delete from db_sysarqcamp where codarq = 3701;
  insert into db_sysarqcamp values(3701,20573,1,0);
  insert into db_sysarqcamp values(3701,20574,2,0);
  insert into db_sysarqcamp values(3701,20575,3,0);
  delete from db_sysprikey where codarq = 3701;
  insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3701,20573,1,20573);
  insert into db_syssequencia values(1000363, 'mensageriaacordo_ac51_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
  update db_sysarqcamp set codsequencia = 1000363 where codarq = 3701 and codcam = 20573;

  --mensageriaacordodb_usuario
  insert into db_sysarquivo values (3702, 'mensageriaacordodb_usuario', 'mensageriaacordodb_usuario', 'ac52', '2014-05-13', 'mensageriaacordodb_usuario', 0, 'f', 'f', 'f', 'f' );
	insert into db_sysarqmod values (69,3702);
	insert into db_syscampo values(20577,'ac52_sequencial','int4','Sequencial','0', 'Sequencial',10,'f','f','f',1,'text','Sequencial');
	insert into db_syscampo values(20579,'ac52_db_usuarios','int4','db_usuarios','0', 'db_usuarios',10,'f','f','f',1,'text','db_usuarios');
	insert into db_syscampo values(20580,'ac52_dias','int4','Dias para Aviso','0', 'Dias',10,'f','f','f',1,'text','Dias');
	delete from db_sysarqcamp where codarq = 3702;
	insert into db_sysarqcamp values(3702,20577,1,0);
	insert into db_sysarqcamp values(3702,20579,2,0);
	insert into db_sysarqcamp values(3702,20580,3,0);
	delete from db_sysprikey where codarq = 3702;
	insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3702,20577,1,20577);
	delete from db_sysforkey where codarq = 3702 and referen = 0;
	insert into db_sysforkey values(3702,20579,1,109,0);
	insert into db_sysindices values(4062,'mensageriaacordodb_usuario_db_usuarios_in',3702,'0');
	insert into db_syscadind values(4062,20579,1);
	insert into db_syssequencia values(1000364, 'mensageriaacordodb_usuario_ac52_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
	update db_sysarqcamp set codsequencia = 1000364 where codarq = 3702 and codcam = 20577;

  -- mensageriaacordoprocessados
  insert into db_sysarquivo values (3705, 'mensageriaacordoprocessados', 'Usuários notificados dos acordos a vencer.', 'ac53', '2014-05-13', 'Usuários notificados', 0, 'f', 'f', 'f', 'f' );
  insert into db_sysarqmod values (69,3705);
  insert into db_syscampo values(20589,'ac53_sequencial','int4','PK da tabela mensageriaacordoprocessados','0', 'Sequencial',10,'f','f','f',1,'text','Sequencial');
  insert into db_syscampo values(20590,'ac53_mensageriaacordodb_usuarios','int4','Usuário para notificar do acordo a vencer.','0', 'Usuário',10,'f','f','f',1,'text','Usuário');
  insert into db_syscampo values(20591,'ac53_acordo','int4','Código do acordo para notificar usuários do seu vencimento.','0', 'Acordo',10,'f','f','f',1,'text','Acordo');
  delete from db_sysarqcamp where codarq = 3705;
  insert into db_sysarqcamp values(3705,20589,1,0);
  insert into db_sysarqcamp values(3705,20590,2,0);
  insert into db_sysarqcamp values(3705,20591,3,0);
  delete from db_sysprikey where codarq = 3705;
  insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3705,20589,1,20589);
  delete from db_sysforkey where codarq = 3705 and referen = 0;
  insert into db_sysforkey values(3705,20591,1,2828,0);
  delete from db_sysforkey where codarq = 3705 and referen = 0;
  insert into db_sysforkey values(3705,20590,1,3702,0);
  insert into db_sysindices values(4066,'mensageriaacordoprocessados_ac53_mensageriaacordodb_usuarios_in',3705,'0');
  insert into db_syscadind values(4066,20590,1);
  insert into db_sysindices values(4067,'mensageriaacordoprocessados_ac53_acordo_in',3705,'0');
  insert into db_syscadind values(4067,20591,1);
  insert into db_syssequencia values(1000367, 'mensageriaacordoprocessados_ac53_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
  update db_sysarqcamp set codsequencia = 1000367 where codarq = 3705 and codcam = 20589;

  
  -- vinculos de processos
insert into db_sysarquivo values (3712, 'placaixaprocesso', 'vinclulo da placaixa com processo administrativo', 'k144', '2014-05-20', 'placaixaprocesso', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (5,3712);
insert into db_sysarquivo values (3713, 'pagordemprocesso', 'vinculo pagordem com processo administrativo', 'e03', '2014-05-20', 'pagordemprocesso', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (38,3713);
insert into db_sysarquivo values (3714, 'slipprocesso', 'vinculo slip com processo administrativo', 'k145', '2014-05-20', 'slipprocesso', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (5,3714);
insert into db_syscampo values(20618,'k144_sequencial','int4','sequencial','0', 'sequencial',10,'f','f','f',1,'text','sequencial');
insert into db_syscampo values(20619,'k144_placaixa','int4','placaixa','0', 'placaixa',10,'f','f','f',1,'text','placaixa');
insert into db_syscampo values(20620,'k144_numeroprocesso','varchar(15)','numero processo','', 'numero processo',15,'t','t','f',0,'text','numero processo');
insert into db_syscampo values(20621,'e03_sequencial','int4','sequencial','0', 'sequencial',10,'f','f','f',1,'text','sequencial');
insert into db_syscampo values(20622,'e03_pagordem','int4','pagordem','0', 'pagordem',10,'f','f','f',1,'text','pagordem');
insert into db_syscampo values(20623,'e03_numeroprocesso','varchar(15)','numero processo','', 'numero processo',15,'t','t','f',0,'text','numero processo');
insert into db_syscampo values(20624,'k145_sequencial','int4','sequencial','0', 'sequencial',10,'f','f','f',1,'text','sequencial');
insert into db_syscampo values(20625,'k145_slip','int4','slip','0', 'slip',10,'f','f','f',1,'text','slip');
insert into db_syscampo values(20626,'k145_numeroprocesso','varchar(15)','numero processo','', 'numero processo',15,'t','t','f',0,'text','numero processo');
delete from db_sysarqcamp where codarq = 3712;
insert into db_sysarqcamp values(3712,20618,1,0);
insert into db_sysarqcamp values(3712,20619,2,0);
insert into db_sysarqcamp values(3712,20620,3,0);
delete from db_sysprikey where codarq = 3712;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3712,20618,1,20618);
delete from db_sysforkey where codarq = 3712 and referen = 0;
insert into db_sysforkey values(3712,20619,1,1023,0);
insert into db_sysindices values(4079,'placaixaprocesso_placaixa_in',3712,'0');
insert into db_syscadind values(4079,20619,1);
insert into db_syssequencia values(1000372, 'placaixaprocesso_k144_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000372 where codarq = 3712 and codcam = 20618;
delete from db_sysarqcamp where codarq = 3713;
insert into db_sysarqcamp values(3713,20621,1,0);
insert into db_sysarqcamp values(3713,20622,2,0);
insert into db_sysarqcamp values(3713,20623,3,0);
delete from db_sysprikey where codarq = 3713;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3713,20621,1,20621);
delete from db_sysforkey where codarq = 3713 and referen = 0;
insert into db_sysforkey values(3713,20622,1,808,0);
insert into db_sysindices values(4080,'pagordemprocesso_pagordem_in',3713,'0');
insert into db_syscadind values(4080,20622,1);
insert into db_syssequencia values(1000373, 'pagordemprocesso_e03_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000373 where codarq = 3713 and codcam = 20621;
delete from db_sysarqcamp where codarq = 3714;
insert into db_sysarqcamp values(3714,20624,1,0);
insert into db_sysarqcamp values(3714,20625,2,0);
insert into db_sysarqcamp values(3714,20626,3,0);
delete from db_sysprikey where codarq = 3714;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3714,20624,1,20624);
delete from db_sysforkey where codarq = 3714 and referen = 0;
insert into db_sysforkey values(3714,20625,1,196,0);
insert into db_sysindices values(4081,'slipprocesso_slip_in',3714,'0');
insert into db_syscadind values(4081,20625,1);
insert into db_syssequencia values(1000374, 'slipprocesso_k145_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000374 where codarq = 3714 and codcam = 20624;  
  
  

  
  
  
insert into db_sysarquivo values (3717, 'empnotaprocesso', 'vinculo empnota com um processo administrativo', 'e04', '2014-05-23', 'empnota proceso', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (38,3717);
insert into db_syscampo values(20636,'e04_sequencial','int4','Sequencial','0', 'Sequencial',10,'f','f','f',1,'text','Sequencial');
insert into db_syscampo values(20637,'e04_empnota','int4','fk empnota','0', 'empnota ',10,'f','f','f',1,'text','empnota');
insert into db_syscampo values(20638,'e04_numeroprocesso','varchar(15)','Numero do Processo','', 'Numero do Processo',15,'t','t','f',0,'text','Numero do Processo');
delete from db_sysarqcamp where codarq = 3717;
insert into db_sysarqcamp values(3717,20636,1,0);
insert into db_sysarqcamp values(3717,20637,2,0);
insert into db_sysarqcamp values(3717,20638,3,0);
delete from db_sysprikey where codarq = 3717;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3717,20636,1,20636);
delete from db_sysforkey where codarq = 3717 and referen = 0;
insert into db_sysforkey values(3717,20637,1,971,0);
insert into db_sysindices values(4085,'empnotaprocesso_empnota_in',3717,'0');
insert into db_syscadind values(4085,20637,1);
insert into db_syssequencia values(1000377, 'empnotaprocesso_e04_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000377 where codarq = 3717 and codcam = 20636;

  
  
  
  

  /**
   * Liberar Menus
   */
  update db_itensmenu set libcliente = true where id_item in (9829, 9830, 9831, 9912, 9869, 9896, 9870, 9852);


  /*
  *
  * FIM TIME B
  *
  */



 /*
  *
  * TIME C
  *
  */

 update db_syscampo set nomecam      = 'ed254_i_atolegal',
                          conteudo     = 'int8',
                          descricao    = 'Ato Legal',
                          valorinicial = '0',
                          rotulo       = 'Ato Legal',
                          nulo         = 't',
                          tamanho      = 20,
                          maiusculo    = 'f',
                          autocompl    = 'f',
                          aceitatipo   = 1,
                          tipoobj      = 'text',
                          rotulorel    = 'Ato Legal'
     where codcam = 12551;

 insert into db_syscampo    values(20559,'ed217_brasao','int4','Tipo de brasão a ser apresentado','1', 'Brasão',10,'f','f','f',1,'text','Brasão');
 insert into db_syscampodef values(20559,'1','República');
 insert into db_syscampodef values(20559,'2','Município');
 insert into db_sysarqcamp  values(2571,20559,14,0);


/**
 * T91754
 */
-- Tabela rechumanomovimentacao
insert into db_sysarquivo values (3699, 'rechumanomovimentacao', 'Movientação de um funcionário da escola;', 'ed118', '2014-04-28', 'rechumanomovimentacao', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod  values (1008004, 3699);
insert into db_syscampo values(20560,'ed118_sequencial','int4','Código sequencial','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(20561,'ed118_escola','int4','Escola','0', 'Escola',10,'f','f','f',1,'text','Escola');
insert into db_syscampo values(20562,'ed118_rechumano','int4','Código do Recurso Humano','0', 'Rec. Humano',10,'f','f','f',1,'text','Rec. Humano');
insert into db_syscampo values(20563,'ed118_usuario','int4','Usuário que realizou a movimentação ','0', 'Usuário',10,'f','f','f',1,'text','Usuário');
insert into db_syscampo values(20564,'ed118_data','date','Data da movimentação','null', 'Data',10,'f','f','f',1,'text','Data');
insert into db_syscampo values(20565,'ed118_hora','varchar(5)','Hora da movimentação','', 'Hora',5,'f','f','f',0,'text','Hora');
insert into db_syscampo values(20566,'ed118_resumo','text','Resumo da movimentação','', 'Resumo',1,'f','f','f',0,'text','Resumo');
insert into db_sysarqcamp values(3699,20560,1,0);
insert into db_sysarqcamp values(3699,20561,2,0);
insert into db_sysarqcamp values(3699,20562,3,0);
insert into db_sysarqcamp values(3699,20563,4,0);
insert into db_sysarqcamp values(3699,20564,5,0);
insert into db_sysarqcamp values(3699,20565,6,0);
insert into db_sysarqcamp values(3699,20566,7,0);
insert into db_sysprikey(codarq,codcam,sequen,camiden) values(3699,20560,1,20560);
insert into db_sysforkey values(3699,20561,1,1010031,0);
insert into db_sysforkey values(3699,20562,1,1010087,0);
insert into db_sysforkey values(3699,20563,1,109,0);
insert into db_sysindices values(4059,'rechumanomovimentacao_escola_in',3699,'0');
insert into db_sysindices values(4060,'rechumanomovimentacao_rechumano_in',3699,'0');
insert into db_sysindices values(4061,'rechumanomovimentacao_usuario_in',3699,'0');
insert into db_syscadind values(4059,20561,1);
insert into db_syscadind values(4060,20562,1);
insert into db_syscadind values(4061,20563,1);
insert into db_syssequencia values(1000360, 'rechumanomovimentacao_ed118_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000360 where codarq = 3699 and codcam = 20560;

-- Tabela rechumanohoradisp
insert into db_syscampo   values(20567,'ed33_ativo','bool','Se o horário esta ativo','t', 'Ativo',1,'f','f','f',5,'text','Ativo');
insert into db_syscampo   values(20568,'ed33_rechumanoescola','int4','Vinculo escola','0', 'Vinculo escola',10,'f','f','f',1,'text','Vinculo escola');
delete from db_sysarqcamp where codarq = 1010091;
insert into db_sysarqcamp values(1010091,1008528,1,1000152);
insert into db_sysarqcamp values(1010091,20568,2,0);
insert into db_sysarqcamp values(1010091,1008530,3,0);
insert into db_sysarqcamp values(1010091,1008531,4,0);
insert into db_sysarqcamp values(1010091,20567,5,0);
delete from db_sysforkey  where codarq = 1010091 and referen = 1010087;
insert into db_sysforkey  values(1010091,20568,1,1010094,0);


insert into db_menu values(3470, 9054,28, 6877);
insert into db_menu values(9054, 2467, 4, 6877);
insert into db_menu values(9054, 8012, 5,6877);
insert into db_menu values(9054,8013,6,6877);


/**
 * T 91754
 */
update db_itensmenu set libcliente = true where id_item = 9941;

update db_menu set menusequencia = 1 where id_item = 9242 and modulo = 1100747 and id_item_filho = 1100958;
update db_menu set menusequencia = 2 where id_item = 9242 and modulo = 1100747 and id_item_filho = 9941;
update db_menu set menusequencia = 3 where id_item = 9242 and modulo = 1100747 and id_item_filho = 8781;
update db_menu set menusequencia = 4 where id_item = 9242 and modulo = 1100747 and id_item_filho = 9241;
update db_menu set menusequencia = 5 where id_item = 9242 and modulo = 1100747 and id_item_filho = 9254;
update db_menu set menusequencia = 6 where id_item = 9242 and modulo = 1100747 and id_item_filho = 9534;
update db_menu set menusequencia = 7 where id_item = 9242 and modulo = 1100747 and id_item_filho = 9099;
update db_menu set menusequencia = 8 where id_item = 9242 and modulo = 1100747 and id_item_filho = 9633;
update db_menu set menusequencia = 9 where id_item = 9242 and modulo = 1100747 and id_item_filho = 9938;

/**
 * T93234
 */
-- lab_requiitem
insert into db_syscampo values(20635,'la21_observacao','text','Observação do exame.','', 'Observação',1,'t','f','f',0,'text','Observação');
delete from db_sysarqcamp where codarq = 2771;
insert into db_sysarqcamp values(2771,15787,1,1678);
insert into db_sysarqcamp values(2771,15788,2,0);
insert into db_sysarqcamp values(2771,15789,3,0);
insert into db_sysarqcamp values(2771,15790,4,0);
insert into db_sysarqcamp values(2771,15791,5,0);
insert into db_sysarqcamp values(2771,16040,6,0);
insert into db_sysarqcamp values(2771,15838,7,0);
insert into db_sysarqcamp values(2771,16574,8,0);
insert into db_sysarqcamp values(2771,17991,9,0);
insert into db_sysarqcamp values(2771,20635,10,0);


 /*
  *
  * FIM TIME C
  *
  */

delete from db_menu where id_item = 7941 and id_item_filho = 8670;
delete from db_menu where id_item_filho = 5630;


 /*
  *
  * INICIO TIME D
  * T 93849
  */

insert into db_syscampo values(20585,'q03_tributacao_municipio','bool','Campo responsável pelo geração de guia segundo tributação fora do município.','false', 'Retenção p/ Prestação Fora do Município',1,'f','f','f',5,'text','Retenção p/ Prestação Fora do Município');
delete from db_sysarqcamp where codarq = 48;
insert into db_sysarqcamp values(48,243,1,0);
insert into db_sysarqcamp values(48,244,2,0);
insert into db_sysarqcamp values(48,245,3,0);
insert into db_sysarqcamp values(48,6853,4,0);
insert into db_sysarqcamp values(48,12649,5,0);
insert into db_sysarqcamp values(48,12650,6,0);
insert into db_sysarqcamp values(48,20501,7,0);
insert into db_sysarqcamp values(48,20585,8,0);

 /*
  * 
  * FIM TIME D
  */


