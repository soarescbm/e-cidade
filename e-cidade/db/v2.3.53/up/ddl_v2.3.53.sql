---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
alter table bib_parametros add column bi26_impressora int4 default 1;

CREATE SEQUENCE idioma_bi22_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE TABLE idioma(
bi22_sequencial int4 NOT NULL default 0,
bi22_idioma     varchar(50) ,
CONSTRAINT idioma_sequ_pk PRIMARY KEY (bi22_sequencial));

CREATE UNIQUE INDEX idioma_idioma_in ON idioma(bi22_idioma);

insert into idioma
values  (nextval('idioma_bi22_sequencial_seq'), 'AFRICÂNER'),
        (nextval('idioma_bi22_sequencial_seq'), 'ALBANÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'ALEMÃO'),
        (nextval('idioma_bi22_sequencial_seq'), 'AMÁRICO'),
        (nextval('idioma_bi22_sequencial_seq'), 'ÁRABE'),
        (nextval('idioma_bi22_sequencial_seq'), 'ARMÊNIO'),
        (nextval('idioma_bi22_sequencial_seq'), 'AZERBAIJANO'),
        (nextval('idioma_bi22_sequencial_seq'), 'BASCO'),
        (nextval('idioma_bi22_sequencial_seq'), 'BENGALI'),
        (nextval('idioma_bi22_sequencial_seq'), 'BIELO-RUSSO'),
        (nextval('idioma_bi22_sequencial_seq'), 'BIRMANÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'BÓSNIO'),
        (nextval('idioma_bi22_sequencial_seq'), 'BÚLGARO'),
        (nextval('idioma_bi22_sequencial_seq'), 'CANARÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'CATALÃO'),
        (nextval('idioma_bi22_sequencial_seq'), 'CAZAQUE'),
        (nextval('idioma_bi22_sequencial_seq'), 'CEBUANO'),
        (nextval('idioma_bi22_sequencial_seq'), 'CHICHEUA'),
        (nextval('idioma_bi22_sequencial_seq'), 'CHINÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'CHONA'),
        (nextval('idioma_bi22_sequencial_seq'), 'CINGALÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'COREANO'),
        (nextval('idioma_bi22_sequencial_seq'), 'CORSO'),
        (nextval('idioma_bi22_sequencial_seq'), 'CRIOULO HAITIANO'),
        (nextval('idioma_bi22_sequencial_seq'), 'CROATA'),
        (nextval('idioma_bi22_sequencial_seq'), 'CURDO'),
        (nextval('idioma_bi22_sequencial_seq'), 'DINAMARQUÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'ESLOVACO'),
        (nextval('idioma_bi22_sequencial_seq'), 'ESLOVENO'),
        (nextval('idioma_bi22_sequencial_seq'), 'ESPANHOL'),
        (nextval('idioma_bi22_sequencial_seq'), 'ESPERANTO'),
        (nextval('idioma_bi22_sequencial_seq'), 'ESTONIANO'),
        (nextval('idioma_bi22_sequencial_seq'), 'FILIPINO'),
        (nextval('idioma_bi22_sequencial_seq'), 'FINLANDÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'FRANCÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'FRÍSIO'),
        (nextval('idioma_bi22_sequencial_seq'), 'GAÉLICO ESCOCÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'GALEGO'),
        (nextval('idioma_bi22_sequencial_seq'), 'GALÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'GEORGIANO'),
        (nextval('idioma_bi22_sequencial_seq'), 'GREGO'),
        (nextval('idioma_bi22_sequencial_seq'), 'GUZERATE'),
        (nextval('idioma_bi22_sequencial_seq'), 'HAUÇÁ'),
        (nextval('idioma_bi22_sequencial_seq'), 'HAVAIANO'),
        (nextval('idioma_bi22_sequencial_seq'), 'HEBRAICO'),
        (nextval('idioma_bi22_sequencial_seq'), 'HINDI'),
        (nextval('idioma_bi22_sequencial_seq'), 'HMONG'),
        (nextval('idioma_bi22_sequencial_seq'), 'HOLANDÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'HÚNGARO'),
        (nextval('idioma_bi22_sequencial_seq'), 'IGBO'),
        (nextval('idioma_bi22_sequencial_seq'), 'IÍDICHE'),
        (nextval('idioma_bi22_sequencial_seq'), 'INDONÉSIO'),
        (nextval('idioma_bi22_sequencial_seq'), 'IORUBA'),
        (nextval('idioma_bi22_sequencial_seq'), 'IRLANDÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'ISLANDÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'ITALIANO'),
        (nextval('idioma_bi22_sequencial_seq'), 'JAPONÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'JAVANÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'KHMER'),
        (nextval('idioma_bi22_sequencial_seq'), 'LAOSIANO'),
        (nextval('idioma_bi22_sequencial_seq'), 'LATIM'),
        (nextval('idioma_bi22_sequencial_seq'), 'LETÃO'),
        (nextval('idioma_bi22_sequencial_seq'), 'LITUANO'),
        (nextval('idioma_bi22_sequencial_seq'), 'LUXEMBURGUÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'MACEDÔNIO'),
        (nextval('idioma_bi22_sequencial_seq'), 'MALAIALA'),
        (nextval('idioma_bi22_sequencial_seq'), 'MALAIO'),
        (nextval('idioma_bi22_sequencial_seq'), 'MALGAXE'),
        (nextval('idioma_bi22_sequencial_seq'), 'MALTÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'MAORI'),
        (nextval('idioma_bi22_sequencial_seq'), 'MARATA'),
        (nextval('idioma_bi22_sequencial_seq'), 'MONGOL'),
        (nextval('idioma_bi22_sequencial_seq'), 'NEPALÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'NORUEGUÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'PACHTO'),
        (nextval('idioma_bi22_sequencial_seq'), 'PERSA'),
        (nextval('idioma_bi22_sequencial_seq'), 'POLONÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'PORTUGUÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'PORTUGUÊS BRASILEIRO'),
        (nextval('idioma_bi22_sequencial_seq'), 'PUNJABI'),
        (nextval('idioma_bi22_sequencial_seq'), 'QUIRGUIZ'),
        (nextval('idioma_bi22_sequencial_seq'), 'ROMENO'),
        (nextval('idioma_bi22_sequencial_seq'), 'RUSSO'),
        (nextval('idioma_bi22_sequencial_seq'), 'SAMOANO'),
        (nextval('idioma_bi22_sequencial_seq'), 'SÉRVIO'),
        (nextval('idioma_bi22_sequencial_seq'), 'SESSOTO'),
        (nextval('idioma_bi22_sequencial_seq'), 'SINDI'),
        (nextval('idioma_bi22_sequencial_seq'), 'SOMALI'),
        (nextval('idioma_bi22_sequencial_seq'), 'SUAÍLE'),
        (nextval('idioma_bi22_sequencial_seq'), 'SUECO'),
        (nextval('idioma_bi22_sequencial_seq'), 'SUNDANÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'TADJIQUE'),
        (nextval('idioma_bi22_sequencial_seq'), 'TAILANDÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'TÂMIL'),
        (nextval('idioma_bi22_sequencial_seq'), 'TCHECO'),
        (nextval('idioma_bi22_sequencial_seq'), 'TELUGO'),
        (nextval('idioma_bi22_sequencial_seq'), 'TURCO'),
        (nextval('idioma_bi22_sequencial_seq'), 'UCRANIANO'),
        (nextval('idioma_bi22_sequencial_seq'), 'URDU'),
        (nextval('idioma_bi22_sequencial_seq'), 'UZBEQUE'),
        (nextval('idioma_bi22_sequencial_seq'), 'VIETNAMITA'),
        (nextval('idioma_bi22_sequencial_seq'), 'XHOSA'),
        (nextval('idioma_bi22_sequencial_seq'), 'INGLÊS'),
        (nextval('idioma_bi22_sequencial_seq'), 'ZULU');



alter table acervo add column bi06_idioma int4;


update acervo set bi06_idioma = (select bi22_sequencial from idioma where bi22_idioma = 'PORTUGUÊS BRASILEIRO');
alter table acervo alter column bi06_idioma set not null;

ALTER TABLE diarioresultado ADD COLUMN ed73_valorreal double precision;
ALTER TABLE edu_parametros ADD COLUMN ed233_apresentarnotaproporcional boolean default true not null;


CREATE TEMP TABLE w_valor_real_diarioresultado as
  SELECT ed73_i_codigo, ed37_c_tipo, ed73_i_valornota
    FROM diarioresultado
    inner join diario         on diario.ed95_i_codigo         = diarioresultado.ed73_i_diario
    inner join regencia       on regencia.ed59_i_codigo       = diario.ed95_i_regencia
    inner join procedimento   on procedimento.ed40_i_codigo   = regencia.ed59_i_codigo
    inner join formaavaliacao on formaavaliacao.ed37_i_codigo = procedimento.ed40_i_formaavaliacao
    where formaavaliacao.ed37_c_tipo = 'NOTA';

UPDATE diarioresultado
   SET ed73_valorreal = w_valor_real_diarioresultado.ed73_i_valornota
  FROM w_valor_real_diarioresultado
 WHERE diarioresultado.ed73_i_codigo = w_valor_real_diarioresultado.ed73_i_codigo;

---------------------------------------------------------------------------------------------------------------
----------------------------------------- FINAL EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO FINANCEIRO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

insert into db_layouttxt values (256, 'BRADESCO - PAGFOR (REMESSA)', 0, '', 1);

insert into db_layoutlinha values (851, 256, 'HEADER', 1, 500, 0, 0, '', '', false);
insert into db_layoutlinha values (852, 256, 'TRANSAÇÃO', 3, 500, 0, 0, '', '', false);
insert into db_layoutlinha values (853, 256, 'TRAILLER', 5, 500, 0, 0, '', '', false);

insert into db_layoutcampos values (13673, 851, 'identificacao_registro', 'IDENTIFICAÇÃO DO REGISTRO', 1, 1, '0', 1, true, true, 'd', '', 0);
insert into db_layoutcampos values (13674, 851, 'codigo_comunicacao', 'CÓDIGO DE COMUNICAÇÃO', 1, 2, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (13675, 851, 'tipo_inscricao', 'TIPO DE INSCRIÇÃO', 1, 10, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (13676, 851, 'cnpj_cpf_base_empresa', 'CNPJ/CPF BASE DA EMPRESA', 1, 11, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (13677, 851, 'nome_empresa', 'NOME DA EMPRESA PAGADORA', 1, 26, '', 40, false, true, 'd', '', 0);
insert into db_layoutcampos values (13678, 851, 'tipo_servico', 'TIPO DE SERVIÇO (PGTO FORNECEDOR)', 1, 66, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (13679, 851, 'codigo_origem_arquivo', 'CÓDIGO DE ORIGEM DO ARQUIVO', 1, 68, '1', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (13680, 851, 'numero_remessa', 'NÚMERO DA REMESSA', 1, 69, '', 5, false, true, 'd', '', 0);
insert into db_layoutcampos values (13681, 851, 'numero_retorno', 'NÚMERO DE RETORNO', 1, 74, '0', 5, false, true, 'd', '', 0);
insert into db_layoutcampos values (13682, 851, 'data_gravacao_arquivo', 'DATA DE GRAVAÇÃO DO ARQUIVO', 1, 79, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (13683, 851, 'hora_gravacao_arquivo', 'HORA DA GRAVAÇÃO DO ARQUIVO', 1, 87, '', 6, false, true, 'e', '', 0);
insert into db_layoutcampos values (13684, 851, 'densidade_gravacao', 'DESNSIDADE DE GRAVAÇÃO (ARQUIVO/FITA)', 1, 93, ' ', 5, false, true, 'd', '', 0);
insert into db_layoutcampos values (13685, 851, 'unidade_densidade', 'UNIDADE DA DENSIDADE (ARQUIVO/FITA)', 1, 98, ' ', 3, false, true, 'd', '', 0);
insert into db_layoutcampos values (13686, 851, 'identificacao_modulo_micro', 'IDENTIFICAÇÃO MÓDULO MICRO', 1, 101, ' ', 5, false, true, 'd', '', 0);
insert into db_layoutcampos values (13687, 851, 'tipo_processamento', 'TIPO DO PROCESSAMENTO', 1, 106, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (13688, 851, 'reservado_empresa', 'RESERVADO PARA USO DA EMPRESA', 1, 107, '', 74, false, true, 'd', '', 0);
insert into db_layoutcampos values (13689, 851, 'reservado_banco_um', 'RESERVADO PARA USO DO BANCO', 1, 181, '', 80, false, true, 'd', '', 0);
insert into db_layoutcampos values (13690, 851, 'reservado_banco_dois', 'RESERVADO BANCO DOIS', 1, 261, '', 217, false, true, 'd', '', 0);
insert into db_layoutcampos values (13691, 851, 'numero_lista_debito', 'NÚMERO DA LISTA DE DÉBITO', 1, 478, '', 9, false, true, 'd', '', 0);
insert into db_layoutcampos values (13692, 851, 'reservado_banco_tres', 'RESERVADO BANCO TRES', 1, 487, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (13693, 851, 'sequencial_registro', 'NÚMERO SEQUENCIAL DO REGISTRO', 1, 495, '', 6, false, true, 'd', '', 0);
insert into db_layoutcampos values (13694, 852, 'identificacao_registro', 'IDENTIFICAÇÃO DO REGISTRO', 1, 1, '1', 1, true, true, 'd', '', 0);
insert into db_layoutcampos values (13695, 852, 'tipo_inscricao_fornecedor', 'TIPO DE INSCRIÇÃO DO FORNECEDOR', 1, 2, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (13696, 852, 'documento', 'DOCUMENTO DO FORNECEDOR', 1, 3, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (13697, 852, 'nome_fornecedor', 'NOME DO FORNECEDOR', 1, 18, '', 30, false, true, 'd', '', 0);
insert into db_layoutcampos values (13698, 852, 'endereco_fornecedor', 'ENDEREÇO DO FORNECEDOR', 1, 48, '', 40, false, true, 'd', '', 0);
insert into db_layoutcampos values (13699, 852, 'cep_fornecedor', 'CEP DO FORNECEDOR', 1, 88, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (13700, 852, 'codigo_banco_fornecedor', 'CÓDIGO DO BANCO DO FORNECEDOR', 1, 96, '', 3, false, true, 'd', '', 0);
insert into db_layoutcampos values (13701, 852, 'codigo_agencia_fornecedor', 'AGENCIA DO FORNECEDOR', 1, 99, '', 5, false, true, 'd', '', 0);
insert into db_layoutcampos values (13702, 852, 'digito_agencia_fornecedor', 'DIGITO DA AGENCIA DO FORNECEDOR', 1, 104, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (13703, 852, 'conta_corrente_fornecedor', 'CONTA CORRENTE DO FORNECEDOR', 1, 105, '', 13, false, true, 'd', '', 0);
insert into db_layoutcampos values (13704, 852, 'digito_conta_corrente_fornecedor', 'DÍGITO DA C/C DO FORNECEDOR', 1, 118, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (13705, 852, 'numero_pagamento', 'NÚMERO DO PAGAMENTO', 1, 120, '', 16, false, true, 'd', '', 0);
insert into db_layoutcampos values (13706, 852, 'carteira', 'CARTEIRA', 1, 136, '', 3, false, true, 'd', '', 0);
insert into db_layoutcampos values (13707, 852, 'nosso_numero', 'NOSSO NÚMERO', 1, 139, '', 12, false, true, 'd', '', 0);
insert into db_layoutcampos values (13708, 852, 'seu_numero', 'SEU NÚMERO', 1, 151, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (13709, 852, 'data_vencimento', 'DATA DE VENCIMENTO', 1, 166, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (13710, 852, 'data_emissao_documento', 'DATA DE EMISSÃO DO DOCUMENTO', 1, 174, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (13711, 852, 'data_limite_desconto', 'DATA LIMITE PARA DESCONTO', 1, 182, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (13712, 852, 'zeros', 'ZEROS', 1, 190, '0', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (13713, 852, 'fator_vencimento', 'FATOR DE VENCIMENTO', 1, 191, '', 4, false, true, 'd', '', 0);
insert into db_layoutcampos values (13714, 852, 'valor_documento', 'VALOR DO DOCUMENTO', 1, 195, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos values (13715, 852, 'valor_pagamento', 'VALOR DO PAGAMENTO', 1, 205, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (13716, 852, 'valor_desconto', 'VALOR DO DESCONTO', 1, 220, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (13717, 852, 'valor_acrescimo', 'VALOR DO ACRÉSCIMO', 1, 235, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (13718, 852, 'tipo_documento', 'TIPO DE DOCUMENTO', 1, 250, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (13719, 852, 'reservado', 'CAMPO RESERVADO', 1, 252, '0', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (13720, 852, 'numero_nota_fiscal', 'NÚMERO DA NOTA FISCAL/DUPLICATA', 1, 253, '', 9, false, true, 'd', '', 0);
insert into db_layoutcampos values (13721, 852, 'serie_documento', 'SÉRIE DO DOCUMENTO', 1, 262, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (13722, 852, 'modalidade_pagamento', 'MODALIDADE DE PAGAMENTO', 1, 264, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (13723, 852, 'data_efetivacao_pagamento', 'DATA PARA EFETIVAÇÃO DO PAGAMENTO', 1, 266, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (13724, 852, 'moeda_cnab', 'MOEDA (CÓDIGO CNAB)', 1, 274, '', 3, false, true, 'd', '', 0);
insert into db_layoutcampos values (13725, 852, 'situacao_agendamento', 'SITUAÇÃO DO AGENDAMENTO', 1, 277, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (13726, 852, 'fixo_branco', 'FIXO BRANCO', 1, 279, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos values (13727, 852, 'tipo_movimento', 'TIPO DE MOVIMENTO', 1, 289, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (13728, 852, 'codigo_movimento', 'CÓDIGO DO MOVIMENTO', 1, 290, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (13729, 852, 'horario_consulta_saldo', 'HORÁRIO PARA CONSULTA DE SALDO', 1, 292, '', 4, false, true, 'd', '', 0);
insert into db_layoutcampos values (13730, 852, 'saldo_disponivel_consulta', 'SALDO DISPONÍVEL NO MOMENTO DA CONSULTA', 1, 296, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (13731, 852, 'valor_taxa_pre_funding', 'VALOR DA TAXA PRÉ FUNDING', 1, 311, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (13732, 852, 'reservado_um', 'RESERVADO', 1, 326, '', 6, false, true, 'd', '', 0);
insert into db_layoutcampos values (13733, 852, 'sacador_avalista', 'SACADOR/AVALISTA', 1, 332, '', 40, false, true, 'd', '', 0);
insert into db_layoutcampos values (13734, 852, 'reservado_dois', 'RESERVA DOIS', 1, 372, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (13735, 852, 'nivel_informacao_retorno', 'NÍVEL DA INFORMAÇÃO DE RETORNO', 1, 373, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (13736, 852, 'informacoes_complementares', 'INFORMAÇÕES COMPLEMENTARES', 1, 374, '', 40, false, true, 'd', '', 0);
insert into db_layoutcampos values (13737, 852, 'codigo_area_empresa', 'CÓDIGO DE ÁREA NA EMPRESA', 1, 414, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (13738, 852, 'uso_empresa', 'CAMPO PARA USO DA EMPRESA', 1, 416, '', 35, false, true, 'd', '', 0);
insert into db_layoutcampos values (13739, 852, 'reserva_tres', 'RESERVA TRES', 1, 451, '', 22, false, true, 'd', '', 0);
insert into db_layoutcampos values (13740, 852, 'codigo_lancamento', 'CÓDIGO DO LANÇAMENTO', 1, 473, '', 5, false, true, 'd', '', 0);
insert into db_layoutcampos values (13741, 852, 'reserva_quatro', 'RESERVA QUATRO', 1, 478, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (13742, 852, 'tipo_conta_fornecedor', 'TIPO DE CONTA DO FORNECEDOR', 1, 479, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (13743, 852, 'conta_complementar', 'CONTA COMPLEMENTAR', 1, 480, '', 7, false, true, 'd', '', 0);
insert into db_layoutcampos values (13744, 852, 'reserva_cinco', 'RESERVA CINCO', 1, 487, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (13745, 852, 'sequencial_registro', 'NÚMERO SEQUENCIAL DO REGISTRO', 1, 495, '', 6, false, true, 'd', '', 0);
insert into db_layoutcampos values (13746, 853, 'identificacao_registro', 'IDENTIFICAÇÃO DO REGISTRO', 1, 1, '', 1, true, true, 'd', '', 0);
insert into db_layoutcampos values (13747, 853, 'quantidade_registro', 'QUANTIDADE DE REGISTROS', 1, 2, '', 6, false, true, 'd', '', 0);
insert into db_layoutcampos values (13748, 853, 'total_valor_pagamentos', 'TOTAL DOS VALORES DE PAGAMENTO', 1, 8, '', 17, false, true, 'd', '', 0);
insert into db_layoutcampos values (13749, 853, 'reserva_um', 'RESERVA UM', 1, 25, '', 470, false, true, 'd', '', 0);
insert into db_layoutcampos values (13750, 853, 'sequencial_registro', 'NUMERO SEQUENCIAL', 1, 495, '', 6, false, true, 'd', '', 0);
update db_layoutcampos set db52_layoutformat = 1 where db52_layoutlinha in (851,852,853);

-- Arquivo de retorno
insert into db_layouttxt values (257, 'BRADESCO - PAGFOR (RETORNO)', 0, '', 1);

insert into db_layoutlinha values (854, 257, 'HEADER', 1, 500, 0, 0, '', '', false);
insert into db_layoutlinha values (855, 257, 'TRANSAÇÃO', 3, 500, 0, 0, '', '', false);
insert into db_layoutlinha values (856, 257, 'TRAILLER', 5, 500, 0, 0, '', '', false);

insert into db_layoutcampos values (14673, 854, 'identificacao_registro', 'IDENTIFICAÇÃO DO REGISTRO', 1, 1, '0', 1, true, true, 'd', '', 0);
insert into db_layoutcampos values (14674, 854, 'codigo_comunicacao', 'CÓDIGO DE COMUNICAÇÃO', 1, 2, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (14675, 854, 'tipo_inscricao', 'TIPO DE INSCRIÇÃO', 1, 10, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (14676, 854, 'cnpj_cpf_base_empresa', 'CNPJ/CPF BASE DA EMPRESA', 1, 11, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (14677, 854, 'nome_empresa', 'NOME DA EMPRESA PAGADORA', 1, 26, '', 40, false, true, 'd', '', 0);
insert into db_layoutcampos values (14678, 854, 'tipo_servico', 'TIPO DE SERVIÇO (PGTO FORNECEDOR)', 1, 66, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (14679, 854, 'codigo_origem_arquivo', 'CÓDIGO DE ORIGEM DO ARQUIVO', 1, 68, '1', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (14680, 854, 'numero_remessa', 'NÚMERO DA REMESSA', 1, 69, '', 5, false, true, 'd', '', 0);
insert into db_layoutcampos values (14681, 854, 'numero_retorno', 'NÚMERO DE RETORNO', 1, 74, '0', 5, false, true, 'd', '', 0);
insert into db_layoutcampos values (14682, 854, 'data_gravacao_arquivo', 'DATA DE GRAVAÇÃO DO ARQUIVO', 1, 79, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (14683, 854, 'hora_gravacao_arquivo', 'HORA DA GRAVAÇÃO DO ARQUIVO', 1, 87, '', 6, false, true, 'e', '', 0);
insert into db_layoutcampos values (14684, 854, 'densidade_gravacao', 'DESNSIDADE DE GRAVAÇÃO (ARQUIVO/FITA)', 1, 93, ' ', 5, false, true, 'd', '', 0);
insert into db_layoutcampos values (14685, 854, 'unidade_densidade', 'UNIDADE DA DENSIDADE (ARQUIVO/FITA)', 1, 98, ' ', 3, false, true, 'd', '', 0);
insert into db_layoutcampos values (14686, 854, 'identificacao_modulo_micro', 'IDENTIFICAÇÃO MÓDULO MICRO', 1, 101, ' ', 5, false, true, 'd', '', 0);
insert into db_layoutcampos values (14687, 854, 'tipo_processamento', 'TIPO DO PROCESSAMENTO', 1, 106, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (14688, 854, 'reservado_empresa', 'RESERVADO PARA USO DA EMPRESA', 1, 107, '', 74, false, true, 'd', '', 0);
insert into db_layoutcampos values (14689, 854, 'reservado_banco_um', 'RESERVADO PARA USO DO BANCO', 1, 181, '', 80, false, true, 'd', '', 0);
insert into db_layoutcampos values (14690, 854, 'reservado_banco_dois', 'RESERVADO BANCO DOIS', 1, 261, '', 217, false, true, 'd', '', 0);
insert into db_layoutcampos values (14691, 854, 'numero_lista_debito', 'NÚMERO DA LISTA DE DÉBITO', 1, 478, '', 9, false, true, 'd', '', 0);
insert into db_layoutcampos values (14692, 854, 'reservado_banco_tres', 'RESERVADO BANCO TRES', 1, 487, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (14693, 854, 'sequencial_registro', 'NÚMERO SEQUENCIAL DO REGISTRO', 1, 495, '', 6, false, true, 'd', '', 0);

insert into db_layoutcampos values (14694, 855, 'identificacao_registro', 'IDENTIFICAÇÃO DO REGISTRO', 1, 1, '1', 1, true, true, 'd', '', 0);
insert into db_layoutcampos values (14695, 855, 'tipo_inscricao_fornecedor', 'TIPO DE INSCRIÇÃO DO FORNECEDOR', 1, 2, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (14696, 855, 'documento', 'DOCUMENTO DO FORNECEDOR', 1, 3, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (14697, 855, 'nome_fornecedor', 'NOME DO FORNECEDOR', 1, 18, '', 30, false, true, 'd', '', 0);
insert into db_layoutcampos values (14698, 855, 'endereco_fornecedor', 'ENDEREÇO DO FORNECEDOR', 1, 48, '', 40, false, true, 'd', '', 0);
insert into db_layoutcampos values (14699, 855, 'cep_fornecedor', 'CEP DO FORNECEDOR', 1, 88, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (14700, 855, 'codigo_banco_fornecedor', 'CÓDIGO DO BANCO DO FORNECEDOR', 1, 96, '', 3, false, true, 'd', '', 0);
insert into db_layoutcampos values (14701, 855, 'codigo_agencia_fornecedor', 'AGENCIA DO FORNECEDOR', 1, 99, '', 5, false, true, 'd', '', 0);
insert into db_layoutcampos values (14702, 855, 'digito_agencia_fornecedor', 'DIGITO DA AGENCIA DO FORNECEDOR', 1, 104, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (14703, 855, 'conta_corrente_fornecedor', 'CONTA CORRENTE DO FORNECEDOR', 1, 105, '', 13, false, true, 'd', '', 0);
insert into db_layoutcampos values (14704, 855, 'digito_conta_corrente_fornecedor', 'DÍGITO DA C/C DO FORNECEDOR', 1, 118, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (14705, 855, 'numero_pagamento', 'NÚMERO DO PAGAMENTO', 1, 120, '', 16, false, true, 'd', '', 0);
insert into db_layoutcampos values (14706, 855, 'carteira', 'CARTEIRA', 1, 136, '', 3, false, true, 'd', '', 0);
insert into db_layoutcampos values (14707, 855, 'nosso_numero', 'NOSSO NÚMERO', 1, 139, '', 12, false, true, 'd', '', 0);
insert into db_layoutcampos values (14708, 855, 'seu_numero', 'SEU NÚMERO', 1, 151, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (14709, 855, 'data_vencimento', 'DATA DE VENCIMENTO', 1, 166, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (14710, 855, 'data_emissao_documento', 'DATA DE EMISSÃO DO DOCUMENTO', 1, 174, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (14711, 855, 'data_limite_desconto', 'DATA LIMITE PARA DESCONTO', 1, 182, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (14712, 855, 'zeros', 'ZEROS', 1, 190, '0', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (14713, 855, 'fator_vencimento', 'FATOR DE VENCIMENTO', 1, 191, '', 4, false, true, 'd', '', 0);
insert into db_layoutcampos values (14714, 855, 'valor_documento', 'VALOR DO DOCUMENTO', 1, 195, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos values (14715, 855, 'valor_pagamento', 'VALOR DO PAGAMENTO', 1, 205, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (14716, 855, 'valor_desconto', 'VALOR DO DESCONTO', 1, 220, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (14717, 855, 'valor_acrescimo', 'VALOR DO ACRÉSCIMO', 1, 235, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (14718, 855, 'tipo_documento', 'TIPO DE DOCUMENTO', 1, 250, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (14720, 855, 'numero_nota_fiscal', 'NÚMERO DA NOTA FISCAL/DUPLICATA', 1, 252, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos values (14721, 855, 'serie_documento', 'SÉRIE DO DOCUMENTO', 1, 262, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (14722, 855, 'modalidade_pagamento', 'MODALIDADE DE PAGAMENTO', 1, 264, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (14723, 855, 'data_efetivacao_pagamento', 'DATA PARA EFETIVAÇÃO DO PAGAMENTO', 1, 266, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (14724, 855, 'moeda_cnab', 'MOEDA (CÓDIGO CNAB)', 1, 274, '', 3, false, true, 'd', '', 0);
insert into db_layoutcampos values (14725, 855, 'situacao_agendamento', 'SITUAÇÃO DO AGENDAMENTO', 1, 277, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (14726, 855, 'informacao_retorno', 'INFORMAÇÃO RETORNO', 1, 279, '', 10, false, true, 'd', '', 0);
insert into db_layoutcampos values (14727, 855, 'tipo_movimento', 'TIPO DE MOVIMENTO', 1, 289, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (14728, 855, 'codigo_movimento', 'CÓDIGO DO MOVIMENTO', 1, 290, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (14729, 855, 'horario_consulta_saldo', 'HORÁRIO PARA CONSULTA DE SALDO', 1, 292, '', 4, false, true, 'd', '', 0);
insert into db_layoutcampos values (14730, 855, 'saldo_disponivel_consulta', 'SALDO DISPONÍVEL NO MOMENTO DA CONSULTA', 1, 296, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (14731, 855, 'valor_taxa_pre_funding', 'VALOR DA TAXA PRÉ FUNDING', 1, 311, '', 15, false, true, 'd', '', 0);
insert into db_layoutcampos values (14732, 855, 'reservado_um', 'RESERVADO', 1, 326, '', 6, false, true, 'd', '', 0);
insert into db_layoutcampos values (14733, 855, 'sacador_avalista', 'SACADOR/AVALISTA', 1, 332, '', 40, false, true, 'd', '', 0);
insert into db_layoutcampos values (14734, 855, 'reservado_dois', 'RESERVA DOIS', 1, 372, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (14735, 855, 'nivel_informacao_retorno', 'NÍVEL DA INFORMAÇÃO DE RETORNO', 1, 373, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (14736, 855, 'informacoes_complementares', 'INFORMAÇÕES COMPLEMENTARES', 1, 374, '', 40, false, true, 'd', '', 0);
insert into db_layoutcampos values (14737, 855, 'codigo_area_empresa', 'CÓDIGO DE ÁREA NA EMPRESA', 1, 414, '', 2, false, true, 'd', '', 0);
insert into db_layoutcampos values (14738, 855, 'uso_empresa', 'CAMPO PARA USO DA EMPRESA', 1, 416, '', 35, false, true, 'd', '', 0);
insert into db_layoutcampos values (14739, 855, 'reserva_tres', 'RESERVA TRES', 1, 451, '', 22, false, true, 'd', '', 0);
insert into db_layoutcampos values (14740, 855, 'codigo_lancamento', 'CÓDIGO DO LANÇAMENTO', 1, 473, '', 5, false, true, 'd', '', 0);
insert into db_layoutcampos values (14741, 855, 'reserva_quatro', 'RESERVA QUATRO', 1, 478, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (14742, 855, 'tipo_conta_fornecedor', 'TIPO DE CONTA DO FORNECEDOR', 1, 479, '', 1, false, true, 'd', '', 0);
insert into db_layoutcampos values (14743, 855, 'conta_complementar', 'CONTA COMPLEMENTAR', 1, 480, '', 7, false, true, 'd', '', 0);
insert into db_layoutcampos values (14744, 855, 'reserva_cinco', 'RESERVA CINCO', 1, 487, '', 8, false, true, 'd', '', 0);
insert into db_layoutcampos values (14745, 855, 'sequencial_registro', 'NÚMERO SEQUENCIAL DO REGISTRO', 1, 495, '', 6, false, true, 'd', '', 0);

insert into db_layoutcampos values (14746, 856, 'identificacao_registro', 'IDENTIFICAÇÃO DO REGISTRO', 1, 1, '', 1, true, true, 'd', '', 0);
insert into db_layoutcampos values (14747, 856, 'quantidade_registro', 'QUANTIDADE DE REGISTROS', 1, 2, '', 6, false, true, 'd', '', 0);
insert into db_layoutcampos values (14748, 856, 'total_valor_pagamentos', 'TOTAL DOS VALORES DE PAGAMENTO', 1, 8, '', 17, false, true, 'd', '', 0);
insert into db_layoutcampos values (14749, 856, 'reserva_um', 'RESERVA UM', 1, 25, '', 470, false, true, 'd', '', 0);
insert into db_layoutcampos values (14750, 856, 'sequencial_registro', 'NUMERO SEQUENCIAL', 1, 495, '', 6, false, true, 'd', '', 0);

update db_layoutcampos set db52_layoutformat = 1 where db52_layoutlinha in (854, 855, 856);

select setval('db_layoutcampos_db52_codigo_seq', 14800);
select setval('db_layoutlinha_db51_codigo_seq', 860);
select setval('db_layouttxt_db50_codigo_seq', 260);

DROP TABLE IF EXISTS pagfornumeracao CASCADE;
DROP SEQUENCE IF EXISTS pagfornumeracao_o152_sequencial_seq;
CREATE SEQUENCE pagfornumeracao_o152_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE TABLE pagfornumeracao(
o152_sequencial   int4 NOT NULL default 0,
o152_instit       int4 NOT NULL default 0,
o152_numero       int4 default 0,
CONSTRAINT pagfornumeracao_sequ_pk PRIMARY KEY (o152_sequencial));
ALTER TABLE pagfornumeracao ADD CONSTRAINT pagfornumeracao_instit_fk FOREIGN KEY (o152_instit) REFERENCES db_config;
CREATE INDEX pagfornumeracao_sequencial_in ON pagfornumeracao(o152_sequencial);
alter table pagfornumeracao add column o152_empagegera integer not null;
ALTER TABLE pagfornumeracao ADD CONSTRAINT pagfornumeracao_empagegera_fk FOREIGN KEY (o152_empagegera) REFERENCES empagegera;

CREATE TABLE empenho.empagemovformapagamento (
e07_sequencial        serial not null,
e07_formatransmissao  int4 not null default 1,
e07_empagemov         int4 not null,
CONSTRAINT empagemovformapagamento_sequ_pk PRIMARY KEY (e07_sequencial));

ALTER TABLE empenho.empagemovformapagamento ADD CONSTRAINT empagemovformapagamento_empagemov_fk FOREIGN KEY (e07_empagemov) REFERENCES empagemov;
CREATE INDEX empagemovformapagamento_empagemov_in ON empenho.empagemovformapagamento(e07_empagemov);


---------------------------------------------------------------------------------------------------------------
------------------------------------------- FIM FINANCEIRO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------------- INICIO SAÚDE ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
CREATE SEQUENCE horususuario_fa66_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE horususuario(
fa66_sequencial  int4 NOT NULL default 0,
fa66_unidade     int4 NOT NULL default 0,
fa66_usuario     varchar(100) NOT NULL ,
fa66_senha       varchar(40) ,
CONSTRAINT horususuario_sequ_pk PRIMARY KEY (fa66_sequencial));

ALTER TABLE horususuario
ADD CONSTRAINT horususuario_unidade_fk FOREIGN KEY (fa66_unidade)
REFERENCES unidades;

CREATE UNIQUE INDEX horususuario_unidade_in ON horususuario(fa66_unidade);
---------------------------------------------------------------------------------------------------------------
--------------------------------------------- FINAL SAÚDE -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO TRIBUTARIO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
alter table cfiptu add column j18_receitacreditorecalculo int4,
                   add column j18_tipodebitorecalculo int4;

alter table cfiptu add constraint cfiptu_receitacreditorecalculo_fk foreign key (j18_receitacreditorecalculo) references tabrec;
alter table cfiptu add constraint cfiptu_tipodebitorecalculo_fk foreign key (j18_tipodebitorecalculo) references arretipo;

-- Compensacao
CREATE SEQUENCE abatimentocorrecao_k167_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE abatimentocorrecao(
k167_sequencial		int4 NOT NULL default 0,
k167_valorantigo		float8 NOT NULL ,
k167_valorcorrigido		float8 NOT NULL ,
k167_data		date NOT NULL ,
k167_abatimento		int4 ,
CONSTRAINT abatimentocorrecao_sequ_pk PRIMARY KEY (k167_sequencial));

ALTER TABLE abatimentocorrecao
ADD CONSTRAINT abatimentocorrecao_abatimento_fk FOREIGN KEY (k167_abatimento)
REFERENCES abatimento;

alter table abatimentoutilizacao add column k157_observacao text;
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FIM TRIBUTARIO -------------------------------------------------------
---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO FOLHA ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
select fc_executa_ddl('alter table rhpessoalmov add column rh02_horasdiarias int4  default 0;');
select fc_executa_ddl('alter table rhpessoalmov add column rh02_cedencia    char(1) NOT NULL default \'X\';');
select fc_executa_ddl('alter table rhpessoalmov add column rh02_onus         char(1) NOT NULL default \'X\';');
select fc_executa_ddl('alter table rhpessoalmov add column rh02_ressarcimento char(1) NOT NULL default \'X\';');
select fc_executa_ddl('alter table rhpessoalmov add column rh02_datacedencia date  default null;');
select fc_executa_ddl('alter table rhpessoalmov add column rh02_cnpjcedencia varchar(20) default 0;');


---------------------------------------------------------------------------------------------------------------
---------------------------------------- FIM FOLHA -------------------------------------------------------
---------------------------------------------------------------------------------------------------------------