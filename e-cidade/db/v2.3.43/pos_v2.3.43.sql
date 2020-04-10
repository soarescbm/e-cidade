insert into db_versao (db30_codver, db30_codversao, db30_codrelease, db30_data, db30_obs)  values (359, 3, 43, '2015-10-16', 'Tarefas: 98687, 98728, 98753, 98754, 98756, 98757, 98760, 98761, 98762, 98763, 98766, 98767, 98774, 98777, 98778, 98781, 98783, 98786, 98790, 98791, 98793, 98795, 98796, 98799, 98800, 98801, 98807, 98809, 98811, 98814, 98816, 98818, 98819, 98820, 98821, 98822, 98824, 98827, 98828, 98830, 98832, 98833, 98834, 98835, 98837, 98838, 98839, 98841, 98845, 98846, 98848, 98850, 98852, 98853, 98854, 98855, 98856, 98857, 98862, 98865, 98867, 98870, 98873, 98877, 98878, 98879, 98885, 98886, 98887, 98888, 98889, 98891, 98893, 98894, 98896, 98897, 98898, 98899, 98902, 98904, 98905, 98906, 98907, 98910, 98911, 98912, 98913, 98915, 98916, 98919, 98921, 98922, 98923, 98924, 98928, 98929, 98931, 98932, 98933, 98934, 98935, 98936, 98937, 98938, 98939, 98941');--drop function fc_dotacaosaldo(integer,integer,integer,date,date);
create or replace function fc_dotacaosaldo(integer,integer,integer,date,date)
returns varchar
as '
DECLARE

  ANOUSU   	ALIAS FOR $1;
  CODDOT  	ALIAS FOR $2;
  TIPO     	ALIAS FOR $3;
    -- 1 SALDO INICIAL DA DOTACAO - ORCAMENTO
    -- 2 SALDO DA DOTACAO  com reserva POR EMP, LIQ, PAG ... POR MES
    -- 3 SALDO DA DOTACAO  PELA CONTABILIDADE ...
    -- 4 SALDO ACUMULADO POR MES
  DATAUSU	ALIAS FOR $4;
  DATAFIM	ALIAS FOR $5;

  VALORINI  	FLOAT8 DEFAULT 0;
  VALOR  	FLOAT8 DEFAULT 0;

  -- VARIAVEL PARA VALOR DA DOTACAO
  VALORRES	                    FLOAT8 DEFAULT 0;

  -- VARIAVEL PARA VALORES RESERVADOS ATE A DATA INFORMADA (FINAL)
  RESERVADO_MANUAL_ATE_DATA	    FLOAT8 DEFAULT 0;
  RESERVADO_AUTOMATICO_ATE_DATA	FLOAT8 DEFAULT 0;
  RESERVADO_ATE_DATA            FLOAT8 DEFAULT 0;

  -- VARIAVEL PARA VALOR DAS RESERVAS DE SALDO
  DATAINI 	DATE;

  SALDO_ANTERIOR	   FLOAT8 DEFAULT 0;
  VALOR_EMPENHADO	   FLOAT8 DEFAULT 0;
  VALOR_ANULADO		   FLOAT8 DEFAULT 0;
  VALOR_LIQUIDADO	   FLOAT8 DEFAULT 0;
  VALOR_PAGO		     FLOAT8 DEFAULT 0;
  VALOR_SUPLEMENTADO FLOAT8 DEFAULT 0;
  VALOR_ESPECIAL     FLOAT8 DEFAULT 0;
  VALOR_REDUZIDO	   FLOAT8 DEFAULT 0;

  VALOR_TRANSFSUP FLOAT8 DEFAULT 0;
  VALOR_TRANSFRED FLOAT8 DEFAULT 0;

  VALOR_EMPENHADOT	  FLOAT8 DEFAULT 0;
  VALOR_ANULADOT	    FLOAT8 DEFAULT 0;
  VALOR_LIQUIDADOT	  FLOAT8 DEFAULT 0;
  VALOR_PAGOT		      FLOAT8 DEFAULT 0;
  VALOR_SUPLEMENTADOT	FLOAT8 DEFAULT 0;
  VALOR_ESPECIALT     FLOAT8 DEFAULT 0;
  VALOR_REDUZIDOT	    FLOAT8 DEFAULT 0;
	VALOR_TRANSFSUPT    FLOAT8 DEFAULT 0;
	VALOR_TRANSFREDT    FLOAT8 DEFAULT 0;

  VALOR_EMPENHADOA	  FLOAT8 DEFAULT 0;
  VALOR_ANULADOA	    FLOAT8 DEFAULT 0;
  VALOR_LIQUIDADOA	  FLOAT8 DEFAULT 0;
  VALOR_PAGOA		      FLOAT8 DEFAULT 0;
  VALOR_SUPLEMENTADOA	FLOAT8 DEFAULT 0;
  VALOR_ESPECIALA	    FLOAT8 DEFAULT 0;
  VALOR_REDUZIDOA	    FLOAT8 DEFAULT 0;
  VALOR_TRANSFSUPA	  FLOAT8 DEFAULT 0;
  VALOR_TRANSFREDA	  FLOAT8 DEFAULT 0;

  SALDO_A_PAGAR 	        FLOAT8 DEFAULT 0;
  SALDO_A_PAGAR_LIQUIDADO	FLOAT8 DEFAULT 0;

  VALOR_ATUAL_DOT             FLOAT8;
  VALOR_ATUAL_MENOS_RESERVADO FLOAT8;


  BEGIN

    SELECT O58_VALOR
    INTO VALORINI
    FROM ORCDOTACAO
    WHERE O58_ANOUSU = ANOUSU
      AND O58_CODDOT = CODDOT;

    IF VALORINI IS NULL THEN
      RETURN 0;
    END IF;

    IF TIPO = 1 THEN

      RETURN ''1'' || TO_CHAR(VALORINI,''999999999.99'');
      -- RETORNO O VALOR DA DOTACAO COM OU SEM RESERVA

    END IF;

    IF TIPO != 5 THEN

      SELECT SUM(O80_VALOR)::float8
      INTO VALORRES
      FROM ORCRESERVA
      WHERE O80_ANOUSU = ANOUSU
            AND O80_CODDOT = CODDOT
            AND DATAUSU <= O80_DTFIM;

      IF VALORRES IS NULL THEN
        VALORRES := 0;
      END IF;

    ELSE

      SELECT SUM(O80_VALOR)::float8
      INTO VALORRES
      FROM ORCRESERVA
        LEFT JOIN  orcreservager ON o80_codres = o84_codres
      WHERE O80_ANOUSU = ANOUSU
            AND O80_CODDOT = CODDOT
            AND DATAUSU <= O80_DTFIM
            AND o84_codres IS NULL;

      IF VALORRES IS NULL THEN
        VALORRES := 0;
      END IF;

    END IF;

    -- BUSCA VALORES RESERVADOS ATE A DATA INFORMADA (FINAL)
    SELECT
      COALESCE(SUM(CASE WHEN orcreservager.o84_codres IS NULL THEN o80_valor ELSE 0 END),0) as manual,
      COALESCE(SUM(CASE WHEN orcreservager.o84_codres IS NOT NULL THEN o80_valor ELSE 0 END),0) as automatico,
      COALESCE(SUM(o80_valor),0) as total
    INTO RESERVADO_MANUAL_ATE_DATA, RESERVADO_AUTOMATICO_ATE_DATA, RESERVADO_ATE_DATA
    FROM orcreserva
      LEFT JOIN orcreservager ON o84_codres = o80_codres
    WHERE o80_anousu = ANOUSU
      AND o80_coddot = CODDOT
      AND (o80_dtini <= DATAFIM
      AND  o80_dtfim >= DATAFIM);


    -- VALOR EMPENHADO
    DATAINI := ANOUSU||''-01-01'' ;

    SELECT
      SUM(CASE WHEN  C53_TIPO = 10 THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END ) AS EMPENHADO,
      SUM(CASE WHEN  C53_TIPO = 11 THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END ) AS ANULADO,
      SUM(CASE WHEN  C53_TIPO = 20 THEN ROUND(c70_VALOR,2) ELSE (CASE WHEN C53_TIPO = 21 THEN ROUND(c70_VALOR*-(1::FLOAT8),2) ELSE 0::FLOAT8 END) END ) AS LIQUIDADO,
      SUM(CASE WHEN  C53_TIPO = 30 THEN ROUND(c70_VALOR,2) ELSE (CASE WHEN C53_TIPO = 31 THEN ROUND(c70_VALOR*-(1::FLOAT8),2) ELSE 0::FLOAT8 END) END ) AS PAGO     ,
      SUM((CASE WHEN (C53_TIPO > 39 AND C53_TIPO < 41) THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END) - ( CASE WHEN C53_TIPO = 41 THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END ) ) AS SUPLEMENTADO,
      SUM((CASE WHEN (C53_TIPO > 49 AND C53_TIPO < 51) THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END ) - (CASE WHEN C53_TIPO = 51 THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END)) AS ESPECIAL,
      SUM((CASE WHEN (C53_TIPO > 59 AND C53_TIPO < 61) THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END ) - (CASE WHEN C53_TIPO = 61 THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END) ) AS REDUZIDO,
      SUM(0) AS TRANSFRECSUP,
      SUM(0) AS TRANSFRECRED
    INTO
      VALOR_EMPENHADOA,
      VALOR_ANULADOA,
      VALOR_LIQUIDADOA,
      VALOR_PAGOA,
      VALOR_SUPLEMENTADOA,
      VALOR_ESPECIALA,
      VALOR_REDUZIDOA,
			VALOR_TRANSFSUPA,
			VALOR_TRANSFREDA
    FROM CONLANCAMDOT
      INNER JOIN CONLANCAM ON C70_CODLAN = C73_CODLAN
      INNER JOIN CONLANCAMDOC ON C71_CODLAN = C70_CODLAN
      INNER JOIN CONHISTDOC ON C53_CODDOC = C71_CODDOC
    WHERE C73_ANOUSU = ANOUSU
          AND C73_CODDOT = CODDOT
          AND C73_DATA BETWEEN DATAINI::date AND DATAUSU-1;

    IF VALOR_EMPENHADOA IS NULL THEN
      VALOR_EMPENHADOA := 0;
    END IF;

    IF VALOR_ANULADOA IS NULL THEN
      VALOR_ANULADOA := 0;
    END IF;

    IF VALOR_LIQUIDADOA IS NULL THEN
      VALOR_LIQUIDADOA := 0;
    END IF;

    IF VALOR_PAGOA IS NULL THEN
      VALOR_PAGOA := 0;
    END IF;

    IF VALOR_SUPLEMENTADOA IS NULL THEN
      VALOR_SUPLEMENTADOA := 0;
    END IF;

    IF VALOR_ESPECIALA IS NULL THEN
      VALOR_ESPECIALA := 0;
    END IF;

    IF VALOR_REDUZIDOA IS NULL THEN
      VALOR_REDUZIDOA  := 0;
    END IF;

    IF VALOR_TRANSFSUPA IS NULL THEN
      VALOR_TRANSFSUPA := 0;
    END IF;

    IF VALOR_TRANSFREDA IS NULL THEN
      VALOR_TRANSFREDA := 0;
    END IF;

    VALOR := VALOR + VALOR_SUPLEMENTADOA + VALOR_ESPECIALA - VALOR_REDUZIDOA - VALOR_EMPENHADOA + VALOR_ANULADOA;

    SELECT
      SUM(CASE WHEN  C53_TIPO = 10 THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END ) AS EMPENHADO,
      SUM(CASE WHEN  C53_TIPO = 11 THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END ) AS ANULADO,
      SUM(CASE WHEN  C53_TIPO = 20 THEN ROUND(c70_VALOR,2) ELSE (CASE WHEN C53_TIPO = 21 THEN ROUND(c70_VALOR*-(1::FLOAT8),2) ELSE 0::FLOAT8 END) END ) AS LIQUIDADO,
      SUM(CASE WHEN  C53_TIPO = 30 THEN ROUND(c70_VALOR,2) ELSE (CASE WHEN C53_TIPO = 31 THEN ROUND(c70_VALOR*-(1::FLOAT8),2) ELSE 0::FLOAT8 END) END ) AS PAGO     ,
      SUM((CASE WHEN (C53_TIPO > 39 AND C53_TIPO < 41) THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END) - ( CASE WHEN C53_TIPO = 41 THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END ) ) AS SUPLEMENTADO,
      SUM((CASE WHEN (C53_TIPO > 49 AND C53_TIPO < 51) THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END ) - (CASE WHEN C53_TIPO = 51 THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END)) AS ESPECIAL,
      SUM((CASE WHEN (C53_TIPO > 59 AND C53_TIPO < 61) THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END ) - (CASE WHEN C53_TIPO = 61 THEN ROUND(c70_VALOR,2) ELSE 0::FLOAT8 END) ) AS REDUZIDO,
      SUM(0) AS TRANSFRECSUP,
      SUM(0) AS TRANSFRECRED
    INTO
      VALOR_EMPENHADO,
      VALOR_ANULADO,
      VALOR_LIQUIDADO,
      VALOR_PAGO,
      VALOR_SUPLEMENTADO,
      VALOR_ESPECIAL,
      VALOR_REDUZIDO,
      VALOR_TRANSFSUP,
      VALOR_TRANSFRED
    FROM CONLANCAMDOT
      INNER JOIN CONLANCAM ON C70_CODLAN = C73_CODLAN
      INNER JOIN CONLANCAMDOC ON C71_CODLAN = C70_CODLAN
      INNER JOIN CONHISTDOC ON C53_CODDOC = C71_CODDOC
    WHERE C73_ANOUSU = ANOUSU
          AND C73_CODDOT = CODDOT
          AND C73_DATA BETWEEN DATAUSU AND DATAFIM;

    VALOR := VALOR + VALORINI;

    IF VALOR_EMPENHADO IS NULL THEN
      VALOR_EMPENHADO := 0;
    END IF;

    IF VALOR_ANULADO IS NULL THEN
      VALOR_ANULADO   := 0;
    END IF;

    IF VALOR_LIQUIDADO IS NULL THEN
      VALOR_LIQUIDADO := 0;
    END IF;

    IF VALOR_PAGO IS NULL THEN
      VALOR_PAGO := 0;
    END IF;

    IF VALOR_SUPLEMENTADO IS NULL THEN
      VALOR_SUPLEMENTADO := 0;
    END IF;

    IF VALOR_ESPECIAL IS NULL THEN
      VALOR_ESPECIAL := 0;
    END IF;

    IF VALOR_REDUZIDO IS NULL THEN
      VALOR_REDUZIDO := 0;
    END IF;

    IF VALOR_TRANSFSUP IS NULL THEN
      VALOR_TRANSFSUP := 0;
    END IF;

    IF VALOR_TRANSFRED IS NULL THEN
      VALOR_TRANSFRED := 0;
    END IF;

    VALOR_EMPENHADOT    := ROUND(VALOR_EMPENHADO + VALOR_EMPENHADOA,2);
    VALOR_ANULADOT      := ROUND(VALOR_ANULADO  + VALOR_ANULADOA,2);
    VALOR_LIQUIDADOT    := ROUND(VALOR_LIQUIDADO+ VALOR_LIQUIDADOA,2);
    VALOR_PAGOT         := ROUND(VALOR_PAGO     + VALOR_PAGOA ,2) ;
    VALOR_SUPLEMENTADOT := ROUND(VALOR_SUPLEMENTADO + VALOR_SUPLEMENTADOA,2);
    VALOR_ESPECIALT     := ROUND(VALOR_ESPECIAL + VALOR_ESPECIALA,2);
    VALOR_REDUZIDOT     := ROUND(VALOR_REDUZIDO + VALOR_REDUZIDOA,2);
    VALOR_TRANSFSUPT    := ROUND(VALOR_TRANSFSUP + VALOR_TRANSFSUPA,2);
    VALOR_TRANSFREDT    := ROUND(VALOR_TRANSFRED + VALOR_TRANSFREDA,2);

    -- SALDO INICIAL
    -- SALDO ANTERIOR
    -- SALDO EMPENHADO
    -- SALDO ANULADO
    -- SALDO LIQUIDADO
    -- SALDO PAGO
    -- SALDO SUPLEMENTADO
    -- SALDO REDUZIDO
    -- SALDO ATUAL
    -- VALOR RESERVADO
    -- SALDO ATUAL MENOS O RESERVADO
    -- SALDO ATUAL A PAGAR
    -- SALDO ATUAL A PAGAR LIQUIDADO
    -- SALDO EMPENHADO ACUMULADO
    -- SALDO ANULADO   ACUMULADO
    -- SALDO LIQUIDADO ACUMULADO
    -- SALDO PAGO ACUMULADO
    -- SALDO SUPLEMENTADO ACUMULADO
    -- SALDO REDUZIDO ACUMULADO

    SALDO_A_PAGAR := VALOR_EMPENHADO - VALOR_ANULADO - VALOR_LIQUIDADO;

    IF SALDO_A_PAGAR < 0 THEN
      SALDO_A_PAGAR := 0;
    END IF;

    SALDO_A_PAGAR_LIQUIDADO := VALOR_LIQUIDADO-VALOR_PAGO;
    IF SALDO_A_PAGAR_LIQUIDADO < 0 THEN
      SALDO_A_PAGAR_LIQUIDADO := 0;
    END IF;

    VALOR_ATUAL_DOT := VALOR + (VALOR_SUPLEMENTADO + VALOR_ESPECIAL) - VALOR_REDUZIDO - VALOR_EMPENHADO + VALOR_ANULADO;
    VALOR_ATUAL_MENOS_RESERVADO := (VALOR) + (VALOR_SUPLEMENTADO + VALOR_ESPECIAL) - VALOR_REDUZIDO - VALOR_EMPENHADO + VALOR_ANULADO - (VALORRES);

    RETURN ''2''
      || TO_CHAR(VALORINI,''999999999.99'')
      || TO_CHAR(VALOR,''999999999.99'')
      || TO_CHAR(VALOR_EMPENHADO,''999999999.99'')
      || TO_CHAR(VALOR_ANULADO,''999999999.99'')
      || TO_CHAR(VALOR_LIQUIDADO,''999999999.99'')
      || TO_CHAR(VALOR_PAGO,''999999999.99'')
      || TO_CHAR((VALOR_SUPLEMENTADO+VALOR_ESPECIAL),''999999999.99'')
      || TO_CHAR(VALOR_REDUZIDO,''999999999.99'')
      || TO_CHAR(VALOR_ATUAL_DOT,''999999999.99'')
      || TO_CHAR(VALORRES,''999999999.99'')
      || TO_CHAR(VALOR_ATUAL_MENOS_RESERVADO,''999999999.99'')
      || TO_CHAR(SALDO_A_PAGAR,''999999999.99'')
      || TO_CHAR(SALDO_A_PAGAR_LIQUIDADO,''999999999.99'')
      || TO_CHAR(VALOR_EMPENHADOT,''999999999.99'')
      || TO_CHAR(VALOR_ANULADOT,''999999999.99'')
      || TO_CHAR(VALOR_LIQUIDADOT,''999999999.99'')
      || TO_CHAR(VALOR_PAGOT,''999999999.99'')
      || TO_CHAR((VALOR_SUPLEMENTADOT+VALOR_ESPECIALT),''999999999.99'')
      || TO_CHAR(VALOR_REDUZIDOT,''999999999.99'')
      || TO_CHAR(VALOR_SUPLEMENTADO,''999999999.99'')
      || TO_CHAR(VALOR_SUPLEMENTADOT,''999999999.99'')
      || TO_CHAR(VALOR_ESPECIAL,''999999999.99'')
      || TO_CHAR(VALOR_ESPECIALT,''999999999.99'')
      || TO_CHAR(VALOR_TRANSFSUP,''999999999.99'')
      || TO_CHAR(VALOR_TRANSFSUPT,''999999999.99'')
      || TO_CHAR(VALOR_TRANSFRED,''999999999.99'')
      || TO_CHAR(VALOR_TRANSFREDT,''999999999.99'')
      || TO_CHAR(RESERVADO_MANUAL_ATE_DATA,''999999999.99'')
      || TO_CHAR(RESERVADO_AUTOMATICO_ATE_DATA,''999999999.99'')
      || TO_CHAR(RESERVADO_ATE_DATA,''999999999.99'');
  END;
' language 'plpgsql';create or replace function fc_calculaprecomedio(integer, integer, float8, boolean)
  returns numeric as
$$

declare

  iCodigoMatestoqueiniMei        alias for $1;
  iCodigoMatestoqueini           alias for $2;
  nQuantidadeMovimento           alias for $3;
  lRecursivo                     alias for $4;

  nPrecoMedio                    numeric default 0;
  iMaterial                      integer;
  iInstituicao                   integer;
  iAlmoxarifado                  integer;
  nValorEstoque                  numeric;
  nQuantidadeEstoque             numeric default 0;
  nValorEstoqueDiferenca         numeric default 0;
  nQuantidadeEstoqueDiferenca    numeric default 0;
  iTipoMovimento                 integer;
  iCodigoEstoque                 integer;
  iCodigoMovimento               integer;
  iCodigoEntradaItem             integer;
  nValorUnitario                 numeric default 0;
  dtMovimento                    date;
  tHora                          timestamp;
  tHoraMovimento                 time;
  lTemPrecoMedio                 boolean default false;
  rValoresPosteriores            record;
  lServico                       boolean;
  iDepto                         integer;
  nQuantidadeSaidasPosteriores   numeric default 0;
  nQuantidadeEntradasPosteriores numeric default 0;
  nSaidasNoPeriodo               numeric default 0;
  nSaldoNoPeriodo                numeric default 0;
  nSaldoAposPeriodo              numeric default 0;
  sMensagemEstoque               varchar;
  lEntradaAposPeriodo            boolean default false;
  sSqlPrecoMedio                 varchar;
begin

   iInstituicao = fc_getsession('DB_instit');
   if iInstituicao is null then
     raise exception 'Instituicao não informada.';
   end if;

   /**
    * Consultamos o codigo do material,
    * atraves da tabela matestoqueitem, com o campo new.m82_matestoqueitem.
    */
    select m70_codmatmater,
           (case when  m71_quant > 0 then
           coalesce(m71_valor/m71_quant, 0)
           else 0 end),
           m71_servico,
           m70_coddepto,
           m71_codlanc
      into iMaterial,
           nValorUnitario,
           lServico,
           iAlmoxarifado,
           iCodigoEntradaItem
      from matestoqueitem
           inner join matestoque       on m70_codigo  = m71_codmatestoque
           inner join matestoqueinimei on m71_codlanc = m82_matestoqueitem
      where m82_codigo  = iCodigoMatestoqueiniMei;

   /**
    * Consultamos o tipo da movimentacao
    */
   select m80_codtipo,
          m81_tipo,
          to_timestamp(m80_data || ' ' || m80_hora, 'YYYY-MM-DD HH24:MI:SS'),
          m80_data,
          m80_hora,
          m80_coddepto,
          instit
     into iCodigoMovimento,
          iTipoMovimento,
          tHora,
          dtMovimento,
          tHoraMovimento,
          iDepto,
          iInstituicao
     from matestoqueini
          inner join matestoquetipo on m81_codtipo = m80_codtipo
          inner join DB_DEPART on m80_coddepto     = coddepto
    where m80_codigo = iCodigoMatestoqueini;

   /**
    * Soma a quantidade em estoque do item na instituicao
    *
    */
   select coalesce(sum(CASE when m81_tipo = 1 then round(m82_quant, 2) when m81_tipo = 2 then round(m82_quant,2)*-1 end), 0),
          round(coalesce(sum(CASE when m81_tipo = 1 then round(round(m82_quant, 2)*m89_valorunitario, 5)
                            when m81_tipo = 2 then round(m82_quant, 2)*round(m89_precomedio, 5)*-1 end), 0) , 2)
     into nQuantidadeEstoque,
          nValorEstoque
     from matestoque
          inner join db_depart          on m70_coddepto       = coddepto
          inner join matestoqueitem     on m70_codigo         = m71_codmatestoque
          inner join matestoqueinimei   on m82_matestoqueitem = m71_codlanc
          inner join matestoqueinimeipm on m82_codigo         = m89_matestoqueinimei
          inner join matestoqueini      on m82_matestoqueini  = m80_codigo
          inner join matestoquetipo     on m81_codtipo        = m80_codtipo
    where instit           = iInstituicao
      and m70_codmatmater  = iMaterial
      and to_timestamp(m80_data || ' ' || m80_hora, 'YYYY-MM-DD HH24:MI:SS') <= tHora
      and m82_codigo <> iCodigoMatestoqueiniMei
      and m70_coddepto = iAlmoxarifado
      and m81_tipo not in(4,5)
      and m71_servico is false;

   /**
     * verificamos se o item possui no mesmo movimento entradas para o mesmo item de estoque
     */
    SELECT coalesce(sum(CASE when m81_tipo = 1 then round(m82_quant, 2)
                             when m81_tipo = 2 then round(m82_quant,2)*-1 end), 0) as saldodif,
           round(coalesce(sum(CASE when m81_tipo = 1 then round(round(round(m82_quant, 2)*m89_valorunitario, 5), 2)
                            when m81_tipo = 2 then round(round(m82_quant, 2)*round(m89_precomedio, 5), 2)*-1 end), 0), 2)
      into nQuantidadeEstoqueDiferenca,
          nValorEstoqueDiferenca
      from matestoqueinimei
           inner join matestoqueitem     on m71_codlanc          = m82_matestoqueitem
           inner join matestoque         on m71_codmatestoque    = m70_codigo
           inner join matestoqueinimeipm on m89_matestoqueinimei = m82_codigo
           inner join matestoqueini      on m82_matestoqueini    = m80_codigo
           inner join matestoquetipo     on m80_codtipo          = m81_codtipo
     where m70_codmatmater   = iMaterial
       and m82_matestoqueini = iCodigoMatestoqueini
       and m82_codigo        > iCodigoMatestoqueiniMei
       and m70_coddepto = iAlmoxarifado
       and m81_tipo not in(4,5)
       and m71_servico is false;
       nQuantidadeEstoque := nQuantidadeEstoque - nQuantidadeEstoqueDiferenca;
       nValorEstoque      := nValorEstoque      - nValorEstoqueDiferenca;

   /**
    * Verificamos o ultimo preco medio da data do material para o item.
    */

   select round(m85_precomedio, 5)
     into nPrecoMedio
     from matmaterprecomedio
    where m85_matmater = iMaterial
      and m85_instit   = iInstituicao
      and m85_coddepto = iAlmoxarifado
      and to_timestamp(m85_data || ' ' || m85_hora, 'YYYY-MM-DD HH24:MI:SS') <= tHora
    order by to_timestamp(m85_data || ' ' || m85_hora, 'YYYY-MM-DD HH24:MI:SS') desc limit 1;

    if ( not found or nPrecoMedio = 0 ) and iCodigoMovimento in (8) then

   select round(m85_precomedio, 5)
     into nPrecoMedio
     from matmaterprecomedio
    where m85_matmater = iMaterial
      and m85_instit   = iInstituicao
      and m85_precomedio > 0
      and m85_coddepto = ( select m80_coddepto
                             from matestoqueini
                                  inner join matestoqueinil  inil  on inil.m86_matestoqueini   = matestoqueini.m80_codigo
                                  inner join matestoqueinill inill on inill.m87_matestoqueinil = inil.m86_codigo
                            where inill.m87_matestoqueini = iCodigoMatestoqueini limit 1)
      and to_timestamp(m85_data || ' ' || m85_hora, 'YYYY-MM-DD HH24:MI:SS') <= tHora
    order by to_timestamp(m85_data || ' ' || m85_hora, 'YYYY-MM-DD HH24:MI:SS') desc limit 1;

      update matmaterprecomedio
         set m85_precomedio = nPrecoMedio
       where m85_matmater = iMaterial
         and m85_instit   = iInstituicao
         and m85_coddepto = iAlmoxarifado
         and to_timestamp(m85_data || ' ' || m85_hora, 'YYYY-MM-DD HH24:MI:SS') <= tHora;

    end if;

    if nQuantidadeEstoque = 0 then
       nValorEstoque := 0;
    end if;
    if  found then
     lTemPrecoMedio = true;
   end if;
   nPrecoMedio := coalesce(nPrecoMedio, 0);
  /**
   * Verificamos as entradas no estoque (refletem no calculo do preço medio)
   * algumas entradas, que na verdade são cancelamentos de saidas, devem entrar no estoque
   * pelo preco médio atual, não alterando o preço do calculo médio.
   */
  if iCodigoMovimento in(8, 1, 3, 12, 14, 15, 25) then

    /**
     * como o sistema já inclui as informações do estoque na hora de verificarmos o preço médio,
     * devemos deduzir a quantidade da entrada, (nQuantidade - m82_quant). a regra do calculo do preço médio é:
     * pegamos a quantidade anterior em estoque, e multiplicamos pelo ultimo preço médio.
     * - Somamos a nova entrada (quantidade e valor da entrada,) e dividimos o valor encontrado pela quantidade
     * encontrada. o resultado dessa divisão, encontramos o preço médio.
     */
    --nValorEstoque      = round(nQuantidadeEstoque * nPrecoMedio, 2);
    nQuantidadeEstoque = nQuantidadeEstoque  + nQuantidadeMovimento;
    nValorEstoque      = round(nValorEstoque + (nQuantidadeMovimento*nValorUnitario), 2);
    nPrecoMedio        = 0;
    if nQuantidadeEstoque > 0 then
      nPrecoMedio    = round( nValorEstoque / nQuantidadeEstoque, 5);
    end if;
  /**
   * Excluimos o preço medio para o movimento/hora
   */
    delete from matmaterprecomedio
     where m85_matmater = imaterial
       and m85_instit   = iInstituicao
       and m85_coddepto = iAlmoxarifado
       and to_timestamp(m85_data || ' ' || m85_hora, 'YYYY-MM-DD HH24:MI:SS') >= tHora;

    insert into matmaterprecomedio
                  (m85_sequencial,
                   m85_matmater,
                   m85_instit,
                   m85_precomedio,
                   m85_data,
                   m85_hora,
                   m85_coddepto
                  )
           values (nextval('matmaterprecomedio_m85_sequencial_seq'),
                   iMaterial,
                   iInstituicao,
                   round(nPrecoMedio, 5),
                   dtMovimento,
                   tHoraMovimento,
                   iAlmoxarifado
                  );

  elsif iTipoMovimento = 2 and iCodigoMovimento not in(8, 9) then

    nValorUnitario = round(nPrecoMedio, 5);

  elsif iCodigoMovimento in(7, 6, 18, 9) then

    nValorUnitario = round(nPrecoMedio, 5);

  elsif iCodigoMovimento in (21) then

    /**
     * caso  a transferencia seja confirmada,
     * temos que fazer a entrada no estoque ao mesmo valor da saida, pois a movimentacao no estoque
     * nao existe a movimentacao de valores.
     * o codigo da transferencia está na tabela mastoqueinil/matestoqueinill
     */
     select round(m89_precomedio, 5)
       into nPrecoMedio
       from matestoqueinill
            inner join matestoqueinil     on m87_matestoqueinil = m86_codigo
            inner join matestoqueinimei   on m86_matestoqueini  = m82_matestoqueini
            inner join matestoqueinimeipm on m82_codigo         = m89_matestoqueinimei
            inner join matestoqueitem     on m82_matestoqueitem = m71_codlanc
            inner join matestoque         on m70_codigo         = m71_codmatestoque
      where m70_codmatmater   = iMaterial
        and m87_matestoqueini = iCodigoMatestoqueini
        and m71_servico is false;

     nValorUnitario = round(nPrecoMedio, 5);
  end if;

  delete from matestoqueinimeipm where m89_matestoqueinimei = iCodigoMatestoqueiniMei;
  insert into matestoqueinimeipm
              (m89_sequencial,
               m89_matestoqueinimei,
               m89_precomedio,
               m89_valorunitario,
               m89_valorfinanceiro
               )
       values (nextval('matestoqueinimeipm_m89_sequencial_seq'),
               iCodigoMatestoqueiniMei,
               round(nPrecoMedio, 5),
               round(nValorUnitario, 5),
               round(nQuantidadeMovimento * round(nValorUnitario, 5), 2)
              );
  return round(nPrecoMedio, 5);
end;
$$
language 'plpgsql';create or replace function public.fc_valida_cns(varchar, varchar) returns boolean as $$
declare
	sCNSin     alias for $1;
	sTipo      alias for $2;
	sCNS       varchar;
	lRetorno   boolean := false;
	iSoma      integer := 0;
	iResto     integer;
	iDV        integer;
	sPIS       varchar;
	sResultado varchar;
	lRaise     boolean := ( case when public.fc_getsession('DB_debugon') is null then false else true end );

begin

	if lRaise is true then
		raise info 'Cartao SUS: %   Tipo: % ', sCNSin, sTipo;
	end if;

	begin
		sCNS := trim( to_char( to_number( sCNSin, '999999999999999' ), '999999999999999') );
	exception
	  when others then
	  	if lRaise is true then
			raise info 'INVALIDO Cartao SUS: %   Tipo: % ', sCNSin, sTipo;
		end if;
		return false;
	end;

	if ( length( sCNS ) != 15 OR sCNS IS NULL ) then
		if lRaise is true then
			raise info 'Cartao SUS: % invalido. -- %', sCNS, length( sCNS );
		end if;
	else
		-- Cartão Provisório
		if sTipo = 'P' then

			for iCount in 1..15
			loop
				iSoma := iSoma + ( to_number( substr( sCNS, iCount, 1), '9' ) * ( 16 - iCount ) );
			end loop;

			iResto = mod( iSoma, 11 );
			lRetorno := ( iResto = 0  );

			if lRaise is true then
				raise info 'Soma: %', iSoma;
				raise info 'Resto: %', iResto;
			end if;

		else -- Cartão Definitivo
			sPIS = substr( sCNS, 1, 11 );
			for iCount in 1..11
			loop
				iSoma := iSoma + ( to_number( substr( sCNS, iCount, 1), '9' ) * ( 16 - iCount ) );
			end loop;
			iResto = mod( iSoma, 11 );

			iDV := 11 - iResto;

			if lRaise is true then
				raise info 'Soma: %', iSoma;
				raise info 'Resto: %', iResto;
				raise info 'DV: %', iDV;
			end if;

			if( iDV = 11 ) then
				iDV := 0;
			end if;

			if( iDV = 10 ) then

				iSoma := 0;
				for iCount in 1..11
				loop
					iSoma := iSoma + ( to_number( substr( sCNS, iCount, 1), '9' ) * ( 16 - iCount ) );
				end loop;

				iSoma := iSoma + 2;
				iResto = mod( iSoma, 11 );
				iDV := 11 - iResto;

				if lRaise is true then
					raise info 'Soma2: %', iSoma;
					raise info 'Resto2: %', iResto;
					raise info 'DV2: %', iDV;
				end if;

				sResultado := sPIS||'001'||iDV;
			else
				sResultado := sPIS||'000'||iDV;
			end if;

			if lRaise is true then
				raise info 'Resultado: %', sResultado;
			end if;

			lRetorno := ( sCNS = sResultado  );

		end if;
	end if;

	return lRetorno;
end;

$$ language 'plpgsql';

create or replace function public.fc_valida_cns(varchar) returns boolean as $$
declare
	sCNS       alias for $1;

begin

	if 	sCNS != ''  then
		if public.fc_valida_cns( sCNS, cast( 'D' as varchar)  ) then
			return true;
		else
			if public.fc_valida_cns( sCNS, cast('P' as varchar) ) then
				return true;
			end if;
		end if;
	end if;

	return ( sCNS is null );

end;

$$ language 'plpgsql';drop function if exists fc_iptu_demonstrativo(integer,integer,integer,boolean);
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
   nAreaEdificada  numeric(15,2) default 0;

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

   nAreaEdificada = rDadosIptu.areat;
   if rDadosIptu.predial is false then
     nAreaEdificada = 0;
   else

    /**
     * Soma as areas edificadas das construcoes da matricula
     */
    select sum(areaed) as areaed
      into nAreaEdificada
      from tmpiptucale;
   end if;

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
   tDemonstrativo := tDemonstrativo || RPAD(' AREA EDIFICADA '       , 55, '.') || ': ' || coalesce(round( nAreaEdificada, 2)::varchar,'')   || ' \n';
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
$$  language 'plpgsql';insert into db_versaoant (db31_codver,db31_data) values (359, current_date);
select setval ('db_versaousu_db32_codusu_seq',(select max (db32_codusu) from db_versaousu));
select setval ('db_versaousutarefa_db28_sequencial_seq',(select max (db28_sequencial) from db_versaousutarefa));
select setval ('db_versaocpd_db33_codcpd_seq',(select max (db33_codcpd) from db_versaocpd));
select setval ('db_versaocpdarq_db34_codarq_seq',(select max (db34_codarq) from db_versaocpdarq));create table bkp_db_permissao_20151016_155013 as select * from db_permissao;
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