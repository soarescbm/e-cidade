insert into db_versao (db30_codver, db30_codversao, db30_codrelease, db30_data, db30_obs)  values (342, 3, 26, '2014-07-01', 'Tarefas: 52990, 61007, 64998, 80874, 83872, 85029, 86069, 89600, 89831, 90035, 90653, 92375, 92468, 92642, 92761, 92873, 92889, 92906, 92916, 93108, 93147, 93225, 93234, 93301, 93415, 93479, 93544, 93563, 93567, 93601, 93638, 93656, 93664, 93736, 93766, 93882, 93891, 93960, 93991, 94022, 94038, 94045, 94053, 94056, 94060, 94091, 94092, 94106, 94109, 94143, 94163, 94169, 94204, 94219, 94221, 94363, 94432, 94479, 94513, 94514, 94542, 94553, 94554, 94570, 94579, 94596, 94629, 94635, 94640, 94650, 94677, 94696, 94718, 94719, 94723, 94726, 94739, 94752, 94757, 94759, 94802, 94807, 94810, 94853, 94870, 94923, 94946, 94950, 94961, 94972, 94999, 95002, 95003, 95015, 95047, 95049, 95055, 95058, 95060, 95073, 95083, 95088, 95121, 95143, 95174, 95177, 95181, 95217, 95219, 95223, 95247, 95284, 95301, 95309, 95311, 95325, 95339, 95346, 95374, 95376, 95403, 95431, 95442, 95447, 95450, 95463, 95464, 95466, 95480, 95484, 95516, 95530, 95537, 95559, 95566, 95571, 95572, 95600, 95716, 95719, 95761, 95787, 95788, 95821, 95849, 95855, 95868, 95883, 95913, 95936, 96090');create or replace function fc_conplanoconta_inc_alt_del() returns trigger as
$$
declare 

  sNomeTabela          varchar;
  sOperacao            varchar;
                      
  sCodBancoOld         varchar;
  sCodAgenciaOld       varchar;
  sDigAgenciaOld       varchar;
                      
  sCodBancoNew         varchar;
  sCodAgenciaNew       varchar;
  sDigAgenciaNew       varchar;
                      
  sSql                 text;
 
  iCodigoBanco         integer;
  iCodigoAgencia       integer;
  iCodigoContaBancaria integer;
    
  rContaBancaria       record;
  
 
begin

  sNomeTabela := lower(TG_RELNAME);
  sOperacao   := upper(TG_OP);

  ---------
  -- Dispara UPDATE na  tabela de ligaÃ§Ã£o do servidor com a contabancÃ¡ria.
  -----------
  if sNomeTabela in ('contabancaria') and sOperacao in ( 'INSERT', 'UPDATE' ) then 

    update rhpessoalmovcontabancaria
       set rh138_contabancaria = rh138_contabancaria
     where rh138_contabancaria = new.db83_sequencial;
  end if;

  perform *
     from conparametro
    where c90_utilcontabancaria is false;

  if found then
    if sOperacao = 'UPDATE' or  sOperacao = 'INSERT' then
      return new;
    else 
      return old;
    end if;
  end if;

  if sNomeTabela = 'contabancaria' then
  
    --
    -- CASO A CONTA SE TRATE DE UMA CONTA QUE NAO SEJA DA PREFEITURA, OU SEJA, QUE O CAMPO db83_contaprefeitura SEJA FALSE
    -- NAO EH EXECUTADO AS OPERACOES DA TRIGGER, RETORNANDO OS REGISTROS SEM ALTERACOES.
    --
    if sOperacao <> 'DELETE' then
    
      if new.db83_contaplano is false then
        return new; 
      end if;
    end if;

    -- Consulta codigo do banco, agencia e digito apartir do bancoagencia cadastrado  anteriormente
    if sOperacao = 'UPDATE' then 
    
      select db_bancos.db90_codban,
             bancoagencia.db89_codagencia,
             bancoagencia.db89_digito
        into sCodBancoOld,
             sCodAgenciaOld,
             sDigAgenciaOld
        from bancoagencia 
             inner join db_bancos on db_bancos.db90_codban = bancoagencia.db89_db_bancos
       where bancoagencia.db89_sequencial = old.db83_bancoagencia;
      
      
      -- Verifica se foi alterado db83_bancoagencia;
      
      if  old.db83_bancoagencia != new.db83_bancoagencia then 
      
        -- Consulta codigo do banco, agencia e digito apartir do bancoagencia novo
        select db_bancos.db90_codban,
               bancoagencia.db89_codagencia,
               bancoagencia.db89_digito
          into sCodBancoNew,
               sCodAgenciaNew,
               sDigAgenciaNew
          from bancoagencia 
               inner join db_bancos on db_bancos.db90_codban = bancoagencia.db89_db_bancos
         where bancoagencia.db89_sequencial = new.db83_bancoagencia;
      
      else       
        sCodBancoNew   := sCodBancoOld;  
        sCodAgenciaNew := sCodAgenciaOld;
        sDigAgenciaNew := sDigAgenciaOld;
      
      end if;    
      
      update conplanoconta
         set c63_banco          = sCodBancoNew,
             c63_agencia        = sCodAgenciaNew,
             c63_conta          = new.db83_conta,
             c63_dvconta        = new.db83_dvconta,
             c63_dvagencia      = sDigAgenciaNew,
             c63_identificador  = new.db83_identificador,
             c63_codigooperacao = new.db83_codigooperacao,
             c63_tipoconta      = new.db83_tipoconta
       where c63_banco          = sCodBancoOld
         and c63_agencia        = sCodAgenciaOld 
         and c63_conta          = old.db83_conta
         and c63_dvconta        = old.db83_dvconta
         and c63_dvagencia      = sDigAgenciaOld
         and c63_identificador  = old.db83_identificador
         and c63_codigooperacao = old.db83_codigooperacao
         and c63_tipoconta      = old.db83_tipoconta;
      
   end if;

  elsif sNomeTabela = 'bancoagencia' then  

     update conplanoconta 
        set c63_banco     = new.db89_db_bancos,
            c63_agencia   = new.db89_codagencia,
            c63_dvagencia = new.db89_digito            
      where c63_banco     = old.db89_db_bancos
        and c63_agencia   = old.db89_codagencia
        and c63_dvagencia = old.db89_digito;


  elsif sNomeTabela = 'conplanocontabancaria' then

    if sOperacao = 'DELETE' then
      iCodigoContaBancaria = old.c56_contabancaria;
    else
      iCodigoContaBancaria = new.c56_contabancaria;
    end if;
  
    raise notice 'sOperacao :%', sOperacao;
    
    select *
      into rContaBancaria
      from contabancaria
           inner join bancoagencia on bancoagencia.db89_sequencial = contabancaria.db83_bancoagencia
     where contabancaria.db83_sequencial = iCodigoContaBancaria;
    
     raise notice 'rContaBancaria.db83_contaplano :%',rContaBancaria.db83_contaplano;
     
    if rContaBancaria.db83_contaplano is true then

      raise notice 'sOperacao: %', sOperacao;
      if sOperacao = 'INSERT' then 
    
        perform * 
           from conplanoconta 
          where c63_codcon = new.c56_codcon
            and c63_anousu = new.c56_anousu;
  
        if found then
  
          update conplanoconta
             set c63_banco          = rContaBancaria.db89_db_bancos,
                 c63_agencia        = rContaBancaria.db89_codagencia,
                 c63_conta          = rContaBancaria.db83_conta,
                 c63_dvconta        = rContaBancaria.db83_dvconta,
                 c63_dvagencia      = rContaBancaria.db89_digito,
                 c63_identificador  = rContaBancaria.db83_identificador,
                 c63_codigooperacao = rContaBancaria.db83_codigooperacao,
                 c63_tipoconta      = rContaBancaria.db83_tipoconta 
           where c63_codcon         = new.c56_codcon
             and c63_anousu         = new.c56_anousu;
  
        else 
  
          insert into conplanoconta ( c63_codcon, 
                                      c63_anousu, 
                                      c63_banco,
                                      c63_agencia,
                                      c63_conta,
                                      c63_dvconta,
                                      c63_dvagencia,
                                      c63_identificador,
                                      c63_codigooperacao,
                                      c63_tipoconta 
                                    ) values (
                                      new.c56_codcon,
                                      new.c56_anousu,
                                      rContaBancaria.db89_db_bancos,
                                      rContaBancaria.db89_codagencia,
                                      rContaBancaria.db83_conta,
                                      rContaBancaria.db83_dvconta,
                                      rContaBancaria.db89_digito,
                                      rContaBancaria.db83_identificador,
                                      rContaBancaria.db83_codigooperacao,
                                      rContaBancaria.db83_tipoconta 
                                    );
        end if; 
  
      elsif sOperacao = 'UPDATE' then      
  
        perform 1 
           from conplanoconta
          where conplanoconta.c63_codcon = new.c56_codcon
            and conplanoconta.c63_anousu = new.c56_anousu;
            
        if found then
        
          sSql := ' select *
                      from contabancaria
                           inner join bancoagencia on bancoagencia.db89_sequencial = contabancaria.db83_bancoagencia
                     where contabancaria.db83_sequencial = '||new.c56_contabancaria;
          for rContaBancaria in execute sSql loop
           
            update conplanoconta
               set c63_codcon         = new.c56_codcon,
                   c63_anousu         = new.c56_anousu,
                   c63_banco          = rContaBancaria.db89_db_bancos,
                   c63_agencia        = rContaBancaria.db89_codagencia,
                   c63_conta          = rContaBancaria.db83_conta,
                   c63_dvconta        = rContaBancaria.db83_dvconta,
                   c63_dvagencia      = rContaBancaria.db89_digito,
                   c63_identificador  = rContaBancaria.db83_identificador,
                   c63_codigooperacao = rContaBancaria.db83_codigooperacao,
                   c63_tipoconta      = rContaBancaria.db83_tipoconta 
             where c63_codcon         = old.c56_codcon
               and c63_anousu         = old.c56_anousu;
          
          end loop;
          
        else 
        
          sSql := ' select *
                      from contabancaria
                           inner join bancoagencia on bancoagencia.db89_sequencial = contabancaria.db83_bancoagencia
                     where contabancaria.db83_sequencial = '||new.c56_contabancaria;
          for rContaBancaria in execute sSql loop
           
            insert into conplanoconta ( c63_codcon         , 
                                        c63_anousu         , 
                                        c63_banco          , 
                                        c63_agencia        , 
                                        c63_conta          , 
                                        c63_dvconta        , 
                                        c63_dvagencia      , 
                                        c63_identificador  , 
                                        c63_codigooperacao , 
                                        c63_tipoconta )
                               values ( new.c56_codcon,                         
                                        new.c56_anousu,                         
                                        rContaBancaria.db89_db_bancos,          
                                        rContaBancaria.db89_codagencia,         
                                        rContaBancaria.db83_conta,              
                                        rContaBancaria.db83_dvconta,            
                                        rContaBancaria.db89_digito,             
                                        rContaBancaria.db83_identificador,      
                                        rContaBancaria.db83_codigooperacao,     
                                        rContaBancaria.db83_tipoconta );                          
               
          end loop;
                                   
        end if;
  
      elsif sOperacao = 'DELETE' then 
    
  
        delete from conplanoconta 
              where c63_codcon = old.c56_codcon
                and c63_anousu = old.c56_anousu;
  
   
      end if;
    
    end if;
   
  end if; 


return old;

end;
$$
language 'plpgsql';

/**
 * Antigo nome da trigger, alterado para "tg_contabancaria_inc_alt_del"
 */
drop   trigger if exists tg_contabancaria_alt on contabancaria;

drop   trigger if exists tg_contabancaria_inc_alt_del on contabancaria;
create trigger tg_contabancaria_inc_alt_del after INSERT OR DELETE OR UPDATE on contabancaria for each row execute procedure fc_conplanoconta_inc_alt_del();

drop   trigger if exists tg_bancoagencia_alt  on bancoagencia;
create trigger tg_bancoagencia_alt  after update on bancoagencia for each row execute procedure fc_conplanoconta_inc_alt_del();


drop   trigger if exists tg_conplanocontabancaria_inc_alt_del on conplanocontabancaria;
create trigger tg_conplanocontabancaria_inc_alt_del after insert or update or delete on conplanocontabancaria for each row execute procedure fc_conplanoconta_inc_alt_del();-- 00 Liberado para execucao
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
         --and c75_data >= v_dtini 
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
        v_vlrpag := round(v_vlrpag + c_lanc.c70_valor,2)::float8;
      end if;
      v_vlrpag_g := round(v_vlrpag_g + c_lanc.c70_valor,2)::float8;
     
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
language 'plpgsql';drop trigger  if exists tg_pensaocontabancaria     on pensaocontabancaria;
drop function if exists fc_pensaocontabancaria_trigger();

create or replace function fc_pensaocontabancaria_trigger()
returns trigger 
as $$
declare 
  rDados     record;
  sBanco     varchar;
  sAgencia   varchar;
  sDVAgencia varchar;
  sConta     varchar;
  sDVConta   varchar;
  lTrigger   varchar default 'false';
begin
  
select fc_getsession('DB_disable_trigger')
    into lTrigger; 
  
  if lTrigger = 'true' then 
    return rDados;
  end if;

  if TG_OP in ('INSERT', 'UPDATE') then
    rDados := new;
  else 
    rDados := old; 
  end if;


  if TG_OP in ('INSERT', 'UPDATE') then
 
    perform fc_putsession('DB_disable_trigger', 'true');

    select db89_db_bancos,   
           db89_codagencia,  
           db89_digito,      
           db83_conta,       
           db83_dvconta      
      into sBanco,    
           sAgencia,  
           sDVAgencia,
           sConta,    
           sDVConta   
      from contabancaria     
     inner join pensaocontabancaria       on rh139_contabancaria = db83_sequencial
     inner join bancoagencia              on db89_sequencial     = db83_bancoagencia
     inner join rhpessoalmov              on rh02_regist         = rDados.rh139_regist
                                         and rh02_anousu         = rDados.rh139_anousu
                                         and rh02_mesusu         = rDados.rh139_mesusu
     inner join pensao                    on r52_anousu          = rDados.rh139_anousu
                                         and r52_mesusu          = rDados.rh139_mesusu
                                         and r52_regist          = rDados.rh139_regist
                                         and r52_numcgm          = rDados.rh139_numcgm 
     where rh139_sequencial = rDados.rh139_sequencial;


    if found then
      update pensao
         set r52_codbco    = sBanco, 
             r52_codage    = sAgencia, 
             r52_dvagencia = sDVAgencia, 
             r52_conta     = sConta, 
             r52_dvconta   = sDVConta
       where r52_regist    = rDados.rh139_regist
         and r52_anousu    = rDados.rh139_anousu
         and r52_mesusu    = rDados.rh139_mesusu
         and r52_numcgm    = rDados.rh139_numcgm;
    end if;

    perform fc_putsession('DB_disable_trigger', 'false');
  else --TG_OP = 'DELETE'
    delete from pensao where r52_regist    = rDados.rh139_regist
                         and r52_anousu    = rDados.rh139_anousu
                         and r52_mesusu    = rDados.rh139_mesusu
                         and r52_numcgm    = rDados.rh139_numcgm; 
  end if;

  return rDados;
end;
$$ language 'plpgsql';

CREATE TRIGGER tg_pensaocontabancaria AFTER
INSERT OR UPDATE OR DELETE
    ON pensaocontabancaria
   FOR EACH ROW EXECUTE PROCEDURE fc_pensaocontabancaria_trigger();drop trigger  if exists tg_pensao     on pensao;
drop trigger  if exists tg_pensao2     on pensao;
drop function if exists fc_pensao_trigger();

create or replace function fc_pensao_trigger()
returns trigger 
as $$
declare 
  sCodigoBanco varchar default null;
  sAgencia     varchar default null;
  sConta       varchar default null;
  rOperacao    record;

  -- Utilizados em contaBancaria
  sNomeServidor             varchar default '';
  iSequencialAgencia        integer;
  iSequencialContaBancaria  integer;
  iSequencialContaServidor  integer;

  TIPO_CONTA_CORRENTE  constant integer := 1;
  TIPO_CONTA_POUPANCA  constant integer := 2;
  TIPO_CONTA_APLICACAO constant integer := 3;
  TIPO_CONTA_SALARIO   constant integer := 4;

  lTrigger   varchar default 'false';
begin
  
  select fc_getsession('DB_disable_trigger')
    into lTrigger; 
  
  
  if ( TG_OP != 'DELETE' ) then 

    rOperacao := new;
  else 
    
    rOperacao := old;
  end if;

  if lTrigger = 'true' then 
    return rOperacao;
  end if;

  --
  -- Quando alterar dados da conta bancaria do pensionista(pensao)
  -- Alterar tambem dados da conta bancaria do sistema (contabancaria e bancoagencia)
  --

  if TG_OP in ( 'INSERT', 'UPDATE' ) then 
    
    perform fc_putsession('DB_disable_trigger', 'true');
    
    if rOperacao.r52_codbco is null or rOperacao.r52_codage is null or rOperacao.r52_conta   is null 
       or rOperacao.r52_codbco = '' or rOperacao.r52_codage = ''    or rOperacao.r52_conta = '' then 

      delete 
        from pensaocontabancaria 
       where rh139_regist   = rOperacao.r52_regist 
         and rh139_anousu   = rOperacao.r52_anousu 
         and rh139_mesusu   = rOperacao.r52_mesusu 
         and rh139_numcgm   = rOperacao.r52_numcgm; 
      perform fc_putsession('DB_disable_trigger', 'false');
      return rOperacao;
    end if;
    --
    -- Verifica se existe Agencia com os dados informados
    -- 
    select z01_nome 
      into sNomeServidor 
      from cgm 
     where z01_numcgm = rOperacao.r52_numcgm;
    
    select db89_sequencial
      into iSequencialAgencia
      from bancoagencia 
     where db89_db_bancos  = rOperacao.r52_codbco
       and db89_codagencia = rOperacao.r52_codage
       and db89_digito     = rOperacao.r52_dvagencia;
    --
    -- Caso no encontre, cria uma nova com os dados informados.
    --
    if not found then 
      
      select nextval('bancoagencia_db89_sequencial_seq')
        into iSequencialAgencia;

      insert into bancoagencia (db89_sequencial, db89_db_bancos, db89_codagencia, db89_digito)
           values ( iSequencialAgencia, rOperacao.r52_codbco, rOperacao.r52_codage, rOperacao.r52_dvagencia );
    end if;

    select db83_sequencial 
      into iSequencialContaBancaria
      from contabancaria
     where db83_bancoagencia = iSequencialAgencia
       and db83_conta        = rOperacao.r52_conta
       and db83_dvconta      = rOperacao.r52_dvconta 
     limit 1;

    if not found then 
      
      select nextval('contabancaria_db83_sequencial_seq')
        into iSequencialContaBancaria;

      insert into contabancaria (
        db83_sequencial,
        db83_descricao,
        db83_bancoagencia,
        db83_conta,
        db83_dvconta,
        db83_identificador,
        db83_codigooperacao,
        db83_tipoconta,
        db83_contaplano
      ) values (
        iSequencialContaBancaria,
        sNomeServidor,
        iSequencialAgencia,
        rOperacao.r52_conta,
        rOperacao.r52_dvconta,
        '0',
        '', 
        TIPO_CONTA_CORRENTE,
        false -- Conta do Plano de Contas da Prefeitura
    );
    end if;

     select rh139_sequencial
       into iSequencialContaServidor
       from pensaocontabancaria 
      where rh139_regist   = rOperacao.r52_regist 
        and rh139_anousu   = rOperacao.r52_anousu 
        and rh139_mesusu   = rOperacao.r52_mesusu 
        and rh139_numcgm   = rOperacao.r52_numcgm; 
    if found then     
       
      update pensaocontabancaria
         set rh139_contabancaria = iSequencialContaBancaria
       where rh139_sequencial    = iSequencialContaServidor;
    else 

      insert into pensaocontabancaria (
        rh139_sequencial,
        rh139_regist,
        rh139_numcgm,
        rh139_anousu,
        rh139_mesusu,
        rh139_contabancaria
      ) values (
        nextval('pensaocontabancaria_rh139_sequencial_seq'), 
        rOperacao.r52_regist,
        rOperacao.r52_numcgm,
        rOperacao.r52_anousu,
        rOperacao.r52_mesusu,
        iSequencialContaBancaria
      );
    end if;

    perform fc_putsession('DB_disable_trigger', 'false');
  else -- TG_OP = 'DELETE'

    perform fc_putsession('DB_disable_trigger', 'true');
    delete from pensaocontabancaria where rh139_regist    = rOperacao.r52_regist
                                      and rh139_anousu    = rOperacao.r52_anousu
                                      and rh139_mesusu    = rOperacao.r52_mesusu
                                      and rh139_numcgm    = rOperacao.r52_numcgm;
    perform fc_putsession('DB_disable_trigger', 'false');
  end if;

  return rOperacao;
end;
$$ language 'plpgsql';

CREATE TRIGGER tg_pensao AFTER
INSERT OR UPDATE
    ON pensao
   FOR EACH ROW EXECUTE PROCEDURE fc_pensao_trigger();

CREATE TRIGGER tg_pensao2 BEFORE
DELETE
    ON pensao
   FOR EACH ROW EXECUTE PROCEDURE fc_pensao_trigger();drop trigger  if exists tg_rhpesbanco     on rhpesbanco;
drop trigger  if exists tg_rhpesbanco_alt on rhpesbanco;
drop function if exists fc_rhpesbanco_alt(); --Removendo versÃµes antigas
drop function if exists fc_rhpesbanco_inc(); --Removendo versÃµes antigas
drop function if exists fc_rhpesbanco_exc(); --Removendo versÃµes antigas
drop function if exists fc_rhpesbanco_trigger();

create or replace function fc_rhpesbanco_trigger()
returns trigger 
as $$
declare 
  iMatricula   integer;
  sCompetencia integer;
  iAno	       integer;
  iMes	       integer;
  sCodigoBanco varchar default null;
  sAgencia     varchar default null;
  sConta       varchar default null;
  iSeqPes      integer;
  iInstituicao integer;
  rOperacao    record;

  -- Utilizados em contaBancaria
  sNomeServidor             varchar default '';
  iSequencialAgencia        integer;
  iSequencialContaBancaria  integer;
  iSequencialContaServidor  integer;

  TIPO_CONTA_CORRENTE  constant integer := 1;
  TIPO_CONTA_POUPANCA  constant integer := 2;
  TIPO_CONTA_APLICACAO constant integer := 3;
  TIPO_CONTA_SALARIO   constant integer := 4;

  lTrigger   varchar default 'false';
begin
  
  select fc_getsession('DB_disable_trigger')
    into lTrigger; 
  
  
  if ( TG_OP != 'DELETE' ) then 

    rOperacao := new;
    iSeqPes := new.rh44_seqpes;
  else 
    
    rOperacao := old;
    iSeqPes := old.rh44_seqpes;
  end if;

  if lTrigger = 'true' then 
    return rOperacao;
  end if;

  select max( r11_anousu || lpad(r11_mesusu,2,0) ) into sCompetencia from cfpess;
  iAno := substr(sCompetencia,1,4)::int;
  iMes := substr(sCompetencia,5,2)::int;
  
  --
  -- Altera Dados no da tabela pessoal
  -- 
  select r01_regist 
    into iMatricula
    from pessoal 
         inner join rhpessoalmov 	on rh02_anousu = r01_anousu 
  	 		                         and rh02_mesusu = r01_mesusu 
  			                         and rh02_instit = r01_instit 
  			                         and rh02_regist = r01_regist 
   where r01_anousu  = iAno 
     and r01_mesusu  = iMes
     and rh02_seqpes = iSeqPes;
 
  if found then
    
    if ( TG_OP not ilike 'DELETE' ) then 
      sCodigoBanco := new.rh44_codban;
      sAgencia     := substr( trim(new.rh44_agencia) || trim(new.rh44_dvagencia), 1,  5);
      sConta       := substr( trim(new.rh44_conta)   || trim(new.rh44_dvconta),   1, 15);
    end if;

    update pessoal
       set r01_banco  = sCodigoBanco,
           r01_agenc  = sAgencia,     
           r01_contac = sConta      
     where r01_regist = iMatricula
       and r01_anousu = iAno
       and r01_mesusu = iMes;
  end if;

  --
  -- Quando alterar dados da conta bancaria do servidor(rhpesbanco)
  -- Alterar tambem dados da conta bancaria do sistema (contabancaria e bancoagencia)
  --

  if TG_OP in ( 'INSERT', 'UPDATE' ) then 

    perform fc_putsession('DB_disable_trigger', 'true');
    --
    -- Verifica se existe Agencia com os dados informados
    -- 
    select z01_nome, 
           rh01_instit
      into sNomeServidor, 
           iInstituicao
      from cgm 
           inner join rhpessoal    on rh01_numcgm = z01_numcgm
           inner join rhpessoalmov on rh01_regist = rh02_regist
                                  and rh02_seqpes = new.rh44_seqpes;

    select db89_sequencial
      into iSequencialAgencia
      from bancoagencia 
     where db89_db_bancos  = new.rh44_codban
       and db89_codagencia = new.rh44_agencia
       and db89_digito     = new.rh44_dvagencia;
    --
    -- Caso nÃ£o encontre, cria uma nova com os dados informados.
    --
    if not found then 
      
      select nextval('bancoagencia_db89_sequencial_seq')
        into iSequencialAgencia;

      insert into bancoagencia (db89_sequencial, db89_db_bancos, db89_codagencia, db89_digito)
           values ( iSequencialAgencia, new.rh44_codban, new.rh44_agencia, new.rh44_dvagencia );
    end if;

    select db83_sequencial 
      into iSequencialContaBancaria
      from contabancaria
     where db83_bancoagencia = iSequencialAgencia
       and db83_conta        = new.rh44_conta
       and db83_dvconta      = new.rh44_dvconta 
     limit 1;

    if not found then 
      
      select nextval('contabancaria_db83_sequencial_seq')
        into iSequencialContaBancaria;

      insert into contabancaria (
        db83_sequencial,
        db83_descricao,
        db83_bancoagencia,
        db83_conta,
        db83_dvconta,
        db83_identificador,
        db83_codigooperacao,
        db83_tipoconta,
        db83_contaplano
      ) values (
        iSequencialContaBancaria,
        sNomeServidor,
        iSequencialAgencia,
        new.rh44_conta,
        new.rh44_dvconta,
        '0',
        '', 
        TIPO_CONTA_CORRENTE,
        false -- Conta do Plano de Contas da Prefeitura
    );
    end if;

     select rh138_sequencial
       into iSequencialContaServidor
       from rhpessoalmovcontabancaria 
      where rh138_rhpessoalmov = new.rh44_seqpes
        and rh138_instit       = iInstituicao;

    if found then     
       
      update rhpessoalmovcontabancaria
         set rh138_contabancaria = iSequencialContaBancaria
       where rh138_sequencial    = iSequencialContaServidor;
    else 

      insert into rhpessoalmovcontabancaria (
        rh138_sequencial,
        rh138_rhpessoalmov,
        rh138_contabancaria,
        rh138_instit
      ) values (
        nextval('rhpessoalmovcontabancaria_rh138_sequencial_seq'), 
        iSeqPes,
        iSequencialContaBancaria,
        iInstituicao
      );
    end if;

    perform fc_putsession('DB_disable_trigger', 'false');
  else -- TG_OP = 'DELETE'
    delete from rhpessoalmovcontabancaria where rh138_rhpessoalmov = rOperacao.rh44_seqpes;
  end if;

  return rOperacao;
end;
$$ language 'plpgsql';

CREATE TRIGGER tg_rhpesbanco AFTER
INSERT OR UPDATE OR DELETE
    ON rhpesbanco
   FOR EACH ROW EXECUTE PROCEDURE fc_rhpesbanco_trigger();drop trigger  if exists tg_rhpessoalmovcontabancaria     on rhpessoalmovcontabancaria;
drop function if exists fc_rhpessoalmovcontabancaria_trigger();

create or replace function fc_rhpessoalmovcontabancaria_trigger()
returns trigger 
as $$
declare 
  rDados     record;
  iSeqPes    integer; 
  sBanco     varchar;
  sAgencia   varchar;
  sDVAgencia varchar;
  sConta     varchar;
  sDVConta   varchar;
  lTrigger   varchar default 'false';
begin
  
  select fc_getsession('DB_disable_trigger')
    into lTrigger; 
  
  if lTrigger = 'true' then 
    return rDados;
  end if;

  if TG_OP in ('INSERT', 'UPDATE') then
    rDados := new;
  else 
    rDados := old; 
  end if;


  if TG_OP in ('INSERT', 'UPDATE') then
 
    perform fc_putsession('DB_disable_trigger', 'true');

    select rh02_seqpes,                                                              
           db89_db_bancos,   
           db89_codagencia,  
           db89_digito,      
           db83_conta,       
           db83_dvconta      
      into iSeqPes,
           sBanco,    
           sAgencia,  
           sDVAgencia,
           sConta,    
           sDVConta   


      from contabancaria     
     inner join rhpessoalmovcontabancaria on rh138_contabancaria = db83_sequencial
     inner join bancoagencia              on db89_sequencial     = db83_bancoagencia
     inner join rhpessoalmov              on rh02_seqpes         = rDados.rh138_rhpessoalmov
                                         and rh02_instit         = rDados.rh138_instit
     where rh138_sequencial = rDados.rh138_sequencial;

    perform 1
       from rhpesbanco
      where rh44_seqpes = rDados.rh138_rhpessoalmov;

    if not found then 
      insert into rhpesbanco values (iSeqPes, sBanco, sAgencia, sDVAgencia, sConta, sDVConta);
    else 
      update rhpesbanco
         set rh44_codban    = sBanco, 
             rh44_agencia   = sAgencia, 
             rh44_dvagencia = sDVAgencia, 
             rh44_conta     = sConta, 
             rh44_dvconta   = sDVConta
       where rh44_seqpes    = rDados.rh138_rhpessoalmov;
    end if;

    perform fc_putsession('DB_disable_trigger', 'false');
  else --TG_OP = 'DELETE'
    delete from rhpesbanco where rh44_seqpes    = rDados.rh138_rhpessoalmov;
  end if;

  return rDados;
end;
$$ language 'plpgsql';

CREATE TRIGGER tg_rhpessoalmovcontabancaria AFTER
INSERT OR UPDATE OR DELETE
    ON rhpessoalmovcontabancaria
   FOR EACH ROW EXECUTE PROCEDURE fc_rhpessoalmovcontabancaria_trigger();DROP TYPE IF EXISTS configuracoes.tp_auditoria_consulta_mudancas CASCADE;
CREATE TYPE configuracoes.tp_auditoria_consulta_mudancas AS (
	esquema           TEXT,
	tabela            TEXT,
	operacao          CHAR(1),
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

	sSQL := 'SELECT * FROM configuracoes.db_auditoria ';
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
	IF tDataHoraInicio < tInicioAno AND lExisteBaseAuditoria IS TRUE THEN
		sConexaoRemota := 'auditoria';
		IF array_position(sConexaoRemota, dblink_get_connections()) IS NULL THEN
			PERFORM dblink_connect(sConexaoRemota, 'dbname='||sBaseAuditoria);
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
						instit             integer);
			IF NOT FOUND THEN
				EXIT;
			END IF;

			rRetorno.esquema           = rAuditoria.esquema;
			rRetorno.tabela            = rAuditoria.tabela;
			rRetorno.operacao          = rAuditoria.operacao;
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
LANGUAGE sql;CREATE OR REPLACE FUNCTION configuracoes.fc_auditoria_existe_mudanca(
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
) RETURNS BOOLEAN AS
$$
DECLARE
	sSQL			TEXT;
	sConector		TEXT DEFAULT 'OR';
	sConexaoRemota	TEXT;
	sBaseAuditoria	TEXT DEFAULT current_database()||'_auditoria';

	tInicioAno				TIMESTAMPTZ;
	lExisteBaseAuditoria	BOOLEAN;
	lRetorno				BOOLEAN DEFAULT FALSE;
BEGIN
	lExisteBaseAuditoria := EXISTS (SELECT 1 FROM pg_database WHERE datname = sBaseAuditoria);

	sSQL := 'SELECT EXISTS (SELECT 1 FROM configuracoes.db_auditoria ';
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

	sSQL := sSQL || ')';

	tInicioAno := (extract(year from current_date)||'-01-01 00:00:00.00000')::timestamptz;

	-- SE o ano da Data/Hora de inicio for igual ao ano da Data/Hora corrente 
	-- OU a base de auditoria NAO EXISTIR, entao executa a query na base corrente
	IF extract(year from tDataHoraInicio) = extract(year from current_date) OR lExisteBaseAuditoria IS FALSE THEN
		EXECUTE sSQL INTO lRetorno;
	END IF;

	IF lRetorno IS TRUE THEN
		RETURN lRetorno;
	END IF;

	-- SE a Data/Hora de inicio for menor que o Inicio do Ano Corrente 
	-- E  a base de auditoria EXISTIR, entao executa a query na base de auditoria
	IF tDataHoraInicio < tInicioAno AND lExisteBaseAuditoria IS TRUE THEN
		sConexaoRemota := 'auditoria';
		IF array_position(sConexaoRemota, dblink_get_connections()) IS NULL THEN
			PERFORM dblink_connect(sConexaoRemota, 'dbname='||sBaseAuditoria);
		END IF;

		SELECT	retorno
		INTO	lRetorno
		FROM	dblink(sConexaoRemota, sSQL) AS (retorno BOOLEAN);
	END IF;

	RETURN lRetorno;
END;
$$
LANGUAGE plpgsql;create or replace function fc_calculaprecomedio(integer, integer, float8, boolean)
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
     --raise exception 'Instituicao não informada.';
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
      
    raise notice 'Valor unitario: %', nValorUnitario;
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
      and m81_tipo not in(4);
   
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
       and m81_tipo not in(4);
       raise notice 'Qtd estoque Dif:%, ValDif: %', nQuantidadeEstoqueDiferenca, nValorEstoqueDiferenca;
       raise notice 'Qtd estoque:% ValorEstoque: %', nQuantidadeEstoque, nValorEstoque;
       nQuantidadeEstoque := nQuantidadeEstoque - nQuantidadeEstoqueDiferenca;
       nValorEstoque      := nValorEstoque      - nValorEstoqueDiferenca;

      raise notice 'Depois Qtd estoque:% VAl est : %', nQuantidadeEstoque, nValorEstoque;
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
   raise notice 'Material: % PrecoMedio: % Estoque: %, Hora: % Instituicao: %',iMaterial, nPrecoMedio, nQuantidadeEstoque, thora, iInstituicao;
  /**
   * Verificamos as entradas no estoque (refletem no calculo do preço medio)
   * algumas entradas, que na verdade são cancelamentos de saidas, devem entrar no estoque
   * pelo preco médio atual, não alterando o preço do calculo médio. 
   */
  if iCodigoMovimento in(8, 1, 3, 12, 14, 15) then 
       
    /**
     * como o sistema já inclui as informações do estoque na hora de verificarmos o preço médio, 
     * devemos deduzir a quantidade da entrada, (nQuantidade - m82_quant). a regra do calculo do preço médio é:
     * pegamos a quantidade anterior em estoque, e multiplicamos pelo ultimo preço médio.
     * - Somamos a nova entrada (quantidade e valor da entrada,) e dividimos o valor encontrado pela quantidade 
     * encontrada. o resultado dessa divisão, encontramos o preço médio. 
     */
    --nValorEstoque      = round(nQuantidadeEstoque * nPrecoMedio, 2);
    nQuantidadeEstoque = nQuantidadeEstoque  + nQuantidadeMovimento;
    raise notice 'Valor Estoque:% Valor Unitario: %', nValorEstoque, nValorUnitario;
    nValorEstoque      = round(nValorEstoque + (nQuantidadeMovimento*nValorUnitario), 2);
    raise notice 'Valor Estoque:% Valor Unitario: % QTDE: %', nValorEstoque, nValorUnitario, nQuantidadeEstoque;
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
        and m87_matestoqueini = iCodigoMatestoqueini;
    
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
language 'plpgsql';--
-- Funcao que efetua calculo/re-calculo de uma matricula especifica
--
-- Parametros: 1 - Ano de Referencia
--             2 - Mes de Referencia
--             3 - Matricula
--             4 - Tipo de movimentacao aguacalc(1 - Parcial, 2 - Geral, 3 Coletor)
--             5 - Troca Numpre? (Qdo houver recalculo)
--             6 - Gera Financeiro? (arrecad, arrematric, arrenumcgm, arreold)
--
SET check_function_bodies TO off; 

drop function if exists fc_agua_calculoparcial(integer, integer, integer, integer, bool, bool);

create or replace function fc_agua_calculoparcial(integer, integer, integer, integer, bool, bool) returns varchar as 
$$
declare
  ---------------------- Parametros
  iAno             alias for $1;
  iMes             alias for $2;
  iMatric          alias for $3;
  iTipo            alias for $4;
  lTrocaNumpre     alias for $5;
  lGeraFinanceiro  alias for $6;
  ----------------------- Variaveis
  sMemoria         text   := ''; -- Campo que contera a memoria de Calculo da Matricula
  sHora            text   := '';
  dData            date   := null;
  nConsumo         float8 := 0;
  nExcesso         float8 := 0;
  nSaldoComp       float8 := 0;
  lTaxaBasica      bool   := false;
  rCalculo         record;  
  rAguaBase        record;
  rCondominio      record;
  iUsuario         integer;
  iInstit          integer;
  iEconomias       integer;
  iConsumo         integer;
  iNumpre          integer;
  iNumpreOld       integer;
  iCodCalc         integer;
  iCondominio      integer;
  iApto            integer;
  iTipoImovel      integer;
  nValorTemp       float8 := 0;
  nPercentualIsencao   float4 := 0;
  lAguaLigada      bool := false;
  lSemAgua         bool := false;
  lEsgotoLigado    bool := false;
  lSemEsgoto       bool := false;
  lRecalculo       bool := false;
  lGeraArrecad     bool := true;
  lRaise           bool := true;
  nAreaConstr      float4 := 0;
  lGeraDesconto    bool := false;
  dDataVenc       date;
begin
	
	dDataVenc := fc_agua_datavencimento(iAno, iMes, iMatric);
  -- 1) Verifica se Existe Hidrometro Instalado
  if fc_agua_hidrometroinstalado(iMatric) = false then
    lTaxaBasica := true;
  else
    -- 1.1) Verifica Consumo e Excesso
    nConsumo   := fc_agua_consumo(iAno, iMes, iMatric);
    nExcesso   := fc_agua_excesso(iAno, iMes, iMatric);
    nSaldoComp := fc_agua_saldocompensado(iAno, iMes, iMatric);
    
    if (nConsumo + nExcesso) = 0 then 
      -- E R R O !!!!
      lTaxaBasica := true;
    end if;
    
  end if;
  
  -- Busca dados da Matricula
  select * 
    into rAguaBase
    from aguabase
   where x01_matric = iMatric;

  -- 2) Verifica dados para Calculo
  lGeraArrecad  := lGeraFinanceiro;
  iEconomias    := rAguaBase.x01_qtdeconomia;
  iConsumo      := fc_agua_consumocodigo(iAno, iMatric, rAguaBase.x01_zona);
  lAguaLigada   := fc_agua_agualigada(iAno, iMatric);
  lEsgotoLigado := fc_agua_esgotoligado(iAno, iMatric);
  lSemAgua      := fc_agua_semagua(iAno, iMatric);
  lSemEsgoto    := fc_agua_semesgoto(iAno, iMatric);
  nAreaConstr   := fc_agua_areaconstr(iMatric);  
  --iNumpre       := fc_agua_numpre();
  iCodCalc      := fc_agua_calculocodigo(iAno, iMes, iMatric);

  if iConsumo is null then
    return '2 - NÃO FOI POSSÍVEL ENCONTRAR CONFIGURAÇÃO DE CONSUMO PARA MATRÍCULA '||iMatric||' EXERCÍCIO '||iAno||' ZONA '||rAguaBase.x01_zona;
  end if;
  
  
  if iCodCalc is not null then
    lRecalculo := true;
  end if;
  
  -- 3) Verifica se eh matricula de condominio e apto
  iCondominio := fc_agua_condominiocodigo(iMatric);
  iApto       := fc_agua_condominioapto(iMatric);
  
 if lRaise = true then
    raise notice 'lGeraArrecad (%) lAguaLigada (%) iApto (%) nConsumo (%) nExcesso (%)', lGeraArrecad, lAguaLigada, iApto, nConsumo, nExcesso;
  end if;

  -- 4) Gera AguaCalc
  --    . Verifica se eh um Novo Calculo 
	dData      := TO_DATE(fc_getsession('DB_datausu'), 'YYYY-MM-DD');
	sHora      := TO_CHAR(CURRENT_TIMESTAMP, 'HH24:MI');
	iUsuario   := CAST(fc_getsession('DB_id_usuario') as integer);
	iInstit    := CAST(fc_getsession('DB_instit') as integer);

  if lRecalculo = false then
    iNumpre    := fc_agua_numpre();
    iNumpreOld := iNumpre;
    iCodCalc   := nextval('aguacalc_x22_codcalc_seq');
  
    insert into aguacalc(
      x22_codcalc,
      x22_codconsumo,
      x22_exerc,
      x22_mes,
      x22_matric,
      x22_area,
      x22_numpre,
      x22_tipo,
      x22_data,
      x22_hora,
      x22_usuario
    ) values (
      iCodCalc,
      iConsumo,
      iAno,
      iMes,
      iMatric,
      nAreaConstr,
      iNumpre,
      iTipo,
      dData,
      sHora,
      iUsuario
    );
  else
    --if lTrocaNumpre = false then
      iNumpreOld := fc_agua_calculonumpre(iAno, iMes, iMatric);
      iNumpre    := iNumpreOld;
    --end if;
    
    update aguacalc 
       set x22_codconsumo = iConsumo,
           x22_area       = nAreaConstr,
           x22_numpre     = iNumpre,
           x22_tipo       = iTipo,
           x22_data       = dData,
           x22_hora       = sHora,
           x22_usuario    = iUsuario
     where x22_codcalc    = iCodCalc;

    delete 
      from aguacalcval 
     where x23_codcalc = iCodCalc;

  end if;

  -- Se for um Apto de um Condominio e tiver agua desligada,
  -- força nao gerar financeiro
  if (lAguaLigada = false) and (iApto is not null) then
    lGeraArrecad := false;

    perform fc_agua_calculogeraarreold(
      iAno,
      iMes,
      iNumpreOld);
  end if;

  -- Elimina Registros do Arrecad
  if lGeraArrecad = true then
    raise notice 'Ano(%), Mes(%), Numpre(%)', iAno, iMes, iNumpreOld;
    perform fc_agua_calculogeraarreold(
      iAno,
      iMes,
      iNumpreOld);
  end if;

  -- Busca Registros para Cálculo
  for rCalculo in 
    select aguaconsumo.*,
           aguaconsumorec.*,
           aguaconsumotipo.*,
           0::float8 as x99_valor,
           0::float8 as x99_valor_desconto
      from aguaconsumo
           inner join aguaconsumorec  on x19_codconsumo = x20_codconsumo
           inner join aguaconsumotipo on x20_codconsumotipo = x25_codconsumotipo
     where x19_codconsumo = iConsumo
  loop
    --
    -- Verifica se Esta Calculando Consumo de Agua
    --
    if  (rCalculo.x25_codconsumotipo = fc_agua_confconsumoagua()) and
      (lSemAgua = false) then
      --
      -- ATENCAO!! Multiplica pelo retorno da funcao que verifica
      --           a qtd de economias levando em conta o multiplicador
      --
      if(iCondominio is not null) then
      
        nValorTemp := fc_agua_calculatxapto(iAno, iCondominio, rCalculo.x25_codconsumotipo);
      
      else 
      
        nValorTemp := rCalculo.x20_valor * fc_agua_qtdeconomias(iMatric);
        
      end if;
    --
    -- .. ou Esgoto
    --
    elsif (rCalculo.x25_codconsumotipo = fc_agua_confconsumoesgoto()) and
          (lSemEsgoto = false) then
          
      if(iCondominio is not null) then
      
        nValorTemp := fc_agua_calculatxapto(iAno, iCondominio, rCalculo.x25_codconsumotipo);
      
      else
      
        nValorTemp := rCalculo.x20_valor * fc_agua_qtdeconomias(iMatric);
        
      end if;
      
    --
    -- .. ou Excesso
    --
    elsif (rCalculo.x25_codconsumotipo = fc_agua_confconsumoexcesso()) then
      if   ((iCondominio is not null) and (lAguaLigada = false)) or (lSemAgua = false) then
        if nExcesso > 0 then
          lGeraDesconto = true;
          nValorTemp   := rCalculo.x20_valor * nExcesso;
        else
          nValorTemp := 0;
        end if;
      else
        nValorTemp := 0;
      end if;
    else
      nValorTemp := 0;
    end if;
    
    -- Verifica Isencao
    nPercentualIsencao := fc_agua_percentualisencao(iAno, iMes, iMatric, rCalculo.x25_codconsumotipo);
    
    if nPercentualIsencao = 0 then
      rCalculo.x99_valor := nValorTemp;
    else
      rCalculo.x99_valor := round(nValorTemp - (nValorTemp * (nPercentualIsencao / 100)), 2);
    end if;

    if lRaise = true then
      raise notice 'Matricula=(%) Isencao=(%) Padrao=(%) Taxa=(%) Valor Calculado=(%) Tipo Consumo=(%)', 
        iMatric,
        nPercentualIsencao,
        rCalculo.x20_valor,
        rCalculo.x25_descr,
        rCalculo.x99_valor,
        rCalculo.x25_codconsumotipo;
    end if;

    if rCalculo.x99_valor > 0 then
      insert into aguacalcval (
        x23_codcalc,
        x23_codconsumotipo,
        x23_valor
      ) values (
        iCodCalc,
        rCalculo.x25_codconsumotipo,
        rCalculo.x99_valor
      );
    end if;

    if lGeraArrecad = true then
      perform fc_agua_calculogerafinanceiro(
        iAno,
        iMes,
        iMatric,
        iNumpreOld,
        iNumpre,
        coalesce(rAguaBase.x01_numcgm, 0),
        rCalculo.x25_receit,
        rCalculo.x25_codhist,
        rCalculo.x99_valor);
    end if;
    
    if lGeraDesconto = true and nSaldoComp > 0 then
      --caso haja saldos compensados repete operação para gerar o desconto
      lGeraDesconto := false;
      
      nValorTemp := -(rCalculo.x20_valor * nSaldoComp);
      
	    if nPercentualIsencao = 0 then
	      rCalculo.x99_valor_desconto := nValorTemp;
	    else
	      rCalculo.x99_valor_desconto := round(nValorTemp - (nValorTemp * (nPercentualIsencao / 100)), 2);
	    end if;
	
	    if lRaise = true then
	      raise notice 'Matricula=(%) Isencao=(%) Padrao=(%) Taxa=(%) Valor Calculado=(%) Tipo Consumo=(%)', 
	        iMatric,
	        nPercentualIsencao,
	        rCalculo.x20_valor,
	        rCalculo.x25_descr,
	        rCalculo.x99_valor_desconto,
	        rCalculo.x25_codconsumotipo;
	    end if;
	
	    if lGeraArrecad = true then
	    
	      perform * from (
										    select k00_numpre
										      from arrecant
										     where k00_numpre = iNumpre
										       and k00_numpar = iMes
										       and k00_tipo   = 137
										       and k00_receit = rCalculo.x25_receit
										    union all
										    select k10_numpre
										      from divold
										     where k10_numpre  = iNumpre
										       and k10_numpar  = iMes
										       and k10_receita = rCalculo.x25_receit
										  ) as x;
									
        if not found then

          delete from arrehist where k00_numpre = iNumpre and k00_numpar = iMes and k00_hist in (970, 918) and k00_histtxt LIKE 'VOLUME DE %GUA COMPENSADO%';

          insert into arrehist
          ( k00_numpre, k00_numpar, k00_hist, k00_dtoper, k00_hora, k00_id_usuario, k00_histtxt, k00_limithist, k00_idhist )
          values 
          ( iNumpre, iMes, 970, dData, sHora, iUsuario, 'VOLUME DE ÁGUA COMPENSADO - VALOR DESCONTO = '||abs(rCalculo.x99_valor_desconto), null, nextval('arrehist_k00_idhist_seq') );
          
          if rCalculo.x99_valor - abs(rCalculo.x99_valor_desconto) > 0 then
        
		        insert into arrecad
		        ( k00_numpre, k00_numpar, k00_numcgm, k00_dtoper, k00_receit, k00_hist, k00_valor, k00_dtvenc, k00_numtot, k00_numdig, k00_tipo, k00_tipojm )
	          values
	          ( iNumpre, iMes, coalesce(rAguaBase.x01_numcgm, 0), dData, rCalculo.x25_receit, 918, rCalculo.x99_valor_desconto,dDataVenc, 12, 0, 137, 0 );
	         
          else
          
            insert into cancdebitos ( k20_codigo, k20_cancdebitostipo, k20_instit, k20_descr, k20_hora, k20_data, k20_usuario )
            values ( ( select nextval('cancdebitos_k20_codigo_seq') ), 2, iInstit, 'CANCELAMENTO POR COMPENSAÇÃO DE CRÉDITO', sHora, dData, iUsuario );
            
            insert into cancdebitosconcarpeculiar ( k72_sequencial, k72_cancdebitos, k72_concarpeculiar ) 
            values ( ( select nextval('cancdebitosconcarpeculiar_k72_sequencial_seq') ), ( select last_value from cancdebitos_k20_codigo_seq ),'000' );
            
            insert into cancdebitosreg ( k21_sequencia, k21_codigo, k21_numpre, k21_numpar, k21_receit, k21_data, k21_hora, k21_obs ) 
            values ( ( select nextval('cancdebitosreg_k21_sequencia_seq') ), 
                     ( select last_value from cancdebitos_k20_codigo_seq ), 
                     iNumpre,
                     iMes,
                     rCalculo.x25_receit,
                     dData, 
                     sHora,
                     'TAXA DE EXCESSO INTEGRALMENTE COMPENSADA, SALDO COMPENSADO: '||nSaldoComp||'m³, VALOR DESCONTO R$'||abs(rCalculo.x99_valor_desconto) );
                     
            insert into cancdebitosproc ( k23_codigo, k23_data, k23_hora, k23_usuario, k23_obs, k23_cancdebitostipo ) 
            values ( ( select nextval('cancdebitosproc_k23_codigo_seq') ), 
                     dData, 
                     sHora, 
                     iUsuario, 
                     'TAXA DE EXCESSO INTEGRALMENTE COMPENSADA, SALDO COMPENSADO: '||nSaldoComp||'m³, VALOR DESCONTO R$'||abs(rCalculo.x99_valor_desconto), 
                     2 );
                     
            insert into cancdebitosprocconcarpeculiar ( k74_sequencial, k74_cancdebitosproc, k74_concarpeculiar ) 
            values ( ( select nextval('cancdebitosprocconcarpeculiar_k74_sequencial_seq') ), ( select last_value from cancdebitosproc_k23_codigo_seq ), '000' );
            
            insert into arrecant ( k00_numpre, k00_numpar, k00_numcgm, k00_dtoper, k00_receit, k00_hist, k00_valor, k00_dtvenc, k00_numtot, k00_numdig, k00_tipo, k00_tipojm )
            select k00_numpre,
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
              from arrecad
             where k00_numpre = iNumpre
               and k00_numpar = iMes
               and k00_receit = rCalculo.x25_receit;
               
            delete
              from arrecad
             where k00_numpre = iNumpre
               and k00_numpar = iMes
               and k00_receit = rCalculo.x25_receit;
               
            insert into cancdebitosprocreg ( k24_sequencia, k24_codigo, k24_cancdebitosreg, k24_vlrhis, k24_vlrcor, k24_juros, k24_multa, k24_desconto ) 
            values ( ( select nextval('cancdebitosprocreg_k24_sequencia_seq') ), 
                     ( select last_value from cancdebitosproc_k23_codigo_seq ), 
                     ( select last_value from cancdebitosreg_k21_sequencia_seq ), 
                     0, 0, 0, 0, 0 );

          end if;
          
        end if;
        
	    end if;
	    
    end if;
    
  end loop;

  if lRaise = true then
    raise notice 'Economias=(%) Agua Ligada=(%) Esgoto Ligado (%) Recalculo=(%) CodCalc=(%) Numpre=(%)',
      iEconomias,
      lAguaLigada,
      lEsgotoLigado,
      lRecalculo,
      iCodCalc,
      iNumpre;
  end if;

  return '1 - CALCULO CONCLUIDO COM SUCESSO ';
end;
$$ language 'plpgsql';set check_function_bodies to on;
create or replace function fc_vistorias_charqueadas(integer)
returns varchar(200)
as $$
  declare
  
  v_vistoria      alias for $1;
  
  v_ativtipo    integer;
  v_numpre        integer;
  v_numpreinscr   integer;
  v_arrecant    integer;
  v_arrecad     integer;
  v_data      date;
  
  v_diasgeral       integer;
  v_mesgeral        integer;
  v_parcial         boolean;
  
  v_achou         boolean default false;
  v_calculou      boolean default false;
  v_datavenc    date;
  v_y74_codsani   integer;
  v_y74_inscrsani   integer;
  v_y80_numcgm    integer;
  v_y69_numpre    integer;
  v_q81_recexe    integer;
  v_q92_hist    integer;
  v_q81_valexe    float8;
  v_q92_tipo    integer;
  v_y71_inscr   integer;
  v_q02_numcgm    integer;
  v_ativ      integer;
  v_anousu      integer;
  v_ativprinc   integer;
  v_diasvenc    integer;

  iFormaCalculoAtividade      integer;
  icodvencimento  integer default 0;

  lVistoriaSanitario         boolean;
  lVistoriaLocalizacao        boolean;

  v_tabmult      boolean;
  v_cadmult      boolean;
  v_area         float8;
  v_multitab     float8 := 1;
  v_multicad     float8 := 1;
  v_valinflator  float8;
  v_base         float8;
  v_valalancar   float8;
  v_text         text default '';
  v_excedente    float8;
  v_quantativ    integer default 0;
  
  iFormulaCalculo   integer;
  
  v_claspont        integer default null;
  v_zonapont        integer;
  v_empreg          integer;
  v_empregpont      integer;
  v_areapont        integer;
  v_pontuacaogeral  integer;

  iorigemdados      integer;
  itipovist1        integer;
  itipovist2        integer;
  v_tipo_quant      integer;
  iinstit           integer;
  ddatavistoria     date;
  
  lencontrouquantidadecalculo boolean default false;
  lraise                      boolean default true;

  lCalculaPorPorteAtividade boolean default false;
  
  CALCULO_ATIVIDADE_PRINCIPAL   CONSTANT integer := 1;
  CALCULO_ATIVIDADE_MAIOR_VALOR CONSTANT integer := 2;

  TIPO_CALCULO_POR_ATIVIDADE    CONSTANT integer := 1;
  CALCULO_POR_PONTUACAO         CONSTANT integer := 2;

  v_record_vistsanitario  record;
  v_record_ativtipo         record;
  v_record_saniatividade  record;
  v_record_arrecad          record;

  rfinanceiro             record;
  
  begin

    lraise  := ( case when fc_getsession('db_debugon') is null then false else true end );
    iinstit := fc_getsession('db_instit');
    
    -- select substr(current_date,0,5) 
    -- into v_anousu; 
    
    select extract(year from y70_data), y70_data, y70_tipovist
           into v_anousu, ddatavistoria, iorigemdados
      from vistorias 
     where y70_codvist = v_vistoria; 
    
    if lraise is true then
      raise notice 'v_anousu: % ', v_anousu;
    end if;
    
-- verifica se a vistoria eh parcial ou geral, para montar a data de vencimento a ser gravada no arrecad --
    if iorigemdados = 1 then
      itipovist1 := 3;
      itipovist2 := 5;
    elsif iorigemdados = 2 then
      itipovist1 := 5;
      itipovist2 := 6;
    else
      return '21-erro ao selecionar origem dos dados (inscrição ou sanitário)!';
    end if;
    
     begin
      
       create temp table w_origemdados as select itipovist1 as q81_codigo union select itipovist2;
      
       exception
         when duplicate_table then 
          truncate w_origemdados; 
          insert into w_origemdados select itipovist1 as q81_codigo union select itipovist2;
     end;
     
    select y70_parcial 
      from vistorias 
     where y70_codvist = v_vistoria 
      into v_parcial;
    
    if v_parcial is not null and v_parcial = false then 
      if lraise is true then
        raise notice 'geral ';
      end if;
      select y77_diasgeral, y77_mesgeral, y70_data from tipovistorias 
      inner join vistorias on y77_codtipo = y70_tipovist 
      where y70_codvist = v_vistoria
      into  v_diasgeral,v_mesgeral,v_data;
      if v_diasgeral is null or v_diasgeral = 0 or v_mesgeral is null or v_mesgeral = 0 then
        return '01- tipo de vistoria sem dia ou mes para vencimento configurado!';
      end if;
      v_datavenc = v_anousu||'-'||v_mesgeral||'-'||v_diasgeral; 
      if lraise is true then
        raise notice 'v_diasvenc: % - v_datavenc: %', v_diasvenc, v_datavenc;
      end if;
    else
      if lraise is true then
        raise notice 'parcial ';
      end if;
      select y77_dias, y70_data, y70_data, y77_diasgeral, y77_mesgeral 
        into v_diasvenc, v_data, v_datavenc, v_diasgeral, v_mesgeral 
        from tipovistorias 
             inner join vistorias on y77_codtipo = y70_tipovist 
       where y70_codvist = v_vistoria ;
      if v_diasvenc is null or v_diasvenc = 0 then
        if v_diasgeral is null then
          return '02- tipo de vistoria sem dias para vencimento configurado!';
        else
          v_datavenc = v_anousu||'-'||v_mesgeral||'-'||v_diasgeral;
        end if;
        
      end if;
      if lraise is true then
        raise notice 'v_diasvenc: % - v_datavenc: % - v_data: %', v_diasvenc, v_datavenc, v_data;
      end if;
--v_data = v_datavenc;
      if lraise is true then
        raise notice 'v_datavenc: %', v_datavenc;
      end if;
      if v_diasvenc is null then
        v_diasvenc = 0;
      end if;
      select v_datavenc + v_diasvenc 
      into v_datavenc; 
    end if;
    
--*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*--  
    
    if lraise is true then
      raise notice 'v_datavenc: %', v_datavenc;
    end if;
    
    select y32_formvist,
           y32_utilizacalculoporteatividade
      into iFormulaCalculo,
           lCalculaPorPorteAtividade
      from parfiscal
     where y32_instit = iinstit ;
    
    select q04_vbase
      into v_base
      from cissqn
     where cissqn.q04_anousu = v_anousu;

    if v_base = 0 or v_base is null then
      return '03- sem valor base cadastrado nos parametros ';
    end if;
    
    select distinct i02_valor
      into v_valinflator
      from cissqn
           inner join infla on q04_inflat = i02_codigo
     where cissqn.q04_anousu = v_anousu
       and date_part('y',i02_data) = v_anousu;

    if v_valinflator is null then
      v_valinflator = 1;
      --   return 'valor do inflator nao configurado corretamente';
    end if;
    
    select y74_codsani,y80_numcgm,y69_numpre 
      into v_y74_codsani,v_y80_numcgm,v_y69_numpre
      from vistsanitario 
           inner join sanitario on y74_codsani = y80_codsani 
           left outer join vistorianumpre on y69_codvist = v_vistoria 
     where y74_codvist = v_vistoria;

    if lraise is true then
      raise notice 'v_y74_codsani: % - v_vistoria: %', v_y74_codsani, v_vistoria;
    end if;

    if v_y74_codsani = 0 or v_y74_codsani is null then

      lVistoriaSanitario = false;

      select y71_inscr,q02_numcgm,y69_numpre 
        into v_y71_inscr,v_q02_numcgm,v_y69_numpre
        from vistinscr
             inner join issbase on q02_inscr = y71_inscr
             left outer join vistorianumpre on y69_codvist = v_vistoria
       where y71_codvist = v_vistoria;

      if v_y71_inscr is null then
        lVistoriaLocalizacao = false;
      else  
        lVistoriaLocalizacao = true;
      end if;

    else  
      lVistoriaSanitario = true;
    end if;
    
    if lraise is true then
      raise notice 'lVistoriaSanitario: % - iFormulaCalculo: %', lVistoriaSanitario, iFormulaCalculo;
    end if;
    
    if lVistoriaLocalizacao = false and lVistoriaSanitario = false then
      return '10- calculo nao configurado para a vistoria numero ' || v_vistoria;
    end if;


    --
    -- Neste ponto ja esta definido qual o tipo de vistoria 
    --   sanitario   - lVistoriaSanitario
    --   localizacao - lVistoriaLocalizacao
    --
    if iFormulaCalculo <> TIPO_CALCULO_POR_ATIVIDADE then 
      return '20-procedimento não preparado para calculo por forma diferente de 1 (normal)';
    end if;
    
    -- Se nao utilizar integracao com sanitario nao entrara aqui
    -- Necessario que tenha registros nas tabelas do sanitario
    if lVistoriaSanitario is true then
      
      v_achou = false;
      
      if lraise is true then
        raise notice 'v_y74_codsani: %', v_y74_codsani;
        raise notice 'antes for...';
      end if;

      if lCalculaPorPorteAtividade then
        
        -- Pega o primeiro tipo de calculo encontrado na tabela de ligação com o porte
        select q85_forcal
          into iFormaCalculoAtividade
          from saniatividade
               inner join sanitarioinscr      on sanitarioinscr.y18_codsani = saniatividade.y83_codsani
               inner join issbaseporte        on issbaseporte.q45_inscr     = sanitarioinscr.y18_inscr
               inner join tabativportetipcalc on tabativportetipcalc.q143_ativid = saniatividade.y83_ativ
                                             and tabativportetipcalc.q143_issporte = issbaseporte.q45_codporte
               inner join tipcalc             on tipcalc.q81_codigo = tabativportetipcalc.q143_tipcalc
               inner join cadcalc             on tipcalc.q81_cadcalc = cadcalc.q85_codigo
         where saniatividade.y83_codsani = v_y74_codsani
           and saniatividade.y83_dtfim is null 
           and saniatividade.y83_ativprinc is true
           and tipcalc.q81_tipo in ( select q81_codigo from w_origemdados );

      else
      
        select min(q85_forcal)
          into iFormaCalculoAtividade
          from tipcalc
               inner join cadcalc        on tipcalc.q81_cadcalc = cadcalc.q85_codigo
               inner join ativtipo       on ativtipo.q80_tipcal = tipcalc.q81_codigo
               inner join saniatividade  on saniatividade.y83_ativ = ativtipo.q80_ativ
         where saniatividade.y83_codsani = v_y74_codsani 
           and saniatividade.y83_dtfim is null 
           and tipcalc.q81_tipo in ( select q81_codigo from w_origemdados );
      end if;

      if iFormaCalculoAtividade is null then
        return '11-sem forma de calculo encontrada (sani)!';
      end if;
      
      if lraise is true then
        raise notice 'iFormaCalculoAtividade: %', iFormaCalculoAtividade;
      end if;
      
      if iFormaCalculoAtividade = CALCULO_ATIVIDADE_PRINCIPAL then

        if lCalculaPorPorteAtividade then

          select y83_ativ
            into v_ativprinc
            from saniatividade 
                 inner join sanitarioinscr      on sanitarioinscr.y18_codsani = saniatividade.y83_codsani
                 inner join issbaseporte        on issbaseporte.q45_inscr     = sanitarioinscr.y18_inscr
                 inner join tabativportetipcalc on tabativportetipcalc.q143_ativid = saniatividade.y83_ativ
                                               and tabativportetipcalc.q143_issporte = issbaseporte.q45_codporte
                 inner join tipcalc on tipcalc.q81_codigo = tabativportetipcalc.q143_tipcalc
           where y83_codsani = v_y74_codsani 
             and y83_dtfim is null 
             and q81_tipo in ( select q81_codigo from w_origemdados ) 
             and y83_ativprinc is true;
        else

          select q80_ativ
            into v_ativprinc
            from saniatividade 
                 inner join ativtipo on saniatividade.y83_ativ = ativtipo.q80_ativ
                 inner join tipcalc on tipcalc.q81_codigo = ativtipo.q80_tipcal
           where y83_codsani = v_y74_codsani 
             and y83_dtfim is null 
             and q81_tipo in ( select q81_codigo from w_origemdados ) 
             and y83_ativprinc is true;
        end if;
        
        if v_ativprinc is not null then
          v_achou = true;
        end if;
        
      elsif iFormaCalculoAtividade = CALCULO_ATIVIDADE_MAIOR_VALOR then
        
        if lCalculaPorPorteAtividade then

          select y83_ativ
            into v_ativprinc
            from saniatividade 
                 inner join sanitarioinscr      on sanitarioinscr.y18_codsani = saniatividade.y83_codsani
                 inner join issbaseporte        on issbaseporte.q45_inscr     = sanitarioinscr.y18_inscr
                 inner join tabativportetipcalc on tabativportetipcalc.q143_ativid = saniatividade.y83_ativ
                                               and tabativportetipcalc.q143_issporte = issbaseporte.q45_codporte
                 inner join tipcalc on tipcalc.q81_codigo = tabativportetipcalc.q143_tipcalc
           where y83_codsani = v_y74_codsani 
             and y83_dtfim is null 
             and q81_tipo in ( select q81_codigo from w_origemdados )
           order by q81_valexe desc
           limit 1;
        else

          select q80_ativ
            into v_ativprinc
            from saniatividade 
                 inner join ativtipo on saniatividade.y83_ativ = ativtipo.q80_ativ
                 inner join tipcalc on tipcalc.q81_codigo = ativtipo.q80_tipcal
           where y83_codsani = v_y74_codsani 
             and y83_dtfim is null 
             and q81_tipo in ( select q81_codigo from w_origemdados )
           order by q81_valexe desc
           limit 1;
        end if;        
        
        if v_ativprinc is not null then
          v_achou = true;
        end if;
        
      end if;
     
      if v_achou is false then
        return '04- nenhuma atividade com tipo 6 cadastrada';
      end if;
    end if;
    
    if lVistoriaLocalizacao = true then
      
      if lCalculaPorPorteAtividade then

        -- Pega o primeiro tipo de calculo encontrado na tabela de ligação com o porte
        -- Faz ligação com tipcalc para verificar se é sanitario ou localização
        select q85_forcal
          into iFormaCalculoAtividade
          from tabativ
               left join ativprinc            on ativprinc.q88_inscr = tabativ.q07_inscr
                                             and ativprinc.q88_seq = tabativ.q07_seq
               inner join issbaseporte        on issbaseporte.q45_inscr = tabativ.q07_inscr
               inner join tabativportetipcalc on tabativportetipcalc.q143_ativid = tabativ.q07_ativ
                                             and tabativportetipcalc.q143_issporte = issbaseporte.q45_codporte
               inner join tipcalc             on tipcalc.q81_codigo = tabativportetipcalc.q143_tipcalc
               inner join cadcalc             on tipcalc.q81_cadcalc = cadcalc.q85_codigo
         where q07_inscr = v_y71_inscr 
           and tabativ.q07_datafi is null
           and tipcalc.q81_tipo in ( select q81_codigo from w_origemdados );
      else 

        select min(q85_forcal)
          into iFormaCalculoAtividade     
          from tipcalc
               inner join cadcalc        on tipcalc.q81_cadcalc = cadcalc.q85_codigo
               inner join ativtipo       on ativtipo.q80_tipcal = tipcalc.q81_codigo
               inner join tabativ        on tabativ.q07_ativ = ativtipo.q80_ativ
         where q07_inscr = v_y71_inscr and
        tabativ.q07_datafi is null and
        tipcalc.q81_tipo in ( select q81_codigo from w_origemdados );
      end if;
      
      if iFormaCalculoAtividade is null then
        
        select min(q85_forcal)
          into iFormaCalculoAtividade
          from issportetipo 
               inner join issbaseporte on q45_inscr    = v_y71_inscr 
                                      and q45_codporte = q41_codporte
               inner join tipcalc      on q41_codtipcalc = q81_codigo 
               inner join cadcalc      on cadcalc.q85_codigo = tipcalc.q81_cadcalc 
               inner join clasativ     on q82_classe = q41_codclasse 
               inner join tabativ      on q82_ativ = q07_ativ 
                                      and q07_inscr = v_y71_inscr
               inner join ativprinc    on ativprinc.q88_inscr = tabativ.q07_inscr 
                                      and ativprinc.q88_seq = tabativ.q07_seq
         where q45_codporte = q41_codporte 
           and q81_tipo in ( select q81_codigo from w_origemdados ) 
           and case 
                 when q07_datafi is null then 
                   true 
                 else q07_datafi >= v_data 
               end 
           and q07_databx is null;
        
        if iFormaCalculoAtividade is null then
          return '17-sem forma de calculo encontrada (inscr)!';
        end if;
        
      end if;
      
      if lraise is true then
        raise notice 'iFormaCalculoAtividade: %', iFormaCalculoAtividade;
      end if;
      
      -- pontuacao das classes
      select  q82_ativ, 
              max(q25_pontuacao)
          into v_ativprinc, 
               v_claspont
          from tabativ
               inner join clasativ   on q82_ativ = q07_ativ
               inner join classepont on q25_classe = q82_classe
         where q07_inscr = v_y71_inscr 
           and case 
                 when q07_datafi is null then true 
                 else q07_datafi >= v_data 
               end 
           and q07_databx is null
         group by q82_ativ
         order by max(q25_pontuacao) desc
         limit 1;
      
      if v_claspont is not null then
      --  return '11-pontuacao da classe nao encontrada';
        
        -- pontuacao zona fiscal
        select q26_pontuacao
          into v_zonapont
          from zonapont
               inner join isszona on q26_zona = q35_zona
         where q35_inscr = v_y71_inscr;
        
        if v_zonapont is null then
          return '12-pontuacao da zona nao encontrada';
        end if;
        
        -- pontuacao empregados/area
        -- multiplicador para localizacao e sanitario
        select q30_quant, 
               q30_area
          into v_empreg, 
               v_area
          from issquant
         where issquant.q30_inscr = v_y71_inscr 
           and issquant.q30_anousu = v_anousu;

        if v_empreg is null then

          select q30_quant, 
                 q30_area
            into v_empreg, 
                 v_area
            from issquant
           where issquant.q30_inscr = v_y71_inscr 
             and issquant.q30_anousu = (v_anousu - 1);

          if v_empreg is null then

            select q30_quant, 
                   q30_area
              into v_empreg, 
                   v_area
              from issquant
             where issquant.q30_inscr = v_y71_inscr 
               and issquant.q30_anousu = (v_anousu + 1);

            if v_empreg is null then

              insert into issquant 
              select * 
                from issquant 
               where issquant.q30_inscr = v_y71_inscr 
                 and issquant.q30_anousu = (v_anousu - 1);
            end if;
          end if;
        end if;

        -- pontuacao pelos empregados
        select q27_pontuacao
               into v_empregpont
          from empregpont
         where v_empreg >= q27_quantini 
           and v_empreg <= q27_quantfim;
        
        if v_empregpont is null then
          return '13-pontuacao do numero de empregados nao encontrada';
        end if;
        
        
        if lraise is true then
          raise notice 'v_area: %', v_area;
        end if;

        -- pontuacao pela area
        select q28_pontuacao
          into v_areapont
          from areapont
         where v_area >= q28_quantini 
           and v_area <= q28_quantfim;

        if v_areapont is null then
          return '14-pontuacao da area nao encontrada';
        end if;
        
        if lraise is true then
          raise notice 'v_claspont: % - v_zonapont: %  - v_empregpont: %  - v_areapont: %', v_claspont, v_zonapont, v_empregpont, v_areapont;
        end if;
        
        v_pontuacaogeral = v_claspont + v_zonapont + v_empregpont + v_areapont;
        
        if lraise is true then
          raise notice 'v_pontuacaogeral: %', v_pontuacaogeral;
        end if;
        
        select q81_codigo,   
               q81_recexe,   
               q92_hist,   
               q81_valexe,   
               q92_tipo 
          into v_ativtipo, 
               v_q81_recexe, 
               v_q92_hist, 
               v_q81_valexe, 
               v_q92_tipo
          from tipcalc 
              inner join tipcalcexe  on tipcalcexe.q83_anousu = v_anousu 
                                    and tipcalcexe.q83_tipcalc = tipcalc.q81_codigo
              inner join cadvencdesc on q92_codigo = tipcalcexe.q83_codven
        where v_pontuacaogeral >= q81_qiexe 
          and v_pontuacaogeral <= q81_qfexe 
          and q81_tipo in ( select q81_codigo from w_origemdados );
        
      -- por ativtipo
      else
        
        if iFormaCalculoAtividade = CALCULO_ATIVIDADE_PRINCIPAL then

          if lCalculaPorPorteAtividade then

            select q07_ativ
              into v_ativprinc
              from tabativ
                   inner join ativprinc           on ativprinc.q88_inscr = tabativ.q07_inscr 
                                                 and ativprinc.q88_seq = tabativ.q07_seq
                   inner join issbaseporte        on issbaseporte.q45_inscr = tabativ.q07_inscr
                   inner join tabativportetipcalc on tabativportetipcalc.q143_ativid = tabativ.q07_ativ
                                                 and tabativportetipcalc.q143_issporte = issbaseporte.q45_codporte
                   inner join tipcalc             on tipcalc.q81_codigo = tabativportetipcalc.q143_tipcalc
             where q07_inscr = v_y71_inscr 
               and tabativ.q07_datafi is null 
               and q81_tipo in ( select q81_codigo from w_origemdados );

          else

            select q80_ativ
              into v_ativprinc
              from tabativ
                   inner join ativprinc on ativprinc.q88_inscr = tabativ.q07_inscr and ativprinc.q88_seq = tabativ.q07_seq
                   inner join ativtipo on tabativ.q07_ativ = ativtipo.q80_ativ
                   inner join tipcalc on tipcalc.q81_codigo = ativtipo.q80_tipcal
             where q07_inscr = v_y71_inscr 
               and tabativ.q07_datafi is null 
               and q81_tipo in ( select q81_codigo from w_origemdados );
          end if;
          
          if v_ativprinc is not null then
            v_achou = true;
          else
            
            select q07_ativ
              into v_ativprinc
              from issportetipo
                   inner join issbaseporte on q45_inscr = v_y71_inscr 
                                          and q45_codporte = q41_codporte
                   inner join tipcalc on q41_codtipcalc = q81_codigo 
                   inner join cadcalc on cadcalc.q85_codigo = tipcalc.q81_cadcalc 
                   inner join clasativ on q82_classe = q41_codclasse 
                   inner join tabativ on q82_ativ = q07_ativ 
                                     and q07_inscr = v_y71_inscr
                   inner join ativprinc on ativprinc.q88_inscr = tabativ.q07_inscr 
                                       and ativprinc.q88_seq = tabativ.q07_seq
             where q45_codporte = q41_codporte 
               and q81_tipo in ( select q81_codigo from w_origemdados ) 
               and case 
                     when q07_datafi is null then 
                       true 
                     else q07_datafi >= v_data 
                   end 
               and q07_databx is null;
            
            if v_ativprinc is not null then
              v_achou = true;
            end if;
            
          end if;
          

        elsif iFormaCalculoAtividade = CALCULO_ATIVIDADE_MAIOR_VALOR then
          
          if lraise is true then
            raise notice 'forcal 2...';
          end if;
          
          if lCalculaPorPorteAtividade then

            select q07_ativ
              into v_ativprinc
              from tabativ
                   inner join issbaseporte        on issbaseporte.q45_inscr = tabativ.q07_inscr
                   inner join tabativportetipcalc on tabativportetipcalc.q143_ativid = tabativ.q07_ativ
                                                 and tabativportetipcalc.q143_issporte = issbaseporte.q45_codporte
                   inner join tipcalc             on tipcalc.q81_codigo = tabativportetipcalc.q143_tipcalc
             where q07_inscr = v_y71_inscr 
               and tabativ.q07_datafi is null
               and tipcalc.q81_tipo in ( select q81_codigo from w_origemdados )
             order by q81_valexe desc
             limit 1;
          else

            select q80_ativ
              into v_ativprinc
              from tabativ
                   inner join ativtipo on tabativ.q07_ativ = ativtipo.q80_ativ
                   inner join tipcalc on tipcalc.q81_codigo = ativtipo.q80_tipcal
             where q07_inscr = v_y71_inscr 
               and tabativ.q07_datafi is null 
               and q81_tipo in ( select q81_codigo from w_origemdados )
             order by q81_valexe desc
             limit 1;
          end if;
          
          if v_ativprinc is not null then
            v_achou = true;
          end if;
          
        end if;
        
        if v_achou is false then
          return '16 - sem atividade principal';
        end if;
        
        if lCalculaPorPorteAtividade then

          select tipcalc.q81_codigo
            into v_ativtipo
            from tabativ
                 inner join issbaseporte        on q45_inscr    = q07_inscr
                 inner join tabativportetipcalc on q143_issporte = q45_codporte
                                               and q143_ativid   = q07_ativ
                 inner join tipcalc on q81_codigo = q143_tipcalc     
                 inner join cadcalc on cadcalc.q85_codigo = tipcalc.q81_cadcalc 
           where q81_tipo in ( select q81_codigo 
                                 from w_origemdados ) 
             and q07_inscr = v_y71_inscr 
             and q07_ativ = v_ativprinc
             and case 
                   when q07_datafi is null 
                     then true 
                   else q07_datafi >= v_data 
                 end 
             and q07_databx is null ;
        else

          select tipcalc.q81_codigo
            into v_ativtipo
            from ativtipo 
                 inner join tabativ on q07_ativ = q80_ativ
                 inner join tipcalc on q80_tipcal = q81_codigo     
                 inner join cadcalc on cadcalc.q85_codigo = tipcalc.q81_cadcalc 
           where q81_tipo in ( select q81_codigo from w_origemdados ) 
             and q07_inscr = v_y71_inscr 
             and case 
                   when q07_datafi is null then true else q07_datafi >= v_data 
                 end 
             and q07_databx is null 
             and q07_ativ = v_ativprinc;
        end if;
        
        if lraise is true then
          raise notice 'v_ativtipo: % - v_y71_inscr: % - v_ativprinc: %', v_ativtipo, v_y71_inscr, v_ativprinc;
        end if;
        
        if v_ativtipo is null then
          
          if lraise is true then
            raise notice 'ativtipo is null - data: % - inscr: % - ativprinc: %', v_data, v_y71_inscr, v_ativprinc;
          end if;
          
          select tipcalc.q81_codigo 
            into v_ativtipo
            from issportetipo 
                 inner join issbaseporte on q45_inscr = v_y71_inscr and q45_codporte = q41_codporte
                 inner join tipcalc on q41_codtipcalc = q81_codigo 
                 inner join cadcalc on cadcalc.q85_codigo = tipcalc.q81_cadcalc 
                 inner join clasativ on q82_classe = q41_codclasse 
                 inner join tabativ on q82_ativ = q07_ativ and q07_inscr = v_y71_inscr
           where q45_codporte = q41_codporte 
            and q81_tipo in ( select q81_codigo from w_origemdados ) 
            and case 
                  when q07_datafi is null then 
                    true 
                  else q07_datafi >= v_data 
                end 
            and q07_databx is null 
            and q82_ativ = v_ativprinc;

          if v_ativtipo is null then
            return '06-sem tipo de calculo configurado!';
          end if;
        end if;
      end if;
    end if;

    if v_y69_numpre = 0 or v_y69_numpre is null then

      select nextval('numpref_k03_numpre_seq') 
        into v_numpre;

      insert into vistorianumpre values(v_vistoria,v_numpre);
    else

      v_numpre = v_y69_numpre;

      select k00_numpre 
        into v_arrecant 
        from arrecant 
       where k00_numpre = v_numpre;

      if v_arrecant != 0 or v_arrecant is not null then
        return '07- vistoria ja paga ou cancelada ';  
      end if; 

      select k00_numpre 
        into v_arrecad 
        from arrecad 
       where k00_numpre = v_numpre;

      if v_arrecad != 0 or v_arrecad is not null then
        delete from arrecad where k00_numpre = v_numpre;
      end if; 
    end if;
      
      --se for por sanitario segue aqui
      if lVistoriaSanitario = true then
        
        for v_record_saniatividade in 
          select y83_ativ,
                 y80_area,
                 q45_codporte
            from saniatividade
                 inner join sanitario      on sanitario.y80_codsani      = y83_codsani
                 left  join sanitarioinscr on sanitarioinscr.y18_codsani = y83_codsani
                 left  join issbaseporte   on issbaseporte.q45_inscr     = sanitarioinscr.y18_inscr
           where y83_codsani = v_y74_codsani 
             and y83_ativ    = v_ativprinc
        loop  
          
          if lraise is true then
            raise notice 'y83_ativ (2): % - anousu: %', v_record_saniatividade.y83_ativ, v_anousu;
          end if;
          
          if lCalculaPorPorteAtividade then

            if v_record_saniatividade.q45_codporte is null then
              return '24- Porte não encontrado no cadastro da empresa. Alvara sanitario : '||v_y74_codsani;
            end if;
              
            select q81_recexe, 
                   q92_hist, 
                   q81_valexe, 
                   q92_tipo,
                   ( select distinct 
                            q83_codven 
                       from tipcalcexe 
                      where q83_tipcalc = q81_codigo 
                       and q83_anousu = v_anousu )
              into v_q81_recexe,
                   v_q92_hist,
                   v_q81_valexe,
                   v_q92_tipo,
                   icodvencimento
              from tabativportetipcalc
                   inner join tipcalc     on tipcalc.q81_codigo    = tabativportetipcalc.q143_tipcalc                                         
                   inner join tipcalcexe  on tipcalcexe.q83_anousu = v_anousu 
                                         and tipcalcexe.q83_tipcalc = tipcalc.q81_codigo
                   inner join cadvencdesc on q92_codigo = tipcalcexe.q83_codven 
             where q143_ativid   = v_record_saniatividade.y83_ativ
               and q143_issporte = v_record_saniatividade.q45_codporte
               and v_record_saniatividade.y80_area between q81_qiexe and q81_qfexe
               and q81_tipo in ( select q81_codigo 
                                   from w_origemdados );
          else

            select q81_recexe, 
                   q92_hist, 
                   q81_valexe, 
                   q92_tipo,
                   ( select distinct 
                            q83_codven 
                       from tipcalcexe 
                      where q83_tipcalc = q81_codigo 
                       and q83_anousu = v_anousu )
              into v_q81_recexe,
                   v_q92_hist,
                   v_q81_valexe,
                   v_q92_tipo,
                   icodvencimento
              from ativtipo 
                   inner join tipcalc     on q80_tipcal = q81_codigo 
                   inner join tipcalcexe  on tipcalcexe.q83_anousu = v_anousu and tipcalcexe.q83_tipcalc = tipcalc.q81_codigo
                   inner join cadvencdesc on q92_codigo = tipcalcexe.q83_codven 
             where q80_ativ = v_record_saniatividade.y83_ativ
               and ( select y80_area from sanitario where y80_codsani = v_y74_codsani) between q81_qiexe and q81_qfexe
               and q81_tipo in ( select q81_codigo from w_origemdados );
          end if;

          if v_q81_recexe is not null then

            v_valalancar = round(v_q81_valexe * v_valinflator * v_base * v_multitab * v_multicad,2);
            
            if lraise is true then
              raise notice 'inserindo no arrecad... v_valalancar (2): % - icodvencimento: %', v_valalancar, icodvencimento;
            end if;
            
            v_calculou = true;
            --
            -- inserindo por sanitario
            --
            -- funcao para gerar o financeiro 
            -- 

            if icodvencimento is null then
              return '18-sem vencimento configurado para o exercicio!';
            end if;

            if lraise is true then
              raise notice 'executando fc_gerafinanceiro(%,%,%,%,%,%,%)', v_numpre,v_valalancar,icodvencimento,v_y80_numcgm,v_data,v_q81_recexe,ddatavistoria;
            end if;

            select * 
              into rfinanceiro 
              from fc_gerafinanceiro(v_numpre,v_valalancar,icodvencimento,v_y80_numcgm,v_data,v_q81_recexe,ddatavistoria);

            select y18_inscr 
              into v_y74_inscrsani 
              from sanitarioinscr 
             where y18_codsani = v_y74_codsani;

            if v_y74_inscrsani is not null then
              
              if lraise is true then
                raise notice 'xxxxxxxxxxxxxxxxxxxxxxxxx: inscricao: %', v_y74_inscrsani;
              end if;
              
              select k00_numpre 
                into v_numpreinscr 
                from arreinscr 
               where k00_numpre = v_numpre;

              if v_numpreinscr != 0 or v_numpreinscr is not null then
                delete from arreinscr where k00_numpre = v_numpreinscr;
              end if;

              insert into arreinscr (k00_numpre, k00_inscr)
                             values (v_numpre, v_y74_inscrsani);
              
            end if;
          end if;
        end loop;
        if v_calculou is true then
          return '09-ok inscricao numero ' || v_y74_inscrsani;
        else
          return '15-ocorreu algum erro durante o calculo (1)!!!';
        end if;
--fim do if do sanitario
--se for por inscricao segue aqui
      elsif lVistoriaLocalizacao = true then
        
        if lraise is true then
          raise notice 'acessou via inscricao... v_claspont: % - v_ativprinc: %', v_claspont, v_ativprinc;
        end if;
        
        if v_claspont is null then
          
          if lCalculaPorPorteAtividade then

            v_text = v_text || ' select q81_qiexe,q81_qfexe,q81_codigo,q81_uqtab,q81_uqcad,q07_ativ as q80_ativ \n';
            v_text = v_text || '   from tabativ \n';
            v_text = v_text || '        inner join issbaseporte        on q45_inscr    = q07_inscr \n';
            v_text = v_text || '        inner join tabativportetipcalc on q143_issporte = q45_codporte \n';
            v_text = v_text || '                                      and q143_ativid   = q07_ativ \n';
            v_text = v_text || '        inner join tipcalc on q81_codigo = q143_tipcalc \n';
            v_text = v_text || '  where q07_ativ = ' || v_ativprinc || '\n';
            v_text = v_text || '    and q45_inscr = ' || v_y71_inscr || '\n';
            v_text = v_text || '    and q81_tipo in ( select q81_codigo from w_origemdados )\n';
            v_text = v_text || ' union \n';
            v_text = v_text || ' select q81_qiexe,q81_qfexe,q81_codigo,q81_uqtab,q81_uqcad,q82_ativ as q80_ativ \n';
            v_text = v_text || '   from issportetipo \n';
            v_text = v_text || '        inner join issbaseporte on q45_inscr          = ' || v_y71_inscr || '\n';
            v_text = v_text || '        inner join tipcalc      on q41_codtipcalc     = q81_codigo \n';
            v_text = v_text || '        inner join cadcalc      on cadcalc.q85_codigo = tipcalc.q81_cadcalc \n';
            v_text = v_text || '        inner join clasativ     on q82_classe         = q41_codclasse \n';
            v_text = v_text || '  where q45_codporte = q41_codporte \n';
            v_text = v_text || '    and q81_tipo in ( select q81_codigo from w_origemdados ) \n';
            v_text = v_text || '    and q82_ativ = ' || v_ativprinc || '\n';

          else 

            v_text = v_text || ' select q81_qiexe,q81_qfexe,q81_codigo,q81_uqtab,q81_uqcad,q80_ativ ';
            v_text = v_text || '   from ativtipo ';
            v_text = v_text || '        inner join tipcalc on q81_codigo = q80_tipcal ';
            v_text = v_text || '  where q80_ativ = ' || v_ativprinc ;
            v_text = v_text || '    and q81_tipo in ( select q81_codigo from w_origemdados )';
            v_text = v_text || ' union ';
            v_text = v_text || ' select q81_qiexe,q81_qfexe,q81_codigo,q81_uqtab,q81_uqcad,q82_ativ as q80_ativ ';
            v_text = v_text || '   from issportetipo ';
            v_text = v_text || '        inner join issbaseporte on q45_inscr          = ' || v_y71_inscr;
            v_text = v_text || '        inner join tipcalc      on q41_codtipcalc     = q81_codigo ';
            v_text = v_text || '        inner join cadcalc      on cadcalc.q85_codigo = tipcalc.q81_cadcalc ';
            v_text = v_text || '        inner join clasativ     on q82_classe         = q41_codclasse ';
            v_text = v_text || '  where q45_codporte = q41_codporte ';
            v_text = v_text || '    and q81_tipo in ( select q81_codigo from w_origemdados ) ';
            v_text = v_text || '    and q82_ativ = ' || v_ativprinc;
          end if;

          select q60_campoutilcalc 
            into v_tipo_quant 
            from parissqn;

          if v_tipo_quant = 2 then
            select q30_quant from issquant into v_area where q30_inscr = v_y71_inscr and q30_anousu = v_anousu;
          else
            select q30_area from issquant into v_area where q30_inscr = v_y71_inscr and q30_anousu = v_anousu;
          end if;
          
          if lraise is true then
            raise notice ' 1- v_area - % inscr - % anousu - %',v_area,v_y71_inscr,v_anousu;
          end if;
          
          if v_area is null then
            v_area = 0;
          end if;
          
        else
          
          v_text = v_text || ' select q81_codigo, ';
          v_text = v_text || '        q81_recexe, ';
          v_text = v_text || '        q92_hist,   ';
          v_text = v_text || '        q81_valexe, ';
          v_text = v_text || '        q92_tipo,   ';
          v_text = v_text || '        q81_qiexe,  ';
          v_text = v_text || '        q81_qfexe,  ';
          v_text = v_text || '        q81_uqtad,  ';
          v_text = v_text || '        q81_uqcad,  ';
          v_text = v_text || '        q80_ativ    ';
          v_text = v_text || '   from ativtipo      ';
          v_text = v_text || '        inner join tipcalc on tipcalc.q81_codigo = ativtipo.q80_tipcal ';
          v_text = v_text || '        inner join tipcalcexe on tipcalcexe.q83_anousu = ' || v_anousu || ' and tipcalcexe.q83_tipcalc = tipcalc.q81_codigo ';
          v_text = v_text || '        inner join cadcalc on q81_cadcalc = q85_codigo ';
          v_text = v_text || '        inner join cadvencdesc on q92_codigo = tipcalcexe.q83_codven ';
          v_text = v_text || ' where ' || v_pontuacaogeral || ' >= q81_qiexe and ';
          v_text = v_text ||              v_pontuacaogeral || ' <= q81_qfexe and ';
          v_text = v_text || '       q81_tipo in ( select q81_codigo from w_origemdados ) and ativtipo.q80_ativ = ' || v_ativprinc;
          
          v_area = v_pontuacaogeral;

          if lraise is true then
            raise notice 'v_area - % ',v_area;
          end if;
          
        end if;
        
        if lCalculaPorPorteAtividade then

          select array_upper(array_accum(distinct substr(q71_estrutural,2,5)::integer),1) 
            into v_quantativ
            from tabativ 
                 inner join issbaseporte        on q45_inscr    = q07_inscr 
                 inner join tabativportetipcalc on q143_issporte = q45_codporte 
                                               and q143_ativid   = q07_ativ 
                 inner join tipcalc             on q81_codigo   = q143_tipcalc 
                 inner join atividcnae          on atividcnae.q74_ativid        = tabativ.q07_ativ 
                 inner join cnaeanalitica       on cnaeanalitica.q72_sequencial = atividcnae.q74_cnaeanalitica 
                 inner join cnae                on cnae.q71_sequencial          = cnaeanalitica.q72_cnae 
           where q07_inscr = v_y71_inscr 
             and q81_tipo in (3,5,6) 
             and (q07_datafi is null or q07_datafi >= current_date) 
             and (q07_databx is null or q07_databx >= current_date);

        else

          select count(*) 
            into v_quantativ 
            from ( select distinct 
                          q07_seq
                     from tabativ 
                          inner join ativtipo on ativtipo.q80_ativ = tabativ.q07_ativ 
                          inner join tipcalc on q81_codigo = q80_tipcal 
                    where q81_tipo in (3,5,6) 
                      and q07_inscr = v_y71_inscr 
                      and (q07_datafi is null or q07_datafi >= current_date) 
                      and (q07_databx is null or q07_databx >= current_date) ) as x;
        end if;
        
        if lraise is true then
          raise notice 'v_quantativ: %', v_quantativ;
        end if;
        
        if lraise is true then
          --raise notice 'v_text: %', v_text;
          raise notice 'antes do for...';
        end if;
        
        for v_record_ativtipo in execute v_text loop
          
          if lraise is true then
            raise notice 'dentro do for... vcalculou : % - tipcalc: % - area: % - qiexe: % - qfexe: %',v_calculou, v_record_ativtipo.q81_codigo, v_area, v_record_ativtipo.q81_qiexe, v_record_ativtipo.q81_qfexe;
          end if;

          if lraise is true then
            raise notice '   antes do if... area - % q81_qiexe - % q81_qfexe - %',v_area,v_record_ativtipo.q81_qiexe,v_record_ativtipo.q81_qfexe;
          end if;

          if v_area >= v_record_ativtipo.q81_qiexe and v_area <= v_record_ativtipo.q81_qfexe then
            
            lencontrouquantidadecalculo := true;
            if lraise is true then
              raise notice '      processando tipcalc: %', v_record_ativtipo.q81_codigo;
            end if;
            
            select q81_recexe, 
                   q92_hist, 
                   q81_valexe, 
                   q92_tipo, 
                   q81_excedenteativ,
                   (select distinct 
                           q83_codven 
                      from tipcalcexe 
                     where q83_tipcalc = q81_codigo 
                       and q83_anousu = v_anousu )
              into v_q81_recexe,
                   v_q92_hist,
                   v_q81_valexe,
                   v_q92_tipo,
                   v_excedente,
                   icodvencimento
              from tipcalc
                   inner join tipcalcexe  on tipcalcexe.q83_anousu = v_anousu 
                                         and tipcalcexe.q83_tipcalc = tipcalc.q81_codigo
                   inner join cadcalc     on q81_cadcalc = q85_codigo 
                   inner join cadvencdesc on q92_codigo = tipcalcexe.q83_codven             
             where q81_codigo = v_record_ativtipo.q81_codigo;
            
            if icodvencimento is null then
              return '18-sem vencimento configurado para o exercicio!';
            end if;

            /*
               verifica se eh para calcular pela issquant ou tabativ
            */
            if v_record_ativtipo.q81_uqcad is true then
               select q30_mult from issquant into v_multicad where q30_inscr = v_y71_inscr and q30_anousu = v_anousu;
               if not found then
                  return '22 - inscricao sem multiplicador cadastrado na issquant';
               end if;

               if v_multicad is null or v_multicad = 0 then
                  v_multicad := 1;
               end if;
            end if;

            if v_record_ativtipo.q81_uqtab is true then
               select q07_quant
               into v_multitab
               from tabativ
               where q07_inscr = v_y71_inscr and q07_ativ = v_record_ativtipo.q80_ativ and q07_databx is null;
               if not found then
                  return '23 - inscricao sem atividade cadastrada na tabativ ou atividade baixada';
               end if;

               if v_multitab is null or v_multitab = 0 then
                  v_multitab := 1;
               end if;
            end if;

            v_valalancar = round(v_q81_valexe * v_valinflator * v_base * v_multicad * v_multitab,2);
            v_calculou = true;
            
            if lraise is true then
              raise notice 'v_valalancar (1): % - k00_numpre: % - v_valinflator: % - v_base: %', v_valalancar, v_numpre, v_valinflator, v_base;
            end if;
            
            if v_excedente > 0 then
              if lraise is true then
                raise notice 'valor antes: %', v_valalancar;
              end if;
              v_valalancar = v_valalancar + (v_valalancar * v_excedente * (v_quantativ - 1));
              if lraise is true then
                raise notice 'valor depois: %', v_valalancar;
              end if;
            end if;

            --
            -- inserindo pelo issbase
            --            
            -- funcao para gerar o financeiro 
            -- 
            select * 
              into rfinanceiro 
              from fc_gerafinanceiro(v_numpre,v_valalancar,icodvencimento,v_q02_numcgm,v_data,v_q81_recexe,ddatavistoria);

            select k00_numpre 
              into v_numpreinscr 
              from arreinscr 
             where k00_numpre = v_numpre;

            if v_numpreinscr != 0 or v_numpreinscr is not null then
              delete from arreinscr where k00_numpre = v_numpreinscr;
            end if;
            insert into arreinscr (k00_numpre, k00_inscr)
                           values (v_numpre, v_y71_inscr);
          end if;
          
        end loop;
        
        
        if lencontrouquantidadecalculo is false then 
          return '24-area/empregados nao enquadrada no tipo de calculo.';
        end if;  
        
        if lraise is true then
          raise notice 'fora do for... v_calculou: %', v_calculou;
        end if;
        
        if v_calculou is true then
          return '09-ok inscricao numero ' || v_y71_inscr;
        else
          return '19-ocorreu algum erro durante o calculo (2)!!!';
        end if;
        
      end if;    
  end;
  
$$ language 'plpgsql';insert into db_versaoant (db31_codver,db31_data) values (342, current_date);
select setval ('db_versaousu_db32_codusu_seq',(select max (db32_codusu) from db_versaousu));
select setval ('db_versaousutarefa_db28_sequencial_seq',(select max (db28_sequencial) from db_versaousutarefa));
select setval ('db_versaocpd_db33_codcpd_seq',(select max (db33_codcpd) from db_versaocpd));
select setval ('db_versaocpdarq_db34_codarq_seq',(select max (db34_codarq) from db_versaocpdarq));insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,56,'A partir desta versão, ao consultar na CGF por CGM, Matricula, Inscrição ou outro filtro, que esteja vinculado a um CGM com CPF/CNPJ inválido, será listado mensagem de alerta na tela.','2014-06-30','Mensagem de usuário');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8314,95466);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,4884,'A partir desta versão, ao importar para divida ativa um débito de Auto de Infração, irá gravar nas observações da divida o nome do débito e o número do auto de infração. ','2014-06-30','Mensagem de usuário');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8311,95450);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,2343,'A partir desta versão esta disponível o alvará sanitário em Openoffice.','2014-06-30','Mensagem de usuário');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8284,52990);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,3571,'A partir desta versão, foi alterada a tela da rotina de Emite Guia de ITBI para permitir informar o número da guia no campo Código da ITBI sem ser necessário clicar no link.','2014-06-30','Mensagem de usuário');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8300,90035);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,3875,'A partir desta versão, foi criada a variável para listar a data de expedição do alvará de obras no documento da Carta de Alvará em openoffice.','2014-06-30','Mensagem de usuário');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8312,95463);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,2551,'A partir desta versão foi criado campo Percentual transmitido na tela da aba Dados do Imóvel da rotina de Inclusão de ITBI, para que seja informado o percentual da área total que esta sendo transmitido. Será informado por default 100% e quando a informação deste campo for alterada, o valor informado no campo Área Transmitida será alterado também.','2014-06-30',' Mensagem de usuário  ');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8298,83872);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,4232,'A partir desta versão, foi criado link Cancelamentos na tela de consulta de ITBI, para quando a Guia de ITBI estiver cancelada deve listar a data do cancelamento, observações lançadas no cancelamento da guia e o nome do usuário que cancelou.','2014-06-30','Mensagem de usuário');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8302,92906);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,2558,'A partir desta versão, foi criado o parâmetro CGM obrigatório Adquirente/Transmitente na rotina Parâmetros do módulo ITBI, para que possa informar se deseja que seja obrigatório informar CGM ao incluir Adquirente e Transmitente, ou incluir os mesmos sem informar CGM.','2014-06-30',' Mensagem de usuário  ');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8299,83872);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,608589,'A partir desta versão, foi incluído a opção de filtrar os dados a partir da Característica Peculiar quando o tipo do cancelamento for Renuncia.','2014-06-30','Mensagem de usuário');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8318,95936);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,3913,'A partir desta versão, foi incluído no cabeçalho do relatório de Matriculas > Setor / Quadra / Lote os dados dos Setores que foram filtrados ao gerar relatório.','2014-06-30','Mensagem de usuário');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8313,95464);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,3571,'A partir desta versão, foi ordenadas as ITBI listadas no link Código da ITBI em ordem decrescente.','2014-06-30',' Mensagem de usuário  ');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8301,90035);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,9087,'Acrescentado campo PA (processo administrativo), o mesmo será emitido no seu documento.','2014-07-01','Segue mensagem para usuário:');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8307,94596);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,3998,'Acrescentado no documento após a informações da dotação orçamentária  o código e descrição do recurso.','2014-07-01','Segue mensagem para usuários:');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8310,95447);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,8692,'Adicionada coluna que informa a unidade de saída de cada material no relatório.','2014-07-01','Segue mensagem para usuários:');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8308,94650);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,9070,'Alterado o tamanho do campo para pesquisa de contas pelo seu código sequencial. Apesar de não haver problemas na gravação do código, o campo não admitia pesquisa em códigos contendo mais de 5 dígitos.','2014-07-01','Segue mensagem para usuários.');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8317,95787);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,3444,'Implementada função para permitir a digitação manual da receita de medicamentos.
Farmácia > Procedimentos >  Entrega de Medicamentos','2014-07-01','Mensagem de usuário');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8306,93664);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,5638,'Implementada impressão do campo \"Processo Administrativo\" no documento da Ordem de Pagamento quando este for informado nas rotinas de liquidação de empenhos.','2014-07-01','Segue mensagem para usuáiros');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8309,95376);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,4337,'Implementada na funcionalidade de seleção de instituições um novo dispositivo para marcar todas ao mesmo tempo. Isto funcionará em todos os menus onde esta seleção é utilizada.','2014-07-01','Segue mensagem para usuários');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8315,95572);

insert into db_versaousu (db32_codusu,db32_codver,db32_id_item,db32_obs,db32_data,db32_obsdb) values (nextval ('db_versaousu_db32_codusu_seq'),342,1100874,'Implementadas melhorias no cadastro  de bases curriculares, permitindo informar uma disciplina global para cada etapa e criar separadamente as disciplinas que compõem a base comum e a base diversificada.

Escolas>Cadastros>Bases Curriculares
Aba Geral
Retirado campo Disciplina Global da aba Geral e colocado na aba Disciplinas para que seja possível o lançamento de uma disciplina global para cada etapa.
Aba disciplinas 
-Criado  campo Tipo de Base com as opções Comum (default) e Diversificada;
-Campo Disciplina Global - ficará habilitado somente quando o campo Controle da Frequência for informado com a opção GLOBALIZADO;
-Campo Carácter Reprobatório - quando selecionada a opção Possui o sistema exigirá o lançamento de avaliações e resultado final para a disciplina. Se informado a opção Não possui, o lançamento e resultado final não serão obrigatórios;
-Campo Lançar na Documentação: SIM para lançar a disciplina nos relatórios, e NÃO para não exibir a disciplina nos relatórios. (Histórico Escolar, Ata de Resultados Finais, Boletim de Desempenho entre outros);
-Somente disciplinas com carácter reprobatório serão consideradas para gerar o resultado final do aluno;
-Disciplinas com Matrícula Obrigatória permanecem  obrigando o lançamento de avaliações para gerar o resultado final e encerramento das avaliações;
-Para Disciplinas Opcionais o lançamento das avaliações continua não obrigatório, exceto quando esta possuir carácter reprobatório. Os alunos da turma que não optarem por cursar a disciplina deverão ser amparados com o tipo de amparo POR CONVENÇÃO.

Escolas>Cadastros>Turmas>Inclusão/Alteração
Aba disciplinas
-Tela refatorada de acordo com as alterações no cadastro de bases curriculares;
-Ao incluir uma turma, se a base curricular possuir uma disciplina global, a mesma estará na turma com a opção Globalizada (FA);
-As disciplinas da base comum ficarão separadas da base diversificada;
-Criado  campo Tipo de Base com as opções Comum (default) e Diversificada.

Escolas>Procedimentos>Manutenção do Histórico Escolar 
Na tela de lançamentos das disciplinas foi incluido o campo Base Comum, quando selecionada a opção SIM, a disciplina será lançada como Base Comum e quando informada a opção NÃO, será lançada na Base Diversificada.','2014-06-30','Mensagem Usuário');
insert into db_versaousutarefa (db28_sequencial,db28_codusu,db28_tarefa) values (nextval ('db_versaousutarefa_db28_sequencial_seq'),8285,64998);

create table bkp_db_permissao_20140701_105401 as select * from db_permissao;
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


DROP VIEW if exists cadastro_portaria;
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
   LEFT JOIN portariaassinatura ON portaria.h31_portariaassinatura = portariaassinatura.rh136_sequencial;



create or replace function fc_parc_getselectorigens_atjuros(integer,integer,integer) returns varchar as
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
$$  language 'plpgsql';

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
