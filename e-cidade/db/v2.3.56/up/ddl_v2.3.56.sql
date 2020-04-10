/**
 * $Id: ddl_v2.3.56.sql,v 1.35 2016/11/03 13:24:32 dbrenan.silva Exp $
 */
---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO TRIBUTARIO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
-- Cria tabela e sequence para tabela grupotaxadiversos
select fc_executa_ddl('
  create sequence fiscal.grupotaxadiversos_y118_sequencial_seq
    increment 1
    minvalue 1
    maxvalue 9223372036854775807
    start 1
    cache 1;
');

CREATE table IF NOT EXISTS fiscal.grupotaxadiversos (
  y118_sequencial       int4         NOT NULL default nextval('fiscal.grupotaxadiversos_y118_sequencial_seq'),
  y118_descricao        varchar(100) NOT NULL,
  y118_inflator         varchar(5)   NOT NULL,
  y118_procedencia      int4         NOT NULL,
  CONSTRAINT grupotaxadiversos_sequencial_pk PRIMARY KEY (y118_sequencial),
  CONSTRAINT grupotaxadiversos_inflator_fk FOREIGN KEY (y118_inflator) REFERENCES inflatores.inflan,
  CONSTRAINT grupotaxadiversos_procedencia_fk FOREIGN KEY (y118_procedencia) REFERENCES diversos.procdiver
);

select fc_executa_ddl('CREATE INDEX grupotaxadiversos_procedencia_in ON fiscal.grupotaxadiversos(y118_procedencia)');
select fc_executa_ddl('CREATE INDEX grupotaxadiversos_inflator_in ON fiscal.grupotaxadiversos(y118_inflator)');

-- Cria tabela e sequence para tabela taxadiversos
select fc_executa_ddl('
  create sequence fiscal.taxadiversos_y119_sequencial_seq
    increment 1
    minvalue 1
    maxvalue 9223372036854775807
    start 1
    cache 1;
') as taxadiversos_y119_sequencial_seq;

CREATE table IF NOT EXISTS fiscal.taxadiversos (
  y119_sequencial          int4         NOT NULL default nextval('fiscal.taxadiversos_y119_sequencial_seq'),
  y119_grupotaxadiversos   int4         NOT NULL,
  y119_natureza            text         NOT NULL,
  y119_formula             int4         NOT NULL,
  y119_unidade             varchar(50)  NOT NULL,
  y119_tipo_periodo        char(1)      NOT NULL,
  y119_tipo_calculo        char(1)      NOT NULL,
  CONSTRAINT taxadiversos_sequencial_pk PRIMARY KEY (y119_sequencial),
  CONSTRAINT taxadiversos_grupotaxadiversos_fk FOREIGN KEY (y119_grupotaxadiversos) REFERENCES fiscal.grupotaxadiversos,
  CONSTRAINT taxadiversos_formula_fk FOREIGN KEY (y119_formula) REFERENCES configuracoes.db_formulas
);
select fc_executa_ddl('CREATE INDEX taxadiversos_grupotaxadiversos_in ON fiscal.taxadiversos(y119_grupotaxadiversos)');
select fc_executa_ddl('CREATE INDEX taxadiversos_formula_in ON fiscal.taxadiversos(y119_formula)');

-- Cria tabela e sequence para tabela lancamentotaxadiversos
select fc_executa_ddl('
  create sequence fiscal.lancamentotaxadiversos_y120_sequencial_seq
    increment 1
    minvalue 1
    maxvalue 9223372036854775807
    start 1
    cache 1;
') as lancamentotaxadiversos_y120_sequencial_seq;

CREATE table IF NOT EXISTS fiscal.lancamentotaxadiversos (
  y120_sequencial     int4      NOT NULL default nextval('fiscal.lancamentotaxadiversos_y120_sequencial_seq'),
  y120_cgm            int4,
  y120_taxadiversos   int4      NOT NULL,
  y120_unidade        float8    NOT NULL,
  y120_periodo        float8,
  y120_datainicio     date,
  y120_datafim        date,
  y120_issbase        int4,
  CONSTRAINT lancamentotaxadiversos_sequencial_pk PRIMARY KEY (y120_sequencial),
  CONSTRAINT lancamentotaxadiversos_cgm_fk FOREIGN KEY (y120_cgm) REFERENCES protocolo.cgm,
  CONSTRAINT lancamentotaxadiversos_taxadiversos_fk FOREIGN KEY (y120_taxadiversos) REFERENCES fiscal.taxadiversos,
  CONSTRAINT lancamentotaxadiversos_issbase_fk FOREIGN KEY (y120_issbase) REFERENCES issqn.issbase
);
select fc_executa_ddl('CREATE INDEX lancamentotaxadiversos_cgm_in ON fiscal.lancamentotaxadiversos(y120_cgm)');
select fc_executa_ddl('CREATE INDEX lancamentotaxadiversos_taxadiversos_in ON fiscal.lancamentotaxadiversos(y120_taxadiversos)');
select fc_executa_ddl('CREATE INDEX lancamentotaxadiversos_issbase_in ON fiscal.lancamentotaxadiversos(y120_issbase)');

-- Cria tabela e sequence para tabela taxavaloresreferencia
select fc_executa_ddl('create sequence fiscal.taxavaloresreferencia_y121_sequencial_seq increment 1 minvalue 1 maxvalue 9223372036854775807 start 1 cache 1;') as taxavaloresreferencia_y121_sequencial_seq;

CREATE table IF NOT EXISTS fiscal.taxavaloresreferencia (
  y121_sequencial         int4           NOT NULL default nextval('fiscal.taxavaloresreferencia_y121_sequencial_seq'),
  y121_descricao          varchar(100)   NOT NULL,
  y121_valor              float8         NOT NULL,
  y121_data_base          date           NOT NULL default current_date,
  CONSTRAINT taxavaloresreferencia_sequencial_pk PRIMARY KEY (y121_sequencial)
);

select fc_executa_ddl('CREATE UNIQUE INDEX taxavaloresreferencia_descricao_un ON fiscal.taxavaloresreferencia(y121_descricao)');

select fc_executa_ddl('CREATE SEQUENCE diversos.diversoslancamentotaxa_dv14_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1; ');

CREATE TABLE IF NOT EXISTS diversos.diversoslancamentotaxa(
  dv14_sequencial              int4 NOT NULL default nextval('diversos.diversoslancamentotaxa_dv14_sequencial_seq'),
  dv14_diversos                int4 NOT NULL,
  dv14_lancamentotaxadiversos  int4 NOT NULL,
  dv14_data_calculo            date,
  CONSTRAINT diversoslancamentotaxa_sequ_pk                   PRIMARY KEY (dv14_sequencial),
  CONSTRAINT diversoslancamentotaxa_diversos_fk               FOREIGN KEY (dv14_diversos)               REFERENCES diversos.diversos,
  CONSTRAINT diversoslancamentotaxa_lancamentotaxadiversos_fk FOREIGN KEY (dv14_lancamentotaxadiversos) REFERENCES fiscal.lancamentotaxadiversos
);


-- Início módulo Água
select fc_executa_ddl('create sequence agua.aguaisencaocgm_x56_sequencial_seq increment 1 minvalue 1 maxvalue 9223372036854775807 start 1 cache 1;') as aguaisencaocgm_x56_sequencial_seq;

create table if not exists agua.aguaisencaocgm(
  x56_sequencial      int4 not null default nextval('aguaisencaocgm_x56_sequencial_seq'),
  x56_aguaisencaotipo int4 not null,
  x56_cgm             int4 not null,
  x56_datainicial     date not null,
  x56_datafinal       date,
  x56_processo        varchar(30) ,
  x56_observacoes     text,
  constraint aguaisencaocgm_sequ_pk primary key (x56_sequencial),
  constraint aguaisencaocgm_aguaisencaotipo_fk foreign key (x56_aguaisencaotipo) references aguaisencaotipo,
  constraint aguaisencaocgm_cgm_fk foreign key (x56_cgm) references cgm
);

-- Água: Cadastro de Economias
select fc_executa_ddl('CREATE SEQUENCE agua.aguacontratoeconomia_x38_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1') as aguacontratoeconomia_x38_sequencial_seq;
create table if not exists agua.aguacontratoeconomia(
x38_sequencial		          int4 not null default nextval('aguacontratoeconomia_x38_sequencial_seq'),
x38_aguacontrato		        int4 not null,
x38_cgm		                  int4 not null,
x38_aguacategoriaconsumo		int4 not null,
x38_datavalidadecadastro		date,
x38_nis		                  varchar(20),
constraint aguacontratoeconomia_sequ_pk primary key (x38_sequencial),
constraint aguacontratoeconomia_cgm_fk foreign key (x38_cgm) references cgm,
constraint aguacontratoeconomia_aguacontrato_fk foreign key (x38_aguacontrato) references aguacontrato,
constraint aguacontratoeconomia_aguacategoriaconsumo_fk foreign key (x38_aguacategoriaconsumo) references aguacategoriaconsumo
);

-- Água: Tipos de Contrato
select fc_executa_ddl('CREATE SEQUENCE agua.aguatipocontrato_x39_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1') as aguatipocontrato_x39_sequencial_seq;
create table if not exists agua.aguatipocontrato(
x39_sequencial		int4 not null  default nextval('aguatipocontrato_x39_sequencial_seq'),
x39_descricao		  varchar(100) ,
constraint aguatipocontrato_sequ_pk primary key (x39_sequencial)
);

-- Água: Contrato
select fc_executa_ddl('alter table agua.aguacontrato alter column x54_aguacategoriaconsumo drop not null;');
select fc_executa_ddl('alter table agua.aguacontrato add column x54_condominio bool;');
select fc_executa_ddl('alter table agua.aguacontrato add column x54_aguatipocontrato int4;');
select fc_executa_ddl('alter table agua.aguacontrato add constraint aguacontrato_aguatipocontrato_fk foreign key (x54_aguatipocontrato) references aguatipocontrato;');
-- Fim módulo Água

-- Cobrança Registrada
select fc_executa_ddl($$
  create sequence caixa.remessacobrancaregistrada_k147_sequencial_seq
  increment 1
  minvalue 1
  maxvalue 9223372036854775807
  start 1
  cache 1;
$$);

select fc_executa_ddl($$
  create sequence caixa.remessacobrancaregistradarecibo_k148_sequencial_seq
  increment 1
  minvalue 1
  maxvalue 9223372036854775807
  start 1
  cache 1;
$$);

create table if not exists caixa.reciboregistra(
  k146_numpre	integer not null,
  k146_convenio	integer not null,
  constraint reciboregistra_convenio_fk foreign key (k146_convenio) references cadconvenio
);

select fc_executa_ddl($$
  create index reciboregistra_numpre_in on caixa.reciboregistra(k146_numpre);
$$);

create table if not exists caixa.remessacobrancaregistrada(
  k147_sequencial	integer not null  default nextval('caixa.remessacobrancaregistrada_k147_sequencial_seq'),
  k147_instit integer not null,
  k147_convenio integer not null,
  k147_sequencialremessa integer not null,
  k147_dataemissao date not null,
  k147_horaemissao char(5),
  constraint remessacobrancaregistrada_sequ_pk primary key (k147_sequencial),
  constraint remessacobrancaregistrada_convenio_fk foreign key (k147_convenio) references cadconvenio
);

create table if not exists caixa.remessacobrancaregistradarecibo(
  k148_sequencial	integer not null  default nextval('caixa.remessacobrancaregistradarecibo_k148_sequencial_seq'),
  k148_remessacobrancaregistrada integer not null,
  k148_numpre	integer,
  constraint remessacobrancaregistradarecibo_sequ_pk primary key (k148_sequencial),
  constraint remessacobrancaregistradarecibo_remessacobrancaregistrada_fk foreign key (k148_remessacobrancaregistrada) references remessacobrancaregistrada
);

select fc_executa_ddl($$
  alter table conveniocobranca add column ar13_contabancaria integer;
  alter table conveniocobranca add CONSTRAINT conveniocobranca_ar13_contabancaria_fk FOREIGN KEY (ar13_contabancaria) REFERENCES contabancaria;
$$);
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------------
----------------------------------------- INICIO EDUCACAO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
select fc_executa_ddl('alter table atividaderh add column ed01_atividadeescolar bool default \'f\'');
---------------------------------------------------------------------------------------------------------------
------------------------------------------- FIM EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
----------------------------------------- INICIO FOLHA --------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

select fc_executa_ddl('CREATE SEQUENCE pessoal.pontosalariodatalimite_rh183_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1');

CREATE TABLE if not exists pontosalariodatalimite(
rh183_sequencial    int4 default nextval('pessoal.pontosalariodatalimite_rh183_sequencial_seq'),
rh183_rubrica   varchar(5)  ,
rh183_datainicio    date NOT NULL default null,
rh183_datafim   date NOT NULL default null,
rh183_matricula   int4 NOT NULL default 0,
rh183_quantidade    int4 NOT NULL default 0,
rh183_valor   float4 NOT NULL default 0,
rh183_instituicao   int4 NOT NULL default 0);

select fc_executa_ddl('ALTER TABLE pontosalariodatalimite
ADD CONSTRAINT pontosalariodatalimite_rubrica_instituicao_fk FOREIGN KEY (rh183_rubrica,rh183_instituicao)
REFERENCES rhrubricas');

select fc_executa_ddl('alter table rhrubricas add column rh27_periodolancamento bool default \'f\'');
---------------------------------------------------------------------------------------------------------------
------------------------------------------- FIM FOLHA ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
----------------------------------------- INICIO CONFIGURACAO -------------------------------------------------
---------------------------------------------------------------------------------------------------------------



select fc_executa_ddl('DROP INDEX acordoacordogarantia_acordo_in');
select fc_executa_ddl('DROP INDEX acordoacordopenalidade_acordo_in');
select fc_executa_ddl('DROP INDEX acordoitemexecutadoempenho_numemp_in');
select fc_executa_ddl('DROP INDEX acordomovcan_acordomovimentacao_in');
select fc_executa_ddl('DROP INDEX acordoparalisacao_sequencial_in');
select fc_executa_ddl('DROP INDEX acordoparalisacaoacordomovimentacao_sequencial_in');
select fc_executa_ddl('DROP INDEX acordoparalisacaoperiodo_sequencial_in');
select fc_executa_ddl('DROP INDEX acordopenalidadeacordotipo_acordtipo_in');
select fc_executa_ddl('DROP INDEX aguaconsumo_x19_areaini_areafim_in');
select fc_executa_ddl('DROP INDEX aguacortemat_x41_dtprazo_in');
select fc_executa_ddl('DROP INDEX aguacortetipodebito_dtvenc_in');
select fc_executa_ddl('DROP INDEX aguadescarrecad_numpre_numpar_in');
select fc_executa_ddl('DROP INDEX aguadescarrecad_numpre_numpar_receit_in');
select fc_executa_ddl('DROP INDEX agualeiturista_x16_dtini_dtfim_in');
select fc_executa_ddl('DROP INDEX cgs_cgm_numcgm_in');
select fc_executa_ddl('DROP INDEX cgs_und_certfolha_in');
select fc_executa_ddl('DROP INDEX cgs_und_certlivro_in');
select fc_executa_ddl('DROP INDEX cgs_und_certnum_in');
select fc_executa_ddl('DROP INDEX cgs_undalt_cgsund_in');
select fc_executa_ddl('DROP INDEX cids_sd22_v_descr_in');
select fc_executa_ddl('DROP INDEX prontuarios_sd24_v_motivo_in');
select fc_executa_ddl('DROP INDEX agendaexameconfirmaresultado_conf_in');
select fc_executa_ddl('DROP INDEX sau_agendaexames_exame_in');
select fc_executa_ddl('DROP INDEX sau_atendprest_descricao_in');
select fc_executa_ddl('DROP INDEX sau_cgscorreto_data_in');
select fc_executa_ddl('DROP INDEX sau_cgserrado_nome_in');
select fc_executa_ddl('DROP INDEX sau_convenio_descricao_in');
select fc_executa_ddl('DROP INDEX sau_examesatributos_atributos_exames_in');
select fc_executa_ddl('DROP INDEX sau_medicosforarede_s154_medico_in');
select fc_executa_ddl('DROP INDEX sau_nivelhier_descricao_in');
select fc_executa_ddl('DROP INDEX sau_servico_servico_in');
select fc_executa_ddl('DROP INDEX sau_tipoatend_descricao_in');
select fc_executa_ddl('DROP INDEX sau_triagemavulsapront_s155_pront_in');
select fc_executa_ddl('DROP INDEX sau_turnoaten_descricao_in');
select fc_executa_ddl('DROP INDEX unidades_sd02_distrito_in');
select fc_executa_ddl('DROP INDEX declaracaoquitacaocarneagua_anoemissao_mesemissao_in');
select fc_executa_ddl('DROP INDEX declaracaoquitacaocarneagua_numpre_numpar_in');
select fc_executa_ddl('DROP INDEX impexemplar_biblio_in');
select fc_executa_ddl('DROP INDEX leitorcategoria_bibli_in');
select fc_executa_ddl('DROP INDEX certidaoexistencia_iptuconstr_in');
select fc_executa_ddl('DROP INDEX certidaoexistenciaprotprocesso_protprocesso_in');
select fc_executa_ddl('DROP INDEX iptuant_refant_in');
select fc_executa_ddl('DROP INDEX iptunaogeracarnesetqua_setqua_in');
select fc_executa_ddl('DROP INDEX iptutabelasdepend_iptutabelas_in');
select fc_executa_ddl('DROP INDEX iptutabelasdepend_iptutabelasdepend_in');
select fc_executa_ddl('DROP INDEX arreidret_instit_in');
select fc_executa_ddl('DROP INDEX corautent_codautent_in');
select fc_executa_ddl('DROP INDEX corcla_autent_in');
select fc_executa_ddl('DROP INDEX devedores_data_ind');
select fc_executa_ddl('DROP INDEX devedores_dt_inscr_in');
select fc_executa_ddl('DROP INDEX devedores_dt_matric_in');
select fc_executa_ddl('DROP INDEX devedores_dt_numpre_in');
select fc_executa_ddl('DROP INDEX devedores_inscr_ind');
select fc_executa_ddl('DROP INDEX devedores_numpre_cgm_data_in');
select fc_executa_ddl('DROP INDEX devedores_numpre_ind');
select fc_executa_ddl('DROP INDEX devedores_tipo_ind');
select fc_executa_ddl('DROP INDEX disrec_instit_in');
select fc_executa_ddl('DROP INDEX tabplansaldorecurso_tabplan_ano_in');
select fc_executa_ddl('DROP INDEX tabplansaldorecursomov_conta_in');
select fc_executa_ddl('DROP INDEX transferenciafinanceirarecebimento_data_in');
select fc_executa_ddl('DROP INDEX transferenciafinanceirarecebimento_estornado_in');
select fc_executa_ddl('DROP INDEX transferenciafinanceirarecebimento_hora_in');
select fc_executa_ddl('DROP INDEX k00_numpre_dst_in');
select fc_executa_ddl('DROP INDEX restos_old_i_sepultamento_in');
select fc_executa_ddl('DROP INDEX sepulta_d_entrada_in');
select fc_executa_ddl('DROP INDEX sepultamentos_i_registro_in');
select fc_executa_ddl('DROP INDEX pc35_pcfornecertiforiginal_pcfornecertif');
select fc_executa_ddl('DROP INDEX solandam_ordem_in');
select fc_executa_ddl('DROP INDEX solandpadrao_ordem_in');
select fc_executa_ddl('DROP INDEX solicitaregistropreco_liberado_in');
select fc_executa_ddl('DROP INDEX bancoagenciaendereco_endereco_in');
select fc_executa_ddl('DROP INDEX caddocumentoatributo_codcam_in');
select fc_executa_ddl('DROP INDEX cadenderpaissistema_db135_db_sistemaexterno_in');
select fc_executa_ddl('DROP INDEX cadenderparam_cadenderestado_in');
select fc_executa_ddl('DROP INDEX cadenderparam_cadendermunicipio_in');
select fc_executa_ddl('DROP INDEX cadenderparam_cadenderpais_in');
select fc_executa_ddl('DROP INDEX grupocaracteristica_grupoutilizacao_in');
select fc_executa_ddl('DROP INDEX mensagemnotificacao_mensagemnotificacaotipo_in');
select fc_executa_ddl('DROP INDEX orcparamseqcoluna_anousu_in');
select fc_executa_ddl('DROP INDEX aberturaexercicioorcamento_usuario_in');
select fc_executa_ddl('DROP INDEX concarpeculiar_estrutural_in');
select fc_executa_ddl('DROP INDEX conlancamcorrente_c86_sequencial_in');
select fc_executa_ddl('DROP INDEX conlancamord_data_ord_in');
select fc_executa_ddl('DROP INDEX conlancamretif_coddoc_in');
select fc_executa_ddl('DROP INDEX conlancamsup_data_sup_in');
select fc_executa_ddl('DROP INDEX conplanoorcamento_descr_in');
select fc_executa_ddl('DROP INDEX conplanosis_descr_in');
select fc_executa_ddl('DROP INDEX padsigapsubsidiosvereadores_ano_in');
select fc_executa_ddl('DROP INDEX padsigapsubsidiosvereadores_mes_in');
select fc_executa_ddl('DROP INDEX reconhecimentocontabiltipo_conhistdoc_in');
select fc_executa_ddl('DROP INDEX reconhecimentocontabiltipo_conhistdocestorno_in');
select fc_executa_ddl('DROP INDEX pardiver_instit_in');
select fc_executa_ddl('DROP INDEX divimporta_instit_in');
select fc_executa_ddl('DROP INDEX pardiv_instit_in');
select fc_executa_ddl('DROP INDEX proced_instit_in');
select fc_executa_ddl('DROP INDEX retermo_numpre_in');
select fc_executa_ddl('DROP INDEX tipoparc_instit_in');
select fc_executa_ddl('DROP INDEX empageformacgm_empageforma_in');
select fc_executa_ddl('DROP INDEX empagemovtipotransmissao_empagetipotransmissao_in');
select fc_executa_ddl('DROP INDEX empenhocotamensal_mes_in');
select fc_executa_ddl('DROP INDEX finalidadepagamentofundeb_codigo_in');
select fc_executa_ddl('DROP INDEX pagordemdescontoempanulado_sequencial_in');
select fc_executa_ddl('DROP INDEX retencaotiporec_receita_in');
select fc_executa_ddl('DROP INDEX avaliacaoestruturanota_db_estrutura_in');
select fc_executa_ddl('DROP INDEX avaliacaoestruturaregra_regraarredondamento_in');
select fc_executa_ddl('DROP INDEX avaliacaoestruturaregrafrequencia_regraarredondamento_in');
select fc_executa_ddl('DROP INDEX censoetapamediacaodidaticopedagogica_mediacaodidaticopedagogica');
select fc_executa_ddl('DROP INDEX controleacessoalunoregistro_dataleitura_in');
select fc_executa_ddl('DROP INDEX controleacessoalunoregistro_hora_in');
select fc_executa_ddl('DROP INDEX edu_anexoatolegal_ed292_nomearquivo_in');
select fc_executa_ddl('DROP INDEX matriculamov_descr_in');
select fc_executa_ddl('DROP INDEX ocorrencia_ocorrenciatipo_in');
select fc_executa_ddl('DROP INDEX procresultado_proced_in');
select fc_executa_ddl('DROP INDEX progressaoparcialalunoencerradodiario_progressao_in');
select fc_executa_ddl('DROP INDEX progressaoparcialalunomatricula_ano_in');
select fc_executa_ddl('DROP INDEX progressaoparcialalunoresultadofinal_resultadofinal_in');
select fc_executa_ddl('DROP INDEX rechumanoescola_rechumano_in');
select fc_executa_ddl('DROP INDEX regraarredondamentofaixa_regraarredondamento_in');
select fc_executa_ddl('DROP INDEX relacaotrabalho_tipohoratrabalho_in');
select fc_executa_ddl('DROP INDEX situacaoeducacao_tiposituacaoeducacao_in');
select fc_executa_ddl('DROP INDEX transflocal_escola_in');
select fc_executa_ddl('DROP INDEX turmacenso_censoetapa_in');
select fc_executa_ddl('DROP INDEX far_controle_cgs_in');
select fc_executa_ddl('DROP INDEX far_fatorriscofaramb_fatoramb_in');
select fc_executa_ddl('DROP INDEX far_fatorriscomedicamento_fa46_fator_in');
select fc_executa_ddl('DROP INDEX far_retiradacadacomp_fa55_retirada_in');
select fc_executa_ddl('DROP INDEX far_retiradaitemlote_matestoque_in');
select fc_executa_ddl('DROP INDEX far_tiporeceitapadrao_fa42_depart_in');
select fc_executa_ddl('DROP INDEX integracaohorusenviodadoscompetencia_dadoscompetencia_in');
select fc_executa_ddl('DROP INDEX aidofnumeracao_numeracao_in');
select fc_executa_ddl('DROP INDEX tipoandam_instit_in');
select fc_executa_ddl('DROP INDEX tipovistorias_instit_in');
select fc_executa_ddl('DROP INDEX avaliacaopergunta_avaltiporesposta_in');
select fc_executa_ddl('DROP INDEX habitformaavaliacaousuario_id_usuario_in');
select fc_executa_ddl('DROP INDEX habitgrupoprograma_tipogrupoprograma_in');
select fc_executa_ddl('DROP INDEX habittipogrupoprogformaval_formval_in');
select fc_executa_ddl('DROP INDEX habittipogrupoprogramaprocdoc_procdoc_in');
select fc_executa_ddl('DROP INDEX classe_descr_in');
select fc_executa_ddl('DROP INDEX confvencissqnvariavel_arretipo_in');
select fc_executa_ddl('DROP INDEX confvencissqnvariavel_histcalc_in');
select fc_executa_ddl('DROP INDEX isscalcant_numpre_in');
select fc_executa_ddl('DROP INDEX issgrupotipoalvara_isstipogrupoalvara_in');
select fc_executa_ddl('DROP INDEX issnotavulsa_q51_numnota');
select fc_executa_ddl('DROP INDEX issnotaavulsacanc_q63_usuario');
select fc_executa_ddl('DROP INDEX isssimulacalculoatividade_atividade_in');
select fc_executa_ddl('DROP INDEX issvarlancval_data_in');
select fc_executa_ddl('DROP INDEX meicgm_meisitucao_in');
select fc_executa_ddl('DROP INDEX meievento_meigrupoevento_in');
select fc_executa_ddl('DROP INDEX notasiss_descr_in');
select fc_executa_ddl('DROP INDEX parissqn_templatealvara_in');
select fc_executa_ddl('DROP INDEX tipcalc_abrev_in');
select fc_executa_ddl('DROP INDEX tipcalc_descr_in');
select fc_executa_ddl('DROP INDEX paritbi_grupodistrterrarura_in');
select fc_executa_ddl('DROP INDEX paritbi_grupoespbenfrural_in');
select fc_executa_ddl('DROP INDEX paritbi_grupoespbenfurbana_in');
select fc_executa_ddl('DROP INDEX paritbi_grupotipobenfrural_in');
select fc_executa_ddl('DROP INDEX paritbi_grupotipobenfurbana_in');
select fc_executa_ddl('DROP INDEX parjuridico_instit_in');
select fc_executa_ddl('DROP INDEX parjuridico_templateinicialquitada_in');
select fc_executa_ddl('DROP INDEX parjuridico_templateparcelamento_in');
select fc_executa_ddl('DROP INDEX partilharemessawebservice_db_remessawebservice_in');
select fc_executa_ddl('DROP INDEX liclicitaproc_protprocesso_in');
select fc_executa_ddl('DROP INDEX marca_c_figura1_in');
select fc_executa_ddl('DROP INDEX marca_c_figura2_in');
select fc_executa_ddl('DROP INDEX marca_c_figura3_in');
select fc_executa_ddl('DROP INDEX marca_c_letra1_in');
select fc_executa_ddl('DROP INDEX marca_c_letra2_in');
select fc_executa_ddl('DROP INDEX marca_c_letra3_in');
select fc_executa_ddl('DROP INDEX marca_c_letra4_in');
select fc_executa_ddl('DROP INDEX marca_c_objeto1_in');
select fc_executa_ddl('DROP INDEX marca_c_objeto2_in');
select fc_executa_ddl('DROP INDEX marca_c_objeto3_in');
select fc_executa_ddl('DROP INDEX atendrequi_data_in');
select fc_executa_ddl('DROP INDEX matestoquetipo_tipo_in');
select fc_executa_ddl('DROP INDEX posicaoestoqueprocessamento_sequencial_in');
select fc_executa_ddl('DROP INDEX mer_tprefeicao_me03_i_escola_in');
select fc_executa_ddl('DROP INDEX parnotificacao_instit_in');
select fc_executa_ddl('DROP INDEX concedente_numcgm_in');
select fc_executa_ddl('DROP INDEX cronogramabasecalculoreceita_mes_in');
select fc_executa_ddl('DROP INDEX cronogramabaserecano_ano');
select fc_executa_ddl('DROP INDEX cronogramametadespesa_mes_in');
select fc_executa_ddl('DROP INDEX orccenarioeconomicoparam_anoorc_in');
select fc_executa_ddl('DROP INDEX orcduplicacaodotacao_o76_anousu');
select fc_executa_ddl('DROP INDEX orcelemento_descr_in');
select fc_executa_ddl('DROP INDEX orcfuncao_descr_in');
select fc_executa_ddl('DROP INDEX orcmeta_descricao_in');
select fc_executa_ddl('DROP INDEX orcparamrelopcre_anousu_in');
select fc_executa_ddl('DROP INDEX orcparamrelopcre_instit_in');
select fc_executa_ddl('DROP INDEX orcprogramavinculoobjetivo_orcprogramaprograma_in');
select fc_executa_ddl('DROP INDEX orcsubfuncao_descr_in');
select fc_executa_ddl('DROP INDEX orcsuplemval_concarpeculiar_fk');
select fc_executa_ddl('DROP INDEX orctiporecconvenio_orctiporec_in');
select fc_executa_ddl('DROP INDEX orctiporecconvenioprotprocesso_proc_in');
select fc_executa_ddl('DROP INDEX ppaintegracao_ano_in');
select fc_executa_ddl('DROP INDEX ppaversao_ppalei_in');
select fc_executa_ddl('DROP INDEX cidadaotelefone_tipotelefone_in');
select fc_executa_ddl('DROP INDEX ouvidoriaatendimento_formareclamacao_in');
select fc_executa_ddl('DROP INDEX ouvidoriaatendimento_tipoident_in');
select fc_executa_ddl('DROP INDEX ouvidoriaatendimentocidadao_seq_in');
select fc_executa_ddl('DROP INDEX ouvatendretornotelefone_tipotel_in');
select fc_executa_ddl('DROP INDEX ouvidoriacadlocalender_local_in');
select fc_executa_ddl('DROP INDEX ouvidoriacadlocalgeral_local_in');
select fc_executa_ddl('DROP INDEX cfpatri_t06_bensmodeloetiqueta_in');
select fc_executa_ddl('DROP INDEX regimeprevidenciainssirf_instit_in');
select fc_executa_ddl('DROP INDEX regimeprevidenciasistemaexterno_db_sistemaexterno_in');
select fc_executa_ddl('DROP INDEX relrubcampos_relrub_instit_in');
select fc_executa_ddl('DROP INDEX rescisao_causaafastamento_in');
select fc_executa_ddl('DROP INDEX rhcadastroferiaslote_anousu_in');
select fc_executa_ddl('DROP INDEX rhcadregimefaltasperiodoaquisitivo_rhcadregime_in');
select fc_executa_ddl('DROP INDEX rhdirfgeracaodadospessoal_tipo_in');
select fc_executa_ddl('DROP INDEX rhempenhofolha_coddot_in');
select fc_executa_ddl('DROP INDEX rhempenhofolha_unidade_in');
select fc_executa_ddl('DROP INDEX rhempenhofolhaexcecaorubrica_instit_in');
select fc_executa_ddl('DROP INDEX rhempenhofolhaexcecaorubrica_orgao_in');
select fc_executa_ddl('DROP INDEX rhempenhofolhaexcecaorubrica_programa_in');
select fc_executa_ddl('DROP INDEX rhempenhofolhaexcecaorubrica_unidade_in');
select fc_executa_ddl('DROP INDEX rhferias_dias_in');
select fc_executa_ddl('DROP INDEX rhferias_periodoaquisitivoinicial_in');
select fc_executa_ddl('DROP INDEX rhferiasperiodo_anopagamento_mespagamento_in');
select fc_executa_ddl('DROP INDEX rhferiasperiodo_datafinal_in');
select fc_executa_ddl('DROP INDEX rhferiasperiodo_tipoponto_in');
select fc_executa_ddl('DROP INDEX rhprovisaoferias_dtini_dtfim_in');
select fc_executa_ddl('DROP INDEX rhsefip_instit_in');
select fc_executa_ddl('DROP INDEX rhslipfolha_concarpeculiar_in');
select fc_executa_ddl('DROP INDEX rhteutri_cartao_in');
select fc_executa_ddl('DROP INDEX rhvisavalecgm_instit_in');
select fc_executa_ddl('DROP INDEX selecaopontorubricas_selecaoponto_in');
select fc_executa_ddl('DROP INDEX ceplocalidades_cepfinal_in');
select fc_executa_ddl('DROP INDEX ceplogradouros_codbairrofinal_in');
select fc_executa_ddl('DROP INDEX certidao_instit_in');
select fc_executa_ddl('DROP INDEX cgmfoto_principal_in');
select fc_executa_ddl('DROP INDEX processoinscr_inscr_in');
select fc_executa_ddl('DROP INDEX processomatric_matric_in');
select fc_executa_ddl('DROP INDEX procmatric_codproc');
select fc_executa_ddl('DROP INDEX protparamglobal_sequencial_in');
select fc_executa_ddl('DROP INDEX rhestagioquesitoresposta_criterio_in');
select fc_executa_ddl('DROP INDEX rhferiasassenta_sequencial_in');
select fc_executa_ddl('DROP INDEX tipoassentamentoferias_assenta_abono_in');
select fc_executa_ddl('DROP INDEX cadastrounicobasemunicipal_chaveregistro_in');
select fc_executa_ddl('DROP INDEX cidadaobeneficio_ano_in');
select fc_executa_ddl('DROP INDEX cidadaobeneficio_mes_in');
select fc_executa_ddl('DROP INDEX cidadaobeneficio_nis_in');
select fc_executa_ddl('DROP INDEX cidadaobeneficio_tipobeneficio_in');
select fc_executa_ddl('DROP INDEX cidadaofamiliavisita_visitatipo_in');
select fc_executa_ddl('DROP INDEX pontoparada_cadenderbairrocadenderrua_in');

-- avaliacaoquestionariointerno
  select fc_executa_ddl('CREATE SEQUENCE configuracoes.avaliacaoquestionariointerno_db170_sequencial_seq
                          INCREMENT 1
                          MINVALUE 1
                          MAXVALUE 9223372036854775807
                          START 1
                          CACHE 1;');

  CREATE TABLE IF NOT EXISTS configuracoes.avaliacaoquestionariointerno(
    db170_sequencial    int4 NOT NULL default 0,
    db170_avaliacao   int4 NOT NULL default 0,
    db170_transmitido   bool  default 'f',
    db170_ativo   bool  default '1',
    db170_codigo    int4 default 0,
    CONSTRAINT avaliacaoquestionariointerno_sequ_pk PRIMARY KEY (db170_sequencial)
  );

  select fc_executa_ddl('ALTER TABLE configuracoes.avaliacaoquestionariointerno
                          ADD CONSTRAINT avaliacaoquestionariointerno_avaliacao_fk FOREIGN KEY (db170_avaliacao)
                          REFERENCES avaliacao;');
--

-- avaliacaoquestionariointernomenu
  select fc_executa_ddl('CREATE SEQUENCE configuracoes.avaliacaoquestionariointernomenu_db171_sequencial_seq
                          INCREMENT 1
                          MINVALUE 1
                          MAXVALUE 9223372036854775807
                          START 1
                          CACHE 1;');

  CREATE TABLE IF NOT EXISTS configuracoes.avaliacaoquestionariointernomenu(
    db171_sequencial    int4 NOT NULL default 0,
    db171_questionario    int4 NOT NULL default 0,
    db171_menu    int4 NOT NULL default 0,
    db171_modulo    int4 default 0,
    CONSTRAINT avaliacaoquestionariointernomenu_sequ_pk PRIMARY KEY (db171_sequencial)
  );

  select fc_executa_ddl('ALTER TABLE configuracoes.avaliacaoquestionariointernomenu
                          ADD CONSTRAINT avaliacaoquestionariointernomenu_questionario_fk FOREIGN KEY (db171_questionario)
                          REFERENCES avaliacaoquestionariointerno;');
--
  select fc_executa_ddl('ALTER TABLE avaliacaopergunta ALTER COLUMN db103_descricao TYPE text;');
-- Ajusta Permissoes
  select fc_grant_revoke('grant', 'plugin', 'select', '%', '%');
--
---------------------------------------------------------------------------------------------------------------
-------------------------------------------- FIM CONFIGURACAO -------------------------------------------------
---------------------------------------------------------------------------------------------------------------
