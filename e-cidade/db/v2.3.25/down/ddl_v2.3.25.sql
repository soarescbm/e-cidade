/**
 * Arquivo ddl que desfaz alterações do ddl up
 */

/*
 *
 * TIME Tributário
 *
 *
 */

alter table rharqbanco drop column if exists rh34_parametrotransmissaoheader;
alter table rharqbanco drop column if exists rh34_parametrotransmissaolote  ;
alter table rharqbanco drop column if exists rh34_codigocompromisso         ;

ALTER TABLE parissqn DROP COLUMN q60_templatebaixaalvaranormal;
ALTER TABLE parissqn DROP COLUMN q60_templatebaixaalvaraoficial;

alter table numpref drop column k03_toleranciacredito;

DROP TABLE IF EXISTS tabdesccadban CASCADE;
DROP SEQUENCE IF EXISTS tabdesccadban_k114_sequencial_seq;

delete from histcalc where k01_codigo = 507;
/*
 *
 * FIM TIME Tributário
 *
 *
 */

/**
 * TIME B
 */

  -- mensageriaacordodb_usuario
  drop sequence IF EXISTS mensageriaacordodb_usuario_ac52_sequencial_seq;
  drop table IF EXISTS mensageriaacordodb_usuario;
  drop INDEX IF EXISTS mensageriaacordodb_usuario_db_usuarios_in

  -- mensageriaacordo
  DROP SEQUENCE mensageriaacordo_ac51_sequencial_seq;
  DROP TABLE mensageriaacordo;

  -- mensageriaacordoprocessados
  DROP SEQUENCE mensageriaacordoprocessados_ac53_sequencial_seq;
  DROP TABLE mensageriaacordoprocessados;

  
	DROP TABLE IF EXISTS placaixaprocesso CASCADE;
	DROP TABLE IF EXISTS slipprocesso CASCADE;
	DROP TABLE IF EXISTS pagordemprocesso CASCADE;
	
	DROP SEQUENCE IF EXISTS placaixaprocesso_k144_sequencial_seq;
	DROP SEQUENCE IF EXISTS slipprocesso_k145_sequencial_seq;
	DROP SEQUENCE IF EXISTS pagordemprocesso_e03_sequencial_seq;
	
	DROP INDEX IF EXISTS placaixaprocesso_placaixa_in;
	DROP INDEX IF EXISTS slipprocesso_slip_in;
	DROP INDEX IF EXISTS pagordemprocesso_pagordem_in;  

	
  
DROP TABLE IF EXISTS empnotaprocesso CASCADE;
DROP SEQUENCE IF EXISTS empnotaprocesso_e04_sequencial_seq;
DROP INDEX IF EXISTS empnotaprocesso_empnota_in;
	

  
/**
 * FIM TIME B
 */

/*
 *
 * TIME C
 *
 *
 */

alter table escoladiretor ALTER COLUMN ed254_i_atolegal set not null;
alter table edu_relatmodel drop column if exists ed217_brasao;


/**
 * T91754
 */
DROP SEQUENCE IF EXISTS rechumanomovimentacao_ed118_sequencial_seq;
DROP INDEX IF EXISTS rechumanomovimentacao_usuario_in;
DROP INDEX IF EXISTS rechumanomovimentacao_rechumano_in;
DROP INDEX IF EXISTS rechumanomovimentacao_escola_in;

ALTER TABLE rechumanohoradisp ADD ed33_i_rechumano int4 NOT NULL default 0;

update rechumanohoradisp
   set ed33_i_rechumano = old
  from w_rechumanohoradisp
 where rechumanohoradisp.ed33_i_codigo = w_rechumanohoradisp.ed33_i_codigo;

DROP TABLE IF EXISTS w_rechumanohoradisp;

ALTER TABLE rechumanohoradisp DROP COLUMN IF EXISTS ed33_rechumanoescola;
ALTER TABLE rechumanohoradisp DROP COLUMN IF EXISTS ed33_ativo;

DROP TABLE IF EXISTS rechumanomovimentacao;

/**
 * T93234
 */
-- lab_requiitem
alter table lab_requiitem drop column la21_observacao;

/*
 *
 * FIM TIME C
 *
 *
 */

 /*
 *
 * INICIO TIME D
 * T 93849
 *
 */
ALTER TABLE issqn.ativid DROP COLUMN q03_tributacao_municipio;

/*
 *
 * FIM TIME D
 *
 *
 */