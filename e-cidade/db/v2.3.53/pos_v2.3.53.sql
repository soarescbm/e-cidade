insert into db_versao (db30_codver, db30_codversao, db30_codrelease, db30_data, db30_obs)  values (369, 3, 53, '2016-07-26', 'Tarefas: 99863, 99920, 99921, 99923, 99925, 99926, 99927, 99929, 99930, 99931, 99932, 99933, 99934, 99935, 99938, 99939, 99940, 99941, 99944, 99945, 99946, 99948, 99949, 99950, 99951, 99952, 99953, 99954, 99956, 99957, 99958, 99959, 99960, 99961, 99964, 99965, 99966, 99967, 99968, 99969, 99970, 99971, 99973, 99974, 99975, 99976, 99977, 99978, 99979, 99980, 99981, 99983, 99984, 99985, 99986, 99987, 99988, 99989, 99990, 99991, 99992, 99993, 99994, 99995, 99996, 99997, 99998, 99999, 100000, 100003, 100007, 100008, 100009, 100010, 100012, 100016, 100017, 100018, 100027, 100028, 100030, 100031, 100034, 100035, 100036, 100037, 100038, 100039, 100040, 100042, 100043, 100044, 100045, 100046, 100047, 100048, 100049, 100050, 100051, 100052, 100053, 100054, 100055, 100056, 100059, 100060, 100061, 100064');--
-- TOC Entry ID 712 (OID 217990288)
--
-- Name: "fc_conta_dias_afasta" (integer,integer,integer,integer) Type: FUNCTION Owner: postgres
--

drop function if exists conta_dias_afasta (integer,integer,integer,integer);
drop function if exists conta_dias_afasta (integer,integer,integer,integer,integer);

CREATE OR REPLACE FUNCTION conta_dias_afasta (integer,integer,integer,integer,integer)
RETURNS integer AS $$
DECLARE
    REGISTRO          ALIAS FOR $1 ;
    ANO               ALIAS FOR $2 ;
    MES               ALIAS FOR $3 ;
    NDIAS             ALIAS FOR $4 ;
    INSTIT            ALIAS FOR $5 ;

    RUBMAT            VARCHAR(4);
    RUBSAU            VARCHAR(4);
    RUBACI            VARCHAR(4);

    INICIO            DATE;
    FIM               DATE;
    QTDAFASTADOS      INTEGER := 0;
    QAFASTADOSNOVO    INTEGER := 0;
    TOTAL             INTEGER := 0;

BEGIN


    INICIO := TO_DATE(trim(TO_CHAR(ANO,'9999')
                     ||lpad(MES,2,0)
                     ||'01')
                    ,'YYYYMMDD')
                     ;
    FIM := TO_DATE(trim(TO_CHAR(ANO,'9999')
                     ||lpad(MES,2,0)
                     || TO_CHAR( NDIAS,'99' ))
                    ,'YYYYMMDD' ) ;

    TOTAL := 0;

SELECT r33_rubmat,
       r33_rubsau,
       r33_rubaci
FROM rhpessoalmov
     inner join inssirf on r33_anousu = rh02_anousu
                       and r33_mesusu = rh02_mesusu
                       and r33_codtab = rh02_tbprev+2
                       and r33_instit = rh02_instit
INTO RUBMAT, RUBSAU, RUBACI
WHERE rh02_regist = registro
  and rh02_anousu = ano
  and rh02_mesusu = mes
  and rh02_instit = instit;

    SELECT
        coalesce(sum( ( CASE WHEN (CASE WHEN R45_SITUAC = 8 
                                        THEN (R45_DTAFAS + 30) 
                                        ELSE R45_DTAFAS 
                                         END) < INICIO
                             THEN ( ( CASE WHEN R45_DTRETO IS NULL
                                           THEN FIM
                                           ELSE R45_DTRETO
                                            END ) - INICIO + 1 )
                            else ( ( CASE WHEN (R45_SITUAC = 8 AND (R45_DTAFAS + 30) > FIM)
                                           THEN (CASE WHEN NDIAS = 31
                                                      THEN 1
                                                      ELSE 0
                                                      END
                                                )
                                           WHEN (R45_SITUAC = 8 AND (R45_DTAFAS + 30) <= FIM AND (R45_DTAFAS + 30) >= INICIO)
                                           THEN (CASE WHEN R45_DTRETO IS NULL or R45_DTRETO > FIM
                                                      THEN FIM - (R45_DTAFAS + 30) + 1
                                                      ELSE R45_DTRETO - (R45_DTAFAS + 30) + 1
                                                      END
                                                )
                                           WHEN (R45_DTRETO IS NULL or R45_DTRETO > FIM )
                                           THEN FIM - R45_DTAFAS + 1
                                           ELSE r45_dtreto - R45_DTAFAS+1
                                           END ) )
                              END ) ),0) INTO QTDAFASTADOS
         FROM AFASTA
         WHERE R45_anousu = ANO
	   AND (
	           ( R45_situac  = 5 and (rubmat is null or trim(rubmat) = '' ))
	        or ( r45_situac  = 3 and (rubaci is null or trim(rubaci) = ''))
	        or ( r45_situac  = 6 and (rubsau is null or trim(rubsau) = '' ))
			    or ( r45_situac  = 8 and (rubsau is null or trim(rubsau) = '' ))
	        or ( r45_situac  = 2 )
	        or ( r45_situac  = 7 )
	       )
           AND R45_mesusu = MES
           AND R45_REGIST = REGISTRO
           AND (   ( R45_DTAFAS <=  FIM
                     AND R45_DTRETO IS NULL )
                OR ( R45_DTAFAS >= INICIO
                     AND R45_DTRETO <= FIM )
                OR ( R45_DTRETO > FIM
                     AND R45_DTAFAS >= INICIO
                     AND R45_DTAFAS <= FIM  )
                OR ( R45_DTAFAS < INICIO
                     AND R45_DTRETO >= INICIO )
                OR ( R45_DTRETO >  FIM
                     AND R45_DTAFAS < INICIO ));

    TOTAL := TOTAL + QTDAFASTADOS;
    SELECT
        coalesce(sum( ( CASE WHEN R69_DTAFAST < INICIO
                THEN ( ( CASE WHEN R69_DTRETORNO IS NULL
                              THEN FIM
                              ELSE R69_DTRETORNO
                               END ) - INICIO + 1)
                else ( ( CASE WHEN ( R69_DTRETORNO IS NULL or R69_DTRETORNO > FIM )
                              THEN FIM - R69_DTAFAST + 1
                              ELSE r69_DTRETORNO - R69_DTAFAST+1
                              END ) )
                 END ) ),0) INTO QAFASTADOSNOVO
         FROM AFASTAMENTO, CAD_AFAST
         WHERE R69_anousu = ANO
           AND R69_mesusu = MES
           AND R69_REGIST = REGISTRO
           AND (   ( R69_DTAFAST <=  FIM
                     AND R69_DTRETORNO IS NULL )
                OR ( R69_DTAFAST >= INICIO
                     AND R69_DTRETORNO <= FIM )
                OR ( R69_DTRETORNO > FIM
                     AND R69_DTAFAST >= INICIO
                     AND R69_DTAFAST <= FIM  )
                OR ( R69_DTAFAST < INICIO
                     AND R69_DTRETORNO >= INICIO )
                OR ( R69_DTRETORNO >  FIM
                     AND R69_DTAFAST < INICIO ))
           AND R68_anousu = ANO
           AND R68_mesusu = MES
           AND R68_CODIGO = R69_CODIGO
           AND R68_VT = 'f';


    TOTAL := TOTAL +QAFASTADOSNOVO;

RETURN TOTAL;

END;

$$ LANGUAGE 'plpgsql';-- ID do Commit: $Id: cgs_endereco.sql,v 1.4 2016/07/25 13:30:52 dbfabio.esteves Exp $

CREATE OR REPLACE FUNCTION fc_cgs_endereco_inc_alt() returns trigger AS
$$   
declare 
    
  iCodigoEstado       integer default 0;
  iCodigoMunicipio    integer default 0;
  iCodigoBairro       integer default 0;
  iCodigoRua          integer default 0;
  iCodigoBairroRua    integer default 0;
  iCodigoLocal        integer default 0;
  iCodigoEndereco     integer default 0;
  iCodigoRuasTipo     integer default 0;
  iCodigoCGS          integer default 0;
  iCodigoCGSEndereco  integer default 0;
  iNumCGSEndereco     integer default 0;

  lRaise              boolean default false;
  sOperacao           text    default '';    

  recordCGS           record;
  recordParametrosEndereco      record;
  rEndereco           record;
begin
      
  lRaise  := case when fc_getsession('DB_debugon') is null then false else true end;
  perform fc_debug('Inicio do Debug da Trigger de Atualizacao de Endereco do CGS', lRaise, true, false);

  if (fc_getsession('DB_desativa_trigger_endereco') is null) then
    return NEW;
  end if;
    
  sOperacao := upper(TG_OP);


  if (sOperacao = 'INSERT') then
    iCodigoCGS := NEW.z01_i_cgsund;
  else 
    iCodigoCGS := OLD.z01_i_cgsund;
  end if;


  /**
   * Verificar se o CGS alterado esta incluído na cgs_undendereco 
   * se estiver tem que verificar campo a campo se houve alteração
   * se não estiver tem que gerar um endereco novo e fazer a ligação 
   * da cgs_undendereco
   */
  select z01_i_cgsund          as codigo_cgs,
         z01_v_ender           as endereco,
         z01_i_numero::varchar as numero,
         z01_v_compl           as complemento,
         z01_v_bairro          as bairro,
         z01_v_munic           as municipio,
         z01_v_uf              as estado_uf,
         z01_v_cep             as cep,
         z01_v_endcon          as endereco_comercial,
         z01_i_numcon          as numero_comercial,
         z01_v_comcon          as complemento_comercial,
         ''                    as bairro_comercial,
         z01_v_muncon          as municipio_comercial,
         z01_v_ufcon           as estado_uf_comercial,
         z01_v_cepcon          as cepcon
    into recordCGS
    from cgs_und 
   where z01_i_cgsund = iCodigoCGS;

      
  if not found then
    perform fc_debug('Nenhum registro retornado para o CGS: ' || iCodigoCGS);
    return null;
  end if;
  
  perform fc_debug('CGS pesquisado: ' || iCodigoCGS);


  if (recordCGS.endereco = '') then
    perform fc_debug('Endereco vazio');
    return null;
  end if;
  
----------------------------------------------- INICIO VERIFICAÇÃO DOS DADOS DO ENDEREÇO -------------------------------------------

  select db99_cadenderpais       as codigoPadraoPais,
         db70_descricao          as descricaoPadraoPais,

         db99_cadenderestado     as codigoPadraoEstado,
         db71_descricao          as descricaoPadraoEstado,
         db71_sigla              as siglaPadraoEstado,

         db99_cadendermunicipio  as codigoPadraoMunicipio,
         db72_descricao          as descricaoPadraoMunicipio
    into recordParametrosEndereco 
    from cadenderparam
         inner join cadenderpais      on cadenderpais.db70_sequencial      = cadenderparam.db99_cadenderpais
         inner join cadenderestado    on cadenderestado.db71_sequencial    = cadenderparam.db99_cadenderestado
         inner join cadendermunicipio on cadendermunicipio.db72_sequencial = cadenderparam.db99_cadendermunicipio;

  if not found then
    perform fc_debug('PARAMETROS DO ENDERECO NAO CONFIGURADOS.');
    return null;
  end if;
    
  perform fc_debug('- Dados Padrao para o Pais:      ' || recordParametrosEndereco.codigoPadraoPais      || ' - ' 
                                                       || recordParametrosEndereco.descricaoPadraoPais
  );
  perform fc_debug('- Dados Padrao para o Estado:    ' || recordParametrosEndereco.codigoPadraoEstado    || ' - ' 
                                                       || recordParametrosEndereco.descricaoPadraoEstado || ' - ' 
                                                       || recordParametrosEndereco.siglaPadraoEstado 
  );
  perform fc_debug('- Dados Padrao para o Municipio: ' || recordParametrosEndereco.codigoPadraoMunicipio || ' - ' 
                                                       || recordParametrosEndereco.descricaoPadraoMunicipio
  );

  /**
   * Pesquisando relação do CGS com o endereco
   */
  select sd109_sequencial as codigoLigacaoEndereco, 
         sd109_endereco   as codigoEndereco
    into iCodigoCGSEndereco, 
         iCodigoEndereco 
    from cgs_undendereco
   where sd109_cgs_und = iCodigoCGS;
  
  if not found then
  ------------------ Se o CGS não existir na tabela de ligação Cria novo endereço para vincular. ID.000001---------------------------

    perform fc_debug('CGS sem endereco cadastrado, sera incluido novo registro.');

    ----------------------------------------------- INICIO do tratameno do estado do ESTADO -------------------------------------------
      -- 
      -- Código padrão do Estado
      -- 
      iCodigoEstado := recordParametrosEndereco.codigoPadraoEstado;
            
      --
      -- Verificar se estado_uf e municipio são diferentes de vazio
      -- se não for atribuir o estado default para o municipio não informado RS, 0-Não Informado 
      --
      if ( (recordCGS.municipio, recordCGS.estado_uf, recordCGS.bairro) != ('','','') ) then
        
        select db71_sequencial
          into iCodigoEstado
          from cadenderestado
         where db71_sigla = trim(recordCGS.estado_uf);

        --   
        -- Se não localizar o estado atribuir o estado dos parametros do endereço
        -- 
        if not found then
          perform fc_debug('Estado não encontrado pela sigla fornecida atribuido dos Parametros do endereco');
        end if;
        iCodigoEstado := recordParametrosEndereco.codigoPadraoEstado;
      end if; -- Fechamento do if (recordCGS.municipio, recordCGS.estado_uf, recordCGS.bairro) != ('','','')
    ----------------------------------------------- FINAL do tratameno do estado do ESTADO --------------------------------------------


    ----------------------------------------------- Inicio do tratameno do estado do Municipio ----------------------------------------
      perform fc_debug('Caso Municipio não seja informado, 0 - Nao informado será utilizado');
      iCodigoMunicipio := 0;

      if (recordCGS.municipio != '') then
        
        select cadendermunicipio.db72_sequencial
          into iCodigoMunicipio
          from cadendermunicipio
         where trim(cadendermunicipio.db72_descricao) = trim(recordCGS.municipio)
           and cadendermunicipio.db72_cadenderestado  = iCodigoEstado;

        --  
        -- Se não encontrou o municipio entao tem que incluir
        -- 
        if not found then

          perform fc_debug('Municipio informado não foi encontrado, será incluido um novo');
          
          iCodigoMunicipio := nextval('cadendermunicipio_db72_sequencial_seq');
          
          insert into cadendermunicipio (
            db72_sequencial,
            db72_descricao,
            db72_cadenderestado
          ) values (
            iCodigoMunicipio,
            recordCGS.municipio,
            iCodigoEstado
          );
        end if;

      end if;
    ---------------------------------------------------- Fim do tratamento do Municipio -----------------------------------------------


    ----------------------------------------------- INICIO TRATAMENTO DOS DADOS DO BAIRRO ---------------------------------------------
      iCodigoBairro := 0; -- Código default

      --  
      -- Se o bairro diferente de vazio pesquisar se existe senão incluir
      -- 
      if (recordCGS.bairro != '') then

        select cadenderbairro.db73_sequencial
          into iCodigoBairro
          from cadenderbairro
         where cadenderbairro.db73_descricao         = recordCGS.bairro 
           and cadenderbairro.db73_cadendermunicipio = iCodigoMunicipio;
       
        if not found then

          perform fc_debug('Bairro não encontrado, será incluído um novo.');

          iCodigoBairro := nextval('cadenderbairro_db73_sequencial_seq');

          insert into cadenderbairro (
            db73_sequencial,
            db73_descricao,
            db73_cadendermunicipio
          ) values (
            iCodigoBairro,
            recordCGS.bairro,
            iCodigoMunicipio
          );
        end if;

      end if;
    ----------------------------------------------- FINAL TRATAMENTO DOS DADOS DO BAIRRO ----------------------------------------------


    ----------------------------------------------- FINAL TRATAMENTO DOS DADOS DA RUA -------------------------------------------------
      if (recordCGS.endereco = '') then
        
        perform fc_debug('Cadastro não pode continuar sem endereço.');
        return null;
      end if;
          
      select cadenderrua.db74_sequencial
        into iCodigoRua
        from cadenderrua
       where cadenderrua.db74_descricao         = recordCGS.endereco
         and cadenderrua.db74_cadendermunicipio = iCodigoMunicipio;
      
      if not found then

        perform fc_debug('Rua não encontrada, será incluído uma nova.');
        
        iCodigoRua := nextval('cadenderrua_db74_sequencial_seq');
        
        insert into cadenderrua (
          db74_sequencial,
          db74_descricao,
          db74_cadendermunicipio
        ) values (
          iCodigoRua,
          recordCGS.endereco,
          iCodigoMunicipio
        );
      end if;
                
      --
      -- Verfica se a rua informada já está vinculada a uma 
      --
      perform cadenderruaruastipo.db85_sequencial from cadenderruaruastipo where cadenderruaruastipo.db85_cadenderrua = iCodigoRua;
          
      if not found then
        perform fc_debug('Vinculando RUA ao TIPO DE RUA');

        insert into cadenderruaruastipo (
          db85_sequencial,
          db85_cadenderrua,
          db85_ruastipo
        ) values (
          nextval('cadenderruaruastipo_db85_sequencial_seq'),
          iCodigoRua,
          3
        );
      end if;
             

      --
      -- Vinculação do BAIRRO com a RUA
      --
      select cadenderbairrocadenderrua.db87_sequencial
        into iCodigoBairroRua
        from cadenderbairrocadenderrua
       where cadenderbairrocadenderrua.db87_cadenderrua    = iCodigoRua
         and cadenderbairrocadenderrua.db87_cadenderbairro = iCodigoBairro;

      if not found then

        perform fc_debug('Não existe vinculação entre BAIRRO e RUA, criando nova...');

        iCodigoBairroRua := nextval('cadenderbairrocadenderrua_db87_sequencial_seq');

        insert into cadenderbairrocadenderrua (
          db87_sequencial,
          db87_cadenderrua,
          db87_cadenderbairro
        ) values (
          iCodigoBairroRua,
          iCodigoRua,
          iCodigoBairro
        );

      end if;

      --
      -- Vinculação da RUA com o LOCAL
      -- 
      select cadenderlocal.db75_sequencial
        into iCodigoLocal
        from cadenderlocal
       where cadenderlocal.db75_cadenderbairrocadenderrua = iCodigoBairroRua;

      if not found then
        
        perform fc_debug('Não existe vinculação do LOCAL com a RUA, incluindo...');

        iCodigoLocal := nextval('cadenderlocal_db75_sequencial_seq');

        insert into cadenderlocal (  
          db75_sequencial,
          db75_cadenderbairrocadenderrua,
          db75_numero
        ) values (
          iCodigoLocal,
          iCodigoBairroRua,
          recordCGS.numero     
        );
      end if;
    ----------------------------------------------- FINAL TRATAMENTO DOS DADOS DA RUA -------------------------------------------------
   

    ------------------------------------------------- INICIO DO TRATAMENTO DO ENDERECO ------------------------------------------------
      --
      -- Inserindo novo endereço
      --
      iCodigoEndereco := nextval('endereco_db76_sequencial_seq');
      
      perform fc_debug('Novo endereco:  ' || iCodigoEndereco);       
      perform fc_debug(' - Complemento: ' || recordCGS.complemento);       
      perform fc_debug(' - CEP........: ' || recordCGS.cep);       

      insert into endereco (
        db76_sequencial,
        db76_cadenderlocal,
        db76_complemento,
        db76_cep
      ) values (
        iCodigoEndereco,
        iCodigoLocal,
        recordCGS.complemento,
        recordCGS.cep
      );

      --
      -- Vinculando endereço com o CGS
      -- 
      perform fc_debug('Vinculando Código do CGS com o Endereço.');

      insert into cgs_undendereco (
        sd109_sequencial,
        sd109_endereco,
        sd109_cgs_und
      ) values (
        nextval('cgs_undendereco_sd109_sequencial_seq'),
        iCodigoEndereco,
        iCodigoCGS
      );
    -------------------------------------------------- FINAL DO TRATAMENTO DO ENDERECO ------------------------------------------------
  else  
  --------------------------------- Se ja exisitir na cgs_undendereco verifica mudanças ID.000001------------------------------------
    
    select cadenderrua.db74_sequencial        as codigoRua,
           cadenderrua.db74_descricao         as descricaoRua,
           
           cadenderlocal.db75_numero          as codigoLocal,
           
           cadenderbairro.db73_sequencial     as codigoBairro,
           cadenderbairro.db73_descricao      as descricaoBairro,
           
           cadendermunicipio.db72_sequencial  as codigoMunicipio,
           cadendermunicipio.db72_descricao   as descricaoMunicipio,

           cadenderestado.db71_sequencial     as codigoEstado,
           cadenderestado.db71_descricao      as descricaoEstado,
           cadenderestado.db71_sigla          as siglaEstado,
           
           endereco.db76_sequencial           as codigoEndereco,
           endereco.db76_cep                  as cep,
           endereco.db76_pontoref             as pontoReferencia,
           endereco.db76_condominio           as numeroCondominio,
           endereco.db76_loteamento           as numeroLoteamento,
           endereco.db76_caixapostal          as numeroCaixaPostal,
           endereco.db76_complemento          as complemento
      into rEndereco
      from endereco 
           inner join cadenderlocal             on cadenderlocal.db75_sequencial             = endereco.db76_cadenderlocal
           inner join cadenderbairrocadenderrua on cadenderbairrocadenderrua.db87_sequencial = cadenderlocal.db75_cadenderbairrocadenderrua
           inner join cadenderrua               on cadenderrua.db74_sequencial               = cadenderbairrocadenderrua.db87_cadenderrua
           inner join cadenderbairro            on cadenderbairro.db73_sequencial            = cadenderbairrocadenderrua.db87_cadenderbairro
           inner join cadendermunicipio         on cadendermunicipio.db72_sequencial         = cadenderrua.db74_cadendermunicipio
           inner join cadenderestado            on cadenderestado.db71_sequencial            = cadendermunicipio.db72_cadenderestado 
     where db76_sequencial = iCodigoEndereco;
             
    if not found then
      perform fc_debug('Não foi possivel recuperar todos os dados para o Endereço: ' || iCodigoEndereco || ' do CGS ' || iCodigoCGS);
      return null;
    end if;
                        
    ------------------------------------------------- INICIO Verificação de Mudança de ESTADO -----------------------------------------------
      select cadenderestado.db71_sequencial
        into iCodigoEstado
        from cadenderestado 
       where cadenderestado.db71_sigla = case when rEndereco.siglaEstado != recordCGS.estado_uf -- Caso estado informado seja diferente
                                              then recordCGS.estado_uf                          -- Utiliza o estado da Operação do Banco
                                              else rEndereco.siglaEstado end;                       -- Caso contrário o do endereço cadastrado
      
      if not found then 

        perform fc_debug(
          'Nenhum estado cadastrado com a sigla: ' || 
          case when rEndereco.siglaEstado != recordCGS.estado_uf
               then recordCGS.estado_uf                         
               else rEndereco.siglaEstado end
        ); 

        return null;
      end if;
    -------------------------------------------------- FINAL Verificação de Mudança de ESTADO -----------------------------------------------
           
    ------------------------------------------------ INICIO Verificação de Mudança de MUNICIPIO ---------------------------------------------
      -- 
      -- Se o municipio vazio atribui 0-Não Informaado e estado Default
      -- 
      iCodigoMunicipio := 0;
      iCodigoEstado    := recordParametrosEndereco.codigoPadraoEstado;

      -- 
      -- Verifica se houve mudança no municipio cadastrado 
      -- procurar pelo municipio se existe se não cadastrar
      -- 
      if (recordCGS.municipio != '') then

        select cadendermunicipio.db72_sequencial
          into iCodigoMunicipio
          from cadendermunicipio 
         where trim(cadendermunicipio.db72_descricao) = trim(recordCGS.municipio);
        
        if not found then 
          
          perform fc_debug('Vinculação do Municipio com o estado não exista, será criado uma nova...');

          iCodigoMunicipio := nextval('cadendermunicipio_db72_sequencial_seq');

          insert into cadendermunicipio (
            db72_sequencial,
            descricaoPadraoMunicipio,
            db72_cadenderestado
          ) values (
            iCodigoMunicipio,
            recordCGS.municipio,
            iCodigoEstado
          );
          
        end if;
           
      end if;/*Fim do if do municipio*/
    ------------------------------------------------- FINAL Verificação de Mudança de MUNICIPIO ---------------------------------------------
    
    ------------------------------------------------- INICIO Verificação de Mudança de BAIRRO -----------------------------------------------
            iCodigoBairro := 0; -- Padrão: Não informado
              
            --
            -- Verifica se houve mudança no municipio cadastrado 
            -- procura pelo municipio 
            -- se existe se não cadastra
            -- 
            if (recordCGS.bairro != '') then

              select cadenderbairro.db73_sequencial
                into iCodigoBairro
                from cadenderbairro 
               where trim(cadenderbairro.db73_descricao)   = trim(recordCGS.bairro)
                 and cadenderbairro.db73_cadendermunicipio = iCodigoMunicipio;
              
              if not found then 
                
                perform fc_debug('Vinculação com bairro e municipio não existe, uma nova será criada.');
                
                iCodigoBairro := nextval('cadenderbairro_db73_sequencial_seq');

                insert into cadenderbairro (
                  db73_sequencial,                                            
                  db73_descricao,                                            
                  db73_cadendermunicipio
                ) values (
                  iCodigoBairro,
                  recordCGS.bairro,
                  iCodigoMunicipio  
                );
              end if;
                 
            end if;
    -------------------------------------------------- FINAL Verificação de Mudança de BAIRRO -----------------------------------------------

    --------------------------------------------------- INICIO Verificação de Mudança de RUA ------------------------------------------------
        if (recordCGS.endereco ='') then

          perform fc_debug('Campo endereço não foi informado.');
          return null;
        end if;

        select cadenderrua.db74_sequencial
          into iCodigoRua
          from cadenderrua 
         where cadenderrua.db74_descricao         = recordCGS.endereco
           and cadenderrua.db74_cadendermunicipio = iCodigoMunicipio;
        
        if not found then 
          
          perform fc_debug('Vinculação entre Rua e Cidade não encontrada, uma nova será criada.');
          iCodigoRua := nextval('cadenderrua_db74_sequencial_seq');

          insert into cadenderrua (
            db74_sequencial,
            db74_descricao,
            db74_cadendermunicipio
          ) values (
            iCodigoRua,
            recordCGS.endereco,
            iCodigoMunicipio
          );
        end if;
    ---------------------------------------------------- FINAL Verificação de Mudança de RUA ------------------------------------------------

    ---------------------------------------------- INICIO Verificação de Mudança de TIPO DE RUA ---------------------------------------------

        perform db85_sequencial from cadenderruaruastipo where db85_cadenderrua = iCodigoRua;
        
        if not found then

          perform fc_debug('TIPO DE RUA não informado, criando um novo...');

          iCodigoRuasTipo := nextval('cadenderruaruastipo_db85_sequencial_seq');

          insert into cadenderruaruastipo (
            db85_sequencial,
            db85_cadenderrua,
            db85_ruastipo
          ) values (
            iCodigoRuasTipo,
            iCodigoRua,
            3
          );
        end if;
    ----------------------------------------------- FINAL Verificação de Mudança de TIPO DE RUA ---------------------------------------------

    ---------------------------------------------- INICIO Verificação de Mudança de BAIRO na RUA --------------------------------------------
        select cadenderbairrocadenderrua.db87_sequencial
          into iCodigoBairroRua
          from cadenderbairrocadenderrua
         where cadenderbairrocadenderrua.db87_cadenderrua    = iCodigoRua
           and cadenderbairrocadenderrua.db87_cadenderbairro = iCodigoBairro;

        if not found then
          
          if lRaise then
            raise notice 'Incluindo na BairroRua';
          end if;

          iCodigoBairroRua := nextval('cadenderbairrocadenderrua_db87_sequencial_seq'); 

          insert into cadenderbairrocadenderrua (
            db87_sequencial,
            db87_cadenderrua,
            db87_cadenderbairro
          ) values (
            iCodigoBairroRua,
            iCodigoRua,
            iCodigoBairro
          );
        end if;
    ----------------------------------------------- FINAL Verificação de Mudança de BAIRO na RUA --------------------------------------------

    ------------------------------------------------- INICIO Verificação de Mudança de LOCAL ------------------------------------------------

        select cadenderlocal.db75_sequencial
          into iCodigoLocal
          from cadenderlocal 
         where cadenderlocal.db75_cadenderbairrocadenderrua = iCodigoBairroRua
           and cadenderlocal.db75_numero                    = cast(recordCGS.numero as text);
        
        if not found then
          
          iCodigoLocal := nextval('cadenderlocal_db75_sequencial_seq');

          insert into cadenderlocal (
            db75_sequencial,
            db75_cadenderbairrocadenderrua,
            db75_numero
          ) values (
            iCodigoLocal,
            iCodigoBairroRua,
            recordCGS.numero
          );
        end if;
    -------------------------------------------------  FINAL Verificação de Mudança de LOCAL ------------------------------------------------

    ------------------------------------------------ INICIO Verificação de Mudança de Endereco ----------------------------------------------

        select count(*) 
          into iNumCGSEndereco
          from cgs_undendereco 
         where sd109_endereco = iCodigoEndereco 
        having count(*) > 1;

        delete from cgs_undendereco where sd109_cgs_und = iCodigoCGS;
              

        if (iNumCGSEndereco > 0 and (recordCGS.complemento != rEndereco.complemento)) then -- ID.000002

          perform fc_debug('Existe mais de um CGS no mesmo endereco inserindo endereco novo');

          iCodigoEndereco := nextval('endereco_db76_sequencial_seq');

          insert into endereco (
            db76_sequencial,
            db76_cadenderlocal,
            db76_complemento,
            db76_caixapostal,
            db76_loteamento,
            db76_condominio,
            db76_pontoref,
            db76_cep
          ) values (
            iCodigoEndereco,
            iCodigoLocal,
            recordCGS.complemento,
            rEndereco.numeroCaixaPostal,
            rEndereco.numeroLoteamento,
            rEndereco.numeroCondominio,
            rEndereco.pontoReferencia,
            recordCGS.cep
          );
        else -- ID.000002
          
          perform db76_sequencial
             from endereco
            where db76_sequencial    = iCodigoEndereco
              and db76_cadenderlocal = iCodigoLocal;

          if not found then

            iCodigoEndereco := nextval('endereco_db76_sequencial_seq');

            insert into endereco (
              db76_sequencial,
              db76_cadenderlocal,
              db76_complemento,
              db76_caixapostal,
              db76_loteamento,
              db76_condominio,
              db76_pontoref,
              db76_cep
            ) values (
              iCodigoEndereco,
              iCodigoLocal,
              recordCGS.complemento,
              rEndereco.numeroCaixaPostal,
              rEndereco.numeroLoteamento,
              rEndereco.numeroCondominio,
              rEndereco.pontoReferencia,
              recordCGS.cep
            );


          else 

            update endereco 
               set db76_cadenderlocal = iCodigoLocal,
                   db76_complemento   = recordCGS.complemento,
                   db76_cep           = recordCGS.cep
             where db76_sequencial    = rEndereco.codigoEndereco;
          end if;

        end if; -- ID.000002

        insert into cgs_undendereco(
          sd109_sequencial,
          sd109_endereco,
          sd109_cgs_und
        ) values (
          nextval('cgs_undendereco_sd109_sequencial_seq'),
          iCodigoEndereco,
          iCodigoCGS
        );
    ------------------------------------------------  FINAL Verificação de Mudança de Endereco ----------------------------------------------

  end if;
  -------------------------------------------------------------- FIM ID.000001---------------------------------------------------------------
  return null;  

end;

$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS tg_cgs_endereco_inc_alt on cgs_und;
CREATE TRIGGER tg_cgs_endereco_inc_alt AFTER UPDATE OR INSERT ON cgs_und FOR EACH ROW EXECUTE PROCEDURE fc_cgs_endereco_inc_alt();drop function if exists fc_baixabanco(integer, date);
create or replace function fc_baixabanco( cod_ret integer,
                                          datausu date,
                                          OUT codigo_retorno integer,
                                          OUT descricao text)
returns record as
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
  iReceitaPadraoCredito            integer;
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

  nValorTotalReciboPaga            numeric;

  rVinculoArre                     record;
  rValorRecibopaga                 record;

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
         coalesce(numpref.k03_toleranciacredito,0)::numeric(15, 2),
         k03_receitapadraocredito
    into lAtivaPgtoParcial,
         iNumprePagamentoParcial,
         iTipoReciboAvulso,
         nVlrToleranciaPgtoParcial,
         nVlrToleranciaCredito,
         iReceitaPadraoCredito
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
     perform fc_debug('  <BaixaBanco>  - iReceitaPadraoCredito:  '||iReceitaPadraoCredito         ,lRaise,false,false);
   end if;

   if iTipoReciboAvulso is null then

     codigo_retorno := 2;
     descricao := 'Operacao Cancelada. Tipo de Debito nao configurado para Recibo Avulso.';
     return;
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
    codigo_retorno := 3;
    descricao := 'ARQUIVO DE RETORNO DO BANCO JA CLASSIFICADO.';
    return;
  end if;

  if conta is null or conta = 0 then
    codigo_retorno := 4;
    descricao := 'SEM CONTA CADASTRADA PARA ARRECADACAO. OPERACAO CANCELADA.';
    return;
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

          codigo_retorno := 5;
          descricao := rRecibo.rvmensagem||' Erro ao processar idret '||rRecordDisbanco.idret||'.';
          return;
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

        codigo_retorno := 6;
        descricao := rRecibo.rvmensagem||'.';
        return;
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

        codigo_retorno := 7;
        descricao := 'Debito com valor negativo - Numpre : '||r_idret.numpre||'.';
        return;
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

        select coalesce(sum(recibopaga.k00_valor), 1)
          into nValorTotalReciboPaga
          from recibopaga
         where recibopaga.k00_numnov = r_idret.numpre;

        create temp table tmp_arrematric_percentual on commit drop as select k00_matric,
                                                                             0::numeric as valor
                                                                        from arrematric
                                                                       where k00_numpre in (select distinct k00_numpre
                                                                                              from recibopaga
                                                                                             where k00_numnov = r_idret.numpre)
                                                                       group by k00_matric;

        if exists(select * from tmp_arrematric_percentual) then

          for rValorRecibopaga in select k00_numpre,
                                         sum(k00_valor) as valor
                                    from recibopaga
                                   where recibopaga.k00_numnov = r_idret.numpre
                                group by k00_numpre
          loop

            for rVinculoArre in select *
                                  from arrematric
                                 where k00_numpre = rValorRecibopaga.k00_numpre
            loop

              update tmp_arrematric_percentual
                 set valor = valor + (rValorRecibopaga.valor*(rVinculoArre.k00_perc/100))
               where k00_matric = rVinculoArre.k00_matric;

            end loop;

          end loop;

          insert into arrematric select iNumpreReciboAvulso,
                                        k00_matric,
                                        (valor*100)/nValorTotalReciboPaga
                                   from tmp_arrematric_percentual;

        end if;

        create temp table tmp_arreinscr_percentual on commit drop as select k00_inscr,
                                                                            0::numeric as valor
                                                                       from arreinscr
                                                                      where k00_numpre in (select distinct k00_numpre
                                                                                            from recibopaga
                                                                                           where k00_numnov = r_idret.numpre)
                                                                      group by k00_inscr;

        if exists(select * from tmp_arreinscr_percentual) then

          for rValorRecibopaga in select k00_numpre,
                                         sum(k00_valor) as valor
                                    from recibopaga
                                   where recibopaga.k00_numnov = r_idret.numpre
                                group by k00_numpre
          loop

            for rVinculoArre in select *
                                  from arreinscr
                                 where k00_numpre = rValorRecibopaga.k00_numpre
            loop

              update tmp_arreinscr_percentual
                 set valor = valor + (rValorRecibopaga.valor*(rVinculoArre.k00_perc/100))
               where k00_inscr = rVinculoArre.k00_inscr;

            end loop;

          end loop;

          insert into arreinscr select iNumpreReciboAvulso,
                                       k00_inscr,
                                       (valor*100)/nValorTotalReciboPaga
                                  from tmp_arreinscr_percentual;

        end if;

        -- drop tmp tables
        drop table if exists tmp_arrematric_percentual;
        drop table if exists tmp_arreinscr_percentual;


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

              --Caso não tenha receita de crédito configurada para o tipo de débito, usamos a receita padrão dos parâmetros
              if iReceitaCredito is null then
                iReceitaCredito := iReceitaPadraoCredito;
              end if;

              if lRaise is true then
                perform fc_debug('  <PgtoParcial>  - iReceitaCredito: '||iReceitaCredito,lRaise,false,false);
              end if;

             if iReceitaCredito is null then

               codigo_retorno := 8;
               descricao := 'Receita de Crédito nao configurado nos parâmeotros e nem para o tipo de débito : '||rRecord.k00_tipo||'.';
               return;
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

            codigo_retorno := 9;
            descricao := 'Recibo '||r_idret.numpre||' inconsistente. IDRET : '||r_idret.idret||'.';
            return;
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

          codigo_retorno := 21;
          descricao := 'IDRET ' || r_codret.idret || ' COM MAIS DE UM PAGAMENTO NO MESMO ARQUIVO. CONTATE SUPORTE PARA VERIFICAÇÕES!';
          return;
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

              codigo_retorno := 22;
              descricao := 'INCONSISTENCIA AO GERAR NOVOS RECIBOS NA DIVISAO. IDRET: '||r_codret.idret||' - NUMPRE RECIBO ORIGINAL: '||r_codret.k00_numpre||'.';
              return;
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

        codigo_retorno := 23;
        descricao := 'IDRET ' || r_codret.idret || ' INCONSISTENTE AO VINCULAR A DIVIDA ATIVA! CONTATE SUPORTE - VALOR SOMADO: ' || v_total2 || ' - VALOR PAGO: ' || r_idret.vlrpago || '!';
        return;
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

              codigo_retorno := 24;
              descricao := 'Receita: '||q_disrec.k00_receit||' nao encontrada verifique o cadastro (1).';
              return;
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

              codigo_retorno := 25;
              descricao := 'Receita: '||q_disrec.k00_receit||' não encontrada verifique o cadastro (2).';
              return;
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

                  codigo_retorno := 26;
                  descricao := 'Receita: '||q_disrec.k00_receit||' nao encontrada verifique o cadastro (3).';
                  return;
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

                  codigo_retorno := 27;
                  descricao := 'Receita: '||q_disrec.k00_receit||' nao encontrada verifique o cadastro (4).';
                  return;
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

      codigo_retorno := 28;
      descricao := 'REGISTROS CLASSIFICADOS SEM DISREC';
      return;
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

      codigo_retorno := 29;
      descricao := 'INCONSISTENCIA NOS VALORES PROCESSADOS DIFERENCA TOTAL DE '||(v_total1-v_total2);
      return;
    end if;

  end if;

  if lRaise is true then
    perform fc_debug('  <BaixaBanco>  - FIM DO PROCESSAMENTO... ',lRaise,false,true);
  end if;

  if retorno = false then

    codigo_retorno := 30;
    descricao := 'NAO EXISTEM DEBITOS PENDENTES PARA ESTE ARQUIVO';
    return;
  else

    codigo_retorno := 1;
    descricao := 'PROCESSO CONCLUIDO COM SUCESSO';
    return;
  end if;

end;

$$ language 'plpgsql';create or replace function fc_iptu_complementar(integer,integer,numeric,boolean) returns boolean as
$$
declare

  iMatricula alias for $1;
  iAnousu    alias for $2;
  nValor     alias for $3;
  lRaise     alias for $4;

  dDataCorrente   date;
  dDataVencimento date;

  iTipoDebito     integer;
  iProcDiver      integer;
  iHistorico      integer;
  iReceita        integer;
  iNumcgm         integer;
  iNumpre         integer;
  iCodDiver       integer;
  iInstit         integer;

  nValorCorrigido numeric;

  sRetornoArrecad  text;
  sDescricaoDebito text;

  rDadosIptu      record;

  iDiasVencimento integer;
begin

  select fc_getsession('DB_datausu')::date
    into dDataCorrente;

  select *
    from tmpdadosiptu
    into rDadosIptu;

  select q92_diasvcto,
         q82_venc
    into iDiasVencimento,
         dDataVencimento
    from cadvencdesc
         inner join cadvenc on q82_codigo = q92_codigo
   where q82_codigo = rDadosIptu.codvenc
     and q82_venc > dDataCorrente
   order by q82_venc
   limit 1;

  iDiasVencimento := coalesce(iDiasVencimento, 0);
  dDataVencimento := coalesce(dDataVencimento, dDataCorrente);

  if dDataVencimento < dDataCorrente then
    dDataVencimento := dDataCorrente + iDiasVencimento;
  end if;

  if extract(year from dDataVencimento) > iAnousu then
    dDataVencimento := (iAnousu || '-12-31')::date;
  end if;

  perform fc_debug(' <iptu_complementar> ENTROU!', true);
  perform fc_debug(' <iptu_complementar> Valor do IPTU Complementar '||nValor, true);

  select j18_tipodebitorecalculo,
         k00_descr
    into iTipoDebito,
         sDescricaoDebito
    from cfiptu
         inner join arretipo on k00_tipo = j18_tipodebitorecalculo
   where j18_anousu = iAnousu;

  if iTipoDebito is null then
    raise exception '<erro>Tipo de débito não configurado para o recálculo de IPTU.</erro>';
  end if;

  perform fc_debug(' <iptu_complementar> Tipo de débito IPTU Complementar '||iTipoDebito, true);

  select dv09_procdiver,
         dv09_hist,
         dv09_receit
    into iProcDiver,
         iHistorico,
         iReceita
    from procdiver
         inner join arretipo on arretipo.k00_tipo = procdiver.dv09_tipo
   where arretipo.k00_tipo = iTipoDebito;

  if not found then
    raise exception '<erro>Nenhuma procedência cadastrada para o tipo de débito %.</erro>', sDescricaoDebito;
  end if;

  perform fc_debug(' <iptu_complementar> Procedência de Diversos '||iProcDiver, true);
  perform fc_debug(' <iptu_complementar> Histórico '||iHistorico, true);

  select fc_corre(iReceita, dDataCorrente, nValor, dDataCorrente, iAnousu, dDataVencimento::date + 10)
    into nValorCorrigido;

  perform fc_debug(' <iptu_complementar> Valor Corrigido '||nValorCorrigido, true);

  select j01_numcgm
    into iNumcgm
    from iptubase
   where j01_matric = iMatricula;

  select nextval('numpref_k03_numpre_seq')
    into iNumpre;

  select nextval('diversos_dv05_coddiver_seq')
    into iCodDiver;

  select codigo
    into iInstit
    from db_config
   where prefeitura is true;

  insert into diversos
   values (iCodDiver,
           iNumcgm,
           dDataCorrente,
           iAnousu,
           iNumpre,
           iHistorico,
           iProcDiver,
           1,
           dDataVencimento,
           dDataVencimento,
           0,
           dDataCorrente,
           nValorCorrigido,
           'Recalculo IPTU quitado' ,
           iInstit);

  insert into arrematric
   values(iNumpre,
          iMatricula,
          100);

  select fc_geraarrecad(iTipoDebito,iNumpre,true,1, false)
    into sRetornoArrecad;

  perform fc_debug(' <iptu_complementar> Retorno da fc_geraarrecad '||sRetornoArrecad, true);

  return true;

end;
$$  language 'plpgsql';create or replace function fc_iptu_geracreditorecalculo( matricula integer,
                                                         ano integer,
                                                         valorCredito numeric,
                                                         raise boolean )
returns boolean as
$$
declare

  receitaCredito   integer;
  numpreNovo       integer;
  cgm              integer;
  codigoAbatimento integer;

  rDadosIptu       record;

begin

  if raise is true then
    perform fc_debug(' <iptu_geracreditorecalculo> Gerando crédito', raise, false, false);
    perform fc_debug(' <iptu_geracreditorecalculo> Valor: ' || valorCredito, raise, false, false);
    perform fc_debug(' <iptu_geracreditorecalculo> Matrícula: ' || matricula, raise, false, false);
  end if;

  select *
    from tmpdadosiptu
    into rDadosIptu;

  select j01_numcgm
    into cgm
    from iptubase
   where j01_matric = matricula;

  if raise is true then
    perform fc_debug(' <iptu_geracreditorecalculo> CGM: ' || cgm, raise, false, false);
  end if;

  select j18_receitacreditorecalculo
    into receitaCredito
    from cfiptu
   where j18_anousu = ano;

  if not found or receitaCredito is null then
    raise exception '<erro>Receita de Crédito não configurada para o recálculo de IPTU.</erro>';
  end if;

  select nextval('numpref_k03_numpre_seq')
    into numpreNovo;

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
                       k00_numnov )
       values ( cgm,
                fc_getsession('DB_datausu')::date,
                receitaCredito,
                505,
                valorCredito,
                fc_getsession('DB_datausu')::date,
                numpreNovo,
                1,
                1,
                0,
                coalesce((select q92_tipo
                   from cadvencdesc
                  where q92_codigo = rDadosIptu.codvenc
                  limit 1), 1),
                0 );

  select nextval('abatimento_k125_sequencial_seq')
    into codigoAbatimento;

  insert into abatimento ( k125_sequencial,
                           k125_tipoabatimento,
                           k125_datalanc,
                           k125_hora,
                           k125_usuario,
                           k125_instit,
                           k125_valor,
                           k125_perc,
                           k125_valordisponivel,
                           k125_abatimentosituacao,
                           k125_observacao )
      values ( codigoAbatimento,
               3, -- Abatimento do tipo crédito
               fc_getsession('DB_datausu')::date,
               extract(hour from now()) || ':' || extract(min from now()),
               fc_getsession('DB_id_usuario')::integer,
               fc_getsession('DB_instit')::integer,
               valorCredito,
               100,
               valorCredito,
               1,
               'Crédito gerado no recálculo de IPTU para a matrícula: ' || matricula );

  insert into abatimentorecibo ( k127_sequencial,
                                 k127_abatimento,
                                 k127_numprerecibo,
                                 k127_numpreoriginal )
       values ( nextval('abatimentorecibo_k127_sequencial_seq'),
                codigoAbatimento,
                numpreNovo,
                null );

  insert into arrehist ( k00_numpre,
                         k00_numpar,
                         k00_hist,
                         k00_dtoper,
                         k00_hora,
                         k00_id_usuario,
                         k00_histtxt,
                         k00_limithist,
                         k00_idhist )
       values ( numpreNovo,
                0,
                505,
                fc_getsession('DB_datausu')::date,
                extract(hour from now()) || ':' || extract(min from now()),
                fc_getsession('DB_id_usuario')::integer,
                '',
                null,
                nextval('arrehist_k00_idhist_seq') );

  insert into arrenumcgm
       values ( cgm,
                numpreNovo );

  insert into arrematric ( k00_numpre,
                           k00_matric,
                           k00_perc )
       values ( numpreNovo,
                matricula,
                100 );

  if raise is true then
    perform fc_debug(' <iptu_geracreditorecalculo> Abatimento: ' || codigoAbatimento, raise, false, false);
    perform fc_debug(' <iptu_geracreditorecalculo> Numpre: ' || numpreNovo, raise, false, false);
  end if;

  return true;
end;

$$ language 'plpgsql';drop function if exists fc_iptu_gerafinanceiro(integer,integer,integer,integer,boolean,boolean,boolean,boolean,boolean);
drop function if exists fc_iptu_gerafinanceiro(integer,integer,integer,integer,boolean,boolean,boolean,boolean,boolean,integer);

create or replace function fc_iptu_gerafinanceiro(integer,integer,integer,integer,boolean,boolean,boolean,boolean,boolean) returns boolean as
$$
declare

  iMatricula        alias for $1;
  iAnousu           alias for $2;
  iParcelaini       alias for $3;
  iParcelafim       alias for $4;
  lCalculogeral     alias for $5;
  lPossuiPagamento  alias for $6;
  lNovoNumpre       alias for $7;
  lDemonstrativo    alias for $8;
  lRaise            alias for $9;

  lExisteAbatimento boolean default false;
  lRetorno          boolean default false;

begin

  return ( select fc_iptu_gerafinanceiro(iMatricula, iAnousu, iParcelaini, iParcelafim, lCalculogeral, lPossuiPagamento, lNovoNumpre, lDemonstrativo, lRaise, 0) );

end;
$$  language 'plpgsql';


create or replace function fc_iptu_gerafinanceiro(integer,integer,integer,integer,boolean,boolean,boolean,boolean,boolean,integer) returns boolean as
$$
declare

  iMatricula                      alias for $1;
  iAnousu                         alias for $2;
  iParcelaini                     alias for $3;
  iParcelafim                     alias for $4;
  lCalculogeral                   alias for $5;
  lPossuiPagamento                alias for $6;
  lNovoNumpre                     alias for $7;
  lDemonstrativo                  alias for $8;
  lRaise                          alias for $9;
  iDiasVcto                       alias for $10;

  nValorParcela                   numeric(15,2) default 0;
  nValorIncrementalReceitaParcela numeric(15,2) default 0;
  nValorTotalCalculo              numeric(15,2) default 0;
  nValorParcelaMinima             numeric(15,2) default 0;
  nPercentualParcela              numeric(15,2) default 0;
  nValorTotalAberto               numeric(15,2) default 0;
  nTotalGeradoReceita             numeric(15,2) default 0;
  nTotalCalculoAnterior           numeric(15,2) default 0;
  nTotalCalculoNovo               numeric(15,2) default 0;

  iDigito                         integer default 0;
  iNumpre                         integer default 0;
  iParcelas                       integer default 0;
  iCgm                            integer default 0;
  iNumpreArrematric               integer default 0;
  iNumeroParcelasPagasCanceladas  integer default 0;
  iUltimaParcelaGerada            integer default 0;
  iDiaPadraoVencimento            integer default 0;
  iMesInicial                     integer default 0;
  iParcelasPadrao                 integer default 0;
  iParcelasProcessadas            integer default 0;
  iNumpreIptunump                 integer default 0;

  lExisteNumpre                   boolean default false;
  lUtilizandoMinima               boolean default false;
  lExisteFinanceiroGerado         boolean;
  lProcessaParcela                boolean;
  lProcessaVencimentoForcado      boolean default false;
  lExisteAbatimento               boolean default false;
  lRetorno                        boolean default false;
  lCreditoRecalculo               boolean default false;
  lDebitoRecalculo                boolean default false;
  lCalculoQuitado                 boolean default false;
  lRecalculoQuitado               boolean default false;

  dDataOperacao                   date;

  tSqlVencimentos                 text default '';
  tManual                         text default '';

  rVencimentos                    record;
  rArrecad                        record;
  rValoresPorReceita              record;
  rDadosIptu                      record;
  rRecibosGerados                 record;

  nPercentualUnica                numeric;
  nTotalCalculoCredito            numeric;

  begin

    -- Verifica se existe Pagamento Parcial para o débito informado
    select j20_numpre
      into iNumpreIptunump
      from iptunump
     where j20_matric = iMatricula
       and j20_anousu = iAnousu
     limit 1;

    if found then

      select fc_verifica_abatimento(1, iNumpreIptunump )::boolean into lExisteAbatimento;
      if lExisteAbatimento then
        raise exception '<erro>Operação Cancelada, Débito com Pagamento Parcial!</erro>';
      end if;
    end if;

    if lRaise is true then

      perform fc_debug('', lRaise, false, false);
      perform fc_debug(' <iptu_gerafinanceiro> Gerando financeiro', lRaise, false, false);
    end if;

    select coalesce( (select sum(k00_valor)
                        from arrecad
                       where k00_numpre = j20_numpre) ,0 ) as valor_total
      into nValorTotalAberto
      from iptunump
     where j20_matric = iMatricula
       and j20_anousu = iAnousu;

    iMesInicial          := iDiasVcto;
    iParcelasPadrao      := iParcelaini;
    iDiaPadraoVencimento := iParcelafim;

    if iMesInicial <> 0 and iParcelasPadrao <> 0 and iDiaPadraoVencimento <> 0 then
      lProcessaVencimentoForcado := true;
    end if;

    select * from tmpdadosiptu into rDadosIptu;

    select nparc
      into iParcelas
      from tmpdadostaxa;

    /**
     * Verifica codigo de arrecadacao
     */
    select j20_numpre
      into iNumpre
      from iptunump
     where j20_anousu = iAnousu
       and j20_matric = iMatricula;

    perform fc_debug(' <iptu_gerafinanceiro> Calculo geral : '||(case when lCalculogeral is true then 'Sim' else 'Nao' end), lRaise, false, false);
    perform fc_debug(' <iptu_gerafinanceiro> Numpre atual  : '||iNumpre                                   , lRaise, false, false);
    perform fc_debug(' <iptu_gerafinanceiro> parcelaini    : '||iParcelaini||' Parcelafim : '||iParcelafim, lRaise, false, false);

    if iNumpre is not null then

	    /**
       * Se for calculo parcial e nao for demonstrativo
       */
      if lCalculogeral = false and lDemonstrativo is false then

        for rArrecad in select distinct k00_numpar
                          from arrecad
                         where k00_numpre = iNumpre
                      order by k00_numpar
        loop

					if iParcelafim = 0 then

						if rArrecad.k00_numpar >= iParcelaini then
							delete from arrecad where k00_numpre = iNumpre and k00_numpar = rArrecad.k00_numpar;
						end if;

					else

						if rArrecad.k00_numpar >= iParcelaini and rArrecad.k00_numpar <= iParcelafim then
							delete from arrecad where k00_numpre = iNumpre and k00_numpar = rArrecad.k00_numpar;
						end if;

					end if;

        end loop;

      end if;

      if lNovoNumpre = false then

        lExisteNumpre = true;

      else

        if lPossuiPagamento = false then

          if lCalculogeral = false and lDemonstrativo is false then

            if lRaise is true then
              perform fc_debug(' <iptu_gerafinanceiro> Deletando iptunump', lRaise, false, false);
            end if;

            delete from iptunump
                  where j20_anousu = iAnousu
                    and j20_matric = iMatricula;
          end if;

          if lDemonstrativo is false then

            select nextval('numpref_k03_numpre_seq')::integer
              into iNumpre;
          end if;

        end if;

      end if;

    else

      if lDemonstrativo is false then
        select nextval('numpref_k03_numpre_seq')::integer into iNumpre;
      end if;

    end if;

    /**
     * Verifica imune
     */
    if not rDadosIptu.tipoisen is null then

      if rDadosIptu.tipoisen = 1 then
        return true;
      end if;
    end if;

    perform fc_debug(' <iptu_gerafinanceiro> Numpre: '||iNumpre, lRaise, false, false);

    /**
     * Verifica taxas
     */
    if lRaise is true then
      perform fc_debug(' <iptu_gerafinanceiro> Processando vencimentos', lRaise, false, false);
    end if;

    /**
     * Esta funcao retorna um select com a consulta para gerar os vencimentos
     * lendo os parametros iMesInicial,iParcelasPadrao,iDiaPadraoVencimento... se os parametros forem diferente de 0 a funcao
     * ira criar uma tabela temporaria com a estrutura do select do cadastro de vencimentos e retornara a string do select
     */
    tSqlVencimentos := ( select fc_iptu_getselectvencimentos(iMatricula,iAnousu,rDadosIptu.codvenc,iMesInicial,iParcelasPadrao,iDiaPadraoVencimento,nValorTotalAberto,lRaise) );

    execute 'select count(*) from ('|| tSqlVencimentos ||') as x'
       into iParcelas;

    lProcessaParcela = true;

    perform fc_debug(' <iptu_gerafinanceiro> Sql retornado dos vencimentos: ' || tSqlVencimentos, lRaise, false, false);

    /**
     * Cgm que sera gravado no arrecad e arrenumcgm
     */
    select fc_iptu_getcgmiptu(iMatricula) into iCgm;

    /**
     * Data de operacao do cfiptu
     */
    select j18_dtoper
      into dDataOperacao
      from cfiptu
     where j18_anousu = iAnousu;

    /**
     * Quantidade de receitas e valores gerados pelo calculo
     */
    select sum(valor)
      into nValorTotalCalculo
      from tmprecval;

    perform fc_debug(' <iptu_gerafinanceiro> Total retornado da tmprecval: '||nValorTotalCalculo, lRaise, false, false);

    /**
     * Valor de minimo da parcela
     */
    select q92_vlrminimo
   		into nValorParcelaMinima
   		from cadvencdesc
     where q92_codigo = rDadosIptu.codvenc;

    /**
     * Quantidade de parcelas que já foram
     * pagas e ou canceladas do iptu sendo gerado
     */
    select coalesce(count(distinct k00_numpar),0)
      into iNumeroParcelasPagasCanceladas
      from ( select distinct k00_numpar
               from arrecant
              where arrecant.k00_numpre = iNumpre
           ) as x;

	  perform fc_debug(' <iptu_gerafinanceiro> TOTAL: '||nValorTotalCalculo||' - nValorParcelaMinima: '||nValorParcelaMinima||' - iParcelas: '||iParcelas||' - Divisao (nValorTotalCalculo / iParcelas): '||(nValorTotalCalculo / iParcelas), lRaise, false, false);

    /**
     * Validamos se este é um recalculo de IPTU quitado
     * Se for, faremos as devidadas validações para determinar se devemos gerar débito ou crédito
     */
    perform *
       from tmpipturecalculo
      where matricula = iMatricula
        and anousu    = iAnousu;

    if found then

      lRecalculoQuitado := true;

      perform fc_debug(' <iptu_gerafinanceiro> Recalculo de IPTU quitado detectado ', lRaise, false, false);

      select sum(valor - valor_isencao)
        into nTotalCalculoAnterior
        from tmpipturecalculo
       where matricula = iMatricula
         and anousu    = iAnousu;

      select sum(j21_valor)
        into nTotalCalculoNovo
        from iptucalv
       where j21_matric = iMatricula
         and j21_anousu = iAnousu;

      perform fc_debug(' <iptu_gerafinanceiro> Valor total do calculo anterior '||nTotalCalculoAnterior, lRaise, false, false);
      perform fc_debug(' <iptu_gerafinanceiro> Valor total do calculo novo '||nTotalCalculoNovo, lRaise, false, false);

      if nTotalCalculoAnterior < nTotalCalculoNovo then
        lDebitoRecalculo := true;
      end if;

      if nTotalCalculoAnterior > nTotalCalculoNovo then
        lCreditoRecalculo := true;
      end if;
    end if;

    perform fc_debug(' <iptu_gerafinanceiro> lDebitoRecalculo '||lDebitoRecalculo, lRaise, false, false);
    perform fc_debug(' <iptu_gerafinanceiro> lCreditoRecalculo '||lCreditoRecalculo, lRaise, false, false);

    if lDebitoRecalculo is true then
      select fc_iptu_complementar(iMatricula, iAnousu, (nTotalCalculoNovo - nTotalCalculoAnterior), lRaise)
        into lCalculoQuitado;

      if lCalculoQuitado is false then

        perform fc_debug(' <iptu_gerafinanceiro> Erro ao gerar IPTU Complementar no recálculo de IPTU Quitado.', lRaise, false, false);
        return false;
      end if;
    end if;

    if lCreditoRecalculo is true then

      nTotalCalculoCredito := nTotalCalculoAnterior - nTotalCalculoNovo;

      if (select count(distinct k00_dtpaga) from arrepaga where k00_numpre = iNumpre) = 1 then

        select k00_percdes
          into nPercentualUnica
          from recibounica
         where k00_numpre = iNumpre
           and k00_dtvenc >= (select coalesce(disbanco.dtpago, arrepaga.k00_dtpaga)
                                from arrepaga
                                     left join arreidret on arreidret.k00_numpre = arrepaga.k00_numpre
                                                         and arreidret.k00_numpar = arrepaga.k00_numpar
                                     left join disbanco  on disbanco.idret = arreidret.idret
                               where arrepaga.k00_numpre = iNumpre
                               limit 1)
         order by k00_dtvenc limit 1;

        if found and nPercentualUnica > 0 then
          nTotalCalculoCredito := nTotalCalculoCredito * (1-(nPercentualUnica/100));
        end if;

      end if;

      select fc_iptu_geracreditorecalculo(iMatricula, iAnousu, nTotalCalculoCredito, lRaise)
        into lCalculoQuitado;

      if lCalculoQuitado is false then

        perform fc_debug(' <iptu_gerafinanceiro> Erro ao gerar crédito no recálculo de IPTU Quitado.', lRaise, false, false);
        return false;
      end if;
    end if;

    /**
     * Caso seja recalculo mas o IPTU não esteja quitado porém o novo valor recalculado seja menor do que a soma do valor
     * pago do IPTU até o momento. Neste caso gera um crédito com a diferença do valor
     */
    if nValorTotalCalculo < 0 and lRecalculoQuitado is false then

      select fc_iptu_geracreditorecalculo(iMatricula, iAnousu, abs(nValorTotalCalculo), lRaise)
        into lCalculoQuitado;

      if lCalculoQuitado is false then

        perform fc_debug(' <iptu_gerafinanceiro> Erro ao gerar crédito no recálculo de IPTU Quitado.', lRaise, false, false);
        return false;
      end if;

    /**
     * Se não tiver que gerar débito de diversos ou crédito por ser um recalculo de IPTU quitado,
     * Realizamos a geração de débito normal, usando as receitas de IPTU e Taxas(caso tenha) e suas
     * devidas parcelas
     */
    elsif nValorTotalCalculo > 0 and lCreditoRecalculo is false and lDebitoRecalculo is false then

      perform fc_debug(' <iptu_gerafinanceiro> Inicia rateio de valor por parcela', lRaise, false, false);
      perform fc_debug(' <iptu_gerafinanceiro> Parcelas: '||iParcelas||' nValorTotalCalculo: '||nValorTotalCalculo, lRaise, false, false);
      perform fc_debug(' <iptu_gerafinanceiro> Verifica se ('||nValorTotalCalculo||' / '||iParcelas||') eh menor que o valor de parcela minimo '||nValorParcelaMinima, lRaise, false, false);
      if (nValorTotalCalculo / iParcelas) < nValorParcelaMinima then

				if floor((nValorTotalCalculo / nValorParcelaMinima)::numeric)::integer = 0 then
				  iParcelas := 1;
				else
          iParcelas := floor((nValorTotalCalculo / nValorParcelaMinima)::numeric)::integer;
				end if;

        lUtilizandoMinima := true;
        perform fc_debug(' <iptu_gerafinanceiro> Entrou em parcela minima... '       , lRaise, false, false);
        perform fc_debug(' <iptu_gerafinanceiro> Quantidade de Parcelas: '||iParcelas, lRaise, false, false);
      end if;

      perform fc_debug('', lRaise, false, false);
      perform fc_debug(' <iptu_gerafinanceiro> NUMPRE DO CALCULO: '||iNumpre, lRaise, false, false);
      perform fc_debug('', lRaise, false, false);

      perform fc_debug(' <iptu_gerafinanceiro> Percorrendo valores a serem gerados agrupado por receita '||iNumpre, lRaise, false, false);


      /**
       * Agrupa por receita
       */
      for rValoresPorReceita in select receita,
                                       (select count( distinct receita) from tmprecval) as qtdreceitas,
                                       sum(valor) as valor
                                  from tmprecval
                              group by receita
                              order by receita
      loop

        nValorIncrementalReceitaParcela := 0;
        iParcelasProcessadas            := 1;

        perform fc_debug(' <iptu_gerafinanceiro> iParcelasProcessadas: '||iParcelasProcessadas||' iParcelas: '||iParcelas, lRaise, false, false);

        /**
         * Percorre o record de vencimentos rateando o valor que fora agrupado por receita
         */
        for rVencimentos in execute tSqlVencimentos
        loop

          if lUtilizandoMinima is false then
            nPercentualParcela := cast(rVencimentos.q82_perc as numeric(15,2));
          else
            nPercentualParcela := 100::numeric / iParcelas;
          end if;

          perform fc_debug(' <iptu_gerafinanceiro> Percentual da parcela ' || nPercentualParcela, lRaise, false, false);

          if iParcelas < iParcelasProcessadas and lProcessaVencimentoForcado is false then

            perform fc_debug(' <iptu_gerafinanceiro> PARCELA '||rVencimentos.q82_parc||' NAO SERA CALCULADA', lRaise, false, false);
            perform fc_debug('', lRaise, false, false);
            continue;
          end if;

          if iParcelaini = 0 then

            perform fc_debug(' <iptu_gerafinanceiro> lProcessaParcela = true | iParcelaini = 0', lRaise, false, false);
            lProcessaParcela = true;
          else

            if rVencimentos.q82_parc >= iParcelaini and rVencimentos.q82_parc <= iParcelafim then
              lProcessaParcela = true;
            else
              lProcessaParcela = false;
            end if;

          end if;

          if lProcessaVencimentoForcado then
            lProcessaParcela = true;
          end if;

          perform fc_debug(' <iptu_gerafinanceiro> Processando parcela = '||( case when lProcessaParcela is true then 'Sim' else 'Nao' end ), lRaise, false, false);

          if lProcessaParcela is true then

            perform *
               from fc_statusdebitos(iNumpre, rVencimentos.q82_parc)
              where rtstatus = 'PAGO' or rtstatus = 'CANCELADO'
              limit 1;

            if found then

              perform fc_debug(' <iptu_gerafinanceiro> Ignorando parcela '||rVencimentos.q82_parc||' por estar paga ou cancelada', lRaise, false, false);
              perform fc_debug('', lRaise, false, false);
              continue;
            end if;

            if rValoresPorReceita.valor > 0 then

              if iParcelas = iParcelasProcessadas and iNumeroParcelasPagasCanceladas = 0 then
                nValorParcela := rValoresPorReceita.valor - nValorIncrementalReceitaParcela;
              else

                nValorParcela                   := trunc (rValoresPorReceita.valor * ( nPercentualParcela / 100::numeric )::numeric, 2 );
                nValorIncrementalReceitaParcela := nValorIncrementalReceitaParcela + nValorParcela;
              end if;

              lExisteFinanceiroGerado := true;
              iDigito                 := fc_digito(iNumpre, rVencimentos.q82_parc, iParcelas);

              perform fc_debug('', lRaise, false, false);
              perform fc_debug(' <iptu_gerafinanceiro> Parcela: '||rVencimentos.q82_parc||' Receita: '||rValoresPorReceita.receita||' Valor: '||nValorParcela, lRaise, false, false);

              if lDemonstrativo is false then

              iParcelasProcessadas = ( iParcelasProcessadas + 1 );

               if round(nValorParcela, 2) = 0 then

                 perform fc_debug(' <iptu_gerafinanceiro> Valor de parcela zerado, continue...', lRaise);
                 continue;
               end if;

                perform fc_debug(' <iptu_gerafinanceiro> GERANDO ARRECAD '                             , lRaise, false, false);
                perform fc_debug(' <iptu_gerafinanceiro> '                                             , lRaise, false, false);
                perform fc_debug(' <iptu_gerafinanceiro> Numpre .......: '||iNumpre                    , lRaise, false, false);
                perform fc_debug(' <iptu_gerafinanceiro> Numpar .......: '||rVencimentos.q82_parc      , lRaise, false, false);
                perform fc_debug(' <iptu_gerafinanceiro> Receita ......: '||rValoresPorReceita.receita , lRaise, false, false);
                perform fc_debug(' <iptu_gerafinanceiro> Valor ........: '||nValorParcela              , lRaise, false, false);
                perform fc_debug(' <iptu_gerafinanceiro> Vencimento ...: '||rVencimentos.q82_parc      , lRaise, false, false);

                delete from arrecad
                 where k00_numpre = iNumpre
                   and k00_numpar = rVencimentos.q82_parc
                   and k00_receit = rValoresPorReceita.receita;

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
                                     dDataOperacao,
                                     rValoresPorReceita.receita,
                                     rVencimentos.q82_hist,
                                     nValorParcela,
                                     rVencimentos.q82_venc,
                                     iNumpre,
                                     rVencimentos.q82_parc,
                                     iParcelas,
                                     iDigito,
                                     rVencimentos.q92_tipo);
              end if;

            end if;

          end if;

          perform fc_debug(' <iptu_gerafinanceiro> nValorParcela.: '||nValorParcela, lRaise, false, false);
          perform fc_debug(' <iptu_gerafinanceiro> nValorIncrementalReceitaParcela: ' || nValorIncrementalReceitaParcela, lRaise);

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
           and k00_receit = rValoresPorReceita.receita;

        update arrecad
           set k00_valor = ( k00_valor + ( rValoresPorReceita.valor - nTotalGeradoReceita ) )
         where k00_numpre = iNumpre
           and k00_numpar = iUltimaParcelaGerada
           and k00_receit = rValoresPorReceita.receita;

      end loop;

      if lRaise is true then

        perform fc_debug('', lRaise, false, false);
        perform fc_debug(' <iptu_gerafinanceiro> Verificando e gerando arrematric, iptunump e iptucalc' , lRaise, false, false);
      end if;

      if lExisteFinanceiroGerado = true then

        if lDemonstrativo is false then

          select k00_numpre
            into iNumpreArrematric
            from arrematric
           where k00_numpre = iNumpre
             and k00_matric = iMatricula;

          if iNumpreArrematric is null then
            insert into arrematric (k00_numpre, k00_matric) values (iNumpre, iMatricula);
          end if;

          for rRecibosGerados in select distinct recibopaga.k00_numnov,
                                recibopaga.k00_dtoper,
                                recibopaga.k00_dtpaga
                           from arrecad
                                inner join recibopaga on recibopaga.k00_numpre = arrecad.k00_numpre
                                                     and recibopaga.k00_numpar = arrecad.k00_numpar
                          where arrecad.k00_numpre = iNumpre
          loop

            delete from recibopaga where k00_numnov = rRecibosGerados.k00_numnov;
            perform fc_recibo(rRecibosGerados.k00_numnov, rRecibosGerados.k00_dtoper, rRecibosGerados.k00_dtpaga, extract(year from rRecibosGerados.k00_dtpaga)::integer);
          end loop;

        end if;

        if lExisteNumpre = false and lDemonstrativo is false then
          insert into iptunump (j20_anousu, j20_matric, j20_numpre) values (iAnousu, iMatricula, iNumpre);
        end if;

      end if;

    end if;

    if lDemonstrativo is false then
      update iptucalc set j23_manual = tManual where j23_matric = iMatricula and j23_anousu = iAnousu;
    end if;

    if lRaise is true then
      perform fc_debug(' <iptu_gerafinanceiro> Fim do processamento da funcao iptu_gerafinanceiro', lRaise, false, true);
    end if;

    return true;

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
  iNumpreVerifica   integer default 0;

  lRaise            boolean default false;
  rtp_Retorno       tp_iptu_verificacalc%ROWTYPE;
  lAbatimento       boolean default false;

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

        rtp_Retorno.rbErro    := false;
        rtp_Retorno.riCodErro := 27::integer;
     elsif iParcArrecant <> 0 and iParcArrepaga = 0 then -- Calculo Cancelado

        rtp_Retorno.rbErro    := true;
        rtp_Retorno.riCodErro := 34::integer;
     end if;

   end if;

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

      rtp_Retorno.rbErro    := true;
      rtp_Retorno.riCodErro := 114::integer;
    end if;

  end if;

  perform fc_debug ( '' , lRaise);
  perform fc_debug (' <iptu_verificacalculo> ERRO        - ' || rtp_Retorno.rbErro   , lRaise);
  perform fc_debug (' <iptu_verificacalculo> CODIGO ERRO - ' || rtp_Retorno.riCodErro, lRaise);
  perform fc_debug ( '' , lRaise);



  create temp table if not exists tmpipturecalculo (
    matricula     integer,
    anousu        integer,
    valor         numeric,
    valor_isencao numeric,
    receita       integer
  );

  delete from tmpipturecalculo;

  if rtp_Retorno.riCodErro = 27 then

    insert into tmpipturecalculo
         select iMatricula,
                iAnousu,
                j21_valor,
                abs(j21_valorisen),
                j21_receit
           from ( select j21_valor,
                         case
                           when iptucalhconf.j89_codhis is not null then
                             (select case
                                       when sum(x.j21_valor) is not null then
                                         sum(x.j21_valor)
                                       else 0
                                     end
                                from iptucalv x
                               where x.j21_anousu = iptucalv.j21_anousu
                                 and x.j21_matric = iptucalv.j21_matric
                                 and x.j21_receit = iptucalv.j21_receit
                                 and x.j21_codhis = iptucalhconf.j89_codhis)
                           else 0
                         end as j21_valorisen,
                         j21_receit
                    from iptucalv
                         inner join iptucalh        on iptucalh.j17_codhis        = j21_codhis
                         left  join iptucalhconf    on iptucalhconf.j89_codhispai = j21_codhis
                         inner join tabrec          on tabrec.k02_codigo          = j21_receit
                         left  join iptucadtaxaexe  on iptucadtaxaexe.j08_tabrec  = j21_receit
                                                   and iptucadtaxaexe.j08_anousu  = j21_anousu
                   where j21_matric = iMatricula
                     and j21_anousu = iAnousu
                     and j17_codhis not in (select j89_codhis from iptucalhconf)
                   order by iptucalh.j17_codhis) as x;
                   
  end if;

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
$$ language 'plpgsql';create or replace function fc_geraarrecad(integer, integer, boolean, integer, boolean) returns varchar(200)
as $$
DECLARE

   V_ARRETIPO  	    alias for $1; -- codigo referente ao campo k00_tipo do arquivo arretipo
   V_CODNUMP        alias for $2; -- NUMPRE PARA CALCULO DO arrecad
   V_OPCAOCALC	    alias for $3; -- TRUE = CALCULA  FALSE = RECALCULA (Quando false gera arreold baseado na arrecad)
   iTipo            alias for $4; -- 1 = arretipo 2 = cadtipo
   lGerarNovoNumpre	alias for $5; -- True = Deve gerar numpre novo e arreold para o numpre antigo do débito

   V_TIPO      	    integer;
   iTipoDebito 	    integer;
   iCodigoDiversos  integer;
   iCodigoDivida    integer;
   V_DIA	          integer;
   V_TOTPAR    	    integer;
   V_CONTADOR 	    integer;
   iNumpreDiversos  integer;
   iNumpreDivida    integer;
   V_NUMPARC   	    integer;
   V_NUMPAR   	    integer;
   V_PROCDIVER	    integer;
   V_NUMCGM	        integer;
   V_RECEITA	      integer;
   V_HIST	          integer;
   V_PROCED	        integer;
   NUMPRE	          integer;
   iInstit	        integer;
   iNumpreNovo      integer;

	 V_DATA	          date;
   V_DTOPER	        date;
   V_PRIVENC	      date;
   V_PROVENC	      date;

	 V_VALOR	        float8;

   lRaise           boolean default true;

BEGIN

  lRaise := ( case when fc_getsession('DB_debugon') is null then false else true end );

	 select cast( fc_getsession('DB_instit') as integer )
	   into iInstit;

   /**
    * Verifica se o parametro na funcao é cadtipo e atribui direto
    */
   if iTipo = 2 then
     V_TIPO = V_ARRETIPO;
   else

     select k03_tipo
       into V_TIPO
       from arretipo
      where k00_tipo   = V_ARRETIPO
        and k00_instit = iInstit;
   end if;

   perform fc_debug('Grupo do debito (k03_tipo): ' || V_TIPO, lRaise);
   perform fc_debug('Tipo do debito (k00_tipo):  ' || V_ARRETIPO, lRaise);
   perform fc_debug('Instit:                     ' || iInstit, lRaise);

   /**
    * Calculo para tipo de débito - Diversos
    */
   if V_TIPO = 7 then

      select dv05_coddiver, dv05_privenc, dv05_provenc, dv05_diaprox, dv05_numtot, dv05_numpre,
             dv05_oper, dv05_numcgm, dv05_procdiver, dv05_vlrhis
        into iCodigoDiversos, V_PRIVENC, V_PROVENC, V_DIA, V_NUMPARC, iNumpreDiversos,
             V_DTOPER, V_NUMCGM, V_PROCDIVER, V_VALOR
        from diversos
       where dv05_numpre = V_CODNUMP;

      if iCodigoDiversos is null then
         return '0 - CODIGO NAO ENCONTRADO';
      end if;

      if V_PRIVENC is null then
         return '1 - DATA DO PRIMEIRO VENCIMENTO ZERADA';
      end if;

      if V_PROVENC is null then
         return '2 - DATA DO SEGUNDO VENCIMENTO ZERADA';
      end if;

      if V_DIA is null then
         V_DIA = SUBSTR(V_PRIVENC, 9, 2)::INTEGER;
      end if;

      if iNumpreDiversos is null then
         return '5 CODIGO DE ARRECADACAO NAO GERADO';
      else

        perform fc_debug('BUSCANDO NUMPRE DA ARRECAD', lRaise);

        select k00_numpre
       	  into NUMPRE
      	  from arrecad
         where k00_numpre = iNumpreDiversos;

        perform fc_debug('NUMPRE:      ' || NUMPRE, lRaise);
        perform fc_debug('V_OPCAOCALC: ' || V_OPCAOCALC, lRaise);

        if NUMPRE is not null then

          if V_OPCAOCALC = true then

            perform fc_debug('Numpre encontrado na arrecad.', lRaise);
            return '4 CODIGO JA CALCULADO';
          else

            perform fc_debug('GERANDO ARREOLD.', lRaise);

            insert into arreold
                 select k00_numpre, k00_numpar, k00_numcgm, k00_dtoper, k00_receit, k00_hist, k00_valor,
                        k00_dtvenc, k00_numtot, k00_numdig, k00_tipo, k00_tipojm
                   from arrecad
                  where K00_NUMPRE = iNumpreDiversos;

            delete from arrecad where k00_numpre = iNumpreDiversos;
          end if;

        end if;

      end if;

      select dv09_receit, dv09_hist, dv09_tipo
        into V_RECEITA, V_HIST, V_PROCED
        from procdiver
       where dv09_procdiver = V_PROCDIVER;

      if V_RECEITA is null then
         return '6 CODIGO DA RECEITA NAO ENCONTRADO NO PROCDIVER';
      end if;
      if V_HIST is null then
         return '7 CODIGO DO HISTORICO NAO ENCONTRADO NO PROCDIVER';
      end if;
      if V_PROCED is null then
         return '8 CODIGO DO TIPO DE DEBITO NAO ENCONTRADO NO PROCDIVER';
      end if;

      V_CONTADOR = 1;

      /**
       * Valida se deve gerar novo numpre para o debito
       */
      if lGerarNovoNumpre = true then

        perform fc_debug('Gerando novo numpre para o Debito', lRaise);
        select nextval('numpref_k03_numpre_seq') into iNumpreNovo;
        perform fc_debug('Numpre gerado: ' || iNumpreNovo , lRaise);

        /**
         * Verifica origem do numpre original para inserir o numpre novo na(s)
         * respectiva(s) tabela(s) - arreinscr / arrematric
         */
        perform 1
           from arrematric
          where k00_numpre = iNumpreDiversos;
        if found then

          perform fc_debug('Encontrado arrematric para diverso com numpre: ' || iNumpreDiversos || '. Inserindo arrematric com numpre: ' || iNumpreNovo, lRaise );
          insert into arrematric (k00_numpre, k00_matric, k00_perc)
               select iNumpreNovo, k00_matric, k00_perc
                 from arrematric
                where k00_numpre = iNumpreDiversos;
        end if;

        perform 1
           from arreinscr
          where k00_numpre = iNumpreDiversos;
        if found then

          perform fc_debug('Encontrado arreinscr para diverso com numpre: ' || iNumpreDiversos || '. Inserindo arreinscr com numpre: ' || iNumpreNovo, lRaise );
          insert into arreinscr (k00_numpre, k00_inscr, k00_perc)
               select iNumpreNovo, k00_inscr, k00_perc
                 from arreinscr
                where k00_numpre = iNumpreDiversos;
        end if;

        iNumpreDiversos = iNumpreNovo;
        /**
         * Atualiza o numpre da diverso
         */
        update diversos set dv05_numpre = iNumpreNovo where dv05_coddiver = iCodigoDiversos;

      end if;

    LOOP

      if V_CONTADOR = 1 then
        V_DATA = V_PRIVENC;
	    end if;
      if V_CONTADOR = 2 then
        V_DATA = V_PROVENC;
	    end if;
      if V_CONTADOR > 2 then
	      V_DATA = FC_VENCIMENTO(V_PROVENC, V_CONTADOR - 1, V_DIA);
	    end if;

      insert into arrecad ( k00_numcgm, k00_dtoper, k00_receit, k00_hist, k00_valor, k00_dtvenc, k00_numpre,
                            k00_numpar, k00_numtot, k00_numdig, k00_tipo, k00_tipojm )
	                 values ( V_NUMCGM, V_DTOPER, V_RECEITA, V_HIST, V_VALOR, V_DATA, iNumpreDiversos, V_CONTADOR,
                            V_NUMPARC, FC_DIGITO(iNumpreDiversos, V_CONTADOR, V_NUMPARC), V_PROCED, 0);

      V_CONTADOR = V_CONTADOR + 1;

      if V_CONTADOR > V_NUMPARC then
	      EXIT;
	    end if;

    END LOOP;

  /**
   * Calculo para tipo de débito - Divida ativa
   */
  elsif V_TIPO = 5 then

      select v01_coddiv, v01_numtot, v01_numpar, v01_numpre, v01_dtoper, v01_numcgm, v01_proced, v01_vlrhis, v01_dtvenc
	  		into iCodigoDivida, V_NUMPARC, V_NUMPAR, iNumpreDivida, V_DTOPER, V_NUMCGM, V_PROCED, V_VALOR, V_PRIVENC
        from divida
       where v01_numpre = V_CODNUMP;

      if iCodigoDivida is null then
        return '0 - CODIGO NAO ENCONTRADO';
      end if;

      if iNumpreDivida is null then
        return '5 CODIGO DE ARRECADACAO NAO GERADO';
      else

        select k00_numpre
	        into NUMPRE
      	  from arrecad
         where k00_numpre = iNumpreDivida;

        perform fc_debug('NUMPRE:      ' || NUMPRE, lRaise);
        perform fc_debug('V_OPCAOCALC: ' || V_OPCAOCALC, lRaise);

        if NUMPRE is not null then

          if V_OPCAOCALC = true then

            perform fc_debug('Numpre encontrado na arrecad.', lRaise);
            return '4 CODIGO JA CALCULADO';
          else

            perform fc_debug('GERANDO ARREOLD.', lRaise);

            insert into arreold
                 select k00_numpre, k00_numpar, k00_numcgm, k00_dtoper, k00_receit, k00_hist, k00_valor,
                        k00_dtvenc, k00_numtot, k00_numdig, k00_tipo, k00_tipojm
                   from arrecad
                  where K00_NUMPRE = iNumpreDivida;

            delete from arrecad where k00_numpre = iNumpreDivida;
          end if;

        end if;

      end if;

      select v03_receit, k00_hist
        into V_RECEITA, V_HIST
        from proced
       where v03_codigo = V_PROCED;

      if V_RECEITA is null then
         return '6 CODIGO DA RECEITA NAO ENCONTRADO NO PROCDIVER';
      end if;

      if V_HIST is null then
         return '7 CODIGO DO HISTORICO NAO ENCONTRADO NO PROCDIVER';
      end if;

      V_DATA = V_PRIVENC;

      perform fc_debug('Numpre:   ' || iNumpreDivida, lRaise);
      perform fc_debug('Numpar:   ' || V_NUMPARC,     lRaise);
      perform fc_debug('Receita:  ' || V_RECEITA,     lRaise);
      perform fc_debug('Arretipo: ' || V_ARRETIPO,    lRaise);

      insert into arrecad (	k00_numcgm, k00_dtoper, k00_receit, k00_hist, k00_valor, k00_dtvenc, k00_numpre,
                            k00_numpar, k00_numtot, k00_numdig, k00_tipo, k00_tipojm )
                   values ( V_NUMCGM, V_DTOPER, V_RECEITA, V_HIST, V_VALOR, V_DATA, iNumpreDivida,
                            V_NUMPAR, V_NUMPARC, FC_DIGITO(iNumpreDivida, V_NUMPAR, V_NUMPARC ),
                            V_ARRETIPO, 0 );

   else

     return '0 TIPO NAO CONFIGURADO';

   end if;

   return '9 CALCULO EFETUADO';

end;
$$ language 'plpgsql';

/**
 * Wrapper fc_geraarrecad
 * @param  {[type]} integer  codigo arretipo
 * @param  {[type]} integer  numpre
 * @param  {[type]} boolean  Opção de calculo
 * @return {[type]}          varchar
 */
create or replace function fc_geraarrecad(integer, integer, boolean) returns varchar(200)
as $$
  select fc_geraarrecad($1, $2, $3, 1, false);
$$
language 'sql';

/**
 * Wrapper fc_geraarrecad passando geracao de numpre novo como false
 * @param  {[type]} integer  codigo arretipo
 * @param  {[type]} integer  numpre
 * @param  {[type]} boolean  Opção de calculo
 * @param  {[type]} boolean  Gerar numpre novo para o diverso (padrao false)
 * @return {[type]}          varchar
 */
create or replace function fc_geraarrecad(integer, integer, boolean, integer) returns varchar(200)
as $$
  select fc_geraarrecad($1, $2, $3, $4, false);
$$
language 'sql';set client_encoding = 'LATIN1';

create or replace function fc_juros(integer,date,date,date,bool,integer) returns float8 as
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
      perform fc_debug('<fc_juros> ------------------------------------------------------------------', lRaise, false, false);
    else
      perform fc_debug('<fc_juros> ------------------------------------------------------------------', lRaise, true, false);
    end if;

    perform fc_debug('<fc_juros> Processando calculo juros...',            lRaise, false, false);
    perform fc_debug('<fc_juros> ',                                        lRaise, false, false);
    perform fc_debug('<fc_juros> ',                                        lRaise, false, false);
    perform fc_debug('<fc_juros> ',                                        lRaise, false, false);
    perform fc_debug('<fc_juros> Parametros: ',                            lRaise, false, false);
    perform fc_debug('<fc_juros> ',                                        lRaise, false, false);
    perform fc_debug('<fc_juros> Receita ..............: ' || rece_juros,  lRaise, false, false);
    perform fc_debug('<fc_juros> Data de Vencimento ...: ' || v_data_venc, lRaise, false, false);
    perform fc_debug('<fc_juros> Data Atual ...........: ' || data_hoje,   lRaise, false, false);
    perform fc_debug('<fc_juros> Data de Operacao .....: ' || data_oper,   lRaise, false, false);
    perform fc_debug('<fc_juros> Impressao de Carne ...: ' || imp_carne,   lRaise, false, false);
    perform fc_debug('<fc_juros> Exercicio ............: ' || subdir,      lRaise, false, false);
    perform fc_debug('<fc_juros> ',                                        lRaise, false, false);
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

  data_venc := data_hoje;

  if lRaise is true then
    perform fc_debug('<fc_juros> V E R I F I C A   S A B A D O   E   D O M I N G O - ' || v_tabrec.k02_sabdom, lRaise, false, false);
    perform fc_debug('<fc_juros>',                                                                             lRaise, false, false);
  end if;

  if v_tabrec.k02_sabdom = true then

    if lRaise is true then
      perform fc_debug('<fc_juros> L O O P   I N I C I O - calend: ' || data_venc, lRaise, false, false);
      perform fc_debug('<fc_juros>',                                               lRaise, false, false);
    end if;

    loop

      data_venc := data_venc - 1;

      if lRaise is true then
        perform fc_debug('<fc_juros> calend: ' || data_venc, lRaise, false, false);
      end if;

      select k13_data
        into data_certa
        from calend
       where k13_data = data_venc;

      if data_certa is null then

        data_certa := data_venc + 1;

        exit;

      end if;

    end loop;

    if lRaise is true then
      perform fc_debug('<fc_juros>', lRaise, false, false);
      perform fc_debug('<fc_juros> L O O P   FIM --------- calend: ' || data_certa, lRaise, false, false);
    end if;

  else

    data_certa := data_hoje;

  end if;

  data_venc := v_data_venc;

  if lRaise is true then
    perform fc_debug('<fc_juros>',                                lRaise, false, false);
    perform fc_debug('<fc_juros> data_certa ...: ' || data_certa, lRaise, false, false);
    perform fc_debug('<fc_juros> data_hoje ....: ' || data_hoje,  lRaise, false, false);
    perform fc_debug('<fc_juros> data_venc ....: ' || data_venc,  lRaise, false, false);
  end if;

  v_datavencant  := data_venc;
  v_datacertaori := data_certa;

  if lRaise is true then
    perform fc_debug('<fc_juros>',                                        lRaise, false, false);
    perform fc_debug('<fc_juros> v_datavencant  ...: ' || v_datavencant,  lRaise, false, false);
    perform fc_debug('<fc_juros> v_datacertaori ...: ' || v_datacertaori, lRaise, false, false);
  end if;

  --
  -- CALCULA JUROS DE PARCELAMENTOS
  --

  if lRaise is true then
    perform fc_debug('<fc_juros> ',                                                                  lRaise, false, false);
    perform fc_debug('<fc_juros> C A L C U L O   D E   J U R O S   P A R C E L A D O - I N I C I O', lRaise, false, false);
    perform fc_debug('<fc_juros> ',                                                                  lRaise, false, false);
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
      perform fc_debug('<fc_juros> Receita de Juros ...: ' || rece_juros,                    lRaise, false, false);
      perform fc_debug('<fc_juros> Regra encontrada ...: ' || v_tabrecregras.k04_sequencial, lRaise, false, false);
      perform fc_debug('<fc_juros> Receita ............: ' || v_tabrecregras.k04_sequencial, lRaise, false, false);
      perform fc_debug('<fc_juros> Codigo J/M .........: ' || v_tabrecregras.k04_codjm,      lRaise, false, false);
      perform fc_debug('<fc_juros> Data Inicial .......: ' || v_tabrecregras.k04_dtini,      lRaise, false, false);
      perform fc_debug('<fc_juros> Data Final .........: ' || v_tabrecregras.k04_dtfim,      lRaise, false, false);
      perform fc_debug('<fc_juros> k02_jurparate ......: ' || v_tabrecregras.k02_jurparate,  lRaise, false, false);
    end if;

    -- itaqui
    v_tipo = v_tabrecregras.k02_jurparate;
    if v_tipo is null then
      v_tipo = 1; -- calcula ate vcto
    end if;

    if lRaise is true then
      perform fc_debug('<fc_juros>',                                  lRaise, false, false);
      perform fc_debug('<fc_juros> v_tipo .............: ' || v_tipo, lRaise, false, false);
    end if;

    if v_tipo = 1 then
      if data_venc < data_certa then

        if lRaise is true then
          perform fc_debug('<fc_juros>', lRaise, false, false);
          perform fc_debug('<fc_juros> Alterando o valor da variavel data_certa('||data_certa||') para o valor da variavel data_venc('||data_venc||')', lRaise, false, false);
        end if;
        data_certa := data_venc;

      end if;
    elsif v_tipo = 2 then -- calcula ate data atual

      if lRaise is true then
          perform fc_debug('<fc_juros>', lRaise, false, false);
          perform fc_debug('<fc_juros> Alterando o valor da variavel data_venc('||data_venc||') para o valor da variavel data_hoje('||data_hoje||')', lRaise, false, false);
      end if;
      data_venc := data_hoje;

    end if;

    if lRaise is true then
      perform fc_debug('<fc_juros>',                                                             lRaise, false, false);
      perform fc_debug('<fc_juros> v_dataopernova .............: ' || v_dataopernova,            lRaise, false, false);
      perform fc_debug('<fc_juros> v_tabrecregras.k04_dtini ...: ' || v_tabrecregras.k04_dtini,  lRaise, false, false);
      perform fc_debug('<fc_juros> v_tabrecregras.k04_dtfim ...: ' || v_tabrecregras.k04_dtfim,  lRaise, false, false);
      perform fc_debug('<fc_juros>',                                                             lRaise, false, false);
      perform fc_debug('<fc_juros> data_certa .................: ' || data_certa,                lRaise, false, false);
      perform fc_debug('<fc_juros> data_venc ..................: ' || data_venc,                 lRaise, false, false);
      perform fc_debug('<fc_juros> data_hoje ..................: ' || data_hoje,                 lRaise, false, false);
      perform fc_debug('<fc_juros>',                                                             lRaise, false, false);
      perform fc_debug('<fc_juros> juros_par ..................: ' || juros_par,                 lRaise, false, false);
      perform fc_debug('<fc_juros> k02_jurpar .................: ' || v_tabrecregras.k02_jurpar, lRaise, false, false);
    end if;

    if v_dataopernova >= v_tabrecregras.k04_dtini and v_dataopernova <= v_tabrecregras.k04_dtfim then

      if data_certa > v_tabrecregras.k04_dtfim then

        if lRaise is true then
           perform fc_debug('<fc_juros> Alterando o valor da variavel data_certa('||data_certa||') para o valor da variavel v_tabrecregras.k04_dtfim('||v_tabrecregras.k04_dtfim||')', lRaise, false, false);
        end if;

        data_certa := v_tabrecregras.k04_dtfim;

        if lRaise is true then
          perform fc_debug('<fc_juros>',                                     lRaise, false, false);
          perform fc_debug('<fc_juros> data_certa: .......: ' || data_certa, lRaise, false, false);
        end if;
      end if;

      if v_tabrecregras.k02_jurpar is not null and v_tabrecregras.k02_jurpar <> 0 then

        if lRaise is true then
          perform fc_debug('<fc_juros>',                                                                                 lRaise, false, false);
          perform fc_debug('<fc_juros> C A L C U L O   D O   J U R O S   D E   F I N A N C I A M E N T O - I N I C I O', lRaise, false, false);
          perform fc_debug('<fc_juros>',                                                                                 lRaise, false, false);
        end if;

        /*
          select que cria a quantidade de meses para o juros de financiamento conforme intervalo de data informado
          o juros deve ser calculado com base na data de operacao
        */
        select count(*)
          into quant_juros
          from generate_series(v_dataopernova, data_hoje - INTERVAL '1 month', INTERVAL '1 month');

        if lRaise is true then
          perform fc_debug('<fc_juros> v_dataopernova ..............: ' || v_dataopernova,            lRaise, false, false);
          perform fc_debug('<fc_juros> data_certa ..................: ' || data_certa,                lRaise, false, false);
          perform fc_debug('<fc_juros> data_hoje ...................: ' || data_hoje,                 lRaise, false, false);
          perform fc_debug('<fc_juros> quant_juros .................: ' || quant_juros,               lRaise, false, false);
          perform fc_debug('<fc_juros> v_tabrecregras.k02_jurpar ...: ' || v_tabrecregras.k02_jurpar, lRaise, false, false);
          perform fc_debug('<fc_juros> v_tabrecregras.k02_juracu ...: ' || v_tabrecregras.k02_juracu, lRaise, false, false);
        end if;

        juros_par := (quant_juros * cast(v_tabrecregras.k02_jurpar as numeric(8,2)));

        --
        -- para juros sob financiamento nao acumulado
        --
        if lRaise is true then
          perform fc_debug('<fc_juros>',                                              lRaise, false, false);
          perform fc_debug('<fc_juros> juros_par ...................: ' || juros_par, lRaise, false, false);
        end if;

        --
        -- para juros sob financiamento acumulado
        --
        if v_tabrecregras.k02_juracu = 't' and quant_juros > 0 then

          if lRaise is true then
            perform fc_debug('<fc_juros>',                                             lRaise, false, false);
            perform fc_debug('<fc_juros> calculando juros de financiamento acumulado', lRaise, false, false);
          end if;

          juros_par := (1 + (v_tabrecregras.k02_jurpar / 100)) ^ quant_juros;
          juros_par := (juros_par - 1) * 100;

          if lRaise is true then
            perform fc_debug('<fc_juros> percentual de juros ...: ' || v_tabrecregras.k02_jurpar, lRaise, false, false);
            perform fc_debug('<fc_juros> numero de periodos ....: ' || quant_juros,               lRaise, false, false);
            perform fc_debug('<fc_juros> juros acumulado .......: ' || juros_par,                 lRaise, false, false);
          end if;

        end if;

        if lRaise is true then
          perform fc_debug('<fc_juros>',                                  lRaise, false, false);
          perform fc_debug('<fc_juros> somando juros de parcelamento...', lRaise, false, false);
        end if;

        if lRaise is true then
          perform fc_debug('<fc_juros>',                                                                                       lRaise, false, false);
          perform fc_debug('<fc_juros> C A L C U L O   D O   J U R O S   D E   F I N A N C I A M E N T O - F I M', lRaise, false, false);
          perform fc_debug('<fc_juros>',                                                                                       lRaise, false, false);
        end if;

      end if;

    end if;

    if v_tipo = 1 then
      data_venc      := v_tabrecregras.k04_dtfim + 1;
      v_dataopernova := v_tabrecregras.k04_dtfim + 1;
    end if;

    data_certa := v_datacertaori;

    if lRaise is true then
      perform fc_debug('<fc_juros> ',                                       lRaise, false, false);
      perform fc_debug('<fc_juros> data_certa .......: ' || data_certa,     lRaise, false, false);
      perform fc_debug('<fc_juros> v_datacertaori ...: ' || v_datacertaori, lRaise, false, false);
      perform fc_debug('<fc_juros> v_dataopernova ...: ' || v_dataopernova, lRaise, false, false);
      perform fc_debug('<fc_juros> ',                                       lRaise, false, false);
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

  if lRaise is true then
    perform fc_debug('<fc_juros> ',                                                            lRaise, false, false);
    perform fc_debug('<fc_juros> juros_financ .....: ' || juros_par,                           lRaise, false, false);
    perform fc_debug('<fc_juros> juros_partotal ...: ' || juros_partotal,                      lRaise, false, false);
    perform fc_debug('<fc_juros> v_datavencant ....: ' || v_datavencant,                       lRaise, false, false);
    perform fc_debug('<fc_juros> v_datacertaori ...: ' || v_datacertaori,                      lRaise, false, false);
    perform fc_debug('<fc_juros> ',                                                            lRaise, false, false);
    perform fc_debug('<fc_juros> C A L C U L O   D E   J U R O S   P A R C E L A D O - F I M', lRaise, false, false);
    perform fc_debug('<fc_juros> ',                                                            lRaise, false, false);
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
$$ language 'plpgsql';insert into db_versaoant (db31_codver,db31_data) values (369, current_date);
select setval ('db_versaousu_db32_codusu_seq',(select max (db32_codusu) from db_versaousu));
select setval ('db_versaousutarefa_db28_sequencial_seq',(select max (db28_sequencial) from db_versaousutarefa));
select setval ('db_versaocpd_db33_codcpd_seq',(select max (db33_codcpd) from db_versaocpd));
select setval ('db_versaocpdarq_db34_codarq_seq',(select max (db34_codarq) from db_versaocpdarq));create table bkp_db_permissao_20160726_171359 as select * from db_permissao;
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
                                                                                                       
select fc_set_pg_search_path();                                                                        
select fc_schemas_dbportal();