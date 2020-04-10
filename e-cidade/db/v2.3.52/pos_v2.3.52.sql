insert into db_versao (db30_codver, db30_codversao, db30_codrelease, db30_data, db30_obs)  values (368, 3, 52, '2016-06-22', 'Tarefas: 99558, 99745, 99756, 99760, 99772, 99774, 99777, 99778, 99782, 99783, 99784, 99785, 99787, 99788, 99791, 99792, 99793, 99794, 99795, 99796, 99797, 99798, 99799, 99800, 99801, 99802, 99803, 99804, 99805, 99806, 99807, 99808, 99809, 99811, 99812, 99813, 99814, 99815, 99816, 99817, 99819, 99820, 99821, 99822, 99823, 99824, 99825, 99826, 99827, 99828, 99830, 99831, 99832, 99833, 99834, 99835, 99836, 99837, 99838, 99839, 99840, 99842, 99843, 99844, 99845, 99846, 99847, 99848, 99849, 99850, 99851, 99852, 99853, 99856, 99857, 99859, 99862, 99864, 99865, 99866, 99868, 99870, 99871, 99872, 99873, 99874, 99875, 99876, 99879, 99880, 99881, 99882, 99884, 99885, 99886, 99887, 99888, 99889, 99890, 99891, 99893, 99894, 99895, 99896, 99897, 99899, 99900, 99901, 99902, 99905, 99906, 99907, 99910, 99911, 99912, 99914, 99915, 99916, 99918');-- ID do Commit: $Id: cgs_endereco.sql,v 1.2 2016/05/31 20:50:41 dbrafael.nery Exp $

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
        sd109_endereco,
        sd109_cgs_und
      ) values (
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
          sd109_endereco,
          sd109_cgs_und
        ) values (
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
CREATE TRIGGER tg_cgs_endereco_inc_alt AFTER UPDATE OR INSERT ON cgs_und FOR EACH ROW EXECUTE PROCEDURE fc_cgs_endereco_inc_alt();--
-- Funcao que gera registros no Financeiro de acordo com calculo
--
-- Parametros: 1 - Ano de Referencia
--             2 - Mes de Referencia
--             3 - Matricula
--             4 - Numpre
--             5 - NumCgm
--             6 - Receita
--             7 - Historico
--             8 - Valor


--drop function fc_agua_calculogerafinanceiro(integer, integer, integer, integer, integer, integer, integer, float8);
create or replace function fc_agua_calculogerafinanceiro(integer, integer, integer, integer, integer, integer, integer, integer, float8) returns bool as 
$$
declare
  -- Parametros
  iAno     alias for $1;
  iMes     alias for $2;
  iMatric   alias for $3;
  iNumpreOld alias for $4;
  iNumpre   alias for $5;
  iNumCgm   alias for $6;
  iReceit   alias for $7;
  iCodHist   alias for $8;
  nValor     alias for $9;
  -- Variaveis
  rArrecad          record;
  rArrecant         record;
  rArreMatric       record;
  rArreNumCgm       record;
  rRecibosGerados   record;
  rsResulDescArreca record;
  rAguaDescHist     record;
  dDataVenc         date;
  dDataOper         date;
  iNumTot            integer := 12; -- Total de Parcelas
  iNumDig           integer := 0;
  iTipo             integer := 0;
  iTipojm           integer := 0;
  iIdOcor           integer := 0;
  iIdOcorMatric     integer := 0;
  fTotalDescDebito  float;
  lRaise            boolean default false;
begin

  lRaise := ( case when fc_getsession('DB_debugon') is null then false else true end );   

  -- Busca Data de Vencimento
  dDataVenc := fc_agua_datavencimento(iAno, iMes, iMatric);

  if dDataVenc is null then
    return false;
  end if;

  --dDataOper := to_date(''01-''||to_char(iMes,''00'')||''-''||iAno, ''DD-MM-YYYY'');
  if fc_getsession('DB_datausu') = '' or fc_getsession('DB_datausu') is null then
    raise exception 'Variavel de sessao[DB_datausu] nao encontrada';
  end if;
  
  dDataOper := cast(fc_getsession('DB_datausu') as date);
  
  iTipo := fc_agua_confarretipo(iAno);
  
  -- Verifica se NumpreOld nao foi Pago/Cancelado/Importado pra Divida
  -- Verifica tambem se numpre não possui pagamento parcial
  perform * from ( 
    select k00_numpre
      from arrecant
     where k00_numpre = iNumpreOld
       and k00_numpar = iMes
       and k00_tipo   = iTipo
       and k00_receit = iReceit
    union all
    select k10_numpre
      from divold
     where k10_numpre  = iNumpreOld
       and k10_numpar  = iMes
       and k10_receita = iReceit
  ) as x;
  
  if not found and nValor > 0 then
    
    --deleta da arreold os registros antigos
    delete from arreold 
     where k00_numpre = iNumpreOld
       and k00_numpar = iMes
       and k00_tipo   = iTipo
       and k00_receit = iReceit;
  
    -- Insere Registro no Arrecad
    insert into arrecad(
      k00_numpre , k00_numpar ,
      k00_numcgm , k00_dtoper ,
      k00_receit , k00_hist   ,
      k00_valor  , k00_dtvenc ,
      k00_numtot , k00_numdig ,
      k00_tipo   , k00_tipojm 
    ) values (
      iNumpre , 
      iMes ,
      iNumCgm , 
      dDataOper ,
      iReceit , 
      3999 + iMes ,
      nValor  , 
      dDataVenc ,
      iNumTot , 
      iNumDig ,
      iTipo , 
      iTipojm
    );
    
    /**
     * retorna para arrecad e arrehist os descontos lançados 
    */
    fTotalDescDebito := 0;
    
    for rsResulDescArreca IN ( SELECT *
                                 FROM aguadescarrecad
                                WHERE x35_numpre = iNumpre
                                  AND x35_numpar = iMes
                                  AND x35_numcgm = iNumCgm
                                  AND x35_receit = iReceit)
    loop
                                  
      /**
       * cancela desconto caso valor do desconto sejá maior do que o débito
       */
    
      fTotalDescDebito := fTotalDescDebito + (rsResulDescArreca.x35_valor * -1);
  
      IF (fTotalDescDebito < nValor) THEN
  
        INSERT INTO arrecad(k00_numpre, k00_numpar, k00_numcgm,
                            k00_dtoper, k00_receit, k00_hist  ,
                            k00_valor , k00_dtvenc, k00_numtot,
                            k00_numdig, k00_tipo  , k00_tipojm)
                    VALUES (rsResulDescArreca.x35_numpre, rsResulDescArreca.x35_numpar, rsResulDescArreca.x35_numcgm,
                            rsResulDescArreca.x35_dtoper, rsResulDescArreca.x35_receit, rsResulDescArreca.x35_hist  ,
                            rsResulDescArreca.x35_valor , rsResulDescArreca.x35_dtvenc, rsResulDescArreca.x35_numtot,
                            rsResulDescArreca.x35_numdig, rsResulDescArreca.x35_tipo  , rsResulDescArreca.x35_tipojm);
        
        SELECT INTO rAguaDescHist *
          FROM aguadescarrehist
               INNER JOIN arrehist ON arrehist.k00_numpre = aguadescarrehist.x36_numpre
                                  AND arrehist.k00_numpar = aguadescarrehist.x36_numpar
                                  AND arrehist.k00_hist   = aguadescarrehist.x36_hist
                                  AND arrehist.k00_dtoper = aguadescarrehist.x36_dtoper
                                  AND arrehist.k00_hora   = aguadescarrehist.x36_hora
         WHERE aguadescarrehist.x36_numpre = iNumpre
           AND aguadescarrehist.x36_numpar = iMes;      
           
        IF NOT found THEN
  
          INSERT INTO arrehist (k00_numpre , k00_numpar   , k00_hist      ,
                                k00_dtoper , k00_hora     , k00_id_usuario,
                                k00_histtxt, k00_limithist, k00_idhist)
          SELECT x36_numpre , x36_numpar   , x36_hist      ,
                 x36_dtoper , x36_hora     , x36_id_usuario,
                 x36_histtxt, x36_limithist, nextval('arrehist_k00_idhist_seq')
            FROM aguadescarrehist
           WHERE aguadescarrehist.x36_numpre = iNumpre
             AND aguadescarrehist.x36_numpar = iMes;
        
        END IF;
        
      ELSE 
      
        iIdOcor       := nextval('histocorrencia_ar23_sequencial_seq');
        iIdOcorMatric := nextval('histocorrenciamatric_ar25_sequencial_seq');
        
        INSERT INTO histocorrencia  
          (ar23_sequencial  , ar23_id_usuario, ar23_instit, ar23_modulo,
           ar23_id_itensmenu, ar23_data      , ar23_hora  , ar23_tipo  ,
           ar23_descricao   , ar23_ocorrencia)
         VALUES
          (iIdOcor, cast(fc_getsession('DB_id_usuario') as integer),
           cast(fc_getsession('DB_instit') as integer), cast(fc_getsession('DB_modulo') as integer),
           cast(fc_getsession('DB_itemmenu_acessado') as integer), TO_DATE(fc_getsession('DB_datausu'), 'YYYY-MM-DD'),
           TO_CHAR(CURRENT_TIMESTAMP, 'HH24:MI')                 , 2,           
           'CANCELAMENTO DE DESCONTO', 'Desconto lançado anteriormente sobre o Numpre '||iNumpre||
           ' é maior que o valor da Parcela Total: R$ '||nValor);
        
        INSERT INTO histocorrenciamatric (ar25_sequencial, ar25_matric, ar25_histocorrencia)
                                  VALUES (iIdOcorMatric, iMatric, iIdOcor);
      
      END IF;
    
    END loop;
    
    -- Gera ArreMatric
    select  into rArreMatric
        *
    from   arrematric
    where  k00_numpre = iNumpre;
  
    if not found then
      insert into arrematric (
        k00_numpre,
        k00_matric
      ) values (
        iNumpre,
        iMatric
      );
    end if;
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
 
  return true;
end;
$$ language 'plpgsql';--
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
  nValorExcesso    float8 := 0;
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
  dDataVenc         date;
  lAtivaPgtoParcial boolean default false;
  lPossuiPagamentoParcialDebito boolean default false;
  
  rsAreaAlterada record;
  
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
  
    raise notice 'lGeraArrecad (%) lAguaLigada (%) iApto (%) nConsumo (%) nExcesso (%)', lGeraArrecad, lAguaLigada, iApto, nConsumo, nExcesso;

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
  
  select k03_pgtoparcial
    into lAtivaPgtoParcial
    from numpref
   where k03_instit = iInstit
     and k03_anousu = iAno;
  
  if lAtivaPgtoParcial is true then      
          
    select true
      into lPossuiPagamentoParcialDebito
      from arreckey
           inner join abatimentoarreckey on k128_arreckey   = k00_sequencial
           inner join abatimento         on k125_sequencial = k128_abatimento 
     where k00_numpre = iNumpre
       and k00_numpar = iMes;
       
    if lPossuiPagamentoParcialDebito is true then
        return '1 - Calculo não efetuado, matricula possui débito com pagamento parcial.';  
    end if;
       
      
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
      if (iCondominio is not null) then
      
        nValorTemp := fc_agua_calculatxapto(iAno, iCondominio, rCalculo.x25_codconsumotipo);
      
      else 
      
        nValorTemp := rCalculo.x20_valor * fc_agua_qtdeconomias(iMatric);
        
      end if;
    --
    -- .. ou Esgoto
    --
    elsif (rCalculo.x25_codconsumotipo = fc_agua_confconsumoesgoto()) and
          (lSemEsgoto = false) then
          
      if (iCondominio is not null) then
      
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
          select coalesce(x50_valor_m3_excesso,0)
              into nValorExcesso
              from aguacalc
              inner join agualeitura                    on x21_mes = iMes  and x21_exerc = iAno and x21_status = 1
              inner join aguahidromatric                on x04_codhidrometro = x21_codhidrometro and x04_matric = iMatric
              inner join aguacoletorexportadadosleitura on x51_agualeitura   = x21_codleitura
              inner join aguacoletorexportadados        on x50_aguacoletorexportadados    = x51_aguacoletorexportadados
            where x22_codconsumo = iConsumo and x22_codcalc = iCodCalc and x50_contaimpressa = 1;
          if nValorExcesso <> 0 then
            nValorTemp   := nValorExcesso;
          else
            nValorTemp   := rCalculo.x20_valor * nExcesso;
          end if;
          nValorExcesso := 0;
          lGeraDesconto = true;
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

      raise notice '2 - Matricula=(%) Isencao=(%) Padrao=(%) Taxa=(%) Valor Calculado=(%) Tipo Consumo=(%)', 
        iMatric,
        nPercentualIsencao,
        rCalculo.x20_valor,
        rCalculo.x25_descr,
        rCalculo.x99_valor,
        rCalculo.x25_codconsumotipo;

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
  
        raise notice '1 - Matricula=(%) Isencao=(%) Padrao=(%) Taxa=(%) Valor Calculado=(%) Tipo Consumo=(%)', 
          iMatric,
          nPercentualIsencao,
          rCalculo.x20_valor,
          rCalculo.x25_descr,
          rCalculo.x99_valor_desconto,
          rCalculo.x25_codconsumotipo;
  
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

          insert into arrecad
          ( k00_numpre, k00_numpar, k00_numcgm, k00_dtoper, k00_receit, k00_hist, k00_valor, k00_dtvenc, k00_numtot, k00_numdig, k00_tipo, k00_tipojm )
          values
          ( iNumpre, iMes, coalesce(rAguaBase.x01_numcgm, 0), dData, rCalculo.x25_receit, 970, rCalculo.x99_valor_desconto,dDataVenc, 12, 0, 137, 0 );
          
          if rCalculo.x99_valor - abs(rCalculo.x99_valor_desconto) = 0 then
          
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
  
  raise notice 'Economias=(%) Agua Ligada=(%) Esgoto Ligado (%) Recalculo=(%) CodCalc=(%) Numpre=(%)',
      iEconomias,
      lAguaLigada,
      lEsgotoLigado,
      lRecalculo,
      iCodCalc,
      iNumpre;
  
  return '1 - CALCULO CONCLUIDO COM SUCESSO ';
end;
$$ language 'plpgsql';--
-- Funcao que retorna o consumo total do Ano/Mes de referencia 
--
-- Parametros: 1 - Ano de Referencia
--             2 - Mes de Referencia
--             3 - Matricula
--
SET check_function_bodies TO off;
create or replace function fc_agua_consumo(integer, integer, integer) returns float8 as
$$
  select coalesce(sum(x21_consumo),0)
	  from agualeitura
         inner join aguahidromatric on x21_codhidrometro = x04_codhidrometro
	 where x21_exerc  = $1
     and x21_mes    = $2
     and x04_matric = $3
     and x21_status = 1 -- Leitura Ativa;
$$
language 'sql';

--
-- Funcao que retorna o consumo total do Ano/Mes de referencia 
--
-- Parametros: 1 - Ano de Referencia
--             2 - Mes de Referencia
--             3 - Matricula
--             4 - Codigo da Leitura a Desconsiderar
--
create or replace function fc_agua_consumo(integer, integer, integer, integer) returns float8 as '
	select		coalesce(sum(x21_consumo),0)
	from		agualeitura
	inner join 	aguahidromatric
	on			x21_codhidrometro = x04_codhidrometro
	where  		x21_exerc  = $1
	and 		x21_mes    = $2
	and     x21_codleitura <> $4
	and     x21_status = 1
	and 		x04_matric = $3;
' language 'sql';insert into db_versaoant (db31_codver,db31_data) values (368, current_date);
select setval ('db_versaousu_db32_codusu_seq',(select max (db32_codusu) from db_versaousu));
select setval ('db_versaousutarefa_db28_sequencial_seq',(select max (db28_sequencial) from db_versaousutarefa));
select setval ('db_versaocpd_db33_codcpd_seq',(select max (db33_codcpd) from db_versaocpd));
select setval ('db_versaocpdarq_db34_codarq_seq',(select max (db34_codarq) from db_versaocpdarq));create table bkp_db_permissao_20160622_171732 as select * from db_permissao;
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