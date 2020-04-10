insert into db_versao (db30_codver, db30_codversao, db30_codrelease, db30_data, db30_obs)  values (340, 3, 25, '2014-05-26', 'Tarefas: 70948, 81079, 81397, 87405, 88241, 89734, 90175, 90592, 91073, 91399, 91527, 91681, 91754, 91824, 91864, 91881, 91994, 92098, 92159, 92192, 92210, 92238, 92239, 92315, 92410, 92433, 92534, 92573, 92589, 92592, 92601, 92618, 92646, 92664, 92710, 92719, 92721, 92723, 92759, 92871, 92875, 92876, 92890, 92891, 92903, 92914, 92915, 92923, 92926, 92934, 92936, 92940, 92946, 92949, 93003, 93006, 93077, 93158, 93163, 93174, 93178, 93215, 93311, 93312, 93333, 93347, 93363, 93368, 93384, 93385, 93386, 93436, 93442, 93451, 93482, 93494, 93512, 93513, 93516, 93517, 93547, 93548, 93565, 93582, 93617, 93635, 93655, 93657, 93688, 93697, 93723, 93802, 93829, 93849, 93868, 93875, 93880, 93916, 93977, 94012, 94013, 94059, 94069, 94114, 94119, 94156, 94220, 94257, 94295, 94310, 94359, 94395, 94462, 94478, 94515');create or replace function docentetemdisponibilidade(integer, bigint[], bigint, bigint)
  returns boolean as
$$
declare

  iRecursoHumano alias for $1;
  aPeriodos      alias for $2;
  aDiasDaSemana  alias for $3;
  iEscola        alias for $4;

  lPossuiDisponibilidade      bool default false;
  aPeriodosDisponibilidade    bigint[];
  aDiasSemanaDisponibilidade  bigint[];
  aRegencias                  bigint[];
  iTotalPeriodosOcupados      integer default 0;
  aDiasSemanaPeriodo          bigint[][];
begin

	  select array_accum(distinct ed33_i_periodo)
      into aPeriodosDisponibilidade,
           aDiasSemanaDisponibilidade
     from rechumanohoradisp
          inner join rechumanoescola on ed75_i_codigo = ed33_rechumanoescola
    where ed75_i_rechumano = iRecursoHumano
      and ed75_i_escola    = iEscola
      and ed33_i_periodo   = any(aPeriodos)
      and ed33_i_diasemana = aDiasDaSemana
      and ed33_ativo is true;
    
      raise notice '%', aPeriodosDisponibilidade;
     if coalesce(array_upper(aPeriodosDisponibilidade, 1), 0) = 0 then
       return false;
     end if;
     
     FOR j IN 1..array_upper(aPeriodosDisponibilidade, 1) LOOP
     
     
         select array_accum(ed58_i_periodo) into  aRegencias
           from regenciahorario
          where ed58_ativo is true
            and ed58_i_rechumano = iRecursoHumano
            and ed58_i_periodo   = aPeriodosDisponibilidade[j]
            and ed58_i_diasemana = aDiasDaSemana;
            
            raise notice '%', aRegencias;
          if coalesce(array_upper(aRegencias, 1), 0) > 0 then
            iTotalPeriodosOcupados := (iTotalPeriodosOcupados + 1);
          end if;
     end loop;
    if iTotalPeriodosOcupados = 0 then 
      lPossuiDisponibilidade = true;
    end if;
  return lPossuiDisponibilidade;
end;
$$
language 'plpgsql';/***
 *
 * Funcao que gera um nome temporario para a sessao do e-cidade no banco de dados
 * 
 * @author Fabrizio Mello
 * @since  13/05/2008
 *
 * $Id: session_custom_variables.sql,v 1.6 2014/05/12 17:59:50 dbfabrizio Exp $
 */
drop function if exists fc_sessionname();
create function fc_sessionname() returns text as
$$
	select 'ecidade.'::text;
$$
language sql;

/***
 *
 * Funcao que inicializa a sessao do e-cidade no banco de dados
 *
 * @author Fabrizio Mello
 * @since  24/09/2007
 *
 * $Id: session_custom_variables.sql,v 1.6 2014/05/12 17:59:50 dbfabrizio Exp $
 */
drop function if exists fc_startsession();
create function fc_startsession() returns boolean as
$$
	select
		case
			/* Se o search_path atual for o default */
			when current_setting('search_path') = '"$user",public' then
				/* entao seta o search_path com os modulos do e-cidade */
				fc_set_pg_search_path()
			else
				true
		end;
$$
language sql;

/**
 * Funcao que retorna uma variavel de sessao do sistema
 * 
 * @param sVariavel     text    Nome da Variavel para buscar o valor
 *
 * @author Fabrizio Mello
 * @since  20/06/2012
 *
 * $Id: session_custom_variables.sql,v 1.6 2014/05/12 17:59:50 dbfabrizio Exp $
 */
create or replace function fc_getsession(text) returns text as
$$
declare
	sRetorno text;
begin
	begin
		sRetorno := nullif(current_setting(fc_sessionname() || lower($1)), '');
	exception
		when others then
	end;
	return sRetorno;
end;
$$
language plpgsql;

/***
 *
 * Funcao que seta uma variavel de sessao do sistema
 * 
 * @param sVariavel     text    Nome da Variavel para setar o valor
 * @param sConteudo     text    Conteudo da variavel
 *
 * @author Fabrizio Mello
 * @since  20/06/2012
 *
 * $Id: session_custom_variables.sql,v 1.6 2014/05/12 17:59:50 dbfabrizio Exp $
 */
drop function if exists fc_putsession(text, text);
create function fc_putsession(text, text) RETURNS boolean as
$$
	select set_config(fc_sessionname() || lower($1), $2, false) = $2;
$$
language sql;

/**
 * Funcao que remove uma variavel de sessao do sistema
 * 
 * @param sVariavel     text    Nome da Variavel para setar o valor
 * @param sConteudo     text    Conteudo da variavel
 *
 * @author FabrÃ­zio Mello
 * @since  20/06/2012
 *
 * $Id: session_custom_variables.sql,v 1.6 2014/05/12 17:59:50 dbfabrizio Exp $
 */
drop function if exists fc_delsession(text);
create function fc_delsession(text) returns boolean as
$$
	select fc_putsession($1, '');
$$
language sql;

/***
 *
 * Funcao que finaliza a sessao do e-cidade no banco de dados
 * 
 *
 * @author Fabrizio Mello
 * @since  20/06/2012
 *
 * $Id: session_custom_variables.sql,v 1.6 2014/05/12 17:59:50 dbfabrizio Exp $
 */
drop function if exists fc_endsession();
create function fc_endsession() returns boolean as
$$
 	select true;
$$
language sql;

/***
 *
 * Funcao que seta o search_path do PostgreSQL de acordo com os modulos 
 * da documentacao do e-cidade
 *
 * @author Fabrizio Mello
 * @since  01/11/2008
 *
 * $Id: session_custom_variables.sql,v 1.6 2014/05/12 17:59:50 dbfabrizio Exp $
 */
create or replace function fc_set_pg_search_path() returns boolean as
$$
declare
	lRetorno   boolean default true;

	sSchemasPath text;
begin

	begin
		sSchemasPath :=
			array_to_string(
				array(
					select *
					  from (
					  	(select 'public' as nomemod)
						union all
						(select regexp_replace(lower(to_ascii(nomemod)), '[^A-Za-z]' , '', 'g') as nomemod
						   from configuracoes.db_sysmodulo)
					) as x
					where exists (select 1 from pg_namespace where nspname = nomemod)
				), ', '
			);

		perform fc_putsession('DB_pg_search_path', sSchemasPath);

		execute 'alter database '||quote_ident(current_database())||' set search_path='||sSchemasPath||';';
		execute 'set search_path='||sSchemasPath||';';

	exception
		when others then
			lRetorno := false;
	end;

	return lRetorno;
end;
$$
language 'plpgsql';

/* Para garantir que apos criada na base ela seja executada */
select fc_set_pg_search_path();-- Drop functions
drop function if exists fc_ultimodiames(integer,integer);
drop function if exists fc_ultimodiames_data(integer,integer);

-- Create functions
create or replace function fc_ultimodiames_data(integer,integer)
returns date
as $$
  select (date ($1||'-'||$2||'-'||'1') + interval '1 month' - interval '1 day')::date;
$$
immutable language sql;

create or replace function fc_ultimodiames(integer,integer)
returns integer
as $$
  select extract(day from fc_ultimodiames_data($1, $2))::integer;
$$
immutable language sql;-- Função que retorna o valor do procedimento de acordo com o ano e mês da competência passada.
-- Se no lugar do ano for passado null, obtém o valor para a competência do ano mais recente para o mês indicado.
-- Se no lugar do mês for passado null, obtém o valor para a competência do mês mais recente para o ano indicado.
-- Se mês e ano forem null, obtém o valor para a competência mais recente.
CREATE OR REPLACE FUNCTION fc_get_valor_procedimento(sProcedimento CHAR(10), iAno INT4, iMes INT4)
RETURNS FLOAT4 AS $$

DECLARE
  nValor FLOAT4;
BEGIN

  IF iAno IS NULL AND iMes IS NULL THEN

    nValor = (SELECT sau_procedimento.sd63_f_sa
                FROM sau_procedimento
                  WHERE sau_procedimento.sd63_c_procedimento = sProcedimento
                    ORDER BY sau_procedimento.sd63_i_anocomp desc, sau_procedimento.sd63_i_mescomp desc 
                      LIMIT 1);
                
  ELSEIF iAno IS NULL THEN

    nValor = (SELECT sau_procedimento.sd63_f_sa
                FROM sau_procedimento
                  WHERE sau_procedimento.sd63_c_procedimento = sProcedimento
                    AND sau_procedimento.sd63_i_mescomp = iMes
                      ORDER BY sau_procedimento.sd63_i_anocomp desc, sau_procedimento.sd63_i_mescomp desc 
                        LIMIT 1);

  ELSEIF iMes IS NULL THEN

    nValor = (SELECT sau_procedimento.sd63_f_sa
                FROM sau_procedimento
                  WHERE sau_procedimento.sd63_c_procedimento = sProcedimento
                    AND sau_procedimento.sd63_i_anocomp = iAno
                      ORDER BY sau_procedimento.sd63_i_anocomp desc, sau_procedimento.sd63_i_mescomp desc 
                        LIMIT 1);

  ELSE

    nValor = (SELECT sau_procedimento.sd63_f_sa
                FROM sau_procedimento
                  WHERE sau_procedimento.sd63_c_procedimento = sProcedimento
                    AND sau_procedimento.sd63_i_anocomp = iAno
                    AND sau_procedimento.sd63_i_mescomp = iMes
                      ORDER BY sau_procedimento.sd63_i_anocomp desc, sau_procedimento.sd63_i_mescomp desc 
                        LIMIT 1);

  END IF;

  RETURN nValor;

END
$$ language 'plpgsql';create or replace function fc_baixabanco( cod_ret integer, datausu date) returns varchar as 
$$
declare

  retorno                   boolean default false;
  
  r_codret                  record;
  r_idret                   record;
  r_divold                  record;
  r_receitas                record;
  r_idunica                 record;
  q_disrec                  record;
  r_testa                   record;
  
  x_totreg                  float8;
  valortotal                float8;
  valorjuros                float8;
  valormulta                float8;
  fracao                    float8;
  nVlrRec                   float8;
  nVlrTfr                   float8;
  nVlrRecm                  float8;
  nVlrRecj                  float8;
  
  _testeidret               integer;
  vcodcla                   integer;
  gravaidret                integer;
  v_nextidret               integer;
  conta                     integer;
  
  v_contador                integer;
  v_somador                 numeric(15,2) default 0;
  v_valor                   numeric(15,2) default 0;
  
  v_valor_sem_round         float8;
  v_diferenca_round         float8;

  dDataCalculoRecibo        date;
  dDataReciboUnica          date;
  
  v_contagem                integer;
  primeirarec               integer default 0;
  primeirarecj              integer default 0;
  primeirarecm              integer default 0;
  primeiranumpre            integer;
  primeiranumpar            integer;
  iMaiorReceitaDisrec       integer;
  iMaiorIdretDisrec         integer;
  nBloqueado                integer;
  
  valorlanc                 float8;
  valorlancj                float8;
  valorlancm                float8;
  
  oidrec                    int8;
  
  autentsn                  boolean;
  
  valorrecibo               float8;
  v_totalrecibo             float8;
                            
  v_total1                  float8 default 0;
  v_total2                  float8 default 0;
                            
  v_totvlrpagooriginal      float8;
  
  v_estaemrecibopaga        boolean;
  v_estaemrecibo            boolean;
  v_estaemarrecadnormal     boolean;
  v_estaemarrecadunica      boolean;
  lVerificaReceita          boolean;
  lClassi                   boolean;
  lVariavel                 boolean;
  lReciboPossuiPgtoParcial  boolean default false;
                            
  nSimDivold                integer;
  nNaoDivold                integer;
  iQtdeParcelasAberto       integer;
  iQtdeParcelasRecibo       integer;
  iQtdeParcelasPago         integer;
                            
  nValorSimDivold           numeric(15,2) default 0;
  nValorNaoDivold           numeric(15,2) default 0;
  nValorTotDivold           numeric(15,2) default 0;
                                          
  nValorPagoDivold          numeric(15,2) default 0;
  nTotValorPagoDivold       numeric(15,2) default 0;
                                          
  nTotalRecibo              numeric(15,2) default 0;
  nTotalNovosRecibos        numeric(15,2) default 0;
                                          
  nTotalDisbancoOriginal    numeric(15,2) default 0;
  nTotalDisbancoDepois      numeric(15,2) default 0;


  iNumnovDivold             integer;
  rContador                 record;
  iIdret                    integer;
  iCodcli                   integer;
  v_diferenca               float8 default 0;
                            
  cCliente                  varchar(100);
  iIdRetProcessar           integer;

  rValoresInconsistentes    record;
                            
  lRaise                    boolean default false;
                            
  iInstitSessao             integer;
                            
  rReciboPaga               record;


  -- Abatimentos 
  lAtivaPgtoParcial         boolean default false;
  lInsereJurMulCorr         boolean default true;
                            
  iAnoSessao                integer;
  iAbatimento               integer;
  iAbatimentoArreckey       integer;
  iArreckey                 integer;
  iArrecadCompos            integer;
  iNumpreIssVar             integer;
  iNumpreRecibo             integer;
  iNumpreReciboAvulso       integer;
  iTipoDebitoPgtoParcial    integer;
  iTipoAbatimento           integer;
  iTipoReciboAvulso         integer;
  iReceitaCredito           integer;
  iRows                     integer;
  iSeqIdRet                 integer;
  iNumpreAnterior            integer default 0;

  nVlrCalculado             numeric(15,2) default 0;
  nDescontoUnica            numeric(15,2) default 0;
  nVlrPgto                  numeric(15,2) default 0;
  nVlrJuros                 numeric(15,2) default 0;
  nVlrMulta                 numeric(15,2) default 0;
  nVlrCorrecao              numeric(15,2) default 0;
  nVlrHistCompos            numeric(15,2) default 0;
  nVlrJurosCompos           numeric(15,2) default 0;
  nVlrMultaCompos           numeric(15,2) default 0;
  nVlrCorreCompos           numeric(15,2) default 0;
  nVlrPgtoParcela           numeric(15,2) default 0;
  nVlrDiferencaPgto         numeric(15,2) default 0;
  nVlrTotalRecibopaga       numeric(15,2) default 0;
  nVlrTotalHistorico        numeric(15,2) default 0;
  nVlrTotalJuroMultaCorr    numeric(15,2) default 0;
  nVlrReceita               numeric(15,2) default 0;
  nVlrAbatido               numeric(15,2) default 0;
  nVlrDiferencaDisrec       numeric(15,2) default 0;
  nVlrInformado             numeric(15,2) default 0;
  nVlrTotalInformado        numeric(15,2) default 0;

  nVlrToleranciaPgtoParcial numeric(15,2) default 0;
  nVlrToleranciaCredito     numeric(15,2) default 0;

  nPercPgto                 numeric;
  nPercReceita              numeric;
  nPercDesconto             numeric;
                            
  sSql                      text;

  rValidaArrebanco          record;
  rRecordDisbanco           record;
  rRecordBanco              record;
  rRecord                   record;
  rRecibo                   record;
  rAcertoDiferenca          record;
  rteste record;
  
  sDebug                    text;
  /**
   * variavel de controle do numpre , se tiver ativado o pgto parcial, e essa variavel for dif. de 0
   * os numpres a partir dele serÃ£o tratados como pgto parcial, abaixo, sem pgto parcial
   */
  iNumprePagamentoParcial   integer default 0;
  
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
   * Verifica se esta configurado Pagamento Parcial
   * Buscamos o valor base setado na numpref campo k03_numprepgtoparcial
   * Consulta o tipo de debito configurado para Recibo Avulso
   * Consulta o parametro de tolerancia para pagamento parcial 
   * 
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
    
    insert into discla (
      codcla, 
      codret, 
      dtcla, 
      instit
    ) values (
      vcodcla, 
      cod_ret, 
      datausu, 
      iInstitSessao
    );
    
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
        perform fc_debug('  <PgtoParcial>  - lança recibo avulto já pago ',lRaise,false,false);
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


      insert into reciborecurso ( k00_sequen,
							      k00_numpre,
							      k00_recurso 
                                ) select nextval('reciborecurso_k00_sequen_seq'),
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

    end loop;


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
--                                  inner join arrecad on arrecad.k00_numpre = disbanco.k00_numpre 
--                                                    and arrecad.k00_numpar = disbanco.k00_numpar 
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

        dDataCalculoRecibo := rRecordDisbanco.data_vencimento_debito;

        select ru.k00_dtvenc 
          into dDataReciboUnica 
          from recibounica ru 
         where ru.k00_numpre = rRecordDisbanco.k00_numpre
           and rRecordDisbanco.k00_numpar = 0
           and ru.k00_dtvenc >= rRecordDisbanco.dtpago
         order by k00_dtvenc 
         limit 1;

        if found then
          dDataCalculoRecibo := dDataReciboUnica;
        end if;
        
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
          perform fc_debug('  <PgtoParcial>  --- dDataCalculoRecibo : ' || dDataCalculoRecibo );
          perform fc_debug('  <PgtoParcial>  --- iAnoSessao         : ' || iAnoSessao         );
          perform fc_debug('  <PgtoParcial>');
        end if;

        select * from fc_recibo(iNumpreRecibo,dDataCalculoRecibo,dDataCalculoRecibo,iAnoSessao)
          into rRecibo;
          
        if rRecibo.rlerro is true then
          return '5 - '||rRecibo.rvmensagem; 
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
							 end ;

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
        perform fc_debug('  <PgtoParcial>  - ######## 1111 incluido no naoprocesar',lRaise,false,false);
      end if;
      
      for iRows in 1..( r_idret.ocorrencias - 1 ) loop
            
          if lRaise then
            perform fc_debug('  <PgtoParcial>  - Inserindo em nao processar - Pagamento duplicado em recibos diferentes',lRaise,false,false);
            perform fc_debug('  <PgtoParcial>  - ########  incluido no naprocesar',lRaise,false,false);
          end if;
          
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
          perform fc_debug('<PgtoParcial> Continuando 1...',lRaise,false,false);
        end if;
        continue;
      end if;

      if r_idret.arrecad then
        perform 1 from arrecad where k00_numpre = r_idret.k00_numpre and k00_tipo = 3;
        if found then
          if lRaise is true then
		    perform fc_debug('<PgtoParcial> Continuando 2...',lRaise,false,false);
		  end if;
          continue;
        end if;
      elsif r_idret.arrecant then
        perform 1 from arrecant where k00_numpre = r_idret.k00_numpre and k00_tipo = 3;
        if found then
          if lRaise is true then
		    perform fc_debug('<PgtoParcial> Continuando 3...',lRaise,false,false);
		  end if;
          continue;
        end if;
      elsif r_idret.arreold then
        perform 1 from arreold where k00_numpre = r_idret.k00_numpre and k00_tipo = 3;
        if found then
          if lRaise is true then
             perform fc_debug('<PgtoParcial> Continuando 4...',lRaise,false,false);
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
    

-- return 'final';

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
                                  left join issvar as issvar_recibo           on issvar_recibo.q05_numpre         = arrecant.k00_numpre 
                                                                             and issvar_recibo.q05_numpar         = arrecant.k00_numpar
                                  left join issvar as issvar_carne            on issvar_carne.q05_numpre          = disbanco.k00_numpre 
                                                                             and issvar_carne.q05_numpar          = disbanco.k00_numpar
                                  left join arrecant as arrecant_issvar_carne on arrecant_issvar_carne.k00_numpre = disbanco.k00_numpre 
                                                                             and arrecant_issvar_carne.k00_numpar = disbanco.k00_numpar
                            where disbanco.classi is false 
                              and disbanco.codret = cod_ret 
                              and disbanco.instit = iInstitSessao
                              and ( issvar_recibo.q05_numpre is not null or ( issvar_carne.q05_numpre is not null and arrecant_issvar_carne.k00_numpre is not null) )
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
               when recibopaga.k00_numnov is not null then 
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
        perform fc_debug('  <PgtoParcial> Valor Pago na Disbanco ..: '||nVlrTotalRecibopaga                                                                   ,lRaise,false,false);
        perform fc_debug('  <PgtoParcial> ',lRaise,false,false);
      end if;
      
      for rRecord in select distinct *
                       from ( select distinct 
                                     1 as tipo,
                                     recibopaga.k00_numpre,
                                     recibopaga.k00_numpar,
                                     round(sum(recibopaga.k00_valor),2) as k00_valor 
                                from recibopaga 
                                     inner join arrecant c on c.k00_numpre = recibopaga.k00_numpre 
                                                          and c.k00_numpar = recibopaga.k00_numpar
                                                         -- and c.k00_receit = recibopaga.k00_receit
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
          perform fc_debug('  <PgtoParcial> Calculando valor informado...'                                                                             ,lRaise,false,false);
          perform fc_debug('  <PgtoParcial> Valor pago na Disbanco ...:'||rRecordDisbanco.vlrpago                                                      ,lRaise,false,false);
          perform fc_debug('  <PgtoParcial> Valor do debito ..........:'||rRecord.k00_valor                                                            ,lRaise,false,false);
          perform fc_debug('  <PgtoParcial> Valor do debito encontrado na tabela '||(case when rRecord.tipo = 1 then 'Recibopaga' else 'Disbanco' end ),lRaise,false,false);   
          perform fc_debug('  <PgtoParcial> Valor pago na disbanco ...:'||nVlrTotalRecibopaga                                                          ,lRaise,false,false);
          perform fc_debug('  <PgtoParcial> Calculo ..................: ( Valor pago na Disbanco * ((( Valor do debito * 100 ) / Valor pago na disbanco ) / 100 ))',lRaise,false,false);
          perform fc_debug('  <PgtoParcial> Valor Informado ..........: ( '||rRecordDisbanco.vlrpago||' * ((( '||rRecord.k00_valor||' * 100 ) / '||nVlrTotalRecibopaga||' ) / 100 )) = '||( rRecordDisbanco.vlrpago * ((( rRecord.k00_valor * 100 ) / nVlrTotalRecibopaga ) / 100 )) ,lRaise,false,false);
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
          nVlrTotalInformado := 0;
      
      
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
         * Foi conversado com a Catia Renata e este é o comportamento correto para a rotina.
         * 
         */
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
        return ' 6 - '||rRecibo.rvmensagem;
      end if;

      -- Acerta o conteudo da disbanco, alterando o numpre do ISSQN quitado pelo da recibopaga
      if lRaise then
        perform fc_debug('  <PgtoParcial>  - 3 - Alterando numpre disbanco ! novo numpre : '||iNumpreRecibo,lRaise,false,false);
      end if;
      
      update disbanco 
         set vlrpago = round((vlrpago - nVlrTotalInformado),2), 
             vlrtot  = round((vlrtot  - nVlrTotalInformado),2) /*, 
             vlrcalc = (vlrcalc - nVlrTotalInformado) */ 
       where idret   = rRecordDisbanco.idret;
       
       update tmpantesprocessar
         set vlrpago = round((vlrpago - nVlrTotalInformado),2) 
       where idret   = rRecordDisbanco.idret;
       
       perform * from recibopaga 
         where k00_numnov = rRecordDisbanco.k00_numpre;
         
       if not found then
       
	       update disbanco 
	          set k00_numpre = iNumpreRecibo,
	              k00_numpar = 0,
	              vlrpago    = round(nVlrTotalInformado,2),
	              vlrtot     = round(nVlrTotalInformado,2)
	        where idret      = rRecordDisbanco.idret;

          update tmpantesprocessar 
             set vlrpago    = round(nVlrTotalInformado,2)
           where idret      = rRecordDisbanco.idret;	       
	       
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
    /*******************************************************************************************************************
     *  GERA ABATIMENTOS 
     ******************************************************************************************************************/
    -- 
    -- Verifica se existe abatimentos sendo eles ( PAGAMENTO PARCIAL, CREDITO E DESCONTO )
    -- 
--return '0';

    if lRaise is true then
      perform fc_debug('  <PgtoParcial> Regra 7 - GERA ABATIMENTO ',lRaise,false,false);
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
              inner join arreckey           k    on k.k00_numpre = r.k00_numpre 
                                                and k.k00_numpar = r.k00_numpar 
                                                and k.k00_receit = r.k00_receit 
              inner join abatimentoarreckey ak   on ak.k128_arreckey   = k.k00_sequencial 
              inner join abatimentodisbanco ab   on ab.k132_abatimento = ak.k128_abatimento
        where k00_numnov    = r_idret.numpre; 
         -- and ab.k132_idret = r_idret.idret;
          
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
          
      lReciboPossuiPgtoParcial := false;

      if lRaise then
        perform fc_debug('  <PgtoParcial>  - numpre : '||r_idret.numpre||' data para pagamento : '||fc_proximo_dia_util(r_idret.k00_dtpaga)||' data que foi pago : '||r_idret.dtpago||' encontrou outro abatimento : '||found,lRaise,false,false);
      end if;

      if fc_proximo_dia_util(r_idret.k00_dtpaga) >= r_idret.dtpago and lReciboPossuiPgtoParcial is false then
                
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
        
        
        -- Acerta as origens do Recibo Avulso de acordo os Numpres da racibopaga informado  
        
        select array_to_string(array_accum(iNumpreReciboAvulso || '_' || arrematric.k00_matric || '_' || arrematric.k00_perc), ',')
          into sSql
          from recibopaga    
               inner join arrematric on arrematric.k00_numpre = recibopaga.k00_numpre
         where recibopaga.k00_numnov = r_idret.numpre; 
        
        insert into arrematric select distinct  
                                      iNumpreReciboAvulso,
                                      arrematric.k00_matric,
                                      arrematric.k00_perc
                                 from recibopaga    
                                      inner join arrematric on arrematric.k00_numpre = recibopaga.k00_numpre
                                where recibopaga.k00_numnov = r_idret.numpre; 


        insert into arreinscr  select distinct  
                                      iNumpreReciboAvulso,
                                      arreinscr.k00_inscr,
                                      arreinscr.k00_perc
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
          -- Alteracao realizada conforme solicitacao da tarefa 75450 solicitada pela Catia Renata
          --   quanto tiver um recibo com desconto manual e for realizado um pagamento parcial o sistema
          --   utiliza como valor calculado o valor liquido (valor com o desconto manual 918)
          --   e deixa o desconto perdido no arrecad, abatimentoarreckey, arreckey sendo que o mesmo ja foi utilizado
          --   para resolver, deletamos o registro de historico 918 do arrecad.
          --

          delete 
            from arrecad 
           where k00_numpre = rRecord.k00_numpre
             and k00_numpar = rRecord.k00_numpar  
             and k00_receit = rRecord.k00_receit 
             and k00_hist   = 918;
             
          delete 
            from abatimentoarreckey 
           using arreckey 
           where k00_sequencial = k128_arreckey 
             and k00_numpre = rRecord.k00_numpre
             and k00_numpar = rRecord.k00_numpar  
             and k00_receit = rRecord.k00_receit 
             and k00_hist   = 918;           

          delete 
            from arreckey
           where k00_numpre = rRecord.k00_numpre
             and k00_numpar = rRecord.k00_numpar  
             and k00_receit = rRecord.k00_receit 
             and k00_hist   = 918;

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


        -- Consulta valor total histoico do debito

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
                                  when k00_hist = 918 then 0
                                  else ( substr(fc_calcula,15,13)::float8 - substr(fc_calcula, 2,13)::float8 )::float8 
                                end as vlrcorrecao,
                                case when k00_hist = 918 then 0::float8 else substr(fc_calcula,28,13)::float8 end as vlrjuros,
                                case when k00_hist = 918 then 0::float8 else substr(fc_calcula,41,13)::float8 end as vlrmulta
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
            
            if round(nVlrPgtoParcela,2) <= 0 and rRecord.k00_hist != 918 then 
              
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
           
           select array_to_string(array_accum(distinct iNumpreReciboAvulso || '-' || arrematric.k00_matric || '-' || arrematric.k00_perc),' , ')
             into sDebug
             from recibopaga    
                  inner join arrematric on arrematric.k00_numpre = recibopaga.k00_numpre
            where recibopaga.k00_numnov = r_idret.numpre;
           
            if lRaise is true then
              perform fc_debug('  <PgtoParcial>  - '||sDebug,lRaise,false,false);
            end if;
            
           insert into arrematric select distinct  
                                         iNumpreReciboAvulso,
                                         arrematric.k00_matric,
                                         arrematric.k00_perc
                                    from recibopaga    
                                         inner join arrematric on arrematric.k00_numpre = recibopaga.k00_numpre
                                   where recibopaga.k00_numnov = r_idret.numpre; 
                                   
           insert into arreinscr  select distinct  
                                         iNumpreReciboAvulso,
                                         arreinscr.k00_inscr,
                                         arreinscr.k00_perc
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
              and recibopaga.k00_hist  != 918
              and exists ( select 1
                             from arrecad
                            where arrecad.k00_numpre = recibopaga.k00_numpre
                              and arrecad.k00_numpar = recibopaga.k00_numpar
                              and arrecad.k00_receit = recibopaga.k00_receit
                            union all                                                 
                           select 1
                             from arrecant
                            where arrecant.k00_numpre = recibopaga.k00_numpre
                              and arrecant.k00_numpar = recibopaga.k00_numpar
                              and arrecant.k00_receit = recibopaga.k00_receit
                            union all                                                 
                           select 1
                             from arreold
                            where arreold.k00_numpre = recibopaga.k00_numpre
                              and arreold.k00_numpar = recibopaga.k00_numpar
                              and arreold.k00_receit = recibopaga.k00_receit
                            union all
                           select 1
                             from arreprescr 
                            where arreprescr.k30_numpre = recibopaga.k00_numpre
                              and arreprescr.k30_numpar = recibopaga.k00_numpar
                              and arreprescr.k30_receit = recibopaga.k00_receit
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
                            and recibopaga.k00_hist  != 918
                            and exists ( select 1
                                           from arrecad
                                          where arrecad.k00_numpre = recibopaga.k00_numpre
                                            and arrecad.k00_numpar = recibopaga.k00_numpar
                                            and arrecad.k00_receit = recibopaga.k00_receit
                                          union all                                                 
                                         select 1
                                           from arrecant
                                          where arrecant.k00_numpre = recibopaga.k00_numpre
                                            and arrecant.k00_numpar = recibopaga.k00_numpar
                                            and arrecant.k00_receit = recibopaga.k00_receit
                                          union all                                                 
                                         select 1
                                           from arreold
                                          where arreold.k00_numpre = recibopaga.k00_numpre
                                            and arreold.k00_numpar = recibopaga.k00_numpar
                                            and arreold.k00_receit = recibopaga.k00_receit
                                          union all
                                         select 1
                                           from arreprescr 
                                          where arreprescr.k30_numpre = recibopaga.k00_numpre
                                            and arreprescr.k30_numpar = recibopaga.k00_numpar
                                            and arreprescr.k30_receit = recibopaga.k00_receit
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

  --        insert into tmpnaoprocessar values (r_codret.idret);
          insert into tmpnaoprocessar values (iIdret);

        elsif v_contador >= 1 then
          return '21 - IDRET ' || r_codret.idret || ' COM MAIS DE UM PAGAMENTO NO MESMO ARQUIVO. CONTATE SUPORTE PARA VERIFICAÇÕES!';
        end if;

      end if;

    end if;


     
    -- Validamos o numpre para ver se nÃ£o estÃ¡ duplicado em algum lugar
    -- arrecad(k00_numpre) = recibopaga(k00_numnov)
    -- arrecad(k00_numpre) = recibo(k00_numnov)
    -- caso esteja nÃ£o processa o numpre caindo em inconsistencia
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
         and (select count(*) from recibopaga where k00_numnov = disbanco.k00_numpre) > 0
         and disbanco.idret not in (select idret from tmpnaoprocessar)
    order by idret 
  loop

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
                                inner join divida  on divold.k10_coddiv = divida.v01_coddiv 
                                inner join arrecad on arrecad.k00_numpre = divida.v01_numpre 
                                                 and arrecad.k00_numpar = divida.v01_numpar 
             and arrecad.k00_valor > 0
                         where divold.k10_numpre = recibopaga.k00_numpre 
                           and divold.k10_numpar = recibopaga.k00_numpar 
--                         and divold.k10_receita = recibopaga.k00_receit
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
--                           and divold.k10_receita = recibopaga.k00_receit
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

        /*delete
          from disbancotxtreg
          where disbancotxtreg.k35_idret = r_codret.idret;*/
        update disbancotxtreg
           set k35_idret = v_nextidret
         where k35_idret = r_codret.idret;

        delete 
          from issarqsimplesregdisbanco
         where q44_disbanco = r_codret.idret;
        
        delete 
          from disbanco 
         where disbanco.idret = r_codret.idret;

--        return 'parou';
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
       /*  
         and case when iNumprePagamentoParcial = 0 
                  then true
                  else disbanco.k00_numpre > iNumprePagamentoParcial 
              end         
        */ 
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

      -- Verificar com Evandro porque nao Colocar o SUM direto
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

--      select setval('w_divold_seq',1);
      
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

      /*delete
        from disbancotxtreg
       where exists(select idret
                      from disbanco
                     where idret  = k35_idret
                       and codret = cod_ret); */
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
    -- fim numpre/numpar (carne)
    
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
      /*   
         and case when iNumprePagamentoParcial = 0 
                  then true
                  else disbanco.k00_numpre > iNumprePagamentoParcial 
              end         
       */  
         and disbanco.idret not in (select idret from tmpnaoprocessar)
    order by disbanco.idret 
  loop
    gravaidret := 0;
    
    -- pelo NUMPRE
    if lRaise is true then
      perform fc_debug('  <BaixaBanco>  - iniciando registro disbanco - idret '||r_codret.idret,lRaise,false,false);
    end if;

    -- T24879: Atualizar valor pago de recibo da emissao geral do ISS
    -- Verifica se Ã© recibo da emissao geral do issqn e na recibopaga esta com valor zerado
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
       /*    
	         and case when iNumprePagamentoParcial = 0 
	                  then true
	                  else disbanco.k00_numpre > iNumprePagamentoParcial 
	              end           
        */   
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
      
---      -- TESTA SE EXISTE NUMPRE E NUMPAR NO ARREIDRET, NAO EXISTINDO INSERE O IDRET DO PAGAMENTO
---      SELECT ARREIDRET.K00_NUMPRE
---             INTO _TESTEIDRET
---             FROM ARREIDRET
---             WHERE ARREIDRET.k00_NUMPRE = R_IDRET.NUMPRE 
---        AND ARREIDRET.K00_NUMPAR = R_IDRET.NUMPAR;
      
---      IF _TESTEIDRET IS NULL THEN
---             INSERT INTO ARREIDRET VALUES (R_IDRET.NUMPRE,R_IDRET.NUMPAR,R_IDRET.IDRET);
---      END IF;
      
      
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
              return '24 - Receita: '||q_disrec.k00_receit||' nÃ£o encontrada verifique o cadastro (1).';
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
      
-- comentado por evandro em 24/05/2007, pois teste abaixo da regra de 3 utiliza essa variavel e tem que ser o valor do ecibo para funcionar 
--        VALORRECIBO = R_IDRET.VLRPAGO;
      
      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - xxx - numpre: '||r_idret.numpre||' - valorrecibo: '||valorrecibo||' - vlrpago: '||r_idret.vlrpago,lRaise,false,false);
      end if;
      
      if valorrecibo = 0 then
        valorrecibo := r_idret.vlrpago;
      end if;
      
      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - recibo... vlrpago: '||r_idret.vlrpago||' - valor recibo: '||valorrecibo,lRaise,false,false);
      end if;
      
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
               datausu,
               recibo.k00_receit,
               recibo.k00_hist, 
               round((recibo.k00_valor / valorrecibo) * r_idret.vlrpago, 2),
               datausu,
               recibo.k00_numpre,
               recibo.k00_numpar,
               recibo.k00_numtot,
               recibo.k00_numdig,
               conta,
               datausu 
          from recibo 
               inner join arreinstit  on arreinstit.k00_numpre = recibo.k00_numpre
                                     and arreinstit.k00_instit = iInstitSessao
         where recibo.k00_numpre = r_idret.numpre;

      -- Verifica se o Total Pago Ã© diferente do que foi Classificado (inserido na Arrepaga)
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
      
--      FOR Q_DISREC IN 
--           SELECT RECIBO.K00_NUMPRE, 
--                  RECIBO.K00_NUMPAR,
--                  K00_RECEIT,
--                  SUM(CASE WHEN K00_VALOR = 0 THEN VLRPAGO ELSE K00_VALOR END)
      
-- alteracao evandro 24/11/2006
      for q_disrec in 
/*          select recibo.k00_numpre, 
                 recibo.k00_numpar, 
                 recibo.k00_receit, 
                 sum(recibo.k00_valor / valorrecibo * vlrpago)
            from recibo
                 inner join disbanco on disbanco.k00_numpre = recibo.k00_numpre 
           where recibo.k00_numpre = r_idret.numpre 
             and disbanco.idret    = r_codret.idret
             and disbanco.instit   = iInstitSessao
        group by recibo.k00_numpre, 
                 recibo.k00_numpar, 
                 recibo.k00_receit, 
                 disbanco.vlrpago 
-- alterado fabrizio 26/06/2009 (Tarefa 26900)
                 */
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
              return '25 - Receita: '||q_disrec.k00_receit||' nÃ£o encontrada verifique o cadastro (2).';
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
      
--if R_IDRET.numpre = 11479037 and R_IDRET.numpar = 2 THEN
-- lRaise = true;
--ELSE
--  lRaise = false;
--END IF;
      
      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - codret : '||r_codret.codret||'-idret : '||r_codret.idret,lRaise,false,false);
      end if;
      
---      SELECT arreidret.K00_NUMPRE
---             INTO _TESTEIDRET
---             FROM ARREIDRET
---             WHERE arreidret.k00_NUMPRE = R_IDRET.NUMPRE 
---        AND arreidret.K00_NUMPAR = R_IDRET.NUMPAR;
---      
---      IF _TESTEIDRET IS NULL THEN
---             INSERT INTO ARREIDRET VALUES (R_IDRET.NUMPRE,R_IDRET.NUMPAR,R_IDRET.IDRET);
---      END IF;
      
      --select sum(arrecad.k00_valor) 
      --  into x_totreg 
      --  from arrecad 
      --       inner join arreinstit  on arreinstit.k00_numpre = arrecad.k00_numpre
      --                             and arreinstit.k00_instit = iInstitSessao
      --       inner join disbanco    on disbanco.k00_numpre = arrecad.k00_numpre
      --                             and disbanco.k00_numpar = arrecad.k00_numpar
      --                             and disbanco.instit = iInstitSessao
      -- where arrecad.k00_numpre  = r_idret.numpre
      --   and arrecad.k00_numpar  = r_idret.numpar;
      
      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - arrecad - numpre: '||r_idret.numpre||' - numpar: '||r_idret.numpar||' - tot: '||x_totreg||' - pago: '||r_idret.vlrpago,lRaise,false,false);
      end if;
      
      --if ( ( x_totreg = 0 or x_totreg is null ) and r_idret.numpar != 0 ) then
      --  update disbanco 
      --     set vlrcalc = vlrtot
      --   where idret  = r_codret.idret
      --     and codret = r_codret.codret
      --     and instit = r_idret.instit;
      --else
        
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
        
      --end if;
      
      if not r_idret.numpre is null then
        
        if lRaise is true then
          perform fc_debug('  <BaixaBanco>  - aaaaaaaaaaaaaaaaaaaaaaaa',lRaise,false,false);
        end if;
        
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
                  return '26 - Receita: '||q_disrec.k00_receit||' nÃ£o encontrada verifique o cadastro (3).';
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
              -- ModificaÃ§Ã£o realizada devido ao erro gerado na tarefa 32607
              -- Motivo do erro:
              -- Foi pego o valor de 72.83 para um numpre de ISSQN Var, quando o arquivo do banco retornou, o  estava com valor zero no arrecad 
              -- O que ocasionava erro nas linhas abaixo pois a variavel nVlrTfr que e resultado do somatorio do valor do  na tabela arrecad e 
              -- utilizado para a divisÃ£o do valor da receita abaixo, estava igual a zero. 
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
                  return '27 - Receita: '||q_disrec.k00_receit||' nÃ£o encontrada verifique o cadastro (4).';
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
      
      /* Comentado pois essa validacao deve ser realizada no inicio do processamento
         e adicionado registro na tabela temporaria "tmpnaoprocessar"
      perform * 
         from issvar 
              inner join disbanco on disbanco.k00_numpre = issvar.q05_numpre
        where disbanco.idret = r_codret.idret
          and disbanco.k00_numpar = 0 ;
      if found then
        lClassi = false;
      else
        lClassi = true;
      end if;*/

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
  
  -- select v_total1 + sum(round(tmpantesprocessar.vlrpago,2))
  --   into v_total1
  --   from tmp_classificaoesexecutadas
  --        inner join disrec            on disrec.codcla            = tmp_classificaoesexecutadas.codigo_classificacao
  --        inner join tmpantesprocessar on tmpantesprocessar.idret  = disrec.idret;
   
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
       where disrec.codcla /* = vcodcla;*/
       in (select codigo_classificacao 
               from tmp_classificaoesexecutadas);
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

$$ language 'plpgsql'; 
----drop function fc_calcula(integer,integer,integer,date,date,integer);
create or replace function fc_calcula(integer,integer,integer,date,date,integer) returns varchar as 
$$
begin
  return fc_calcula($1, $2, $3, $4, $5, $6, null);
end
$$
language 'plpgsql';

create or replace function fc_calcula(integer,integer,integer,date,date,integer,varchar) returns varchar as 
$$
declare
  numpre          alias for $1;
  numpar          alias for $2;
  creceita        alias for $3;
  dtemite         alias for $4;
  dtvenc          alias for $5;
  subdir          alias for $6;
  nomedebitos     alias for $7; -- Nome alternativo para a tabela debitos (default = debitos)
  
  iFormaCorrecao integer default 2;
  iInstit        integer;

  v_subdir        integer;
  numero_erro     char(1) default '1';    
  v_debitos       record;
  record_numpre   record;
  record_alias    record;
  record_grava    record;
  record_numpref  record;
  v_composicao    record;

  venc_unic       date default current_date;
  venc_unic1      date;
  venc_unic2      date;
  num_par         integer;
  
  valor_receita   float8 default 0;
  correcao        float8 default 0;
  juro            float8 default 0;
  multa           float8 default 0;
  desconto        float8 default 0;
  valor_hist      float8 default 0;
  receita         integer;
  
  v_recjur        integer default 0;
  v_recmul        integer default 0;

  v_integr        boolean;
  
  k00_operac      integer;
  k06_operac      integer;
  k09_operac      integer;
  qualoperac      boolean default false;
  dtoper          date;
  datavenc        date;
  unica           boolean default false;
  
  sqlrecibo       char(255);
  
  vlrestorno      float8 default 0;
  vlrcorrecao     float8 default 0;
  vlrjuros        float8 default 0;
  vlrmulta        float8 default 0;
  vlrdesconto     float8 default 0;
  vlrinflator     float8 default 0;
  nperccalc       float8 default 100;
  qrinflator      varchar(5);
  vlrtotinf       float8 default 0;
  qinflator       varchar(5);
  calcula         boolean;
  processa        boolean default false;
  issqnvariavel   boolean default false;
  v_exerc           integer;
  v_dtoper        date;
  v_calculoinfla  float8;
  
  totperc             float8  default 0;
  nao_tem_recibo  boolean default false;

  lRaise         boolean default false;
  
  nValorHistorico float8 default 0;
  nValorCorrecao  float8 default 0;
  nValorJuros     float8 default 0;
  nValorMulta     float8 default 0;
  nValorDesconto  float8 default 0;
  
  nAcumHistorico  float8 default 0;
  nAcumCorrecao   float8 default 0;
  nAcumJuros      float8 default 0;
  nAcumMulta      float8 default 0;
  nAcumDesconto   float8 default 0;

  -- diferencas das proporcionalidades arrematric e arreinscr
  nDiferencaHis   float8 default 0;
  nDiferencaCor   float8 default 0;
  nDiferencaJur   float8 default 0;
  nDiferencaMul   float8 default 0;
  nDiferencaDes   float8 default 0;

  nComposCorrecao   numeric(15,2) default 0;
  nComposJuros      numeric(15,2) default 0;
  nComposMulta      numeric(15,2) default 0;

  nCorreComposJuros numeric(15,2) default 0;
  nCorreComposMulta numeric(15,2) default 0;

  nPercMulta float8 default 0;

  historic        integer default 0;

  sNomeDebitos    varchar default 'debitos';

begin

  lRaise := ( case when fc_getsession('DB_debugon') is null then false else true end );
  if lRaise is true then
     if fc_getsession('db_debug') <> '' then  
       perform fc_debug('<calcula> Processando calculo de correcao, juros e multa...', lRaise, false, false);
     else 
       perform fc_debug('<calcula> Processando calculo de correcao, juros e multa...', lRaise, true, false);
     end if;
  end if;
  
  select k00_instit
    into iInstit
    from arreinstit
   where k00_numpre = numpre;

  if iInstit is null then
    select codigo
      into iInstit
      from db_config
     where prefeitura is true
     limit 1;
  end if;

  if nomedebitos is not null or trim(nomedebitos) <> '' then
    sNomeDebitos := nomedebitos;
  end if;

  v_subdir := subdir;
  if v_subdir >= 10000 then
    v_subdir := v_subdir - 10000;
  end if;

  select k03_separajurmulparc
    into iFormaCorrecao
    from numpref
   where k03_instit = iInstit
     and k03_anousu = v_subdir;
  if lRaise is true then
    perform fc_debug('<calcula> numpre: '||numpre||' - iFormaCorrecao: '||iFormaCorrecao, lRaise, false,false);
  end if;
  
  select k03_recjur, k03_recmul 
  into v_recjur, v_recmul 
  from numpref 
  order by k03_anousu desc limit 1;
  
--  numpre := to_number(numpre,'99999999');
--  numpar := to_number(numpar,'999');
--raise notice 'ok';
  for record_numpre in select distinct * from (select distinct k00_numpre,k00_numpar  
    from arrecad
    where k00_numpre = numpre  
    union all
    select distinct recibo.k00_numpre,recibo.k00_numpar
    from recibo
    left outer join arrepaga on recibo.k00_numpre = arrepaga.k00_numpre
    where recibo.k00_numpre = numpre and arrepaga.k00_numpre is null
    union all
    select distinct k99_numpre_n,1 as k00_numpar
    from db_reciboweb
    where k99_numpre_n = numpre 
    ) as x
    order by k00_numpre,k00_numpar loop
    
--  raise notice 'aqui%',numpre;
    
    if numpar != 0 then
      if lRaise is true then
        perform fc_debug('<calcula> numpar diferente de 0',lRaise,false,false);
      end if;
      if record_numpre.k00_numpar != numpar then
        num_par := 0;
      else
        num_par := numpar;
      end if;
    else
      if lRaise is true then
        perform fc_debug('<calcula> numpar igual a 0',lRaise,false,false);
      end if;
      num_par := record_numpre.k00_numpar;
      unica := true;   
    end if;
    
    if lRaise is true then
      perform fc_debug('<calcula> numpar: '||num_par||' - unica: '||unica, lRaise,false,false);
    end if;
    
    if num_par != 0 then
      
      valor_receita := 0;
      
      for record_alias in  select * from 
        (select *,'arrecad' as db_arquivo from 
        (select k00_hist,k00_receit,k00_tipo,k00_dtoper,fc_calculavenci(k00_numpre,k00_numpar,k00_dtvenc,dtemite) as k00_dtvenc,k00_numpre,k00_numpar,k00_valor as k00_valor 
        from arrecad
        where k00_numpre = numpre and k00_numpar = num_par 
        --group by k00_receit,k00_tipo,k00_dtoper,k00_dtvenc,k00_numpre,k00_numpar
        ) as xx
        union all
        select *,'recibo' as db_arquivo from 
        (select k00_hist, k00_receit,k00_tipo,k00_dtoper,k00_dtvenc,k00_numpre as k00_numpre,k00_numpar,k00_valor as k00_valor 
        from recibo
        where k00_numpre = numpre and k00_numpar = num_par 
        --group by k00_receit,k00_tipo,k00_dtoper,k00_dtvenc,k00_numpre,k00_numpar
        ) as xy
        union all
        select *,'recuni' as db_arquivo from 
        (select k00_hist, k00_receit,k00_hist as k00_tipo,k00_dtoper,k00_dtvenc,k00_numnov as k00_numpre,0 as k00_numpar,k00_valor as k00_valor 
        from recibopaga
        where k00_numnov = numpre and k00_conta = 0 
        --group by k00_receit,k00_tipo,k00_dtoper,k00_dtvenc,k00_numnov,k00_numpar
        ) as xz
        ) as x
        order by k00_numpre,k00_numpar,k00_receit,k00_hist loop
        --
        if lRaise is true then
          perform fc_debug('<calcula> arquivo: '||record_alias.db_arquivo||' - valor: '||record_alias.k00_valor, lRaise, false, false);
        end if;
        
        if record_alias.db_arquivo = 'arrecad' then
          
          --raise notice 'arrecad';
          nao_tem_recibo = true;
          
          if record_alias.k00_valor = 0 then
            if unica = true then
            
              if lRaise is true then
                perform fc_debug('<calcula> 1 - Fim do processamento do calculo de correcao, juros e multa...', lRaise, false, true);
              end if;            
              return '6          0.0         0.00         0.00         0.00         0.00                   0.000000';
              
            else
              -- variavel
              if record_alias.k00_tipo != 3 then
              
                if lRaise is true then
                  perform fc_debug('<calcula> 2 - Fim do processamento do calculo de correcao, juros e multa...', lRaise, false, true);
                end if;              
                return '7          0.0         0.00         0.00         0.00         0.00                   0.000000';
                
              end if;
            end if;
          end if;
          calcula = false;
          if ( creceita <> 0 and creceita = record_alias.k00_receit ) or creceita = 0 then 
            calcula = true;
          end if;

          if calcula = true then
            
            if lRaise is true then
              perform fc_debug('<calcula>    calcula: '||calcula,lRaise, false,false);
            end if;

            venc_unic     := dtvenc;
            receita       := record_alias.k00_receit;
            dtoper        := record_alias.k00_dtoper;
            datavenc      := record_alias.k00_dtvenc;
            valor_receita := record_alias.k00_valor;
            if valor_receita = 0 then
              select case when q05_valor != 0 then q05_valor else q05_vlrinf end  
              into valor_receita
              from issvar where q05_numpre = record_alias.k00_numpre and
              q05_numpar = record_alias.k00_numpar;
              if valor_receita is null then
                valor_receita := 0;
              else
                issqnvariavel := true;
              end if;
            end if;
            valor_hist := valor_hist + round(valor_receita, 2);
            qualoperac := false;
            -- calcula correcao 
            processa := true;


            if lRaise is true then
              perform fc_debug('<calcula>    numpre : '||record_alias.k00_numpre||' numpar : '||record_alias.k00_numpar||' receita : '||record_alias.k00_receit||' valor_receita : '||valor_receita||' k00_valor : '||record_alias.k00_valor||' iFormaCorrecao : '||iFormaCorrecao, lRaise, false,false);
            end if;


            if valor_receita <> 0 then 

              if iFormaCorrecao = 1 then

                  select rnCorreComposJuros, rnCorreComposMulta, rnComposCorrecao, rnComposJuros, rnComposMulta
                    into nCorreComposJuros, nCorreComposMulta, nComposCorrecao, nComposJuros, nComposMulta
                    from fc_retornacomposicao(record_alias.k00_numpre, record_alias.k00_numpar, record_alias.k00_receit, record_alias.k00_hist, dtoper, dtvenc, v_subdir, datavenc);

                  if lRaise is true then
                    perform fc_debug('<calcula> valor_receita: '||valor_receita||' - nComposCorrecao: '||nComposCorrecao,lRaise, false, false);
                  end if;

                  valor_receita = valor_receita + nComposCorrecao;

                  if lRaise is true then
                    perform fc_debug('<calcula>    valor_receita: '||valor_receita||' - nComposCorrecao: '||nComposCorrecao, lRaise, false, false);
                  end if;

              end if;

              if lRaise is true then
                perform fc_debug('<calcula>    nComposCorrecao: '||nComposCorrecao||' - nCorreComposJuros: '||nCorreComposJuros||' - nCorreComposMulta: '||nCorreComposMulta||' - nComposJuros: '||nComposJuros||' - nComposMulta: '||nComposMulta, lRaise, false, false);
                perform fc_debug('<calcula> '||receita||' - '||dtoper||' - '||valor_receita||' - '||venc_unic||' - '||v_subdir||' - '||datavenc, lRaise, false, false);
              end if;

              correcao := fc_corre(receita,dtoper,valor_receita,venc_unic,v_subdir,datavenc);
  
              if lRaise is true then
                perform fc_debug('<calcula>   correcao (2): '||correcao, lRaise, false, false);
              end if;

              correcao := correcao + nCorreComposJuros + nCorreComposMulta;

              if lRaise is true then
                perform fc_debug('<calcula> correcao (3): '||correcao, lRaise, false, false);
              end if;

              if correcao = 0 then
              
                if lRaise is true then
                  perform fc_debug('<calcula> 3 - Fim do processamento do calculo de correcao, juros e multa...', lRaise, false, true);
                end if;              
                return '9          0.0         0.00         0.00         0.00         0.00                   0.000000';
                
              end if;

              correcao := round( correcao - valor_receita , 2 );

            else
              correcao := 0;
            end if;

            vlrcorrecao := vlrcorrecao + correcao + valor_receita;
            
            if lRaise is true then
              perform fc_debug('<calcula>    vlrcorrecao: '||vlrcorrecao||' - correcao: '||correcao||' - valor_receita: '||valor_receita, lRaise, false, false);
            end if;

            if ( valor_receita + correcao ) <> 0 then

              select k02_integr
              into v_integr
              from tabrec
              inner join tabrecjm on tabrec.k02_codjm = tabrecjm.k02_codjm
              where k02_codigo = receita;

              if lRaise is true then
                perform fc_debug('<calcula> v_integr: '||v_integr||' - unica: '||unica, lRaise, false, false);
              end if;

              if v_integr is null then
                v_integr = false;
              end if;

              if lRaise is true then
                perform fc_debug('<calcula> unica: '||unica||' - v_integr: '||v_integr, lRaise, false, false);
              end if;

              if unica is false or (unica is true and v_integr is not true) then
                if lRaise is true then
                  perform fc_debug('<calcula>  receita: '||receita||' - datavenc: '||datavenc||' - dtemite: '||dtemite||' - dtoper: '||dtoper||' - v_subdir: '||v_subdir, lRaise, false, false);
                  perform fc_debug('<calcula>  fc_juros('||receita||','||datavenc||','||dtemite||','||dtoper||',false,'||v_subdir||')', lRaise, false, false);
                end if;
                juro  := round(( correcao+valor_receita) * fc_juros(receita,datavenc,dtemite,dtoper,false,v_subdir)::numeric(20,10) ,2);
                juro = round(juro + nComposJuros,2);
                -- calcula multa
                nPercMulta = fc_multa(receita,datavenc,dtemite,dtoper,v_subdir)::numeric(20,10);
                multa := round( round( correcao+valor_receita ,2) * fc_multa(receita,datavenc,dtemite,dtoper,v_subdir)::numeric(20,10) ,2);
                multa = round(multa + nComposMulta,2);

                if lRaise is true then
                  perform fc_debug('<calcula> k03_recjur: '||v_recjur||' - k03_recmul: '||v_recmul, lRaise, false, false);
                  perform fc_debug('<calcula> --- aqui: multa: '||multa||' - correcao: '||correcao||' - valor_receita: '||valor_receita||' - nComposMulta: '||nComposMulta||' - percmulta: '||nPercMulta, lRaise, false, false);
                end if;
                
                if v_recjur = 0 or 
                  v_recmul = 0 or
                  v_recjur = v_recmul then
                  if juro+multa <> 0 then
                    vlrjuros := vlrjuros + juro;
                    vlrmulta := vlrmulta + multa;
                  end if;
                else
                  if juro <> 0 then
                    vlrjuros := vlrjuros + juro;
                  end if;
                  if multa <> 0 then
                    vlrmulta := vlrmulta + multa;
                  end if;
                end if;
              end if;
              --calcular desconto
              -- somente para sapiranga
              
              if correcao+valor_receita <> 0 then
                
                if lRaise is true then
                  perform fc_debug('<calcula> desconto '||receita||' - '||venc_unic||'-'||valor_receita||'-'||juro||'-'||unica||'-'||datavenc||'-'||v_subdir, lRaise, false, false);
                  perform fc_debug('<calcula> desconto - rec: '||receita||' - venc_unic: '||venc_unic||' - correc: '||correcao||' - vlrrec: '||valor_receita||' - juro: '||juro||' - unica: '||unica||' - dtvenc: '||datavenc||' - subdir: '||v_subdir, lRaise, false, false);
                end if;
                
                desconto := fc_desconto(receita,venc_unic,correcao+valor_receita,juro+multa,unica,datavenc,v_subdir,record_alias.k00_numpre)::numeric(20,10);
                
                if lRaise is true then
                  perform fc_debug('<calcula>    desconto calculado: '||desconto, lRaise, false, false);
                end if;
                
                if desconto <> 0 then
                  vlrdesconto := vlrdesconto + desconto;
                end if; 
                
                if lRaise is true then
                  perform fc_debug('<calcula> desconto '||desconto, lRaise, false, false);
                end if;
                
              end if; 
              
              select k02_corr 
              into qinflator
              from tabrec
              inner join tabrecjm on tabrec.k02_codjm = tabrecjm.k02_codjm
              where k02_codigo = receita;
              if not qinflator is null then
                vlrinflator := correcao + valor_receita + juro + multa - desconto;
                if lRaise is true then
                  perform fc_debug('<calcula> correcao: '||correcao||' - valor_receita: '||valor_receita||' - juro: '||juro||' - multa: '||multa||' - desconto: '||desconto, lRaise, false, false);
                end if;
                if lRaise is true then
                  perform fc_debug('<calcula> vlrinflator: '||vlrinflator||' - qinflator: '||qinflator||' - venc_unic: '||venc_unic, lRaise, false, false);
                end if;
                v_calculoinfla := fc_vlinf(qinflator,venc_unic);
                if v_calculoinfla = 0 then
                  v_calculoinfla = 0;
                else
                  select round(vlrinflator/v_calculoinfla,6)
                  into vlrinflator;
                end if;
                vlrtotinf  := vlrtotinf + vlrinflator;
                qrinflator := qinflator;
              end if;
              
            end if;
          end if; 
        else
          if record_alias.k00_tipo = 400 then
            vlrjuros := vlrjuros + record_alias.k00_valor;
          else
            if record_alias.k00_tipo = 401 then
              vlrmulta := vlrmulta + record_alias.k00_valor;
            else
              vlrcorrecao := vlrcorrecao + record_alias.k00_valor ;
            end if;
          end if ;
          
          processa := true;
          
        end if;
        
      end loop;
      
    end if;
    
  end loop;
  
  if processa = true then
    if vlrcorrecao+vlrjuros+vlrmulta = 0 then
      if issqnvariavel = true then
      
        if lRaise is true then
          perform fc_debug('<calcula> 4 - Fim do processamento do calculo de correcao, juros e multa...', lRaise, false, true);
        end if;      
        return '8          0.0         0.00         0.00         0.00         0.00                   0.000000';
        
      else
      
        if lRaise is true then
          perform fc_debug('<calcula> 5 - Fim do processamento do calculo de correcao, juros e multa...', lRaise, false, true);
        end if;      
        return '5          0.0         0.00         0.00         0.00         0.00                   0.000000';
        
      end if;
    else
      if vlrtotinf is null then
        vlrtotinf := 0;
      end if;
      if qrinflator is null then
        qrinflator := '   ';
      end if;
--raise notice '%-%-%-%-%-%-%-%-%', numero_erro,valor_hist,vlrcorrecao,vlrjuros,vlrmulta,vlrdesconto,venc_unic,vlrtotinf,qrinflator;
      if subdir >= 10000 then

        -- cria consulta preparada para os numpres que serao inseridos na debitos
        begin
--            raise notice 'cria sql preparado';
          prepare select_debitos(integer, integer, integer) as 
            select distinct
                   deb.*,
                   arreinstit.k00_instit,
                   arretipo.k03_tipo
              from (
                  select arrecad.k00_numpre,
                         arrecad.k00_numpar,
                         arrecad.k00_receit,
                         arrecad.k00_dtvenc,
                         arrecad.k00_dtoper,
                         case
                           when promitente.j41_matric is null then iptubase.j01_numcgm
                           else promitente.j41_numcgm
                         end as k00_numcgm,
                         arrematric.k00_matric,
                         arrematric.k00_perc as k00_percmatric,
                         cast(0 as integer)  as k00_inscr,
                         cast(0 as float8)   as k00_percinscr,
                         arrecad.k00_tipo
                    from arrecad
                         inner join arrematric on arrematric.k00_numpre = arrecad.k00_numpre
                         inner join iptubase   on iptubase.j01_matric   = arrematric.k00_matric
                         left join promitente  on promitente.j41_matric = arrematric.k00_matric
                                              and promitente.j41_tipopro is true
                   where arrecad.k00_numpre = $1
                     and arrecad.k00_numpar = $2
                     and arrecad.k00_receit = $3
                  union all
                  select arrecad.k00_numpre,
                         arrecad.k00_numpar,
                         arrecad.k00_receit,
                         arrecad.k00_dtvenc,
                         arrecad.k00_dtoper,
                         arrecad.k00_numcgm,
                         cast(0 as integer)  as k00_matric,
                         cast(0 as float8)   as k00_percmatric,
                         arreinscr.k00_inscr as k00_inscr,
                         arreinscr.k00_perc  as k00_percinscr,
                         arrecad.k00_tipo
                    from arrecad
                         inner join arreinscr  on arreinscr.k00_numpre  = arrecad.k00_numpre
                   where arrecad.k00_numpre = $1
                     and arrecad.k00_numpar = $2
                     and arrecad.k00_receit = $3
                  union all
                  select arrecad.k00_numpre,
                         arrecad.k00_numpar,
                         arrecad.k00_receit,
                         arrecad.k00_dtvenc,
                         arrecad.k00_dtoper,
                         arrecad.k00_numcgm,
                         cast(0 as integer)  as k00_matric,
                         cast(0 as float8)   as k00_percmatric,
                         cast(0 as integer)  as k00_inscr,
                         cast(0 as float8)   as k00_percinscr,
                         arrecad.k00_tipo
                    from arrecad
                         inner join arrenumcgm on arrenumcgm.k00_numpre = arrecad.k00_numpre
                         left  join arreinscr  on arreinscr.k00_numpre  = arrecad.k00_numpre
                         left  join arrematric on arrematric.k00_numpre = arrecad.k00_numpre
                   where arrecad.k00_numpre = $1
                     and arrecad.k00_numpar = $2
                     and arrecad.k00_receit = $3
                     and arreinscr.k00_numpre is null
                     and arrematric.k00_numpre is null
                  ) as deb
                  inner join arreinstit on arreinstit.k00_numpre = deb.k00_numpre
                  inner join arretipo   on arretipo.k00_tipo     = deb.k00_tipo;

        prepare select_exerc_tipo_5(integer, integer) as
            select v01_exerc
              from divida
             where v01_numpre = $1
               and v01_numpar = $2
             limit 1;

        prepare select_exerc_tipo_18(integer, integer) as
            select case when divida.v01_exerc is null then extract (year from arrecad.k00_dtoper) else divida.v01_exerc end
              from arrecad
                   inner join inicialnumpre on inicialnumpre.v59_numpre = arrecad.k00_numpre
                   inner join inicialcert   on inicialcert.v51_inicial  = inicialnumpre.v59_inicial
                   inner join certid        on certid.v13_certid        = inicialcert.v51_certidao
                   inner join certdiv       on certdiv.v14_certid       = certid.v13_certid
                   inner join divida        on certdiv.v14_coddiv       = divida.v01_coddiv
                                           and divida.v01_numpre        = arrecad.k00_numpre
                                           and divida.v01_numpar        = arrecad.k00_numpar
            where arrecad.k00_numpre = $1
              and arrecad.k00_numpar = $2
            limit 1;

        prepare select_dtoper_termo(integer) as
            select v07_dtlanc
              from termo
             where v07_numpre = $1
             limit 1;

        exception when duplicate_prepared_statement then
        end;

        for v_debitos in execute 'execute select_debitos('||numpre||', '||numpar||', '||receita||')'
        loop
          v_exerc := null; 
          if v_debitos.k03_tipo = 5 then
            execute 'execute select_exerc_tipo_5('||numpre||', '||numpar||')'
               into v_exerc;
          elsif v_debitos.k03_tipo = 18 then 
            execute 'execute select_exerc_tipo_18('||numpre||', '||numpar||')'
               into v_exerc;
          end if;

          if v_debitos.k03_tipo in (6, 21, 28, 30) then
            execute 'execute select_dtoper_termo('||numpre||')'
               into v_dtoper;
            if v_dtoper is null then
              v_dtoper := v_debitos.k00_dtoper;
            end if;
          else
            v_dtoper := v_debitos.k00_dtoper;
          end if;

          if v_exerc is null then
            v_exerc := to_char(v_debitos.k00_dtoper, 'yyyy');
          end if;
         
          if v_debitos.k00_percmatric > 0 and v_debitos.k00_percmatric::float8 <> 100::float8 then
            nperccalc := v_debitos.k00_percmatric::float8;
          elsif v_debitos.k00_percinscr > 0 and v_debitos.k00_percinscr::float8 <> 100::float8 then
            nperccalc := v_debitos.k00_percinscr::float8;
          else
            nperccalc := 100::float8;
          end if;

          -- acumula valor historico para comparar com o arrecad
          nValorHistorico := round( (valor_hist  * nperccalc/100)::float8 ,2);
          nValorCorrecao  := round( (vlrcorrecao * nperccalc/100)::float8 ,2);
          nValorJuros     := round( (vlrjuros    * nperccalc/100)::float8 ,2);
          nValorMulta     := round( (vlrmulta    * nperccalc/100)::float8 ,2);
          nValorDesconto  := round( (vlrdesconto * nperccalc/100)::float8 ,2);

          nAcumHistorico  := nAcumHistorico + nValorHistorico;
          nDiferencaHis   := round(valor_hist - nAcumHistorico, 2);

          nAcumCorrecao   := nAcumCorrecao + nValorCorrecao;
          nDiferencaCor   := round(vlrcorrecao - nAcumCorrecao, 2);

          nAcumJuros      := nAcumJuros + nValorJuros;
          nDiferencaJur   := round(vlrjuros - nAcumJuros, 2);

          nAcumMulta      := nAcumMulta + nValorMulta;
          nDiferencaMul   := round(vlrmulta - nAcumMulta, 2);

          nAcumDesconto   := nAcumDesconto + nValorDesconto;
          nDiferencaDes   := round(vlrdesconto - nAcumDesconto, 2);

          -- efetuar acerto dos centavos do valor historico
          if abs(nDiferencaHis) = cast(0.01 as float8) then
            nValorHistorico := nValorHistorico + nDiferencaHis;
          end if;

          -- efetuar acerto dos centavos do valor corrigido
          if abs(nDiferencaCor) = cast(0.01 as float8) then
            nValorCorrecao := nValorCorrecao + nDiferencaCor;
          end if;

          -- efetuar acerto dos centavos do valor juros
          if abs(nDiferencaJur) = cast(0.01 as float8) then
            nValorJuros := nValorJuros + nDiferencaJur;
          end if;

          -- efetuar acerto dos centavos do valor multa
          if abs(nDiferencaMul) = cast(0.01 as float8) then
            nValorMulta := nValorMulta + nDiferencaMul;
          end if;

          -- efetuar acerto dos centavos do valor desconto
          if abs(nDiferencaDes) = cast(0.01 as float8) then
            nValorDesconto := nValorDesconto + nDiferencaDes;
          end if;

          select k00_hist 
            into historic
            from arrecad 
           where k00_numpre = v_debitos.k00_numpre 
             and k00_numpar = v_debitos.k00_numpar 
             and k00_receit = v_debitos.k00_receit 
           limit 1;

        -- Verifica datas da debitos
        -- if not exists(select 1 from datadebitos where k115_data = dtemite and k115_instit = v_debitos.k00_instit) then
        --      insert into datadebitos (k115_sequencial, k115_data, k115_instit) 
        --                                              values (nextval('datadebitos_k115_sequencial_seq'),dtemite,v_debitos.k00_instit);
        -- end if;


          execute '
            insert into '||sNomedebitos||'
                               (k22_data ,
                                k22_numpre,
                                k22_numpar,
                                k22_receit,
                                k22_dtvenc,
                                k22_dtoper,
                                k22_hist  ,
                                k22_numcgm,
                                k22_matric,
                                k22_inscr ,
                                k22_tipo  ,
                                k22_vlrhis,
                                k22_vlrcor,
                                k22_juros ,
                                k22_multa ,
                                k22_desconto,
                                k22_exerc,
                                k22_instit )
                       values ( '||quote_literal(dtemite)||',
                                '||coalesce(v_debitos.k00_numpre, 0)||',
                                '||coalesce(v_debitos.k00_numpar, 0)||',
                                '||coalesce(v_debitos.k00_receit, 0)||',
                                '||quote_literal(v_debitos.k00_dtvenc)||',
                                '||quote_literal(v_dtoper)||',
                                '||coalesce(historic, 0)||',
                                '||coalesce(v_debitos.k00_numcgm, 0)||',
                                '||coalesce(v_debitos.k00_matric, 0)||',
                                '||coalesce(v_debitos.k00_inscr, 0)||',
                                '||coalesce(v_debitos.k00_tipo, 0)||',
                                '||coalesce(nValorHistorico, 0.0)||',
                                '||coalesce(nValorCorrecao, 0.0)||',
                                '||coalesce(nValorJuros, 0.0)||',
                                '||coalesce(nValorMulta, 0.0)||',
                                '||coalesce(nValorDesconto, 0.0)||',
                                '||coalesce(v_exerc, 0)||',
                                '||coalesce(v_debitos.k00_instit, 0)||')' ; 
          
        end loop;
        
        if lRaise is true then
          perform fc_debug('<calcula> 6 - Fim do processamento do calculo de correcao, juros e multa...', lRaise, false, true);
        end if;        
        return '0          0.0         0.00         0.00         0.00         0.00                   0.000000';
        
      else
      
        if lRaise is true then
          perform fc_debug('<calcula> 7 - Fim do processamento do calculo de correcao, juros e multa...', lRaise, false, true);
        end if;      
        return trim(numero_erro) || to_char(valor_hist,'999999990.00')|| to_char(vlrcorrecao,'999999990.00') || to_char(vlrjuros,'999999990.00') || to_char(vlrmulta,'999999990.00') || to_char(vlrdesconto,'999999990.00') || to_char(venc_unic,'yyyy-mm-dd') || to_char(vlrtotinf,'999999990.000000')||qrinflator;
        
      end if;
    end if;
  else
-- criar select para pegar valor do estorno ver possibilidade
-- de listar pela data de pagamento
    if numpar = 0 then
      select sum(k00_valor)
      into vlrcorrecao
      from arrepaga
      where k00_numpre = numpre ;
    else
      select sum(k00_valor)
      into vlrcorrecao
      from arrepaga
      where k00_numpre = numpre and k00_numpar = numpar;      
    end if;
    if vlrcorrecao is null then
      select round(sum(k00_valor),2) as sum
      into vlrcorrecao
      from db_reciboweb,arrepaga
      where db_reciboweb.k99_numpre   = arrepaga.k00_numpre and
      db_reciboweb.k99_numpar   = arrepaga.k00_numpar and
      db_reciboweb.k99_numpre_n = numpre;
      if vlrcorrecao is null then
      
        if lRaise is true then
          perform fc_debug('<calcula> 8 - Fim do processamento do calculo de correcao, juros e multa...', lRaise, false, true);
        end if;      
        return '9          0.0         0.00         0.00         0.00         0.00                   0.000000';
        
      else
        
        select round(sum(k00_valor),2) as sum
        into vlrestorno
        from recibopaga
        where k00_numnov = numpre;
        if vlrestorno != vlrcorrecao then
        
          if lRaise is true then
            perform fc_debug('<calcula> 9 - Fim do processamento do calculo de correcao, juros e multa...', lRaise, false, true);
          end if;        
          return '2' || to_char(vlrcorrecao,'999999990.00');
          
        else
        
          if lRaise is true then
            perform fc_debug('<calcula> 10 - Fim do processamento do calculo de correcao, juros e multa...', lRaise, false, true);
          end if;        
          return '4' || to_char(vlrcorrecao,'999999990.00');
          
        end if;
        
      end if;
    else
    
      if lRaise is true then
        perform fc_debug('<calcula> 11 - Fim do processamento do calculo de correcao, juros e multa...', lRaise, false, true);
      end if;    
      return '4' || to_char(vlrcorrecao,'999999990.00');
      
    end if;
  end if;
  
  if lRaise is true then
    perform fc_debug('<calcula> 12 - Fim do processamento do calculo de correcao, juros e multa...', lRaise, false, true);
  end if;  
  return '9          0.0         0.00         0.00         0.00         0.00                   0.000000';
  
end;
$$ language 'plpgsql';drop function if exists fc_calculoiptu_cap_2008(integer,integer,boolean,boolean,boolean,boolean,boolean,integer,integer);

create or replace function fc_calculoiptu_cap_2008(integer,integer,boolean,boolean,boolean,boolean,boolean,integer,integer) returns varchar(100) as
$$

declare

   iMatricula 	  	alias   for $1; -- matricula
   iAnousu    	  	alias   for $2; -- exercicio
   bGerafinanc      alias   for $3; -- gera financeiro
   bAtualizap    	 	alias   for $4; -- atualiza parcela
   bNovonumpre	  	alias   for $5; -- novo numpre
   bCalculogeral   	alias   for $6; -- calculo geral
   bDemo        		alias   for $7; -- gera demonstrativo
   iParcelaini     	alias   for $8; -- parcela inicial
   iParcelafim     	alias   for $9; -- parcela final

   iIdbql           integer default 0;
   iNumcgm          integer default 0;
   iCodcli          integer default 0;
   iCodisen         integer default 0;
   iTipois          integer default 0;
   iParcelas        integer default 0;
   iNumconstr       integer default 0;
   iZona            integer default 0;
   iCodErro         integer default 0;

   dDatabaixa       date;

   nAreal           numeric default 0;
   nAreaTotalC      numeric default 0;
   nAreac           numeric default 0;
   nTotarea         numeric default 0;
   nFracao          numeric default 0;
   nFracaolote      numeric default 0;
   nAliquota        numeric default 0;
   nIsenaliq        numeric default 0;
   nArealo          numeric default 0;
   nVvc             numeric(15,2) default 0;
   nVvt             numeric(15,2) default 0;
   nVv              numeric(15,2) default 0;
   nViptu           numeric(15,2) default 0;
   nValorInflator   numeric(15,2) default 0;

   tRetorno         text default '';
   tDemo            text default '';

   bFinanceiro      boolean;
   bDadosIptu       boolean;
   bErro            boolean;
   bIsentaxas       boolean;
   bTempagamento    boolean;
   bEmpagamento     boolean;
   bTaxasCalculadas boolean;
   bRaise           boolean default false; -- true para habilitar raise na funcao principal
   bSubRaise        boolean default false; -- true para habilitar raise nas sub-funcoes

   rCfiptu          record;

begin

   bRaise    := false;   -- true para abilitar raise notice na funcao principal
   bSubRaise := false;   -- true para abilitar raise notice nas sub-funcoes

  if bRaise then
    raise notice 'IDBQL - %  AREAL - %  FRACAO - %  CGM - %   DATABAIXA - %   ERRO - %  RETORNO - %',  iIdbql,  nAreal,  nFracao,  iNumcgm,  dDatabaixa, bErro, tRetorno;
  end if;



  /* VERIFICA SE OS PARAMETROS PASSADOS ESTAO CORRETOS */
  select riidbql, rnareal, rnfracao, rinumcgm, rdbaixa, rberro, rtretorno
    into iIdbql,  nAreal,  nFracao,  iNumcgm,  dDatabaixa, bErro, tRetorno
    from fc_iptu_verificaparametros(iMatricula,iAnousu,iParcelaini,iParcelafim);
  if bRaise then
    raise notice 'IDBQL - %  AREAL - %  FRACAO - %  CGM - %   DATABAIXA - %   ERRO - %  RETORNO - %',  iIdbql,  nAreal,  nFracao,  iNumcgm,  dDatabaixa, bErro, tRetorno;
  end if;

  /* VERIFICA SE O CALCULO PODE SER REALIZADO */
  select rbErro,
         riCodErro
    into bErro,
         iCodErro
    from fc_iptu_verificacalculo(iMatricula,iAnousu,iParcelaini,iParcelafim);
  if bErro is true and bDemo is false then
    select fc_iptu_geterro(iCodErro,'') into tRetorno;
    return tRetorno;
  end if;

  /* VERIFICA SE MATRICULA ESTA BAIXADA */
  if dDataBaixa is not null and to_char(dDataBaixa,'Y')::integer <= iAnousu then

     /* criar funcao para exclusao de calculo */

     delete from arrecad using iptunump where k00_numpre = iptunump.j20_numpre and iptunump.j20_anousu = iAnousu and iptunump.j20_matric = iMatricula;
     delete from iptunump where j20_anousu = iAnousu and j20_matric = iMatricula;

     select fc_iptu_geterro(2, '') into tRetorno;
     return tRetorno;

  end if;


  /* CRIA AS TABELAS TEMPORARIAS */
  select * into bErro from fc_iptu_criatemptable(bSubRaise);

  /* GUARDA OS PARAMETROS DO CALCULO */
  select *
    from cfiptu into rCfiptu
	       left join infla on i02_codigo = j18_infla
	                      and extract (year from i02_data) = j18_anousu
	where j18_anousu = iAnousu;

  if rCfiptu.i02_valor is null then
     select fc_iptu_geterro(99, 'SEM VALOR DO INFLATOR CONFIGURADO!') into tRetorno;
     return tRetorno;
  end if;

  /* FRACIONA LOTE */
  if bRaise then
    raise notice 'PARAMETROS IPTU_FRACIONALOTE FRACAO DO LOTE : % -- % -- % -- % ',iMatricula, iAnousu, bDemo, bSubRaise;
  end if;
  select rnfracao, rtdemo, rtmsgerro, rberro
    into nFracaolote, tDemo, tRetorno, bErro
    from fc_iptu_fracionalote(iMatricula,iAnousu,bDemo,bSubRaise);
    update tmpdadosiptu set fracao = nFracaolote;
  if bRaise then
    raise notice 'RETORNO FC_IPTU_FRACIONALOTE --->>> FRACAO DO LOTE : % - DEMONS : % - MSGRETORNO : % - ERRO : % ',nFracaolote, tDemo, tRetorno, bErro;
  end if;

  /* VERIFICA PAGAMENTOS */
  if bRaise then
    raise notice 'PARAMETROS fc_iptu_verificapag VERIFICANDO PARGAMENTOS  : % -- % -- % -- % ',iMatricula, iAnousu, bDemo, bSubRaise;
  end if;
  select rbtempagamento, rbempagamento, rtmsgretorno, rberro
    into bTempagamento, bEmpagamento, tRetorno, bErro
    from fc_iptu_verificapag(iMatricula,iAnousu,bCalculogeral,bAtualizap,false,bDemo,bSubRaise);
  if bRaise then
    raise notice 'RETORNO fc_iptu_verificapag -->>> TEMPAGAMENTO : % -- EMPAGAMENTO % -- RETORNO % -- ERRO % ',bTempagamento, bEmpagamento, tRetorno, bErro;
  end if;

  /* CALCULA VALOR DO TERRENO */
  if bRaise then
    raise notice 'PARAMETROS fc_iptu_calculavvt_cap_2008  IDBQL : % -- FRACAO DO LOTE % -- DEMO % -- ERRO % ',iIdbql, nFracaolote, tRetorno, bErro;
  end if;
  select rnvvt, rnAreaTotalC,rnarea, rtdemo, rtmsgerro, rberro
    into nVvt, nAreaTotalC, nAreac, tDemo, tRetorno, bErro
    from fc_iptu_calculavvt_cap_2008(iIdbql, nFracaolote, iAnousu, bDemo, bSubRaise);
  if bRaise then
    raise notice 'RETORNO fc_iptu_calculavvt_cap_2008 -->>> Area Total Corrigida: % VVT : % -- AREA CORRIGIDA % --  RETORNO % -- ERRO % ',nAreaTotalC, nVvt, nAreac, tRetorno, bErro;
  end if;

  if bErro = true then
    select fc_iptu_geterro(6, '') into tRetorno;
    return tRetorno;
  end if;

  /* VERIFICA ISENCOES */
  if bRaise then
    raise notice 'PARAMETROS fc_iptu_verificaisencoes  MATRICULA % -- ANOUSU % -- DEMO % -- ERRO % ', iMatricula, iAnousu, bDemo, bSubRaise;
  end if;
  select ricodisen, ritipois, rnisenaliq, rbisentaxas, rnarealo
    into iCodisen, iTipois, nIsenaliq, bIsentaxas, nArealo
    from fc_iptu_verificaisencoes(iMatricula,iAnousu,bDemo,bSubRaise);
  if iTipois is not null then
    update tmpdadosiptu set tipoisen = iTipois;
  end if;
  if bRaise then
    raise notice 'RETORNO fc_iptu_verificaisencoes -->>> CODISEN : % -- TIPOISEN : % --  ALIQ INSEN : % -- INSENTAXAS: % -- AREALO : % ',iCodisen, iTipois, nIsenaliq, bIsentaxas, nArealo;
  end if;

  /* CALCULA VALOR DA CONSTRUCAO */
  if bRaise then
    raise notice 'PARAMETROS fc_iptu_calculavvc_cap_2008  MATRICULA % -- ANOUSU % -- DEMO % -- ERRO % ', iMatricula, iAnousu, bDemo, bSubRaise;
  end if;

     --
     -- Atenção!
     -- No calculo do valor venal da construção o inflator e o seu valor podem ser alterados de acordo com a caracteristica
     -- da construção do grupo 6.
     -- Se a caracteristica for 60 ou 61 o inflator utilizado será o CUB
     -- Se a caracteristica for 62 ou 66 o inflator utilizado será o CUB_C
     -- Do contrário será o valor do inflator configurado nos parâmetros do IPTU
     --
   select case
            when j35_caract in (60,61)
              then ( select i02_valor from infla where extract (year from i02_data) = iAnousu and i02_codigo = 'CUB')
            when j35_caract in (62,66)
              then ( select i02_valor from infla where extract (year from i02_data) = iAnousu and i02_codigo = 'CUB_C')
          end
     into nValorInflator
     from carlote
          inner join caracter on caracter.j31_codigo = carlote.j35_caract
    where j31_grupo = 6
      and j35_idbql = iIdbql;
    if nValorInflator = 0 then
      nValorInflator = rCfiptu.i02_valor::numeric;
    end if;

  select rnvvc, rntotarea, rinumconstr, rtdemo, rtmsgerro, rberro
    into nVvc, nTotarea, iNumconstr, tDemo, tRetorno, bErro
    from fc_iptu_calculavvc_cap_2008(iMatricula,iAnousu, nValorInflator::numeric, bDemo,bSubRaise);
  if bRaise then
    raise notice 'RETORNO fc_iptu_calculavvc_cap_2008 -->>> VVC : % -- AREA TOTAL : % --  NUMERO DE CONTRUCOES : % -- RETORNO : % -- ERRO : % ', nVvc, nTotarea, iNumconstr, tRetorno, bErro;
  end if;
  if nVvc is null or nVvc = 0 and iNumconstr <> 0 then
     select fc_iptu_geterro(22, '') into tRetorno;
     return tRetorno;
  end if;
	if bErro is true then
     select fc_iptu_geterro(22, '') into tRetorno;
     return tRetorno;
	end if;

  /* BUSCA A ALIQUOTA  */
  -- so executar se nao for isento
  if iNumconstr is not null and iNumconstr > 0 then
      select fc_iptu_getaliquota_cap_2008(iMatricula,iIdbql,iNumcgm,true,bSubRaise) into nAliquota;
  else
      select fc_iptu_getaliquota_cap_2008(iMatricula,iIdbql,iNumcgm,false,bSubRaise) into nAliquota;
  end if;

  if not found or nAliquota = 0 then
     select fc_iptu_geterro(13, '') into tRetorno;
     return tRetorno;
  end if;

/*--------- CALCULA O VALOR VENAL -----------*/

  nVv    := nVvc + nVvt;

  nViptu := nVv * ( nAliquota / 100 );

/*-------------------------------------------*/
  select count(*)
    into iParcelas
    from cadvencdesc
         inner join cadvenc on q92_codigo = q82_codigo
   where q92_codigo = rCfiptu.j18_vencim ;
  if not found or iParcelas = 0 then
     select fc_iptu_geterro(14, '') into tRetorno;
     return tRetorno;
  end if;

  select j34_zona
  into iZona
  from lote where j34_idbql = iIdbql;

  perform predial from tmpdadosiptu where predial is true;
  if found then
    insert into tmprecval values (rCfiptu.j18_rpredi, nViptu, 1, false);
  else
    insert into tmprecval values (rCfiptu.j18_rterri, nViptu, 1, false);
  end if;

  update tmpdadosiptu set viptu = nViptu, codvenc = rCfiptu.j18_vencim , aliq = nAliquota;

  update tmpdadostaxa set anousu = iAnousu, matric = iMatricula, idbql = iIdbql, valiptu = nViptu, valref = rCfiptu.j18_vlrref, vvt = nVvt, nparc = iParcelas, zona = iZona, totareaconst = nTotArea ;

/* CALCULA AS TAXAS */
  select db21_codcli
    into iCodcli
    from db_config;

  if bRaise then
    raise notice 'PARAMETROS fc_iptu_calculataxas  ANOUSU % -- CODCLI % ',iAnousu, iCodcli;
  end if;


  select fc_iptu_calculataxas(iMatricula,iAnousu,iCodcli,bSubRaise)
     into bTaxasCalculadas;

  -- aqui eu coloquei sei que nao esta no padrao
  --select fc_iptu_taxalixo(3,1,2,0,1,true)
  --   into tDemo;

  if bRaise then
    raise notice 'RETORNO fc_iptu_calculataxas --->>> TAXASCALCULADAS - %',bTaxasCalculadas;
  end if;

/* MONTA O DEMONSTRATIVO */
  select fc_iptu_demonstrativo(iMatricula,iAnousu,iIdbql,bSubRaise )
     into tDemo;

/* GERA FINANCEIRO */
  if bDemo is false then -- Se nao for demonstrativo gera o financeiro, caso contrario retorna o demonstrativo
    select fc_iptu_geradadosiptu(iMatricula,iIdbql,iAnousu,nIsenaliq,bDemo,bSubRaise)
      into bDadosIptu;
      if bGerafinanc then
        select fc_iptu_gerafinanceiro(iMatricula,iAnousu,iParcelaini,iParcelafim,bCalculogeral,bTempagamento,bNovonumpre,bDemo,bSubRaise)
          into bFinanceiro;
      end if;
  else
     return tDemo;
  end if;

  if bDemo is false then
     update iptucalc set j23_manual = tDemo where j23_matric = iMatricula and j23_anousu = iAnousu;
  end if;

  select fc_iptu_geterro(1, '') into tRetorno;
  return tRetorno;

end;
$$  language 'plpgsql';--create type tp_iptu_calculavvc as (rnVvc       numeric(15,2),
--                                   rnTotarea   numeric,
--                                   riNumconstr integer,
--                                   rtDemo      text,
--                                   rtMsgerro   text,
--                                   rbErro      boolean,
--                                   riCodErro   integer,
--                                   rtErro      text);
drop function if exists fc_iptu_calculavvc_cap_2008(integer,integer,numeric(15,4),boolean,boolean);
create or replace function fc_iptu_calculavvc_cap_2008(integer,integer,numeric(15,4),boolean,boolean) returns tp_iptu_calculavvc as
$$
declare

  iMatricula                   alias for $1;
  iAnousu                      alias for $2;
  ni02_valor                   alias for $3;
  bMostrademo                  alias for $4;
  bRaise                       alias for $5;

  nAreaconstr                  numeric default 0;
  nValorConstr                 numeric(15,2) default 0;
  nValor                       numeric(15,2) default 0;
  nPerc					       numeric(15,2) default 0;

  iNumerocontr                 integer default 0;
  iAuxMatric                   integer default 0;

  iObsolencia                  integer default 1;
  nFatorObsolencia             numeric(15,2) default 0;

  tSql                         text    default '';
  bAtualiza                    boolean default true;
  rConstr                      record;

  rtp_iptu_calculavvc tp_iptu_calculavvc%ROWTYPE;

  begin
  -- SEPARAR PARA TRATAR MELHOR OS ERROS, TIRAR O INNER COM CARVALOR PQ PODE HAVER CONSTRUCAO SEM VALOR LANCADO
    if bRaise then
      raise notice 'INICIANDO CALCULO VVC ...';
    end if;

    rtp_iptu_calculavvc.rnVvc       := 0;
    rtp_iptu_calculavvc.rnTotarea   := 0;
    rtp_iptu_calculavvc.riNumconstr := 0;
    rtp_iptu_calculavvc.rtDemo      := '';
    rtp_iptu_calculavvc.rtMsgerro   := 'Retorno ok' ;
    rtp_iptu_calculavvc.rbErro      := 'f';
    rtp_iptu_calculavvc.riCodErro   := 0;
    rtp_iptu_calculavvc.rtErro      := '';

    tSql := ' select iptuconstr.j39_matric,
                     j39_idcons,
                     j39_ano,
                     iptuconstr.j39_matric,
                     j39_idcons,
                     j39_area::numeric,
                     (select sum(j31_pontos)
                        from carconstr
                             inner join caracter on j48_caract = j31_codigo
                       where j48_matric = iptuconstr.j39_matric
                         and j48_idcons = iptuconstr.j39_idcons) as j31_pontos,
                     (select j48_caract
                        from carconstr
                             inner join caracter on j48_caract = j31_codigo
                       where j48_matric = iptuconstr.j39_matric
                         and j48_idcons = iptuconstr.j39_idcons
                         and j31_grupo = 20) as j48_tipoconst,
                     (select j48_caract
                        from carconstr
                             inner join caracter on j48_caract = j31_codigo
                       where j48_matric = iptuconstr.j39_matric
                         and j48_idcons = iptuconstr.j39_idcons
                         and j31_grupo = 8) as j48_paredes
                from iptuconstr
               where iptuconstr.j39_matric = '||iMatricula||'
                 and j39_dtdemo is null';

    if bRaise then
      raise notice '%', tSql;
    end if;

    for rConstr in execute tSql loop

      if not rConstr.j48_tipoconst in ( 189, 192, 193 ) then

        if rConstr.j48_tipoconst = 191 then

          if rConstr.j48_paredes = 83 then
            nPerc = 0.30;
          elseif rConstr.j48_paredes = 82 then
            nPerc = 0.20;
          else
            nPerc = 0.15;
          end if;

        else

          if rConstr.j31_pontos between 0 and 29 then
            nPerc = 0.20;
          elseif rConstr.j31_pontos between 30 and 49 then
            nPerc = 0.30;
          elseif rConstr.j31_pontos between 50 and 69 then
            nPerc = 0.50;
          elseif rConstr.j31_pontos between 70 and 89 then
            nPerc = 0.70;
          elseif rConstr.j31_pontos between 90 and 100 then
            nPerc = 0.90;
          end if;

        end if;

        select iAnousu - rConstr.j39_ano into iObsolencia;

--        raise notice 'obso: %', iObsolencia;

        if iObsolencia <= 3 then
          nFatorObsolencia := 1;
        elsif iObsolencia <= 6 then
          nFatorObsolencia := 0.93;
        elsif iObsolencia <= 9 then
          nFatorObsolencia := 0.86;
        elsif iObsolencia <= 12 then
          nFatorObsolencia := 0.79;
        elsif iObsolencia <= 15 then
          nFatorObsolencia := 0.72;
        elsif iObsolencia <= 18 then
          nFatorObsolencia := 0.65;
        elsif iObsolencia <= 21 then
          nFatorObsolencia := 0.58;
        elsif iObsolencia <= 24 then
          nFatorObsolencia := 0.51;
        elsif iObsolencia <= 27 then
          nFatorObsolencia := 0.44;
        elsif iObsolencia <= 30 then
          nFatorObsolencia := 0.37;
        else
          nFatorObsolencia := 0.30;
        end if;

        nValor       := nPerc * ni02_valor;
        nValor       := nValor * nFatorObsolencia;
        iNumerocontr := iNumerocontr + 1;
        nAreaconstr  := nAreaconstr + rConstr.j39_area;
        nValorConstr := nValorConstr + (nValor * rConstr.j39_area);

        insert into tmpiptucale (anousu, matric,idcons,areaed,vm2,pontos,valor)
        values (iAnousu,iMatricula,rConstr.j39_idcons,rConstr.j39_area,nValor,rConstr.j31_pontos,nValor * rConstr.j39_area);
        if bAtualiza then
          update tmpdadosiptu set predial = true;
          bAtualiza = false;
        end if;

      end if;

    end loop;

    perform j39_matric from iptuconstr where j39_matric = iMatricula and j39_dtdemo is null limit 1;

    if found then

      perform matric from tmpiptucale limit 1;

      if not found and not rConstr.j48_tipoconst in ( 189, 192, 193 ) then
        rtp_iptu_calculavvc.rtDemo      := 'sem caracteristica lancada';
        rtp_iptu_calculavvc.rbErro      := 't';
      else

        rtp_iptu_calculavvc.rnVvc       := nValorConstr;
        rtp_iptu_calculavvc.rnTotarea   := nAreaconstr::numeric;
        rtp_iptu_calculavvc.riNumconstr := iNumerocontr;
        rtp_iptu_calculavvc.rtDemo      := '';
        rtp_iptu_calculavvc.rbErro      := 'f';

--        raise notice 'valor: %', rtp_iptu_calculavvc.rnVvc;

        update tmpdadosiptu set vvc = rtp_iptu_calculavvc.rnVvc;

      end if;

    end if;

    return rtp_iptu_calculavvc;

  end;
  $$  language 'plpgsql';--drop function fc_iptu_calculavvt_cap_2008(integer,numeric,integer,boolean,boolean);

--drop   type tp_iptu_calculavvt;

--create type tp_iptu_calculavvt as (rnVvt     numeric(15,2),
--                                   rnAreaTotalC    numeric,
--                                   rnArea    numeric,
--                                   rnTestada   numeric,
--                                   rtDemo    text,
--                                   rtMsgerro text,
--                                   rbErro    boolean,
--                                   riCoderro integer,
--                                   rtErro    text);
drop function if exists fc_iptu_calculavvt_cap_2008(integer,numeric,integer,boolean,boolean);
create or replace function fc_iptu_calculavvt_cap_2008(integer,numeric,integer,boolean,boolean) returns tp_iptu_calculavvt as
$$
declare

    iIdbql       alias for $1;
    nFracao      alias for $2;
    iAnousu      alias for $3;
    bMostrademo  alias for $4;
    bRaise       alias for $5;

    rnAreaTotLote numeric;
    rnArealote    numeric;
    rnTestada     numeric;
    nValor       numeric;
    nTestada     numeric;
    rtp_iptu_calculavvt tp_iptu_calculavvt%ROWTYPE;

begin

    rtp_iptu_calculavvt.rnVvt        := 0;
    rtp_iptu_calculavvt.rnAreaTotalC := 0;
    rtp_iptu_calculavvt.rnArea       := 0;
    rtp_iptu_calculavvt.rnTestada    := 0;
    rtp_iptu_calculavvt.rtDemo       := '';
    rtp_iptu_calculavvt.rtMsgerro    := '';
    rtp_iptu_calculavvt.rbErro       := 'f';
    rtp_iptu_calculavvt.riCoderro    := 0;
    rtp_iptu_calculavvt.rtErro       := '';

    if bRaise then
      raise notice 'INICIANDO CALCULO DO VALOR VENAL TERRITORIAL...';
    end if;

    select	j34_area,
						case when coalesce(j36_testle,0) > 0 then j36_testle else  coalesce(j36_testad,0) end
      into	rnArealote,
						rnTestada
      from lote
	   inner join testpri on j49_idbql = j34_idbql
	   inner join face    on j37_face  = j49_face
	   inner join testada on j36_idbql = j34_idbql and j36_face = j49_face
    where j34_idbql = iIdbql;

--    raise notice 'area: %', rnArealote;

		if rnArealote <= 600 then

			select j72_valor
			into nValor
			from carlote
			inner join lote on j34_idbql = j35_idbql
			inner join caracter on j35_caract = j31_codigo
			inner join carzonavalor on j72_caract = j35_caract and j72_anousu = iAnousu and j72_tipo = 'T'
			where j35_idbql = iIdbql and j31_grupo = 3 and j72_zona = j34_zona;

    else

			select j72_valor
			into nValor
			from lote
			inner join carzonavalor on j72_caract = 12 and j72_anousu = iAnousu and j72_tipo = 'P'
			where j34_idbql = iIdbql and j72_zona = j34_zona and rnArealote between j72_quantini and j72_quantfim;

--      raise notice 'valor: % - iIdbql: % - rnArealote: %', nValor, iIdbql, rnArealote;

		end if;

    if not found or rnTestada = null or rnTestada = 0 then
      rtp_iptu_calculavvt.rnVvt     := 0;
      rtp_iptu_calculavvt.rnAreaTotalC    := 0;
      rtp_iptu_calculavvt.rnArea    := 0;
      rtp_iptu_calculavvt.rnTestada    := 0;
      rtp_iptu_calculavvt.rtDemo    := '';
      rtp_iptu_calculavvt.rtMsgerro := ' Valor m2 do terreno nao encontrado na tabela face ';
      rtp_iptu_calculavvt.rbErro    := 't';
      return rtp_iptu_calculavvt;
    end if;

    rnAreaTotLote                 := rnArealote;

    rtp_iptu_calculavvt.rnAreaTotalC    := rnAreaTotLote;

    rnAreaTotLote                 := rnAreaTotLote * (nFracao / 100);

--    raise notice 'rnTestada: %', rnTestada;

    rtp_iptu_calculavvt.rnArea    := rnAreaTotLote;
    rtp_iptu_calculavvt.rnTestada := rnTestada;
    rtp_iptu_calculavvt.rnVvt     := rnAreaTotLote * nValor;
    rtp_iptu_calculavvt.rtDemo    := '';
    rtp_iptu_calculavvt.rtMsgerro := '';
    rtp_iptu_calculavvt.rbErro    := 'f';

    update tmpdadosiptu set vvt = rtp_iptu_calculavvt.rnVvt, vm2t=nValor, areat=rnAreaTotLote, testada = rnTestada;

    return rtp_iptu_calculavvt;

end;
$$ language 'plpgsql';drop function if exists fc_iptu_getaliquota_cap_2008(integer,integer,integer,boolean,boolean);
create or replace function fc_iptu_getaliquota_cap_2008(integer,integer,integer,boolean,boolean) returns numeric as
$$
declare

    iMatricula alias for $1;
    iIdbql     alias for $2;
    iNumcgm    alias for $3;
    bPredial   alias for $4;
    bRaise     alias for $5;

    rnAliq           numeric default 0;
    cSetor           char(4);
    cQuadra          char(4);
    iCaract          integer default 0;
    iImoTerritoriais integer default 0;
    iNumcalculos     integer default 0;

begin
  /* EXECUTAR SOMENTE SE NAO TIVER ISENCAO */
  if bRaise then
      raise notice 'DEFININDO QUAL ALIQUOTA APLICAR ...';
      raise notice 'IPTU : %', case when bPredial is true then 'PREDIAL' else 'TERRITORIAL' end;
  end if;

  /* conta qntos anos ja foram calculados */
  --select coalesce(count(*),0) into iNumcalculos from iptucalc where j23_matric = iMatricula and j23_anousu >= 2007 ;

  select case when bPredial = false then j30_aliter else j30_alipre end,
         j34_setor,
         j34_quadra
    into rnAliq,
         cSetor,
         cQuadra
    from iptubase
        inner join lote on j01_idbql = j34_idbql
        inner join setor on j34_setor  = j30_codi
  where j01_matric = iMatricula;

  /* Para os lotes da quadra 26 do setor 15 e os lotes da quadra 11 do setor 16 que são considerados distritos, a alíquota do IPTU é diferenciada, sendo:
      0,20 % para predial
      0,50% para territorial. */
  if  ((cQuadra = '0026' and cSetor = '0015') or (cQuadra = '0011' and cSetor = '0016')) and bPredial is true  then
      rnAliq := 0.20;
  elseif ((cQuadra = '0026' and cSetor = '0015') or (cQuadra = '0011' and cSetor = '0016')) and bPredial is false  then
      rnAliq := 0.50;
  end if;

  if bRaise then
    raise notice 'ALIQUOTA FINAL - %',rnAliq;
  end if;

  if rnAliq is null or rnAliq = 0 then
     return 0;
  end if;

  return rnAliq;

end;
$$  language 'plpgsql';drop view empresa;

create or replace view empresa as
select issbase.q02_inscr, 
       q02_dtcada, 
       q02_dtinic, 
       q02_dtbaix,
       q07_ativ, 
       q07_perman, 
       q03_descr, 
       q07_datain, 
       q07_datafi, 
       q07_databx, 
       q07_quant, 
       q07_tipbx,
       to_ascii(cgm.z01_nome,'LATIN2') as z01_nome, 
       cgm.z01_nomecomple, 
       to_ascii(cgm2.z01_nome,'LATIN2') as q02_escrit, 
       cgm.z01_nomefanta, 
       cgm.z01_cgccpf,
       cgm.z01_incest,
       case 
         when issruas.q02_inscr   is null 
           then cgm.z01_ender    
         else ruas.j14_nome       
       end as z01_ender,
       case 
         when issruas.q02_inscr   is null 
           then ''               
         else j88_sigla
       end as j14_tipo,
       case 
         when (cgm.z01_nomecomple is null or trim(cgm.z01_nomecomple) = '')       
           then cgm.z01_nome   
         else cgm.z01_nomecomple    
       end as razao,
       case when issruas.q02_inscr   is null then cgm.z01_numero   else issruas.q02_numero  end as z01_numero,
       case when issruas.q02_inscr   is null then cgm.z01_compl    else issruas.q02_compl   end as z01_compl,
       case when issruas.q02_inscr   is null then cgm.z01_cxpostal else issruas.q02_cxpost  end as z01_cxpostal,
       case when issruas.z01_cep     is null then cgm.z01_cep      else issruas.z01_cep     end as z01_cep,
       case when issbairro.q13_inscr is null then cgm.z01_bairro   else bairro.j13_descr    end as z01_bairro,
       case when issruas.q02_inscr   is null then cgm.z01_munic    else (select munic from db_config where prefeitura = true limit 1) end as z01_munic,
       case when issruas.q02_inscr   is null then cgm.z01_uf       else (select uf from db_config where prefeitura = true limit 1) end as z01_uf,
       case when issruas.q02_inscr   is null then 0        else issruas.j14_codigo  end as q02_lograd,    
       case when issbairro.q13_inscr is null then 0        else bairro.j13_codi     end as q02_bairro,
       cgm.z01_telef,q02_numcgm, q03_atmemo, q02_memo,
       case when q88_inscr is not null then 'P' else 'S' end as q88_tipo,
       q02_inscmu,
       cgm.z01_ident 
  from issbase
       inner join cgm                 on cgm.z01_numcgm         = issbase.q02_numcgm
        left outer join issruas       on issruas.q02_inscr      = issbase.q02_inscr
        left outer join ruas          on issruas.j14_codigo     = ruas.j14_codigo
        left outer join ruastipo      on ruas.j14_tipo          = ruastipo.j88_codigo
        left outer join issbairro     on issbairro.q13_inscr    = issbase.q02_inscr
        left outer join bairro        on issbairro.q13_bairro   = bairro.j13_codi
        left outer join issmatric     on issmatric.q05_inscr    = issbase.q02_inscr
        left outer join iptubase      on iptubase.j01_matric    = issmatric.q05_matric
        left outer join issprocesso   on issprocesso.q14_inscr  = issbase.q02_inscr
       inner join tabativ             on tabativ.q07_inscr      = issbase.q02_inscr
        left join ativprinc           on ativprinc.q88_inscr    = tabativ.q07_inscr 
                                     and ativprinc.q88_seq      = tabativ.q07_seq
       inner join ativid              on tabativ.q07_ativ       = ativid.q03_ativ
        left outer join escrito       on escrito.q10_inscr      = issbase.q02_inscr
        left outer join cgm cgm2      on escrito.q10_numcgm     = cgm2.z01_numcgm
 order by q88_tipo;create or replace function fc_juros(integer,date,date,date,bool,integer) returns float8 as 
$$
declare

  rece_juros      alias for $1;
  v_data_venc     alias for $2;
  data_hoje       alias for $3;
  data_oper       alias for $4;
  imp_carne       alias for $5;
  subdir          alias for $6;
  --
  carnes          char(10);

  dia             integer;
  dia1            integer;
  dia2            integer;
  v_tipo          integer default 1;
  mesdatacerta    integer default 0;
  mesdatavenc     integer default 0;
  iDiaOperacao    integer;
  iMesOperacao    integer;
  iAnoOperacao    integer;
  iDiaVencimento  integer;
  iMesVencimento  integer;
  iAnoVencimento  integer;

  dia1_par        integer;
  mes1_par        integer;
  ano1_par        integer;
  dia2_par        integer;
  mes2_par        integer;
  ano2_par        integer;
  qano_par        integer;
  qmes_par        integer;

  juros           numeric;
  v_juroscalc     numeric;
  juros_par       numeric;
  juross          numeric;
  juros_acumulado numeric;
  jur_i           numeric;
  juros_partotal  numeric default 0;
  jurostotal      numeric default 0;
  jurosretornar   numeric default 0;
  
  v_selicatual    float8;

  dt_venci        date;  
  data_comercial  date;
  data_venc       date;
  data_venc_base  date;
  data_certa      date;
  data_base       date;
  v_datacertaori  date;
  v_dataopernova  date;
  v_datavencant   date;

  lRaise          boolean default false;
  
  v_tabrec        record;
  v_tabrecregras  record;
  
begin

  v_dataopernova := data_oper;

  lRaise  := ( case when fc_getsession('DB_debugon') is null then false else true end );
  if lRaise is true then
  
    if fc_getsession('db_debug') <> '' then
      perform fc_debug('<fc_juros> ------------------------------------------------------------------',lRaise,false,false);
    else 
      perform fc_debug('<fc_juros> ------------------------------------------------------------------',lRaise,true,false);
    end if;

    perform fc_debug('<fc_juros> Processando calculo juros...'           ,lRaise, false, false);
    perform fc_debug('<fc_juros> '                                      ,lRaise, false, false);
    perform fc_debug('<fc_juros> '                                      ,lRaise, false, false);
    perform fc_debug('<fc_juros> '                                      ,lRaise, false, false);
    perform fc_debug('<fc_juros> Parametros: '                          ,lRaise, false, false);
    perform fc_debug('<fc_juros> '                                      ,lRaise, false, false);
    perform fc_debug('<fc_juros> Receita ..............: '||rece_juros  ,lRaise, false, false);
    perform fc_debug('<fc_juros> Data de Vencimento ...: '||v_data_venc ,lRaise, false, false);
    perform fc_debug('<fc_juros> Data Atual ...........: '||data_hoje   ,lRaise, false, false);
    perform fc_debug('<fc_juros> Data de Operacao .....: '||data_oper   ,lRaise, false, false);
    perform fc_debug('<fc_juros> Impressao de Carne ...: '||imp_carne   ,lRaise, false, false);
    perform fc_debug('<fc_juros> Exercicio ............: '||subdir      ,lRaise, false, false);
    perform fc_debug('<fc_juros> ',lRaise,false,false);
  end if;

  select *
    into v_tabrec
    from tabrec 
         inner join tabrecjm on tabrecjm.k02_codjm = tabrec.k02_codjm
   where k02_codigo = rece_juros;
   

  if not found then
    if lRaise is true then
      perform fc_debug('<fc_juros> retornando 0 (1)',lRaise,false,false);
    end if;
    return 0;
  end if;

  juros     := 0;
  juros_par := 0;
  
  if lRaise is true then
    perform fc_debug('<fc_juros> Alterando o valor da variavel data_venc('||data_venc||') para o valor da variavel data_hoje('||data_hoje||'),',lRaise,false,false);
  end if;
  data_venc := data_hoje;
  
  if lRaise is true then
    perform fc_debug('<fc_juros> procurando no calend (fora do loop): '||data_venc,lRaise,false,false);
    perform fc_debug('<fc_juros> v_tabrec.k02_sabdom: '||v_tabrec.k02_sabdom,lRaise,false,false);
  end if;
  
  if v_tabrec.k02_sabdom = true then
    loop
    
      data_venc := data_venc - 1 ; 
      if lRaise is true then
        perform fc_debug('<fc_juros> procurando no calend (dentro do loop): '||data_venc,lRaise,false,false);
      end if;
      
      select k13_data
        into data_certa
        from calend
       where k13_data = data_venc;

      if data_certa is null then

        if lRaise is true then
          perform fc_debug('<fc_juros> nao achou no calend data: '||data_venc,lRaise,false,false);
          perform fc_debug('<fc_juros> Alterando o valor da variavel data_certa('||data_certa||') para o valor da variavel data_venc+1('||(data_venc+1)||')',lRaise,false,false);
        end if;
        
        data_certa := data_venc+1 ;
        exit;

      else
      
        if lRaise is true then
          perform fc_debug('<fc_juros> achou no calend data: '||data_venc,lRaise,false,false);
        end if;
      end if;

    end loop;
    
  else
  
    if lRaise is true then
       perform fc_debug('<fc_juros> Alterando o valor da variavel data_certa('||data_certa||') para o valor da variavel data_hoje('||data_hoje||')',lRaise,false,false);
    end if;   
    data_certa := data_hoje;
    
  end if;

  data_venc := v_data_venc;

  if lRaise is true then
    perform fc_debug('<fc_juros> data_certa: '||data_certa||' - data_hoje: '||data_hoje||' - data_venc: '||data_venc, lRaise, false, false);
  end if;

  v_datavencant   := data_venc;
  v_datacertaori  := data_certa;

  if lRaise is true then
    perform fc_debug('<fc_juros> bem no inicio: v_datavencant: '||v_datavencant||', v_datacertaori: '||v_datacertaori, lRaise, false, false);
  end if;

  --
  -- CALCULA JUROS DE PARCELAMENTOS
  --

    if lRaise is true then
      perform fc_debug('<fc_juros> ', lRaise, false, false);
      perform fc_debug('<fc_juros> c a l c u l o    d e  j u r o s   p a r c e l a d o', lRaise, false, false);
      perform fc_debug('<fc_juros> ', lRaise, false, false);
    end if;

    juros_partotal := 0;

    for v_tabrecregras in 
      select * 
        from tabrecregrasjm 
             inner join tabrecjm on tabrecjm.k02_codjm = tabrecregrasjm.k04_codjm
       where k04_receit = rece_juros
      order by k04_dtini
    loop

      if lRaise then
        perform fc_debug('<fc_juros> Receita de Juros: '||rece_juros                   , lRaise, false, false); 
        perform fc_debug('<fc_juros> Regra encontrada: '||v_tabrecregras.k04_sequencial, lRaise, false, false);
        perform fc_debug('<fc_juros> Receita: '||v_tabrecregras.k04_sequencial         , lRaise, false, false);
        perform fc_debug('<fc_juros> Codigo J/M: '||v_tabrecregras.k04_codjm           , lRaise, false, false);
        perform fc_debug('<fc_juros> Data Inicial: '||v_tabrecregras.k04_dtini         , lRaise, false, false);
        perform fc_debug('<fc_juros> Data Final: '||v_tabrecregras.k04_dtfim           , lRaise, false, false);
        perform fc_debug('<fc_juros> k02_jurparate: '||v_tabrecregras.k02_jurparate    , lRaise, false, false);
      end if;  

      -- itaqui
      v_tipo = v_tabrecregras.k02_jurparate;
      if v_tipo is null then
        v_tipo = 1; -- calcula ate vcto
      end if;
      
      if lRaise is true then
         perform fc_debug('<fc_juros> ',lRaise, false, false);
         perform fc_debug('<fc_juros> v_tipo: '||v_tipo,lRaise, false, false);
      end if;
 
      if v_tipo = 1 then
        if data_venc < data_certa then
        
          if lRaise is true then
             perform fc_debug('<fc_juros> Alterando o valor da variavel data_certa('||data_certa||') para o valor da variavel data_venc('||data_venc||')', lRaise, false, false);
          end if;        
          data_certa := data_venc;
          
        end if;
      elsif v_tipo = 2 then -- calcula ate data atual
      
        if lRaise is true then
             perform fc_debug('<fc_juros> Alterando o valor da variavel data_venc('||data_venc||') para o valor da variavel data_hoje('||data_hoje||')', lRaise, false, false);
        end if;
        data_venc := data_hoje;
        
      end if;


      if lRaise is true then
        perform fc_debug('<fc_juros> v_dataopernova: '||v_dataopernova, lRaise, false, false); 
        perform fc_debug('<fc_juros> data_certa: '||data_certa,         lRaise, false, false);
        perform fc_debug('<fc_juros> data_venc: '||data_venc,           lRaise, false, false); 
        perform fc_debug('<fc_juros> juros_par: '||juros_par,           lRaise, false, false);
      end if;

      if v_dataopernova >= v_tabrecregras.k04_dtini and v_dataopernova <= v_tabrecregras.k04_dtfim then

        if lRaise is true then
          perform fc_debug('<fc_juros> ', lRaise, false, false);
          perform fc_debug('<fc_juros> v_dataopernova > v_tabrecregras.k04_dtini e v_dataopernova <= v_tabrecregras.k04_dtfim', lRaise, false, false);
          perform fc_debug('<fc_juros> >> Entrou tipo de juro e multa: '||v_tabrecregras.k04_codjm||' - data_certa: '||data_certa||' - jurpar: '||v_tabrecregras.k02_jurpar, lRaise, false, false);
          perform fc_debug('<fc_juros> ', lRaise, false, false);
        end if;

        if data_certa > v_tabrecregras.k04_dtfim then
          if lRaise is true then
            perform fc_debug('<fc_juros>    1', lRaise, false, false);
          end if;
          if lRaise is true then
             perform fc_debug('<fc_juros> Alterando o valor da variavel data_certa('||data_certa||') para o valor da variavel v_tabrecregras.k04_dtfim('||v_tabrecregras.k04_dtfim||')',lRaise, false, false);
          end if;
          data_certa := v_tabrecregras.k04_dtfim;
          
        else
          if lRaise is true  then
            perform fc_debug('<fc_juros> 2 - data_certa: '||data_certa, lRaise, false, false);
          end if;
        end if;
        
        if lRaise is true then
          perform fc_debug('<fc_juros> k02_jurpar: '||v_tabrecregras.k02_jurpar||' - data_certa: '||data_certa,lRaise, false, false);
        end if;
        
        if v_tabrecregras.k02_jurpar is not null and v_tabrecregras.k02_jurpar <> 0 then
        
          if lRaise is true then
            perform fc_debug('<fc_juros>    k02_jurpar <> 0',lRaise, false, false);
            perform fc_debug('<fc_juros>    data_venc: '||data_venc||' - v_dataopernova: '||v_dataopernova||' - data_certa: '||data_certa,lRaise, false, false);
          end if;
    
          if data_venc > v_dataopernova then
          
            if lRaise is true then
              perform fc_debug('<fc_juros> data_venc eh maior que v_dataopernova... ',lRaise, false, false);
            end if;
            
            dt_venci := data_venc;
            
            if extract(year from data_venc) > extract(year from v_dataopernova) then
            
              if lRaise is true then
                perform fc_debug('<fc_juros>    ano do vencimento maior ao ano da data de operacao...',lRaise, false, false);
              end if;
              
              if data_certa > data_venc then
              
                juros_par := juros_par + ((extract(year from data_venc) - 1) - extract(year from v_dataopernova)) * 12;
                juros_par := juros_par + extract(month from data_venc);
                if extract(year from (v_dataopernova + 1)) = extract(year from v_dataopernova) then
                  juros_par := juros_par + ( 13 - extract(month from (v_dataopernova + 1)) );
                end if;
                
              else
              
                juros_par := juros_par + ((extract(year from data_certa) - 1) - (extract(year from v_dataopernova))) * 12;
                juros_par := juros_par + extract(month from data_certa);
                if extract(year from (v_dataopernova + 1)) = extract(year from v_dataopernova) then
                  juros_par := juros_par + ( 13 - extract(month from (v_dataopernova + 1)) );
                end if;

              end if;

            else
        
              if lRaise is true  then
                perform fc_debug('<fc_juros> calculo dos juros: '||juros_par, lRaise, false, false);
                perform fc_debug('<fc_juros> juros_par + ((mes data_certa)+1) - ((mes v_dataopernova) +1) = '
                                  ||juros_par||'+'||(extract(month from data_certa) + 1 )||' - '
                                  ||extract(month from (v_dataopernova+1)), lRaise, false, false);
              end if;
          
                juros_par := juros_par + ( extract(month from data_certa) + 1 ) - ( extract(month from (v_dataopernova+1)) );
                
            end if;
            
            data_venc := dt_venci;
            
            if lRaise is true then
              perform fc_debug('<fc_juros>       diminuindo 1 nos juros: '||juros_par, lRaise, false, false);
            end if;
            
            juros_par := juros_par - 1;
            
            if lRaise is true then
              perform fc_debug('<fc_juros>       ficou 1 nos juros: '||juros_par, lRaise, false, false);
            end if;
            
            if juros_par < 0 then
              juros_par := 0;
            end if;
          
            --
            -- para juros sob financiamento acumulado
            --
            if v_tabrecregras.k02_juracu = 't' then
            
              juros_acumulado := 1;
              for jur_i in 1..juros_par 
              loop
                juros_acumulado := juros_acumulado * 1.01;
              end loop;
              
              juros_par := ( juros_acumulado - 1 ) * 100;
              
            end if;

            --
            -- para juros sob financiamento nao acumulado
            --

            juros_par := (juros_par * cast(v_tabrecregras.k02_jurpar as numeric(8,2)));

            if lRaise is true then
              perform fc_debug('<fc_juros> somando juros de parcelamento...', lRaise, false, false);
            end if;

          else
    
            if lRaise is true then
              perform fc_debug('<fc_juros> Nao esta vencido ou seja, data_venc menor que v_dataopernova, não realiza calculo...', lRaise, false, false);
            end if;
      
          end if;

        end if;

      end if;

      if v_tipo = 1 then
        data_venc      := v_tabrecregras.k04_dtfim + 1;
        v_dataopernova := v_tabrecregras.k04_dtfim + 1;
      end if;
      
      if lRaise is true then
        perform fc_debug('<fc_juros> Alterando o valor da variavel data_certa('||data_certa||') para o valor da variavel v_datacertaori('||v_datacertaori||')',lRaise, false, false);
      end if;
      data_certa := v_datacertaori;
      
      if lRaise is true then
        perform fc_debug('<fc_juros> v_dataopernova: '||v_dataopernova,lRaise, false, false);
        perform fc_debug('<fc_juros> ',lRaise, false, false);
      end if;

      if v_tabrecregras.k02_juros = 999 then
        if data_venc < data_certa then
          juros_par := 0;
        end if;
      end if;

      if lRaise is true  then
        perform fc_debug('<fc_juros>  ',lRaise, false, false);
        perform fc_debug('<fc_juros> somando '||juros_par||' em juros_partotal que atualmente esta em: '||juros_partotal, lRaise, false, false);
        perform fc_debug('<fc_juros> ',lRaise, false, false);
      end if;

      juros_partotal := juros_partotal + juros_par;
      juros_par := 0;
      
    end loop;

  if lRaise is true  then
    perform fc_debug('<fc_juros> juros_financ: '||juros_par||' - juros_partotal: '||juros_partotal, lRaise, false, false);
    perform fc_debug('<fc_juros> bem no meio: v_datavencant: '||v_datavencant||' v_datacertaori: '||v_datacertaori, lRaise, false, false);
    perform fc_debug('<fc_juros> ', lRaise, false, false);
    perform fc_debug('<fc_juros> FIM CALCULO DE FINANCIAMENTO ', lRaise, false, false);
    perform fc_debug('<fc_juros> ', lRaise, false, false);
  end if;

  --
  -- calcula juros normal
  --

  if lRaise is true then
    perform fc_debug('<fc_juros> ', lRaise, false, false);
    perform fc_debug('<fc_juros> INICIO CALCULO NORMAL', lRaise, false, false);
    perform fc_debug('<fc_juros> ', lRaise, false, false);
    perform fc_debug('<fc_juros> juros: '||juros||' - juros_par: '||juros_par, lRaise, false, false);
    perform fc_debug('<fc_juros> ',lRaise, false, false);
    perform fc_debug('<fc_juros> a - v_datavencant: '||v_datavencant||' - data_certa: '||data_certa, lRaise, false, false);
    perform fc_debug('<fc_juros> ',lRaise, false, false);
  end if;

    if v_datavencant < data_certa then

      if lRaise is true then
        perform fc_debug('<fc_juros> ',lRaise, false, false);
        perform fc_debug('<fc_juros> c a l c u l o    d e  j u r o s   n o r m a l',lRaise, false, false);
        perform fc_debug('<fc_juros> ',lRaise, false, false);
      end if;

      v_dataopernova := data_oper;
      data_venc      := v_datavencant;
      data_certa     := v_datacertaori;
      data_base      := data_certa;
      data_venc_base := data_venc;
      jurostotal     := 0;
      
      iDiaOperacao   := extract(day   from data_hoje);
      iMesOperacao   := extract(month from data_hoje);
      iAnoOperacao   := extract(year  from data_hoje);
                     
      iDiaVencimento := extract(day   from data_venc_base);
      iMesVencimento := extract(month from data_venc_base);
      iAnoVencimento := extract(year  from data_venc_base);

      if imp_carne = 'f' then

        if lRaise is true then
          perform fc_debug('<fc_juros> data certa: '||data_certa,lRaise, false, false);
        end if;


        for v_tabrecregras in 
          select * 
            from tabrecregrasjm 
                 inner join tabrecjm on tabrecjm.k02_codjm = tabrecregrasjm.k04_codjm
           where k04_receit = rece_juros 
          order by k04_dtini
        loop
        
          if lRaise then
            perform fc_debug('<fc_juros> _____________________________________________________'     ,lRaise, false, false);
            perform fc_debug('<fc_juros> Receita de Juros: '||rece_juros                            ,lRaise, false, false); 
            perform fc_debug('<fc_juros> Regra encontrada: '||v_tabrecregras.k04_sequencial         ,lRaise, false, false);
            perform fc_debug('<fc_juros> Receita: '||v_tabrecregras.k04_sequencial                  ,lRaise, false, false);
            perform fc_debug('<fc_juros> Codigo J/M: '||v_tabrecregras.k04_codjm                    ,lRaise, false, false);
            perform fc_debug('<fc_juros> Data Inicial: '||v_tabrecregras.k04_dtini                  ,lRaise, false, false);
            perform fc_debug('<fc_juros> Data Final: '||v_tabrecregras.k04_dtfim                    ,lRaise, false, false);
            perform fc_debug('<fc_juros> voltando data de vencimento para original: '||v_datavencant,lRaise, false, false);
          end if;
          data_venc := v_datavencant;

          if lRaise is true then
            perform fc_debug('<fc_juros> '                                 ,lRaise, false, false);
            perform fc_debug('<fc_juros> Verificamos se a data de vencimento base (data_venc_base) estah entre a data inicial e final da tabela de regras de juros e multa da receita (tabrecregrasjm)',lRaise, false, false);
            perform fc_debug('<fc_juros> '                                 ,lRaise, false, false);
            perform fc_debug('<fc_juros> data_venc_base: '||data_venc_base ,lRaise, false, false);
            perform fc_debug('<fc_juros> v_dataopernova: '||v_dataopernova ,lRaise, false, false);
            perform fc_debug('<fc_juros> data_certa: '||data_certa         ,lRaise, false, false);
            perform fc_debug('<fc_juros> data_venc: '||data_venc           ,lRaise, false, false); 
            perform fc_debug('<fc_juros> juros: '||juros                   ,lRaise, false, false);
          end if;
          
          if data_venc_base >= v_tabrecregras.k04_dtini and data_venc_base <= v_tabrecregras.k04_dtfim then

            if lRaise is true then
               perform fc_debug('<fc_juros> ', lRaise, false, false);
               perform fc_debug('<fc_juros> v_dataopernova > v_tabrecregras.k04_dtini e v_dataopernova <= v_tabrecregras.k04_dtfim', lRaise, false, false);
               perform fc_debug('<fc_juros> *****************************************************', lRaise, false, false);
               perform fc_debug('<fc_juros> >> ENTROU NO TIPO DE JURO: '||v_tabrecregras.k04_codjm, lRaise, false, false);
               perform fc_debug('<fc_juros> *****************************************************', lRaise, false, false);
               perform fc_debug('<fc_juros> ', lRaise, false, false);
               perform fc_debug('<fc_juros> ', lRaise, false, false);
            end if;
            
            data_venc := data_venc_base;
            if data_venc_base > v_tabrecregras.k04_dtfim then

              if lRaise is true then
                perform fc_debug('<fc_juros> Data de Vencimento (data_venc_base) '||data_venc_base||' maior que a data final (k04_dtfim) '||v_tabrecregras.k04_dtfim||' da tabela de regras de juros e multa da receita (tabrecregrasjm)',lRaise, false, false);    
                perform fc_debug('<fc_juros> Alteramos a data de vencimento (data_venc) para a ultima data da tabelas de regras de juros e multa da receita (tabrecregrasjm): '||v_tabrecregras.k04_dtfim, lRaise, false, false);
              end if;            
              data_venc := v_tabrecregras.k04_dtfim;
              
            else
            
              if data_venc_base < v_tabrecregras.k04_dtini then
              
                if lRaise is true then
                  perform fc_debug('<fc_juros> Data de Vencimento (data_venc_base) '||data_venc_base||' menor que a data inicial (k04_dtini) '||v_tabrecregras.k04_dtini||' da tabela de regras de juros e multa da receita (tabrecregrasjm)', lRaise, false, false);    
                  perform fc_debug('<fc_juros> Alteramos a data de vencimento (data_venc) para a data inicial da tabelas de regras de juros e multa da receita (tabrecregrasjm): '||v_tabrecregras.k04_dtini, lRaise, false, false);
                end if;
                
                data_venc := v_tabrecregras.k04_dtini;
                
              else
              
                if v_datavencant > v_tabrecregras.k04_dtini then
                
                  data_venc := v_datavencant;
                  if lRaise is true then
                    perform fc_debug('<fc_juros> Data de Vencimento Anterior!? (v_datavencant) '||v_datavencant||' maior que a data inicial (k04_dtini) '||v_tabrecregras.k04_dtini||' da tabela de regras de juros e multa da receita (tabrecregrasjm)',lRaise, false, false);    
                    perform fc_debug('<fc_juros> Alteramos a data de vencimento (data_venc) para a data de vencimento anterior (v_datavencant): '||v_datavencant, lRaise, false, false);
                  end if;
                  
                else
                
                  if lRaise is true then
                    perform fc_debug('<fc_juros> Nada eh alterado em termos de data de vencimento', lRaise, false, false);
                  end if;
                  
                end if;
              end if;
              
            end if;
            
            if lRaise is true then
               perform fc_debug('<fc_juros> ',lRaise, false, false);
               perform fc_debug('<fc_juros> ',lRaise, false, false);
            end if;   

            if data_venc < v_tabrecregras.k04_dtfim then
              data_certa := v_tabrecregras.k04_dtfim;
            end if;

            if data_certa > v_datacertaori then
              data_certa := v_datacertaori;
            end if;

            if lRaise is true then
              perform fc_debug('<fc_juros> entrou tipo de juro e multa: '||v_tabrecregras.k04_codjm||' - data_certa: '||data_certa||' - data_venc: '||data_venc||' - data_venc_base: '||data_venc_base||' - juros: '||v_tabrecregras.k02_juros, lRaise, false, false);
            end if;

            if data_venc < data_certa then
        
              if lRaise is true then
                perform fc_debug('<fc_juros> vencimento MENOR que data certa - data certa: '||data_certa, lRaise, false, false);
              end if;

              if extract(year from data_certa) > extract(year from data_venc) then

                if lRaise is true then
                  perform fc_debug('<fc_juros>       ano da data_certa maior que ano do data_venc', lRaise, false, false);
                  perform fc_debug('<fc_juros>       juros (1): '||juros, lRaise, false, false);
                end if;

                v_juroscalc := (((extract(year from data_certa) - 1) - (extract(year from data_venc))) * 12);
                if lRaise is true then
                  perform fc_debug('<fc_juros>          1 - v_juroscalc: '||v_juroscalc, lRaise, false, false);
                end if;
                juros := juros + v_juroscalc;

                if lRaise is true then
                  perform fc_debug('<fc_juros>          juros: '||juros, lRaise, false, false);
                end if;

                v_juroscalc := extract(month from data_certa);
                if lRaise is true then
                  perform fc_debug('<fc_juros>          2 - v_juroscalc: '||v_juroscalc, lRaise, false, false);
                end if;
                juros := juros + v_juroscalc;
       
                if lRaise is true then
                  perform fc_debug('<fc_juros>          juros: '||juros, lRaise, false, false);
                end if;

                if (extract(year from (data_venc + 1))) = extract(year from data_venc) then
                  v_juroscalc := (13 - (extract(month from (data_venc + 1))));
                  if lRaise is true then
                    perform fc_debug('<fc_juros>          3 - v_juroscalc: '||v_juroscalc, lRaise, false, false);
                  end if;
                  juros := juros + v_juroscalc;
                end if;
                
                if lRaise is true then
                  perform fc_debug('<fc_juros>             juros: '||juros, lRaise, false, false);
                end if;
           
              else
                                
                if lRaise is true then
                  perform fc_debug('<fc_juros>       ano da data_certa menor que ano do data_venc', lRaise, false, false);
                  perform fc_debug('<fc_juros>       juros (2): '||juros, lRaise, false, false);
                end if;
                                
                mesdatacerta := extract(month from data_certa);
                mesdatavenc  := extract(month from (data_venc + 1));

                if lRaise is true then
                  perform fc_debug('<fc_juros>       mesdatacerta: '||mesdatacerta||' - mesdatavenca: '||mesdatavenc, lRaise, false, false);
                end if;

                v_juroscalc := (extract(month from data_certa) + 1) - extract(month from (data_venc + 1));
                                
                if lRaise is true then
                  perform fc_debug('<fc_juros>          4 - v_juroscalc: '||v_juroscalc, lRaise, false, false);
                end if;
                                
                juros := juros + v_juroscalc;
                                
              end if;

              if lRaise is true then
                perform fc_debug('<fc_juros>          *** juros: '||juros||' - juros por dia: '||v_tabrecregras.k02_jurdia, lRaise, false, false);
              end if;
             
              --
              -- se juros por dia, cobrar proporcional apartir do dia de vencimento
              --
              if v_tabrecregras.k02_jurdia = 't' then
              
                --
                -- Quando o calculo de juros é diario, desconsideramos os juros calculados anteriormente
                --
                if lRaise is true then
                  perform fc_debug('<fc_juros> juros por dia... juros atual: '||juros||' - dia: '||dia, lRaise, false, false);
                end if;
                
                juros  := juros - 1;
                
                dia1 := extract(day from data_certa);
                dia2 := extract(day from data_venc);
                if lRaise is true then
                  perform fc_debug('<fc_juros> data_hoje: '||data_hoje||' - data_certa: '||data_certa||' - data_venc: '||data_venc, lRaise, false, false);
                  perform fc_debug('<fc_juros> dia1: '||dia1||' - dia2: '||dia2, lRaise, false, false);
                end if;
                dia := dia1 - dia2;
                if dia < 0 then
                
                  if lRaise is true then
                    perform fc_debug('<fc_juros> entrou no menor: '||dia, lRaise, false, false);
                  end if;

                  dia := extract(day from data_venc) - extract(day from data_certa);
                  dia := 30-dia+2;
                  if dia = 31 then
                    dia = 30;
                  end if;
                  
                elseif dia = 0 then
                
                  if lRaise is true then
                    perform fc_debug('<fc_juros> entrou no maior: '||dia, lRaise, false, false);
                  end if;
                  dia    := 30;
                end if;
              
                if lRaise is true then
                  perform fc_debug('<fc_juros> dia: '||dia, lRaise, false, false);
                  perform fc_debug('<fc_juros> (v_tabrecregras.k02_juros: '||v_tabrecregras.k02_juros||' /30) * '||dia, lRaise, false, false);
                end if;
                juross := ( cast(v_tabrecregras.k02_juros as numeric) / 30) * dia;
                if lRaise is true then
                  perform fc_debug('<fc_juros> juross: '||juross||' - v_tabrecregras.k02_juros: '||v_tabrecregras.k02_juros, lRaise, false, false);
                end if;
                juros  := juros + juross;
              end if;
               
              if lRaise is true then
                perform fc_debug('<fc_juros>       juros: '||juros, lRaise, false, false);
              end if;


              v_juroscalc := cast(v_tabrecregras.k02_juros as numeric(8,2));
              if lRaise is true then
                perform fc_debug('<fc_juros>       5 - v_juroscalc: '||v_juroscalc, lRaise, false, false);
                perform fc_debug('<fc_juros>       6 - juros: '||juros, lRaise, false, false);
              end if;

              if juros is not null and juros <> 0 then
              
                if lRaise is true then
                  perform fc_debug('<fc_juros>       7 - juros existe...', lRaise, false, false);
                end if;
                
                data_comercial := data_venc + 1;
                
                if lRaise is true then
                  perform fc_debug('<fc_juros>       7.5 - data_comercial: '||data_comercial||' - data_venc: '||data_venc, lRaise, false, false);
                end if;

                if extract(month from data_comercial) = extract(month from data_venc) then
                  if lRaise is true then
                    perform fc_debug('<fc_juros>       8 - mes da data comercial = mes da data vencimento...', lRaise, false, false);
                  end if;

                  if extract(day from data_venc) >= extract(day from data_certa) then
                    if lRaise is true then
                      perform fc_debug('<fc_juros>       9 - dia da data de vencimento >= dia da data certa...', lRaise, false, false);
                    end if;
                    if lRaise is true then
                      perform fc_debug('<fc_juros> antes: '||juros, lRaise, false, false);
                    end if;
                    
                    -- modificacao feita em carazinho pois os juros estavam negativos em alguns casos
                    -- entao coloquei esse if abaixo antes de diminuir 1 para testar
                    ------if v_tabrecregras.k02_jurdia <> 't' then
                      juros := juros - 1;
                    ------end if;
                    
                    if lRaise is true then
                      perform fc_debug('<fc_juros> depois: '||juros, lRaise, false, false);
                    end if;
                  end if;
                end if;
              end if;
              if lRaise is true then
                perform fc_debug('<fc_juros>       10 - v_juroscalc: '||v_juroscalc||' - juros: '||juros, lRaise, false, false);
              end if;
              juros := juros * v_juroscalc;
              if lRaise is true then
                perform fc_debug('<fc_juros>       11 - juros: '||juros, lRaise, false, false);
              end if;
              
              if lRaise is true then
                perform fc_debug('<fc_juros>    old: v_dataopernova: '||v_dataopernova||' - data_venc: '||data_venc||' - data_certa: '||data_certa, lRaise, false, false);
                perform fc_debug('<fc_juros>    new: v_dataopernova: '||v_dataopernova||' - data_venc: '||data_venc||' - data_certa: '||data_certa||' - data_venc_base: '||data_venc_base, lRaise, false, false);
                perform fc_debug('<fc_juros> ', lRaise, false, false);
              end if;
              v_dataopernova := v_tabrecregras.k04_dtfim + 1;
              data_venc_base := v_dataopernova;
              data_certa     := v_datacertaori;
              
            else
              if lRaise is true then
                perform fc_debug('<fc_juros>       vencimento maior que data certa..............', lRaise, false, false);
              end if;
            end if;
        
          else
            if lRaise is true then
              perform fc_debug('<fc_juros> ', lRaise, false, false);
              perform fc_debug('<fc_juros> data de operacao  f o r a  periodo das regras', lRaise, false, false);
              perform fc_debug('<fc_juros> ', lRaise, false, false);
            end if;
          end if;

          if v_tabrecregras.k02_juros = 999 then
          
            if lRaise is true then
              perform fc_debug('<fc_juros> k02_juros == 999 - juros: '||juros, lRaise, false, false);
            end if;
            
            juros := 0;
            
            if data_venc < data_certa then
              if lRaise is true then
                perform fc_debug('<fc_juros> data_venc ('||data_venc||') < data_certa ('||data_certa||')',lRaise, false, false);
              end if;
              select  i02_valor 
                into v_selicatual 
                from infla 
               where i02_codigo = 'SELIC' 
                 and i02_valor <> 0 
              order by i02_data desc limit 1;
              
              if lRaise is true then
                perform fc_debug('<fc_juros> juros: '||juros||' - selic: '||v_selicatual, lRaise, false, false);
              end if;
              
              juros := fc_vlinf('SELIC'::varchar,data_venc);
              
              if lRaise is true then
                perform fc_debug('<fc_juros> juros: '||juros, lRaise, false, false);
              end if;
              
              if juros < 0 then
                juros := 0;
              end if;
              
            end if;
          end if;

          if lRaise is true then
            perform fc_debug('<fc_juros> somando '||juros||' em jurostotal que atualmente esta em: '||jurostotal, lRaise, false, false);
            perform fc_debug('<fc_juros> '                                                     ,lRaise, false, false);
            perform fc_debug('<fc_juros> FIM CALCULO DA REGRA: '||v_tabrecregras.k04_sequencial,lRaise, false, false);
            perform fc_debug('<fc_juros> _____________________________________________________',lRaise, false, false);
            perform fc_debug('<fc_juros> '                                                     ,lRaise, false, false);
          end if;

          jurostotal := jurostotal + juros;
          juros      := 0;

        end loop;

      end if;

    else
    
      if lRaise is true then
        perform fc_debug('<fc_juros> aaaaaa',lRaise, false, false); 
        perform fc_debug('<fc_juros> a - v_datavencant: '||v_datavencant||' - data_certa: '||data_certa, lRaise, false, false);
      end if;
      
    end if;
    
  if v_tabrec.k02_juroslimite > 0 and jurostotal > v_tabrec.k02_juroslimite then 
  
    jurostotal := v_tabrec.k02_juroslimite;
    
    if lRaise is true then
      perform fc_debug('<fc_juros> limite de juros definido para ateh '||jurostotal, lRaise, false, false);
    end if;
    
  end if;
   
  if lRaise is true  then
    perform fc_debug('<fc_juros> juros: '||juros||' - juros_par: '||juros_par, lRaise, false, false);
    perform fc_debug('<fc_juros> juros_financiamento: '||juros_partotal||' - juros mora: '||jurostotal, lRaise, false, false);
  end if;

  jurosretornar = jurostotal + juros_partotal;

  if lRaise is true  then
    perform fc_debug('<fc_juros> jurosretornar: '||jurosretornar                                    ,lRaise,false,false);
    perform fc_debug('<fc_juros> '                                                                  ,lRaise,false,false);
    perform fc_debug('<fc_juros> '                                                                  ,lRaise,false,false);
    perform fc_debug('<fc_juros> ------------------------------------------------------------------',lRaise,false,true);
  end if;
  
  return (jurostotal::float8 + juros_partotal::float8) / 100::float8;
    
end;
$$ language 'plpgsql';--
-- Segundo o Parametro ImpPossPro da tabela CFIPTU, entao imprimier a palavra POSSUIDOR
--
DROP VIEW proprietario_ender;

create or replace view proprietario_ender as
        select distinct 
	             x.j01_matric,
	             x.codpri,
	             x.nomepri::varchar(40),
	             x.tipopri::varchar(40),
	             coalesce(x.j39_numero,0) as j39_numero,
	             x.j39_compl,
	             x.j14_codigo,
	             x.j14_nome,
	             x.j14_tipo,
	             x.j13_descr
         from ( select iptubase.j01_matric, 
	       		           case 
	       		             when rr.j14_codigo is null 
	       		               then r.j14_codigo 
	       		             else rr.j14_codigo 
	       		           end as codpri,
	       		           case 
	       		             when rr.j14_nome is null 
	       		               then r.j14_nome   
	       		             else rr.j14_nome   
	       		           end as nomepri,
	       		           case 
                         when rr.j14_tipo is null then 
                           rt.j88_sigla
                         else
                           rrt.j88_sigla
                       end as tipopri,
	       		           case 
	       		             when j15_numero > 0 and j39_matric is null 
	       		               then j15_numero 
	       		             else j39_numero 
	       		           end as j39_numero,
	       		           case 
	       		             when length(trim(j15_compl)) > 0 and j39_matric is null 
	       		               then j15_compl    
	       		             else j39_compl     
	       		           end as j39_compl,
		                   r.j14_codigo,
			                 r.j14_nome, 
                       rt.j88_sigla as j14_tipo,
			                 j13_descr 
	                from iptubase
		                   left  outer join iptuconstr 		on iptuconstr.j39_matric     = iptubase.j01_matric 
                                                     and iptuconstr.j39_idprinc    is true
                                                     and iptuconstr.j39_dtdemo     is null 
		                   left  outer join ruas rr    		on rr.j14_codigo             = iptuconstr.j39_codigo 
                       left  outer join ruastipo rrt  on rrt.j88_codigo            = rr.j14_tipo
		                   inner       join lote          on lote.j34_idbql            = iptubase.j01_idbql  
		                   left  outer join testpri     	on lote.j34_idbql            = testpri.j49_idbql  
		                   left  outer join testadanumero on testadanumero.j15_idbql   = testpri.j49_idbql
		                                                 and testadanumero.j15_face    = testpri.j49_face
		                   left  outer join ruas r 		    on r.j14_codigo              = testpri.j49_codigo 
                       left  outer join ruastipo rt   on rt.j88_codigo             = r.j14_tipo
		                   left  outer join bairro        on j13_codi                  = j34_bairro
	) as x;insert into db_versaoant (db31_codver,db31_data) values (340, current_date);
select setval ('db_versaousu_db32_codusu_seq',(select max (db32_codusu) from db_versaousu));
select setval ('db_versaousutarefa_db28_sequencial_seq',(select max (db28_sequencial) from db_versaousutarefa));
select setval ('db_versaocpd_db33_codcpd_seq',(select max (db33_codcpd) from db_versaocpd));
select setval ('db_versaocpdarq_db34_codarq_seq',(select max (db34_codarq) from db_versaocpdarq));insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),340,1101213,'Disponibilizada a opção de gerar relatórios com ou sem  ato legal da atividade diretor.
Se desejar que o ato legal apareça ao lado da atividade Diretor, acessar o Módulo Secretaria>Cadastros>Tabelas > Atividades , campo Exige Ato Legal informar SIM.
Acessar Módulo Escola>Cadastros>Dados da Escola>Aba Diretores - o sistema irá obrigar a informar um ato legal. Caso a opção escolhida no cadastro de atividades,  campo Exige Ato Legal seja NÃO, ao informar um diretor não será obrigado a informar o ato legal.','2014-05-15','Mensagem Usuário ');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8248,91864);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),340,7814,'Incluído campo Brasão no cadastro de modelos de relatórios, para permitir gerar Histórico do Aluno e Certificado de Conclusão com o Brasão da República Federativa do Brasil ou com o logo do município, conforme informado no modelo.
Para configurar, acessar Módulo Secretaria>Cadastros>Modelos de Relatórios>Alteração - campo Brasão.','2014-05-16','Mensagem Usuário');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8251,92192);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),340,9941,'Melhorias no Relatório Diário de Classe
Escola>Relatórios>DIário de Classe
-Incluída a opção para gerar o relatório conforme Registro Manual ou Lançamentos Frequência/Conteúdo.
-Para turmas onde a Frequência for por Períodos e a grade de horários estiver configurada corretamente, o sistema irá carregar no relatório do diário de classe, para marcar as faltas, a quantidade de períodos do dia.Se escolhida a opção Registro Manual, funcionará como anteriormente.
-Alterado o termo Transferido Fora e Transerido Rede para Transferido.

MODELO 1 - o modelo  1 e 4 passaram a ser o mesmo, todos os fitros que estavam disponíveis no modelo 4, passaram para o modelo 1.
MODELO 2- quando selecionada uma turma onde o controle da frequência é Globalizado, só irá carregar a disciplina informada como global.
MODELO 3- Duas páginas por disciplina, Presencas e Avaliações
MODELO 4 - Somente quando a turma selecionar for do tipo EJA.
','2014-05-15','Mensagem Usuário');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8257,92723);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),340,1100847,'Realizada validação no cadastro do calendário escolar,  para não permitir  incluir feriados e eventos fora do período entre a data inicial e final informada na aba geral do calendário.
Escola>Cadastros>Calendário>Inclusão/Alteração
Secretaria>Cadastros>Calendário Base>Inclusão/Alteração



Estas validações devem ser realizadas também no Módulo Secretaria - cadastros>Calendário Base>Inclusão.','2014-05-15','Mensagem de Usuário');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8253,92573);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),340,673567,'Realizadas alterações no cadastro de Recursos Humanos

Escola>Cadastros>Recursos Humanos>Aba Escolas
Ao informar uma data de saida para o professor, o sistema irá limpar a aba disponibilidade e aba horários, permitindo assim que outra escola, ao incluir o professor nos recursos humanos, possa informar a disponibilidade sem conflitos.
Se desejar substituir o professor na turma, utilizar a rotina de ausências e substituições(Procedimentos>Controle de Ausências e Substituições) , informando a ausência e somente depois informar a data de saída do professor ou então exclui o vínculo acessando a aba horários da turma.

Na consulta do professor, foram disponibilizadas mais informações
Escola> Consulta>Professores> 
Aba Escolas: Consulta de dados do Professor por Escola, como Data de Ingresso e Saída, Regime de Trabalho,Área de Trabalho, Disciplinas e Turno.
Aba Disponiblidade: disponivel para consulta, a disponibilidade ativa do professor, e até mesmo a disponibilidade inativa, ou seja, que ja tenha sido informada a data de saida na Escola.
Aba Movimentações:Ao informar a data de saída do professor na Escola, o sistema irá lançar um registro nas movimentações. 
','2014-05-22','Mensagem de Usuário');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8246,91754);

create table bkp_db_permissao_20140526_141617 as select * from db_permissao;
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