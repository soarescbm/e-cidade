insert into db_versao (db30_codver, db30_codversao, db30_codrelease, db30_data, db30_obs)  values (352, 3, 36, '2015-03-20', 'Tarefas: 97587, 97598, 97599, 97603, 97604, 97605, 97607, 97608, 97610, 97611, 97614, 97616, 97617, 97618, 97619, 97620, 97624, 97625, 97626, 97627, 97628, 97629, 97632, 97633, 97634, 97636, 97637, 97638, 97640, 97641, 97642, 97645, 97646, 97648, 97649, 97650, 97651, 97652, 97653, 97654, 97655, 97656, 97657, 97658, 97659, 97660, 97661, 97662, 97664, 97665, 97666, 97667, 97668, 97669, 97670, 97671, 97672, 97673, 97674, 97675, 97677, 97678, 97679, 97680, 97681, 97683, 97685, 97686, 97687, 97688, 97689, 97690, 97691, 97692, 97696, 97697, 97698, 97699, 97700, 97701, 97702, 97703, 97704, 97706, 97707, 97708, 97710, 97711, 97712, 97713, 97714, 97715, 97716, 97717, 97719, 97721, 97722, 97723, 97724, 97725, 97726, 97727, 97728, 97729, 97730, 97732, 97733, 97734, 97736, 97737, 97739, 97740, 97742, 97744, 97745, 97746, 97747, 97748, 97750, 97751, 97752, 97753, 97754, 97755, 97756, 97757, 97758, 97759, 97760, 97761, 97763');CREATE OR REPLACE FUNCTION fc_edurfanterior(iMatricula numeric)
RETURNS varchar AS $$
DECLARE
 iCalendario    integer;
 iSerie         integer;
 iAluno         integer;
 iMatriculaAnt  integer;
 iTurma         integer;
 iAno           integer;
 cSituacao      varchar;
 cConcluida     varchar;
 iLinhas        integer;
 iLinhas2       integer;
 iDiario        integer;
 iCalendarioAnt integer;
 iSerieAnt      integer;
 cRFanterior    varchar;
BEGIN
 SELECT ed57_i_calendario, ed221_i_serie, ed60_i_aluno, ed52_i_ano
   INTO iCalendario, iSerie, iAluno, iAno
   FROM matricula
        inner join turma          on ed57_i_codigo     = ed60_i_turma
        inner join calendario     on ed52_i_codigo     = ed57_i_calendario
        inner join matriculaserie on ed221_i_matricula = ed60_i_codigo
  WHERE ed60_i_codigo  = iMatricula
    AND ed221_c_origem = 'S';

 SELECT ed60_i_codigo, ed57_i_codigo, trim(ed60_c_situacao), ed60_c_concluida, ed57_i_calendario, ed221_i_serie
   INTO iMatriculaAnt, iTurma, cSituacao, cConcluida, iCalendarioAnt, iSerieAnt
   FROM matricula
        inner join turma          on ed57_i_codigo     = ed60_i_turma
        inner join calendario     on ed52_i_codigo     = ed57_i_calendario
        inner join matriculaserie on ed221_i_matricula = ed60_i_codigo
  WHERE ed60_i_aluno = iAluno
    AND ed60_i_codigo not in (iMatricula)
    AND (    ed52_i_ano not in (iAno)
         OR ( ed52_i_ano = iAno AND ed221_i_serie != iSerie )
        )
    AND ed60_c_ativa     = 'S'
    AND ed60_c_concluida = 'S'
    AND ed221_c_origem   = 'S'
  ORDER BY ed60_d_datamatricula DESC
  LIMIT 1;

    GET DIAGNOSTICS iLinhas = ROW_COUNT;

 IF iLinhas > 0 THEN
   IF cSituacao = 'CLASSIFICADO' OR cSituacao = 'AVANÇADO' THEN
     cRFanterior := 'A';
   ELSIF cSituacao = 'MATRICULADO' THEN
     SELECT ed95_i_codigo INTO iDiario
       FROM diario
            inner join aluno       on ed47_i_codigo = ed95_i_aluno
            inner join diariofinal on ed74_i_diario = ed95_i_codigo
            inner join regencia    on ed59_i_codigo = ed95_i_regencia
            inner join turma       on ed57_i_codigo = ed59_i_turma
            inner join matricula  on ed60_i_turma   = ed57_i_codigo
      WHERE ed95_i_aluno           = iAluno
        AND ed95_i_calendario      = iCalendarioAnt
        AND ed95_i_serie           = iSerieAnt
        AND ed59_c_condicao        = 'OB'
        AND ed74_c_resultadofinal != 'A'
        AND ed60_i_codigo          = iMatriculaAnt;

        GET DIAGNOSTICS iLinhas2 = ROW_COUNT;

     IF iLinhas2 = 0 THEN
       cRFanterior := 'A';
     ELSE
       cRFanterior := 'R';
     END IF;
   ELSE
     cRFanterior := 'S';
   END IF;
 ELSE
   cRFanterior := 'S';
 END IF;
 RETURN cRFanterior;
END;
$$ LANGUAGE plpgsql;-- 00 Liberado para execucao
-- 01 Empenho nao pode ser anulado   ( saldo na data )
-- 02 Empenho nao pode ser anulado   ( saldo geral )
-- 03 Empenho nao pode ser liquidado ( saldo na data )
-- 04 Empenho nao pode ser liquidado ( saldo geral )
-- 05 Empenho nao pode ser anulado liquidacao ( saldo na data )
-- 06 Empenho nao pode ser anulado liquidacao ( saldo geral )
-- 07 Empenho nao pode ser pago      ( saldo na data )
-- 08 Empenho nao pode ser pago      ( saldo geral )
-- 09 Empenho nao pode ser anulado pagamento   ( saldo  na data )
-- 10 Empenho nao pode ser anulado pagamento   ( saldo geral )
-- 11 AUTORIZACAO SEM RESERVA DE SALDO
-- 12 SEM SALDO NA DOTACAO (codigo autorizacao) (saldo dotacao);
-- 13 PROCESSO AUTORIZADO (codigo da reserva)
-- 14 Empenho nao encontrado
-- 15 Nao usado
-- 16 Empenho nao encontrado no empresto ( nao e resto a pagar )

--drop function fc_verifica_lancamento (integer,date,integer,float8);
create or replace function fc_verifica_lancamento(integer,date,integer,float8) returns text as
$$
declare

  p_numemp         alias for $1;
  p_dtfim          alias for $2;
  p_doc            alias for $3;
  p_valor          alias for $4;

  c_lanc           record;

  v_dtini          date;
  v_erro           integer default 0;

  v_vlremp         float8 default 0;
  v_vlrliq         float8 default 0;
  v_vlrpag         float8 default 0;

  v_vlremp_g       float8 default 0;
  v_vlrliq_g       float8 default 0;
  v_vlrpag_g       float8 default 0;

  v_saldodisprp    numeric default 0;

  m_erro           text;

  v_anousu         integer default 0;
  v_instit         integer ;

  v_saldo_dotacao  float8 default 0;
  v_reserva_valor  float8 default 0;

  dataemp          boolean;  --  permite empenho com data maior que o ultimo empenho
  dataserv         boolean;  --  permite empenho com data maior que a data do servidor
  maxdataemp       date;

begin

  -- para documento numero 1 o valor da variavel p_numemp deve ser o numero da autorizacao
  -- significa que a autorizacao esta sendo empenhada e ira gerar o documento 1
  if p_doc = 1 then

    -- Busca Instituicao da Autorizacao
    select e54_instit
      into v_instit
      from empautoriza
     where e54_autori = p_numemp;

    -- verifica se pode empenhar com data anterior a do servidor ( retornaram a data )
    select e30_empdataemp,
           e30_empdataserv
      into dataemp, dataserv
      from empparametro
     where e39_anousu = substr(p_dtfim,1,4)::integer ;

    if (dataemp = false) then
      -- nao permite empenhar com data anterior ao ultimo empenho emitido
      select max(e60_emiss)
        into maxdataemp
        from empempenho
       where e60_instit = v_instit;

      if  p_dtfim < maxdataemp  then
        return '11 VOCÊ NÃO PODE EMPENHAR COM DATA INFERIOR AO ULTIMO EMPENHO EMITIDO. INSTITUICAO ('||v_instit||')';
      end if;

    end if;

    if (dataserv = false) then
      -- nao permite empenhar com data superior a data do servidor
      if  p_dtfim > current_date  then
        return '11 VOCÊ NÃO PODE EMPENHAR COM DATA SUPERIOR A DATA DO SISTEMA (SERVIDOR). INSTITUICAO ('||v_instit||')';
      end if;

    end if;

    -- testa se existe a reserva de saldo para est
    select o83_codres
      into v_erro
      from orcreservaaut
     where o83_autori = p_numemp;

    if not found then
      return '11 AUTORIZAÇÃO SEM RESERVA DE SALDO. (' || p_numemp || ').';
    else
      select substr(fc_dotacaosaldo(o80_anousu,o80_coddot,2,p_dtfim,p_dtfim),106,13)::float8, o80_valor
        into v_saldo_dotacao, v_reserva_valor
        from orcreserva
       where o80_codres = V_ERRO;

      if v_saldo_dotacao >= v_reserva_valor then
        return '0  PROCESSO AUTORIZADO (' || v_erro || ').';
      else
        return '12 SEM SALDO NA DOTACAO (' || v_erro || ' - ' || v_saldo_dotacao || ').';
      end if;

    end if;


  end if;

  -- testa os lancamentos do empenho
  select e60_emiss,
         e60_anousu,
         e60_instit
    into v_dtini, v_anousu
    from empempenho
   where e60_numemp = p_numemp;

  if v_dtini is null then
    return '14 Empenho não encontrado.';
  end if;

  if v_anousu < substr(p_dtfim,1,4)::integer then

    select round(round(e91_vlremp,2) - round(e91_vlranu,2),2)::float8,
           round(e91_vlrliq,2)::float8,
           round(e91_vlrpag,2)::float8
      into v_vlremp,v_vlrliq,v_vlrpag
      from empresto
     where e91_anousu = substr(p_dtfim,1,4)::integer
       and e91_numemp = p_numemp;

    if v_vlremp is null then
      return '16 EMPENHO NÃO CADASTRADO COMO RESTOS A PAGAR';
    end if;

    v_dtini := (substr(p_dtfim,1,4)||'-01-01')::date;

    v_vlremp_g := v_vlremp;
    v_vlrliq_g := v_vlrliq;
    v_vlrpag_g := v_vlrpag;

  end if;


  if v_dtini > p_dtfim then
    return '14 Data informada menor que data de emissão do Empenho.';
  end if;

  raise notice 'data ini % - EMP %', v_dtini, p_numemp;

  for c_lanc in
      select c53_coddoc,
             c53_descr,
             c75_numemp,
             c70_data,
             c70_valor
        from conlancamemp
             inner join conlancamdoc on c75_codlan = c71_codlan
             inner join conlancam    on c70_codlan = c75_codlan
             inner join conhistdoc   on c53_coddoc = c71_coddoc
       where c75_numemp = p_numemp
         and c75_data >= v_dtini
    order by c70_data
  loop

    -- RAISE NOTICE '\n%,%,%,%,%',c_lanc.c53_coddoc,c_lanc.c53_descr,c_lanc.c75_numemp,c_lanc.c70_valor,c_lanc.c70_data;

    /**
     * Empenho - 10
     */
    if c_lanc.c53_coddoc in(1, 82, 304, 308, 410, 500, 504) then

      if c_lanc.c70_data <= p_dtfim then
        v_vlremp := round(v_vlremp + c_lanc.c70_valor,2)::float8;
      end if;
      v_vlremp_g := round(v_vlremp_g + c_lanc.c70_valor,2)::float8;

    /**
     * Estorno de Empenho - 11
     */
    elsif c_lanc.c53_coddoc in(2, 83, 305, 309, 411, 501, 505) then

      if c_lanc.c70_data <= p_dtfim then
        v_vlremp := round(v_vlremp - c_lanc.c70_valor,2)::float8;
      end if;
      v_vlremp_g := round(v_vlremp_g - c_lanc.c70_valor,2)::float8;

    /**
     * Estorno de RP nao processado - 11
     */
    elsif c_lanc.c53_coddoc = 32 then
      if c_lanc.c70_data <= p_dtfim then
        v_vlremp := round(v_vlremp - c_lanc.c70_valor,2)::float8;
      end if;
      v_vlremp_g := round(v_vlremp_g - c_lanc.c70_valor,2)::float8;

    /**
     * Liquidacao - 20
     */
    elsif c_lanc.c53_coddoc in(3, 23, 39, 84, 412, 202, 204, 206, 306, 310, 502, 506) then

      if c_lanc.c70_data <= p_dtfim then
        v_vlrliq := round(v_vlrliq + c_lanc.c70_valor,2)::float8;
      end if;
      v_vlrliq_g := round(v_vlrliq_g + c_lanc.c70_valor,2)::float8;

    /**
     * liquidacao de RP - 20
     */
    elsif c_lanc.c53_coddoc = 33 then
      if c_lanc.c70_data <= p_dtfim then
        v_vlrliq := round(v_vlrliq + c_lanc.c70_valor,2)::float8;
      end if;
      v_vlrliq_g := round(v_vlrliq_g + c_lanc.c70_valor,2)::float8;

     /**
      * Anulacao de liquidacao - 21
      */
    elsif c_lanc.c53_coddoc in(4, 24, 40, 85, 203, 205, 207, 413, 307, 311, 503, 507) then
      if c_lanc.c70_data <= p_dtfim then
        v_vlrliq := round(v_vlrliq - c_lanc.c70_valor,2)::float8;
      end if;
      v_vlrliq_g := round(v_vlrliq_g - c_lanc.c70_valor,2)::float8;

    /**
     * Anulacao de Liquidacao de RP - 21
     */
    elsif c_lanc.c53_coddoc = 34 then
      if c_lanc.c70_data <= p_dtfim then
        v_vlrliq := round(v_vlrliq - c_lanc.c70_valor,2)::float8;
      end if;
      v_vlrliq_g := round(v_vlrliq_g - c_lanc.c70_valor,2)::float8;


    /**
     * pagamento - 30
     */
    elsif c_lanc.c53_coddoc = 5 then
      if c_lanc.c70_data <= p_dtfim then
        v_vlrpag := round(v_vlrpag + c_lanc.c70_valor,2)::float8;
      end if;
      v_vlrpag_g := round(v_vlrpag_g + c_lanc.c70_valor,2)::float8;

     /**
      * estorno de pagamento - 31
      */
    elsif c_lanc.c53_coddoc = 6 then
      if c_lanc.c70_data <= p_dtfim then
        v_vlrpag := round(v_vlrpag - c_lanc.c70_valor,2)::float8;
      end if;
      v_vlrpag_g := round(v_vlrpag_g - c_lanc.c70_valor,2)::float8;

     /**
      * Pagamento de RP - 30
      */
    elsif c_lanc.c53_coddoc = 35 then
      if c_lanc.c70_data <= p_dtfim then
        v_vlrpag := round(v_vlrpag /*+ c_lanc.c70_valor*/,2)::float8;
      end if;
      v_vlrpag_g := round(v_vlrpag_g /*+ c_lanc.c70_valor*/,2)::float8;

    /**
     * estorno de pagamento de RP - 31
     */
    elsif c_lanc.c53_coddoc = 36 then
      if c_lanc.c70_data <= p_dtfim then
        v_vlrpag := round(v_vlrpag - c_lanc.c70_valor,2)::float8;
      end if;
      v_vlrpag_g := round(v_vlrpag_g - c_lanc.c70_valor,2)::float8;

    /**
     * Pagamento de RP processado - 30
     */
    elsif c_lanc.c53_coddoc = 37 then
      if c_lanc.c70_data <= p_dtfim then
        v_vlrpag := round(v_vlrpag + c_lanc.c70_valor,2)::float8;
      end if;
      v_vlrpag_g := round(v_vlrpag_g + c_lanc.c70_valor,2)::float8;

      /**
       * Estorno de RP não processado - 31
       */
    elsif c_lanc.c53_coddoc = 38 then
      if c_lanc.c70_data <= p_dtfim then
        v_vlrpag := round(v_vlrpag - c_lanc.c70_valor,2)::float8;
      end if;
      v_vlrpag_g := round(v_vlrpag_g - c_lanc.c70_valor,2)::float8;
    end if;

  end loop;
  --raise notice '%,%,%',v_vlremp,v_vlrliq,v_vlrpag;

  if p_doc = 2 or p_doc = 32 then

    -- testar anulacao de empenho
    -- precisa ter saldo para anular ( emp - liq > 0 )
    -- erro na data passada
    if round(v_vlremp - v_vlrliq,2)::float8 >= p_valor then
      m_erro := '0 PROCESSO AUTORIZADO.';
      v_erro := 0;
    else
      m_erro :=  '01 Não existe saldo para anular nesta data.';
      v_erro := 1;
    end if;

    -- erro geral no empenho
    if v_erro = 0 then
      if round(v_vlremp_g - v_vlrliq_g,2)::float8 >= p_valor then
        m_erro := '0 PROCESSO AUTORIZADO.';
        v_erro := 0;
      else
        m_erro := '02 Não existe saldo geral no empenho para anular.';
        v_erro := 2;
      end if;
    end if;

  end if;

  if p_doc = 3 or p_doc = 33 or p_doc = 23 then

    -- testar liquidacao de empenho
    -- precisa ter saldo para anular ( emp - liq > 0 )
    -- erro na data passada
    if round(v_vlremp - v_vlrliq,2)::float8 >= round(p_valor,2)::float8 then
      m_erro := '0 PROCESSO AUTORIZADO.';
      v_erro := 0;
    else
      m_erro := '03 Não existe saldo a liquidar neste data.';
      v_erro := 3;
    end if;

    -- erro geral no empenho
    if v_erro = 0 then
      if round(v_vlremp_g - v_vlrliq_g,2)::float8 >= p_valor then
        m_erro := '0 PROCESSO AUTORIZADO.';
        v_erro := 0;
      else
        m_erro := '04 Não existe saldo geral no empenho para liquidar.';
        v_erro := 4;
      end if;
    end if;
  end if;

  if p_doc = 4 or p_doc = 34 or p_doc = 24 then

    -- testar estorno de liquidacao de empenho
    -- precisa ter saldo para anular ( emp - liq > 0 )
    -- erro na data passada

    if p_doc = 34 then

      select sum(case
               when c71_coddoc = 33 then
                 c70_valor
               else
                 c70_valor * -1
             end)
        into v_saldodisprp
        from conlancam
             inner join conlancamemp on c75_codlan = c70_codlan
             inner join conlancamdoc on c71_codlan = c70_codlan
       where c75_numemp = p_numemp
         and c71_coddoc in (33, 34)
         and extract (year from c70_data) = extract (year from p_dtfim);

      --raise notice 'disp: %', v_saldodisprp;

      if v_saldodisprp is null then
        v_saldodisprp = 0;
      end if;

      --raise notice 'doc: % - valor: % - disp: % - numemp: % - p_dtfim: %', p_doc, p_valor, v_saldodisprp, p_numemp, p_dtfim;

      if p_valor > v_saldodisprp then
        m_erro := '05 Não existe saldo para anular a liquidação nesta data.) Saldo Disponível: '|| v_saldodisprp;
        v_erro := 5;
      end if;

    end if;

    if v_erro = 0 then
      if round(v_vlrliq - v_vlrpag,2)::float8 >= p_valor then
        m_erro := '0 PROCESSO AUTORIZADO.';
        v_erro := 0;
      else
        m_erro := '05 Não existe saldo para anular a liquidação nesta data.';
        v_erro := 5;
      end if;
    end if;

    -- erro geral no empenho
    if v_erro = 0 then
      if round(v_vlrliq_g - v_vlrpag_g,2)::float8 >= p_valor then
        m_erro := '0 PROCESSO AUTORIZADO.';
        v_erro := 0;
      else
        m_erro := '06 Não existem saldo geral no empenho para estornar a liquidação.';
        v_erro := 6;
      end if;
    end if;

  end if;


  if p_doc = 5 or p_doc = 35  or p_doc = 37 then

    -- testar pagamento de empenho
    -- precisa ter saldo para anular ( emp - liq > 0 )
    -- erro na data passada
    if( round(v_vlrliq - v_vlrpag,2)::float8 >= p_valor) then
      v_erro := 0;
      m_erro := '0 PROCESSO AUTORIZADO.';
    else
      m_erro := '07 Não existe saldo a pagar nesta data. Empenho: ' || to_char(p_numemp, '9999999999');
      v_erro := 7;
    end if;

    -- erro geral no empenho
    if v_erro = 0 then
      if round(v_vlrliq_g - v_vlrpag_g,2)::float8 >= p_valor then
        m_erro := '0 PROCESSO AUTORIZADO.';
        v_erro := 0;
      else
        m_erro := '08 Não existe saldo geral a pagar no empenho.';
        v_erro := 8;
      end if;
    end if;

  end if;

  if p_doc = 6 or p_doc = 36  or p_doc = 38 then

    -- testar anulacao de pagamento empenho
    -- precisa ter saldo para anular ( emp - liq > 0 )
    -- erro na data passada
    if v_vlrpag >= p_valor then
      m_erro := '0 PROCESSO AUTORIZADO.';
      v_erro := 0;
    else
      m_erro := '09 Não existe saldo para anular pagamento nesta data.';
      v_erro := 9;
    end if;

    -- erro geral no empenho
    if v_erro = 0 then
      if v_vlrpag_g >= p_valor then
        m_erro := '0 PROCESSO AUTORIZADO.';
        v_erro := 0;
      else
        m_erro := '10 Não existe saldo geral no empenho para anular o pagamento.';
        v_erro := 10;
      end if;
    end if;

  end if;


  --raise notice ' ate data %,%,%',v_vlremp,v_vlrliq,v_vlrpag;
  --raise notice ' geral    %,%,%',v_vlremp_g,v_vlrliq_g,v_vlrpag_g;

  return m_erro;

end;
$$
language 'plpgsql';-- Função que retorna o total de cotas gastas por uma prestadora para uma especialidade
-- em uma competência. O total de cotas gastas consiste na quantidade de cotas distribuída
-- mais a quantidade de cotas já agendadas pela própria prestatora (prestadora = solicitante)
-- Parâmetros: código da prestadora, estrutural da especialidade, mês e Ano
CREATE OR REPLACE FUNCTION fc_cotasGastasPrestEspecComp(int4, varchar(6), int4, int4)
RETURNS INT4 AS $$
  SELECT (SELECT CASE
                   WHEN SUM(sau_cotasagendamento.s163_i_quantidade) IS NULL
                     THEN 0
                   ELSE SUM(sau_cotasagendamento.s163_i_quantidade)
                 END
            FROM sau_cotasagendamento
              INNER JOIN rhcbo ON rhcbo.rh70_sequencial = sau_cotasagendamento.s163_i_rhcbo
                WHERE sau_cotasagendamento.s163_i_upsprestadora = $1
                  AND sau_cotasagendamento.s163_i_mescomp = $3
                  AND sau_cotasagendamento.s163_i_anocomp = $4
                  AND rhcbo.rh70_estrutural LIKE $2)::int4
         +
         (SELECT CASE
                   WHEN count(*) = 0
                     THEN 0
                   ELSE count(*)
                 END
            FROM agendamentos
              INNER JOIN undmedhorario ON undmedhorario.sd30_i_codigo = agendamentos.sd23_i_undmedhor
              INNER JOIN especmedico ON especmedico.sd27_i_codigo = undmedhorario.sd30_i_undmed
              INNER JOIN unidademedicos ON unidademedicos.sd04_i_codigo  = especmedico.sd27_i_undmed
              INNER JOIN rhcbo ON rhcbo.rh70_sequencial = especmedico.sd27_i_rhcbo
                WHERE unidademedicos.sd04_i_unidade = $1 -- Prestadora
                  AND agendamentos.sd23_i_upssolicitante = $1 -- Solicitante
                  and not EXISTS ( select * from agendaconsultaanula where s114_i_agendaconsulta = sd23_i_codigo )
                  AND agendamentos.sd23_d_consulta BETWEEN ($4::varchar || '-' || $3::varchar || '-01')::date
                    AND ((($4::varchar || '-' || $3::varchar || '-01')::date
                           + '1 month'::interval) - '1 day'::interval)
                  AND rhcbo.rh70_estrutural LIKE $2
                  and sd30_d_valfinal is null)::int4;

$$ LANGUAGE 'sql';create or replace function fc_baixabanco( cod_ret integer, datausu date) returns varchar as
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

  nBloqueado                integer;

  valorlanc                 float8;
  valorlancj                float8;
  valorlancm                float8;

  oidrec                    int8;

  autentsn                  boolean;

  valorrecibo               float8;

  v_total1                  float8 default 0;
  v_total2                  float8 default 0;

  v_estaemrecibopaga        boolean;
  v_estaemrecibo            boolean;
  v_estaemarrecadnormal     boolean;
  v_estaemarrecadunica      boolean;
  lVerificaReceita          boolean;
  lClassi                   boolean;
  lReciboPossuiPgtoParcial  boolean default false;

  nSimDivold                integer;
  nNaoDivold                integer;
  iQtdeParcelasAberto       integer;
  iQtdeParcelasRecibo       integer;

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
  iIdret                    integer;
  v_diferenca               float8 default 0;

  cCliente                  varchar(100);
  iIdRetProcessar           integer;

  -- Abatimentos
  lAtivaPgtoParcial         boolean default false;
  lInsereJurMulCorr         boolean default true;

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
  iNumpreAnterior           integer default 0;

  nVlrCalculado             numeric(15,2) default 0;
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

  iAnoSessao                integer;
  iInstitSessao             integer;

  rReciboPaga               record;
  rContador                 record;
  rRecordDisbanco           record;
  rRecordBanco              record;
  rRecord                   record;
  rRecibo                   record;
  rAcertoDiferenca          record;

  /**
   * variavel de controle do numpre , se tiver ativado o pgto parcial, e essa variavel for dif. de 0
   * os numpres a partir dele serão tratados como pgto parcial, abaixo, sem pgto parcial
   */
  iNumprePagamentoParcial   integer default 0;

  lRaise                    boolean default false;
  sDebug                    text;

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

   /**
     * Inserimos na tmpnaoprocessar os numpres dos idrets onde nao
     * sao encontrada as origens excluindo juro, multa e desconto
     */
    for r_idret in select idret, k00_numpre
                     from disbanco
                    where disbanco.codret = cod_ret
    loop

    perform 1
       from recibopaga
      where recibopaga.k00_numnov = r_idret.k00_numpre
        and recibopaga.k00_hist  not in ( 918, 400, 401 )
        and not
            exists ( select 1
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

      if found then

        if lRaise then
          perform fc_debug(' <baixabanco> NÃO ENCONTRADA ORIGENS, INSERINDO NA tmpnaoprocessar '||r_idret.idret,lRaise,false,false);
        end if;

        insert into tmpnaoprocessar values (r_idret.idret);
      end if;

    end loop;

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
                                     inner join arrecant  c on c.k00_numpre = recibopaga.k00_numpre
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

        --if rRecord.k00_numpre != iNumpreAnterior then

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
        --end if;

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

      if lRaise then
        perform fc_debug('  <PgtoParcial>  - numpre : '||r_idret.numpre||' data para pagamento : '||fc_proximo_dia_util(r_idret.k00_dtpaga)||' data que foi pago : '||r_idret.dtpago||' encontrou outro abatimento : '||lReciboPossuiPgtoParcial,lRaise,false,false);
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


        -- Acerta as origens do Recibo Avulso de acordo os Numpres da recibopaga informado

        select array_to_string(array_accum(iNumpreReciboAvulso || '_' || arrematric.k00_matric || '_' || arrematric.k00_perc), ',')
          into sSql
          from recibopaga
               inner join arrematric on arrematric.k00_numpre = recibopaga.k00_numpre
         where recibopaga.k00_numnov = r_idret.numpre;

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
         and exists (select 1 from recibopaga inner join divold on k00_numpre = k10_numpre and k00_numpar = k10_numpar where k00_numnov = disbanco.k00_numpre)
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
       where disrec.codcla /* = vcodcla;*/
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

$$ language 'plpgsql';create or replace function fc_calculoiptu_araruama_2011(integer,integer,boolean,boolean,boolean,boolean,boolean,integer,integer) returns varchar(100) as
$$

declare

   iMatricula       alias   for $1;
   iAnousu          alias   for $2;
   lGerafinanc      alias   for $3;
   lAtualizaParcela alias   for $4;
   lNovonumpre      alias   for $5;
   lCalculogeral    alias   for $6;
   lDemonstrativo   alias   for $7;
   iParcelaini      alias   for $8;
   iParcelafim      alias   for $9;

   iIdbql           integer default 0;
   iNumcgm          integer default 0;
   iCodcli          integer default 0;
   iCodisen         integer default 0;
   iTipois          integer default 0;
   iParcelas        integer default 0;
   iNumconstr       integer default 0;
   iCodErro         integer default 0;
   iCaracterLote    integer default 0;

   dDatabaixa       date;

   nValorUFISA      numeric default 0;
   nValorMinimo     numeric default 0;
   nAreal           numeric default 0;
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

   tRetorno         text default '';
   tDemo            text default '';

   bFinanceiro      boolean;
   bDadosIptu       boolean;
   lErro            boolean;
   lIsentaxas       boolean;
   lTempagamento    boolean;
   lEmpagamento     boolean;
   bTaxasCalculadas boolean;
   lRaise           boolean default false; -- true para habilitar raise na funcao principal

   rCfiptu          record;

begin
 /**
  *  Retorna o valor do inflator UFISA
  */

  perform fc_debug('INICIANDO CALCULO',lRaise,true,false);
  lRaise    := true;

  /**
   * Executa PRE CALCULO
   */
  select r_iIdbql, r_nAreal, r_nFracao, r_iNumcgm, r_dDatabaixa, r_nFracaolote,
         r_tDemo, r_lTempagamento, r_lEmpagamento, r_iCodisen, r_iTipois, r_nIsenaliq,
         r_lIsentaxas, r_nArealote, r_iCodCli, r_tRetorno

    into iIdbql, nAreal, nFracao, iNumcgm, dDatabaixa, nFracaolote, tDemo, lTempagamento,
         lEmpagamento, iCodisen, iTipois, nIsenaliq, lIsentaxas, nArealo, iCodCli, tRetorno

    from fc_iptu_precalculo( iMatricula, iAnousu, lCalculogeral, lAtualizaParcela, lDemonstrativo, lRaise );

  perform fc_debug(' RETORNO DA PRE CALCULO: ',            lRaise);
  perform fc_debug('  iIdbql        -> ' || iIdbql,        lRaise);
  perform fc_debug('  nAreal        -> ' || nAreal,        lRaise);
  perform fc_debug('  nFracao       -> ' || nFracao,       lRaise);
  perform fc_debug('  iNumcgm       -> ' || iNumcgm,       lRaise);
  perform fc_debug('  dDatabaixa    -> ' || dDatabaixa,    lRaise);
  perform fc_debug('  nFracaolote   -> ' || nFracaolote,   lRaise);
  perform fc_debug('  tDemo         -> ' || tDemo,         lRaise);
  perform fc_debug('  lTempagamento -> ' || lTempagamento, lRaise);
  perform fc_debug('  lEmpagamento  -> ' || lEmpagamento,  lRaise);
  perform fc_debug('  iCodisen      -> ' || iCodisen,      lRaise);
  perform fc_debug('  iTipois       -> ' || iTipois,       lRaise);
  perform fc_debug('  nIsenaliq     -> ' || nIsenaliq,     lRaise);
  perform fc_debug('  lIsentaxas    -> ' || lIsentaxas,    lRaise);
  perform fc_debug('  nArealote     -> ' || nArealo,       lRaise);
  perform fc_debug('  iCodCli       -> ' || iCodCli,       lRaise);
  perform fc_debug('  tRetorno      -> ' || tRetorno,      lRaise);

  /**
   * Variavel de retorno contem a msg
   * de erro retornada do pre calculo
   */
  if trim(tRetorno) <> '' then
    return tRetorno;
  end if;

  perform fc_putsession('anousu_calculo', iAnousu::varchar);

  select fc_get_valor_ufisa(iAnousu)
    into nValorUFISA;

  perform fc_debug('VALOR DO INFLATOR(UFISA) : '|| nValorUFISA, lRaise);

  /* GUARDA OS PARAMETROS DO CALCULO */
  select * from into rCfiptu cfiptu where j18_anousu = iAnousu;

  update tmpdadosiptu set matric = iMatricula;

  /* CALCULA VALOR DO TERRENO */
  perform fc_debug('PARAMETROS fc_iptu_calculavvt_araruama_2011  IDBQL : '||iIdbql||' -- FRACAO DO LOTE '||nFracaolote||' -- DEMO '||tRetorno||' -- ERRO '||lErro||' ', lRaise);

  select rnvvt,
         rnarea,
         rtdemo,
         rtmsgerro,
         rberro
    into nVvt,
         nAreac,
         tDemo,
         tRetorno,
         lErro
    from fc_iptu_calculavvt_araruama_2011(iIdbql, iAnousu, nFracaolote, lDemonstrativo, lRaise);

  if lErro then
    return tRetorno;
  end if;

  perform fc_debug('RETORNO fc_iptu_calculavvt_araruama_2011 -->>> VVT : '||nVvt||' -- AREA CONTRUIDA '||nAreac||' --  RETORNO '||tRetorno||' -- ERRO '||lErro,lRaise);

  /* CALCULA VALOR DA CONSTRUCAO */
  perform fc_debug('PARAMETROS fc_iptu_calculavvc_araruama_2011  MATRICULA '||iMatricula||' -- ANOUSU '||iAnousu||' -- DEMO '||lDemonstrativo||' -- ERRO '||lRaise, lRaise);

  select rnvvc,
         rntotarea,
         rinumconstr,
         rtdemo,
         rtmsgerro,
         rberro
    into nVvc,
         nTotarea,
         iNumconstr,
         tDemo,
         tRetorno,
         lErro
    from fc_iptu_calculavvc_araruama_2011(iMatricula,iAnousu,lDemonstrativo,lRaise);

  perform fc_debug('RETORNO fc_iptu_calculavvc_araruama_2011 -->>> VVC : '||nVvc||' -- AREA TOTAL : '||nTotarea||' --  NUMERO DE CONTRUCOES : '||iNumconstr||' -- RETORNO : '||tRetorno||' -- ERRO : '||lErro, lRaise);

  if nVvc is null or nVvc = 0 and iNumconstr <> 0 then
    return tRetorno;
  end if;
  /**
   *  Calcula valor venal do imovel
   */
  nVv    := nVvc + nVvt;

  /* BUSCA A ALIQUOTA  */
  -- so executar se nao for isento
  if iNumconstr is not null and iNumconstr > 0 then
      select fc_iptu_getaliquota_araruama_2011(iMatricula, iAnousu, iIdbql, iNumcgm, nVv, true,  lRaise) into nAliquota;
  else
      select fc_iptu_getaliquota_araruama_2011(iMatricula, iAnousu, iIdbql, iNumcgm, nVv, false, lRaise) into nAliquota;
  end if;

  if not found or nAliquota = 0 then
     select fc_iptu_geterro(13, '') into tRetorno;
     return tRetorno;
  end if;
-- return nAliquota::text;
/*--------- CALCULA O VALOR DO IPTU  ----------- */

  nViptu := nVv * ( nAliquota / 100 );

 -- seleciona a caracteristica do lote do Grupo 2

 select j35_caract
   into iCaracterLote
   from iptubase
        inner join carlote   on  j35_idbql   =  j01_idbql
        inner join caracter  on  j31_codigo  =  j35_caract
  where j01_matric = iMatricula
    and j31_grupo = 2;

  /**
   * Caso a caracteristica do lote do grupo 4 for 30115
   * o Valor do iptu vai ser 75% do valor do inflator
   * E seta a aliquota = 75%
   *
   * Em outras caracteristicas o valor minimo nÃ£o pode ser menor que o valor
   * do inflator. Por causa disso Ã© estipulado um valor minimo.
   */

  perform fc_debug('iCaracterLote: ' || iCaracterLote , lRaise);

  if iCaracterLote = 30115 then

    update tmpdadosiptu set aliq = nValorUFISA;
    nViptu := nValorUFISA * 0.75;
    perform fc_debug('Aplicando UFISA de 75%: ' || nValorUFISA * 0.75, lRaise );
  else

    if nViptu < nValorUFISA then

      nViptu := nValorUFISA;
      perform fc_debug('Valor calculado Ã© inferior a UFISA. Alterando valor para : ' || nValorUFISA, lRaise );
    end if;
    perform fc_debug('Aplicando UFISA: ' || nValorUFISA , lRaise);
  end if;

  perform fc_debug('VALOR IPTU: '||nViptu, lRaise);

  select count(*)
    into iParcelas
    from cadvencdesc
         inner join cadvenc on q92_codigo = q82_codigo
   where q92_codigo = rCfiptu.j18_vencim ;
  if not found or iParcelas = 0 then
     select fc_iptu_geterro(14, '') into tRetorno;
     return tRetorno;
  end if;

  perform predial from tmpdadosiptu where predial is true;
  if found then
    insert into tmprecval values (rCfiptu.j18_rpredi, nViptu, 1, false);
  else
    insert into tmprecval values (rCfiptu.j18_rterri, nViptu, 1, false);
  end if;

  update tmpdadosiptu set viptu = nViptu, codvenc = rCfiptu.j18_vencim;

  update tmpdadostaxa set anousu = iAnousu, matric = iMatricula, idbql = iIdbql, valiptu = nViptu, valref = rCfiptu.j18_vlrref, vvt = nVvt, nparc = iParcelas;

/* CALCULA AS TAXAS */
  select db21_codcli
    into iCodcli
    from db_config
   where prefeitura is true;

  perform fc_debug('PARAMETROS fc_iptu_calculataxas  ANOUSU '||iAnousu||' -- CODCLI '||iCodcli, lRaise);

  select fc_iptu_calculataxas(iMatricula,iAnousu,iCodcli,lRaise)
    into bTaxasCalculadas;

  perform fc_debug('RETORNO fc_iptu_calculataxas --->>> TAXASCALCULADAS - '||bTaxasCalculadas, lRaise);

/* MONTA O DEMONSTRATIVO */
  select fc_iptu_demonstrativo(iMatricula,iAnousu,iIdbql,lRaise )
    into tDemo;

/* GERA FINANCEIRO */
  if lDemonstrativo is false then -- Se nao for demonstrativo gera o financeiro, caso contrario retorna o demonstrativo

    select fc_iptu_geradadosiptu(iMatricula,iIdbql,iAnousu,nIsenaliq,lDemonstrativo,lRaise)
      into bDadosIptu;

      if lGerafinanc then
        select fc_iptu_gerafinanceiro(iMatricula,iAnousu,iParcelaini,iParcelafim,lCalculogeral,lTempagamento,lNovonumpre,lDemonstrativo,lRaise)
          into bFinanceiro;
      end if;

  else
     return tDemo;
  end if;

  if lDemonstrativo is false then
     update iptucalc set j23_manual = tDemo where j23_matric = iMatricula and j23_anousu = iAnousu;
  end if;

  select fc_iptu_geterro(1, '') into tRetorno;
  return tRetorno;

end;
$$  language 'plpgsql';--drop function if exists fc_iptu_calculavvt_araruama_2011(integer,numeric,boolean,boolean);
--drop function if exists fc_iptu_calculavvt_araruama_2011(integer,integer,numeric,boolean,boolean);

-- drop type if exists tp_iptu_calculavvt;

-- create type tp_iptu_calculavvt as (rnVvt     numeric(15,2),
--                                    rnAreaTotalC    numeric,
--                                    rnArea    numeric,
--                                    rnTestada   numeric,
--                                    rtDemo    text,
--                                    rtMsgerro text,
--                                    rbErro    boolean,
--                                    riCoderro integer,
--                                    rtErro    text);

create or replace function fc_iptu_calculavvt_araruama_2011(integer,integer,numeric,boolean,boolean) returns tp_iptu_calculavvt as
$$
declare

    iIdbql        alias   for   $1;
    iAnousu       alias   for   $2;
    nFracao       alias   for   $3;
    bMostrademo   alias   for   $4;
    lRaise        alias   for   $5;

    rnAreaTotLote numeric;
    rnArealote    numeric;
    nValor        numeric;
    iMatricula    numeric;
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

    perform fc_debug('INICIANDO CALCULO DO VALOR VENAL TERRITORIAL...');
   /**
    * Pega matricula da tabela temporaria
    */
    select matric
      into iMatricula
      from tmpdadosiptu;

    select j34_area,
           j10_vlrter
      into rnArealote,
           nValor
      from iptubase
           inner join iptucalcpadrao on j01_matric = j10_matric
                                    and j10_anousu = iAnousu
           inner join lote           on j34_idbql  = j01_idbql
     where j01_matric = iMatricula;

    if not found then

      select fc_iptu_geterro(113, '') into rtp_iptu_calculavvt.rtMsgerro;
      rtp_iptu_calculavvt.rbErro    := 't';
      return rtp_iptu_calculavvt;
    end if;

    if rnArealote = 0 then

      select fc_iptu_geterro(3, '') into rtp_iptu_calculavvt.rtMsgerro;
      rtp_iptu_calculavvt.rbErro    := 't';
      return rtp_iptu_calculavvt;
    end if;

    if nValor = 0 then

      select fc_iptu_geterro(30, '') into rtp_iptu_calculavvt.rtMsgerro;
      rtp_iptu_calculavvt.rbErro    := 't';
      return rtp_iptu_calculavvt;
    end if;

    rnAreaTotLote                 := rnArealote * (nFracao / 100);
    rtp_iptu_calculavvt.rnArea    := rnAreaTotLote;
    rtp_iptu_calculavvt.rnVvt     := nValor;
    rtp_iptu_calculavvt.rtDemo    := '';
    rtp_iptu_calculavvt.rtMsgerro := '';
    rtp_iptu_calculavvt.rbErro    := 'f';

    update tmpdadosiptu set vvt = nValor, vm2t=(rnArealote/nValor), areat=rnAreaTotLote;

    return rtp_iptu_calculavvt;

end;
$$  language 'plpgsql';create or replace function fc_iptu_calculataxas(integer,integer,integer,boolean) returns boolean as
$$
declare

  iMatric      alias for $1;
  iAnousu      alias for $2;
  iCodCli      alias for $3;
  lRaise       alias for $4;

  vNomefuncao  varchar(100);
  vFuncao      varchar(100);

  nPercIsen    numeric;

  tSql         text default '';
  tRes         text;

  rTaxas       record;
  bFuncao      boolean;
  bIsenTaxas   boolean;

  iTipoIsen    integer;
  iRecTaxa     integer;

  aParam       text[3];

begin

  perform fc_debug(' ', lRaise);
  perform fc_debug(' <iptu_calculataxas> CALCULANDO AS TAXAS DA TABELA IPTUCADTAXAEXE... ', lRaise);

  select tipoisen,
         isentaxas
    into iTipoIsen,
         bIsenTaxas
    from tmpdadosiptu ;

  tSql := tSql||'select * ';
  tSql := tSql||'  from iptucadtaxaexe ';
  tSql := tSql||'       inner join iptucadtaxa    on iptucadtaxa.j07_iptucadtaxa       = iptucadtaxaexe.j08_iptucadtaxa ';
  tSql := tSql||'       left  join iptutaxamatric on iptutaxamatric.j09_iptucadtaxaexe = iptucadtaxaexe.j08_iptucadtaxaexe ';
  tSql := tSql||'                                and iptutaxamatric.j09_matric = '||iMatric;
  tSql := tSql||'       left  join iptucalcconfrec on j23_anousu = '||iAnousu;
  tSql := tSql||'                                 and j23_matric = '||iMatric;
  tSql := tSql||'                                 and j23_recorg = j08_tabrec ';
  tSql := tSql||'                                 and j23_tipo   = 2 ';
  tSql := tSql||' where j08_anousu = '||iAnousu;

  perform fc_debug(' <iptu_calculataxas> SQL BASE DAS TAXAS : ' || coalesce( tSql, '' ), lRaise);

  for rTaxas in execute tSql
  loop

    tRes := '';
    select coalesce(j56_perc,0)::numeric
      into nPercIsen
      from isentaxa
           inner join iptuisen on j56_codigo = j46_codigo
           inner join isenexe  on j47_codigo = j46_codigo
     where j46_matric = iMatric
       and j56_receit = rTaxas.j08_tabrec
       and j47_anousu = iAnousu;

    perform fc_debug(' <iptu_calculataxas> nPercIsen: ' || coalesce( nPercIsen, 0), lRaise);

    if not found  or nPercIsen is null then
      nPercIsen := 0;
    end if;

    if rTaxas.j23_sequencial is null then

      aParam[1] := rTaxas.j08_tabrec::text;
      iRecTaxa  := rTaxas.j08_tabrec::text;
    else

      aParam[1] := rTaxas.j23_recdst::text;
      iRecTaxa  := rTaxas.j23_recdst::text;
    end if;

    aParam[2] := rTaxas.j08_aliq::text;
    aParam[3] := rTaxas.j08_iptucalh::text;
    aParam[4] := nPercIsen::text;

    --
    -- Se tem digitacao manual para a matricula usa o valor da iptutaxamatric(j09_matric)
    --
    if rTaxas.j09_valor is not null and rTaxas.j09_valor > 0 then
      aParam[5] := rTaxas.j09_valor::text;
    else
      aParam[5] := rTaxas.j08_valor::text;
    end if;

    aParam[6] := case when lRaise is true then 'true' else 'false' end;

    tRes      := fc_montachamadafuncao(rTaxas.j08_db_sysfuncoes, iCodCli, aParam, lRaise);

    perform fc_debug(' <iptu_calculataxas> percisen -- ' || nPercIsen ||' histisen -- ' || rTaxas.j08_histisen, lRaise);
    perform fc_debug(' <iptu_calculataxas> FUNCAO ---- ' || tRes, lRaise);

    if tRes is not null then
      execute 'select ' || tRes into bFuncao;
    end if;

    perform fc_debug(' <iptu_calculataxas> iTipoIsen : ' || iTipoIsen || ' bIsenTaxas : ' || coalesce (bIsenTaxas, false ), lRaise);

    if iTipoIsen = 1 then

      if lRaise then
        perform fc_debug(' <iptu_calculataxas> 1 -- update tmptaxapercisen tipo : 1 perc : 100 histisen : ' || rTaxas.j08_histisen, lRaise);
      end if;

      update tmptaxapercisen set histcalcisen = rTaxas.j08_histisen, percisen = 100 where rectaxaisen = iRecTaxa;

    elsif iTipoIsen in ( 0, 2 ) and bIsenTaxas is true then
      if lRaise then
        perform fc_debug(' <iptu_calculataxas> 2 -- update tmptaxapercisen tipo : 0 isentaxas : true perc : 100 histisen : ' || rTaxas.j08_histisen, lRaise);
      end if;

      update tmptaxapercisen set histcalcisen = rTaxas.j08_histisen, percisen = 100 where rectaxaisen = iRecTaxa;

    elsif nPercIsen <> 0 then

      /* nesse momento tem q guardar o percentual de isencao e a receita da taxa */
      if lRaise then
        perform fc_debug(' <iptu_calculataxas> 3 -- update tmptaxapercisen tipo <> 0 histisen : ' || rTaxas.j08_histisen, lRaise);
      end if;

      update tmptaxapercisen set histcalcisen = rTaxas.j08_histisen where rectaxaisen = iRecTaxa;

    end if;

  end loop;

  perform fc_debug(' <iptu_calculataxas> FIM CALCULO DE TAXAS DA TABELA IPTUCADTAXAEXE', lRaise);
  perform fc_debug(' ', lRaise);

  return true;

end;
$$  language 'plpgsql';drop function if exists fc_iptu_demonstrativo(integer,integer,integer,boolean);
create or replace function fc_iptu_demonstrativo(integer,integer,integer,boolean) returns text as
$$
declare

   iMatricula      alias for $1;
   iAnousu         alias for $2;
   iIdql           alias for $3;
   lRaise          alias for $4;

   tDemonstrativo	 text          default '\n';
   tSqlConstr   	 text          default '';
   nTotal          numeric(15,2) default 0;

   iTotalPontos    integer       default 0;
   iNumpreVerifica integer       default 0;

   rValores        record;
   rDadosIptu      record;
   rProprietario   record;
   rEndereco       record;
   rConstr         record;
   rCaract         record;
   rLoteCaract     record;

   lAbatimento     boolean default false;

begin

   lRaise  := (case when fc_getsession('DB_debugon') is null then false else true end);

   perform fc_debug(' <iptu_demonstrativo> Gerando Desmontrativo de Calculo', lRaise);

   /**
    * Verifica se existe Pagamento Parcial para o débito informado
    */
    select j20_numpre
      into iNumpreVerifica
      from iptunump
     where j20_matric = iMatricula
       and j20_anousu = iAnousu
      limit 1;

    if found then

      select fc_verifica_abatimento( 1, ( select j20_numpre
                                           from iptunump
                                          where j20_matric = iMatricula
                                            and j20_anousu = iAnousu
                                          limit 1 ))::boolean into lAbatimento;

      if lAbatimento then
        raise exception '<erro>Operação Cancelada, Débito com Pagamento Parcial!</erro>';
      end if;

    end if;

    /**
     * Dados do Proprietario
     */
   select cgm.z01_cgccpf,
          cgm.z01_ident,
          cgm.z01_ender,
          cgm.z01_numero,
          cgm.z01_bairro,
          cgm.z01_cep,
          cgm.z01_munic,
          cgm.z01_uf,
          cgm.z01_telef,
          cgm.z01_cadast
     into rProprietario
     from cgm
          inner join iptubase on iptubase.j01_numcgm = cgm.z01_numcgm
    where j01_matric = iMatricula;

   tDemonstrativo := tDemonstrativo || LPAD('[ PROPRIETÁRIO ]--',90,'-') || '\n';
   tDemonstrativo := tDemonstrativo || '\n';
   tDemonstrativo := tDemonstrativo || RPAD(' CGC/CPF '             ,55,'.') || ': ' || trim(coalesce(rProprietario.z01_cgccpf,''))               ||' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' IDENTIDADE/INSC.EST ' ,55,'.') || ': ' || trim(coalesce(rProprietario.z01_ident,''))                ||' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' ENDERECO '            ,55,'.') || ': ' || trim(coalesce(rProprietario.z01_ender,''))                ||' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' NUMERO '              ,55,'.') || ': ' || trim(coalesce(rProprietario.z01_numero,0)::varchar)       ||' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' BAIRRO '              ,55,'.') || ': ' || trim(coalesce(rProprietario.z01_bairro,''))               ||' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' CEP '                 ,55,'.') || ': ' || trim(coalesce(rProprietario.z01_cep,''))                  ||' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' MUNICIPIO '           ,55,'.') || ': ' || trim(coalesce(rProprietario.z01_munic,''))                ||' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' UF '                  ,55,'.') || ': ' || trim(coalesce(rProprietario.z01_uf,''))                   ||' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' TELEFONE '            ,55,'.') || ': ' || trim(coalesce(rProprietario.z01_telef,''))                ||' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' DATA DO CADASTRO '    ,55,'.') || ': ' || trim(coalesce(cast(rProprietario.z01_cadast as text),'')) ||' \n';
   tDemonstrativo := tDemonstrativo || '\n';

   /**
    * Endereco do imovel
    */
   select distinct
          iptuconstr.j39_numero,
          iptuconstr.j39_compl,
          ruas.j14_nome,
          bairro.j13_descr,
          lote.j34_setor,
          lote.j34_quadra,
          lote.j34_lote,
          lote.j34_area
     into rEndereco
     from iptubase
          left  join iptuconstr on j01_matric = j39_matric
          inner join lote       on j34_idbql  = j01_idbql
          inner join bairro     on j34_bairro = j13_codi
          inner join testpri    on j01_idbql  = j49_idbql
          inner join ruas       on j49_codigo = j14_codigo
    where iptuconstr.j39_dtdemo is null
      and j01_matric = iMatricula;

   tDemonstrativo := tDemonstrativo || LPAD('[ ENDERECO DO IMÓVEL ]--',90,'-') || '\n';
   tDemonstrativo := tDemonstrativo || '\n';
   tDemonstrativo := tDemonstrativo || RPAD(' LOGRADOURO '            ,55,'.') || ': ' || trim(coalesce(rEndereco.j14_nome,''))            ||' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' NUMERO '                ,55,'.') || ': ' || trim(coalesce(rEndereco.j39_numero::varchar,'')) ||' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' COMPLEMENTO '           ,55,'.') || ': ' || trim(coalesce(rEndereco.j39_compl,''))           ||' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' BAIRRO '                ,55,'.') || ': ' || trim(coalesce(rEndereco.j13_descr,''))           ||' \n';
   tDemonstrativo := tDemonstrativo || '\n';

   /**
    * Dados do lote
    */
   tDemonstrativo := tDemonstrativo || LPAD('[ DADOS DO LOTE ]--' ,90,'-') || '\n';
   tDemonstrativo := tDemonstrativo || '\n';
   tDemonstrativo := tDemonstrativo || RPAD(' SETOR/QUADRA/LOTE ' ,55,'.') || ': ' || trim(coalesce(rEndereco.j34_setor,'') || '/' || coalesce(rEndereco.j34_quadra,'') || '/' || coalesce(rEndereco.j34_lote,'')) || ' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' AREA '              ,55,'.') || ': ' || trim(coalesce(rEndereco.j34_area::varchar,'')) || ' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' TESTADA PRINCIPAL ' ,55,'.') || ': ' || trim(coalesce(rEndereco.j14_nome,''))          || ' \n';
   tDemonstrativo := tDemonstrativo || ' CARACTERISTICAS DO LOTE : \n';

   for rLoteCaract in select j31_codigo, j31_descr, j31_grupo
                        from carlote
                             inner join caracter on j35_caract = j31_codigo
                       where j35_idbql = iIdql
   loop
     tDemonstrativo := tDemonstrativo || LPAD( ' ' || coalesce(rLoteCaract.j31_codigo::varchar, ''), 40, '.') || ' - ' || coalesce(rLoteCaract.j31_descr, '') || ' - GRUPO : ' || rLoteCaract.j31_grupo || '\n';
   end loop;

   tDemonstrativo := tDemonstrativo||'\n';

   /**
    * Dados das construcoes
    */
   tDemonstrativo := tDemonstrativo||LPAD('[ DADOS DAS CONSTRUÇÕES ]--' ,90,'-')||'\n';
   tDemonstrativo := tDemonstrativo||'\n';

   tSqlConstr     :=               'select distinct j39_idcons, j39_area, j39_ano, valor,   ';
   tSqlConstr     := tSqlConstr || '                j39_matric, coalesce(pontos,0) as pontos';
   tSqlConstr     := tSqlConstr || '  from iptuconstr                                       ';
   tSqlConstr     := tSqlConstr || '       inner join tmpiptucale on matric = j39_matric    ';
   tSqlConstr     := tSqlConstr || '                             and idcons = j39_idcons    ';
   tSqlConstr     := tSqlConstr || ' where j39_matric = ' || iMatricula;

   for rConstr in execute tSqlConstr
   loop
      tDemonstrativo := tDemonstrativo || '\n';
      tDemonstrativo := tDemonstrativo || RPAD(' CONSTRUÇÃO '           , 55, '.') || ': ' || coalesce(rConstr.j39_idcons::varchar,'')          || ' \n';
      tDemonstrativo := tDemonstrativo || RPAD(' PONTUAÇÃO '            , 55, '.') || ': ' || coalesce(rConstr.pontos::varchar,'')              || ' \n';
      tDemonstrativo := tDemonstrativo || RPAD(' AREA '                 , 55, '.') || ': ' || coalesce(round(rConstr.j39_area,2)::varchar,'')   || ' \n';
      tDemonstrativo := tDemonstrativo || RPAD(' ANO DA CONSTRUÇÃO '    , 55, '.') || ': ' || coalesce(rConstr.j39_ano::varchar,'')             || ' \n';
      tDemonstrativo := tDemonstrativo || RPAD(' VLR VENAL CONSTRUÇÃO ' , 55, '.') || ': ' || coalesce(round(rConstr.valor,2)::varchar,'')      || ' \n';

      tDemonstrativo := tDemonstrativo||' CARACTERISTICAS DA CONSTRUÇÃO : \n';
      for rCaract in select *
                      from carconstr
                           inner join caracter on j48_caract = j31_codigo
                     where j48_matric = rConstr.j39_matric
                       and j48_idcons = rConstr.j39_idcons
      loop
        tDemonstrativo := tDemonstrativo || LPAD(' ' || rCaract.j31_codigo, 40, '.') || ' - ' || coalesce(rCaract.j31_descr, '') || ' - GRUPO : ' || rCaract.j31_grupo || '\n';
      end loop;

   end loop;

   tDemonstrativo := tDemonstrativo||'\n';

   /**
    * Dados do financeiro
    */
   select * from tmpdadosiptu into rDadosIptu;

   select sum(coalesce(pontos,0))
     into iTotalPontos
     from tmpiptucale;

   tDemonstrativo := tDemonstrativo || LPAD('[ CALCULO ' || coalesce(IAnousu::varchar, '') || ' ]--', 90, '-') || '\n';
   tDemonstrativo := tDemonstrativo || '\n';
   tDemonstrativo := tDemonstrativo || RPAD(' PONTUAÇÃO '            , 55, '.') || ': ' || coalesce(iTotalPontos::varchar, '') ||'  \n';
   tDemonstrativo := tDemonstrativo || RPAD(' AREA P/ CALCULO '      , 55, '.') || ': ' || coalesce(round( (rDadosIptu.areat*rDadosIptu.fracao)/100 ,2)::varchar,'') || ' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' FRACAO '               , 55, '.') || ': ' || coalesce(round( rDadosIptu.fracao, 2)::varchar, '') || '% \n';
   tDemonstrativo := tDemonstrativo || RPAD(' ALIQUOTA '             , 55, '.') || ': ' || coalesce(round( rDadosIptu.aliq, 2)::varchar, '')   || '% \n';
   tDemonstrativo := tDemonstrativo || RPAD(' VALOR VENAL TERRENO '  , 55, '.') || ': ' || coalesce(round( rDadosIptu.vvt, 2)::varchar, '')    || ' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' VALOR VENAL EDIFIC '   , 55, '.') || ': ' || coalesce(round( rDadosIptu.vvc, 2)::varchar, '')    || ' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' AREA EDIFICADA '       , 55, '.') || ': ' || coalesce(round( rDadosIptu.areat, 2)::varchar,'')   || ' \n';
   tDemonstrativo := tDemonstrativo || RPAD(' VALOR M2 DO TERRENO '  , 55, '.') || ': ' || coalesce(round( rDadosIptu.vm2t, 2)::varchar, '')   || ' \n';

 for rValores in select *
                   from tmprecval
                        inner join tabrec on receita = k02_codigo
 loop
   tDemonstrativo := tDemonstrativo || RPAD(' VALOR ' || coalesce(rValores.k02_descr::varchar, ''), 55, '.') || ': ' || coalesce( round(rValores.valor, 2)::varchar, '') || '\n';
   nTotal         := nTotal + rValores.valor;
 end loop;

 tDemonstrativo := tDemonstrativo || RPAD(' TOTAL A PAGAR ', 55, '.') || ': ' || coalesce(nTotal, 0) || '  \n';

 return tDemonstrativo;

end;
$$  language 'plpgsql';create or replace function fc_iptu_geradadosiptu(integer,integer,integer,numeric,boolean,boolean) returns boolean as
$$
declare

    iMatricula          alias for $1;
    iIdbql              alias for $2;
    iAnousu             alias for $3;
    nAliqIsen           alias for $4;
    bRaise              alias for $6;

    nTestada            numeric       default 0;
    nBase               numeric(15,2) default 0;

    nViptu              numeric(15,2) default 0;
    nVlrisen            numeric(15,2) default 0;
    nAreatrib           numeric       default 0;
    nAreal              numeric       default 0;

    iReciptu            integer;
    iVencim             integer;
    iHistiptu           integer;
    iHistIsenIptu       integer;
    iHistIsenI          integer;
    iTipoIsen           integer;
    iEspReciptu         integer;
    iTipoCalculo        integer;

    dDtoper             date;
    bErro               boolean;
    bIsenTaxas          boolean;
    lTemDigitacaoManual boolean;
    tSql                text    default '';

    rDadosIptu          record;
    rIptucale           record;
    rIptucalv           record;

    lRaise              boolean;

begin

  lRaise              := bRaise;
  lTemDigitacaoManual := fc_getsession('DB_iptumanual');

  perform fc_debug(' <iptu_geradadosiptu> Gerando Dados Iptu', lRaise);
  perform fc_debug(' <iptu_geradadosiptu> nAliqIsen: ' || nAliqIsen, lRaise);

  iTipoCalculo := 1;
  if lTemDigitacaoManual is not null and lTemDigitacaoManual is true then
    iTipoCalculo := 2;
  end if;

  select tipoisen, isentaxas
    into iTipoIsen, bIsenTaxas
    from tmpdadosiptu;

  /**
   * Insere os dados na iptucale, dados q foram manipulados na tmpiptucale durante o calculo
   */
  insert into iptucale
       select anousu, matric, idcons, round(areaed, 2),
              round(vm2, 2), pontos, round(valor, 2)
         from tmpiptucale;

  select * into rDadosIptu from tmpdadosiptu;

  select sum(areaed) as areaed
    into rIptucale
    from tmpiptucale;

    /**
     * Grava os dados do iptu na iptucalc, iptucalv(onde fica os dados referente aos valores)
     */
   select case when j36_testle = 0
               then j36_testad
               else j36_testle end as j36_testle,
          case when j34_areal  = 0
               then j34_area
              else j34_areal   end as j34_areal
     into nTestada, nAreal
     from testpri
          inner join lote    on j34_idbql = j49_idbql
          inner join face    on j49_face  = j37_face
          inner join testada on j49_face  = j36_face
                            and j49_idbql = j36_idbql
    where j49_idbql = iIdbql;

    select case when rDadosIptu.predial is false
						    then j18_rterri
							  else j18_rpredi
					 end,
					 j18_vencim,
					 j18_dtoper,
					 j18_vlrref,
					 j18_iptuhistisen
      into iReciptu, iVencim, dDtoper, nBase, iHistIsenIptu
      from cfiptu
     where j18_anousu = iAnousu;

   /**
    *  Calcula a area tributada
    */
   begin

     /**
      * Verifica se tem receita especifica por matricula pre-configurada
      * troca a receita default(cfiptu) pela receita especifica( iptucalcconfrec)
      */
     select j23_recdst
       into iEspReciptu
       from iptucalcconfrec
      where j23_matric = iMatricula
        and j23_anousu = iAnousu
        and j23_recorg = iReciptu
        and j23_tipo   = 1;

     if found then

       perform fc_debug(' <iptu_geradadosiptu> Alterando receita: ' || iReciptu || ' por receita especifica: ' || iEspReciptu, lRaise);

       /**
        * Troca a receita da tmprec para seguir a mesma logica na hora de gerar o financeiro
        */
       update tmprecval
          set receita = iEspReciptu
        where receita = iReciptu
          and taxa is false;

       update tmptaxapercisen
          set rectaxaisen = iEspReciptu
        where rectaxaisen = iReciptu;

       iReciptu := iEspReciptu;

     end if;

   exception

     when undefined_table then
     when others then
   end;

   nAreatrib := rIptucale.areaed * (rDadosIptu.fracao / 100);

   perform fc_debug(' <iptu_geradadosiptu> Area tributada: ' || coalesce( nAreatrib, 0 ), lRaise);

   insert into iptucalc
               ( j23_anousu,
                 j23_matric,
                 j23_testad,
                 j23_arealo,
                 j23_areafr,
                 j23_areaed,
                 j23_m2terr,
                 j23_vlrter,
                 j23_aliq  ,
                 j23_vlrisen,
                 j23_tipoim,
                 j23_manual,
                 j23_tipocalculo )
        values ( iAnousu,
                 iMatricula,
                 round(nTestada,         2),
                 round(rDadosIptu.areat, 2),
                 round(rDadosIptu.fracao,2),
                 round(rIptucale.areaed, 2),
                 round(rDadosIptu.vm2t,  2),
                 round(rDadosIptu.vvt,   2),
                 round(rDadosIptu.aliq,  2),
                 round(nVlrisen,         2),
                 (case when rDadosIptu.predial is true then 'P' else 'T' end),
                 '',
                 iTipoCalculo ) ;

    /**
     * Incluindo com taxa false
     */
    for rIptucalv in select *
                       from tmprecval
                            left join tmptaxapercisen on tmprecval.receita = tmptaxapercisen.rectaxaisen
                      where taxa is false
    loop

      perform fc_debug(' <iptu_geradadosiptu> Receita: '           || iReciptu, lRaise);
      perform fc_debug(' <iptu_geradadosiptu> Valor: '             || coalesce( round(rIptucalv.valor,2), 0 ), lRaise);
      perform fc_debug(' <iptu_geradadosiptu> Historico: '         || rIptucalv.hist, lRaise);
      perform fc_debug(' <iptu_geradadosiptu> Historico Insecao: ' || rIptucalv.histcalcisen, lRaise);

      if rIptucalv.hist = 1 then

        iHistiptu  := 1;
        iHistIsenI := iHistIsenIptu;
      else

        iHistiptu  := rIptucalv.hist;
        iHistIsenI := rIptucalv.histcalcisen;
      end if;

      if rIptucalv.valor > 0 then

        insert into iptucalv ( j21_anousu,
                               j21_matric,
                               j21_receit,
                               j21_valor,
                               j21_quant,
                               j21_codhis )
                      values ( iAnousu,
                               iMatricula,
                               iReciptu,
                               round(rIptucalv.valor, 2),
                               0,
                               iHistiptu );
      end if;

      if iTipoIsen = 1 and rIptucalv.valor <> 0 then

         nVlrisen  := rIptucalv.valor * ( 100 / 100);
         perform fc_debug(' <iptu_geradadosiptu> Valor da Isencao: ' || coalesce( nVlrisen, 0 ), lRaise);

         insert into iptucalv ( j21_anousu, j21_matric, j21_receit, j21_valor, j21_quant, j21_codhis )
                       values ( iAnousu, iMatricula, iReciptu, round( ( nVlrisen *-1),2) , 0, iHistIsenI );

      elsif nAliqIsen is not null and nAliqIsen > 0 then

         nVlrisen  := rIptucalv.valor * ( nAliqIsen / 100);
         perform fc_debug(' <iptu_geradadosiptu> Valor da Isencao (Utilizando Aliquota): ' || coalesce( nVlrisen, 0 ), lRaise);

         insert into iptucalv ( j21_anousu, j21_matric, j21_receit, j21_valor, j21_quant, j21_codhis )
                       values ( iAnousu, iMatricula, iReciptu,  round( ( nVlrisen *-1),2) , 0, iHistIsenI );
      end if;

    end loop;

    for rIptucalv in select *
                       from tmprecval
                            inner join tmptaxapercisen on tmprecval.receita = tmptaxapercisen.rectaxaisen
                      where taxa is true
    loop

      perform fc_debug(' <iptu_geradadosiptu> Receita Isencao de Taxa: '    || rIptucalv.rectaxaisen, lRaise);
      perform fc_debug(' <iptu_geradadosiptu> Percentual Isencao de Taxa: ' || rIptucalv.percisen,    lRaise);
      perform fc_debug(' <iptu_geradadosiptu> Taxa: '                        || rIptucalv.taxa,        lRaise);

      /**
       * Grava o valor da isencao na iptucalv
       */
      if rIptucalv.rectaxaisen is not null then

        if rIptucalv.histcalcisen is not null then

          perform fc_debug(' <iptu_geradadosiptu> Incluindo valores', lRaise);

          if rIptucalv.valsemisen <> 0 then

          insert into iptucalv (j21_anousu, j21_matric, j21_receit, j21_valor, j21_quant, j21_codhis)
               values (iAnousu, iMatricula, rIptucalv.receita, round( rIptucalv.valsemisen, 2), 0, rIptucalv.hist);

          end if;

          if rIptucalv.percisen > 0 then

            perform fc_debug(' <iptu_geradadosiptu> Incluindo valor de isencao', lRaise);

            insert into iptucalv (j21_anousu, j21_matric, j21_receit, j21_valor, j21_quant, j21_codhis)
                 values (iAnousu, iMatricula, rIptucalv.receita, round( ((rIptucalv.valsemisen * rIptucalv.percisen) / 100),2) * -1, 0, rIptucalv.histcalcisen);

				  end if;

          update tmprecval
             set valor = ( select round(sum(coalesce(j21_valor, 0)), 2)
                             from iptucalv
                            where j21_matric = iMatricula
                              and j21_receit = receita
                              and j21_anousu = iAnousu )
           where receita = receita;

			  end if;

      end if;

    end loop;

    perform fc_debug(' <iptu_geradadosiptu> Valor Iptu SEM isencao' || rDadosIptu.viptu, lRaise);

    nViptu := rDadosIptu.viptu - ( rDadosIptu.viptu * ( nAliqIsen / 100) );

    perform fc_debug(' <iptu_geradadosiptu> Valor Iptu:'          || nViptu,   lRaise);
    perform fc_debug(' <iptu_geradadosiptu> Valor Iptu isencao: ' || nVlrisen, lRaise);

     update tmpdadosiptu set viptu = nViptu;
     update tmprecval    set valor = nViptu where taxa is false and hist = 1 ;

    return true;

end;
$$  language 'plpgsql';drop              function if exists fc_iptu_gerafinanceiro(integer,integer,integer,integer,boolean,boolean,boolean,boolean,boolean);
drop              function if exists fc_iptu_gerafinanceiro(integer,integer,integer,integer,boolean,boolean,boolean,boolean,boolean,integer);
create or replace function fc_iptu_gerafinanceiro(integer,integer,integer,integer,boolean,boolean,boolean,boolean,boolean) returns boolean as
$$
declare

  iMatricula     alias for $1;
  iAnousu        alias for $2;
  iParcelaini    alias for $3;
  iParcelafim    alias for $4;
  bCalculogeral  alias for $5;
  bTempagamento  alias for $6;
  bNovonumpre    alias for $7;
  bDemo          alias for $8;
  bRaise         alias for $9;

  lAbatimento    boolean default false;
  lRetorno       boolean default false;

begin

  return ( select fc_iptu_gerafinanceiro(iMatricula,iAnousu,iParcelaini,iParcelafim,bCalculogeral,bTempagamento,bNovonumpre,bDemo,bRaise,0) );

end;
$$  language 'plpgsql';

create or replace function fc_iptu_gerafinanceiro(integer,integer,integer,integer,boolean,boolean,boolean,boolean,boolean,integer) returns boolean as
$$
declare

  iMatricula                 alias for $1;
  iAnousu                    alias for $2;
  iParcelaini                alias for $3;
  iParcelafim                alias for $4;
  bCalculogeral              alias for $5;
  bTempagamento              alias for $6;
  bNovonumpre                alias for $7;
  bDemo                      alias for $8;
  bRaise                     alias for $9;
  iDiasVcto                  alias for $10;

  nSoma                      numeric(15,2) default 0;
  nValorpar                  numeric(15,2) default 0;
  nDifValor                  numeric(15,2) default 0;
  nTotalzao                  numeric(15,2) default 0;
  nDiferenca                 numeric(15,2) default 0;
  valorx                     numeric(15,2) default 0;
  valorxx                    numeric(15,2) default 0;
  xxvalor                    numeric(15,2) default 0;
  nTotal			               numeric(15,2) default 0;
  nParcMinima		             numeric(15,2) default 0;
  nPercParcela     	 	       numeric(15,2) default 0;
  nValorTotalAberto          numeric(15,2) default 0;
  nTotalGeradoReceita        numeric(15,2) default 0;

  iVencim                    integer default 0;
  iDigito                    integer default 0;
  iNumpre                    integer default 0;
  iParcelas                  integer default 0;
  iCgm                       integer default 0;
  iNumpreexiste              integer default 0;
  iNumParcelasVenc           integer default 0;
  iNumParcPagasCanceladas    integer default 0;
  iDivisorPerc               integer default 0;
  iUltimaParcelaGerada       integer default 0;

  iDiaPadraoVcto             integer default 0;
  iMesIni                    integer default 0;
  iParcelasPadrao            integer default 0;
  iParcelasProcessadas       integer default 0;
  iNumpreVerifica            integer default 0;

  bMesmonumpre               boolean default false;
  bTrocouMinima	             boolean default false;
  bRetornoSql  	             boolean default false;
  bTemfinanc                 boolean;
  bPassa                     boolean;
  lProcessaVencimentoForcado boolean default false;
  lAbatimento                boolean default false;

  dDtoper                    date;

  cVir            char(1)    default '';
  tSqlTmp         text       default '';
  tWhereParc      text       default '';
  tInParc         text       default '';
  tSql            text       default '';
  tManual         text       default '';

  rVencim                    record;
  rArrecad                   record;
  rRecval                    record;
  rDadosIptu                 record;
  rIptucalv                  record;

  begin

    -- Verifica se existe Pagamento Parcial para o débito informado
    select j20_numpre
      from iptunump
      into iNumpreVerifica
     where j20_matric = iMatricula
       and j20_anousu = iAnousu limit 1;

    if found then
      select fc_verifica_abatimento(1,iNumpreVerifica )::boolean into lAbatimento;
      if lAbatimento then
        raise exception '<erro>Operação Cancelada, Débito com Pagamento Parcial!</erro>';
      end if;
    end if;

    if bRaise is true then
      perform fc_debug('Gerando financeiro',bRaise,false,false);
    end if;

    select coalesce( (select sum(k00_valor)
                        from arrecad
                       where k00_numpre = j20_numpre) ,0 ) as valor_total
      into nValorTotalAberto
      from iptunump
     where j20_matric = iMatricula
       and j20_anousu = iAnousu;

    iMesIni         := iDiasVcto;
    iParcelasPadrao := iParcelaini;
    iDiaPadraoVcto  := iParcelafim;

    if iMesIni <> 0 and iParcelasPadrao <> 0 and iDiaPadraoVcto <> 0 then
      lProcessaVencimentoForcado := true;
    end if;

    select * from tmpdadosiptu into rDadosIptu;

    select nparc
      into iParcelas
      from tmpdadostaxa;

--  verifica codigo de arrecadacao
    select j20_numpre
      into iNumpre
      from iptunump
     where j20_anousu = iAnousu
       and j20_matric = iMatricula;

    perform fc_debug('Calculo geral : '||(case when bCalculogeral is true then 'SIM' else 'NAO' end),bRaise,false,false);
    perform fc_debug('Numpre atual  : '||iNumpre                                 ,bRaise,false,false);
    perform fc_debug('parcelaini : '||iParcelaini||' Parcelafim : '||iParcelafim ,bRaise,false,false);

    if iNumpre is not null then

	  -- se for calculo parcial e nao for demonstrativo
      if bCalculogeral = false and bDemo is false then

        for rArrecad in select distinct
                               k00_numpar
                          from arrecad
                         where k00_numpre = iNumpre
                         order by k00_numpar
        loop

					if iParcelafim = 0 then

						if rArrecad.k00_numpar >= iParcelaini then

							delete from arrecad
							      where k00_numpre = iNumpre
							        and k00_numpar = rArrecad.k00_numpar;

					    tInParc = tInParc||cVir||rArrecad.k00_numpar;
					    cVir = ',';

						end if;

					else

						if rArrecad.k00_numpar >= iParcelaini and rArrecad.k00_numpar <= iParcelafim then

							delete from arrecad
							      where k00_numpre = iNumpre
							        and k00_numpar = rArrecad.k00_numpar;

					    tInParc = tInParc||cVir||rArrecad.k00_numpar;
					    cVir = ',';

						end if;

					end if;

        end loop;

      end if;



      if bNovonumpre = false then

        bMesmonumpre = true;

      else

        if bTempagamento = false then

          if bCalculogeral = false and bDemo is false then

            if bRaise is true then
              raise notice 'deletando iptunump...';
            end if;

            delete from iptunump
                  where j20_anousu = iAnousu
                    and j20_matric = iMatricula;

          end if;

          if bDemo is false then

            select nextval('numpref_k03_numpre_seq')::integer
              into iNumpre;

          end if;

        end if;

      end if;

    else

      if bDemo is false then
        select nextval('numpref_k03_numpre_seq')::integer into iNumpre;
      end if;

    end if;

-- se imune sai
    if not rDadosIptu.tipoisen is null then

      if rDadosIptu.tipoisen = 1 then
        return true;
      end if;

    end if;

    perform fc_debug('Numpre: '||iNumpre,bRaise,false,false);

-- verifica taxas
    nSoma := 0;
    if bRaise is true then
      perform fc_debug('antes dos vencimentos',bRaise,false,false);
    end if;

    --
    -- Esta funcao retorna um select com a consulta para gerar os vencimentos
    -- lendo os parametros iMesIni,iParcelasPadrao,iDiaPadraoVcto... se os parametros forem diferente de 0 a funcao
    -- ira criar uma tabela temporaria com a estrutura do select do cadastro de vencimentos e retornara a string do select
    --
    tSql := ( select fc_iptu_getselectvencimentos(iMatricula,iAnousu,rDadosIptu.codvenc,iMesIni,iParcelasPadrao,iDiaPadraoVcto,nValorTotalAberto,bRaise) );

    execute 'select count(*) from ('|| tSql ||') as x'
       into iParcelas;

    bPassa = true;

    perform fc_debug('Sql retornado dos vencimentos: ' || tSql,bRaise,false,false);

    /* PEGA O CGM Q VAI SER GRAVADO NO ARRECAD E ARRENUMCGM */
    select fc_iptu_getcgmiptu(iMatricula) into iCgm;

    /* PEGA A DATA DE OPERACAO DO CFIPTU */
    select j18_dtoper
      into dDtoper
      from cfiptu
     where j18_anousu = iAnousu;

    select sum(valor)
      into nTotal
      from tmprecval;

    perform fc_debug('TOTAL RETORNADO DA TMPORECVAL: '||nTotal,bRaise,false,false);

    select q92_vlrminimo
   		into nParcMinima
   		from cadvencdesc
     where q92_codigo = rDadosIptu.codvenc;

    select count(distinct q82_parc)
      into iNumParcelasVenc
      from cadvenc
     where q82_codigo = rDadosIptu.codvenc;

    select coalesce(count(distinct k00_numpar),0)
      into iNumParcPagasCanceladas
      from ( select distinct k00_numpar
               from arrecant
              where arrecant.k00_numpre = iNumpre
           ) as x;

	  perform fc_debug('TOTAL: '||nTotal||' - nParcMinima: '||nParcMinima||' - iParcelas: '||iParcelas||' - Divisao (nTotal / iParcelas): '||(nTotal / iParcelas),bRaise,false,false);

    if nTotal > 0 then

		  perform fc_debug('Parcelas: '||iParcelas||' nTotal: '||nTotal,bRaise,false,false);

      if (nTotal / iParcelas) < nParcMinima then

				if floor((nTotal / nParcMinima)::numeric)::integer = 0 then
					 iParcelas := 1;
				else
           iParcelas := floor((nTotal / nParcMinima)::numeric)::integer;
				end if;

        bTrocouMinima := true;

        perform fc_debug('entrou em parcela minima... '       ,bRaise,false,false);
        perform fc_debug('Quantidade de Parcelas: '||iParcelas,bRaise,false,false);

      end if;

		  perform fc_debug('tInParc: '||tInParc,bRaise,false,false);
		  perform fc_debug('',bRaise,false,false);
      perform fc_debug('NUMPRE DO CALCULO: '||iNumpre,bRaise,false,false);
      perform fc_debug('',bRaise,false,false);

      -- Agrupa por receita
      for rRecval in select receita,
                            (select count( distinct receita) from tmprecval) as qtdreceitas,
                            sum(valor) as valor
                       from tmprecval
                      group by receita
                      order by receita
      loop

        xxvalor := 0;
        iParcelasProcessadas := 1;

        perform fc_debug('iParcelasProcessadas '||iParcelasProcessadas||' iParcelas '||iParcelas, bRaise,false,false);

        for rVencim in execute tSql
        loop

          if bTrocouMinima is false then
            nPercParcela := cast(rVencim.q82_perc as numeric(15,2));
          else
            nPercParcela := 100::numeric / iParcelas;
          end if;

          if iParcelas < iParcelasProcessadas and lProcessaVencimentoForcado is false then

            perform fc_debug('PARCELA '||rVencim.q82_parc||' NAO SERA CALCULADA', bRaise,false,false);
            perform fc_debug('', bRaise,false,false);

            continue;

          end if;

          if iParcelaini = 0 then

            perform fc_debug('bPassa = true | iParcelaini = 0', bRaise,false,false);
            bPassa = true;

          else

            if rVencim.q82_parc >= iParcelaini and rVencim.q82_parc <= iParcelafim then
              bPassa = true;
            else
              bPassa = false;
            end if;

          end if;

          if lProcessaVencimentoForcado then
            bPassa = true;
          end if;

          perform fc_debug('Processando parcela = '||( case when bPassa is true then 'SIM' else 'NAO' end ), bRaise,false,false);

          if bPassa is true then

              perform *
                 from fc_statusdebitos(iNumpre,rVencim.q82_parc)
                where rtstatus = 'PAGO'
                   or rtstatus = 'CANCELADO'
                limit 1;

              if found then

                  perform fc_debug(' --- Ignorando parcela '||rVencim.q82_parc||' por estar paga ou cancelada --- ', bRaise,false,false);
                  perform fc_debug('', bRaise,false,false);

                continue;

              end if;

            if rRecval.valor > 0 then

              if iParcelas = iParcelasProcessadas and iNumParcPagasCanceladas = 0 then
                nValorpar := rRecval.valor - xxvalor;
              else
                nValorpar := trunc (rRecval.valor * ( nPercParcela / 100::numeric)::numeric ,2 ); --valor truncado
                xxvalor   := xxvalor + nValorpar;
              end if;

              nSoma      := nSoma + nValorpar;
              bTemfinanc := true;
              iDigito    := fc_digito(iNumpre,rVencim.q82_parc,iParcelas);

              perform fc_debug('', bRaise,false,false);
              perform fc_debug('Parcela: '||rVencim.q82_parc||' Receita:'||rRecval.receita||' Valor:'||nValorpar||' Diff:'||nDifValor, bRaise,false,false);
              perform fc_debug('', bRaise,false,false);

              if bDemo is false then

                perform fc_debug('GERANDO ARRECAD '                   ,bRaise,false,false);
                perform fc_debug(''                                   ,bRaise,false,false);
                perform fc_debug('Numpre .......: '||iNumpre          ,bRaise,false,false);
                perform fc_debug('Numpar .......: '||rVencim.q82_parc ,bRaise,false,false);
                perform fc_debug('Receita ......: '||rRecval.receita  ,bRaise,false,false);
                perform fc_debug('Valor ........: '||nValorpar        ,bRaise,false,false);
                perform fc_debug('Vencimento ...: '||rVencim.q82_parc ,bRaise,false,false);
                perform fc_debug('nDifValor ....: '||nDifValor        ,bRaise,false,false);
                perform fc_debug(''                                   ,bRaise,false,false);

                delete from arrecad
                 where k00_numpre = iNumpre
                   and k00_numpar = rVencim.q82_parc
                   and k00_receit = rRecval.receita;

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
                                     k00_tipo)
                             values (iCgm,
                                     dDtoper,
                                     rRecval.receita,
                                     rVencim.q82_hist,
                                     nValorpar,
                                     rVencim.q82_venc,
                                     iNumpre,
                                     rVencim.q82_parc,
                                     iParcelas,
                                     iDigito,
                                     rVencim.q92_tipo);

                iParcelasProcessadas = ( iParcelasProcessadas + 1 );

              end if;

            end if;

          end if;

          perform fc_debug('', bRaise,false,false);
          perform fc_debug('nValorpar: '||nValorpar||' - nDifValor: '||nDifValor , bRaise,false,false);
          perform fc_debug('', bRaise,false,false);

        end loop;

        /*
         * Lancando a diferenca na ultima parcela
         */
        select max(k00_numpar)
          into iUltimaParcelaGerada
          from arrecad
         where k00_numpre = iNumpre;

        select sum(k00_valor)
          into nTotalGeradoReceita
          from arrecad
         where k00_numpre = iNumpre
           and k00_receit = rRecval.receita;

        update arrecad
           set k00_valor = ( k00_valor + ( rRecval.valor - nTotalGeradoReceita ) )
         where k00_numpre = iNumpre
           and k00_numpar = iUltimaParcelaGerada
           and k00_receit = rRecval.receita;

      end loop;

      if bRaise is true then
        perform fc_debug('depois dos vencimentos...' , bRaise,false,false);
      end if;

      if bTemfinanc = true then

        if bDemo is false then

          select k00_numpre
            into iNumpreexiste
            from arrematric
           where k00_numpre = iNumpre
             and k00_matric = iMatricula;
          if iNumpreexiste is null then

            insert into arrematric (k00_numpre,
                                    k00_matric)
                            values (iNumpre,
                                    iMatricula);
          end if;

        end if;

        if bMesmonumpre = false and bDemo is false then
          insert into iptunump (j20_anousu,
                                j20_matric,
                                j20_numpre)
                        values (iAnousu,
                                iMatricula,
                                iNumpre );
        end if;

      end if;

    end if;

    if bDemo is false then
      update iptucalc set j23_manual = tManual
                    where j23_matric = iMatricula
                      and j23_anousu = iAnousu;
    end if;

    if bRaise is true then
      perform fc_debug('Fim do processamento da funcao iptu_gerafinanceiro...', bRaise, false, true);
    end if;

    return true;

  end;
$$  language 'plpgsql';create or replace function fc_iptu_getfatorcarlote(integer, integer, integer) returns float8 as
$$

  select coalesce(sum(j74_fator), 0) as fator
    from carlote
         inner join carfator cf on cf.j74_caract = carlote.j35_caract
         inner join caracter c  on c.j31_codigo  = cf.j74_caract
   where j31_grupo  = $1
     and j35_idbql  = $2
     and j74_anousu = $3;
$$
language 'sql';create or replace function fc_iptu_getselectvencimentos(integer,integer,integer,integer,integer,integer,float,boolean) returns varchar as
$$
declare

  iMatricula         alias for $1;
  iAnousu            alias for $2;
  iCodCadVenc        alias for $3;
  iMesIni            alias for $4;
  iParcelas          alias for $5;
  iDiaPadrao         alias for $6;
  lRaise             alias for $8;

  iTotalParcelas     integer default 0;
  iParcelaAtual      integer default 0;
  iMesAtual          integer default 0;
  iAnousuAtual       integer default 0;
  iTipo              integer default 0;
  iHist              integer default 0;
  iParcCanceladas    integer default 0;
  iParcCalcular      integer default 0;
  iParcCadvenc       integer default 0;

  nValorPago         float8;
  nValorTotalImposto float8;
  nPercentual        float8;
  nVlrMinimo         float8;
  nValorTotal        float8;
  nTotalNovo         float8;
  nPercCalculadoNovo float8;

  dDataVencimento    date;

  sSqlRetorno        varchar default '';

begin

  select coalesce(sum(case when arrepaga.k00_valor is null then arrecant.k00_valor else arrepaga.k00_valor end ),0)
    into nValorPago
    from iptunump
         inner join arrecant on arrecant.k00_numpre = iptunump.j20_numpre
         left  join arrepaga on arrepaga.k00_numpre = arrecant.k00_numpre
                            and arrepaga.k00_numpar = arrecant.k00_numpar
                            and arrepaga.k00_receit = arrecant.k00_receit
   where j20_matric = iMatricula
     and j20_anousu = iAnousu;

  select sum(valor)
    into nValorTotalImposto
    from tmprecval;

  if nValorPago > 0 then

    if nValorTotalImposto > 0 then
      nPercentual = ( 100 - ( nValorPago / nValorTotalImposto * 100 ) );
    else
      nPercentual = 100;
    end if;

    update tmprecval
       set valor = ( ( valor / 100 ) * nPercentual ) ;
  end if;

  if iMesIni <> 0 and iParcelas <> 0 and iDiaPadrao <> 0 then

    select q92_tipo, q92_hist, q92_vlrminimo
      into iTipo, iHist, nVlrMinimo
      from cadvencdesc
     where q92_codigo = iCodCadVenc;

     select coalesce(max(k00_numpar),0)
       into iParcelaAtual
       from iptunump
            inner join arrecant on arrecant.k00_numpre = iptunump.j20_numpre
      where j20_matric = iMatricula
        and j20_anousu = iAnousu;

    nPercentual    := ( 100::float / iParcelas );
    iTotalParcelas := ( iParcelas + iMesIni -1 );
    iParcelaAtual  := ( iParcelaAtual + 1 );
    iMesAtual      := iMesIni;
    iAnousuAtual   := iAnousu;

    for iParcela in iMesIni..iTotalParcelas loop

        dDataVencimento := cast( iAnousuAtual::varchar||'-'||iMesAtual::varchar||'-'||iDiaPadrao::varchar as date );

        insert into tmp_cadvenc (q92_codigo,q92_tipo,q92_hist,q92_vlrminimo,q82_parc,q82_venc,q82_perc,q82_hist)
                         values (iCodCadVenc,iTipo,iHist,nVlrMinimo,iParcelaAtual,dDataVencimento,nPercentual,iHist);

        iParcelaAtual  := ( iParcelaAtual + 1 );
        iMesAtual      := ( iMesAtual + 1 );
        if iMesAtual > 12 then
          iMesAtual    := 1;
          iAnousuAtual := ( iAnousuAtual + 1 );
        end if;

    end loop;

    sSqlRetorno := 'select q92_codigo,
                           q92_tipo,
                           q92_hist,
                           q92_vlrminimo,
                           q82_parc,
                           q82_venc,
                           q82_perc,
                           q82_hist
                      from tmp_cadvenc ';
  else

    select coalesce(count(*),0)
      into iParcCanceladas
      from ( select distinct k00_numpre,k00_numpar
               from iptunump
                    inner join arrecant on arrecant.k00_numpre = iptunump.j20_numpre
              where j20_matric = iMatricula
                and j20_anousu = iAnousu
           ) as x;

     select ( count(q82_parc) - iParcelas )
       into iParcCadvenc
       from cadvencdesc
            inner join cadvenc on q92_codigo = q82_codigo
      where q92_codigo = iCodCadVenc;

    iParcCalcular := (iParcCadvenc - iParcCanceladas);

    if iParcCanceladas <> 0 then

      if iParcCalcular <> 0 then
        nPercentual := ( 100::float / iParcCalcular );
      else
        nPercentual := ( 100::float );
      end if;
    end if;

    sSqlRetorno = 'select q92_codigo,
                          q92_tipo,
                          q92_hist,
                          q92_vlrminimo,
                          q82_parc,
                          q82_venc,';

    if iParcCanceladas <> 0 then
      sSqlRetorno = sSqlRetorno || nPercentual || '::float8 as q82_perc, ';
    else
      sSqlRetorno = sSqlRetorno || 'q82_perc, ';
    end if;

    sSqlRetorno   = sSqlRetorno || 'q82_hist
                              from cadvencdesc
                                   inner join cadvenc on q92_codigo = q82_codigo
                             where q92_codigo = ' || iCodCadVenc || ' order by q82_parc';

  end if;

  perform fc_debug(' <iptu_getselectvencimentos> ' || sSqlRetorno, lRaise );

  return sSqlRetorno;

end;
$$  language 'plpgsql';create or replace function fc_calculoiptu_guaiba_2015(integer,integer,boolean,boolean,boolean,boolean,boolean,integer,integer) returns varchar(100) as
$$

declare

   iMatricula           alias   for $1;
   iAnousu              alias   for $2;
   lGerafinanceiro      alias   for $3;
   lAtualizaParcela     alias   for $4;
   lNovonumpre          alias   for $5;
   lCalculogeral        alias   for $6;
   lDemonstrativo       alias   for $7;
   iParcelaini          alias   for $8;
   iParcelafim          alias   for $9;

   iIdbql               integer default 0;
   iNumcgm              integer default 0;
   iCodcli              integer default 0;
   iCodisen             integer default 0;
   iTipois              integer default 0;
   iParcelas            integer default 0;
   iNumconstr           integer default 0;
   iZona                integer default 0;

   dDatabaixa           date;

   nAreal               numeric default 0;
   nAreac               numeric default 0;
   nTotarea             numeric default 0;
   nFracao              numeric default 0;
   nFracaolote          numeric default 0;
   nAliquota            numeric default 0;
   nRedutor             numeric default 0;
   nIsenaliq            numeric default 0;
   nArealo              numeric default 0;
   nVvc                 numeric(15,2) default 0;
   nVvt                 numeric(15,2) default 0;
   nVv                  numeric(15,2) default 0;
   nViptu               numeric(15,2) default 0;
   nValorMaxAnoAnterior numeric(15,2) default 0;

   tRetorno              text default '';
   tDemo                 text default '';

   bFinanceiro           boolean;
   bDadosIptu            boolean;
   lErro                 boolean;
   iCodErro              integer;
   tErro                 text;
   lIsentaxas            boolean;
   lTempagamento         boolean;
   lEmpagamento          boolean;
   bTaxasCalculadas      boolean;
   bDescontoRegular      boolean;
   nFatorComercializacao numeric;
   lRaise                boolean default false;
   iContador             integer default 0;

   rCfiptu              record;
   rCarConstr           record;

begin

  lRaise    := ( case when fc_getsession('DB_debugon') is null then false else true end );
  lRaise    := true;

  perform fc_debug('INICIANDO CALCULO',lRaise,true,false);

  /**
   * Executa PRE CALCULO
   */
  select r_iIdbql, r_nAreal, r_nFracao, r_iNumcgm, r_dDatabaixa, r_nFracaolote,
         r_tDemo, r_lTempagamento, r_lEmpagamento, r_iCodisen, r_iTipois, r_nIsenaliq,
         r_lIsentaxas, r_nArealote, r_iCodCli, r_tRetorno

    into iIdbql, nAreal, nFracao, iNumcgm, dDatabaixa, nFracaolote, tDemo, lTempagamento,
         lEmpagamento, iCodisen, iTipois, nIsenaliq, lIsentaxas, nArealo, iCodCli, tRetorno

    from fc_iptu_precalculo( iMatricula, iAnousu, lCalculogeral, lAtualizaParcela, lDemonstrativo, lRaise );

  perform fc_debug(' RETORNO DA PRE CALCULO: ',            lRaise);
  perform fc_debug('  iIdbql        -> ' || iIdbql,        lRaise);
  perform fc_debug('  nAreal        -> ' || nAreal,        lRaise);
  perform fc_debug('  nFracao       -> ' || nFracao,       lRaise);
  perform fc_debug('  iNumcgm       -> ' || iNumcgm,       lRaise);
  perform fc_debug('  dDatabaixa    -> ' || dDatabaixa,    lRaise);
  perform fc_debug('  nFracaolote   -> ' || nFracaolote,   lRaise);
  perform fc_debug('  tDemo         -> ' || tDemo,         lRaise);
  perform fc_debug('  lTempagamento -> ' || lTempagamento, lRaise);
  perform fc_debug('  lEmpagamento  -> ' || lEmpagamento,  lRaise);
  perform fc_debug('  iCodisen      -> ' || iCodisen,      lRaise);
  perform fc_debug('  iTipois       -> ' || iTipois,       lRaise);
  perform fc_debug('  nIsenaliq     -> ' || nIsenaliq,     lRaise);
  perform fc_debug('  lIsentaxas    -> ' || lIsentaxas,    lRaise);
  perform fc_debug('  nArealote     -> ' || nArealo,       lRaise);
  perform fc_debug('  iCodCli       -> ' || iCodCli,       lRaise);
  perform fc_debug('  tRetorno      -> ' || tRetorno,      lRaise);

 /**
   * Variavel de retorno contem a msg
   * de erro retornada do pre calculo
   */
  if trim(tRetorno) <> '' then
    return tRetorno;
  end if;

  /**
   * Guarda os parametros do calculo
   */
  select * from into rCfiptu cfiptu where j18_anousu = iAnousu;

  /**
   * Calcula valor do terreno
   */
  perform fc_debug('PARAMETROS fc_iptu_calculavvt_guaiba_2015 Anousu: '||iAnousu||' - IDBQL: '||iIdbql||' - FRACAO DO LOTE: '||nFracaolote||' DEMO: '||lDemonstrativo||'- j18_vlrref: '||rCfiptu.j18_vlrref::numeric, lRaise);

  select rnvvt, rnarea, rtdemo, rtmsgerro, rberro, riCodErro, rtErro
    into nVvt, nAreac, tDemo, tRetorno, lErro, iCodErro, tErro
    from fc_iptu_calculavvt_guaiba_2015( iMatricula, iIdbql, iAnousu, nFracaolote, lDemonstrativo, lRaise );

  perform fc_debug('RETORNO fc_iptu_calculavvt_guaiba_2015 -> VVT: '||nVvt||' - AREA CONSTRUIDA: '||nAreac||' - RETORNO: '||tRetorno||' - ERRO: '||lErro, lRaise);
  perform fc_debug('', lRaise);

  if lErro is true then

    select fc_iptu_geterro( iCodErro, tErro ) into tRetorno;
    return tRetorno;
  end if;

  /**
   * Calcula valor da construcao
   */
  perform fc_debug('PARAMETROS fc_iptu_calculavvc_guaiba_2015 MATRICULA: '||iMatricula||' - ANOUSU:'||iAnousu, lRaise);

  select rnvvc, rntotarea, rinumconstr, rtdemo, rtmsgerro, rlerro, riCodErro, rtErro
    into nVvc, nTotarea, iNumconstr, tDemo, tRetorno, lErro, iCodErro, tErro
    from fc_iptu_calculavvc_guaiba_2015( iMatricula, iAnousu, lRaise );

  perform fc_debug('RETORNO fc_iptu_calculavvc_guaiba_2015 -> VVC: '||nVvc||' - AREA TOTAL: '||nTotarea||' - NUMERO DE CONSTRUÇÕES: '||iNumconstr||' - RETORNO: '||tRetorno||' - ERRO: '||lErro, lRaise);
  perform fc_debug('', lRaise);

  if lErro is true then

    select fc_iptu_geterro(iCodErro, tErro) into tRetorno;
    return tRetorno;
  end if;

  /**
   * Busca o fator de comercializaçao do imovel
   */
  perform fc_debug('PARAMETROS fc_iptu_get_fator_comercializacao_guaiba_2015 MATRICULA: '||iMatricula||' - ANOUSU:'||iAnousu, lRaise);

  select rnFatorComercializacao, rlerro, riCodErro, rtErro
    into nFatorComercializacao, lErro, iCodErro, tErro
    from fc_iptu_get_fator_comercializacao_guaiba_2015( iMatricula, iAnousu, lRaise );

  perform fc_debug('RETORNO fc_iptu_get_fator_comercializacao_guaiba_2015 -> nFatorComercializacao '||nFatorComercializacao, lRaise);
  perform fc_debug('', lRaise);

  if lErro is true then

    select fc_iptu_geterro(iCodErro, tErro) into tRetorno;
    return tRetorno;
  end if;

  nVv := (nVvc + nVvt) * nFatorComercializacao;

  perform fc_debug('nVv := (nVvc + nVvt) * nFatorComercializacao', lRaise);
  perform fc_debug('nVv := ('||nVvc||' + '||nVvt||') * '||nFatorComercializacao, lRaise);
  perform fc_debug('nVv  = '||nVv, lRaise);

  /**
   * Busca a aliquota e redutor
   */
  if iNumconstr is not null and iNumconstr > 0 then

    perform fc_debug('PARAMETROS fc_iptu_getaliquotaredutor_guaiba_2015 iIdbql: '||iIdbql||' Predial - '||true||' - ANOUSU:'||iAnousu||' nVv - '||nVv, lRaise);

    select rnAliquota, rnRedutor
      into nAliquota, nRedutor
      from fc_iptu_getaliquotaredutor_guaiba_2015(iIdbql, true, iAnousu, nVv, lRaise );
  else

    perform fc_debug('PARAMETROS fc_iptu_getaliquotaredutor_guaiba_2015 iIdbql: '||iIdbql||' Predial - '||false||' - ANOUSU:'||iAnousu||' nVv - '||nVv, lRaise);

    select rnAliquota, rnRedutor
      into nAliquota, nRedutor
      from fc_iptu_getaliquotaredutor_guaiba_2015(iIdbql, false, iAnousu, nVv, lRaise );
  end if;

  perform fc_debug('RETORNO fc_iptu_getaliquotaredutor_guaiba_2015 -> nAliquota '||nAliquota||' nRedutor '||nRedutor, lRaise);
  perform fc_debug('', lRaise);

  if lErro is true then

    select fc_iptu_geterro(iCodErro, tErro) into tRetorno;
    return tRetorno;
  end if;

  perform fc_debug('nVv := nVv * nAliquota / 100', lRaise);
  perform fc_debug('nVv := '||nVv||' * '||nAliquota|| ' / 100', lRaise);
  nVv := nVv * nAliquota / 100;
  perform fc_debug('nVv = '||nVv, lRaise);

  perform fc_debug('nViptu := nVv - nRedutor', lRaise);
  perform fc_debug('nViptu := '||nVv||' - '||nRedutor, lRaise);

  nViptu := nVv - nRedutor;

  /**
   * Verificamos se todas as construçoes estao regulares para que possamos aplicar
   * o desconto de 20% ao valor total do IPTU
   */

  bDescontoRegular := false;
  if iNumconstr <> 0 then

    for rCarConstr in select j48_caract
                        from carconstr
                             inner join caracter on j48_caract = j31_codigo
                             inner join iptuconstr on j48_matric = j39_matric
                                                  and j39_idcons = j48_idcons
                       where j48_matric = iMatricula
                         and j39_dtdemo is null
                         and j31_grupo  = 58 loop
      /**
       * Adicionamos um contador ao for para verificarmos quantas caracteristas do grupo 52
       * foram informadas para esta matricula
       */
      iContador := iContador + 1;
      if rCarConstr.j48_caract = 30168 then

        bDescontoRegular := false;
        exit;
      elsif rCarConstr.j48_caract = 30167 then
        bDescontoRegular := true;
      end if;
    end loop;
  end if;

  /**
   * Caso o número do contador de caracteristicas for inferior ao de construções, significa que
   * há pelo menos uma construção que não fora informada a sua condição(grupo 52), portanto não
   * reberá desconto
   */
  if iContador < iNumconstr then
    bDescontoRegular := false;
  end if;

  if bDescontoRegular then

    perform fc_debug('MATRICULA REGULAR', lRaise);
    perform fc_debug('nViptu := '||nViptu||' * 0.8', lRaise);
    nViptu := nViptu * 0.8;
  end if;

  perform fc_debug('nViptu : ' || nViptu, lRaise);

  select count(*)
    into iParcelas
    from cadvencdesc
         inner join cadvenc on q92_codigo = q82_codigo
   where q92_codigo = rCfiptu.j18_vencim;

  if not found or iParcelas = 0 then

    select fc_iptu_geterro(14, '') into tRetorno;
    return tRetorno;
  end if;

  perform predial from tmpdadosiptu where predial is true;
  if found then
    insert into tmprecval values (rCfiptu.j18_rpredi, nViptu, 1, false);
  else
    insert into tmprecval values (rCfiptu.j18_rterri, nViptu, 1, false);
  end if;

  update tmpdadosiptu
     set viptu = nViptu, codvenc = rCfiptu.j18_vencim;

  update tmpdadostaxa
     set anousu  = iAnousu,
         matric  = iMatricula,
         idbql   = iIdbql,
         valiptu = nViptu,
         valref  = rCfiptu.j18_vlrref,
         vvt     = nVvt,
         nparc   = iParcelas;

  perform fc_debug('PARAMETROS fc_iptu_calculataxas ANOUSU: '||iAnousu||' - CODCLI: '||iCodcli, lRaise);

  /**
   * Calcula as taxas
   */
  select fc_iptu_calculataxas(iMatricula, iAnousu, iCodcli, false)
    into bTaxasCalculadas;

  perform fc_debug('RETORNO fc_iptu_calculataxas -> TAXASCALCULADAS: ' || bTaxasCalculadas, lRaise);

  /**
   * Monta o demonstrativo
   */
  select fc_iptu_demonstrativo(iMatricula, iAnousu, iIdbql, false)
    into tDemo;

  /**
   * Gera financeiro
   *  -> Se nao for demonstrativo gera o financeiro, caso contrario retorna o demonstrativo
   */
  if lDemonstrativo is false then

    select fc_iptu_geradadosiptu(iMatricula, iIdbql, iAnousu, nIsenaliq, lDemonstrativo, false)
      into bDadosIptu;

      if lGerafinanceiro then

        select fc_iptu_gerafinanceiro( iMatricula, iAnousu, iParcelaini, iParcelafim, lCalculogeral, lTempagamento, lNovonumpre, lDemonstrativo, false )
          into bFinanceiro;
      end if;
  else
     return tDemo;
  end if;

  if lDemonstrativo is false then

     update iptucalc
        set j23_manual = tDemo
      where j23_matric = iMatricula
        and j23_anousu = iAnousu;
  end if;

  perform fc_debug('CALCULO CONCLUIDO COM SUCESSO',lRaise, false, true);

  select fc_iptu_geterro(1, '') into tRetorno;
  return tRetorno;

end;
$$ language 'plpgsql';create or replace function fc_iptu_calculavvc_guaiba_2015( iMatricula      integer,
                                                           iAnousu         integer,
                                                           lRaise          boolean,

                                                           OUT rnVvc       numeric(15,2),
                                                           OUT rnTotarea   numeric,
                                                           OUT riNumconstr integer,
                                                           OUT rtDemo      text,
                                                           OUT rtMsgerro   text,
                                                           OUT rlErro      boolean,
                                                           OUT riCodErro   integer,
                                                           OUT rtErro      text
                                                          ) returns record as
$$
declare

    iMatricula     alias for $1;
    iAnousu        alias for $2;
    lRaise         alias for $3;

    nValorVenalTotal     numeric(15,2) default 0;
    iNumeroedificacoes   integer default 0;
    nValorVenal          numeric;
    rFatorDepreciacao    record;
    rValorM2             record;
    lEdificacao          boolean;
    nAreaconstr          numeric(15,2) default 0;
    lMatriculaPredial    boolean;

    tSqlConstr           text    default '';
    lAtualiza            boolean default true;
    rConstr              record;

begin

    perform fc_debug('', lRaise);
    perform fc_debug('' || lpad('',60,'-'), lRaise);
    perform fc_debug('* INICIANDO CALCULO DO VALOR VENAL DA CONSTRUCAO', lRaise);

    rnVvc       := 0;
    rnTotarea   := 0;
    riNumconstr := 0;
    rtDemo      := '';
    rtMsgerro   := 'Retorno ok';
    rlErro      := 'f';
    riCodErro   := 0;
    rtErro      := '';

    tSqlConstr :=               ' select * ';
    tSqlConstr := tSqlConstr || '  from iptuconstr';
    tSqlConstr := tSqlConstr || ' where j39_matric = ' || iMatricula;
    tSqlConstr := tSqlConstr || '   and j39_dtdemo is null';

    perform fc_debug('Select buscando as contrucoes : ' || tSqlConstr, lRaise);

    for rConstr in execute tSqlConstr loop

      lEdificacao := true;

      perform fc_debug('FATOR DE DEPRECIACAO', lRaise);
      rFatorDepreciacao := fc_iptu_get_fator_depreciacao_guaiba_2015( iMatricula, rConstr.j39_idcons, iAnousu, lRaise);
      perform fc_debug('MATRICULA : ' || iMatricula || ' IDCONSTR: ' || rConstr.j39_idcons || 'VALOR: ' || rFatorDepreciacao.rnFatorDepreciacao, lRaise);

      if rFatorDepreciacao.rlErro then

        rlErro    := true;
        riCodErro := rFatorDepreciacao.riCodErro;
        rtErro    := rFatorDepreciacao.rtErro;
        return;
      end if;

      perform fc_debug('VALOR DO METRO QUADRADO', lRaise);

      rValorM2 := fc_iptu_get_valor_metro_quadrado_guaiba_2015( iMatricula, rConstr.j39_idcons, iAnousu, lRaise);
      perform fc_debug('MATRICULA : ' || iMatricula || ' IDCONSTR: ' || rConstr.j39_idcons || 'VALOR: ' || rFatorDepreciacao.rnFatorDepreciacao, lRaise);

      if rValorM2.rlErro then

        rlErro    := true;
        riCodErro := rValorM2.riCodErro;
        rtErro    := rValorM2.rtErro;
        return;
      end if;

      perform fc_debug(' VVC usando formula: ( rConstr.j39_area * rValorM2 * nFatorDepreciacao )', lRaise);
      perform fc_debug('  -> Valores: ( '||rConstr.j39_area||' * '||rValorM2.rnVm2||' * '||rFatorDepreciacao.rnFatorDepreciacao||' )', lRaise);

      nValorVenal        := ( rConstr.j39_area * rValorM2.rnVm2 * rFatorDepreciacao.rnFatorDepreciacao );
      perform fc_debug(' VVC : '||coalesce(nValorVenal,0),lRaise);

      nValorVenalTotal   := nValorVenalTotal + nValorVenal;
      perform fc_debug(' VVC total: '||coalesce(nValorVenalTotal,0),lRaise);

      nAreaconstr        := nAreaconstr + rConstr.j39_area;
      perform fc_debug('Area Construida: ' || coalesce(nAreaconstr,0),lRaise);
      iNumeroedificacoes := iNumeroedificacoes + 1;

      insert into tmpiptucale (anousu, matric,idcons,areaed,vm2,pontos,valor,edificacao)
               values (iAnousu, iMatricula, rConstr.j39_idcons, rConstr.j39_area, rValorM2.rnVm2, 0, nValorVenal, lEdificacao);
      if lAtualiza then

        update tmpdadosiptu set predial = true;
        lAtualiza = false;
      end if;

    end loop;

    perform matric
       from tmpiptucale
    where edificacao is true;

    if found then
      lMatriculaPredial = true;
    else
      lMatriculaPredial = false;
    end if;

    if lMatriculaPredial is true then

      rnVvc       := nValorVenalTotal;
      rnTotarea   := nAreaconstr;
      riNumconstr := iNumeroedificacoes;
      rtDemo      := '';
      rlErro      := 'f';

      update tmpdadosiptu set vvc = rnVvc;
    else

      delete from tmpiptucale;
      update tmpdadosiptu set predial = false;
    end if;

    perform fc_debug('' || lpad('',60,'-'), lRaise);
    perform fc_debug('', lRaise);

  return;

end;
$$  language 'plpgsql';drop function if exists fc_iptu_calculavvt_guaiba_2015(integer, integer, numeric, numeric, boolean, boolean);

create or replace function fc_iptu_calculavvt_guaiba_2015( integer, integer, integer, numeric, boolean, boolean,
                                                           OUT rnVvt        numeric(15,2),
                                                           OUT rnAreaTotalC numeric,
                                                           OUT rnArea       numeric,
                                                           OUT rnTestada    numeric,
                                                           OUT rtDemo       text,
                                                           OUT rtMsgerro    text,
                                                           OUT rbErro       boolean,
                                                           OUT riCoderro    integer,
                                                           OUT rtErro       text ) returns record as
$$
declare

    iMatricula       alias for $1;
    iIdbql           alias for $2;
    iAnousu          alias for $3;
    nFracao          alias for $4;
    lDemonstrativo   alias for $5;
    lRaise           alias for $6;

    rnArealote                    numeric;
    nAreaLoteIsento               numeric;
    nAreaRealLote                 numeric;
    rnAreaCorrigida               numeric;
    rnVm2terreno                  numeric;
    nFatorSituacao                numeric;
    nFatorPedologia               numeric;
    nFatorTopografia              numeric;
    nFatorNivel                   numeric;
    nFatorGleba                   numeric;
    nFatorDepreciacaoProfundidade numeric;

begin

    rnVvt        := 0;
    rnAreaTotalC := 0;
    rnArea       := 0;
    rnTestada    := 0;
    rtDemo       := '';
    rtMsgerro    := '';
    rbErro       := 'f';
    riCoderro    := 0;
    rtErro       := '';

    perform fc_debug('' || lpad('',60,'-'), lRaise);
    perform fc_debug('* INICIANDO CALCULO DO VALOR VENAL TERRITORIAL',lRaise);

    select case when sum(j34_areal) = 0
                then sum(j34_area)
                else sum(j34_areal)  end
           into rnArealote
      from lote
           inner join testpri on j49_idbql  = j34_idbql
           inner join testada on j36_idbql  = j49_idbql
                             and j36_face   = j49_face
                             and j36_codigo = j49_codigo
           inner join face    on j37_face   = j49_face
     where j34_idbql = iIdbql;

    select rnarealo
    into nAreaLoteIsento
    from fc_iptu_verificaisencoes(iMatricula,iAnousu,lDemonstrativo,lRaise);

    perform fc_debug('AREA ISENTA DO LOTE: ' || nAreaLoteIsento,lRaise);
    if nAreaLoteIsento > 0 then

      nAreaRealLote = rnArealote - nAreaLoteIsento;
      perform fc_debug('AREA REAL DO LOTE: ' || nAreaRealLote,lRaise);

      if nAreaRealLote < 0 then

        rtErro    := 'Area real do lote nao pode ser menor que 0 (zero)';
        riCodErro := 17;
        rbErro    := 't';
        return;
      end if;

      perform fc_debug('AREA ISENTA DO LOTE: ' || nAreaLoteIsento,lRaise);
    else
      nAreaRealLote = rnArealote;
    end if;

    if rnArealote is null then

      /**
       * Testada principal nao cadastrada
       */
      rbErro    := 't';
      riCodErro := 6;
      rtErro    := '';
      return;
    end if;

    perform fc_debug('AREA REAL DO LOTE: ' || nAreaRealLote,lRaise);

    select coalesce( j81_valorterreno, 0 )
      into rnVm2terreno
      from facevalor fv
           inner join testpri tp on fv.j81_face = tp.j49_face
     where j81_anousu    = iAnousu
       and tp.j49_idbql  = iIdbql;

    if not found or rnVm2terreno = 0 then

      /**
       * Nao encontrado valor do M2 do terreno para face (facevalor)
       */
      rbErro    := true;
      riCodErro := 25;
      rtErro    := '';
      return;
    end if;

    perform fc_debug('nVlrM2Terreno = ' || rnVm2terreno, lRaise);

    rnAreaCorrigida := ( nAreaRealLote * ( nFracao / 100 ) );
    rnArea          := rnAreaCorrigida;
    perform fc_debug('rnAreaCorrigida = ' || rnAreaCorrigida, lRaise);

    /**
     * Fator de Depreciação de Profundidade
     */
    nFatorDepreciacaoProfundidade := ( select fc_iptu_get_fator_profundidade_guaiba_2015( iIdbql, iAnousu, lRaise ) );
    if nFatorDepreciacaoProfundidade = 0 then

      rbErro    := true;
      riCodErro := 111;
      rtErro    := '';
      return;
    end if;

    /**
     * Fator de Situação
     */
    nFatorSituacao                := ( select fc_iptu_getfatorcarlote( 50, iIdbql, iAnousu ) );
    if nFatorSituacao = 0 then

      rbErro    := true;
      riCodErro := 101;
      rtErro    := '50 - FATOR DE SITUACAO';
      return;
    end if;

    /**
     * Fator de Topografia
     */
    nFatorTopografia              := ( select fc_iptu_getfatorcarlote( 48, iIdbql, iAnousu ) );
    if nFatorTopografia = 0 then

      rbErro    := true;
      riCodErro := 101;
      rtErro    := '48 - FATOR DE TOPOGRAFIA';
      return;
    end if;

    /**
     * Fator de Pedologia
     */
    nFatorPedologia               := ( select fc_iptu_getfatorcarlote( 51, iIdbql, iAnousu ) );
    if nFatorPedologia = 0 then

      rbErro    := true;
      riCodErro := 101;
      rtErro    := '51 - FATOR DE PEDOLOGIA';
      return;
    end if;

    /**
     * Fator de Gleba
     */
    nFatorGleba                   := ( select fc_iptu_getfatorgleba_guaiba_2015( iIdbql ) );

    -- VVT :=  At x Vm2 x Fp x Fs x Ft x Fpe X Gleba
    rnVvt := ( rnAreaCorrigida               *
               rnVm2terreno                  *
               nFatorDepreciacaoProfundidade *
               nFatorSituacao                *
               nFatorTopografia              *
               nFatorPedologia               *
               nFatorGleba );

    perform fc_debug('Calculando VVT utilizando formula: VVT :=  At x Vm2 x Fp x Fs x Ft x Fpe X Gleba',     lRaise);
    perform fc_debug(' -> Valores: VVT := '||rnAreaCorrigida||' x '||rnVm2terreno||' x '||nFatorDepreciacaoProfundidade||' x '||nFatorSituacao||' x '||nFatorTopografia||' x '||nFatorPedologia||' x '||nFatorGleba, lRaise);
    perform fc_debug('AREA CORRIG BRUTA (RAIZ QUADRADA DA PROFUNDIDADE): ' || rnAreaCorrigida,               lRaise);
    perform fc_debug('VALOR METRO QUADRADO DO TERRENO:                   ' || rnVm2terreno,                  lRaise);
    perform fc_debug('FATOR DEPRECIACAO PROFUNDIDADE:                    ' || nFatorDepreciacaoProfundidade, lRaise);
    perform fc_debug('FATOR SITUACAO:                                    ' || nFatorSituacao,                lRaise);
    perform fc_debug('FATOR TOPOGRAFIA:                                  ' || nFatorTopografia,              lRaise);
    perform fc_debug('FATOR PEDOLOGIA:                                   ' || nFatorPedologia,               lRaise);
    perform fc_debug('FATOR GLEBA:                                       ' || nFatorGleba,                   lRaise);
    perform fc_debug('VALOR VENAL TERRENO:                               ' || rnVvt,                         lRaise);

    update tmpdadosiptu set vvt = rnVvt, vm2t = rnVm2terreno, areat = rnAreaCorrigida;

    perform fc_debug('' || lpad('',60,'-'), lRaise);

    return;

end;
$$  language 'plpgsql';create or replace function fc_iptu_get_fator_comercializacao_guaiba_2015( iMatricula                integer,
                                                                          iAnousu                   integer,
                                                                          lRaise                    boolean,

                                                                         OUT rlErro                 boolean,
                                                                         OUT riCodErro              integer,
                                                                         OUT rtErro                 text,
                                                                         OUT rnFatorComercializacao numeric(15,2)) returns record as
$$
declare

  iMatricula alias for $1;
  iAnousu    alias for $2;
  lRaise     alias for $3;

begin

  rlErro                 := false;
  riCodErro              := 0;
  rtErro                 := '';
  rnFatorComercializacao := 0;

  select j110_fator
    into rnFatorComercializacao
    from iptubase
         inner join lote      on j01_idbql = j34_idbql
         inner join zonafator on j34_zona  = j110_zona
   where j01_matric  = iMatricula
     and j110_anousu = iAnousu;

  if rnFatorComercializacao is null then

    rlErro    := true;
    riCodErro := 108;
    rtErro    := iAnousu || ' (zonafator)';
    return;
  end if;

  rnFatorComercializacao := rnFatorComercializacao / 100;

  return;

end;
$$  language 'plpgsql';create or replace function fc_calculoiptu_jaguarao_2015(integer,integer,boolean,boolean,boolean,boolean,boolean,integer,integer) returns varchar(100) as
$$

declare

   iMatricula           alias   for $1;
   iAnousu              alias   for $2;
   lGerafinanceiro      alias   for $3;
   lAtualizaParcela     alias   for $4;
   lNovonumpre          alias   for $5;
   lCalculogeral        alias   for $6;
   lDemonstrativo       alias   for $7;
   iParcelaini          alias   for $8;
   iParcelafim          alias   for $9;

   iIdbql               integer default 0;
   iNumcgm              integer default 0;
   iCodcli              integer default 0;
   iCodisen             integer default 0;
   iTipois              integer default 0;
   iParcelas            integer default 0;
   iNumconstr           integer default 0;
   iZona                integer default 0;

   dDatabaixa           date;

   nAreal               numeric default 0;
   nAreac               numeric default 0;
   nTotarea             numeric default 0;
   nFracao              numeric default 0;
   nFracaolote          numeric default 0;
   nAliquota            numeric default 0;
   nIsenaliq            numeric default 0;
   nArealo              numeric default 0;
   nVvc                 numeric(15,2) default 0;
   nVvt                 numeric(15,2) default 0;
   nVv                  numeric(15,2) default 0;
   nViptu               numeric(15,2) default 0;
   nValorMaxAnoAnterior numeric(15,2) default 0;

   tRetorno             text default '';
   tDemo                text default '';

   bFinanceiro          boolean;
   bDadosIptu           boolean;
   lErro                boolean;
   iCodErro             integer;
   tErro                text;
   bIsentaxas           boolean;
   bTempagamento        boolean;
   bEmpagamento         boolean;
   bTaxasCalculadas     boolean;
   lRaise               boolean default false;

   rCfiptu              record;

begin

  lRaise    := ( case when fc_getsession('DB_debugon') is null then false else true end );

  perform fc_debug('INICIANDO CALCULO',lRaise, true, false);

  /**
   * Executa PRE CALCULO
   */
  select r_iIdbql, r_nAreal, r_nFracao, r_iNumcgm, r_dDatabaixa, r_nFracaolote,
         r_tDemo, r_lTempagamento, r_lEmpagamento, r_iCodisen, r_iTipois, r_nIsenaliq,
         r_lIsentaxas, r_nArealote, r_iCodCli, r_tRetorno

    into iIdbql, nAreal, nFracao, iNumcgm, dDatabaixa, nFracaolote, tDemo, bTempagamento,
         bEmpagamento, iCodisen, iTipois, nIsenaliq, bIsentaxas, nArealo, iCodCli, tRetorno

    from fc_iptu_precalculo( iMatricula, iAnousu, lCalculogeral, lAtualizaParcela, lDemonstrativo, lRaise );

  perform fc_debug(' RETORNO DA PRE CALCULO: ',            lRaise);
  perform fc_debug('  iIdbql        -> ' || iIdbql,        lRaise);
  perform fc_debug('  nAreal        -> ' || nAreal,        lRaise);
  perform fc_debug('  nFracao       -> ' || nFracao,       lRaise);
  perform fc_debug('  iNumcgm       -> ' || iNumcgm,       lRaise);
  perform fc_debug('  dDatabaixa    -> ' || dDatabaixa,    lRaise);
  perform fc_debug('  nFracaolote   -> ' || nFracaolote,   lRaise);
  perform fc_debug('  tDemo         -> ' || tDemo,         lRaise);
  perform fc_debug('  lTempagamento -> ' || bTempagamento, lRaise);
  perform fc_debug('  lEmpagamento  -> ' || bEmpagamento,  lRaise);
  perform fc_debug('  iCodisen      -> ' || iCodisen,      lRaise);
  perform fc_debug('  iTipois       -> ' || iTipois,       lRaise);
  perform fc_debug('  nIsenaliq     -> ' || nIsenaliq,     lRaise);
  perform fc_debug('  lIsentaxas    -> ' || bIsentaxas,    lRaise);
  perform fc_debug('  nArealote     -> ' || nArealo,       lRaise);
  perform fc_debug('  iCodCli       -> ' || iCodCli,       lRaise);
  perform fc_debug('  tRetorno      -> ' || tRetorno,      lRaise);

  /**
   * Variavel de retorno contem a msg
   * de erro retornada do pre calculo
   */
  if trim(tRetorno) <> '' then
    return tRetorno;
  end if;

  /**
   * Guarda os parametros do calculo
   */
  select * from into rCfiptu cfiptu where j18_anousu = iAnousu;

  /**
   * Calcula valor do terreno
   */
  perform fc_debug('PARAMETROS fc_iptu_calculavvt_jaguarao_2015 IDBQL: '||iIdbql||' - FRACAO DO LOTE: '||nFracaolote||' DEMO: '||tRetorno||'- ERRO: '||lErro, lRaise);

  select rnvvt, rnarea, rtdemo, rtmsgerro, rberro, riCodErro, rtErro
    into nVvt, nAreac, tDemo, tRetorno, lErro, iCodErro, tErro
    from fc_iptu_calculavvt_jaguarao_2015( iMatricula, iIdbql, iAnousu, nFracaolote, nAreal, lDemonstrativo, lRaise );

  perform fc_debug('RETORNO fc_iptu_calculavvt_jaguarao_2015 -> VVT: '||nVvt||' - AREA CONSTRUIDA: '||nAreac||' - RETORNO: '||tRetorno||' - ERRO: '||lErro, lRaise);
  perform fc_debug('', lRaise);

  if lErro is true then

    select fc_iptu_geterro( iCodErro, tErro ) into tRetorno;
    return tRetorno;
  end if;

  /**
   * Calcula valor da construcao
   */
  perform fc_debug('PARAMETROS fc_iptu_calculavvc_jaguarao_2015 MATRICULA: '||iMatricula||' - ANOUSU:'||iAnousu||' - DEMO: '||lDemonstrativo, lRaise);

  select rnvvc, rntotarea, rinumconstr, rtdemo, rtmsgerro, rberro, riCodErro, rtErro
    into nVvc, nTotarea, iNumconstr, tDemo, tRetorno, lErro, iCodErro, tErro
    from fc_iptu_calculavvc_jaguarao_2015( iMatricula, iAnousu, lDemonstrativo, lRaise );

  perform fc_debug('RETORNO fc_iptu_calculavvc_jaguarao_2015 -> VVC: '||nVvc||' - AREA TOTAL: '||nTotarea||' - NUMERO DE CONSTRUÇÕES: '||iNumconstr||' - RETORNO: '||tRetorno||' - ERRO: '||lErro, lRaise);
  perform fc_debug('', lRaise);

  if lErro is true then

    select fc_iptu_geterro(iCodErro, tErro) into tRetorno;
    return tRetorno;
  end if;

  if nVvc is null or nVvc = 0 and iNumconstr <> 0 then

    select fc_iptu_geterro(103, '') into tRetorno;
    return tRetorno;
  end if;

  /**
   * Busca a aliquota
   */
  if iNumconstr is not null and iNumconstr > 0 then
    select fc_iptu_getaliquota_jaguarao_2015('true'::boolean, nTotarea::numeric, lRaise) into nAliquota;
  else
    select fc_iptu_getaliquota_jaguarao_2015('false'::boolean, nTotarea::numeric, lRaise) into nAliquota;
  end if;

  if nAliquota = 0 then

    select fc_iptu_geterro(13, '') into tRetorno;
    return tRetorno;
  end if;

  /**
   * Calcula o Valor Venal
   */
  perform fc_debug('' || lpad('',60,'-'), lRaise);

  nVv    := nVvc + nVvt;
  perform fc_debug(' CALCULO DO VALOR VENAL: Vvc= '||nVvc||' nVvt= '||nVvt||' VALOR VENAL= '||nVv, lRaise);

  nViptu := nVv * (nAliquota / 100);
  perform fc_debug(' CALCULO DO VALOR DO IPTU: Vvi= '||nViptu||' Aliquota= '||nAliquota/100, lRaise);

  perform fc_debug('' || lpad('',60,'-'), lRaise);
  /*-------------------------------------------*/

  perform fc_debug('nViptu : ' || nViptu, lRaise);

  select count(*)
    into iParcelas
    from cadvencdesc
         inner join cadvenc on q92_codigo = q82_codigo
   where q92_codigo = rCfiptu.j18_vencim;

  if not found or iParcelas = 0 then

    select fc_iptu_geterro(14, '') into tRetorno;
    return tRetorno;
  end if;

  perform predial from tmpdadosiptu where predial is true;
  if found then
    insert into tmprecval values (rCfiptu.j18_rpredi, nViptu, 1, false);
  else
    insert into tmprecval values (rCfiptu.j18_rterri, nViptu, 1, false);
  end if;

  update tmpdadosiptu
     set viptu = nViptu, codvenc = rCfiptu.j18_vencim;

  update tmpdadostaxa
     set anousu  = iAnousu,
         matric  = iMatricula,
         idbql   = iIdbql,
         valiptu = nViptu,
         valref  = rCfiptu.j18_vlrref,
         vvt     = nVvt,
         nparc   = iParcelas;

  perform fc_debug('PARAMETROS fc_iptu_calculataxas ANOUSU: '||iAnousu||' - CODCLI: '||iCodcli, lRaise);

  /**
   * Calcula as taxas
   */
  select fc_iptu_calculataxas(iMatricula, iAnousu, iCodcli, lRaise)
    into bTaxasCalculadas;

  perform fc_debug('RETORNO fc_iptu_calculataxas -> TAXASCALCULADAS: ' || bTaxasCalculadas, lRaise);

  /**
   * Monta o demonstrativo
   */
  select fc_iptu_demonstrativo(iMatricula, iAnousu, iIdbql, lRaise)
    into tDemo;

  /**
   * Gera financeiro
   *  -> Se nao for demonstrativo gera o financeiro, caso contrario retorna o demonstrativo
   */
  if lDemonstrativo is false then

    select fc_iptu_geradadosiptu(iMatricula, iIdbql, iAnousu, nIsenaliq, lDemonstrativo, lRaise)
      into bDadosIptu;

      if lGerafinanceiro then

        select fc_iptu_gerafinanceiro( iMatricula, iAnousu, iParcelaini, iParcelafim, lCalculogeral, bTempagamento, lNovonumpre, lDemonstrativo, lRaise )
          into bFinanceiro;
      end if;
  else
     return tDemo;
  end if;

  if lDemonstrativo is false then

     update iptucalc
        set j23_manual = tDemo
      where j23_matric = iMatricula
        and j23_anousu = iAnousu;
  end if;

  perform fc_debug('CALCULO CONCLUIDO COM SUCESSO',lRaise, false, true);

  select fc_iptu_geterro(1, '') into tRetorno;
  return tRetorno;

end;
$$ language 'plpgsql';create or replace function fc_iptu_calculavvc_jaguarao_2015( iMatricula      integer,
                                                             iAnousu         integer,
                                                             lDemonstrativo  boolean,
                                                             bRaise          boolean,

                                                             OUT rnVvc       numeric(15,2),
                                                             OUT rnTotarea   numeric,
                                                             OUT riNumconstr integer,
                                                             OUT rtDemo      text,
                                                             OUT rtMsgerro   text,
                                                             OUT rbErro      boolean,
                                                             OUT riCodErro   integer,
                                                             OUT rtErro      text
                                                      ) returns record as
$$
declare

    iMatricula           alias for $1;
    iAnousu              alias for $2;
    lDemonstrativo       alias for $3;
    lRaise               alias for $4;

    nValorVenalTotal     numeric default 0;
    iNumeroedificacoes   integer default 0;
    nVm2c                numeric(15,2) default 0;
    nValorVenal          numeric;
    nAreaconstr          numeric(15,2) default 0;
    lEdificacao          boolean;
    lMatriculaPredial    boolean;

    nPontos              numeric default 0;
    tSqlConstr           text    default '';
    lAtualiza            boolean default true;

    rConstr              record;

begin

    perform fc_debug('', lRaise);
    perform fc_debug('' || lpad('',60,'-'), lRaise);
    perform fc_debug('* INICIANDO CALCULO DO VALOR VENAL DA CONSTRUCAO', lRaise);

    rnVvc       := 0;
    rnTotarea   := 0;
    riNumconstr := 0;
    rtDemo      := '';
    rtMsgerro   := 'Retorno ok';
    rbErro      := 'f';
    riCodErro   := 0;
    rtErro      := '';

    tSqlConstr :=               ' select * ';
    tSqlConstr := tSqlConstr || '  from iptuconstr ';
    tSqlConstr := tSqlConstr || ' where j39_matric = ' || iMatricula;
    tSqlConstr := tSqlConstr || '   and j39_dtdemo is null';

    perform fc_debug('<vvc> Select buscando as contrucoes : ' || tSqlConstr, lRaise);

    for rConstr in execute tSqlConstr loop

      lEdificacao := true;

      select coalesce(j140_valor,0) as vm2c
        into nVm2c
        from carconstr
             inner join caracter                       on j48_caract      = j31_codigo
             inner join agrupamentocaracteristica      on j48_caract      = j139_caracter
             inner join agrupamentocaracteristicavalor on j140_sequencial = j139_agrupamentocaracteristicavalor
       where j48_matric = rConstr.j39_matric
         and j48_idcons = rConstr.j39_idcons
         and j31_grupo  = 20;

      if nVm2c = 0 OR not found then

        rbErro    := 't';
        riCodErro := 104;
        rtErro    := '20.';
        return;
      end if;

      perform fc_debug('<vvc> VALOR DO METRO QUADRADO: ' || nVm2c, lRaise);

      select coalesce(j83_pontos,0) as pontos
        into nPontos
        from iptuconstrpontos
       where j83_matric = rConstr.j39_matric
         and j83_idcons = rConstr.j39_idcons;

      if nPontos = 0 or not found then

        rbErro    := 't';
        riCodErro := 23;
        rtErro    := ', VERIFIQUE O CADASTRO DA CONSTRUCAO.';
        return;
      end if;

      perform fc_debug('<vvc> PONTUACAO: ' || nPontos, lRaise);

      perform fc_debug('<vvc> MATRICULA: ' || iMatricula || ' IDCONSTR: ' || rConstr.j39_idcons || ' ANO: ' || iAnousu || ' VALOR: ' || nVm2c, lRaise);

      perform fc_debug('<vvc> VVC usando formula: ( rConstr.j39_area * nVm2c * (nPontos / 100) )', lRaise);
      perform fc_debug('<vvc> -> Valores: '||rConstr.j39_area||' * '||nVm2c||' * ('||nPontos||' / 100)', lRaise);

      nValorVenal       = rConstr.j39_area * nVm2c * (nPontos / 100);
      nValorVenalTotal := nValorVenalTotal + nValorVenal;
      perform fc_debug('<vvc> Valor venal: ' || coalesce(nValorVenal, 0), lRaise);

      nAreaconstr        := nAreaconstr + rConstr.j39_area;
      perform fc_debug('<vvc> Area Construida: ' || coalesce(nAreaconstr,0),lRaise);
      iNumeroedificacoes := iNumeroedificacoes + 1;

      insert into tmpiptucale (anousu, matric, idcons, areaed, vm2, pontos, valor, edificacao)
           values (iAnousu, iMatricula, rConstr.j39_idcons, rConstr.j39_area, nVm2c, nPontos, nValorVenal, lEdificacao);

      if lAtualiza then

        update tmpdadosiptu set predial = true;
        lAtualiza = false;
      end if;

      perform fc_debug('<vvc>  ',lRaise);

    end loop;

    perform fc_debug('<vvc> Valor total venal: '|| coalesce(nValorVenalTotal, 0), lRaise);

    perform matric
       from tmpiptucale
      where edificacao is true;

    if found then
      lMatriculaPredial = true;
    else
      lMatriculaPredial = false;
    end if;

    if lMatriculaPredial is true then

      rnVvc       := nValorVenalTotal;
      rnTotarea   := nAreaconstr;
      riNumconstr := iNumeroedificacoes;
      rtDemo      := '';
      rbErro      := 'f';

      update tmpdadosiptu set vvc = rnVvc;
    else

      delete from tmpiptucale;
      update tmpdadosiptu set predial = false;
    end if;

      perform fc_debug('' || lpad('',60,'-'), lRaise);
      perform fc_debug('', lRaise);

    return;

end;
$$  language 'plpgsql';create or replace function fc_iptu_calculavvt_jaguarao_2015( integer, integer, integer, numeric, numeric, boolean, boolean,
                                                            OUT rnVvt        numeric(15,2),
                                                            OUT rnAreaTotalC numeric,
                                                            OUT rnArea       numeric,
                                                            OUT rnTestada    numeric,
                                                            OUT rtDemo       text,
                                                            OUT rtMsgerro    text,
                                                            OUT rbErro       boolean,
                                                            OUT riCoderro    integer,
                                                            OUT rtErro       text ) returns record as
$$
declare

    iMatricula        alias for $1;
    iIdbql            alias for $2;
    iAnousu           alias for $3;
    nFracao           alias for $4;
    nAreal            alias for $5;
    lDemonstrativo    alias for $6;
    lRaise            alias for $7;

    rnArealote        numeric default 0;
    nAreaLoteIsento   numeric default 0;
    nAreaRealLote     numeric default 0;
    rnAreaCorrigida   numeric default 0;
    rnVm2terreno      numeric default 0;
    nValorMinimo      numeric default 0;

    iGrupoTopografia  integer default 11;
    iGrupoPedologia   integer default 12;
    iGrupoLocalizacao integer default 13;

    nFatorTopografia  numeric default 0;
    nFatorPedologia   numeric default 0;
    nFatorLocalizacao numeric default 0;

begin

    rnVvt        := 0;
    rnAreaTotalC := 0;
    rnArea       := 0;
    rnTestada    := 0;
    rtDemo       := '';
    rtMsgerro    := '';
    rbErro       := 'f';
    riCoderro    := 0;
    rtErro       := '';

    perform fc_debug('' || lpad('',60,'-'), lRaise);
    perform fc_debug('* INICIANDO CALCULO DO VALOR VENAL TERRITORIAL',lRaise);

    select case when j34_areal = 0
                then j34_area
                else j34_areal end
      into rnArealote
      from lote
           inner join testpri on j49_idbql  = j34_idbql
           inner join testada on j36_idbql  = j49_idbql
                             and j36_face   = j49_face
                             and j36_codigo = j49_codigo
           inner join face    on j37_face   = j49_face
    where j34_idbql = iIdbql;

    if rnArealote is null then

      rbErro    := 't';
      riCodErro := 6;
      rtErro    := '';
      return;
    end if;

    select rnarealo
      into nAreaLoteIsento
      from fc_iptu_verificaisencoes(iMatricula, iAnousu, lDemonstrativo, lRaise);

    if nAreaLoteIsento > 0 then

      perform fc_debug(' AREA REAL DO LOTE: ' || rnArealote, lRaise);
      nAreaRealLote = rnArealote - nAreaLoteIsento;
      if nAreaRealLote < 0 then

        rbErro    := 't';
        riCodErro := 6;
        rtErro    := 'Area real do lote não pode ser menor que 0 (zero)';
        return;
      end if;

      perform fc_debug(' AREA ISENTA DO LOTE: ' || nAreaLoteIsento,lRaise);
    else

      nAreaRealLote = rnArealote;
    end if;

    rnArealote = nAreaRealLote;

    perform fc_debug('AREA REAL DO LOTE APOS ISENCAO: ' || rnArealote,lRaise);

    /**
     * Busca valor do m2 por zona
     */
    select coalesce(j51_valorm2t, 0)
      into rnVm2terreno
      from lote
           inner join zonasvalor on j34_zona = j51_zona
     where j34_idbql  = iIdbql
       and j51_anousu = iAnousu;

    if rnVm2terreno = 0 OR rnVm2terreno is null then

      rbErro    := 't';
      riCodErro := 105;
      rtErro    := ' VERIFIQUE VALOR POR ZONA.';
      return;
    end if;

    perform fc_debug('rnVm2terreno = ' || rnVm2terreno, lRaise);

    rnAreaCorrigida := ( rnArealote * ( nFracao / 100 ) );

    /**
     * Busca Fator de Topografia
     */
    select j140_valor
      into nFatorTopografia
       from lote
            inner join carlote                        on j34_idbql       = j35_idbql
            inner join caracter                       on j35_caract      = j31_codigo
                                                     and j31_grupo       = iGrupoTopografia
            inner join agrupamentocaracteristica      on j35_caract      = j139_caracter
                                                     and j139_anousu     = iAnousu
            inner join agrupamentocaracteristicavalor on j140_sequencial = j139_agrupamentocaracteristicavalor
      where j34_idbql = iIdbql;

    if not found then

      rbErro    := 't';
      riCodErro := 101;
      rtErro    := ' ' || iGrupoTopografia;
      return;
    end if;

    /**
     * Busca Fator de Topografia
     */
    select j140_valor
      into nFatorPedologia
       from lote
            inner join carlote                        on j34_idbql       = j35_idbql
            inner join caracter                       on j35_caract      = j31_codigo
                                                     and j31_grupo       = iGrupoPedologia
            inner join agrupamentocaracteristica      on j35_caract      = j139_caracter
                                                     and j139_anousu     = iAnousu
            inner join agrupamentocaracteristicavalor on j140_sequencial = j139_agrupamentocaracteristicavalor
      where j34_idbql = iIdbql;

    if not found then

      rbErro    := 't';
      riCodErro := 101;
      rtErro    := ' ' || iGrupoPedologia;
      return;
    end if;

    /**
     * Busca Fator de Topografia
     */
    select j140_valor
      into nFatorLocalizacao
       from lote
            inner join carlote                        on j34_idbql       = j35_idbql
            inner join caracter                       on j35_caract      = j31_codigo
                                                     and j31_grupo       = iGrupoLocalizacao
            inner join agrupamentocaracteristica      on j35_caract      = j139_caracter
                                                     and j139_anousu     = iAnousu
            inner join agrupamentocaracteristicavalor on j140_sequencial = j139_agrupamentocaracteristicavalor
      where j34_idbql = iIdbql;

    if not found then

      rbErro    := 't';
      riCodErro := 101;
      rtErro    := ' ' || iGrupoLocalizacao;
      return;
    end if;

    /**
     * VVT = At x Vm2t x Ft x Fp x Fl
     *   At  - Área do terreno
     *   Vm² - Valor do metro quadrado do terreno
     *   Ft  - Fator de topografia
     *   Fp  - Fator de pedologia
     *   Fl  - Fator de localização do terreno
     */

    rnVvt := ( rnAreaCorrigida * rnVm2terreno * nFatorTopografia * nFatorPedologia * nFatorLocalizacao );

    perform fc_debug('Calculando VVT utilizando formula: VVT := At x Vm2t x Ft x Fp x Fl',     lRaise);
    perform fc_debug(' -> Valores: VVT := '||rnAreaCorrigida||' x '||rnVm2terreno||' x '||nFatorTopografia||' x '||nFatorPedologia||' x '||nFatorLocalizacao, lRaise);
    perform fc_debug('AREA CORRIG BRUTA (RAIZ QUADRADA DA PROFUNDIDADE): ' || rnAreaCorrigida,   lRaise);
    perform fc_debug('VALOR METRO QUADRADO DO TERRENO:                   ' || rnVm2terreno,      lRaise);
    perform fc_debug('Fator Topografia:                                  ' || nFatorTopografia,  lRaise);
    perform fc_debug('Fator Pedologia:                                   ' || nFatorPedologia,   lRaise);
    perform fc_debug('Fator Localizacao:                                 ' || nFatorLocalizacao, lRaise);
    perform fc_debug('VVT:                                               ' || rnVvt,             lRaise);

    update tmpdadosiptu
       set vvt   = rnVvt,
           vm2t  = rnVm2terreno,
           areat = rnAreaCorrigida;

    perform fc_debug('' || lpad('',60,'-'), lRaise);

    return;

end;
$$  language 'plpgsql';create or replace function fc_iptu_getaliquota_jaguarao_2015 (boolean, numeric, boolean) returns numeric as
$$
declare

  lPredial        alias for $1;
  nAreaConstruida alias for $2;
  lRaise          alias for $3;

  nAliquota       numeric default 0;

begin

  perform fc_debug( 'DEFININDO ALIQUOTA A APLICAR' , lRaise);
  perform fc_debug( 'IPTU: ' || case when lPredial is true then 'PREDIAL' else 'TERRITORIAL' end, lRaise);
  perform fc_debug( 'AreaConstruida: ' || nAreaConstruida, lRaise);

  nAliquota = 1;
  /**
   * Terrenos com edificacao - predial     - a aliquota de 0,60%
   * Terrenos baldios        - territorial - a aliquota de 1%
   */
  if lPredial is true then
    nAliquota = 0.60;
  end if;

  perform fc_debug('Aliquota Final: ' || nAliquota, lRaise);

  execute 'update tmpdadosiptu set aliq = ' || coalesce( nAliquota, 0 );

  return nAliquota;

end;
$$ language 'plpgsql';create or replace function fc_calculoiptu_jaguarao_2015(integer,integer,boolean,boolean,boolean,boolean,boolean,integer,integer) returns varchar(100) as
$$

declare

   iMatricula           alias   for $1;
   iAnousu              alias   for $2;
   lGerafinanceiro      alias   for $3;
   lAtualizaParcela     alias   for $4;
   lNovonumpre          alias   for $5;
   lCalculogeral        alias   for $6;
   lDemonstrativo       alias   for $7;
   iParcelaini          alias   for $8;
   iParcelafim          alias   for $9;

   iIdbql               integer default 0;
   iNumcgm              integer default 0;
   iCodcli              integer default 0;
   iCodisen             integer default 0;
   iTipois              integer default 0;
   iParcelas            integer default 0;
   iNumconstr           integer default 0;
   iZona                integer default 0;

   dDatabaixa           date;

   nAreal               numeric default 0;
   nAreac               numeric default 0;
   nTotarea             numeric default 0;
   nFracao              numeric default 0;
   nFracaolote          numeric default 0;
   nAliquota            numeric default 0;
   nIsenaliq            numeric default 0;
   nArealo              numeric default 0;
   nVvc                 numeric(15,2) default 0;
   nVvt                 numeric(15,2) default 0;
   nVv                  numeric(15,2) default 0;
   nViptu               numeric(15,2) default 0;
   nValorMaxAnoAnterior numeric(15,2) default 0;

   tRetorno             text default '';
   tDemo                text default '';

   bFinanceiro          boolean;
   bDadosIptu           boolean;
   lErro                boolean;
   iCodErro             integer;
   tErro                text;
   bIsentaxas           boolean;
   bTempagamento        boolean;
   bEmpagamento         boolean;
   bTaxasCalculadas     boolean;
   lRaise               boolean default false;

   rCfiptu              record;

begin

  lRaise    := ( case when fc_getsession('DB_debugon') is null then false else true end );

  perform fc_debug('INICIANDO CALCULO',lRaise,true,false);

  /**
   * Executa PRE CALCULO
   */
  select r_iIdbql, r_nAreal, r_nFracao, r_iNumcgm, r_dDatabaixa, r_nFracaolote,
         r_tDemo, r_lTempagamento, r_lEmpagamento, r_iCodisen, r_iTipois, r_nIsenaliq,
         r_lIsentaxas, r_nArealote, r_iCodCli, r_tRetorno

    into iIdbql, nAreal, nFracao, iNumcgm, dDatabaixa, nFracaolote, tDemo, bTempagamento,
         bEmpagamento, iCodisen, iTipois, nIsenaliq, bIsentaxas, nArealo, iCodCli, tRetorno

    from fc_iptu_precalculo( iMatricula, iAnousu, lCalculogeral, lAtualizaParcela, lDemonstrativo, lRaise );

  perform fc_debug(' RETORNO DA PRE CALCULO: ',            lRaise);
  perform fc_debug('  iIdbql        -> ' || iIdbql,        lRaise);
  perform fc_debug('  nAreal        -> ' || nAreal,        lRaise);
  perform fc_debug('  nFracao       -> ' || nFracao,       lRaise);
  perform fc_debug('  iNumcgm       -> ' || iNumcgm,       lRaise);
  perform fc_debug('  dDatabaixa    -> ' || dDatabaixa,    lRaise);
  perform fc_debug('  nFracaolote   -> ' || nFracaolote,   lRaise);
  perform fc_debug('  tDemo         -> ' || tDemo,         lRaise);
  perform fc_debug('  lTempagamento -> ' || bTempagamento, lRaise);
  perform fc_debug('  lEmpagamento  -> ' || bEmpagamento,  lRaise);
  perform fc_debug('  iCodisen      -> ' || iCodisen,      lRaise);
  perform fc_debug('  iTipois       -> ' || iTipois,       lRaise);
  perform fc_debug('  nIsenaliq     -> ' || nIsenaliq,     lRaise);
  perform fc_debug('  lIsentaxas    -> ' || bIsentaxas,    lRaise);
  perform fc_debug('  nArealote     -> ' || nArealo,       lRaise);
  perform fc_debug('  iCodCli       -> ' || iCodCli,       lRaise);
  perform fc_debug('  tRetorno      -> ' || tRetorno,      lRaise);

  /**
   * Variavel de retorno contem a msg
   * de erro retornada do pre calculo
   */
  if trim(tRetorno) <> '' then
    return tRetorno;
  end if;

  /**
   * Guarda os parametros do calculo
   */
  select * from into rCfiptu cfiptu where j18_anousu = iAnousu;

  /**
   * Calcula valor do terreno
   */
  perform fc_debug('PARAMETROS fc_iptu_calculavvt_jaguarao_2015 IDBQL: '||iIdbql||' - FRACAO DO LOTE: '||nFracaolote||' DEMO: '||tRetorno||'- ERRO: '||lErro, lRaise);

  select rnvvt, rnarea, rtdemo, rtmsgerro, rberro, riCodErro, rtErro
    into nVvt, nAreac, tDemo, tRetorno, lErro, iCodErro, tErro
    from fc_iptu_calculavvt_jaguarao_2015( iAnousu ,iIdbql, nFracaolote, rCfiptu.j18_vlrref::numeric, lDemonstrativo, lRaise );

  perform fc_debug('RETORNO fc_iptu_calculavvt_jaguarao_2015 -> VVT: '||nVvt||' - AREA CONSTRUIDA: '||nAreac||' - RETORNO: '||tRetorno||' - ERRO: '||lErro, lRaise);
  perform fc_debug('', lRaise);

  if lErro is true then

    select fc_iptu_geterro( iCodErro, tErro ) into tRetorno;
    return tRetorno;
  end if;

  /**
   * Calcula valor da construcao
   */
  perform fc_debug('PARAMETROS fc_iptu_calculavvc_jaguarao_2015 MATRICULA: '||iMatricula||' - ANOUSU:'||iAnousu||' - DEMO: '||lDemonstrativo, lRaise);

  select rnvvc, rntotarea, rinumconstr, rtdemo, rtmsgerro, rberro, riCodErro, rtErro
    into nVvc, nTotarea, iNumconstr, tDemo, tRetorno, lErro, iCodErro, tErro
    from fc_iptu_calculavvc_jaguarao_2015( iMatricula, iAnousu, rCfiptu.j18_vlrref::numeric, lDemonstrativo, lRaise );

  perform fc_debug('RETORNO fc_iptu_calculavvc_jaguarao_2015 -> VVC: '||nVvc||' - AREA TOTAL: '||nTotarea||' - NUMERO DE CONSTRUÇÕES: '||iNumconstr||' - RETORNO: '||tRetorno||' - ERRO: '||lErro, lRaise);
  perform fc_debug('', lRaise);

  if lErro is true then

    select fc_iptu_geterro(iCodErro, tErro) into tRetorno;
    return tRetorno;
  end if;

  if nVvc is null or nVvc = 0 and iNumconstr <> 0 then

    select fc_iptu_geterro(22, '') into tRetorno;
    return tRetorno;
  end if;

  /**
   * Busca a aliquota
   */
  if iNumconstr is not null and iNumconstr > 0 then
    select fc_iptu_getaliquota_jaguarao_2015('true'::boolean, nTotarea::numeric, lRaise) into nAliquota;
  else
    select fc_iptu_getaliquota_jaguarao_2015('false'::boolean, nTotarea::numeric, lRaise) into nAliquota;
  end if;

  if nAliquota = 0 then

    select fc_iptu_geterro(13, '') into tRetorno;
    return tRetorno;
  end if;

  /**
   * Calcula o Valor Venal
   */
  perform fc_debug('' || lpad('',60,'-'), lRaise);

  nVv    := nVvc + nVvt;
  perform fc_debug(' CALCULO DO VALOR VENAL: Vvc= '||nVvc||' nVvt= '||nVvt||' VALOR VENAL= '||nVv, lRaise);

  nViptu := nVv * (nAliquota / 100);
  perform fc_debug(' CALCULO DO VALOR DO IPTU: Vvi= '||nViptu||' Aliquota= '||nAliquota/100, lRaise);

  perform fc_debug('' || lpad('',60,'-'), lRaise);
  /*-------------------------------------------*/

  perform fc_debug('nViptu : ' || nViptu, lRaise);

  select count(*)
    into iParcelas
    from cadvencdesc
         inner join cadvenc on q92_codigo = q82_codigo
   where q92_codigo = rCfiptu.j18_vencim;

  if not found or iParcelas = 0 then

    select fc_iptu_geterro(14, '') into tRetorno;
    return tRetorno;
  end if;

  perform predial from tmpdadosiptu where predial is true;
  if found then
    insert into tmprecval values (rCfiptu.j18_rpredi, nViptu, 1, false);
  else
    insert into tmprecval values (rCfiptu.j18_rterri, nViptu, 1, false);
  end if;

  update tmpdadosiptu
     set viptu = nViptu, codvenc = rCfiptu.j18_vencim;

  update tmpdadostaxa
     set anousu  = iAnousu,
         matric  = iMatricula,
         idbql   = iIdbql,
         valiptu = nViptu,
         valref  = rCfiptu.j18_vlrref,
         vvt     = nVvt,
         nparc   = iParcelas;

  perform fc_debug('PARAMETROS fc_iptu_calculataxas ANOUSU: '||iAnousu||' - CODCLI: '||iCodcli, lRaise);

  /**
   * Calcula as taxas
   */
  select fc_iptu_calculataxas(iMatricula, iAnousu, iCodcli, lRaise)
    into bTaxasCalculadas;

  perform fc_debug('RETORNO fc_iptu_calculataxas -> TAXASCALCULADAS: ' || bTaxasCalculadas, lRaise);

  /**
   * Monta o demonstrativo
   */
  select fc_iptu_demonstrativo(iMatricula, iAnousu, iIdbql, lRaise)
    into tDemo;

  /**
   * Gera financeiro
   *  -> Se nao for demonstrativo gera o financeiro, caso contrario retorna o demonstrativo
   */
  if lDemonstrativo is false then

    select fc_iptu_geradadosiptu(iMatricula, iIdbql, iAnousu, nIsenaliq, lDemonstrativo, lRaise)
      into bDadosIptu;

      if lGerafinanceiro then

        select fc_iptu_gerafinanceiro( iMatricula, iAnousu, iParcelaini, iParcelafim, lCalculogeral, bTempagamento, lNovonumpre, lDemonstrativo, lRaise )
          into bFinanceiro;
      end if;
  else
     return tDemo;
  end if;

  if lDemonstrativo is false then

     update iptucalc
        set j23_manual = tDemo
      where j23_matric = iMatricula
        and j23_anousu = iAnousu;
  end if;

  perform fc_debug('CALCULO CONCLUIDO COM SUCESSO',lRaise, false, true);

  select fc_iptu_geterro(1, '') into tRetorno;
  return tRetorno;

end;
$$ language 'plpgsql';create or replace function fc_calculoiptu_taquari_2015(integer,integer,boolean,boolean,boolean,boolean,boolean,integer,integer) returns varchar(100) as
$$

declare

   iMatricula 	  	    alias   for $1;
   iAnousu              alias   for $2;
   lGerafinanceiro      alias   for $3;
   lAtualizaParcela     alias   for $4;
   lNovonumpre          alias   for $5;
   lCalculogeral        alias   for $6;
   lDemonstrativo       alias   for $7;
   iParcelaini          alias   for $8;
   iParcelafim          alias   for $9;

   iIdbql               integer default 0;
   iNumcgm              integer default 0;
   iCodcli              integer default 0;
   iCodisen             integer default 0;
   iTipois              integer default 0;
   iParcelas            integer default 0;
   iNumconstr           integer default 0;
	 iZona				        integer default 0;

   dDatabaixa           date;

   nAreal               numeric default 0;
   nAreac               numeric default 0;
   nTotarea             numeric default 0;
   nFracao              numeric default 0;
   nFracaolote          numeric default 0;
   nAliquota            numeric default 0;
   nIsenaliq            numeric default 0;
   nArealo              numeric default 0;
   nVvc                 numeric(15,2) default 0;
   nVvt                 numeric(15,2) default 0;
   nVv                  numeric(15,2) default 0;
   nViptu               numeric(15,2) default 0;
   nValorMaxAnoAnterior numeric(15,2) default 0;

   tRetorno             text default '';
   tDemo                text default '';

   bFinanceiro          boolean;
   bDadosIptu           boolean;
   lErro                boolean;
	 iCodErro					    integer;
	 tErro						    text;
   bIsentaxas           boolean;
   bTempagamento        boolean;
   bEmpagamento         boolean;
   bTaxasCalculadas     boolean;
   lRaise               boolean default false;

   rCfiptu              record;

begin

  lRaise    := ( case when fc_getsession('DB_debugon') is null then false else true end );

  perform fc_debug('INICIANDO CALCULO',lRaise,true,false);

  /**
   * Executa PRE CALCULO
   */
  select r_iIdbql, r_nAreal, r_nFracao, r_iNumcgm, r_dDatabaixa, r_nFracaolote,
         r_tDemo, r_lTempagamento, r_lEmpagamento, r_iCodisen, r_iTipois, r_nIsenaliq,
         r_lIsentaxas, r_nArealote, r_iCodCli, r_tRetorno

    into iIdbql, nAreal, nFracao, iNumcgm, dDatabaixa, nFracaolote, tDemo, bTempagamento,
         bEmpagamento, iCodisen, iTipois, nIsenaliq, bIsentaxas, nArealo, iCodCli, tRetorno

    from fc_iptu_precalculo( iMatricula, iAnousu, lCalculogeral, lAtualizaParcela, lDemonstrativo, lRaise );

  perform fc_debug(' RETORNO DA PRE CALCULO: ',            lRaise);
  perform fc_debug('  iIdbql        -> ' || iIdbql,        lRaise);
  perform fc_debug('  nAreal        -> ' || nAreal,        lRaise);
  perform fc_debug('  nFracao       -> ' || nFracao,       lRaise);
  perform fc_debug('  iNumcgm       -> ' || iNumcgm,       lRaise);
  perform fc_debug('  dDatabaixa    -> ' || dDatabaixa,    lRaise);
  perform fc_debug('  nFracaolote   -> ' || nFracaolote,   lRaise);
  perform fc_debug('  tDemo         -> ' || tDemo,         lRaise);
  perform fc_debug('  lTempagamento -> ' || bTempagamento, lRaise);
  perform fc_debug('  lEmpagamento  -> ' || bEmpagamento,  lRaise);
  perform fc_debug('  iCodisen      -> ' || iCodisen,      lRaise);
  perform fc_debug('  iTipois       -> ' || iTipois,       lRaise);
  perform fc_debug('  nIsenaliq     -> ' || nIsenaliq,     lRaise);
  perform fc_debug('  lIsentaxas    -> ' || bIsentaxas,    lRaise);
  perform fc_debug('  nArealote     -> ' || nArealo,       lRaise);
  perform fc_debug('  iCodCli       -> ' || iCodCli,       lRaise);
  perform fc_debug('  tRetorno      -> ' || tRetorno,      lRaise);

  /**
   * Variavel de retorno contem a msg
   * de erro retornada do pre calculo
   */
  if trim(tRetorno) <> '' then
    return tRetorno;
  end if;

  /**
   * Guarda os parametros do calculo
   */
  select * from into rCfiptu cfiptu where j18_anousu = iAnousu;

  /**
   * Calcula valor do terreno
   */
  perform fc_debug('PARAMETROS fc_iptu_calculavvt_taquari_2015 IDBQL: '||iIdbql||' - FRACAO DO LOTE: '||nFracaolote||' DEMO: '||tRetorno||'- ERRO: '||lErro, lRaise);
  select rnvvt, rnarea, rtdemo, rtmsgerro, rberro, riCodErro, rtErro
    into nVvt, nAreac, tDemo, tRetorno, lErro, iCodErro, tErro
    from fc_iptu_calculavvt_taquari_2015( iMatricula, iIdbql, iAnousu, nFracaolote, nAreal, lDemonstrativo, lRaise );

  perform fc_debug('RETORNO fc_iptu_calculavvt_taquari_2015 -> VVT: '||nVvt||' - AREA CONSTRUIDA: '||nAreac||' - RETORNO: '||tRetorno||' - ERRO: '||lErro, lRaise);
  perform fc_debug('', lRaise);

	if lErro is true then

    select fc_iptu_geterro( iCodErro, tErro ) into tRetorno;
    return tRetorno;
	end if;

  /**
   * Calcula valor da construcao
   */
  perform fc_debug('PARAMETROS fc_iptu_calculavvc_taquari_2015 MATRICULA: '||iMatricula||' - ANOUSU:'||iAnousu||' - DEMO: '||lDemonstrativo, lRaise);

  select rnvvc, rntotarea, rinumconstr, rtdemo, rtmsgerro, rberro, riCodErro, rtErro
    into nVvc, nTotarea, iNumconstr, tDemo, tRetorno, lErro, iCodErro, tErro
    from fc_iptu_calculavvc_taquari_2015( iMatricula, iAnousu, rCfiptu.j18_vlrref::numeric, lDemonstrativo, lRaise );

  perform fc_debug('RETORNO fc_iptu_calculavvc_taquari_2015 -> VVC: '||nVvc||' - AREA TOTAL: '||nTotarea||' - NUMERO DE CONSTRUÇÕES: '||iNumconstr||' - RETORNO: '||tRetorno||' - ERRO: '||lErro, lRaise);
  perform fc_debug('', lRaise);

  if lErro is true then

    select fc_iptu_geterro(iCodErro, tErro) into tRetorno;
    return tRetorno;
  end if;

  if nVvc is null or nVvc = 0 and iNumconstr <> 0 then

    select fc_iptu_geterro(22, '') into tRetorno;
    return tRetorno;
  end if;

  /**
   * Busca a aliquota
   */
  select fc_iptu_getaliquota_taquari_2015(iMatricula, lRaise) into nAliquota;

  if nAliquota = 0 then

    select fc_iptu_geterro(13, '') into tRetorno;
    return trim(tRetorno) || ', VERIFIQUE A CARACTERISTICA DO GRUPO 3.';
  end if;

  /**
   * Calcula o Valor Venal
   */
  perform fc_debug('' || lpad('',60,'-'), lRaise);

  nVv    := nVvc + nVvt;
  perform fc_debug(' CALCULO DO VALOR VENAL: Vvc= '||nVvc||' nVvt= '||nVvt||' VALOR VENAL= '||nVv, lRaise);

  nViptu := nVv * (nAliquota / 100);
  perform fc_debug(' CALCULO DO VALOR DO IPTU: Vvi= '||nViptu||' Aliquota= '||nAliquota/100, lRaise);

  perform fc_debug('' || lpad('',60,'-'), lRaise);
  /*-------------------------------------------*/

  perform fc_debug('nViptu : ' || nViptu, lRaise);

  select count(*)
    into iParcelas
    from cadvencdesc
         inner join cadvenc on q92_codigo = q82_codigo
   where q92_codigo = rCfiptu.j18_vencim;

  if not found or iParcelas = 0 then

    select fc_iptu_geterro(14, '') into tRetorno;
    return tRetorno;
  end if;

  perform predial from tmpdadosiptu where predial is true;
  if found then
    insert into tmprecval values (rCfiptu.j18_rpredi, nViptu, 1, false);
  else
    insert into tmprecval values (rCfiptu.j18_rterri, nViptu, 1, false);
  end if;

  update tmpdadosiptu
     set viptu = nViptu, codvenc = rCfiptu.j18_vencim;

  update tmpdadostaxa
     set anousu  = iAnousu,
         matric  = iMatricula,
         idbql   = iIdbql,
         valiptu = nViptu,
         valref  = rCfiptu.j18_vlrref,
         vvt     = nVvt,
         nparc   = iParcelas;

  perform fc_debug('PARAMETROS fc_iptu_calculataxas ANOUSU: '||iAnousu||' - CODCLI: '||iCodcli, lRaise);

  /**
   * Calcula as taxas
   */
  select fc_iptu_calculataxas(iMatricula, iAnousu, iCodcli, lRaise)
    into bTaxasCalculadas;

  perform fc_debug('RETORNO fc_iptu_calculataxas -> TAXASCALCULADAS: ' || bTaxasCalculadas, lRaise);

  /**
   * Monta o demonstrativo
   */
  select fc_iptu_demonstrativo(iMatricula, iAnousu, iIdbql, lRaise)
    into tDemo;

  /**
   * Gera financeiro
   *  -> Se nao for demonstrativo gera o financeiro, caso contrario retorna o demonstrativo
   */
  if lDemonstrativo is false then

    select fc_iptu_geradadosiptu(iMatricula, iIdbql, iAnousu, nIsenaliq, lDemonstrativo, lRaise)
      into bDadosIptu;

      if lGerafinanceiro then

        select fc_iptu_gerafinanceiro( iMatricula, iAnousu, iParcelaini, iParcelafim, lCalculogeral, bTempagamento, lNovonumpre, lDemonstrativo, lRaise )
          into bFinanceiro;
      end if;
  else
     return tDemo;
  end if;

  if lDemonstrativo is false then

     update iptucalc
        set j23_manual = tDemo
      where j23_matric = iMatricula
        and j23_anousu = iAnousu;
  end if;

  perform fc_debug('CALCULO CONCLUIDO COM SUCESSO',lRaise, false, true);

  select fc_iptu_geterro(1, '') into tRetorno;
  return tRetorno;

end;
$$ language 'plpgsql';create or replace function fc_iptu_calculavvc_taquari_2015( iMatricula      integer,
                                                            iAnousu         integer,
                                                            nVlrref         numeric,
                                                            bMostrademo     boolean,
                                                            bRaise          boolean,

                                                            OUT rnVvc       numeric(15,2),
                                                            OUT rnTotarea   numeric,
                                                            OUT riNumconstr integer,
                                                            OUT rtDemo      text,
                                                            OUT rtMsgerro   text,
                                                            OUT rbErro      boolean,
                                                            OUT riCodErro   integer,
                                                            OUT rtErro      text
                                                      ) returns record as
$$
declare

    iMatricula           alias for $1;
    iAnousu              alias for $2;
	  nVlrref 	           alias for $3;
    lRaise               alias for $5;

	  nValorVenalTotal	    numeric(15,2) default 0;
	  iNumeroedificacoes   integer default 0;
    nVm2c    			       numeric(15,2) default 0;
    nValorVenal     	   numeric;
    nFatorEstConservacao numeric;
	  lEdificacao			     boolean;
    nAreaconstr			     numeric(15,2) default 0;
	  lMatriculaPredial	   boolean;

    tSqlConstr           text    default '';
	  tSqlCar		           text    default '';
    lAtualiza            boolean default true;

    rConstr              record;
    rCar			           record;
    rValorM2             record;

begin

    perform fc_debug('', lRaise);
    perform fc_debug('' || lpad('',60,'-'), lRaise);
    perform fc_debug('* INICIANDO CALCULO DO VALOR VENAL DA CONSTRUCAO', lRaise);

    rnVvc       := 0;
    rnTotarea   := 0;
    riNumconstr := 0;
    rtDemo      := '';
    rtMsgerro   := 'Retorno ok';
    rbErro      := 'f';
    riCodErro   := 0;
    rtErro      := '';

    tSqlConstr :=               ' select * ';
    tSqlConstr := tSqlConstr || '  from iptuconstr ';
	  tSqlConstr := tSqlConstr || ' where j39_matric = ' || iMatricula;
    tSqlConstr := tSqlConstr || '   and j39_dtdemo is null';

    perform fc_debug('Select buscando as contrucoes : ' || tSqlConstr, lRaise);

    for rConstr in execute tSqlConstr loop

     lEdificacao := true;
     rValorM2    := fc_iptu_get_valor_medio_carconstr_taquari_2015( iMatricula, rConstr.j39_idcons, iAnousu, lRaise );

     if rValorM2.rbErro then

        rbErro    := 't';
        riCodErro := 104;
        rtErro    := '21.';
        return;
      end if;

     nVm2c := rValorM2.rnVm2;

     perform fc_debug('MATRICULA : ' || iMatricula || ' IDCONSTR: ' || rConstr.j39_idcons ||' ANO: '|| iAnousu || 'VALOR: ' || nVm2c, lRaise);


     perform fc_debug(' VVC usando formula: ( rConstr.j39_area * nVm2c  )', lRaise);
     perform fc_debug('  -> Valores: ( '||rConstr.j39_area||' * '||nVm2c||' )', lRaise);

     nValorVenal        := ( rConstr.j39_area * nVm2c );
	   nValorVenalTotal   := nValorVenalTotal + nValorVenal;
     perform fc_debug('Valor total venal: '||coalesce(nValorVenalTotal,0),lRaise);

     nAreaconstr        := nAreaconstr + rConstr.j39_area;
     perform fc_debug('Area Construida: ' || coalesce(nAreaconstr,0),lRaise);
	   iNumeroedificacoes := iNumeroedificacoes + 1;

  	 insert into tmpiptucale (anousu, matric, idcons, areaed, vm2, pontos, valor, edificacao)
 				  values (iAnousu, iMatricula, rConstr.j39_idcons, rConstr.j39_area, nVm2c, 0, nValorVenal, lEdificacao);

  	 if lAtualiza then

  	   update tmpdadosiptu set predial = true;
  	   lAtualiza = false;
  	 end if;

      end loop;

      perform matric
     	   from tmpiptucale
  	  where edificacao is true;

  	if found then
  	  lMatriculaPredial = true;
  	else
  	  lMatriculaPredial = false;
  	end if;

  	if lMatriculaPredial is true then

  	  rnVvc       := nValorVenalTotal;
  	  rnTotarea   := nAreaconstr;
  	  riNumconstr := iNumeroedificacoes;
  	  rtDemo      := '';
  	  rbErro      := 'f';

  	  update tmpdadosiptu set vvc = rnVvc;
  	else

  	  delete from tmpiptucale;
  	  update tmpdadosiptu set predial = false;
  	end if;

      perform fc_debug('' || lpad('',60,'-'), lRaise);
      perform fc_debug('', lRaise);

    return;

end;
$$  language 'plpgsql';create or replace function fc_iptu_calculavvt_taquari_2015( integer, integer, integer, numeric, numeric, boolean, boolean,
                                                            OUT rnVvt        numeric(15,2),
                                                            OUT rnAreaTotalC numeric,
                                                            OUT rnArea       numeric,
                                                            OUT rnTestada    numeric,
                                                            OUT rtDemo       text,
                                                            OUT rtMsgerro    text,
                                                            OUT rbErro       boolean,
                                                            OUT riCoderro    integer,
                                                            OUT rtErro       text ) returns record as
$$
declare

    iMatricula       alias for $1;
    iIdbql           alias for $2;
    iAnousu          alias for $3;
    nFracao          alias for $4;
    nAreal           alias for $5;
    lDemonstrativo   alias for $6;
    lRaise           alias for $7;

    rnArealote       numeric default 0;
    nAreaLoteIsento  numeric default 0;
    nAreaRealLote    numeric default 0;
    rnAreaCorrigida  numeric default 0;
    rnVm2terreno     numeric default 0;
    nValorMinimo     numeric default 0;

begin

    rnVvt        := 0;
    rnAreaTotalC := 0;
    rnArea       := 0;
    rnTestada    := 0;
    rtDemo       := '';
    rtMsgerro    := '';
    rbErro       := 'f';
    riCoderro    := 0;
    rtErro       := '';

    perform fc_debug('' || lpad('',60,'-'), lRaise);
    perform fc_debug('* INICIANDO CALCULO DO VALOR VENAL TERRITORIAL',lRaise);

    select case when j34_areal = 0
                then j34_area
                else j34_areal end
      into rnArealote
      from lote
           inner join testpri on j49_idbql  = j34_idbql
           inner join testada on j36_idbql  = j49_idbql
                             and j36_face   = j49_face
                             and j36_codigo = j49_codigo
           inner join face    on j37_face   = j49_face
    where j34_idbql = iIdbql;

    if rnArealote is null then

      rbErro    := 't';
      riCodErro := 6;
      rtErro    := '';
      return;
    end if;

    select rnarealo
      into nAreaLoteIsento
      from fc_iptu_verificaisencoes(iMatricula, iAnousu, lDemonstrativo, lRaise);

    if nAreaLoteIsento > 0 then

      perform fc_debug(' AREA REAL DO LOTE: ' || rnArealote, lRaise);
      nAreaRealLote = rnArealote - nAreaLoteIsento;
      if nAreaRealLote < 0 then

        rbErro    := 't';
        riCodErro := 6;
        rtErro    := 'Area real do lote não pode ser menor que 0 (zero)';
        return;
      end if;

      perform fc_debug(' AREA ISENTA DO LOTE: ' || nAreaLoteIsento,lRaise);
    else

      nAreaRealLote = rnArealote;
    end if;

    rnArealote = nAreaRealLote;
    perform fc_debug('AREA REAL DO LOTE: ' || rnArealote,lRaise);

    /**
     * Busca valor do m2 por zona e setor
     */
    select coalesce(j141_valorm2, 0), coalesce(j141_valorminimo, 0)
      into rnVm2terreno, nValorMinimo
      from lote
           inner join zonassetorvalor on j141_setor = j34_setor
                                     and j141_zonas = j34_zona
     where j34_idbql   = iIdbql
       and j141_anousu = iAnousu;

    if rnVm2terreno = 0 OR rnVm2terreno is null then

      rbErro    := 't';
      riCodErro := 105;
      rtErro    := ' VERIFIQUE VALOR POR ZONA E SETOR.';
      return;
    end if;

    perform fc_debug('rnVm2terreno = ' || rnVm2terreno, lRaise);

    rnAreaCorrigida := ( rnArealote * ( nFracao / 100 ) );

    -- VVT := At x Vm2t
    rnVvt := ( rnAreaCorrigida * rnVm2terreno );

    perform fc_debug('Calculando VVT utilizando formula: VVT := At x Vm2t',                    lRaise);
    perform fc_debug(' -> Valores: VVT := '||rnAreaCorrigida||' x '||rnVm2terreno,             lRaise);
    perform fc_debug('AREA CORRIG BRUTA (RAIZ QUADRADA DA PROFUNDIDADE): ' || rnAreaCorrigida, lRaise);
    perform fc_debug('VALOR METRO QUADRADO DO TERRENO:                   ' || rnVm2terreno,    lRaise);
    perform fc_debug('VVT: '          || rnVvt,           lRaise);
    perform fc_debug('Valor Minimo: ' || nValorMinimo,    lRaise);

    /**
     * Validamos se o valor venal do terreno é inferior ao minimo
     */
    if rnVvt < nValorMinimo then

      perform fc_debug('Valor venal calculado inferior, alterando valor para: ' || nValorMinimo, lRaise);
      rnVvt = nValorMinimo;
    end if;

    update tmpdadosiptu
       set vvt   = rnVvt,
           vm2t  = rnVm2terreno,
           areat = rnAreaCorrigida;

    perform fc_debug('' || lpad('',60,'-'), lRaise);

    return;

end;
$$  language 'plpgsql';create or replace function fc_iptu_getaliquota_taquari_2015(integer, boolean) returns numeric as
$$
declare

  iMatricula              alias for $1;
  lRaise                  alias for $2;

  tSql                    text default '';
  nAliquota               numeric default 0;
  iCaracteristicaAliquota integer default 0;

begin

  perform fc_debug( 'DEFININDO ALIQUOTA A APLICAR', lRaise);
  perform fc_debug( 'Matricula: ' || iMatricula, lRaise);

  /**
   * Predial     - a aliquota de 1% - 30113
   * Territorial - a aliquota de 2% - 30114
   */
  select j35_caract
    into iCaracteristicaAliquota
    from iptubase
         inner join carlote on j35_idbql = j01_idbql
   where j01_matric = iMatricula
     and j35_caract in ( 30114, 30113 );

  nAliquota = 1;
  if iCaracteristicaAliquota = 30114 then
    nAliquota = 2;
  end if;

  if iCaracteristicaAliquota = 0 OR iCaracteristicaAliquota is null then
    nAliquota = 0;
  end if;

  perform fc_debug('Aliquota: ' || nAliquota, lRaise);

  execute 'update tmpdadosiptu set aliq = ' || coalesce( nAliquota, 0 );

  return nAliquota;

end;
$$ language 'plpgsql';create or replace function fc_iptu_get_valor_medio_carconstr_taquari_2015 ( iMatricula    integer,
                                                                            iIdContrucao  integer,
                                                                            iAnousu       integer,
                                                                            lRaise        boolean,

                                                                        OUT rbErro    boolean,
                                                                        OUT riCodErro integer,
                                                                        OUT rtErro    text,
                                                                        OUT rnVm2     numeric ) returns record as
$$
declare

  iMatricula            alias for $1;
  iIdContrucao          alias for $2;
  iAnousu               alias for $3;
  lRaise                alias for $4;

  iCaracteristicaTipo   integer default 0;
  iCaracteristicaPadrao integer default 0;

  tSql                  text    default '';

begin

  rbErro    := false;
  riCodErro := 0;
  rtErro    := '';
  rnVm2     := 0;

  select j48_caract
    into iCaracteristicaTipo
    from carconstr
         inner join caracter on j48_caract = j31_codigo
   where j31_grupo  = 20
     and j48_idcons = iIdContrucao
     and j48_matric = iMatricula;

  if iCaracteristicaTipo is null then

    rbErro    := true;
    riCodErro := 104;
    rtErro    := '20 - TIPO UNIDADE';
    return;
  end if;

  perform fc_debug('iCaracteristicaTipo: ' || iCaracteristicaTipo, lRaise);

  select j48_caract
    into iCaracteristicaPadrao
    from carconstr
         inner join caracter on j48_caract = j31_codigo
   where j31_grupo  = 21
     and j48_idcons = iIdContrucao
     and j48_matric = iMatricula;

  if iCaracteristicaPadrao is null then

    rbErro    := true;
    riCodErro := 104;
    rtErro    := '21 - PADRAO UNIDADE';
    return;
  end if;

  perform fc_debug('iCaracteristicaPadrao: ' || iCaracteristicaPadrao, lRaise);

  select j140_valor
    into rnVm2
    from agrupamentocaracteristicavalor
   where j140_sequencial in ( select grupoTipo.j139_agrupamentocaracteristicavalor
                                from agrupamentocaracteristica grupoTipo
                               where grupoTipo.j139_caracter = iCaracteristicaTipo
                                 and  exists ( select 1
                                                 from agrupamentocaracteristica grupoPadrao
                                                where grupoPadrao.j139_caracter                     = iCaracteristicaPadrao
                                                  and grupoPadrao.j139_anousu                       = iAnousu
                                                  and grupoTipo.j139_agrupamentocaracteristicavalor = grupoPadrao.j139_agrupamentocaracteristicavalor ) );

  perform fc_debug(' <iptu_get_valor_metro_quadrado> Buscando valor metro quadrado construcao:' , lRaise);
  perform fc_debug(' <iptu_get_valor_metro_quadrado> iMatricula      : ' || iMatricula         , lRaise);
  perform fc_debug(' <iptu_get_valor_metro_quadrado> iIdContrucao    : ' || iIdContrucao       , lRaise);
  perform fc_debug(' <iptu_get_valor_metro_quadrado> Anousu          : ' || iAnousu            , lRaise);
  perform fc_debug(' <iptu_get_valor_metro_quadrado> Valor Retornado : ' || rnVm2              , lRaise);
  perform fc_debug('', lRaise);

  if rnVm2 is null then

    rbErro    := true;
    riCodErro := 110;
    rtErro    := iAnousu;
    return;
  end if;

end;
$$  language 'plpgsql';create or replace function fc_juros(integer,date,date,date,bool,integer) returns float8 as
$$
declare

  rece_juros      alias for $1;
  v_data_venc     alias for $2;
  data_hoje       alias for $3;
  data_oper       alias for $4;
  imp_carne       alias for $5;
  subdir          alias for $6;

  carnes          char(10);

  dia             integer default 0;
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

  juros           numeric default 0;
  v_juroscalc     numeric;
  juros_par       numeric;
  juross          numeric;
  juros_acumulado numeric;
  jur_i           numeric;
  juros_partotal  numeric default 0;
  quant_juros     numeric default 0;
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

  juros       := 0;
  juros_par   := 0;
  quant_juros := 0;

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
    perform fc_debug('<fc_juros> C A L C U L O   D E   J U R O S   P A R C E L A D O', lRaise, false, false);
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
      perform fc_debug('<fc_juros> Receita:          '||v_tabrecregras.k04_sequencial         , lRaise, false, false);
      perform fc_debug('<fc_juros> Codigo J/M:       '||v_tabrecregras.k04_codjm           , lRaise, false, false);
      perform fc_debug('<fc_juros> Data Inicial:     '||v_tabrecregras.k04_dtini         , lRaise, false, false);
      perform fc_debug('<fc_juros> Data Final:       '||v_tabrecregras.k04_dtfim           , lRaise, false, false);
      perform fc_debug('<fc_juros> k02_jurparate:    '||v_tabrecregras.k02_jurparate    , lRaise, false, false);
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
      perform fc_debug('<fc_juros> data_certa:     '||data_certa,         lRaise, false, false);
      perform fc_debug('<fc_juros> data_venc:      '||data_venc,           lRaise, false, false);
      perform fc_debug('<fc_juros> juros_par:      '||juros_par,           lRaise, false, false);
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
          perform fc_debug('<fc_juros> ', lRaise, false, false);
          perform fc_debug('<fc_juros>    INICIO DO CALCULO DO JUROS DE FINANCIAMENTO',lRaise, false, false);
          perform fc_debug('<fc_juros> ', lRaise, false, false);
          perform fc_debug('<fc_juros>    k02_jurpar <> 0',lRaise, false, false);
          perform fc_debug('<fc_juros>    data_venc: '||data_venc||' - v_dataopernova: '||v_dataopernova||' - data_certa: '||data_certa,lRaise, false, false);
        end if;

        /*
          select que cria a quantidade de meses para o juros de financiamento conforme intervalo de data informado
          o juros deve ser calculado com base na data de operacao
        */
        select count(*)
          into quant_juros
          from generate_series(v_dataopernova, data_certa - INTERVAL '1 month', INTERVAL '1 month');

        if lRaise is true then
          perform fc_debug('<fc_juros> quantidade de meses de juros de financimanento: '||quant_juros, lRaise, false, false);
        end if;

        juros_par := (quant_juros * cast(v_tabrecregras.k02_jurpar as numeric(8,2)));
        --
        -- para juros sob financiamento nao acumulado
        --
        if lRaise is true then
          perform fc_debug('<fc_juros> quantidade de juros: '||juros_par||' percentual de juros: '||v_tabrecregras.k02_jurpar, lRaise, false, false);
        end if;

        --
        -- para juros sob financiamento acumulado
        --
        if v_tabrecregras.k02_juracu = 't' and quant_juros > 0 then

          if lRaise is true then
            perform fc_debug('<fc_juros> calculando juros de financiamento acumulado', lRaise, false, false);
          end if;

          juros_par := (1 + (v_tabrecregras.k02_jurpar / 100)) ^ quant_juros;

          if lRaise is true then
            perform fc_debug('<fc_juros> percentual de juros: '||v_tabrecregras.k02_jurpar, lRaise, false, false);
            perform fc_debug('<fc_juros> numero de periodos: '||quant_juros, lRaise, false, false);
            perform fc_debug('<fc_juros> juros acumulado: '||juros_par, lRaise, false, false);
          end if;
          juros_par := (juros_par - 1) * 100;

        end if;

        if lRaise is true then
          perform fc_debug('<fc_juros> somando juros de parcelamento...', lRaise, false, false);
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
            -- se juros por dia, cobrar proporcional a partir do dia de vencimento
            --
            if v_tabrecregras.k02_jurdia = 't' then
              --
              -- Quando o calculo de juros é diario, desconsideramos os juros calculados anteriormente
              --
              juros  := 0;

              if lRaise is true then
                perform fc_debug('<fc_juros>                             ', lRaise, false, false);
                perform fc_debug('<fc_juros> ----------------------------', lRaise, false, false);
                perform fc_debug('<fc_juros> INICIO CALCULO JUROS DIARIO.', lRaise, false, false);
                perform fc_debug('<fc_juros>          juros por dia: '||v_tabrecregras.k02_jurdia, lRaise, false, false);
                perform fc_debug('<fc_juros> ----------------------------', lRaise, false, false);
                perform fc_debug('<fc_juros>                             ', lRaise, false, false);
              end if;

              /*
                select que cria os dias conforme intervalo de data informado
              */
              select count(*)
                into dia
                from generate_series(data_venc, data_certa - INTERVAL '1 day', INTERVAL '1 day');

              if lRaise is true then
                perform fc_debug('<fc_juros> quantidade de dias de atraso: '||dia, lRaise, false, false);
              end if;

              juross := ( cast(v_tabrecregras.k02_juros as numeric) / 30) * dia;
              juros  := juros + juross;

              if lRaise is true then
                perform fc_debug('<fc_juros> calculo do percentual diario: (v_tabrecregras.k02_juros: '||v_tabrecregras.k02_juros||' / 30) * '||dia, lRaise, false, false);
                perform fc_debug('<fc_juros> juross: '||juross||' / v_tabrecregras.k02_juros: '||v_tabrecregras.k02_juros||' / juros: '||juros, lRaise, false, false);
              end if;

              if lRaise is true then
                perform fc_debug('<fc_juros>                             ', lRaise, false, false);
                perform fc_debug('<fc_juros> -------------------------', lRaise, false, false);
                perform fc_debug('<fc_juros> FIM CALCULO JUROS DIARIO.', lRaise, false, false);
                perform fc_debug('<fc_juros> -------------------------', lRaise, false, false);
                perform fc_debug('<fc_juros>                             ', lRaise, false, false);
              end if;

            end if;

            if lRaise is true then
              perform fc_debug('<fc_juros>       juros: '||juros, lRaise, false, false);
            end if;

            v_juroscalc := cast(v_tabrecregras.k02_juros as numeric(8,2));
            if lRaise is true then
              perform fc_debug('<fc_juros>       5 - v_juroscalc: '||v_juroscalc, lRaise, false, false);
              perform fc_debug('<fc_juros>       6 - juros: '||juros, lRaise, false, false);
            end if;

            if juros is not null and juros <> 0 and v_tabrecregras.k02_jurdia <> 't' then

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

  jurosretornar = (jurostotal::float8 + juros_partotal::float8) / 100::float8;

  if lRaise is true  then
    perform fc_debug('<fc_juros> jurosretornar: '||jurosretornar                                    ,lRaise,false,false);
    perform fc_debug('<fc_juros> '                                                                  ,lRaise,false,false);
    perform fc_debug('<fc_juros> '                                                                  ,lRaise,false,false);
    perform fc_debug('<fc_juros> ------------------------------------------------------------------',lRaise,false,true);
  end if;

  return jurosretornar;

end;
$$ language 'plpgsql';drop function fc_recibo(integer,date,date,integer);
drop   type tp_recibo;

create type tp_recibo as ( rvMensagem varchar(100),
                           rlErro     boolean );

create or replace function fc_recibo(integer,date,date,integer) returns tp_recibo  as
$$
DECLARE
  NUMPRE                ALIAS FOR $1;
  DTEMITE               ALIAS FOR $2;
  DTVENC                ALIAS FOR $3;
  ANOUSU                ALIAS FOR $4;

  iFormaCorrecao        integer default 2;
  iInstit               integer;
  iExerc                integer;

  USASISAGUA            BOOLEAN;

  UNICA                 BOOLEAN := FALSE;
  NUMERO_ERRO           char(200);
  NUMCGM                INTEGER;
  RECORD_NUMPRE         RECORD;
  RECORD_ALIAS          RECORD;
  RECORD_GRAVA          RECORD;
  RECORD_NUMPREF        RECORD;
  RECORD_UNICA          RECORD;

  VALOR_RECEITA         FLOAT8;
  VALOR_RECEITA_ORI     FLOAT8;
  DESC_VALOR_RECEITA    FLOAT8 DEFAULT 0;

  VALOR_RECEITAORI      FLOAT8;

  CORRECAO              FLOAT8 DEFAULT 0;
  DESC_CORRECAO         FLOAT8 DEFAULT 0;
  CORRECAOORI           FLOAT8;
  JURO                  FLOAT8 DEFAULT 0;
  MULTA                 FLOAT8 DEFAULT 0;
  vlrjuroparc           FLOAT8 DEFAULT 0;
  vlrmultapar           FLOAT8 DEFAULT 0;
  DESCONTO              FLOAT8;
  nDescontoCorrigido    FLOAT8 default 0;

  RECEITA               INTEGER;
  K03_RECMUL            INTEGER;
  K03_RECJUR            INTEGER;
  V_K00_HIST            INTEGER;
  QUAL_OPER             INTEGER;

  DTOPER                DATE;
  DATAVENC              DATE;
  SQLRECIBO             VARCHAR(400);

  VLRJUROS              FLOAT8 default 0;
  VLRMULTA              FLOAT8 default 0;
  VLRDESCONTO           FLOAT8 default 0;

  V_CADTIPOPARC         INTEGER;
  V_CADTIPOPARC_FORMA   INTEGER;
  NUMPAR                INTEGER;
  NUMTOT                INTEGER;
  NUMDIG                INTEGER;
  ARRETIPO              INTEGER;
  PROCESSA              BOOLEAN DEFAULT FALSE;
  ISSQNVARIAVEL         BOOLEAN;
  CODBCO                INTEGER;
  CODAGE                CHAR(5);
  NUMBCO                VARCHAR(15);
  RECEITA_JUR           INTEGER;
  RECEITA_MUL           INTEGER;
  iTipoVlr              INTEGER;

  PERCDESCJUR           FLOAT8 DEFAULT 0;
  PERCDESCMUL           FLOAT8 DEFAULT 0;
  PERCDESCVLR           FLOAT8 DEFAULT 0;

  nPercArreDesconto     FLOAT8 DEFAULT 0;

  v_composicao          record;

  nComposCorrecao       numeric(15,2) default 0;
  nComposJuros          numeric(15,2) default 0;
  nComposMulta          numeric(15,2) default 0;

  nCorreComposJuros     numeric(15,2) default 0;
  nCorreComposMulta     numeric(15,2) default 0;

  rtp_recibo            tp_recibo%ROWTYPE;

  TOTPERC               FLOAT8;
  TEM_DESCONTO          INTEGER DEFAULT 0;

  lRaise                boolean default false;
  lParcelamento         boolean default false;

BEGIN

  lRaise := ( case when fc_getsession('DB_debugon') is null then false else true end );
  if lRaise is true then
    if fc_getsession('db_debug') <> '' then
      perform fc_debug('<recibo> Inicio do processamento do recibo...', lRaise, false, false);
    else
      perform fc_debug('<recibo> Inicio do processamento do recibo...', lRaise, true, false);
    end if;
  end if;

  select cast( fc_getsession('DB_instit') as integer )
    into iInstit;

  select cast( fc_getsession('DB_anousu') as integer )
    into iExerc;

  select db21_usasisagua
    into USASISAGUA
    from db_config
   where codigo = iInstit;

  if lRaise is true then
    perform fc_debug('<recibo> Numpre ...............:'||NUMPRE,  lRaise, false, false);
    perform fc_debug('<recibo> Data de Emissao ......:'||DTEMITE, lRaise, false, false);
    perform fc_debug('<recibo> Data de Vencimento ...:'||DTVENC,  lRaise, false, false);
    perform fc_debug('<recibo> AnoUsu ...............:'||ANOUSU,  lRaise, false, false);
  end if;

  select k03_separajurmulparc
    into iFormaCorrecao
    from numpref
   where k03_instit = iInstit
     and k03_anousu = iExerc;

  FOR RECORD_NUMPREF IN SELECT *
                          FROM NUMPREF
                         WHERE K03_ANOUSU = ANOUSU
  LOOP
    RECEITA_JUR := RECORD_NUMPREF.K03_RECJUR;
    RECEITA_MUL := RECORD_NUMPREF.K03_RECMUL;
  END LOOP;

  if lRaise is true then
    perform fc_debug('<recibo>'                                 ,lRaise, false, false);
    perform fc_debug('<recibo> Receita para Juro:'||RECEITA_JUR ,lRaise, false, false);
    perform fc_debug('<recibo> Receita para Multa:'||RECEITA_MUL,lRaise, false, false);
    perform fc_debug('<recibo>'                                 ,lRaise, false, false);
  end if;

 perform k00_numpre
    from recibo
   where k00_numnov = numpre LIMIT 1;
  if found then

    rtp_recibo.rvMensagem    := '4 - Erro ao gerar recibo. Contate suporte!';
    rtp_recibo.rlErro        := true;

    if lRaise is true then
      perform fc_debug('<recibo> Encontrados registros do numpre na tabela recibo'           , lRaise, false, false);
      perform fc_debug('<recibo> '                                                           , lRaise, false, false);
      perform fc_debug('<recibo> 5 - Fim do processamento - Retorno: '||rtp_recibo.rvMensagem, lRaise, false, false);
      perform fc_debug('<recibo> '                                                           , lRaise, false, true);
    end if;

    return  rtp_recibo;

  end if;

 perform 1
    from db_reciboweb
   where k99_numpre_n = numpre limit 1;
  if not found then

     rtp_recibo.rvMensagem    := '2 - Erro ao gerar recibo. Contate suporte!';
     rtp_recibo.rlErro        := true;

     if lRaise is true then
       perform fc_debug('<recibo> Não encontrados registros do numpre na tabela db_reciboweb' , lRaise, false, false);
       perform fc_debug('<recibo> '                                                           , lRaise, false, false);
       perform fc_debug('<recibo> 2 - Fim do processamento - Retorno: '||rtp_recibo.rvMensagem, lRaise, false, false);
       perform fc_debug('<recibo> '                                                           , lRaise, false, true);
     end if;

     return  rtp_recibo;

  end if;

  if lRaise is true then
    perform fc_debug('<recibo> Encontrados registros do numpre '||NUMPRE||' na tabela db_reciboweb, processando...',lRaise, false, false);
  end if;
  FOR RECORD_NUMPRE IN SELECT *
                         FROM DB_RECIBOWEB
                        WHERE K99_NUMPRE_N = NUMPRE
  LOOP

    CODBCO = RECORD_NUMPRE.K99_CODBCO;
    CODAGE = RECORD_NUMPRE.K99_CODAGE;
--    NUMBCO = RECORD_NUMPRE.K99_NUMBCO;

    if lRaise is true then
      perform fc_debug('<recibo> '                                                           , lRaise, false, false);
      perform fc_debug('<recibo> -- Processando funcao fc_numbcoconvenio...'                 , lRaise, false, false);
    end if;
    select fc_numbcoconvenio(NUMBCO::integer) into NUMBCO;
    if lRaise is true then
      perform fc_debug('<recibo> Numbco : '||NUMBCO,lRaise, false, false);
      perform fc_debug('<recibo> -- Fim do processamento da funcao fc_numbcoconvenio...'     , lRaise, false, false);
      perform fc_debug('<recibo> '                                                           , lRaise, false, false);
    end if;

    TEM_DESCONTO = RECORD_NUMPRE.K99_DESCONTO;
    if lRaise is true then
      perform fc_debug('<recibo> TEM_DESCONTO: '||TEM_DESCONTO, lRaise, false, false);
    end if;

    if lRaise is true then
        perform fc_debug('<recibo> '                                                                  , lRaise, false, false);
        perform fc_debug('<recibo> '||lpad('',100,'-')                                                , lRaise, false, false);
        perform fc_debug('<recibo> 1 Buscando dados na tabela arrecad pelo Numpre '||RECORD_NUMPRE.K99_NUMPRE||' Parcela '||RECORD_NUMPRE.K99_NUMPAR||'...', lRaise, false, false);
    end if;

    FOR RECORD_UNICA IN SELECT DISTINCT
                               K00_NUMPRE,
                               K00_NUMPAR
                          FROM ARRECAD
                         WHERE K00_NUMPRE = RECORD_NUMPRE.K99_NUMPRE
                           AND CASE
                                 WHEN RECORD_NUMPRE.K99_NUMPAR = 0 THEN
                                   TRUE
                                 ELSE
                                   K00_NUMPAR = RECORD_NUMPRE.K99_NUMPAR
                               END
    LOOP

      if lRaise is true then
        perform fc_debug('<recibo> Encontrou dados, Processa = true'                                  , lRaise, false, false);
        perform fc_debug('<recibo> Nnumpre: '||RECORD_NUMPRE.K99_NUMPRE||' - Numpar: '||RECORD_NUMPRE.K99_NUMPAR||' - processa: '||PROCESSA,lRaise, false, false);
      end if;
      PROCESSA := TRUE;

      IF RECORD_NUMPRE.K99_NUMPAR = 0 THEN
        UNICA := TRUE;

      ELSE
        IF RECORD_NUMPRE.K99_NUMPAR != RECORD_UNICA.K00_NUMPAR THEN
          if lRaise is true then
            perform fc_debug('<recibo> Parcela ('||RECORD_NUMPRE.K99_NUMPAR||') da tabela db_reciboweb diferente da parcela ('||RECORD_UNICA.K00_NUMPAR||') do arrecad', lRaise, false, false);
          end if;
          PROCESSA := FALSE;
        END IF;

      END IF;

      NUMPAR := RECORD_UNICA.K00_NUMPAR;

      IF PROCESSA = TRUE THEN

        if lRaise is true then
          perform fc_debug('<recibo> 2 Buscando dados na tabela arrecad pelo Numpre '||RECORD_NUMPRE.K99_NUMPRE||' Parcela '||NUMPAR||'...', lRaise, false, false);
        end if;

        FOR RECORD_ALIAS IN
            SELECT K00_RECEIT,
                   K00_DTOPER,
                   K00_NUMCGM,
                   fc_calculavenci(k00_numpre,k00_numpar,K00_DTVENC,DTEMITE) AS K00_DTVENC,
                   K00_NUMPRE,
                   K00_NUMPAR,
                   min(K00_hist) as K00_hist,
                   (select sum(k00_valor)
                      from arrecad as a
                     where a.k00_numpre = arrecad.k00_numpre
                       and a.k00_numpar = arrecad.k00_numpar
                       and a.k00_receit = arrecad.k00_receit
                       and a.k00_tipo   = arrecad.k00_tipo ) as k00_valor,
                   K00_TIPO
              FROM ARRECAD
             WHERE K00_NUMPRE = RECORD_NUMPRE.K99_NUMPRE
               AND K00_NUMPAR = NUMPAR
             group by K00_RECEIT,
                      K00_DTOPER,
                      K00_NUMCGM,
                      fc_calculavenci(k00_numpre,k00_numpar,K00_DTVENC,DTEMITE),
                      K00_NUMPRE,
                      K00_NUMPAR,
                      K00_TIPO
             ORDER BY K00_NUMPRE,K00_NUMPAR,K00_RECEIT
        LOOP

          if lRaise is true then

            perform fc_debug('<recibo> '                                                                  , lRaise, false, false);
            perform fc_debug('<recibo> Processando registros do Numpre '||RECORD_ALIAS.K00_NUMPRE||'...'  , lRaise, false, false);
            perform fc_debug('<recibo> Parcela .............:'||RECORD_ALIAS.K00_NUMPAR                   , lRaise, false, false);
            perform fc_debug('<recibo> Receita .............:'||RECORD_ALIAS.K00_RECEIT                   , lRaise, false, false);
            perform fc_debug('<recibo> Tipo ................:'||RECORD_ALIAS.K00_TIPO                     , lRaise, false, false);
            perform fc_debug('<recibo> Data de Operacao ....:'||RECORD_ALIAS.K00_DTOPER                   , lRaise, false, false);
            perform fc_debug('<recibo> Data de Vencimento ..:'||RECORD_ALIAS.K00_DTVENC                   , lRaise, false, false);
            perform fc_debug('<recibo> Valor da Receita ....:'||RECORD_ALIAS.K00_RECEIT                   , lRaise, false, false);
            perform fc_debug('<recibo> '                                                                  , lRaise, false, false);
            perform fc_debug('<recibo> Processa = true...'                                                , lRaise, false, false);

          end if;
          PROCESSA := TRUE;
          RECEITA  := RECORD_ALIAS.K00_RECEIT;
          ARRETIPO := RECORD_ALIAS.K00_TIPO;
          DTOPER   := RECORD_ALIAS.K00_DTOPER;
          NUMCGM   := RECORD_ALIAS.K00_NUMCGM;
          DATAVENC := RECORD_ALIAS.K00_DTVENC;
          VALOR_RECEITA := RECORD_ALIAS.K00_VALOR;

          IF VALOR_RECEITA = 0 THEN
            SELECT Q05_VLRINF
              INTO VALOR_RECEITA
              FROM ISSVAR
             WHERE Q05_NUMPRE = RECORD_ALIAS.K00_NUMPRE
               AND Q05_NUMPAR = RECORD_ALIAS.K00_NUMPAR;
            IF VALOR_RECEITA IS NULL THEN
              VALOR_RECEITA := 0;
            ELSE
              ISSQNVARIAVEL := TRUE;
            END IF;
          END IF;

          QUAL_OPER := 0;
          -- T24879: Se valor da receita nao for 0 (zero) ou
          -- recibo for proveniente de uma emissao geral de iss variavel
          -- continua geracao da recibopaga
          IF ( VALOR_RECEITA <> 0 OR RECORD_NUMPRE.K99_TIPO = 6 ) THEN

            FOR RECORD_GRAVA IN SELECT *
                                  FROM ARRECAD
                                 WHERE K00_NUMPRE = RECORD_NUMPRE.K99_NUMPRE
                                   AND K00_NUMPAR = NUMPAR
                                   AND K00_RECEIT = RECEITA
            LOOP

              IF QUAL_OPER = 0 THEN
                V_K00_HIST := RECORD_GRAVA.K00_HIST;
                NUMTOT := RECORD_GRAVA.K00_NUMTOT;
                NUMDIG  := RECORD_GRAVA.K00_NUMDIG;
                QUAL_OPER := 1;
              END IF;

            END LOOP;

            -- CALCULA CORRECAO
            IF VALOR_RECEITA <> 0 THEN

              if iFormaCorrecao = 1 then

                VALOR_RECEITA_ORI = VALOR_RECEITA;


                if lRaise is true then
                  perform fc_debug('<recibo> Forma de correcao .......: '||iFormaCorrecao, lRaise, false, false);
                  perform fc_debug('<recibo> VALOR_RECEITA_ORI .......: '||VALOR_RECEITA_ORI, lRaise, false, false);
                  perform fc_debug('<recibo> VALOR_RECEITA ...: '||VALOR_RECEITA, lRaise, false, false);
                  perform fc_debug('<recibo> fc_retornacomposicao('||record_alias.k00_numpre||','||record_alias.k00_numpar||','||record_alias.k00_receit||','||record_alias.k00_hist||','||dtoper||','||dtvenc||','||anousu||','||datavenc||')', lRaise, false, false);
                end if;

                select coalesce(rnCorreComposJuros,0),
                       coalesce(rnCorreComposMulta,0),
                       coalesce(rnComposCorrecao,0),
                       coalesce(rnComposJuros,0),
                       coalesce(rnComposMulta,0)
                  into nCorreComposJuros,
                       nCorreComposMulta,
                       nComposCorrecao,
                       nComposJuros,
                       nComposMulta
                  from fc_retornacomposicao(record_alias.k00_numpre, record_alias.k00_numpar, record_alias.k00_receit, record_alias.k00_hist, dtoper, dtvenc, anousu, datavenc);

                if lRaise is true then
                  perform fc_debug('<recibo> 1=nComposCorrecao: '||nComposCorrecao||' - VALOR_RECEITA: '||VALOR_RECEITA,lRaise, false,false);
                end if;

                VALOR_RECEITA = VALOR_RECEITA + nComposCorrecao;
                if lRaise is true then
                  perform fc_debug('<recibo> 2=nComposCorrecao: '||nComposCorrecao||' - VALOR_RECEITA: '||VALOR_RECEITA||' - VALOR_RECEITA: '||VALOR_RECEITA,lRaise, false,false);
                  perform fc_debug('<recibo> 1 Chamando a funcao fc_corre...',lRaise, false,false);
                end if;

                CORRECAO := ROUND( FC_CORRE(RECEITA,DTOPER,VALOR_RECEITA,DTVENC,ANOUSU,DATAVENC) , 2 );

                if lRaise is true then
                  perform fc_debug('<recibo> CORRECAO 1: '||CORRECAO,lRaise, false,false);
                end if;

                CORRECAO := ROUND( CORRECAO - VALOR_RECEITA + nComposCorrecao, 2 );

                if lRaise is true then
                  perform fc_debug('<recibo> CORRECAO 2: '||CORRECAO||' - nCorreComposJuros: '||nCorreComposJuros||' - nCorreComposMulta: '||nCorreComposMulta,lRaise, false,false);
                end if;

                CORRECAO := CORRECAO + nCorreComposJuros + nCorreComposMulta;

                if lRaise is true then
                  perform fc_debug('<recibo> VALOR_RECEITA: '||VALOR_RECEITA||' VALOR_RECEITA: '||VALOR_RECEITA||' - CORRECAO 3: '||CORRECAO,lRaise, false,false);
                end if;

                VALOR_RECEITA = VALOR_RECEITA_ORI;

              else

                if lRaise is true then
                  perform fc_debug('<recibo> 2 Chamando a funcao fc_corre...',lRaise, false,false);
                end if;

                CORRECAO := ROUND( FC_CORRE(RECEITA,DTOPER,VALOR_RECEITA,DTVENC,ANOUSU,DATAVENC) - round(VALOR_RECEITA,2) , 2 );

                if lRaise is true then
                  perform fc_debug('<recibo> Forma de correcao ..............: '||coalesce(iFormaCorrecao,0), lRaise, false, false);
                  perform fc_debug('<recibo> Receita ........................: '||RECEITA, lRaise, false, false);
                  perform fc_debug('<recibo> DtOper .........................: '||DTOPER, lRaise, false, false);
                  perform fc_debug('<recibo> Valor da receita para calculo ..: '||VALOR_RECEITA, lRaise, false, false);
                  perform fc_debug('<recibo> DtVencto .......................: '||DTVENC, lRaise, false, false);
                  perform fc_debug('<recibo> Ano ............................: '||ANOUSU, lRaise, false, false);
                  perform fc_debug('<recibo> Data para Vencimento ...........: '||DATAVENC, lRaise, false, false);
                  perform fc_debug('<recibo> Correcao .......................: '||CORRECAO, lRaise, false, false);
                end if;

              end if;

            ELSE
              CORRECAO := 0;
            END IF;

            --raise notice 'TEM_DESCONTO: %', TEM_DESCONTO;

            IF TEM_DESCONTO > 0 THEN

              select descjur,
                     descmul,
                     descvlr,
                     k40_codigo,
                     k40_forma,
                     tipovlr
                into percdescjur,
                     percdescmul,
                     percdescvlr,
                     v_cadtipoparc,
                     v_cadtipoparc_forma,
                     iTipoVlr
                from cadtipoparc
                     inner join tipoparc on tipoparc.cadtipoparc = cadtipoparc.k40_codigo
               where DTEMITE between dtini and dtfim
                 and maxparc = 1
                 and k40_codigo = TEM_DESCONTO;

              if lRaise is true then
                perform fc_debug('<recibo> '                                              ,lRaise, false,false);
                perform fc_debug('<recibo> Desconto em Regra...'                          ,lRaise, false,false);
                perform fc_debug('<recibo> DTVENC ................:'||DTVENC              ,lRaise, false,false);
                perform fc_debug('<recibo> percdescjur ...........:'||percdescjur         ,lRaise, false,false);
                perform fc_debug('<recibo> percdescmul ...........:'||percdescmul         ,lRaise, false,false);
                perform fc_debug('<recibo> percdescvlr ...........:'||percdescvlr         ,lRaise, false,false);
                perform fc_debug('<recibo> v_cadtipoparc .........:'||v_cadtipoparc       ,lRaise, false,false);
                perform fc_debug('<recibo> v_cadtipoparc_forma ...:'||v_cadtipoparc_forma ,lRaise, false,false);
                perform fc_debug('<recibo> iTipoVlr ..............:'||iTipoVlr            ,lRaise, false,false);
              end if;

            END IF;

            if lRaise is true then
              perform fc_debug('<recibo> CORRECAO '||receita||'-'||dtoper||'-'||VALOR_RECEITA||'-'||VALOR_RECEITA||'-'||datavenc||'-'||dtvenc,lRaise, false,false);
            end if;

            CORRECAOORI      := CORRECAO;
            VALOR_RECEITAORI := VALOR_RECEITA;
--
--
--  Trabalhar neste if para utilizar a mesma logica da recibodesconto
--   alterar o programa de emissao de recibo para selecionar
--   a regra se o contribuinte for ou nao loteador
--

            perform v07_numpre
               from termo
              where v07_numpre = RECORD_NUMPRE.K99_NUMPRE;
            if found then
              lParcelamento := true;
            end if;

              if percdescvlr is not null and percdescvlr > 0 then

                if iTipoVlr = 1 then

                  DESC_CORRECAO := ROUND(CORRECAO * percdescvlr / 100,2);
                  if lRaise is true then
                    perform fc_debug('<recibo> desconto na correcao 2: '||CORRECAO||' (-'||DESC_CORRECAO||') - VALOR_RECEITA: '||VALOR_RECEITA||' - VALOR_RECEITA: '||VALOR_RECEITA||' - PERCENTUAL: '||percdescvlr,lRaise, false,false);
                  end if;
                  if DESC_CORRECAO > 0 then
                    --

                  if lRaise is true then

                    perform fc_debug('<recibo> ', lRaise, false, false);
                    perform fc_debug('<recibo> 01 - inserindo na recibopaga... ', lRaise, false, false);
                    perform fc_debug('<recibo> 01 - Numpre .....: '||RECORD_NUMPRE.K99_NUMPRE, lRaise, false, false);
                    perform fc_debug('<recibo> 01 - Numpar .....: '||NUMPAR, lRaise, false, false);
                    perform fc_debug('<recibo> 01 - Receita ....: '||RECEITA, lRaise, false, false);
                    perform fc_debug('<recibo> 01 - Historico ..:  918', lRaise, false, false);
                    perform fc_debug('<recibo> 01 - Valor ......: '||(DESC_CORRECAO*-1), lRaise, false, false);
                    perform fc_debug('<recibo> ', lRaise, false, false);

                  end if;

                    INSERT INTO RECIBOPAGA (k00_numcgm,
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
                                    VALUES (NUMCGM,
                                            DTEMITE,
                                            RECEITA,
                                            918,
                                            (DESC_CORRECAO*-1),
                                            DATAVENC,
                                            RECORD_NUMPRE.K99_NUMPRE,
                                            NUMPAR,NUMTOT,
                                            NUMDIG,
                                            0,
                                            DTVENC,
                                            NUMPRE);
                  end if;
                elsif iTipoVlr = 2 then
                  nDescontoCorrigido := ROUND((VALOR_RECEITA + CORRECAO) * percdescvlr / 100,2);
                  if lRaise is true then
                    perform fc_debug('<recibo> desconto na correcao 2: '||CORRECAO||' (-'||DESC_CORRECAO||') - VALOR_RECEITA: '||VALOR_RECEITA||' - VALOR_RECEITA: '||VALOR_RECEITA||' - PERCENTUAL: '||percdescvlr,lRaise, false,false);
                  end if;
                  if nDescontoCorrigido > 0 then
                    --
                  if lRaise is true then

                    perform fc_debug('<recibo> ', lRaise, false, false);
                    perform fc_debug('<recibo> 02 - inserindo na recibopaga... ', lRaise, false, false);
                    perform fc_debug('<recibo> 02 - Numpre .....: '||RECORD_NUMPRE.K99_NUMPRE, lRaise, false, false);
                    perform fc_debug('<recibo> 02 - Numpar .....: '||NUMPAR, lRaise, false, false);
                    perform fc_debug('<recibo> 02 - Receita ....: '||RECEITA, lRaise, false, false);
                    perform fc_debug('<recibo> 02 - Historico ..:  918', lRaise, false, false);
                    perform fc_debug('<recibo> 02 - Valor ......: '||(nDescontoCorrigido*-1), lRaise, false, false);
                    perform fc_debug('<recibo> ', lRaise, false, false);

                  end if;

                    INSERT INTO RECIBOPAGA (k00_numcgm,
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
                                    VALUES (NUMCGM,
                                            DTEMITE,
                                            RECEITA,
                                            918,
                                            (nDescontoCorrigido*-1),
                                            DATAVENC,
                                            RECORD_NUMPRE.K99_NUMPRE,
                                            NUMPAR,
                                            NUMTOT,
                                            NUMDIG,
                                            0,
                                            DTVENC,
                                            NUMPRE);
                  end if;
                end if;

                -- Se a forma de aplicacao da regra for pra loteamentos (= 3)
                -- entao aplica desconto no valor da receita (historico)
                if v_cadtipoparc_forma = 3 then
                  DESC_VALOR_RECEITA := ROUND(VALOR_RECEITA * percdescvlr / 100,2);
                  if DESC_VALOR_RECEITA > 0 then
                    if lRaise is true then
                      perform fc_debug('<recibo> desconto (3) - DESC_VALOR_RECEITA: '||DESC_VALOR_RECEITA,lRaise, false,false);
                    end if;
                    --
                  if lRaise is true then

                    perform fc_debug('<recibo> ', lRaise, false, false);
                    perform fc_debug('<recibo> 03 - inserindo na recibopaga... ', lRaise, false, false);
                    perform fc_debug('<recibo> 03 - Numpre .....: '||RECORD_NUMPRE.K99_NUMPRE, lRaise, false, false);
                    perform fc_debug('<recibo> 03 - Numpar .....: '||NUMPAR, lRaise, false, false);
                    perform fc_debug('<recibo> 03 - Receita ....: '||RECEITA, lRaise, false, false);
                    perform fc_debug('<recibo> 03 - Historico ..:  918', lRaise, false, false);
                    perform fc_debug('<recibo> 03 - Valor ......: '||(DESC_VALOR_RECEITA*-1), lRaise, false, false);
                    perform fc_debug('<recibo> ', lRaise, false, false);

                  end if;

                    INSERT INTO RECIBOPAGA (k00_numcgm,
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
                                            k00_numnov)
                                    VALUES (NUMCGM,
                                            DTEMITE,
                                            RECEITA,
                                            918,
                                            (DESC_VALOR_RECEITA*-1),
                                            DATAVENC,
                                            RECORD_NUMPRE.K99_NUMPRE,
                                            NUMPAR,
                                            NUMTOT,
                                            NUMDIG,
                                            0,
                                            DTVENC,
                                            NUMPRE);
                  end if;
                end if;

                if lRaise is true then
                  perform fc_debug('<recibo> desconto na correcao 2: '||CORRECAO||' - VALOR_RECEITA: '||VALOR_RECEITA||' - VALOR_RECEITA: '||VALOR_RECEITA,lRaise, false,false);
              end if;

            end if;

/**
 * final na manutencao
 *
 */
            if lRaise is true then
              perform fc_debug('<recibo> '                                                                     , lRaise, false, false);
              perform fc_debug('<recibo> - juro ....................: '||JURO||' - descjur: '||percdescjur     , lRaise, false, false);
              perform fc_debug('<recibo> - multa ...................: '||MULTA||' - descmul: '||percdescmul    , lRaise, false, false);
              perform fc_debug('<recibo> - correcao ................: '||CORRECAO||' - descvlr: '||percdescvlr , lRaise, false, false);
              perform fc_debug('<recibo> - VALOR_RECEITA ...........: '||VALOR_RECEITA                         , lRaise, false, false);
              perform fc_debug('<recibo> - VALOR_RECEITA ...: '||VALOR_RECEITA                 , lRaise, false, false);
              perform fc_debug('<recibo> - cadtipoparc: '||coalesce(v_cadtipoparc::varchar, 'NULL')            , lRaise, false, false);
              perform fc_debug('<recibo> '                                                                     , lRaise, false, false);
            end if;

            -- T24879: Se valor diferente de zero ou tipo recibo for da emissao geral do iss
            -- gera recibopaga normalmente
            IF (VALOR_RECEITA + CORRECAO) <> 0 OR RECORD_NUMPRE.K99_TIPO = 6 THEN

              if lRaise is true then

                perform fc_debug('<recibo> ', lRaise, false, false);
                perform fc_debug('<recibo> 04 - inserindo na recibopaga... ', lRaise, false, false);
                perform fc_debug('<recibo> 04 - Numpre .....: '||RECORD_NUMPRE.K99_NUMPRE, lRaise, false, false);
                perform fc_debug('<recibo> 04 - Numpar .....: '||NUMPAR, lRaise, false, false);
                perform fc_debug('<recibo> 04 - Receita ....: '||RECEITA, lRaise, false, false);
                perform fc_debug('<recibo> 04 - Historico ..: '||V_K00_HIST + 100, lRaise, false, false);
                perform fc_debug('<recibo> 04 - Valor ......: '||ROUND(VALOR_RECEITA+CORRECAO,2), lRaise, false, false);
                perform fc_debug('<recibo> ', lRaise, false, false);

              end if;

              INSERT INTO RECIBOPAGA ( k00_numcgm,
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
                                       k00_dtpaga,
                                       k00_numnov )
                              VALUES ( NUMCGM,
                                       DTEMITE,
                                       RECEITA,
                                       V_K00_HIST + 100,
                                       ROUND(VALOR_RECEITA+CORRECAO,2),
                                       DATAVENC,
                                       RECORD_NUMPRE.K99_NUMPRE,
                                       NUMPAR,
                                       NUMTOT,
                                       NUMDIG,
                                       0,
                                       DTVENC,
                                       NUMPRE );

-- CALCULA DESCONTO DA ARREDESCONTO
             if lParcelamento then

                -- Verifica desconto
                nPercArreDesconto := fc_recibodesconto(RECORD_NUMPRE.K99_NUMPRE,
                                                       NUMPAR,
                                                       NUMTOT,
                                                       RECEITA,
                                                       ARRETIPO,
                                                       DTEMITE,
                                                       DATAVENC);
                if nPercArreDesconto > 0 then

                  if lRaise is true then
                    perform fc_debug('<recibo> desconto (4) - nPercArreDesconto: '||nPercArreDesconto,lRaise, false,false);
                  end if;

                  if lRaise is true then

                    perform fc_debug('<recibo> ', lRaise, false, false);
                    perform fc_debug('<recibo> 05 - inserindo na recibopaga... ', lRaise, false, false);
                    perform fc_debug('<recibo> 05 - Numpre .....: '||RECORD_NUMPRE.K99_NUMPRE, lRaise, false, false);
                    perform fc_debug('<recibo> 05 - Numpar .....: '||NUMPAR, lRaise, false, false);
                    perform fc_debug('<recibo> 05 - Receita ....: '||RECEITA, lRaise, false, false);
                    perform fc_debug('<recibo> 05 - Historico ..: 918', lRaise, false, false);
                    perform fc_debug('<recibo> 05 - Valor ......: '||ROUND(((ROUND(VALOR_RECEITA+CORRECAO,2) * nPercArreDesconto)/100),2) * -1, lRaise, false, false);
                    perform fc_debug('<recibo> ', lRaise, false, false);

                  end if;

                  INSERT INTO RECIBOPAGA ( k00_numcgm,
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
                                           k00_dtpaga,
                                           k00_numnov )
                                  VALUES ( NUMCGM,
                                           DTEMITE,
                                           RECEITA,
                                           918,
                                           ROUND(((ROUND(VALOR_RECEITA+CORRECAO,2) * nPercArreDesconto)/100),2) * -1,
                                           DATAVENC,
                                           RECORD_NUMPRE.K99_NUMPRE,
                                           NUMPAR,
                                           NUMTOT,
                                           NUMDIG,
                                           0,
                                           DTVENC,
                                           NUMPRE );

                end if;
              end if;

            END IF;

            IF (VALOR_RECEITAORI + CORRECAOORI) <> 0 THEN

            -- CALCULA JUROS
              if lRaise is true then
                perform fc_debug('<recibo> VALOR_RECEITAORI: '||VALOR_RECEITAORI,lRaise, false,false);
              end if;

              if iFormaCorrecao = 1 then
                JURO  := ROUND(( VALOR_RECEITAORI + CORRECAO ) * FC_JUROS(RECEITA,DATAVENC,DTEMITE,DTOPER,FALSE,ANOUSU),2 );
              else
                JURO  := ROUND(( CORRECAOORI+VALOR_RECEITAORI) * FC_JUROS(RECEITA,DATAVENC,DTEMITE,DTOPER,FALSE,ANOUSU),2 );
              end if;

              if lRaise is true then
                perform fc_debug('<recibo> JURO: '||JURO||' - nComposJuros: '||nComposJuros||' - valor para calcular juros: 1: '||CORRECAOORI||' - 2: '||VALOR_RECEITAORI,lRaise, false,false);
              end if;

              JURO = JURO + nComposJuros;



             -- CALCULA MULTA
              if iFormaCorrecao = 1 then
                MULTA := round( (VALOR_RECEITAORI + CORRECAO )::numeric(15,2) * FC_MULTA(RECEITA,DATAVENC,DTEMITE,DTOPER,ANOUSU)::numeric(15,5) ,2);
              else
                MULTA := ROUND(( CORRECAOORI+VALOR_RECEITAORI)::numeric(15,2) * FC_MULTA(RECEITA,DATAVENC,DTEMITE,DTOPER,ANOUSU)::numeric(15,5),2 );
              end if;

              if lRaise is true then
                perform fc_debug('<recibo> MULTA: '||MULTA||' - nComposMulta: '||nComposMulta||' - valor para calcular juros: 1: '||CORRECAOORI||' - 2: '||VALOR_RECEITAORI, lRaise, false,false);
                perform fc_debug('<recibo> CORRECAO: '||CORRECAO, lRaise, false, false);
              end if;

              MULTA = MULTA + nComposMulta;

              SELECT K02_RECMUL,
                     K02_RECJUR
                INTO K03_RECMUL,
                     K03_RECJUR
                FROM TABREC
               WHERE K02_CODIGO = RECEITA;

              IF K03_RECMUL IS NULL THEN
                K03_RECMUL := RECEITA_MUL;
              END IF;

              IF K03_RECJUR IS NULL THEN
                K03_RECJUR := RECEITA_JUR;
              END IF;
-- INCLUIDO VARIAVEL DESCONTO NO DB_RECIBOWEB


              if percdescjur is not null and percdescmul is not null and (nPercArreDesconto is null or nPercArreDesconto <= 0) then
                vlrjuroparc := (ROUND(cast(JURO as FLOAT8) * percdescjur / 100,2));

                if lRaise is true then
                  perform fc_debug('<recibo> desconto (5) - vlrjuroparc: '||vlrjuroparc, lRaise, false, false);
                end if;

                if vlrjuroparc > 0 then

                  if lRaise is true then

                    perform fc_debug('<recibo> ', lRaise, false, false);
                    perform fc_debug('<recibo> 06 - inserindo na recibopaga... ', lRaise, false, false);
                    perform fc_debug('<recibo> 06 - Numpre .....: '||RECORD_NUMPRE.K99_NUMPRE, lRaise, false, false);
                    perform fc_debug('<recibo> 06 - Numpar .....: '||NUMPAR, lRaise, false, false);
                    perform fc_debug('<recibo> 06 - Receita ....: '||K03_RECJUR, lRaise, false, false);
                    perform fc_debug('<recibo> 06 - Historico ..: 918', lRaise, false, false);
                    perform fc_debug('<recibo> 06 - Valor ......: '||(vlrjuroparc * -1), lRaise, false, false);
                    perform fc_debug('<recibo> ', lRaise, false, false);

                  end if;


                  INSERT INTO RECIBOPAGA ( k00_numcgm,
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
                                           k00_dtpaga,
                                           k00_numnov)
                                  VALUES ( NUMCGM,
                                           DTEMITE,
                                           K03_RECJUR,
                                           918,
                                           (vlrjuroparc * -1),
                                           DATAVENC,
                                           RECORD_NUMPRE.K99_NUMPRE,
                                           NUMPAR,
                                           NUMTOT,
                                           NUMDIG,
                                           0,
                                           DTVENC,
                                           NUMPRE);
                end if;
                vlrmultapar := (ROUND(cast(MULTA as FLOAT8) * percdescmul / 100,2));
                if vlrmultapar > 0  then
                  if lRaise is true then
                    perform fc_debug('<recibo> desconto (6) - vlrmultapar: '||vlrmultapar, lRaise, false, false);
                  end if;

                  if lRaise is true then

                    perform fc_debug('<recibo> ', lRaise, false, false);
                    perform fc_debug('<recibo> 07 - inserindo na recibopaga... ', lRaise, false, false);
                    perform fc_debug('<recibo> 07 - Numpre .....: '||RECORD_NUMPRE.K99_NUMPRE, lRaise, false, false);
                    perform fc_debug('<recibo> 07 - Numpar .....: '||NUMPAR, lRaise, false, false);
                    perform fc_debug('<recibo> 07 - Receita ....: '||K03_RECMUL, lRaise, false, false);
                    perform fc_debug('<recibo> 07 - Historico ..: 918', lRaise, false, false);
                    perform fc_debug('<recibo> 07 - Valor ......: '||(vlrmultapar * -1), lRaise, false, false);
                    perform fc_debug('<recibo> ', lRaise, false, false);

                  end if;

                  INSERT INTO RECIBOPAGA ( k00_numcgm,
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
                                           k00_dtpaga,
                                           k00_numnov )
                                  VALUES ( NUMCGM,
                                           DTEMITE,
                                           K03_RECMUL,
                                           918,
                                           (vlrmultapar * -1),
                                           DATAVENC,
                                           RECORD_NUMPRE.K99_NUMPRE,
                                           NUMPAR,
                                           NUMTOT,
                                           NUMDIG,
                                           0,
                                           DTVENC,
                                           NUMPRE );
                 end if;
              end if;

              if lRaise is true then
                perform fc_debug('<recibo>    2 - juro: '||JURO||' - descjur: '||percdescjur||' - multa: '||MULTA||' - descmul: '||percdescmul||' - correcao: '||CORRECAO||' - VALOR_RECEITA: '||VALOR_RECEITA, lRaise, false, false);
              end if;

              IF K03_RECJUR = 0 OR K03_RECMUL = 0 OR K03_RECJUR = K03_RECMUL THEN

                IF JURO+MULTA <> 0 THEN

                  VLRJUROS := VLRJUROS + JURO;
                  VLRMULTA := VLRMULTA + MULTA;
                  if lRaise is true then
                    perform fc_debug('<recibo>  valor total juros + multa (7) - '||(JURO+MULTA), lRaise, false, false);
                  end if;

                  if lRaise is true then

                    perform fc_debug('<recibo> ', lRaise, false, false);
                    perform fc_debug('<recibo> 08 - inserindo na recibopaga... ', lRaise, false, false);
                    perform fc_debug('<recibo> 08 - Numpre .....: '||RECORD_NUMPRE.K99_NUMPRE, lRaise, false, false);
                    perform fc_debug('<recibo> 08 - Numpar .....: '||NUMPAR, lRaise, false, false);
                    perform fc_debug('<recibo> 08 - Receita ....: '||K03_RECJUR, lRaise, false, false);
                    perform fc_debug('<recibo> 08 - Historico ..: 400', lRaise, false, false);
                    perform fc_debug('<recibo> 08 - Valor ......: '||ROUND(JURO+MULTA,2), lRaise, false, false);
                    perform fc_debug('<recibo> ', lRaise, false, false);

                  end if;

                  INSERT INTO RECIBOPAGA ( k00_numcgm,
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
                                           k00_dtpaga,
                                           k00_numnov )
                                  VALUES ( NUMCGM,
                                           DTEMITE,
                                           K03_RECJUR,
                                           400,
                                           ROUND(JURO+MULTA,2),
                                           DATAVENC,
                                           RECORD_NUMPRE.K99_NUMPRE,
                                           NUMPAR,
                                           NUMTOT,
                                           NUMDIG,
                                           0,
                                           DTVENC,
                                           NUMPRE );
                END IF;

              ELSE

                IF JURO <> 0 THEN

                  VLRJUROS := VLRJUROS + JURO;

                  if lRaise is true then

                    perform fc_debug('<recibo> ', lRaise, false, false);
                    perform fc_debug('<recibo> 09 - inserindo na recibopaga... ', lRaise, false, false);
                    perform fc_debug('<recibo> 09 - Numpre .....: '||RECORD_NUMPRE.K99_NUMPRE, lRaise, false, false);
                    perform fc_debug('<recibo> 09 - Numpar .....: '||NUMPAR, lRaise, false, false);
                    perform fc_debug('<recibo> 09 - Receita ....: '||K03_RECJUR, lRaise, false, false);
                    perform fc_debug('<recibo> 09 - Historico ..: 400', lRaise, false, false);
                    perform fc_debug('<recibo> 09 - Valor ......: '||ROUND(JURO,2), lRaise, false, false);
                    perform fc_debug('<recibo> ', lRaise, false, false);

                  end if;

                  INSERT INTO RECIBOPAGA ( k00_numcgm,
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
                                           k00_dtpaga,
                                           k00_numnov )
                                  VALUES ( NUMCGM,
                                           DTEMITE,
                                           K03_RECJUR,
                                           400,
                                           ROUND(JURO,2),
                                           DATAVENC,
                                           RECORD_NUMPRE.K99_NUMPRE,
                                           NUMPAR,
                                           NUMTOT,
                                           NUMDIG,
                                           0,
                                           DTVENC,
                                           NUMPRE );

                END IF;

                IF MULTA <> 0 THEN

                  VLRMULTA := VLRMULTA + MULTA;

                  if lRaise is true then

                    perform fc_debug('<recibo> ', lRaise, false, false);
                    perform fc_debug('<recibo> 10 - inserindo na recibopaga... ', lRaise, false, false);
                    perform fc_debug('<recibo> 10 - Numpre .....: '||RECORD_NUMPRE.K99_NUMPRE, lRaise, false, false);
                    perform fc_debug('<recibo> 10 - Numpar .....: '||NUMPAR, lRaise, false, false);
                    perform fc_debug('<recibo> 10 - Receita ....: '||K03_RECMUL, lRaise, false, false);
                    perform fc_debug('<recibo> 10 - Historico ..: 401', lRaise, false, false);
                    perform fc_debug('<recibo> 10 - Valor ......: '||ROUND(MULTA,2), lRaise, false, false);
                    perform fc_debug('<recibo> ', lRaise, false, false);

                  end if;


                  INSERT INTO RECIBOPAGA ( k00_numcgm,
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
                                           k00_dtpaga,
                                           k00_numnov )
                                  VALUES ( NUMCGM,
                                           DTEMITE,
                                           K03_RECMUL,
                                           401,
                                           ROUND(MULTA,2),
                                           DATAVENC,
                                           RECORD_NUMPRE.K99_NUMPRE,
                                           NUMPAR,
                                           NUMTOT,
                                           NUMDIG,
                                           0,
                                           DTVENC,
                                           NUMPRE );

                END IF;

              END IF;

              --CALCULAR DESCONTO
              IF CORRECAOORI+VALOR_RECEITAORI <> 0 THEN

                DESCONTO := FC_DESCONTO(RECEITA,
                                        DTEMITE,
                                        CORRECAOORI+VALOR_RECEITAORI,
                                        JURO+MULTA,
                                        UNICA,
                                        DATAVENC,
                                        ANOUSU,
                                        RECORD_NUMPRE.K99_NUMPRE);
                IF DESCONTO <> 0 THEN
                  VLRDESCONTO := VLRDESCONTO + DESCONTO;

                  if lRaise is true then

                    perform fc_debug('<recibo> desconto (8) - '||DESCONTO, lRaise, false, false);

                    perform fc_debug('<recibo> ', lRaise, false, false);
                    perform fc_debug('<recibo> 11 - inserindo na recibopaga... ', lRaise, false, false);
                    perform fc_debug('<recibo> 11 - Numpre .....: '||RECORD_NUMPRE.K99_NUMPRE, lRaise, false, false);
                    perform fc_debug('<recibo> 11 - Numpar .....: '||NUMPAR, lRaise, false, false);
                    perform fc_debug('<recibo> 11 - Receita ....: '||RECEITA, lRaise, false, false);
                    perform fc_debug('<recibo> 11 - Historico ..: 918', lRaise, false, false);
                    perform fc_debug('<recibo> 11 - Valor ......: '||ROUND(DESCONTO*-1,2), lRaise, false, false);
                    perform fc_debug('<recibo> ', lRaise, false, false);

                  end if;

                  INSERT INTO RECIBOPAGA ( k00_numcgm,
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
                                           k00_dtpaga,
                                           k00_numnov )
                                  VALUES ( NUMCGM,
                                           DTEMITE,
                                           RECEITA,
                                           918,
                                           ROUND(DESCONTO*-1,2),
                                           DATAVENC,
                                           RECORD_NUMPRE.K99_NUMPRE,
                                           NUMPAR,
                                           NUMTOT,
                                           NUMDIG,
                                           0,
                                           DTVENC,
                                           NUMPRE );
                END IF;

              END IF;

            END IF;

          ELSE

            IF USASISAGUA = FALSE AND RECEITA <> 401002 THEN

              rtp_recibo.rvMensagem    := '1 - Erro ao gerar recibo. Contate suporte!';
              rtp_recibo.rlErro        := true;

              if lRaise is true then
                perform fc_debug('<recibo> '                                                           , lRaise, false, false);
                perform fc_debug('<recibo> 1 - Fim do processamento - Retorno: '||rtp_recibo.rvMensagem, lRaise, false, false);
                perform fc_debug('<recibo> '                                                           , lRaise, false, true);
              end if;
              RETURN rtp_recibo;

            END IF;

          END IF;

        END LOOP;

      END IF;

    END LOOP;

  END LOOP;

  IF PROCESSA = TRUE THEN

    if cast(NUMBCO as integer) <> 0 then

      INSERT INTO ARREBANCO (k00_numpre,
                             k00_numpar,
                             k00_codbco,
                             k00_codage,
                             k00_numbco)
                     VALUES (NUMPRE    ,
                             0,
                             CODBCO    ,
                             CODAGE    ,
                             NUMBCO    );
    end if;

    -- @todo - verificar esta validacao
    perform k00_receit,
            round(sum(k00_valor),2)
       from recibopaga
      where k00_numnov = NUMPRE
      group by k00_receit
     having round(sum(k00_valor),2) < 0;

    if found then
      rtp_recibo.rlErro     := true;
      rtp_recibo.rvMensagem := 'Recibo com registros negativos por receita. Contate suporte!';
    else
      rtp_recibo.rlErro     := false;
      rtp_recibo.rvMensagem := '';
    end if;

    if lRaise is true then
        perform fc_debug('<recibo> '                                                           , lRaise, false, false);
        perform fc_debug('<recibo> 3 - Fim do processamento - Retorno: '||rtp_recibo.rvMensagem, lRaise, false, false);
        perform fc_debug('<recibo> '                                                           , lRaise, false, true);
    end if;

    RETURN rtp_recibo;

  ELSE

      rtp_recibo.rvMensagem    := '3 - Erro ao gerar recibo. Contate suporte!';
      rtp_recibo.rlErro        := true;

      if lRaise is true then
        perform fc_debug('<recibo> Não encontrados registros na tabela arrecad'                , lRaise, false, false);
        perform fc_debug('<recibo> '                                                           , lRaise, false, false);
        perform fc_debug('<recibo> 4 - Fim do processamento - Retorno: '||rtp_recibo.rvMensagem, lRaise, false, false);
        perform fc_debug('<recibo> '                                                           , lRaise, false, true);
      end if;

      RETURN  rtp_recibo;

  END IF;

END;
$$ language 'plpgsql';insert into db_versaoant (db31_codver,db31_data) values (352, current_date);
select setval ('db_versaousu_db32_codusu_seq',(select max (db32_codusu) from db_versaousu));
select setval ('db_versaousutarefa_db28_sequencial_seq',(select max (db28_sequencial) from db_versaousutarefa));
select setval ('db_versaocpd_db33_codcpd_seq',(select max (db33_codcpd) from db_versaocpd));
select setval ('db_versaocpdarq_db34_codarq_seq',(select max (db34_codarq) from db_versaocpdarq));create table bkp_db_permissao_20150320_161633 as select * from db_permissao;
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