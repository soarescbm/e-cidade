---------------------------------------------------------------------------------------------------------------
--------------------------------------- INICIO TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

alter table abatimentoutilizacaodestino drop column if exists k170_valor;

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------- INICIO FINANCEIRO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------


drop table if exists empnotasuspensao;
drop sequence if exists empnotasuspensao_cc36_sequencial_seq;

---------------------------------------------------------------------------------------------------------------
--------------------------------------- FIM FINANCEIRO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------
--------------------------------------- INICIO FOLHA ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
--DROP TABLE:
DROP TABLE IF EXISTS eventofinanceiroautomatico CASCADE;
--Criando drop sequences
DROP SEQUENCE IF EXISTS eventofinanceiroautomatico_rh181_sequencial_seq;
DROP SEQUENCE IF EXISTS eventofinanceiroautomatico_rubrica_mes_selecao_instituicao_un;

DROP TABLE IF EXISTS rhconsignadomovimentomanual;
DROP SEQUENCE IF EXISTS rhconsignadomovimentomanual_rh182_sequencial_seq;

select fc_executa_ddl('ALTER TABLE rhconsignadomovimento DROP COLUMN rh151_situacao;');
select fc_executa_ddl('ALTER TABLE rhconsignadomovimento DROP COLUMN rh151_consignadoorigem;');
select fc_executa_ddl('ALTER TABLE rhconsignadomovimento DROP COLUMN rh151_tipoconsignado;');

DROP TABLE IF EXISTS atolegalprevidencia CASCADE;
DROP SEQUENCE IF EXISTS atolegalprevidencia_rh179_sequencial_seq;
DROP TABLE IF EXISTS atolegalprevidenciainssirf CASCADE;
DROP SEQUENCE IF EXISTS atolegalprevidenciainssirf_rh180_sequencial_seq;

ALTER TABLE rhparam drop CONSTRAINT rhparam_tempocontribuicaorgps_fk;
ALTER TABLE rhparam drop CONSTRAINT rhparam_tempocontribuicaorpps_fk;
ALTER TABLE rhparam drop CONSTRAINT rhparam_temposficticios_fk;
ALTER TABLE rhparam drop CONSTRAINT rhparam_temposemcontribuicao_fk;

alter table rhparam drop column h36_tempocontribuicaorgps;
alter table rhparam drop column h36_tempocontribuicaorpps;
alter table rhparam drop column h36_temposficticios;
alter table rhparam drop column h36_temposemcontribuicao;

ALTER TABLE cfpess DROP COLUMN r11_basefgintegral;
ALTER TABLE cfpess DROP COLUMN r11_basefgparcial;

delete from rharquivossiprev where rh94_sequencial in(6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17);
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL FOLHA ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------- INICIO CONFIGURACAO ---------------------------------------------------
---------------------------------------------------------------------------------------------------------------

drop table configuracoes.db_tutorialetapapassos;
drop sequence configuracoes.db_tutorialetapapassos_id_seq;
drop table configuracoes.db_tutorialetapas;
drop sequence configuracoes.db_tutorialetapas_id_seq;
drop table configuracoes.db_tutorial;
drop sequence configuracoes.db_tutorial_id_seq;

  -- organograma --
ALTER TABLE    db_depart      DROP COLUMN     id_usuarioresp;
ALTER TABLE    db_organograma DROP CONSTRAINT db_organograma_depart_fk;
ALTER TABLE    db_organograma DROP CONSTRAINT db_organograma_estruturavalor_fk;
DROP  TABLE    IF EXISTS db_organograma;
DROP  INDEX    IF EXISTS db_depart_loginresp_in;
DROP  INDEX    IF EXISTS db_organograma_estruturavalor_in;
DROP  INDEX    IF EXISTS db_organograma_descricao_in;
DROP  SEQUENCE IF EXISTS db_organograma_db122_sequencial_seq;

update db_itensmenu set id_item = 8843 , descricao = 'Cadastro de Organograma' , help = 'Cadastro de Organograma' , itemativo = '1' , manutencao = '1' , desctec = 'Cadastro de Organograma' , libcliente = 'false' where id_item = 8843;
update db_itensmenu set id_item = 8847 , descricao = 'Inclusão' , help = '' , funcao = 'con1_organograma001.php' , itemativo = '1' , manutencao = '1' , desctec = '' , libcliente = 'false' where id_item = 8847;
update db_itensmenu set id_item = 8848 , descricao = 'Alteração' , help = '' , funcao = 'con1_organograma002.php' , itemativo = '1' , manutencao = '1' , desctec = '' , libcliente = 'false' where id_item = 8848;
update db_itensmenu set id_item = 8849 , descricao = 'Relatório de Organograma' , help = '' , funcao = 'con2_organograma.php' , itemativo = '1' , manutencao = '1' , desctec = '' , libcliente = 'false' where id_item = 8849;
update db_itensmenu set id_item = 8871 , descricao = 'Configurações Gerais' , help = 'Configurações Gerais' , funcao = 'con4_configuracoesgerais.php' , itemativo = '1' , manutencao = '1' , desctec = 'Configurações Gerais' , libcliente = 'false' where id_item = 8871;

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL CONFIGURACAO ---------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO SAUDE ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
alter table cgs_und drop column if exists z01_registromunicipio;
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL SAUDE ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------