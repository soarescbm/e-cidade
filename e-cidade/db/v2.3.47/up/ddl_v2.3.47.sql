--
-- Versão: $Id: ddl_v2.3.47.sql,v 1.11 2016/02/03 11:18:44 dbrenan Exp $
--

/****************************************************************************************************************
 * =====================================  Folha de Pagamento (Pessoal/RH) ===================================== *
 ****************************************************************************************************************/

-- Criando  sequences
CREATE SEQUENCE lancamentorra_rh173_sequencial_seq
  INCREMENT 1  MINVALUE 1  MAXVALUE 9223372036854775807  START 1  CACHE 1;
CREATE SEQUENCE lancamentorraloteregistroponto_rh174_sequencial_seq
  INCREMENT 1  MINVALUE 1  MAXVALUE 9223372036854775807  START 1  CACHE 1;
CREATE SEQUENCE tipoassefinanceirorra_rh172_sequencial_seq
  INCREMENT 1  MINVALUE 1  MAXVALUE 9223372036854775807  START 1  CACHE 1;
CREATE SEQUENCE db_faixavalores_db150_sequencial_seq
  INCREMENT 1  MINVALUE 1  MAXVALUE 9223372036854775807  START 1  CACHE 1;
CREATE SEQUENCE db_tabelavalores_db149_sequencial_seq
  INCREMENT 1  MINVALUE 1  MAXVALUE 9223372036854775807  START 1  CACHE 1;
CREATE SEQUENCE db_tabelavalorestipo_db151_sequencial_seq
  INCREMENT 1  MINVALUE 1  MAXVALUE 9223372036854775807  START 1  CACHE 1;
CREATE SEQUENCE faixavaloresirrf_rh175_sequencial_seq
  INCREMENT 1  MINVALUE 1  MAXVALUE 9223372036854775807  START 1  CACHE 1;
-- TABELAS E ESTRUTURA

-- Módulo: pessoal
CREATE TABLE lancamentorra(
  rh173_sequencial		int4 NOT NULL  default nextval('lancamentorra_rh173_sequencial_seq'),
  rh173_assentamentorra		int4 NOT NULL,
  rh173_valorlancado		float8 NOT NULL,
  rh173_encargos		float8 NOT NULL,
  rh173_pensao		float8 NOT NULL,
  rh173_baseprevidencia		float8,
  rh173_baseirrf float8,
  CONSTRAINT lancamentorra_sequ_pk PRIMARY KEY (rh173_sequencial)
);

-- Módulo: pessoal
CREATE TABLE lancamentorraloteregistroponto(
  rh174_sequencial		int4 NOT NULL  default nextval('lancamentorraloteregistroponto_rh174_sequencial_seq'),
  rh174_lancamentorra		int4 NOT NULL ,
  rh174_loteregistroponto		int4 ,
  CONSTRAINT lancamentorraloteregistroponto_sequ_pk PRIMARY KEY (rh174_sequencial)
);

-- Módulo: pessoal
CREATE TABLE tipoassefinanceirorra(
  rh172_sequencial		int4 NOT NULL  default nextval('tipoassefinanceirorra_rh172_sequencial_seq'),
  rh172_tipoasse		int4 NOT NULL ,
  rh172_rubricaprevidencia		char(4) NOT NULL ,
  rh172_rubricaprovento		char(4) NOT NULL ,
  rh172_rubricapensao		char(4) NOT NULL ,
  rh172_rubricairrf		char(4) NOT NULL ,
  rh172_rubricaparceladeducao   char(4) NOT NULL ,
  rh172_rubricamolestia		char(4) NOT NULL ,
  rh172_instit		int4 ,
  CONSTRAINT tipoassefinanceirorra_sequ_pk PRIMARY KEY (rh172_sequencial)
);

-- Módulo: recursoshumanos
CREATE TABLE assentamentorra(
  h83_assenta   int4 NOT NULL default 0,
  h83_valor   float8 NOT NULL ,
  h83_meses   int4 NOT NULL ,
  h83_encargos    float8 NOT NULL ,
  CONSTRAINT assentamentorra_sequ_pk PRIMARY KEY (h83_assenta)
);

-- Módulo: configuracoes
CREATE TABLE db_faixavalores(
db150_sequencial    int4 NOT NULL  default nextval('db_faixavalores_db150_sequencial_seq'),
db150_db_tabelavalores    int4 NOT NULL ,
db150_inicio    float8 NOT NULL ,
db150_final   float8 ,
CONSTRAINT db_faixavalores_sequ_pk PRIMARY KEY (db150_sequencial));


-- Módulo: configuracoes
CREATE TABLE db_tabelavalores(
db149_sequencial    int4 NOT NULL  default nextval('db_tabelavalores_db149_sequencial_seq'),
db149_descricao   varchar(100) NOT NULL ,
db149_db_tabelavalorestipo    int4 ,
CONSTRAINT db_tabelavalores_sequ_pk PRIMARY KEY (db149_sequencial));


-- Módulo: configuracoes
CREATE TABLE db_tabelavalorestipo(
db151_sequencial    int4 NOT NULL  default nextval('db_tabelavalorestipo_db151_sequencial_seq'),
db151_descricao   varchar(100) ,
CONSTRAINT db_tabelavalorestipo_sequ_pk PRIMARY KEY (db151_sequencial));


-- Módulo: pessoal
CREATE TABLE faixavaloresirrf(
rh175_sequencial    int4 NOT NULL  default nextval('faixavaloresirrf_rh175_sequencial_seq'),
rh175_db_faixavalores   int4 NOT NULL ,
rh175_percentual    float8 NOT NULL ,
rh175_deducao   float8 ,
CONSTRAINT faixavaloresirrf_sequ_pk PRIMARY KEY (rh175_sequencial));



-- CHAVE ESTRANGEIRA


ALTER TABLE lancamentorra
        ADD CONSTRAINT lancamentorra_assentamentorra_fk FOREIGN KEY (rh173_assentamentorra)
 REFERENCES assentamentorra;

ALTER TABLE lancamentorraloteregistroponto
        ADD CONSTRAINT lancamentorraloteregistroponto_lancamentorra_fk FOREIGN KEY (rh174_lancamentorra)
 REFERENCES lancamentorra;

ALTER TABLE lancamentorraloteregistroponto
        ADD CONSTRAINT lancamentorraloteregistroponto_loteregistroponto_fk FOREIGN KEY (rh174_loteregistroponto)
 REFERENCES loteregistroponto;

ALTER TABLE tipoassefinanceirorra
        ADD CONSTRAINT tipoassefinanceirorra_rubricairrf_instit_fk FOREIGN KEY (rh172_rubricairrf, rh172_instit)
 REFERENCES rhrubricas;

ALTER TABLE tipoassefinanceirorra
        ADD CONSTRAINT tipoassefinanceirorra_rubricaprevidencia_instit_fk FOREIGN KEY (rh172_rubricaprevidencia, rh172_instit)
 REFERENCES rhrubricas;

ALTER TABLE tipoassefinanceirorra
        ADD CONSTRAINT tipoassefinanceirorra_rubricaprovento_instit_fk FOREIGN KEY (rh172_rubricaprovento, rh172_instit)
 REFERENCES rhrubricas;

ALTER TABLE tipoassefinanceirorra
        ADD CONSTRAINT tipoassefinanceirorra_rubricapensao_instit_fk FOREIGN KEY (rh172_rubricapensao, rh172_instit)
 REFERENCES rhrubricas;

ALTER TABLE tipoassefinanceirorra
        ADD CONSTRAINT tipoassefinanceirorra_rubricaparceladeducao_instit_fk FOREIGN KEY (rh172_rubricaparceladeducao, rh172_instit)
 REFERENCES rhrubricas;

ALTER TABLE tipoassefinanceirorra
        ADD CONSTRAINT tipoassefinanceirorra_rubricamolestia_instit_fk FOREIGN KEY (rh172_rubricamolestia, rh172_instit)
 REFERENCES rhrubricas;

ALTER TABLE assentamentorra
        ADD CONSTRAINT assentamentorra_assenta_fk FOREIGN KEY (h83_assenta)
 REFERENCES assenta;

ALTER TABLE db_faixavalores
        ADD CONSTRAINT db_faixavalores_tabelavalores_fk FOREIGN KEY (db150_db_tabelavalores)
 REFERENCES db_tabelavalores;

ALTER TABLE db_tabelavalores
        ADD CONSTRAINT db_tabelavalores_tabelavalorestipo_fk FOREIGN KEY (db149_db_tabelavalorestipo)
 REFERENCES db_tabelavalorestipo;

ALTER TABLE faixavaloresirrf
        ADD CONSTRAINT faixavaloresirrf_faixavalores_fk FOREIGN KEY (rh175_db_faixavalores)
 REFERENCES db_faixavalores;

ALTER TABLE cfpess
        ADD COLUMN r11_tabelavaloresrra int4;

ALTER TABLE cfpess
        ADD CONSTRAINT tabelavaloresrra_faixavalores_fk FOREIGN KEY (r11_tabelavaloresrra)
  REFERENCES db_tabelavalores;


-- INDICES
CREATE  INDEX lancamentorra_assentamentorra_in ON lancamentorra(rh173_assentamentorra);
CREATE  INDEX lancamentorraloteregistroponto_loteregistroponto_in ON lancamentorraloteregistroponto(rh174_loteregistroponto);
CREATE  INDEX lancamentorraloteregistroponto_lancamentorra_in ON lancamentorraloteregistroponto(rh174_lancamentorra);
CREATE  INDEX assentamentorra_assenta_in ON assentamentorra(h83_assenta);
CREATE  INDEX db_faixavalores_db_tabelavalores_in ON db_faixavalores(db150_db_tabelavalores);
CREATE  INDEX faixavaloresirrf_db_faixavalores_in ON faixavaloresirrf(rh175_db_faixavalores);
CREATE UNIQUE INDEX tipoassefinanceirorra_tipoasse_un_in ON tipoassefinanceirorra(rh172_tipoasse);

/**
 * Inserindo Natureza do assentamento do tipo RRA
 */
-- update naturezatipoassentamento set rh159_descricao = 'Padrão' where rh159_sequencial = 1;
-- update naturezatipoassentamento set rh159_descricao = 'Substituição' where rh159_sequencial = 2;
-- insert into naturezatipoassentamento values(3, 'RRA');
-- insert into db_tabelavalorestipo (db151_descricao) values ('Default');
-- insert into db_tabelavalorestipo (db151_descricao) values ('IRRF RRA');

---------------------------------------------------------------------------------------------
-------------------------------- INICIO TRIBUTARIO ------------------------------------------
---------------------------------------------------------------------------------------------

alter table pardiv add column v04_cobrarjurosmultacda boolean default false;

---------------------------------------------------------------------------------------------
---------------------------------- FIM TRIBUTARIO -------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------
----------------------------------- INICIO EDUCACAO/SAUDE -----------------------------------------
---------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------
-- Inicio Cadastro Avaliação Ficha PSF - Ficha de Avaliação de Elegibilidade e Admissão --
------------------------------------------------------------------------------------------
select fc_executa_ddl('insert into avaliacao( db101_sequencial ,db101_avaliacaotipo ,db101_descricao ,db101_identificador ,db101_obs ,db101_ativo ) values ( 3000007 ,4 ,\'AVALIAÇÃO DE ELEGIBILIDADE E ADMISSÃO\' ,\'f9\' ,\'\' ,\'t\' );');
select fc_executa_ddl('insert into avaliacaogrupopergunta( db102_sequencial ,db102_avaliacao ,db102_descricao ,db102_identificador ) values ( 3000034 ,3000007 ,\'Avaliação de Elegibilidade e Admissão\' ,\'f9g1\' );');
select fc_executa_ddl('insert into avaliacaopergunta( db103_sequencial ,db103_avaliacaotiporesposta ,db103_avaliacaogrupopergunta ,db103_descricao ,db103_identificador ,db103_obrigatoria ,db103_ativo ,db103_ordem ) values ( 3000213 ,3 ,3000034 ,\'Condição(ões) Avaliada(s)\' ,\'f9g1condicoes\' ,\'f\' ,\'t\' ,1 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000768 ,3000213 ,\'Acamado\' ,\'f9g1condicoesAcamado\' ,\'f\' ,1 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000769 ,3000213 ,\'Domiciliado\' ,\'f9g1condicoesDomiciliado\' ,\'f\' ,2 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000770 ,3000213 ,\'Úlceras / Feridas (grau III ou IV)\' ,\'f9g1condicoesUlceras\' ,\'f\' ,3 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000771 ,3000213 ,\'Acompanhamento nutricional\' ,\'f9g1condicoesAcompanhamentoNutricional\' ,\'f\' ,4 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000772 ,3000213 ,\'Uso de sonda naso-gástrica - SNG\' ,\'f9g1condicoesSNG\' ,\'f\' ,5 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000773 ,3000213 ,\'Uso de sonda naso-enteral - SNE\' ,\'f9g1condicoesSNE\' ,\'f\' ,6 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000774 ,3000213 ,\'Uso de gastrostomia\' ,\'f9g1condicoesGastrostomia\' ,\'f\' ,7 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000775 ,3000213 ,\'Uso de colostomia\' ,\'f9g1condicoesColostomia\' ,\'f\' ,8 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000776 ,3000213 ,\'Uso de cistostomia\' ,\'f9g1condicoesCistostomia\' ,\'f\' ,9 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000777 ,3000213 ,\'Uso de sonda vesical de demora - SVD\' ,\'f9g1condicoesSVD\' ,\'f\' ,10 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000778 ,3000213 ,\'Acompanhamento pré-operatório\' ,\'f9g1condicoesPreOperatorio\' ,\'f\' ,11 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000779 ,3000213 ,\'Acompanhamento pós-operatório\' ,\'f9g1condicoesPosOperatorio\' ,\'f\' ,12 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000780 ,3000213 ,\'Adaptação ao uso de órtese / prótese\' ,\'f9g1condicoesOrteseProtese\' ,\'f\' ,13 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000781 ,3000213 ,\'Reabilitação domiciliar\' ,\'f9g1condicoesReabilitacaoDomiciliar\' ,\'f\' ,14 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000782 ,3000213 ,\'Cuidados paliativos oncológico\' ,\'f9g1condicoesPaliativosOncologico\' ,\'f\' ,15 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000783 ,3000213 ,\'Cuidados paliativos não-oncológico\' ,\'f9g1condicoesPaliativosNaoOncologico\' ,\'f\' ,16 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000784 ,3000213 ,\'Oxigenoterapia domiciliar\' ,\'f9g1condicoesOxigenoterapia\' ,\'f\' ,17 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000785 ,3000213 ,\'Uso de traqueostomia\' ,\'f9g1condicoesTraqueostomia\' ,\'f\' ,18 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000786 ,3000213 ,\'Uso de aspirador de vias aéreas para higiene brônquica\' ,\'f9g1condicoesAspiradorViasAereas\' ,\'f\' ,19 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000787 ,3000213 ,\'Suporte ventilatório não invasivo - CPAP\' ,\'f9g1condicoesCPAP\' ,\'f\' ,20 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000788 ,3000213 ,\'Suporte ventilatório não invasivo - BiPAP\' ,\'f9g1condicoesBiPAP\' ,\'f\' ,21 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000789 ,3000213 ,\'Diálise peritonial\' ,\'f9g1condicoesDialisePeritonial\' ,\'f\' ,22 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000790 ,3000213 ,\'Paracentese\' ,\'f9g1condicoesParacentese\' ,\'f\' ,23 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000791 ,3000213 ,\'Medicação parenteral\' ,\'f9g1condicoesMedicacaoParenteral\' ,\'f\' ,24 );');
select fc_executa_ddl('insert into avaliacaopergunta( db103_sequencial ,db103_avaliacaotiporesposta ,db103_avaliacaogrupopergunta ,db103_descricao ,db103_identificador ,db103_obrigatoria ,db103_ativo ,db103_ordem ) values ( 3000214 ,2 ,3000034 ,\'CID (principal)\' ,\'f9g1cid1\' ,\'t\' ,\'t\' ,2 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000792 ,3000214 ,\'\' ,\'f9g1cid1_2\' ,\'true\' ,0 );');
select fc_executa_ddl('insert into avaliacaopergunta( db103_sequencial ,db103_avaliacaotiporesposta ,db103_avaliacaogrupopergunta ,db103_descricao ,db103_identificador ,db103_obrigatoria ,db103_ativo ,db103_ordem ) values ( 3000215 ,2 ,3000034 ,\'CID (secundário) \' ,\'f9g1cid2\' ,\'f\' ,\'t\' ,3 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000793 ,3000215 ,\'\' ,\'f9g1cid2_2\' ,\'true\' ,0 );');
select fc_executa_ddl('insert into avaliacaopergunta( db103_sequencial ,db103_avaliacaotiporesposta ,db103_avaliacaogrupopergunta ,db103_descricao ,db103_identificador ,db103_obrigatoria ,db103_ativo ,db103_ordem ) values ( 3000216 ,2 ,3000034 ,\'CID (secundário)\' ,\'f9g1cid3\' ,\'f\' ,\'t\' ,4 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000794 ,3000216 ,\'\' ,\'f9g1cid3_2\' ,\'true\' ,0 );');
select fc_executa_ddl('insert into avaliacaopergunta( db103_sequencial ,db103_avaliacaotiporesposta ,db103_avaliacaogrupopergunta ,db103_descricao ,db103_identificador ,db103_obrigatoria ,db103_ativo ,db103_ordem ) values ( 3000217 ,1 ,3000034 ,\'Conclusão da Elegibilidade\' ,\'f9g1conclusaoElegibilidade\' ,\'t\' ,\'t\' ,5 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000795 ,3000217 ,\'Elegível - AD1\' ,\'f9g1conclusaoElegibilidadeAD1\' ,\'f\' ,1 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000796 ,3000217 ,\'Elegível - AD2\' ,\'f9g1conclusaoElegibilidadeAD2\' ,\'f\' ,2 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000797 ,3000217 ,\'Elegível - AD3\' ,\'f9g1conclusaoElegibilidadeAD3\' ,\'f\' ,3 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000798 ,3000217 ,\'Inelegível\' ,\'f9g1conclusaoElegibilidadeInelegivel\' ,\'f\' ,4 );');
select fc_executa_ddl('insert into avaliacaopergunta( db103_sequencial ,db103_avaliacaotiporesposta ,db103_avaliacaogrupopergunta ,db103_descricao ,db103_identificador ,db103_obrigatoria ,db103_ativo ,db103_ordem ) values ( 3000218 ,1 ,3000034 ,\'Se elegível, escolha o procedimento\' ,\'f9g1procedimento\' ,\'f\' ,\'t\' ,6 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000799 ,3000218 ,\'Admissão na própria EMAD\' ,\'f9g1procedimentoAdmissao\' ,\'f\' ,1 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000800 ,3000218 ,\'Encaminhado para outra EMAD\' ,\'f9g1procedimentoEncaminhadoEMAD\' ,\'f\' ,2 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000801 ,3000218 ,\'Encaminhado para Atenção Básica (AD1)\' ,\'f9g1procedimentoEncaminhadoBasica\' ,\'f\' ,3 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000802 ,3000218 ,\'Outro encaminhamento\' ,\'f9g1procedimentoEncaminhadoOutro\' ,\'f\' ,4 );');
select fc_executa_ddl('insert into avaliacaopergunta( db103_sequencial ,db103_avaliacaotiporesposta ,db103_avaliacaogrupopergunta ,db103_descricao ,db103_identificador ,db103_obrigatoria ,db103_ativo ,db103_ordem ) values ( 3000219 ,3 ,3000034 ,\'Se inelegível, assinale o(s) motivo(s)\' ,\'f9g1motivo\' ,\'f\' ,\'t\' ,7 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000803 ,3000219 ,\'Instabilidade clínica com necessidade de monitorização contínua\' ,\'f9g1motivoInstabilidadeClinica\' ,\'f\' ,1 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000804 ,3000219 ,\'Necessidade de propedêutica complementar, com demanda potencial para a realização de vários procedimentos diagnósticos, com urgência\' ,\'f9g1motivoNecessidadePropedeutica\' ,\'f\' ,2 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000805 ,3000219 ,\'Outro motivo clínico\' ,\'f9g1motivoOutroMotivoClinico\' ,\'f\' ,3 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000806 ,3000219 ,\'Ausência de cuidador (em caso de necessidade)\' ,\'f9g1motivoAusenciaCuidador\' ,\'f\' ,4 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000807 ,3000219 ,\'Outras condições sociais e/ou famil. impeditivas do cuidado domiciliar\' ,\'f9g1motivoOutrasCondicoes\' ,\'f\' ,5 );');
------------------------------------------------------------------------------------------
-- Fim Cadastro Avaliação Ficha PSF - Ficha de Avaliação de Elegibilidade e Admissão -----
------------------------------------------------------------------------------------------

select fc_executa_ddl('CREATE SEQUENCE cadenderestadosistema_db300_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;');

select fc_executa_ddl('CREATE TABLE cadenderestadosistema(
                         db300_sequencial    int4 NOT NULL default 0,
                         db300_db_sistemaexterno   int4 NOT NULL default 0,
                         db300_cadenderestado    int4 NOT NULL default 0,
                         db300_codigo    varchar(50) ,
                         CONSTRAINT cadenderestadosistema_sequ_pk PRIMARY KEY (db300_sequencial));
                      ');

select fc_executa_ddl('ALTER TABLE cadenderestadosistema ADD CONSTRAINT cadenderestadosistema_sistemaexterno_fk FOREIGN KEY (db300_db_sistemaexterno) REFERENCES db_sistemaexterno;');
select fc_executa_ddl('ALTER TABLE cadenderestadosistema ADD CONSTRAINT cadenderestadosistema_cadenderestado_fk FOREIGN KEY (db300_cadenderestado) REFERENCES cadenderestado;');
select fc_executa_ddl('CREATE  INDEX cadenderestadosistema_cadenderestado_in ON cadenderestadosistema(db300_cadenderestado);');
select fc_executa_ddl('CREATE  INDEX cadenderestadosistema_db_sistemaexterno_in ON cadenderestadosistema(db300_db_sistemaexterno);');



select fc_executa_ddl('create temp table w_estados (
                        dne    int,
                        estado varchar(255));
                      ');

select fc_executa_ddl('insert into w_estados values (1,  \'ACRE\');');
select fc_executa_ddl('insert into w_estados values (2,  \'ALAGOAS\');');
select fc_executa_ddl('insert into w_estados values (3,  \'AMAPÁ\');');
select fc_executa_ddl('insert into w_estados values (4,  \'AMAZONAS\');');
select fc_executa_ddl('insert into w_estados values (5,  \'BAHIA\');');
select fc_executa_ddl('insert into w_estados values (6,  \'CEARÁ\');');
select fc_executa_ddl('insert into w_estados values (7,  \'DISTRITO FEDERAL\');');
select fc_executa_ddl('insert into w_estados values (8,  \'ESPÍRITO SANTO\');');
select fc_executa_ddl('insert into w_estados values (9,  \'RORAIMA\');');
select fc_executa_ddl('insert into w_estados values (10, \'GOIÁS\');');
select fc_executa_ddl('insert into w_estados values (11, \'MARANHÃO\');');
select fc_executa_ddl('insert into w_estados values (12, \'MATO GROSSO\');');
select fc_executa_ddl('insert into w_estados values (13, \'MATO GROSSO DO SUL\');');
select fc_executa_ddl('insert into w_estados values (14, \'MINAS GERAIS\');');
select fc_executa_ddl('insert into w_estados values (15, \'PARÁ\');');
select fc_executa_ddl('insert into w_estados values (16, \'PARAÍBA\');');
select fc_executa_ddl('insert into w_estados values (17, \'PARANÁ\');');
select fc_executa_ddl('insert into w_estados values (18, \'PERNAMBUCO\');');
select fc_executa_ddl('insert into w_estados values (19, \'PIAUÍ\');');
select fc_executa_ddl('insert into w_estados values (20, \'RIO DE JANEIRO\');');
select fc_executa_ddl('insert into w_estados values (21, \'RIO GRANDE DO NORTE\');');
select fc_executa_ddl('insert into w_estados values (22, \'RIO GRANDE DO SUL\');');
select fc_executa_ddl('insert into w_estados values (23, \'RONDÔNIA\');');
select fc_executa_ddl('insert into w_estados values (24, \'TOCANTINS\');');
select fc_executa_ddl('insert into w_estados values (25, \'SANTA CATARINA\');');
select fc_executa_ddl('insert into w_estados values (26, \'SÃO PAULO\');');
select fc_executa_ddl('insert into w_estados values (27, \'SERGIPE\');');

select fc_executa_ddl('insert into cadenderestadosistema
                       select nextval(\'cadenderestadosistema_db300_sequencial_seq\'), 8, db71_sequencial, dne
                         from w_estados
                        inner join cadenderestado         on fc_remove_acentos(trim(estado)) = fc_remove_acentos(trim(db71_descricao))
                        left  join cadenderestadosistema  on db300_cadenderestado = db71_sequencial
                                                         and db300_codigo = dne::varchar
                        where db300_sequencial is null;
                      ');



insert into regracalculocargahoraria
( select nextval('regracalculocargahoraria_ed127_codigo_seq'), ed52_i_ano, false, ed18_i_codigo
           from (

                 select distinct ed18_i_codigo, ed52_i_ano
                  from escola
                  join calendarioescola         on ed38_i_escola = ed18_i_codigo
                  join calendario               on ed52_i_codigo = ed38_i_calendario
                  left join regracalculocargahoraria on ed127_ano = ed52_i_ano
                                               and ed127_escola = ed18_i_codigo
                 where ed127_codigo is null
                ) as c
        );

---------------------------------------------------------------------------------------------------
------------------------------------- FIM EDUCACAO/SAUDE ------------------------------------------
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-------------------------------- INICIO CONFIGURACAO ----------------------------------------
---------------------------------------------------------------------------------------------

select fc_executa_ddl('
  CREATE SEQUENCE configuracoes.atendcadareamod_at26_sequencia_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 2000000
  CACHE 1;
');

select fc_executa_ddl('select setval(\'atendcadareamod_at26_sequencia_seq\', 2000000);');

select fc_executa_ddl('
  CREATE SEQUENCE configuracoes.db_pluginmodulos_db152_sequencial_seq
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;

  CREATE TABLE configuracoes.db_pluginmodulos(
  db152_sequencial  int4 NOT NULL  default nextval(\'configuracoes.db_pluginmodulos_db152_sequencial_seq\'),
  db152_db_plugin   int4 NOT NULL ,
  db152_db_modulo   int4 ,
  CONSTRAINT db_pluginmodulos_sequ_pk PRIMARY KEY (db152_sequencial));

  ALTER TABLE configuracoes.db_pluginmodulos
  ADD CONSTRAINT db_pluginmodulos_plugin_fk FOREIGN KEY (db152_db_plugin)
  REFERENCES db_plugin;

  ALTER TABLE configuracoes.db_pluginmodulos
  ADD CONSTRAINT db_pluginmodulos_modulo_fk FOREIGN KEY (db152_db_modulo)
  REFERENCES db_modulos;

  CREATE INDEX db_pluginmodulos_db152_db_modulo_in ON configuracoes.db_pluginmodulos(db152_db_modulo);
  CREATE INDEX db_pluginmodulos_db152_db_plugin_in ON configuracoes.db_pluginmodulos(db152_db_plugin);
');

alter table db_pluginitensmenu add column db146_uid varchar(255);
alter table configuracoes.db_pluginmodulos add column db152_uid varchar(255);



DROP INDEX IF EXISTS db_auditoria_datahora_servidor_in;
DROP INDEX IF EXISTS db_auditoria_instit_in;

SELECT fc_executa_ddl($$ CREATE INDEX db_auditoria_datahora_servidor_instit_in ON db_auditoria USING btree (datahora_servidor, instit); $$);


---------------------------------------------------------------------------------------------
---------------------------------- FIM CONFIGURACAO -----------------------------------------
---------------------------------------------------------------------------------------------
