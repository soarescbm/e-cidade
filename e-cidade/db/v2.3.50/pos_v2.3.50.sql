insert into db_versao (db30_codver, db30_codversao, db30_codrelease, db30_data, db30_obs)  values (366, 3, 50, '2016-04-14', 'Tarefas: 99495, 99525, 99533, 99536, 99540, 99541, 99542, 99544, 99545, 99546, 99547, 99548, 99549, 99551, 99552, 99553, 99554, 99555, 99556, 99560, 99561, 99562, 99563, 99564, 99565, 99567, 99568, 99569, 99570, 99571, 99572, 99573, 99574, 99575, 99577, 99578, 99579, 99580, 99581, 99582, 99584, 99585, 99586, 99587, 99588, 99589, 99590, 99592, 99594, 99595, 99596, 99597, 99598, 99601, 99602, 99603, 99604, 99605, 99606, 99607, 99608, 99609, 99610, 99611, 99613, 99614, 99616, 99617, 99618, 99619, 99620, 99621, 99622, 99624, 99625, 99626, 99627, 99629, 99630, 99633, 99635, 99636, 99637, 99639, 99641, 99642, 99643, 99644, 99646');DROP TYPE IF EXISTS configuracoes.tp_auditoria_consulta_mudancas CASCADE;
CREATE TYPE configuracoes.tp_auditoria_consulta_mudancas AS (
	esquema           TEXT,
	tabela            TEXT,
	operacao          CHAR(1),
	chave             VARCHAR,
	transacao         BIGINT,
	datahora_sessao   TIMESTAMP WITH TIME ZONE,
	datahora_servidor TIMESTAMP WITH TIME ZONE,
	usuario           VARCHAR(20),
	nome_campo        TEXT,
	valor_antigo      TEXT,
	valor_novo        TEXT,
	logsacessa        INTEGER,
	instit            INTEGER
);

CREATE OR REPLACE FUNCTION configuracoes.fc_auditoria_consulta_mudancas(
	tDataHoraInicio TIMESTAMP,
	tDataHoraFim    TIMESTAMP,
	sEsquema        TEXT,
	sTabela         TEXT,
	sUsuario        TEXT,
	iLogsAcessa     INTEGER,
	iInstit         INTEGER,
	sCampo          TEXT,
	sValorAntigo    TEXT,
	sValorNovo      TEXT
) RETURNS SETOF configuracoes.tp_auditoria_consulta_mudancas AS
$$
DECLARE
	rRetorno		configuracoes.tp_auditoria_consulta_mudancas;
	rAuditoria		RECORD;

	rCursorRetorno	REFCURSOR;

	iQtdMudancas	INTEGER;
	iMudanca		INTEGER;

	sSQL			TEXT;
	sConector		TEXT DEFAULT 'OR';
	sConexaoRemota	TEXT;
	sBaseAuditoria	TEXT DEFAULT current_database()||'_auditoria';

	tInicioAno				TIMESTAMPTZ;
	lExisteBaseAuditoria	BOOLEAN;
BEGIN
	lExisteBaseAuditoria := EXISTS (SELECT 1 FROM pg_database WHERE datname = sBaseAuditoria);

	sSQL := E'SELECT *, (select string_agg(coalesce((chave).nome_campo[id], \'NULL\') || \'=\' || coalesce((chave).valor[id], \'NULL\'), \'\\n\') from generate_series(1, array_upper((chave).nome_campo, 1)) as id) as chave_text   FROM configuracoes.db_auditoria ';
	sSQL := sSQL || ' WHERE datahora_servidor BETWEEN '||quote_literal(tDataHoraInicio::TEXT)||'::TIMESTAMPTZ AND '||quote_literal(tDataHoraFim::TEXT)||'::TIMESTAMPTZ';
	sSQL := sSQL || '   AND instit  = '||iInstit::TEXT;

	IF sEsquema IS NOT NULL THEN
		sSQL := sSQL || '   AND esquema = '||quote_literal(sEsquema);
	END IF;

	IF sTabela IS NOT NULL THEN
		sSQL := sSQL || '   AND tabela  = '||quote_literal(sTabela);
	END IF;

	IF sUsuario IS NOT NULL THEN
		sSQL := sSQL || '   AND usuario  = '||quote_literal(sUsuario);
	END IF;

	IF iLogsAcessa IS NOT NULL THEN
		sSQL := sSQL || '   AND logsacessa  = '||cast(iLogsAcessa as text);
	END IF;

	IF sCampo IS NOT NULL AND (sValorAntigo IS NOT NULL OR sValorNovo IS NOT NULL) THEN
		sSQL := sSQL || '   AND (((mudancas).nome_campo    @> ARRAY['||quote_literal(sCampo)||'] ';
		sSQL := sSQL || '    OR   (chave).nome_campo       @> ARRAY['||quote_literal(sCampo)||']) ';

		IF sValorAntigo IS NULL AND sValorNovo IS NOT NULL THEN
			sSQL := sSQL || '   AND ((mudancas).valor_novo @> ARRAY['||quote_literal(sValorNovo)||'] AND ';
			sSQL := sSQL || '        ((mudancas).valor_novo)[array_position('||quote_literal(sCampo)||', (mudancas).nome_campo)] = '||quote_literal(sValorNovo)||') ';
			sSQL := sSQL || '    OR ((chave).valor @> ARRAY['||quote_literal(sValorNovo)||'])) ';
		ELSIF sValorAntigo IS NOT NULL AND sValorNovo IS NULL THEN
			sSQL := sSQL || '   AND ((mudancas).valor_antigo @> ARRAY['||quote_literal(sValorAntigo)||'] AND ';
			sSQL := sSQL || '        ((mudancas).valor_antigo)[array_position('||quote_literal(sCampo)||', (mudancas).nome_campo)] = '||quote_literal(sValorAntigo)||') ';
			sSQL := sSQL || '    OR ((chave).valor @> ARRAY['||quote_literal(sValorAntigo)||'])) ';
		ELSE
			sSQL := sSQL || '   AND (((mudancas).valor_antigo @> ARRAY['||quote_literal(sValorAntigo)||'] OR ';
			sSQL := sSQL || '         (mudancas).valor_novo   @> ARRAY['||quote_literal(sValorNovo)||']) AND ';
			sSQL := sSQL || '        (((mudancas).valor_antigo)[array_position('||quote_literal(sCampo)||', (mudancas).nome_campo)] = '||quote_literal(sValorAntigo)||' OR ';
			sSQL := sSQL || '         ((mudancas).valor_novo)[array_position('||quote_literal(sCampo)||', (mudancas).nome_campo)] = '||quote_literal(sValorNovo)||'))';
			sSQL := sSQL || '    OR ((chave).valor @> ARRAY['||quote_literal(sValorAntigo)||'] OR (chave).valor @> ARRAY['||quote_literal(sValorNovo)||'])) ';
		END IF;
	END IF;

	tInicioAno := (extract(year from current_date)||'-01-01 00:00:00.00000')::timestamptz;

	-- SE a Data/Hora de inicio for menor que o Inicio do Ano Corrente 
	-- E  a base de auditoria EXISTIR, entao executa a query na base de auditoria
	IF tDataHoraInicio < tInicioAno AND lExisteBaseAuditoria IS TRUE AND EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'dblink') THEN
		sConexaoRemota := 'auditoria';
		IF array_position(sConexaoRemota, dblink_get_connections()) IS NULL THEN
			PERFORM dblink_connect(sConexaoRemota, 'dbname='||sBaseAuditoria);
		ELSE
			PERFORM dblink_exec(sConexaoRemota, 'DISCARD ALL');
		END IF;
		PERFORM dblink_open(sConexaoRemota, 'log', sSQL);

		LOOP
			SELECT	*
			INTO	rAuditoria
			FROM	dblink_fetch(sConexaoRemota, 'log', 1)
					AS (sequencial         integer,
						esquema            text,
						tabela             text,
						operacao           dm_operacao_tabela,
						transacao          bigint,
						datahora_sessao    timestamp with time zone,
						datahora_servidor  timestamp with time zone,
						tempo              interval,
						usuario            character varying(20),
						chave              tp_auditoria_chave_primaria,
						mudancas           tp_auditoria_mudancas_campo,
						logsacessa         integer,
						instit             integer,
						chave_text         text);
			IF NOT FOUND THEN
				EXIT;
			END IF;

			rRetorno.esquema           = rAuditoria.esquema;
			rRetorno.tabela            = rAuditoria.tabela;
			rRetorno.operacao          = rAuditoria.operacao;
			rRetorno.chave             = rAuditoria.chave_text;
			rRetorno.transacao         = rAuditoria.transacao;
			rRetorno.datahora_sessao   = rAuditoria.datahora_sessao;
			rRetorno.datahora_servidor = rAuditoria.datahora_servidor;
			rRetorno.usuario           = rAuditoria.usuario;
			rRetorno.logsacessa        = rAuditoria.logsacessa;
			rRetorno.instit            = rAuditoria.instit;

			iQtdMudancas := ARRAY_UPPER((rAuditoria.mudancas).nome_campo, 1);

			FOR iMudanca IN 1..iQtdMudancas
			LOOP
				rRetorno.nome_campo   := (rAuditoria.mudancas).nome_campo[iMudanca];
				rRetorno.valor_antigo := (rAuditoria.mudancas).valor_antigo[iMudanca];
				rRetorno.valor_novo   := (rAuditoria.mudancas).valor_novo[iMudanca];

				RETURN NEXT rRetorno;
			END LOOP;

		END LOOP;

		PERFORM dblink_close(sConexaoRemota, 'log');
	END IF;

	-- SE o ano da Data/Hora de inicio for igual ao ano da Data/Hora corrente 
	-- OU a base de auditoria NAO EXISTIR, entao executa a query na base corrente
	IF extract(year from tDataHoraInicio) = extract(year from current_date) OR lExisteBaseAuditoria IS FALSE THEN

		OPEN rCursorRetorno FOR EXECUTE sSQL;

		LOOP
			FETCH rCursorRetorno INTO rAuditoria;
			IF NOT FOUND THEN
				EXIT;
			END IF;

			rRetorno.esquema           = rAuditoria.esquema;
			rRetorno.tabela            = rAuditoria.tabela;
			rRetorno.operacao          = rAuditoria.operacao;
			rRetorno.chave             = rAuditoria.chave_text;
			rRetorno.transacao         = rAuditoria.transacao;
			rRetorno.datahora_sessao   = rAuditoria.datahora_sessao;
			rRetorno.datahora_servidor = rAuditoria.datahora_servidor;
			rRetorno.usuario           = rAuditoria.usuario;
			rRetorno.logsacessa        = rAuditoria.logsacessa;
			rRetorno.instit            = rAuditoria.instit;

			iQtdMudancas := ARRAY_UPPER((rAuditoria.mudancas).nome_campo, 1);

			FOR iMudanca IN 1..iQtdMudancas
			LOOP
				rRetorno.nome_campo   := (rAuditoria.mudancas).nome_campo[iMudanca];
				rRetorno.valor_antigo := (rAuditoria.mudancas).valor_antigo[iMudanca];
				rRetorno.valor_novo   := (rAuditoria.mudancas).valor_novo[iMudanca];

				RETURN NEXT rRetorno;
			END LOOP;

		END LOOP;

		CLOSE rCursorRetorno;
	END IF;

	RETURN;
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION configuracoes.fc_auditoria_consulta_mudancas(
  tDataHoraInicio TIMESTAMP,
  tDataHoraFim    TIMESTAMP,
  sEsquema        TEXT,
  sTabela         TEXT,
  sUsuario        TEXT,
  iLogsAcessa     INTEGER,
  iInstit         INTEGER
) RETURNS SETOF configuracoes.tp_auditoria_consulta_mudancas AS
$$
  SELECT *
    FROM configuracoes.fc_auditoria_consulta_mudancas($1, $2, $3, $4, $5, $6, $7, NULL, NULL, NULL);
$$
LANGUAGE sql;


CREATE OR REPLACE FUNCTION configuracoes.fc_logsacessa_consulta(
	tDataHoraInicio TIMESTAMP,
	tDataHoraFim    TIMESTAMP,
	iInstit         INTEGER,
	sWhere          TEXT
) RETURNS SETOF configuracoes.db_logsacessa AS
$$
DECLARE
	rRetorno		configuracoes.db_logsacessa;

	rCursorRetorno	REFCURSOR;

	iQtdMudancas	INTEGER;
	iMudanca		INTEGER;

	sSQL			TEXT;
	sConexaoRemota	TEXT;
	sBaseAuditoria	TEXT DEFAULT current_database()||'_auditoria';

	tInicioAno				TIMESTAMPTZ;
	lExisteBaseAuditoria	BOOLEAN;
BEGIN
	lExisteBaseAuditoria := EXISTS (SELECT 1 FROM pg_database WHERE datname = sBaseAuditoria);

	sSQL := E'SELECT * FROM configuracoes.db_logsacessa';
	sSQL := sSQL || ' WHERE data BETWEEN '||quote_literal(tDataHoraInicio::DATE::TEXT)||'::DATE AND '||quote_literal(tDataHoraFim::DATE::TEXT)||'::DATE';
	sSQL := sSQL || '   AND instit  = '||iInstit::TEXT;
	sSQL := sSQL || COALESCE(' AND '||sWhere, '');

	tInicioAno := (extract(year from current_date)||'-01-01 00:00:00.00000')::timestamptz;

	-- SE a Data/Hora de inicio for menor que o Inicio do Ano Corrente 
	-- E  a base de auditoria EXISTIR, entao executa a query na base de auditoria
	IF tDataHoraInicio < tInicioAno AND lExisteBaseAuditoria IS TRUE AND EXISTS (SELECT 1 FROM pg_extension WHERE extname = 'dblink') THEN
		sConexaoRemota := 'auditoria';
		IF array_position(sConexaoRemota, dblink_get_connections()) IS NULL THEN
			PERFORM dblink_connect(sConexaoRemota, 'dbname='||sBaseAuditoria);
		ELSE
			PERFORM dblink_exec(sConexaoRemota, 'DISCARD ALL');
		END IF;
		PERFORM dblink_open(sConexaoRemota, 'log', sSQL);

		LOOP
			SELECT	*
			INTO	rRetorno
			FROM	dblink_fetch(sConexaoRemota, 'log', 1)
					AS (codsequen   integer,
						ip          character varying(50),
						data        date,
						hora        character varying(10),
						arquivo     text,
						obs         text,
						id_usuario  integer,
						id_modulo   integer,
						id_item     integer,
						coddepto    integer,
						instit      integer,
						auditoria   boolean);

			IF NOT FOUND THEN
				EXIT;
			END IF;

			RETURN NEXT rRetorno;
		END LOOP;

		PERFORM dblink_close(sConexaoRemota, 'log');
	END IF;

	-- SE o ano da Data/Hora de inicio for igual ao ano da Data/Hora corrente 
	-- OU a base de auditoria NAO EXISTIR, entao executa a query na base corrente
	--IF extract(year from tDataHoraInicio) = extract(year from current_date) OR lExisteBaseAuditoria IS FALSE THEN

		OPEN rCursorRetorno FOR EXECUTE sSQL;

		LOOP
			FETCH rCursorRetorno INTO rRetorno;
			IF NOT FOUND THEN
				EXIT;
			END IF;

			RETURN NEXT rRetorno;
		END LOOP;

		CLOSE rCursorRetorno;
	--END IF;

	RETURN;
END;
$$
LANGUAGE plpgsql;create or replace function fc_baixabanco( cod_ret integer, datausu date) returns varchar as
$$
declare

  retorno                          boolean default false;

  r_codret                         record;
  r_idret                          record;
  r_divold                         record;
  r_receitas                       record;
  r_idunica                        record;
  q_disrec                         record;
  r_testa                          record;

  x_totreg                         float8;
  valortotal                       float8;
  valorjuros                       float8;
  valormulta                       float8;
  fracao                           float8;
  nVlrRec                          float8;
  nVlrTfr                          float8;
  nVlrRecm                         float8;
  nVlrRecj                         float8;

  _testeidret                      integer;
  vcodcla                          integer;
  gravaidret                       integer;
  v_nextidret                      integer;
  conta                            integer;

  v_contador                       integer;
  v_somador                        numeric(15,2) default 0;
  v_valor                          numeric(15,2) default 0;

  v_valor_sem_round                float8;
  v_diferenca_round                float8;

  dDataCalculoRecibo               date;
  dDataReciboUnica                 date;

  v_contagem                       integer;
  primeirarec                      integer default 0;
  primeirarecj                     integer default 0;
  primeirarecm                     integer default 0;
  primeiranumpre                   integer;
  primeiranumpar                   integer;

  nBloqueado                       integer;

  valorlanc                        float8;
  valorlancj                       float8;
  valorlancm                       float8;

  oidrec                           int8;

  autentsn                         boolean;

  valorrecibo                      float8;

  v_total1                         float8 default 0;
  v_total2                         float8 default 0;

  v_estaemrecibopaga               boolean;
  v_estaemrecibo                   boolean;
  v_estaemarrecadnormal            boolean;
  v_estaemarrecadunica             boolean;
  lVerificaReceita                 boolean;
  lClassi                          boolean;
  lReciboInvalidoPorTrocaDeReceita boolean default false;
  lReciboPossuiPgtoParcial         boolean default false;

  nSimDivold                       integer;
  nNaoDivold                       integer;
  iQtdeParcelasAberto              integer;
  iQtdeParcelasRecibo              integer;

  nValorSimDivold                  numeric(15,2) default 0;
  nValorNaoDivold                  numeric(15,2) default 0;
  nValorTotDivold                  numeric(15,2) default 0;

  nValorPagoDivold                 numeric(15,2) default 0;
  nTotValorPagoDivold              numeric(15,2) default 0;

  nTotalRecibo                     numeric(15,2) default 0;
  nTotalNovosRecibos               numeric(15,2) default 0;

  nTotalDisbancoOriginal           numeric(15,2) default 0;
  nTotalDisbancoDepois             numeric(15,2) default 0;

  iNumnovDivold                    integer;
  iIdret                           integer;
  v_diferenca                      float8 default 0;

  cCliente                         varchar(100);
  iIdRetProcessar                  integer;

  -- Abatimentos
  lAtivaPgtoParcial                boolean default false;
  lInsereJurMulCorr                boolean default true;

  iAbatimento                      integer;
  iAbatimentoArreckey              integer;
  iArreckey                        integer;
  iArrecadCompos                   integer;
  iNumpreIssVar                    integer;
  iNumpreRecibo                    integer;
  iNumpreReciboAvulso              integer;
  iTipoDebitoPgtoParcial           integer;
  iTipoAbatimento                  integer;
  iTipoReciboAvulso                integer;
  iReceitaCredito                  integer;
  iRows                            integer;
  iSeqIdRet                        integer;
  iNumpreAnterior                  integer default 0;

  nVlrCalculado                    numeric(15,2) default 0;
  nVlrPgto                         numeric(15,2) default 0;
  nVlrJuros                        numeric(15,2) default 0;
  nVlrMulta                        numeric(15,2) default 0;
  nVlrCorrecao                     numeric(15,2) default 0;
  nVlrHistCompos                   numeric(15,2) default 0;
  nVlrJurosCompos                  numeric(15,2) default 0;
  nVlrMultaCompos                  numeric(15,2) default 0;
  nVlrCorreCompos                  numeric(15,2) default 0;
  nVlrPgtoParcela                  numeric(15,2) default 0;
  nVlrDiferencaPgto                numeric(15,2) default 0;
  nVlrTotalRecibopaga              numeric(15,2) default 0;
  nVlrTotalHistorico               numeric(15,2) default 0;
  nVlrTotalJuroMultaCorr           numeric(15,2) default 0;
  nVlrReceita                      numeric(15,2) default 0;
  nVlrAbatido                      numeric(15,2) default 0;
  nVlrDiferencaDisrec              numeric(15,2) default 0;
  nVlrInformado                    numeric(15,2) default 0;
  nVlrTotalInformado               numeric(15,2) default 0;

  nVlrToleranciaPgtoParcial        numeric(15,2) default 0;
  nVlrToleranciaCredito            numeric(15,2) default 0;

  nPercPgto                        numeric;
  nPercReceita                     numeric;
  nPercDesconto                    numeric;

  iCountDebitoOrigem               integer default 0;
  iCountRecibopaga                 integer default 0;

  iAnoSessao                       integer;
  iInstitSessao                    integer;

  rReciboPaga                      record;
  rContador                        record;
  rRecordDisbanco                  record;
  rRecordBanco                     record;
  rRecord                          record;
  rRecibo                          record;
  rAcertoDiferenca                 record;

  /**
   * variavel de controle do numpre , se tiver ativado o pgto parcial, e essa variavel for dif. de 0
   * os numpres a partir dele serão tratados como pgto parcial, abaixo, sem pgto parcial
   */
  iNumprePagamentoParcial          integer default 0;

  lRaise                           boolean default false;
  sDebug                           text;

begin

  -- Busca Dados Sessão
  iInstitSessao := cast(fc_getsession('DB_instit') as integer);
  iAnoSessao    := cast(fc_getsession('DB_anousu') as integer);
  lRaise        := ( case when fc_getsession('DB_debugon') is null then false else true end );

  if lRaise is true then
    if trim(fc_getsession('db_debug')) <> '' then
      perform fc_debug('  <BaixaBanco>  - INICIANDO PROCESSAMENTO... ',lRaise,false,false);
    else
      perform fc_debug('  <BaixaBanco>  - INICIANDO PROCESSAMENTO... ',lRaise,true,false);
    end if;
  end if;

  /**
   * Verifica se o numpre pertence a outra instituição e insere na tmpnaoprocessar
   * para gerar inconsistencia
   */
  insert into tmpnaoprocessar
       select idret
         from disbanco
              inner join arreinstit on arreinstit.k00_numpre = disbanco.k00_numpre
        where arreinstit.k00_instit <> iInstitSessao
          and disbanco.codret       = cod_ret;

  /**
   * Verifica se esta configurado Pagamento Parcial
   * Buscamos o valor base setado na numpref campo k03_numprepgtoparcial
   * Consulta o tipo de debito configurado para Recibo Avulso
   * Consulta o parametro de tolerancia para pagamento parcial
   */
  select k03_pgtoparcial,
         k03_numprepgtoparcial,
         k03_reciboprot,
         coalesce(numpref.k03_toleranciapgtoparc,0)::numeric(15, 2),
         coalesce(numpref.k03_toleranciacredito,0)::numeric(15, 2)
    into lAtivaPgtoParcial,
         iNumprePagamentoParcial,
         iTipoReciboAvulso,
         nVlrToleranciaPgtoParcial,
         nVlrToleranciaCredito
    from numpref
   where numpref.k03_anousu = iAnoSessao
     and numpref.k03_instit = iInstitSessao;

   if lRaise is true then
     perform fc_debug('  <BaixaBanco>  - PARAMETROS DO NUMPREF '                                  ,lRaise,false,false);
     perform fc_debug('  <BaixaBanco>  - lAtivaPgtoParcial:  '||lAtivaPgtoParcial                 ,lRaise,false,false);
     perform fc_debug('  <BaixaBanco>  - iNumprePagamentoParcial:  '||iNumprePagamentoParcial     ,lRaise,false,false);
     perform fc_debug('  <BaixaBanco>  - iTipoReciboAvulso:  '||iTipoReciboAvulso                 ,lRaise,false,false);
     perform fc_debug('  <BaixaBanco>  - nVlrToleranciaPgtoParcial:  '||nVlrToleranciaPgtoParcial ,lRaise,false,false);
     perform fc_debug('  <BaixaBanco>  - nVlrToleranciaCredito:  '||nVlrToleranciaCredito         ,lRaise,false,false);
   end if;

   if iTipoReciboAvulso is null then
     return '2 - Operacao Cancelada. Tipo de Debito nao configurado para Recibo Avulso. ';
   end if;

    select k00_conta,
           autent,
           count(*)
      into conta,
           autentsn,
           vcodcla
      from disbanco
           inner join disarq on disarq.codret = disbanco.codret
     where disbanco.codret = cod_ret
       and disbanco.classi is false
       and disbanco.instit = iInstitSessao
  group by disarq.k00_conta,
           disarq.autent;

  if vcodcla is null or vcodcla = 0 then
    return '3 - ARQUIVO DE RETORNO DO BANCO JA CLASSIFICADO';
  end if;
  if conta is null or conta = 0 then
    return '4 - SEM CONTA CADASTRADA PARA ARRECADACAO. OPERACAO CANCELADA.';
  end if;

  if lRaise is true then
    perform fc_debug('  <BaixaBanco>  - autentsn:  '||autentsn,lRaise,false,false);
  end if;

  select upper(munic)
  into cCliente
  from db_config
  where codigo = iInstitSessao;

  if autentsn is false then

    select nextval('discla_codcla_seq')
      into vcodcla;

    insert into discla ( codcla,  codret,  dtcla,   instit )
                values ( vcodcla, cod_ret, datausu, iInstitSessao );

   /**
    * Insere dados da baixa de Banco nesta tabela pois na pl que a chama o arquivo e divido em mais de uma classificacao
    */
   if lRaise is true then
     perform fc_debug('  <BaixaBanco> - 276 - '||cod_ret||','||vcodcla,lRaise,false,false);
   end if;

   insert into   tmp_classificaoesexecutadas("codigo_retorno", "codigo_classificacao")
          values (cod_ret, vcodcla);

    if lRaise is true then
      perform fc_debug('  <BaixaBanco>  - vcodcla: '||vcodcla,lRaise,false,false);
    end if;

  else
    if lRaise is true then
      perform fc_debug('  <BaixaBanco>  - nao '||autentsn,lRaise,false,false);
    end if;
  end if;

/**
 * Aqui inicia pre-processamento do Pagamento Parcial
 */
  if lAtivaPgtoParcial is true then

    if lRaise then
      perform fc_debug('  <PgtoParcial>  - Parametro pagamento parcial ativado !',lRaise,false,false);
    end if;

    /*******************************************************************************************************************
     *  VERIFICA RECIBO AVULSO
     ******************************************************************************************************************/
    -- Caso exista algum recibo avulso que jah esteja pago, o sistema gera um novo recibo avulso
    if lRaise then
      perform fc_debug('  <PgtoParcial> Regra 1 - VERIFICA RECIBO AVULSO',lRaise,false,false);
    end if;

    for rRecordDisbanco in

      select disbanco.*
        from disbanco
             inner join recibo   on recibo.k00_numpre   = disbanco.k00_numpre
             inner join arrepaga on arrepaga.k00_numpre = disbanco.k00_numpre
       where disbanco.codret = cod_ret
         and disbanco.classi is false
         and case when iNumprePagamentoParcial = 0
                  then true
                  else disbanco.k00_numpre > iNumprePagamentoParcial
              end
         and disbanco.instit = iInstitSessao

    loop

      select nextval('numpref_k03_numpre_seq')
        into iNumpreRecibo;

      if lRaise is true then
        perform fc_debug('  <PgtoParcial>  - lança recibo avulso já pago ',lRaise,false,false);
      end if;

      insert into recibo ( k00_numcgm,
                           k00_dtoper,
                           k00_receit,
                           k00_hist,
                           k00_valor,
                           k00_dtvenc,
                           k00_numpre,
                           k00_numpar,
                           k00_numtot,
                           k00_numdig,
                           k00_tipo,
                           k00_tipojm,
                           k00_codsubrec,
                           k00_numnov
                         ) select k00_numcgm,
                                  k00_dtoper,
                                  k00_receit,
                                  k00_hist,
                                  k00_valor,
                                  k00_dtvenc,
                                  iNumpreRecibo,
                                  k00_numpar,
                                  k00_numtot,
                                  k00_numdig,
                                  k00_tipo,
                                  k00_tipojm,
                                  k00_codsubrec,
                                  k00_numnov
                             from recibo
                            where recibo.k00_numpre = rRecordDisbanco.k00_numpre;

      insert into reciborecurso ( k00_sequen, k00_numpre, k00_recurso )
           select nextval('reciborecurso_k00_sequen_seq'),
                  iNumpreRecibo,
                  k00_recurso
             from reciborecurso
            where reciborecurso.k00_numpre = rRecordDisbanco.k00_numpre;

      insert into arrehist ( k00_numpre,
                             k00_numpar,
                             k00_hist,
                             k00_dtoper,
                             k00_hora,
                             k00_id_usuario,
                             k00_histtxt,
                             k00_limithist,
                             k00_idhist
                           ) values (
                             iNumpreRecibo,
                             1,
                             502,
                             datausu,
                             '00:00',
                             1,
                             'Recibo avulso referente a baixa do recibo avulso ja pago - Numpre : '||rRecordDisbanco.k00_numpre,
                             null,
                             nextval('arrehist_k00_idhist_seq')
                          );

      insert into arreproc ( k80_numpre,
                             k80_codproc )  select iNumpreRecibo,
                                                   arreproc.k80_codproc
                                              from arreproc
                                             where arreproc.k80_numpre = rRecordDisbanco.k00_numpre;

      insert into arrenumcgm ( k00_numpre,
                               k00_numcgm ) select iNumpreRecibo,
                                                   arrenumcgm.k00_numcgm
                                              from arrenumcgm
                                             where arrenumcgm.k00_numpre = rRecordDisbanco.k00_numpre;

      insert into arrematric ( k00_numpre,
                               k00_matric ) select iNumpreRecibo,
                                                   arrematric.k00_matric
                                              from arrematric
                                             where arrematric.k00_numpre = rRecordDisbanco.k00_numpre;

      insert into arreinscr ( k00_numpre,
                              k00_inscr )   select iNumpreRecibo,
                                                   arreinscr.k00_inscr
                                              from arreinscr
                                             where arreinscr.k00_numpre = rRecordDisbanco.k00_numpre;

      if lRaise then
        perform fc_debug('  <PgtoParcial>  - 1 - Alterando numpre disbanco ! novo numpre : '||iNumpreRecibo,lRaise,false,false);
      end if;

      update disbanco
         set k00_numpre = iNumpreRecibo
       where idret      = rRecordDisbanco.idret;

    end loop; --Fim do loop de validação da regra 1 para recibo avulso


    /*********************************************************************************
     *  GERA RECIBO PARA CARNE
     ********************************************************************************/
    -- Verifica se o pagamento eh referente a um Carne
    -- Caso seja entao eh gerado um recibopaga para os debitos
    -- do arrecad e acertado o numpre na tabela disbanco
    if lRaise then
      perform fc_debug('  <PgtoParcial> Regra 2 - GERA RECIBO PARA CARNE!',lRaise,false,false);
    end if;

    for rRecordDisbanco in select disbanco.idret,
                                  disbanco.dtpago,
                                  disbanco.k00_numpre,
                                  disbanco.k00_numpar,
                                  ( select k00_dtvenc
                                      from (select k00_dtvenc
                                              from arrecad
                                             where arrecad.k00_numpre = disbanco.k00_numpre
                                              and case
                                                    when disbanco.k00_numpar = 0 then true
                                                    else arrecad.k00_numpar = disbanco.k00_numpar
                                                  end
                                           union
                                            select k00_dtvenc
                                              from arrecant
                                             where arrecant.k00_numpre = disbanco.k00_numpre
                                               and case
                                                     when disbanco.k00_numpar = 0 then true
                                                     else arrecant.k00_numpar = disbanco.k00_numpar
                                                   end
                                           union
                                            select k00_dtvenc
                                              from arreold
                                             where arreold.k00_numpre = disbanco.k00_numpre
                                               and case
                                                     when disbanco.k00_numpar = 0 then true
                                                     else arreold.k00_numpar = disbanco.k00_numpar
                                                   end
                                            ) as x limit 1
                                  ) as data_vencimento_debito
                            from disbanco
                            where disbanco.codret = cod_ret
                              and disbanco.classi is false
                              and disbanco.instit = iInstitSessao
                              and case when iNumprePagamentoParcial = 0
                                       then true
                                       else disbanco.k00_numpre > iNumprePagamentoParcial
                                   end
                              and exists ( select 1
                                             from arrecad
                                            where arrecad.k00_numpre = disbanco.k00_numpre
                                              and case
                                                    when disbanco.k00_numpar = 0 then true
                                                    else arrecad.k00_numpar  = disbanco.k00_numpar
                                                  end
                                            union all
                                           select 1
                                             from arrecant
                                            where arrecant.k00_numpre = disbanco.k00_numpre
                                              and case
                                                    when disbanco.k00_numpar = 0 then true
                                                    else arrecant.k00_numpar = disbanco.k00_numpar
                                                  end
                                           union all
                                           select 1
                                             from arreold
                                            where arreold.k00_numpre = disbanco.k00_numpre
                                              and case
                                                    when disbanco.k00_numpar = 0 then true
                                                    else arreold.k00_numpar = disbanco.k00_numpar
                                                  end
                                            limit 1 )
                              and not exists ( select 1
                                                 from issvar
                                                where issvar.q05_numpre = disbanco.k00_numpre
                                                  and issvar.q05_numpar = disbanco.k00_numpar
                                                limit 1 )
                              and not exists ( select 1
                                                 from tmpnaoprocessar
                                                where tmpnaoprocessar.idret = disbanco.idret )
                         order by disbanco.idret

    loop

      select nextval('numpref_k03_numpre_seq')
        into iNumpreRecibo;

      if lRaise is true then
        perform fc_debug('  <PgtoParcial>  - Processando geracao de recibo para - Numpre: '||rRecordDisbanco.k00_numpre||'  Numpar: '||rRecordDisbanco.k00_numpar,lRaise,false,false);
      end if;

      select distinct
             arrecad.k00_tipo
        into rRecord
        from arrecad
       where arrecad.k00_numpre = rRecordDisbanco.k00_numpre
         and case
               when rRecordDisbanco.k00_numpar = 0
                 then true
               else arrecad.k00_numpar = rRecordDisbanco.k00_numpar
             end
       limit 1;

      if found then

        if lRaise is true then
          perform fc_debug('  <PgtoParcial>  - Encontrou no arrecad - Gerando Recibo para o debito - Numpre: '||rRecordDisbanco.k00_numpre||'  Numpar: '||rRecordDisbanco.k00_numpar,lRaise,false,false);
        end if;

        select k00_codbco, k00_codage, fc_numbco(k00_codbco,k00_codage) as fc_numbco
          into rRecordBanco
          from arretipo
         where k00_tipo = rRecord.k00_tipo;

        insert into db_reciboweb ( k99_numpre,
                                   k99_numpar,
                                   k99_numpre_n,
                                   k99_codbco,
                                   k99_codage,
                                   k99_numbco,
                                   k99_desconto,
                                   k99_tipo,
                                   k99_origem
                                 ) values (
                                   rRecordDisbanco.k00_numpre,
                                   rRecordDisbanco.k00_numpar,
                                   iNumpreRecibo,
                                   coalesce(rRecordBanco.k00_codbco,0),
                                   coalesce(rRecordBanco.k00_codage,'0'),
                                   rRecordBanco.fc_numbco,
                                   0,
                                   2,
                                   1 );

        dDataCalculoRecibo := rRecordDisbanco.data_vencimento_debito;

        /**
         * Trabalhar este if
         */
        select ru.k00_dtvenc
          into dDataReciboUnica
          from recibounica ru
         where ru.k00_numpre = rRecordDisbanco.k00_numpre
           and rRecordDisbanco.k00_numpar = 0
           and ru.k00_dtvenc >= rRecordDisbanco.dtpago
         order by k00_dtvenc
         limit 1;

        perform fc_debug('  <PgtoParcial>  - dDataReciboUnica:' || dDataReciboUnica, lRaise);

        if found then
          dDataCalculoRecibo := dDataReciboUnica;
        end if;

        perform fc_debug('  <PgtoParcial>  - dDataCalculoRecibo:' || dDataCalculoRecibo, lRaise);

        if lRaise is true then
          perform fc_debug('  <PgtoParcial>  - ');
          perform fc_debug('  <PgtoParcial>  ---------------- Validando datas de vencimento ----------------');
          perform fc_debug('  <PgtoParcial>  - Opções:');
          perform fc_debug('  <PgtoParcial>  - 1 - Próximo dia util do vencimento do arrecad : ' || fc_proximo_dia_util(dDataCalculoRecibo));
          perform fc_debug('  <PgtoParcial>  - 2 - Data do Pagamento Bancário                : ' || rRecordDisbanco.dtpago);
          perform fc_debug('  <PgtoParcial>  ---------------------------------------------------------------');
          perform fc_debug('  <PgtoParcial>  - ');
          perform fc_debug('  <PgtoParcial>  - Opção Default : "1" ');
        end if;

        if rRecordDisbanco.dtpago > fc_proximo_dia_util(dDataCalculoRecibo)  then -- Paguei Depois do Vencimento

          dDataCalculoRecibo := rRecordDisbanco.dtpago;

          if lRaise is true then
            perform fc_debug('  <PgtoParcial>  - Alterando para Opção de Vencimento "2" ');
          end if;
        end if;

        if lRaise is true then

          perform fc_debug('  <PgtoParcial>');
          perform fc_debug('  <PgtoParcial>  - Rodando FC_RECIBO'    );
          perform fc_debug('  <PgtoParcial>  --- iNumpreRecibo      : ' || iNumpreRecibo      );
          perform fc_debug('  <PgtoParcial>  --- dDataCalculoRecibo : ' || dDataCalculoRecibo );
          perform fc_debug('  <PgtoParcial>  --- iAnoSessao         : ' || iAnoSessao         );
          perform fc_debug('  <PgtoParcial>');
        end if;

        select * from fc_recibo(iNumpreRecibo,dDataCalculoRecibo,dDataCalculoRecibo,iAnoSessao)
          into rRecibo;

        if rRecibo.rlerro is true then
          return '5 - '||rRecibo.rvmensagem||' Erro ao processar idret '||rRecordDisbanco.idret||'.';
        end if;

      else

        if lRaise is true then
          perform fc_debug('  <PgtoParcial>  - Nao encontrou no arrecad - Gerando Recibo para o debito - Numpre: '||rRecordDisbanco.k00_numpre||'  Numpar: '||rRecordDisbanco.k00_numpar,lRaise,false,false);
        end if;

        select distinct
               arrecant.k00_tipo
          into rRecord
          from arrecant
         where arrecant.k00_numpre = rRecordDisbanco.k00_numpre
         union
        select distinct
               arreold.k00_tipo
          from arreold
         where arreold.k00_numpre = rRecordDisbanco.k00_numpre
         limit 1;

        select k00_codbco,
               k00_codage,
               fc_numbco(k00_codbco,k00_codage) as fc_numbco
          into rRecordBanco
          from arretipo
         where k00_tipo = rRecord.k00_tipo;

        insert into db_reciboweb ( k99_numpre,
                                   k99_numpar,
                                   k99_numpre_n,
                                   k99_codbco,
                                   k99_codage,
                                   k99_numbco,
                                   k99_desconto,
                                   k99_tipo,
                                   k99_origem
                                 ) values (
                                   rRecordDisbanco.k00_numpre,
                                   rRecordDisbanco.k00_numpar,
                                   iNumpreRecibo,
                                   coalesce(rRecordBanco.k00_codbco,0),
                                   coalesce(rRecordBanco.k00_codage,'0'),
                                   rRecordBanco.fc_numbco,
                                   0,
                                   2,
                                   1 );

        if lRaise is true then
          perform fc_debug('<PgtoParcial>  - Lançou recibo caso sejá carne ',lRaise,false,false);
        end if;

        insert into recibopaga ( k00_numcgm,
                                 k00_dtoper,
                                 k00_receit,
                                 k00_hist,
                                 k00_valor,
                                 k00_dtvenc,
                                 k00_numpre,
                                 k00_numpar,
                                 k00_numtot,
                                 k00_numdig,
                                 k00_conta,
                                 k00_dtpaga,
                                 k00_numnov )
                          select k00_numcgm,
                                 k00_dtoper,
                                 k00_receit,
                                 k00_hist,
                                 k00_valor,
                                 k00_dtvenc,
                                 k00_numpre,
                                 k00_numpar,
                                 k00_numtot,
                                 k00_numdig,
                                 0,
                                 datausu,
                                 iNumpreRecibo
                            from arrecant
                           where arrecant.k00_numpre = rRecordDisbanco.k00_numpre
                             and case
                                   when rRecordDisbanco.k00_numpar = 0 then true
                                     else rRecordDisbanco.k00_numpar = arrecant.k00_numpar
                                 end
                           union
                          select k00_numcgm,
                                 k00_dtoper,
                                 k00_receit,
                                 k00_hist,
                                 k00_valor,
                                 k00_dtvenc,
                                 k00_numpre,
                                 k00_numpar,
                                 k00_numtot,
                                 k00_numdig,
                                 0,
                                 datausu,
                                 iNumpreRecibo
                            from arreold
                           where arreold.k00_numpre = rRecordDisbanco.k00_numpre
                             and case
                                   when rRecordDisbanco.k00_numpar = 0 then true
                                     else rRecordDisbanco.k00_numpar = arreold.k00_numpar
                                 end;

      end if;

      if rRecordDisbanco.k00_numpar = 0 then
        insert into tmplista_unica values (rRecordDisbanco.idret);
      end if;

      -- Acerta o conteudo da disbanco, alterando o numpre do carne pelo da recibopaga
      if lRaise then
        perform fc_debug('  <PgtoParcial>  - Acertando numpre do recibo gerado para o carne (arreold ou arrecant) numnov : '||iNumpreRecibo,lRaise,false,false);
      end if;

      if lRaise then
        perform fc_debug('  <PgtoParcial>  - 2 - Alterando numpre disbanco ! novo numpre : '||iNumpreRecibo,lRaise,false,false);
      end if;

      update disbanco
         set k00_numpre = iNumpreRecibo,
             k00_numpar = 0
       where idret = rRecordDisbanco.idret;

      update tmpdisbanco_inicio_original
         set k00_numpre = iNumpreRecibo
       where idret = rRecordDisbanco.idret;

    end loop;

    if lRaise then
      perform fc_debug('  <PgtoParcial>  - Final processamento para geracao recibo para carne, '||clock_timestamp(),lRaise,false,false);
    end if;

    /*******************************************************************************************************************
     *  NÃO PROCESSA PAGAMENTOS DUPLICADOS EM RECIBOS DIFERENTES
     ******************************************************************************************************************/
    if lRaise then
      perform fc_debug('  <PgtoParcial> Regra 4 - NAO PROCESSA PAGAMENTOS DUPLICADOS EM RECIBOS DIFERENTES!',lRaise,false,false);
    end if;
    for r_idret in

        select x.k00_numpre,
               x.k00_numpar,
               count(x.idret) as ocorrencias
          from ( select distinct
                        recibopaga.k00_numpre,
                        recibopaga.k00_numpar,
                        disbanco.idret
                   from disbanco
                        inner join recibopaga on recibopaga.k00_numnov = disbanco.k00_numpre
                  where disbanco.codret = cod_ret
                    and disbanco.classi is false
                    and case when iNumprePagamentoParcial = 0
                             then true
                             else disbanco.k00_numpre > iNumprePagamentoParcial
                         end
                    and disbanco.instit = iInstitSessao ) as x
                left  join numprebloqpag  on numprebloqpag.ar22_numpre = x.k00_numpre
                                         and numprebloqpag.ar22_numpar = x.k00_numpar
         where numprebloqpag.ar22_numpre is null
             and not exists ( select 1
                                from tmpnaoprocessar
                               where tmpnaoprocessar.idret = x.idret )
         group by x.k00_numpre,
                  x.k00_numpar
           having count(x.idret) > 1

    loop

      if lRaise is true then
        perform fc_debug('  <PgtoParcial>  - ######## Incluido na tmpnaoprocessar',lRaise,false,false);
      end if;

      for iRows in 1..( r_idret.ocorrencias - 1 ) loop

          perform fc_debug('  <PgtoParcial>  - Inserindo na tmpnaoprocessar - Pagamento duplicado em recibos diferentes', lRaise);
          perform fc_debug('  <PgtoParcial>  - ######## Incluido na tmpnaoprocessar numpre: ' || r_idret.k00_numpre,      lRaise);
          perform fc_debug('  <PgtoParcial>                                         numpar: ' || r_idret.k00_numpar,      lRaise);

          -- @todo - verificar esta logica, a principio parece estar inserindo aqui o mesmo recibo
          -- em arquivos (codret) diferentes
          insert into tmpnaoprocessar select coalesce(max(disbanco.idret),0)
                                        from disbanco
                                       where disbanco.codret = cod_ret
                                         and case when iNumprePagamentoParcial = 0
                                                  then true
                                                  else disbanco.k00_numpre > iNumprePagamentoParcial
                                              end
                                         and disbanco.classi is false
                                         and disbanco.instit = iInstitSessao
                                         and disbanco.k00_numpre in ( select recibopaga.k00_numnov
                                                                        from recibopaga
                                                                       where recibopaga.k00_numpre = r_idret.k00_numpre
                                                                         and recibopaga.k00_numpar = r_idret.k00_numpar )
                                         and not exists ( select 1
                                                            from tmpnaoprocessar
                                                           where tmpnaoprocessar.idret = disbanco.idret );

      end loop;

    end loop;


    /*********************************************************************************************************************
     *  EFETUA AJUSTE NOS RECIBOS QUE TENHAM ALGUMA PARCELA DE SUA ORIGEM, PAGA/CANCELADA/IMPORTADA PARA DIVIDA/PARCELADA
     *********************************************************************************************************************/
    --
    -- Processa somente os recibos que tenham todos debitos em aberto ou todos pagos
    if lRaise then
      perform fc_debug('  <PgtoParcial> Regra 5 - EFETUA AJUSTE NOS RECIBOS QUE TENHAM ALGUMA PARCELA DE SUA ORIGEM',lRaise,false,false);
      perform fc_debug('  <PgtoParcial>           PAGA/CANCELADA/IMPORTADA PARA DIVIDA/PARCELADA!',lRaise,false,false);
    end if;

    for r_idret in
        select disbanco.idret,
               disbanco.k00_numpre as numpre,
               r.k00_numpre,
               r.k00_numpar,
               (select count(*)
                  from (select distinct
                               recibopaga.k00_numpre,
                               recibopaga.k00_numpar
                          from recibopaga
                               inner join arrecad on arrecad.k00_numpre = recibopaga.k00_numpre
                                                 and arrecad.k00_numpar = recibopaga.k00_numpar
                         where recibopaga.k00_numnov = disbanco.k00_numpre ) as x
               ) as qtd_aberto,
               (select count(*)
                  from (select distinct
                               k00_numpre,
                               k00_numpar
                          from recibopaga
                          where recibopaga.k00_numnov = disbanco.k00_numpre ) as x
               ) as qtd_recibo,
               exists ( select 1
                          from arrecad a
                         where a.k00_numpre = r.k00_numpre
                           and a.k00_numpar = r.k00_numpar ) as arrecad,
               exists ( select 1
                          from arrecant a
                         where a.k00_numpre = r.k00_numpre
                           and a.k00_numpar = r.k00_numpar ) as arrecant,
               exists ( select 1
                          from arreold a
                         where a.k00_numpre = r.k00_numpre
                           and a.k00_numpar = r.k00_numpar ) as arreold
          from disbanco
               inner join recibopaga r   on r.k00_numnov              = disbanco.k00_numpre
               left  join numprebloqpag  on numprebloqpag.ar22_numpre = disbanco.k00_numpre
                                        and numprebloqpag.ar22_numpar = disbanco.k00_numpar
         where disbanco.codret = cod_ret
           and disbanco.classi is false
           and disbanco.instit = iInstitSessao
           and numprebloqpag.ar22_numpre is null
           and case when iNumprePagamentoParcial = 0
                    then true
                    else disbanco.k00_numpre > iNumprePagamentoParcial
                end
           and not exists ( select 1
                              from tmpnaoprocessar
                             where tmpnaoprocessar.idret = disbanco.idret )
           order by disbanco.codret,
                  disbanco.idret,
                  disbanco.k00_numpre,
                  r.k00_numpre,
                  r.k00_numpar
    loop

      if lRaise is true then
        perform fc_debug('<PgtoParcial> Processando idret '||r_idret.idret||' Numpre: '||r_idret.numpre||'...',lRaise,false,false);
      end if;

      -- @todo - verificar esta logica com muita calma, acredito nao ser aqui o melhor lugar...
      if ( r_idret.qtd_aberto = r_idret.qtd_recibo ) or r_idret.qtd_aberto = 0 then
        if lRaise is true then
          perform fc_debug('<PgtoParcial> Continuando 1 ( qtd_aberto = qtd_recibo OU qtd_aberto = 0 )...',lRaise,false,false);
        end if;
        continue;
      end if;

      if r_idret.arrecad then
        perform 1 from arrecad where k00_numpre = r_idret.k00_numpre and k00_tipo = 3;
        if found then
          if lRaise is true then
        perform fc_debug('<PgtoParcial> Continuando 2 ( nao encontrou numpre na arrecad )...',lRaise,false,false);
      end if;
          continue;
        end if;
      elsif r_idret.arrecant then
        perform 1 from arrecant where k00_numpre = r_idret.k00_numpre and k00_tipo = 3;
        if found then
          if lRaise is true then
        perform fc_debug('<PgtoParcial> Continuando 3 ( nao encontrou numpre na arrecant )...',lRaise,false,false);
      end if;
          continue;
        end if;
      elsif r_idret.arreold then
        perform 1 from arreold where k00_numpre = r_idret.k00_numpre and k00_tipo = 3;
        if found then
          if lRaise is true then
             perform fc_debug('<PgtoParcial> Continuando 4 ( nao encontrou numpre na arreold )...',lRaise,false,false);
          end if;
          continue;
        end if;
      end if;

      --
      -- Se nao encontrar o numpre e numpar em nenhuma das tabelas : arrecad,arrecant,arreold
      --   insere em tmpnaoprocessar para nao processar do loop principal do processamento
      --
      if r_idret.arrecad is false and r_idret.arrecant is false and r_idret.arreold is false then
        perform 1 from tmpnaoprocessar where idret = r_idret.idret;
        if not found then

          if lRaise is true then
             perform fc_debug('<PgtoParcial> Inserindo idret '||r_idret.idret||' em tmpnaoprocessar...',lRaise,false,false);
          end if;
          insert into tmpnaoprocessar values (r_idret.idret);
        end if;
      elsif r_idret.arrecad is false then
        --
        --  Caso nao encontrar no arrecad deleta o numpre e numpar
        --    da recibopaga para ajustar o recibo, pressupondo que tenha sido pago ou cancelado
        --    uma parcela do recibo. Este ajuste no recibo Ã© necessario para que o sistema encontre
        --    a diferenca entre o valor pago e o valor do recibo, gerando assim um credito com o valor
        --    da diferenca
        --

        if lRaise then
          perform fc_debug('  <PgtoParcial>  - Quantidade em aberto : '||r_idret.qtd_aberto||' Quantidade no recibo : '||r_idret.qtd_recibo                             ,lRaise,false,false);
          perform fc_debug('  <PgtoParcial>  - Deletando da recibopaga -- numnov : '||r_idret.numpre||' numpre : '||r_idret.k00_numpre||' numpar : '||r_idret.k00_numpar,lRaise,false,false);
        end if;

        --
        -- Verificamos se o numnov que esta prestes a ser deletado poussui vinculo com alguma partilha
        -- Caso encontrado vinculo, o recibo nao e exclui­do e sera retornado erro no processamento
        --
        perform v77_processoforopartilha
           from processoforopartilhacusta
          where v77_numnov in (select k00_numnov
                                from recibopaga
                               where k00_numnov = r_idret.numpre
                                 and k00_numpre = r_idret.k00_numpre
                                 and k00_numpar = r_idret.k00_numpar);
        if found then
          raise exception   'Erro ao realizar exclusao de recibo da CGF (recibopaga) Numnov: % Numpre: % Numpar: % possuem vinculo com geracao de partilha de custas para processo do foro', r_idret.numpre, r_idret.k00_numpre, r_idret.k00_numpar;
        end if;

        delete from recibopaga
         where k00_numnov = r_idret.numpre
           and k00_numpre = r_idret.k00_numpre
           and k00_numpar = r_idret.k00_numpar;

      end if;

    end loop;

    /*******************************************************************************************************************
     *  GERA RECIBO PARA ISSQN VARIAVEL
     ******************************************************************************************************************/
    if lRaise then
      perform fc_debug('  <PgtoParcial> Regra 6 - GERA RECIBO PARA ISSQN VARIAVEL',lRaise,false,false);
    end if;

    -- Verifica se existe algum  referente a ISSQN Variavel que ja esteja quitado e o valor seja 0 (zero)
    -- Nesse caso sera gerado ARRECAD / ISSVAR / RECIBO para o  encontrado e acertado o numpre na tabela disbanco
    --
    -- Alterado o sql para buscar dados da disbanco de issqn variável que estão na recibopaga, jah realizava antes da alteracao,
    -- e buscar dados da disbanco de issqn variavel que nao tiveram seu pagamento por recibo, lógica nova.
    --
    for rRecordDisbanco in select distinct
                                  disbanco.*,
                                  issvar_carne.q05_numpre as issvar_carne_numpre,
                                  issvar_carne.q05_numpar as issvar_carne_numpar
                             from disbanco
                                  left join recibopaga                        on recibopaga.k00_numnov            = disbanco.k00_numpre
                                  left join arrecant                          on arrecant.k00_numpre              = recibopaga.k00_numpre
                                                                             and arrecant.k00_numpar              = recibopaga.k00_numpar
                                                                             and arrecant.k00_receit              = recibopaga.k00_receit
                                  left join arreold                           on arreold.k00_numpre               = recibopaga.k00_numpre
                                                                             and arreold.k00_numpar               = recibopaga.k00_numpar
                                                                             and arreold.k00_receit               = recibopaga.k00_receit
                                  left join issvar as issvar_recibo           on issvar_recibo.q05_numpre         = arrecant.k00_numpre
                                                                             and issvar_recibo.q05_numpar         = arrecant.k00_numpar
                                  left join issvar as issvar_recibo_old       on issvar_recibo_old.q05_numpre     = arreold.k00_numpre
                                                                             and issvar_recibo_old.q05_numpar     = arreold.k00_numpar
                                  left join issvar as issvar_carne            on issvar_carne.q05_numpre          = disbanco.k00_numpre
                                                                             and issvar_carne.q05_numpar          = disbanco.k00_numpar
                                  left join arrecant as arrecant_issvar_carne on arrecant_issvar_carne.k00_numpre = disbanco.k00_numpre
                                                                             and arrecant_issvar_carne.k00_numpar = disbanco.k00_numpar
                                  left join arreold as arreold_issvar_carne   on arreold_issvar_carne.k00_numpre  = disbanco.k00_numpre
                                                                             and arreold_issvar_carne.k00_numpar  = disbanco.k00_numpar
                            where disbanco.classi is false
                              and disbanco.codret = cod_ret
                              and disbanco.instit = iInstitSessao
                              and (
                                    --deve Estar na arrecant              OU Estar na arreold
                                    (issvar_recibo.q05_numpre is not null or issvar_recibo_old.q05_numpre is not null )
                                    -- OU
                                    or (
                                          -- Estar na disbanco com o numpre da issvar
                                          issvar_carne.q05_numpre is not null
                                          --E  Estar na arrecant                            OU Estar na arreold
                                          and (arrecant_issvar_carne.k00_numpre is not null or arreold_issvar_carne.k00_numpre is not null)
                                        )
                                  )
                              and case when iNumprePagamentoParcial = 0
                                       then true
                                       else disbanco.k00_numpre > iNumprePagamentoParcial
                                   end
                              and not exists ( select 1
                                                 from tmpnaoprocessar
                                                where tmpnaoprocessar.idret = disbanco.idret )
                         order by disbanco.idret
    loop

      if lRaise is true then
          perform fc_debug('  <PgtoParcial> ',lRaise,false,false);
          perform fc_debug('  <PgtoParcial> ',lRaise,false,false);
          perform fc_debug('  <PgtoParcial> PROCESSANDO IDRET '||rRecordDisbanco.idret||'...',lRaise,false,false);
          perform fc_debug('  <PgtoParcial>                                                 ',lRaise,false,false);
          perform fc_debug('  <PgtoParcial> Gerando recibos                                 ',lRaise,false,false);
      end if;

      --
      -- Alterado o sql para atender aos casos em que foi pago um issqn variavel por carnê ao invés de recibo
      --
      select distinct
             case
               when recibopaga.k00_numnov is not null and round(sum(recibopaga.k00_valor),2) > 0.00 then
                 round(sum(recibopaga.k00_valor),2)
               else
                 vlrpago
             end
        into nVlrTotalRecibopaga
        from disbanco
             left join recibopaga on recibopaga.k00_numnov = disbanco.k00_numpre
       where disbanco.idret  = rRecordDisbanco.idret
         and disbanco.instit = iInstitSessao
       group by recibopaga.k00_numnov, disbanco.vlrpago ;

      if lRaise is true then

        perform fc_debug('  <PgtoParcial> Numpre Disbanco .........: '||rRecordDisbanco.k00_numpre                                                            ,lRaise,false,false);
        perform fc_debug('  <PgtoParcial> Numpre IssVar ...........: '||rRecordDisbanco.issvar_carne_numpre||' Parcela: '||rRecordDisbanco.issvar_carne_numpar,lRaise,false,false);
        perform fc_debug('  <PgtoParcial> Valor Pago na Disbanco (recibopaga) ..: '||nVlrTotalRecibopaga                                                                   ,lRaise,false,false);
        perform fc_debug('  <PgtoParcial> ',lRaise,false,false);
      end if;

      nVlrTotalInformado := 0;

      for rRecord in select distinct tipo,
                                        k00_numpre,
                                        k00_numpar,
                                        case
                                          when k00_valor = 0 then rRecordDisbanco.vlrpago
                                          else k00_valor
                                        end as k00_valor
                       from ( select distinct
                                     1 as tipo,
                                     recibopaga.k00_numpre,
                                     recibopaga.k00_numpar,
                                     round(sum(recibopaga.k00_valor),2) as k00_valor
                                from recibopaga
                                     left join arrecant  c on c.k00_numpre = recibopaga.k00_numpre
                                                          and c.k00_numpar  = recibopaga.k00_numpar
                               where recibopaga.k00_numnov = rRecordDisbanco.k00_numpre
                               group by recibopaga.k00_numpre,
                                        recibopaga.k00_numpar
                               union
                              select 2 as tipo,
                                     rRecordDisbanco.issvar_carne_numpre as k00_numpre,
                                     rRecordDisbanco.issvar_carne_numpar as k00_numpar,
                                     rRecordDisbanco.vlrpago             as k00_valor
                               where rRecordDisbanco.issvar_carne_numpre is not null
                             ) as dados
                  order by k00_numpre, k00_numpar

      loop

        if lRaise is true then

          perform fc_debug('  <PgtoParcial> '                                                                                                          ,lRaise,false,false);
          perform fc_debug('  <PgtoParcial> Calculando valor informado...'                                                                             ,lRaise,false,false);
          perform fc_debug('  <PgtoParcial> Valor pago na Disbanco ...:'||rRecordDisbanco.vlrpago                                                      ,lRaise,false,false);
          perform fc_debug('  <PgtoParcial> Valor do debito ..........:'||rRecord.k00_valor                                                            ,lRaise,false,false);
          perform fc_debug('  <PgtoParcial> Valor do debito encontrado na tabela '||(case when rRecord.tipo = 1 then 'Recibopaga' else 'Disbanco' end ),lRaise,false,false);
          perform fc_debug('  <PgtoParcial> Valor pago na disbanco ...:'||nVlrTotalRecibopaga                                                          ,lRaise,false,false);
          perform fc_debug('  <PgtoParcial> Calculo ..................: ( Valor pago na Disbanco * ((( Valor do debito * 100 ) / Valor pago na disbanco ) / 100 ))',lRaise,false,false);
          perform fc_debug('  <PgtoParcial> Valor Informado ..........: ( '||coalesce(rRecordDisbanco.vlrpago,0)||' * ((( '||coalesce(rRecord.k00_valor,0)||' * 100 ) / '||coalesce(nVlrTotalRecibopaga,0)||' ) / 100 )) = '||( coalesce(rRecordDisbanco.vlrpago,0) * ((( coalesce(rRecord.k00_valor,0) * 100 ) / coalesce(nVlrTotalRecibopaga,0) ) / 100 )) ,lRaise,false,false);
        end if;

        nVlrInformado := ( rRecordDisbanco.vlrpago * ((( rRecord.k00_valor * 100 ) / nVlrTotalRecibopaga ) / 100 ));

        if rRecord.k00_numpre != iNumpreAnterior then

          -- Gera Numpre do ISSQN Variavel
          select nextval('numpref_k03_numpre_seq')
            into iNumpreIssVar;

          -- Gera Numpre do Recibo
          select nextval('numpref_k03_numpre_seq')
            into iNumpreRecibo;

          iNumpreAnterior    := rRecord.k00_numpre;

          insert into arreinscr select distinct
                                       iNumpreIssVar,
                                       arreinscr.k00_inscr,
                                       arreinscr.k00_perc
                                  from arreinscr
                                 where arreinscr.k00_numpre = rRecord.k00_numpre;

        end if;
        --
        -- Apenas excluimos o recibo quando o pagamento for por recibo (tipo = 1)
        --
        if rRecord.tipo = 1 then

          delete
            from recibopaga
           where k00_numnov = rRecordDisbanco.k00_numpre
             and k00_numpre = rRecord.k00_numpre
             and k00_numpar = rRecord.k00_numpar;
        end if;

        if lRaise is true then
          perform fc_debug('  <PgtoParcial> Incluindo registros do Numpre '||rRecord.k00_numpre||' Parcela '||rRecord.k00_numpar||' na tabela arrecad como iss complementar com o novo numpre '||iNumpreIssVar,lRaise,false,false);
        end if;

        /*
         * Alterada a lógica para inclusão no arrecad.
         *
         * Ao invés de utilizar a data de operação e vencimento original do débito, esta sendo utilizada a data de processamento da baixa de banco
         * Isto devido a geração de correção, juro e multa indevidos para o débito pois esses valores ja estão embutidos no valor total pago na disbanco.
         *
         * Verifica se deve buscar os dados da arrecant (Caso o débito ja tenha sido pago)
         *                                  ou arreold (Caso o débito tenha sido importado para divida)
         */
        perform 1
           from arrecant
          where k00_numpre = rRecord.k00_numpre
            and k00_numpar = rRecord.k00_numpar;

        if not found then

          perform fc_debug('  <PgtoParcial> Gerando arrecad utilizando arreold para iss complementar', lRaise);
          insert into arrecad ( k00_numpre,
                                k00_numpar,
                                k00_numcgm,
                                k00_dtoper,
                                k00_receit,
                                k00_hist,
                                k00_valor,
                                k00_dtvenc,
                                k00_numtot,
                                k00_numdig,
                                k00_tipo,
                                k00_tipojm
                              ) select iNumpreIssVar,
                                       arreold.k00_numpar,
                                       arreold.k00_numcgm,
                                       datausu,
                                       arreold.k00_receit,
                                       arreold.k00_hist,
                                       ( case
                                           when rRecord.tipo = 1
                                             then 0
                                           else rRecordDisbanco.vlrpago
                                         end ),
                                       datausu,
                                       1,
                                       arreold.k00_numdig,
                                       arreold.k00_tipo,
                                       arreold.k00_tipojm
                                  from arreold
                                 where arreold.k00_numpre = rRecord.k00_numpre
                                   and arreold.k00_numpar = rRecord.k00_numpar;
        else

          perform fc_debug('  <PgtoParcial> Gerando arrecad utilizando arrecant para iss complementar', lRaise);
          insert into arrecad ( k00_numpre,
                                k00_numpar,
                                k00_numcgm,
                                k00_dtoper,
                                k00_receit,
                                k00_hist,
                                k00_valor,
                                k00_dtvenc,
                                k00_numtot,
                                k00_numdig,
                                k00_tipo,
                                k00_tipojm
                              ) select iNumpreIssVar,
                                       arrecant.k00_numpar,
                                       arrecant.k00_numcgm,
                                       datausu,
                                       arrecant.k00_receit,
                                       arrecant.k00_hist,
                                       ( case
                                           when rRecord.tipo = 1
                                             then 0
                                           else rRecordDisbanco.vlrpago
                                         end ),
                                       datausu,
                                       1,
                                       arrecant.k00_numdig,
                                       arrecant.k00_tipo,
                                       arrecant.k00_tipojm
                                  from arrecant
                                 where arrecant.k00_numpre = rRecord.k00_numpre
                                   and arrecant.k00_numpar = rRecord.k00_numpar;
        end if;

        insert into issvar ( q05_codigo,
                             q05_numpre,
                             q05_numpar,
                             q05_valor,
                             q05_ano,
                             q05_mes,
                             q05_histor,
                             q05_aliq,
                             q05_bruto,
                             q05_vlrinf
                           ) select nextval('issvar_q05_codigo_seq'),
                                    iNumpreIssVar,
                                    issvar.q05_numpar,
                                    issvar.q05_valor,
                                    issvar.q05_ano,
                                    issvar.q05_mes,
                                    'ISSQN Complementar gerado automaticamente atraves da baixa de banco devido a quitacao ',
                                    issvar.q05_aliq,
                                    issvar.q05_bruto,
                                    nVlrInformado
                               from issvar
                              where q05_numpre = rRecord.k00_numpre
                                and q05_numpar = rRecord.k00_numpar;

        select k00_codbco,
               k00_codage,
               fc_numbco(k00_codbco,k00_codage) as fc_numbco
          into rRecordBanco
          from arretipo
         where k00_tipo = ( select k00_tipo
                              from arrecant
                             where arrecant.k00_numpre = rRecord.k00_numpre
                               and arrecant.k00_numpar = rRecord.k00_numpar
                             limit 1 );

        insert into db_reciboweb ( k99_numpre,
                                   k99_numpar,
                                   k99_numpre_n,
                                   k99_codbco,
                                   k99_codage,
                                   k99_numbco,
                                   k99_desconto,
                                   k99_tipo,
                                   k99_origem
                                 ) values (
                                   iNumpreIssVar,
                                   rRecord.k00_numpar,
                                   iNumpreRecibo,
                                   coalesce(rRecordBanco.k00_codbco,0),
                                   coalesce(rRecordBanco.k00_codage,'0'),
                                   rRecordBanco.fc_numbco,
                                   0,
                                   2,
                                   1
                                 );

         if lRaise is true then
           perform fc_debug('  <PgtoParcial>  - xxx - valor informado : '||nVlrInformado||' total : '||nVlrTotalInformado,lRaise,false,false);
         end if;

         nVlrTotalInformado := ( nVlrTotalInformado + nVlrInformado );

      end loop;

      if lRaise is true then
        perform fc_debug('  <PgtoParcial>  - 1 - valor antes disbanco : '||nVlrTotalInformado,lRaise,false,false);
      end if;

      if rRecordDisbanco.vlrpago != round(nVlrTotalInformado,2) then

        if lRaise is true then
          perform fc_debug('  <PgtoParcial>  - Valor Pago na Disbanco diferente do Valor Total Informado... ',lRaise,false,false);
          perform fc_debug('  <PgtoParcial>  - Valor Pago na Disbanco ....: '||rRecordDisbanco.vlrpago,lRaise,false,false);
          perform fc_debug('  <PgtoParcial>  - Valor Total Informado......: '||round(nVlrTotalInformado,2),lRaise,false,false);
          perform fc_debug('  <PgtoParcial>  - ',lRaise,false,false);
          perform fc_debug('  <PgtoParcial>  - Alterando o valor informado da issvar ajustando com a diferenca encontrada ('||(rRecordDisbanco.vlrpago - round(nVlrTotalInformado,2))||')',lRaise,false,false);
        end if;

        update issvar
           set q05_vlrinf = q05_vlrinf + (rRecordDisbanco.vlrpago - round(nVlrTotalInformado,2))
         where q05_codigo = ( select max(q05_codigo)
                                from issvar
                               where q05_numpre = iNumpreIssVar );
      end if;

      if lRaise is true then
      perform fc_debug('  <PgtoParcial>  - 2 - valor antes disbanco : '||nVlrTotalInformado,lRaise,false,false);
      end if;

      -- Gera Recibopaga
      if lRaise is true then
      perform fc_debug('  <PgtoParcial>  - Gerando ReciboPaga',lRaise,false,false);
      end if;

      select * from fc_recibo(iNumpreRecibo,rRecordDisbanco.dtpago,rRecordDisbanco.dtpago,iAnoSessao)
        into rRecibo;

      if lRaise is true then
        perform fc_debug('  <PgtoParcial>  - Fim do Processamento da ReciboPaga',lRaise,false,false);
      end if;

      if rRecibo.rlerro is true then
        return '6 - '||rRecibo.rvmensagem;
      end if;

      -- Acerta o conteudo da disbanco, alterando o numpre do ISSQN quitado pelo da recibopaga
      if lRaise then
        perform fc_debug('  <PgtoParcial>  - 3 - Alterando numpre disbanco ! novo numpre : '||iNumpreRecibo,lRaise,false,false);
      end if;

      update disbanco
         set vlrpago = round((vlrpago - nVlrTotalInformado),2),
             vlrtot  = round((vlrtot  - nVlrTotalInformado),2)
       where idret   = rRecordDisbanco.idret;

       /**
        * Comentando update da tmpantesprocessar pois gerava inconsistencia quando o debito
        * foi pago em duplicidade
        *
       update tmpantesprocessar
         set vlrpago = round((vlrpago - nVlrTotalInformado),2)
       where idret   = rRecordDisbanco.idret;*/

       perform * from recibopaga
         where k00_numnov = rRecordDisbanco.k00_numpre;

       if not found then

         update disbanco
            set k00_numpre = iNumpreRecibo,
                k00_numpar = 0,
                vlrpago    = round(nVlrTotalInformado,2),
                vlrtot     = round(nVlrTotalInformado,2)
          where idret      = rRecordDisbanco.idret;

          /*update tmpantesprocessar
             set vlrpago    = round(nVlrTotalInformado,2)
           where idret      = rRecordDisbanco.idret;*/

       else

         iSeqIdRet := nextval('disbanco_idret_seq');

         if lRaise is true then
           perform fc_debug('  <PgtoParcial>  - idret update : '||rRecordDisbanco.idret||' novo idret : '||iSeqIdRet||' valor antes disbanco : '||nVlrTotalInformado,lRaise,false,false);
         end if;

          insert into disbanco ( k00_numbco,
                                k15_codbco,
                                k15_codage,
                                codret,
                                dtarq,
                                dtpago,
                                vlrpago,
                                vlrjuros,
                                vlrmulta,
                                vlracres,
                                vlrdesco,
                                vlrtot,
                                cedente,
                                vlrcalc,
                                idret,
                                classi,
                                k00_numpre,
                                k00_numpar,
                                convenio,
                                instit )
                        select k00_numbco,
                               k15_codbco,
                               k15_codage,
                               codret,
                               dtarq,
                               dtpago,
                               round(nVlrTotalInformado,2),
                               0,
                               0,
                               0,
                               0,
                               round(nVlrTotalInformado,2),
                               cedente,
                               round(nVlrTotalInformado,2),
                               iSeqIdRet,
                               classi,
                               iNumpreRecibo,
                               0,
                               convenio,
                              instit
                         from disbanco
                        where disbanco.idret = rRecordDisbanco.idret;
           end if;

         if lRaise is true then
           perform fc_debug('  <PgtoParcial>  ',lRaise,false,false);
           perform fc_debug('  <PgtoParcial>  FIM DO PROCESSAMENTO DO IDRET '||rRecordDisbanco.idret,lRaise,false,false);
           perform fc_debug('  <PgtoParcial>  ',lRaise,false,false);
         end if;

    end loop;

    perform fc_debug('  <PgtoParcial>  - Inicio verificacao de recibo oriundo de integracao externa', lRaise);
    for rRecord in select disbanco.k00_numpre, disbanco.k00_numpar, disbanco.idret,
                          vlrpago::numeric(15,2)   as valorpagodisbanco,
                          q05_valor::numeric(15,2) as valorlancadoissvar
                     from disbanco
                          inner join db_reciboweb on k99_numpre = disbanco.k00_numpre
                                                 and k99_numpar = disbanco.k00_numpar
                                                 and k99_tipo   = 9
                                                 and k99_origem = 3
                          inner join issvar       on k99_numpre = q05_numpre
                                                 and k99_numpar = q05_numpar
                          inner join arrecad      on arrecad.k00_numpre = disbanco.k00_numpre
                                                 and arrecad.k00_numpar = disbanco.k00_numpar
                    where codret = cod_ret
                      and classi is false
                      and instit = iInstitSessao
    loop

      perform fc_debug('  <PgtoParcial>  - Numpre Iss:                   ' || rRecord.k00_numpre,         lRaise);
      perform fc_debug('  <PgtoParcial>  - Valor encontrado em aberto:   ' || rRecord.valorlancadoissvar, lRaise);
      perform fc_debug('  <PgtoParcial>  - Valor pago:                   ' || rRecord.valorpagodisbanco,  lRaise);
      perform fc_debug('  <PgtoParcial>  - Tolerancia Pagamento Parcial: ' || nVlrToleranciaPgtoParcial,  lRaise);

      nVlrDiferencaPgto := ( rRecord.valorlancadoissvar - rRecord.valorpagodisbanco )::numeric(15,2);

      /**
       * Pagamento parcial para recibos oriundos de integracao externa deve ser gerado inconsistencia
       */
      if nVlrDiferencaPgto > 0 and nVlrDiferencaPgto > nVlrToleranciaPgtoParcial then

        perform fc_debug('  <PgtoParcial>  - Gerando inconsistencia para o idret: ' || rRecord.idret ||'. Pagamento Parcial oriundo de integracao externa.', lRaise);
        insert into tmpnaoprocessar values (rRecord.idret);
      end if;
    end loop;

    perform fc_debug('  <PgtoParcial>  - Fim verificacao de recibo oriundo de integracao externa', lRaise);

    /*******************************************************************************************************************
     *  GERA ABATIMENTOS
     ******************************************************************************************************************/
    --
    -- Verifica se existe abatimentos sendo eles ( PAGAMENTO PARCIAL, CREDITO E DESCONTO )
    --

    if lRaise is true then
      perform fc_debug('  <PgtoParcial> Regra 7 - GERA ABATIMENTO ', lRaise,false,false);
    end if;

    for r_idret in

        select distinct
               disbanco.k00_numpre as numpre,
               disbanco.k00_numpar as numpar,
               disbanco.idret,
               disbanco.k15_codbco,
               disbanco.k15_codage,
               disbanco.k00_numbco,
               disbanco.vlrpago,
               disbanco.vlracres,
               disbanco.vlrdesco,
               disbanco.vlrjuros,
               disbanco.vlrmulta,
               disbanco.dtpago,
               round(sum(recibopaga.k00_valor),2) as k00_valor,
               recibopaga.k00_dtpaga,
               disbanco.instit
          from disbanco
               inner join recibopaga     on disbanco.k00_numpre       = recibopaga.k00_numnov
               left  join numprebloqpag  on numprebloqpag.ar22_numpre = disbanco.k00_numpre
                                        and numprebloqpag.ar22_numpar = disbanco.k00_numpar
         where disbanco.codret = cod_ret
           and disbanco.classi is false
           and disbanco.instit = iInstitSessao
           and numprebloqpag.ar22_numpre is null
           and case when iNumprePagamentoParcial = 0
                    then true
                    else disbanco.k00_numpre > iNumprePagamentoParcial
                end
           and not exists ( select 1
                              from tmpnaoprocessar
                             where tmpnaoprocessar.idret = disbanco.idret )
           and exists ( select 1
                          from arrecad
                         where arrecad.k00_numpre = recibopaga.k00_numpre
                           and arrecad.k00_numpar = recibopaga.k00_numpar
                         union all
                        select 1
                          from arrecant
                         where arrecant.k00_numpre = recibopaga.k00_numpre
                           and arrecant.k00_numpar = recibopaga.k00_numpar
                         union all
                        select 1
                          from arreold
                         where arreold.k00_numpre = recibopaga.k00_numpre
                           and arreold.k00_numpar = recibopaga.k00_numpar
                         union all
                        select 1
                          from arreprescr
                         where arreprescr.k30_numpre = recibopaga.k00_numpre
                           and arreprescr.k30_numpar = recibopaga.k00_numpar
                          limit 1 )
      group by disbanco.k00_numpre,
               disbanco.k00_numpar,
               disbanco.idret,
               disbanco.k15_codbco,
               disbanco.k15_codage,
               disbanco.k00_numbco,
               disbanco.vlrpago,
               disbanco.vlracres,
               disbanco.vlrdesco,
               disbanco.vlrjuros,
               disbanco.vlrmulta,
               disbanco.dtpago,
               disbanco.instit,
               recibopaga.k00_dtpaga
      order by disbanco.idret

    loop

      lReciboInvalidoPorTrocaDeReceita = false;

      if lRaise is true then

        perform fc_debug('  <PgtoParcial>  - '||lpad('',100,'=')                                  ,lRaise,false,false);
        perform fc_debug('  <PgtoParcial>  - IDRET : '||r_idret.idret                             ,lRaise,false,false);
        perform fc_debug('  <PgtoParcial>  - '||lpad('',100,'=')                                  ,lRaise,false,false);
        perform fc_debug('  <PgtoParcial>  - '                                                    ,lRaise,false,false);
        perform fc_debug('  <PgtoParcial>  - Numpre RECIBOPAGA : '||r_idret.numpre                ,lRaise,false,false);
        perform fc_debug('  <PgtoParcial>  - Valor Pago        : '||r_idret.vlrpago::numeric(15,2),lRaise,false,false);
        perform fc_debug('  <PgtoParcial>  - '                                                    ,lRaise,false,false);

      end if;

      --
      -- se o recibo estiver valido buscamos o valor calculado do recibo
      --
      if lRaise is true then
        perform fc_debug('  <PgtoParcial>  - Data recibopaga : '||r_idret.k00_dtpaga||' data pago banco : '||r_idret.dtpago,lRaise,false,false);
      end if;

      --
      -- Verificamos se o recibo que esta sendo pago tem algum pagamento parcial
      --   caso tenha pgto parcial recalcula a origem do debito
      --
      perform *
         from recibopaga r
              inner join arreckey           k    on k.k00_numpre       = r.k00_numpre
                                                and k.k00_numpar       = r.k00_numpar
                                                and k.k00_receit       = r.k00_receit
              inner join abatimentoarreckey ak   on ak.k128_arreckey   = k.k00_sequencial
              inner join abatimentodisbanco ab   on ab.k132_abatimento = ak.k128_abatimento
        where k00_numnov    = r_idret.numpre;

      if found then
        lReciboPossuiPgtoParcial := true;
      else

        lReciboPossuiPgtoParcial := false;
        if lRaise is true then
          perform fc_debug('  <PgtoParcial>  ------------------------------------------'            ,lRaise,false,false);
          perform fc_debug('  <PgtoParcial>  - Nao Encontrou Pagamento Parcial Anterior'            ,lRaise,false,false);
          perform fc_debug('  <PgtoParcial>  - Numpre: '||r_idret.numpre||', IDRet: '||r_idret.idret,lRaise,false,false);
          perform fc_debug('  <PgtoParcial>  ------------------------------------------'            ,lRaise,false,false);
        end if;
      end if;

      /**
       * Validamos se o recibo foi gerado por regra, pois caso tenha
       * sido não deve recalcular a origem do débito
       * --Se for diferente de 0 não pode recalcular
       **/
      if lReciboPossuiPgtoParcial is true then

        perform *
         from recibopaga r
              inner join arreckey           k    on k.k00_numpre       = r.k00_numpre
                                                 and k.k00_numpar       = r.k00_numpar
                                                 and k.k00_receit       = r.k00_receit
              inner join abatimentoarreckey ak   on ak.k128_arreckey   = k.k00_sequencial
              inner join abatimentodisbanco ab   on ab.k132_abatimento = ak.k128_abatimento
              inner join db_reciboweb       dw   on r.k00_numnov       = dw.k99_numpre_n
        where k00_numnov   = r_idret.numpre
          and k99_desconto <> 0;

        if found then
          lReciboPossuiPgtoParcial := false;
        end if;

      end if;

       perform 1
          from recibopaga
         where recibopaga.k00_numnov = r_idret.numpre
           and recibopaga.k00_hist   not in (918, 970, 400, 401)
           and not exists (select 1
                             from arrecad
                            where arrecad.k00_numpre = recibopaga.k00_numpre
                              and arrecad.k00_numpar = recibopaga.k00_numpar
                              and arrecad.k00_receit = recibopaga.k00_receit );
      if found then
        lReciboInvalidoPorTrocaDeReceita := true;
      end if;

      perform fc_debug('  <PgtoParcial>  - Numpre : '||r_idret.numpre, lRaise);
      perform fc_debug('  <PgtoParcial>  - Data para pagamento : '||fc_proximo_dia_util(r_idret.k00_dtpaga), lRaise);
      perform fc_debug('  <PgtoParcial>  - Encontrou outro abatimento : '||lReciboPossuiPgtoParcial, lRaise);
      perform fc_debug('  <PgtoParcial>  - Trocou de receita : '||lReciboInvalidoPorTrocaDeReceita, lRaise);

      if     fc_proximo_dia_util(r_idret.k00_dtpaga) >= r_idret.dtpago
         and lReciboPossuiPgtoParcial is false
         and lReciboInvalidoPorTrocaDeReceita is false
      then

        if lRaise is true then
          perform fc_debug('  <PgtoParcial>  - Calculado 1 ',lRaise,false,false);
        end if;

        select round(sum(k00_valor),2) as valor_total_recibo
          into nVlrCalculado
          from recibopaga
               inner join disbanco on disbanco.k00_numpre = recibopaga.k00_numnov
         where recibopaga.k00_numnov = r_idret.numpre
           and disbanco.idret        = r_idret.idret
           and exists ( select 1
                          from arrecad
                         where arrecad.k00_numpre = recibopaga.k00_numpre
                           and arrecad.k00_numpar = recibopaga.k00_numpar
                         limit 1 );

        if lRaise is true then
          perform fc_debug('  <PgtoParcial>  - Valor calculado para recibo pago dentro do vencimento (recibopaga) : '||nVlrCalculado,lRaise,false,false);
        end if;

      else

        if lRaise is true then
          perform fc_debug('  <PgtoParcial>  - Calculado 2 ',lRaise,false,false);
        end if;

        select coalesce(round(sum(utotal),2),0)::numeric(15,2)
          into nVlrCalculado
          from ( select ( substr(fc_calcula,15,13)::float8 +
                          substr(fc_calcula,28,13)::float8 +
                          substr(fc_calcula,41,13)::float8 -
                          substr(fc_calcula,54,13)::float8 ) as utotal
                   from ( select fc_calcula( x.k00_numpre,
                                             x.k00_numpar,
                                             0,
                                             x.dtpago,
                                             x.dtpago,
                                             extract(year from x.dtpago)::integer)
                                        from ( select distinct
                                                      recibopaga.k00_numpre,
                                                      recibopaga.k00_numpar,
                                                      dtpago
                                                 from recibopaga
                                                      inner join disbanco    on disbanco.k00_numpre     = recibopaga.k00_numnov
                                                      inner join arrecad     on arrecad.k00_numpre      = recibopaga.k00_numpre
                                                                            and arrecad.k00_numpar      = recibopaga.k00_numpar
                                                where recibopaga.k00_numnov = r_idret.numpre
                                                  and disbanco.idret        = r_idret.idret ) as x
                        ) as y
                ) as z;

      end if;

      if nVlrCalculado is null then
        nVlrCalculado := 0;
      end if;

      perform 1
         from recibopaga
              inner join disbanco on disbanco.k00_numpre = recibopaga.k00_numnov
              inner join arrecad  on arrecad.k00_numpre  = recibopaga.k00_numpre
                                 and arrecad.k00_numpar  = recibopaga.k00_numpar
              inner join issvar   on issvar.q05_numpre   = recibopaga.k00_numpre
                                 and issvar.q05_numpar   = recibopaga.k00_numpar
        where recibopaga.k00_numnov = r_idret.numpre
          and arrecad.k00_valor     = 0;

      if found then

        if lRaise is true then
          perform fc_debug('  <PgtoParcial>  - **** ISSQN Variavel **** ',lRaise,false,false);
        end if;

        nVlrCalculado := r_idret.vlrpago;

      end if;


      if nVlrCalculado < 0 then
        return '7 - Debito com valor negativo - Numpre : '||r_idret.numpre;
      end if;


      nVlrPgto          := ( r_idret.vlrpago )::numeric(15,2);
      nVlrDiferencaPgto := ( nVlrCalculado - nVlrPgto )::numeric(15,2);

      if lRaise is true then

        perform fc_debug('  <PgtoParcial>  - Calculado ................: '||nVlrCalculado            ,lRaise,false,false);
        perform fc_debug('  <PgtoParcial>  - Diferenca ................: '||nVlrDiferencaPgto        ,lRaise,false,false);
        perform fc_debug('  <PgtoParcial>  - Tolerancia Pgto Parcial ..: '||nVlrToleranciaPgtoParcial,lRaise,false,false);
        perform fc_debug('  <PgtoParcial>  - Tolerancia Credito .......: '||nVlrToleranciaCredito    ,lRaise,false,false);
        perform fc_debug('  <PgtoParcial>  - '                                                       ,lRaise,false,false);

      end if;

      -- Caso o Pagamento Parcial esteja ativado entao a verificado se o valor pago e igual ao total do
      -- e caso nao seja, tambem e verificado se a diferenca do pagamento e menor que a tolenrancia para pagamento
      if lRaise is true then
        perform fc_debug('  <PgtoParcial>  - nVlrDiferencaPgto: '||nVlrDiferencaPgto||', nVlrDiferencaPgto: '||nVlrDiferencaPgto||',  nVlrToleranciaPgtoParcial: '||nVlrToleranciaPgtoParcial,lRaise,false,false);
      end if;

      /**
       * Inicio do Pagamento Parcial
       */
      if nVlrDiferencaPgto > 0 and nVlrDiferencaPgto > nVlrToleranciaPgtoParcial then

        -- Percentual pago do debito
        nPercPgto          := (( nVlrPgto * 100 ) / nVlrCalculado )::numeric;

        -- Insere Abatimento
        select nextval('abatimento_k125_sequencial_seq')
          into iAbatimento;

        if lRaise is true then

          perform fc_debug('  <PgtoParcial>  - '||lpad('',100,'-'),lRaise,false,false);
          perform fc_debug('  PAGAMENTO PARCIAL : '||iAbatimento,lRaise,false,false);
          perform fc_debug('  <PgtoParcial>  - '||lpad('',100,'-'),lRaise,false,false);

        end if;

        insert into abatimento ( k125_sequencial,
                                 k125_tipoabatimento,
                                 k125_datalanc,
                                 k125_hora,
                                 k125_usuario,
                                 k125_instit,
                                 k125_valor,
                                 k125_perc
                               ) values (
                                 iAbatimento,
                                 1,
                                 datausu,
                                 to_char(current_timestamp,'HH24:MI'),
                                 cast(fc_getsession('DB_id_usuario') as integer),
                                 iInstitSessao,
                                 nVlrPgto,
                                 nPercPgto
                               );

        insert into abatimentodisbanco ( k132_sequencial,
                     k132_abatimento,
                     k132_idret
                     ) values (
                      nextval('abatimentodisbanco_k132_sequencial_seq'),
                      iAbatimento,
                      r_idret.idret
                    );


        -- Gera um Recibo Avulso
        select nextval('numpref_k03_numpre_seq')
          into iNumpreReciboAvulso;

        insert into abatimentorecibo ( k127_sequencial,
                                       k127_abatimento,
                                       k127_numprerecibo,
                                       k127_numpreoriginal
                                     ) values (
                                       nextval('abatimentorecibo_k127_sequencial_seq'),
                                       iAbatimento,
                                       iNumpreReciboAvulso,
                                       coalesce( (select k00_numpre
                                                    from tmpdisbanco_inicio_original
                                                   where idret = r_idret.idret), iNumpreReciboAvulso)
                                     );


        -- Geracao de Recibo Avulso por Receita e Pagamento;

        select distinct round(sum(recibopaga.k00_valor),2)
          into nVlrTotalRecibopaga
          from disbanco
               inner join recibopaga on recibopaga.k00_numnov = disbanco.k00_numpre
         where disbanco.idret  = r_idret.idret
           and disbanco.instit = iInstitSessao;


        for rRecord in select distinct
                              recibopaga.k00_numcgm     as k00_numcgm,
                              recibopaga.k00_receit     as k00_receit,
                              round(sum(recibopaga.k00_valor),2) as k00_valor
                         from disbanco
                              inner join recibopaga on recibopaga.k00_numnov = disbanco.k00_numpre
                        where disbanco.idret  = r_idret.idret
                          and disbanco.instit = iInstitSessao
                     group by recibopaga.k00_receit,
                              recibopaga.k00_numcgm
        loop

          select k00_tipo
            into iTipoDebitoPgtoParcial
            from ( select ( select arrecad.k00_tipo
                              from arrecad
                             where arrecad.k00_numpre = recibopaga.k00_numpre
                               and arrecad.k00_numpar = recibopaga.k00_numpar

                             union

                            select arrecant.k00_tipo
                              from arrecant
                             where arrecant.k00_numpre = recibopaga.k00_numpre
                               and arrecant.k00_numpar = recibopaga.k00_numpar
                                limit 1
                          ) as k00_tipo
                     from disbanco
                          inner join recibopaga on recibopaga.k00_numnov = disbanco.k00_numpre
                    where disbanco.idret  = r_idret.idret
                      and disbanco.instit = iInstitSessao
                 ) as x;


          nPercReceita := ( (rRecord.k00_valor * 100) / nVlrTotalRecibopaga )::numeric(20,10);
          nVlrReceita  := trunc(( nVlrPgto * ( nPercReceita / 100 ))::numeric(15,2),2);

          if lRaise is true then
            perform fc_debug('  <PgtoParcial>  - <PgtoParcial> - Gerando recibo por receita e pagamento ',lRaise,false,false);
          end if;

          insert into recibo ( k00_numcgm,
                               k00_dtoper,
                               k00_receit,
                               k00_hist,
                               k00_valor,
                               k00_dtvenc,
                               k00_numpre,
                               k00_numpar,
                               k00_numtot,
                               k00_numdig,
                               k00_tipo,
                               k00_tipojm,
                               k00_codsubrec,
                               k00_numnov
                             ) values (
                               rRecord.k00_numcgm,
                               datausu,
                               rRecord.k00_receit,
                               504,
                               nVlrReceita,
                               datausu,
                               iNumpreReciboAvulso,
                               1,
                               1,
                               0,
                               iTipoDebitoPgtoParcial,
                               0,
                               0,
                               0
                             );


          insert into arrehist ( k00_numpre,
                                 k00_numpar,
                                 k00_hist,
                                 k00_dtoper,
                                 k00_hora,
                                 k00_id_usuario,
                                 k00_histtxt,
                                 k00_limithist,
                                 k00_idhist
                               ) values (
                                 iNumpreReciboAvulso,
                                 1,
                                 504,
                                 datausu,
                                 '00:00',
                                 1,
                                 'Recibo avulso referente pagamento parcial do recibo da CGF - numnov: ' || r_idret.numpre || ' idret: ' || r_idret.idret,
                                 null,
                                 nextval('arrehist_k00_idhist_seq')
                               );

          perform *
             from arrenumcgm
            where k00_numpre = iNumpreReciboAvulso
              and k00_numcgm = rRecord.k00_numcgm;

          if not found then

            insert into arrenumcgm ( k00_numcgm, k00_numpre ) values ( rRecord.k00_numcgm, iNumpreReciboAvulso );

          end if;
        end loop;

        /**
         * @todo remover o 100% pois quanto eh gerado um recibo de um parcelamento ha sim mais de uma matricula vinculada ao mesmo e assim o sera inserido 100 para cada origem do credito ou pagamento parcial
         */
        -- Acerta as origens do Recibo Avulso de acordo os Numpres da recibopaga informado
        insert into arrematric select distinct
                                      iNumpreReciboAvulso,
                                      arrematric.k00_matric,
                                      -- colocado 100 % fixo porque o numpre do recibo avulso gerado se trata de pagamento parcial
                                      -- e nao vai ter divisao de percentual entre mais de um numpre da mesma matricula
                                      100 as k00_perc
                                 from recibopaga
                                      inner join arrematric on arrematric.k00_numpre = recibopaga.k00_numpre
                                where recibopaga.k00_numnov = r_idret.numpre;


        insert into arreinscr  select distinct
                                      iNumpreReciboAvulso,
                                      arreinscr.k00_inscr,
                                      -- colocado 100 % fixo porque o numpre do recibo avulso gerado se trata de pagamento parcial
                                      -- e nao vai ter divisao de percentual entre mais de um numpre da mesma inscricao
                                      100 as k00_perc
                                 from recibopaga
                                      inner join arreinscr on arreinscr.k00_numpre = recibopaga.k00_numpre
                                where recibopaga.k00_numnov = r_idret.numpre;

        -- Percorre todos os debitos a serem abatidos
        for rRecord in select distinct
                              arrecad.k00_numpre,
                              arrecad.k00_numpar,
                              arrecad.k00_hist,
                              arrecad.k00_receit,
                              arrecad.k00_tipo
                         from recibopaga
                              inner join arrecad on arrecad.k00_numpre = recibopaga.k00_numpre
                                                and arrecad.k00_numpar = recibopaga.k00_numpar
                                                and arrecad.k00_receit = recibopaga.k00_receit
                        where recibopaga.k00_numnov = r_idret.numpre
                     order by arrecad.k00_numpre,
                              arrecad.k00_numpar,
                              arrecad.k00_receit
        loop

          select arreckey.k00_sequencial,
                 arrecadcompos.k00_sequencial
            into iArreckey,
                 iArrecadCompos
            from arreckey
                 left join arrecadcompos on arrecadcompos.k00_arreckey = arreckey.k00_sequencial
           where k00_numpre = rRecord.k00_numpre
             and k00_numpar = rRecord.k00_numpar
             and k00_receit = rRecord.k00_receit
             and k00_hist   = rRecord.k00_hist;

          --
          --   Quando houver um recibo com desconto manual e for realizado um pagamento parcial o sistema
          --   utiliza como valor calculado o valor liquido (valor com o desconto manual 918)
          --   e deixa o desconto perdido no arrecad, abatimentoarreckey, arreckey sendo que o mesmo ja foi utilizado
          --   para resolver, deletamos o registro de historico 918 do arrecad.
          --

          delete
            from arrecad
           where k00_numpre = rRecord.k00_numpre
             and k00_numpar = rRecord.k00_numpar
             and k00_receit = rRecord.k00_receit
             and k00_hist   in (918, 970);

          delete
            from abatimentoarreckey
           using arreckey
           where k00_sequencial = k128_arreckey
             and k00_numpre = rRecord.k00_numpre
             and k00_numpar = rRecord.k00_numpar
             and k00_receit = rRecord.k00_receit
             and k00_hist   in (918, 970);

          delete
            from arreckey
           where k00_numpre = rRecord.k00_numpre
             and k00_numpar = rRecord.k00_numpar
             and k00_receit = rRecord.k00_receit
             and k00_hist   in (918, 970);

          if iArreckey is null then

            select nextval('arreckey_k00_sequencial_seq')
              into iArreckey;

            insert into arreckey ( k00_sequencial,
                                   k00_numpre,
                                   k00_numpar,
                                   k00_receit,
                                   k00_hist,
                                   k00_tipo
                                 ) values (
                                   iArreckey,
                                   rRecord.k00_numpre,
                                   rRecord.k00_numpar,
                                   rRecord.k00_receit,
                                   rRecord.k00_hist,
                                   rRecord.k00_tipo
                                 );

          end if;

          -- Insere ligacao do abatimento com o debito
          select nextval('abatimentoarreckey_k128_sequencial_seq')
            into iAbatimentoArreckey;

          insert into abatimentoarreckey ( k128_sequencial,
                                           k128_arreckey,
                                           k128_abatimento,
                                           k128_valorabatido,
                                           k128_correcao,
                                           k128_juros,
                                           k128_multa
                                         ) values (
                                           iAbatimentoArreckey,
                                           iArreckey,
                                           iAbatimento,
                                           0,
                                           0,
                                           0,
                                           0
                                         );

          if iArrecadCompos is not null then

            insert into abatimentoarreckeyarrecadcompos ( k129_sequencial,
                                                          k129_abatimentoarreckey,
                                                          k129_arrecadcompos,
                                                          k129_vlrhist,
                                                          k129_correcao,
                                                          k129_juros,
                                                          k129_multa
                                                        ) values (
                                                          nextval('abatimentoarreckeyarrecadcompos_k129_sequencial_seq'),
                                                          iAbatimentoArreckey,
                                                          iArrecadCompos,
                                                          0,
                                                          0,
                                                          0,
                                                          0
                                                        );
          end if;

        end loop;

        -- Consulta valor total historico do debito
        select round(sum(x.k00_valor),2) as k00_valor
          into nVlrTotalHistorico
          from ( select distinct arrecad.*
                   from recibopaga
                      inner join arrecad  on arrecad.k00_numpre = recibopaga.k00_numpre
                                       and arrecad.k00_numpar = recibopaga.k00_numpar
                                       and arrecad.k00_receit = recibopaga.k00_receit
                where recibopaga.k00_numnov = r_idret.numpre ) as x;

        if lRaise is true then

          perform fc_debug('  <PgtoParcial>  - ',lRaise,false,false);
          perform fc_debug('  <PgtoParcial>  - Total Historico   : '||nVlrTotalHistorico,lRaise,false,false);

        end if;

        -- Valor a ser abatido do arrecad e igual ao percentual do pagamento sobre o total historico
        nVlrAbatido := trunc(( nVlrTotalHistorico * ( nPercPgto / 100 ))::numeric(15,2),2);

        nVlrTotalJuroMultaCorr := nVlrPgto - nVlrAbatido;

        -- Dilui o valor abatido do arrecad ate zerar o nVlrAbatido encontrado
        while round(nVlrAbatido,2) > 0 loop

          nPercPgto := (( nVlrAbatido * 100 ) / nVlrTotalHistorico )::numeric;

          if lRaise is true then

            perform fc_debug('  <PgtoParcial>  - '||lpad('',100,'.')              ,lRaise,false,false);
            perform fc_debug('  <PgtoParcial>  - Valor Abatido   : '||nVlrAbatido ,lRaise,false,false);
            perform fc_debug('  <PgtoParcial>  - Perc  Pagamento : '||nPercPgto   ,lRaise,false,false);

          end if;

          for rRecord in select *,
                                case
                                  when k00_hist in (918, 970) then 0
                                  else ( substr(fc_calcula,15,13)::float8 - substr(fc_calcula, 2,13)::float8 )::float8
                                end as vlrcorrecao,
                                case when k00_hist in (918, 970) then 0::float8 else substr(fc_calcula,28,13)::float8 end as vlrjuros,
                                case when k00_hist in (918, 970) then 0::float8 else substr(fc_calcula,41,13)::float8 end as vlrmulta
                           from ( select abatimentoarreckey.k128_sequencial,
                                         abatimentoarreckeyarrecadcompos.k129_sequencial,
                                         arrecad.*,
                                         arrecadcompos.*,
                                         fc_calcula( arrecad.k00_numpre,
                                                     arrecad.k00_numpar,
                                                     arrecad.k00_receit,
                                                     r_idret.dtpago,
                                                     r_idret.dtpago,
                                                     extract( year from r_idret.dtpago )::integer )
                                    from abatimentoarreckey
                                         inner join arreckey      on arreckey.k00_sequencial    = abatimentoarreckey.k128_arreckey
                                         left  join arrecadcompos on arrecadcompos.k00_arreckey = arreckey.k00_sequencial
                                         left  join abatimentoarreckeyarrecadcompos on k129_abatimentoarreckey = abatimentoarreckey.k128_sequencial
                                         inner join arrecad       on arrecad.k00_numpre         = arreckey.k00_numpre
                                                                 and arrecad.k00_numpar         = arreckey.k00_numpar
                                                                 and arrecad.k00_receit         = arreckey.k00_receit
                                                                 and arrecad.k00_hist           = arreckey.k00_hist
                                   where abatimentoarreckey.k128_abatimento = iAbatimento
                                order by arrecad.k00_numpre asc,
                                         arrecad.k00_numpar asc,
                                         arrecad.k00_valor  desc
                                ) as x


          loop

            -- Caso tenha sido zerado a variavel nVlrAbatido entao sai do loop

            if nVlrAbatido <= 0 then

              exit;

            end if;

            nVlrPgtoParcela := trunc((rRecord.k00_valor * ( nPercPgto / 100 ))::numeric(20,10),2);

            if lRaise is true then
              perform fc_debug('  <PgtoParcial>  - Valor Pagamento da Parcela: '||nVlrPgtoParcela,lRaise,false,false);
              perform fc_debug('  <PgtoParcial>  - lInsereJurMulCorr: '||lInsereJurMulCorr,lRaise,false,false);
            end if;

            if lInsereJurMulCorr then

              nVlrJuros         := trunc((rRecord.vlrjuros     * ( nPercPgto / 100 ))::numeric(20,10),2);
              nVlrMulta         := trunc((rRecord.vlrmulta     * ( nPercPgto / 100 ))::numeric(20,10),2);
              nVlrCorrecao      := trunc((rRecord.vlrcorrecao  * ( nPercPgto / 100 ))::numeric(20,10),2);

              nVlrHistCompos    := trunc((rRecord.k00_vlrhist  * ( nPercPgto / 100 ))::numeric(20,10),2);
              nVlrJurosCompos   := trunc((rRecord.k00_juros    * ( nPercPgto / 100 ))::numeric(20,10),2);
              nVlrMultaCompos   := trunc((rRecord.k00_multa    * ( nPercPgto / 100 ))::numeric(20,10),2);
              nVlrCorreCompos   := trunc((rRecord.k00_correcao * ( nPercPgto / 100 ))::numeric(20,10),2);

              if lRaise is true then
                perform fc_debug('  <PgtoParcial>  - nPercPgto:          : '||nPercPgto           ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - rRecord.vlrjuros    : '||rRecord.vlrjuros    ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - rRecord.vlrmulta    : '||rRecord.vlrmulta    ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - rRecord.vlrcorrecao : '||rRecord.vlrcorrecao ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>'                                                ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - rRecord.k00_vlrhist : '||rRecord.k00_vlrhist ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - rRecord.k00_juros   : '||rRecord.k00_juros   ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - rRecord.k00_multa   : '||rRecord.k00_multa   ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - rRecord.k00_correcao: '||rRecord.k00_correcao,lRaise,false,false);

                perform fc_debug('  <PgtoParcial>  -'                                             ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  -'                                             ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - nVlrJuros      : '||nVlrJuros                ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - nVlrMulta      : '||nVlrMulta                ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - nVlrCorrecao   : '||nVlrCorrecao             ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - '                                            ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - nVlrHistCompos : '||nVlrHistCompos           ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - nVlrJurosCompos: '||nVlrJurosCompos          ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - nVlrMultaCompos: '||nVlrMultaCompos          ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - nVlrCorreCompos: '||nVlrCorreCompos          ,lRaise,false,false);
              end if;

            else

              nVlrJuros         := 0;
              nVlrMulta         := 0;
              nVlrCorrecao      := 0;

              nVlrHistCompos    := 0;
              nVlrJurosCompos   := 0;
              nVlrMultaCompos   := 0;
              nVlrCorreCompos   := 0;

            end if;
            if lRaise is true then

              perform fc_debug('  <PgtoParcial>  -    Numpre: '||lpad(rRecord.k00_numpre,10,'0')||' Numpar: '||lpad(rRecord.k00_numpar, 3,'0')||' Receita: '||rRecord.k00_receit||' Valor Parcela: '||rRecord.k00_valor::numeric(15,2)||' Corr: '||nVlrCorrecao::numeric(15,2)||' Juros: '||nVlrJuros::numeric(15,2)||' Multa: '||nVlrMulta::numeric(15,2)||' Valor Pago: '||nVlrPgtoParcela::numeric(15,2)||' Resto: '||nVlrAbatido::numeric(15,2),lRaise,false,false);

            end if;

            -- Nao deixa retornar o valor zerado

            if lRaise is true then
              perform fc_debug('  <PgtoParcial>  - nVlrPgtoParcela: '||nVlrPgtoParcela||' rRecord.k00_hist: '||rRecord.k00_hist,lRaise,false,false);
            end if;

            if round(nVlrPgtoParcela,2) <= 0 and rRecord.k00_hist not in (918, 970) then

              if lRaise is true then

                perform fc_debug('  <PgtoParcial>  -    * Valor Parcela Menor que 0,01 - Corrige para 0,01 ',lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - ',lRaise,false,false);

              end if;

              nVlrPgtoParcela := 0.01;

            end if;


            update abatimentoarreckey
               set k128_valorabatido = ( k128_valorabatido + nVlrPgtoParcela )::numeric(15,2),
                   k128_correcao     = ( k128_correcao     + nVlrCorrecao    )::numeric(15,2),
                   k128_juros        = ( k128_juros        + nVlrJuros       )::numeric(15,2),
                   k128_multa        = ( k128_multa        + nVlrMulta       )::numeric(15,2)
             where k128_sequencial   = rRecord.k128_sequencial;


            if rRecord.k129_sequencial is not null then

              update abatimentoarreckeyarrecadcompos
                 set k129_vlrhist      = ( k129_vlrhist  + nVlrHistCompos  )::numeric(15,2),
                     k129_correcao     = ( k129_correcao + nVlrCorreCompos )::numeric(15,2),
                     k129_juros        = ( k129_juros    + nVlrJurosCompos )::numeric(15,2),
                     k129_multa        = ( k129_multa    + nVlrMultaCompos )::numeric(15,2)
               where k129_sequencial   = rRecord.k129_sequencial;

            end if;


            nVlrAbatido := trunc(( nVlrAbatido - nVlrPgtoParcela )::numeric(20,10),2)::numeric(15,2);

            if lRaise is true then
              perform fc_debug('  <PgtoParcial>  - nVlrAbatido: '||nVlrAbatido,lRaise,false,false);
            end if;

          end loop;

          if lRaise is true then
            perform fc_debug('  <PgtoParcial>  - lInsereJurMulCorr = False',lRaise,false,false);
          end if;

          lInsereJurMulCorr := false;

        end loop;

        if lRaise is true then
          perform fc_debug('  <PgtoParcial>  - iAbatimento: '||iAbatimento,lRaise,false,false);
        end if;

        select round(sum(abatimentoarreckey.k128_correcao) +
                     sum(abatimentoarreckey.k128_juros)    +
                     sum(abatimentoarreckey.k128_multa),2) as totaljuromultacorr
          into rRecord
          from abatimentoarreckey
         where abatimentoarreckey.k128_abatimento = iAbatimento;


        if lRaise is true then

          perform fc_debug('  <PgtoParcial>  - '                                                          ,lRaise,false,false);
          perform fc_debug('  <PgtoParcial>  - Total - Juros/ Multa / Corr : '||rRecord.totaljuromultacorr,lRaise,false,false);
          perform fc_debug('  <PgtoParcial>  - Total - Geral               : '||nVlrTotalJuroMultaCorr    ,lRaise,false,false);
          perform fc_debug('  <PgtoParcial>  - '                                                          ,lRaise,false,false);

        end if;


        if rRecord.totaljuromultacorr <> round(nVlrTotalJuroMultaCorr,2) then

          update abatimentoarreckey
             set k128_correcao = ( k128_correcao + ( nVlrTotalJuroMultaCorr - round(rRecord.totaljuromultacorr,2) ))::numeric(15,2)
           where k128_sequencial in ( select max(k128_sequencial)
                                         from abatimentoarreckey
                                        where k128_abatimento = iAbatimento );
        end if;

        for rRecord in select distinct
                              arrecad.*,
                              abatimentoarreckey.k128_valorabatido,
                              arrecadcompos.k00_sequencial                              as arrecadcompos,
                              coalesce(abatimentoarreckeyarrecadcompos.k129_vlrhist ,0) as histcompos,
                              coalesce(abatimentoarreckeyarrecadcompos.k129_correcao,0) as correcompos,
                              coalesce(abatimentoarreckeyarrecadcompos.k129_juros   ,0) as juroscompos,
                              coalesce(abatimentoarreckeyarrecadcompos.k129_multa   ,0) as multacompos
                         from abatimentoarreckey
                              inner join arreckey                        on arreckey.k00_sequencial    = abatimentoarreckey.k128_arreckey
                              inner join arrecad                         on arrecad.k00_numpre         = arreckey.k00_numpre
                                                                        and arrecad.k00_numpar         = arreckey.k00_numpar
                                                                        and arrecad.k00_receit         = arreckey.k00_receit
                                                                        and arrecad.k00_hist           = arreckey.k00_hist
                              left  join arrecadcompos                   on arrecadcompos.k00_arreckey = arreckey.k00_sequencial
                              left  join abatimentoarreckeyarrecadcompos on abatimentoarreckeyarrecadcompos.k129_abatimentoarreckey = abatimentoarreckey.k128_sequencial
                        where abatimentoarreckey.k128_abatimento = iAbatimento
                     order by arrecad.k00_numpre,
                              arrecad.k00_numpar,
                              arrecad.k00_receit

        loop


          -- Caso o valor abata todo valor devido entao e quitado a tabela

          if round((rRecord.k00_valor - rRecord.k128_valorabatido),2) = 0 then

            insert into arrecantpgtoparcial ( k00_numpre,
                                              k00_numpar,
                                              k00_numcgm,
                                              k00_dtoper,
                                              k00_receit,
                                              k00_hist,
                                              k00_valor,
                                              k00_dtvenc,
                                              k00_numtot,
                                              k00_numdig,
                                              k00_tipo,
                                              k00_tipojm,
                                              k00_abatimento
                                            ) values (
                                              rRecord.k00_numpre,
                                              rRecord.k00_numpar,
                                              rRecord.k00_numcgm,
                                              rRecord.k00_dtoper,
                                              rRecord.k00_receit,
                                              rRecord.k00_hist,
                                              rRecord.k00_valor,
                                              rRecord.k00_dtvenc,
                                              rRecord.k00_numtot,
                                              rRecord.k00_numdig,
                                              rRecord.k00_tipo,
                                              rRecord.k00_tipojm,
                                              iAbatimento
                                            );
            delete
              from arrecad
             where k00_numpre = rRecord.k00_numpre
               and k00_numpar = rRecord.k00_numpar
               and k00_receit = rRecord.k00_receit
               and k00_hist   = rRecord.k00_hist;

          else

            update arrecad
             set k00_valor  = ( k00_valor - rRecord.k128_valorabatido )
           where k00_numpre = rRecord.k00_numpre
             and k00_numpar = rRecord.k00_numpar
             and k00_receit = rRecord.k00_receit
             and k00_hist   = rRecord.k00_hist;

          end if;


          if rRecord.arrecadcompos is not null then

            update arrecadcompos
               set k00_vlrhist    = ( k00_vlrhist  - rRecord.histcompos  ),
                   k00_correcao   = ( k00_correcao - rRecord.correcompos ),
                   k00_juros      = ( k00_juros    - rRecord.juroscompos ),
                   k00_multa      = ( k00_multa    - rRecord.multacompos )
             where k00_sequencial = rRecord.arrecadcompos;

          end if;

        end loop;

        -- Acerta NUMPRE da disbanco
        if lRaise then
          perform fc_debug('  <PgtoParcial>  - 4 - Alterando numpre disbanco ! novo numpre : '||iNumpreReciboAvulso,lRaise,false,false);
        end if;

        update disbanco
           set k00_numpre = iNumpreReciboAvulso,
               k00_numpar = 0
         where idret      = r_idret.idret;


      --
      -- FIM PGTO PARCIAL
      --
      -- INICIO CREDITO/DESCONTO
      -- validacao da tolerancia do credito
      -- se o valor da diferenca for menor que 0 (significa que é um credito)
      -- e se o valor absoluto da diferenca for maior que o valor da tolerancia para credito sera gerado o credito
      --
      --
      elsif nVlrDiferencaPgto != 0 and ( nVlrDiferencaPgto > 0 or ( nVlrDiferencaPgto < 0 and abs(nVlrDiferencaPgto) > nVlrToleranciaCredito) ) then


        if lRaise is true then
          perform fc_debug('  <PgtoParcial>  - nVlrDiferencaPgto: '||nVlrDiferencaPgto||' - nVlrToleranciaCredito: '||nVlrToleranciaCredito, lRaise, false, false);
        end if;

        select nextval('abatimento_k125_sequencial_seq')
          into iAbatimento;


        if nVlrDiferencaPgto > 0 then

          iTipoAbatimento   = 2;

          if lRaise is true then

            perform fc_debug('  <PgtoParcial>  - '||lpad('',100,'-')      ,lRaise,false,false);
            perform fc_debug('  <PgtoParcial>  - DESCONTO : '||iAbatimento,lRaise,false,false);
            perform fc_debug('  <PgtoParcial>  - '||lpad('',100,'-')      ,lRaise,false,false);

          end if;

        else

          iTipoAbatimento   = 3;
          nVlrDiferencaPgto := ( nVlrDiferencaPgto * -1 );

          if lRaise is true then

            perform fc_debug('  <PgtoParcial>  - '||lpad('',100,'-')      ,lRaise,false,false);
            perform fc_debug('  <PgtoParcial>  - CREDITO : '||iAbatimento ,lRaise,false,false);
            perform fc_debug('  <PgtoParcial>  - '||lpad('',100,'-')      ,lRaise,false,false);

          end if;

        end if;


        nPercPgto := (( nVlrDiferencaPgto * 100 ) / r_idret.k00_valor )::numeric;

        if lRaise is true then
          perform fc_debug('  <PgtoParcial>  - Lancando Abatimento. nPercPgto: '||nPercPgto,lRaise,false,false);
        end if;

        insert into abatimento ( k125_sequencial,
                                 k125_tipoabatimento,
                                 k125_datalanc,
                                 k125_hora,
                                 k125_usuario,
                                 k125_instit,
                                 k125_valor,
                                 k125_perc,
                                 k125_valordisponivel
                               ) values (
                                 iAbatimento,
                                 iTipoAbatimento,
                                 datausu,
                                 to_char(current_timestamp,'HH24:MI'),
                                 cast(fc_getsession('DB_id_usuario') as integer),
                                 iInstitSessao,
                                 nVlrDiferencaPgto,
                                 nPercPgto,
                                 nVlrDiferencaPgto
                               );

        insert into abatimentodisbanco ( k132_sequencial,
                                         k132_abatimento,
                                         k132_idret
                                       ) values (
                                         nextval('abatimentodisbanco_k132_sequencial_seq'),
                                         iAbatimento,
                                         r_idret.idret
                                       );
        if lRaise is true then
          perform fc_debug('  <PgtoParcial>  - TipoAbatimento: '||iTipoAbatimento,lRaise,false,false);
        end if;

          if iTipoAbatimento = 3 then


          -- Gera um Recibo Avulso

          select nextval('numpref_k03_numpre_seq')
            into iNumpreReciboAvulso;

          if lRaise is true then
            perform fc_debug('  <PgtoParcial> -  ## Gerando recibo avulso. NumpreReciboAvulso: '||iNumpreReciboAvulso,lRaise,false,false);
          end if;

          insert into abatimentorecibo ( k127_sequencial,
                                         k127_abatimento,
                                         k127_numprerecibo,
                                         k127_numpreoriginal
                                       ) values (
                                         nextval('abatimentorecibo_k127_sequencial_seq'),
                                         iAbatimento,
                                         iNumpreReciboAvulso,
                                         coalesce( (select k00_numpre
                                                      from tmpdisbanco_inicio_original
                                                     where idret = r_idret.idret ), iNumpreReciboAvulso)
                                       );

          for rRecord in select k00_numcgm,
                                k00_tipo,
                                round(sum(k00_valor),2) as k00_valor
                           from ( select recibopaga.k00_numcgm,
                                         ( select arrecad.k00_tipo
                                             from arrecad
                                            where arrecad.k00_numpre = recibopaga.k00_numpre
                                              and arrecad.k00_numpar = recibopaga.k00_numpar
                                            union all
                                           select arrecant.k00_tipo
                                             from arrecant
                                            where arrecant.k00_numpre = recibopaga.k00_numpre
                                              and arrecant.k00_numpar = recibopaga.k00_numpar
                                            union all
                                           select arreold.k00_tipo
                                             from arreold
                                            where arreold.k00_numpre = recibopaga.k00_numpre
                                              and arreold.k00_numpar = recibopaga.k00_numpar
                                    union all
                                 select 1
                                   from arreprescr
                                  where arreprescr.k30_numpre = recibopaga.k00_numpre
                                    and arreprescr.k30_numpar = recibopaga.k00_numpar
                                         limit 1 ) as k00_tipo,
                                         recibopaga.k00_valor
                                    from disbanco
                                         inner join recibopaga on recibopaga.k00_numnov = disbanco.k00_numpre
                                   where disbanco.idret  = r_idret.idret
                                     and disbanco.instit = iInstitSessao
                                ) as x
                       group by k00_numcgm,
                                k00_tipo
           loop

             nVlrReceita := ( rRecord.k00_valor * ( nPercPgto / 100 ) )::numeric(15,2);

             select k00_receitacredito
               into iReceitaCredito
               from arretipo
              where k00_tipo = rRecord.k00_tipo;

              if lRaise is true then
                perform fc_debug('  <PgtoParcial>  - iReceitaCredito: '||iReceitaCredito,lRaise,false,false);
              end if;

             if iReceitaCredito is null then
               return '8 - Receita de Credito nao configurado para o tipo : '||rRecord.k00_tipo;
             end if;

             if lRaise is true then
               perform fc_debug('  <PgtoParcial>  - ## lancando o recibo ref ao credito. ReceitaCredito: '||rRecord.k00_tipo||' ValorReceita: '||nVlrReceita,lRaise,false,false);
             end if;

             insert into recibo ( k00_numcgm,
                                  k00_dtoper,
                                  k00_receit,
                                  k00_hist,
                                  k00_valor,
                                  k00_dtvenc,
                                  k00_numpre,
                                  k00_numpar,
                                  k00_numtot,
                                  k00_numdig,
                                  k00_tipo,
                                  k00_tipojm,
                                  k00_codsubrec,
                                  k00_numnov
                                ) values (
                                  rRecord.k00_numcgm,
                                  datausu,
                                  iReceitaCredito,
                                  505,
                                  nVlrReceita,
                                  datausu,
                                  iNumpreReciboAvulso,
                                  1,
                                  1,
                                  0,
                                  iTipoReciboAvulso,
                                  0,
                                  0,
                                  0
                                );

             insert into arrehist ( k00_numpre,
                                    k00_numpar,
                                    k00_hist,
                                    k00_dtoper,
                                    k00_hora,
                                    k00_id_usuario,
                                    k00_histtxt,
                                    k00_limithist,
                                    k00_idhist
                                  ) values (
                                    iNumpreReciboAvulso,
                                    1,
                                    505,
                                    datausu,
                                    '00:00',
                                    1,
                                    'Recibo avulso referente ao credito do recibo da CGF - numnov: ' || r_idret.numpre || 'idret: ' || r_idret.idret,
                                    null,
                                    nextval('arrehist_k00_idhist_seq')
                                  );

             perform *
                from arrenumcgm
               where k00_numpre = iNumpreReciboAvulso
                 and k00_numcgm = rRecord.k00_numcgm;

             if not found then

               perform fc_debug('  <PgtoParcial>  - inserindo registro do recibo na arrenumcgm',lRaise,false,false);
               insert into arrenumcgm ( k00_numcgm, k00_numpre ) values ( rRecord.k00_numcgm, iNumpreReciboAvulso );
             end if;

           end loop;

           if lRaise is true then
             perform fc_debug('  <PgtoParcial>  - Inserindo na Arrematric [3]:'||iNumpreReciboAvulso,lRaise,false,false);
           end if;

           if lRaise is true then
             perform fc_debug('  <PgtoParcial>  - '||sDebug,lRaise,false,false);
           end if;

           insert into arrematric select distinct
                                         iNumpreReciboAvulso,
                                         arrematric.k00_matric,
                                         -- colocado 100 % fixo porque o numpre do recibo avulso gerado se trata de credito
                                         -- e nao vai ter divisao de percentual entre mais de um numpre da mesma matricula
                                         100 as k00_perc
                                    from recibopaga
                                         inner join arrematric on arrematric.k00_numpre = recibopaga.k00_numpre
                                   where recibopaga.k00_numnov = r_idret.numpre;

           insert into arreinscr  select distinct
                                         iNumpreReciboAvulso,
                                         arreinscr.k00_inscr,
                                         -- colocado 100 % fixo porque o numpre do recibo avulso gerado se trata de credito
                                         -- e nao vai ter divisao de percentual entre mais de um numpre da mesma matricula
                                         100 as k00_perc
                                    from recibopaga
                                         inner join arreinscr on arreinscr.k00_numpre = recibopaga.k00_numpre
                                   where recibopaga.k00_numnov = r_idret.numpre;

          if nVlrCalculado = 0 then

            if lRaise then
              perform fc_debug('  <PgtoParcial>  - 5 - Alterando numpre disbanco ! novo numpre : '||iNumpreReciboAvulso,lRaise,false,false);
            end if;

            update disbanco
               set k00_numpre = iNumpreReciboAvulso,
                   k00_numpar = 0
             where idret      = r_idret.idret;

          else

            if lRaise is true or true then
              perform fc_debug('  <PgtoParcial>  - Insere Disbanco',lRaise,false,false);
            end if;

            select nextval('disbanco_idret_seq')
              into iSeqIdRet;

            insert into disbanco (k00_numbco,
                                  k15_codbco,
                                  k15_codage,
                                  codret,
                                  dtarq,
                                  dtpago,
                                  vlrpago,
                                  vlrjuros,
                                  vlrmulta,
                                  vlracres,
                                  vlrdesco,
                                  vlrtot,
                                  cedente,
                                  vlrcalc,
                                  idret,
                                  classi,
                                  k00_numpre,
                                  k00_numpar,
                                  convenio,
                                  instit )
                           select k00_numbco,
                                  k15_codbco,
                                  k15_codage,
                                  codret,
                                  dtarq,
                                  dtpago,
                                  round(nVlrDiferencaPgto,2),
                                  0,
                                  0,
                                  0,
                                  0,
                                  round(nVlrDiferencaPgto,2),
                                  cedente,
                                  round(vlrcalc,2),
                                  iSeqIdRet,
                                  classi,
                                  iNumpreReciboAvulso,
                                  0,
                                  convenio,
                                 instit
                            from disbanco
                           where disbanco.idret = r_idret.idret;

            insert into tmpantesprocessar ( idret,
                                         vlrpago,
                                         v01_seq
                                       ) values (
                                         iSeqIdRet,
                                         nVlrDiferencaPgto,
                                         ( select nextval('w_divold_seq') )
                                       );

            update disbanco
               set vlrpago  = round(( vlrpago - nVlrDiferencaPgto ),2),
                   vlrtot   = round(( vlrtot  - nVlrDiferencaPgto ),2)
             where idret    = r_idret.idret;

            update tmpantesprocessar
               set vlrpago = round( vlrpago - nVlrDiferencaPgto,2 )
             where idret   = r_idret.idret;

          end if;

        end if;

        while nVlrDiferencaPgto > 0 loop

          nPercDesconto := (( nVlrDiferencaPgto * 100 ) / r_idret.k00_valor )::numeric;

          if lRaise is true then

            perform fc_debug('  <PgtoParcial>  - '||lpad('',100,'.')               ,lRaise,false,false);
            perform fc_debug('  <PgtoParcial>  - Percentual : '||nPercDesconto     ,lRaise,false,false);
            perform fc_debug('  <PgtoParcial>  - Diferenca  : '||nVlrDiferencaPgto ,lRaise,false,false);

          end if;

          perform 1
             from recibopaga
            where recibopaga.k00_numnov = r_idret.numpre
              and recibopaga.k00_hist   not in (918, 970)
              and exists ( select 1
                             from arrecad
                            where arrecad.k00_numpre = recibopaga.k00_numpre
                              and arrecad.k00_numpar = recibopaga.k00_numpar
                            union all
                           select 1
                             from arrecant
                            where arrecant.k00_numpre = recibopaga.k00_numpre
                              and arrecant.k00_numpar = recibopaga.k00_numpar
                            union all
                           select 1
                             from arreold
                            where arreold.k00_numpre = recibopaga.k00_numpre
                              and arreold.k00_numpar = recibopaga.k00_numpar
                            union all
                           select 1
                             from arreprescr
                            where arreprescr.k30_numpre = recibopaga.k00_numpre
                              and arreprescr.k30_numpar = recibopaga.k00_numpar
                            limit 1 );

          if not found then
            return '9 - Recibo '||r_idret.numpre||' inconsistente. IDRET : '||r_idret.idret;
          end if;

          for rRecord in select distinct
                                recibopaga.k00_numpre,
                                recibopaga.k00_numpar,
                                recibopaga.k00_receit,
                                recibopaga.k00_hist,
                                recibopaga.k00_numcgm,
                                recibopaga.k00_numtot,
                                recibopaga.k00_numdig,
                                ( select arrecad.k00_tipo
                                    from arrecad
                                   where arrecad.k00_numpre  = recibopaga.k00_numpre
                                     and arrecad.k00_numpar  = recibopaga.k00_numpar
                                   union all
                                  select arrecant.k00_tipo
                                    from arrecant
                                   where arrecant.k00_numpre = recibopaga.k00_numpre
                                     and arrecant.k00_numpar = recibopaga.k00_numpar
                                   union all
                                  select arreold.k00_tipo
                                    from arreold
                                   where arreold.k00_numpre = recibopaga.k00_numpre
                                     and arreold.k00_numpar = recibopaga.k00_numpar
                                   union all
                                  select 1
                                    from arreprescr
                                   where arreprescr.k30_numpre = recibopaga.k00_numpre
                                     and arreprescr.k30_numpar = recibopaga.k00_numpar
                                   limit 1 ) as k00_tipo,
                                round(sum(recibopaga.k00_valor),2) as k00_valor
                           from recibopaga
                          where recibopaga.k00_numnov = r_idret.numpre
                            and recibopaga.k00_hist   not in (918, 970)
                            and exists ( select 1
                                           from arrecad
                                          where arrecad.k00_numpre = recibopaga.k00_numpre
                                            and arrecad.k00_numpar = recibopaga.k00_numpar
                                         --   and arrecad.k00_receit = recibopaga.k00_receit
                                          union all
                                         select 1
                                           from arrecant
                                          where arrecant.k00_numpre = recibopaga.k00_numpre
                                            and arrecant.k00_numpar = recibopaga.k00_numpar
                                         --   and arrecant.k00_receit = recibopaga.k00_receit
                                          union all
                                         select 1
                                           from arreold
                                          where arreold.k00_numpre = recibopaga.k00_numpre
                                            and arreold.k00_numpar = recibopaga.k00_numpar
                                         --   and arreold.k00_receit = recibopaga.k00_receit
                                          union all
                                         select 1
                                           from arreprescr
                                          where arreprescr.k30_numpre = recibopaga.k00_numpre
                                            and arreprescr.k30_numpar = recibopaga.k00_numpar
                                         --   and arreprescr.k30_receit = recibopaga.k00_receit
                                          limit 1 )
                       group by recibopaga.k00_numpre,
                                recibopaga.k00_numpar,
                                recibopaga.k00_receit,
                                recibopaga.k00_hist,
                                recibopaga.k00_numcgm,
                                recibopaga.k00_numtot,
                                recibopaga.k00_numdig
          loop

            if nVlrDiferencaPgto <= 0 then

              if lRaise is true then

                perform fc_debug('  <PgtoParcial>  - '     ,lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - SAIDA',lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - '     ,lRaise,false,false);

              end if;

              exit;

            end if;

            nVlrPgtoParcela := trunc((rRecord.k00_valor * ( nPercDesconto / 100 ))::numeric,2);


            if lRaise is true then
              perform fc_debug('  <PgtoParcial>  -   Numpre: '||lpad(rRecord.k00_numpre,10,'0')||' Numpar: '||lpad(rRecord.k00_numpar, 3,'0')||' Receita: '||lpad(rRecord.k00_receit,10,'0')||' Valor Parcela: '||rRecord.k00_valor::numeric(15,2)||' Valor Pago: '||nVlrPgtoParcela::numeric(15,2)||' Resto: '||nVlrDiferencaPgto::numeric(15,2),lRaise,false,false);
            end if;


            if nVlrPgtoParcela <= 0 then

              if lRaise is true then
                perform fc_debug('  <PgtoParcial>  -   * Valor Parcela Menor que 0,01 - Corrige para 0,01 ',lRaise,false,false);
                perform fc_debug('  <PgtoParcial>  - ',lRaise,false,false);
              end if;

              nVlrPgtoParcela := 0.01;

            end if;


            select k00_sequencial
              into iArreckey
              from arrecadacao.arreckey
             where k00_numpre = rRecord.k00_numpre
               and k00_numpar = rRecord.k00_numpar
               and k00_receit = rRecord.k00_receit
               and k00_hist   = rRecord.k00_hist;


            if not found then

              select nextval('arreckey_k00_sequencial_seq')
                into iArreckey;

              insert into arreckey ( k00_sequencial,
                                     k00_numpre,
                                     k00_numpar,
                                     k00_receit,
                                     k00_hist,
                                     k00_tipo
                                   ) values (
                                     iArreckey,
                                     rRecord.k00_numpre,
                                     rRecord.k00_numpar,
                                     rRecord.k00_receit,
                                     rRecord.k00_hist,
                                     rRecord.k00_tipo
                                   );
            end if;


            select k128_sequencial
              into iAbatimentoArreckey
              from abatimentoarreckey
                   inner join arreckey on arreckey.k00_sequencial = abatimentoarreckey.k128_arreckey
             where abatimentoarreckey.k128_abatimento = iAbatimento
               and arreckey.k00_numpre = rRecord.k00_numpre
               and arreckey.k00_numpar = rRecord.k00_numpar
               and arreckey.k00_receit = rRecord.k00_receit
               and arreckey.k00_hist   = rRecord.k00_hist;

            if found then

              update abatimentoarreckey
                 set k128_valorabatido = ( k128_valorabatido + nVlrPgtoParcela )::numeric(15,2)
               where k128_sequencial   = iAbatimentoArreckey;

            else

              -- Insere ligacao do abatimento com o

              insert into abatimentoarreckey ( k128_sequencial,
                                               k128_arreckey,
                                               k128_abatimento,
                                               k128_valorabatido,
                                             k128_correcao,
                                             k128_juros,
                                             k128_multa
                                             ) values (
                                               nextval('abatimentoarreckey_k128_sequencial_seq'),
                                               iArreckey,
                                               iAbatimento,
                                               nVlrPgtoParcela,
                                               0,
                                               0,
                                               0
                                             );
            end if;

            nVlrDiferencaPgto := round(nVlrDiferencaPgto - nVlrPgtoParcela,2);

          end loop;

        end loop;

      end if; -- fim credito/desconto

    end loop;

    if lRaise is true then
      perform fc_debug('  <PgtoParcial>  -  FIM ABATIMENTO ',lRaise,false,false);
    end if;

  end if;

  /**
   * Fim do Pagamento Parcial
   */

  if lRaise is true then
    perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
    perform fc_debug('  <BaixaBanco>  - processando numpres duplos com pagamento em cota unica e parcelado no mesmo arquivo...',lRaise,false,false);
    perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
  end if;

  for r_codret in
      select disbanco.codret,
             disbanco.idret,
             disbanco.instit,
             disbanco.k00_numpre,
             disbanco.k00_numpar,
             coalesce((select count(*)
                         from recibopaga
                        where recibopaga.k00_numnov = disbanco.k00_numpre
                          and disbanco.k00_numpar = 0),0) as quant_recibopaga,
             coalesce((select count(*)
                         from arrecad
                        where arrecad.k00_numpre = disbanco.k00_numpre
                          and disbanco.k00_numpar = 0),0) as quant_arrecad_unica,
             coalesce((select max(k00_numtot)
                         from arrecad
                        where arrecad.k00_numpre = disbanco.k00_numpre
                          and disbanco.k00_numpar = 0),0) as arrecad_unica_numtot,
             coalesce((select count(distinct k00_numpar)
                         from arrecad
                        where arrecad.k00_numpre = disbanco.k00_numpre
                          and disbanco.k00_numpar = 0),0) as arrecad_unica_quant_numpar,
             coalesce((select max(d2.idret)
                         from disbanco d2
                        where d2.k00_numpre = disbanco.k00_numpre
                          and d2.codret = disbanco.codret
                          and d2.idret <> disbanco.idret
                          and classi is false),0) as idret_mesmo_numpre
        from disbanco
       where disbanco.codret = cod_ret
         and disbanco.classi is false
         and disbanco.instit = iInstitSessao
    order by idret
  loop

    -- idret_mesmo_numpre
    -- busca se tem algum numpre duplo no mesmo arquivo (significa que o contribuinte pagou no mesmo dia e banco e consequentemente no mesmo arquivo
    -- o numpre numpre 2 ou mais vezes

    if lRaise is true then
      perform fc_debug('  <BaixaBanco>  - idret: '||r_codret.idret||' - numpre: '||r_codret.k00_numpre||' - parcela: '||r_codret.k00_numpar||' - quant_recibopaga: '||r_codret.quant_recibopaga||' - quant_arrecad_unica: '||r_codret.quant_arrecad_unica||' - arrecad_unica_numtot: '||r_codret.arrecad_unica_numtot||' - arrecad_unica_quant_numpar: '||r_codret.arrecad_unica_quant_numpar,lRaise,false,false);
    end if;

    -- alteracao 1
    -- o sistema tem que descobrir nos casos de pagamento da unica e parcelado, qual o idret na unica de maior percentual (pois pode ter pago 2 unicas)
    -- e nao inserir na tabela "tmpnaoprocessar" o idret desse registro

    if r_codret.k00_numpar = 0 and r_codret.quant_arrecad_unica > 0 then

      if r_codret.arrecad_unica_quant_numpar <> r_codret.arrecad_unica_numtot then
        -- se for unica e a quantidade de parcelas em aberto for diferente da quantidade total de parcelas, significa que o contribuinte pagou como unica
        -- mas ja tem parcelas em aberto, e dessa forma o sistema nao vai processar esse registro para alguem verificar o que realmente vai ser feito,
        -- pois o contribuinte pagou o valor da unica mas nao tem mais todas as parcelas que formaram a unica em aberto

        if cCliente != 'ALEGRETE' then
          insert into tmpnaoprocessar values (r_codret.idret);

          if lRaise is true then
           perform fc_debug('  <BaixaBanco>  - inserindo em tmpnaoprocessar (1): '||r_codret.idret,lRaise,false,false);
          end if;
        end if;

      else

        for r_testa in
          select idret,
                 k00_numpre,
                 k00_numpar
            from disbanco
           where disbanco.k00_numpre =  r_codret.k00_numpre
             and disbanco.codret     =  r_codret.codret
             and disbanco.idret      <> r_codret.idret
             and classi              is false
        loop

          if lRaise is true then
            perform fc_debug('  <BaixaBanco>  - idret: '||r_testa.idret||' - numpar: '||r_testa.k00_numpar,lRaise,false,false);
          end if;

          -- busca a parcela unica de menor valor (maior percentual de desconto) paga por esse numpre
          select idret
          into iIdRetProcessar
          from disbanco
          where disbanco.k00_numpre =  r_codret.k00_numpre
                and disbanco.k00_numpar = 0
                and disbanco.codret     =  r_codret.codret
                and classi is false
          order by vlrpago limit 1;

          if lRaise is true then
            perform fc_debug('  <BaixaBanco>  - idret: '||r_testa.idret||' - iIdRetProcessar: '||iIdRetProcessar,lRaise,false,false);
          end if;

          -- senao for o registro da unica de maior percentual nao processa
          if iIdRetProcessar != r_testa.idret then

            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  - inserindo em tmpnaoprocessar (2): '||r_testa.idret,lRaise,false,false);
            end if;

            insert into tmpnaoprocessar values (r_testa.idret);

          else

            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  - NAO inserindo em tmpnaoprocessar (2): '||r_testa.idret,lRaise,false,false);
            end if;

          end if;

      end loop;

        select count(distinct disbanco2.idret)
          into v_contador
          from disbanco
               inner join recibopaga          on disbanco.k00_numpre  =  recibopaga.k00_numpre
                                             and disbanco.k00_numpar  =  0
               inner join disbanco disbanco2  on disbanco2.k00_numpre =  recibopaga.k00_numnov
                                             and disbanco2.k00_numpar =  0
                                             and disbanco2.codret     =  cod_ret
                                             and disbanco2.classi     is false
                                             and disbanco2.instit     =  iInstitSessao
                                             and disbanco2.idret      <> r_codret.idret
         where disbanco.codret = cod_ret
           and disbanco.classi is false
           and disbanco.instit = iInstitSessao
           and disbanco.idret  = r_codret.idret;

        if lRaise is true then
          perform fc_debug('  <BaixaBanco>  - idret: '||r_codret.idret||' - v_contador: '||v_contador,lRaise,false,false);
        end if;

        if v_contador = 1 then
          select distinct
                 disbanco2.idret
            into iIdret
            from disbanco
                 inner join recibopaga         on disbanco.k00_numpre  = recibopaga.k00_numpre
                                              and disbanco.k00_numpar  = 0
                 inner join disbanco disbanco2 on disbanco2.k00_numpre = recibopaga.k00_numnov
                                              and disbanco2.k00_numpar = 0
                                              and disbanco2.codret     = cod_ret
                                              and disbanco2.classi     is false
                                              and disbanco2.instit     = iInstitSessao
                                              and disbanco2.idret      <> r_codret.idret
           where disbanco.codret = cod_ret
             and disbanco.classi is false
             and disbanco.instit = iInstitSessao
             and disbanco.idret  = r_codret.idret;

          if lRaise is true then
            perform fc_debug('  <BaixaBanco>  - inserindo em nao processar (3) - idret1: '||iIdret||' - idret2: '||r_codret.idret,lRaise,false,false);
          end if;

          insert into tmpnaoprocessar values (iIdret);

        elsif v_contador >= 1 then
          return '21 - IDRET ' || r_codret.idret || ' COM MAIS DE UM PAGAMENTO NO MESMO ARQUIVO. CONTATE SUPORTE PARA VERIFICAÇÕES!';
        end if;

      end if;

    end if;

    -- Validamos o numpre para ver se nao esta duplicado em algum lugar
    -- arrecad(k00_numpre) = recibopaga(k00_numnov)
    -- arrecad(k00_numpre) = recibo(k00_numnov)
    -- caso esteja nao processa o numpre caindo em inconsistencia
    if exists ( select 1 from arrecad where arrecad.k00_numpre   = r_codret.k00_numpre limit 1)
          and ( exists ( select 1 from recibopaga where recibopaga.k00_numnov = r_codret.k00_numpre limit 1) or
                exists ( select 1 from recibo     where recibo.k00_numnov     = r_codret.k00_numpre limit 1) ) then
       if lRaise is true then
          perform fc_debug('  <BaixaBanco>  - inserindo em tmpnaoprocessar (5): '||r_codret.idret,lRaise,false,false);
       end if;
       insert into tmpnaoprocessar values (r_codret.idret);
    end if;

    -- Validacao numpre na ISSVAR com numpar = 0 na DISBANCO para nao processar
    -- porem se o numpre estiver na db_reciboweb (k99_numpre_n) e na issvar (q05_numpre)
    -- significa que esse debito eh oriundo de uma integracao externa. Ex: Gissonline
    if r_codret.k00_numpar = 0
      and exists (select 1 from issvar where q05_numpre = r_codret.k00_numpre)
      and not exists (select 1 from db_reciboweb where k99_numpre_n = r_codret.k00_numpre) then
      if lRaise is true then
          perform fc_debug('  <BaixaBanco>  - inserindo em tmpnaoprocessar (6): '||r_codret.idret,lRaise,false,false);
      end if;
      insert into tmpnaoprocessar values (r_codret.idret);
    end if;

    if lRaise is true then
      perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
    end if;

  end loop;

  /**
   * Adicionada validação para separar recibos e carnes que possuiam suas origens importadas para divida
   * apenas quando pagamento parcial estiver DESATIVADO
   */
  if lAtivaPgtoParcial = false then

    if lRaise is true then
      perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
      perform fc_debug('  <BaixaBanco>  - inicio separando recibopaga...',lRaise,false,false);
      perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
    end if;

    -- acertando recibos (recibopaga) com registros que foram importados divida e outros que nao foram importados, e estava gerando erro, entao a logica abaixo
    -- separa em dois recibos novos os casos
    for r_codret in
        select disbanco.codret,
               disbanco.idret,
               disbanco.instit,
               disbanco.k00_numpre,
               disbanco.k00_numpar,
               disbanco.vlrpago::numeric(15,2),
               (select round(sum(k00_valor),2)
                  from recibopaga
                 where k00_numnov = disbanco.k00_numpre) as recibopaga_sum_valor
         from disbanco
         where disbanco.codret = cod_ret
           and disbanco.classi is false
           and disbanco.instit = iInstitSessao
           and k00_numpar = 0
           and exists (select 1 from recibopaga inner join divold on k00_numpre = k10_numpre and k00_numpar = k10_numpar where k00_numnov = disbanco.k00_numpre)
           and (select count(*) from recibopaga where k00_numnov = disbanco.k00_numpre) > 0
           and disbanco.idret not in (select idret from tmpnaoprocessar)
      order by idret
    loop

        perform *
           from abatimentodisbanco
          where k132_idret = r_codret.idret;

        if found then
          continue;
        end if;

        if lRaise is true then
          perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
          perform fc_debug('  <BaixaBanco>  - idret: '||r_codret.idret||' - vlrpago: '||r_codret.vlrpago||' - numpre: '||r_codret.k00_numpre||' - numpar: '||r_codret.k00_numpar,lRaise,false,false);
        end if;

        nSimDivold := 0;
        nNaoDivold := 0;

        nValorSimDivold := 0;
        nValorNaoDivold := 0;

        nTotValorPagoDivold := 0;

        nTotalRecibo       := 0;
        nTotalNovosRecibos := 0;

        perform * from (
        select  recibopaga.k00_numpre as recibopaga_numpre,
                recibopaga.k00_numpar as recibopaga_numpar,
                recibopaga.k00_receit as recibopaga_receit,
                recibopaga.k00_numnov,
                coalesce( (select count(*)
                             from divold
                                  inner join divida  on divold.k10_coddiv  = divida.v01_coddiv
                                  inner join arrecad on arrecad.k00_numpre = divida.v01_numpre
                                                    and arrecad.k00_numpar = divida.v01_numpar
                                                    and arrecad.k00_valor  > 0
                            where divold.k10_numpre = recibopaga.k00_numpre
                              and divold.k10_numpar = recibopaga.k00_numpar
                          ), 0 ) as divold,
                round(sum(k00_valor),2) as k00_valor
           from disbanco
                inner join recibopaga on disbanco.k00_numpre = recibopaga.k00_numnov
                                     and disbanco.k00_numpar = 0
          where disbanco.idret = r_codret.idret
          group by recibopaga.k00_numpre,
                   recibopaga.k00_numpar,
                   recibopaga.k00_receit,
                   recibopaga.k00_numnov,
                   divold
        ) as x where k00_valor < 0;

        if found then
          insert into tmpnaoprocessar values (r_codret.idret);
          perform fc_debug('  <BaixaBanco>  - idret '||r_codret.idret || ' - insert tmpnaoprocessar',lRaise,false,false);
        else

          for r_testa in
          select  recibopaga.k00_numpre as recibopaga_numpre,
                  recibopaga.k00_numpar as recibopaga_numpar,
                  recibopaga.k00_receit as recibopaga_receit,
                  recibopaga.k00_numnov,
                  coalesce( (select count(*)
                               from divold
                                    inner join divida  on divold.k10_coddiv = divida.v01_coddiv
                                    inner join arrecad on arrecad.k00_numpre = divida.v01_numpre
                                                     and arrecad.k00_numpar = divida.v01_numpar
                 and arrecad.k00_valor > 0
                             where divold.k10_numpre = recibopaga.k00_numpre
                               and divold.k10_numpar = recibopaga.k00_numpar
                             --and divold.k10_receita = recibopaga.k00_receit
                            ),0) as divold,
                  round(sum(k00_valor),2) as k00_valor
             from disbanco
                  inner join recibopaga on disbanco.k00_numpre = recibopaga.k00_numnov
                                       and disbanco.k00_numpar = 0
            where disbanco.idret = r_codret.idret
            group by recibopaga.k00_numpre,
                     recibopaga.k00_numpar,
                     recibopaga.k00_receit,
                     recibopaga.k00_numnov,
                     divold
          loop

            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  - verificando recibopaga - numpre: '||r_testa.recibopaga_numpre||' - numpar: '||r_testa.recibopaga_numpar||' - divold: '||r_testa.divold||' - k00_valor: '||r_testa.k00_valor,lRaise,false,false);
            end if;

            if r_testa.divold > 0 then
              nSimDivold := nSimDivold + 1;
              nValorSimDivold := nValorSimDivold + r_testa.k00_valor;
            else
              nNaoDivold := nNaoDivold + 1;
              nValorNaoDivold := nValorNaoDivold + r_testa.k00_valor;
            end if;
            insert into tmpacerta_recibopaga_unif values (r_testa.recibopaga_numpre, r_testa.recibopaga_numpar, r_testa.recibopaga_receit, r_testa.k00_numnov, case when r_testa.divold > 0 then 1 else 2 end);

          end loop;

        end if;

        if lRaise is true then
          perform fc_debug('  <BaixaBanco>  - nSimDivold: '||nSimDivold||' - nNaoDivold: '||nNaoDivold||' - idret: '||r_codret.idret,lRaise,false,false);
        end if;

        if nSimDivold > 0 and nNaoDivold > 0 then

          if lRaise is true then
            perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
            perform fc_debug('  <BaixaBanco>  - vai ser dividido...',lRaise,false,false);
            perform fc_debug('  <BaixaBanco>  - nSimDivold: '||nSimDivold||' - nNaoDivold: '||nNaoDivold||' - idret: '||r_codret.idret,lRaise,false,false);
            perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
          end if;

          nValorTotDivold := nValorSimDivold + nValorNaoDivold;

          for rContador in select 1 as tipo union select 2 as tipo
            loop

            select nextval('numpref_k03_numpre_seq') into iNumnovDivold;

            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  - inserindo em recibopaga - numnov: '||iNumnovDivold,lRaise,false,false);
              perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
            end if;

            insert into recibopaga
            (
            k00_numcgm,
            k00_dtoper,
            k00_receit,
            k00_hist,
            k00_valor,
            k00_dtvenc,
            k00_numpre,
            k00_numpar,
            k00_numtot,
            k00_numdig,
            k00_conta,
            k00_dtpaga,
            k00_numnov
            )
            select
            k00_numcgm,
            k00_dtoper,
            k00_receit,
            k00_hist,
            k00_valor,
            k00_dtvenc,
            k00_numpre,
            k00_numpar,
            k00_numtot,
            k00_numdig,
            k00_conta,
            k00_dtpaga,
            iNumnovDivold
            from recibopaga
            inner join tmpacerta_recibopaga_unif on
            recibopaga.k00_numpre = tmpacerta_recibopaga_unif.numpre and
            recibopaga.k00_numpar = tmpacerta_recibopaga_unif.numpar and
            recibopaga.k00_receit = tmpacerta_recibopaga_unif.receit and
            recibopaga.k00_numnov = tmpacerta_recibopaga_unif.numpreoriginal
            where tmpacerta_recibopaga_unif.tipo = rContador.tipo;

            insert into db_reciboweb
            (
            k99_numpre,
            k99_numpar,
            k99_numpre_n,
            k99_codbco,
            k99_codage,
            k99_numbco,
            k99_desconto,
            k99_tipo,
            k99_origem
            )
            select
            distinct
            k99_numpre,
            k99_numpar,
            iNumnovDivold,
            k99_codbco,
            k99_codage,
            k99_numbco,
            k99_desconto,
            k99_tipo,
            k99_origem
            from db_reciboweb
            inner join tmpacerta_recibopaga_unif on
            k99_numpre = tmpacerta_recibopaga_unif.numpre and
            k99_numpar = tmpacerta_recibopaga_unif.numpar and
            k99_numpre_n = tmpacerta_recibopaga_unif.numpreoriginal
            where tmpacerta_recibopaga_unif.tipo = rContador.tipo;

            insert into arrehist
            (
            k00_numpre,
            k00_numpar,
            k00_hist,
            k00_dtoper,
            k00_hora,
            k00_id_usuario,
            k00_histtxt,
            k00_limithist,
            k00_idhist
            )
            values
            (
            iNumnovDivold,
            0,
            930,
            current_date,
            to_char(now(), 'HH24:MI'),
            1,
            'criado automaticamente pela divisao automatica dos recibos durante a consistencia da baixa de banco - numpre original: ' || r_testa.k00_numnov,
            null,
            nextval('arrehist_k00_idhist_seq'));

            select nextval('disbanco_idret_seq') into v_nextidret;

            nValorPagoDivold := case when rContador.tipo = 1 then nValorSimDivold else nValorNaoDivold end / nValorTotDivold * r_codret.vlrpago;
            nTotValorPagoDivold := nTotValorPagoDivold + nValorPagoDivold;

            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  - tipo: '||rContador.tipo||' - nValorSimDivold: '||nValorSimDivold||' - nValorNaoDivold: '||nValorNaoDivold||' - nValorTotDivold: '||nValorTotDivold||' - vlrpago: '||r_codret.vlrpago||' - nTotValorPagoDivold: '||nTotValorPagoDivold,lRaise,false,false);
            end if;

            if rContador.tipo = 2 then
              if nTotValorPagoDivold <> r_codret.vlrpago then
                if lRaise is true then
                  perform fc_debug('  <BaixaBanco>  - acertando nValorPagoDivold',lRaise,false,false);
                end if;
                nValorPagoDivold := r_codret.vlrpago - nTotValorPagoDivold;
              end if;
            end if;

            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  - inserindo disbanco - idret: '||v_nextidret||' - vlrpago: '||nValorPagoDivold||' - numnov: '||iNumnovDivold||' - novo idret: '||v_nextidret,lRaise,false,false);
            end if;

            insert into disbanco (k00_numbco,
                                  k15_codbco,
                                  k15_codage,
                                  codret,
                                  dtarq,
                                  dtpago,
                                  vlrpago,
                                  vlrjuros,
                                  vlrmulta,
                                  vlracres,
                                  vlrdesco,
                                  vlrtot,
                                  cedente,
                                  vlrcalc,
                                  idret,
                                  classi,
                                  k00_numpre,
                                  k00_numpar,
                                  convenio,
                                  instit )
                           select k00_numbco,
                                  k15_codbco,
                                  k15_codage,
                                  codret,
                                  dtarq,
                                  dtpago,
                                  round(nValorPagoDivold,2),
                                  0,
                                  0,
                                  0,
                                  0,
                                  round(nValorPagoDivold,2),
                                  cedente,
                                  round(vlrcalc,2),
                                  v_nextidret,
                                  false,
                                  iNumnovDivold,
                                  0,
                                  convenio,
                                  instit
                             from disbanco
                            where idret = r_codret.idret;

            insert into tmpantesprocessar (idret, vlrpago, v01_seq) values (v_nextidret, nValorPagoDivold, (select nextval('w_divold_seq')) );

            select round(sum(k00_valor),2)
              into nTotalRecibo
              from recibopaga where k00_numnov = iNumnovDivold;

            nTotalNovosRecibos := nTotalNovosRecibos + nTotalRecibo;

          end loop;

          if lRaise is true then
            perform fc_debug('  <BaixaBanco>  - nTotalNovosRecibos: '||nTotalNovosRecibos||' - recibopaga_k00_valor: '||r_codret.recibopaga_sum_valor,lRaise,false,false);
            if round(nTotalNovosRecibos,2) <> round(r_codret.recibopaga_sum_valor,2) then
              return '22 - INCONSISTENCIA AO GERAR NOVOS RECIBOS NA DIVISAO. IDRET: ' || r_codret.idret || ' - NUMPRE RECIBO ORIGINAL: ' || r_codret.k00_numpre;
            end if;
          end if;

          update disbancotxtreg
             set k35_idret = v_nextidret
           where k35_idret = r_codret.idret;

          delete
            from issarqsimplesregdisbanco
           where q44_disbanco = r_codret.idret;

          delete
            from disbancoprocesso
           where k142_idret = r_codret.idret;

          delete
            from disbanco
           where disbanco.idret = r_codret.idret;

        else

          if lRaise is true then
            perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
            perform fc_debug('  <BaixaBanco>  - NAO vai ser dividido...',lRaise,false,false);
            perform fc_debug('  <BaixaBanco>  - nSimDivold: '||nSimDivold||' - nNaoDivold: '||nNaoDivold||' - idret: '||r_codret.idret,lRaise,false,false);
            perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
          end if;

        end if;

        delete from tmpacerta_recibopaga_unif;

    end loop;

    if lRaise is true then
      perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
      perform fc_debug('  <BaixaBanco>  - fim separando recibopaga...',lRaise,false,false);
      perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
    end if;

  end if;
  /**
   * Fim da separação de recibos e carnes que possuiam suas origens importadas para divida
   */

  select round(sum(vlrpago),2)
    into nTotalDisbancoOriginal
    from tmpdisbanco_inicio_original;

  select round(sum(vlrpago),2)
    into nTotalDisbancoDepois
    from disbanco
   where disbanco.codret = cod_ret
     and disbanco.classi is false
     and disbanco.instit = iInstitSessao;

  if lRaise is true then
    perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
    perform fc_debug('  <BaixaBanco>  - nTotalDisbancoOriginal: '||nTotalDisbancoOriginal||' - nTotalDisbancoDepois: '||nTotalDisbancoDepois,lRaise,false,false);
    perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
    perform fc_debug('  <BaixaBanco>  - inicio verificando se foi importado para divida',lRaise,false,false);
    perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
  end if;

  -- verifica se foi importado para divida, porem somente nos casos de pagamento por carne, ou seja, registros que estejam no arrecad pelo numpre e parcela
  for r_codret in
      select disbanco.codret,
             disbanco.idret,
             disbanco.instit
        from disbanco
       where disbanco.codret = cod_ret
         and disbanco.classi is false
         and disbanco.instit = iInstitSessao
         and disbanco.idret not in (select idret from tmpnaoprocessar)
    order by idret
  loop

    -- inicio numpre/numpar (carne)
    for r_idret in
      select distinct
             1 as tipo,
             disbanco.dtarq,
             disbanco.dtpago,
             disbanco.k00_numpre as numpre,
             disbanco.k00_numpar as numpar,
             disbanco.idret,
             disbanco.k15_codbco,
             disbanco.k15_codage,
             disbanco.k00_numbco,
             disbanco.vlrpago,
             disbanco.vlracres,
             disbanco.vlrdesco,
             disbanco.vlrjuros,
             disbanco.vlrmulta,
             disbanco.instit
        from disbanco
             inner join divold   on divold.k10_numpre = disbanco.k00_numpre
                                and divold.k10_numpar = disbanco.k00_numpar
             inner join divida   on divida.v01_coddiv = divold.k10_coddiv
                                and divida.v01_instit = iInstitSessao
             inner join arrecad  on arrecad.k00_numpre = divida.v01_numpre
                                and arrecad.k00_numpar = divida.v01_numpar
        and arrecad.k00_valor > 0
       where disbanco.idret  = r_codret.idret
         and disbanco.classi is false
         and disbanco.instit = iInstitSessao
         and disbanco.k00_numpar > 0
      union
      select distinct
             2 as tipo,
             disbanco.dtarq,
             disbanco.dtpago,
             disbanco.k00_numpre as numpre,
             disbanco.k00_numpar as numpar,
             disbanco.idret,
             disbanco.k15_codbco,
             disbanco.k15_codage,
             disbanco.k00_numbco,
             disbanco.vlrpago,
             disbanco.vlracres,
             disbanco.vlrdesco,
             disbanco.vlrjuros,
             disbanco.vlrmulta,
             disbanco.instit
       from disbanco
             inner join db_reciboweb on db_reciboweb.k99_numpre_n = disbanco.k00_numpre
             inner join divold       on divold.k10_numpre = db_reciboweb.k99_numpre
                                    and divold.k10_numpar = db_reciboweb.k99_numpar
             inner join divida       on divida.v01_coddiv = divold.k10_coddiv
                                    and divida.v01_instit = iInstitSessao
             inner join arrecad      on arrecad.k00_numpre = divida.v01_numpre
                                    and arrecad.k00_numpar = divida.v01_numpar
            and arrecad.k00_valor > 0
       where disbanco.idret  = r_codret.idret
         and disbanco.classi is false
         and disbanco.instit = iInstitSessao
         and disbanco.k00_numpar = 0
       union
      select distinct
             3 as tipo,
             disbanco.dtarq,
             disbanco.dtpago,
             disbanco.k00_numpre as numpre,
             disbanco.k00_numpar as numpar,
             disbanco.idret,
             disbanco.k15_codbco,
             disbanco.k15_codage,
             disbanco.k00_numbco,
             disbanco.vlrpago,
             disbanco.vlracres,
             disbanco.vlrdesco,
             disbanco.vlrjuros,
             disbanco.vlrmulta,
             disbanco.instit
        from disbanco
             inner join divold   on divold.k10_numpre = disbanco.k00_numpre and disbanco.k00_numpar = 0
             inner join divida   on divida.v01_coddiv = divold.k10_coddiv
                                and divida.v01_instit = iInstitSessao
             inner join arrecad  on arrecad.k00_numpre = divida.v01_numpre
                                and arrecad.k00_numpar = divida.v01_numpar
                                and arrecad.k00_valor > 0
       where disbanco.idret  = r_codret.idret
         and disbanco.classi is false
         and disbanco.instit = iInstitSessao
         and disbanco.k00_numpar = 0

    loop

      --
      -- Verificamos se o idret ja nao teve um abatimento lancado.
      --   Quando temos um recibo que teve uma de suas origens(numpre, numpar) importadas para divida / parcelada
      --   antes do processamento do pagamento a baixa os retira do recibopaga para gerar uma diferenca e processa
      --   o pagamento parcial / credito normalmente
      -- Por isso no caso de existir regitros na abatimentodisbanco passamos para a proxima volta do for
      --
      perform *
         from abatimentodisbanco
        where k132_idret = r_codret.idret;

      if found then
        continue;
      end if;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
        perform fc_debug('  <BaixaBanco>  - divold idret: '||R_IDRET.idret||' - tipo: '||R_IDRET.tipo||' - vlrpago: '||R_IDRET.vlrpago,lRaise,false,false);
      end if;

      v_total1 := 0;
      v_total2 := 0;
      v_diferenca_round := 0;

      for r_divold in

        select distinct
               1 as tipo,
               v01_coddiv,
               divida.v01_numpre,
               divida.v01_numpar,
               divida.v01_valor
          from disbanco
               inner join divold   on divold.k10_numpre = disbanco.k00_numpre
                                  and divold.k10_numpar = disbanco.k00_numpar
               inner join divida   on divida.v01_coddiv = divold.k10_coddiv
                                  and divida.v01_instit = iInstitSessao
               inner join arrecad  on arrecad.k00_numpre = divida.v01_numpre
                                  and arrecad.k00_numpar = divida.v01_numpar
          and arrecad.k00_valor > 0
         where disbanco.idret  = r_codret.idret and r_idret.tipo = 1
           and disbanco.classi is false
           and disbanco.instit = iInstitSessao
           and disbanco.k00_numpar > 0
        union
        select distinct
               2 as tipo,
               v01_coddiv,
               divida.v01_numpre,
               divida.v01_numpar,
               divida.v01_valor
          from disbanco
               inner join db_reciboweb on db_reciboweb.k99_numpre_n = disbanco.k00_numpre and disbanco.k00_numpar = 0
               inner join divold       on divold.k10_numpre = db_reciboweb.k99_numpre
                                      and divold.k10_numpar = db_reciboweb.k99_numpar
               inner join divida       on divida.v01_coddiv = divold.k10_coddiv
                                      and divida.v01_instit = iInstitSessao
               inner join arrecad      on arrecad.k00_numpre = divida.v01_numpre
                                      and arrecad.k00_numpar = divida.v01_numpar
              and arrecad.k00_valor > 0
         where disbanco.idret  = r_codret.idret and r_idret.tipo = 2
           and disbanco.classi is false
           and disbanco.instit = iInstitSessao
         union
        select distinct
               3 as tipo,
               v01_coddiv,
               divida.v01_numpre,
               divida.v01_numpar,
               divida.v01_valor
          from disbanco
               inner join divold   on divold.k10_numpre = disbanco.k00_numpre and disbanco.k00_numpar = 0
               inner join divida   on divida.v01_coddiv = divold.k10_coddiv
                                  and divida.v01_instit = iInstitSessao
               inner join arrecad  on arrecad.k00_numpre = divida.v01_numpre
                                  and arrecad.k00_numpar = divida.v01_numpar
          and arrecad.k00_valor > 0
         where disbanco.idret  = r_codret.idret and r_idret.tipo = 3
           and disbanco.classi is false
           and disbanco.instit = iInstitSessao
           and disbanco.k00_numpar = 0

      loop

        if lRaise is true then
          perform fc_debug('  <BaixaBanco>  - somando v_total1 - v01_coddiv: '||r_divold.v01_coddiv||' - valor: '||r_divold.v01_valor,lRaise,false,false);
        end if;

        v_total1 := v_total1 + r_divold.v01_valor;

      end loop;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - idret: '||r_codret.idret||' - v_total1: '||v_total1,lRaise,false,false);
      end if;

      for r_divold in
        select * from
        (
        select distinct
               1 as tipo,
               v01_coddiv,
               divida.v01_numpre,
               divida.v01_numpar,
               divida.v01_valor,
               nextval('w_divold_seq') as v01_seq
          from disbanco
               inner join divold   on divold.k10_numpre = disbanco.k00_numpre
                                  and divold.k10_numpar = disbanco.k00_numpar
               inner join divida   on divida.v01_coddiv = divold.k10_coddiv
                                  and divida.v01_instit = iInstitSessao
               inner join arrecad  on arrecad.k00_numpre = divida.v01_numpre
                                  and arrecad.k00_numpar = divida.v01_numpar
          and arrecad.k00_valor > 0
         where disbanco.idret  = r_codret.idret
           and disbanco.classi is false
           and disbanco.instit = iInstitSessao
           and r_idret.tipo = 1
           and disbanco.k00_numpar > 0
         union
         select distinct
               2 as tipo,
               v01_coddiv,
               v01_numpre,
               v01_numpar,
               v01_valor,
               nextval('w_divold_seq') as v01_seq
          from (
                 select distinct
                       v01_coddiv,
                       divida.v01_numpre,
                       divida.v01_numpar,
                       divida.v01_valor
                  from disbanco
                       inner join db_reciboweb on db_reciboweb.k99_numpre_n = disbanco.k00_numpre and disbanco.k00_numpar = 0
                       inner join divold   on divold.k10_numpre = db_reciboweb.k99_numpre
                                          and divold.k10_numpar = db_reciboweb.k99_numpar
                       inner join divida   on divida.v01_coddiv = divold.k10_coddiv
                                          and divida.v01_instit = iInstitSessao
                       inner join arrecad  on arrecad.k00_numpre = divida.v01_numpre
                                          and arrecad.k00_numpar = divida.v01_numpar
            and arrecad.k00_valor > 0
                 where disbanco.idret  = r_codret.idret
                   and disbanco.classi is false
                   and disbanco.instit = iInstitSessao
                   and r_idret.tipo = 2
              ) as x
        union
         select distinct
               3 as tipo,
               v01_coddiv,
               v01_numpre,
               v01_numpar,
               v01_valor,
               nextval('w_divold_seq') as v01_seq
          from (
                select distinct
                       v01_coddiv,
                       divida.v01_numpre,
                       divida.v01_numpar,
                       divida.v01_valor
                from disbanco
                     inner join divold   on divold.k10_numpre = disbanco.k00_numpre and disbanco.k00_numpar = 0
                     inner join divida   on divida.v01_coddiv = divold.k10_coddiv
                                        and divida.v01_instit = iInstitSessao
                     inner join arrecad  on arrecad.k00_numpre = divida.v01_numpre
                                        and arrecad.k00_numpar = divida.v01_numpar
          and arrecad.k00_valor > 0
               where disbanco.idret  = r_codret.idret
                 and disbanco.classi is false
                 and disbanco.instit = iInstitSessao
                 and r_idret.tipo = 3
                 and disbanco.k00_numpar = 0
              ) as x
           ) as x
           order by v01_seq

      loop

        select nextval('disbanco_idret_seq')
          into v_nextidret;

        v_valor           := round(round(r_divold.v01_valor, 2) / v_total1 * round(r_idret.vlrpago, 2), 2);
        v_valor_sem_round := round(r_divold.v01_valor, 2) / v_total1 * round(r_idret.vlrpago, 2);

        v_diferenca_round := v_diferenca_round + (v_valor - v_valor_sem_round);

        if lRaise is true then
          perform fc_debug('  <BaixaBanco>  - inserindo disbanco - processando idret: '||r_codret.idret||' - v01_coddiv: '||r_divold.v01_coddiv||' - valor: '||v_valor,lRaise,false,false);
        end if;

        if lRaise is true then
          perform fc_debug('  <BaixaBanco>  - v_valor: '||v_valor||' - v_valor_sem_round: '||v_valor_sem_round||' - v_diferenca_round: '||v_diferenca_round||' - seq: '||r_divold.v01_seq||' - tipo: '||r_divold.tipo,lRaise,false,false);
        end if;

        insert into disbanco (
          k00_numbco,
          k15_codbco,
          k15_codage,
          codret,
          dtarq,
          dtpago,
          vlrpago,
          vlrjuros,
          vlrmulta,
          vlracres,
          vlrdesco,
          vlrtot,
          cedente,
          vlrcalc,
          idret,
          classi,
          k00_numpre,
          k00_numpar,
          convenio,
          instit
        ) values (
          r_idret.k00_numbco,
          r_idret.k15_codbco,
          r_idret.k15_codage,
          cod_ret,
          r_idret.dtarq,
          r_idret.dtpago,
          v_valor,
          0,
          0,
          0,
          0,
          v_valor,
          '',
          0,
          v_nextidret,
          false,
          r_divold.v01_numpre,
          r_divold.v01_numpar,
          '',
          r_idret.instit
        );

        insert into tmpantesprocessar (idret, vlrpago, v01_seq) values (v_nextidret, v_valor, r_divold.v01_seq);

        v_total2 := v_total2 + v_valor;

      end loop;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - v_total2 antes da diferenca do round: '||v_total2,lRaise,false,false);
      end if;

      if v_diferenca_round <> 0 then
        update tmpantesprocessar set vlrpago = round(vlrpago - v_diferenca_round,2) where v01_seq = (select max(v01_seq) from tmpantesprocessar);
        update disbanco          set vlrpago = round(vlrpago - v_diferenca_round,2) where idret   = (select idret from tmpantesprocessar where v01_seq = (select max(v01_seq) from tmpantesprocessar));
        v_total2 := v_total2 - v_diferenca_round;
        if lRaise is true then
          perform fc_debug('  <BaixaBanco>  - v_total2 depois da diferenca do round: '||v_total2,lRaise,false,false);
        end if;

      end if;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - v_total2: '||v_total2||' - vlrpago: '||r_idret.vlrpago,lRaise,false,false);
      end if;

      if round(v_total2, 2) <> round(r_idret.vlrpago, 2) then
        return '23 - IDRET ' || r_codret.idret || ' INCONSISTENTE AO VINCULAR A DIVIDA ATIVA! CONTATE SUPORTE - VALOR SOMADO: ' || v_total2 || ' - VALOR PAGO: ' || r_idret.vlrpago || '!';
      end if;

      update disbancotxtreg
         set k35_idret = v_nextidret
       where k35_idret = r_codret.idret;

      --
      -- Deletando da issarqsimplesregdisbanco pois pode o debito
      -- do simples ter sido importado para divida
      --
      delete
        from issarqsimplesregdisbanco
       where q44_disbanco = r_codret.idret;

      delete
        from disbancoprocesso
       where k142_idret = r_codret.idret;

      delete
        from disbanco
       where disbanco.codret = cod_ret
         and disbanco.classi = false
         and disbanco.idret  = r_codret.idret;

      delete
        from tmpantesprocessar
       where idret = r_codret.idret;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - DELETANDO DISBANCO E ANTESPROCESSAR...',lRaise,false,false);
      end if;

    end loop;

  end loop;

  if lRaise is true then
    perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
    perform fc_debug('  <BaixaBanco>  - fim verificando se foi importado para divida',lRaise,false,false);
    perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
    perform fc_debug('  <BaixaBanco>  - inicio PROCESSANDO REGISTROS...',lRaise,false,false);
    perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
  end if;

  --------
  -------- PROCESSANDO REGISTROS
  --------
  for r_codret in
      select disbanco.codret,
             disbanco.idret,
             disbanco.k00_numpre,
             disbanco.k00_numpar,
             disbanco.vlrpago
        from disbanco
       where disbanco.codret = cod_ret
         and disbanco.classi is false
         and disbanco.instit = iInstitSessao
         and disbanco.idret not in (select idret from tmpnaoprocessar)
    order by disbanco.idret
  loop
    gravaidret := 0;

    -- pelo NUMPRE
    if lRaise is true then
      perform fc_debug('  <BaixaBanco>  - iniciando registro disbanco - idret '||r_codret.idret,lRaise,false,false);
    end if;

    -- Verifica se eh recibo da emissao geral do issqn e na recibopaga esta com valor zerado
    -- caso positivo iremos atualizar o valor da recibopaga com o vlrpago da disbanco
    -- e gerar um arrehist para o caso
      select k00_numpre,
             k00_numpar,
             k00_receit,
             k00_hist,
             round(sum(k00_valor),2) as k00_valor
        into rReciboPaga
        from db_reciboweb
             inner join recibopaga  on k00_numnov = k99_numpre_n
       where k99_numpre_n = r_codret.k00_numpre
         and k99_tipo     = 6 -- Emissao Geral de ISSQN
    group by k00_numpre,
             k00_numpar,
             k00_receit,
             k00_hist
      having cast(round(sum(k00_valor),2) as numeric) = cast(0.00 as numeric);

    if found then
      update recibopaga
         set k00_valor  = r_codret.vlrpago
       where k00_numnov = r_codret.k00_numpre
         and k00_numpre = rReciboPaga.k00_numpre
         and k00_numpar = rReciboPaga.k00_numpar
         and k00_receit = rReciboPaga.k00_receit
         and k00_hist   = rReciboPaga.k00_hist;

      -- T24879: gerar arrehist para essa alteracao
      insert
        into arrehist(k00_idhist, k00_numpre, k00_numpar, k00_hist, k00_dtoper, k00_hora, k00_id_usuario, k00_histtxt, k00_limithist)
      values (nextval('arrehist_k00_idhist_seq'),
              rReciboPaga.k00_numpre,
              rReciboPaga.k00_numpar,
              rReciboPaga.k00_hist,
              cast(fc_getsession('DB_datausu') as date),
              to_char(current_timestamp, 'HH24:MI'),
              cast(fc_getsession('DB_id_usuario') as integer),
              'ALTERADO PELO ARQUIVO BANCARIO CODRET='||cast(r_codret.codret as text)||' IDRET='||cast(r_codret.idret as text),
              null);

    end if;

    v_estaemrecibopaga    := false;
    v_estaemrecibo        := false;
    v_estaemarrecadnormal := false;
    v_estaemarrecadunica  := false;

    if lRaise is true then
      perform fc_debug('  <BaixaBanco>  - verificando recibopaga...',lRaise,false,false);
      -- TESTE 1 - RECIBOPAGA
      -- alteracao 2 - sistema deve testar como ja faz na autentica se todos os registros da recibopaga estao na arrecad, e senao tem que dar inconsistencia
    end if;

    for r_idret in

    /**
     * @todo verificar numprebloqpag / alterar disbanco por recibopaga
     */
        select disbanco.k00_numpre as numpre,
               disbanco.k00_numpar as numpar,
               disbanco.idret,
               disbanco.k15_codbco,
               disbanco.k15_codage,
               disbanco.k00_numbco,
               disbanco.vlrpago,
               disbanco.vlracres,
               disbanco.vlrdesco,
               disbanco.vlrjuros,
               disbanco.vlrmulta,
               round(sum(recibopaga.k00_valor),2) as k00_valor,
               disbanco.instit
          from disbanco
               inner join recibopaga     on disbanco.k00_numpre       = recibopaga.k00_numnov
               left  join numprebloqpag  on numprebloqpag.ar22_numpre = disbanco.k00_numpre
                                        and numprebloqpag.ar22_numpar = disbanco.k00_numpar
         where disbanco.idret  = r_codret.idret
           and disbanco.classi is false
           and disbanco.instit = iInstitSessao
           and recibopaga.k00_conta = 0
           and numprebloqpag.ar22_numpre is null
      group by disbanco.k00_numpre,
               disbanco.k00_numpar,
               disbanco.idret,
               disbanco.k15_codbco,
               disbanco.k15_codage,
               disbanco.k00_numbco,
               disbanco.vlrpago,
               disbanco.vlracres,
               disbanco.vlrdesco,
               disbanco.vlrjuros,
               disbanco.vlrmulta,
               disbanco.instit
    loop

      v_estaemrecibopaga := true;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - recibopaga - numpre '||r_idret.numpre||' numpar '||r_idret.numpar,lRaise,false,false);
      end if;

      -- Verifica se algum numpre do recibo nao esta no arrecad
      -- caso nao esteja passa para o proximo e deixa inconsistente
      select coalesce(count(*),0)
        into iQtdeParcelasAberto
        from  (select distinct
                      arrecad.k00_numpre,
                      arrecad.k00_numpar
                 from recibopaga
                      inner join arrecad on arrecad.k00_numpre = recibopaga.k00_numpre
                                        and arrecad.k00_numpar = recibopaga.k00_numpar
                where k00_numnov = r_codret.k00_numpre ) as x;

      select coalesce(count(*),0)
        into iQtdeParcelasRecibo
        from (select distinct
                     recibopaga.k00_numpre,
                     recibopaga.k00_numpar
                from recibopaga
               where k00_numnov = r_codret.k00_numpre ) as x;

      if iQtdeParcelasAberto <> iQtdeParcelasRecibo then
        if lRaise is true then
          perform fc_debug('  <BaixaBanco>  -   nao encontrou arrecad... gravaidret: '||gravaidret,lRaise,false,false);
        end if;
        continue;
      else
        if lRaise is true then
          perform fc_debug('  <BaixaBanco>  -   encontrou em arrecad... gravaidret: '||gravaidret,lRaise,false,false);
        end if;
      end if;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - entrou no update vlrcalc (1)...',lRaise,false,false);
      end if;

      -- Acerta vlrcalc
      update disbanco
         set vlrcalc = round((select (substr(fc_calcula,15,13)::float8+
                                substr(fc_calcula,28,13)::float8+
                                substr(fc_calcula,41,13)::float8-
                                substr(fc_calcula,54,13)::float8) as utotal
                          from (select fc_calcula(k00_numpre,k00_numpar,0,dtpago,dtpago,extract(year from dtpago)::integer)
                                  from disbanco
                                 where idret = r_codret.idret
                                   and codret = r_codret.codret
                                   and instit = iInstitSessao
                          ) as x
                       ),2)
       where idret  = r_codret.idret
         and codret = r_codret.codret
         and instit = r_idret.instit;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - saiu no update vlrcalc (1)...',lRaise,false,false);
      end if;

      gravaidret := r_codret.idret;
      retorno    := true;

      -- INSERE NO ARREPAGA OS PAGAMENTOS
      insert into arrepaga ( k00_numcgm,
                             k00_dtoper,
                             k00_receit,
                             k00_hist,
                             k00_valor,
                             k00_dtvenc,
                             k00_numpre,
                             k00_numpar,
                             k00_numtot,
                             k00_numdig,
                             k00_conta,
                             k00_dtpaga
                           ) select k00_numcgm,
                                    datausu,
                                    k00_receit,
                                    k00_hist,
                                    round(sum(k00_valor),2) as k00_valor,
                                    datausu,
                                    k00_numpre,
                                    k00_numpar,
                                    k00_numtot,
                                    k00_numdig,
                                    conta,
                                    datausu
                               from ( select k00_numcgm,
                                             k00_receit,
                                             case
                                               when exists ( select 1
                                                               from tmplista_unica
                                                              where idret = r_idret.idret ) then 990
                                               else k00_hist
                                             end as k00_hist,
                                             round((k00_valor / r_idret.k00_valor) * r_idret.vlrpago, 2) as k00_valor,
                                             k00_numpre,
                                             k00_numpar,
                                             k00_numtot,
                                             k00_numdig
                                        from recibopaga
                                       where k00_numnov = r_idret.numpre
                                    ) as x
                           group by k00_numcgm,
                                    k00_receit,
                                    k00_hist,
                                    k00_numpre,
                                    k00_numpar,
                                    k00_numtot,
                                    k00_numdig
                           order by k00_numpre,
                                    k00_numpar,
                                    k00_receit;

-- ALTERA SITUACAO DO ARREPAGA
      update recibopaga
         set k00_conta = conta,
             k00_dtpaga = datausu
       where k00_numnov = r_idret.numpre;

      v_contador := 0;
      v_somador  := 0;
      v_contagem := 0;

      for q_disrec in
          select k00_numpre,
                 k00_numpar,
                 k00_receit,
                 sum(round((k00_valor / r_idret.k00_valor) * r_idret.vlrpago, 2))
            from recibopaga
           where k00_numnov = r_idret.numpre
        group by k00_numpre,
                 k00_numpar,
                 k00_receit
          having sum(round(k00_valor,2)) <> 0.00::float8
      loop
        v_contagem := v_contagem + 1;
      end loop;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - v_contagem: '||v_contagem,lRaise,false,false);
      end if;

      for q_disrec in
          select k00_numpre,
                 k00_numpar,
                 k00_receit,
                 sum( round((k00_valor / r_idret.k00_valor) * r_idret.vlrpago, 2) )::numeric(15,2)
            from recibopaga
           where k00_numnov = r_idret.numpre
        group by k00_numpre,
                 k00_numpar,
                 k00_receit
          having sum(round(k00_valor,2)) <> 0.00::float8
      loop

        v_contador := v_contador + 1;

        -- INSERE NO ARRECANT
        insert into arrecant  (
          k00_numpre,
          k00_numpar,
          k00_numcgm,
          k00_dtoper,
          k00_receit,
          k00_hist  ,
          k00_valor ,
          k00_dtvenc,
          k00_numtot,
          k00_numdig,
          k00_tipo  ,
          k00_tipojm
        ) select arrecad.k00_numpre,
                 arrecad.k00_numpar,
                 arrecad.k00_numcgm,
                 arrecad.k00_dtoper,
                 arrecad.k00_receit,
                 arrecad.k00_hist  ,
                 arrecad.k00_valor ,
                 arrecad.k00_dtvenc,
                 arrecad.k00_numtot,
                 arrecad.k00_numdig,
                 arrecad.k00_tipo  ,
                 arrecad.k00_tipojm
            from arrecad
                 inner join arreinstit  on arreinstit.k00_numpre = arrecad.k00_numpre
                                       and arreinstit.k00_instit = iInstitSessao
           where arrecad.k00_numpre = q_disrec.k00_numpre
             and arrecad.k00_numpar = q_disrec.k00_numpar;

        -- DELETE DO ARRECAD
        delete
          from arrecad
         using arreinstit
         where arreinstit.k00_numpre = arrecad.k00_numpre
           and arreinstit.k00_instit = iInstitSessao
           and arrecad.k00_numpre = q_disrec.k00_numpre
           and arrecad.k00_numpar = q_disrec.k00_numpar;

       -- TESTA SE EXISTE NUMPRE E NUMPAR NO ARREIDRET, NAO EXISTINDO INSERE O IDRET DO PAGAMENTO
        select arreidret.k00_numpre
          into _testeidret
          from arreidret
         where arreidret.k00_numpre = q_disrec.k00_numpre
           and arreidret.k00_numpar = q_disrec.k00_numpar
           and arreidret.idret      = r_idret.idret
           and arreidret.k00_instit = iInstitSessao;

        if lRaise is true then
          perform fc_debug('  <BaixaBanco>  - inserindo arreidret - numpre: '||q_disrec.k00_numpre||' - numpar: '||q_disrec.k00_numpar||' - idret: '||r_idret.idret,lRaise,false,false);
        end if;

        if _testeidret is null then
          insert into arreidret (
            k00_numpre,
            k00_numpar,
            idret,
            k00_instit
          ) values (
            q_disrec.k00_numpre,
            q_disrec.k00_numpar,
            r_idret.idret,
            r_idret.instit
          );
        end if;

        if q_disrec.sum != 0 then
          if autentsn is false then
-- GRAVA DISREC DAS RECEITAS PARA A CLASSIFICACAO
            v_somador := v_somador + q_disrec.sum;

            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  - inserindo disrec - receita: '||q_disrec.k00_receit||' - valor: '||q_disrec.sum||' - contador: '||v_contador||' - somador: '||v_somador||' - contagem: '||v_contagem,lRaise,false,false);
            end if;

            v_valor := q_disrec.sum;

            if v_contador = v_contagem then
              if lRaise is true then
                perform fc_debug('  <BaixaBanco>  - vlrpago: '||r_idret.vlrpago||' - v_somador: '||v_somador,lRaise,false,false);
              end if;
              v_valor := v_valor + round(r_idret.vlrpago - v_somador,2);
            end if;

            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  - into disrec 1',lRaise,false,false);
              perform fc_debug('  <BaixaBanco>  - Verifica Receita',lRaise,false,false);
            end if;

            lVerificaReceita := fc_verificareceita(q_disrec.k00_receit);

            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  - Retorno verifica Receita: '||lVerificaReceita,lRaise,false,false);
            end if;

            if lVerificaReceita is false then
              return '24 - Receita: '||q_disrec.k00_receit||' nao encontrada verifique o cadastro (1).';
            end if;

            perform * from disrec where disrec.codcla = vcodcla and disrec.k00_receit = q_disrec.k00_receit and disrec.idret = r_idret.idret and disrec.instit = r_idret.instit;

            if not found then

              v_valor := round(v_valor,2);

              if lRaise is true then
                perform fc_debug('  <BaixaBanco>  -    inserindo disrec 1 - valor: '||v_valor||' - receita: '||q_disrec.k00_receit,lRaise,false,false);
              end if;

              if v_valor > 0 then

                if lRaise is true then
                  perform fc_debug('  <BaixaBanco>  - Inserindo na DISREC. valor: '||v_valor,lRaise,false,false);
                end if;

                insert into disrec (
                  codcla,
                  k00_receit,
                  vlrrec,
                  idret,
                  instit
                ) values (
                  vcodcla,
                  q_disrec.k00_receit,
                  v_valor,
                  r_idret.idret,
                  r_idret.instit
                );
              end if;

            else

              if lRaise is true then
                perform fc_debug('  <BaixaBanco>  -    update disrec 1 - receita: '||q_disrec.k00_receit,lRaise,false,false);
              end if;

              update disrec set vlrrec = vlrrec + round(v_valor,2)
              where disrec.codcla = vcodcla and disrec.k00_receit = q_disrec.k00_receit and disrec.idret = r_idret.idret and disrec.instit = r_idret.instit;
            end if;

          end if;
        end if;

      end loop;

    end loop;

    if v_estaemrecibopaga is false then
      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - nao esta em recibopaga...',lRaise,false,false);
      end if;
    else
      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - esta em recibopaga...',lRaise,false,false);
      end if;
    end if;

-- arquivo recibo

    if lRaise is true then
      perform fc_debug('  <BaixaBanco>  - verificando recibo...',lRaise,false,false);
      -- TESTE 2 -RECIBO AVULSO
    end if;

    for r_idret in
      select distinct
             disbanco.k00_numpre as numpre,
             disbanco.k00_numpar as numpar,
             disbanco.idret,
             disbanco.k15_codbco,
             disbanco.k15_codage,
             disbanco.k00_numbco,
             disbanco.vlrpago,
             disbanco.vlracres,
             disbanco.vlrdesco,
             disbanco.vlrjuros,
             disbanco.vlrmulta,
             disbanco.instit
        from disbanco
             inner join recibo       on disbanco.k00_numpre       = recibo.k00_numpre
             left join numprebloqpag on numprebloqpag.ar22_numpre = disbanco.k00_numpre
                                    and numprebloqpag.ar22_numpar = disbanco.k00_numpar
       where disbanco.idret  = r_codret.idret
         and disbanco.classi = false
         and disbanco.instit = iInstitSessao
         and numprebloqpag.ar22_sequencial is null
    loop

      v_estaemrecibo := true;

-- Verifica se algum numpre do recibo jÃ¡ esta pago
-- caso positivo passa para o proximo e deixa inconsistente
      perform recibo.k00_numpre
         from recibo
              inner join arrepaga  on arrepaga.k00_numpre = recibo.k00_numpre
                                  and arrepaga.k00_numpar = recibo.k00_numpar
        where recibo.k00_numpre = r_idret.numpre;

      if found then
        if lRaise is true then
          perform fc_debug('  <BaixaBanco>  - recibo ja esta pago... gravaidret: '||gravaidret,lRaise,false,false);
        end if;
        continue;
      end if;

      -- Acerta vlrcalc
      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - entrou no update vlrcalc (1)...',lRaise,false,false);
      end if;

      -- Acerta vlrcalc
      update disbanco
         set vlrcalc = round((select (substr(fc_calcula,15,13)::float8+
                                substr(fc_calcula,28,13)::float8+
                                substr(fc_calcula,41,13)::float8-
                                substr(fc_calcula,54,13)::float8) as utotal
                          from (select fc_calcula(k00_numpre,k00_numpar,0,dtpago,dtpago,extract(year from dtpago)::integer)
                                  from disbanco
                                 where idret = r_codret.idret
                                   and codret = r_codret.codret
                                   and instit = iInstitSessao
                          ) as x
                       ),2)
       where idret  = r_codret.idret
         and codret = r_codret.codret
         and instit = r_idret.instit;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - saiu no update vlrcalc (1)...',lRaise,false,false);
      end if;

      gravaidret := r_codret.idret;
      retorno    := true;

      -- INSERE NO ARREPAGA OS PAGAMENTOS
      select round(sum(k00_valor),2)
        into valorrecibo
        from recibo
       where k00_numpre = r_idret.numpre;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - xxx - numpre: '||r_idret.numpre||' - valorrecibo: '||valorrecibo||' - vlrpago: '||r_idret.vlrpago,lRaise,false,false);
      end if;

      if valorrecibo = 0 then
        valorrecibo := r_idret.vlrpago;
      end if;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - recibo... vlrpago: '||r_idret.vlrpago||' - valor recibo: '||valorrecibo,lRaise,false,false);
      end if;

     /**
      * Alterado para agrupar por receita quando for recibo avulso para não gerar registros duplicados
      * na arrepaga (k00_numpre k00_numpar k00_receit k00_hist)
      */
      insert into arrepaga (
        k00_numcgm,
        k00_dtoper,
        k00_receit,
        k00_hist,
        k00_valor,
        k00_dtvenc,
        k00_numpre,
        k00_numpar,
        k00_numtot,
        k00_numdig,
        k00_conta,
        k00_dtpaga
      ) select recibo.k00_numcgm,
               min(datausu),
                recibo.k00_receit,
                recibo.k00_hist,
               sum(round((recibo.k00_valor / valorrecibo) * r_idret.vlrpago, 2)),
               min(datausu),
                recibo.k00_numpre,
                recibo.k00_numpar,
               min(recibo.k00_numtot),
               min(recibo.k00_numdig),
               min(conta),
               min(datausu)
           from recibo
                inner join arreinstit on arreinstit.k00_numpre = recibo.k00_numpre
                                     and arreinstit.k00_instit = iInstitSessao
         where recibo.k00_numpre = r_idret.numpre
      group by recibo.k00_numcgm,
               recibo.k00_numpre,
               recibo.k00_numpar,
               recibo.k00_receit,
               recibo.k00_hist;

      -- Verifica se o Total Pago é diferente do que foi Classificado (inserido na Arrepaga)
      v_diferenca := round(r_idret.vlrpago - (select round(sum(k00_valor),2) from arrepaga where k00_numpre = r_idret.numpre), 2);
      if v_diferenca > 0 then

        -- Altera maior receita com a diferenca encontrada
        if lRaise is true then
          perform fc_debug('  <BaixaBanco>  - recibo com diferenca de '||v_diferenca||' no classificado do idret '||r_idret.idret||' (numpre '||r_idret.numpre||' numpar '||r_idret.numpar||')',lRaise,false,false);
        end if;

        update arrepaga
           set k00_valor = k00_valor + v_diferenca
         where k00_numpre = r_idret.numpre
           and k00_receit = (select max(k00_receit) from arrepaga where k00_numpre = r_idret.numpre);
      end if;

      v_diferenca := 0; -- Seta valor anterior para garantir

     -- ALTERA SITUACAO DO ARREPAGA
      for q_disrec in

          select arrepaga.k00_numpre,
                 arrepaga.k00_numpar,
                 arrepaga.k00_receit,
                 sum(round(arrepaga.k00_valor, 2))
            from arrepaga
                 inner join disbanco on disbanco.k00_numpre = arrepaga.k00_numpre
           where arrepaga.k00_numpre = r_idret.numpre
             and disbanco.idret      = r_codret.idret
             and disbanco.instit     = iInstitSessao
        group by arrepaga.k00_numpre,
                 arrepaga.k00_numpar,
                 arrepaga.k00_receit
      loop
        -- INSERE NO ARRECANT
        -- DELETE DO ARRECAD
        -- TESTA SE EXISTE NUMPRE E NUMPAR NO ARREIDRET, NAO EXISTINDO INSERE O IDRET DO PAGAMENTO
        select arreidret.k00_numpre
          into _testeidret
          from arreidret
         where arreidret.k00_numpre = q_disrec.k00_numpre
           and arreidret.k00_numpar = q_disrec.k00_numpar
           and arreidret.idret      = r_idret.idret
           and arreidret.k00_instit = iInstitSessao;

        if _testeidret is null then
          insert into arreidret (
            k00_numpre,
            k00_numpar,
            idret,
            k00_instit
          ) values (
            q_disrec.k00_numpre,
            q_disrec.k00_numpar,
            r_idret.idret,
            r_idret.instit
          );
        end if;

        if q_disrec.sum != 0 then
          if autentsn is false then
-- GRAVA DISREC DAS RECEITAS PARA A CLASSIFICACAO
            lVerificaReceita := fc_verificareceita(q_disrec.k00_receit);
            if lVerificaReceita is false then
              return '25 - Receita: '||q_disrec.k00_receit||' não encontrada verifique o cadastro (2).';
            end if;

            perform *
               from disrec
              where disrec.codcla     = vcodcla
                and disrec.k00_receit = q_disrec.k00_receit
                and disrec.idret      = r_idret.idret
                and disrec.instit     = r_idret.instit;
            if not found then
              if lRaise is true then
                perform fc_debug('  <BaixaBanco>  - into disrec 2 - valor: '||q_disrec.sum||' - receita: '||q_disrec.k00_receit,lRaise,false,false);
              end if;


              if round(q_disrec.sum,2) > 0 then

                insert into disrec (
                  codcla,
                  k00_receit,
                  vlrrec,
                  idret,
                  instit
                ) values (
                  vcodcla,
                  q_disrec.k00_receit,
                  round(q_disrec.sum,2),
                  r_idret.idret,
                  r_idret.instit
                );

             end if;

            else
              if lRaise is true then
                perform fc_debug('  <BaixaBanco>  -    update disrec 2 - receita: '||q_disrec.k00_receit,lRaise,false,false);
              end if;
              update disrec set vlrrec = vlrrec + round(v_valor,2)
              where disrec.codcla = vcodcla and disrec.k00_receit = q_disrec.k00_receit and disrec.idret = r_idret.idret and disrec.instit = r_idret.instit;
            end if;
            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  - into disrec 3',lRaise,false,false);
            end if;
          end if;
        end if;

      end loop;

    end loop;

    if v_estaemrecibo is false then
      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - nao esta em recibo...',lRaise,false,false);
      end if;
    else
      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - esta em recibo...',lRaise,false,false);
      end if;
    end if;

    ----
    ---- PROCURANDO ARRECAD
    ----

    if lRaise is true then
      perform fc_debug('  <BaixaBanco>  - verificando arrecad...',lRaise,false,false);
      -- TESTE 3 - ARRECAD
    end if;

    for r_idret in
      select distinct
             1 as tipo,
             disbanco.k00_numpre as numpre,
             disbanco.k00_numpar as numpar,
             disbanco.idret,
             disbanco.k15_codbco,
             disbanco.k15_codage,
             disbanco.k00_numbco,
             disbanco.vlrpago,
             disbanco.vlracres,
             disbanco.vlrdesco,
             disbanco.vlrjuros,
             disbanco.vlrmulta,
             disbanco.instit
        from disbanco
             inner join arrecad      on arrecad.k00_numpre = disbanco.k00_numpre
                                    and arrecad.k00_numpar = disbanco.k00_numpar
             inner join arreinstit   on arreinstit.k00_numpre = arrecad.k00_numpre
                                    and arreinstit.k00_instit = iInstitSessao
             left join arrepaga      on arrepaga.k00_numpre = arrecad.k00_numpre
                                    and arrepaga.k00_numpar = arrecad.k00_numpar
                                    and arrepaga.k00_receit = arrecad.k00_receit
             left join numprebloqpag on numprebloqpag.ar22_numpre = arrecad.k00_numpre
                                    and numprebloqpag.ar22_numpar = arrecad.k00_numpar
       where disbanco.idret  = r_codret.idret
         and disbanco.classi is false
         and disbanco.instit = iInstitSessao
         and arrepaga.k00_numpre is null
         and numprebloqpag.ar22_sequencial is null
      union
      select distinct
             2 as tipo,
             disbanco.k00_numpre as numpre,
             disbanco.k00_numpar as numpar,
             disbanco.idret,
             disbanco.k15_codbco,
             disbanco.k15_codage,
             disbanco.k00_numbco,
             disbanco.vlrpago,
             disbanco.vlracres,
             disbanco.vlrdesco,
             disbanco.vlrjuros,
             disbanco.vlrmulta,
             disbanco.instit
        from disbanco
             inner join arrecad      on arrecad.k00_numpre = disbanco.k00_numpre
                                    and disbanco.k00_numpar = 0
             inner join arreinstit   on arreinstit.k00_numpre = arrecad.k00_numpre
                                    and arreinstit.k00_instit = iInstitSessao
             left join arrepaga      on arrepaga.k00_numpre = arrecad.k00_numpre
                                    and arrepaga.k00_numpar = arrecad.k00_numpar
                                    and arrepaga.k00_receit = arrecad.k00_receit
             left join numprebloqpag on numprebloqpag.ar22_numpre = arrecad.k00_numpre
                                    and numprebloqpag.ar22_numpar = arrecad.k00_numpar
       where disbanco.idret = r_codret.idret
         and disbanco.classi is false
         and disbanco.instit = iInstitSessao
         and arrepaga.k00_numpre is null
         and numprebloqpag.ar22_sequencial is null
    loop

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - ###### - tipo: '||r_idret.tipo,lRaise,false,false);
      end if;

      retorno := true;

      if r_idret.numpar = 0 then
        v_estaemarrecadunica  := true;
      else
        v_estaemarrecadnormal := true;
      end if;

      -- INSERE NO DISBANCO O VALOR CORRETO DO PAGAMENTO
      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - codret : '||r_codret.codret||'-idret : '||r_codret.idret,lRaise,false,false);
      end if;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - arrecad - numpre: '||r_idret.numpre||' - numpar: '||r_idret.numpar||' - tot: '||x_totreg||' - pago: '||r_idret.vlrpago,lRaise,false,false);
      end if;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - entrou no update vlrcalc...',lRaise,false,false);
      end if;

        -- Acerta vlrcalc
        update disbanco
           set vlrcalc = round((select (substr(fc_calcula,15,13)::float8+
                                  substr(fc_calcula,28,13)::float8+
                                  substr(fc_calcula,41,13)::float8-
                                  substr(fc_calcula,54,13)::float8) as utotal
                            from (select fc_calcula(k00_numpre,k00_numpar,0,dtpago,dtpago,extract(year from dtpago)::integer)
                                    from disbanco
                                   where idret = r_codret.idret
                                     and codret = r_codret.codret
                                     and instit = iInstitSessao
                            ) as x
                         ),2)
         where idret  = r_codret.idret
           and codret = r_codret.codret
           and instit = r_idret.instit;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - saiu no update vlrcalc...',lRaise,false,false);
      end if;

      if not r_idret.numpre is null then

        if r_idret.numpar != 0 then

          -- TESTE 3.1 - ARRECAD COM PARCELA PREENCHIDA

          valortotal := r_idret.vlrpago+r_idret.vlracres-r_idret.vlrdesco;
          valorjuros := r_idret.vlrjuros;
          valormulta := r_idret.vlrmulta;

          if lRaise is true then
            perform fc_debug('  <BaixaBanco>  - valortotal: '||valortotal,lRaise,false,false);
          end if;

          select round(sum(arrecad.k00_valor),2) as k00_vlrtot
            into nVlrTfr
            from arrecad
                 inner join arreinstit on arreinstit.k00_numpre = arrecad.k00_numpre
           where arrecad.k00_numpre    = r_idret.numpre
             and arrecad.k00_numpar    = r_idret.numpar
             and arreinstit.k00_instit = r_idret.instit;

          primeirarec := 0;
          valorlanc   := 0;
          valorlancj  := 0;
          valorlancm  := 0;
          for r_receitas in
              select k00_numcgm,
                     k00_numtot,
                     k00_numdig,
                     k00_receit,
                     round(sum(k00_valor),2)::float8 as k00_valor,
                     k02_recjur,
                     k02_recmul
                from arrecad
                     inner join arreinstit on arreinstit.k00_numpre = arrecad.k00_numpre
                     inner join tabrec     on tabrec.k02_codigo     = arrecad.k00_receit
                     inner join tabrecjm   on tabrec.k02_codjm      = tabrecjm.k02_codjm
               where arrecad.k00_numpre    = r_idret.numpre
                 and arrecad.k00_numpar    = r_idret.numpar
                 and arreinstit.k00_instit = r_idret.instit
            group by k00_numcgm,
                     k00_numtot,
                     k00_numdig,
                     k00_receit,
                     k02_recjur,
                     k02_recmul
          loop

            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  - inicio do for...',lRaise,false,false);
              perform fc_debug('  <BaixaBanco>  - ==========',lRaise,false,false);
            end if;

            if r_receitas.k00_valor = 0 then
              fracao := 1::float8;
            else
              fracao := round((r_receitas.k00_valor*100)::float8/nVlrTfr,8)::float8/100::float8;
            end if;

            nVlrRec := to_char(round(valortotal * fracao,2),'9999999999999.99')::float8;

            -- juros
            nVlrRecj := to_char(round(valorjuros * fracao,2),'9999999999999.99')::float8;

            -- multa
            nVlrRecm := to_char(round(valormulta * fracao,2),'9999999999999.99')::float8;

            if lRaise then
              perform fc_debug('  <BaixaBanco>  - JUROS : '||nVlrRecj||' RECEITA : '||r_receitas.k02_recjur,lRaise,false,false);
              perform fc_debug('  <BaixaBanco>  - MULTA : '||nVlrRecm||' RECEITA : '||r_receitas.k02_recmul,lRaise,false,false);
              perform fc_debug('  <BaixaBanco>  - VALOR : '||nVlrRec ||' RECEITA : '||r_receitas.k00_receit,lRaise,false,false);
            end if;

            if r_receitas.k02_recjur = r_receitas.k02_recmul then
              nVlrRecj := nVlrRecj + nVlrRecm;
              nVlrRecm := 0;
            end if;

            if r_receitas.k02_recjur is null then
              nVlrRec  := nVlrRecm + nVlrRecj;
              nVlrRecj := 0;
              nVlrRecm := 0;
            end if;

            gravaidret := r_codret.idret;

            --
            -- Inserindo o valor da receita
            --
            if nVlrRec != 0 then
              if primeirarec = 0 then
                primeirarec := r_receitas.k00_receit;
              end if;
              valorlanc := round(valorlanc + nVlrRec,2)::float8;
              if lRaise is true then
                perform fc_debug('  <BaixaBanco>  - valorlanc: '||valorlanc,lRaise,false,false);
              end if;

              insert into arrepaga  (
                k00_numcgm,
                k00_dtoper,
                k00_receit,
                k00_hist  ,
                k00_valor ,
                k00_dtvenc,
                k00_numpre,
                k00_numpar,
                k00_numtot,
                k00_numdig,
                k00_conta ,
                k00_dtpaga
              ) values (
                r_receitas.k00_numcgm,
                datausu,
                r_receitas.k00_receit  ,
                991,
                nVlrRec,
                datausu ,
                r_idret.numpre,
                r_idret.numpar ,
                r_receitas.k00_numtot ,
                r_receitas.k00_numdig ,
                conta,
                datausu
              );
            end if;

            --
            -- Inserindo o valor do juros
            --
            if round(nVlrRecj,2)::float8 != 0 then
              if primeirarecj = 0 then
                primeirarecj := r_receitas.k02_recjur;
              end if;
              valorlancj := round(valorlancj + nVlrRecj,2)::float8;

              if lRaise is true then
                perform fc_debug('  <BaixaBanco>  - Valor do juros '||nVlrRecj,lRaise,false,false);
                perform fc_debug('  <BaixaBanco>  - valorlancj: '||valorlancj,lRaise,false,false);
              end if;

              insert into arrepaga (
                k00_numcgm,
                k00_dtoper,
                k00_receit,
                k00_hist  ,
                k00_valor ,
                k00_dtvenc,
                k00_numpre,
                k00_numpar,
                k00_numtot,
                k00_numdig,
                k00_conta ,
                k00_dtpaga
              ) values (
                r_receitas.k00_numcgm,
                datausu,
                r_receitas.k02_recjur ,
                991,
                round(nVlrRecj,2)::float8,
                datausu,
                r_idret.numpre,
                r_idret.numpar ,
                r_receitas.k00_numtot ,
                r_receitas.k00_numdig  ,
                conta,
                datausu
              );
            end if;

            --
            -- Inserindo o valor da multa
            --
            if round(nVlrRecm,2)::float8 != 0 then

              if lRaise then
                perform fc_debug('  <BaixaBanco>  - Valor da multa : '||round(nVlrRecm,2),lRaise,false,false);
              end if;

              if primeirarecm = 0 then
                primeirarecm := r_receitas.k02_recmul;
              end if;
              valorlancm := round(valorlancm + nVlrRecm,2)::float8;

              insert into arrepaga (
                k00_numcgm,
                k00_dtoper,
                k00_receit,
                k00_hist  ,
                k00_valor ,
                k00_dtvenc,
                k00_numpre,
                k00_numpar,
                k00_numtot,
                k00_numdig,
                k00_conta ,
                k00_dtpaga
              ) values (
                r_receitas.k00_numcgm,
                datausu,
                r_receitas.k02_recmul ,
                991 ,
                round(nVlrRecm,2)::float8,
                datausu  ,
                r_idret.numpre,
                r_idret.numpar ,
                r_receitas.k00_numtot ,
                r_receitas.k00_numdig  ,
                conta,
                datausu
              );
            else
              if lRaise then
                perform fc_debug('  <BaixaBanco>  - nao processou multa - valor da multa : '||round(nVlrRecm,2),lRaise,false,false);
              end if;
            end if;

            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  - final do for...',lRaise,false,false);
              perform fc_debug('  <BaixaBanco>  - ==========',lRaise,false,false);
            end if;

          end loop;

          if lRaise is true then
            perform fc_debug('  <BaixaBanco>  - ==========',lRaise,false,false);
            perform fc_debug('  <BaixaBanco>  - fora do for...',lRaise,false,false);
            perform fc_debug('  <BaixaBanco>  - ==========',lRaise,false,false);
          end if;

          valorlanc := round(valortotal - (valorlanc),2)::float8;

          if valorlanc != 0 then
            select oid
              into oidrec
              from arrepaga
             where k00_numpre = r_idret.numpre
               and k00_numpar = r_idret.numpar
               and k00_receit = primeirarec;

            update arrepaga
               set k00_valor = round(k00_valor + valorlanc,2)::float8
             where oid = oidrec ;
          end if;

          valorlancj := round(valorjuros - (valorlancj),2)::float8;
          if valorlancj != 0 then

            if lRaise then
              perform fc_debug('  <BaixaBanco>  - Somando juros na receira principal : '||valorlancj,lRaise,false,false);
            end if;

            select oid
              into oidrec
              from arrepaga
             where k00_numpre = r_idret.numpre
               and k00_numpar = r_idret.numpar
               and k00_receit = primeirarecj;

            -- comentei para teste

            update arrepaga
               set k00_valor = round(k00_valor + valorlancj,2)::float8
             where oid = oidrec;

          end if;

          valorlancm := round(valormulta - (valorlancm),2)::float8;
          if valorlancm != 0 then
            select oid
              into oidrec
              from arrepaga
             where k00_numpre = r_idret.numpre
               and k00_numpar = r_idret.numpar
               and k00_receit = primeirarecm;

            update arrepaga
               set k00_valor = round(k00_valor + valorlancm,2)::float8
             where oid = oidrec;

          end if;

          for q_disrec in
              select k00_receit,
                     round(sum(k00_valor),2) as sum
                from arrepaga
               where k00_numpre = r_idret.numpre
                 and k00_numpar = r_idret.numpar
                 and k00_dtoper = datausu
            group by k00_receit
          loop
            if q_disrec.sum != 0 then
              if autentsn is false then

                lVerificaReceita := fc_verificareceita(q_disrec.k00_receit);
                if lVerificaReceita is false then
                  return '26 - Receita: '||q_disrec.k00_receit||' nao encontrada verifique o cadastro (3).';
                end if;

                perform *
                   from disrec
                  where disrec.codcla = vcodcla
                    and disrec.k00_receit = q_disrec.k00_receit
                    and disrec.idret      = r_idret.idret
                    and disrec.instit     = r_idret.instit;
                if not found then
                  if lRaise is true then
                    perform fc_debug('  <BaixaBanco>  - into disrec 4 - valor: '||q_disrec.sum||' - receita: '||q_disrec.k00_receit,lRaise,false,false);
                  end if;

                  if round(q_disrec.sum,2) > 0 then

                    insert into disrec (
                      codcla,
                      k00_receit,
                      vlrrec,
                      idret,
                      instit
                    ) values (
                      vcodcla,
                      q_disrec.k00_receit,
                      round(q_disrec.sum,2),
                      r_idret.idret,
                      r_idret.instit
                    );

                  end if;

                else

                  if lRaise is true then
                    perform fc_debug('  <BaixaBanco>  -    update disrec 4 - receita: '||q_disrec.k00_receit,lRaise,false,false);
                  end if;

                  update disrec
                     set vlrrec = vlrrec + round(v_valor,2)
                   where disrec.codcla     = vcodcla
                     and disrec.k00_receit = q_disrec.k00_receit
                     and disrec.idret      = r_idret.idret
                     and disrec.instit     = r_idret.instit;

                end if;
                if lRaise is true then
                  perform fc_debug('  <BaixaBanco>  - into disrec 5',lRaise,false,false);
                end if;
              end if;
            end if;
          end loop;

          insert into arrecant (
            k00_numcgm,
            k00_dtoper,
            k00_receit,
            k00_hist  ,
            k00_valor ,
            k00_dtvenc,
            k00_numpre,
            k00_numpar,
            k00_numtot,
            k00_numdig,
            k00_tipo  ,
            k00_tipojm
          ) select arrecad.k00_numcgm,
                   arrecad.k00_dtoper,
                   arrecad.k00_receit,
                   arrecad.k00_hist  ,
                   arrecad.k00_valor ,
                   arrecad.k00_dtvenc,
                   arrecad.k00_numpre,
                   arrecad.k00_numpar,
                   arrecad.k00_numtot,
                   arrecad.k00_numdig,
                   arrecad.k00_tipo  ,
                   arrecad.k00_tipojm
              from arrecad
                   inner join arreinstit on arreinstit.k00_numpre = arrecad.k00_numpre
             where arrecad.k00_numpre = r_idret.numpre
               and arrecad.k00_numpar = r_idret.numpar
               and arreinstit.k00_instit = r_idret.instit;

          delete
            from arrecad
           using arreinstit
           where arrecad.k00_numpre    = arreinstit.k00_numpre
             and arrecad.k00_numpre    = r_idret.numpre
             and arrecad.k00_numpar    = r_idret.numpar
             and arreinstit.k00_instit = r_idret.instit;

-- TESTA SE EXISTE NUMPRE E NUMPAR NO ARREIDRET, NAO EXISTINDO INSERE O IDRET DO PAGAMENTO
          select arreidret.k00_numpre
            into _testeidret
            from arreidret
           where arreidret.k00_numpre = r_idret.numpre
             and arreidret.k00_numpar = r_idret.numpar
             and arreidret.idret      = r_idret.idret
             and arreidret.k00_instit = r_idret.instit;

          if _testeidret is null then
            insert into arreidret (
              k00_numpre,
              k00_numpar,
              idret,
              k00_instit
            ) values (
              r_idret.numpre,
              r_idret.numpar,
              r_idret.idret,
              r_idret.instit
            );
          end if;

        else
          -- PARCELA UNICA
          -- TESTE 3.2 - ARRECAD COM PARCELA UNICA

          valortotal := r_idret.vlrpago+r_idret.vlracres-r_idret.vlrdesco;
          valorjuros := r_idret.vlrjuros;
          valormulta := r_idret.vlrmulta;

          if lRaise is true then
            perform fc_debug('  <BaixaBanco>  -  unica - vlrtot '||valortotal||' - numpre: '||r_idret.numpre,lRaise,false,false);
          end if;

          select round(sum(arrecad.k00_valor),2) as k00_vlrtot
            into nVlrTfr
            from arrecad
                 inner join arreinstit on arreinstit.k00_numpre = arrecad.k00_numpre
           where arrecad.k00_numpre    = r_idret.numpre
             and arreinstit.k00_instit = r_idret.instit;

          primeirarec := 0;
          valorlanc   := 0;
          valorlancj  := 0;
          valorlancm  := 0;

          for r_idunica in
            select distinct
                   arrecad.k00_numpre as numpre,
                   arrecad.k00_numpar as numpar
              from arrecad
                   inner join arreinstit on arreinstit.k00_numpre = arrecad.k00_numpre
             where arrecad.k00_numpre    = r_idret.numpre
               and arreinstit.k00_instit = r_idret.instit
          loop

            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  - dentro do for do arrecad - parcela: '||r_idunica.numpar,lRaise,false,false);
            end if;

            for r_receitas in
                select k00_numcgm,
                       k00_numtot,
                       k00_numdig,
                       k00_receit,
                       k00_tipo,
                       round(sum(k00_valor),2)::float8 as k00_valor,
                       k02_recjur,
                       k02_recmul
                  from arrecad
                       inner join arreinstit on arreinstit.k00_numpre = arrecad.k00_numpre
                       inner join tabrec     on tabrec.k02_codigo     = arrecad.k00_receit
                       inner join tabrecjm   on tabrec.k02_codjm      = tabrecjm.k02_codjm
                 where arrecad.k00_numpre    = r_idunica.numpre
                   and arrecad.k00_numpar    = r_idunica.numpar
                   and arreinstit.k00_instit = r_idret.instit
              group by k00_numcgm,
                       k00_numtot,
                       k00_numdig,
                       k00_receit,
                       k00_tipo,
                       k02_recjur,
                       k02_recmul
            loop

              --
              -- ModificaÃ§ao realizada devido ao erro gerado na tarefa 32607
              -- Motivo do erro:
              -- Foi pego o valor de 72.83 para um numpre de ISSQN Var, quando o arquivo do banco retornou, o  estava com valor zero no arrecad
              -- O que ocasionava erro nas linhas abaixo pois a variavel nVlrTfr que e resultado do somatorio do valor do  na tabela arrecad e
              -- utilizado para a divisao do valor da receita abaixo, estava igual a zero.
              --
              if r_receitas.k00_tipo = 3 and nVlrTfr = 0 then
                fracao := 100;
              else
                fracao := round((r_receitas.k00_valor*100)::float8/nVlrTfr,8)::float8/100::float8;
              end if;
              --
              -- fim da modificacao
              --


              nVlrRec := round(to_char(round(valortotal * fracao,2),'9999999999999.99')::float8,2)::float8;

              if lRaise is true then
                perform fc_debug('  <BaixaBanco>  -  rec '||r_receitas.k00_receit||' nVlrRec '||nVlrRec,lRaise,false,false);
              end if;

              -- juros
              nVlrRecj := round(to_char(round(valorjuros * fracao,2),'9999999999999.99')::float8,2)::float8;

              -- multa
              nVlrRecm := round(to_char(round(valormulta * fracao,2),'9999999999999.99')::float8,2)::float8;

              if r_receitas.k02_recjur = r_receitas.k02_recmul then
                nVlrRecj := nVlrRecj + nVlrRecm;
                nVlrRecm := 0;
              end if;

              if r_receitas.k02_recjur is null then
                nVlrRec  := nVlrRecm + nVlrRecj;
                nVlrRecj := 0;
                nVlrRecm := 0;
              end if;

              gravaidret := r_codret.idret;

              if lRaise is true then
                perform fc_debug('  <BaixaBanco>  - nVlrRec: '||nVlrRec,lRaise,false,false);
              end if;

              if nVlrRec != 0 then
                if primeirarec = 0 then
                  primeirarec := r_receitas.k00_receit;
                end if;
                primeiranumpre := r_idunica.numpre;
                primeiranumpar := r_idunica.numpar;
                valorlanc      := round(valorlanc + nVlrRec,2)::float8;

                insert into arrepaga (
                  k00_numcgm,
                  k00_dtoper,
                  k00_receit,
                  k00_hist,
                  k00_valor,
                  k00_dtvenc,
                  k00_numpre,
                  k00_numpar,
                  k00_numtot,
                  k00_numdig,
                  k00_conta,
                  k00_dtpaga
                ) values (
                  r_receitas.k00_numcgm,
                  datausu,
                  r_receitas.k00_receit  ,
                  990 ,
                  round(nVlrRec,2)::float8,
                  datausu  ,
                  r_idunica.numpre,
                  r_idunica.numpar ,
                  r_receitas.k00_numtot,
                  r_receitas.k00_numdig  ,
                  conta,
                  datausu
                );
              end if;

              if round(nVlrRecj,2)::float8 != 0 then
                if primeirarecj = 0 then
                  primeirarecj := r_receitas.k02_recjur;
                end if;
                primeiranumpre := r_idunica.numpre;
                primeiranumpar := r_idunica.numpar;
                valorlancj     := round(valorlancj + nVlrRecj,2)::float8;
                if lRaise is true then
                  perform fc_debug('  <BaixaBanco>  - juros '||nVlrRecj,lRaise,false,false);
                end if;

                insert into arrepaga (
                  k00_numcgm,
                  k00_dtoper,
                  k00_receit,
                  k00_hist  ,
                  k00_valor ,
                  k00_dtvenc,
                  k00_numpre,
                  k00_numpar,
                  k00_numtot,
                  k00_numdig,
                  k00_conta ,
                  k00_dtpaga
                ) values (
                  r_receitas.k00_numcgm,
                  datausu,
                  r_receitas.k02_recjur ,
                  990,
                  round(nVlrRecj,2)::float8,
                  datausu,
                  r_idunica.numpre,
                  r_idunica.numpar ,
                  r_receitas.k00_numtot ,
                  r_receitas.k00_numdig  ,
                  conta,
                  datausu
                );
              end if;

              if round(nVlrRecm,2)::float8 != 0 then
                if primeirarecm = 0 then
                  primeirarecm := r_receitas.k02_recmul;
                end if;
                primeiranumpre := r_idunica.numpre;
                primeiranumpar := r_idunica.numpar;
                valorlancm     := round(valorlancm + nVlrRecm,2)::float8;

                insert into arrepaga (
                  k00_numcgm,
                  k00_dtoper,
                  k00_receit,
                  k00_hist  ,
                  k00_valor ,
                  k00_dtvenc,
                  k00_numpre,
                  k00_numpar,
                  k00_numtot,
                  k00_numdig,
                  k00_conta ,
                  k00_dtpaga
                ) values (
                  r_receitas.k00_numcgm,
                  datausu,
                  r_receitas.k02_recmul ,
                  990 ,
                  round(nVlrRecm,2)::float8,
                  datausu ,
                  r_idunica.numpre,
                  r_idunica.numpar ,
                  r_receitas.k00_numtot ,
                  r_receitas.k00_numdig  ,
                  conta,
                  datausu
                );
              end if;

            end loop;

            insert into arrecant (
              k00_numcgm,
              k00_dtoper,
              k00_receit,
              k00_hist  ,
              k00_valor ,
              k00_dtvenc,
              k00_numpre,
              k00_numpar,
              k00_numtot,
              k00_numdig,
              k00_tipo  ,
              k00_tipojm
            ) select arrecad.k00_numcgm,
                     arrecad.k00_dtoper,
                     arrecad.k00_receit,
                     arrecad.k00_hist  ,
                     arrecad.k00_valor ,
                     arrecad.k00_dtvenc,
                     arrecad.k00_numpre,
                     arrecad.k00_numpar,
                     arrecad.k00_numtot,
                     arrecad.k00_numdig,
                     arrecad.k00_tipo  ,
                     arrecad.k00_tipojm
                from arrecad
                     inner join arreinstit on arreinstit.k00_numpre = arrecad.k00_numpre
               where arrecad.k00_numpre    = r_idunica.numpre
                 and arrecad.k00_numpar    = r_idunica.numpar
                 and arreinstit.k00_instit = r_idret.instit;

            delete
              from arrecad
             using arreinstit
             where arrecad.k00_numpre    = arreinstit.k00_numpre
               and arrecad.k00_numpre    = r_idunica.numpre
               and arrecad.k00_numpar    = r_idunica.numpar
               and arreinstit.k00_instit = r_idret.instit;
-- TESTA SE EXISTE NUMPRE E NUMPAR NO ARREIDRET, NAO EXISTINDO INSERE O IDRET DO PAGAMENTO
            select arreidret.k00_numpre
              into _testeidret
              from arreidret
             where arreidret.k00_numpre = r_idunica.numpre
               and arreidret.k00_numpar = r_idunica.numpar
               and arreidret.idret      = r_idret.idret
               and arreidret.k00_instit = r_idret.instit;

            if _testeidret is null then
              insert into arreidret (
                k00_numpre,
                k00_numpar,
                idret,
                k00_instit
              ) values (
                r_idunica.numpre,
                r_idunica.numpar,
                r_idret.idret,
                r_idret.instit
              );
            end if;

          end loop;

          valorlanc  := round(valortotal - (valorlanc),2)::float8;
          valorlancj := round(valorjuros - (valorlancj),2)::float8;
          valorlancm := round(valormulta - (valorlancm),2)::float8;

          IF VALORLANC != 0  THEN

            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  -  acerta 1 -- '||valorlanc,lRaise,false,false);
            end if;

            select oid
              into oidrec
              from arrepaga
             where k00_numpre = primeiranumpre
               and k00_numpar = primeiranumpar
               and k00_receit = primeirarec;

            update arrepaga
               set k00_valor = round(k00_valor + valorlanc,2)::float8
             where oid = oidrec ;
          end if;

          if valorlancj != 0 then

            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  -  acerta 2 -- '||valorlancj,lRaise,false,false);
            end if;

            select oid
              into oidrec
              from arrepaga
             where k00_numpre = primeiranumpre
               and k00_numpar = primeiranumpar
               and k00_receit = primeirarecj;

            update arrepaga
               set k00_valor = round(k00_valor + valorlancj,2)::float8
             where oid = oidrec;

          end if;

          if valorlancm != 0 then

            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  -  acerta 3  -- '||valorlancm,lRaise,false,false);
            end if;

            select oid
              into oidrec
              from arrepaga
             where k00_numpre = primeiranumpre
               and k00_numpar = primeiranumpar
               and k00_receit = primeirarecm;

            update arrepaga
               set k00_valor = round(k00_valor + valorlancm,2)::float8
             where oid = oidrec;

          end if;

          if lRaise is true then
            perform fc_debug('  <BaixaBanco>  - antes for disrec - datausu: '||datausu,lRaise,false,false);
          end if;

          for q_disrec in
              select k00_receit,
                     round(sum(k00_valor),2) as sum
                from arrepaga
               where k00_numpre = r_idret.numpre
--                and k00_numpar = r_idret.numpar
                 and k00_dtoper = datausu
            group by k00_receit
          loop
            if q_disrec.sum != 0 then
              if autentsn is false then
                if lRaise is true then
                  perform fc_debug('  <BaixaBanco>  - into disrec 6',lRaise,false,false);
                end if;

                lVerificaReceita := fc_verificareceita(q_disrec.k00_receit);
                if lVerificaReceita is false then
                  return '27 - Receita: '||q_disrec.k00_receit||' nao encontrada verifique o cadastro (4).';
                end if;

                perform * from disrec where disrec.codcla = vcodcla and disrec.k00_receit = q_disrec.k00_receit and disrec.idret = r_idret.idret and disrec.instit = r_idret.instit;
                if not found then
                  if lRaise is true then
                    perform fc_debug('  <BaixaBanco>  -    inserindo disrec 6 - valor: '||q_disrec.sum||' - receita: '||q_disrec.k00_receit,lRaise,false,false);
                  end if;

                  if round(q_disrec.sum,2) > 0 then

                    insert into disrec (
                      codcla,
                      k00_receit,
                      vlrrec,
                      idret,
                      instit
                    ) values (
                      vcodcla,
                      q_disrec.k00_receit,
                      round(q_disrec.sum,2),
                      r_idret.idret,
                      r_idret.instit
                    );

                  end if;

                else
                  if lRaise is true then
                    perform fc_debug('  <BaixaBanco>  -    update disrec 6 - receita: '||q_disrec.k00_receit,lRaise,false,false);
                  end if;
                  update disrec set vlrrec = vlrrec + round(v_valor,2)
                  where disrec.codcla = vcodcla and disrec.k00_receit = q_disrec.k00_receit and disrec.idret = r_idret.idret and disrec.instit = r_idret.instit;
                end if;
              end if;
            end if;
            if lRaise is true then
              perform fc_debug('  <BaixaBanco>  - durante for disrec',lRaise,false,false);
            end if;
          end loop;

          if lRaise is true then
            perform fc_debug('  <BaixaBanco>  - depois for disrec',lRaise,false,false);
          end if;

        end if;

      end if;

    end loop;

    if v_estaemarrecadnormal is false then
      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - nao esta em arrecad normal...',lRaise,false,false);
      end if;
    else
      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - esta em arrecad normal...',lRaise,false,false);
      end if;
    end if;

    if v_estaemarrecadunica is false then
      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - nao esta em arrecad unica...',lRaise,false,false);
      end if;
    else
      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - esta em arrecad unica...',lRaise,false,false);
      end if;
    end if;

-- pelo numpre do arrecad
    if gravaidret != 0 then
      if autentsn is false then
        insert into disclaret (
          codcla,
          codret
        ) values (
          vcodcla,
          r_codret.idret
        );
      end if;

      select ar22_sequencial
        into nBloqueado
        from numprebloqpag
             inner join disbanco on disbanco.k00_numpre = numprebloqpag.ar22_numpre
                                and disbanco.k00_numpar = numprebloqpag.ar22_numpar
        where disbanco.idret = r_codret.idret;

      if nBloqueado is not null and nBloqueado > 0 then
        lClassi = false;
      else
        lClassi = true;
      end if;

      if lRaise is true then
        if lClassi is true then
          perform fc_debug('  <BaixaBanco>  -  3 - Debito nao Bloqueado ',lRaise,false,false);
        else
          perform fc_debug('  <BaixaBanco>  -  4 - Debito Bloqueado '||r_codret.idret,lRaise,false,false);
        end if;
      end if;

      update disbanco
         set classi = lClassi
       where idret = r_codret.idret;
    else
      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - classi is false',lRaise,false,false);
      end if;
    end if;

    if lRaise is true then
      perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
      perform fc_debug('  <BaixaBanco>  - finalizando registro disbanco - idret '||R_CODRET.IDRET,lRaise,false,false);
      perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
    end if;

  end loop;

  if lRaise is true then
    perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
    perform fc_debug('  <BaixaBanco>  - fim PROCESSANDO REGISTROS...',lRaise,false,false);
    perform fc_debug('  <BaixaBanco>  -  ',lRaise,false,false);
  end if;

  select sum(round(tmpantesprocessar.vlrpago,2))
    into v_total1
    from tmpantesprocessar
         inner join disbanco on tmpantesprocessar.idret = disbanco.idret
   where disbanco.classi is true;

  if lRaise is true then
    perform fc_debug('  <BaixaBanco>  - ===============',lRaise,false,false);
    perform fc_debug('  <BaixaBanco>  - VCODCLA: '||VCODCLA,lRaise,false,false);
  end if;

  if autentsn is false then

    select sum(round(disrec.vlrrec,2))
      into v_total2
      from disrec
     where disrec.codcla = VCODCLA;

    if lRaise is true then
      perform fc_debug('  <BaixaBanco>  ',lRaise,false,false);
      perform fc_debug('  <BaixaBanco>  |1| v_total1 (soma disbanco.vlrpago): '||v_total1||' - v_total2 (soma disrec.vlrrec): '||v_total2,lRaise,false,false);
      perform fc_debug('  <BaixaBanco>  ',lRaise,false,false);
    end if;

    perform distinct
            disbanco.idret,
            disrec.idret
       from tmpantesprocessar
            inner join disbanco  on disbanco.idret = tmpantesprocessar.idret
                                and disbanco.classi is true
            left  join disrec    on disrec.idret = disbanco.idret
      where disrec.idret is null;

    if found and autentsn is false then
      return '28 - REGISTROS CLASSIFICADOS SEM DISREC';
    end if;

    v_diferenca = ( v_total1 - v_total2 );

    if cast(round(v_diferenca,2) as numeric) <> cast(round(0,2) as numeric) then

      if lRaise is true then
        perform fc_debug('============================',lRaise,false,false);
        perform fc_debug('<BaixaBanco> - Executar Acerto',lRaise,false,false);
        perform fc_debug('<BaixaBanco> - CodRet: '||cod_ret,lRaise,false,false);
        perform fc_debug('============================',lRaise,false,false);
      end if;

      for rAcertoDiferenca in  select idret,
                                      vlrpago as valor_disbanco,
                                      ( select sum(vlrrec)
                                          from disrec
                                         where disrec.idret = disbanco.idret) as valor_disrec
                                 from disbanco
                                where codret = cod_ret
                                  and cast(round(vlrpago,2) as numeric) <> cast(round((select sum(vlrrec)
                                                                                        from disrec
                                                                                       where disrec.idret = disbanco.idret),2) as numeric)
      loop

        nVlrDiferencaDisrec := ( rAcertoDiferenca.valor_disbanco - rAcertoDiferenca.valor_disrec );

        if lRaise is true then
          perform fc_debug('  <BaixaBanco> - Acerto de diferenca disrec | idret : '||rAcertoDiferenca.idret,lRaise,false,false);
          perform fc_debug('  <BaixaBanco> - valor disbanco : '||rAcertoDiferenca.valor_disbanco           ,lRaise,false,false);
          perform fc_debug('  <BaixaBanco> - valor disrec : '||rAcertoDiferenca.valor_disrec               ,lRaise,false,false);
        end if;

        update disrec
           set vlrrec = ( vlrrec + nVlrDiferencaDisrec )
         where idret  = rAcertoDiferenca.idret
           and codcla = VCODCLA
           and k00_receit = (select k00_receit
                               from disrec
                              where idret = rAcertoDiferenca.idret
                              order by vlrrec
                               desc limit 1);

      end loop;

      select sum(round(disrec.vlrrec,2))
        into v_total2
        from disrec
       where disrec.codcla
       in (select codigo_classificacao
               from tmp_classificaoesexecutadas);

       perform fc_debug('  <BaixaBanco> - v_total2 ( soma disrec ) : ' ||v_total2, lRaise, false, false);
    end if;

    if lRaise is true then
      perform fc_debug('  <BaixaBanco>  ',lRaise,false,false);
      perform fc_debug('  <BaixaBanco>  |2| v_total1 (soma disbanco.vlrpago): '||v_total1||' - v_total2 (soma disrec.vlrrec): '||v_total2,lRaise,false,false);
      perform fc_debug('  <BaixaBanco>  ',lRaise,false,false);
    end if;

    if v_total1 <> v_total2 then

      return '29 - INCONSISTENCIA NOS VALORES PROCESSADOS DIFERENCA TOTAL DE '||(v_total1-v_total2);

    end if;

  end if;

  if lRaise is true then
    perform fc_debug('  <BaixaBanco>  - FIM DO PROCESSAMENTO... ',lRaise,false,true);
  end if;

  if retorno = false then
    return '30 - NAO EXISTEM DEBITOS PENDENTES PARA ESTE ARQUIVO';
  else
    return '1 - PROCESSO CONCLUIDO COM SUCESSO ';
  end if;

end;

$$ language 'plpgsql';create or replace function fc_arreoldcalc_atu() returns trigger as
$$
declare

    bDelete     boolean default false;
    bUpdate     boolean default false;
    bInsert     boolean default false;

    sOperacao   text    := '';

    nVlrHis     float8 default 0;
    nVlrCor     float8 default 0;
    nVlrJur     float8 default 0;
    nVlrMul     float8 default 0;
    nVlrDes     float8 default 0;

    dDataCalc   date default current_date;

    iNumpre     integer;
    iNumpar     integer;
    iReceit     integer;


    sCalcula    text;

begin
    if fc_getsession('__status_tg_arreold_atu') = 'disable' then
        return new;
    end if;

    sOperacao := upper(TG_OP);


    if sOperacao = 'DELETE' then
        iNumpre = old.k00_numpre;
        iNumpar = old.k00_numpar;
        iReceit = old.k00_receit;
    else
        iNumpre = new.k00_numpre;
        iNumpar = new.k00_numpar;
        iReceit = new.k00_receit;
    end if;

    if (sOperacao = 'DELETE') then
        bDelete := true;
    else

    if fc_getsession('DB_datausu') <> '' then
      dDataCalc := fc_getsession('DB_datausu')::date;
    end if;


    perform k00_numpre,k00_numpar,k00_receit from arreoldcalc
        where arreoldcalc.k00_numpre = iNumpre
        and arreoldcalc.k00_numpar = iNumpar
        and arreoldcalc.k00_receit = iReceit;
    if found then
            bUpdate := true;
        else
            bInsert := true;
        end if;
    end if;

  if bDelete is true or bUpdate is true then

        delete from arreoldcalc
       where arreoldcalc.k00_numpre = iNumpre
       and arreoldcalc.k00_numpar = iNumpar
       and arreoldcalc.k00_receit = iReceit;

    end if;

  --raise notice 'bDelete - % bUpdate - % bInsert - %',bDelete,bUpdate,bInsert;

    if ( bInsert is true or bUpdate is true ) then

    --raise notice 'yyyyyyyy';
    --raise notice 'numpre : % numpar : % receita : % datacalc : % ano : % ',iNumpre, iNumpar, iReceit, dDataCalc, extract(year from dDataCalc)::integer;

    sCalcula := fc_calculaold(iNumpre, iNumpar, iReceit, dDataCalc, dDataCalc, extract(year from dDataCalc)::integer);

    --raise notice 'sCalcula: %', sCalcula;

    if substr(sCalcula,1,1) != '1' then
          return new;
        end if;

        --raise notice 'calcula : % ',sCalcula;
    --raise notice 'cor : % jur : % mul : % des : %',substr(sCalcula,15,13),substr(sCalcula,28,13),substr(sCalcula,41,13),substr(sCalcula,54,13);

      nVlrHis  := substr(sCalcula,02,13)::float8;
      nVlrCor  := substr(sCalcula,15,13)::float8;
      nVlrJur  := substr(sCalcula,28,13)::float8;
      nVlrMul  := substr(sCalcula,41,13)::float8;
      nVlrDes  := substr(sCalcula,54,13)::float8;

    --raise notice 'nVlrHis: % - nVlrCor: % - nVlrJur: % - nVlrMul: % - nVlrDes: %', nVlrHis, nVlrCor, nVlrJur, nVlrMul, nVlrDes;

        insert
          into arreoldcalc (
                   k00_arreoldcalc,
                         k00_numpre,
                         k00_numpar,
                         k00_receit,
                         k00_hist,
                         k00_dtcalc,
                         k00_vlrhis,
                         k00_vlrcor,
                         k00_vlrjur,
                         k00_vlrmul,
                         k00_vlrdes
               )
        values (nextval('arreoldcalc_k00_arreoldcalc_seq'),
                new.k00_numpre,
                        new.k00_numpar,
                        new.k00_receit,
                        new.k00_hist,
                        dDataCalc,
                        nVlrHis,
                        nVlrCor,
                        nVlrJur,
                        nVlrMul,
                        nVlrDes);

    end if;
  if (sOperacao = 'DELETE') then
    return old;
  end if;

  return new;

end;
$$
language 'plpgsql';-- quando reparcelar um parcelamento que e de 3 matriculas, tem que gerar 3 arrematric do novo numpre
-- revisar bem parcelamento de diversos e melhorias
-- considera-se que nao pode se parcelar inicial com outro tipo de debito, mesmo que seja outro parcelamento de inicial,
-- mas podemos parcelar mais de uma inicial no mesmo parcelamento, por isso que existe a tabela termoini

-- tipos de testes
-- parcelar um diversos
-- reparcelar um diversos
-- parcelar 2 diversos, um de cada procedencia
-- parcelar 1 diversos e um parcelamento de diversos

drop function if exists fc_parcelamento(integer,date,date,integer,integer,float8,integer,integer,integer,integer,float8,float8);

set check_function_bodies to on;
create or replace function fc_parcelamento(integer,date,date,integer,integer,float8,integer,integer,integer,integer,float8,float8,text,integer)
returns varchar(100)
as $$
declare

  v_cgmresp                        alias for $1;  -- cgm do responsavel pelo parcelamento
  v_privenc                        alias for $2;  -- vencimento da entrada
  v_segvenc                        alias for $3;  -- vencimento da parcela 2
  v_diaprox                        alias for $4;  -- dia de vencimento da parcela 3 em diante
  v_totparc                        alias for $5;  -- total de parcelas
  v_entrada                        alias for $6;  -- valor da entrada
  v_login                          alias for $7;  -- login de quem fez o parcelamento
  v_cadtipo                        alias for $8;  -- tipo de debito dos registros selecionados
  v_desconto                       alias for $9;  -- regra de parcelamento utilizada
  v_temdesconto                    alias for $10; -- se tem desconto (nao utilizada)
  v_valorparcela                   alias for $11; -- valor de cada parcela
  v_valultimaparcela               alias for $12; -- valor da ultima parcela

  sObservacao                      alias for $13; -- observacao do parcelamento
  iProcesso                        alias for $14; -- codigo do processo (protprocesso)

  v_ultparc                        integer default 2;
  v_matric                         integer default 0;
  v_inscr                          integer default 0;

  iUltMatric                       integer;
  iUltNumpre                       integer;
  iUltNumpar                       integer;
  iUltReceit                       integer;

  iSeqArrecKey                     integer;
  iSeqArrecadcompos                integer;

  v_anousu                         integer;
  v_totpar                         integer;
  v_cgmpri                         integer;
  v_somar1                         integer;
  v_somar2                         integer;
  v_numpre                         integer;
  v_receita                        integer;
  v_termo                          integer;
  v_termo_ori                      integer;
  v_tipo                           integer;
  v_tiponovo                       integer;
  v_quantparcel                    integer;
  v_var                            integer;
  v_inicialmov                     integer;
  v_totparcdestarec                integer;
  v_contador                       integer;
  v_cadtipoparc                    integer;
  v_recdestino                     integer;
  v_dia                            integer;
  v_ultdiafev                      integer;
  v_maxrec                         integer;
  v_anovenc                        integer;
  v_mesvenc                        integer;
  v_totalparcelas                  integer;
  v_anovencprox                    integer;
  v_mesvencprox                    integer;
  v_recjurosultima                 integer;
  v_recmultaultima                 integer;
  v_histjuro                       integer;
  v_proxmessegvenc                 integer;
  iInstit                          integer;
  iAnousu                          integer;
  iQtdRegistrosMatricula           integer;
  iQtdRegistrosInscricao           integer;

  v_totaldivida                    numeric default 0;
  v_somar                          numeric default 0;
  v_totalliquido                   numeric default 0;
  v_total_liquido                  numeric default 0;
  v_totalzao                       numeric default 0;

  v_calcula_valprop                numeric(15,10);
  v_calcula_valor                  float8 default 0;
  v_calcula_his                    numeric(15,2);
  v_calcula_cor                    numeric(15,2);
  v_calcula_jur                    numeric(15,2);
  v_calcula_mul                    numeric(15,2);
  v_calcula_desccor                numeric(15,2);
  v_calcula_descjur                numeric(15,2);
  v_calcula_descmul                numeric(15,2);

  nValidacaoPerc                   numeric(15,10);
  nPercentualVirtualCgm            numeric(15,10);
  nDiferencaPercentualCGM          numeric(15,10) default 0;
  nDiferencaPercentualAjuste       numeric(15,10);

  v_descontocor                    float8 default 0;
  v_tipodescontocor                integer default 0;
  v_descontojur                    float8 default 0;
  v_descontomul                    float8 default 0;
  v_total                          float8;
  v_totalcomjuro                   float8;
  v_valparc                        float8;
  v_diferencanaultima              float8;

  v_valorinserir                   float8;
  v_ent_prop                       float8;
  v_vlrateagora                    float8;
  v_totateagora                    float8;
  v_resto                          float8 default 0;
  v_teste                          float8;
  v_saldo                          float8;
  v_calcular                       float8;
  v_valorparcelanew                float8;
  v_valultimaparcelanew            float8;

  v_valdesccor                     float8;
  v_valdescjur                     float8;
  v_valdescmul                     float8;

  nValorTotalOrigem                float8;
  nPercCalc                        float8;
  nSomaPercMatric                  float8;
  nSomaPercInscr                   float8;
  nTotArreMatric                   float8;
  nTotArreInscr                    float8;

  nVlrHis                          numeric default 0;
  nVlrCor                          numeric default 0;
  nVlrJur                          numeric default 0;
  nVlrMul                          numeric default 0;
  nVlrDes                          numeric default 0;
  nPercMatric                      numeric default 0;
  nPercInscr                       numeric default 0;
  nPercCGM                         numeric default 0;
  lIncluiEmParcelas                boolean default false;

  nVlrTotalHistorico               numeric default 0;
  nVlrTotalCorrecao                numeric default 0;
  nVlrTotalJuros                   numeric default 0;
  nVlrTotalMulta                   numeric default 0;

  v_historico_compos               float8 default 0;
  v_correcao_compos                float8 default 0;
  v_juros_compos                   float8 default 0;
  v_multa_compos                   float8 default 0;

  nVlrHistoricoComposicao          numeric(15,2) default 0;
  nVlrCorrecaoComposicao           numeric(15,2) default 0;
  nVlrJurosComposicao              numeric(15,2) default 0;
  nVlrMultaComposicao              numeric(15,2) default 0;
  nVlrTotalParcelamento            numeric(15,2) default 0;
  nVlrTotalComposicao              numeric(15,2) default 0;
  nVlrDiferencaComposicaoTotal     numeric(15,2) default 0;

  nVlrTotalParcelamentoHistorico   numeric(15,2) default 0;
  nVlrTotalParcelamentoCorrigido   numeric(15,2) default 0;
  nVlrTotalParcelamentoJuros       numeric(15,2) default 0;
  nVlrTotalParcelamentoMulta       numeric(15,2) default 0;
  nVlrTotalDescontoCorrigido       numeric(15,2) default 0;
  nVlrTotalDescontoJuros           numeric(15,2) default 0;
  nVlrTotalDescontoMulta           numeric(15,2) default 0;

  nVlrDiferencaComposicaoHistorico numeric(15,2) default 0;
  nVlrDiferencaComposicaoCorrecao  numeric(15,2) default 0;
  nVlrDiferencaComposicaoJuros     numeric(15,2) default 0;
  nVlrDiferencaComposicaoMulta     numeric(15,2) default 0;

  v_ultdiafev_d                    date;
  v_vcto                           date;
  dDataUsu                         date;

  sArreoldJuncao                   varchar default '';
  v_proxmessegvenc_c               varchar(2);
  v_ultdiafev_c                    varchar(10);
  sStringUpdate                    varchar;
  sNumpreSemVinculoMatricInsc      text;

  v_comando                        text;
  v_comando_cria                   text;

  v_iniciais                       record;
  v_record_perc                    record;
  v_record_numpres                 record;
  v_record_numpar                  record;
  v_record_receitas                record;
  v_record_recpar                  record;
  v_record_origem                  record;
  v_record_desconto                record;
  rPercOrigem                      record;
  rSeparaJurMul                    record;
  rAjusteDiferencaPercentual       record;

  lTabelasCriadas                  boolean;
  v_parcnormal                     boolean default false; -- se tem divida ativa selecionada
  v_parcinicial                    boolean default false; -- se tem inicial selecionada
  lParcDiversos                    boolean default false; -- se tem diversos selecionado
  lParcContrib                     boolean default false; -- se tem contribuicao de melhoria selecionado
  lParcParc                        boolean default false; -- se tem parcelamento selecionado (caso esteja efetuando um reparcelamento)
  v_juronaultima                   boolean default false;
  v_descontar                      boolean default false;
  lSeparaJuroMulta                 integer default 2;
  lGravaArrecad                    boolean default true;
  lParcelaZerada                   boolean default false;
  lValidaParcInicial               boolean default false;

  lRaise                           boolean default false;

  begin

-- valores retornados:
-- 1 = ok
-- 2 = tentando parcelar mais de um tipo (k03_tipo) de debito
-- 3 = tipo de debito nao configurado para parcelamento
-- 4 = parcelamento nao encontrado pelo numpre
-- 5 = tentando reparcelar mais de um parcelamento
-- 6 = tentando parcelar mais de um numpre (debito)

    lRaise  := ( case when fc_getsession('DB_debugon') is null or fc_getsession('DB_debugon') = '' then false else true end );
    if lRaise is true then
      perform fc_debug('Processando parcelamento dos débitos...',lRaise,true,false);
    end if;

    v_totalparcelas       = v_totparc;
    v_valorparcelanew     = v_valorparcela;
    v_valultimaparcelanew = v_valultimaparcela;

    iInstit := cast(fc_getsession('DB_instit') as integer);
    if iInstit is null then
       raise exception 'Variavel de sessão [DB_instit] não encontrada.';
    end if;

    iAnousu := cast(fc_getsession('DB_anousu') as integer);
    if iAnousu is null then
       raise exception 'Variavel de sessão [DB_anousu] não encontrada.';
    end if;

    dDataUsu := cast(fc_getsession('DB_datausu') as date);
    if dDataUsu is null then
       raise exception 'Variavel de sessão [DB_datausu] não encontrada.';
    end if;

    select k03_separajurmulparc
      into lSeparaJuroMulta
      from numpref
     where k03_instit = iInstit
       and k03_anousu = iAnousu;

    --lSeparaJuroMulta = false;

        -- testa se existe algum tipo de parcelamento configurado
    select count(*)
      from tipoparc
     where instit = iInstit
      into v_contador;

    if v_contador is null then
      return '[0] - Sem configuracao na tabela tipoparc para instituicao %', iInstit;
    end if;

    if lRaise is true then
      perform fc_debug('verificando se tem mais de um tipo de debito...',lRaise,false,false);
    end if;

    -- existe uma tabela temporaria chamada totalportipo, criada antes de chamar a funcao de parcelamento
        -- que contem os valores a parcelar agrupada por tipo de debito
        -- nessa tabela existe a informacao se o tipo de debito tem direito a desconto ou nao

        -- a tabela numpres_parc contem os registros marcados na CGF pelo usuario
        -- cria indice na tabela utilizada durante os parcelamentos
    create index numpres_parc_in on numpres_parc using btree (k00_numpre, k00_numpar);

    -- for buscando as origens de cada debito selecionado para parcelar(numpres_parc)
    for v_record_origem in  select arretipo.k03_tipo,
                                   arrecad.k00_numpre, count(*)
                              from numpres_parc
                             inner join arrecad  on arrecad.k00_numpre = numpres_parc.k00_numpre
                             inner join arretipo on arretipo.k00_tipo  = arrecad.k00_tipo
                             group by arretipo.k03_tipo,
                                      arrecad.k00_numpre
    loop

      -- se origem(k03_tipo) for
      if v_record_origem.k03_tipo = 5 then

        -- 5 divida ativa
        v_parcnormal = true;

      elsif v_record_origem.k03_tipo = 18 then

        -- inicial do foro
        v_parcinicial = true;
        lValidaParcInicial = true;

      elsif v_record_origem.k03_tipo = 4 then

        -- contribuicao de melhoria
        lParcContrib = true;

      elsif v_record_origem.k03_tipo = 7 then

        -- diversos
        lParcDiversos = true;

      elsif v_record_origem.k03_tipo in (6,13,16,17) then

        -- reparcelamentos
           -- 6   parcelamento de divida
           -- 13  parcelamento de inicial de divida
           -- 16  parcelamento de diveros
           -- 17  parcelamento de contribuicao de melhoria
        lParcParc = true;

        if v_record_origem.k03_tipo = 13 then
          lValidaParcInicial = true;
        end if;

      end if;

      if lRaise is true then
        perform fc_debug('k00_tipo: '||v_record_origem.k03_tipo||'k00_numpre:'||v_record_origem.k00_numpre,lRaise,false,false);
      end if;

    end loop;

    if v_parcnormal is true and v_parcinicial is true then
      return '[1] - Nao pode ser parcela divida normal com ajuizada!';
    end if;

    -- se houver débitos do tipo Inicial verificamos se o parâmetro do Mód. Juridio PARTILHA está ativo "SIM" e
    -- caso exista mais de um processo para as iniciais bloqueamos o parcelamento.
    if lValidaParcInicial is true then

       perform v19_partilha
         from parjuridico
        where v19_anousu = iAnousu
          and v19_instit = iInstit
          and v19_partilha is true;
       if found then

          perform count( distinct case
                                    when processoinicial.v71_processoforo is null
                                      then processoparcel.v71_processoforo
                                    else processoinicial.v71_processoforo end )
             from NUMPRES_PARC
                  left join inicialnumpre                          on inicialnumpre.v59_numpre        = NUMPRES_PARC.k00_numpre
                  left join processoforoinicial as processoinicial on processoinicial.v71_inicial     = inicialnumpre.v59_inicial
                  left join termo                                  on termo.v07_numpre                = NUMPRES_PARC.k00_numpre
                  left join termoini                               on termoini.parcel                 = termo.v07_parcel
                  left join processoforoinicial as processoparcel  on processoparcel.v71_inicial      = termoini.inicial
           having count(distinct case
                                   when processoinicial.v71_processoforo is null
                                     then processoparcel.v71_processoforo
                                   else processoinicial.v71_processoforo end) > 1;
          if found then
            return '[2] - Não é possível parcelar iniciais com processos do foro diferentes para um mesmo parcelamento! [Utilização de Partilha Ativada]';
          end if;

       end if;

    end if;

    if lRaise is true then
      perform fc_debug('guardando o tipo de debito...',lRaise,false,false);
    end if;

    v_tipo = v_cadtipo;

    if lRaise is true then
      perform fc_debug('guardando o tipo de debito...',lRaise,false,false);
    end if;

        -- select na termoconfigo para descobrir qual o tipo de debito
        -- que vai ser gerado com o debito do novo parcelamento
        -- tabela termotipoconfig tem o tipo de debito dos grupos de debitos
        -- que e possivel parcelar

    if lRaise is true then
      perform fc_debug('instit -- '||iInstit,lRaise,false,false);
    end if;

    select k42_tiponovo
      into v_tiponovo
      from termotipoconfig
     where k42_cadtipo = v_tipo
       and k42_instit  = iInstit;
    if not found then
      return '[3] - Este tipo de debito nao esta configurado para parcelamento';
    end if;

    if lRaise is true then
      perform fc_debug('tipo novo:'||v_tiponovo,lRaise,false,false);
    end if;

    -- cria tabela temporarias para utilizacao durante o calculo
    if lRaise is true then
       perform fc_debug('',lRaise,false,false);
       perform fc_debug('+--------------------------------------------------------------------------------------------------',lRaise,false,false);
       perform fc_debug('| ',lRaise,false,false);
       perform fc_debug('| CRIANDO TABELAS TEMPORARIAS PARA O PROCESSAMENTO DO PARCELAMENTO ',lRaise,false,false);
       perform fc_debug('| ',lRaise,false,false);
       perform fc_debug('+--------------------------------------------------------------------------------------------------',lRaise,false,false);
       perform fc_debug('',lRaise,false,false);
    end if;
    select fc_parc_criatemptable(lRaise)
      into lTabelasCriadas;
    if lTabelasCriadas is false then
      return '[4] - Problema ao criar as tabelas temporarias. ';
    end if;


    -- Desativado parâmetro para que não seja gerado registros na incorporação tributária
    perform fc_putsession('DB_utiliza_incorporacao','false');

    -- funcao que corrige o arrecad no caso de encontrar registros duplicados(numpre,numpar,receit)
    perform fc_corrigeparcelamento();

    -- Ativado parâmetro para que continue sendo gerado registros na incorporação tributária
    perform fc_putsession('DB_utiliza_incorporacao','true');

        -- testa se todas as parcelas do parcelamento foram marcadas,
        -- senao nao permite parcelar apenas algumas parcelas do parcelamento
        -- ou seja, ou parcela todas as parcelas do parcelamento, ou nada
    for v_record_origem in select distinct
                                  termo.v07_parcel
                             from numpres_parc
                            inner join termo on termo.v07_numpre = numpres_parc.k00_numpre
                            where k03_tipodebito <> 18
    loop

      -- soma a quantidade de parcelas do parcelamento
      select count(distinct arrecad.k00_numpar)
        into v_somar1
        from arrecad
       inner join termo on termo.v07_parcel = v_record_origem.v07_parcel
       where arrecad.k00_numpre = termo.v07_numpre;

      if lRaise is true then
        perform fc_debug('v_record_origem.v07_parcel: '||v_record_origem.v07_parcel,lRaise,false,false);
      end if;

            -- testa a quantidade de parcelas marcadas
      select count(distinct numpres_parc.k00_numpar)
        into v_somar2
        from numpres_parc
       inner join termo on termo.v07_parcel = v_record_origem.v07_parcel
       where numpres_parc.k00_numpre = termo.v07_numpre;

      if lRaise is true then
        perform fc_debug('Verificando quantidades de parcelaas marcadas com a quantidade de parcelas do débito: v_somar1: '||v_somar1||' - v_somar2: '||v_somar2,lRaise,false,false);
      end if;
            -- compara
      if v_somar1 <> v_somar2 then
        return '[5] - Todas as parcelas do parcelamento ' || v_record_origem.v07_parcel || ' devem ser marcadas!';
      end if;

    end loop;

    if lRaise is true then
      perform fc_debug('entrada'||v_entrada,lRaise,false,false);
      perform fc_debug('valor das parcelas:'||v_valorparcelanew,lRaise,false,false);
      perform fc_debug('valor da ultima parcela:'||v_valultimaparcelanew,lRaise,false,false);
      perform fc_debug('pegando cgm do(s) numpre(s) com arrecad...',lRaise,false,false);
    end if;

        -- busca cgm principal para gravar no arrecad posteriormente
    if v_parcinicial is true then


      select k00_numcgm
        from arrecad
        into v_cgmpri
             inner join numpres_parc on arrecad.k00_numpre = numpres_parc.k00_numpre
       limit 1;

    else

      select k00_numcgm
        from arrecad
        into v_cgmpri
             inner join numpres_parc on arrecad.k00_numpre = numpres_parc.k00_numpre
                                    and arrecad.k00_numpar = numpres_parc.k00_numpar
       limit 1;

    end if;



    if lRaise is true then
      perform fc_debug('Pegando cgm de acordo com matricula ou inscricao...',lRaise,false,false);
    end if;

    v_anousu := iAnousu;

        -- se for parcelamento de inicial
    if v_parcinicial is true then

      if lRaise is true then
        perform fc_debug('t i p o: 18',lRaise,false,false);
      end if;

            -- procura cgm principal por matricula ou inscricao
      for v_record_origem in select distinct
                                    arrematric.k00_matric,
                                    arreinscr.k00_inscr
                               from numpres_parc
                                    left join arrematric on arrematric.k00_numpre = numpres_parc.k00_numpre
                                    left join arreinscr  on arreinscr.k00_numpre  = numpres_parc.k00_numpre
                                   inner join arrecad    on arrecad.k00_numpre    = numpres_parc.k00_numpre
      loop

        if lRaise is true then
          perform fc_debug('processando... matricula: '||v_record_origem.k00_matric||' inscricao: '||v_record_origem.k00_inscr,lRaise,false,false);
        end if;

        if v_record_origem.k00_matric is not null then
          select j01_numcgm
            from iptubase
            into v_cgmpri
           where j01_matric = v_record_origem.k00_matric;
        end if;

        if v_record_origem.k00_inscr is not null then
          select q02_numcgm
            from issbase
            into v_cgmpri
           where q02_inscr = v_record_origem.k00_inscr;
        end if;

      end loop;

        -- senao for inicial do foro
    else

      if lRaise is true then
        perform fc_debug(' ',lRaise,false,false);
        perform fc_debug(' ',lRaise,false,false);
        perform fc_debug('Buscando CGM princial por matricula ou inscrição',lRaise,false,false);
        perform fc_debug(' ',lRaise,false,false);
      end if;

      -- procura cgm principal por matricula ou inscricao
      for v_record_origem in select distinct
                                    arrematric.k00_matric,
                                    arreinscr.k00_inscr
                               from numpres_parc
                               left join arrematric on arrematric.k00_numpre = numpres_parc.k00_numpre
                               left join arreinscr  on arreinscr.k00_numpre  = numpres_parc.k00_numpre
                              inner join arrecad    on arrecad.k00_numpre    = numpres_parc.k00_numpre
                                                   and arrecad.k00_numpar = numpres_parc.k00_numpar
      loop

        if lRaise is true then
          perform fc_debug('Processando... matricula: '||v_record_origem.k00_matric||' inscricao: '||v_record_origem.k00_inscr, lRaise, false, false);
        end if;

        if v_record_origem.k00_matric is not null then
          select j01_numcgm
            from iptubase
            into v_cgmpri
           where j01_matric = v_record_origem.k00_matric;
        end if;

        if v_record_origem.k00_inscr is not null then
          select q02_numcgm
            from issbase
            into v_cgmpri
           where q02_inscr = v_record_origem.k00_inscr;
        end if;

      end loop;

      if lRaise is true then
        perform fc_debug('',lRaise,false,false);
        perform fc_debug('',lRaise,false,false);
        perform fc_debug('Fim da busca do CGM principal',lRaise,false,false);
        perform fc_debug('',lRaise,false,false);
      end if;

    end if;



    if lRaise is true  then
      perform fc_debug('agora vai processar correcao e tal...',lRaise,false,false);
    end if;

        -- se for inicial, traz apenas os numpres envolvidos, ja que no caso de parcelamento de inicial
        -- o usuario nao tem opcao de marcar as parcelas, tendo que parcelar toda a inicial
        -- se nao for inicial, traz os numpres com suas respectivas parcelas marcadas
    if v_parcinicial is true then
      v_comando = 'select distinct k00_numpre from numpres_parc';
    else
      v_comando = 'select distinct k00_numpre, k00_numpar from numpres_parc';
    end if;


        -- varre a lista de numpres/parcelas marcados pelo usuario
    for v_record_numpres in execute v_comando
    loop

      if lRaise is true then
        if v_parcinicial is false then
          perform fc_debug('      numpre '||v_record_numpres.k00_numpre||' - numpar: '||v_record_numpres.k00_numpar,lRaise, false, false);
        else
          perform fc_debug('      numpre '||v_record_numpres.k00_numpre||' - numpar: 0',lRaise, false, false);
        end if;
      end if;

      v_matric = 0;
      v_inscr  = 0;

      -- busca a matricula do numpre que esta sendo processado
      select k00_matric
        into v_var
        from arrematric
       where k00_numpre = v_record_numpres.k00_numpre;

      if v_var is not null then
        v_matric = v_var;

        if lRaise is true then
          perform fc_debug(' origem: matricula '||v_matric,lRaise,false,false);
        end if;
      end if;


      -- busca a inscricao do numpre que esta sendo processado
      select k00_inscr
        into v_var
        from arreinscr
       where k00_numpre = v_record_numpres.k00_numpre;

      if v_var is not null then
        v_inscr = v_var;

        if lRaise is true then
          perform fc_debug(' origem: inscricao '||v_inscr,lRaise,false,false);
        end if;
      end if;

      -- processa cada registro acumulando por numpre, parcela, receita e tipo de debito
      -- armazenando as informacoes de valor historico, corrigido, juros e multa
      -- na tabela arrecad_parc_rec para utilizacao em processamento futuro
      -- independente se for inicial ou nao

      -- se for inicial
      if v_parcinicial is true then

        if lRaise is true  then
          perform fc_debug('      entrando tipo 18...',lRaise,false,false);
        end if;

        for v_record_numpar in select k00_numpre,
                                      k00_numpar,
                                      k00_receit,
                                      k03_tipo,
                                      substr(fc_calcula,2,13)::float8  as vlrhis,
                                      substr(fc_calcula,15,13)::float8 as vlrcor,
                                      substr(fc_calcula,28,13)::float8 as vlrjuros,
                                      substr(fc_calcula,41,13)::float8 as vlrmulta,
                                      substr(fc_calcula,54,13)::float8 as vlrdesc,
                                      (substr(fc_calcula,15,13)::float8+substr(fc_calcula,28,13)::float8+substr(fc_calcula,41,13)::float8-substr(fc_calcula,54,13)::float8) as total
                                 from ( select k00_numpre,
                                               k00_numpar,
                                               k00_receit,
                                               k03_tipo,
                                               fc_calcula(k00_numpre,k00_numpar,k00_receit,dDataUsu,dDataUsu,v_anousu) as fc_calcula
                                          from ( select distinct
                                                        arrecad.k00_numpre,
                                                        arrecad.k00_numpar,
                                                        arrecad.k00_receit,
                                                        arretipo.k03_tipo
                                                   from arrecad
                                                        inner join arretipo on arrecad.k00_tipo = arretipo.k00_tipo
                                                  where arrecad.k00_numpre = v_record_numpres.k00_numpre
                                               ) as x
                                      ) as y
        loop

          select receit
            from arrecad_parc_rec
            into v_receita
           where numpre = v_record_numpar.k00_numpre
             and numpar = v_record_numpar.k00_numpar
             and receit = v_record_numpar.k00_receit;

          /*--------------------------------------------------------------------------------------*/

          if lRaise is true then
            perform fc_debug('1 - numpre: '||v_record_numpar.k00_numpre||', numpar: '||v_record_numpar.k00_numpar||', receit: '||v_record_numpar.k00_receit||', v_receita: '||v_receita,lRaise,false,false);
          end if;

          -- se nao existe registro insere
          if v_receita is null then

            if lRaise is true then
              perform fc_debug(' ',lRaise,false,false);
              perform fc_debug('inserindo registro na arrecad_parc_rec',lRaise,false,false);
            end if;

            execute 'insert into arrecad_parc_rec values (' || v_record_numpar.k00_numpre || ','
                                                            || v_record_numpar.k00_numpar || ','
                                                            || v_record_numpar.k00_receit || ','
                                                            || v_record_numpar.k03_tipo   || ','
                                                            || v_record_numpar.vlrhis     || ','
                                                            || v_record_numpar.vlrcor     || ','
                                                            || v_record_numpar.vlrjuros   || ','
                                                            || v_record_numpar.vlrmulta   || ','
                                                            || v_record_numpar.vlrdesc    || ','
                                                            || v_record_numpar.total      || ','
                                                            || v_matric                   || ','
                                                            || v_inscr                    || ','
                                                            || 0                          || ','
                                                            || 0                          || ','
                                                            || 0                          || ','
                                                            || 'false'                    || ');';
          -- se ja existe, soma
          else

            execute 'update arrecad_parc_rec set valor   = valor  + ' || v_record_numpar.total    || ','
                                              || 'vlrhis = vlrhis + ' || v_record_numpar.vlrhis   || ','
                                              || 'vlrcor = vlrcor + ' || v_record_numpar.vlrcor   || ','
                                              || 'vlrjur = vlrjur + ' || v_record_numpar.vlrjuros || ','
                                              || 'vlrmul = vlrmul + ' || v_record_numpar.vlrmulta || ','
                                              || 'vlrdes = vlrdes + ' || v_record_numpar.vlrdesc
                                      || ' where numpre = ' || v_record_numpar.k00_numpre
                                      || '   and numpar = ' || v_record_numpar.k00_numpar
                                      || '   and receit = ' || v_record_numpar.k00_receit ||';';
          end if;

        end loop;

        if lRaise is true then
          perform fc_debug('      saindo do tipo 18...',lRaise,false,false);
        end if;

      else -- se nao for inicial foro


        if lRaise is true then
          perform fc_debug(' tipo diferente de 18 ',lRaise,false,false);
        end if;

        if lRaise is true then
          perform fc_debug('numpre: '||v_record_numpres.k00_numpre||' - numpar: '||v_record_numpres.k00_numpar,lRaise,false,false);
        end if;

        for v_record_numpar in select k00_numpre,
                                      k00_numpar,
                                      k00_receit,
                                      k03_tipo,
                                      substr(fc_calcula,2, 13)::float8 as vlrhis,
                                      substr(fc_calcula,15,13)::float8 as vlrcor,
                                      substr(fc_calcula,28,13)::float8 as vlrjuros,
                                      substr(fc_calcula,41,13)::float8 as vlrmulta,
                                      substr(fc_calcula,54,13)::float8 as vlrdesc,
                                      (substr(fc_calcula,15,13)::float8+
                                      substr(fc_calcula,28,13)::float8+
                                      substr(fc_calcula,41,13)::float8-
                                      substr(fc_calcula,54,13)::float8) as total
                                 from ( select distinct
                                               k00_numpre,
                                               k00_numpar,
                                               k00_receit,
                                               k03_tipo,
                                               fc_calcula(k00_numpre,k00_numpar,k00_receit,dDataUsu,dDataUsu,v_anousu) as fc_calcula
                                          from ( select distinct
                                                        arrecad.k00_numpre,
                                                        arrecad.k00_numpar,
                                                        arrecad.k00_receit,
                                                        arretipo.k03_tipo
                                                   from arrecad
                                                        inner join arretipo on arrecad.k00_tipo = arretipo.k00_tipo
                                                  where arrecad.k00_numpre = v_record_numpres.k00_numpre
                                                    and arrecad.k00_numpar = v_record_numpres.k00_numpar
                                                                                             ) as x
                                                                            ) as y
          loop

          if lRaise is true then
            perform fc_debug('         dentro do for...',lRaise,false,false);
          end if;

                    /*--------------------------------------------------------------------------------------*/

          select receit
            from arrecad_parc_rec
            into v_receita
           where numpre  = v_record_numpar.k00_numpre
             and numpar  = v_record_numpar.k00_numpar
             and receit  = v_record_numpar.k00_receit;

          if lRaise is true then
            perform fc_debug('2 - numpre: '||v_record_numpar.k00_numpre||' numpar: '||v_record_numpar.k00_numpar||' receit: '||v_record_numpar.k00_receit||' v_receita: '||v_receita||' - valor: '||v_record_numpar.total,lRaise,false,false);
          end if;

                    -- se nao existe registro insere
          if v_receita is null then

            if lRaise is true then
              perform fc_debug('   inserindo no arrecad_parc_rec... numpre: '||v_record_numpar.k00_numpre,lRaise,false,false);
            end if;

            execute 'insert into arrecad_parc_rec values (' || v_record_numpar.k00_numpre || ',' ||
                                                               v_record_numpar.k00_numpar || ',' ||
                                                               v_record_numpar.k00_receit || ',' ||
                                                               v_record_numpar.k03_tipo   || ',' ||
                                                               v_record_numpar.vlrhis     || ',' ||
                                                               v_record_numpar.vlrcor     || ',' ||
                                                               v_record_numpar.vlrjuros   || ',' ||
                                                               v_record_numpar.vlrmulta   || ',' ||
                                                               v_record_numpar.vlrdesc    || ',' ||
                                                               v_record_numpar.total      || ',' ||
                                                               v_matric                   || ',' ||
                                                               v_inscr                    || ');';

          else

            execute 'update arrecad_parc_rec set valor = valor + ' || v_record_numpar.total
            || ',vlrhis = vlrhis + ' || v_record_numpar.vlrhis
            || ',vlrcor = vlrcor + ' || v_record_numpar.vlrcor
            || ',vlrjur = vlrjur + ' || v_record_numpar.vlrjuros
            || ',vlrmul = vlrmul + ' || v_record_numpar.vlrmulta
            || ',vlrdes = vlrdes + ' || v_record_numpar.vlrdesc
            || ' where numpre = '    || v_record_numpar.k00_numpre || ' and '
            || '       numpar = '    || v_record_numpar.k00_numpar || ' and '
            || '       receit = '    || v_record_numpar.k00_receit || ';';
          end if;

          if lRaise is true then
            perform fc_debug(' fim do for...',lRaise,false,false);
          end if;

        end loop;

      end if;

    end loop;

    if lRaise is true then
      perform fc_debug('gravando na tabela parcelas... tipo: '||v_tipo,lRaise,false,false);
      perform fc_debug('v_temdesconto: '||v_temdesconto,lRaise,false,false);
    end if;

        -- busca regra de parcelamento
    select cadtipoparc.k40_codigo
      into v_cadtipoparc
      from tipoparc
           inner join cadtipoparc on cadtipoparc = k40_codigo
     where maxparc       > 1
       and dDataUsu     >= k40_dtini
       and dDataUsu     <= k40_dtfim
       and k40_codigo    = v_desconto
       and k40_aplicacao = 1 -- Aplicar Antes do Lancamento
    order by maxparc  limit 1;

    if lRaise is true then
      perform fc_debug('v_cadtipoparc: '||v_cadtipoparc,lRaise,false,false);
    end if;

        -- varre as regras de parcelamento para descobrir o percentual de desconto nos juros e multa de acordo com
        -- a quantidade de parcelas selecionadas pelo usuario
    for v_record_desconto in select *
                               from tipoparc
                              where maxparc     > 1
                                and cadtipoparc = v_cadtipoparc
                                and cadtipoparc = v_desconto
                              order by maxparc
    loop

      if v_totalparcelas >= v_ultparc and v_totalparcelas <= v_record_desconto.maxparc then
        v_tipodescontocor = v_record_desconto.tipovlr;
        v_descontocor = v_record_desconto.descvlr;
        v_descontomul = v_record_desconto.descmul;
        v_descontojur = v_record_desconto.descjur;

        exit;

      end if;

    end loop;

    if lRaise is true then
      perform fc_debug('total do desconto na multa : '||v_descontomul,lRaise,false,false);
      perform fc_debug('total do desconto nos juros: '||v_descontojur,lRaise,false,false);
      perform fc_debug('antes do for do arrecad_parc_rec...',lRaise,false,false);
    end if;

    -- soma o valor corrigido + juros + multa antes de efetuar o desconto
    -- valor apenas para conferencia em possivel debug
    select round(sum(valor),2),
           round(sum(vlrcor+vlrjur+vlrmul-vlrdesccor-vlrdescjur-vlrdescmul),2)
      into v_somar,
           v_totalliquido
      from arrecad_parc_rec;

    if lRaise is true then
      perform fc_debug('v_somar: '||v_somar||' - v_totalliquido: '||v_totalliquido,lRaise,false,false);
    end if;

    -- varre tabela dos registros a parcelar para aplicar desconto nos juros e multa
    for v_record_recpar in select *
                             from arrecad_parc_rec
    loop

      -- testa se o tipo de debito desse registro tem direito a desconto
      select case
               when k00_cadtipoparc > 0
               then true
               else false
             end
        into v_descontar
        from totalportipo
       where k03_tipodebito = v_record_recpar.tipo;

      if lRaise is true then
        perform fc_debug('tipo: '||v_record_recpar.tipo||' - descontar: '||v_descontar,lRaise,false,false);
      end if;

            -- se tem direito a desconto, aplica o desconto e da update nos valores do registro atual da arrecad_parc_rec
      if v_descontar is true then

        v_valdesccor = 0;

        if v_tipodescontocor = 1 then

          if lRaise is true then
            perform fc_debug('vlrcor: '||v_record_recpar.vlrcor||' - vlrhis: '||v_record_recpar.vlrhis||' - v_descontocor: '||v_descontocor,lRaise,false,false);
          end if;
          v_valdesccor = round((v_record_recpar.vlrcor - v_record_recpar.vlrhis) * v_descontocor / 100,2);

        elsif v_tipodescontocor = 2 then
          v_valdesccor = round(v_record_recpar.vlrcor * v_descontocor / 100,2);
        end if;

        if lRaise is true then
          perform fc_debug('v_valdesccor: '||v_valdesccor,lRaise,false,false);
        end if;

        v_valdescjur = round(v_record_recpar.vlrjur * v_descontojur / 100,2);
        if lRaise is true then
          perform fc_debug('v_valdescjur: '||v_valdescjur||' - v_descontojur: '||v_descontojur,lRaise,false, false);
        end if;

        v_valdescmul = round(v_record_recpar.vlrmul * v_descontomul / 100,2);
        if lRaise is true then
          perform fc_debug('v_valdescmul: '||v_valdescmul||' - v_descontomul: '||v_descontomul,lRaise,false,false);
        end if;

        execute 'update arrecad_parc_rec set vlrjur = ' || v_record_recpar.vlrjur
             || ', vlrmul      = ' || v_record_recpar.vlrmul
             || ', valor       = valor - ' || v_valdescjur || ' - ' || v_valdescmul || ' - ' || v_valdesccor
             || ', vlrdesccor  = ' || round(v_valdesccor,2)
             || ', vlrdescjur  = ' || round(v_record_recpar.vlrjur * v_descontojur / 100,2)
             || ', vlrdescmul  = ' || round(v_record_recpar.vlrmul * v_descontomul / 100,2)
             || ' where numpre = '    || v_record_recpar.numpre || ' and '
             || '       numpar = '    || v_record_recpar.numpar || ' and '
             || '       receit = '    || v_record_recpar.receit ||   ';';

      end if;

      if lRaise is true then
        perform fc_debug('   numpre: '||v_record_recpar.numpre||' - numpar: '||v_record_recpar.numpar||' - receita: '||v_record_recpar.receit,lRaise,false,false);
      end if;

    end loop;

        -- passa o conteudo do campo juro para false em todos os registros
    execute 'update arrecad_parc_rec set juro = false';

    if lRaise is true then
      perform fc_debug('v_desconto: '||v_desconto,lRaise,false,false);
    end if;

        -- se a forma na regra de parcelamento for 2 (juros na ultima)
    select case
             when k40_forma = 2
             then true
             else false
           end
      into v_juronaultima
      from cadtipoparc
     where k40_codigo = v_desconto;

    if v_juronaultima is null then
      v_juronaultima = false;
    end if;

    if lRaise is true then
      perform fc_debug('desconto na ultima: '||v_juronaultima,lRaise,false,false);
    end if;

    for v_record_recpar in select *
                             from arrecad_parc_rec loop

            -- se for para colocar juros na ultima
            -- insere mais dois registros: um para juros e outro para multa
            -- e update no campo valor deixando apenas o valor corrigido
      if v_juronaultima is true then

        select k02_recjur,
               k02_recmul
          from tabrec
          into v_recjurosultima,
               v_recmultaultima
         where k02_codigo = v_record_recpar.receit;

        if lRaise is true then
          perform fc_debug('jur: '||v_recjurosultima||' - mul: '||v_recmultaultima,lRaise,false,false);
          perform fc_debug('numpre: '||v_record_recpar.numpre||' - numpar: '||v_record_recpar.numpar||' - jurosnaultima: '||v_recjurosultima,lRaise,false,false);
          perform fc_debug('tipo: '||v_record_recpar.tipo||' - juros: '||v_record_recpar.vlrjur||' - matric: '||v_record_recpar.matric||' - inscr: '||v_record_recpar.inscr||' - descjur: '||v_record_recpar.vlrdescjur||' - descmul: '||v_record_recpar.vlrdescmul,lRaise,false,false);
        end if;

        execute 'insert into arrecad_parc_rec values (' || v_record_recpar.numpre          || ',' ||
                                                           v_record_recpar.numpar          || ',' ||
                                                           v_recjurosultima                || ',' ||
                                                           v_record_recpar.tipo            || ',' ||
                                                           v_record_recpar.vlrjur          || ',' ||
                                                           v_record_recpar.vlrjur          || ',' ||
                                                           0                               || ',' ||
                                                           0                               || ',' ||
                                                           0                               || ',' ||
                                                           v_record_recpar.vlrjur          || ',' ||
                                                           v_record_recpar.matric          || ',' ||
                                                           v_record_recpar.inscr           || ',' ||
                                                           0                               || ',' ||
                                                           v_record_recpar.vlrdescjur      || ',' ||
                                                           v_record_recpar.vlrdescmul      || ',' ||
                                                           'true'                          || ');';

        if lRaise is true then
          perform fc_debug('1',lRaise,false,false);
        end if;

        -- inserindo multa
        execute 'insert into arrecad_parc_rec values (' || v_record_recpar.numpre          || ',' ||
                                                           v_record_recpar.numpar          || ',' ||
                                                           v_recmultaultima                || ',' ||
                                                           v_record_recpar.tipo            || ',' ||
                                                           v_record_recpar.vlrmul          || ',' ||
                                                           v_record_recpar.vlrmul          || ',' ||
                                                           0                               || ',' ||
                                                           0                               || ',' ||
                                                           0                               || ',' ||
                                                           v_record_recpar.vlrmul          || ',' ||
                                                           v_record_recpar.matric          || ',' ||
                                                           v_record_recpar.inscr           || ',' ||
                                                           0                               || ',' ||
                                                           v_record_recpar.vlrdescjur      || ',' ||
                                                           v_record_recpar.vlrdescmul      || ',' ||
                                                           'true'                          || ');';

        if lRaise is true then
          perform fc_debug('2',lRaise,false,false);
        end if;

        execute 'update arrecad_parc_rec set valor  = ' || v_record_recpar.vlrcor ||
                                     ' where numpre = ' || v_record_recpar.numpre ||
                                     '   and numpar = ' || v_record_recpar.numpar ||
                                     '   and receit = ' || v_record_recpar.receit || ';';

        if lRaise is true then
          perform fc_debug('3',lRaise,false,false);
        end if;

      end if;

    end loop;

    if lRaise is true then
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
    end if;

        -- apenas mostra os registros atuais para possivel conferencia
    for v_record_recpar in select *
                             from arrecad_parc_rec loop

      if lRaise is true then
        perform fc_debug('numpre: '||v_record_recpar.numpre||' - par: '||v_record_recpar.numpar||' - rec: '||v_record_recpar.receit||' - cor: '||v_record_recpar.vlrcor||' - jur: '||v_record_recpar.vlrjur||' - tot: '||v_record_recpar.valor||' - juro: '||v_record_recpar.juro,lRaise, false,false);
      end if;

    end loop;

    if lRaise is true then
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
    end if;

    if lRaise is true then
      perform fc_debug('depois do for do arrecad_parc_rec...',lRaise,false,false);
    end if;

        -- calcula valor total com juro
    select round(sum(valor),2)
      from arrecad_parc_rec
      into v_totalcomjuro;

        -- se for juros na ultima, o campo valor ja esta sem juros e multa
        -- entao a variavel v_total recebe sem juros e a regra for de colocar os juros na ultima parcela
        -- note que o campo juro da tabela recebe false apenas nos registros que nao sao dos juros para incluir na ultima
    if v_juronaultima is false then
      select round(sum(valor),2)
        from arrecad_parc_rec
        into v_total;
    else
      select round(sum(valor),2)
        from arrecad_parc_rec
       where juro is false
        into v_total;
    end if;

        -- diferente entre variavel com e sem juros
        -- utilizada na regra de juros na ultima
    v_diferencanaultima = v_totalcomjuro - v_total;

    if lRaise is true then
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug('total (primeira versao do script): '||v_total||' - v_totalparcelas: '||v_totalparcelas,lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug('v_tipo: '||v_tipo,lRaise,false,false);
    end if;

    v_somar = 0;

    if lRaise is true then
      perform fc_debug('antes do tipo 5...',lRaise,false,false);
    end if;

    -- cria variavel para select agrupando os valores por
    -- tipo de origem, receita nova e receita original
    -- note que o sistema tem 3 niveis de origem
    -- 1 = de divida ativa
    -- 2 = parcelamento de divida, parcelamento de inicial, parcelamento de contribuicao, inicial do foro e contribuicao
    -- 3 = diversos

    v_comando =              '  select tipo_origem,                                                                                                                       \n';
    v_comando = v_comando || '         receita,                                                                                                                           \n';
    v_comando = v_comando || '         receitaori,                                                                                                                        \n';
    v_comando = v_comando || '         min(k00_hist) as k00_hist,                                                                                                         \n';
    v_comando = v_comando || '         round(sum(valor),2) as valor,                                                                                                      \n';
    v_comando = v_comando || '         round(sum(total_his),2) as total_his,                                                                                              \n';
    v_comando = v_comando || '         round(sum(total_cor),2) as total_cor,                                                                                              \n';
    v_comando = v_comando || '         round(sum(total_jur),2) as total_jur,                                                                                              \n';
    v_comando = v_comando || '         round(sum(total_mul),2) as total_mul,                                                                                              \n';
    v_comando = v_comando || '         round(sum(total_desccor),2) as total_desccor,                                                                                      \n';
    v_comando = v_comando || '         round(sum(total_descjur),2) as total_descjur,                                                                                      \n';
    v_comando = v_comando || '         round(sum(total_descmul),2) as total_descmul                                                                                       \n';
    v_comando = v_comando || '    from ( select 1 as tipo_origem,                                                                                                         \n';
    v_comando = v_comando || '                  receit as receita,                                                                                                        \n';
    v_comando = v_comando || '                  receitaori,                                                                                                               \n';
    v_comando = v_comando || '                  min(k00_hist) as k00_hist,                                                                                                \n';
    v_comando = v_comando || '                  sum(valor) as valor,                                                                                                      \n';
    v_comando = v_comando || '                  sum(total_his) as total_his,                                                                                              \n';
    v_comando = v_comando || '                  sum(total_cor) as total_cor,                                                                                              \n';
    v_comando = v_comando || '                  sum(total_jur) as total_jur,                                                                                              \n';
    v_comando = v_comando || '                  sum(total_mul) as total_mul,                                                                                              \n';
    v_comando = v_comando || '                  sum(total_desccor) as total_desccor,                                                                                      \n';
    v_comando = v_comando || '                  sum(total_descjur) as total_descjur,                                                                                      \n';
    v_comando = v_comando || '                  sum(total_descmul) as total_descmul                                                                                       \n';
    v_comando = v_comando || '               from ( select a.numpre,                                                                                                      \n';
    v_comando = v_comando || '                             a.numpar,                                                                                                      \n';
    v_comando = v_comando || '                             a.receita as receit,                                                                                           \n';
    v_comando = v_comando || '                             a.receitaori as receitaori,                                                                                    \n';
    v_comando = v_comando || '                             min(k00_hist) as k00_hist,                                                                                     \n';
    v_comando = v_comando || '                             sum(a.valor) as valor,                                                                                         \n';
    v_comando = v_comando || '                             sum(total_his) as total_his,                                                                                   \n';
    v_comando = v_comando || '                             sum(total_cor) as total_cor,                                                                                   \n';
    v_comando = v_comando || '                             sum(total_jur) as total_jur,                                                                                   \n';
    v_comando = v_comando || '                             sum(total_mul) as total_mul,                                                                                   \n';
    v_comando = v_comando || '                             sum(total_desccor) as total_desccor,                                                                           \n';
    v_comando = v_comando || '                             sum(total_descjur) as total_descjur,                                                                           \n';
    v_comando = v_comando || '                             sum(total_descmul) as total_descmul                                                                            \n';
    v_comando = v_comando || '                      from ( select arrecad_parc_rec.numpre,                                                                                \n';
    v_comando = v_comando || '                                    arrecad_parc_rec.numpar,                                                                                \n';
    v_comando = v_comando || '                                    arrecad_parc_rec.receit as receitaori,                                                                  \n';
    v_comando = v_comando || '                                    recparproc.receita as receita,                                                                          \n';
    v_comando = v_comando || '                                    min(proced.k00_hist) as k00_hist,                                                                       \n';
    v_comando = v_comando || '                                    round(sum(arrecad_parc_rec.valor),2) as valor,                                                          \n';
    v_comando = v_comando || '                                    round(sum(vlrhis),2) as total_his,                                                                      \n';
    v_comando = v_comando || '                                    round(sum(vlrcor),2) as total_cor,                                                                      \n';
    v_comando = v_comando || '                                    round(sum(vlrjur),2) as total_jur,                                                                      \n';
    v_comando = v_comando || '                                    round(sum(vlrmul),2) as total_mul,                                                                      \n';
    v_comando = v_comando || '                                    round(sum(vlrdesccor),2) as total_desccor,                                                              \n';
    v_comando = v_comando || '                                    round(sum(vlrdescjur),2) as total_descjur,                                                              \n';
    v_comando = v_comando || '                                    round(sum(vlrdescmul),2) as total_descmul                                                               \n';
    v_comando = v_comando || '                               from arrecad_parc_rec                                                                                        \n';
    v_comando = v_comando || '                                    inner join arrecad     on arrecad.k00_numpre    = arrecad_parc_rec.numpre                               \n';
    v_comando = v_comando || '                                                          and arrecad.k00_numpar    = arrecad_parc_rec.numpar                               \n';
    v_comando = v_comando || '                                                          and arrecad.k00_receit    = arrecad_parc_rec.receit                               \n';
    v_comando = v_comando || '                                                          and arrecad.k00_valor     > 0                                                     \n';
    v_comando = v_comando || '                                    inner join arretipo    on arretipo.k00_tipo     = arrecad.k00_tipo                                      \n';
    v_comando = v_comando || '                                    left  join divida      on divida.v01_numpre     = arrecad.k00_numpre                                    \n';
    v_comando = v_comando || '                                                          and divida.v01_numpar     = arrecad.k00_numpar                                    \n';
    v_comando = v_comando || '                                    left  join recparproc  on recparproc.v03_codigo = divida.v01_proced                                     \n';
    v_comando = v_comando || '                                    inner join proced      on proced.v03_codigo     = divida.v01_proced                                     \n';
    v_comando = v_comando || '                                    where k03_tipo = 5                                                                                      \n';
    if v_juronaultima is true then
     v_comando = v_comando || '                                     and juro is false                                                                                     \n';
    end if;
    v_comando = v_comando || '                                    group by arrecad_parc_rec.numpre,                                                                       \n';
    v_comando = v_comando || '                                             arrecad_parc_rec.numpar,                                                                       \n';
    v_comando = v_comando || '                                             arrecad_parc_rec.receit,                                                                       \n';
    v_comando = v_comando || '                                             recparproc.receita                                                                             \n';
    v_comando = v_comando || '                           ) as a                                                                                                           \n';
    v_comando = v_comando || '                          group by a.numpre,                                                                                                \n';
    v_comando = v_comando || '                                   a.numpar,                                                                                                \n';
    v_comando = v_comando || '                                   a.receita,                                                                                               \n';
    v_comando = v_comando || '                                   a.receitaori                                                                                             \n';
    v_comando = v_comando || '                    ) as x                                                                                                                  \n';
    v_comando = v_comando || '               group by receit,                                                                                                             \n';
    v_comando = v_comando || '                        receitaori                                                                                                          \n';

    v_comando = v_comando || '      union                                                                                                                                 \n';

    v_comando = v_comando || '             select 2 as tipo_origem,                                                                                                       \n';
    v_comando = v_comando || '                    case when recparproc.receita is null then                                                                               \n';
    v_comando = v_comando || '                         arrecad_parc_rec.receit                                                                                            \n';
    v_comando = v_comando || '                       else                                                                                                                 \n';
    v_comando = v_comando || '                         recparproc.receita                                                                                                 \n';
    v_comando = v_comando || '                    end as receit,                                                                                                          \n';
    v_comando = v_comando || '                    arrecad_parc_rec.receit as receitaori,                                                                                  \n';
    v_comando = v_comando || '                    min(arrecad.k00_hist) as k00_hist,                                                                                      \n';
    v_comando = v_comando || '                    round(sum(arrecad_parc_rec.valor),2) as valor,                                                                          \n';
    v_comando = v_comando || '                    round(sum(vlrhis),2) as total_his,                                                                                      \n';
    v_comando = v_comando || '                    round(sum(vlrcor),2) as total_cor,                                                                                      \n';
    v_comando = v_comando || '                    round(sum(vlrjur),2) as total_jur,                                                                                      \n';
    v_comando = v_comando || '                    round(sum(vlrmul),2) as total_mul,                                                                                      \n';
    v_comando = v_comando || '                    round(sum(vlrdesccor),2) as total_desccor,                                                                              \n';
    v_comando = v_comando || '                    round(sum(vlrdescjur),2) as total_descjur,                                                                              \n';
    v_comando = v_comando || '                    round(sum(vlrdescmul),2) as total_descmul                                                                               \n';
    v_comando = v_comando || '               from arrecad_parc_rec                                                                                                        \n';
    v_comando = v_comando || '                    inner join arrecad    on arrecad.k00_numpre = arrecad_parc_rec.numpre                                                   \n';
    v_comando = v_comando || '                                         and arrecad.k00_numpar = arrecad_parc_rec.numpar                                                   \n';
    v_comando = v_comando || '                                         and arrecad.k00_receit = arrecad_parc_rec.receit                                                   \n';
    v_comando = v_comando || '                                         and arrecad.k00_valor > 0                                                                          \n';
    v_comando = v_comando || '                    inner join arretipo   on  arretipo.k00_tipo = arrecad.k00_tipo                                                          \n';
    v_comando = v_comando || '                    left  join divida     on divida.v01_numpre     = arrecad.k00_numpre                                                     \n';
    v_comando = v_comando || '                                         and divida.v01_numpar     = arrecad.k00_numpar                                                     \n';
    v_comando = v_comando || '                    left  join recparproc on recparproc.v03_codigo = divida.v01_proced                                                      \n';
    v_comando = v_comando || '                    left join proced     on proced.v03_codigo     = divida.v01_proced                                                      \n';
    v_comando = v_comando || '              where ( k03_tipo in (6, 13, 18, 17, 4)                                                                                        \n';
    v_comando = v_comando || '                      or (     k03_tipo in (7,16)                                                                                           \n';
    v_comando = v_comando || '                           and exists (select 1                                                                                             \n';
    v_comando = v_comando || '                                         from termo                                                                                         \n';
    v_comando = v_comando || '                                              inner join termoreparc on termoreparc.v08_parcel = termo.v07_parcel                           \n';
    v_comando = v_comando || '                                        where v07_numpre = arrecad_parc_rec.numpre) )                                                       \n';
    v_comando = v_comando || '                    )                                                                                                                       \n';
    v_comando = v_comando || '                and not exists (select 1                                                                                                    \n';
    v_comando = v_comando || '                                  from termo                                                                                                \n';
    v_comando = v_comando || '                                       inner join termodiver on termo.v07_parcel = termodiver.dv10_parcel                                   \n';
    v_comando = v_comando || '                                 where termo.v07_numpre = arrecad_parc_rec.numpre )                                                         \n';
    if v_juronaultima is true then
        v_comando = v_comando || '            and juro is false                                                                                                           \n';
    end if;
    v_comando = v_comando || '              group by recparproc.receita,                                                                                             \n';
    v_comando = v_comando || '                     arrecad_parc_rec.receit                                                                                                \n';

    v_comando = v_comando || '    union \n';

    v_comando = v_comando || '             select 3 as tipo_origem,                                                                                                       \n';
    v_comando = v_comando || '                    recparprocdiver.receita,                                                                                                \n';
    v_comando = v_comando || '                    recparprocdiver.receita as receitaori,                                                                                  \n';
    v_comando = v_comando || '                    procdiver.dv09_hist,                                                                                                    \n';
    v_comando = v_comando || '                    round(sum(valor),2) as valor,                                                                                           \n';
    v_comando = v_comando || '                    round(sum(vlrhis),2) as total_his,                                                                                      \n';
    v_comando = v_comando || '                    round(sum(vlrcor),2) as total_cor,                                                                                      \n';
    v_comando = v_comando || '                    round(sum(vlrjur),2) as total_jur,                                                                                      \n';
    v_comando = v_comando || '                    round(sum(vlrmul),2) as total_mul,                                                                                      \n';
    v_comando = v_comando || '                    round(sum(vlrdesccor),2) as total_desccor,                                                                              \n';
    v_comando = v_comando || '                    round(sum(vlrdescjur),2) as total_descjur,                                                                              \n';
    v_comando = v_comando || '                    round(sum(vlrdescmul),2) as total_descmul                                                                               \n';
    v_comando = v_comando || '               from diversos                                                                                                                \n';
    v_comando = v_comando || '                    left join (select termodiver.*                                                                                          \n';
    v_comando = v_comando || '                                 from termodiver                                                                                            \n';
    v_comando = v_comando || '                                inner join termo on dv10_parcel = v07_parcel                                                                \n';
    v_comando = v_comando || '                                                and v07_situacao = 1) as termodiver on dv05_coddiver             = dv10_coddiver            \n';
    v_comando = v_comando || '                                 left join recparprocdiver                          on recparprocdiver.procdiver = diversos.dv05_procdiver  \n';
    v_comando = v_comando || '                                inner join procdiver                                on procdiver.dv09_procdiver  = diversos.dv05_procdiver  \n';
    v_comando = v_comando || '                                inner join arrecad_parc_rec                         on diversos.dv05_numpre      = arrecad_parc_rec.numpre  \n';
    v_comando = v_comando || '              where dv10_coddiver is null                                                                                                   \n';
    v_comando = v_comando || '              group by recparprocdiver.receita,                                                                                             \n';
    v_comando = v_comando || '                       procdiver.dv09_hist                                                                                                  \n';

    v_comando = v_comando || '    union                                                                                                                                   \n';

    v_comando = v_comando || '           select tipo_origem,                                                                                                              \n';
    v_comando = v_comando || '                  receita,                                                                                                                  \n';
    v_comando = v_comando || '                  receitaori,                                                                                                               \n';
    v_comando = v_comando || '                  dv09_hist,                                                                                                                \n';
    v_comando = v_comando || '                  round(sum(valor),2) as valor,                                                                                             \n';
    v_comando = v_comando || '                  round(sum(vlrhis),2) as total_his,                                                                                        \n';
    v_comando = v_comando || '                  round(sum(vlrcor),2) as total_cor,                                                                                        \n';
    v_comando = v_comando || '                  round(sum(vlrjur),2) as total_jur,                                                                                        \n';
    v_comando = v_comando || '                  round(sum(vlrmul),2) as total_mul,                                                                                        \n';
    v_comando = v_comando || '                  round(sum(vlrdesccor),2) as total_desccor,                                                                                \n';
    v_comando = v_comando || '                  round(sum(vlrdescjur),2) as total_descjur,                                                                                \n';
    v_comando = v_comando || '                  round(sum(vlrdescmul),2) as total_descmul                                                                                 \n';
    v_comando = v_comando || '             from ( select 4 as tipo_origem,                                                                                                \n';
    v_comando = v_comando || '                           (select min(recparprocdiver.receita)                                                                             \n';
    v_comando = v_comando || '                              from termodiver                                                                                               \n';
    v_comando = v_comando || '                                   inner join diversos         on termodiver.dv10_coddiver  = dv05_coddiver                                 \n';
    v_comando = v_comando || '                                   inner join recparprocdiver  on recparprocdiver.procdiver = diversos.dv05_procdiver                       \n';
    v_comando = v_comando || '                                   inner join procdiver        on procdiver.dv09_procdiver  = diversos.dv05_procdiver                       \n';
    v_comando = v_comando || '                             where termodiver.dv10_parcel = v07_parcel ) as receita,                                                        \n';
    v_comando = v_comando || '                           (select min(recparprocdiver.receita)                                                                             \n';
    v_comando = v_comando || '                              from termodiver                                                                                               \n';
    v_comando = v_comando || '                                   inner join diversos         on termodiver.dv10_coddiver  = dv05_coddiver                                 \n';
    v_comando = v_comando || '                                   inner join recparprocdiver  on recparprocdiver.procdiver = diversos.dv05_procdiver                       \n';
    v_comando = v_comando || '                                   inner join procdiver        on procdiver.dv09_procdiver  = diversos.dv05_procdiver                       \n';
    v_comando = v_comando || '                             where termodiver.dv10_parcel = v07_parcel ) as receitaori,                                                     \n';
    v_comando = v_comando || '                           (select min(procdiver.dv09_hist)                                                                                 \n';
    v_comando = v_comando || '                              from termodiver                                                                                               \n';
    v_comando = v_comando || '                                   inner join diversos         on termodiver.dv10_coddiver  = dv05_coddiver                                 \n';
    v_comando = v_comando || '                                   inner join recparprocdiver  on recparprocdiver.procdiver = diversos.dv05_procdiver                       \n';
    v_comando = v_comando || '                                   inner join procdiver        on procdiver.dv09_procdiver  = diversos.dv05_procdiver                       \n';
    v_comando = v_comando || '                             where termodiver.dv10_parcel = v07_parcel ) as dv09_hist,                                                      \n';
    v_comando = v_comando || '                           valor,                                                                                                           \n';
    v_comando = v_comando || '                           vlrhis,                                                                                                          \n';
    v_comando = v_comando || '                           vlrcor,                                                                                                          \n';
    v_comando = v_comando || '                           vlrjur,                                                                                                          \n';
    v_comando = v_comando || '                           vlrmul,                                                                                                          \n';
    v_comando = v_comando || '                           vlrdesccor,                                                                                                      \n';
    v_comando = v_comando || '                           vlrdescjur,                                                                                                      \n';
    v_comando = v_comando || '                           vlrdescmul                                                                                                       \n';
    v_comando = v_comando || '                      from arrecad_parc_rec                                                                                                 \n';
    v_comando = v_comando || '                           inner join termo on v07_numpre = arrecad_parc_rec.numpre                                                         \n';
    v_comando = v_comando || '                           inner join ( select distinct                                                                                     \n';
    v_comando = v_comando || '                                               dv10_parcel                                                                                  \n';
    v_comando = v_comando || '                                          from termodiver ) as parcdiver  on parcdiver.dv10_parcel = termo.v07_parcel                       \n';
    v_comando = v_comando || '                  ) as diver                                                                                                                \n';
    v_comando = v_comando || '            group by tipo_origem,                                                                                                           \n';
    v_comando = v_comando || '                     receita,receitaori,                                                                                                    \n';
    v_comando = v_comando || '                     dv09_hist                                                                                                              \n';
    v_comando = v_comando || '         ) as xxx                                                                                                                           \n';
    v_comando = v_comando || 'group by tipo_origem,                                                                                                                       \n';
    v_comando = v_comando || '         receita,                                                                                                                           \n';
    v_comando = v_comando || '         receitaori                                                                                                                         \n';

    if lRaise then
      perform fc_debug('sql : '||v_comando,lRaise,false,false);
    end if;

    if lRaise then
      perform fc_debug('v_total: '||v_total,lRaise,false,false);
    end if;

    v_comando_cria = 'create temp table w_testando as ' || v_comando;
    execute v_comando_cria;

    -- tipo 3 = parcelamento de diversos
    -- tipo 4 = reparcelamento de diversos

    -- se regra for de juros na ultima, diminui o total de parcelas em 1
    if v_juronaultima is true then
       v_totalparcelas = v_totalparcelas - 1;

       if lRaise is true then
         perform fc_debug('mudando - v_total: '||v_total,lRaise,false,false);
       end if;
    end if;

    -- processa receita por receita para gerar os registros na tabela parcelas
    -- que sera utilizada posteriormente para gerar os registros na tabela arrecad
    for v_record_recpar in execute v_comando
    loop

      if v_record_recpar.tipo_origem is null then
         return '[6] - Não encontrados registros na tabela Divida para um dos debitos que esta sendo parcelado.';
      end if;

      if v_record_recpar.receita is null then
        return '[7] - Receita de parcelamento nao configurada para a procedencia';
      end if;

      -- se origem for divida ativa, soma na variavel v_totaldivida
      if v_record_recpar.tipo_origem = 1 then
          v_totaldivida = v_totaldivida + v_record_recpar.valor;
      end if;

      if lRaise is true then
          perform fc_debug('tipo_origem: '||v_record_recpar.tipo_origem||' - receita: '||v_record_recpar.receita||' - receitaoriginal: '||v_record_recpar.receitaori||' - hist: '||v_record_recpar.k00_hist||' - valor: '||v_record_recpar.valor||' - total_cor: '||v_record_recpar.total_cor,lRaise,false,false);
      end if;

      -- calcula entrada proporcional ao valor desta receita
      -- regra de tres normal em relacao percentual da entrada do registro atual em relacao ao total do parcelamento
      -- se for o caso de ter apenas uma receita em processamento, essa variavel vai ser igual ao valor da entrada
      v_ent_prop = v_record_recpar.valor * (v_entrada / v_total);
      v_total_liquido = v_record_recpar.total_cor + v_record_recpar.total_jur + v_record_recpar.total_mul - v_record_recpar.total_desccor - v_record_recpar.total_descjur - v_record_recpar.total_descmul;

      if lRaise is true then
        perform fc_debug('xxxxxxxxxxxxx: receita: '||v_record_recpar.receita||' - valor: '||v_record_recpar.valor||' - entrada proporcional: '||v_ent_prop||' - valor: '||v_record_recpar.valor||' - total: '||v_total_liquido,lRaise,false,false);
        perform fc_debug(' ',lRaise,false,false);
        perform fc_debug('========== receita: '||v_record_recpar.receita,lRaise,false,false);
        perform fc_debug(' ',lRaise,false,false);
      end if;

      -- processa parcela por parcela
      for v_parcela in 1..v_totalparcelas
      loop

        -- variavel do valor da parcela recebe o valor da receita deste registro / valor total do parcelamento
        -- que na pratica seria a proporcionalidade deste registro em relacao ao total do parcelamento
        v_valparc = v_record_recpar.valor / v_total;

        if lRaise is true then
            perform fc_debug('   v_valparc: '||v_valparc||' - v_total: '||v_total||' - valor: '||v_record_recpar.valor||' - receit: '||v_record_recpar.receita||' - entrada: '||v_entrada,lRaise,false,false);
        end if;

        if v_parcela = 1 then
            -- se parcela igual a 1, entao valor parcela e igual ao valor da entrada * valor da proporcionalidade
            -- deste registro em relacao ao total do parcelamento
            v_valparc = v_entrada * v_valparc;
        else
            -- se nao for a parcela 1 entao
            -- valor da parcela recebe o valor da parcela definido pelo usuario na CGF * valor da proporcionalidade
            -- deste registro em relacao ao total do parcelamento
            v_valparc = v_valorparcelanew * v_valparc;
        end if;

        --v_valparc = round(v_valparc,2);

        if lRaise is true then
            perform fc_debug('   000 = parcela: '||v_parcela||' - receita: '||v_record_recpar.receita||' - valor: '||v_valparc||' - v_valorparcelanew: '||v_valorparcelanew||' - receitaori: '||v_record_recpar.receitaori,lRaise,false,false);
        end if;

        v_calcula_valprop = v_record_recpar.valor / v_total;
        v_teste           = round(v_record_recpar.valor / v_total,2);

        if v_teste <= 0 then

          if lRaise is true then
            perform fc_debug('valor: '||v_record_recpar.valor||' - v_total: '||v_total||' - v_teste: '||v_teste||' - parcela: '||v_parcela||' - receita: '||v_record_recpar.receita||' - v_calcula_valprop: '||v_calcula_valprop,lRaise,false,false);
          end if;
        end if;

        if lRaise is true then
          perform fc_debug('v_valparc: '||v_valparc||' - valor: '||v_record_recpar.valor||' - total_his: '||v_record_recpar.total_his||' - total: '||v_total,lRaise,false,false);
        end if;

        v_calcula_valor   = v_record_recpar.valor;
        v_calcula_his     = round( v_valparc / v_record_recpar.valor * v_record_recpar.total_his ,2);
        v_calcula_cor     = round( v_valparc / v_record_recpar.valor * v_record_recpar.total_cor ,2);
        v_calcula_jur     = round( v_valparc / v_record_recpar.valor * v_record_recpar.total_jur ,2);
        v_calcula_mul     = round( v_valparc / v_record_recpar.valor * v_record_recpar.total_mul ,2);
        v_calcula_desccor = round( v_valparc / v_calcula_valor * v_record_recpar.total_desccor ,2);
        v_calcula_descjur = round( v_valparc / v_calcula_valor * v_record_recpar.total_descjur ,2);
        v_calcula_descmul = round( v_valparc / v_calcula_valor * v_record_recpar.total_descmul ,2);

        if lRaise then
          perform fc_debug('v_calcula_his: '||v_calcula_his||' - v_valparc: '||v_valparc||' - v_calcula_valor: '||v_calcula_valor||' - total_desccor: '||v_record_recpar.total_desccor,lRaise,false,false);
        end if;

        if v_valparc > 0 then

          if round(v_valparc,2) > 0 then

            lIncluiEmParcelas = true;

          else

            perform * from parcelas where receit = v_record_recpar.receita;

            if found then
              lIncluiEmParcelas = false;
            else
              lIncluiEmParcelas = true;
            end if;

          end if;

          if lIncluiEmParcelas is true then

            -- insere valores calculados na tabela parcelas
            execute 'insert into parcelas values (' || v_parcela                                 || ',' ||
                                                       v_record_recpar.receita                   || ',' ||
                                                       v_record_recpar.receitaori                || ',' ||
                                                       v_record_recpar.k00_hist                  || ',' ||
                                                       v_valparc                                 || ',' ||
                                                       v_calcula_valprop                         || ',' ||
                                                       v_calcula_his                             || ',' ||
                                                       v_calcula_cor                             || ',' ||
                                                       v_calcula_jur                             || ',' ||
                                                       v_calcula_mul                             || ',' ||
                                                       v_calcula_desccor                         || ',' ||
                                                       v_calcula_descjur                         || ',' ||
                                                       v_calcula_descmul                         ||
                                                       ');';

          else

            execute 'update parcelas set '   ||
                    '  valor   = valor   + ' || v_valparc         ||
                    ', valprop = valprop + ' || v_calcula_valprop ||
                    ', valhis  = valhis  + ' || v_calcula_his     ||
                    ', valcor  = valcor  + ' || v_calcula_cor     ||
                    ', valjur  = valjur  + ' || v_calcula_jur     ||
                    ', valmul  = valmul  + ' || v_calcula_mul     ||
                    ', descor  = descor  + ' || v_calcula_desccor ||
                    ', descjur = descjur + ' || v_calcula_descjur ||
                    ', descmul = descmul + ' || v_calcula_descmul ||
                    ' where receit = ' || v_record_recpar.receita;

          end if;

        end if;

      end loop;

    end loop;

    -- se regra for de juros na ultima
    if v_juronaultima is true then

        if lRaise is true then
          perform fc_debug('processando ultima... diferenca: '||(v_totalcomjuro - v_total),lRaise,false,false);
        end if;

        -- soma 1 na variavel do total de parcelas
        v_totalparcelas = v_totalparcelas + 1;

        -- gera comando para agrupar receita por receita somando o valor
        v_comando =              ' select arrecad_parc_rec. ';
        v_comando = v_comando || '        receit as receita, ';
        v_comando = v_comando || '            sum(arrecad_parc_rec.valor) as valor ';
        v_comando = v_comando || '   from arrecad_parc_rec ';
        v_comando = v_comando || '  where juro is true ';
        v_comando = v_comando || '  group by arrecad_parc_rec.receit ';

        select v04_histjuros
          from pardiv
          into v_histjuro;
        if v_histjuro is null then
          v_histjuro = 1;
        end if;

        for v_record_recpar in execute v_comando
        loop

          v_valorinserir = round(v_record_recpar.valor,2);

          if lRaise is true then
             perform fc_debug('111 = inserindo diferenca: '||v_valorinserir||' - receita: '||v_record_recpar.receita||' - valor: '||v_record_recpar.valor.lRaise,false,false);
          end if;

          execute 'insert into parcelas values (' || v_totalparcelas          || ',' ||
                                                     v_record_recpar.receita  || ',' ||
                                                     v_record_recpar.receita  || ',' ||
                                                     v_histjuro               || ',' ||
                                                     v_valorinserir           || ',' ||
                                                     (v_valorinserir) / v_totalcomjuro ||
                                                     ');';

        end loop;

        v_total = v_totalcomjuro;

    end if;

    if lRaise is true then
        perform fc_debug('saindo do tipo 5...',lRaise,false,false);
    end if;

    if lRaise is true then
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug('-',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug('terminou de gravar na tabela parcelas...',lRaise,false,false);
    end if;

    update parcelas set valor   = w_testando.valor,
                        valhis  = w_testando.total_his,
                        valcor  = w_testando.total_cor,
                        valjur  = w_testando.total_jur,
                        valmul  = w_testando.total_mul,
                        descor  = w_testando.total_desccor,
                        descjur = w_testando.total_descjur,
                        descmul = w_testando.total_descmul
     from w_testando
    where receit = w_testando.receita
      and parcelas.valor = 0;

        -- calcula a maior parcela e a soma do valor dos registros da tabela parcelas
    select max(parcela),
           sum(valor)
      from parcelas
      into v_totpar, v_somar;

    if lRaise is true then
      perform fc_debug('total de parcelas: '||v_totpar||' - v_somar: '||v_somar,lRaise,true,true);
    end if;

        -- testa se ocorreu alguma inconsistencia
    if v_totpar = 0 or v_totpar is null then
      return '[8] - Erro ao gerar parcelas... provavelmente falta recparproc...';
    end if;

    select round(sum(valor),2)
      into v_totalliquido
      from parcelas;

    if lRaise is true then
      perform fc_debug('v_totalliquido: '||v_totalliquido,lRaise,true,true);
    end if;

    --raise notice 'trocando total (%) por total_liquido (%)', v_total, v_totalliquido;
    --v_total = v_totalliquido;

        -- se for
        -- 6  = parcelamento de divida
        -- 16 = parcelamento de inicial
        -- 17 = parcelamento de melhorias
        -- 13 = inicial do foro
    if v_tipo in (6,16,17,13) then
            -- conta a quantidade de parcelamentos
      select count(v07_parcel)
        into v_quantparcel
        from (select distinct
                     v07_parcel
                from termo
               inner join numpres_parc on termo.v07_numpre = numpres_parc.k00_numpre) as x;
      if v_quantparcel is null then
        return '[9] - Parcelamento nao encontrado pelo numpre';
      end if;

            -- registra o codigo do parcelamento
      select v07_parcel
        into v_termo_ori
        from termo
       inner join numpres_parc on termo.v07_numpre = numpres_parc.k00_numpre
      limit 1;

    end if;

    -- recebe o codigo do novo parcelamento
    select nextval('termo_v07_parcel_seq') into v_termo;

    -- recebe o numpre do novo parcelamento
    select nextval('numpref_k03_numpre_seq') into v_numpre;

    if lRaise is true then
      perform fc_debug('termo '||v_termo,lRaise,false,false);
      perform fc_debug('numpre '||v_numpre,lRaise,false,false);
    end if;

        -- se for reparelamento pega todos os parcelamentos atuais e troca a situacao para 3(inativo)
    if lParcParc then

      for v_record_origem in
        select distinct v07_parcel
          from termo
         inner join numpres_parc on termo.v07_numpre = numpres_parc.k00_numpre
      loop
                -- inativa o parcelamento
        update termo set v07_situacao = 3
         where v07_parcel = v_record_origem.v07_parcel;

      end loop;
    end if;

    --if lSeparaJuroMulta and 1=2 then
      /**
       *  Funcao fc_SeparaJuroMulta()
       *
       *    Esta funcao separa o valor do juros e da multa
       *    em registros separados, lancando valor na receita de juro e multa
       *    configurada na tabrec.
       */
      --select * from fc_SeparaJuroMulta() into rSeparaJurMul;

    --end if;

    -- registra o ano do vencimento da segunda parcela
    select extract (year from v_segvenc) into v_anovenc;

    -- registra o mes do vencimento da segunda parcela
    select extract (month from v_segvenc) into v_mesvenc;

    if lRaise is true then
      perform fc_debug('v_anovenc: '||v_anovenc||' - v_mesvenc: '||v_mesvenc,lRaise,false,false);
    end if;

    v_somar = 0;

    -- soma o valor total da tabela parcelas, apenas para conferencia
    for v_record_recpar in select parcela,
                                  receit,
                                  valor
                             from parcelas
    loop
      v_somar = v_somar + v_record_recpar.valor;
      if lRaise is true then
        perform fc_debug('parcela: '||v_record_recpar.parcela||' - receita: '||v_record_recpar.receit||' - valor: '||v_record_recpar.valor,lRaise,false,false);
      end if;
    end loop;

    if lRaise is true then
      perform fc_debug('v_somar: '||v_somar,lRaise,false,false);
    end if;

        -- exibe os valores da tabela parcelas agrupado por receita, apenas para conferencia
    for v_record_recpar in select receit,
                                  round(sum(valor),2) as valor,
                                  round(sum(valhis+valcor+valjur+valmul-descor-descjur-descmul),2) as sum
                             from parcelas
                            group by receit
    loop
      if lRaise is true then
        perform fc_debug('valor da receita: '||v_record_recpar.receit||' - liquido: '||v_record_recpar.sum||' - valor: '||v_record_recpar.valor,lRaise,false,false);
      end if;
    end loop;

    -- varre a tabela parcelas por receita para gravar os registros no arrecad
    -- existe uma tabela chamada totrec que recebe os valores ja processados e armazena por receita

    -- verifica se tem registro na tabela de configuracao da receita forcada como receita de destino

    for v_record_recpar in select distinct
                                  receitaori
                             from parcelas
    loop

      select case
               when coalesce( (select count(*)
                                 from recreparcori a
                                      inner join recreparcarretipo on k72_codigo = a.k70_codigo
                                where a.k70_recori = recreparcori.k70_recori ),0) = 0
                then k71_recdest
                else case
                       when coalesce( ( select count(*)
                                          from recreparcarretipo
                                         where k72_codigo = recreparcori.k70_codigo
                                           and k72_arretipo = v_tiponovo ),0) = 0
                       then null
                       else k71_recdest
                end
             end as destino
        into v_recdestino
        from recreparcori
             inner join recreparcdest on k70_codigo = k71_codigo
       where k70_recori = v_record_recpar.receitaori
         and v_totparc >= k70_vezesini
         and v_totparc <= k70_vezesfim
         and
         (
           (     ( select count(*)
                     from recreparcori a
                          inner join recreparcarretipo on k72_codigo = a.k70_codigo
                    where a.k70_recori = recreparcori.k70_recori) = 0
             and ( select count(*)
                     from recreparcarretipo
                    where k72_codigo = recreparcori.k70_codigo
                      and k72_arretipo = v_tiponovo) = 0
           )
          or
          (     select count(*)
                  from recreparcori a
                 inner join recreparcarretipo on k72_codigo = a.k70_codigo
                 where a.k70_recori = recreparcori.k70_recori) > 0
            and (select count(*)
                   from recreparcarretipo
                  where k72_codigo = recreparcori.k70_codigo
                    and k72_arretipo = v_tiponovo) > 0
         );


       if lRaise is true or 1=1 then
         perform fc_debug('v_recdestino: '||v_recdestino||' - receitaori: '||v_record_recpar.receitaori||' - v_totparc: '||v_totparc||' - v_tiponovo: '||v_tiponovo,lRaise,false,false);
       end if;

       if v_recdestino is not null or v_recdestino <> 0 then
         execute ' update parcelas set receit = ' || v_recdestino || ' where ' ||
                 ' receitaori = ' || v_record_recpar.receitaori || ';';
       end if;

    end loop;

    create temp table w_base_parcelas as
      select parcela,
             receit,
             min(hist)                as hist,
             round(sum(valor),2)      as valor,
             sum(valprop)             as valprop,
             round(sum(valhis),2)     as valhis,
             round(sum(valcor),2)     as valcor,
             round(sum(valjur),2)     as valjur,
             round(sum(valmul),2)     as valmul,
             round(sum(descor),2)     as descor,
             round(sum(descjur),2)    as descjur,
             round(sum(descmul),2)    as descmul
        from parcelas
       group by parcela, receit
       order by receit, parcela;

    if lRaise is true then
      perform fc_debug('total de parcelas: '||v_totpar||' - v_somar: '||v_somar,lRaise,false,false);
    end if;

    if lRaise is true then
        perform fc_debug(' ',lRaise,false,false);
        perform fc_debug(' ',lRaise,false,false);
        perform fc_debug(' ',lRaise,false,false);
        perform fc_debug(' ',lRaise,false,false);
        perform fc_debug(' ',lRaise,false,false);
    end if;

    for v_record_recpar in  select *
                              from w_base_parcelas
                             order by parcela, receit
    loop

      if lRaise is true then
        perform fc_debug('   inicio do loop... parcela: '||v_record_recpar.parcela||' - receita: '||v_record_recpar.receit||' - v_totalparcelas: '||v_totalparcelas||' - valor: '||v_record_recpar.valor||' - valprop: '||v_record_recpar.valprop,lRaise,false,false);
      end if;

      lParcelaZerada=false;

            -- conta o total de parcelas desta receita
      select max(parcela)
        into v_totparcdestarec
        from parcelas
       where receit = v_record_recpar.receit;

            -- soma o que ja foi inserido na tabela totrec da receita do registro atual
      select coalesce(sum(valor),0) into v_totateagora from totrec where receit = v_record_recpar.receit;
            -- soma o total do valor da tabela parcelas da receita do registro atual
      -- V E R I F I C A R
      select round(sum(valor+valcor+valjur+valmul),2) into v_calcular from parcelas where receit = v_record_recpar.receit;

      if lRaise is true then
        perform fc_debug('v_calcular: '||v_calcular,lRaise,false,false);
      end if;

      if lRaise is true then
        perform fc_debug(' ',lRaise,false,false);
        perform fc_debug('total desta receita: '||v_record_recpar.receit||' - ate agora: '||v_totateagora,lRaise,false,false);
        perform fc_debug(' ',lRaise,false,false);
      end if;

            -- registra o valor da receita do registro atual
      v_valparc = round(v_record_recpar.valor,2);

      -- se for a ultima parcela
      if v_record_recpar.parcela = v_totalparcelas then

                -- se for juros na ultima
        if v_juronaultima is true then
                    -- valor da parcela recebe exatamente o valor registrado na receita do registro atual
          v_valparc = v_valparc;
        else

          if lRaise is true then
            perform fc_debug('U L T I M A... - RECEITA: '||v_record_recpar.receit,lRaise,false,false);
            perform fc_debug('v_totalparcelas: '||v_totalparcelas||' - v_valparc: '||v_valparc||' - v_entrada: '||v_entrada||' - v_total: '||v_total||' - valprop: '||v_record_recpar.valprop,lRaise,false,false);
          end if;

          if lRaise is true then
            perform fc_debug('total desta receita: '||v_record_recpar.receit||' - ate agora: '||v_totateagora,lRaise,false,false);
          end if;

                    -- saldo e calculado com
                    -- (o total de parcelas - 2) * valor registrado na receita do registro atual
          --v_saldo = round((v_totalparcelas - 2) * ( v_valparc + v_record_recpar.valcor + v_record_recpar.valjur + v_record_recpar.valmul),2);
          v_saldo = round((v_totalparcelas - 2) * ( v_valparc ),2);

          if lRaise is true then
            perform fc_debug('Saldo Atual: '||v_saldo,lRaise,false,false);
          end if;

                    -- saldo eh calculado com
                    -- saldo calculado + ( entrada * valor proporcional dessa receita em relacao ao total do parcelamento )
          v_saldo = round(v_saldo + ( v_entrada * v_record_recpar.valprop ),2);

          if lRaise is true then
            perform fc_debug('111 - v_saldo: '||v_saldo||' - v_totateagora: '||v_totateagora||' - v_calcular: '||v_calcular,lRaise,false,false);
          end if;

          if lRaise is true then
            perform fc_debug('totateagora: '||v_totateagora||' - total: '||v_total||' - valprop: '||v_record_recpar.valprop||' - saldo: '||v_saldo||' - rec: '||v_record_recpar.receit||' - parc: '||v_record_recpar.parcela||' - hist: '||v_record_recpar.hist,lRaise,false,false);
          end if;

                    -- se total ate agora for maior ou igual ao total do parcelamento * valor proporcional dessa receita em relacao ao total do parcelamento
          if round(v_totateagora,2) >= round(v_total * v_record_recpar.valprop,2) then
            if lRaise is true then
              perform fc_debug('v_totateagora: '||v_totateagora||' - v_total: '||v_total||' - valprop: '||v_record_recpar.valprop, lRaise,false,false);
              perform fc_debug('passou na ultima...',lRaise,false,false);
            end if;
                        -- valor da parcela recebe zero
            v_valparc = 0;
            lParcelaZerada=true;
            continue;

                    -- se total ate agora for menor ao total do parcelamento * valor proporcional dessa receita em relacao ao total do parcelamento
          else

            if lRaise is true then
              perform fc_debug('nao passou na ultima... v_total: '||v_total||' - v_saldo: '||v_saldo||' - prop: '||v_record_recpar.valprop,lRaise,false,false);
            end if;

                        -- valor da parcela recebe: (total do parcelamento * valor proporcional dessa receita em relacao ao total do parcelamento) - saldo calculado
            v_valparc = round(round((v_total * v_record_recpar.valprop),2) - v_saldo,2);

            if lRaise is true then
              perform fc_debug('v_valparc: '||v_valparc,lRaise,false,false);
            end if;

                        -- se valor da parcela for menor que zero
            if v_valparc < 0 then
                            -- valor da parcela recebe
                            -- (total do parcelamento * valor proporcional dessa receita em relacao ao total do parcelamento) - saldo - valor da parcela
              v_valparc = round((v_total * v_record_recpar.valprop) - v_saldo,2)::float8 - round(v_valparc,2)::float8;
              if lRaise is true then
                perform fc_debug(' ',lRaise,false,false);
                perform fc_debug('t e s t e: '||v_valparc,lRaise,false,false);
                perform fc_debug(' ',lRaise,false,false);
              end if;
            end if;

            --v_valparc := ( v_valparc - ( v_record_recpar.valcor + v_record_recpar.valjur + v_record_recpar.valmul ) );

          end if;

          if lRaise is true then
            perform fc_debug('Valor ultima parcela : '||v_valparc,lRaise,false,false);
          end if;

                    -- resto recebe valor da parcela + total ate agora
          v_resto = v_valparc + v_totateagora;

          if lRaise is true then
            perform fc_debug('222 - v_saldo: '||v_saldo||' - totateagora: '||v_resto||' - v_valparc: '||v_valparc||' - v_calcular: '||v_calcular,lRaise,false,false);
          end if;

        end if;

            -- se nao for a ultima parcela
      else

        if lRaise is true then
          perform fc_debug(' ',lRaise,false,false);
          perform fc_debug(' n a o   e   a   u l t i m a ',lRaise,false,false);
          perform fc_debug(' ',lRaise,false,false);
        end if;

                -- se for juros na ultima
        if v_juronaultima is true then

                  -- se eh a penultima parcela
          if v_record_recpar.parcela = (v_totalparcelas - 1) then

            if lRaise is true then
              perform fc_debug('nessa',lRaise,false,false);
            end if;

          end if;

        end if;

        if lRaise is true then
          perform fc_debug('v_totalparcelas: '||v_totalparcelas||' - v_valparc: '||v_valparc||' - v_entrada: '||v_entrada||' - valprop: '||v_record_recpar.valprop||' - v_total: '||v_total,lRaise,false,false);
        end if;

                -- saldo recebe (total de parcelas - 2) * valor da parcela
        -- V E R I F I C A R
        v_saldo = round((v_totalparcelas - 2) * ( v_valparc + v_record_recpar.valcor + v_record_recpar.valjur + v_record_recpar.valmul ),2);

                -- saldo recebe: saldo + (entrada * valor proporcional dessa receita em relacao ao total do parcelamento) - saldo - valor da parcela)
        v_saldo = round(v_saldo + (v_entrada * v_record_recpar.valprop),2);

        if lRaise is true then
          perform fc_debug('v_valparc: '||v_valparc,lRaise,false,false);
          perform fc_debug('parcela: '||v_record_recpar.parcela||' - v_valparc: '||v_valparc||' - saldo: '||v_saldo||' - resto: '||v_resto,lRaise,false,false);
        end if;

                -- se total ate agora for maior que total da receita do registro atual
        if round(v_totateagora,2) > round(v_calcular,2) then

          -- (desativado) v_valparc = round(v_saldo - round((v_record_recpar.parcela - 1) * v_valparc,2)::float8,2);
                    -- valor da parcela recebe zero
          v_valparc = 0;
          if lRaise is true then
            perform fc_debug('Valor da parcela recebendo ZERO valparc : '||v_valparc,lRaise,false,false);
            perform fc_debug('111111111111111111111',lRaise,false,false);
          end if;

                -- se total ate agora for menor ou igual que total da receita do registro atual
        else

                    -- valor ate agora recebe: parcela * valor da parcela
          -- V E R I F I C A R
          v_vlrateagora = round(v_record_recpar.parcela * ( v_valparc + v_record_recpar.valcor + v_record_recpar.valjur + v_record_recpar.valmul ),2);

          if lRaise is true then
            perform fc_debug('v_vlrateagora: '||v_vlrateagora||' - v_valparc: '||v_valparc,lRaise,false,false);
          end if;

                    -- resto recebe: (valor total do parcelamento * valor proporcional dessa receita em relacao ao total do parcelamento) - saldo
          v_resto = round(round(v_total * v_record_recpar.valprop,2) - round(v_saldo,2),2);

          if lRaise is true then
            perform fc_debug('parcela: '||v_record_recpar.parcela||' - v_valparc: '||v_valparc||' - saldo: '||v_saldo||' - resto: '||v_resto,lRaise,false,false);
          end if;

          if lRaise is true then
            perform fc_debug('v_totateagora: '||v_totateagora||' - v_valparc: '||v_valparc||' - v_calcular: '||v_calcular,lRaise,false,false);
          end if;

                    -- se (total ate agora + valor da parcela) for maior que total da receita do registro atual
          if round(round(v_totateagora,2) + round(v_valparc,2),2) > round(v_calcular,2) then
                        -- valor da parcela recebe: total da receita do registro atual - total ate agora
            v_valparc = round( round(v_calcular,2) - round(v_totateagora,2),2 );
            if lRaise is true then
              perform fc_debug('22222222222',lRaise,false,false);
            end if;
          end if;

        end if;

      end if;

      if lRaise is true then
        perform fc_debug('   ...',lRaise,false,false);
      end if;

      -- se parcela = 1
      if v_record_recpar.parcela = 1 then
                -- vencimento igual ao vencimento da entrada especificada na CGF
        v_vcto = v_privenc;
                -- valor da parcela = entrada * proporcionalidade
        if lRaise is true then
          perform fc_debug('v_entrada: '||v_entrada||' - valprop: '||v_record_recpar.valprop||' - valcor: '||v_record_recpar.valcor||' - valju: '||v_record_recpar.valjur||' - valmul: '||v_record_recpar.valmul,lRaise,false,false);
        end if;

        if lRaise is true then
          perform fc_debug('   1 === v_valparc: '||v_valparc||' - v_entrada: '||v_entrada||' - valprop: '||v_record_recpar.valprop, lRaise, false,false);
        end if;
        v_valparc = round( ( v_entrada ) * v_record_recpar.valprop,2);
        if lRaise is true then
          perform fc_debug('   2 === v_valparc: '||v_valparc,lRaise, false,false);
        end if;

      elsif v_record_recpar.parcela = 2 then
              -- vencimento = vencimento da segunda parcela especificada na CGF
        v_vcto = v_segvenc;
      else

                -- soma meses para calcular vencimento baseado na data de vencimento da parcela 2
        execute 'truncate vcto';
        v_comando = 'insert into vcto select ' || '''' || to_char(v_segvenc,'yyyy') || '-' || trim(to_char(v_segvenc, 'mm')) || '-' || trim(to_char(v_segvenc, 'dd')) || '''' || '::date' || '+' || '''' || v_record_recpar.parcela - 3 || ' months' || '''' || '::interval';
        execute v_comando;

        select extract (month from data),
               extract (year from data)
        from vcto
        into v_mesvenc,
        v_anovenc;

        if lRaise is true then
          perform fc_debug('',lRaise,false,false);
          perform fc_debug('v_mesvenc: '||v_mesvenc||' - parcela: '||v_record_recpar.parcela,lRaise,false,false);
          perform fc_debug('',lRaise,false,false);
        end if;

                -- se mes for 12 (dezembro)
        if to_number(to_char(v_segvenc,'mm'), '999') = 12 then
                    -- proximo mes = 1 (janeiro)
          v_proxmessegvenc = 1;
        else
                    -- soma mes
          v_proxmessegvenc = to_number(to_char(v_segvenc,'mm'), '999') + 1;
        end if;

                -- faz o mes ficar sempre com 2 digitos
        if v_proxmessegvenc < 10 then
          v_proxmessegvenc_c = '0' || trim(to_char(v_proxmessegvenc, '99'));
        else
          v_proxmessegvenc_c = trim(to_char(v_proxmessegvenc, '999'));
        end if;

                -- registra o dia do proximo vencimento especifidada na CGF
        v_dia = v_diaprox;

                -- soma 1 no mes de vencimento
        v_mesvenc = v_mesvenc + 1;
        if lRaise is true then
          perform fc_debug('   executando vcto... v_segvenc: '||v_segvenc||' - v_diaprox: '||v_diaprox||' - v_dia: '||v_dia||' - v_mesvenc: '||v_mesvenc||' - parc: '||v_record_recpar.parcela,lRaise,false,false);
        end if;

                -- se ultrapassar dezembro, passa para janeiro do ano seguinte
        if v_mesvenc = 13 then
          v_mesvenc = 1;
          v_anovenc = v_anovenc + 1;
        end if;

        v_mesvencprox = v_mesvenc + 1;
        v_anovencprox = v_anovenc;

                -- se ultrapassar dezembro, passa para janeiro do ano seguinte
        if v_mesvencprox = 13 then
          v_mesvencprox = 1;
          v_anovencprox = v_anovencprox + 1;
        end if;

        if lRaise is true then
          perform fc_debug('quase... v_mesvencprox: '||v_mesvencprox||' - v_anovencprox: '||v_anovencprox,lRaise,false,false);
        end if;
                -- calcula ultimo dia de fevereiro
        v_ultdiafev_c   = trim(to_char(v_anovencprox,'99999')) || '-' || trim(to_char(v_mesvencprox, '999')) || '-01';
        if lRaise is true then
          perform fc_debug('   1 - v_ultdiafev_c: '||v_ultdiafev_c,lRaise,false,false);
        end if;
                -- calcula ultimo dia de fevereiro
        v_ultdiafev_d   = trim(v_ultdiafev_c)::date - 1;

        if lRaise is true then
          perform fc_debug('   2 - v_ultdiafev_d: '||v_ultdiafev_d,lRaise,false,false);
        end if;
                -- calcula ultimo dia de fevereiro
        v_ultdiafev = to_number(to_char(v_ultdiafev_d, 'dd'), '999');

                -- testa se dia e valido nos meses
        if v_dia = 31 and v_mesvenc in (4, 6, 9, 11) then
          v_dia = 30;
          if lRaise is true then
            perform fc_debug('mudando 1',lRaise,false,false);
          end if;
        elsif v_dia >= 30 and v_mesvenc in (2) then
          v_dia = 28;
          if lRaise is true then
            perform fc_debug('mudando 2',lRaise,false,false);
          end if;
        end if;

        if lRaise is true then
          perform fc_debug('mesvenc: '||v_mesvenc||' - dia: '||v_dia,lRaise,false,false);
        end if;

                -- calcula se vencimento e correto
        if v_mesvenc = 2 and v_dia >= 28 then
          if lRaise is true then
            perform fc_debug('fevereiro...',lRaise,false,false);
          end if;
          v_dia = v_ultdiafev;
        end if;

                -- calcula vencimento
        execute 'truncate vcto';
        v_comando = 'insert into vcto select ' || '''' || to_char(v_anovenc,'99999') || '-' || trim(trim(to_char(v_mesvenc, '999'))) || '-' || trim(to_char(v_dia, '999')) || '''' || '::date';
        execute v_comando;
        select data from vcto into v_vcto;
        if lRaise is true then
          perform fc_debug('   fim vcto... '||v_vcto,lRaise,false,false);
        end if;

      end if;

      if lRaise is true then
        perform fc_debug('          inserindo em totrec a parcela '||v_record_recpar.parcela||' no valor de '||v_valparc,lRaise,false,false);
      end if;

            -- insere na tabela totrec o registro atual com o valor da parcela
      execute 'insert into totrec values (' || v_record_recpar.receit || ', ' || v_record_recpar.parcela || ', ' || v_valparc || ')';

      if lRaise is true then
        perform fc_debug('1 - parcela: '||v_record_recpar.parcela||' - valor: '||v_valparc,lRaise,false,false);
      end if;

      if lRaise is true then
        perform fc_debug('k00_numcgm: '||v_cgmpri||' - k00_receit: '||v_record_recpar.receit||' - k00_hist: '||v_record_recpar.hist||' - k00_valor: '||v_valparc||' - k00_dtvenc: '||v_vcto||' - k00_numpre: '||v_numpre||' - k00_numpar: '||v_record_recpar.parcela||' - k00_numtot: '||v_totalparcelas||' - k00_tipo: '||v_tiponovo,lRaise,false,false);
      end if;

      v_recdestino = v_record_recpar.receit;

      if lRaise is true then
        perform fc_debug('   no arrecad... val: '||v_valparc||' - recdest: '||v_recdestino||' - vcto: '||v_vcto||' - parcela: '||v_record_recpar.parcela,lRaise,false,false);
      end if;

      if v_valparc < 0 then
        return '[10] - valor da parcela ' || v_record_recpar.parcela || ' menor que zero: ' || v_valparc;
      elsif v_valparc = 0 then
        return '[11] - valor da parcela ' || v_record_recpar.parcela || ' zerada: ' || v_valparc;
      end if;

            -- se valor da parcela maior que zero
            -- insere no arrecad

      if lRaise is true then
        perform fc_debug('k00_numpre : '||v_numpre||' k00_numpar : '||v_record_recpar.parcela||' k00_receit : '||v_recdestino||' k00_valor : '||v_valparc,lRaise,false,false);
      end if;

      lGravaArrecad = true;

      if v_valparc > 0 then

        if lSeparaJuroMulta = 1 then

          if lRaise is true then

             perform fc_debug('',lRaise,false,false);
             perform fc_debug('+--------------------------------------------------------------------------------------------',lRaise,false,false);
             perform fc_debug('|                                                                                            ',lRaise,false,false);
             perform fc_debug('|      Processando dados da composicao do Numpre: '||v_numpre||' Parcela: '||v_record_recpar.parcela||' Receita: '||v_recdestino,lRaise,false,false);
             perform fc_debug('|                                                                                            ',lRaise,false,false);
             perform fc_debug('+--------------------------------------------------------------------------------------------',lRaise,false,false);
             perform fc_debug('',lRaise,false,false);

          end if;


          iSeqArrecKey := nextval('arreckey_k00_sequencial_seq');

          if lRaise is true then
             perform fc_debug('     ',lRaise,false,false);
             perform fc_debug('     1. G E R A N D O  D A D O S  N A  T A B E L A  ARRECKEY  P A R A  A  P A R C E L A: '||v_record_recpar.parcela,lRaise,false,false);
             perform fc_debug('        Sequencial: '||iSeqArrecKey||' Numpre: '||v_numpre||' Numpar: '||v_record_recpar.parcela||' Receita: '||v_recdestino||' Historico: '||v_record_recpar.hist||' Tipo: '||v_tiponovo,lRaise,false,false);
             perform fc_debug('',lRaise,false,false);
          end if;

          insert into arreckey ( k00_sequencial,
                                 k00_numpre,
                                 k00_numpar,
                                 k00_receit,
                                 k00_hist,
                                 k00_tipo )
                        values ( iSeqArrecKey,
                                 v_numpre,
                                 v_record_recpar.parcela,
                                 v_recdestino,
                                 v_record_recpar.hist,
                                 v_tiponovo
                               );


          select round(sum(valhis),2),
                 round(sum(valcor-descor-valhis),2),
                 round(sum(valjur-descjur),2),
                 round(sum(valmul-descmul),2)
            into nVlrTotalHistorico,
                 nVlrTotalCorrecao,
                 nVlrTotalJuros,
                 nVlrTotalMulta
            from w_base_parcelas
           where receit = v_record_recpar.receit;

          select round(sum(vlrdesccor),2),
                 round(sum(vlrdescjur),2),
                 round(sum(vlrdescmul),2)
            into nVlrTotalDescontoCorrigido,
                 nVlrTotalDescontoJuros,
                 nVlrTotalDescontoMulta
            from arrecad_parc_rec;

          if lRaise is true then
            perform fc_debug('     ',lRaise,false,false);
            perform fc_debug('     2. C A L C U L A N D O  V A L O R E S  D A  C O M P O S I C A O  D A  P A R C E L A',lRaise,false,false);
            perform fc_debug('     ',lRaise,false,false);
            perform fc_debug('        Valores Totais do Debito:  ',lRaise,false,false);
            perform fc_debug('        Total Historico(nVlrTotalHistorico) ..: '||nVlrTotalHistorico,lRaise,false,false);
            perform fc_debug('        Total Correcao(nVlrTotalCorrecao) ....: '||nVlrTotalCorrecao,lRaise,false,false);
            perform fc_debug('        Total Juros(nVlrTotalJuros) ..........: '||nVlrTotalJuros,lRaise,false,false);
            perform fc_debug('        Total Multa(nVlrTotalMulta) ..........: '||nVlrTotalMulta,lRaise,false,false);
            perform fc_debug('        v_somar(???): '||v_somar,lRaise,false,false);
            perform fc_debug('     ',lRaise,false,false);
          end if;

          v_historico_compos = v_record_recpar.valhis;
          v_correcao_compos  = ( v_record_recpar.valcor - v_record_recpar.descor - v_record_recpar.valhis );
          v_juros_compos     = ( v_record_recpar.valjur - v_record_recpar.descjur );
          v_multa_compos     = ( v_record_recpar.valmul - v_record_recpar.descmul );

          if lRaise is true then
            perform fc_debug('        Parcela: '||v_record_recpar.parcela||' - Receita: '||v_record_recpar.receit,lRaise,false,false);
            perform fc_debug('        Valor da Parcela(v_valparc) ........................: '||v_valparc,lRaise,false,false);
            perform fc_debug('        Valor historico da Composicao(v_historico_compos) ..: '||v_historico_compos,lRaise,false,false);
            perform fc_debug('        Valor corrigido da Composicao(v_correcao_compos) ...: '||v_correcao_compos,lRaise,false,false);
            perform fc_debug('        Valor juros da Composicao(v_juros_compos) ..........: '||v_juros_compos,lRaise,false,false);
            perform fc_debug('        Valor multa da Composicao(v_multa_compos) ..........: '||v_multa_compos,lRaise,false,false);
          end if;

          --
          --
          -- Caso seja a ultima parcela do parcelamento realizamos a verificação nos valores gerados para a composição das parcelas
          -- Se encontrar alguma diferenca é realizado o processamento do ajuste da composicao
          --
          if v_record_recpar.parcela = v_totparcdestarec then

             if lRaise is true then
                perform fc_debug('       ',lRaise,false,false);
                perform fc_debug('       >> U L T I M A  P A R C E L A  D O  P A R C E L A M E N T O <<',lRaise,false,false);
                perform fc_debug('       2.1  VERIFICANDO E PROCESSANDO CORRECAO NAS DIFERENCAS DE VALORES(ARREDONDAMENTO) ',lRaise,false,false);
                perform fc_debug('       ',lRaise,false,false);
             end if;

             --
             -- Verificamos os valores já gerados para a composicao do débito somando com o valor que será gerado para esta parcela e receita
             --
             select sum(k00_vlrhist)+v_historico_compos,
                    sum(k00_correcao)+v_correcao_compos,
                    sum(k00_juros)+v_juros_compos,
                    sum(k00_multa)+v_multa_compos
               into nVlrHistoricoComposicao,
                    nVlrCorrecaoComposicao,
                    nVlrJurosComposicao,
                    nVlrMultaComposicao
               from arrecadcompos
              inner join arreckey on arreckey.k00_sequencial = arrecadcompos.k00_arreckey
              where k00_numpre = v_numpre;

              --
              -- Verificamos o total do valor de origem do parcelamento sem alterações e aplicações de regra.
              --
              select sum(k00_vlrhis),
                     sum(k00_vlrcor-k00_vlrhis),
                     sum(k00_juros),
                     sum(k00_multa),
                     sum(k00_desconto),
                     sum(k00_total)
                into nVlrTotalParcelamentoHistorico,
                     nVlrTotalParcelamentoCorrigido,
                     nVlrTotalParcelamentoJuros,
                     nVlrTotalParcelamentoMulta,
                     nVlrTotalParcelamento
                from totalportipo;

              --
              -- Calculamos os valores de composicao Total e Diferencas
              --
              nVlrTotalComposicao              := (nVlrHistoricoComposicao+nVlrCorrecaoComposicao+nVlrJurosComposicao+nVlrMultaComposicao);

              nVlrDiferencaComposicaoHistorico := nVlrTotalParcelamentoHistorico - nVlrHistoricoComposicao;
              nVlrDiferencaComposicaoCorrecao  := nVlrTotalParcelamentoCorrigido - nVlrCorrecaoComposicao - nVlrTotalDescontoCorrigido;
              nVlrDiferencaComposicaoJuros     := nVlrTotalParcelamentoJuros     - nVlrJurosComposicao    - nVlrTotalDescontoJuros;
              nVlrDiferencaComposicaoMulta     := nVlrTotalParcelamentoMulta     - nVlrMultaComposicao    - nVlrTotalDescontoMulta;

              nVlrDiferencaComposicaoTotal     := round(abs(nVlrDiferencaComposicaoHistorico)+abs(nVlrDiferencaComposicaoCorrecao)+abs(nVlrDiferencaComposicaoJuros)+abs(nVlrDiferencaComposicaoMulta),2);

              if lRaise is true then
                 perform fc_debug('         Valores gerados no processamento da composicao: ',lRaise,false,false);
                 perform fc_debug('         nVlrTotalHistorico ............: '||nVlrHistoricoComposicao,lRaise,false,false);
                 perform fc_debug('         nVlrTotalCorrecao .............: '||nVlrCorrecaoComposicao,lRaise,false,false);
                 perform fc_debug('         nVlrTotalJuros ................: '||nVlrJurosComposicao,lRaise,false,false);
                 perform fc_debug('         nVlrTotalMulta ................: '||nVlrMultaComposicao,lRaise,false,false);
                 perform fc_debug('         ---------------------------------------',lRaise,false,false);
                 perform fc_debug('         Total da Composicao ..........: '||nVlrTotalComposicao,lRaise,false,false);
                 perform fc_debug('         Total do Parcelamento ........: '||nVlrTotalParcelamento,lRaise,false,false);
                 perform fc_debug(' ',lRaise,false,false);
                 perform fc_debug('         Valores das diferencas encontradas: ',lRaise,false,false);
                 perform fc_debug('         Diferenca no Vlr. Historico ..: '||nVlrDiferencaComposicaoHistorico,lRaise,false,false);
                 perform fc_debug('         Diferenca no Vlr. Corrigido ..: '||nVlrDiferencaComposicaoCorrecao,lRaise,false,false);
                 perform fc_debug('         Diferenca no Vlr. dos Juros ..: '||nVlrDiferencaComposicaoJuros,lRaise,false,false);
                 perform fc_debug('         Diferenca no Vlr. da Multa ...: '||nVlrDiferencaComposicaoMulta,lRaise,false,false);
                 perform fc_debug('         ---------------------------------------',lRaise,false,false);
                 perform fc_debug('         Total da Diferenca (abs) .....: '||nVlrDiferencaComposicaoTotal,lRaise,false,false);
              end if;

              --
              -- Caso seja encontrada diferenca na composicao do débito com o total parcelado
              -- Realizamos os ajustes necessarios nos valores onde existem diferenca, se o valor da diferenca existir e não for maior que 1.
              --
              if abs(nVlrDiferencaComposicaoTotal) between 0.01 and 1.00 then

                 if lRaise is true then
                     perform fc_debug('',lRaise,false,false);
                     perform fc_debug('         >> Processando acerto da diferenca da composicao <<',lRaise,false,false);
                 end if;

                 if abs(nVlrDiferencaComposicaoHistorico) <> 0 then

                  if lRaise is true then
                     perform fc_debug('            - Corrigindo diferenca no valor Historico de '||nVlrDiferencaComposicaoHistorico,lRaise,false,false);
                  end if;
                  v_historico_compos := v_historico_compos+nVlrDiferencaComposicaoHistorico;
                 end if;

                 if abs(nVlrDiferencaComposicaoCorrecao) <> 0 then

                  if lRaise is true then
                     perform fc_debug('            - Corrigindo diferenca no valor Corrigido de '||nVlrDiferencaComposicaoCorrecao,lRaise,false,false);
                  end if;
                  v_correcao_compos := v_correcao_compos+nVlrDiferencaComposicaoCorrecao;
                 end if;

                 if abs(nVlrDiferencaComposicaoJuros) <> 0 then

                  if lRaise is true then
                     perform fc_debug('            - Corrigindo diferenca no valor dos Juros de '||nVlrDiferencaComposicaoJuros,lRaise,false,false);
                  end if;
                  v_juros_compos := v_juros_compos+nVlrDiferencaComposicaoJuros;

                 end if;

                 if abs(nVlrDiferencaComposicaoMulta) <> 0 then

                  if lRaise is true then
                     perform fc_debug('            - Corrigindo diferenca no valor da Multa de '||nVlrDiferencaComposicaoMulta,lRaise,false,false);
                  end if;
                  v_multa_compos := v_multa_compos+nVlrDiferencaComposicaoMulta;

                 end if;

                 --
                 --
                 -- Se a variável de sessão db_debugon estiver setada, verificamos os valores finais gerados para a composição do débito
                 -- Essa verificação é realizada buscando os valores já gerados somando com o valor da receita que será cadastrado já com
                 -- os ajustes de valores.
                 --
                 if lRaise is true then

                    select sum(k00_vlrhist)  + v_historico_compos,
                           sum(k00_correcao) + v_correcao_compos,
                           sum(k00_juros)    + v_juros_compos,
                           sum(k00_multa)    + v_multa_compos
                      into nVlrHistoricoComposicao,
                           nVlrCorrecaoComposicao,
                           nVlrJurosComposicao,
                           nVlrMultaComposicao
                      from arrecadcompos
                     inner join arreckey on arreckey.k00_sequencial = arrecadcompos.k00_arreckey
                     where k00_numpre = v_numpre;

                    nVlrTotalComposicao              := (nVlrHistoricoComposicao+nVlrCorrecaoComposicao+nVlrJurosComposicao+nVlrMultaComposicao);

                    nVlrDiferencaComposicaoHistorico := nVlrTotalParcelamentoHistorico - nVlrHistoricoComposicao;
                    nVlrDiferencaComposicaoCorrecao  := nVlrTotalParcelamentoCorrigido - nVlrCorrecaoComposicao - nVlrTotalDescontoCorrigido;
                    nVlrDiferencaComposicaoJuros     := nVlrTotalParcelamentoJuros     - nVlrJurosComposicao    - nVlrTotalDescontoJuros;
                    nVlrDiferencaComposicaoMulta     := nVlrTotalParcelamentoMulta     - nVlrMultaComposicao    - nVlrTotalDescontoMulta;

                    nVlrDiferencaComposicaoTotal     := round(abs(nVlrDiferencaComposicaoHistorico)+abs(nVlrDiferencaComposicaoCorrecao)+abs(nVlrDiferencaComposicaoJuros)+abs(nVlrDiferencaComposicaoMulta),2);

                    perform fc_debug('         Valores gerados no processamento da composicao apos o acerto das diferencas: ',lRaise,false,false);
                    perform fc_debug('         nVlrTotalHistorico ............: '||nVlrHistoricoComposicao,lRaise,false,false);
                    perform fc_debug('         nVlrTotalCorrecao .............: '||nVlrCorrecaoComposicao,lRaise,false,false);
                    perform fc_debug('         nVlrTotalJuros ................: '||nVlrJurosComposicao,lRaise,false,false);
                    perform fc_debug('         nVlrTotalMulta ................: '||nVlrMultaComposicao,lRaise,false,false);
                    perform fc_debug('         ---------------------------------------',lRaise,false,false);
                    perform fc_debug('         Total da Composicao ..........: '||nVlrTotalComposicao,lRaise,false,false);
                    perform fc_debug('         Total do Parcelamento ........: '||nVlrTotalParcelamento,lRaise,false,false);
                    perform fc_debug(' ',lRaise,false,false);
                    perform fc_debug('         Valores das diferencas encontradas: ',lRaise,false,false);
                    perform fc_debug('         Diferenca no Vlr. Historico ..: '||nVlrDiferencaComposicaoHistorico,lRaise,false,false);
                    perform fc_debug('         Diferenca no Vlr. Corrigido ..: '||nVlrDiferencaComposicaoCorrecao,lRaise,false,false);
                    perform fc_debug('         Diferenca no Vlr. dos Juros ..: '||nVlrDiferencaComposicaoJuros,lRaise,false,false);
                    perform fc_debug('         Diferenca no Vlr. da Multa ...: '||nVlrDiferencaComposicaoMulta,lRaise,false,false);
                    perform fc_debug('         ---------------------------------------',lRaise,false,false);
                    perform fc_debug('         Total da Diferenca (abs) .....: '||nVlrDiferencaComposicaoTotal,lRaise,false,false);

                 end if;

              end if;

          end if;

          iSeqArrecadcompos := nextval('arrecadcompos_k00_sequencial_seq');
          insert into arrecadcompos ( k00_sequencial,
                                      k00_arreckey,
                                      k00_vlrhist,
                                      k00_correcao,
                                      k00_juros,
                                      k00_multa )
                             values ( iSeqArrecadcompos,
                                      iSeqArrecKey,
                                      v_historico_compos,
                                      v_correcao_compos,
                                      v_juros_compos,
                                      v_multa_compos );

          if lRaise is true then

            perform fc_debug('',lRaise,false,false);
            perform fc_debug('     3. I N S E R I N D O  R E G I S T R O S  D E  C O M P O S I C A O (ArrecadCompos)',lRaise,false,false);
            perform fc_debug('        Cod. Arreckey(k00_arreckey): '||iSeqArrecKey||' Numpre: '||v_numpre||' Parcela: '||v_record_recpar.parcela||' Receita: '||v_recdestino,lRaise,false,false);
            perform fc_debug('',lRaise,false,false);

          end if;

          if v_historico_compos = 0 and v_correcao_compos = 0 and v_juros_compos = 0 and v_multa_compos = 0 then
            v_valparc = 0;
            lGravaArrecad = false;
          else
            v_valparc = round(v_historico_compos,2);
          end if;

          if lRaise is true then

             perform fc_debug('',lRaise,false,false);
             perform fc_debug('+--------------------------------------------------------------------------------------------',lRaise,false,false);
             perform fc_debug('|                                                                                            ',lRaise,false,false);
             perform fc_debug('|      Fim do processamento da composicao do Numpre: '||v_numpre||' Parcela: '||v_record_recpar.parcela||' Receita: '||v_recdestino,lRaise,false,false);
             perform fc_debug('|                                                                                            ',lRaise,false,false);
             perform fc_debug('+--------------------------------------------------------------------------------------------',lRaise,false,false);
             perform fc_debug('',lRaise,false,false);

          end if;

        end if;

        if lRaise is true then
            perform fc_debug(' ',lRaise,false,false);
            perform fc_debug('Inserindo dados da parcela no Arrecad',lRaise,false,false);
            perform fc_debug('Numpre: '||v_numpre||' Numpar: '||v_record_recpar.parcela||' Receita: '||v_recdestino||' Valor: '||v_valparc||' - Round: '||round(v_valparc,2),lRaise,false,false);
            perform fc_debug(' ',lRaise,false,false);
        end if;

        if lSeparaJuroMulta = 2 then

          if (round(v_valparc,2) <= 0 or v_valparc is null) then
            return '[12] - valor da parcela ' || trim(to_char(v_record_recpar.parcela, '999')) || ' zerada ou em branco! Contate suporte';
          end if;

        end if;

        if lGravaArrecad is true then

          insert into arrecad (k00_numcgm,
                               k00_dtoper,
                               k00_receit,
                               k00_hist,
                               k00_valor,
                               k00_dtvenc,
                               k00_numpre,
                               k00_numpar,
                               k00_numtot,
                               k00_numdig,
                               k00_tipo,
                               k00_tipojm)
                       values (v_cgmpri,
                               dDataUsu,
                               v_recdestino,
                               v_record_recpar.hist,
                               round(v_valparc,2),
                               v_vcto,
                               v_numpre,
                               v_record_recpar.parcela,
                               v_totalparcelas,
                               0,
                               v_tiponovo,
                               0);

          select k00_valor
            into v_teste
            from arrecad
           where k00_numpre = v_numpre
             and k00_numpar = v_record_recpar.parcela
             and k00_receit = v_recdestino;

          if lRaise is true then
            perform fc_debug('Dados inseridos na Arrecad: Valor: '||v_valparc||' - Round: '||round(v_valparc,2)||' - Teste(Valor inserido no Arrecad): '||v_teste,lRaise,false,false);
          end if;

        end if;

        if lRaise is true then
          perform fc_debug(' ',lRaise,false,false);
          perform fc_debug(' ',lRaise,false,false);
        end if;

      else
        perform fc_debug('Valor da parcela(v_valparc) menor ou igual a zero: '||v_valparc,lRaise,false,false);
      end if;

      if lRaise is true then
        perform fc_debug('Receita Origem: '||v_record_recpar.receit||' - Receita Destino: '||v_recdestino,lRaise,false,false);
        perform fc_debug('Receita: '||v_record_recpar.receit||' - Qtd Total de Parcelas da Receita: '||v_totparcdestarec,lRaise,false,false);
      end if;

      -- conta a quantidade total de parcelas desta receita
      select count(*)
        into v_totparcdestarec
        from parcelas
       where receit = v_record_recpar.receit;

      if lRaise is true then
        perform fc_debug('Receita: '||v_record_recpar.receit||' - Qtd Total de Parcelas da Receita: '||v_totparcdestarec,lRaise,false,false);
      end if;

      --
      -- Se parcela atual for igual a ultima parcela desta receita
      -- reinicia as variaveis com os dados especificados na CGF para o vencimento da parcela 2
      --
      if v_record_recpar.parcela = v_totparcdestarec then

        select extract (year from v_segvenc)
          into v_anovenc;

        select extract (month from v_segvenc)
          into v_mesvenc;

      end if;

    end loop;

    if lRaise is true then
        perform fc_debug(' ',lRaise,false,false);
        perform fc_debug(' ',lRaise,false,false);
        perform fc_debug(' ',lRaise,false,false);
        perform fc_debug(' ',lRaise,false,false);
        perform fc_debug(' ',lRaise,false,false);
    end if;

    if lRaise is true then

      -- mostra os valores por parcela do arrecad, apenas para conferencia
      for v_record_recpar in select k00_numpar,
                                    sum(k00_valor)
                               from arrecad
                              where k00_numpre = v_numpre
                              group by k00_numpar
      loop

        if lRaise is true then
          perform fc_debug('2 - parcela: '||v_record_recpar.k00_numpar||' - valor: '||v_record_recpar.sum,lRaise,false,false);
        end if;

      end loop;

    end if;

    -- sum do campo valor
    select sum(valor)
      into nValorTotalOrigem
      from w_base_parcelas;

    for rPercOrigem in select numpre,
                              numpar,
                              receit,
                              sum(valor) as valor
                         from arrecad_parc_rec
                        group by numpre, numpar, receit
    loop

      nPercCalc := ( ( rPercOrigem.valor / nValorTotalOrigem ) * 100 );
--    raise notice 'valor: % - nValorTotalOrigem: % - PercCalcComRound: %', rPercOrigem.valor, nValorTotalOrigem, nPercCalc ;

      perform sum(k00_perc)
         from ( select k00_matric as k00_origem,
                       coalesce(k00_perc, 100) as k00_perc,
                       1 as tipo
                  from arrematric
                 where k00_numpre = rPercOrigem.numpre
                 union
                select k00_inscr as k00_origem,
                       coalesce(k00_perc, 100) as k00_perc,
                       2 as tipo
                  from arreinscr
                 where k00_numpre = rPercOrigem.numpre
                union
                select 0   as k00_origem,
                       100 as k00_perc,
                       3   as tipo
                  from arrenumcgm
                       left join arrematric on arrematric.k00_numpre = arrenumcgm.k00_numpre
                       left join arreinscr  on arreinscr.k00_numpre  = arrenumcgm.k00_numpre
                 where arrematric.k00_numpre is null
                   and arreinscr.k00_numpre  is null
                   and arrenumcgm.k00_numpre = rPercOrigem.numpre
              ) as x
       having cast(round(sum(k00_perc),2) as numeric) <> cast(100 as numeric);
      if found then
          return '[13] - Inconsistencia no percentual da origem - numpre: ' || rPercOrigem.numpre;
      end if;

      for v_record_perc in select k00_matric              as k00_origem,
                                  coalesce(k00_perc, 100) as k00_perc,
                                  1                       as tipo
                             from arrematric
                            where k00_numpre = rPercOrigem.numpre
                            union
                           select k00_inscr               as k00_origem,
                                  coalesce(k00_perc, 100) as k00_perc,
                                  2                       as tipo
                             from arreinscr
                            where k00_numpre = rPercOrigem.numpre
                            union
                           select 0   as k00_origem,
                                  100 as k00_perc,
                                  3   as tipo
                             from arrenumcgm
                             left join arrematric on arrematric.k00_numpre = arrenumcgm.k00_numpre
                             left join arreinscr  on arreinscr.k00_numpre  = arrenumcgm.k00_numpre
                            where arrematric.k00_numpre is null
                              and arreinscr.k00_numpre  is null
                              and arrenumcgm.k00_numpre = rPercOrigem.numpre
      loop

        if lRaise then
          perform fc_debug('---------------------------------------------------------------',lRaise,false,false);
          perform fc_debug('numpre: '||rPercOrigem.numpre||' - perc: '||v_record_perc.k00_perc||' - tipo: '||v_record_perc.tipo||' - percentual por registro: '||nPercCalc,lRaise,false,false);
          perform fc_debug('---------------------------------------------------------------',lRaise,false,false);
        end if;

        if v_record_perc.tipo = 1 then

            execute 'insert into arrecad_parc_rec_perc values ('|| rPercOrigem.numpre                        || ','
                                                                || rPercOrigem.numpar                        || ','
                                                                || rPercOrigem.receit                        || ','
                                                                || v_record_perc.k00_origem                  || ','
                                                                || nPercCalc * v_record_perc.k00_perc / 100  || ','
                                                                || 0                                         || ','
                                                                || 0                                         || ','
                                                                || 0                                         || ','
                                                                || v_record_perc.tipo                        || ');';
        elsif v_record_perc.tipo = 2 then

            execute 'insert into arrecad_parc_rec_perc values (' || rPercOrigem.numpre                        || ','
                                                                 || rPercOrigem.numpar                        || ','
                                                                 || rPercOrigem.receit                        || ','
                                                                 || 0                                         || ','
                                                                 || 0                                         || ','
                                                                 || v_record_perc.k00_origem                  || ','
                                                                 || nPercCalc * v_record_perc.k00_perc / 100  || ','
                                                                 || 0                                         || ','
                                                                 || v_record_perc.tipo                        || ');';

        elsif v_record_perc.tipo = 3 then

            execute 'insert into arrecad_parc_rec_perc values (' || rPercOrigem.numpre                        || ','
                                                                 || rPercOrigem.numpar                        || ','
                                                                 || rPercOrigem.receit                        || ','
                                                                 || 0                                         || ','
                                                                 || 0                                         || ','
                                                                 || 0                                         || ','
                                                                 || 0                                         || ','
                                                                 || nPercCalc * v_record_perc.k00_perc / 100  || ','
                                                                 || v_record_perc.tipo                        || ');';
        end if;

      end loop;

    end loop;

    /**
     * Somamos o percentual virtual do cgm para distribui-lo entre as origens (Matricula e Inscricao)
     */
    select coalesce(sum(perccgm), 0)
      into nPercentualVirtualCgm
      from arrecad_parc_rec_perc
     where percmatric = 0
       and percinscr  = 0;

    select count(*)
      into iQtdRegistrosMatricula
      from arrecad_parc_rec_perc
     where tipo = 1;

    select count(*)
      into iQtdRegistrosInscricao
      from arrecad_parc_rec_perc
     where tipo = 2;


    if ( ((iQtdRegistrosMatricula + iQtdRegistrosInscricao) > 0) and (nPercentualVirtualCgm > 0) ) then

      nDiferencaPercentualCGM = coalesce((nPercentualVirtualCgm / (iQtdRegistrosMatricula + iQtdRegistrosInscricao)), 0);

      if lRaise then
        perform fc_debug('nDiferencaPercentualCGM' || nDiferencaPercentualCGM, lRaise, false, false);
      end if;

      update arrecad_parc_rec_perc
         set percmatric = percmatric + nDiferencaPercentualCGM
       where tipo = 1 ;

      update arrecad_parc_rec_perc
         set percinscr = percinscr + nDiferencaPercentualCGM
       where tipo = 2 ;

      update arrecad_parc_rec_perc
         set perccgm = 0
       where tipo = 3;

    end if;


   /**
    * Calculamos a diferenca no valor percentual entre o somatorio de todas as origens (Matricula e Inscricao)
    */
    select 100 - (sum(percmatric) + sum(percinscr))
      into nDiferencaPercentualAjuste
      from arrecad_parc_rec_perc
     where tipo in (1,2);

    /**
     * Se existir diferenca no percentual
     * Ajustamos a diferenca no arredondamento no primeiro registro encontrado
     */
    if nDiferencaPercentualAjuste <> cast( 0 as numeric(15,10) ) then

      if lRaise then
        perform fc_debug('---------------------------------------------------------------',lRaise,false,false);
        perform fc_debug('Valor da diferenca de arredondamento: '||nDiferencaPercentualAjuste,lRaise,false,false);
        perform fc_debug('---------------------------------------------------------------',lRaise,false,false);
      end if;

      for rAjusteDiferencaPercentual in select * from arrecad_parc_rec_perc where tipo <> 3 limit 1
      loop

        if rAjusteDiferencaPercentual.tipo = 1 then

          update arrecad_parc_rec_perc
             set percmatric = ( percmatric + ( nDiferencaPercentualAjuste ) )
           where numpre = rAjusteDiferencaPercentual.numpre
             and numpar = rAjusteDiferencaPercentual.numpar
             and receit = rAjusteDiferencaPercentual.receit
             and matric = rAjusteDiferencaPercentual.matric;

        elsif rAjusteDiferencaPercentual.tipo = 2 then

          update arrecad_parc_rec_perc
             set percinscr = ( percinscr + ( nDiferencaPercentualAjuste ) )
           where numpre = rAjusteDiferencaPercentual.numpre
             and numpar = rAjusteDiferencaPercentual.numpar
             and receit = rAjusteDiferencaPercentual.receit
             and inscr  = rAjusteDiferencaPercentual.inscr;
        end if;

      end loop;
    end if;

    nSomaPercMatric = 0;
    nTotArreMatric  = 0;

    select round(sum(percmatric),2)
      into nTotArreMatric
      from arrecad_parc_rec_perc;

    for rPercOrigem in select matric,
                              sum(percmatric) as k00_perc,
                              tipo
                         from arrecad_parc_rec_perc
                        where matric > 0
                        group by matric,tipo
    loop

      if lRaise then
        perform fc_debug('---------------------------------------------------------------',lRaise,false,false);
        perform fc_debug('matric: '||rPercOrigem.matric||' - perc: '||rPercOrigem.k00_perc||' numpre : '||v_numpre ,lRaise,false,false);
        perform fc_debug('---------------------------------------------------------------',lRaise,false,false);
      end if;

      -- tipo = 3 quer dizer que nao tem origem de matricula ou inscricao
      -- (o numpre origem esta somente na arrenumcgm ou seja nao precisa gravar percentual na arrematric ou arreinscr)
      if rPercOrigem.tipo <> 3 then
              insert into arrematric (k00_matric,
                                      k00_numpre,
                                      k00_perc)
                              values (rPercOrigem.matric,
                                      v_numpre,
                                      rPercOrigem.k00_perc);
      end if;

       v_totalzao       := round(v_totalzao + rPercOrigem.k00_perc,2);
       nSomaPercMatric  := round(nSomaPercMatric + rPercOrigem.k00_perc,2);

    end loop;

    if lRaise then
      perform fc_debug('v_totalzao (1): '||v_totalzao,lRaise,false,false);
    end if;

    nSomaPercInscr = 0;
    nTotArreInscr  = 0;

    select round(sum(percinscr),2)
      into nTotArreInscr
      from arrecad_parc_rec_perc;

    for rPercOrigem in select inscr,
                              sum(percinscr) as k00_perc,
                              tipo
                         from arrecad_parc_rec_perc
                        where inscr > 0
                        group by inscr,tipo
    loop

      if lRaise then
        raise info 'inscr: % - perc: % numpre : % ',rPercOrigem.inscr, rPercOrigem.k00_perc, v_numpre;
      end if;

      if lRaise then
        perform fc_debug('---------------------------------------------------------------',lRaise,false,false);
        perform fc_debug('inscr: '||rPercOrigem.inscr||' - perc: '||rPercOrigem.k00_perc||' numpre : '||v_numpre,lRaise,false,false);
        perform fc_debug('---------------------------------------------------------------',lRaise,false,false);
      end if;

      -- tipo = 3 quer dizer que nao tem origem de matricula ou inscricao
      -- (o numpre origem esta somente na arrenumcgm ou seja nao precisa gravar percentual na arrematric ou arreinscr)
      if rPercOrigem.tipo <> 3 then
            insert into arreinscr (k00_inscr,
                                   k00_numpre,
                                   k00_perc)
                           values (rPercOrigem.inscr,
                                   v_numpre,
                                   rPercOrigem.k00_perc);
      end if;

      v_totalzao      := round( v_totalzao + rPercOrigem.k00_perc ,2);
      nSomaPercInscr  := round( nSomaPercInscr + rPercOrigem.k00_perc ,2);

    end loop;

    if lRaise then
      perform fc_debug('v_totalzao (2): '||v_totalzao,lRaise,false,false);
      perform fc_debug('nTotArreInscr : '|| nTotArreInscr || 'nSomaPercInscr : ' || nSomaPercInscr || 'TOTAL: ' ||(nTotArreInscr-nSomaPercInscr) );
    end if;

    if lRaise then
      perform fc_debug('v_totalzao (3): '||v_totalzao,lRaise,false,false);
    end if;

    for rPercOrigem in select numpre,
                              sum(round(perccgm,2)) as k00_perc
                         from arrecad_parc_rec_perc
                        where tipo = 3
                        group by numpre
    loop

      if lRaise then
         perform fc_debug('---------------------------------------------------------------',lRaise,false,false);
         perform fc_debug(' por cgm -- numpre -- '||rPercOrigem.k00_perc||' percentual -- '||rPercOrigem.numpre,lRaise,false,false);
         perform fc_debug('---------------------------------------------------------------',lRaise,false,false);
      end if;

      v_totalzao := (v_totalzao + rPercOrigem.k00_perc);

    end loop;


    -- Corrige arredondamentos

    nPercCalc = 100.00 - round(v_totalzao,2);
    if nPercCalc < 0.5 then

       --
       -- Jogamos a diferença do percentual na Arreinscr quando:
       --  - Não existir vinculo com matricula
       --  - O percentual da inscrição for menor que o percentual da matricula
       --
       -- Jogamos a difença do percentual na Arrematric quando:
       -- - Não existir vinculo com a inscrição
       -- - O Percentual da matricula for menor que o percentual da inscrição
       --
      if lRaise then
        perform fc_debug('nPercCalc < 0.5 --------------------- nSomaPercInscr ...: '||nSomaPercInscr ,lRaise,false,false);
        perform fc_debug('nPercCalc < 0.5 --------------------- nSomaPercMatric...: '||nSomaPercMatric,lRaise,false,false);
        perform fc_debug('nPercCalc < 0.5 --------------------- nPercCalc.........: '||nPercCalc      ,lRaise,false,false);
        perform fc_debug('nPercCalc < 0.5 --------------------- v_totalzao........: '||v_totalzao     ,lRaise,false,false);
      end if;

       v_totalzao := v_totalzao + nPercCalc;
       if lRaise then
          perform fc_debug('v_totalzao (4): '||v_totalzao,lRaise,false,false);
       end if;

    end if;
    -- soma os percentuais da arrematric e arreinscr... nao esquecendo de que pode NAO ter registros em nenhuma das duas tabelas

    if lRaise is true then
      perform fc_debug(' Apos nPercCalc < 0.5 ---- total utilizado na comparacao final: '||v_total,lRaise,false,false);
      perform fc_debug(' Apos nPercCalc < 0.5 ---- totalzao ..........................: '||v_totalzao,lRaise,false,false);
    end if;

    if round(v_totalzao,2)::numeric <> 100::numeric and round(v_totalzao,2)::numeric <> 0::numeric then
      return '[14] - Erro calculando percentual entre as origens devedoras';
    end if;

    if lRaise is true then
      perform fc_debug('',lRaise,false,false);
      perform fc_debug(' Verificando percentuais na arrematric, arreinscr e arrenumcgm gerados para o numpre '||v_numpre,lRaise,false,false);
      perform fc_debug('',lRaise,false,false);
    end if;


    select sum(k00_perc)
      into nValidacaoPerc

       from ( select k00_matric as k00_origem,
                     coalesce(k00_perc, 100) as k00_perc,
                     1 as tipo
                from arrematric
               where k00_numpre = v_numpre
               union
              select k00_inscr as k00_origem,
                     coalesce(k00_perc, 100) as k00_perc,
                     2 as tipo
                from arreinscr
               where k00_numpre = v_numpre
              union
              select 0   as k00_origem,
                     100 as k00_perc,
                     3   as tipo
                from arrenumcgm
                     left join arrematric on arrematric.k00_numpre = arrenumcgm.k00_numpre
                     left join arreinscr  on arreinscr.k00_numpre  = arrenumcgm.k00_numpre
               where arrematric.k00_numpre is null
                 and arreinscr.k00_numpre  is null
                 and arrenumcgm.k00_numpre = v_numpre
            ) as x;

--     having cast(round(nValidacaoPerc +nPercentualVirtualCgm,2) as numeric) <> cast(100.00 as numeric);
--  raise notice 'nValidacaoPerc : % nPercentualVirtualCgm : % ',nValidacaoPerc,nPercentualVirtualCgm;


--     nValidacaoPerc := nValidacaoPerc + nPercentualVirtualCgm;
    nValidacaoPerc := nValidacaoPerc;

    perform fc_debug('----nValidacaoPerc        : ' || nValidacaoPerc);
    perform fc_debug('----nPercentualVirtualCgm : ' || nPercentualVirtualCgm);
    perform fc_debug('----v_totalzao : ' || v_totalzao);

-- return 'final percentual 2';

    if round( nValidacaoPerc, 2) <> 100.00 then

        --return 'final : perc : '||round(nValidacaoPerc,2)||' numpre : '||v_numpre;

        --
        -- Verificamos se o problema é devido estar no parcelamento débitos que pertencem a matricula/inscrição e débitos sem vinculo com matricula/inscricao
        -- Se for encontrado um numpre que não esteja vinculado a matricula e a inscrição na origem, mostramos uma mensagem de erro diferenciada para facilitar a
        -- correção do caso. Geralmente a correção é realizada vinculando o numpre a uma matricula ou inscrição.
        --
        select array_to_string(array_accum( distinct arrecad_parc_rec.numpre),',')
          into sNumpreSemVinculoMatricInsc
          from arrecad_parc_rec
               left join arrematric on arrematric.k00_numpre = arrecad_parc_rec.numpre
               left join arreinscr  on arreinscr.k00_numpre  = arrecad_parc_rec.numpre
         where arrematric.k00_numpre is null
           and arreinscr.k00_numpre  is null;
        if sNumpreSemVinculoMatricInsc <> '' then
          return '[15] - Inconsistencia no percentual do débito gerado após o processamento do parcelamento - numpre: '||v_numpre||'. - Encontrados numpres que não possuem vinculo com Matricula/Inscrição. Numpres ['||sNumpreSemVinculoMatricInsc||']';
        else
          return '[15] - Inconsistencia no percentual do débito gerado após o processamento do parcelamento - numpre: '||v_numpre;
        end if;

    end if;

    if lRaise is true then
      perform fc_debug('',lRaise,false,false);
    end if;

        -- insere registros na arreparc
        -- agrupados por receita
    for v_record_receitas in  select receit,
                                     sum(vlrhis) as vlrhis,
                                     sum(vlrcor) as vlrcor,
                                     sum(vlrjur) as vlrjur,
                                     sum(vlrmul) as vlrmul,
                                     sum(vlrdes) as vlrdes,
                                     sum(valor)  as valor
                                from arrecad_parc_rec
                               group by receit
    loop

      if lRaise is true then
        perform fc_debug('receita: '||v_record_receitas.receit||' - valor: '||v_record_receitas.valor, lRaise,false,false);
      end if;

      insert into arreparc values (v_numpre,v_record_receitas.receit,v_record_receitas.valor / v_total * 100);

      nVlrHis := nVlrHis + v_record_receitas.vlrhis;
      nVlrCor := nVlrCor + v_record_receitas.vlrcor;
      nVlrJur := nVlrJur + v_record_receitas.vlrjur;
      nVlrMul := nVlrMul + v_record_receitas.vlrmul;
      nVlrDes := nVlrDes + v_record_receitas.vlrdes;

    end loop;

    if lRaise is true then
      perform fc_debug('',lRaise,false,false);
    end if;

        -- insere na termo
    insert into termo ( v07_parcel,
                        v07_dtlanc,
                        v07_valor,
                        v07_numpre,
                        v07_totpar,
                        v07_vlrpar,
                        v07_dtvenc,
                        v07_vlrent,
                        v07_datpri,
                        v07_vlrmul,
                        v07_vlrjur,
                        v07_perjur,
                        v07_permul,
                        v07_login,
                        v07_numcgm,
                        v07_hist,
                        v07_ultpar,
                        v07_desconto,
                        v07_desccor,
                        v07_descjur,
                        v07_descmul,
                        v07_situacao,
                        v07_instit,
                        v07_vlrhis,
                        v07_vlrcor,
                        v07_vlrdes )
               values ( v_termo,
                        dDataUsu,
                        v_total,
                        v_numpre,
                        v_totalparcelas,
                        v_valorparcelanew,
                        v_segvenc,
                        v_entrada,
                        v_privenc,
                        nVlrMul,
                        nVlrJur,
                        0,
                        0,
                        v_login,
                        v_cgmresp,
                        sObservacao,
                        v_valultimaparcelanew,
                        v_desconto,
                        v_descontocor,
                        v_descontojur,
                        v_descontomul,
                        1, -- Situacao Ativo
                        iInstit,
                        nVlrHis,
                        nVlrCor,
                        nVlrDes );

    -- se foi informado codigo do processo entao insere na termoprotprocesso
    if iProcesso is not null and iProcesso != 0  then

      if lRaise is true then
        perform fc_debug(' Insere na protprocesso  Processo : '||iProcesso,lRaise,false,false);
      end if;

      insert into termoprotprocesso (v27_sequencial,
                                     v27_termo,
                                     v27_protprocesso)
                             values (nextval('termoprotprocesso_v27_sequencial_seq'),
                                     v_termo,
                                     iProcesso);
    end if;

        -- se origem tiver parcelamento
        -- insere na termoreparc
    if lParcParc then
      if lRaise is true then
        perform fc_debug('v08_parcel: '||v_termo||' - v08_parcelorigem: '||v_termo_ori,lRaise,false,false);
      end if;

      for v_record_origem in select distinct v07_parcel
                               from termo
                                    inner join numpres_parc on termo.v07_numpre = numpres_parc.k00_numpre
      loop

        if lRaise is true then
          perform fc_debug('into termoreparc...',lRaise,false,false);
        end if;

        insert into termoreparc (v08_sequencial,
                                 v08_parcel,
                                 v08_parcelorigem)
                         values (nextval('termoreparc_v08_sequencial_seq'),
                                 v_termo,
                                 v_record_origem.v07_parcel);

      end loop;

    end if;

    if lRaise is true then
      perform fc_debug('v_totaldivida: '||v_totaldivida,lRaise,false,false);
    end if;

    /**
     * Deve ignorar a receita de juros e multa quando a forma utilizada no parcelamento
     * é juros e multa na ultima
     */
    -- insere na termodiv (obs o select da arrecad_parc_rec da um inner join com a divida so para inserir na termodiv quando a origem for divida)
    if v_juronaultima is true then

      insert into termodiv (parcel,
                            coddiv,
                            valor,
                            vlrcor,
                            juros,
                            multa,
                            desconto,
                            total,
                            vlrdesccor,
                            vlrdescjur,
                            vlrdescmul,
                            numpreant,
                            v77_perc)
                     select x.*,
                            x.valor / v_totaldivida * 100
                       from ( select v_termo,
                                     v01_coddiv,
                                     round(sum(vlrhis),2)::float8     as vlrhis,
                                     round(sum(vlrcor),2)::float8     as vlrcor,
                                     round(sum(vlrjur),2)::float8     as vlrjur,
                                     round(sum(vlrmul),2)::float8     as vlrmul,
                                     round(sum(vlrdes),2)::float8     as vlrdes,
                                     round(sum(valor),2)::float8      as valor,
                                     round(sum(vlrdesccor),2)::float8 as vlrdesccor,
                                     round(sum(vlrdescjur),2)::float8 as vlrdescjur,
                                     round(sum(vlrdescmul),2)::float8 as vlrdescmul,
                                     divida.v01_numpre
                                from arrecad_parc_rec
                                     inner join divida on divida.v01_numpre = arrecad_parc_rec.numpre
                                                      and divida.v01_numpar = arrecad_parc_rec.numpar
                               where tipo = 5
                                 and receit not in ( select distinct receit from arrecad_parc_rec where juro is true )
                            group by v01_coddiv, v01_numpre ) as x;
    else

      insert into termodiv (parcel,
                           coddiv,
                           valor,
                           vlrcor,
                           juros,
                           multa,
                           desconto,
                           total,
                           vlrdesccor,
                           vlrdescjur,
                           vlrdescmul,
                           numpreant,
                           v77_perc)
                    select x.*,
                           x.valor / v_totaldivida * 100
                      from ( select v_termo,
                                    v01_coddiv,
                                    round(sum(vlrhis),2)::float8     as vlrhis,
                                    round(sum(vlrcor),2)::float8     as vlrcor,
                                    round(sum(vlrjur),2)::float8     as vlrjur,
                                    round(sum(vlrmul),2)::float8     as vlrmul,
                                    round(sum(vlrdes),2)::float8     as vlrdes,
                                    round(sum(valor),2)::float8      as valor,
                                    round(sum(vlrdesccor),2)::float8 as vlrdesccor,
                                    round(sum(vlrdescjur),2)::float8 as vlrdescjur,
                                    round(sum(vlrdescmul),2)::float8 as vlrdescmul,
                                    divida.v01_numpre
                               from arrecad_parc_rec
                                    inner join divida on divida.v01_numpre = arrecad_parc_rec.numpre
                                                     and divida.v01_numpar = arrecad_parc_rec.numpar
                              where tipo = 5
                           group by v01_coddiv, v01_numpre ) as x;
    end if;

        -- mostra os valores com origem de divida ativa
    if lRaise is true then

      for v_record_numpres in select *
                                from termodiv
                               where parcel = v_termo
      loop

         perform fc_debug('coddiv: '||v_record_numpres.coddiv||' - vlcor: '||v_record_numpres.vlrcor||' - total: '||v_record_numpres.total||' - juro: '||v_record_numpres.juros||' - multa: '||v_record_numpres.multa,lRaise,false,false);

      end loop;

    end if;

        -- SE ORIGEM FOR DIVERSOS
    if lParcDiversos then

      if lRaise is true then
        perform fc_debug('inserindo em termodiver...',lRaise,false,false);
      end if;
          -- insere na termodiver
      insert into termodiver (dv10_parcel,
                              dv10_coddiver,
                              dv10_valor,
                              dv10_vlrcor,
                              dv10_juros,
                              dv10_multa,
                              dv10_desconto,
                              dv10_total,
                              dv10_numpreant,
                              dv10_vlrdescjur,
                              dv10_vlrdescmul,
                              dv10_perc)
                       select x.*,
                              x.valor/v_total
                         from ( select v_termo,
                                     dv05_coddiver,
                                     round(sum(vlrhis),2)::float8     as vlrhis,
                                     round(sum(vlrcor),2)::float8     as vlrcor,
                                     round(sum(vlrjur),2)::float8     as vlrjur,
                                     round(sum(vlrmul),2)::float8     as vlrmul,
                                     round(sum(vlrdes),2)::float8     as vlrdes,
                                     round(sum(valor),2)::float8      as valor,
                                     diversos.dv05_numpre,
                                     round(sum(vlrdescjur),2)::float8 as vlrdescjur,
                                     round(sum(vlrdescmul),2)::float8 as vlrdescmul
                                from arrecad_parc_rec
                                     inner join diversos on diversos.dv05_numpre = arrecad_parc_rec.numpre
                               group by dv05_coddiver, dv05_numpre
                              ) as x;
    end if;

        -- SE ORIGEM FOR CONTRIBUICAO DE MELHORIAS
    if lParcContrib then

      if lRaise is true then
        perform fc_debug('inserindo em termodiver...',lRaise,false,false);
      end if;

      -- insere na termodiver
      insert into termocontrib (parcel,
                                contricalc,
                                valor,
                                vlrcor,
                                juros,
                                multa,
                                desconto,
                                total,
                                numpreant,
                                vlrdescjur,
                                vlrdescmul,
                                perc)
                         select x.*,
                                x.valor/v_total
                           from ( select v_termo,
                                       d09_sequencial,
                                       round(sum(vlrhis),2)::float8     as vlrhis,
                                       round(sum(vlrcor),2)::float8     as vlrcor,
                                       round(sum(vlrjur),2)::float8     as vlrjur,
                                       round(sum(vlrmul),2)::float8     as vlrmul,
                                       round(sum(vlrdes),2)::float8     as vlrdes,
                                       round(sum(valor),2)::float8      as valor,
                                       contricalc.d09_numpre,
                                       round(sum(vlrdescjur),2)::float8 as vlrdescjur,
                                       round(sum(vlrdescmul),2)::float8 as vlrdescmul
                                  from arrecad_parc_rec
                                       inner join contricalc on contricalc.d09_numpre = arrecad_parc_rec.numpre
                                 group by d09_sequencial,d09_numpre
                         ) as x;
    end if;

    if lRaise is true then
      perform fc_debug('v_parcinicial: '||v_parcinicial,lRaise,false,false);
    end if;

        -- SE ORIGEM FOR INICIAL DO FORO
    if v_parcinicial is true then

       if lRaise is true then
          perform fc_debug('inserindo em termoini...',lRaise,false,false);
       end if;

            -- insere na termoini
       insert into termoini(parcel,
                            inicial,
                            valor,
                            vlrcor,
                            juros,
                            multa,
                            desconto,
                            total,
                            vlrdesccor,
                            vlrdescjur,
                            vlrdescmul,
                            v61_perc)
                     select x.*,
                            x.valor/v_total
                       from ( select v_termo,
                                     inicialnumpre.v59_inicial,
                                     round(sum(vlrhis),2)::float8 as vlrhis,
                                     round(sum(vlrcor),2)::float8 as vlrcor,
                                     round(sum(vlrjur),2)::float8 as vlrjur,
                                     round(sum(vlrmul),2)::float8 as vlrmul,
                                     round(sum(vlrdes),2)::float8 as vlrdes,
                                     round(sum(valor),2)::float8 as valor,
                                     round(sum(vlrdesccor),2)::float8 as vlrdesccor,
                                     round(sum(vlrdescjur),2)::float8 as vlrdescjur,
                                     round(sum(vlrdescmul),2)::float8 as vlrdescmul
                                from arrecad_parc_rec
                                     inner join inicialnumpre on inicialnumpre.v59_numpre = arrecad_parc_rec.numpre
                               group by inicialnumpre.v59_inicial
                            ) as x;

      for v_iniciais in select distinct v59_inicial
                                   from arrecad_parc_rec
                                 inner join inicialnumpre on inicialnumpre.v59_numpre = arrecad_parc_rec.numpre
                                 inner join inicial       on inicial.v50_inicial      = inicialnumpre.v59_inicial
                                                         and inicial.v50_situacao     = 1
      loop

        select nextval('inicialmov_v56_codmov_seq') into v_inicialmov;

        insert into inicialmov values (v_inicialmov,v_iniciais.v59_inicial,4,'',dDataUsu,v_login);
        update inicial set v50_codmov = v_inicialmov where v50_inicial = v_iniciais.v59_inicial;

      end loop;

    end if;

   -- Deletando os registros do arreold que estao incorretamente devido a bug
   -- da versao antiga da funcao fc_excluiparcelamento

    delete from arreold
          using arrecad_parc_rec
          where arreold.k00_numpre = arrecad_parc_rec.numpre
            and arreold.k00_numpar = arrecad_parc_rec.numpar
            and arreold.k00_receit = arrecad_parc_rec.receit;

        -- insere no arreold

    insert into arreold(k00_numcgm,
                        k00_dtoper,
                        k00_receit,
                        k00_hist,
                        k00_valor,
                        k00_dtvenc,
                        k00_numpre,
                        k00_numpar,
                        k00_numtot,
                        k00_numdig,
                        k00_tipo,
                        k00_tipojm)
                 select arrecad.k00_numcgm,
                        arrecad.k00_dtoper,
                        arrecad.k00_receit,
                        arrecad.k00_hist,
                        arrecad.k00_valor,
                        arrecad.k00_dtvenc,
                        arrecad.k00_numpre,
                        arrecad.k00_numpar,
                        arrecad.k00_numtot,
                        arrecad.k00_numdig,
                        arrecad.k00_tipo,
                        arrecad.k00_tipojm
                   from arrecad
                  inner join arrecad_parc_rec on arrecad.k00_numpre = arrecad_parc_rec.numpre
                                             and arrecad.k00_numpar = arrecad_parc_rec.numpar
                                             and arrecad.k00_receit = arrecad_parc_rec.receit
                  left join arreold           on arreold.k00_numpre = arrecad_parc_rec.numpre
                                             and arreold.k00_numpar = arrecad_parc_rec.numpar
                                             and arreold.k00_receit = arrecad_parc_rec.receit
                 where arreold.k00_numpre is null
                   and arrecad.k00_valor > 0;

    delete from arrecad
          using arrecad_parc_rec
          where arrecad.k00_numpre = arrecad_parc_rec.numpre
            and arrecad.k00_numpar = arrecad_parc_rec.numpar
            and arrecad.k00_receit = arrecad_parc_rec.receit;

        -- conta a quantidade de registros do arrecad
    select count(*)
      from arrecad
      into v_contador
     where k00_numpre = v_numpre;

    if lRaise is true then
      perform fc_debug('total final de registros no arrecad: '||v_contador,lRaise,false,false);
    end if;

    -- soma o valor gravado no arrecad
    if lSeparaJuroMulta = 2 then

      select round(sum(k00_valor),2)
        into v_resto
        from arrecad
       where k00_numpre = v_numpre;

    else

      select round(sum(arrecad.k00_valor)+coalesce(sum(arrecadcompos.k00_correcao),0) + coalesce(sum(arrecadcompos.k00_juros),0) + coalesce(sum(arrecadcompos.k00_multa),0) ,2)
        into v_resto
        from arrecad
             left  join arreckey      on arreckey.k00_numpre = arrecad.k00_numpre
                                     and arreckey.k00_numpar = arrecad.k00_numpar
                                     and arreckey.k00_receit = arrecad.k00_receit
                                     and arreckey.k00_hist   = arrecad.k00_hist
             left  join arrecadcompos on arrecadcompos.k00_arreckey = arreckey.k00_sequencial
       where arrecad.k00_numpre = v_numpre;

    end if;

    if lRaise is true then
      perform fc_debug('Total do arrecad (v_resto): '||v_resto||' - v_total: '||v_total,lRaise,false,false);
    end if;

    -- registra a diferenca do valor gravado no arrecad e do total do parcelamento calculado durante o processamento
    v_teste = round(v_total,2) - round(v_resto,2);

    if lRaise is true then

      perform fc_debug('v_teste: '||v_teste,lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug('ACERTAR DIFERENCA',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);
      perform fc_debug(' ',lRaise,false,false);

    end if;

    if abs(v_teste) between 0.01 and 3.00 and v_juronaultima is false then

      if lRaise is true then
        perform fc_debug('entrou no 0.01 - diferenca: '||v_teste,lRaise,false,false);
      end if;

      select k00_receit
        into v_maxrec
        from arrecad
       where k00_numpre = v_numpre
         and k00_numpar = v_totalparcelas
       order by k00_valor desc limit 1;

      update arrecad
         set k00_valor  = k00_valor + v_teste
       where k00_numpre = v_numpre
         and k00_numpar = v_totalparcelas
         and k00_receit = v_maxrec;

    end if;

        -- se juros na ultima
    if v_juronaultima is true then

      select k00_receit
        into v_receita
        from arrecad
       where k00_numpre = v_numpre
         and k00_numpar = v_totalparcelas - 1
       limit 1;

      if round(v_total,2) <> round(v_resto,2) then

        if lRaise is true then
          perform fc_debug('update: '||(round(v_total,2) - round(v_resto,2)),lRaise,false,false);
        end if;

                -- altera o valor da penultima parcela com a diferenca
        update arrecad
           set k00_valor = k00_valor + round(round(v_total,2) - round(v_resto,2),2)
        where k00_numpre = v_numpre
          and k00_numpar = v_totalparcelas - 1
          and k00_receit = v_receita;

      end if;

    end if;

-- funcao que corrige o arrecad no caso de encontrar registros duplicados(numpre,numpar,receit)
--    perform fc_corrigeparcelamento();

    if lSeparaJuroMulta = 2 then

      select round(sum(k00_valor),2)
        into v_resto
        from arrecad
       where k00_numpre = v_numpre;

    else

      select round(sum(arrecad.k00_valor)+coalesce(sum(arrecadcompos.k00_correcao),0) + coalesce(sum(arrecadcompos.k00_juros),0) + coalesce(sum(arrecadcompos.k00_multa),0) ,2)
        into v_resto
        from arrecad
             left  join arreckey      on arreckey.k00_numpre = arrecad.k00_numpre
                                     and arreckey.k00_numpar = arrecad.k00_numpar
                                     and arreckey.k00_receit = arrecad.k00_receit
                                     and arreckey.k00_hist   = arrecad.k00_hist
             left  join arrecadcompos on arrecadcompos.k00_arreckey = arreckey.k00_sequencial
       where arrecad.k00_numpre = v_numpre;
    end if;

    if lRaise is true then
      perform fc_debug('total do arrecad (v_resto): '||v_resto||' - v_total: '||v_total||' - totparc: '||v_totparc,lRaise,false,false);
    end if;

    for v_record_recpar in select k00_receit,
                                  sum(k00_valor)
                             from arrecad
                            where k00_numpre = v_numpre
                            group by k00_receit
    loop

      if lRaise is true then
        perform fc_debug('receita: '||v_record_recpar.k00_receit||' - valor: '||v_record_recpar.sum,lRaise,false,false);
      end if;

    end loop;

    -- se total do arrecad for diferenca do total calculado durante o processamento
    -- mostra mensagem de erro

    if lRaise then
      perform fc_debug('Parcelamento : '||v_termo||' Numpre : '||v_numpre||' Total: '||v_total||' - Resto: '||v_resto||' Diferenca: '||(round(v_total,2) - round(v_resto,2)),lRaise,false,false);
      raise notice '%',fc_debug('Fim do Processamento...',lRaise,false,true);
    end if;

    if round(v_total,2) <> round(v_resto,2) then
      return '[16] - total gerado da soma das parcelas inconsistente!';
    end if;

    return '1 - Parcelamento efetuado com sucesso - Termo Gerado: '||v_termo||' - Numpre: '||v_numpre;

  end;

$$ language 'plpgsql';insert into db_versaoant (db31_codver,db31_data) values (366, current_date);
select setval ('db_versaousu_db32_codusu_seq',(select max (db32_codusu) from db_versaousu));
select setval ('db_versaousutarefa_db28_sequencial_seq',(select max (db28_sequencial) from db_versaousutarefa));
select setval ('db_versaocpd_db33_codcpd_seq',(select max (db33_codcpd) from db_versaocpd));
select setval ('db_versaocpdarq_db34_codarq_seq',(select max (db34_codarq) from db_versaocpdarq));create table bkp_db_permissao_20160414_135119 as select * from db_permissao;
create temp table w_perm_filhos as 
select distinct 
       i.id_item        as filho, 
       p.id_usuario     as id_usuario, 
       p.permissaoativa as permissaoativa, 
       p.anousu         as anousu, 
       p.id_instit      as id_instit, 
       m.modulo         as id_modulo  
  from db_itensmenu i  
       inner join db_menu      m  on m.id_item_filho = i.id_item 
       inner join db_permissao p  on p.id_item       = m.id_item_filho 
                                 and p.id_modulo     = m.modulo 
 where coalesce(i.libcliente, false) is true;

create index w_perm_filhos_in on w_perm_filhos(filho);

create temp table w_semperm_pai as 
select distinct m.id_item       as pai, m.id_item_filho as filho 
  from db_itensmenu i 
       inner join db_menu            m  on m.id_item   = i.id_item 
       left  outer join db_permissao p  on p.id_item   = m.id_item 
                                       and p.id_modulo = m.modulo 
 where p.id_item is null 
   and coalesce(i.libcliente, false) is true;
create index w_semperm_pai_in on w_semperm_pai(filho);
insert into db_permissao (id_usuario,id_item,permissaoativa,anousu,id_instit,id_modulo) 
select distinct wf.id_usuario, wp.pai, wf.permissaoativa, wf.anousu, wf.id_instit, wf.id_modulo 
  from w_semperm_pai wp 
       inner join w_perm_filhos wf on wf.filho = wp.filho 
       where not exists (select 1 from db_permissao p 
                    where p.id_usuario = wf.id_usuario 
                      and p.id_item    = wp.pai 
                      and p.anousu     = wf.anousu 
                      and p.id_instit  = wf.id_instit 
                      and p.id_modulo  = wf.id_modulo); 
delete from db_permissao
 where not exists (select a.id_item 
                     from db_menu a 
                    where a.modulo = db_permissao.id_modulo 
                      and (a.id_item       = db_permissao.id_item or 
                           a.id_item_filho = db_permissao.id_item) );
delete from db_itensfilho    
 where not exists (select 1 from db_arquivos where db_arquivos.codfilho = db_itensfilho.codfilho);

CREATE FUNCTION acerta_permissao_hierarquia() RETURNS varchar AS $$ 

 declare  

   i integer default 1; 

   BEGIN 

  while i < 5 loop   

    insert into db_permissao select distinct 
                                 db_permissao.id_usuario, 
                                 db_menu.id_item, 
                                 db_permissao.permissaoativa, 
                                 db_permissao.anousu, 
                                 db_permissao.id_instit, 
                                 db_permissao.id_modulo 
                            from db_permissao 
                                 inner join db_menu on db_menu.id_item_filho = db_permissao.id_item 
                                                   and db_menu.modulo        = db_permissao.id_modulo 
                           where not exists ( select 1 
                                                from db_permissao as p 
                                               where p.id_item    = db_menu.id_item 
                                                 and p.id_usuario = db_permissao.id_usuario 
                                                 and p.anousu     = db_permissao.anousu 
                                                 and p.id_instit  = db_permissao.id_instit 
                                                 and p.id_modulo  = db_permissao.id_modulo );

  i := i+1; 

 end loop;

return 'Processo concluido com sucesso!';
END; 
$$ LANGUAGE 'plpgsql' ;

select acerta_permissao_hierarquia();
drop function acerta_permissao_hierarquia();create or replace function fc_executa_ddl(text) returns boolean as $$ 
  declare  
    sDDL     alias for $1;
    lRetorno boolean default true;
  begin   
    begin 
      EXECUTE sDDL;
    exception 
      when others then 
        raise info 'Error Code: % - %', SQLSTATE, SQLERRM;
        lRetorno := false;
    end;  
    return lRetorno;
  end; 
  $$ language plpgsql ;

  select fc_executa_ddl('ALTER TABLE '||quote_ident(table_schema)||'.'||quote_ident(table_name)||' ENABLE TRIGGER ALL;') 
  from information_schema.tables 
   where table_schema not in ('pg_catalog', 'pg_toast', 'information_schema')
     and table_schema !~ '^pg_temp'
     and table_type = 'BASE TABLE'
   order by table_schema, table_name;

                                                                                                       
SELECT CASE WHEN EXISTS (SELECT 1 FROM pg_authid WHERE rolname = 'dbseller')                           
  THEN fc_grant('dbseller', 'select', '%', '%') ELSE -1 END;                                           
SELECT CASE WHEN EXISTS (SELECT 1 FROM pg_authid WHERE rolname = 'plugin')                             
  THEN fc_grant('plugin', 'select', '%', '%') ELSE -1 END;                                             
SELECT fc_executa_ddl('GRANT CREATE ON TABLESPACE '||spcname||' TO dbseller;')                         
  FROM pg_tablespace                                                                                   
 WHERE spcname !~ '^pg_' AND EXISTS (SELECT 1 FROM pg_authid WHERE rolname = 'dbseller');              
                                                                                                       
  delete from db_versaoant where not exists (select 1 from db_versao where db30_codver = db31_codver); 
  delete from db_versaousu where not exists (select 1 from db_versao where db30_codver = db32_codver); 
  delete from db_versaocpd where not exists (select 1 from db_versao where db30_codver = db33_codver); 
                                                                                                       
select fc_schemas_dbportal();
