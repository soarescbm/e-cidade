------------------------------------------------------------------------------------
---------------------------------- TIME C ------------------------------------------
------------------------------------------------------------------------------------

-- Criacao do layout do CENSO 2015
insert into db_layouttxt( db50_codigo ,db50_layouttxtgrupo ,db50_descr ,db50_quantlinhas ,db50_obs ) values ( 226 ,2 ,'CENSO 2015' ,0 ,'CENSO 2015' );
-- Registros (linhas)
insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta )
     values ( 734, 226 ,'REGISTRO 00' ,3 ,0 ,0 ,0 ,'Dados de identificação da escola' ,'|' ,'0' ),
            ( 735, 226 ,'REGISTRO 10' ,3 ,0 ,0 ,0 ,'Caracterização e infra estrutura' ,'|' ,'0' ),
            ( 736, 226 ,'REGISTRO 20' ,3 ,0 ,0 ,0 ,'Cadastro de turma' ,'|' ,'0' ),
            ( 737, 226 ,'REGISTRO 30' ,3 ,0 ,0 ,0 ,'Cadastro de Docente - identificação' ,'|' ,'0' ),
            ( 738, 226 ,'REGISTRO 40' ,3 ,0 ,0 ,0 ,'Cadastro de Docente - Documentos e Endereço' ,'|' ,'0' ),
            ( 739, 226 ,'REGISTRO 50' ,3 ,0 ,0 ,0 ,'Cadastro de Docente - Dados Variáveis' ,'|' ,'0' ),
            ( 740, 226 ,'REGISTRO 51' ,3 ,0 ,0 ,0 ,'Cadastro de docente - dados de docência' ,'|' ,'0' ),
            ( 741, 226 ,'REGISTRO 60' ,3 ,0 ,0 ,0 ,'Cadastro de Aluno - Identificação' ,'|' ,'0' ),
            ( 742, 226 ,'REGISTRO 70' ,3 ,0 ,0 ,0 ,'Cadastro de Aluno - Documentos e Endereço' ,'|' ,'0' ),
            ( 743, 226 ,'REGISTRO 80' ,3 ,0 ,0 ,0 ,'Cadastro de Aluno - Vínculo(matrícula)' ,'|' ,'0' );


-- Registro 00
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
                    values ( 12073 ,734 ,'tipo_registro' ,'TIPO DE REGISTRO' ,14 ,1 ,'00' ,2 ,'t' ,'t' ,'d' ,'' ,0 ),
                           ( 12076 ,734 ,'codigo_escola_inep' ,'CÓDIGO DE ESCOLA - INEP' ,14 ,3 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12078 ,734 ,'numero_cpf_gestor_escolar' ,'NÚMERO DO CPF DO GESTOR ESCOLAR' ,14 ,11 ,'' ,11 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12080 ,734 ,'nome_gestor_escolar' ,'NOME DO GESTOR ESCOLAR' ,14 ,22 ,'' ,100 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12082 ,734 ,'cargo_gestor_escolar' ,'CARGO DO GESTOR ESCOLAR' ,14 ,122 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12087 ,734 ,'endereco_eletronico_gestor_escolar' ,'ENDEREÇO ELETRÔNICO DO GESTOR ESCOLAR' ,14 ,123 ,'' ,50 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12088 ,734 ,'situacao_funcionamento' ,'SITUAÇÃO DE FUNCIONAMENTO' ,14 ,173 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12090 ,734 ,'data_inicio_ano_letivo' ,'DATA DE INÍCIO DO ANO LETIVO' ,14 ,174 ,'' ,10 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12092 ,734 ,'data_termino_ano_letivo' ,'DATA DE TÉRMINO DO ANO LETIVO' ,14 ,184 ,'' ,10 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12093 ,734 ,'nome_escola' ,'NOME DA ESCOLA' ,14 ,194 ,'' ,100 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12095 ,734 ,'latitude' ,'LATITUDE' ,14 ,294 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12097 ,734 ,'longitude' ,'LONGITUDE' ,14 ,314 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12099 ,734 ,'cep' ,'CEP' ,14 ,334 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12100 ,734 ,'endereco' ,'ENDEREÇO' ,14 ,342 ,'' ,100 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12102 ,734 ,'endereco_numero' ,'ENDEREÇO NÚMERO' ,14 ,442 ,'' ,10 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12104 ,734 ,'complemento_endereco' ,'COMPLEMENTO' ,14 ,452 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12106 ,734 ,'bairro' ,'BAIRRO' ,14 ,472 ,'' ,50 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12108 ,734 ,'uf' ,'UF' ,14 ,522 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12110 ,734 ,'municipio' ,'MUNICÍPIO' ,14 ,524 ,'' ,7 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12111 ,734 ,'distrito' ,'DISTRITO' ,14 ,531 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12113 ,734 ,'ddd' ,'DDD' ,14 ,533 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12114 ,734 ,'telefone' ,'TELEFONE' ,14 ,535 ,'' ,9 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12115 ,734 ,'telefone_publico_1' ,'TELEFONE PÚBLICO' ,14 ,544 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12117 ,734 ,'telefone_publico_2' ,'OUTRO TELEFONE DE CONTATO' ,14 ,552 ,'' ,9 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12118 ,734 ,'fax' ,'FAX' ,14 ,561 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12121 ,734 ,'endereco_eletronico' ,'ENDEREÇO ELETRÔNICO' ,14 ,569 ,'' ,50 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12123 ,734 ,'codigo_orgao_regional_ensino' ,'CÓDIGO DO ÓRGÃO REGIONAL DE ENSINO' ,14 ,619 ,'' ,5 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12126 ,734 ,'dependencia_administrativa' ,'DEPENDÊNCIA ADMINISTRATIVA' ,14 ,624 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12128 ,734 ,'localizacao_zona_escola' ,'LOCALIZAÇÃO/ZONA DA ESCOLA' ,14 ,625 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12130 ,734 ,'categoria_escola_privada' ,'CATEGORIA DA ESCOLA PRIVADA' ,14 ,626 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12132 ,734 ,'conveniada_poder_publico' ,'CONVENIADA COM O PODER PÚBLICO' ,14 ,627 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12137 ,734 ,'mant_esc_privada_empresa_grupo_empresarial_pes_fis' ,'MANTENEDORA - EMPRESA, GRUPOS EMPRESARIA' ,14 ,628 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12138 ,734 ,'mant_esc_privada_sidicatos_associacoes_cooperativa' ,'MANTENEDORA - SINDICATOS DE TRABALHADORE' ,14 ,629 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12139 ,734 ,'mant_esc_privada_ong_internacional_nacional_oscip' ,'MANTENEDORA - ORGANIZAÇÃO NÃO GOVERNAMEN' ,14 ,630 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12140 ,734 ,'mant_esc_privada_instituicoes_sem_fins_lucrativos' ,'MANTENEDORA - INSTITUIÇÕES SEM FINS LUCR' ,14 ,631 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12142 ,734 ,'sistema_s_sesi_senai_sesc_outros' ,'SISTEMA S' ,14 ,632 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12144 ,734 ,'cnpj_mantenedora_principal_escola_privada' ,'CNPJ DA MANTENEDORA PRINCIPAL DA ESCOLA' ,14 ,633 ,'' ,14 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12146 ,734 ,'cnpj_escola_privada' ,'CNPJ DA ESCOLA PRIVADA' ,14 ,647 ,'' ,14 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12149 ,734 ,'regulamentacao_autorizacao_conselho_orgao' ,'REGULAMENTAÇÃO/AUTORIZAÇÃO NO CONSELHO' ,14 ,661 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12154 ,734 ,'unidade_vinculada_escola_educacao_basica' ,'UNIDADE VINCULADA A ESCOLA DE EDUCAÇÃO' ,14 ,662 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12157 ,734 ,'codigo_escola_sede' ,'CÓDIGO DA ESCOLA SEDE' ,14 ,663 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12160 ,734 ,'codigo_ies' ,'CÓDIGO DA IES' ,14 ,671 ,'' ,14 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12162 ,734 ,'pipe' ,'FINALIZADOR DE LINHA' ,14 ,685 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 );

-- Registro 10
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
                    values ( 12167 ,735 ,'tipo_registro' ,'TIPO DE REGISTRO' ,14 ,1 ,'10' ,2 ,'t' ,'t' ,'d' ,'' ,0 ),
                           ( 12168 ,735 ,'codigo_escola_inep' ,'CÓDIGO DA ESCOLA - INEP' ,14 ,3 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12170 ,735 ,'local_funcionamento_escola_predio_escolar' ,'LOCAL DE FUNCIONAMENTO - PRÉDIO ESCOLAR' ,14 ,11 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12172 ,735 ,'local_funcionamento_escola_templo_igreja' ,'LOCAL DE FUNCIONAMENTO - TEMPLO/IGREJA' ,14 ,12 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12174 ,735 ,'local_funcionamento_escola_salas_empresas' ,'LOCAL DE FUNCIONAMENTO - SALA DE EMPRESA' ,14 ,13 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12176 ,735 ,'local_funcionamento_escola_casa_professor' ,'LOCAL FUNCIONAMENTO - CASA DO PROFESSOR' ,14 ,14 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12178 ,735 ,'local_funcionamento_escola_salas_outras_escolas' ,'LOCAL DE FUNCIONAMENTO - SALA OUTRA ESCO' ,14 ,15 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12181 ,735 ,'local_funcionamento_escola_galpao_rancho_paiol_bar' ,'LOCAL FUNCIONAMENTO - GALPÃO/RANCHO' ,14 ,16 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12183 ,735 ,'local_funcionamento_escola_un_internacao_socio' ,'LOCAL FUNCIONAMENTO - UNIDADE SOCIOEDUCA' ,14 ,17 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12185 ,735 ,'local_funcionamento_escola_unidade_prisional' ,'LOCAL FUNCIONAMENTO - UNIDADE PRISIONAL' ,14 ,18 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12187 ,735 ,'local_funcionamento_escola_outros' ,'LOCAL FUNCIONAMENTO - OUTROS' ,14 ,19 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12189 ,735 ,'forma_ocupacao_predio' ,'FORMA DE OCUPAÇÃO DO PRÉDIO' ,14 ,20 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12191 ,735 ,'predio_compartilhado_outra_escola' ,'PRÉDIO COMPARTILHADO COM OUTRA ESCOLA' ,14 ,21 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12193 ,735 ,'codigo_escola_compartilha_1' ,'CÓDIGO DA ESCOLA A QUAL COMPARTILHA 1' ,14 ,22 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12195 ,735 ,'codigo_escola_compartilha_2' ,'CÓDIGO DA ESCOLA A QUAL COMPARTILHA 2' ,14 ,30 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12197 ,735 ,'codigo_escola_compartilha_3' ,'CÓDIGO DA ESCOLA A QUAL COMPARTILHA 3' ,14 ,38 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12198 ,735 ,'codigo_escola_compartilha_4' ,'CÓDIGO DA ESCOLA A QUAL COMPARTILHA 4' ,14 ,46 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12201 ,735 ,'codigo_escola_compartilha_5' ,'CÓDIGO DA ESCOLA A QUAL COMPARTILHA 5' ,14 ,54 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12206 ,735 ,'codigo_escola_compartilha_6' ,'CÓDIGO DA ESCOLA A QUAL COMPARTILHA 6' ,14 ,62 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12209 ,735 ,'agua_consumida_alunos' ,'ÁGUA CONSUMIDA PELOS ALUNOS' ,14 ,70 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12214 ,735 ,'abastecimento_agua_rede_publica' ,'ABASTECIMENTO ÁGUA - REDE PÚBLICA' ,14 ,71 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12218 ,735 ,'abastecimento_agua_poco_artesiano' ,'ABASTECIMENTO ÁGUA - POÇO ARTESIANO' ,14 ,72 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12223 ,735 ,'abastecimento_agua_cacimba_cisterna_poco' ,'ABASTECIMENTO ÁGUA - CACIMBA/CISTERNA' ,14 ,73 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12228 ,735 ,'abastecimento_agua_fonte_rio_igarape_riacho_correg' ,'ABASTECIMENTO ÁGUA - FONTE/RIO/IGARAPÉ' ,14 ,74 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12231 ,735 ,'abastecimento_agua_inexistente' ,'ABASTECIMENTO ÁGUA - INEXISTENTE' ,14 ,75 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12234 ,735 ,'abastecimento_energia_eletrica_rede_publica' ,'ABASTECIMENTO ENERGIA - REDE PÚBLICA' ,14 ,76 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12237 ,735 ,'abastecimento_energia_eletrica_gerador' ,'ABASTECIMENTO ENERGIA - GERADOR' ,14 ,77 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12241 ,735 ,'abastecimento_energia_eletrica_outros_alternativa' ,'ABASTECIMENTO ENERGIA - OUTROS' ,14 ,78 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12245 ,735 ,'abastecimento_energia_eletrica_inexistente' ,'ABASTECIMENTO ENERGIA - INEXISTENTE' ,14 ,79 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12247 ,735 ,'esgoto_sanitario_rede_publica' ,'ESGOTO SANITÁRIO - REDE PÚBLICA' ,14 ,80 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12248 ,735 ,'esgoto_sanitario_fossa' ,'ESGOTO SANITÁRIO - FOSSA' ,14 ,81 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12250 ,735 ,'esgoto_sanitario_inexistente' ,'ESGOTO SANITÁRIO - INEXISTENTE' ,14 ,82 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12255 ,735 ,'destinacao_lixo_coleta_periodica' ,'DESTINAÇÃO LIXO - COLETA PERIÓDICA' ,14 ,83 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12257 ,735 ,'destinacao_lixo_queima' ,'DESTINAÇÃO LIXO - QUEIMA' ,14 ,84 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12260 ,735 ,'destinacao_lixo_joga_outra_area' ,'DESTINAÇÃO LIXO - JOGA EM OUTRA ÁREA' ,14 ,85 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12262 ,735 ,'destinacao_lixo_recicla' ,'DESTINAÇÃO LIXO - RECICLA' ,14 ,86 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12264 ,735 ,'destinacao_lixo_enterra' ,'DESTINAÇÃO LIXO - ENTERRA' ,14 ,87 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12266 ,735 ,'destinacao_lixo_outros' ,'DESTINAÇÃO LIXO - OUTROS' ,14 ,88 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12269 ,735 ,'dependencias_existentes_escola_sala_diretoria' ,'DEPENDÊNCIAS - SALA DA DIRETORA' ,14 ,89 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12275 ,735 ,'dependencias_existentes_escola_sala_professores' ,'DEPENDÊNCIAS - SALA DE PROFESSORES' ,14 ,90 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12277 ,735 ,'dependencias_existentes_escola_sala_secretaria' ,'DEPENDÊNCIAS - SALA DE SECRETARIA' ,14 ,91 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12281 ,735 ,'dependencias_existentes_escola_laboratorio_informa' ,'DEPENDÊNCIAS - LABORATÓRIO INFORMÁTICA' ,14 ,92 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12284 ,735 ,'dependencias_existentes_escola_laboratorio_ciencia' ,'DEPENDÊNCIAS - LABORATÓRIO DE CIÊNCIAS' ,14 ,93 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12288 ,735 ,'dependencias_existentes_escola_sala_recursos_multi' ,'DEPENDÊNCIAS - SALA RECURSOS MULTIFUNCIO' ,14 ,94 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12289 ,735 ,'dependencias_existentes_escola_quadra_esporte_cobe' ,'DEPENDÊNCIAS - QUADRA ESPORTE COBERTA' ,14 ,95 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12291 ,735 ,'dependencias_existentes_escola_quadra_esporte_desc' ,'DEPENDÊNCIAS - QUADRA ESPORTE DESCOBERTA' ,14 ,96 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12294 ,735 ,'dependencias_existentes_escola_cozinha' ,'DEPENDÊNCIAS - COZINHA' ,14 ,97 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12297 ,735 ,'dependencias_existentes_escola_biblioteca' ,'DEPENDÊNCIAS - BIBLIOTECA' ,14 ,98 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12299 ,735 ,'dependencias_existentes_escola_sala_leitura' ,'DEPENDÊNCIAS - SALA DE LEITURA' ,14 ,99 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12301 ,735 ,'dependencias_existentes_escola_parque_infantil' ,'DEPENDÊNCIAS - PARQUE INFANTIL' ,14 ,100 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12303 ,735 ,'dependencias_existentes_escola_bercario' ,'DEPENDÊNCIAS - BERÇÁRIO' ,14 ,101 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12304 ,735 ,'dependencias_existentes_escola_banheiro_fora_predi' ,'DEPENDÊNCIAS - BANHEIRO FORA DO PRÉDIO' ,14 ,102 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12306 ,735 ,'dependencias_existentes_escola_banheiro_dentro_pre' ,'DEPENDÊNCIAS - BANHEIRO DENTRO DO PRÉDIO' ,14 ,103 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12310 ,735 ,'dependencias_existentes_escola_banheiro_educ_infan' ,'DEPENDÊNCIAS - BANHEIRO EDUCAÇÃO INFANTI' ,14 ,104 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12313 ,735 ,'dependencias_existentes_escola_banheiro_alunos_def' ,'DEPENDÊNCIAS - BANHEIRO DEFICIÊNCIA' ,14 ,105 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12316 ,735 ,'dependencias_existentes_escola_dep_vias_alunos_def' ,'DEPENDÊNCIAS - VIAS ADEQUADAS DEFICIÊNCI' ,14 ,106 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12320 ,735 ,'dependencias_existentes_escola_banheiro_chuveiro' ,'DEPENDÊNCIAS - BANHEIRO COM CHUVEIRO' ,14 ,107 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12322 ,735 ,'dependencias_existentes_escola_refeitorio' ,'DEPENDÊNCIAS - REFEITÓRIO' ,14 ,108 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12325 ,735 ,'dependencias_existentes_escola_despensa' ,'DEPENDÊNCIAS - DESPENSA' ,14 ,109 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12328 ,735 ,'dependencias_existentes_escola_almoxarifado' ,'DEPENDÊNCIAS - ALMOXARIFADO' ,14 ,110 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12333 ,735 ,'dependencias_existentes_escola_auditorio' ,'DEPENDÊNCIAS - AUDITÓRIO' ,14 ,111 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12336 ,735 ,'dependencias_existentes_escola_patio_coberto' ,'DEPENDÊNCIAS - PÁTIO COBERTO' ,14 ,112 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12339 ,735 ,'dependencias_existentes_escola_patio_descoberto' ,'DEPENDÊNCIAS - PÁTIO DESCOBERTO' ,14 ,113 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12340 ,735 ,'dependencias_existentes_escola_alojamento_aluno' ,'DEPENDÊNCIAS - ALOJAMENTO DE ALUNO' ,14 ,114 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12341 ,735 ,'dependencias_existentes_escola_alojamento_professo' ,'DEPENDÊNCIAS - ALOJAMENTO DE PROFESSOR' ,14 ,115 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12342 ,735 ,'dependencias_existentes_escola_area_verde' ,'DEPENDÊNCIAS - ÁREA VERDE' ,14 ,116 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12344 ,735 ,'dependencias_existentes_escola_lavanderia' ,'DEPENDÊNCIAS - LAVANDERIA' ,14 ,117 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12347 ,735 ,'dependencias_existentes_escola_nenhuma_relacionada' ,'DEPENDÊNCIAS - NENHUMA DAS RELACIONADAS' ,14 ,118 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12348 ,735 ,'numero_salas_aula_existentes_escola' ,'NÚMERO DE SALAS DE AULA EXISTENTES' ,14 ,119 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12349 ,735 ,'numero_salas_usadas_como_salas_aula' ,'SALAS UTILIZADAS COMO SALA DE AULA' ,14 ,123 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12350 ,735 ,'equipamentos_existentes_escola_televisao' ,'EQUIPAMENTOS - APARELHO DE TELEVISÃO' ,14 ,127 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12351 ,735 ,'equipamentos_existentes_escola_videocassete' ,'EQUIPAMENTOS - VIDEOCASSETE' ,14 ,131 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12352 ,735 ,'equipamentos_existentes_escola_dvd' ,'EQUIPAMENTOS - APARELHO DE DVD' ,14 ,135 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12353 ,735 ,'equipamentos_existentes_escola_antena_parabolica' ,'EQUIPAMENTOS - ANTENA PARABÓLICA' ,14 ,139 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12354 ,735 ,'equipamentos_existentes_escola_copiadora' ,'EQUIPAMENTOS - COPIADORA' ,14 ,143 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12355 ,735 ,'equipamentos_existentes_escola_retroprojetor' ,'EQUIPAMENTOS - RETROPROJETOR' ,14 ,147 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12356 ,735 ,'equipamentos_existentes_escola_impressora' ,'EQUIPAMENTOS - IMPRESSORA' ,14 ,151 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12357 ,735 ,'equipamentos_existentes_escola_aparelho_som' ,'EQUIPAMENTOS - APARELHO DE SOM' ,14 ,155 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12358 ,735 ,'equipamentos_existentes_escola_projetor_datashow' ,'EQUIPAMENTOS - PROJETOR MULTIMÍDIA' ,14 ,159 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12359 ,735 ,'equipamentos_existentes_escola_fax' ,'EQUIPAMENTOS - FAX' ,14 ,163 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12360 ,735 ,'equipamentos_existentes_escola_maquina_fotografica' ,'EQUIPAMENTOS - MÁQUINA FOTOGRÁFICA' ,14 ,167 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12361 ,735 ,'equipamentos_existentes_escola_computador' ,'EQUIPAMENTOS - COMPUTADORES' ,14 ,171 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12362 ,735 ,'equipamentos_impressora_multifuncional' ,'EQUIPAMENTOS - IMPRESSORA MULTIFUNCIONAL' ,14 ,175 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12363 ,735 ,'quantidade_computadores_uso_administrativo' ,'QUANTIDADE DE COMPUTADORES USO ADMINISTR' ,14 ,179 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12364 ,735 ,'quantidade_computadores_uso_alunos' ,'QUANTIDADE DE COMPUTADORES USO ALUNO' ,14 ,183 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12365 ,735 ,'acesso_internet' ,'ACESSO À INTERNET' ,14 ,187 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12366 ,735 ,'banda_larga' ,'BANDA LARGA' ,14 ,188 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12367 ,735 ,'total_funcionarios_prof_aux_assistentes_monitores' ,'TOTAL DE FUNCIONÁRIOS DA ESCOLA' ,14 ,189 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12368 ,735 ,'alimentacao_escolar_aluno' ,'ALIMENTAÇÃO ESCOLAR PARA OS ALUNOS' ,14 ,193 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12369 ,735 ,'atendimento_educacional_especializado' ,'ATENDIMENTO EDUCACIONAL ESPECIALIZADO' ,14 ,194 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12370 ,735 ,'atividade_complementar' ,'ATIVIDADE COMPLEMENTAR' ,14 ,195 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12371 ,735 ,'modalidade_ensino_regular' ,'MODALIDADE - ENSINO REGULAR' ,14 ,196 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12372 ,735 ,'modalidade_educacao_especial_modalidade_substutiva' ,'MODALIDADE - EDUCAÇÃO ESPECIAL' ,14 ,197 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12373 ,735 ,'modalidade_educacao_jovens_adultos' ,'MODALIDADE - EDUCAÇÃO DE JOVENS E ADULTO' ,14 ,198 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12374 ,735 ,'modalidade_educacao_profissional' ,'MODALIDADE - EDUCAÇÃO PROFISSIONAL' ,14 ,199 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12375 ,735 ,'ensino_fundamental_organizado_ciclos' ,'ENSINO FUNDAMENTAL ORGANIZADO EM CICLOS' ,14 ,200 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12376 ,735 ,'localizacao_diferenciada_escola' ,'LOCALIZAÇÃO DIFERENCIADA DA ESCOLA' ,14 ,201 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12377 ,735 ,'materiais_didaticos_especificos_nao_utiliza' ,'MATERIAL ESPECÍFICOS - NÃO UTILIZA' ,14 ,202 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12378 ,735 ,'materiais_didaticos_especificos_quilombola' ,'MATERIAL ESPECÍFICOS - QUILOMBOLA' ,14 ,203 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12379 ,735 ,'materiais_didaticos_especificos_indigena' ,'MATERIAL ESPECÍFICOS - INDÍGENA' ,14 ,204 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12380 ,735 ,'educacao_indigena' ,'EDUCAÇÃO INDÍGENA' ,14 ,205 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12381 ,735 ,'lingua_ensino_ministrado_lingua_indigena' ,'LÍNGUA MINISTRADA - LÍNGUA INDÍGENA' ,14 ,206 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12382 ,735 ,'lingua_ensino_ministrada_lingua_portuguesa' ,'LÍNGUA MINISTRADA - LÍNGUA PORTUGUESA' ,14 ,207 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12383 ,735 ,'codigo_lingua_indigena' ,'CÓDIGO DA LÍNGUA INDÍGENA' ,14 ,208 ,'' ,5 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12384 ,735 ,'escola_cede_espaco_turma_brasil_alfabetizado' ,'ESCOLA CEDE ESPAÇO TURMAS BRASIL ALFABET' ,14 ,213 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12385 ,735 ,'escola_abre_finais_semanas_comunidade' ,'ESCOLA ABRE AOS FINAIS DE SEMANA' ,14 ,214 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12386 ,735 ,'escola_formacao_alternancia' ,'ESCOLA COM PROPOSTA PEDAGÓGICA DE FORMAÇ' ,14 ,215 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12387 ,735 ,'pipe' ,'FINALIZADOR DE LINHA' ,14 ,216 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 );


-- Registro 20
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr , db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
     values ( 11965 ,736 ,'tipo_registro' ,'TIPO REGISTRO' ,14 ,1 ,'20' ,2 ,'t' ,'t' ,'d' ,'' ,0 ),
            ( 11966 ,736 ,'codigo_escola_inep' ,'CÓDIGO ESCOLA - INEP' ,14 ,3 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11967 ,736 ,'codigo_turma_inep' ,'CÓDIGO TURMA - INEP' ,14 ,11 ,'' ,10 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11968 ,736 ,'codigo_turma_entidade_escola' ,'CÓDIGO DA TURMA NA ENTIDADE/ESCOLA' ,14 ,21 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11969 ,736 ,'nome_turma' ,'NOME DA TURMA' ,14 ,41 ,'' ,80 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11970 ,736 ,'mediacao_didatico_pedagogica' ,'TIPO DE MEDIAÇÃO DIDÁTICO PEDAGÓGICA' ,14 ,121 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11971 ,736 ,'horario_turma_horario_inicial_hora' ,'HORÁRIO DA TURMA - HORA INICIAL' ,14 ,122 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11972 ,736 ,'horario_turma_horario_inicial_minuto' ,'HORÁRIO DA TURMA - H. INICIAL MINUTO' ,14 ,124 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11973 ,736 ,'horario_turma_horario_final_hora' ,'HORÁRIO DA TURMA - H. FINAL - HORA' ,14 ,126 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11974 ,736 ,'horario_turma_horario_final_minuto' ,'HORÁRIO DA TURMA - H. FINAL MINUTO' ,14 ,128 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11975 ,736 ,'dia_semana_domingo' ,'DIA DA SEMANA - DOMINGO' ,14 ,130 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11976 ,736 ,'dia_semana_segunda' ,'DIA DA SEMANA - SEGUNDA FEIRA' ,14 ,131 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11977 ,736 ,'dia_semana_terca' ,'DIA DA SEMANA - TERÇA FEIRA' ,14 ,132 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11978 ,736 ,'dia_semana_quarta' ,'DIA DA SEMANA - QUARTA FEIRA' ,14 ,133 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11979 ,736 ,'dia_semana_quinta' ,'DIA DA SEMANA - QUINTA FEIRA' ,14 ,134 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11980 ,736 ,'dia_semana_sexta' ,'DIA DA SEMANA - SEXTA FEIRA' ,14 ,135 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11981 ,736 ,'dia_semana_sabado' ,'DIA DA SEMANA - SÁBADO' ,14 ,136 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11982 ,736 ,'tipo_atendimento' ,'TIPO DE ATENDIMENTO' ,14 ,137 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11983 ,736 ,'turma_participante_mais_educacao_ensino_medio_inov' ,'TURMA PARTICIPANTE PROG. MAIS EDUCACAO' ,14 ,138 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11984 ,736 ,'codigo_tipo_atividade_complementar_1' ,'CODIGO DO TIPO DE ATIVIDADE 1' ,14 ,139 ,'' ,5 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11985 ,736 ,'codigo_tipo_atividade_complementar_2' ,'CODIGO DO TIPO DE ATIVIDADE 2' ,14 ,144 ,'' ,5 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11986 ,736 ,'codigo_tipo_atividade_complementar_3' ,'CODIGO DO TIPO DE ATIVIDADE 3' ,14 ,149 ,'' ,5 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11987 ,736 ,'codigo_tipo_atividade_complementar_4' ,'CODIGO DO TIPO DE ATIVIDADE 4' ,14 ,154 ,'' ,5 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11988 ,736 ,'codigo_tipo_atividade_complementar_5' ,'CODIGO DO TIPO DE ATIVIDADE 5' ,14 ,159 ,'' ,5 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11989 ,736 ,'codigo_tipo_atividade_complementar_6' ,'CODIGO DO TIPO DE ATIVIDADE 6' ,14 ,164 ,'' ,5 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11990 ,736 ,'aee_ensino_sistema_braille' ,'AEE ENSINO SISTEMA BRAILLE' ,14 ,169 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11991 ,736 ,'aee_ensino_uso_recursos_opticos_nao_opticos' ,'AEE ENSINO DO USO DE RECURSOS OPTICOS' ,14 ,170 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11992 ,736 ,'aee_estrategias_desenvolvimento_processos_mentais' ,'AEE ESTRAT. P DESENV. DE PROC. MENTAIS' ,14 ,171 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11993 ,736 ,'aee_tecnicas_orientacao_mobilidade' ,'AEE TEC. PARA ORIENTAÇÃO E MOBILIDADE' ,14 ,172 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11994 ,736 ,'aee_ensino_lingua_brasileira_sinais_libras' ,'AEE ENS. LINGUA BRAS. DE SINAIS - LIBRAS' ,14 ,173 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11995 ,736 ,'aee_ensino_comunicacao_alternativa_aumentativa' ,'AEE ENS. DE USO COMUNIC. ALTERNATIVA CAA' ,14 ,174 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11996 ,736 ,'aee_estrategia_enriquecimento_curricular' ,'AEE ESTRAT. P/ ENRIQUECIMENTO CURRICULAR' ,14 ,175 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11997 ,736 ,'aee_ensino_uso_soroban' ,'AEE ENSINO DO USO DO SOROBAN' ,14 ,176 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11998 ,736 ,'aee_ensino_usabilidade_funcionalidades_informatica' ,'AEE USABILIDADE INFORMATICA ACESSIVEL' ,14 ,177 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 11999 ,736 ,'aee_ensino_lingua_portuguesa_modalidade_escrita' ,'AEE ENSINO LINGUA PORTUGUESA MODALIDADE' ,14 ,178 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12000 ,736 ,'aee_estrategias_autonomia_ambiente_escolar' ,'AEE ESTRATEGIAS PARA AUTONOMIA AMBIENTE ' ,14 ,179 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12001 ,736 ,'modalidade_turma' ,'MODALIDADE' ,14 ,180 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12002 ,736 ,'etapa_ensino_turma' ,'ETAPA ENSINO' ,14 ,181 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12003 ,736 ,'codigo_curso_educacao_profissional' ,'CÓDIGO DO CURSO TÉCNICO' ,14 ,183 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12004 ,736 ,'disciplinas_turma_quimica' ,'DISCIPLINA - QUÍMICA' ,14 ,191 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12005 ,736 ,'disciplinas_turma_fisica' ,'DISCIPLINA - FISICA' ,14 ,192 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12006 ,736 ,'disciplinas_turma_matematica' ,'DISCIPLINA - MATEMÁTICA' ,14 ,193 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12007 ,736 ,'disciplinas_turma_biologia' ,'DISCIPLINA - BIOLOGIA' ,14 ,194 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12008 ,736 ,'disciplinas_turma_ciencias' ,'DISCIPLINA - CIENCIAS' ,14 ,195 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12009 ,736 ,'disciplinas_turma_lingua_literatura_portuguesa' ,'DISCIPLINA - LINGUA PORTUGUESA' ,14 ,196 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12010 ,736 ,'disciplinas_lingua_literatura_estrangeira_inglesa' ,'DISCIPLINA - LINGUA ESTRANGEIRA INGLESA' ,14 ,197 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12011 ,736 ,'disciplinas_lingua_literatura_estrangeira_espanhol' ,'DISCIPLINA LINGUA ESPANHOLA' ,14 ,198 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12012 ,736 ,'disciplinas_lingua_literatura_estrangeira_frances' ,'DISCIPLINA LINGUA FRANCES' ,14 ,199 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12013 ,736 ,'disciplinas_lingua_literatura_estrangeira_outra' ,'DISCIPLINA - OUTRA' ,14 ,200 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12014 ,736 ,'disciplinas_turma_artes' ,'DISCIPLINA - ARTES' ,14 ,201 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12015 ,736 ,'disciplinas_turma_educacao_fisica' ,'DISCIPLINA - EDUCAÇÃO FISICA' ,14 ,202 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12016 ,736 ,'disciplinas_turma_historia' ,'DISCIPLINA - HISTORIA' ,14 ,203 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12017 ,736 ,'disciplinas_turma_geografia' ,'DISCIPLINA - GEOGRAFIA' ,14 ,204 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12018 ,736 ,'disciplinas_turma_filosofia' ,'DISCIPLINA - FILOSOFIA' ,14 ,205 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12019 ,736 ,'disciplinas_turma_estudos_sociais' ,'DISCIPLINA - ESTUDOS SOCIAIS' ,14 ,206 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12020 ,736 ,'disciplinas_turma_sociologia' ,'DISCIPLINA - SOCIOLOGIA' ,14 ,207 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12021 ,736 ,'disciplinas_turma_informatica_computacao' ,'DISCIPLINA - INFORMATICA/COMPUTAÇÃO' ,14 ,208 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12022 ,736 ,'disciplinas_turma_disciplinas_profissionalizantes' ,'DISCIPLINA - PROFISSIONALIZANTE' ,14 ,209 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12023 ,736 ,'disciplinas_turma_voltadas_atendimento_necessidade' ,'DISCIPLINA VOLTADAS A ATEND. NECESSIDADE' ,14 ,210 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12024 ,736 ,'disciplinas_turma_voltadas_diversidade_sociocultur' ,'DISCIPLINA VOLTADAS DIVERSIDADE SOCIOCUL' ,14 ,211 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12025 ,736 ,'disciplinas_turma_libras' ,'DISCIPLINA - LIBRAS' ,14 ,212 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12026 ,736 ,'disciplinas_turma_disciplinas_pedagogicas' ,'DISCIPLINA - DISCIPLINAS PEDAG ' ,14 ,213 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12027 ,736 ,'disciplinas_turma_ensino_religioso' ,'DISCIPLINA - ENSINO RELIGIOSO ' ,14 ,214 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12028 ,736 ,'disciplinas_turma_lingua_indigena' ,'DISCIPLINA - LINGUA INDIGENA ' ,14 ,215 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12029 ,736 ,'disciplinas_turma_outras' ,'DISCIPLINA - 99 OUTRAS' ,14 ,216 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12030 ,736 ,'turma_sem_docente' ,'TURMA SEM PROFISSIONAL ESCOLAR EM SALA' ,14 ,217 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12031 ,736 ,'pipe' ,'FINALIZADOR DE LINHA' ,14 ,218 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 );

-- REGISTRO 30
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
     values ( 12032 ,737 ,'tipo_registro' ,'TIPO DE REGISTRO' ,14 ,1 ,'30' ,2 ,'t' ,'t' ,'d' ,'' ,0 ),
            ( 12033 ,737 ,'codigo_escola_inep' ,'CÓDIGO DA ESCOLA INEP' ,14 ,3 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12034 ,737 ,'identificacao_unica_docente_inep' ,'IDENTIFICAÇÃO ÚNICA DO DOCENTE INEP' ,14 ,11 ,'' ,12 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12035 ,737 ,'codigo_docente_entidade_escola' ,'CÓDIGO DO DOCENTE NA ENTIDADE/ESCOLA' ,14 ,23 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12036 ,737 ,'nome_completo' ,'NOME COMPLETO' ,14 ,43 ,'' ,100 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12037 ,737 ,'email' ,'E-MAIL' ,14 ,143 ,'' ,100 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12038 ,737 ,'numero_identificacao_social_inss' ,'NÚMERO DE IDENTIFICAÇÃO SOCIAL INSS' ,14 ,243 ,'' ,11 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12039 ,737 ,'data_nascimento' ,'DATA DE NASCIMENTO' ,14 ,254 ,'' ,10 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12040 ,737 ,'sexo' ,'SEXO' ,14 ,264 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12041 ,737 ,'cor_raca' ,'COR/RAÇA' ,14 ,265 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12042 ,737 ,'nome_completo_mae' ,'NOME COMPLETO DA MÃE' ,14 ,266 ,'' ,100 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12043 ,737 ,'nacionalidade_docente' ,'NACIONAL DOCENTE, AUXILIAR, EDUC INFANTI' ,14 ,366 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12044 ,737 ,'pais_origem' ,'PAÍS DE ORIGEM' ,14 ,367 ,'' ,3 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12045 ,737 ,'uf_nascimento' ,'UF DE NASCIMENTO' ,14 ,370 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12046 ,737 ,'municipio_nascimento' ,'MUNICÍPIO DE NASCIMENTO' ,14 ,372 ,'' ,7 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12047 ,737 ,'docente_deficiencia' ,'DOCENTE COM DEFICIÊNCIA' ,14 ,379 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12048 ,737 ,'tipos_deficiencia_cegueira' ,'TIPOS DE DEFICIÊNCIAS' ,14 ,380 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12049 ,737 ,'tipos_deficiencia_baixa_visao' ,'TIPOS DEFICIENCIA BAIXA VISÃO' ,14 ,381 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12050 ,737 ,'tipos_deficiencia_surdez' ,'TIPOS DEFICIENCIA SURDEZ' ,14 ,382 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12051 ,737 ,'tipos_deficiencia_auditiva' ,'TIPOS DEFICIENCIA AUDITIVA' ,14 ,383 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12052 ,737 ,'tipos_deficiencia_surdocegueira' ,'TIPOS DEFICIENCIA SURDOCEGUEIRA' ,14 ,384 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12053 ,737 ,'tipos_deficiencia_fisica' ,'TIPOS DEFICIENCIA FISICA' ,14 ,385 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12054 ,737 ,'tipos_deficiencia_intelectual' ,'TIPOS DEFICIENCIA INTELECTUAL' ,14 ,386 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12055 ,737 ,'tipos_deficiencia_multipla' ,'TIPOS DEFICIENCIA MÚLTIPLA' ,14 ,387 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12056 ,737 ,'pipe' ,'PIPE' ,14 ,388 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 );
-- REGISTRO 40
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
     values ( 12058 ,738 ,'codigo_escola_inep' ,'CÓDIGO DA ESCOLA - INEP' ,14 ,3 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12059 ,738 ,'identificacao_unica_docente_inep' ,'IDENTIFICAÇÃO ÚNICA DO DOCENTE INEP' ,14 ,11 ,'' ,12 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12060 ,738 ,'codigo_docente_entidade_escola' ,'CÓDIGO DO DOCENTE ENTIDADE/ESCOLA' ,14 ,23 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12061 ,738 ,'numero_cpf' ,'NÚMERO DO CPF' ,14 ,43 ,'' ,11 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12062 ,738 ,'localizacao_zona_residencia' ,'LOCALIZAÇÃO/ZONA DA RESIDÊNCIA' ,14 ,54 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12063 ,738 ,'cep' ,'CEP' ,14 ,55 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12064 ,738 ,'endereco' ,'ENDEREÇO' ,14 ,63 ,'' ,100 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12065 ,738 ,'numero_endereco' ,'NÚMERO DO ENDEREÇO' ,14 ,163 ,'' ,10 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12066 ,738 ,'complemento' ,'COMPLEMENTO' ,14 ,173 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12067 ,738 ,'bairro' ,'BAIRRO' ,14 ,193 ,'' ,50 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12068 ,738 ,'uf' ,'UF' ,14 ,243 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12069 ,738 ,'municipio' ,'MUNICÍPIO' ,14 ,245 ,'' ,7 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12070 ,738 ,'pipe' ,'PIPE' ,14 ,252 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 );
-- REGISTRO 50
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
     values ( 12074 ,739 ,'tipo_registro' ,'TIPO DE REGISTRO' ,14 ,1 ,'50' ,2 ,'t' ,'t' ,'d' ,'' ,0 ),
            ( 12075 ,739 ,'codigo_escola_inep' ,'CÓDIGO DA ESCOLA - INEP' ,14 ,3 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12077 ,739 ,'identificacao_unica_docente' ,'IDENTIFICAÇÃO ÚNICA DO DOCENTE(INEP' ,14 ,11 ,'' ,12 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12079 ,739 ,'codigo_docente_entidade_escola' ,'CÓDIGO DO DOCENTE NA ENTIDADE/ESCOLA' ,14 ,23 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12081 ,739 ,'escolaridade' ,'ESCOLARIDADE' ,14 ,43 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12083 ,739 ,'situacao_curso_superior_1' ,'SITUAÇÃO DO CURSO SUPERIOR 1' ,14 ,44 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12084 ,739 ,'formacao_complementacao_pedagogica_1' ,'FORMAÇÃO/COMPLEMENTAÇÃO PEDAGÓGICA 1' ,14 ,45 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12085 ,739 ,'codigo_curso_superior_1' ,'CÓDIGO DO CURSO SUPERIOR 1' ,14 ,46 ,'' ,6 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12086 ,739 ,'ano_inicio_curso_superior_1' ,'ANO DE INÍCIO DO CURSO SUPERIOR 1' ,14 ,52 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12089 ,739 ,'ano_conclusao_curso_superior_1' ,'ANO DE CONCLUSÃO DO CURSO SUPERIOR 1' ,14 ,56 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12091 ,739 ,'tipo_instituicao_curso_superior_1' ,'TIPO DE INSTITUIÇÃO DO CURSO SUPERIOR 1' ,14 ,60 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12094 ,739 ,'instituicao_curso_superior_1' ,'INSTITUIÇÃO DO CURSO SUPERIOR 1' ,14 ,61 ,'' ,7 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12096 ,739 ,'situacao_curso_superior_2' ,'SITUAÇÃO DO CURSO SUPERIOR 2' ,14 ,68 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12098 ,739 ,'formacao_complementacao_pedagogica_2' ,'FORMAÇÃO/COMPLEMENTAÇÃO PEDAGÓGIGA 2' ,14 ,69 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12101 ,739 ,'codigo_curso_superior_2' ,'CÓDIGO DO CURSO SUPERIOR 2' ,14 ,70 ,'' ,6 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12103 ,739 ,'ano_inicio_curso_superior_2' ,'ANO DE INÍCIO DO CURSO SUPERIOR 2' ,14 ,76 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12105 ,739 ,'ano_conclusao_curso_superior_2' ,'ANO DE CONCLUSÃO DO CURSO SUPERIOR 2' ,14 ,80 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12107 ,739 ,'tipo_instituicao_curso_superior_2' ,'TIPO DE INSTITUIÇÃO DO CURSO SUPERIOR 2' ,14 ,84 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12109 ,739 ,'instituicao_curso_superior_2' ,'INSTITUIÇÃO DO CURSO SUPERIOR 2' ,14 ,85 ,'' ,7 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12112 ,739 ,'situacao_curso_superior_3' ,'SITUAÇÃO DO CURSO SUPERIOR 3' ,14 ,92 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12116 ,739 ,'formacao_complementacao_pedagogica_3' ,'FORMAÇÃO/COMPLEMENTAÇÃO PEDAGÓGICA 3' ,14 ,93 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12119 ,739 ,'codigo_curso_superior_3' ,'CÓDIGO DO CURSO SUPERIOR 3' ,14 ,94 ,'' ,6 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12120 ,739 ,'ano_inicio_curso_superior_3' ,'ANO DE INÍCIO DO CURSO SUPERIOR 3' ,14 ,100 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12122 ,739 ,'ano_conclusao_curso_superior_3' ,'ANO DE CONCLUSÃO DO CURSO SUPERIOR 3' ,14 ,104 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12124 ,739 ,'tipo_instituicao_curso_superior_3' ,'TIPO DE INSTITUIÇÃO DO CURSO SUPERIOR' ,14 ,108 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12125 ,739 ,'instituicao_curso_superior_3' ,'INSTITUIÇÃO DO CURSO SUPERIOR 3' ,14 ,109 ,'' ,7 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12127 ,739 ,'pos_graduacao_especializacao' ,'PÓS GRADUAÇÃO - ESPECIALIZAÇÃO' ,14 ,116 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12129 ,739 ,'pos_graduacao_mestrado' ,'PÓS GRADUAÇÃO - MERTRADO' ,14 ,117 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12131 ,739 ,'pos_graduacao_doutorado' ,'PÓS GRADUAÇÃO DOUTORADO' ,14 ,118 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12133 ,739 ,'pos_graduacao' ,'PÓS GRADUAÇÃO' ,14 ,119 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12134 ,739 ,'especifico_creche_0_3_anos' ,'ESPECÍFICO PARA CRECHE DE 0 A 3 ANOS' ,14 ,120 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12135 ,739 ,'especifico_pre_escola_4_5_anos' ,'ESPECÍFICO PARA PRÉ-ESCOLA DE 4 A 5 ANOS' ,14 ,121 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12136 ,739 ,'especifico_anos_iniciais_ensino_fundamental' ,'ESPECÍFICO PARA ANOS INICIAIS ENSINO FUN' ,14 ,122 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12141 ,739 ,'especifico_anos_finais_ensino_fundamental' ,'ESPECÍFICO PARA ANOS FINAIS DO ENS FUNDA' ,14 ,123 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12143 ,739 ,'especifico_ensino_medio' ,'ESPECÍFICO PARA ENSINO MÉDIO' ,14 ,124 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12145 ,739 ,'especifico_eja' ,'ESPECÍFICO PARA EDUCAÇÃO JOVENS ADULTOS' ,14 ,125 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12147 ,739 ,'especifico_educacao_especial' ,'ESPECÍFICO PARA EDUCAÇÃO ESPECIAL' ,14 ,126 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12148 ,739 ,'especifico_educacao_indigena' ,'ESPECÍFICO PARA EDUCAÇÃO INDÍGENA' ,14 ,127 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12150 ,739 ,'especifico_educacao_campo' ,'ESPECÍFICO PARA EDUCAÇÃO DO CAMPO' ,14 ,128 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12151 ,739 ,'especifico_educacao_ambiental' ,'ESPECÍFICO PARA EDUCAÇÃO AMBIENTAL' ,14 ,129 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12152 ,739 ,'especifico_educacao_direitos_humanos' ,'ESPECÍFICO PARA EDUCAÇÃO EM DIREITOS HUM' ,14 ,130 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12153 ,739 ,'genero_diversidade_sexual' ,'GÊNERO E DIVERSIDADE SEXUAL' ,14 ,131 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12155 ,739 ,'direitos_crianca_adolescente' ,'DIREITOS DE CRIANÇA E ADOLESCENTE' ,14 ,132 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12156 ,739 ,'educ_relacoes_etnicorraciais_his_cult_afro_brasil' ,'EDUC PARA ETNIA HIS CUL AFRO BRASILEIRA' ,14 ,133 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12158 ,739 ,'outros' ,'OUTROS' ,14 ,134 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12159 ,739 ,'nenhum' ,'NENHUM' ,14 ,135 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12161 ,739 ,'pipe' ,'PIPE' ,14 ,136 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 );
-- REGISTRO 51
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
     values ( 12163 ,740 ,'tipo_registro' ,'TIPO DE REGISTRO' ,14 ,1 ,'51' ,2 ,'t' ,'t' ,'d' ,'' ,0 ),
            ( 12164 ,740 ,'codigo_escola_inep' ,'CÓDIGO DA ESCOLA - INEP' ,14 ,3 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12165 ,740 ,'identificacao_unica_inep' ,'IDENTIFICAÇÃO ÚNICA(INEP)' ,14 ,11 ,'' ,12 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12166 ,740 ,'codigo_docente_entidade_escola' ,'CÓDIGO DO DOCENTE NA ENTIDADE/ESCOLA' ,14 ,23 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12199 ,740 ,'codigo_turma_inep' ,'CÓDIGO DA TURMA NO INEP' ,14 ,43 ,'' ,10 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12202 ,740 ,'codigo_turma_entidade_escola' ,'CÓDIGO DA TURMA NA ENTIDADE/ESCOLA' ,14 ,53 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12204 ,740 ,'funcao_exerce_escola_turma' ,'FUNÇÃO QUE EXERCE NA ESCOLA/TURMA' ,14 ,73 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12205 ,740 ,'situacao_funcional_contratacao_vinculo' ,'SITUAÇÃO FUNCIONAL/REGIME DE CONTRATAÇÃO' ,14 ,74 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12208 ,740 ,'codigo_disciplina_1' ,'CÓDIGO DA DISCIPLINA 1' ,14 ,75 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12211 ,740 ,'codigo_disciplina_2' ,'CÓDIGO DA DISCIPLINA 2' ,14 ,77 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12212 ,740 ,'codigo_disciplina_3' ,'CÓDIGO DA DISCIPLINA 3' ,14 ,79 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12215 ,740 ,'codigo_disciplina_4' ,'CÓDIGO DA DISCIPLINA 4' ,14 ,81 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12219 ,740 ,'codigo_disciplina_5' ,'CÓDIGO DA DISCIPLINA 5' ,14 ,83 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12221 ,740 ,'codigo_disciplina_6' ,'CÓDIGO DA DISCIPLINA 6' ,14 ,85 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12224 ,740 ,'codigo_disciplina_7' ,'CÓDIGO DA DISCIPLINA 7' ,14 ,87 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12226 ,740 ,'codigo_disciplina_8' ,'CÓDIGO DA DISCIPLINA 8' ,14 ,89 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12229 ,740 ,'codigo_disciplina_9' ,'CÓDIGO DA DISCIPLINA 9' ,14 ,91 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12233 ,740 ,'codigo_disciplina_10' ,'CÓDIGO DA DISCIPLINA 10' ,14 ,93 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12236 ,740 ,'codigo_disciplina_11' ,'CÓDIGO DA DISCIPLINA 11' ,14 ,95 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12238 ,740 ,'codigo_disciplina_12' ,'CÓDIGO DA DISCIPLINA 12' ,14 ,97 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12240 ,740 ,'codigo_disciplina_13' ,'CÓDIGO DA DISCIPLINA 13' ,14 ,99 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12243 ,740 ,'pipe' ,'PIPE' ,14 ,101 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 );

-- Registro 60
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
                    values ( 12169 ,741 ,'tipo_registro' ,'TIPO DE REGISTRO' ,14 ,1 ,'60' ,2 ,'t' ,'t' ,'d' ,'' ,0 ),
                           ( 12171 ,741 ,'codigo_escola_inep' ,'CÓDIGO DA ESCOLA - INEP' ,14 ,3 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12173 ,741 ,'identificacao_unica_aluno' ,'IDENTIFICAÇÃO ÚNICA DO ALUNO( INEP )' ,14 ,11 ,'' ,12 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12175 ,741 ,'codigo_aluno_entidade_escola' ,'CÓDIGO DO ALUNO NA ENTIDADE/ESCOLA' ,14 ,23 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12177 ,741 ,'nome_completo' ,'NOME COMPLETO' ,14 ,43 ,'' ,100 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12179 ,741 ,'data_nascimento' ,'DATA DE NASCIMENTO' ,14 ,143 ,'' ,10 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12180 ,741 ,'sexo' ,'SEXO' ,14 ,153 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12182 ,741 ,'cor_raca' ,'COR/RAÇA' ,14 ,154 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12184 ,741 ,'filiacao' ,'FILIAÇÃO' ,14 ,155 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12186 ,741 ,'nome_mae' ,'NOME DA MÃE' ,14 ,156 ,'' ,100 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12188 ,741 ,'nome_pai' ,'NOME DO PAI' ,14 ,256 ,'' ,100 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12190 ,741 ,'nacionalidade_aluno' ,'NACIONALIDADE DO ALUNO' ,14 ,356 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12192 ,741 ,'pais_origem' ,'PAÍS DE ORIGEM' ,14 ,357 ,'' ,3 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12194 ,741 ,'uf_nascimento' ,'UF DE NASCIMENTO' ,14 ,360 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12196 ,741 ,'municipio_nascimento' ,'MUNICÍPIO DE NASCIMENTO' ,14 ,362 ,'' ,7 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12200 ,741 ,'alunos_deficiencia_transtorno_desenv_superdotacao' ,'TRANSTORNO DESENVOLVIMENTO OU SUPERDOTAÇ' ,14 ,369 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12203 ,741 ,'tipos_defic_transtorno_cegueira' ,'TRANSTORNO DESENV/SUPERDOTAÇÃO CEGUEIRA' ,14 ,370 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12207 ,741 ,'tipos_defic_transtorno_baixa_visao' ,'TRANSTORNO DESENV/SUPERDOTAÇÃO BAIXA VIS' ,14 ,371 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12210 ,741 ,'tipos_defic_transtorno_surdez' ,'TRANSTORNO DESENV/SUPERDOTAÇÃO SURDEZ' ,14 ,372 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12213 ,741 ,'tipos_defic_transtorno_auditiva' ,'TRANSTORNO DESENV/SUPERDOTAÇÃO DEF AUDIT' ,14 ,373 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12216 ,741 ,'tipos_defic_transtorno_surdocegueira' ,'TRANSTORNO DESENV/SUPERDOTAÇÃO SURDOCEGU' ,14 ,374 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12217 ,741 ,'tipos_defic_transtorno_def_fisica' ,'TRANSTORNO DESENV/SUPERDOTAÇÃO DEF FISIC' ,14 ,375 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12220 ,741 ,'tipos_defic_transtorno_def_intelectual' ,'TRANSTORNO DESENV/SUPERDOT DEF INTELECTU' ,14 ,376 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12222 ,741 ,'tipos_defic_transtorno_def_multipla' ,'TRANSTORNO DESENV/SUPERDOT DEF MULTÍPLA' ,14 ,377 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12225 ,741 ,'tipos_defic_transtorno_def_autismo_infantil' ,'TRANSTORNO DESENV/SUPERDOT DEF AUTIS INF' ,14 ,378 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12227 ,741 ,'tipos_defic_transtorno_def_asperger' ,'TRANSTORNO DESENV/SUPERDOT DEF ASPERGER' ,14 ,379 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12230 ,741 ,'tipos_defic_transtorno_def_sindrome_rett' ,'TRANSTORNO DESENV/SUPERDOT DEF RETT' ,14 ,380 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12232 ,741 ,'tipos_defic_transtorno_desintegrativo_infancia' ,'TRANSTORNO DESENV/SUPERDOT DESINT INFANC' ,14 ,381 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12235 ,741 ,'tipos_defic_transtorno_altas_habilidades' ,'TRANSTORNO DESENV/SUPERDOT ALTAS HABILID' ,14 ,382 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12239 ,741 ,'recurso_auxilio_ledor' ,'RECURSO AUXILIO LEDOR' ,14 ,383 ,'' ,1 ,'f' ,'t' ,'d' ,'Recursos necessários para a participação do INEP - auxilio ledor' ,0 ),
                           ( 12242 ,741 ,'recurso_auxilio_transcricao' ,'RECURSO AUXILIO LEDOR' ,14 ,384 ,'' ,1 ,'f' ,'t' ,'d' ,'Recursos necessários para a participação do INEP - auxilio transcrição' ,0 ),
                           ( 12244 ,741 ,'recurso_auxilio_interprete' ,'RECURSO AUXILIO INTERPRETE' ,14 ,385 ,'' ,1 ,'f' ,'t' ,'d' ,'Recursos necessários para a participação do INEP - auxilio interprete' ,0 ),
                           ( 12246 ,741 ,'recurso_auxilio_interprete_libras' ,'RECURSO AUXILIO INTERPRETE LIBRAS' ,14 ,386 ,'' ,1 ,'f' ,'t' ,'d' ,'Recursos necessários para a participação do INEP - auxilio interprete libras' ,0 ),
                           ( 12249 ,741 ,'recurso_auxilio_leitura_labial' ,'RECURSO AUXILIO LEITURA LABIAL' ,14 ,387 ,'' ,1 ,'f' ,'t' ,'d' ,'Recursos necessários para a participação do INEP - auxilio leitura labial' ,0 ),
                           ( 12251 ,741 ,'recurso_auxilio_prova_ampliada_16' ,'RECURSO AUXILIO PROVA AMPLIADA 16' ,14 ,388 ,'' ,1 ,'f' ,'t' ,'d' ,'Recursos necessários para a participação do INEP - auxilio prova ampliada 16' ,0 ),
                           ( 12252 ,741 ,'recurso_auxilio_prova_ampliada_20' ,'RECURSO AUXILIO PROVA AMPLIADA 20' ,14 ,389 ,'' ,1 ,'f' ,'t' ,'d' ,'Recursos necessários para a participação do INEP - auxilio prova ampliada 20' ,0 ),
                           ( 12253 ,741 ,'recurso_auxilio_prova_ampliada_24' ,'RECURSO AUXILIO PROVA AMPLIADA 24' ,14 ,390 ,'' ,1 ,'f' ,'t' ,'d' ,'Recursos necessários para a participação do INEP - auxilio prova ampliada 24' ,0 ),
                           ( 12254 ,741 ,'recurso_auxilio_prova_braille' ,'RECURSO AUXILIO PROVA BRAILLE' ,14 ,391 ,'' ,1 ,'f' ,'t' ,'d' ,'Recursos necessários para a participação do INEP - auxilio prova braille' ,0 ),
                           ( 12256 ,741 ,'recurso_auxilio_nenhum' ,'RECURSO AUXILIO NENHUM' ,14 ,392 ,'' ,1 ,'f' ,'t' ,'d' ,'Recursos necessários para a participação do INEP - auxilio nenhum' ,0 ),
                           ( 12343 ,741 ,'pipe' ,'PIPE' ,14 ,393 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 );

-- Registro 70
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
                    values ( 12258 ,742 ,'tipo_registro' ,'TIPO DE REGISTRO' ,14 ,1 ,'70' ,2 ,'t' ,'t' ,'d' ,'' ,0 ),
                           ( 12259 ,742 ,'codigo_escola_inep' ,'CÓDIGO DA ESCOLA - INEP' ,14 ,3 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12261 ,742 ,'identificacao_unica_aluno' ,'IDENTIFICAÇÃO ÚNICA DO ALUNO ( INEP )' ,14 ,11 ,'' ,12 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12263 ,742 ,'codigo_aluno_entidade' ,'CÓDIGO DO ALUNO NA ENTIDADE/ESCOLA' ,14 ,23 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12265 ,742 ,'numero_identidade' ,'NÚMERO DA IDENTIDADE' ,14 ,43 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12267 ,742 ,'orgao_emissor_identidade' ,'ÓRGÃO EMISSOR DA IDENTIDADE' ,14 ,63 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12268 ,742 ,'uf_identidade' ,'UF DA IDENTIDADE' ,14 ,65 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12270 ,742 ,'data_expedicao_identidade' ,'DATA DE EXPEDIÇÃO DA IDENTIDADE' ,14 ,67 ,'' ,10 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12271 ,742 ,'certidao_civil' ,'CERTIDÃO CIVIL' ,14 ,77 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12272 ,742 ,'tipo_certidao_civil' ,'TIPO DE CERTIDÃO CIVIL' ,14 ,78 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12273 ,742 ,'numero_termo' ,'NÚMERO DO TERMO' ,14 ,79 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12274 ,742 ,'folha' ,'FOLHA' ,14 ,87 ,'' ,4 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12276 ,742 ,'livro' ,'LIVRO' ,14 ,91 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12278 ,742 ,'data_emissao_certidao' ,'DATA DE EMISSÃO DA CERTIDÃO' ,14 ,99 ,'' ,10 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12279 ,742 ,'uf_cartorio' ,'UF DO CARTÓRIO' ,14 ,109 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12280 ,742 ,'municipio_cartorio' ,'MUNICÍPIO DO CARTÓRIO' ,14 ,111 ,'' ,7 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12282 ,742 ,'codigo_cartorio' ,'CÓDIGO DO CARTÓRIO' ,14 ,118 ,'' ,6 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12283 ,742 ,'numero_matricula' ,'NÚMERO DA MATRÍCULA(CERTIDÃO NOVA)' ,14 ,124 ,'' ,32 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12285 ,742 ,'numero_cpf' ,'NÚMERO DO CPF' ,14 ,156 ,'' ,11 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12286 ,742 ,'documento_estrangeiro_passaporte' ,'DOCUMENTO ESTRANGEIRO/PASSAPORTE' ,14 ,167 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12287 ,742 ,'numero_identificacao_social' ,'NÚMERO DE IDENTIFICÃO SOCIAL' ,14 ,187 ,'' ,11 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12290 ,742 ,'localizacao_zona_residencia' ,'LOCALIZAÇÃO/ZONA DA RESIDÊNCIA' ,14 ,198 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12292 ,742 ,'cep' ,'CEP' ,14 ,199 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12293 ,742 ,'endereco' ,'ENDEREÇO' ,14 ,207 ,'' ,100 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12295 ,742 ,'numero' ,'NÚMERO' ,14 ,307 ,'' ,10 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12296 ,742 ,'complemento' ,'COMPLEMENTO' ,14 ,317 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12298 ,742 ,'bairro' ,'BAIRRO' ,14 ,337 ,'' ,50 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12300 ,742 ,'uf' ,'UF' ,14 ,387 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12302 ,742 ,'municipio' ,'MUNICIPIO' ,14 ,389 ,'' ,7 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12345 ,742 ,'pipe' ,'PIPE' ,14 ,396 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 );

-- Registro 80
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
                    values ( 12305 ,743 ,'tipo_registro' ,'TIPO DE REGISTRO' ,14 ,1 ,'80' ,2 ,'t' ,'t' ,'d' ,'' ,0 ),
                           ( 12307 ,743 ,'codigo_escola_inep' ,'CÓDIGO DA ESCOLA - INEP' ,14 ,3 ,'' ,8 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12308 ,743 ,'identificacao_unica_aluno' ,'IDENTIFICAÇÃO ÚNICA DO ALUNO( INEP )' ,14 ,11 ,'' ,12 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12309 ,743 ,'codigo_aluno_entidade_escola' ,'CÓDIGO DO ALUNO NA ENTIDADE/ESCOLA' ,14 ,23 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12311 ,743 ,'codigo_turma_inep' ,'CÓDIGO DA TURMA NO INEP' ,14 ,43 ,'' ,10 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12312 ,743 ,'codigo_turma_entidade_escola' ,'CÓDIGO DA TURMA NA ENTIDADE/ESCOLA' ,14 ,53 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12314 ,743 ,'codigo_matricula_aluno' ,'CÓDIGO DA MATRÍCULA DO ALUNO' ,14 ,73 ,'' ,12 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12315 ,743 ,'turma_unificada' ,'TURMA UNIFICADA' ,14 ,85 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12317 ,743 ,'codigo_etapa_multi_etapa' ,'ALUNO NA TURMA MULTIETAPA EJA NORMAL/PRO' ,14 ,86 ,'' ,2 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12318 ,743 ,'recebe_escolarizacao_outro_espaco' ,'RECEBE ESCOLARIZAÇÃO EM OUTRO ESPAÇO' ,14 ,88 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12319 ,743 ,'transporte_escolar_publico' ,'TRANSPORTE ESCOLAR PÚBLICO' ,14 ,89 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12321 ,743 ,'poder_publico_transporte_escolar' ,'PODER PÚBLICO RESPONSÁVEL PELO TRANSPORT' ,14 ,90 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12323 ,743 ,'rodoviario_vans_kombi' ,'RODOVIÁRIO - VANS/KOMBI' ,14 ,91 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12324 ,743 ,'rodoviario_microonibus' ,'RODOVIARIO - MICROÔNIBUS' ,14 ,92 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12326 ,743 ,'rodoviario_onibus' ,'RODOVIARIO ÔNIBUS' ,14 ,93 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12327 ,743 ,'rodoviario_bicicleta' ,'RODOVIARIO BICICLETA' ,14 ,94 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12329 ,743 ,'rodoviario_tracao_animal' ,'RODOVIARIO TRAÇÃO ANIMAL' ,14 ,95 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12330 ,743 ,'rodoviario_outro' ,'RODOVIARIO OUTRO' ,14 ,96 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12331 ,743 ,'aquaviario_embarcacao_5_pessoas' ,'AQUAVIARIO EMBARCACAO CAPACIDADE PARA 5' ,14 ,97 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12332 ,743 ,'aquaviario_embarcacao_5_a_15_pessoas' ,'AQUAVIARIO EMBARCACAO CAPACIDADE 5 A 15' ,14 ,98 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12334 ,743 ,'aquaviario_embarcacao_15_a_35_pessoas' ,'AQUAVIARIO EMBARCACAO CAPACIDADE 15 A 35' ,14 ,99 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12335 ,743 ,'aquaviario_embarcacao_mais_de_35_pessoas' ,'AQUAVIARIO EMBARCACAO CAPACIDADE + 35 PE' ,14 ,100 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12337 ,743 ,'ferroviario_trem_metro' ,'FERROVIÁRIO TREM/METRÔ' ,14 ,101 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
                           ( 12338 ,743 ,'forma_ingresso_aluno_escola_federal' ,'FORMA INGRESSO ALUNO ESCOLA FEDERAL' ,14 ,102 ,'' ,2 ,'f' ,'t' ,'d' ,'Forma ingresso do aluno, apenas em escolas federais' ,0 ),
                           ( 12346 ,743 ,'pipe' ,'PIPE' ,14 ,104 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 );



-- Estrutura dicionario de dados
insert into db_sysarquivo
     values (3792, 'mediacaodidaticopedagogica', 'Mediação didatico-pedagógica', 'ed130', '2015-03-23', 'Mediação didatico-pedagógica', 0, 'f', 'f', 'f', 'f' ),
            (3793, 'censoetapamediacaodidaticopedagogica', 'vínculo da etapa do censo com o tipo de mediação didático pedagógica', 'ed131', '2015-03-23', 'censoetapamediacaodidaticopedagogica', 0, 'f', 'f', 'f', 'f' ),
            (3794, 'turmacensoetapa', 'Vínculo da turma com a etapa do censo', 'ed132', '2015-03-23', 'Turma censo etapa', 0, 'f', 'f', 'f', 'f' ),
            (3795, 'seriecensoetapa', 'Vínculo da etapa do e-cidade com a etapa do censo', 'ed133', '2015-03-23', 'Série censo etapa', 0, 'f', 'f', 'f', 'f' ),
            (3796, 'censoetapaturmacenso', 'Censo etapa turma censo', 'ed134', '2015-03-23', 'Censo etapa turma censo', 0, 'f', 'f', 'f', 'f' );

insert into db_sysarqmod
     values (1008004,3792),
            (1008004,3793),
            (1008004,3794),
            (1008004,3795),
            (1008004,3796);

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
     values (21044,'ed266_ano','int4','Ano','0', 'Ano',10,'f','f','f',1,'text','Ano'),
            ( 21047 ,'ed130_codigo' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' ),
            ( 21048 ,'ed130_descricao' ,'varchar(20)' ,'Descrição' ,'' ,'Decrição' ,25 ,'false' ,'true' ,'false' ,0 ,'text' ,'Decrição' ),
            ( 21052 ,'ed131_censoetapa' ,'int4' ,'Censo Etapa' ,'' ,'Censo Etapa' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Censo Etapa' ),
            ( 21050 ,'ed131_codigo' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' ),
            ( 21051 ,'ed131_mediacaodidaticopedagogica' ,'int4' ,'Mediação didático pedagógica' ,'' ,'Mediação didático pedagógica' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Mediação didático pedagógica' ),
            ( 21053 ,'ed131_ano' ,'int4' ,'Ano de vínculo' ,'' ,'Ano' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Ano' ),
            ( 21056 ,'ed10_mediacaodidaticopedagogica','int4','Mediação didático-pedagógica','0', 'Mediação didático-pedagógica',10,'f','f','f',1,'text','Mediação didático-pedagógica'),
            ( 21058 ,'ed132_codigo' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' ),
            ( 21059 ,'ed132_turma' ,'int4' ,'Vínculo com a turma' ,'' ,'Turma' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Turma' ),
            ( 21060 ,'ed132_censoetapa' ,'int4' ,'Vínculo Censo Etapa' ,'' ,'Censo Etapa' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Censo Etapa' ),
            ( 21061 ,'ed132_ano' ,'int4' ,'Ano' ,'' ,'Ano' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Ano' ),
            ( 21065 ,'ed133_codigo' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' ),
            ( 21066 ,'ed133_serie' ,'int4' ,'Etapa' ,'' ,'Etapa' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Etapa' ),
            ( 21067 ,'ed133_censoetapa' ,'int4' ,'Etapa do Censo' ,'' ,'Etapa do Censo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Etapa do Censo' ),
            ( 21068 ,'ed133_ano' ,'int4' ,'Ano' ,'' ,'Ano' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Ano' ),
            ( 21071 ,'ed134_codigo' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' ),
            ( 21072 ,'ed134_turmacenso' ,'int4' ,'Turma censo' ,'' ,'Turma censo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Turma censo' ),
            ( 21073 ,'ed134_censoetapa' ,'int4' ,'Etapa Censo' ,'' ,'Etapa Censo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Etapa Censo' ),
            ( 21074 ,'ed134_ano' ,'int4' ,'Ano de vínculo' ,'' ,'Ano' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Ano' ),
            ( 21111 ,'ed272_ano','int4','Ano da censoetapa','0', 'Ano',10,'f','f','f',1,'text','Ano'),
            ( 21121 ,'ed131_regular','varchar(1)','Identifica se etapa é da modalidade de ensino : Ensino Regular S - Sim N - Não','N', 'Regular',1,'f','t','f',0,'text','Regular'),
            ( 21122 ,'ed131_especial','char(1)','Identifica se etapa é da modalidade de ensino : Educação Especial S - Sim N - Não','N', 'Especial',1,'f','t','f',0,'text','Especial'),
            ( 21123 ,'ed131_eja','char(1)','Identifica se etapa é da modalidade de ensino : Educação de Jovens e Adultos S - Sim N - Não','N', 'EJA',1,'f','t','f',0,'text','EJA'),
            ( 21124 ,'ed131_profissional','char(1)','Identifica se etapa é da modalidade de ensino : Educação Profissional S - Sim N - Não','N', 'Profissional',1,'f','t','f',0,'text','Profissional');

insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia )
     values ( 2413,    21044, 7, 0 ),
            ( 3792,    21047, 1 ,0 ),
            ( 3792,    21048, 2 ,0 ),
            ( 3793,    21050, 1 ,0 ),
            ( 3793,    21051, 2 ,0 ),
            ( 3793,    21052, 3 ,0 ),
            ( 3793,    21053, 4 ,0 ),
            ( 1010045, 21056, 6 ,0 ),
            ( 3794,    21058, 1 ,0 ),
            ( 3794,    21059, 2 ,0 ),
            ( 3794,    21060, 3 ,0 ),
            ( 3794,    21061, 4 ,0 ),
            ( 3795,    21065, 1 ,0 ),
            ( 3795,    21066, 2 ,0 ),
            ( 3795,    21067, 3 ,0 ),
            ( 3795,    21068, 4 ,0 ),
            ( 3796,    21071, 1 ,0 ),
            ( 3796,    21072, 2 ,0 ),
            ( 3796,    21073, 3 ,0 ),
            ( 3796,    21074, 4 ,0 ),
            ( 2457,    21111, 4, 0 ),
            ( 3793,    21121, 5, 0 ),
            ( 3793,    21122, 6, 0 ),
            ( 3793,    21123, 7, 0 ),
            ( 3793,    21124, 8, 0 );

insert into db_sysprikey (codarq,codcam,sequen,camiden)
     values (3792, 21047, 1, 21048),
            (3793, 21050, 1, 21050),
            (3794, 21058, 1, 21058),
            (3795, 21065, 1, 21065),
            (3796, 21071, 1, 21071);

insert into db_sysforkey
     values ( 3793, 21052,1,2413,0),
            ( 3793, 21053,2,2413,0),
            ( 3793, 21051,1,3792,0),
            ( 1010045, 21056,1,3792,0),
            ( 3794, 21059,1,1010083,0),
            ( 3794, 21060,1,2413,0),
            ( 3794, 21061,2,2413,0),
            ( 3795, 21066,1,1010047,0),
            ( 3795, 21067,1,2413,0),
            ( 3795, 21068,2,2413,0),
            ( 3796, 21072,1,3703,0),
            ( 3796, 21073,1,2413,0),
            ( 3796, 21074,2,2413,0);

insert into db_sysindices
     values (4183,'censoetapamediacaodidaticopedagogica_mediacaodidaticopedagogica_in',3793,'0'),
            (4184,'censoetapamediacaodidaticopedagogica_censoetapa_in',3793,'0'),
            (4185,'turmacensoetapa_turma_in',3794,'0'),
            (4186,'turmacensoetapa_censoetapa_in',3794,'0'),
            (4187,'seriecensoetapa_serie_in',3795,'0'),
            (4188,'seriecensoetapa_censoetapa_in',3795,'0'),
            (4189,'censoetapaturmacenso_turmacenso_in',3796,'0'),
            (4190,'censoetapaturmacenso_censoetapa_in',3796,'0');

insert into db_syscadind
     values (4183, 21051, 1),
            (4184, 21052, 1),
            (4185, 21059, 1),
            (4186, 21060, 1),
            (4187, 21066, 1),
            (4188, 21067, 1),
            (4189, 21072, 1),
            (4190, 21073, 1);

insert into db_syssequencia
     values (1000447, 'mediacaodidaticopedagogica_ed130_codigo_seq', 1, 1, 9223372036854775807, 1, 1),
            (1000448, 'censoetapamediacaodidaticopedagogica_ed131_codigo_seq', 1, 1, 9223372036854775807, 1, 1),
            (1000449, 'turmacensoetapa_ed132_codigo_seq', 1, 1, 9223372036854775807, 1, 1),
            (1000450, 'seriecensoetapa_ed133_codigo_seq', 1, 1, 9223372036854775807, 1, 1),
            (1000451, 'censoetapaturmacenso_ed134_codigo_seq', 1, 1, 9223372036854775807, 1, 1);

update db_sysarqcamp set codsequencia = 1000447 where codarq = 3792 and codcam = 21047;
update db_sysarqcamp set codsequencia = 1000448 where codarq = 3793 and codcam = 21050;
update db_sysarqcamp set codsequencia = 1000449 where codarq = 3794 and codcam = 21058;
update db_sysarqcamp set codsequencia = 1000450 where codarq = 3795 and codcam = 21065;
update db_sysarqcamp set codsequencia = 1000451 where codarq = 3796 and codcam = 21071;

update db_syscampo set nomecam = 'ed57_i_censoetapa', conteudo = 'int8', descricao = 'Etapa Censo', valorinicial = 'null', rotulo = 'Etapa Censo', nulo = 't', tamanho = 20, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Etapa Censo' where codcam = 15221;
update db_syscampo set nomecam = 'ed11_i_codcenso', conteudo = 'int4', descricao = 'Código Censo', valorinicial = 'null', rotulo = 'Código Censo', nulo = 't', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Código Censo' where codcam = 13786;
update db_syscampo set nomecam = 'ed266_c_regular', conteudo = 'char(1)', descricao = 'Regular', valorinicial = 'null', rotulo = 'Regular', nulo = 't', tamanho = 1, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Regular' where codcam = 13782;
update db_syscampo set nomecam = 'ed266_c_especial', conteudo = 'char(1)', descricao = 'Especial', valorinicial = 'null', rotulo = 'Especial', nulo = 't', tamanho = 1, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Especial' where codcam = 13783;
update db_syscampo set nomecam = 'ed266_c_eja', conteudo = 'char(1)', descricao = 'EJA', valorinicial = 'null', rotulo = 'EJA', nulo = 't', tamanho = 1, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'EJA' where codcam = 13784;
update db_syscampo set nulo = 't', aceitatipo = 1 where codcam = 20583;

delete from db_sysforkey  where codarq = 1010083 and referen = 2413;
delete from db_sysforkey  where codarq = 1010047 and referen = 2413;
delete from db_sysforkey  where codarq = 3703    and referen = 2413;
delete from db_sysindices where codind = 4063;


delete from db_sysprikey where codarq = 2413;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(2413,13780,1,13780);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(2413,21044,2,13780);

delete from db_sysforkey where codarq = 2457;
insert into db_sysforkey values(2457,13992,2,2413,0);
insert into db_sysforkey values(2457,21111,3,2413,0);

insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso )
  values ( 3000579 ,3000010 ,'Impressora Multifuncional' ,'equipamentos_impressora_multifuncional' ,'t' ,0 );

update db_syscampo set rotulo = 'Caráter Reprobatório', rotulorel = 'Caráter Reprobatório', descricao = 'Define se disciplina possui Caráter Reprobatório' where codcam = 20657;
update db_syscampo set rotulo = 'Caráter Reprobatório', rotulorel = 'Caráter Reprobatório', descricao = 'Define se regência possui Caráter Reprobatório' where codcam = 20661;



insert into avaliacaoperguntaopcaolayoutcampo( ed313_sequencial ,ed313_ano ,ed313_db_layoutcampo ,ed313_avaliacaoperguntaopcao ,ed313_layoutvalorcampo )
     values ( 847 ,2015 ,12170 ,3000039 ,'0' ),
            ( 848 ,2015 ,12172 ,3000040 ,'0' ),
            ( 849 ,2015 ,12174 ,3000041 ,'0' ),
            ( 850 ,2015 ,12176 ,3000042 ,'0' ),
            ( 851 ,2015 ,12178 ,3000043 ,'0' ),
            ( 852 ,2015 ,12181 ,3000044 ,'0' ),
            ( 853 ,2015 ,12183 ,3000045 ,'0' ),
            ( 854 ,2015 ,12185 ,3000560 ,'0' ),
            ( 855 ,2015 ,12187 ,3000046 ,'0' ),
            ( 856 ,2015 ,12189 ,3000047 ,'1' ),
            ( 857 ,2015 ,12189 ,3000048 ,'2' ),
            ( 858 ,2015 ,12189 ,3000049 ,'3' ),
            ( 859 ,2015 ,12191 ,3000097 ,'1' ),
            ( 860 ,2015 ,12191 ,3000098 ,'0' ),
            ( 861 ,2015 ,12193 ,3000571 ,'' ),
            ( 862 ,2015 ,12195 ,3000572 ,'' ),
            ( 863 ,2015 ,12197 ,3000576 ,'' ),
            ( 864 ,2015 ,12198 ,3000573 ,'' ),
            ( 865 ,2015 ,12201 ,3000574 ,'' ),
            ( 866 ,2015 ,12206 ,3000575 ,'' ),
            ( 867 ,2015 ,12209 ,3000099 ,'0' ),
            ( 868 ,2015 ,12209 ,3000100 ,'1' ),
            ( 869 ,2015 ,12214 ,3000088 ,'0' ),
            ( 871 ,2015 ,12218 ,3000089 ,'0' ),
            ( 872 ,2015 ,12223 ,3000090 ,'0' ),
            ( 873 ,2015 ,12228 ,3000091 ,'0' ),
            ( 874 ,2015 ,12231 ,3000092 ,'0' ),
            ( 875 ,2015 ,12234 ,3000093 ,'0' ),
            ( 876 ,2015 ,12237 ,3000094 ,'0' ),
            ( 877 ,2015 ,12241 ,3000095 ,'0' ),
            ( 878 ,2015 ,12245 ,3000096 ,'0' ),
            ( 879 ,2015 ,12247 ,3000050 ,'0' ),
            ( 880 ,2015 ,12248 ,3000051 ,'0' ),
            ( 881 ,2015 ,12250 ,3000052 ,'0' ),
            ( 882 ,2015 ,12255 ,3000067 ,'0' ),
            ( 883 ,2015 ,12257 ,3000068 ,'0' ),
            ( 884 ,2015 ,12260 ,3000069 ,'0' ),
            ( 885 ,2015 ,12262 ,3000070 ,'0' ),
            ( 886 ,2015 ,12264 ,3000071 ,'0' ),
            ( 887 ,2015 ,12266 ,3000072 ,'0' ),
            ( 888 ,2015 ,12269 ,3000000 ,'0' ),
            ( 889 ,2015 ,12275 ,3000001 ,'0' ),
            ( 890 ,2015 ,12277 ,3000017 ,'0' ),
            ( 891 ,2015 ,12281 ,3000002 ,'0' ),
            ( 892 ,2015 ,12284 ,3000003 ,'0' ),
            ( 893 ,2015 ,12288 ,3000004 ,'0' ),
            ( 894 ,2015 ,12289 ,3000005 ,'0' ),
            ( 895 ,2015 ,12291 ,3000006 ,'0' ),
            ( 896 ,2015 ,12294 ,3000007 ,'0' ),
            ( 897 ,2015 ,12297 ,3000008 ,'0' ),
            ( 898 ,2015 ,12299 ,3000009 ,'0' ),
            ( 899 ,2015 ,12301 ,3000010 ,'0' ),
            ( 900 ,2015 ,12303 ,3000011 ,'0' ),
            ( 901 ,2015 ,12304 ,3000012 ,'0' ),
            ( 902 ,2015 ,12306 ,3000013 ,'0' ),
            ( 903 ,2015 ,12310 ,3000014 ,'0' ),
            ( 904 ,2015 ,12313 ,3000015 ,'0' ),
            ( 905 ,2015 ,12316 ,3000126 ,'0' ),
            ( 906 ,2015 ,12320 ,3000018 ,'0' ),
            ( 907 ,2015 ,12322 ,3000019 ,'0' ),
            ( 908 ,2015 ,12325 ,3000020 ,'0' ),
            ( 909 ,2015 ,12328 ,3000021 ,'0' ),
            ( 910 ,2015 ,12333 ,3000022 ,'0' ),
            ( 911 ,2015 ,12336 ,3000023 ,'0' ),
            ( 912 ,2015 ,12339 ,3000024 ,'0' ),
            ( 913 ,2015 ,12340 ,3000025 ,'0' ),
            ( 914 ,2015 ,12341 ,3000026 ,'0' ),
            ( 915 ,2015 ,12342 ,3000027 ,'0' ),
            ( 916 ,2015 ,12344 ,3000028 ,'0' ),
            ( 917 ,2015 ,12347 ,3000016 ,'0' ),
            ( 918 ,2015 ,12348 ,3000103 ,'' ),
            ( 919 ,2015 ,12349 ,3000104 ,'' ),
            ( 922 ,2015 ,12350 ,3000056 ,'' ),
            ( 923 ,2015 ,12351 ,3000057 ,'' ),
            ( 924 ,2015 ,12352 ,3000058 ,'' ),
            ( 925 ,2015 ,12353 ,3000059 ,'' ),
            ( 926 ,2015 ,12354 ,3000060 ,'' ),
            ( 927 ,2015 ,12355 ,3000061 ,'' ),
            ( 928 ,2015 ,12356 ,3000062 ,'' ),
            ( 929 ,2015 ,12357 ,3000063 ,'' ),
            ( 930 ,2015 ,12358 ,3000064 ,'' ),
            ( 931 ,2015 ,12359 ,3000065 ,'' ),
            ( 932 ,2015 ,12360 ,3000066 ,'' ),
            ( 933 ,2015 ,12361 ,3000032 ,'' ),
            ( 934 ,2015 ,12362 ,3000579 ,'' ),
            ( 935 ,2015 ,12363 ,3000033 ,'' ),
            ( 936 ,2015 ,12364 ,3000113 ,'' ),
            ( 937 ,2015 ,12365 ,3000035 ,'1' ),
            ( 938 ,2015 ,12365 ,3000036 ,'0' ),
            ( 939 ,2015 ,12366 ,3000037 ,'1' ),
            ( 940 ,2015 ,12366 ,3000038 ,'0' ),
            ( 941 ,2015 ,12368 ,3000101 ,'1' ),
            ( 942 ,2015 ,12368 ,3000102 ,'0' ),
            ( 943 ,2015 ,12369 ,3000108 ,'1' ),
            ( 944 ,2015 ,12369 ,3000109 ,'2' ),
            ( 945 ,2015 ,12369 ,3000110 ,'0' ),
            ( 946 ,2015 ,12370 ,3000105 ,'1' ),
            ( 947 ,2015 ,12370 ,3000106 ,'0' ),
            ( 948 ,2015 ,12370 ,3000107 ,'2' ),
            ( 949 ,2015 ,12375 ,3000111 ,'0' ),
            ( 950 ,2015 ,12375 ,3000112 ,'1' ),
            ( 951 ,2015 ,12377 ,3000053 ,'0' ),
            ( 952 ,2015 ,12378 ,3000054 ,'0' ),
            ( 953 ,2015 ,12379 ,3000055 ,'0' ),
            ( 954 ,2015 ,12384 ,3000122 ,'1' ),
            ( 955 ,2015 ,12384 ,3000123 ,'0' ),
            ( 956 ,2015 ,12385 ,3000124 ,'1' ),
            ( 957 ,2015 ,12385 ,3000125 ,'0' ),
            ( 958 ,2015 ,12386 ,3000561 ,'1' ),
            ( 959 ,2015 ,12386 ,3000562 ,'0' );


-- tipohoratrabalho
delete from db_sysarqcamp  where codcam = 21032;
delete from db_syscampodef where codcam = 21032;
delete from db_sysforkey   where codarq = 3789 and referen = 1010031;
delete from db_sysindices  where codind in (4171, 4170);
delete from db_syscadind   where codind in (4171, 4170);

insert into db_sysindices
     values (4202,'tipohoratrabalho_descricao_in',3789,'1'),
            (4203,'tipohoratrabalho_abreviatura_in',3789,'0');

insert into db_syscadind values(4202,21028,1);
insert into db_syscadind values(4203,21029,1);
delete from db_syscampo where codcam = 21032;
update db_menu set modulo = 7159 where id_item_filho = 10054 AND modulo = 1100747;


-- tamanho nome
update db_syscampo set nomecam = 'z01_v_nome',  conteudo = 'varchar(255)', tamanho = 255 where codcam = 1008845;
update db_syscampo set nomecam = 'z01_v_mae',   conteudo = 'varchar(255)', tamanho = 255 where codcam = 11248;
update db_syscampo set nomecam = 'z01_c_pis',   conteudo = 'char(11)',     tamanho = 11  where codcam = 11654;
update db_syscampo set nomecam = 's128_v_nome', conteudo = 'varchar(255)', tamanho = 255 where codcam = 15475;
update db_syscampo set nomecam = 'z01_v_email', conteudo = 'varchar(255)', tamanho = 255 where codcam = 1008858;
delete from db_syscampodef where codcam = 1008858;

-- campo cnpj na unidade
insert into db_syscampo values(21136,'sd02_cnpjcpf','varchar(14)','CNPJ/CPF da unidade','', 'CNPJ/CPF',14,'t','f','f',1,'text','CNPJ/CPF');
insert into db_sysarqcamp values(100011,21136,26,0);

-- consulta pedido tfd
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente )
     values ( 10062 ,'Pedido TFD' ,'Pedido TFD' ,'tfd3_consultapedidotfd001.php' ,'1' ,'1' ,'Consulta do pedido tfd' ,'true' );
delete from db_menu where id_item_filho = 10062 AND modulo = 8322;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8172 ,10062 ,2 ,8322 );

-- Ajustado label dos campos do cadastro de UPS
update db_syscampo set nomecam = 'sd02_i_cidade', conteudo = 'int4', descricao = 'Código da Cidade IBGE', valorinicial = '0', rotulo = 'Cód. IBGE', nulo = 't', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Cód. IBGE' where codcam = 100046;
update db_syscampo set nomecam = 'sd02_i_regiao', conteudo = 'int4', descricao = 'Código da região da Unidade', valorinicial = '0', rotulo = 'Cód. Região', nulo = 't', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Cód. Região' where codcam = 100045;
update db_syscampo set nomecam = 'sd02_i_distrito', conteudo = 'int4', descricao = 'Código do distrito da Unidade', valorinicial = '0', rotulo = 'Cód. Distrito', nulo = 't', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Cód. Distrito' where codcam = 100044;
update db_syscampo set nomecam = 'sd02_v_microreg', conteudo = 'varchar(6)', descricao = 'Código da Microrregião de Saúde', valorinicial = '', rotulo = 'Microrregião', nulo = 't', tamanho = 6, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Microrregião' where codcam = 11390;
update db_syscampo set nomecam = 'sd02_v_distadmin', conteudo = 'varchar(4)', descricao = 'Código do Módulo Assistencial (Conforme o plano Diretor de Regionalização do Estado/Município).', valorinicial = '', rotulo = 'Módulo Assistencial', nulo = 't', tamanho = 4, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Módulo Assistencial' where codcam = 11392;

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10063 ,'Relatório de Viagens' ,'Relatório de Viagens' ,'tfd2_relatorioviagens001.php' ,'1' ,'1' ,'Formulário para impressão do relatório de viagens' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8324 ,10063 ,6 ,8322 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10064 ,'Veículos TFD' ,'Veículos TFD' ,'tfd3_veiculostfd001.php' ,'1' ,'1' ,'Consulta contendo as vagas dos veículos do TFD' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8172 ,10064 ,3 ,8322 );

insert into db_syscampo values(21140,'ed33_horaatividade','bool','Mostra se as hora do professor é uma atividade ou hora aula.','f', 'Hora de Atividade',1,'f','f','f',5,'text','Hora de Atividade');
insert into db_sysarqcamp values(1010091,21140,7,0);

------------------------------------------------------------------------------------
----------------------------- FIM  TIME C ------------------------------------------
------------------------------------------------------------------------------------

-------------------------------
------ INÍCIO TIME FOLHA ------
-------------------------------
--Alterando layout dos campos de valores dos arquivos de retorno e de margem para o consignet
update db_layoutcampos set db52_layoutformat = 2 where db52_codigo = 11961;
update db_layoutcampos set db52_layoutformat = 2 where db52_codigo = 11962;
update db_layoutcampos set db52_layoutformat = 2 where db52_codigo = 11942;

--Alterando tabela rhpreponto para poder relacionar, criando campo, sequencia e chave primária
insert into db_syscampo values(21107,'rh149_sequencial','int4','Sequencial da tabela será a chave única.','0', 'Sequencial da tabela',19,'f','f','f',1,'text','Sequencial da tabela');
insert into db_syscampo values(21132,'rh149_competencia','varchar(7)','Campo para armazenar a competencia das rubricas que possuem data limite.','', 'Competência',7,'t','t','f',0,'text','Competência');
delete from db_sysarqcamp where codarq = 3766;
insert into db_sysarqcamp values(3766,21107,1,0);
insert into db_sysarqcamp values(3766,20923,2,0);
insert into db_sysarqcamp values(3766,20924,3,0);
insert into db_sysarqcamp values(3766,20925,4,0);
insert into db_sysarqcamp values(3766,20926,5,0);
insert into db_sysarqcamp values(3766,20927,6,0);
insert into db_sysarqcamp values(3766,20928,7,0);
insert into db_sysarqcamp values(3766,21132,8,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3766,21107,1,21107);
insert into db_syssequencia values(1000455, 'rhpreponto_rh149_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000455 where codarq = 3766 and codcam = 21107;

--Inserindo tabelas no dicionário de dados
insert into db_sysarquivo values (3798, 'loteregistroponto', 'Tabela para consolidar os lotes de registros a serem incluídos no ponto dos servidores.', 'rh155', '2015-03-23', '', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (28,3798);
insert into db_sysarquivo values (3801, 'rhprepontoloteregistroponto', 'Tabela relacional para ligar a tabela rhpreponto com a tabela de lote de registros do ponto.', 'rh156', '2015-03-24', '', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (28,3801);
insert into db_sysarquivo values (3804, 'db_usuariosrhlota', 'Tabela utilizada para relacionar usuários a lotação.', 'rh157', '2015-04-09', 'Relaciona Usuarios a lotação', 0, 'f', 't', 'f', 't' );
insert into db_sysarqmod values (28,3804);

--Inserindo campos nas tabelas do dicionário de dados
insert into db_syscampo values(21089,'rh155_sequencial','int4','Campo sequencial para guardar sequencia de lotes criados.','0', '',19,'f','f','f',1,'text','');
insert into db_syscampo values(21091,'rh155_descricao','varchar(255)','Campo para informar o nome do lote que se está gerando.','', 'Descrição',255,'f','t','f',0,'text','Descrição');
insert into db_syscampo values(21095,'rh155_ano','int4','Ano da competência que se gera um lote.','0', 'Competência',4,'f','f','f',1,'text','Competência');
insert into db_syscampo values(21097,'rh155_mes','int4','Mês da competência que se está gerando um lote.','0', 'Mês da Competência',2,'f','f','f',1,'text','Mês da Competência');
insert into db_syscampo values(21100,'rh155_situacao','char(1)','Campo que guarda o status de um lote. A-Aberto, F-Fechado, C-Confirmado','', 'Situação',1,'f','t','f',0,'text','Situação');
insert into db_syscampo values(21125,'rh155_instit','int4','Instituição do lote de registros','0', 'Instituição',10,'f','f','f',1,'text','Instituição');
insert into db_syscampo values(21126,'rh155_usuario','int4','Usuario que criou o lote de registros do ponto.','0', 'Usuario',19,'f','f','f',1,'text','Usuario');
insert into db_syscampo values(21114,'rh156_sequencial','int4','Sequencial para chave única da tabela.','0', 'Sequencial da tabela',19,'f','f','f',1,'text','Sequencial da tabela');
insert into db_syscampo values(21116,'rh156_rhpreponto','int4','Chave com a tabela preponto','0', 'rhpreponto',19,'f','f','f',1,'text','rhpreponto');
insert into db_syscampo values(21117,'rh156_loteregistroponto','int4','Chave com a tabela loteregistroponto','0', 'loteregistroponto',19,'f','f','f',1,'text','loteregistroponto');
insert into db_syscampo values(21129,'rh157_usuario','int4','Campo para chave estrangeira da tabela db_usuarios.','0', 'Usuário',19,'f','f','f',1,'text','Usuário');
insert into db_syscampo values(21130,'rh157_lotacao','int4','Campo para vincular uma lotação ao usuário, chave estrangeira com a tabela rhlota.','0', 'Lotação do Usuário',19,'f','f','f',1,'text','Lotação do Usuário');
insert into db_syscampo values(21131,'rh157_sequencial','int4','Campo sequencial que servirá de chave primária para a tabela relacional.','0', 'Chave Primária',19,'f','f','f',1,'text','Chave Primária');
--Alterando tipo de dados da coluna de valor na tabela rhpreponto
update db_syscampo set nomecam = 'rh149_valor', conteudo = 'float8', descricao = 'Valor da Rubrica', valorinicial = '0', rotulo = 'Valor', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 4, tipoobj = 'text', rotulorel = 'Valor' where codcam = 20926;

--Inserindo valor default para o campo
insert into db_syscampodef values(21100,'A','Aberto');

--Vinculando os campos à tabela
insert into db_sysarqcamp values(3798,21089,1,0);
insert into db_sysarqcamp values(3798,21091,2,0);
insert into db_sysarqcamp values(3798,21095,3,0);
insert into db_sysarqcamp values(3798,21097,4,0);
insert into db_sysarqcamp values(3798,21100,5,0);
insert into db_sysarqcamp values(3798,21125,6,0);
insert into db_sysarqcamp values(3798,21126,7,0);
insert into db_sysarqcamp values(3801,21114,1,0);
insert into db_sysarqcamp values(3801,21116,2,0);
insert into db_sysarqcamp values(3801,21117,3,0);
insert into db_sysarqcamp values(3804,21131,1,0);
insert into db_sysarqcamp values(3804,21129,2,0);
insert into db_sysarqcamp values(3804,21130,3,0);

--Inserindo sequencia à tabela e vinculando ao campo respectivo
insert into db_syssequencia values(1000452, 'loteregistroponto_rh155_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
insert into db_syssequencia values(1000457, 'rhprepontoloteregistroponto_rh156_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
insert into db_syssequencia values(1000461, 'db_usuariosrhlota_rh157_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000452 where codarq = 3798 and codcam = 21089;
update db_sysarqcamp set codsequencia = 1000457 where codarq = 3801 and codcam = 21114;
update db_sysarqcamp set codsequencia = 1000461 where codarq = 3804 and codcam = 21131;

--Inserindo chave primária da tabela
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3798,21089,1,21089);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3801,21114,1,21114);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3804,21131,1,21131);

--Inserindo índices e vinculando à tabela
insert into db_sysindices values(4191,'loteregistroponto_sequencial_in',3798,'0');
insert into db_sysindices values(4197,'rhprepontoloteregistroponto_sequencial_in',3801,'0');
insert into db_sysindices values(4205,'db_usuariosrhlota_usuario_lotacao_in',3804,'1');
insert into db_syscadind values(4191,21089,1);
insert into db_syscadind values(4197,21114,1);
insert into db_syscadind values(4205,21129,1);
insert into db_syscadind values(4205,21130,2);

--Inserindo chave estrangeira na tabela
insert into db_sysforkey values(3801,21116,1,3766,0);
insert into db_sysforkey values(3801,21117,1,3798,0);
insert into db_sysforkey values(3798,21125,1,83,0);
insert into db_sysforkey values(3798,21126,1,109,0);
insert into db_sysforkey values(3804,21129,1,109,0);
insert into db_sysforkey values(3804,21130,1,894,0);

----------- Menus para a rotina de processamento de registros do ponto em lote -----------------
--Cria itens de menu
insert into db_itensmenu values(10059, 'Registros do Ponto em Lote', 'Lançar rubricas em lote', '', '1', '1', 'Menu para lançamento de rúbricas em lote, lançamento pode ser feito por rúbrica ou por servidor.', 'false'  );
insert into db_itensmenu values(10060, 'Manutenção do Lote', 'Manutenção do Lote', 'pes4_manutencaolotesinicio001.php', '1', '1', 'Menu para criar e fechar lotes e lancar, alterar e excluir registros de um lote. Registro seria um lançamento do ponto.', 'false' );
insert into db_itensmenu values(10061, 'Processar Lote', 'Processar Lote', 'pes4_processamento_loteregistroponto.php', '1', '1', 'Menu utilizado para confirmar, cancelar, excluir um lote de registros do ponto.', 'false' );
--Vincúla os itens de menu ao menu
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1818 ,10059 ,106 ,952 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10059 ,10060 ,1 ,952 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10059 ,10061 ,2 ,952 );
-------------------------------
------- FIM TIME FOLHA --------
-------------------------------



------------------------------------------------------------------------------------
------------------------------ TRIBUTARIO ------------------------------------------
------------------------------------------------------------------------------------
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10056 ,'Processamento Arquivo Retenção' ,'Processamento de Arquivo de Retenção' ,'' ,'1' ,'1' ,'Processamento de Arquivo de Retenção de ISSQN' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 32 ,10056 ,454 ,40 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10057 ,'Importação do Arquivo de Retorno' ,'Importação do Arquivo de Retorno' ,'iss4_importaarquivoretencao001.php' ,'1' ,'1' ,'Importação do Arquivo de Retorno do banco com os débitos retidos' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10056 ,10057 ,1 ,40 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10058 ,'Processamento do Arquivo de Retorno' ,'Processamento do Arquivo de Retorno' ,'iss4_processaarquivoretencao001.php' ,'1' ,'1' ,'Processamento do Arquivo de Retorno do banco de débitos retidos' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10056 ,10058 ,2 ,40 );

insert into db_sysarquivo values (3791, 'issarquivoretencao', 'Tabela que armazena os dados dos Arquivo de Retenção de ISSQN', 'q90', '2015-03-23', 'Arquivo de Retenção', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (3,3791);
insert into db_syscampo values(21049,'q90_sequencial','int4','Código Arquivo de Retenção de ISSQN','0', 'Código Arquivo de Retenção',10,'f','f','f',1,'text','Código Arquivo de Retenção');
insert into db_syscampo values(21054,'q90_instit','int4','Instituição','0', 'Instituição',10,'f','f','f',1,'text','Instituição');
insert into db_syscampo values(21055,'q90_data','date','Data de Importação','null', 'Data de Importação',10,'f','f','f',0,'text','Data de Importação');
insert into db_syscampo values(21057,'q90_nroremessa','int4','Número da Remessa','0', 'Número da Remessa',6,'f','f','f',1,'text','Número da Remessa');
insert into db_syscampo values(21062,'q90_versao','int4','Versão do Arquivo','0', 'Versão do Arquivo',2,'f','f','f',1,'text','Versão do Arquivo');
insert into db_syscampo values(21063,'q90_numeroremessa','int4','Número da Remessa','0', 'Número da Remessa',6,'f','f','f',1,'text','Número da Remessa');
insert into db_syscampo values(21064,'q90_quantidaderegistro','int4','Quantidade de Linhas do Arquivo','0', 'Quantidade de Linhas',10,'f','f','f',1,'text','Quantidade de Linhas');
insert into db_syscampo values(21069,'q90_valortotal','float8','Valor Total dos Registros','0', 'Valor Total',17,'f','f','f',4,'text','Valor Total');
insert into db_syscampo values(21070,'q90_codigobanco','int4','Código do Banco','0', 'Código do Banco',10,'f','f','f',1,'text','Código do Banco');
insert into db_syscampo values(21075,'q90_oidarquivo ','oid','Arquivo','', 'Arquivo',1,'f','f','f',1,'text','Arquivo');
insert into db_syscampo values(21076,'q90_nomearquivo','varchar(50)','Nome do Arquivo','', 'Nome do Arquivo',50,'f','f','f',0,'text','Nome do Arquivo');
insert into db_sysarqcamp values(3791,21049,1 ,0);
insert into db_sysarqcamp values(3791,21054,2 ,0);
insert into db_sysarqcamp values(3791,21055,3 ,0);
insert into db_sysarqcamp values(3791,21063,4 ,0);
insert into db_sysarqcamp values(3791,21062,5 ,0);
insert into db_sysarqcamp values(3791,21064,6 ,0);
insert into db_sysarqcamp values(3791,21069,7 ,0);
insert into db_sysarqcamp values(3791,21070,8 ,0);
insert into db_sysarqcamp values(3791,21075,9 ,0);
insert into db_sysarqcamp values(3791,21076,10,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3791,21049,1,21063);
insert into db_syssequencia values(1000453, 'issarquivoretencao_q90_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000453 where codarq = 3791 and codcam = 21049;
insert into db_sysindices values(4192,'issarquivoretencao_numeroremessa_in',3791,'1');
insert into db_syscadind values(4192,21063,1);

insert into db_sysarquivo values (3797, 'issarquivoretencaoregistro', 'Registros dos Arquivo Retenção de ISSQN', 'q91', '2015-03-23', 'Registros Arquivo Retenção', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (3,3797);
update db_syscampo set nomecam = 'q91_dataemissaodocumento', conteudo = 'date', descricao = 'Data de Emissão do documento', valorinicial = 'null', rotulo = 'Data de Emissão', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Data de Emissão' where codcam = 21080;
insert into db_syscampo values(21077,'q91_sequencial','int4','Código do Registro do Arquivo de Retenções de ISSQN','0', 'Código do Registro',10,'f','f','f',1,'text','Código do Registro');
insert into db_syscampo values(21078,'q91_issarquivoretencao','int4','Código Arquivo de Retenção de ISSQN','0', 'Código Arquivo de Retenção',10,'f','f','f',1,'text','Código Arquivo de Retenção');
insert into db_syscampo values(21079,'q91_sequencialregistro','int4','Sequencial que indica a posição do registro no arquivo de rentenções','0', 'Sequencial Registro',8,'f','f','f',1,'text','Sequencial Registro');
insert into db_syscampo values(21080,'q91_dataemissaodocumento','date','Data de Emissão do documento','null', 'Data de Emissão',10,'f','f','f',1,'text','Data de Emissão');
insert into db_syscampo values(21081,'q91_datavencimento','date','Data de Vencimento do débito','null', 'Data de Vencimento',10,'f','f','f',0,'text','Data de Vencimento');
insert into db_syscampo values(21082,'q91_numerodocumento','varchar(12)','Número do Documento','', 'Número do Documento',12,'t','t','f',0,'text','Número do Documento');
insert into db_syscampo values(21083,'q91_cnpjtomador','int4','CNPJ do Tomador do Serviço','0', 'CNPJ Tomador',14,'f','f','f',1,'text','CNPJ Tomador');
insert into db_syscampo values(21084,'q91_codigomunicipiotomador','int4','Código do Município do Tomador do Serviço','0', 'Código Município Tomador',6,'f','f','f',1,'text','Código Município Tomador');
insert into db_syscampo values(21085,'q91_cpfcnpjprestador','int4','CPF ou CNPJ Prestador do serviço','0', 'CPF ou CNPJ Prestador',14,'f','f','f',1,'text','CPF ou CNPJ Prestador');
insert into db_syscampo values(21086,'q91_codigomunicipionota','int4','Código do Múnicípio da Nota Fiscal','0', 'Código Múnicípio Nota',6,'f','f','f',1,'text','Código Múnicípio Nota');
insert into db_syscampo values(21087,'q91_esferareceita','varchar(1)','Esfera da Receita','', 'Esfera Receita',1,'f','f','f',2,'text','Esfera Receita');
insert into db_syscampo values(21088,'q91_anousu','int4','Ano','0', 'Ano',4,'f','f','f',1,'text','Ano');
insert into db_syscampo values(21090,'q91_mesusu','int4','Mes','0', 'Mes',02,'f','f','f',1,'text','Mes');
insert into db_syscampo values(21092,'q91_valorprincipal','float8','Valor Principal','0', 'Valor Principal',17,'f','f','f',4,'text','Valor Principal');
insert into db_syscampo values(21093,'q91_valormulta','float8','Valor Multa','0', 'Valor Multa',17,'t','f','f',4,'text','Valor Multa');
insert into db_syscampo values(21094,'q91_valorjuros','float8','Valor Juros','0', 'Valor Juros',17,'t','f','f',4,'text','Valor Juros');
insert into db_syscampo values(21096,'q91_numeronotafiscal','int4','Número da Nota Fiscal','0', 'Nota Fiscal',10,'f','f','f',1,'text','Nota Fiscal');
insert into db_syscampo values(21098,'q91_serienotafiscal','varchar(5)','Serie da Nota Fiscal','', 'Serie Nota Fiscal',5,'f','t','f',0,'text','Serie Nota Fiscal');
insert into db_syscampo values(21099,'q91_subserienotafiscal','int4','Sub-Série da Nota Fiscal','0', 'Sub-Série Nota Fiscal',2,'t','f','f',1,'text','Sub-Série Nota Fiscal');
insert into db_syscampo values(21101,'q91_dataemissaonotafiscal','date','Data de Emissão da Nota Fiscal','null', 'Data Emissão Nota Fiscal',10,'f','f','f',0,'text','Data Emissão Nota Fiscal');
insert into db_syscampo values(21102,'q91_valornotafiscal','float8','Valor da Nota Fiscal','0', 'Valor Nota Fiscal',17,'f','f','f',4,'text','Valor Nota Fiscal');
insert into db_syscampo values(21103,'q91_aliquota','float8','Aliquota do Serviço','0', 'Aliquota',5,'f','f','f',4,'text','Aliquota');
insert into db_syscampo values(21104,'q91_valorbasecalculo','float8','Valor Base de Cálculo','0', 'Valor Base Cálculo',17,'f','f','f',4,'text','Valor Base Cálculo');
insert into db_syscampo values(21105,'q91_observacao','text','Observações','', 'Observações',234,'f','f','f',0,'text','Observações');
insert into db_syscampo values(21106,'q91_codigomunicipiofavorecido','int4','Código do Município Favorecido','0', 'Código Município Favorecido',6,'f','f','f',1,'text','Código Município Favorecido');
insert into db_sysarqcamp values(3797,21077,1,0);
insert into db_sysarqcamp values(3797,21078,2,0);
insert into db_sysarqcamp values(3797,21079,3,0);
insert into db_sysarqcamp values(3797,21080,4,0);
insert into db_sysarqcamp values(3797,21081,5,0);
insert into db_sysarqcamp values(3797,21082,6,0);
insert into db_sysarqcamp values(3797,21083,7,0);
insert into db_sysarqcamp values(3797,21084,8,0);
insert into db_sysarqcamp values(3797,21085,9,0);
insert into db_sysarqcamp values(3797,21086,10,0);
insert into db_sysarqcamp values(3797,21087,11,0);
insert into db_sysarqcamp values(3797,21088,12,0);
insert into db_sysarqcamp values(3797,21090,13,0);
insert into db_sysarqcamp values(3797,21092,14,0);
insert into db_sysarqcamp values(3797,21093,15,0);
insert into db_sysarqcamp values(3797,21094,16,0);
insert into db_sysarqcamp values(3797,21096,17,0);
insert into db_sysarqcamp values(3797,21098,18,0);
insert into db_sysarqcamp values(3797,21099,19,0);
insert into db_sysarqcamp values(3797,21101,20,0);
insert into db_sysarqcamp values(3797,21102,21,0);
insert into db_sysarqcamp values(3797,21103,22,0);
insert into db_sysarqcamp values(3797,21104,23,0);
insert into db_sysarqcamp values(3797,21105,24,0);
insert into db_sysarqcamp values(3797,21106,25,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3797,21077,1,21096);
insert into db_sysforkey values(3797,21078,1,3791,0);
insert into db_syssequencia values(1000454, 'issarquivoretencaoregistro_q91_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000454 where codarq = 3797 and codcam = 21077;
insert into db_sysindices values(4201,'issarquivoretencaoregistro_issarquivoretencao_sequencialregistro_in',3797,'1');

insert into db_sysarquivo values (3799, 'issarquivoretencaoregistrodisbanco', 'Vínculo entre o Arquivo de Retenção e o Disbanco', 'q94', '2015-03-24', 'Arquivo de Retenção Disbanco', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (3,3799);
insert into db_syscampo values(21108,'q94_sequencial','int4','Sequencial do vínculo entre o Arquivo de Retenção e Disbanco','0', 'Sequencial',10,'f','f','f',1,'text','Sequencial');
insert into db_syscampo values(21109,'q94_issarquivoretencaoregistro','int4','Código do Registro do Arquivo de Retencão','0', 'Código Registro Retencão',10,'f','f','f',1,'text','Código Registro Retencão');
insert into db_syscampo values(21110,'q94_disbanco','int4','Código do Disbanco','0', 'Código Disbanco',10,'f','f','f',1,'text','Código Disbanco');
insert into db_sysarqcamp values(3799,21108,1,0);
insert into db_sysarqcamp values(3799,21109,2,0);
insert into db_sysarqcamp values(3799,21110,3,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3799,21108,1,21109);
insert into db_sysforkey values(3799,21109,1,3797,0);
insert into db_sysforkey values(3799,21110,1,214,0);
insert into db_sysindices values(4193,'issarquivoretencaoregistrodisbanco_issarquivoretencaoregistro_in',3799,'0');
insert into db_syscadind values(4193,21109,1);
insert into db_sysindices values(4194,'issarquivoretencaoregistrodisbanco_disbanco_in',3799,'0');
insert into db_syscadind values(4194,21110,1);
insert into db_syssequencia values(1000456, 'issarquivoretencaoregistrodisbanco_q94_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000456 where codarq = 3799 and codcam = 21108;

insert into db_sysarquivo values (3800, 'issarquivoretencaoregistroissbase', 'Vínculo entre os registros do arquivo de retenção e issbase', 'q128', '2015-03-24', 'Registro Retenção ISSBase', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (3,3800);
insert into db_syscampo values(21112,'q128_sequencial','int4','Código do vículo entro o Registro do Arquivo de Retencão e ISSBase','0', 'Código Registro Retencão ISSBase',10,'f','f','f',1,'text','Código Registro Retencão ISSBase');
insert into db_syscampo values(21113,'q128_inscr','int4','Inscrição do Contribuinte','0', 'Inscrição',10,'f','f','f',1,'text','Inscrição');
insert into db_syscampo values(21115,'q128_issarquivoretencaoregistro','int4','Código do Registro do Arquivo de Retencão','0', 'Código Registro Retencão',10,'f','f','f',1,'text','Código Registro Retencão');
insert into db_sysarqcamp values(3800,21112,1,0);
insert into db_sysarqcamp values(3800,21113,2,0);
insert into db_sysarqcamp values(3800,21115,3,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3800,21112,1,21112);
insert into db_sysforkey values(3800,21113,1,41,0);
insert into db_sysforkey values(3800,21115,1,3797,0);
insert into db_sysindices values(4195,'issarquivoretencaoregistroissbase_inscr_in',3800,'0');
insert into db_syscadind values(4195,21113,1);
insert into db_sysindices values(4196,'issarquivoretencaoregistroissbase_issarquivoretencaoregistro_in',3800,'0');
insert into db_syscadind values(4196,21115,1);
insert into db_syssequencia values(1000458, 'issarquivoretencaoregistroissbase_q128_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000458 where codarq = 3800 and codcam = 21112;

insert into db_sysarquivo values (3802, 'issarquivoretencaoregistroissplan', 'Tabela de Vínculo entre os Registros dos Arquivos de Retenção e Issplan', 'q137', '2015-03-24', 'Arquivo Retenção Issplan', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (3,3802);
insert into db_syscampo values(21118,'q137_sequencial','int4','Código do vículo entre Registro do Arquivo de Retencão e ISSPlan','0', 'Código Registro Retencão ISSPlan',10,'f','f','f',1,'text','Código Registro Retencão ISSPlan');
insert into db_syscampo values(21119,'q137_issplan','int4','Planilha vinculada ao Registro do Arquivo de Retenção','0', 'Planilha',10,'f','f','f',1,'text','Planilha');
insert into db_syscampo values(21120,'q137_issarquivoretencaoregistro','int4','Código do Registro do Arquivo de Retencão','0', 'Código Registro Retencão',10,'f','f','f',1,'text','Código Registro Retencão');
delete from db_sysarqcamp where codarq = 3802;
insert into db_sysarqcamp values(3802,21118,1,0);
insert into db_sysarqcamp values(3802,21119,2,0);
insert into db_sysarqcamp values(3802,21120,3,0);
delete from db_sysprikey where codarq = 3802;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3802,21118,1,21119);
delete from db_sysforkey where codarq = 3802 and referen = 0;
insert into db_sysforkey values(3802,21119,1,421,0);
delete from db_sysforkey where codarq = 3802 and referen = 0;
insert into db_sysforkey values(3802,21120,1,3797,0);
insert into db_sysindices values(4198,'issarquivoretencaoregistroissplan_issplan_in',3802,'0');
insert into db_syscadind values(4198,21119,1);
insert into db_sysindices values(4199,'issarquivoretencaoregistroissplan_issarquivoretencaoregisTRIBUTtro_in',3802,'0');
insert into db_syscadind values(4199,21120,1);
insert into db_syssequencia values(1000459, 'issarquivoretencaoregistroissplan_q137_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000459 where codarq = 3802 and codcam = 21118;


--Layout arquivo de retenção iss - issarquivoretencao
insert into db_layouttxt( db50_codigo, db50_layouttxtgrupo, db50_descr, db50_quantlinhas, db50_obs ) values ( 227 ,1 ,'ARQUIVO RETENÇÃO ISS' ,0 ,'' );

--Cabeçalho
insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta )
     values ( 744 ,227 ,'HEADER' ,1 ,500 ,0 ,0 ,'' ,'' ,'0' );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
     values ( 12388 ,744 ,'codigo_registro' ,'CÓDIGO DO REGISTRO' ,1 ,1 ,'1' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12389 ,744 ,'sequencial_registro' ,'SEQUENCIAL DO REGISTRO' ,2 ,2 ,'' ,8 ,'t' ,'t' ,'e' ,'' ,0 ),
            ( 12390 ,744 ,'codigo_convenio' ,'CÓDIGO DO CONVÊNIO' ,1 ,10 ,'' ,29 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12391 ,744 ,'data_geracao_arquivo' ,'DATA DA GERAÇÃO DO ARQUIVO' ,2 ,30 ,'' ,8 ,'f' ,'t' ,'e' ,'' ,0 ),
            ( 12392 ,744 ,'numero_remessa' ,'NÚMERO DA REMESSA' ,2 ,38 ,'' ,6 ,'f' ,'t' ,'e' ,'' ,0 ),
            ( 12393 ,744 ,'numero_versao' ,'NÚMERO DA VERSÃO' ,2 ,44 ,'' ,2 ,'f' ,'t' ,'e' ,'' ,0 ),
            ( 12394 ,744 ,'filler' ,'FILLER' ,1 ,46 ,'' ,22 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12395 ,744 ,'decencio_referencia' ,'DECENCIO DE REFERÊNCIA' ,2 ,68 ,'' ,8 ,'f' ,'t' ,'e' ,'' ,0 ),
            ( 12396 ,744 ,'filler' ,'FILLER' ,1 ,76 ,'' ,425 ,'f' ,'t' ,'d' ,'' ,0 );

--Detail
insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta )
     values ( 745, 227, 'DETALHE', 3, 500, 0, 0, '', '', '0' );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
     values ( 12397, 745, 'codigo_registro', 'CÓDIGO DO REGISTRO', 1, 1, '2', 1, 'f', 't', 'd', '', 0 ),
            ( 12398, 745, 'sequencial_registro' ,'SEQUENCIAL DO REGISTRO' ,2 ,2 ,'' ,8, 't', 't', 'e', '', 0 ),
            ( 12399, 745, 'data_emissao_documento' ,'DATA DE EMISSÃO DO DOCUMENTO' ,2 ,10 ,'' ,8, 'f', 't', 'e', '', 0 ),
            ( 12400, 745, 'data_vencimento_documento' ,'DATA DE VENCIMENTO DO DOCUMENTO' ,1 ,18 ,'' ,8, 'f', 't', 'd', '', 0 ),
            ( 12401, 745, 'numero_ducumento' ,'NÚMERO DO DUCUMENTO' ,1 ,26 ,'' ,12, 'f', 't', 'd', '', 0 ),
            ( 12402, 745, 'espaco_branco' ,'ESPAÇO EM BRANCO' ,2 ,38 ,'' ,6, 'f', 't', 'e', '', 0 ),
            ( 12403, 745, 'espaco_branco' ,'ESPAÇO EM BRANCO' ,2 ,44 ,'' ,5, 'f', 't', 'e', '', 0 ),
            ( 12404, 745, 'espaco_branco' ,'ESPAÇO EM BRANCO' ,2 ,49 ,'' ,6, 'f', 't', 'e', '', 0 ),
            ( 12405, 745, 'cnpj_unidade_tomadora' ,'NÚMERO DO CNPJ DA UNIDADE GESTORA TOMADO' ,2 ,55 ,'' ,14, 'f', 't', 'e', '', 0 ),
            ( 12406, 745, 'codigo_municipio_tomadora' ,'CÓDIGO DO MUNICÍPIO DA UNIDADE GESTORA' ,2 ,69 ,'' ,6, 'f', 't', 'e', '', 0 ),
            ( 12407, 745, 'cnpj_cpf_substituto' ,'NÚMERO DO CNPJ OU CPF DO SUBSTITUTO' ,2 ,75 ,'' ,14, 'f', 't', 'e', '', 0 ),
            ( 12408, 745, 'codigo_municipio_nota_fiscal' ,'CÓDIGO DO MUNICÍPIO DA NOTA FISCAL' ,2 ,89 ,'' ,6, 'f', 't', 'e', '', 0 ),
            ( 12409, 745, 'espaco_branco' ,'ESPAÇO EM BRANCO' ,1 ,95 ,'' ,5, 'f', 't', 'd', '', 0 ),
            ( 12410, 745, 'esfera_receita' ,'ESFERA DA RECEITA' ,1 ,100 ,'' ,1, 'f', 't', 'd', '', 0 ),
            ( 12411, 745, 'competencia' ,'COMPETÊNCIA' ,1 ,101 ,'' ,6, 'f', 't', 'd', '', 0 ),
            ( 12412, 745, 'valor_principal' ,'VALOR DO IMPOSTO' ,2 ,107 ,'' ,17, 'f', 't', 'e', '', 0 ),
            ( 12413, 745, 'valor_multa' ,'VALOR DA MULTA' ,2 ,124 ,'' ,17, 'f', 't', 'e', '', 0 ),
            ( 12414, 745, 'valor_juros' ,'VALOR DOS JUROS' ,2 ,141 ,'' ,17, 'f', 't', 'e', '', 0 ),
            ( 12415, 745, 'numero_nota_fiscal_recibo' ,'NÚMERO DA NOTA FISCAL/RECIBO' ,2 ,158 ,'' ,10, 'f', 't', 'e', '', 0 ),
            ( 12416, 745, 'serie_nota_fiscal' ,'SÉRIE DA NOTA FISCAL' ,1 ,168 ,'' ,5, 'f', 't', 'd', '', 0 ),
            ( 12417, 745, 'subserie_nota_fiscal' ,'SUB-SÉRIE DA NOTA FISCAL' ,2 ,173 ,'' ,2, 'f', 't', 'e', '', 0 ),
            ( 12418, 745, 'data_emissao_nota_fiscal_recibo' ,'DATA DE EMISSÃO DA NOTA FISCAL/RECIBO' ,2 ,175 ,'' ,8, 'f', 't', 'e', '', 0 ),
            ( 12419, 745, 'valor_nota_fiscal_recibo' ,'VALOR DA NOTA FISCAL/RECIBO' ,2 ,183 ,'' ,17, 'f', 't', 'e', '', 0 ),
            ( 12420, 745, 'aliquota' ,'ALÍQUOTA' ,2 ,200 ,'' ,5, 'f', 't', 'e', '', 0 ),
            ( 12421, 745, 'valor_base_calculo' ,'VALOR DO SERVIÇO' ,2 ,205 ,'' ,17, 'f', 't', 'e', '', 0 ),
            ( 12422, 745, 'observacao' ,'OBSERVAÇÃO' ,1 ,222 ,'' ,234, 'f', 't', 'd', '', 0 ),
            ( 12423, 745, 'codigo_municipio_favorecido' ,'CÓDIGO DO MUNICÍPIO FAVORECIDO' ,2 ,456 ,'' ,6, 'f', 't', 'e', '', 0 ),
            ( 12424, 745, 'filler' ,'FILLER' ,1 ,462 ,'' ,39, 'f', 't', 'd', '', 0 );

--Footer
insert into db_layoutlinha( db51_codigo, db51_layouttxt, db51_descr, db51_tipolinha, db51_tamlinha, db51_linhasantes, db51_linhasdepois, db51_obs, db51_separador, db51_compacta )
     values ( 746, 227, 'TRAILLER', 5, 500, 0, 0, '', '', '0' );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
     values ( 12425 ,746 ,'codigo_registro' ,'CÓDIGO DO REGISTRO' ,1 ,1 ,'9' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12426, 746, 'sequencial_registro' ,'SEQUENCIAL DO REGISTRO',2 ,2 ,'' ,8 ,'t' ,'t' ,'e' , '', 0 ),
            ( 12427, 746, 'total_registros_gravados' ,'TOTAL DE REGISTROS GRAVADOS' ,2 ,10 ,'' ,6 ,'f' ,'t' ,'e' , '', 0 ),
            ( 12428, 746, 'valor_total_recebido' ,'VALOR TOTAL RECEBIDO' ,2 ,16 ,'' ,17 ,'f' ,'t' ,'e' , '', 0 ),
            ( 12429, 746, 'filler' ,'FILLER' ,1 ,33 ,'' ,468 ,'f' ,'t' ,'d' , '', 0 );
insert into db_sysarquivo values (3805, 'issarquivoretencaodisarq', 'Vínculo entre o Arquivo de Retenção de ISSQN e disarq', 'q145', '2015-04-09', 'Arquivo de Retenção DisArq', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (3,3805);
insert into db_syscampo values(21133,'q145_sequencial','int4','Sequencial do vínculo entre o arquivo de retenção e a disarq','0', 'Sequencial ',10,'f','f','f',1,'text','Sequencial');
insert into db_syscampo values(21134,'q145_issarquivoretencao','int4','Código Arquivo de Retenção de ISSQN','0', 'Código Arquivo de Retenção',10,'f','f','f',1,'text','Código Arquivo de Retenção');
insert into db_syscampo values(21135,'q145_disarq','int4','Disarq','0', 'Disarq',10,'f','f','f',1,'text','Disarq');
insert into db_sysarqcamp values(3805,21133,1,0);
insert into db_sysarqcamp values(3805,21134,2,0);
insert into db_sysarqcamp values(3805,21135,3,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3805,21133,1,21135);
insert into db_sysforkey values(3805,21134,1,3791,0);
insert into db_sysforkey values(3805,21135,1,213,0);
insert into db_sysindices values(4206,'issarquivoretencaodisarq_issarquivoretencao_disarq_in',3805,'1');
insert into db_syscadind values(4206,21134,1);
insert into db_syscadind values(4206,21135,2);
insert into db_syssequencia values(1000462, 'issarquivoretencaodisarq_q145_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000462 where codarq = 3805 and codcam = 21133;

insert into db_sysarquivo values (3806, 'issarquivoretencaoregistroissvar', 'Vínculo entre Registros do Arquivo de Retenção ISSQN com Issvar', 'q146', '2015-04-15', 'Arquivo de Retenção ISSVar', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (3,3806);
insert into db_syscampo values(21137,'q146_sequencial','int4','Sequencial do vínculo entre issarquivoretencaoregistro e issvar','0', 'Sequencial',10,'f','f','f',1,'text','Sequencial');
insert into db_syscampo values(21138,'q146_issvar','int4','Código da Issvar','0', 'IssVar',10,'f','f','f',1,'text','IssVar');
insert into db_syscampo values(21139,'q146_issarquivoretencaoregistro','int4','Código do Registro do Arquivo de Retencão ISSQN','0', 'Código Registro Retencão',10,'f','f','f',1,'text','Código Registro Retencão');
insert into db_sysarqcamp values(3806,21137,1,0);
insert into db_sysarqcamp values(3806,21138,2,0);
insert into db_sysarqcamp values(3806,21139,3,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3806,21137,1,21137);
insert into db_sysforkey values(3806,21138,1,63,0);
insert into db_sysforkey values(3806,21139,1,3797,0);
insert into db_sysindices values(4207,'issarquivoretencaoregistroissvar_issvar_in',3806,'0');
insert into db_syscadind values(4207,21138,1);
insert into db_sysindices values(4208,'issarquivoretencaoregistroissvar_issarquivoretencaoregistro_in',3806,'0');
insert into db_syscadind values(4208,21139,1);
insert into db_syssequencia values(1000463, 'issarquivoretencaoregistroissvar_q146_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000463 where codarq = 3806 and codcam = 21137;


/**
 * Meio Ambiente
 */
update db_syscampo set nomecam = 'am01_descricao', conteudo = 'varchar(60)', descricao = 'Critérios de medição de atividade de impacto local', valorinicial = '', rotulo = 'Critério de Medição', nulo = 'f', tamanho = 60, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Critério de Medição' where codcam = 20755;
insert into db_syscampo values(21142,'am05_protprocesso','int4','Código do Protocolo','0', 'Protocolo',10,'f','f','f',1,'text','Protocolo');
insert into db_sysforkey values(3741,21142,1,403,0);

----------------------------------------------------------------------------------------
------------------------------ FIM TRIBUTARIO ------------------------------------------
----------------------------------------------------------------------------------------

  update db_syscampo set aceitatipo = 1, rotulo='Departamento' where codcam = 814;
 update db_syscampo set rotulo = 'Órgão'   where codcam=5570;
 update db_syscampo set rotulo = 'Unidade' where codcam=5571;
 update db_syscampo set rotulo = 'Função'  where codcam=5572;
 update db_syscampo set rotulo = 'Subfunção' where  codcam=5573;
 update db_syscampo set rotulo = 'Programa' where  codcam=5574;
 update db_syscampo set rotulo = 'Projeto/Atividade' where  codcam=5575;
 update db_syscampo set rotulo = 'Elemento' where  codcam=5576;
 update db_syscampo set rotulo = 'Recurso' where  codcam=5577;


 /* Bloqueio de menus não utilizados mais na contabilidade/tesouraria */
 update db_itensmenu set libcliente = false where id_item in (3668, 3669, 3837, 3835);