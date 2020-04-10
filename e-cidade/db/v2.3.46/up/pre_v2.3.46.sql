--
-- Versão: $Id: pre_v2.3.46.sql,v 1.29 2016/01/12 12:58:36 dbrafael.nery Exp $
--

 --Alterações de Layout para DIRF 2016
 insert into db_syscampo values(21695,'r11_baserraparcelaisenta','varchar(4)','Base Parcela Isenta','', 'Base Parcela Isenta',4,'t','t','f',0,'text','Base para Parcela Isenta do RRA');
 insert into db_sysarqcamp values(536,21695,95,0);
 insert into rhdirftipovalor values(24, 'RRA - Dedução - Parcela isenta aposentado ou inativo');
 update rhdirftipovalor set rh97_descricao = 'RRA - Rendimentos isentos Moléstia Grave' where rh97_sequencial = 23;
 --
 --Inserindo layout para dirf 2016
 --
 insert into db_layouttxt values (230, 'LAYOUT DIRF 2016', 0, '', 1);
 insert into db_layoutlinha values (775,230,'RRA',3,192,0,0,'Registros de rendimentos recebidos acumuladamente.','|','t');
 insert into db_layoutlinha values (776, 230, 'BPFRRA', 3, 135, 0, 0,
 'Regras de validação do registro:
 - Deve estar classificado em ordem crescente por:
   - CPF;
   - Natureza do RRA;
 - Deve estar associado ao registro do tipo IDREC.',
 '|', 't');
 insert into db_layoutlinha values (777, 230, 'QTMESES', 3, 55, 0, 0,
 'Regras de validação do registro:
 - Deve ocorrer apenas um registro de cada identificador para o mesmo beneficiário;
 - Deve estar associado ao registro do tipo BPFRRA.',
 '|', 't');
 insert into db_layoutlinha values (778, 230, 'VALORES MENSAIS - RTRT', 3, 200, 0, 0, '', '|', 't');
 insert into db_layoutlinha values (779, 230, 'RESPO', 3, 86, 0, 0, '', '|', 't');
 insert into db_layoutlinha values (780, 230, 'HEADER', 1, 32, 0, 0, '', '|', 't');
 insert into db_layoutlinha values (781, 230, 'DECPJ', 3, 195, 0, 0, '', '|', 't');
 insert into db_layoutlinha values (782, 230, 'IDREC', 3, 9, 0, 0, '', '|', 't');
 insert into db_layoutlinha values (783, 230, 'BPFDEC', 3, 85, 0, 0, '', '|', 'f');
 insert into db_layoutlinha values (784, 230, 'BPJDEC', 3, 170, 0, 0, '', '|', 't');
 insert into db_layoutlinha values (785, 230, 'IDENTIFICADOR_PSE', 3, 3, 0, 0, '', '|', 'f');
 insert into db_layoutlinha values (786, 230, 'INF', 3, 214, 0, 0, '', '|', 't');
 insert into db_layoutlinha values (787, 230, 'FIMDIRF', 4, 7, 0, 0, '', '|', 't');
 insert into db_layoutlinha values (788, 230, 'RIO', 3, 78, 0, 0, '', '|', 't');
 insert into db_layoutlinha values (789, 230, 'PLANO_SAUDE', 3, 91, 0, 0, '', '|', 'f');
 insert into db_layoutlinha values (790, 230, 'operadora_PSE', 3, 176, 0, 0, 'OPERADOR DO PLANO DE SAUDE', '|', 'f');

 insert into db_layoutcampos values (12645, 778, 'julho', 'JULHO', 1, 96, '', 15, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12646, 778, 'junho', 'JUNHO', 1, 81, '', 15, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12647, 781, 'cnpj', 'CNPJ', 1, 6, '', 14, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12648, 781, 'nome_empresarial', 'NOME EMPRESARIAL', 1, 20, '', 150, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12649, 781, 'natureza_declarante', 'NATUREZA DO DECLARANTE', 2, 170, '2', 1, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12650, 781, 'responsavel_perante_cnpj', 'CPF RESPONSÁVEL PERANTE O CNPJ', 2, 171, '', 11, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12651, 788, 'valor_anual', 'VALOR ANUAL', 1, 4, '', 13, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12652, 788, 'descricao_rend_isentos', 'DESCRIÇÃO DOS RENDIMENTOS ISENTOS - OUTR', 1, 17, 'OUTROS', 60, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12653, 788, 'Pipe', 'PIPE', 13, 77, '', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12654, 785, 'identificador_registro', 'identificador_registro', 1, 1, 'PSE', 3, 't', 't', 'd', '', 0);
 insert into db_layoutcampos values (12655, 785, 'pipe', 'PIPE', 1, 4, '', 0, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12656, 780, 'identificador_registro', 'IDENTIFICADOR DE REGISTRO', 1, 1, 'Dirf', 4, 't', 't', 'd', '', 0);
 insert into db_layoutcampos values (12657, 778, 'idetificador_registro', 'IDENTIFICADOR DE REGISTRO', 1, 1, 'RTRT', 5, 't', 't', 'd', '', 0);
 insert into db_layoutcampos values (12658, 790, 'identificador_registro', 'identificador_registro', 1, 1, 'OPSE', 4, 't', 't', 'd', '', 0);
 insert into db_layoutcampos values (12659, 790, 'cnpj', 'CNPJ OPERADOR', 1, 5, '', 14, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12660, 778, 'janeiro', 'JANEIRO', 1, 6, '', 15, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12701, 786, 'informacao_complementar', 'INFORMAÇÃO COMLEMENTAR', 1, 15, '', 200, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12661, 789, 'identificador_registro', 'identificador_registro', 1, 1, 'TPSE', 4, 't', 't', 'd', '', 0);
 insert into db_layoutcampos values (12662, 789, 'cpf', 'cpf', 1, 5, '', 11, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12663, 789, 'nome', 'nome', 1, 16, '', 60, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12664, 790, 'pipe', 'PIPE', 13, 175, '', 0, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12665, 781, 'identificador_registro', 'IDENTIFICADOR DE REGISTRO', 1, 1, 'DECPJ', 5, 't', 't', 'd', '', 0);
 insert into db_layoutcampos values (12666, 782, 'identificador_registro', 'IDENTIFICADOR DE REGISTRO', 1, 1, 'IDREC', 5, 't', 't', 'd', '', 0);
 insert into db_layoutcampos values (12667, 783, 'identificador_registro', 'IDENTIFICADOR DE REGISTRO', 1, 1, 'BPFDEC', 6, 't', 't', 'd', '', 0);
 insert into db_layoutcampos values (12668, 788, 'identificador_registro', 'IDENTIFICADOR DE REGISTRO', 1, 1, 'RIO', 3, 't', 't', 'd', '', 0);
 insert into db_layoutcampos values (12669, 790, 'nome', 'nome', 13, 19, '', 150, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12670, 790, 'registro_ans', 'registro_ans', 1, 169, '', 6, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12671, 784, 'cnpj', 'CNPJ', 1, 7, '', 14, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12672, 784, 'nome', 'NOME', 1, 21, '', 60, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12673, 784, 'identificador_registro', 'IDETIFICADOR DE REGISTRO', 1, 1, 'BPJDEC', 6, 't', 't', 'd', '', 0);
 insert into db_layoutcampos values (12674, 783, 'data_laudo', 'DATA ATRIBUÍDA PELO LAUDO DA MOLÉSTIA GR', 1, 78, '', 0, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12675, 781, 'administradora_fund_invest', 'O DECLARANTE É INSTITUIÇÃO ADMINISTRADOR', 1, 184, 'N', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12676, 783, 'cpf', 'CPF', 1, 7, '', 11, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12677, 783, 'nome', 'NOME', 1, 18, '', 60, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12678, 782, 'codigo_receita', 'CÓDIGO DE RECEITA', 2, 6, '', 4, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12679, 778, 'fevereiro', 'FEVEREIRO', 1, 21, '', 15, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12680, 778, 'marco', 'MARÇO', 1, 36, '', 15, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12681, 778, 'abril', 'ABRIL', 1, 51, '', 15, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12682, 778, 'maio', 'MAIO', 1, 66, '', 15, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12683, 781, 'socio_ostensivo', 'O DECLARANTE É SÓCIO OSTENSIVO RESPONSÁV', 1, 182, 'N', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12684, 781, 'depositario_credito_dec_judicial', 'O DECLARANTE É DEPOSITÁRIO DE CRÉDITO', 1, 183, 'N', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12685, 786, 'cpf', 'CPF', 1, 4, '', 11, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12686, 789, 'valor_ano', 'valor_ano', 1, 76, '', 13, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12687, 780, 'ano_referencia', 'ANO REFERÊNCIA', 1, 5, '', 4, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12688, 780, 'ano_calendario', 'ANO CALENDÁRIO', 1, 9, '', 4, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12689, 780, 'idetificador_retificadora', 'IDENTIFICADOR DE RETIFICADORA', 1, 13, '', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12690, 780, 'numero_recibo', 'NÚMERO DO RECIBO', 1, 14, '', 12, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12691, 789, 'pipe', 'PIPE', 13, 89, '', 0, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12692, 779, 'cpf', 'CPF', 1, 6, '', 11, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12693, 779, 'nome', 'NOME', 1, 17, '', 60, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12694, 779, 'ddd', 'DDD', 1, 77, '', 2, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12695, 786, 'identificador_registro', 'IDENTIFICADOR DE REGISTRO', 1, 1, 'INF', 3, 't', 't', 'd', '', 0);
 insert into db_layoutcampos values (12696, 783, 'Pipe', 'PIPE', 13, 78, '', 0, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12697, 782, 'Pipe', 'PIPE', 13, 10, '', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12698, 787, 'identificador_registro', 'IDENTIFICADOR DE REGISTRO', 1, 1, 'FIMDirf', 7, 't', 't', 'd', '', 0);
 insert into db_layoutcampos values (12699, 787, 'Pipe', 'PIPE', 13, 8, '', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12700, 784, 'Pipe', 'PIPE', 13, 81, '', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12702, 786, 'Pipe', 'PIPE', 13, 215, '', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12703, 778, 'Pipe', 'PIPE', 13, 201, '', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12704, 778, 'agosto', 'AGOSTO', 1, 111, '', 15, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12705, 778, 'setembro', 'SETEMBRO', 1, 126, '', 15, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12706, 778, 'outubro', 'OUTUBRO', 1, 141, '', 15, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12707, 778, 'novembro', 'NOVEMBRO', 1, 156, '', 15, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12708, 778, 'dezembro', 'DEZEMBRO', 1, 171, '', 15, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12709, 778, 'decimo_terceiro', 'DÉCIMO TERCEIRO', 1, 186, '', 15, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12710, 781, 'rendimentos_residentes_exterior', 'O DECLARANTE PAGOU RENDIMENTOS A RESIDEN', 1, 185, 'N', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12714, 779, 'telefone', 'TELEFONE', 1, 79, '', 9, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12715, 780, 'identificador_estrutura_layout', 'IDENTIFICADOR DE ESTRUTURA DE LAYOUT', 1, 26, '7C2DE7J', 7, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12716, 780, 'Pipe', 'PIPE', 13, 33, '', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12717, 781, 'plano_privado_assistencia', 'INDICADOR DE PLANO PRIVADO DE ASSISTÊNCI', 1, 186, 'N', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12718, 779, 'ramal', 'RAMAL', 1, 88, '', 6, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12719, 779, 'fax', 'FAX', 1, 94, '', 9, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12720, 779, 'correio_eletronico', 'CORREIO ELETRÔNICO', 1, 103, '', 50, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12721, 779, 'Pipe', 'PIPE', 13, 153, '', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12722, 781, 'indicador_pagto_copa', 'INDICADOR DE PAGAMENTO PARA A COPA', 1, 187, 'N', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12723, 775, 'identificador', 'IDENTIFICADOR DE REGISTRO', 1, 1, 'RRA', 3, 't', 't', 'd', '', 0);
 insert into db_layoutcampos values (12724, 775, 'identificador_rendimento_recebido', 'IDENTIFICADOR DE RENDIMENTO RECEBIDO', 1, 3, '', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12725, 775, 'numero_processo', 'NÚMERO DO PROCESSO/REQUERIMENTO', 1, 4, '', 20, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12726, 775, 'nome_advogado', 'NOME DO ADVOGADO', 1, 39, '', 150, 'f', 't', 'd', 'Nome do advogado/Nome empresarial do escritório de advocacia', 0);
 insert into db_layoutcampos values (12727, 775, 'tipo_advogado', 'INDICADOR DE TIPO DE ADVOGADO/ESCRITÓRI', 1, 24, '', 1, 'f', 't', 'e', 'Indicador de tipo de advogado/escritório de advocacia', 0);
 insert into db_layoutcampos values (12728, 775, 'documento_advogado', 'CPF DO ADVOGADO/CNPJ DO ESCRITÓRIO DE A', 1, 25, '', 14, 'f', 't', 'e', 'CPF do advogado/CNPJ do escritório de advocacia', 0);
 insert into db_layoutcampos values (12729, 775, 'pipe', 'PIPE', 1, 189, '', 0, 'f', 't', 'd', 'PIPE DE ENCERRAMENTO DE LINHA', 0);
 insert into db_layoutcampos values (12730, 776, 'identificador', 'IDENTIFICADOR DE REGISTRO', 1, 1, 'BPFRRA', 6, 't', 't', 'd', 'Identificador de registro', 0);
 insert into db_layoutcampos values (12731, 776, 'cpf', 'CPF', 1, 7, '', 11, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12732, 776, 'nome', 'NOME', 1, 18, '', 60, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12711, 781, 'situacao_especial', 'A DECLARAÇÃO É SITUAÇÃO ESPECIAL', 1, 188, 'N', 1, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12733, 776, 'natureza', 'NATUREZA DO RRA', 1, 78, '', 50, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12734, 776, 'data_molestia', 'DATA MOLESTIA GRAVE', 4, 128, '', 8, 'f', 't', 'e', '', 0);
 insert into db_layoutcampos values (12735, 776, 'pipe', 'PIPE', 1, 136, '', 0, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12736, 777, 'janeiro', 'JANEIRO', 3, 8, '', 4, 'f', 't', 'e', 'Janeiro', 0);
 insert into db_layoutcampos values (12737, 777, 'fevereiro', 'FEVEREIRO', 3, 12, '', 4, 'f', 't', 'e', 'Fevereiro', 0);
 insert into db_layoutcampos values (12738, 777, 'identificador', 'IDENTIFICADOR', 1, 1, 'QTMESES', 7, 'f', 't', 'd', 'QTMESES', 0);
 insert into db_layoutcampos values (12739, 777, 'março', 'MARÇO', 3, 16, '', 4, 'f', 't', 'e', 'Março', 0);
 insert into db_layoutcampos values (12740, 777, 'abril', 'ABRIL', 3, 20, '', 4, 'f', 't', 'e', 'Abril', 0);
 insert into db_layoutcampos values (12741, 777, 'maio', 'MAIO', 3, 24, '', 4, 'f', 't', 'e', 'Maio', 0);
 insert into db_layoutcampos values (12742, 777, 'junho', 'JUNHO', 3, 28, '', 4, 'f', 't', 'e', 'Junho', 0);
 insert into db_layoutcampos values (12743, 777, 'agosto', 'AGOSTO', 3, 36, '', 4, 'f', 't', 'e', 'Agosto', 0);
 insert into db_layoutcampos values (12744, 777, 'outubro', 'OUTUBRO', 3, 44, '', 4, 'f', 't', 'e', 'Outubro', 0);
 insert into db_layoutcampos values (12745, 777, 'dezembro', 'DEZEMBRO', 3, 52, '', 4, 'f', 't', 'e', 'Dezembro', 0);
 insert into db_layoutcampos values (12746, 777, 'julho', 'JULHO', 3, 32, '', 4, 'f', 't', 'e', 'Julho', 0);
 insert into db_layoutcampos values (12747, 777, 'setembro', 'SETEMBRO', 3, 40, '', 4, 'f', 't', 'e', 'Setembro', 0);
 insert into db_layoutcampos values (12748, 777, 'novembro', 'NOVEMBRO', 3, 48, '', 4, 'f', 't', 'e', 'Novembro', 0);
 insert into db_layoutcampos values (12749, 777, 'pipe', 'PIPE', 1, 56, '', 0, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12750, 779, 'identificador_registro', 'IDENTIFICADOR DE REGISTRO', 1, 1, 'RESPO', 5, 't', 't', 'd', '', 0);
 insert into db_layoutcampos values (12712, 781, 'data_evento', 'DATA DE EVENTO', 1, 189, '', 8, 'f', 't', 'd', '', 0);
 insert into db_layoutcampos values (12713, 781, 'Pipe', 'PIPE', 13, 197, '', 1, 'f', 't', 'd', '', 0);

 --Alterando tamanhao do campo de observações
 update db_layoutcampos set db52_tamanho = 500 where db52_layoutlinha = 786 and db52_codigo = 12701;
 --Alterando posição dos campos situacao_especial, data_evento e pipe
 update db_layoutcampos set db52_posicao = 189 where db52_layoutlinha = 781 and db52_codigo = 12711;
 update db_layoutcampos set db52_posicao = 190 where db52_layoutlinha = 781 and db52_codigo = 12712;
 update db_layoutcampos set db52_posicao = 198 where db52_layoutlinha = 781 and db52_codigo = 12713;
 --Inserindo novo campo para a dirf para informações das olimpíadas
 insert into db_layoutcampos values(12751,781,'indicador_pagto_olimpiada','INDICADOR DE PAGAMENTO PARA A OLIMPÍADA',1,188,'N',1,'f','t','d','Indicador de pagamentos aos jogos olímpicos e paraolímpicos de 2016. S para existência e N para não existência.',0);
