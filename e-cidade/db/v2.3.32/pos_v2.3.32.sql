insert into db_versao (db30_codver, db30_codversao, db30_codrelease, db30_data, db30_obs)  values (348, 3, 32, '2014-12-01', 'Tarefas: 79243, 84601, 94444, 97158, 97167, 97176, 97196, 97197, 97198, 97200, 97201, 97202, 97203, 97204, 97206, 97207, 97209, 97210, 97211, 97212, 97214, 97215, 97217, 97218, 97219, 97220, 97221, 97222, 97223, 97224, 97225, 97227, 97228, 97230, 97234, 97236, 97237, 97238, 97241, 97242, 97243, 97244, 97245, 97246, 97247, 97249, 97251, 97252, 97253, 97254, 97255, 97256, 97257, 97258, 97259, 97265, 97266, 97267, 97268, 97269, 97270, 97271, 97272, 97274, 97276, 97277, 97278, 97281, 97282, 97283, 97284, 97285, 97286, 97287, 97288, 97289, 97290, 97291, 97292, 97295, 97298, 97299, 97300, 97301, 97304, 97306, 97309, 97311, 97313, 97314, 97315, 97316, 97318, 97323, 97324, 97326, 97327, 97328, 97329, 97330, 97331, 97332, 97333, 97335, 97336, 97340');create or replace function fc_saldo_item_estoque(integer, integer)
returns numeric
as $$
  declare

   nSaldo numeric default 0;
   iCodigoDepartamento alias for $1;
   iCodigoMaterial     alias for $2;

 begin

    select coalesce(sum(case when m81_tipo = 1 then m82_quant when m81_tipo = 2 then m82_quant * -1  else 0 end), 0)
      into nSaldo
      from matestoqueinimei
           inner join matestoqueini  on m82_matestoqueini  = m80_codigo
           inner join matestoqueitem on m82_matestoqueitem = m71_codlanc
           inner join matestoquetipo on m81_codtipo        = m80_codtipo
           inner join matestoque     on m71_codmatestoque  = m70_codigo
     where m70_coddepto    = iCodigoDepartamento
       and m70_codmatmater = iCodigoMaterial;

    return nSaldo;

  end;
$$ language 'plpgsql';create or replace function fc_matestoqueinimei_inc()
  returns trigger as
$$

declare

  nPrecoMedio                    numeric default 0;
  iMaterial                      integer;
  iInstituicao                   integer;
  nValorEstoque                  numeric;
  nQuantidadeEstoque             numeric default 0;
  iTipoMovimento                 integer;
  iCodigoEstoque                 integer;
  iCodigoMovimento               integer;
  nValorUnitario                 numeric default 0;
  dtMovimento                    date;
  tHora                          timestamp;
  tHoraMovimento                 time;
  lTemPrecoMedio                 boolean default false;
  nQuantidadeMovimento           numeric default 0;
  rValoresAnterior               record;
  rValoresPosteriores            record;
  lServico                       boolean default false;
  iDepto                         integer;
  nQuantidadeSaidasPosteriores   numeric default 0;
  nQuantidadeEntradasPosteriores numeric default 0;
  nSaidasNoPeriodo               numeric default 0;
  nSaldoNoPeriodo                numeric default 0;
  nSaldoAposPeriodo              numeric default 0;
  sMensagemEstoque               varchar;
  lEntradaAposPeriodo            boolean default false;
begin

   iInstituicao = fc_getsession('DB_instit');
   if iInstituicao is null then
     raise exception 'Instituicao nao informada.';
   end if;


   /**
    * Consultamos o tipo da movimentacao
    */
   select m80_codtipo,
          m81_tipo,
          to_timestamp(m80_data || ' ' || m80_hora, 'YYYY-MM-DD HH24:MI:SS'),
          m80_data,
          m80_hora,
          m80_coddepto,
          instit,
          m70_codmatmater
          m71_servico
     into iCodigoMovimento,
          iTipoMovimento,
          tHora,
          dtMovimento,
          tHoraMovimento,
          iDepto,
          iInstituicao,
          iMaterial,
          lServico
     from matestoqueini
          inner join matestoquetipo on m81_codtipo = m80_codtipo
          inner join DB_DEPART on m80_coddepto     = coddepto
          inner join matestoqueinimei on m80_codigo = m82_matestoqueini
          inner join matestoqueitem   on m82_matestoqueitem = m71_codlanc
          inner join matestoque       on m71_codmatestoque  = m70_codigo
    where m80_codigo = NEW.m82_matestoqueini;

    /**
     * verifica se existe saldo no estoque para realizar a operacao (saldo cronologico.)
     * pois usuario pode retornar a data, termos uma saida do material antes de termos a entrada.....
     */
   raise notice 'codigo: % Hora: %', new.m82_codigo, tHora;
   if iTipoMovimento = 2 and lServico = false then

     raise notice 'tipo Movimento:% Operacao:%, Servico:%',iTipoMovimento, TG_OP,lServico;

      /**
       * percorremos todo a movimentação do estoque posterior a data do movimento
       */
      for rValoresAnterior in select m82_quant,
                          m81_tipo,
                          to_timestamp(m80_data || ' ' || m80_hora, 'YYYY-MM-DD HH24:MI:SS') as dtmov
                     from matestoque
                          inner join db_depart        on m70_coddepto       = coddepto
                          inner join matestoqueitem   on m70_codigo         = m71_codmatestoque
                          inner join matestoqueinimei on m82_matestoqueitem = m71_codlanc
                          inner join matestoqueini    on m82_matestoqueini  = m80_codigo
                          inner join matestoquetipo   on m81_codtipo        = m80_codtipo
                    where instit           = iInstituicao
                     and m70_codmatmater  = iMaterial
                     and m70_coddepto     = iDepto
                     and m82_codigo       <> new.m82_codigo
                     and m81_tipo    in(1, 2)
                     and to_timestamp(m80_data || ' ' || m80_hora, 'YYYY-MM-DD HH24:MI:SS') < tHora
                    order by to_timestamp(m80_data || ' ' || m80_hora, 'YYYY-MM-DD HH24:MI:SS')

     loop

       raise notice 'Tipo: %, Quantidade:%',rValoresAnterior.m81_tipo,  rValoresAnterior.m82_quant;
       /**
        * Abatemos o valor do estoque do saldo no periodo, caso nao tenha nenhuma entrada, pois
        */
       if rValoresAnterior.m81_tipo = 1 then
         nQuantidadeEstoque = nQuantidadeEstoque + rValoresAnterior.m82_quant;
       elsif rValoresAnterior.m81_tipo = 2 then
         nQuantidadeEstoque = nQuantidadeEstoque - rValoresAnterior.m82_quant;
       end if;
     end loop;
     raise notice 'Antes No periodo: %, saidas no periodo:%', nQuantidadeEstoque, nSaidasNoPeriodo;
     nSaldoNoPeriodo    = nQuantidadeEstoque -  new.m82_quant;
     raise notice 'No periodo: %, apos Periodo:%', nSaldoNoPeriodo, nSaldoAposPeriodo;
     if (nSaldoNoPeriodo < 0 or nSaldoAposPeriodo  < 0) and lServico is false then


        raise exception 'Saldo total não disponível nesta data (%). Saldo disponivel: %. Servico: %',
                         to_char(dtMovimento, 'DD/MM/YYYY'),
                         nQuantidadeEstoque - nSaidasNoPeriodo, lServico;

     end if;
  end if;


  perform fc_calculaprecomedio(NEW.m82_codigo::integer,
                               NEW.m82_matestoqueini::integer,
                               NEW.m82_quant, false);


    for rValoresPosteriores in select matestoqueinimei.*
	                             from matestoqueitem
	                                  inner join matestoqueinimei on m82_matestoqueitem = m71_codlanc
	                                  inner join matestoqueini    on m80_codigo         = m82_matestoqueini
	                                  inner join matestoque       on m71_codmatestoque  = m70_codigo
	                                  inner join db_depart        on m70_coddepto       = coddepto
	                            where m70_codmatmater  = iMaterial
	                             and instit            = iInstituicao
	                             and to_timestamp(m80_data || ' ' || m80_hora, 'YYYY-MM-DD HH24:MI:SS') > tHora
	                           order by  to_timestamp(m80_data || ' ' || m80_hora, 'YYYY-MM-DD HH24:MI:SS')
	loop

	  perform fc_calculaprecomedio(rValoresPosteriores.m82_codigo::integer,
                                   rValoresPosteriores.m82_matestoqueini::integer,
                                   rValoresPosteriores.m82_quant, false);
    end loop;

    /**
     * verifica se existe saldo no estoque para realizar a operacao (saldo cronologico.)
     * pois usuário pode retornar a data, termos uma saida do material antes de termos a entrada.....
     */

    if iTipoMovimento = 2 and TG_OP = 'INSERT' and lServico = false then

      /**
       * percorremos todo a movimentação do estoque posterior a data do movimento
       */
      for rValoresPosteriores in select m82_quant,
                          m81_tipo,
                          to_timestamp(m80_data || ' ' || m80_hora, 'YYYY-MM-DD HH24:MI:SS') as dtmov
                     from matestoque
                          inner join db_depart        on m70_coddepto       = coddepto
                          inner join matestoqueitem   on m70_codigo         = m71_codmatestoque
                          inner join matestoqueinimei on m82_matestoqueitem = m71_codlanc
                          inner join matestoqueini    on m82_matestoqueini  = m80_codigo
                          inner join matestoquetipo   on m81_codtipo        = m80_codtipo
                    where instit           = iInstituicao
                     and m70_codmatmater  = iMaterial
                     and m70_coddepto     = iDepto
                     and m81_tipo    in(1, 2)
                     and to_timestamp(m80_data || ' ' || m80_hora, 'YYYY-MM-DD HH24:MI:SS') > tHora
                    order by to_timestamp(m80_data || ' ' || m80_hora, 'YYYY-MM-DD HH24:MI:SS')
                                  limit 1
     loop

       if rValoresPosteriores.m81_tipo = 1 then
         lEntradaAposPeriodo := true;
       end if;
       /**
        * Abatemos o valor do estoque do saldo no periodo, caso nao tenha nenhuma entrada, pois
        */
       if rValoresPosteriores.m81_tipo = 2 and lEntradaAposPeriodo = false then
         nSaidasNoPeriodo = nSaidasNoPeriodo + rValoresPosteriores.m82_quant;
       elsif rValoresPosteriores.m81_tipo = 2 and lEntradaAposPeriodo = true then
         nSaldoAposPeriodo = nSaldoAposPeriodo - rValoresPosteriores.m82_quant;
       else
         nSaldoAposPeriodo = nSaldoAposPeriodo + rValoresPosteriores.m82_quant;
       end if;
     end loop;

     nSaldoNoPeriodo    = nQuantidadeEstoque - nSaidasNoPeriodo - NEW.m82_quant;
     if (nSaldoNoPeriodo < 0 or nSaldoAposPeriodo  < 0) and lServico is false  then


        raise exception 'Saldo total não disponível nesta data (%). Saldo disponível: %. Servico: %',
                         to_char(dtMovimento, 'DD/MM/YYYY'),
                         nQuantidadeEstoque - nSaidasNoPeriodo, lServico;

     end if;
  end if;
  return new;
end;
$$
language 'plpgsql';
drop TRIGGER if exists "tg_matestoqueinimei_inc" on matestoqueinimei;
CREATE TRIGGER "tg_matestoqueinimei_inc" after  update or insert ON "matestoqueinimei" FOR EACH ROW EXECUTE PROCEDURE "fc_matestoqueinimei_inc" ();/**
 * Trigger Para a validação do saldo no material dentro de um departamento
 * @author Matheus Felini <matheus.felini@dbseller.com.br>
 */
create or replace function fc_saldoestoque_trigger()
returns trigger
as $$
  declare
   nSaldo              numeric default 0;
   iCodigoDepartamento integer;
   iCodigoMaterial     INTEGER ;
   iTipoMovimentacao   integer;
   dtMovimento date;
 begin

    select m81_tipo,
           m80_data
      into iTipoMovimentacao,
           dtMovimento
      from matestoqueini
           inner join matestoquetipo on m81_codtipo = m80_codtipo
     where m80_codigo = new.m82_matestoqueini;

     select m70_codmatmater,
           m70_coddepto
      into iCodigoMaterial,
           iCodigoDepartamento
      from matestoqueitem
           inner join matestoque on matestoque.m70_codigo = m71_codmatestoque
     where m71_codlanc = new.m82_matestoqueitem;

    select coalesce(sum(case when m81_tipo = 1 then m82_quant when m81_tipo = 2 then m82_quant * -1  else 0 end), 0)
      into nSaldo
      from matestoqueinimei
           inner join matestoqueini  on m82_matestoqueini  = m80_codigo
           inner join matestoqueitem on m82_matestoqueitem = m71_codlanc
           inner join matestoquetipo on m81_codtipo        = m80_codtipo
           inner join matestoque     on m71_codmatestoque  = m70_codigo
     where m70_coddepto    = iCodigoDepartamento
       and m70_codmatmater = iCodigoMaterial;

    if iTipoMovimentacao = 2 and nSaldo - new.m82_quant < 0 then

        raise exception 'Saldo total não disponível nesta data (%). Saldo disponível: %',
                         to_char(dtMovimento, 'DD/MM/YYYY'),
                         nSaldo;
    end if;

    return new;

  end;
$$ language 'plpgsql';

drop   trigger if exists tg_saldoestoque_inc_alt on matestoqueinimei;
create trigger tg_saldoestoque_inc_alt before INSERT or UPDATE on matestoqueinimei for each row execute procedure fc_saldoestoque_trigger();SET check_function_bodies TO off;
create or replace function fc_agua_calculaconsumo() returns trigger as 
$$
declare
  iAno             integer;
  iMes             integer;
  iMatric          integer;
  iRegraSituacao   integer := 0;
  iMeses           integer := 0;
  nLeitura         float8  := 0;
  nConsumo         float8  := 0;
  nConsumoTotal    float8  := 0;
  nConsumoAnterior float8  := 0;
  nUltimaLeitura   float8  := 0;
  nConsumoMaximo   float8  := 0;
  nConsumoPadrao   float8  := 0;
  nExcesso         float8  := 0;
  nSaldo           float8  := 0;
  sOperacao        text    := '';
  iIdOcor          integer;
  iIdOcorMatric    integer;
  iCodLeitura      integer;
  lVirouHidrometro boolean;
  iQtdDigitosHidro integer;
  sDigitosHidro    text;
  iResidencial     integer;
begin
  sOperacao := upper(TG_OP);
  
  if (sOperacao = 'DELETE') then
    --raise exception 'Nao é permitido executar % na tabela %', sOperacao, TG_RELNAME;
    return old;
  end if;

  -- Trata UPDATE
  if sOperacao = 'UPDATE' then
    if (new.x21_leitura = old.x21_leitura) and 
       (new.x21_consumo <> old.x21_consumo or 
        new.x21_excesso <> old.x21_excesso or 
        new.x21_saldo   <> old.x21_saldo) then
        
      return new;
    end if;
    iCodLeitura := old.x21_codleitura;
  end if;
  
  -- Se estiver incluindo uma Leitura que nao for manual 
  -- ou que seja inativa entao nao processa o calculo do 
  -- consumo/excesso
  if new.x21_status <> 1 or new.x21_tipo = 2 then
    return new;
  end if;
  
  iAno := new.x21_exerc;
  iMes := new.x21_mes;
  
  select x04_matric,
         x04_qtddigito
    into iMatric,
         iQtdDigitosHidro
    from aguahidromatric
   where x04_codhidrometro = new.x21_codhidrometro;
  
  lVirouHidrometro := new.x21_virou; 
  
  if fc_agua_hidrometroativo(new.x21_codhidrometro) = 'f' then
    raise exception 'Hidrometro % da matricula % nao esta ativo', new.x21_codhidrometro, iMatric;
  end if;
  
  nLeitura := new.x21_leitura;
  
  -- Verifica Consumo Maximo para a Matricula especificada
  nConsumoPadrao := coalesce(fc_agua_consumomaximo(iAno, iMes, iMatric), 0);
  
  -- Verifica a nao existencia de leituras anteriores (regra 1 de aguasitleitura)
  iMeses := fc_agua_mesesultimaleitura(iAno, iMes, iMatric, iCodLeitura);
  
  if iMeses > 0 then
    nConsumoMaximo := nConsumoPadrao * iMeses;
  else
    nConsumoMaximo := nConsumoPadrao;
  end if;
  
  -- Busca regra para calculo do consumo
  select x17_regra
    into iRegraSituacao
    from aguasitleitura
   where x17_codigo = new.x21_situacao;
  
  if sOperacao = 'UPDATE' then
    -- Acumula consumo anterior, caso ja exista alguma leitura no mes
    nConsumoAnterior := fc_agua_consumo(iAno, iMes, iMatric, old.x21_codleitura);
    nUltimaLeitura := coalesce(fc_agua_leituraanterior(iMatric, old.x21_codleitura), 0);
  else
    -- Acumula consumo anterior, caso ja exista alguma leitura no mes
    nConsumoAnterior := fc_agua_consumo(iAno, iMes, iMatric);
    nUltimaLeitura := coalesce(fc_agua_ultimaleitura(iMatric, iAno, iMes), 0);
  end if;
  
  -- Verifica se leitura atual eh menor que anterior, e se hidrometro nao virou
  -- observando se a regra da situacao nao eh a 2=CANCELADA (caso de troca de hidrometro)  
  
  if (nLeitura < nUltimaLeitura) and (iRegraSituacao <> 2) and (new.x21_tipo <> 3) then
    
    if lVirouHidrometro is false then
      raise exception 'Leitura atual (%) menor que anterior (%)', nLeitura, nUltimaLeitura;
    end if;
  end if;
  
  if (nLeitura < nUltimaLeitura) and (new.x21_tipo = 3) then
  
    lVirouHidrometro := true; 
  end if;
  
  iResidencial = fc_agua_existecaract(iMatric, 5001);
  --
  -- Regra = 0  LEITURA NORMAL Sem Virar Relógio do Hidrômetro 
  -- . Efetua Procedimentos de Calculo de Consumo e Excesso
  --
  if iRegraSituacao = 0 and lVirouHidrometro is false then
    nConsumo      := nLeitura - nUltimaLeitura;
    nConsumoTotal := nConsumo + nConsumoAnterior;
    
    nExcesso := nConsumoTotal - nConsumoMaximo;
    
    if nConsumoTotal > nConsumoMaximo then
    
      nConsumo := nConsumo - nExcesso;
      
    elsif nConsumoTotal < nConsumoMaximo and iResidencial is not null then
    
      nSaldo   := nConsumoMaximo - nConsumo;
    
    end if;
    
  --
  -- Regra = 0  LEITURA NORMAL Virando Relógio do Hidrômetro 
  -- . Efetua Procedimentos de Calculo de Consumo e Excesso
  --
  elsif iRegraSituacao = 0 and lVirouHidrometro is true then
    
    if iQtdDigitosHidro is null or iQtdDigitosHidro = 0 then
      raise exception 'Hidrometro % da matricula % nao esta com o campo DIGITOS devidamente configurado', new.x21_codhidrometro, iMatric;
    end if;
    
    sDigitosHidro := repeat('9', abs(iQtdDigitosHidro));
    nConsumo      := cast(sDigitosHidro as float8) - nUltimaLeitura + nLeitura;
    nConsumoTotal := nConsumo + nConsumoAnterior;
  
    nExcesso := nConsumoTotal - nConsumoMaximo;
    
    if nConsumoTotal > nConsumoMaximo then
    
      nConsumo := nConsumo - nExcesso;
      
    elsif nConsumoTotal < nConsumoMaximo and iResidencial is not null then
    
      nSaldo   := nConsumoMaximo - nConsumo;
      
    end if;
    
  --
  -- Regra = 1  SEM LEITURA
  -- . Nao Efetua Procedimentos de Calculo de Consumo e Excesso,
  --   repetindo a leitura anterior e atribuindo consumo padrao e Excesso = 0
  --
  elsif iRegraSituacao = 1 then
  
    nConsumo        := nConsumoPadrao;
    new.x21_leitura := nUltimaLeitura;
    nExcesso        := 0;
  elsif iRegraSituacao = 3 then
    
    nConsumo        := nConsumoPadrao;
    new.x21_leitura := nUltimaLeitura;
    nExcesso        := 0;
    
    if iResidencial is not null then
      nSaldo        := nConsumoPadrao;
    end if;
    
  end if;
  
  --Sistema deve dar saldo apartir de 01/04/2011
  if (nSaldo < 0) or (new.x21_exerc = 2011 and new.x21_mes < 4) or (new.x21_exerc < 2011 and new.x21_mes > 0) then
    nSaldo := 0;
  end if;
  
  raise info 'aaaaa';
  perform fc_agua_calculasaldo(iAno, iMes, iMatric, new.x21_codleitura, nExcesso, true);
  
  new.x21_consumo := nConsumo;
  new.x21_excesso := nExcesso;
  new.x21_saldo   := nSaldo;
  
  if sOperacao = 'UPDATE' then
    
    if ((new.x21_leitura <> old.x21_leitura) and new.x21_tipo <> 3) then
    
      iIdOcor       := nextval('histocorrencia_ar23_sequencial_seq');
      iIdOcorMatric := nextval('histocorrenciamatric_ar25_sequencial_seq');
    
      insert into histocorrencia  
      (ar23_sequencial, ar23_id_usuario, ar23_instit, ar23_modulo, ar23_id_itensmenu, ar23_data , ar23_hora, ar23_tipo, ar23_descricao, ar23_ocorrencia)
      values
      (iIdOcor, cast(fc_getsession('DB_id_usuario') as integer), cast(fc_getsession('DB_instit') as integer), cast(fc_getsession('DB_modulo') as integer), cast(fc_getsession('DB_itemmenu_acessado') as integer), TO_DATE(fc_getsession('DB_datausu'), 'YYYY-MM-DD'), TO_CHAR(CURRENT_TIMESTAMP, 'HH24:MI'), 2, 'ALTERAÇAÕ DE LEITURA', 'Alterado a leitura do mês '||iMes||'/'||iAno||' de '||old.x21_leitura||' para '||new.x21_leitura||', sendo recalculado o excesso e a compensação.');
       
      insert into histocorrenciamatric
      (ar25_sequencial, ar25_matric, ar25_histocorrencia)
      values
      (iIdOcorMatric, iMatric, iIdOcor);
    
    end if;
  end if;
  
  return new;
end;
$$
language 'plpgsql';


drop trigger tr_agua_calculaconsumo on agualeitura;

create trigger tr_agua_calculaconsumo 
before insert or update or delete
on agualeitura for each row 
execute procedure fc_agua_calculaconsumo();create or replace function fc_baixabanco( cod_ret integer, datausu date) returns varchar as
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
  iNumpreAnterior           integer default 0;

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

--if R_IDRET.numpre = 11479037 and R_IDRET.numpar = 2 THEN
-- lRaise = true;
--ELSE
--  lRaise = false;
--END IF;

      if lRaise is true then
        perform fc_debug('  <BaixaBanco>  - codret : '||r_codret.codret||'-idret : '||r_codret.idret,lRaise,false,false);
      end if;

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

$$ language 'plpgsql';drop function fc_calculoiptu(integer,integer,boolean,boolean,boolean,boolean,boolean,text[]);
create or replace function fc_calculoiptu(integer,integer,boolean,boolean,boolean,boolean,boolean,text[]) returns varchar(100) as
$$

declare

   iMatricula 	  	  alias   for $1;
   iAnousu    	  	  alias   for $2;
   bGerafinanc        alias   for $3;
   bAtualizap	 	  	  alias   for $4;
   bNovonumpre	  	  alias   for $5;
   bCalculogeral   	  alias   for $6;
   bDemo		       	  alias   for $7;
   aParametrosFinais  alias   for $8;

   iCodFuncao       integer default 0;
   iCodCli          integer default 0;
   iTotPos          integer default 0;
   iInd             integer default 0;
   iTotparametros   integer default 0;

   aParam           text[3];
   tRes             text;
   tRetorno         text default '';
   tRetornoCalc     text default '';

   rCfiptu          record;

   lRaise           boolean default false;

begin

	lRaise  := ( case when fc_getsession('DB_debugon') is null then false else true end );

  select j18_db_sysfuncoes
    into iCodFuncao
    from cfiptu
   where j18_anousu = iAnousu;

  if not found then
    return 'CALCULO INDISPONIVEL PARA O ANO DE '||iAnousu;
  end if;

  select db21_codcli
    into iCodCli
    from db_config
   where prefeitura is true;

  if not found then
    return 'CONFIGURACAO DO CLIENTE INDISPONIVEL CONTATE O SUPORTE ';
  end if;

  aParam[1] := iMatricula::text;
  aParam[2] := iAnousu::text;
  aParam[3] := case when bGerafinanc   is true then 'true' else 'false' end;
  aParam[4] := case when bAtualizap    is true then 'true' else 'false' end;
  aParam[5] := case when bNovonumpre   is true then 'true' else 'false' end;
  aParam[6] := case when bCalculogeral is true then 'true' else 'false' end;
  aParam[7] := case when bDemo         is true then 'true' else 'false' end;

  iTotPos := ( array_upper(aParametrosFinais,1) + array_upper(aParam,1) )::integer;

  iTotparametros := array_upper(aParam,1)::integer;

  for iInd in 8..iTotPos loop
    aParam[iInd] := aParametrosFinais[ ( iInd - iTotparametros ) ];
  end loop;

  tRes := fc_montachamadafuncao(iCodFuncao, iCodCli, aParam, lRaise);

  perform fc_debug(' <calculoiptu> Funcao a ser executada: ' || tRes, lRaise);

  if tRes is not null then
    execute 'select '||tRes into tRetornoCalc;
  end if;

  return tRetornoCalc;

end;
$$  language 'plpgsql';drop function fc_iptu_calculataxas(integer,integer,integer,boolean);
create or replace function fc_iptu_calculataxas(integer,integer,integer,boolean) returns boolean as
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

  perform fc_debug(' <iptu_calculataxas> SQL BASE DAS TAXAS : % ' || coalesce( tSql, '' ), lRaise);

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
$$  language 'plpgsql';drop function fc_iptu_criatemptable(boolean);
create or replace function fc_iptu_criatemptable(boolean) returns boolean as
$$
declare

     lRaise alias for $1;

     rbErro boolean default false;
     nome   name;

begin

   /**
    * FUNCAO PARA CRIAR AS TABELAS TEMPORARIAS
    */
  perform fc_debug('', lRaise);
  perform fc_debug(' <iptu_criatemptable> INICIANDO CRIACAO DE ESTRUTURAS TEMPORARIAS...', lRaise);

  begin

    /*
     * NAO REMOVER CAMPOS DESSAS TABELAS, ESSA ALTERACAO PODE CAUSAR PROBLEMAS EM TODOS OS CALCULOS
     * QUANDO USAR AS TABELAS TEMPORARIAS NAO USE SELECT * INTO VAI1, VAR2,VAR3 FROM XXX.
     * USE: SELECT CAMPO1,CAMPO2,CAMPO3 INTO  VAR1, VAR2,VAR3 FROM XXXX.
     */

    /**
     * Tabela que guarda as receitas e valores das mesmas, para gerar o financeiro(arrecad)
     */
    create temporary table tmprecval( "receita" integer,"valor" numeric,"hist" integer,"taxa" boolean );
    perform fc_debug(' <iptu_criatemptable> TABELA TMPRECVAL CRIADA', lRaise);

    /**
     * Tabela que guarda os dados referente ao comportamento do calculo durante o processamento das sub-funcoes
     */
    create temporary table tmpdadosiptu( "aliq"      numeric,
                                         "vvc"       numeric,
                                         "vvt"       numeric,
                                         "viptu"     numeric,
                                         "fracao"    numeric,
                                         "areat"     numeric,
                                         "predial"   boolean,
                                         "codvenc"   integer,
                                         "tipoisen"  integer,
                                         "vm2t"      numeric,
                                         "testada"   numeric,
                                         "matric"    integer,
                                         "isentaxas" boolean );
    insert into tmpdadosiptu values (0,0,0,0,0,0,false,0,0,0,0,0);
    perform fc_debug(' <iptu_criatemptable> TABELA TMPDADOSIPTU CRIADA', lRaise);

    /**
     * Tabela que guarda os dados das contrucoes calculadas, alimentada pela fc_iptu_calculavvc
     */
    create temporary table tmpiptucale( "anousu"     integer,
                                        "matric"     integer,
                                        "idcons"     integer,
                                        "areaed"     numeric,
                                        "vm2"        numeric,
                                        "pontos"     integer,
                                        "valor"      numeric,
                                        "edificacao" boolean );
    perform fc_debug(' <iptu_criatemptable> TABELA TMPIPTUCALE CRIADA', lRaise);

    /**
     * Tabela que guarda os valores para calcular as taxas
     */
    create temporary table tmpdadostaxa( "anousu"  integer,
                                         "matric"  integer,
                                         "zona"    integer,
                                         "idbql"   integer,
                                         "nparc"   integer,
                                         "valiptu" numeric,
                                         "valref"  numeric,
                                         "vvt"     numeric,
                                         "totareaconst" numeric );
    insert into tmpdadostaxa values (0,0,0,0,0,0,0,0,0);
    perform fc_debug(' <iptu_criatemptable> TABELA TMPDADOSTAXA CRIADA', lRaise);

    /**
     * Tabela com os parametros para o comportamento da fase do calculo que gera o financeiro
     */
    create temporary table tmpfinanceiro("anousu" integer,"matric" integer,"idbql" integer,"valiptu" numeric,"valref" numeric,"vvt" numeric);
    insert into tmpfinanceiro values (0,0,0,0,0,0);
    perform fc_debug(' <iptu_criatemptable> TABELA TMPFINANCEIRO CRIADA', lRaise);

    /**
     * Tabela que guarda as receitas e percentual de isencao das taxas
     */
    create temporary table tmptaxapercisen("rectaxaisen" integer,"percisen" numeric, "histcalcisen" integer,"valsemisen" numeric);
    perform fc_debug(' <iptu_criatemptable> TABELA TMPTAXAPERCISEN CRIADA', lRaise);

    /**
     * Tabela que guarda os valores para "outras" taxas (taxa bombeiro, limpeza)
     */
		create temporary table tmpoutrosvalores("valor" numeric,"descricao" varchar);
    perform fc_debug(' <iptu_criatemptable> TABELA TMPTAXAPERCISEN CRIADA', lRaise);

    /**
     * Tabela que guarda os valores de vencimentos
     */
    create temporary table tmp_cadvenc as
      select q92_codigo,
             q92_tipo,
             q92_hist,
             q92_vlrminimo,
             q82_parc,
             q82_venc,
             q82_perc,
             q82_hist
        from cadvencdesc
             inner join cadvenc on q92_codigo = q82_codigo
       limit 0;
    perform fc_debug(' <iptu_criatemptable> TABELA TMP_CADVENC CRIADA', lRaise);

  exception
       when duplicate_table then
            truncate tmprecval;
            truncate tmpdadosiptu;
            truncate tmpiptucale;
            truncate tmpdadostaxa;
            truncate tmpfinanceiro;
            truncate tmptaxapercisen;
            truncate tmpoutrosvalores;
            truncate tmp_cadvenc;
            insert into tmpdadosiptu  values (0,0,0,0,0,0,false,0,0,0,0,0,false);
            insert into tmpdadostaxa  values (0,0,0,0,0,0,0,0,0);
            insert into tmpfinanceiro values (0,0,0,0,0,0);
  end;

  perform fc_debug(' <iptu_criatemptable> FIM CRIACAO DE ESTRUTURAS TEMPORARIAS', lRaise);
  perform fc_debug('', lRaise);

  return rbErro;

end;
$$  language 'plpgsql';drop function if exists fc_iptu_demonstrativo(integer,integer,integer,boolean);
create or replace function fc_iptu_demonstrativo(integer,integer,integer,boolean) returns text as
$$
declare

   iMatricula      alias for $1;
   iAnousu         alias for $2;
   iIdql           alias for $3;
   bRaise          alias for $4;

   tDemonstrativo	 text        default '\n';
   tSqlConstr   	 text        default '';
   nTotal          numeric(15,2) default 0;
   nVm2            numeric       default 0;

   iTotalPontos    integer default 0;
   iNumpreVerifica integer default 0;

   rValores        record;
   rDadosIptu      record;
   rProprietario   record;
   rEndereco       record;
   rConstr         record;
   rCaract         record;
   rLoteCaract     record;

   lAbatimento     boolean default false;

begin

   if bRaise then
      raise notice ' GERANDO DEMONSTRATIVO DE CALCULO ...';
   end if;

    -- Verifica se existe Pagamento Parcial para o débito informado
    select j20_numpre
      from iptunump
      into iNumpreVerifica
     where j20_matric = iMatricula
       and j20_anousu = iAnousu limit 1;

    if found then
      select fc_verifica_abatimento(1,( select j20_numpre
                                          from iptunump
                                         where j20_matric = iMatricula
                                           and j20_anousu = iAnousu
                                         limit 1 ))::boolean into lAbatimento;

      if lAbatimento then
        raise exception '<erro>Operação Cancelada, Débito com Pagamento Parcial!</erro>';
      end if;
    end if;
------------------------------- dados do proprietario -------------------------
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

   tDemonstrativo := tDemonstrativo||LPAD('[ PROPRIETÁRIO ]--',90,'-')||'\n';
   tDemonstrativo := tDemonstrativo||'\n';
   tDemonstrativo := tDemonstrativo||RPAD(' CGC/CPF '             ,55,'.')||': '|| trim(coalesce(rProprietario.z01_cgccpf,'')) ||' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' IDENTIDADE/INSC.EST ' ,55,'.')||': '|| trim(coalesce(rProprietario.z01_ident,''))  ||' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' ENDERECO '            ,55,'.')||': '|| trim(coalesce(rProprietario.z01_ender,''))  ||' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' NUMERO '              ,55,'.')||': '|| trim(coalesce(rProprietario.z01_numero,0)::varchar)  ||' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' BAIRRO '              ,55,'.')||': '|| trim(coalesce(rProprietario.z01_bairro,'')) ||' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' CEP '                 ,55,'.')||': '|| trim(coalesce(rProprietario.z01_cep,''))    ||' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' MUNICIPIO '           ,55,'.')||': '|| trim(coalesce(rProprietario.z01_munic,''))  ||' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' UF '                  ,55,'.')||': '|| trim(coalesce(rProprietario.z01_uf,''))     ||' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' TELEFONE '            ,55,'.')||': '|| trim(coalesce(rProprietario.z01_telef,''))  ||' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' DATA DO CADASTRO '    ,55,'.')||': '|| trim(coalesce(cast(rProprietario.z01_cadast as text),'')) ||' \n';
   tDemonstrativo := tDemonstrativo||'\n';

------------------------------ endereco do imovel ------------------------------
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


   tDemonstrativo := tDemonstrativo||LPAD('[ ENDERECO DO IMÓVEL ]--',90,'-')||'\n';
   tDemonstrativo := tDemonstrativo||'\n';
   tDemonstrativo := tDemonstrativo||RPAD(' LOGRADOURO '            ,55,'.')||': '|| trim(coalesce(rEndereco.j14_nome,''))   ||' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' NUMERO '                ,55,'.')||': '|| trim(coalesce(rEndereco.j39_numero::varchar,'')) ||' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' COMPLEMENTO '           ,55,'.')||': '|| trim(coalesce(rEndereco.j39_compl,''))  ||' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' BAIRRO '                ,55,'.')||': '|| trim(coalesce(rEndereco.j13_descr,''))  ||' \n';
   tDemonstrativo := tDemonstrativo||'\n';

--------------------------------- dados do lote ---------------------------------

   tDemonstrativo := tDemonstrativo||LPAD('[ DADOS DO LOTE ]--' ,90,'-')||'\n';
   tDemonstrativo := tDemonstrativo||'\n';
   tDemonstrativo := tDemonstrativo||RPAD(' SETOR/QUADRA/LOTE ' ,55,'.')||': '|| trim(coalesce(rEndereco.j34_setor,'')||'/'||coalesce(rEndereco.j34_quadra,'')||'/'||coalesce(rEndereco.j34_lote,'')) || ' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' AREA '              ,55,'.')||': '|| trim(coalesce(rEndereco.j34_area::varchar,'')) || ' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' TESTADA PRINCIPAL ' ,55,'.')||': '|| trim(coalesce(rEndereco.j14_nome,'')) || ' \n';
   tDemonstrativo := tDemonstrativo||' CARACTERISTICAS DO LOTE : \n';
   for rLoteCaract in select j31_codigo,j31_descr,j31_grupo from carlote
                      inner join caracter on j35_caract = j31_codigo
                      where j35_idbql = iIdql
   loop
       tDemonstrativo := tDemonstrativo||LPAD(' '||coalesce(rLoteCaract.j31_codigo::varchar,'') ,40,'.')||' - '||coalesce(rLoteCaract.j31_descr,'')||' - GRUPO : '||rLoteCaract.j31_grupo||'\n';
   end loop;
   tDemonstrativo := tDemonstrativo||'\n';


------------------------------ dados das construcoes ------------------------------
   tDemonstrativo := tDemonstrativo||LPAD('[ DADOS DAS CONSTRUÇÕES ]--' ,90,'-')||'\n';
   tDemonstrativo := tDemonstrativo||'\n';
   tSqlConstr := 'select distinct j39_idcons,j39_area,j39_ano,valor,j39_matric,coalesce(pontos,0) as pontos from iptuconstr
                            inner join tmpiptucale on matric = j39_matric and idcons = j39_idcons
                  where j39_matric = '||iMatricula;
   for rConstr in execute tSqlConstr
   loop
      tDemonstrativo := tDemonstrativo||'\n';
      tDemonstrativo := tDemonstrativo||RPAD(' CONSTRUÇÃO '           ,55,'.')||': '|| coalesce(rConstr.j39_idcons::varchar,'')          || ' \n';
      tDemonstrativo := tDemonstrativo||RPAD(' PONTUAÇÃO '            ,55,'.')||': '|| coalesce(rConstr.pontos::varchar,'')              || ' \n';
      tDemonstrativo := tDemonstrativo||RPAD(' AREA '                 ,55,'.')||': '|| coalesce(round(rConstr.j39_area,2)::varchar,'')   || ' \n';
      tDemonstrativo := tDemonstrativo||RPAD(' ANO DA CONSTRUÇÃO '    ,55,'.')||': '|| coalesce(rConstr.j39_ano::varchar,'')             || ' \n';
      tDemonstrativo := tDemonstrativo||RPAD(' VLR VENAL CONSTRUÇÃO ' ,55,'.')||': '|| coalesce(round(rConstr.valor,2)::varchar,'')      || ' \n';

      tDemonstrativo := tDemonstrativo||' CARACTERISTICAS DA CONSTRUÇÃO : \n';
      for rCaract in select * from carconstr
                     inner join caracter  on j48_caract = j31_codigo
                     where j48_matric = rConstr.j39_matric
                       and j48_idcons = rConstr.j39_idcons
      loop
           tDemonstrativo := tDemonstrativo||LPAD(' '||rCaract.j31_codigo ,40,'.')||' - '||coalesce(rCaract.j31_descr,'')||' - GRUPO : '||rCaract.j31_grupo||'\n';
      end loop;

   end loop;
   tDemonstrativo := tDemonstrativo||'\n';


------------------------------ dados do financeiro ------------------------------

   select * from tmpdadosiptu into rDadosIptu;

   select sum(coalesce(pontos,0))
     into iTotalPontos
     from tmpiptucale ;

   tDemonstrativo := tDemonstrativo||LPAD('[ CALCULO '||coalesce(IAnousu::varchar,'')||' ]--',90,'-')||'\n';
   tDemonstrativo := tDemonstrativo||'\n';
   tDemonstrativo := tDemonstrativo||RPAD(' PONTUAÇÃO '            ,55,'.')||': '|| coalesce(iTotalPontos::varchar,'')||'  \n';
   tDemonstrativo := tDemonstrativo||RPAD(' AREA P/ CALCULO '      ,55,'.')||': '|| coalesce(round( (rDadosIptu.areat*rDadosIptu.fracao)/100 ,2)::varchar,'') || ' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' FRACAO '               ,55,'.')||': '|| coalesce(round( rDadosIptu.fracao,2)::varchar,'') || '% \n';
   tDemonstrativo := tDemonstrativo||RPAD(' ALIQUOTA '             ,55,'.')||': '|| coalesce(round( rDadosIptu.aliq,2)::varchar,'')   || '% \n';
   tDemonstrativo := tDemonstrativo||RPAD(' VALOR VENAL TERRENO '  ,55,'.')||': '|| coalesce(round( rDadosIptu.vvt,2)::varchar,'')    || ' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' VALOR VENAL EDIFIC '   ,55,'.')||': '|| coalesce(round( rDadosIptu.vvc,2)::varchar,'')    || ' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' AREA EDIFICADA '       ,55,'.')||': '|| coalesce(round( rDadosIptu.areat,2)::varchar,'')  || ' \n';
   tDemonstrativo := tDemonstrativo||RPAD(' VALOR M2 DO TERRENO '  ,55,'.')||': '|| coalesce(round( rDadosIptu.vm2t,2)::varchar,'')   || ' \n';

 for rValores in select * from tmprecval inner join tabrec on receita = k02_codigo loop
     tDemonstrativo := tDemonstrativo||RPAD(' VALOR '||coalesce(rValores.k02_descr::varchar,''),55,'.')||': '|| coalesce(round(rValores.valor,2)::varchar,'') || '\n';
     nTotal         := nTotal + rValores.valor;
 end loop;

 tDemonstrativo := tDemonstrativo||RPAD(' TOTAL A PAGAR ',55,'.')||': '||coalesce(nTotal,0)||'  \n';

 return tDemonstrativo;

end;
$$  language 'plpgsql';create or replace function fc_iptu_excluicalculo(integer, integer) returns void as
$$
declare

  iMatricula alias for $1;
  iAnousu    alias for $2;
  lRaise     boolean default false;

begin

  lRaise  := ( case when fc_getsession('DB_debugon') is null then false else true end );

  perform fc_debug('');
  perform fc_debug(' <iptu_excluircalculo> EXCLUI CALCULO...',               lRaise);
  perform fc_debug(' <iptu_excluircalculo>   iMatricula ->  ' || iMatricula, lRaise);
  perform fc_debug(' <iptu_excluircalculo>   iAnousu    ->  ' || iAnousu,    lRaise);

  perform fc_debug(' <iptu_excluircalculo> Deletando da arrecad', lRaise);
  delete from arrecad using iptunump
        where k00_numpre          = iptunump.j20_numpre
          and iptunump.j20_anousu = iAnousu
          and iptunump.j20_matric = iMatricula;

  perform fc_debug(' <iptu_excluircalculo> Deletando da iptunump', lRaise);
  delete from iptunump
        where j20_anousu = iAnousu
          and j20_matric = iMatricula;

  perform fc_debug(' <iptu_excluircalculo> FIM EXCLUI CALCULO', lRaise);
  perform fc_debug('');

  return;
end;
$$ language 'plpgsql';drop function fc_iptu_fracionalote(integer,integer,boolean,boolean);

drop   type tp_iptu_fracionalote;
create type tp_iptu_fracionalote as ( rnFracao  numeric,
rtDemo    text,
rtMsgerro text,
rbErro    boolean);

create or replace function fc_iptu_fracionalote(integer,integer,boolean,boolean) returns tp_iptu_fracionalote as
$$
declare

  iMatricula 	alias for $1;
  iAnousu    	alias for $2;
  bMostrademo alias for $3; --Não utilizada no escopo
  lRaise      alias for $4;

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

          update iptubase set j01_fracao = 0 where j01_idbql = iIdbql;
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

    if bRaise then
      perform fc_debug('Calculo geral : '||(case when bCalculogeral is true then 'SIM' else 'NAO' end),bRaise,false,false);
      perform fc_debug('Numpre atual  : '||iNumpre                                 ,bRaise,false,false);
      perform fc_debug('parcelaini : '||iParcelaini||' Parcelafim : '||iParcelafim ,bRaise,false,false);
    end if;


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


    if bRaise then
      perform fc_debug('Numpre: '||iNumpre,bRaise,false,false);
    end if;

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

    if bRaise then
      perform fc_debug('Sql retornado dos vencimentos:'||tSql,bRaise,false,false);
    end if;

    /* PEGA O CGM Q VAI SER GRAVADO NO ARRECAD E ARRENUMCGM */
    select fc_iptu_getcgmiptu(iMatricula) into iCgm;

    /* PEGA A DATA DE OPERACAO DO CFIPTU */
    select j18_dtoper
      into dDtoper
      from cfiptu
     where j18_anousu = iAnousu;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------

    select sum(valor)
      into nTotal
      from tmprecval;

    if bRaise then
      perform fc_debug('TOTAL RETORNADO DA TMPORECVAL: '||nTotal,bRaise,false,false);
    end if;

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

		if bRaise then
		  perform fc_debug('TOTAL: '||nTotal||' - nParcMinima: '||nParcMinima||' - iParcelas: '||iParcelas||' - Divisao (nTotal / iParcelas): '||(nTotal / iParcelas),bRaise,false,false);
		end if;

    if nTotal > 0 then

			if bRaise then
			  perform fc_debug('Parcelas: '||iParcelas||' nTotal: '||nTotal,bRaise,false,false);
      end if;

      if (nTotal / iParcelas) < nParcMinima then

				if floor((nTotal / nParcMinima)::numeric)::integer = 0 then
					 iParcelas := 1;
				else
           iParcelas := floor((nTotal / nParcMinima)::numeric)::integer;
				end if;

        bTrocouMinima := true;

        if bRaise then

          perform fc_debug('entrou em parcela minima... '       ,bRaise,false,false);
          perform fc_debug('Quantidade de Parcelas: '||iParcelas,bRaise,false,false);

        end if;

      end if;

			if bRaise then

			  perform fc_debug('tInParc: '||tInParc,bRaise,false,false);
			  perform fc_debug('',bRaise,false,false);
        perform fc_debug('NUMPRE DO CALCULO: '||iNumpre,bRaise,false,false);
        perform fc_debug('',bRaise,false,false);

      end if;

      -- aqui tem que agrupar por receita
      for rRecval in select receita,
                            (select count( distinct receita) from tmprecval) as qtdreceitas,
                            sum(valor) as valor
                       from tmprecval
                      group by receita
                      order by receita
      loop

        xxvalor := 0;
        iParcelasProcessadas := 1;

        for rVencim in execute tSql
        loop

          if bTrocouMinima is false then
            nPercParcela := cast(rVencim.q82_perc as numeric(15,2));
          else
            nPercParcela := 100::numeric / iParcelas;
          end if;

          --if rVencim.q82_parc > iParcelas and lProcessaVencimentoForcado is false then
          if iParcelas < iParcelasProcessadas and lProcessaVencimentoForcado is false then
            if bRaise then
              perform fc_debug('PARCELA '||rVencim.q82_parc||' NAO SERA CALCULADA', bRaise,false,false);
              perform fc_debug('', bRaise,false,false);
            end if;

            continue;

          end if;

          if iParcelaini = 0 then

            if bRaise then
              perform fc_debug('bPassa = true | iParcelaini = 0', bRaise,false,false);
            end if;

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

          if bRaise then
            perform fc_debug('Processando parcela = '||( case when bPassa is true then 'SIM' else 'NAO' end ), bRaise,false,false);
          end if;

          if bPassa is true then

              perform *
                 from fc_statusdebitos(iNumpre,rVencim.q82_parc)
                where rtstatus = 'PAGO'
                   or rtstatus = 'CANCELADO'
                limit 1;

              if found then

                if bRaise then
                  perform fc_debug(' --- Ignorando parcela '||rVencim.q82_parc||' por estar paga ou cancelada --- ', bRaise,false,false);
                  perform fc_debug('', bRaise,false,false);
                end if;

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

              if bRaise then
                perform fc_debug('', bRaise,false,false);
                perform fc_debug('Parcela: '||rVencim.q82_parc||' Receita:'||rRecval.receita||' Valor:'||nValorpar||' Diff:'||nDifValor, bRaise,false,false);
                perform fc_debug('', bRaise,false,false);
              end if;

              if bDemo is false then

                if bRaise then
                 perform fc_debug('GERANDO ARRECAD '                   ,bRaise,false,false);
                 perform fc_debug(''                                   ,bRaise,false,false);
                 perform fc_debug('Numpre .......: '||iNumpre          ,bRaise,false,false);
                 perform fc_debug('Numpar .......: '||rVencim.q82_parc ,bRaise,false,false);
                 perform fc_debug('Receita ......: '||rRecval.receita  ,bRaise,false,false);
                 perform fc_debug('Valor ........: '||nValorpar        ,bRaise,false,false);
                 perform fc_debug('Vencimento ...: '||rVencim.q82_parc ,bRaise,false,false);
                 perform fc_debug('nDifValor ....: '||nDifValor        ,bRaise,false,false);
                 perform fc_debug(''                                   ,bRaise,false,false);
                end if;

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


          if bRaise then
            perform fc_debug('', bRaise,false,false);
            perform fc_debug('nValorpar: '||nValorpar||' - nDifValor: '||nDifValor , bRaise,false,false);
            perform fc_debug('', bRaise,false,false);
          end if;

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
      raise notice '%',fc_debug('Fim do processamento da funcao iptu_gerafinanceiro...',bRaise,false,true);
    end if;

    return true;

  end;
$$  language 'plpgsql';drop function fc_iptu_geterro(integer, text);
create or replace function fc_iptu_geterro(integer, text) returns varchar as
$$
declare

    iCodErro alias for $1;
		tErro		 alias for $2;

    vMsg     varchar(300) default '';

begin

    select lpad(j62_codigo,3,'0')||' - '||j62_descr
      into vMsg
      from iptucadlogcalc
     where j62_codigo = iCodErro
  order by j62_codigo;

  if found then
    return vMsg||coalesce(' '||tErro,' ');
  else
    return '9999 - Ocorreu um erro durante a operacao ! Contate o Suporte - erro: ' || iCodErro || coalesce(' '||tErro,' ');
  end if;

end;
$$  language 'plpgsql';create or replace function fc_iptu_precalculo ( iMatricula           integer,
                                                iAnousu              integer,
                                                lCalculogeral        boolean,
                                                lAtualizaParcela     boolean,
                                                lMostraDemonstrativo boolean,
                                                lRaise               boolean,

                                                OUT r_iIdbql         integer,
                                                OUT r_nAreal         float8,
                                                OUT r_nFracao        float8,
                                                OUT r_iNumcgm        integer,
                                                OUT r_dDatabaixa     date,
                                                OUT r_nFracaolote    numeric,
                                                OUT r_tDemo          text,
                                                OUT r_lTempagamento  boolean,
                                                OUT r_lEmpagamento   boolean,
                                                OUT r_iCodisen       integer,
                                                OUT r_iTipois        integer,
                                                OUT r_nIsenaliq      numeric,
                                                OUT r_lIsentaxas     boolean,
                                                OUT r_nArealote      numeric,
                                                OUT r_iCodCli        integer,
                                                OUT r_tRetorno       text
                                              ) returns record as
$$
declare

  iMatricula           alias for $1;
  iAnousu              alias for $2;
  lCalculogeral        alias for $3; -- Calculo Geral
  lAtualizaParcela     alias for $4; -- Atualizar Parcelas
  lMostraDemonstrativo alias for $5; -- Demonstrativo
  lRaise               alias for $6; -- Variavel de Debug

  iIdbql          integer;
  nAreal          float8;
  nFracao         float8;
  iNumcgm         integer;
  dDatabaixa      date;
  nFracaolote     numeric;
  tDemo           text;
  lTempagamento   boolean;
  lEmpagamento    boolean;
  iCodisen        integer;
  iTipois         integer;
  nIsenaliq       numeric;
  lIsentaxas      boolean;
  nArealote       numeric;
  iCodCli         integer;

  tRetorno        text    default '';
  iCodErro        integer default 0;

  lErro           boolean;

begin

  lRaise  := ( case when fc_getsession('DB_debugon') is null then false else true end );

  if trim(fc_getsession('db_debug')) <> '' then
    perform fc_debug(' <iptu_precalculo> INICIANDO PRE-CALCULO...', lRaise, false, false);
  else
    perform fc_debug(' <iptu_precalculo> INICIANDO PRE-CALCULO...', lRaise, true, false);
  end if;

  perform fc_debug(' <iptu_precalculo> PARAMETROS RECEBIDOS', lRaise);
  perform fc_debug(' <iptu_precalculo> iMatricula           -' || iMatricula          , lRaise);
  perform fc_debug(' <iptu_precalculo> iAnousu              -' || iAnousu             , lRaise);
  perform fc_debug(' <iptu_precalculo> lCalculogeral        -' || lCalculogeral       , lRaise);
  perform fc_debug(' <iptu_precalculo> lAtualizaParcela     -' || lAtualizaParcela    , lRaise);
  perform fc_debug(' <iptu_precalculo> lMostraDemonstrativo -' || lMostraDemonstrativo, lRaise);

  r_iIdbql        := 0;
  r_nAreal        := 0;
  r_nFracao       := 0;
  r_iNumcgm       := 0;
  r_dDatabaixa    := null::date;
  r_nFracaolote   := 0;
  r_tDemo         := '';
  r_lTempagamento := false::boolean;
  r_lEmpagamento  := false::boolean;
  r_iCodisen      := 0;
  r_iTipois       := 0;
  r_nIsenaliq     := 0;
  r_lIsentaxas    := false::boolean;
  r_nArealote     := 0;
  r_iCodCli       := 0;
  r_tRetorno      := '';

  /**
   * Verifica se os parametros passados estao corretos
   */
  select riidbql, rnareal, rnfracao, rinumcgm, rdbaixa, rberro, rtretorno
    into iIdbql,  nAreal,  nFracao,  iNumcgm,  dDatabaixa, lErro, tRetorno
    from fc_iptu_verificaparametros( iMatricula, iAnousu );

  if length(tRetorno) > 0 then

    r_tRetorno := tRetorno;
    return;
  end if;

  perform fc_debug('<parametros> IDBQL: '  || iIdbql,   lRaise);
  perform fc_debug('<parametros> AREAL: '  || nAreal,   lRaise);
  perform fc_debug('<parametros> FRACAO: ' || nFracao,  lRaise);
  perform fc_debug('<parametros> CGM: '    || iNumcgm,  lRaise);

  r_iIdbql     = iIdbql;
  r_nAreal     = nAreal;
  r_nFracao    = nFracao;
  r_iNumcgm    = iNumcgm;
  r_dDatabaixa = dDatabaixa;
  r_tRetorno   = tRetorno;

  /**
   * Verifica se o calculo pode ser realizado
   */
  select rbErro, riCodErro
    into lErro, iCodErro
    from fc_iptu_verificacalculo( iMatricula, iAnousu );

  if lErro is true and lMostraDemonstrativo is false then

    /**
     * Devolve mensagem de erro direto para função de calculo
     */
    select fc_iptu_geterro( iCodErro, '' ) into r_tRetorno;
    return;
  end if;

  /**
   * Verifica se matricula esta baixada
   */
  if dDataBaixa is not null and to_char( dDataBaixa, 'Y' )::integer <= iAnousu then

    /**
     * Exclui calculo e retorna msg de matricula baixada
     */
    perform fc_iptu_excluicalculo( iMatricula, iAnousu );

    select fc_iptu_geterro( 2, '' ) into r_tRetorno;
    return;
  end if;

  /**
   * Cria as tabelas temporarias
   */
  select fc_iptu_criatemptable( lRaise ) into lErro;

  /**
   * Fracionando lote
   */
  perform fc_debug('PARAMETROS IPTU_FRACIONALOTE FRACAO DO LOTE: Matricula: ' || iMatricula || ' - Anousu: '|| iAnousu, lRaise);

  select rnfracao, rtdemo, rtmsgerro, rberro
    into nFracaolote, tDemo, r_tRetorno, lErro
    from fc_iptu_fracionalote( iMatricula, iAnousu, lMostraDemonstrativo, lRaise );

  update tmpdadosiptu set fracao = nFracaolote;

  perform fc_debug('RETORNO fc_iptu_fracionalote -> Fração do Lote: '||nFracaolote||' - DEMONS: '||tDemo, lRaise);

  r_nFracaolote = nFracaolote;
  r_tDemo       = tDemo;

  /**
   * Verifica Pagamentos
   */
  perform fc_debug('', lRaise);
  perform fc_debug('PARAMETROS fc_iptu_verificapag -> Matricula: '||iMatricula||' - Anousu: '||iAnousu||' - Desmonstrativo: '||lMostraDemonstrativo, lRaise);

  select rbtempagamento, rbempagamento, rtmsgretorno, rberro
    into lTempagamento, lEmpagamento, r_tRetorno, lErro
    from fc_iptu_verificapag( iMatricula, iAnousu, lCalculogeral, lAtualizaParcela, false, lMostraDemonstrativo, lRaise );

  perform fc_debug('RETORNO fc_iptu_verificapag -> TEMPAGAMENTO: '||lTempagamento||' - EMPAGAMENTO: '||lEmpagamento||' - RETORNO: '||r_tRetorno||' - ERRO: '||lErro, lRaise);

  r_lTempagamento = lTempagamento;
  r_lEmpagamento  = lEmpagamento;

  /**
   * Verifica Isenções
   */
  perform fc_debug('PARAMETROS fc_iptu_verificaisencoes -> Matricula: '||iMatricula||' - Anousu: '||iAnousu||' - Desmonstrativo: '||lMostraDemonstrativo, lRaise);

  select ricodisen, ritipois, rnisenaliq, rbisentaxas, rnarealo
    into iCodisen, iTipois, nIsenaliq, lIsentaxas, nArealote
    from fc_iptu_verificaisencoes( iMatricula, iAnousu, lMostraDemonstrativo, lRaise );

  if iTipois is not null then
    update tmpdadosiptu set tipoisen = iTipois;
  end if;

  r_iCodisen   = iCodisen;
  r_iTipois    = iTipois;
  r_nIsenaliq  = nIsenaliq;
  r_lIsentaxas = lIsentaxas;
  r_nArealote  = nArealote;

  perform fc_debug('RETORNO fc_iptu_verificaisencoes -> CODISEN:    '||iCodisen||' '
                                                       'TIPOISEN:   '||iTipois||' '
                                                       'ALIQ INSEN: '||nIsenaliq||' '
                                                       'INSENTAXAS: '||lIsentaxas||' '
                                                       'AREALO:     '||nArealote, lRaise);

  perform fc_debug(' <iptu_precalculo> FIM PRE-CALCULO...', lRaise);
  perform fc_debug(' ', lRaise);

  /**
   * Busca CodCli da prefeitura
   */
  select db21_codcli
    into r_iCodCli
    from db_config
   where prefeitura is true;

  return;

end;
$$  language 'plpgsql';drop function fc_iptu_verificaisencoes(integer,integer,boolean,boolean);

drop   type tp_iptu_verificaisencoes;
create type tp_iptu_verificaisencoes as (riCodisen    integer,
																				 riTipois     integer,
																				 rnIsenaliq   numeric,
																				 rnArealo     numeric,
																				 rbIsentaxas  boolean );

create or replace function fc_iptu_verificaisencoes(integer,integer,boolean,boolean) returns tp_iptu_verificaisencoes as
$$
declare

   iMatricula 	alias for $1;
   iAnousu    	alias for $2;
	 bMostrademo  alias for $3;
	 lRaise       alias for $4;

   riCodisen    integer;
	 riTipois     integer;
	 rnIsenaliq   numeric;
	 rnArealo     numeric;
	 rbIsentaxas  boolean default false;

   rtp_iptu_verificaisencoes tp_iptu_verificaisencoes%ROWTYPE;

begin

    perform fc_debug(' <iptu_verificaisencoes> VERIFICANDO ISENCOES...', lRaise);

    rtp_iptu_verificaisencoes.riCodisen   := 0;
    rtp_iptu_verificaisencoes.riTipois    := 0;
    rtp_iptu_verificaisencoes.rnIsenaliq  := 0;
    rtp_iptu_verificaisencoes.rbIsentaxas := 'f';
    rtp_iptu_verificaisencoes.rnArealo    := 0;

    select j46_codigo,
           coalesce(j45_tipis,0),
           j46_perc::numeric,
           j45_taxas as j45_taxas,
           case when j46_arealo is null then 0::numeric
                                        else j46_arealo::numeric
                 end as j46_arealo
      into rtp_iptu_verificaisencoes.riCodisen,
           rtp_iptu_verificaisencoes.riTipois,
           rtp_iptu_verificaisencoes.rnIsenaliq,
           rtp_iptu_verificaisencoes.rbIsentaxas,
           rtp_iptu_verificaisencoes.rnArealo
      from iptuisen
           inner join isenexe  on j46_codigo = j47_codigo
           inner join tipoisen on j46_tipo   = j45_tipo
    where j46_matric = iMatricula
      and j47_anousu = iAnousu;

    if rtp_iptu_verificaisencoes.rnIsenaliq is null then
      rtp_iptu_verificaisencoes.rnIsenaliq = 0;
    end if;

    if rtp_iptu_verificaisencoes.rbIsentaxas is null then
      rtp_iptu_verificaisencoes.rbIsentaxas = 'true'::boolean;
    else
      rtp_iptu_verificaisencoes.rbIsentaxas = 'false'::boolean;
    end if;

    perform fc_debug(' <iptu_verificaisencoes> riCodisen:   ' || coalesce( rtp_iptu_verificaisencoes.riCodisen, 0 ),   lRaise);
    perform fc_debug(' <iptu_verificaisencoes> rbIsentaxas: ' || rtp_iptu_verificaisencoes.rbIsentaxas,                lRaise);
    perform fc_debug(' <iptu_verificaisencoes> rnIsenaliq:  ' || coalesce( rtp_iptu_verificaisencoes.rnIsenaliq, 0 ),  lRaise);

    return rtp_iptu_verificaisencoes;

end;
$$  language 'plpgsql';drop function fc_iptu_verificapag(integer,integer,boolean,boolean,boolean,boolean,boolean);

drop   type if exists retPag;
create type retPag as (rbTempagamento boolean,
                       rbEmpagamento  boolean,
											 rtMsgretorno   text,
                       rbErro         boolean );

create or replace function fc_iptu_verificapag(integer,integer,boolean,boolean,boolean,boolean,boolean) returns retPag as
$$
declare

   iMatricula    	alias for $1;
   iAnousu      	alias for $2;
   bCalculogeral 	alias for $3;
	 bAtualizap    	alias for $4;
	 blimpacalculo  alias for $5; --Não utilizada no escopo
   bDemo      	  alias for $6;
	 lRaise         alias for $7;

	 iNumpre        integer;
	 iParini        integer;


   bEmpagamento   boolean default false;
   bEtempagamento boolean default false;

   rRetpag  retPag%ROWTYPE;

begin

   rRetpag.rbTempagamento := false;
   rRetpag.rbEmpagamento  := false;
   rRetpag.rtMsgretorno   := '';
   rRetpag.rbErro         := false;

   /**
    * Verifica pagamentos
    */
   perform fc_debug(' ', lRaise);
   perform fc_debug(' <iptu_verificapag> INICIANDO VERIFICACAO DE PAGAMENTOS ...', lRaise);

   select j20_numpre,
          max(k00_numpar) as k00_numpar
     into iNumpre,
		      iParini
     from iptunump
          inner join arrecant on j20_numpre = k00_numpre
   where j20_anousu = iAnousu
     and j20_matric = iMatricula
   group by j20_numpre;

   if not iNumpre is null and bDemo = false then

      if bAtualizap = false then
         rRetpag.rbEmpagamento = true;
      end if;
      rRetpag.rbTempagamento = true;

   else
      iParini := 1;
   end if;

   perform fc_debug(' <iptu_verificapag> iNumpre: ' || coalesce( iNumpre, 0 ) || ' - iParini: ' || coalesce( iParini, 0 ), lRaise);

   /**
    * Remove calculo existente
    */
   if bDemo is false then

      perform fc_debug(' <iptu_verificapag> deletando iptucalv, iptucale, iptucalc...', lRaise);
      delete from iptucalv where j21_anousu = iAnousu and j21_matric = iMatricula;
      delete from iptucale where j22_anousu = iAnousu and j22_matric = iMatricula;
      delete from iptucalc where j23_anousu = iAnousu and j23_matric = iMatricula;
   end if;

   perform fc_debug(' <iptu_verificapag> FIM VERIFICACAO DE PAGAMENTOS', lRaise);
   perform fc_debug(' ', lRaise);

   return rRetpag;

end;
$$  language 'plpgsql';drop function if exists fc_iptu_verificaparametros(integer, integer);
drop function if exists fc_iptu_verificaparametros(integer, integer, integer, integer);

drop   type if exists tp_iptu_parametros;
create type tp_iptu_parametros as (riIdbql   integer,
                                   rnAreal   numeric,
																   rnFracao  numeric,
																   riNumcgm  integer,
																   rdBaixa   date,
																   rtRetorno text,
																   rbErro    boolean);
/**
 * @deprecated
 * Removido campos parcelaini e parcelafim
 *
 * Utilizar fc_iptu_verificaparametros( iMatricula, iAnousu )
 */
create or replace function fc_iptu_verificaparametros(integer, integer, integer, integer) returns tp_iptu_parametros as
$$
declare

  iMatricula alias for $1;
  iAnousu    alias for $2;
  parcelaini alias for $3; -- Não utilizada no escopo
  parcelafim alias for $4; -- Não utilizada no escopo

  lRaise     boolean default false;

  rtp_Retorno tp_iptu_parametros%ROWTYPE;

begin

  lRaise  := ( case when fc_getsession('DB_debugon') is null then false else true end );

  rtp_Retorno.riIdbql   := 0::integer;
  rtp_Retorno.rnAreal   := 0::numeric;
  rtp_Retorno.rnFracao  := 0::numeric;
  rtp_Retorno.riNumcgm  := 0::integer;
  rtp_Retorno.rdBaixa   := null::date;
  rtp_Retorno.rtRetorno := ''::text;
  rtp_Retorno.rbErro    := false::boolean;

  select into rtp_Retorno
         j01_idbql     as iIdbql,

         case when j34_areal = 0
              then j34_area
         else j34_areal
         end           as nAreal,

         j34_totcon    as nFracao,
         j01_numcgm    as iNumcgm,
         j01_baixa     as dBaixa,
         ''::text      as tRetorno,
         true::boolean as bErro
   from  iptubase
         inner join lote          on j34_idbql  = j01_idbql
         left outer join iptufrac on j25_anousu = iAnousu
                                 and j25_matric = j01_matric
   where j01_matric = iMatricula;

   /**
    * "Logica" abaixo deve ser verificada
    */
   if rtp_Retorno.riIdbql is null then

      rtp_Retorno.rbErro    := true;
      rtp_Retorno.rtRetorno := '16 matricula nao cadastrada';
   end if;

   if not rtp_Retorno.rdBaixa is null then

      rtp_Retorno.rbErro    := true;
      rtp_Retorno.rtRetorno := '02 matricula baixada';
   end if;

   if rtp_Retorno.rnAreal = 0 or rtp_Retorno.rnAreal is null then

      rtp_Retorno.rbErro    := true;
      rtp_Retorno.rtRetorno := '03 area do lote zerada';
   end if;

   perform fc_debug ( '' ,lRaise);
   perform fc_debug (' <iptu_verificaparametros> IDBQL     - ' || rtp_Retorno.riIdbql   , lRaise);
   perform fc_debug (' <iptu_verificaparametros> AREAL     - ' || rtp_Retorno.rnAreal   , lRaise);
   perform fc_debug (' <iptu_verificaparametros> FRACAO    - ' || rtp_Retorno.rnFracao  , lRaise);
   perform fc_debug (' <iptu_verificaparametros> CGM       - ' || rtp_Retorno.riNumcgm  , lRaise);
   perform fc_debug (' <iptu_verificaparametros> DATABAIXA - ' || rtp_Retorno.rdBaixa   , lRaise);
   perform fc_debug (' <iptu_verificaparametros> ERRO      - ' || rtp_Retorno.rbErro    , lRaise);
   perform fc_debug (' <iptu_verificaparametros> RETORNO   - ' || rtp_Retorno.rtRetorno , lRaise);
   perform fc_debug ( '' ,lRaise);

   return rtp_Retorno;

end;

$$ language 'plpgsql';

/**
 * Wrapper para fc_iptu_verificaparametros original passando apenas matricula e anousu
 */
create or replace function fc_iptu_verificaparametros(integer, integer) returns tp_iptu_parametros as
$$
declare

    iMatricula  alias for $1;
    iAnousu     alias for $2;

    rRetorno    record;

begin

    for rRetorno in
      select * from fc_iptu_verificaparametros(iMatricula, iAnousu, 0, 0)
    loop
      return rRetorno;
    end loop;

end;
$$ language 'plpgsql';drop function fc_montachamadafuncao(integer,integer,text[],boolean);
create or replace function fc_montachamadafuncao(integer,integer,text[],boolean) returns varchar as
$$
declare

    iCodFuncao   alias for $1;
    iCodCli      alias for $2;
    aValores     alias for $3;
    lRaise       alias for $4;

    cVirgula     char(1) default '';
    sParametros  varchar default '';
    sNomefuncao  varchar default '';
    tSql         text    default '';

    rParametros  record;

begin

  select nomefuncao
    into sNomefuncao
    from db_sysfuncoes
   where codfuncao = iCodfuncao;

  tSql :=  'select db42_tipo, db42_ordem
              from db_sysfuncoesparam
                   left join db_sysfuncoescliente  on db41_funcao = db42_funcao
             where db42_funcao  = '||iCodFuncao||'
               and case when db41_cliente is not null then
                    db41_cliente = '||iCodCli||' else true
                   end
          order by db42_ordem';

  perform fc_debug(' <montachamadafuncao> sql monta chamada funcao -> ' || tSql, lRaise);

  for rParametros in execute tSql loop

    sParametros := sParametros || cVirgula || quote_literal(aValores[rParametros.db42_ordem]) || '::' || rParametros.db42_tipo;
    cVirgula := ', ';
  end loop;

  sNomeFuncao := sNomeFuncao || '(' ||sParametros || ');';

  perform fc_debug(' <montachamadafuncao> Retorno: ' || sNomeFuncao, lRaise);

  return sNomeFuncao;

end;
$$  language 'plpgsql';drop   function if exists fc_iptu_verificacalculo(integer, integer);
drop   function if exists fc_iptu_verificacalculo(integer, integer, integer, integer);

drop   type if exists iptu_verificacalc;
drop   type if exists tp_iptu_verificacalc;
create type tp_iptu_verificacalc as (rbErro    boolean,
                                     riCodErro integer);

/**
 * @deprecated
 * Removido campos parcelaini e parcelafim
 *
 * Utilizar fc_iptu_verificacalculo( iMatricula, iAnousu )
 */
create or replace function fc_iptu_verificacalculo(integer, integer, integer, integer) returns tp_iptu_verificacalc as
$$
declare

  iMatricula  alias for $1;
  iAnousu     alias for $2;
  iParcini    alias for $3; --Não utilizado no escopo
  iParcfim    alias for $4; --Não utilizado no escopo

  iNumpre           integer default 0;
  iParcArrecad      integer default 0;
  iTotParcArrecad   integer default 0;
  iParcArrepaga     integer default 0;
  iTotParcArrepaga  integer default 0;
  iParcArrecant     integer default 0;
  iTotParcArrecant  integer default 0;
  iDivold           integer default 0;

  lRaise            boolean default false;
  rtp_Retorno       tp_iptu_verificacalc%ROWTYPE;

begin

  lRaise  := ( case when fc_getsession('DB_debugon') is null then false else true end );

  rtp_Retorno.rbErro    := false;
  rtp_Retorno.riCodErro := 0::integer;

  /*
   * Verifica a situação do Calculo de IPTU
   *  Situações de bloqueio:
   *   1 - Importado para Divida
   *   2 - Totalmente Pago
   *   3 - Totalmente Cancelado
   */
   select distinct arrecad.k00_numpre,
                   arrecad.k00_numtot,
                   (select coalesce(count(k00_numpar),0) from arrecad  where k00_numpre = iptunump.j20_numpre),
                   (select coalesce(count(k00_numpar),0) from arrepaga where k00_numpre = iptunump.j20_numpre),
                   (select coalesce(count(k00_numpar),0) from arrecant where k00_numpre = iptunump.j20_numpre),
                   coalesce((select divold.k10_numpre from divold where k10_numpre = iptunump.j20_numpre limit 1),0)
     into iNumpre,
          iParcArrecad,
          iTotParcArrecad,
          iParcArrepaga,
          iParcArrecant,
          iDivold
     from iptubase
          inner join iptunump on iptunump.j20_matric = iptubase.j01_matric
                             and iptunump.j20_anousu = iAnousu
          left join  arrecad  on arrecad.k00_numpre  = iptunump.j20_numpre
   where iptubase.j01_matric = iMatricula
     and j20_numpre is not null;

   if found then

     if iDivold <> 0 then -- Com Importação para a Dívida

        rtp_Retorno.rbErro    := true;
        rtp_Retorno.riCodErro := 32::integer;
     elsif iNumpre is null and iParcArrepaga <> 0 then -- Em processo de Pagamento

        rtp_Retorno.rbErro    := true;
        rtp_Retorno.riCodErro := 27::integer;
     elsif iParcArrecant <> 0 and iParcArrepaga = 0 then -- Calculo Cancelado

        rtp_Retorno.rbErro    := true;
        rtp_Retorno.riCodErro := 34::integer;
     end if;

   end if;

   perform fc_debug ( '' , lRaise);
   perform fc_debug (' <iptu_verificacalculo> ERRO        - ' || rtp_Retorno.rbErro   , lRaise);
   perform fc_debug (' <iptu_verificacalculo> CODIGO ERRO - ' || rtp_Retorno.riCodErro, lRaise);
   perform fc_debug ( '' , lRaise);

   return rtp_Retorno;

end;

$$ language 'plpgsql';

/**
 * Wrapper para fc_iptu_verificacalculo original passando apenas matricula e anousu
 */
create or replace function fc_iptu_verificacalculo(integer, integer) returns tp_iptu_verificacalc as
$$
declare

    iMatricula  alias for $1;
    iAnousu     alias for $2;

    rRetorno    record;

begin

    for rRetorno in
      select * from fc_iptu_verificacalculo(iMatricula, iAnousu, 0, 0)
    loop
      return rRetorno;
    end loop;

end;
$$ language 'plpgsql';create or replace function fc_calculoiptu_oso_2008(integer,integer,boolean,boolean,boolean,boolean,boolean,integer,integer) returns varchar(100) as
$$

declare

   iMatricula       alias   for $1;
   iAnousu          alias   for $2;
   lGerafinanceiro  alias   for $3; -- Gera Financeiro
   lAtualizaParcela alias   for $4; -- Atualizar Parcelas
   lNovonumpre      alias   for $5; -- Gera Novo Numpre
   lCalculogeral    alias   for $6; -- Calculo Geral
   lDemonstrativo   alias   for $7; -- Demonstrativo
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

   dDataBaixa       date;

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
   tErro            text default '';

   lFinanceiro      boolean;
   lDadosIptu       boolean;
   lErro            boolean;
   lIsentaxas       boolean;
   lTempagamento    boolean;
   lEmpagamento     boolean;
   lTaxasCalculadas boolean;

   lRaise           boolean default true;

   rCfiptu          record;

begin

  lRaise  := ( case when fc_getsession('DB_debugon') is null then false else true end );

  perform fc_debug('INICIANDO CALCULO',lRaise,true,false);

  /**
   * Executa PRE CALCULO
   */
  select r_iIdbql, r_nAreal, r_nFracao, r_iNumcgm, r_dDatabaixa, r_nFracaolote,
         r_tDemo, r_lTempagamento, r_lEmpagamento, r_iCodisen, r_iTipois, r_nIsenaliq,
         r_lIsentaxas, r_nArealote, r_iCodCli, r_tRetorno

    into iIdbql, nAreal, nFracao, iNumcgm, dDataBaixa, nFracaolote, tDemo, lTempagamento,
         lEmpagamento, iCodisen, iTipois, nIsenaliq, lIsentaxas, nArealo, iCodCli, tRetorno

    from fc_iptu_precalculo( iMatricula, iAnousu, lCalculogeral, lAtualizaparcela, lDemonstrativo, lRaise );

  perform fc_debug(' RETORNO DA PRE CALCULO: ',            lRaise);
  perform fc_debug('  iIdbql        -> ' || iIdbql,        lRaise);
  perform fc_debug('  nAreal        -> ' || nAreal,        lRaise);
  perform fc_debug('  nFracao       -> ' || nFracao,       lRaise);
  perform fc_debug('  iNumcgm       -> ' || iNumcgm,       lRaise);
  perform fc_debug('  dDataBaixa    -> ' || dDataBaixa,    lRaise);
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
  perform fc_debug('PARAMETROS fc_iptu_calculavvt_oso_2008  IDBQL: ' || iIdbql || ' - FRACAO DO LOTE: ' || nFracaolote || ' - DEMO: ' || tRetorno, lRaise);

  select rnvvt, rnarea, rtdemo, rtmsgerro, rbErro, riCoderro, rtMsgerro
    into nVvt, nAreac, tDemo, tRetorno, lErro, iCodErro, tErro
    from fc_iptu_calculavvt_oso_2008(iMatricula, iIdbql, nFracaolote,iAnousu, lDemonstrativo, lRaise);

  perform fc_debug('RETORNO fc_iptu_calculavvt_oso_2008 -> VVT: '||nVvt||' - AREA CONTRUIDA: '||nAreac||' - RETORNO: '||tRetorno||' - ERRO '||lErro, lRaise);
  perform fc_debug('RETORNO - ERRO '||lErro, lRaise);
  perform fc_debug('', lRaise);

  if lErro is true then

    select fc_iptu_geterro( iCodErro, tErro ) into tRetorno;
    return tRetorno;
  end if;

  /**
   * Calcula valor da construcao
   */
  perform fc_debug('PARAMETROS fc_iptu_calculavvc_oso_2008  MATRICULA: '||iMatricula||' - ANOUSU: '||iAnousu||' - DEMO: '||lDemonstrativo, lRaise);

  select rnvvc, rntotarea, rinumconstr, rtdemo, rtmsgerro, rbErro, riCoderro, rtMsgerro
    into nVvc, nTotarea, iNumconstr, tDemo, tRetorno, lErro, iCodErro, tErro
    from fc_iptu_calculavvc_oso_2008(iMatricula, iAnousu, lDemonstrativo, lRaise);

  perform fc_debug('RETORNO fc_iptu_calculavvc_oso_2008 -> VVC: '||nVvc||' - AREA TOTAL: '||nTotarea||' - NUMERO DE CONTRUÇÕES: '||iNumconstr||' - RETORNO: '||tRetorno||' - ERRO: '||lErro, lRaise);
  perform fc_debug('', lRaise);

  if lErro is true then

    select fc_iptu_geterro( iCodErro, tErro ) into tRetorno;
    return tRetorno;
  end if;

  if nVvc is null or nVvc = 0 and iNumconstr <> 0 then

    select fc_iptu_geterro( 22, '' ) into tRetorno;
    return tRetorno;
  end if;

  /**
   * Busca a aliquota
   */
  perform fc_debug('PARAMETROS fc_iptu_getaliquota_oso_2008 -> MATRICULA: '||iMatricula||' - IDBQL: '||iIdbql||' - CGM: '||iNumcgm, lRaise);

  if iNumconstr is not null and iNumconstr > 0 then
    select fc_iptu_getaliquota_oso_2008(iMatricula, iIdbql, iNumcgm, true::boolean, lRaise) into nAliquota;
  else
    select fc_iptu_getaliquota_oso_2008(iMatricula, iIdbql, iNumcgm, false::boolean, lRaise) into nAliquota;
  end if;

  if not found or nAliquota = 0 then

    select fc_iptu_geterro(13,'') into tRetorno;
    return tRetorno;
  end if;

  perform fc_debug('RETORNO fc_iptu_getaliquota_oso_2008 -> ALIQUOTA : '||nAliquota, lRaise);

  /**
   * Calcula o Valor Venal
   */
  perform fc_debug('' || lpad('',60,'-'), lRaise);
  nVv    := nVvc + nVvt;
  perform fc_debug(' CALCULO DO VALOR VENAL: Vvc= '||coalesce(nVvc,0)||' nVvt= '||coalesce(nVvt,0)||' VALOR VENAL= '||coalesce(nVv,0), lRaise);

  nViptu := nVv * (nAliquota / 100);
  perform fc_debug(' CALCULO DO VALOR DO IPTU: Vvi= '||coalesce(nViptu,0)||' Aliquota= '||nAliquota/100, lRaise);

  perform fc_debug('' || lpad('',60,'-'), lRaise);
  /*-------------------------------------------*/

  perform fc_debug('nViptu : '||nViptu, lRaise);

  select count(*)
    into iParcelas
    from cadvencdesc
         inner join cadvenc on q92_codigo = q82_codigo
   where q92_codigo = rCfiptu.j18_vencim;

  if not found or iParcelas = 0 then
     select fc_iptu_geterro(14,'') into tRetorno;
     return tRetorno;
  end if;

  perform predial from tmpdadosiptu where predial is true;
  if found then
    insert into tmprecval values (rCfiptu.j18_rpredi, nViptu, 1, false);
  else
    insert into tmprecval values (rCfiptu.j18_rterri, nViptu, 1, false);
  end if;

  /**
   * Calcula Taxa de Lixo
   */
  update tmpdadosiptu set viptu = nViptu, codvenc = rCfiptu.j18_vencim;

  update tmpdadostaxa
     set anousu  = iAnousu,
         matric  = iMatricula,
         idbql   = iIdbql,
         valiptu = nViptu,
         valref  = rCfiptu.j18_vlrref,
         vvt     = nVvt,
         nparc   = iParcelas;

  perform fc_debug('PARAMETROS fc_iptu_calculataxas ANOUSU: '||iAnousu||' - CODCLI: '||iCodcli, lRaise);

  select fc_iptu_calculataxas(iMatricula,iAnousu,iCodcli,lRaise)
    into lTaxasCalculadas;

  perform fc_debug('RETORNO fc_iptu_calculataxas -> TAXASCALCULADAS: '||lTaxasCalculadas, lRaise);

  /**
   * Monta o demonstrativo
   */
  select fc_iptu_demonstrativo(iMatricula,iAnousu,iIdbql,lRaise )
    into tDemo;

  /**
   * Gera financeiro
   *  -> Se nao for demonstrativo gera o financeiro, caso contrario retorna o demonstrativo
   */
  if lDemonstrativo is false then

    select fc_iptu_geradadosiptu(iMatricula, iIdbql, iAnousu, nIsenaliq, lDemonstrativo, lRaise)
      into lDadosIptu;
      if lGerafinanceiro then

        select fc_iptu_gerafinanceiro( iMatricula, iAnousu, iParcelaini, iParcelafim, lCalculogeral, lTempagamento, lNovonumpre, lDemonstrativo, lRaise)
          into lFinanceiro;
      end if;
  else

     return tDemo;
  end if;

  if lDemonstrativo is false then
    update iptucalc set j23_manual = tDemo where j23_matric = iMatricula and j23_anousu = iAnousu;
  end if;

  perform fc_debug('CALCULO CONCLUIDO COM SUCESSO',lRaise, false, true);

  select fc_iptu_geterro(1, '') into tRetorno;
  return tRetorno;

end;
$$  language 'plpgsql';create or replace function fc_iptu_calculavvc_oso_2008(integer,integer,boolean,boolean) returns tp_iptu_calculavvc as
$$
declare

  iMatricula         alias for $1;
  iAnousu            alias for $2;
  lMostrademo        alias for $3;
  lRaise             alias for $4;

  nAreaconstr        numeric default 0;
  nValorConstr       numeric default 0;
  nValor             numeric default 0;
  nVm2c              numeric default 0;
  nFatorIdade        numeric default 0;
  nFatorReducaoSetor numeric default 0;
  iNumerocontr       integer default 0;
  cSetor             char(4);
  tSql               text    default '';
  lAtualiza          boolean default true;
  rConstr            record;

  rtp_iptu_calculavvc tp_iptu_calculavvc%ROWTYPE;

begin

  perform fc_debug('', lRaise);
  perform fc_debug('' || lpad('',60,'-'), lRaise);
  perform fc_debug('* INICIANDO CALCULO DO VALOR VENAL DA CONSTRUCAO', lRaise);

  rtp_iptu_calculavvc.rnVvc       := 0;
  rtp_iptu_calculavvc.rnTotarea   := 0;
  rtp_iptu_calculavvc.riNumconstr := 0;
  rtp_iptu_calculavvc.rtDemo      := '';
  rtp_iptu_calculavvc.rtMsgerro   := 'Retorno ok' ;
  rtp_iptu_calculavvc.rbErro      := 'f';
  rtp_iptu_calculavvc.riCodErro   := 0;
  rtp_iptu_calculavvc.rtErro      := '';

  tSql :=         ' select distinct on (iptuconstr.j39_matric, j39_idcons)';
  tSql := tSql || '                 iptuconstr.j39_matric,                ';
  tSql := tSql || '                 j39_idcons,                           ';
  tSql := tSql || '                 j39_ano,                              ';
  tSql := tSql || '                 j39_area::numeric                     ';
  tSql := tSql || '            from iptuconstr                            ';
  tSql := tSql || '       where iptuconstr.j39_dtdemo is null             ';
  tSql := tSql || '         and iptuconstr.j39_matric = ' || iMatricula;

  perform fc_debug('Select buscando as contrucoes : '||tSql, lRaise);

  /**
   * Busca Construções vinculadas a matricula
   */
  for rConstr in execute tSql loop

     perform fc_debug('MATRICULA - '||rConstr.j39_matric||' CONTRUCAO - '||rConstr.j39_idcons, lRaise);

     select coalesce(j71_valor,0) as vm2c
       into nVm2c
       from carconstr
            inner join caracter  on j48_caract = j31_codigo
            inner join carvalor  on j71_caract = j31_codigo
                                and j71_anousu = iAnousu
     where j48_matric = rConstr.j39_matric
       and j48_idcons = rConstr.j39_idcons
       and j31_grupo = 2;

     select coalesce(j71_valor,1) as fator_idade
       into nFatorIdade
       from carconstr
            inner join caracter  on j48_caract = j31_codigo
            inner join carvalor  on j71_caract = j31_codigo
                                and j71_anousu = iAnousu
     where j48_matric = rConstr.j39_matric
       and j48_idcons = rConstr.j39_idcons
       and j31_grupo = 3;

     perform fc_debug('VM2C - '||nVm2c||' FATOR IDADE - '||nFatorIdade, lRaise);

     nValorConstr := (nVm2c * rConstr.j39_area)::numeric;
     nValorConstr := nValorConstr * nFatorIdade;
     nValor       := nValor + nValorConstr;
     iNumerocontr := iNumerocontr + 1;
     nAreaconstr  := nAreaconstr + rConstr.j39_area;

     insert into tmpiptucale (anousu, matric, idcons, areaed, vm2, pontos, valor)
          values (iAnousu, iMatricula, rConstr.j39_idcons, rConstr.j39_area, nVm2c, 0, nValorConstr);

     if lAtualiza then

       update tmpdadosiptu set predial = true;
       lAtualiza = false;
     end if;

  end loop;

  /**
   * Fator de diminuicao de acordo com o setor
   *
   * 0001 - 1
   * 0111 - 0.9
   * 0150 - 0.85
   * 0160 - 0.7
   * 0170 - 0.95
   * 0255 - 0.7
   * 0640 - 0.7
   * 0650 - 0.9
   * 0655 - 0.7
   * 0660 - 0.8
   * 0670 - 0.8
   * 0690 - 0.7
   */
  select j34_setor
    into cSetor
    from lote
         inner join iptubase on j01_idbql = j34_idbql
  where j01_matric = iMatricula;

  nFatorReducaoSetor := 1;

  if cSetor = '0001' then
    nFatorReducaoSetor := 1;
  elseif cSetor = '0111' then
    nFatorReducaoSetor := 0.9;
  elseif cSetor = '0150' then
    nFatorReducaoSetor := 0.85;
  elseif cSetor = '0160' then
    nFatorReducaoSetor := 0.7;
  elseif cSetor = '0170' then
    nFatorReducaoSetor := 0.95;
  elseif cSetor = '0255' then
    nFatorReducaoSetor := 0.7;
  elseif cSetor = '0640' then
    nFatorReducaoSetor := 0.7;
  elseif cSetor = '0650' then
    nFatorReducaoSetor := 0.9;
  elseif cSetor = '0655' then
    nFatorReducaoSetor := 0.7;
  elseif cSetor = '0660' then
    nFatorReducaoSetor := 0.8;
  elseif cSetor = '0670' then
    nFatorReducaoSetor := 0.8;
  elseif cSetor = '0690' then
    nFatorReducaoSetor := 0.7;
  end if;

  perform fc_debug('FATOR DE REDUCAO PARA O SETOR '||cSetor||' : '||nFatorReducaoSetor, lRaise);
  perform fc_debug('VVC SEM FATOR DE REDUCAO POR SETOR: '||nValor::numeric, lRaise);

  /**
   * Reducao por setor
   */
  update tmpiptucale set valor = valor * nFatorReducaoSetor;

  perform fc_debug('Valor total venal predial: ' || (nValor::numeric * nFatorReducaoSetor),lRaise);

  rtp_iptu_calculavvc.rnVvc       := nValor::numeric * nFatorReducaoSetor;
  rtp_iptu_calculavvc.rnTotarea   := nAreaconstr::numeric;
  rtp_iptu_calculavvc.riNumconstr := iNumerocontr;
  rtp_iptu_calculavvc.rtDemo      := '';
  rtp_iptu_calculavvc.rbErro      := 'f';

  update tmpdadosiptu set vvc = rtp_iptu_calculavvc.rnVvc;

  return rtp_iptu_calculavvc;

end;
$$  language 'plpgsql';create or replace function fc_iptu_calculavvt_oso_2008(integer,integer,numeric,integer,boolean,boolean) returns tp_iptu_calculavvt as
$$
declare

  iMatricula   alias for $1;
  iIdbql       alias for $2;
  nFracao      alias for $3;
  iAnousu      alias for $4;
  lMostrademo  alias for $5;
  lRaise       alias for $6;

  rnAreaTotLote           numeric;
  rnArealote              numeric;
  nValor                  numeric;
  nValorVenalTerreno      numeric;

  nProfundidadeMedia      numeric default 0;
  nTopografia             numeric default 0;
  nSituacao               numeric default 0;
  nPedologia              numeric default 0;
  nFatorProfundidadeMedia numeric default 0;
  nFatorGleba             numeric default 0;
  nPotenciaArea           numeric default 0;
  nPotenciaTest           numeric default 0;
  nMedidaTestada          numeric default 0;
  nTotTestada             numeric default 0;

  iCaractlote             integer;
  bPredial                boolean;

  rtp_iptu_calculavvt tp_iptu_calculavvt%ROWTYPE;

begin

  rtp_iptu_calculavvt.rnVvt        := 0;
  rtp_iptu_calculavvt.rnAreaTotalC := 0;
  rtp_iptu_calculavvt.rnArea       := 0;
  rtp_iptu_calculavvt.rnTestada    := 0;
  rtp_iptu_calculavvt.rtDemo       := '';
  rtp_iptu_calculavvt.rtMsgerro    := '';
  rtp_iptu_calculavvt.rbErro       := false;
  rtp_iptu_calculavvt.riCoderro    := 0;
  rtp_iptu_calculavvt.rtErro       := '';

  perform fc_debug('' || lpad('',60,'-'), lRaise);
  perform fc_debug('* INICIANDO CALCULO DO VALOR VENAL TERRITORIAL', lRaise);

  select sum(j36_testad)
    into nTotTestada
    from testada
   where j36_idbql = iIdbql;

  select j34_area
    into rnArealote
    from lote
   where j34_idbql = iIdbql;

  select sum(case when j36_testle <> 0 then j36_testle else j36_testad end) as profundidade_media
    into nMedidaTestada
    from testada
         inner join testpri on testpri.j49_idbql  = testada.j36_idbql
                           and testpri.j49_face   = testada.j36_face
                           and testpri.j49_codigo = testada.j36_codigo
   where j36_idbql = iIdbql;

  nProfundidadeMedia := rnArealote / nMedidaTestada;

  perform fc_debug('IDBQL: '||iIdbql||' | AREA DO LOTE: '||rnArealote||' | PROFUNDIDADE: '||nProfundidadeMedia||' | ', lRaise);

  select case when j39_matric is not null then true else false end as predial
    into bPredial
    from iptubase
         left join iptuconstr on j39_matric = j01_matric
  where j01_matric = iMatricula
    and j39_dtdemo is null limit 1;

  if bPredial then

    select distinct
           j81_valorterreno
      into nValor
      from iptuconstr
           inner join iptubase   on j39_matric = j01_matric
           inner join lote       on j01_idbql  = j34_idbql
           inner join face       on j37_setor  = j34_setor
                                and j37_quadra = j34_quadra
                                and j37_codigo = iptuconstr.j39_codigo
           inner join facevalor  on j37_face   = j81_face
                                and j81_anousu = iAnousu
    where j39_matric = iMatricula
      and j39_dtdemo  is null
      and j39_idprinc is true;

    perform fc_debug('VALOR ENCONTRADO PELA TESTADA DA RUA DA CONSTRUCAO: '||nValor||' | ', lRaise);
  end if;

  if nValor = 0 or nValor is null or not bPredial then

    select j81_valorterreno
      into nValor
      from lote
           inner join testpri   on j49_idbql  = j34_idbql
           inner join face      on j37_face   = j49_face
           inner join facevalor on j37_face   = j81_face
                               and j81_anousu = iAnousu
    where j34_idbql = iIdbql;

    perform fc_debug('VALOR ENCONTRADO PELA TESTADA PRINCIPAL: '||nValor||' | ', lRaise);
  end if;

  if not found then

   rtp_iptu_calculavvt.rnVvt     := 0;
   rtp_iptu_calculavvt.rnArea    := 0;
   rtp_iptu_calculavvt.rtDemo    := '';
   rtp_iptu_calculavvt.rtMsgerro := ' Valor m2 do terreno nao encontrado na tabela facevalor ';
   rtp_iptu_calculavvt.riCoderro := 0;
   rtp_iptu_calculavvt.rbErro    := true;
   return rtp_iptu_calculavvt;
  end if;

  select (select j71_valor
              from carlote
                   inner join carvalor on j71_caract = j35_caract
                   inner join caracter on j71_caract = j31_codigo
             where j31_grupo  = 4
               and j71_anousu = iAnousu
               and j35_idbql  = lote.j34_idbql
             limit 1  ) as topografia,

           (select j71_valor
              from carlote
                   inner join carvalor on j71_caract = j35_caract
                   inner join caracter on j71_caract = j31_codigo
             where j31_grupo  = 5
               and j71_anousu = iAnousu
               and j35_idbql  = lote.j34_idbql
             limit 1  ) as pedologia,

           (select j71_valor
              from carlote
                   inner join carvalor on j71_caract = j35_caract
                   inner join caracter on j71_caract = j31_codigo
             where j31_grupo  = 6
               and j71_anousu = iAnousu
               and j35_idbql  = lote.j34_idbql
             limit 1  ) as situacao
     into nTopografia,
          nSituacao,
          nPedologia
     from lote
  where j34_idbql = iIdbql;

  perform fc_debug('PROFUNDIDADE MEDIA - '||nProfundidadeMedia||' | ', lRaise);

  if nProfundidadeMedia < 30 then
    nFatorProfundidadeMedia = sqrt ( nProfundidadeMedia / 30 );
  elseif nProfundidadeMedia >= 30 and nProfundidadeMedia <= 40 then
    nFatorProfundidadeMedia = 1 ;
  elseif nProfundidadeMedia > 40 and nProfundidadeMedia < 120 then
    nFatorProfundidadeMedia = ( 40 / nProfundidadeMedia );
  else
    nFatorProfundidadeMedia = 0.58;
  end if;

  perform fc_debug('FATOR PEDOLOGIA - '||nPedologia||'  | FATOR SITUACAO - '||nSituacao||' | FATOR TOPOGRAFIA - '||nTopografia||' | FATOR PROFUNDIDADE - '||nFatorProfundidadeMedia||' |', lRaise);
  perform fc_debug('AREA TOTAL DO LOTE - '||coalesce(rnArealote,0)||'  | VALOR DO M2  - '||coalesce(nValor,0)||' |', lRaise);

  nFatorGleba = 1;
  nValorVenalTerreno := rnArealote * nValor;

  if rnArealote > 3000 then

     nPotenciaArea = rnArealote ^ -0.42;
     nPotenciaTest = nTotTestada ^ 0.16;
     nFatorGleba   = 10 * nPotenciaArea *  nPotenciaTest ;

     perform fc_debug('CALCULO FATOR GLEBA : ', lRaise);
     perform fc_debug('AREA DO LOTE  : '||rnArealote||' | NUMERO DE TESTADAS : '||nTotTestada||' | ', lRaise);
     perform fc_debug('POTENCIA AREA : '||nPotenciaArea||' | POTENCIA TESTADA   : '||nPotenciaTest||' | ', lRaise);
     perform fc_debug('FATOR GLEBA   : '||nFatorGleba||' | ', lRaise);
     perform fc_debug('FORMA DE CALCULO DO FATOR GLEBA fator gleba := 10 * (arealote^0.42 / numtestadas^0.16)', lRaise);

     nValorVenalTerreno := nValorVenalTerreno * nFatorGleba;
  else
     nValorVenalTerreno := nValorVenalTerreno * nFatorProfundidadeMedia;
  end if;

  /**
   * nValorVenalTerreno := (rnArealote * nFracao  / 100) * nValor * nPedologia * nSituacao * nTopografia;
   *
   */
  perform fc_debug('CALCULO VENAL TERRENO: (nValorVenalTerreno * nFracao  / 100) * nPedologia * nSituacao * nTopografia', lRaise );
  perform fc_debug(' -> ('||coalesce(nValorVenalTerreno,0)||' * '||coalesce(nFracao,0)||'  / 100) * '||coalesce(nPedologia,0)||' * '||coalesce(nSituacao,0)||' * '||coalesce(nTopografia,0), lRaise );

  nValorVenalTerreno := (nValorVenalTerreno * nFracao  / 100) * nPedologia * nSituacao * nTopografia;

  perform fc_debug('VALOR VENAL TERRENO: ' || nValorVenalTerreno || ' - FRACAO: ' || (nFracao / 100),lRaise);

  rnAreaTotLote                 := rnArealote * (nFracao / 100);
  rtp_iptu_calculavvt.rnArea    := rnAreaTotLote;
  rtp_iptu_calculavvt.rnVvt     := nValorVenalTerreno ;
  rtp_iptu_calculavvt.rtDemo    := '';
  rtp_iptu_calculavvt.rtMsgerro := '';
  rtp_iptu_calculavvt.riCoderro := 0;
  rtp_iptu_calculavvt.rbErro    := false;

  update tmpdadosiptu set vvt = rtp_iptu_calculavvt.rnVvt, vm2t=nValor, areat=rnAreaTotLote ;

  perform fc_debug('' || lpad('',60,'-'), lRaise);

  return rtp_iptu_calculavvt;

end;
$$  language 'plpgsql';create or replace function fc_iptu_getaliquota_oso_2008(integer,integer,integer,boolean,boolean) returns numeric as
$$
declare

    iMatricula alias for $1;
    iIdbql     alias for $2;
    iNumcgm    alias for $3;
    lPredial   alias for $4;
    lRaise     alias for $5;

    rnAliquota       numeric(15,2) default 0;
    nAliqPredial     numeric(15,2) default 0;
    nAliqTerritorial numeric(15,2) default 0;
    iSetor           integer default 0;
    iCaract          integer default 0;
    iImoTerritoriais integer default 0;
    iNumcalculos     integer default 0;

begin

  perform fc_debug('DEFININDO QUAL ALIQUOTA APLICAR ...');
  perform fc_debug('IPTU : ' || case when lPredial is true then 'PREDIAL' else 'TERRITORIAL' end, lRaise);

  select j70_alipre,   j70_aliter
    into nAliqPredial, nAliqTerritorial
    from zonasaliq
         inner join lote on j34_zona = j70_zona
  where j34_idbql = iIdbql;

 if not found then
   return 0;
 end if;

 if lPredial then
   rnAliquota := nAliqPredial;
 else
   rnAliquota := nAliqTerritorial;
 end if;

 update tmpdadosiptu set aliq = rnAliquota;

 perform fc_debug('Aliquota Final: ' || rnAliquota, lRaise);

 return rnAliquota;

end;
$$  language 'plpgsql';create or replace function fc_iptu_taxalimpeza_osorio(integer,numeric,integer,numeric,numeric,boolean) returns boolean as
$$
declare

    iReceita                 alias for $1;
    iAliquota                alias for $2;
    iHistoricoCalculoIsencao alias for $3;
    nPercIsen                alias for $4;
    nValpar                  alias for $5;
    lRaise                   alias for $6;

    nValorTaxa      numeric(15,2) default 0;
    nValorDesconto  numeric(15,2) default 0;
    nInflatorURM    numeric(15,4) default 0;
    nAreaEdificada  numeric(15,2) default 0;
    iCaract         integer       default 0;
    iIdbql          integer       default 0;
    iNparc          integer       default 0;
    lPredial        boolean       default false;
    tSql            text          default '';
    iURM            integer       default 0;

  begin

    /**
     * So calcula se for predial
     */
    perform fc_debug('' || lpad('',60,'-'), lRaise);
    perform fc_debug('CALCULANDO TAXA DE COLETA DE LIXO...', lRaise);
    perform fc_debug(' <iptu_taxalimpeza_osorio> receita - ' ||iReceita||' aliq - '||iAliquota||' historico - ' || iHistoricoCalculoIsencao, lRaise);

    select coalesce( sum(areaed) ,0)
      into nAreaEdificada
      from ( select areaed, coalesce( ( select carconstr.j48_caract
                                          from carconstr
                                               inner join caracter on carconstr.j48_caract = caracter.j31_codigo
                                         where carconstr.j48_matric = tmpiptucale.matric
                                           and carconstr.j48_idcons = tmpiptucale.idcons
                                      ), 0 ) as j48_caract
              from tmpiptucale
           ) as x;

    select idbql,nparc
      into iIdbql,iNparc
      from tmpdadostaxa;

    perform fc_debug(' <iptu_taxalimpeza_osorio> iNparc: ' || iNparc, lRaise);
    perform fc_debug(' <iptu_taxalimpeza_osorio> iIdbql: ' || iIdbql, lRaise);

    if not found then
      return false;
    end if;

    perform fc_debug(' <iptu_taxalimpeza_osorio> nAreaEdificada: ' || nAreaEdificada, lRaise);


    if nAreaEdificada = 0 then
      nPercIsen := 100;
    end if;

    case
      when nAreaEdificada between 1   and 50   then
        iURM := 15;
      when nAreaEdificada between 51  and 100  then
        iURM := 30;
      when nAreaEdificada between 101 and 200  then
        iURM := 60;
      when nAreaEdificada between 201 and 300  then
        iURM := 90;
      when nAreaEdificada between 301 and 1000 then
        iURM := 120;
      when nAreaEdificada > 1000 then
        iURM := 300;
      else
        iURM := 0;
    end case;

    select i02_valor::numeric
      into nInflatorURM
      from infla
     where extract ( year from i02_data) = (select anousu
                                              from tmpiptucale
                                             limit 1)
     limit 1;

    if nInflatorURM is null or nInflatorURM = 0 then
      return false;
    end if;
    perform fc_debug(' <iptu_taxalimpeza_osorio> Percentual de Isencao: ' || nPercIsen, lRaise);

    nValorTaxa := nInflatorURM * iURM;

    perform fc_debug(' <iptu_taxalimpeza_osorio> URM: ' || iURM || ' INFLATOR: ' || nInflatorURM, lRaise);
    perform fc_debug(' <iptu_taxalimpeza_osorio> Limpeza: ' || nValorTaxa, lRaise);
    perform fc_debug(' <iptu_taxalimpeza_osorio> Inserindo tmptaxapercisen  - iReceita '||coalesce(iReceita,0)||' nPercIsen - '||coalesce(nPercIsen,0)||' nValorTaxa - ' || coalesce(nValorTaxa,0), lRaise);

    insert into tmptaxapercisen values (iReceita, nPercIsen, 0, nValorTaxa);

    if nPercIsen > 0 then

      nValorDesconto := nValorTaxa * ( nPercIsen / 100 );
      nValorTaxa     := nValorTaxa * ( 100 - nPercIsen ) / 100;
    end if;

    perform fc_debug(' <iptu_taxalimpeza_osorio> LIMPEZA COM INSENÇÃO: ' || coalesce(nValorTaxa,0) || ' DESCONTO: '|| nValorDesconto, lRaise);

    tSql := 'insert into tmprecval values ('||iReceita||','||nValorTaxa||','||iHistoricoCalculoIsencao||',true)';

    execute tSql;

    return true;

  end;
$$ language 'plpgsql';create or replace function fc_juros(integer,date,date,date,bool,integer) returns float8 as
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
$$ language 'plpgsql';insert into db_versaoant (db31_codver,db31_data) values (348, current_date);
select setval ('db_versaousu_db32_codusu_seq',(select max (db32_codusu) from db_versaousu));
select setval ('db_versaousutarefa_db28_sequencial_seq',(select max (db28_sequencial) from db_versaousutarefa));
select setval ('db_versaocpd_db33_codcpd_seq',(select max (db33_codcpd) from db_versaocpd));
select setval ('db_versaocpdarq_db34_codarq_seq',(select max (db34_codarq) from db_versaocpdarq));create table bkp_db_permissao_20141201_111357 as select * from db_permissao;
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