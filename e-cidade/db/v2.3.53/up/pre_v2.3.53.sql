---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
insert into db_syscampo values(21910,'bi26_impressora','int4','Define qual o tamanho do papel deve ser impresso os comprovantes de empréstimos e devoluções.','1', 'Impressão de Comprovantes',10,'t','f','f',1,'text','Impressão de Comprovantes');
insert into db_sysarqcamp values(2138,21910,4,0);

update db_menu set menusequencia = 1 where id_item = 1100625 and modulo = 1100625 and id_item_filho = 3470;
update db_menu set menusequencia = 2 where id_item = 1100625 and modulo = 1100625 and id_item_filho = 1797;
update db_menu set menusequencia = 3 where id_item = 1100625 and modulo = 1100625 and id_item_filho = 31;
update db_menu set menusequencia = 4 where id_item = 1100625 and modulo = 1100625 and id_item_filho = 1818;

update db_layoutcampos set db52_layoutformat = 15
 where db52_codigo in (13333, 13260, 13504, 13503, 13502, 13501, 13625, 13623, 13621, 13620, 13355, 13354, 13351, 13348 );


insert into db_sysarquivo values (3948, 'idioma', 'lista de idiomas', 'bi22', '2016-07-04', 'Idioma', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (1008002,3948);
insert into db_syscampo values(21925,'bi22_sequencial','int4','Código sequencial','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21926,'bi22_idioma','varchar(50)','Idioma','', 'Idioma',50,'f','t','f',0,'text','Idioma');
insert into db_sysarqcamp values(3948, 21925, 1, 0);
insert into db_sysarqcamp values(3948, 21926, 2, 0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3948,21925,1,21925);
insert into db_syssequencia values(1000583, 'idioma_bi22_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000583 where codarq = 3948 and codcam = 21925;
insert into db_sysindices values(4362,'idioma_idioma_in',3948,'1');
insert into db_syscadind values(4362,21926,1);

insert into db_syscampo values(21927,'bi06_idioma','int4','Idioma do acervo','0', 'Idioma',10,'f','f','f',1,'text','Idioma');
insert into db_sysarqcamp values(1008014,21927,15,0);
insert into db_sysforkey values(1008014,21927,1,3948,0);

insert into db_syscampo values(21939,'ed73_valorreal','float8','Valor real da avaliação do aluno sem que seja alterada pela proporcionalidade.','0', 'Valor Real',15,'t','f','f',4,'text','Valor Real');
insert into db_syscampo values(21940,'ed233_apresentarnotaproporcional','bool','Parâmetro para verificar se deve mostrar a nota proporcional do aluno ou a nota real.','true', 'Apresentar Nota Proporcional',1,'f','f','f',5,'text','Apresentar Nota Proporcional');
insert into db_sysarqcamp values(1010120,21939,9,0);
insert into db_sysarqcamp values(2019,21940,16,0);


---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO FINANCEIRO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------


insert into db_sysarquivo values (3945, 'pagfornumeracao', 'Controle da numeração do PAGFOR (Bradesco)', 'o152', '2016-06-23', 'pagfornumeracao', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (5,3945);
insert into db_syscampo values(21911,'o152_sequencial','int4','Código Sequencial','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21912,'o152_instit','int4','Código sequencial da instituição','0', 'Código da Instituição',10,'f','f','f',1,'text','Código da Instituição');
insert into db_syscampo values(21913,'o152_numero','int4','Numeração Atual','0', 'Numeração Atual',10,'f','f','f',1,'text','Numeração Atual');
insert into db_syscampo values(21922,'o152_empagegera','int4','Código da Remessa','0', 'Código da Remessa',10,'f','f','f',1,'text','Código da Remessa');

delete from db_sysarqcamp where codarq = 3945;
insert into db_sysarqcamp values(3945,21911,1,0);
insert into db_sysarqcamp values(3945,21912,2,0);
insert into db_sysarqcamp values(3945,21913,3,0);
insert into db_sysarqcamp values(3945,21922,4,0);
insert into db_syssequencia values(1000580, 'pagfornumeracao_o152_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);

update db_sysarqcamp set codsequencia = 1000580 where codarq = 3945 and codcam = 21911;
delete from db_sysforkey where codarq = 3945 and referen = 0;
insert into db_sysforkey values(3945,21912,1,83,0);
insert into db_sysforkey values(3945,21922,1,1002,0);
delete from db_sysprikey where codarq = 3945;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3945,21911,1,21913);
insert into db_sysindices values(4359,'pagfornumeracao_sequencial_in',3945,'0');
insert into db_syscadind values(4359,21911,1);

insert into db_itensmenu values( 10249, 'Regerar Arquivo - PagFor', 'Regerar Arquivo de Remessa - PagFor', 'cai4_reemissaoarquivoobn001.php?tipo_transmissao=3', '1', '1', 'Regera arquivo de transmissão do PAGFOR', '1'	);
insert into db_itensfilho (id_item, codfilho) values(10249,1);
insert into db_menu values(4343,10249,17,39);

update db_itensmenu set descricao = 'Regerar Arquivo OBN', help = 'Regerar arquivo OBN', funcao = 'cai4_reemissaoarquivoobn001.php?tipo_transmissao=2', itemativo = '1', desctec = 'Rotina para reemissão de arquivo OBN' where id_item = 9786;

insert into empagetipotransmissao values (3, 'BRADESCO - PAGFOR');

insert into errobanco values (115, 'AA', 'Arquivo duplicado', false, 3);
insert into errobanco values (116, 'AB', 'Data limite para desconto, sem valor correspondente', false, 3);
insert into errobanco values (117, 'AC', 'Tipo de serviço inválido', false, 3);
insert into errobanco values (118, 'AD', 'Modalidade de pagamento inválida', false, 3);
insert into errobanco values (119, 'AE', 'Tipo de inscrição e identificação do cliente pagador incompatíveis', false, 3);
insert into errobanco values (120, 'AF', 'Valores não numéricos ou zerados', false, 3);
insert into errobanco values (121, 'AG', 'Tipo de inscrição e identificação do favorecido incompatível', false, 3);
insert into errobanco values (122, 'AJ', 'Tipo de movimento inválido', false, 3);
insert into errobanco values (123, 'AL', 'Banco, agência ou conta inválido', false, 3);
insert into errobanco values (124, 'AM', 'Agência do favorecido inválida', false, 3);
insert into errobanco values (125, 'AN', 'Conta corrente do favorecido inválida', false, 3);
insert into errobanco values (126, 'AO', 'Nome do favorecido não informado', false, 3);
insert into errobanco values (127, 'AQ', 'Tipo de moeda inválido', false, 3);
insert into errobanco values (128, 'AT', 'CGC/CPF do favorecido inválido', false, 3);
insert into errobanco values (129, 'AU', 'Endereço do favorecido não informado', false, 3);
insert into errobanco values (130, 'AX', 'CEP do favorecido inválido', false, 3);
insert into errobanco values (131, 'AY', 'Alteração inválida; Banco anterior Bradesco', false, 3);
insert into errobanco values (132, 'AZ', 'Código de Banco do favorecido inválido', false, 3);
insert into errobanco values (133, 'BD', 'Pagamento agendado', false, 3);
insert into errobanco values (134, 'BE', 'Hora de gravação inválida', false, 3);
insert into errobanco values (135, 'BF', 'Identificação da empresa no Banco, inválida', false, 3);
insert into errobanco values (136, 'BG', 'CGC/CPF do pagador inválido', false, 3);
insert into errobanco values (137, 'BH', 'Tipo de inscrição do cliente favorecido inválido', false, 3);
insert into errobanco values (138, 'BI', 'Data de vencimento inválida ou não preenchida', false, 3);
insert into errobanco values (139, 'BJ', 'Data de emissão do documento inválida', false, 3);
insert into errobanco values (140, 'BK', 'Tipo de inscrição do cliente favorecido não permitido', false, 3);
insert into errobanco values (141, 'BL', 'Data limite para desconto inválida', false, 3);
insert into errobanco values (142, 'BM', 'Data para efetivação do pagamento inválida', false, 3);
insert into errobanco values (143, 'BN', 'Data para efetivação anterior a do processamento', false, 3);
insert into errobanco values (144, 'BO', 'Cliente não cadastrado', false, 3);
insert into errobanco values (145, 'BP', 'Identificação de Título Bradesco divergente da original', false, 3);
insert into errobanco values (146, 'BQ', 'Data do documento posterior ao vencimento', false, 3);
insert into errobanco values (147, 'BT', 'Desautorização efetuada', false, 3);
insert into errobanco values (148, 'BU', 'Alteração efetuada', false, 3);
insert into errobanco values (149, 'BV', 'Exclusão efetuada', false, 3);
insert into errobanco values (150, 'BW', 'Pagamento efetuado', true, 3);
insert into errobanco values (151, 'FA', 'Código de origem inválido', false, 3);
insert into errobanco values (152, 'FB', 'Data de gravação do arquivo inválida', false, 3);
insert into errobanco values (153, 'FC', 'Tipo de documento inválido', false, 3);
insert into errobanco values (154, 'FE', 'Número de pagamento inválido', false, 3);
insert into errobanco values (155, 'FF', 'Valor do desconto sem data limite', false, 3);
insert into errobanco values (156, 'FG', 'Data limite para desconto posterior ao vencimento', false, 3);
insert into errobanco values (157, 'FH', 'Falta número e/ou série do documento', false, 3);
insert into errobanco values (158, 'FI', 'Exclusão de agendamento não disponível', false, 3);
insert into errobanco values (159, 'FJ', 'Soma dos valores não confere', false, 3);
insert into errobanco values (160, 'FK', 'Falta valor de pagamento', false, 3);
insert into errobanco values (161, 'FL', 'Modalidade de pagamento inválida para o contrato', false, 3);
insert into errobanco values (162, 'FM', 'Código de movimento inválido', false, 3);
insert into errobanco values (163, 'FN', 'Tentativa de inclusão de registro existente', false, 3);
insert into errobanco values (164, 'FO', 'Tentativa de alteração para registro inexistente', false, 3);
insert into errobanco values (165, 'FP', 'Tentativa de efetivação de agendamento não disponível', false, 3);
insert into errobanco values (166, 'FQ', 'Tentativa de desautorização de agendamento não disponível', false, 3);
insert into errobanco values (167, 'FR', 'Autorização de agendamento sem data de efetivação e sem data de vencimento', false, 3);
insert into errobanco values (168, 'FS', 'Título em agendamento; Pedido de confirmação', false, 3);
insert into errobanco values (169, 'FT', 'Tipo de inscrição do cliente pagador inválido', false, 3);
insert into errobanco values (170, 'FU', 'Contrato inexistente ou inativo', false, 3);
insert into errobanco values (171, 'FV', 'Cliente com convênio cancelado', false, 3);
insert into errobanco values (172, 'FW', 'Valor autorizado inferior ao original', false, 3);
insert into errobanco values (173, 'FX', 'Está faltando registro header', false, 3);
insert into errobanco values (174, 'FZ', 'Valor autorizado não confere para pagamento em atraso', false, 3);
insert into errobanco values (175, 'F0', 'Agendamento em atraso; não permitido pelo convênio', false, 3);
insert into errobanco values (176, 'F1', 'Tentativa de Agendamento com Desc. Fora do Prazo', false, 3);
insert into errobanco values (177, 'F3', 'Tentativa de alteração inválida; confirmação de débito já efetuada', false, 3);
insert into errobanco values (178, 'F4', 'Falta registro trailler', false, 3);
insert into errobanco values (179, 'F5', 'Valor do trailler não confere', false, 3);
insert into errobanco values (180, 'F6', 'Quantidade de registros do trailler não confere', false, 3);
insert into errobanco values (181, 'F7', 'Tentativa de alteração inválida; pagamento já enviado ao Bradesco Instantâneo', false, 3);
insert into errobanco values (182, 'F8', 'Pagamento enviado após o horário estipulado', false, 3);
insert into errobanco values (183, 'F9', 'Tentativa de inclusão de registro existente em histórico', false, 3);
insert into errobanco values (184, 'GA', 'Tipo de DOC/TED inválido', false, 3);
insert into errobanco values (185, 'GB', 'Número do DOC/TED inválido', false, 3);
insert into errobanco values (186, 'GC', 'Finalidade do DOC/TED inválida ou inexistente', false, 3);
insert into errobanco values (187, 'GD', 'Conta corrente do favorecido encerrada / bloqueada', false, 3);
insert into errobanco values (188, 'GE', 'Conta corrente do favorecido não recadastrada', false, 3);
insert into errobanco values (189, 'GF', 'Inclusão de pagamento via modalidade 30 não permitida', false, 3);
insert into errobanco values (190, 'GG', 'Campo livre do código de barras (linha digitável) inválido', false, 3);
insert into errobanco values (191, 'GH', 'Dígito verificador do código de barras inválido', false, 3);
insert into errobanco values (192, 'GI', 'Código da moeda da linha digitável inválido', false, 3);
insert into errobanco values (193, 'GJ', 'Conta poupança do favorecido inválida', false, 3);
insert into errobanco values (194, 'GK', 'Conta poupança do favorecido não recadastrada', false, 3);
insert into errobanco values (195, 'GL', 'Conta poupança do favorecido não encontrada', false, 3);
insert into errobanco values (196, 'GM', 'Pagamento 3 (três) dias após o vencimento', false, 3);
insert into errobanco values (197, 'GN', 'Conta complementar inválida', false, 3);
insert into errobanco values (198, 'GO', 'Inclusão de DOC/TED para Banco 237 não permitido', false, 3);
insert into errobanco values (199, 'GP', 'CGC/CPF do favorecido divergente do cadastro do Banco', false, 3);
insert into errobanco values (200, 'GQ', 'Tipo de DOC/TED não permitido via sistema eletrônico', false, 3);
insert into errobanco values (201, 'GR', 'Alteração inválida; pagamento já enviado a agência pagadora', false, 3);
insert into errobanco values (202, 'GS', 'Limite de pagamento excedido. Fale com o Gerente da sua agência', false, 3);
insert into errobanco values (203, 'GT', 'Limite vencido/vencer em 30 dias', false, 3);
insert into errobanco values (204, 'GU', 'Pagamento agendado por aumento de limite ou redução no total autorizado', false, 3);
insert into errobanco values (205, 'GV', 'Cheque OP estornado conforme seu pedido', false, 3);
insert into errobanco values (206, 'GW', 'Conta corrente ou conta poupança com razão não permitido para efetivação de crédito', false, 3);
insert into errobanco values (207, 'GX', 'Cheque OP com data limite vencida', false, 3);
insert into errobanco values (208, 'GY', 'Conta poupança do favorecido encerrada / bloqueada', false, 3);
insert into errobanco values (209, 'GZ', 'Conta corrente do pagador encerrada / bloqueada', false, 3);
insert into errobanco values (210, 'HA', 'Agendado, débito sob consulta de saldo', false, 3);
insert into errobanco values (211, 'HB', 'Pagamento não efetuado, saldo insuficiente', false, 3);
insert into errobanco values (212, 'HC', 'Pagamento não efetuado, além de saldo insuficiente, conta com cadastro no DVL', false, 3);
insert into errobanco values (213, 'HD', 'Pagamento não efetuado, além de saldo insuficiente, conta bloqueada', false, 3);
insert into errobanco values (214, 'HE', 'Data de Vencto/Pagto fora do prazo de operação do banco', false, 3);
insert into errobanco values (215, 'HF', 'Processado e debitado', false, 3);
insert into errobanco values (216, 'HG', 'Processado e não debitado por saldo insuficiente', false, 3);
insert into errobanco values (217, 'HI', 'Cheque OP Emitido nesta data', false, 3);
insert into errobanco values (218, 'JA', 'Código de lançamento inválido', false, 3);
insert into errobanco values (219, 'JB', 'DOC/TED/Títulos devolvidos e estornados', false, 3);
insert into errobanco values (220, 'JC', 'Modalidade alterada de 07/CIP, para 08/STR', false, 3);
insert into errobanco values (221, 'JD', 'Modalidade alterada de 07/CIP, para 03/DOC COMPE', false, 3);
insert into errobanco values (222, 'JE', 'Modalidade alterada de 08/STR para 07/CIP', false, 3);
insert into errobanco values (223, 'JF', 'Modalidade alterada de 08/STR para 03/COMPE', false, 3);
insert into errobanco values (224, 'JG', 'Alteração de Modalidade Via Arquivo não Permitido', false, 3);
insert into errobanco values (225, 'JH', 'Horário de Consulta de Saldo após Encerramento Rotina', false, 3);
insert into errobanco values (226, 'JI', 'Modalidade alterada de 01/Crédito em conta para 05/Crédito em conta real time', false, 3);
insert into errobanco values (227, 'JJ', 'Horário de agendamento Inválido', false, 3);
insert into errobanco values (228, 'JK', 'Tipo de conta ? modalidade DOC/TED - inválido', false, 3);
insert into errobanco values (229, 'JL', 'Titulo Agendado/Descontado', false, 3);
insert into errobanco values (230, 'JM', 'Alteração não Permitida, Titulo Antecipado/Descontado', false, 3);
insert into errobanco values (231, 'JN', 'Modalidade Alter. de 05/Crédito em Conta Real Time Para 01/Crédito em Conta', false, 3);
insert into errobanco values (232, 'JO', 'Exclusão não Permitida Titulo Antecipado/Descontado', false, 3);
insert into errobanco values (233, 'JP', 'Pagamento com Limite TED Excedido. Fale com o Gerente da sua agência para Autorização.', false, 3);
insert into errobanco values (234, 'KO', 'Autorização para debito em conta', false, 3);
insert into errobanco values (235, 'KP', 'Cliente pagador não cadastrado do PAGFOR', false, 3);
insert into errobanco values (236, 'KQ', 'Modalidade inválida para pagador em teste', false, 3);
insert into errobanco values (237, 'KR', 'Banco destinatário não operante nesta data', false, 3);
insert into errobanco values (238, 'KS', 'Modalidade alterada de DOC. Para TED', false, 3);
insert into errobanco values (239, 'KT', 'Dt. Efetivação alterada p/ próximo MOVTO. ** TRAG', false, 3);
insert into errobanco values (240, 'KV', 'CPF/CNPJ do investidor inválido ou inexistente', false, 3);
insert into errobanco values (241, 'KW', 'Tipo Inscrição Investidor Inválido ou inexistente', false, 3);
insert into errobanco values (242, 'KX', 'Nome do Investidor Inexistente', false, 3);
insert into errobanco values (243, 'KZ', 'Código do Investidor Inexistente', false, 3);
insert into errobanco values (244, 'LA', 'Agendado. Sob Lista de Débito', false, 3);
insert into errobanco values (245, 'LB', 'Pagamento não autorizado sob Lista de Débito', false, 3);
insert into errobanco values (246, 'LC', 'Lista com mais de uma modalidade', false, 3);
insert into errobanco values (247, 'LD', 'Lista com mais de uma data de Pagamento', false, 3);
insert into errobanco values (248, 'LE', 'Número de Lista Duplicado', false, 3);
insert into errobanco values (249, 'LF', 'Lista de Débito vencida e não autorizada', false, 3);
insert into errobanco values (250, 'LG', 'Conta Salário não permitida para este convênio', false, 3);
insert into errobanco values (251, 'LH', 'Código de Lançamento inválido para Conta Salário', false, 3);
insert into errobanco values (252, 'LI', 'Finalidade de DOC / TED inválido para Salário', false, 3);
insert into errobanco values (253, 'LJ', 'Conta Salário obrigatória para este Código de Lançamento', false, 3);
insert into errobanco values (254, 'LK', 'Tipo de Conta do Favorecido Inválida', false, 3);
insert into errobanco values (255, 'LL', 'Nome do Favorecido Inconsistente', false, 3);
insert into errobanco values (256, 'LM', 'Número de Lista de Débito Inválido', false, 3);
insert into errobanco values (257, 'MA', 'Tipo conta Inválida para finalidade', false, 3);
insert into errobanco values (258, 'MB', 'Conta Crédito Investimento inválida/inexistente', false, 3);
insert into errobanco values (259, 'MC', 'Conta Débito Investimento Inválida/inexistente', false, 3);
insert into errobanco values (260, 'MD', 'Titularidade diferente para tipo de conta', false, 3);
insert into errobanco values (261, 'ME', 'Data de Pagamento Alterada devido a Feriado Local', false, 3);
insert into errobanco values (262, 'MF', 'Alegação Efetuada', false, 3);
insert into errobanco values (263, 'MG', 'Alegação Não Efetuada. Motivo da Alegação/Reconhecimento da Divida Inconsistente.', false, 3);
insert into errobanco values (264, 'MH', 'Autorização Não Efetuada. Código de Reconhecimento da divida não permitido.', false, 3);
insert into errobanco values (265, 'NC', 'Código Identificador Inválido', false, 3);
insert into errobanco values (266, 'TR', 'Ag/ Conta do favorecido alterado por Transferência de agencia.', false, 3);

insert into db_errobanco select '237', e92_sequencia from errobanco where e92_sequencia between 115 and 266;



insert into db_sysarquivo values (3952, 'empagemovformapagamento', 'Forma de Pagamento', 'e07', '2016-07-13', 'empagemovformapagamento', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (38,3952);
insert into db_syscampo values(21951,'e07_sequencial','int4','Código sequencial','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21952,'e07_empagemov','int4','Código do movimento','0', 'Código do Movimento',10,'f','f','f',1,'text','Código do Movimento');
insert into db_syscampo values(21953,'e07_formatransmissao','int4','1 = DOC 2 = TED','0', 'Forma de Transmissão',10,'f','f','f',1,'text','Forma de Transmissão');
insert into db_syscampodef values(21953,'1','DOC');
insert into db_syscampodef values(21953,'2','TED');
delete from db_sysarqcamp where codarq = 3952;
insert into db_sysarqcamp values(3952,21951,1,0);
insert into db_sysarqcamp values(3952,21953,2,0);
insert into db_sysarqcamp values(3952,21952,3,0);
insert into db_sysindices values(4365,'empagemovformapagamento_empagemov_in',3952,'0');
insert into db_syscadind values(4365,21952,1);
delete from db_sysforkey where codarq = 3952 and referen = 0;
insert into db_sysforkey values(3952,21952,1,995,0);
delete from db_sysprikey where codarq = 3952;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3952,21951,1,21952);
insert into db_syssequencia values(1000587, 'empagemovformapagamento_e07_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000587 where codarq = 3952 and codcam = 21951;

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL FINANCEIRO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------------- INICIO SAÚDE ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10247 ,'Hórus' ,'Hórus' ,'' ,'1' ,'1' ,'Menu principal do Hórus.' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 3444 ,10247 ,25 ,6877 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10248 ,'Configuração de Usuário' ,'Configuração de Usuário' ,'far4_configuracaousuariohorus001.php' ,'1' ,'1' ,'Formulário para configuração do usuário de acesso ao Hórus.' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10247 ,10248 ,1 ,6877 );
update db_itensmenu set id_item = 10115 , descricao = 'Exportação' , help = 'Exportação' , funcao = 'far4_exportacaohorus001.php' , itemativo = '1' , manutencao = '1' , desctec = 'Menu para exportação dos dados da farmácia( Entrada, Saída e Dispensação ) para o Hórus.' , libcliente = 'true' where id_item = 10115;
delete from db_menu where id_item_filho = 10115 AND modulo = 6877;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10247 ,10115 ,2 ,6877 );
insert into db_sysarquivo values (3946, 'horususuario', 'Guarda os usuários de acesso ao hórus por departamento.', 'fa66', '2016-06-28', 'Usuários de acesso ao hórus', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (52,3946);
insert into db_syscampo values(21914,'fa66_sequencial','int4','Sequencial de horususuario','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21915,'fa66_unidade','int4','Unidade configurada com os dados do usuário.','0', 'Unidade',10,'f','f','f',1,'text','Unidade');
insert into db_syscampo values(21916,'fa66_usuario','varchar(100)','Usuário de acesso ao hórus.','', 'Usuário',100,'f','t','f',0,'text','Usuário');
insert into db_syscampo values(21917,'fa66_senha','varchar(40)','Senha de acesso ao hórus.','', 'Senha',40,'f','t','f',0,'text','Senha');
insert into db_sysarqcamp values(3946,21914,1,0);
insert into db_sysarqcamp values(3946,21915,2,0);
insert into db_sysarqcamp values(3946,21916,3,0);
insert into db_sysarqcamp values(3946,21917,4,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3946,21914,1,21915);
insert into db_syssequencia values(1000581, 'horususuario_fa66_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000581 where codarq = 3946 and codcam = 21914;
delete from db_sysforkey where codarq = 3946 and referen = 0;
insert into db_sysforkey values(3946,21915,1,100011,0);
insert into db_sysindices values(4360,'horususuario_unidade_in',3946,'1');
insert into db_syscadind values(4360,21915,1);
---------------------------------------------------------------------------------------------------------------
--------------------------------------------- FINAL SAÚDE -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO TRIBUTARIO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
     values ( 21918 ,'j18_receitacreditorecalculo' ,'int4' ,'Receita de Crédito utilizada no recálculo' ,'' ,'Receita de Crédito' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Receita de Crédito' );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
     values ( 21919 ,'j18_tipodebitorecalculo' ,'int4' ,'Tipo de Débito utilizado no RecÃ¡lculo' ,'' ,'Tipo de Débito' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Tipo de Débito' );

insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 153 ,21918 ,30 ,0 );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 153 ,21919 ,31 ,0 );

insert into db_sysforkey values(153,21919,1,82,0);
insert into db_sysforkey values(153,21918,1,75,0);

update iptucadlogcalc set j62_erro = false where j62_codigo = 27;

-- Compensacao
insert into db_sysarquivo values (3949, 'abatimentocorrecao', 'Histórico de Correção de Créditos', 'k167', '2016-07-05', 'Abatimento Correção', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (54,3949);

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
    values ( 21928 ,'k167_sequencial' ,'int4' ,'Sequencial' ,'0' ,'Sequencial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Sequencial' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3949 ,21928 ,1 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
    values ( 21929 ,'k167_valorantigo' ,'float8' ,'Valor Antigo' ,'' ,'Valor Antigo' ,15 ,'false' ,'false' ,'false' ,4 ,'text' ,'Valor Antigo' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3949 ,21929 ,2 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
    values ( 21930 ,'k167_valorcorrigido' ,'float8' ,'Valor Corrigido' ,'' ,'Valor Corrigido' ,15 ,'false' ,'false' ,'false' ,4 ,'text' ,'Valor Corrigido' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3949 ,21930 ,3 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
    values ( 21931 ,'k167_data' ,'date' ,'Data da Correção' ,'' ,'Data da Correção' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Data da Correção' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3949 ,21931 ,4 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
    values ( 21932 ,'k167_abatimento' ,'int4' ,'Código do Abatimento' ,'' ,'Código do Abatimento' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código do Abatimento' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3949 ,21932 ,5 ,0 );

insert into db_syssequencia values(1000584, 'abatimentocorrecao_k167_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000584 where codarq = 3949 and codcam = 21928;
insert into db_sysforkey values(3949,21932,1,3191,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3949,21928,1,21928);
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FIM TRIBUTARIO -------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO FOLHA ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
insert into db_layoutcampos SELECT 13751 ,138 ,'carga_horaria' ,'CARGA HORARIA' ,2 ,348 ,'' ,3 ,'f' ,'t' ,'e' ,'' ,0 FROM db_layoutcampos WHERE NOT EXISTS(SELECT 1 FROM db_layoutcampos WHERE db52_codigo = 13751) limit 1;
insert into db_layoutcampos select 13752 ,138 ,'tipo_carga_horaria' ,'TIPO DA CARGA HORARIA' ,1 ,351 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 FROM db_layoutcampos WHERE NOT EXISTS(SELECT 1 FROM db_layoutcampos WHERE db52_codigo = 13752) limit 1;
insert into db_layoutcampos select 13753 ,138 ,'tipo_cedencia' ,'TIPO DA CEDENCIA' ,1 ,352 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 FROM db_layoutcampos WHERE NOT EXISTS(SELECT 1 FROM db_layoutcampos WHERE db52_codigo = 13753) limit 1;
insert into db_layoutcampos select 13754 ,138 ,'onus_origem' ,'ONUS PARA A ORIGEM' ,1 ,353 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 FROM db_layoutcampos WHERE NOT EXISTS(SELECT 1 FROM db_layoutcampos WHERE db52_codigo = 13754) limit 1;
insert into db_layoutcampos select 13755 ,138 ,'ressarcimento' ,'RESSARCIMENTO' ,1 ,354 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 FROM db_layoutcampos WHERE NOT EXISTS(SELECT 1 FROM db_layoutcampos WHERE db52_codigo = 13755) limit 1;
insert into db_layoutcampos select 13756 ,138 ,'data_movimentacao_cedencia' ,'DATA DE MOVIMENTACAO' ,4 ,355 ,'00000000' ,8 ,'f' ,'t' ,'e' ,'' ,0 FROM db_layoutcampos WHERE NOT EXISTS(SELECT 1 FROM db_layoutcampos WHERE db52_codigo = 13756) limit 1;
insert into db_layoutcampos select 13757 ,138 ,'cnpj_origem_destino' ,'CNPJ ORGÃO ORIGEM/DESTINO' ,7 ,363 ,'' ,14 ,'f' ,'t' ,'e' ,'' ,0 FROM db_layoutcampos WHERE NOT EXISTS(SELECT 1 FROM db_layoutcampos WHERE db52_codigo = 13757) limit 1;

select fc_executa_ddl('insert into db_syscampo values(21933,\'rh02_horasdiarias\',\'int4\',\'Número de horas diárias, caso o campo tipo de folha seja diário.\',\'0\', \'Horas Diárias\',20,\'t\',\'f\',\'f\',1,\'text\',\'Horas Diárias\');');
select fc_executa_ddl('insert into db_syscampo values(21934,\'rh02_cedencia\',\'char(1)\',\'Tipo da cedência, pode ser Cedido, Adido ou Não se Aplica, sendo não se aplica a opção default.\',\'X\', \'Tipo\',1,\'f\',\'t\',\'f\',0,\'text\',\'Tipo Cedência\');');
select fc_executa_ddl('insert into db_syscampodef values(21934,\'C\',\'Cedido\');');
select fc_executa_ddl('insert into db_syscampodef values(21934,\'A\',\'Adido\');');
select fc_executa_ddl('insert into db_syscampodef values(21934,\'X\',\'Não se aplica\');');
select fc_executa_ddl('insert into db_syscampo values(21935,\'rh02_onus\',\'char(1)\',\'Informa se existe onus na cedência de um servidor. Especifica se o Onus é da origem ou destino.\',\'X\', \'Ônus\',1,\'f\',\'t\',\'f\',0,\'text\',\'Onus\');');
select fc_executa_ddl('insert into db_syscampodef values(21935,\'X\',\'Não se Aplica\');');
select fc_executa_ddl('insert into db_syscampodef values(21935,\'S\',\'Ônus para origem\');');
select fc_executa_ddl('insert into db_syscampodef values(21935,\'N\',\'Ônus para destino\');');

select fc_executa_ddl('insert into db_syscampo values(21936,\'rh02_ressarcimento\',\'char(1)\',\'Campo que informa se a cedência possui ressarcimento.\',\'X\', \'Ressarcimento\',1,\'f\',\'t\',\'f\',0,\'text\',\'Ressarcimento\');');
select fc_executa_ddl('insert into db_syscampodef values(21936,\'X\',\'Não se aplica\');');
select fc_executa_ddl('insert into db_syscampodef values(21936,\'S\',\'Sim\');');
select fc_executa_ddl('insert into db_syscampodef values(21936,\'N\',\'Não\');');
select fc_executa_ddl('insert into db_syscampo   values(21937,\'rh02_datacedencia\',\'date\',\'Data emq ue ocorreu o cadastro da cedência\',\'null\', \'Data Movimentação\',10,\'t\',\'f\',\'f\',1,\'text\',\'Data Movimentação\');');
select fc_executa_ddl('insert into db_syscampo   values(21938,\'rh02_cnpjcedencia\',\'varchar(20)\',\'CNPJ da Origem/Destino da Cedência. Armazena o CNPj para qual o servidor foi cedido, ou o cnpj do orgão que o Servidor foi Adido.\',\'0\', \'CNPJ Origem/Destino\',20,\'f\',\'f\',\'f\',1,\'text\',\'CNPJ Origem/Destino\');');
select fc_executa_ddl('insert into db_sysarqcamp values(1158,21933,28,0);');
select fc_executa_ddl('insert into db_sysarqcamp values(1158,21934,29,0);');
select fc_executa_ddl('insert into db_sysarqcamp values(1158,21935,30,0);');
select fc_executa_ddl('insert into db_sysarqcamp values(1158,21936,31,0);');
select fc_executa_ddl('insert into db_sysarqcamp values(1158,21937,32,0);');
select fc_executa_ddl('insert into db_sysarqcamp values(1158,21938,33,0);');



---------------------------------------------------------------------------------------------------------------
---------------------------------------- FIM FOLHA ------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

