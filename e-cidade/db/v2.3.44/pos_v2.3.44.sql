insert into db_versao (db30_codver, db30_codversao, db30_codrelease, db30_data, db30_obs)  values (360, 3, 44, '2015-11-23', 'Tarefas: 98909, 98940, 98943, 98945, 98948, 98951, 98952, 98953, 98955, 98956, 98957, 98958, 98959, 98960, 98961, 98963, 98965, 98966, 98967, 98969, 98971, 98972, 98973, 98974, 98976, 98978, 98979, 98981, 98983, 98984, 98985, 98987, 98989, 98990, 98991, 98993, 98994, 98995, 98996, 98997, 98998, 99000, 99001, 99002, 99003, 99005, 99006, 99007, 99008, 99009, 99010, 99013, 99014, 99016, 99017, 99018, 99019, 99020, 99021, 99022, 99023, 99024, 99025, 99026, 99027, 99028, 99029, 99030, 99031, 99035, 99037, 99038, 99039, 99042, 99043, 99044, 99045, 99047, 99049, 99050, 99052, 99053, 99054, 99055, 99056, 99057, 99058, 99059, 99060, 99062, 99064, 99065, 99066, 99070, 99071, 99072, 99074, 99076, 99077, 99078, 99079, 99081, 99082, 99085, 99086, 99088, 99089, 99090, 99091, 99092, 99093, 99094, 99095, 99096, 99097, 99098, 99100, 99101, 99102, 99103, 99104, 99105, 99106, 99107, 99108, 99109, 99110, 99117, 99118, 99120, 99123');create or replace function fc_dias_no_mes_folha(iAno integer, iMes integer, lDiasNoMes bool) returns integer as
$$
  declare iDias  integer;
  begin

    if lDiasNoMes is true then
      return ndias(iAno, iMes);
    end if;
    return 30;
  end;

$$
language 'plpgsql';-- Função que calcula e retorna a quantidade total de cotas para uma especialidade, em uma UPS prestadora
-- para uma determinada competência. Este total é calculado de acordo com o número de fichas para a
-- especialidade para cada dia da competência. Para isso, é realizada consulta na tabela undmedhorario,
-- onde eu tenho o total de fichas, o dia da semana e o período de validade do horário. Faço ligação
-- com a tabela especmedico, de onde eu obtenho a especialidade. Faço ligação com a tabela unidademedicos,
-- de onde obtenho a unidade.
-- Esta função faz verificação de ausências e de paralisações que influenciam no número de fichas do horário.
CREATE OR REPLACE FUNCTION fc_totalCotasPrestEspecComp(iUps int4, sEspec varchar(6), iMes int4, iAno int4) 
RETURNS INT4 AS $$
DECLARE
  dIniComp DATE := (iAno::varchar(4) || '-' || iMes::varchar(2) || '-01')::date;
  dFimComp DATE := (dIniComp + '1 month'::interval) - '1 day'::interval;
  dTmp     DATE := dIniComp;
  iTmp int4;
  dIniCompTmp DATE;
  dFimCompTmp DATE;
  pCursor CURSOR FOR
            SELECT sd30_d_valinicial, sd30_d_valfinal, sd30_i_diasemana,
                   (sd30_i_fichas + sd30_i_reservas) as totalfichas, sd30_c_horaini::time, sd30_c_horafim::time,
                   sd27_i_codigo, sd04_i_unidade
              FROM undmedhorario
                INNER JOIN especmedico ON especmedico.sd27_i_codigo = undmedhorario.sd30_i_undmed
                INNER JOIN unidademedicos ON unidademedicos.sd04_i_codigo = especmedico.sd27_i_undmed
                INNER JOIN rhcbo ON rhcbo.rh70_sequencial = especmedico.sd27_i_rhcbo
                  WHERE unidademedicos.sd04_i_unidade = iUps
                     AND rhcbo.rh70_estrutural LIKE sEspec
                     AND especmedico.sd27_c_situacao = 'A'
                     AND ((undmedhorario.sd30_d_valinicial IS NULL AND undmedhorario.sd30_d_valfinal IS NULL)
                           OR (undmedhorario.sd30_d_valinicial IS NULL
                               AND undmedhorario.sd30_d_valfinal IS NOT NULL
                               AND undmedhorario.sd30_d_valfinal >= dIniComp)
                           OR (undmedhorario.sd30_d_valfinal IS NULL
                               AND undmedhorario.sd30_d_valinicial IS NOT NULL
                               AND undmedhorario.sd30_d_valinicial <= dFimComp)
                           OR ((undmedhorario.sd30_d_valinicial IS NOT NULL AND undmedhorario.sd30_d_valfinal IS NOT NULL)
                               AND (dIniComp BETWEEN undmedhorario.sd30_d_valinicial AND undmedhorario.sd30_d_valfinal
                                    OR dFimComp BETWEEN undmedhorario.sd30_d_valinicial AND undmedhorario.sd30_d_valfinal
                                    OR  undmedhorario.sd30_d_valinicial BETWEEN dIniComp AND dFimComp
                                    OR  undmedhorario.sd30_d_valfinal BETWEEN dIniComp AND dFimComp)));
  rsDados RECORD;
  iNumCotas int4 := 0;
  pCursorAus REFCURSOR;
  rsAus RECORD;
  tIntervalo time;
  fIntervalo float;
  tTempoAtend time;
  fTempoAtend float;
  iDias int4;
  iFichasDescontar int4;
BEGIN

  OPEN pCursor;
  FETCH pCursor INTO rsDados;

  <<loop_horarios>>
  WHILE FOUND LOOP

    IF rsDados.sd30_d_valinicial IS NULL THEN
      dIniCompTmp := dIniComp;
    ELSE
      IF rsDados.sd30_d_valinicial < dIniComp THEN
        dIniCompTmp := dIniComp;
      ELSE
        dIniCompTmp := rsDados.sd30_d_valinicial;
      END IF;
    END IF;

    IF rsDados.sd30_d_valfinal IS NULL THEN
      dFimCompTmp := dFimComp;
    ELSE
      IF rsDados.sd30_d_valfinal > dFimComp THEN
        dFimCompTmp := dFimComp;
      ELSE
        dFimCompTmp := rsDados.sd30_d_valfinal;
      END IF;
    END IF;

    iFichasDescontar := 0;
    iDias            := 0;
    iTmp             := 0;
    dTmp             := dIniCompTmp;

    -- Calculo quantas vezes o dia da semana ocorreu no intervalo
    <<loop_num_dia_semana>>
    WHILE dTmp BETWEEN dIniCompTmp AND dFimCompTmp LOOP

      -- RAISE NOTICE 'Dia: %  Dia da semana: %', dTmp, EXTRACT(DOW FROM dTmp);
      IF (EXTRACT(DOW FROM dTmp) + 1) = rsDados.sd30_i_diasemana THEN

        iDias := iDias + 1;

        OPEN pCursorAus FOR
          SELECT * FROM
            ((SELECT CASE
                       WHEN TRIM(a.sd06_c_horainicio) = ''
                         THEN NULL
                       ELSE a.sd06_c_horainicio::time
                     END AS sd06_c_horainicio,
                     CASE
                       WHEN TRIM(a.sd06_c_horafim) = ''
                         THEN NULL
                       ELSE a.sd06_c_horafim::time
                     END AS sd06_c_horafim
                FROM ausencias AS a
                  WHERE a.sd06_i_especmed = rsDados.sd27_i_codigo
                    AND dTmp BETWEEN a.sd06_d_inicio AND a.sd06_d_fim
                    AND ((a.sd06_c_horainicio IS NULL AND a.sd06_c_horafim IS NULL)
                         OR (TRIM(a.sd06_c_horainicio) = '' AND TRIM(a.sd06_c_horafim) = '')
                         OR rsDados.sd30_c_horaini BETWEEN a.sd06_c_horainicio::time AND a.sd06_c_horafim::time
                         OR rsDados.sd30_c_horafim BETWEEN a.sd06_c_horainicio::time AND a.sd06_c_horafim::time
                         OR (rsDados.sd30_c_horaini < a.sd06_c_horainicio::time
                             AND rsDados.sd30_c_horafim > a.sd06_c_horafim::time)))
                UNION
             (SELECT CASE
                       WHEN TRIM(a.s140_c_horaini) = ''
                         THEN NULL
                       ELSE a.s140_c_horaini::time
                     END AS sd06_c_horainicio,
                     CASE
                       WHEN TRIM(a.s140_c_horafim) = ''
                         THEN NULL
                       ELSE a.s140_c_horafim::time
                     END AS sd06_c_horafim
                FROM sau_upsparalisada AS a
                  WHERE a.s140_i_unidade = rsDados.sd04_i_unidade
                    AND dTmp BETWEEN a.s140_d_inicio AND a.s140_d_fim
                    AND ((a.s140_c_horaini IS NULL AND a.s140_c_horafim::time IS NULL)
                         OR (TRIM(a.s140_c_horaini) = '' AND TRIM(a.s140_c_horafim) = '')
                         OR rsDados.sd30_c_horaini BETWEEN a.s140_c_horaini::time AND a.s140_c_horafim::time
                         OR rsDados.sd30_c_horafim BETWEEN a.s140_c_horaini::time AND a.s140_c_horafim::time
                         OR (rsDados.sd30_c_horaini < a.s140_c_horaini::time
                             AND rsDados.sd30_c_horafim > a.s140_c_horafim::time)))) as u
             ORDER BY sd06_c_horainicio IS NULL DESC, sd06_c_horafim IS NULL DESC;
        FETCH pCursorAus INTO rsAus;

        fIntervalo := 0.0; -- Intervalo de ausência / paralisação

        <<loop_aus>> -- loop que processa todas as ausencias / paralisações
        WHILE FOUND LOOP

          IF rsAus.sd06_c_horainicio IS NULL AND rsAus.sd06_c_horafim IS NOT NULL THEN
            rsAus.sd06_c_horainicio := '00:00'::time;
          ELSIF rsAus.sd06_c_horainicio IS NOT NULL AND rsAus.sd06_c_horafim IS NULL THEN
            rsAus.sd06_c_horafim := '23:59'::time;
          END IF;

          -- Se a ausência engloba todo o horário das fichas, então é como se o dia não tivesse fichas
          -- Obs: as comparações de intersecção não estão todas aqui pq se na ausência for informado um
          -- horário (de início ou de fim) e outro estiver null, eu coloco valores padrões pra eles (00:00 ou 23:59)
          IF ((rsAus.sd06_c_horainicio::time IS NULL AND rsAus.sd06_c_horafim::time IS NULL)
              OR (rsDados.sd30_c_horaini >= rsAus.sd06_c_horainicio
                  AND rsDados.sd30_c_horafim <= rsAus.sd06_c_horafim)) THEN

            iDias      := iDias - 1;
            fIntervalo := 0.0; -- Seto para não entrar no if que logo após sair do while
            EXIT loop_aus;

          -- Período de ausência se dá do início do horário até rsAus.sd06_c_horafim
          ELSIF rsDados.sd30_c_horaini >= rsAus.sd06_c_horainicio THEN

            tIntervalo := rsAus.sd06_c_horafim - rsDados.sd30_c_horaini;

          -- Período de ausência se dá de rsAus.sd06_c_horainicio até o final do horário
          ELSIF rsDados.sd30_c_horafim <= rsAus.sd06_c_horafim THEN

            tIntervalo := rsDados.sd30_c_horafim - rsAus.sd06_c_horainicio;

          ELSE -- O período de ausência está entre o início e o fim do horário, então todo seu intervalo é contado

            tIntervalo := rsAus.sd06_c_horafim - rsAus.sd06_c_horainicio;

          END IF;

          fIntervalo := fIntervalo + EXTRACT(HOURS FROM tIntervalo)::float + (EXTRACT(MINUTES FROM tIntervalo)::float / 60.0);
          FETCH pCursorAus INTO rsAus;

        END LOOP; -- Fim do loop que processa as ausências / paralisações

        IF fIntervalo > 0.0 THEN -- Tem ausência / paralisação

          tTempoAtend := rsDados.sd30_c_horafim - rsDados.sd30_c_horaini;
          fTempoAtend := EXTRACT(HOURS FROM tTempoAtend)::float + (EXTRACT(MINUTES FROM tTempoAtend)::float / 60.0);
          IF fTempoAtend <= 0.0 THEN
            fTempoAtend := 1.0;
          END IF;

          iTmp := ceil((fIntervalo * rsDados.totalfichas) / fTempoAtend); -- Regra de três simples
          IF iTmp > rsDados.totalfichas THEN
            iDias := iDias - 1;
          ELSE
            iFichasDescontar := iFichasDescontar + iTmp;
          END IF;

        END IF;

        CLOSE pCursorAus;

        dTmp := dTmp + '7 days'::interval; -- Somo 7 dias, pois estou verificando para um dia da semana específico

      ELSE -- Somo 1 dia pq ainda não encontrei o primeiro dia da semana que fecha com o que estou procurando
        dTmp := dTmp + '1 day'::interval;
      END IF;

    END LOOP; -- Fim loop que calcula o numero de dias da semana

    iNumCotas := iNumCotas + ((iDias * rsDados.totalfichas) - iFichasDescontar);

    FETCH pCursor INTO rsDados;

  END LOOP;

  CLOSE pCursor;

  RETURN iNumCotas;

END
$$ LANGUAGE 'plpgsql';-- Função que calcula e retorna a quantidade total de cotas para uma especialidade, em uma UPS prestadora
-- para uma determinada competência. Este total é calculado de acordo com o número de fichas para a
-- especialidade para cada dia da competência. Para isso, é realizada consulta na tabela undmedhorario,
-- onde eu tenho o total de fichas, o dia da semana e o período de validade do horário. Faço ligação
-- com a tabela especmedico, de onde eu obtenho a especialidade. Faço ligação com a tabela unidademedicos,
-- de onde obtenho a unidade.
-- Esta função faz verificação de ausências e de paralisações que influenciam no número de fichas do horário.
CREATE OR REPLACE FUNCTION fc_totalCotasPrestEspecMedComp(iUps int4, sEspec varchar(6), iMed int4, iMes int4, iAno int4)
RETURNS INT4 AS $$
DECLARE
  dIniComp DATE := (iAno::varchar(4) || '-' || iMes::varchar(2) || '-01')::date;
  dFimComp DATE := (dIniComp + '1 month'::interval) - '1 day'::interval;
  dTmp     DATE := dIniComp;
  iTmp int4;
  dIniCompTmp DATE;
  dFimCompTmp DATE;
  pCursor CURSOR FOR
            SELECT sd30_d_valinicial, sd30_d_valfinal, sd30_i_diasemana,
                   (sd30_i_fichas + sd30_i_reservas) as totalfichas, sd30_c_horaini::time, sd30_c_horafim::time,
                   sd27_i_codigo, sd04_i_unidade
              FROM undmedhorario
                INNER JOIN especmedico ON especmedico.sd27_i_codigo = undmedhorario.sd30_i_undmed
                INNER JOIN unidademedicos ON unidademedicos.sd04_i_codigo = especmedico.sd27_i_undmed
                INNER JOIN rhcbo ON rhcbo.rh70_sequencial = especmedico.sd27_i_rhcbo
                  WHERE unidademedicos.sd04_i_unidade = iUps
                     AND rhcbo.rh70_estrutural LIKE sEspec
                     AND especmedico.sd27_i_codigo = iMed
                     AND especmedico.sd27_c_situacao = 'A'
                     AND ((undmedhorario.sd30_d_valinicial IS NULL AND undmedhorario.sd30_d_valfinal IS NULL)
                           OR (undmedhorario.sd30_d_valinicial IS NULL
                               AND undmedhorario.sd30_d_valfinal IS NOT NULL
                               AND undmedhorario.sd30_d_valfinal >= dIniComp)
                           OR (undmedhorario.sd30_d_valfinal IS NULL
                               AND undmedhorario.sd30_d_valinicial IS NOT NULL
                               AND undmedhorario.sd30_d_valinicial <= dFimComp)
                           OR ((undmedhorario.sd30_d_valinicial IS NOT NULL AND undmedhorario.sd30_d_valfinal IS NOT NULL)
                               AND (dIniComp BETWEEN undmedhorario.sd30_d_valinicial AND undmedhorario.sd30_d_valfinal
                                    OR dFimComp BETWEEN undmedhorario.sd30_d_valinicial AND undmedhorario.sd30_d_valfinal
                                    OR  undmedhorario.sd30_d_valinicial BETWEEN dIniComp AND dFimComp
                                    OR  undmedhorario.sd30_d_valfinal BETWEEN dIniComp AND dFimComp)));
  rsDados RECORD;
  iNumCotas int4 := 0;
  pCursorAus REFCURSOR;
  rsAus RECORD;
  tIntervalo time;
  fIntervalo float;
  tTempoAtend time;
  fTempoAtend float;
  iDias int4;
  iFichasDescontar int4;
BEGIN

  OPEN pCursor;
  FETCH pCursor INTO rsDados;

  <<loop_horarios>>
  WHILE FOUND LOOP

    IF rsDados.sd30_d_valinicial IS NULL THEN
      dIniCompTmp := dIniComp;
    ELSE
      IF rsDados.sd30_d_valinicial < dIniComp THEN
        dIniCompTmp := dIniComp;
      ELSE
        dIniCompTmp := rsDados.sd30_d_valinicial;
      END IF;
    END IF;

    IF rsDados.sd30_d_valfinal IS NULL THEN
      dFimCompTmp := dFimComp;
    ELSE
      IF rsDados.sd30_d_valfinal > dFimComp THEN
        dFimCompTmp := dFimComp;
      ELSE
        dFimCompTmp := rsDados.sd30_d_valfinal;
      END IF;
    END IF;

    iFichasDescontar := 0;
    iDias            := 0;
    iTmp             := 0;
    dTmp             := dIniCompTmp;

    -- Calculo quantas vezes o dia da semana ocorreu no intervalo
    <<loop_num_dia_semana>>
    WHILE dTmp BETWEEN dIniCompTmp AND dFimCompTmp LOOP

      -- RAISE NOTICE 'Dia: %  Dia da semana: %', dTmp, EXTRACT(DOW FROM dTmp);
      IF (EXTRACT(DOW FROM dTmp) + 1) = rsDados.sd30_i_diasemana THEN

        iDias := iDias + 1;

        OPEN pCursorAus FOR
          SELECT * FROM
            ((SELECT CASE
                       WHEN TRIM(a.sd06_c_horainicio) = ''
                         THEN NULL
                       ELSE a.sd06_c_horainicio::time
                     END AS sd06_c_horainicio,
                     CASE
                       WHEN TRIM(a.sd06_c_horafim) = ''
                         THEN NULL
                       ELSE a.sd06_c_horafim::time
                     END AS sd06_c_horafim
                FROM ausencias AS a
                  WHERE a.sd06_i_especmed = rsDados.sd27_i_codigo
                    AND dTmp BETWEEN a.sd06_d_inicio AND a.sd06_d_fim
                    AND ((a.sd06_c_horainicio IS NULL AND a.sd06_c_horafim IS NULL)
                         OR (TRIM(a.sd06_c_horainicio) = '' AND TRIM(a.sd06_c_horafim) = '')
                         OR rsDados.sd30_c_horaini BETWEEN a.sd06_c_horainicio::time AND a.sd06_c_horafim::time
                         OR rsDados.sd30_c_horafim BETWEEN a.sd06_c_horainicio::time AND a.sd06_c_horafim::time
                         OR (rsDados.sd30_c_horaini < a.sd06_c_horainicio::time
                             AND rsDados.sd30_c_horafim > a.sd06_c_horafim::time)))
                UNION
             (SELECT CASE
                       WHEN TRIM(a.s140_c_horaini) = ''
                         THEN NULL
                       ELSE a.s140_c_horaini::time
                     END AS sd06_c_horainicio,
                     CASE
                       WHEN TRIM(a.s140_c_horafim) = ''
                         THEN NULL
                       ELSE a.s140_c_horafim::time
                     END AS sd06_c_horafim
                FROM sau_upsparalisada AS a
                  WHERE a.s140_i_unidade = rsDados.sd04_i_unidade
                    AND dTmp BETWEEN a.s140_d_inicio AND a.s140_d_fim
                    AND ((a.s140_c_horaini IS NULL AND a.s140_c_horafim::time IS NULL)
                         OR (TRIM(a.s140_c_horaini) = '' AND TRIM(a.s140_c_horafim) = '')
                         OR rsDados.sd30_c_horaini BETWEEN a.s140_c_horaini::time AND a.s140_c_horafim::time
                         OR rsDados.sd30_c_horafim BETWEEN a.s140_c_horaini::time AND a.s140_c_horafim::time
                         OR (rsDados.sd30_c_horaini < a.s140_c_horaini::time
                             AND rsDados.sd30_c_horafim > a.s140_c_horafim::time)))) as u
             ORDER BY sd06_c_horainicio IS NULL DESC, sd06_c_horafim IS NULL DESC;
        FETCH pCursorAus INTO rsAus;

        fIntervalo := 0.0; -- Intervalo de ausência / paralisação

        <<loop_aus>> -- loop que processa todas as ausencias / paralisações
        WHILE FOUND LOOP

          IF rsAus.sd06_c_horainicio IS NULL AND rsAus.sd06_c_horafim IS NOT NULL THEN
            rsAus.sd06_c_horainicio := '00:00'::time;
          ELSIF rsAus.sd06_c_horainicio IS NOT NULL AND rsAus.sd06_c_horafim IS NULL THEN
            rsAus.sd06_c_horafim := '23:59'::time;
          END IF;

          -- Se a ausência engloba todo o horário das fichas, então é como se o dia não tivesse fichas
          -- Obs: as comparações de intersecção não estão todas aqui pq se na ausência for informado um
          -- horário (de início ou de fim) e outro estiver null, eu coloco valores padrões pra eles (00:00 ou 23:59)
          IF ((rsAus.sd06_c_horainicio::time IS NULL AND rsAus.sd06_c_horafim::time IS NULL)
              OR (rsDados.sd30_c_horaini >= rsAus.sd06_c_horainicio
                  AND rsDados.sd30_c_horafim <= rsAus.sd06_c_horafim)) THEN

            iDias      := iDias - 1;
            fIntervalo := 0.0; -- Seto para não entrar no if que logo após sair do while
            EXIT loop_aus;

          -- Período de ausência se dá do início do horário até rsAus.sd06_c_horafim
          ELSIF rsDados.sd30_c_horaini >= rsAus.sd06_c_horainicio THEN

            tIntervalo := rsAus.sd06_c_horafim - rsDados.sd30_c_horaini;

          -- Período de ausência se dá de rsAus.sd06_c_horainicio até o final do horário
          ELSIF rsDados.sd30_c_horafim <= rsAus.sd06_c_horafim THEN

            tIntervalo := rsDados.sd30_c_horafim - rsAus.sd06_c_horainicio;

          ELSE -- O período de ausência está entre o início e o fim do horário, então todo seu intervalo é contado

            tIntervalo := rsAus.sd06_c_horafim - rsAus.sd06_c_horainicio;

          END IF;

          fIntervalo := fIntervalo + EXTRACT(HOURS FROM tIntervalo)::float + (EXTRACT(MINUTES FROM tIntervalo)::float / 60.0);
          FETCH pCursorAus INTO rsAus;

        END LOOP; -- Fim do loop que processa as ausências / paralisações

        IF fIntervalo > 0.0 THEN -- Tem ausência / paralisação

          tTempoAtend := rsDados.sd30_c_horafim - rsDados.sd30_c_horaini;
          fTempoAtend := EXTRACT(HOURS FROM tTempoAtend)::float + (EXTRACT(MINUTES FROM tTempoAtend)::float / 60.0);
          IF fTempoAtend <= 0.0 THEN
            fTempoAtend := 1.0;
          END IF;

          iTmp := ceil((fIntervalo * rsDados.totalfichas) / fTempoAtend); -- Regra de três simples
          IF iTmp > rsDados.totalfichas THEN
            iDias := iDias - 1;
          ELSE
            iFichasDescontar := iFichasDescontar + iTmp;
          END IF;

        END IF;

        CLOSE pCursorAus;

        dTmp := dTmp + '7 days'::interval; -- Somo 7 dias, pois estou verificando para um dia da semana específico

      ELSE -- Somo 1 dia pq ainda não encontrei o primeiro dia da semana que fecha com o que estou procurando
        dTmp := dTmp + '1 day'::interval;
      END IF;

    END LOOP; -- Fim loop que calcula o numero de dias da semana

    iNumCotas := iNumCotas + ((iDias * rsDados.totalfichas) - iFichasDescontar);

    FETCH pCursor INTO rsDados;

  END LOOP;

  CLOSE pCursor;

  RETURN iNumCotas;

END
$$ LANGUAGE 'plpgsql';drop function if exists fc_iptu_fracionalote(integer,integer,boolean,boolean);
drop function if exists fc_iptu_fracionalote(integer,integer,boolean,boolean,boolean);

drop   type tp_iptu_fracionalote;
create type tp_iptu_fracionalote as ( rnFracao  numeric,
rtDemo    text,
rtMsgerro text,
rbErro    boolean);

create or replace function fc_iptu_fracionalote(integer,integer,boolean,boolean) returns tp_iptu_fracionalote as
$$
declare

  iMatricula            alias for $1;
  iAnousu               alias for $2;
  bMostrademo           alias for $3;
  lRaise                alias for $4;

  rtp_iptu_fracionalote tp_iptu_fracionalote%ROWTYPE;

  begin

    rtp_iptu_fracionalote.rnFracao  := 0;
    rtp_iptu_fracionalote.rtDemo    := '';
    rtp_iptu_fracionalote.rtMsgerro := '';
    rtp_iptu_fracionalote.rbErro    := 'f';

    select *
      into rtp_iptu_fracionalote
      from fc_iptu_fracionalote(iMatricula, iAnousu, bMostrademo, lRaise, true);

    return rtp_iptu_fracionalote;

  end;
$$  language 'plpgsql';


create or replace function fc_iptu_fracionalote(integer,integer,boolean,boolean,boolean) returns tp_iptu_fracionalote as
$$
declare

  iMatricula 	           alias for $1;
  iAnousu    	           alias for $2;
  bMostrademo            alias for $3; --Não utilizada no escopo
  lRaise                 alias for $4;
  lAtualizaFracaoForcada alias for $5;

  cSetor	              char(4);
  cQuadra	              char(4);
  cLote		              char(4);
  iIptufrac	            integer;
  fTotalAreaConstruida  numeric;
  iTotalMatriculas	    integer;
  tManual 	            text     default '';
  iIdbql 	              integer  default 0;
  rnFracao 	            numeric  default 0;
  nAreacalc	            numeric  default 0;
  nJ01_fracao           numeric  default 0;

  rFracao	              record;

  rtp_iptu_fracionalote tp_iptu_fracionalote%ROWTYPE;

  begin

    perform fc_debug('', lRaise);
    perform fc_debug(' <fracionalote> INICIANDO FRACIONAMENTO DO LOTE...', lRaise);

    rtp_iptu_fracionalote.rnFracao  := 0;
    rtp_iptu_fracionalote.rtDemo    := '';
    rtp_iptu_fracionalote.rtMsgerro := '';
    rtp_iptu_fracionalote.rbErro    := 'f';

    select j01_idbql into iIdbql
      from iptubase
     where j01_matric = iMatricula;

    select j34_setor,
           j34_quadra,
           j34_lote
           into cSetor,
           cQuadra,
           cLote
      from lote
     where j34_idbql = iIdbql;

    perform fc_debug(' <fracionalote> Setor: '||cSetor||' - Quadra: '||cQuadra||' Lote: '||cLote, lRaise);

    /**
     * Conta quantas iMatriculas tem para o lote da iMatricula a ser calculada
     */
    select count(j01_idbql)
      into iTotalMatriculas
      from iptubase
           inner join lote on j01_idbql = j34_idbql
     where j01_baixa is null
       and j34_setor  = cSetor
       and j34_quadra = cQuadra
       and j34_lote   = cLote;

    perform fc_debug(' <fracionalote> iMatricula          : ' || iMatricula, lRaise);
    perform fc_debug(' <fracionalote> fracao              : ' || rnFracao, lRaise);
    perform fc_debug(' <fracionalote> total de iMatriculas: ' || iTotalMatriculas, lRaise);

    if iTotalMatriculas = 1 then

        if rnFracao is null or rnFracao = 0 then
          rnFracao = 100::numeric;
        else

          perform fc_debug(' <fracionalote> Calculando area construida da iMatricula... ' || iMatricula, lRaise);

          /**
           * Retorna a area total contruida da MATRICULA
           */
           select into nAreacalc fc_iptu_getareaconstrmat( iMatricula );

           if lRaise is true then
             perform fc_debug(' <fracionalote> Fracao de novo: ' || rnFracao, lRaise);
           end if;

           if lRaise is true then
             perform fc_debug(' <fracionalote> fracaocalc: ' || nAreacalc, lRaise);
           end if;

           if nAreacalc is null or nAreacalc = 0 then
             rnFracao = 100;
           else

             rnFracao = ( (nAreacalc / rnFracao ) * 100 );
             perform fc_debug(' <fracionalote> nAreacalc: '||nAreacalc||' - rnFracao: ' || rnFracao, lRaise);
           end if;

        end if;

    else

      /**
       * Retorna a area total contruida do LOTE
       */
      select into fTotalAreaConstruida fc_iptu_getareaconstrlote(cSetor,cQuadra,cLote);

      perform fc_debug(' <fracionalote> Total construido no lote: ' || fTotalAreaConstruida, lRaise);

      tManual := tManual || 'total construido no lote: ' || fTotalAreaConstruida || ' - ';

      if fTotalAreaConstruida = 0 then

        select j01_fracao
          into nJ01_fracao
          from iptubase
         where j01_matric = iMatricula;

        if nJ01_fracao = 0 or nJ01_fracao is null then

          if lAtualizaFracaoForcada then
            update iptubase set j01_fracao = 0 where j01_idbql = iIdbql;
          end if;

          rnFracao = 100::numeric;
        else
          rnFracao = nJ01_fracao;
        end if;

      else

        perform fc_debug(' <fracionalote> Fraciona rFracao ', lRaise);

        for rFracao in

            select j01_matric, sum(j39_area)
              from iptubase
                   inner join iptuconstr on j39_matric = j01_matric
             where j01_baixa is null
               and j39_dtdemo is null
               and j01_matric = iMatricula
          group by j01_matric loop

          perform fc_debug(' <fracionalote> processando fracao iMatricula: '||coalesce(rFracao.j01_matric,0)||' - contruido desta: ' || coalesce(rFracao.sum,0), lRaise );

          select j25_matric
            into iIptufrac
            from iptufrac
           where j25_matric = rFracao.j01_matric
             and j25_anousu = iAnousu;

          perform fc_debug(' <fracionalote>    iptufrac: ' || coalesce( iIptufrac, 0 ), lRaise);

          if iIptufrac is null or iIptufrac = 0 then

            perform fc_debug(' <fracionalote>    insert no iptufrac', lRaise);
            insert into iptufrac values (iAnousu, rFracao.j01_matric, iIdbql, rFracao.sum / fTotalAreaConstruida * 100);
          else

            perform fc_debug(' <fracionalote>    update no iptufrac', lRaise);
            update iptufrac
               set j25_fracao = rFracao.sum / fTotalAreaConstruida * 100,
                   j25_idbql  = iIdbql
             where j25_matric = rFracao.j01_matric
               and j25_anousu = iAnousu;
          end if;

        end loop;

        select j25_fracao
          into rnFracao
          from iptufrac
         where j25_matric = iMatricula
           and j25_anousu = iAnousu;

        if rnFracao is null or rnFracao = 0 then
          rnFracao = 100::numeric;
        end if;

      end if;

    end if;

    select j01_fracao
      into nJ01_fracao
      from iptubase
    where j01_matric = iMatricula;

    if nJ01_fracao is not null and nJ01_fracao > 0 then
      rnFracao = nJ01_fracao;
    end if;

    rtp_iptu_fracionalote.rnFracao := rnFracao;
    rtp_iptu_fracionalote.rtDemo   := tManual;
    perform fc_debug(' <fracionalote> texto demonstrativo :' || tManual, lRaise);

    perform fc_debug(' <fracionalote> FIM FRACIONAMENTO DO LOTE', lRaise);
    perform fc_debug(' ', lRaise);

    return rtp_iptu_fracionalote;

  end;
  $$  language 'plpgsql';insert into db_versaoant (db31_codver,db31_data) values (360, current_date);
select setval ('db_versaousu_db32_codusu_seq',(select max (db32_codusu) from db_versaousu));
select setval ('db_versaousutarefa_db28_sequencial_seq',(select max (db28_sequencial) from db_versaousutarefa));
select setval ('db_versaocpd_db33_codcpd_seq',(select max (db33_codcpd) from db_versaocpd));
select setval ('db_versaocpdarq_db34_codarq_seq',(select max (db34_codarq) from db_versaocpdarq));create table bkp_db_permissao_20151123_113516 as select * from db_permissao;
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