insert into db_versao (db30_codver, db30_codversao, db30_codrelease, db30_data, db30_obs)  values (343, 3, 27, '2014-08-04', 'Tarefas: 88897, 89689, 92020, 94085, 94649, 94702, 94922, 95201, 95228, 95317, 95443, 95501, 95510, 95768, 95856, 95857, 95865, 95910, 95985, 96022, 96026, 96029, 96040, 96051, 96061, 96062, 96071, 96143, 96147, 96157, 96159, 96160, 96168, 96190, 96200, 96206, 96208, 96210, 96219, 96221, 96224, 96271, 96389, 96400, 96409, 96426, 96567, 96569, 96586, 96588, 96599, 96600, 96620, 96635, 96636, 96637, 96646, 96647, 96648, 96657, 96659, 96661, 96665, 96667, 96668, 96669, 96670, 96675, 96677, 96678, 96680, 96681, 96684, 96688, 96689, 96695, 96696, 96701, 96702, 96703, 96705, 96709, 96710, 96712, 96715, 96717, 96718, 96722, 96723, 96724, 96725, 96726, 96727, 96729, 96730, 96731, 96732, 96734, 96737, 96741, 96742, 96744, 96745, 96747, 96749, 96751, 96752, 96753, 96754, 96755, 96756, 96757, 96758, 96760, 96762, 96763, 96766, 96767');DROP VIEW if exists cadastro_portaria;
create view cadastro_portaria as
 SELECT rhpessoal.rh01_regist,
        cgm.z01_nome,
        portaria.h31_dtportaria,
        portaria.h31_numero,
        portaria.h31_anousu,
        portaria.h31_dtlanc,
        rhpessoal.rh01_numcgm,
        cgm.z01_ident,
        cgm.z01_ender,
        cgm.z01_numero,
        cgm.z01_compl,
        cgm.z01_bairro,
        cgm.z01_cep,
        cgm.z01_munic,
        rhpessoal.rh01_admiss,
        CASE rhregime.rh30_regime
            WHEN 1 THEN 'ESTATUTARIO'::text
            WHEN 2 THEN 'CLT'::text
            WHEN 3 THEN 'EXTRA QUADRO'::text
            ELSE NULL::text
        END AS rh30_regime,
        rhfuncao.rh37_descr,
        rhlocaltrab.rh55_descr,
        padroes.r02_descr,
        CASE WHEN substr(padroes.r02_descr::text, 1, 1) = 'P'::text
             THEN ''::text
             ELSE btrim( substr(padroes.r02_descr::text, 3, 2) )
        END AS r02_nivel,
        CASE WHEN substr(padroes.r02_descr::text, 1, 1) <> 'P'::text
             THEN ''::text
             ELSE btrim( split_part(padroes.r02_descr::text, '-'::text, 1) )
        END AS r02_padrao,
        CASE WHEN substr(padroes.r02_descr::text, 1, 1) <> 'P'::text
             THEN ''::text
             ELSE btrim( split_part(padroes.r02_descr::text, '-'::text, 2) )
        END AS r02_grau,
        CASE WHEN substr(padroes.r02_descr::text, 1, 1) = 'P'::text
             THEN ''::text
             ELSE btrim( substr(padroes.r02_descr::text, 6, 1))
        END AS r02_classe,
        tipoasse.h12_descr,
        btrim(portaria.h31_amparolegal) AS h31_amparolegal,
        assenta.h16_histor,
        assenta.h16_hist2,
        portariaproced.h40_descr,
        portariaenvolv.h42_descr,
        assenta.h16_dtconc,
        assenta.h16_quant,
        assenta.h16_dtterm,
        portaria.h31_portariatipo,
        f.rh37_descr AS h07_cant,
        rhpessoal.rh01_nasc,
        orcorgao.o40_descr,
        portaria.h31_dtinicio,
        portariaassinatura.rh136_nome,
        portariaassinatura.rh136_cargo,
        portariaassinatura.rh136_amparo
   FROM portaria
   JOIN portariaassenta         ON portaria.h31_sequencial         = portariaassenta.h33_portaria
   JOIN portariatipo            ON portariatipo.h30_sequencial     = portaria.h31_portariatipo
   JOIN portariaenvolv          ON portariaenvolv.h42_sequencial   = portariatipo.h30_portariaenvolv
   JOIN portariaproced          ON portariaproced.h40_sequencial   = portariatipo.h30_portariaproced
   JOIN assenta                 ON portariaassenta.h33_assenta     = assenta.h16_codigo
   JOIN tipoasse                ON assenta.h16_assent              = tipoasse.h12_codigo
   JOIN rhpessoal               ON assenta.h16_regist              = rhpessoal.rh01_regist
   JOIN cgm                     ON rhpessoal.rh01_numcgm           = cgm.z01_numcgm
   LEFT JOIN rhpessoalmov       ON rhpessoalmov.rh02_regist        = rhpessoal.rh01_regist
                               AND rhpessoalmov.rh02_anousu        = fc_anofolha(rhpessoalmov.rh02_instit)
                               AND rhpessoalmov.rh02_mesusu        = fc_mesfolha(rhpessoalmov.rh02_instit)
   JOIN rhfuncao                ON rhfuncao.rh37_funcao            = rhpessoal.rh01_funcao
                               AND rhfuncao.rh37_instit            = rhpessoalmov.rh02_instit
   LEFT JOIN rhlota             ON rhpessoalmov.rh02_lota          = rhlota.r70_codigo
                               AND rhpessoalmov.rh02_instit        = rhlota.r70_instit
   LEFT JOIN rhlotaexe          ON rhpessoalmov.rh02_anousu        = rhlotaexe.rh26_anousu
                               AND rhlota.r70_codigo               = rhlotaexe.rh26_codigo
   LEFT JOIN orcorgao           ON orcorgao.o40_anousu             = rhlotaexe.rh26_anousu
                              AND orcorgao.o40_orgao               = rhlotaexe.rh26_orgao
   LEFT JOIN rhregime           ON rhregime.rh30_codreg            = rhpessoalmov.rh02_codreg
                               AND rhregime.rh30_instit            = rhpessoalmov.rh02_instit
   LEFT JOIN rhpeslocaltrab     ON rhpeslocaltrab.rh56_seqpes      = rhpessoalmov.rh02_seqpes
                               AND rhpeslocaltrab.rh56_princ       = true
   LEFT JOIN rhlocaltrab        ON rhlocaltrab.rh55_codigo         = rhpeslocaltrab.rh56_localtrab
   LEFT JOIN rhpespadrao        ON rhpespadrao.rh03_seqpes         = rhpessoalmov.rh02_seqpes
   LEFT JOIN padroes            ON padroes.r02_anousu              = rhpessoalmov.rh02_anousu
                               AND padroes.r02_mesusu              = rhpessoalmov.rh02_mesusu
                               AND padroes.r02_regime              = rhregime.rh30_regime
                               AND btrim(padroes.r02_codigo::text) = btrim(rhpespadrao.rh03_padrao::text)
                               AND padroes.r02_instit              = rhpessoalmov.rh02_instit
   LEFT JOIN admissao           ON rhpessoal.rh01_regist           = admissao.h07_regist
   LEFT JOIN rhfuncao f         ON f.rh37_funcao                   = admissao.h07_cant::integer
                               AND f.rh37_instit                   = rhpessoalmov.rh02_instit
   LEFT JOIN flegal             ON flegal.h04_codigo               = admissao.h07_fundam
   LEFT JOIN concur             ON concur.h06_refer                = admissao.h07_refe
   LEFT JOIN areas              ON areas.h05_codigo                = admissao.h07_area
   LEFT JOIN portariaassinatura ON portaria.h31_portariaassinatura = portariaassinatura.rh136_sequencial;create or replace function fc_iptu_getaliquota_riopardo_2008(integer,integer,integer,boolean,integer,boolean) returns numeric as
$$
declare

    iMatricula         alias for $1;
    iIdbql             alias for $2;
    iNumcgm            alias for $3;
    bPredial           alias for $4;
    iAnousu            alias for $5;
    lRaise             alias for $6;

    nAliq              numeric default 0;

    iSetor             integer default 0;
    iCaract            integer default 0;
    iImoTerritoriais   integer default 0;
    iNumcalculos       integer default 0;

begin

  /* EXECUTAR SOMENTE SE NAO TIVER ISENCAO */
  if lRaise then
    raise notice 'DEFININDO QUAL ALIQUOTA APLICAR ...';
    raise notice 'IPTU : %', case when bPredial is true then 'PREDIAL' else 'TERRITORIAL' end;
  end if;

  if bPredial is true then

    select j73_aliq
      into nAliq
      from carconstr
           inner join caraliq    on j73_anousu = iAnousu
                                 and j73_caract = j48_caract
           left  join iptuconstr on j48_idcons = j39_idcons
                                 and j48_matric = j39_matric
      where j48_matric = iMatricula
        and j39_dtdemo is null
   order by j73_aliq
    limit 1;

  else
    nAliq := 3;
  end if;

--  raise notice 'nAliq: %', nAliq;

  perform fc_debug('Aliquota Final :'||nAliq,lRaise,false,false);

  execute 'update tmpdadosiptu set aliq = '||nAliq;

  return nAliq;

end;
$$ language 'plpgsql';create or replace function fc_parc_getselectorigens_atjuros(integer,integer,integer) returns varchar as
$$
declare

  iParcelamento      alias for $1;
  iTipo              alias for $2;
  iTipoAnulacao      alias for $3;

  iAnoUsu            integer default 0;

  dDataCorrecao      date;

  sCamposSql         varchar default '';
  sSqlRetorno        varchar default '';
  sSql               varchar default '';
  sCampoInicial      varchar default '';

  lRaise             boolean default false;


begin

  lRaise := ( case when fc_getsession('DB_debugon') is null then false else true end );

  iAnoUsu := cast( (select fc_getsession('DB_anousu')) as integer);
  if iAnoUsu is null then
    raise exception 'ERRO : Variavel de sessao [DB_anousu] nao encontrada.';
  end if;

  dDataCorrecao := cast( (select fc_getsession('DB_datausu')) as date);
  if dDataCorrecao is null then
    raise exception 'ERRO : Variavel de sessao [DB_datausu] nao encontrada.';
  end if;

  perform fc_debug(''                                                      ,lRaise,false,false);
  perform fc_debug('Processando funcao fc_parc_getselectorigens_atjuros...' ,lRaise,false,false);

  sCamposSql := ' distinct
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
                  k00_tipo,
                  k00_tipojm,
                  termo.v07_dtlanc,';

  perform fc_debug('Verificamos a Regra de Anulacao:'                                                                    ,lRaise,false,false);
  perform fc_debug('Regra de Anulacao da Regra de Parcelamento (cadtipoparc:k40_tipoanulacao): '||iTipoAnulacao          ,lRaise,false,false);
  perform fc_debug('Regra de Anulacao 1 ......: Utilizamos o valor do arreold (campo: k00_valor) como corrigido sem aplicar correcao',lRaise,false,false);
  perform fc_debug('Regra de Anulacao 2 e 3 ..: Aplicamos correcao (fc_corre) sobre o valor do arreold (campo: k00_valor)'           ,lRaise,false,false);

  if iTipoAnulacao = 1 then

    sCamposSql := sCamposSql || ' k00_valor as corrigido, \n';
    sCamposSql := sCamposSql || ' 0 as juros,             \n';
    sCamposSql := sCamposSql || ' 0 as multa              \n';

  else

    sCamposSql := sCamposSql || ' fc_corre(arreold.k00_receit,arreold.k00_dtvenc,arreold.k00_valor,\''||dDataCorrecao||'\','||iAnoUsu||',\''||dDataCorrecao||'\') as corrigido, \n';
    sCamposSql := sCamposSql || ' 0 as juros, \n';
    sCamposSql := sCamposSql || ' 0 as multa  \n';

  end if;

  if iTipo = 1 then

    perform fc_debug('Tipo de Parcelamento 1 - termodiv: '                                             ,lRaise,false,false);
    perform fc_debug('Sql busca os dados da termodiv, divida e arreold'                                ,lRaise,false,false);
    perform fc_debug('Valor corrigido varia de acordo com a Regra de Anulacao explicado anteriormente' ,lRaise,false,false);

    sSqlRetorno :=                ' select '||sCamposSql||                                                                                          '\n';
    sSqlRetorno := sSqlRetorno || '   from termo                                                                                                     \n';
    sSqlRetorno := sSqlRetorno || '        inner join termodiv  on termo.v07_parcel 	= termodiv.parcel                                              \n';
    sSqlRetorno := sSqlRetorno || '        inner join divida    on termodiv.coddiv   	= divida.v01_coddiv                                            \n';
    sSqlRetorno := sSqlRetorno || '        inner join arreold   on arreold.k00_numpre	= divida.v01_numpre and arreold.k00_numpar = divida.v01_numpar \n';
    sSqlRetorno := sSqlRetorno || '  where termo.v07_parcel = ' || iParcelamento ||                                                                 '\n';
    sSqlRetorno := sSqlRetorno || '  order by k00_dtoper,k00_dtvenc,k00_numpre, k00_numpar, k00_receit                                               \n';

  elsif iTipo = 2 then

    perform fc_debug('Tipo de Parcelamento 2 - termoreparc: ' ,lRaise,false,false);
    perform fc_debug('Sql busca os dados da termoreparc, termo, tabelas de origem do termo (termodiv, termoini, termodiver e termocontrib), arreold etc ' ,lRaise,false,false);
    perform fc_debug('Valor corrigido varia de acordo com a Regra de Anulacao explicado anteriormente' ,lRaise,false,false);

    sSqlRetorno := sSqlRetorno || '   select '||sCamposSql||'                                                         \n';
    sSqlRetorno := sSqlRetorno || '     from termoreparc                                                              \n';
    sSqlRetorno := sSqlRetorno || '          inner join termo on v07_parcel            = termoreparc.v08_parcelorigem \n';
    sSqlRetorno := sSqlRetorno || '          inner join arreold on arreold.k00_numpre  = termo.v07_numpre             \n';
    sSqlRetorno := sSqlRetorno || '   where termoreparc.v08_parcel = ' || iParcelamento ||                           '\n';

    sSqlRetorno := sSqlRetorno || ' union all \n';	-- tras os reparcelamentos de divida

    sSqlRetorno := sSqlRetorno || '   select '||sCamposSql||'                                                         \n';
    sSqlRetorno := sSqlRetorno || '     from termoreparc                                                              \n';
    sSqlRetorno := sSqlRetorno || '          inner join termo     on v07_parcel         = termoreparc.v08_parcel      \n';
    sSqlRetorno := sSqlRetorno || '          inner join termodiv  on termo.v07_parcel 	= termodiv.parcel             \n';
    sSqlRetorno := sSqlRetorno || '          inner join divida  	on termodiv.coddiv   	= divida.v01_coddiv           \n';
    sSqlRetorno := sSqlRetorno || '          inner join arreold 	on arreold.k00_numpre	= divida.v01_numpre           \n';
    sSqlRetorno := sSqlRetorno || '                              and arreold.k00_numpar = divida.v01_numpar           \n';
    sSqlRetorno := sSqlRetorno || '   where termoreparc.v08_parcel = ' || iParcelamento ||                           '\n';

  	sSqlRetorno := sSqlRetorno || ' union all \n';	-- tras os reparcelamentos do foro

    sSqlRetorno := sSqlRetorno || '   select '||sCamposSql||                                                               '\n';
    sSqlRetorno := sSqlRetorno || '     from termoreparc                                                                    \n';
    sSqlRetorno := sSqlRetorno || '          inner join termo         on v07_parcel                = termoreparc.v08_parcel \n';
    sSqlRetorno := sSqlRetorno || '          inner join termoini      on termo.v07_parcel 	       = termoini.parcel        \n';
    sSqlRetorno := sSqlRetorno || '          inner join inicialnumpre on inicialnumpre.v59_inicial = termoini.inicial       \n';
    sSqlRetorno := sSqlRetorno || '          inner join divida 	      on inicialnumpre.v59_numpre  = divida.v01_numpre      \n';
    sSqlRetorno := sSqlRetorno || '          inner join arreold 	    on arreold.k00_numpre        = divida.v01_numpre      \n';
	  sSqlRetorno := sSqlRetorno || '                                  and arreold.k00_numpar        = divida.v01_numpar      \n';
    sSqlRetorno := sSqlRetorno || '   where termoreparc.v08_parcel = ' || iParcelamento;

	  sSqlRetorno := sSqlRetorno || ' union all \n';	-- tras os reparcelamentos de diversos

    sSqlRetorno := sSqlRetorno || '   select '||sCamposSql||                                                              '\n';
    sSqlRetorno := sSqlRetorno || '     from termoreparc                                                                   \n';
    sSqlRetorno := sSqlRetorno || '          inner join termo         on v07_parcel             = termoreparc.v08_parcel   \n';
    sSqlRetorno := sSqlRetorno || '          inner join termodiver    on termo.v07_parcel 	 	  = termodiver.dv10_parcel   \n';
    sSqlRetorno := sSqlRetorno || '          inner join diversos      on diversos.dv05_coddiver = termodiver.dv10_coddiver \n';
    sSqlRetorno := sSqlRetorno || '          inner join arreold 	    on arreold.k00_numpre     = diversos.dv05_numpre     \n';
    sSqlRetorno := sSqlRetorno || '   where termoreparc.v08_parcel = ' || iParcelamento ||                                '\n';

	  sSqlRetorno := sSqlRetorno || ' union all \n';	-- tras os reparcelamentos de contribuicao de melhorias

    sSqlRetorno := sSqlRetorno || '   select '||sCamposSql||'                                                                          \n';
    sSqlRetorno := sSqlRetorno || '     from termoreparc                                                                               \n';
    sSqlRetorno := sSqlRetorno || '          inner join termo         on v07_parcel                = termoreparc.v08_parcel            \n';
    sSqlRetorno := sSqlRetorno || '          inner join termocontrib  on termo.v07_parcel          = termocontrib.parcel               \n';
    sSqlRetorno := sSqlRetorno || '          inner join contricalc    on contricalc.d09_sequencial = termocontrib.contricalc           \n';
    sSqlRetorno := sSqlRetorno || '          inner join arreold 	     on arreold.k00_numpre        = contricalc.d09_numpre            \n';
	  sSqlRetorno := sSqlRetorno || '          left  join divold  	     on arreold.k00_numpre        = divold.k10_numpre                \n';
    sSqlRetorno := sSqlRetorno || '                                  and arreold.k00_numpar        = divold.k10_numpar                 \n';
	  sSqlRetorno := sSqlRetorno || '                                  and arreold.k00_receit        = divold.k10_receita                \n';
    sSqlRetorno := sSqlRetorno || '   where ( divold.k10_numpre is null and divold.k10_numpar is null and divold.k10_receita is null ) \n';
	  sSqlRetorno := sSqlRetorno || '     and termoreparc.v08_parcel = ' || iParcelamento ||                                            '\n';
    sSqlRetorno := sSqlRetorno || '   order by k00_dtoper,k00_dtvenc,k00_numpre, k00_numpar, k00_receit                                \n';

  elsif iTipo = 3 then  -- parcelamento de inicial

    perform fc_debug('Tipo de Parcelamento 3 - termoini: '                                                                                      ,lRaise,false,false);
    perform fc_debug('Sql busca os dados da termo, termoini, inicialnumpre, inicialcert, certdiv, divida, arreold, arreoldcalc, certter, termo' ,lRaise,false,false);
    perform fc_debug('Valor corrigido varia de acordo com a Regra de Anulacao explicado anteriormente'                                          ,lRaise,false,false);

    sSqlRetorno :=                '  select '||sCamposSql||', inicial                                                       \n';
    sSqlRetorno := sSqlRetorno || '   from termo                                                                            \n';
    sSqlRetorno := sSqlRetorno || '        inner join termoini    	on termo.v07_parcel 	       = termoini.parcel          \n';
    sSqlRetorno := sSqlRetorno || '        inner join inicialnumpre on inicialnumpre.v59_inicial = termoini.inicial         \n';
  	sSqlRetorno := sSqlRetorno || '        inner join inicialcert   on termoini.inicial          = inicialcert.v51_inicial  \n';
	  sSqlRetorno := sSqlRetorno || '        inner join certdiv       on certdiv.v14_certid        = inicialcert.v51_certidao \n';
    sSqlRetorno := sSqlRetorno || '        inner join divida        on certdiv.v14_coddiv        = divida.v01_coddiv        \n';
    sSqlRetorno := sSqlRetorno || '        inner join arreold 	    on arreold.k00_numpre        = divida.v01_numpre        \n';
    sSqlRetorno := sSqlRetorno || '                               and arreold.k00_numpar         = divida.v01_numpar        \n';
    sSqlRetorno := sSqlRetorno || '  where termo.v07_parcel = ' || iParcelamento ||                                        '\n';
	  sSqlRetorno := sSqlRetorno || '  union                                                                                  \n';
    sSqlRetorno := sSqlRetorno || '   select '||sCamposSql||', inicial                                                      \n';
    sSqlRetorno := sSqlRetorno || '   from termo                                                                            \n';
    sSqlRetorno := sSqlRetorno || '        inner join termoini    	     on termo.v07_parcel 	  = termoini.parcel           \n';
    sSqlRetorno := sSqlRetorno || '        inner join inicialnumpre      on inicialnumpre.v59_inicial = termoini.inicial    \n';
	  sSqlRetorno := sSqlRetorno || '        inner join inicialcert        on termoini.inicial    = inicialcert.v51_inicial   \n';
	  sSqlRetorno := sSqlRetorno || '        inner join certter            on certter.v14_certid  = inicialcert.v51_certidao  \n';
    sSqlRetorno := sSqlRetorno || '        inner join termo termo_origem on termo_origem.v07_parcel = certter.v14_parcel    \n';
    sSqlRetorno := sSqlRetorno || '        inner join arreold 	         on arreold.k00_numpre	= termo_origem.v07_numpre   \n';
    sSqlRetorno := sSqlRetorno || '  where termo.v07_parcel = ' || iParcelamento ||                                        '\n';
    sSqlRetorno := sSqlRetorno || '  order by k00_dtoper,k00_dtvenc,k00_numpre, k00_numpar, k00_receit                      \n';

  elsif iTipo = 4 then -- parcelamento de diveros

    perform fc_debug('Tipo de Parcelamento 4 - termodiver: '                                           ,lRaise,false,false);
    perform fc_debug('Sql busca os dados da termo, termodiver, diversos e arreold'                     ,lRaise,false,false);
    perform fc_debug('Valor corrigido varia de acordo com a Regra de Anulacao explicado anteriormente' ,lRaise,false,false);

    sSqlRetorno :=                '   select '||sCamposSql ||                                                        '\n';
    sSqlRetorno := sSqlRetorno || '   from termo                                                                      \n';
    sSqlRetorno := sSqlRetorno || '        inner join termodiver on termo.v07_parcel       = termodiver.dv10_parcel   \n';
    sSqlRetorno := sSqlRetorno || '        inner join diversos   on diversos.dv05_coddiver = termodiver.dv10_coddiver \n';
    sSqlRetorno := sSqlRetorno || '        inner join arreold    on arreold.k00_numpre 	   = diversos.dv05_numpre     \n';
    sSqlRetorno := sSqlRetorno || '  where termo.v07_parcel = ' || iParcelamento ||                                  '\n';
    sSqlRetorno := sSqlRetorno || '  order by k00_dtoper,k00_dtvenc,k00_numpre, k00_numpar, k00_receit                \n';

  elsif iTipo = 5 then -- parcelamento de contribuicao de melhorias

    perform fc_debug('Tipo de Parcelamento 2 - termocontrib: '                                                             ,lRaise,false,false);
    perform fc_debug('Sql busca os dados da termo, termocontrib, contricalc e arreold, '                                   ,lRaise,false,false);
    perform fc_debug('havendo um left com a divold apenas para garantir que nao virao registros que sao oriundos da divida',lRaise,false,false);
    perform fc_debug('Valor corrigido varia de acordo com a Regra de Anulacao explicado anteriormente'                     ,lRaise,false,false);

    sSqlRetorno :=                '   select '||sCamposSql ||                                                                         '\n';
    sSqlRetorno := sSqlRetorno || '   from termo                                                                                       \n';
    sSqlRetorno := sSqlRetorno || '        inner join termocontrib on termo.v07_parcel          = termocontrib.parcel                  \n';
    sSqlRetorno := sSqlRetorno || '        inner join contricalc   on contricalc.d09_sequencial = termocontrib.contricalc              \n';
    sSqlRetorno := sSqlRetorno || '        inner join arreold	  	 on arreold.k00_numpre        = contricalc.d09_numpre                \n';
		-- left com divold porque o numpre da contricalc pode estar na arreold tanto por parcelamento como por importacao de divida mais como o que interessa e so os
		-- registros referente ao parcelamento dou um left com divold para garantir que nao vira registros que sao oriundos da divida
	  sSqlRetorno := sSqlRetorno || '        left  join divold       on arreold.k00_numpre        = divold.k10_numpre                    \n';
    sSqlRetorno := sSqlRetorno || '                               and arreold.k00_numpar        = divold.k10_numpar                    \n';
    sSqlRetorno := sSqlRetorno || '                               and arreold.k00_receit        = divold.k10_receita                   \n';
    sSqlRetorno := sSqlRetorno || '   where ( divold.k10_numpre is null and divold.k10_numpar is null and divold.k10_receita is null ) \n';
    sSqlRetorno := sSqlRetorno || '     and termo.v07_parcel = ' || iParcelamento ||                                                  '\n';
    sSqlRetorno := sSqlRetorno || '   order by k00_dtoper,k00_dtvenc,k00_numpre, k00_numpar, k00_receit                                \n';

  end if;

  if iTipoAnulacao <> 1 then

    perform fc_debug('Tipo de Anulacao '||iTipoAnulacao||', retornamos o sql com calculo do juro e multa em cima do valor corrigido'  ,lRaise,false,false);

    sSql = sSqlRetorno;

    if iTipo = 3 then -- adiciona o numero da inicial aos campos da query quando parcelamento de inicial
      sCampoInicial := ' , inicial \n';
    end if;

    sSqlRetorno := '';
    sSqlRetorno := sSqlRetorno||'select distinct        \n';
    sSqlRetorno := sSqlRetorno||'       x.k00_numcgm,   \n';
    sSqlRetorno := sSqlRetorno||'       x.k00_dtoper,   \n';
    sSqlRetorno := sSqlRetorno||'       x.k00_receit,   \n';
    sSqlRetorno := sSqlRetorno||'       x.k00_hist,     \n';
    sSqlRetorno := sSqlRetorno||'       x.k00_valor,    \n';
    sSqlRetorno := sSqlRetorno||'       x.k00_dtvenc,   \n';
    sSqlRetorno := sSqlRetorno||'       x.k00_numpre,   \n';
    sSqlRetorno := sSqlRetorno||'       x.k00_numpar,   \n';
    sSqlRetorno := sSqlRetorno||'       x.k00_numtot,   \n';
    sSqlRetorno := sSqlRetorno||'       x.k00_numdig,   \n';
    sSqlRetorno := sSqlRetorno||'       x.k00_tipo,     \n';
    sSqlRetorno := sSqlRetorno||'       x.k00_tipojm,   \n';
    sSqlRetorno := sSqlRetorno||'       x.corrigido,    \n';
    sSqlRetorno := sSqlRetorno||'       ( x.corrigido * coalesce( fc_juros(x.k00_receit,x.k00_dtvenc,\''||dDataCorrecao||'\',\''||dDataCorrecao||'\',false,'||iAnoUsu||'),0)) as juros, \n';
    sSqlRetorno := sSqlRetorno||'       ( x.corrigido * coalesce( fc_multa(x.k00_receit,x.k00_dtvenc,\''||dDataCorrecao||'\',x.k00_dtoper,'||iAnoUsu||'),0)) as multa                   \n';
    sSqlRetorno := sSqlRetorno||'       '||sCampoInicial||' \n';
    sSqlRetorno := sSqlRetorno||'  from ( '||sSql||' ) as x \n';
    sSqlRetorno := sSqlRetorno||' order by k00_dtoper,k00_dtvenc,k00_numpre, k00_numpar, k00_receit\n';

  end if;

  return sSqlRetorno;

end;
$$  language 'plpgsql';insert into db_versaoant (db31_codver,db31_data) values (343, current_date);
select setval ('db_versaousu_db32_codusu_seq',(select max (db32_codusu) from db_versaousu));
select setval ('db_versaousutarefa_db28_sequencial_seq',(select max (db28_sequencial) from db_versaousutarefa));
select setval ('db_versaocpd_db33_codcpd_seq',(select max (db33_codcpd) from db_versaocpd));
select setval ('db_versaocpdarq_db34_codarq_seq',(select max (db34_codarq) from db_versaocpdarq));insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),343,4342,'A partir desta versão está implementada uma nova funcionalidade que contempla o envio de pagamentos via transmissão eletrônica de dados no formato OBN.
O processo de pagamentos via agenda (Manutenção de Pagamentos), não sofrerá grandes modificações, salvo a adição do procedimento de configuração de envio implementado entre a atualização de um movimento na forma \"TRA\" e a efetiva geração do arquivo txt.
Neste procedimento, será possível:
   - definir se o movimento será enviado ao banco no formato OBN ou CNAB240;
   - fazer leitura de códigos de barras para faturas/boletos constantes nas ordens de pagamento (somente para o formato OBN).
As demais etapas do processo de pagamentos, permanecerão inalteradas em suas características.
É importante informar que serão necessários alguns envios prévios como teste em cada localidade nos novos arquivos no formato OBN, e nos primeiros envios será normal ocorrerem inconsistências até que o uso da rotina se estabilize. 
Em primeiro momento, as permissões do menu que ativa o OBN estarão desabilitadas, ficando a decisão do uso a cargo do administrador do sistema sob a orientação do suporte técnico.','2014-08-01','Mensagem para usuários Financeiro - Formato OBN.');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8326,95865);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),343,9956,'A partir desta versão será disponibilizada a inclusão de informações referentes a Doenças Epidemiológicas no Campo: Agravo.
A função será registrar todos os atendimentos que os pacientes apresentarem sintomas de doenças epidemiológicas.
A inclusão dessas informações irá gerar relatório, que servirá para notificar a Vigilância Sanitária.','2014-08-01','95317
Agravo');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8328,95865);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),343,4737,'Criado parágrafo para a observação Aluno Aprovado pelo Conselho, registrada nos relatórios que exibem o resultado final do aluno (aprovado ou reprovado). A observação poderá ser alterada ou deletada, para que a observação não conste nos relatórios.','2014-08-04','Configuração > Procedimentos >Manutenção de Documentos / Parágrafos ');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8332,95865);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),343,5238,'Emissão do Termo de Rescisão sem efetuar cálculo financeiro, para cálculo zerado e sem a informação de rubricas.','2014-08-01','A partir desta release o sistema permite a emissão de Termo de rescisão, com cálculo zerado e sem a informação de rubricas.');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8319,95865);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),343,5572,'Exibição do total de dias da grade de tempo de serviço detalhado por ano, mês e dias.','2014-08-01','77342 - Na grade de tempo de serviço conste também a informação de ano, mês e dias.');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8323,95865);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),343,5036,'Inserção de botão de atalho para a tela de Consulta Financeira.','2014-08-01','Cálculo Financeiro - Ter a opção de calcular mais de um ponto ao mesmo tempo.
');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8325,95865);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),343,4355,'Inserção de novo campo no cadastro de servidor - Tipo de Reajuste: (Paridade ou Real)
 Obs.: Este campo será exibido somente para servidores Inativos ou Pensionistas. ','2014-08-01','Paridade e Real, no cadastro de servidor incluir campo p/ informar o tipo de paridade, criar relatório..');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8321,95865);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),343,5493,'Inserção de novo filtro para Reajuste Salarial - Tipo de Reajuste (Real ou Paridade).  E na consulta de servidor por Matrícula agora é possível adicionar novos filtros, como: Cargo, Tipo de Regime e Lotação. ','2014-08-01','Tarefa 73953 - Rotina de ajuste salarial incluir filtro para seleção por tipo de paridade.');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8324,95865);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),343,9645,'Na tela de lançamento das avaliações, opção Alterar Resultado Final, selecionar o aluno e a Forma de Aprovação aprovado pelo conselho. No campo Alterar Nota Final
Quando selecionada a opção Não informar, o sistema irá aprovar o aluno e lançar a observação aprovado pelo conselho nos relatórios, conforme comportamento antes desta melhoria.
Na opção Informar e Substituir, o lançamento de nova nota será obrigatório e irá substituir a nota do aluno nos relatórios e consultas.
Na opção Informar e Não substituir o lançamento da nova nota será obrigatório, mas apenas registrará a nota do aluno nas observações dos relatórios finais do aluno, sem substituí-la.','2014-08-01','94085
A partir desta versão, o sistema permitirá alterar e substituir a nota final do aluno, quando o mesmo for aprovado pelo conselho de classe.');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8331,95865);

create table bkp_db_permissao_20140804_165958 as select * from db_permissao;
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