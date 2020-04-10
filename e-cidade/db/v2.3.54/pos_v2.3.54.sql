insert into db_versao (db30_codver, db30_codversao, db30_codrelease, db30_data, db30_obs)  values (370, 3, 54, '2016-08-30', 'Tarefas: 100062, 100066, 100067, 100068, 100069, 100070, 100071, 100073, 100075, 100076, 100077, 100078, 100079, 100080, 100081, 100082, 100083, 100084, 100085, 100086, 100087, 100088, 100090, 100092, 100094, 100097, 100098, 100099, 100101, 100103, 100105, 100106, 100107, 100108, 100109, 100111, 100112, 100114, 100115, 100119, 100120, 100121, 100122, 100123, 100124, 100125, 100126, 100127, 100128, 100129, 100130, 100131, 100134, 100135, 100137, 100138, 100139, 100140, 100141, 100143, 100144, 100145, 100146, 100147, 100148, 100150, 100152, 100153, 100154, 100156, 100157, 100158, 100159, 100160, 100161, 100162, 100163, 100164, 100165, 100167, 100168, 100169, 100170, 100171, 100173, 100174, 100176, 100177, 100178, 100180');/*
 * $1 = id_acount apartir da contagem pra gerar mapas de migracao (NULL apartir inicio) 
 * $2 = tamanho do bloco do mapa de migraÃ§Ã£o (padrao usado = 1000)
 *
 */
CREATE OR REPLACE FUNCTION configuracoes.fc_auditoria_adiciona_acount_fila(INTEGER, INTEGER)
RETURNS void
AS $$
	/* Controle de concorrencia para evitar execuÃ§Ãµes simultÃ¢neas */
	SELECT pg_advisory_xact_lock(-123456789);

	SELECT fc_putsession('configuracoes.db_auditoria_migracao_sequencial_seq',
		(SELECT last_value+1 FROM configuracoes.db_auditoria_migracao_sequencial_seq)::text);

	INSERT	INTO configuracoes.db_auditoria_migracao (sequencial, id_acount_ini, id_acount_fim, status)
	SELECT	NEXTVAL('db_auditoria_migracao_sequencial_seq'),
			minimo + (soma * id) - soma + (
			CASE
				WHEN id = 1
					THEN 0
					ELSE 1
				END
			) AS id_acount_ini,
			CASE
				WHEN (minimo + (soma * id)) > maximo
				THEN maximo
				ELSE (minimo + (soma * id))
			END AS id_acount_fim,
			cast('NAO INICIADO' AS TEXT)
	FROM 	(SELECT	(SELECT	min(id_acount)
					 FROM	ONLY db_acount
					 WHERE	id_acount > coalesce($1, 0)) AS minimo,
					(SELECT	max(id_acount)
					 FROM	ONLY db_acount
					 WHERE	id_acount > coalesce($1, 0)) AS maximo,
					id,
					$2 AS soma
			 FROM	generate_series(1, (
						SELECT	ceil((max(id_acount) - min(id_acount) + 1) / $2::float8)
						FROM	ONLY db_acount
						WHERE	id_acount > coalesce($1, 0)
					)::integer) AS id LIMIT 10) AS x
	WHERE (minimo+maximo) > 0;

	UPDATE	db_auditoria_migracao
	SET		datahora_ini = COALESCE((dhi).datahora_ini, NOW() - interval '6 months'),
			datahora_fim = COALESCE((dhi).datahora_fim, NOW()),
			instit       = COALESCE((dhi).instit, (SELECT array_agg(codigo) FROM db_config))
	FROM	(SELECT	sequencial,
					fc_auditoria_busca_datahora_e_instit((current_date - interval '6 months')::date, id_acount_ini, id_acount_fim) AS dhi
			 FROM	db_auditoria_migracao
			 WHERE	sequencial >= fc_getsession('configuracoes.db_auditoria_migracao_sequencial_seq')::integer) AS x
	WHERE	db_auditoria_migracao.sequencial = x.sequencial;
$$
LANGUAGE sql;

DROP FUNCTION IF EXISTS public.fc_auditoria_adiciona_acount_fila();
CREATE OR REPLACE FUNCTION configuracoes.fc_auditoria_adiciona_acount_fila()
RETURNS void
AS $$
	SELECT configuracoes.fc_auditoria_adiciona_acount_fila(
				(SELECT	id_acount_fim
				 FROM	configuracoes.db_auditoria_migracao
				 ORDER	BY id_acount_fim DESC
				 LIMIT	1), 1000 );
$$
LANGUAGE sql;

CREATE OR REPLACE FUNCTION configuracoes.fc_auditoria_adiciona_todos_acount_fila()
RETURNS void
AS $$
	SELECT configuracoes.fc_auditoria_adiciona_acount_fila(NULL, 1000);
$$
LANGUAGE sql;DROP FUNCTION IF EXISTS public.fc_auditoria_busca_datahora_e_instit(DATE, INTEGER, INTEGER);
CREATE OR REPLACE FUNCTION configuracoes.fc_auditoria_busca_datahora_e_instit(
	data_inicial DATE,
	id_acount_ini INTEGER,
	id_acount_fim INTEGER,
	OUT datahora_ini TIMESTAMPTZ,
	OUT datahora_fim TIMESTAMPTZ,
	OUT instit INTEGER[])

AS $$
  select min(datahora_ini) as datahora_ini,
         max(datahora_fim) as datahora_fim,
         array_agg(distinct instit) as instit
    from ( (select to_timestamp(min(datahr)) as datahora_ini,
                   to_timestamp(max(datahr)) as datahora_fim,
                   instit
              from (select datahr,
                           coalesce((select min(i.id_instit) from db_userinst i where i.id_usuario=a.id_usuario),
                           (select codigo from db_config where prefeitura is true limit 1)) as instit
                      from db_acount a
                     where not exists
                             (select 1
                                from db_acountacesso ac
                                     join db_logsacessa la  on la.codsequen = ac.codsequen
                                                           and la.data >= $1
                                                           and la.instit = coalesce((select min(i.id_instit) from db_userinst i where i.id_usuario=a.id_usuario),
                                                                                    (select codigo from db_config where prefeitura is true limit 1))
                               where ac.id_acount = a.id_acount)
                       and a.id_acount between $2 and $3
                   ) as y
             group by instit)
           union all
           (select (min(data)||' '||min(hora))::timestamptz as datahora_ini,
                   (max(data)||' '||max(hora))::timestamptz as datahora_fim,
                   la.instit
              from db_acountacesso ac join db_logsacessa la on la.codsequen=ac.codsequen
                                                           and la.data >= $1
                                                           and la.instit in (select codigo from db_config)
             where ac.id_acount between $2 and $3
             group by la.instit)
         ) as x
$$
LANGUAGE sql;create or replace function fc_calculaprecomedio(integer, integer, float8, boolean)
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
                            when m81_tipo = 2 then round(m82_quant, 2)*round(case when m81_codtipo in (4, 19) then m89_valorunitario else m89_precomedio end, 5)*-1 end), 0) , 2)
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
                            when m81_tipo = 2 then round(round(m82_quant, 2)*round( case when m81_codtipo in (4, 19) then m89_valorunitario else m89_precomedio end, 5), 2)*-1 end), 0), 2)
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

  elsif iCodigoMovimento in (4, 19) then


    select round( (m71_valor/m71_quant) , 2)
      into nValorUnitario
      from matestoqueinill
           inner join matestoqueinil on m86_codigo = m87_matestoqueinil
           inner join matestoqueini on m86_matestoqueini = m80_codigo
           inner join matestoqueinimei on m80_codigo = m82_matestoqueini
           inner join matestoqueitem on m82_matestoqueitem = m71_codlanc
     where m87_matestoqueini = iCodigoMatestoqueini;


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
language 'plpgsql';-- ID do Commit: $Id: cgs_endereco.sql,v 1.6 2016/07/28 13:32:29 dbfabio.esteves Exp $

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

  if (fc_getsession('DB_desativa_trigger_endereco') is not null) then
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
            db72_descricao,
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
CREATE TRIGGER tg_cgs_endereco_inc_alt AFTER UPDATE OR INSERT ON cgs_und FOR EACH ROW EXECUTE PROCEDURE fc_cgs_endereco_inc_alt();drop function if exists fc_calculoiptu_ale_2009(integer,integer,boolean,boolean,boolean,boolean,boolean,integer,integer);
create or replace function fc_calculoiptu_ale_2009(integer,integer,boolean,boolean,boolean,boolean,boolean,integer,integer) returns varchar(100) as
$$

declare

   iMatricula 	  	alias   for $1;
   iAnousu    	  	alias   for $2;
   bGerafinanc      alias   for $3;
   bAtualizap	 	  	alias   for $4;
   bNovonumpre	  	alias   for $5;
   bCalculogeral   	alias   for $6;
   bDemo		       	alias   for $7;
   iParcelaini     	alias   for $8;
   iParcelafim     	alias   for $9;

   iIdbql           integer default 0;
   iNumcgm          integer default 0;
   iCodcli          integer default 0;
   iCodisen         integer default 0;
   iTipois          integer default 0;
   iParcelas        integer default 0;
   iNumconstr       integer default 0;
   iCodErro         integer default 0;

   dDatabaixa       date;

   nAreal           numeric default 0;
   nAreac           numeric default 0;
   nTotarea         numeric default 0;
   nFracao          numeric default 0;
   nFracaolote      numeric default 0;

   nAliquota            numeric default 0;
   nAliquotaTerritorial numeric default 0;
   nAliquotaPredial     numeric default 0;

   nProporcaoVVT        numeric(15,2) default 0;
   nVVCIsencao          numeric(15,2) default 0;
   nVVTIsencao          numeric(15,2) default 0;
   nVVCVVTIsencao       numeric(15,2) default 0;

   iMesesPredial     integer;
   iMesesTerritorial integer;
   nVIptuVvt         numeric(15,2) default 0;
   nVIptuVvc         numeric(15,2) default 0;

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
   bErro            boolean;
   bIsentaxas       boolean;
   bTempagamento    boolean;
   bEmpagamento     boolean;
   bTaxasCalculadas boolean;
   lRaise           boolean default false; -- true para abilitar raise na funcao principal
   lSulRaise        boolean default false; -- true para abilitar raise nas sub-funcoes

   rCfiptu          record;

begin

  lRaise    := (fc_getsession('DB_debugon') <> '');
  lSulRaise := (fc_getsession('DB_debugon') <> '');

  perform fc_debug('INICIANDO CALCULO',lRaise,true,false);

/* VERIFICA SE OS PARAMETROS PASSADOS ESTAO CORRETOS */
  select riidbql, rnareal, rnfracao, rinumcgm, rdbaixa, rberro, rtretorno
    into iIdbql,  nAreal,  nFracao,  iNumcgm,  dDatabaixa, bErro, tRetorno
    from fc_iptu_verificaparametros(iMatricula,iAnousu,iParcelaini,iParcelafim);
  if lRaise then
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
     delete from arrecad using iptunump
      where k00_numpre = iptunump.j20_numpre
        and iptunump.j20_anousu = iAnousu
        and iptunump.j20_matric = iMatricula;
     delete from iptunump
      where j20_anousu = iAnousu
        and j20_matric = iMatricula;

     select fc_iptu_geterro(2,'') into tRetorno;
     return tRetorno;
  end if;


  /* CRIA AS TABELAS TEMPORARIAS */
  select * into bErro from fc_iptu_criatemptable(lSulRaise);

  /* GUARDA OS PARAMETROS DO CALCULO */
  select * from into rCfiptu cfiptu where j18_anousu = iAnousu;

  /* FRACIONA LOTE */
  if lRaise then
    raise notice 'PARAMETROS IPTU_FRACIONALOTE FRACAO DO LOTE : % -- % -- % -- % ',iMatricula, iAnousu, bDemo, lSulRaise;
  end if;
  select rnfracao, rtdemo, rtmsgerro, rberro
    into nFracaolote, tDemo, tRetorno, bErro
    from fc_iptu_fracionalote(iMatricula,iAnousu,bDemo,lSulRaise);
    update tmpdadosiptu set fracao = nFracaolote;
  if lRaise then
    raise notice 'RETORNO FC_IPTU_FRACIONALOTE --->>> FRACAO DO LOTE : % - DEMONS : % - MSGRETORNO : % - ERRO : % ',nFracaolote, tDemo, tRetorno, bErro;
  end if;

  /* VERIFICA PAGAMENTOS */
  if lRaise then
    raise notice 'PARAMETROS fc_iptu_verificapag VERIFICANDO PARGAMENTOS  : % -- % -- % -- % ',iMatricula, iAnousu, bDemo, lSulRaise;
  end if;
  select rbtempagamento, rbempagamento, rtmsgretorno, rberro
    into bTempagamento, bEmpagamento, tRetorno, bErro
    from fc_iptu_verificapag(iMatricula,iAnousu,bCalculogeral,bAtualizap,false,bDemo,lSulRaise);
  if lRaise then
    raise notice 'RETORNO fc_iptu_verificapag -->>> TEMPAGAMENTO : % -- EMPAGAMENTO % -- RETORNO % -- ERRO % ',bTempagamento, bEmpagamento, tRetorno, bErro;
  end if;

  /* CALCULA VALOR DO TERRENO */
  if lRaise then
    raise notice 'PARAMETROS fc_iptu_calculavvt_ale_2009  IDBQL : % -- FRACAO DO LOTE % -- DEMO % -- ERRO % ',iIdbql, nFracaolote, tRetorno, bErro;
  end if;

  select rnvvt, rnarea, rtdemo, rtmsgerro, rberro
    into nVvt, nAreac, tDemo, tRetorno, bErro
    from fc_iptu_calculavvt_ale_2009(iMatricula, iIdbql, iAnousu, nFracaolote, nAreal, bDemo, lSulRaise);
  if lRaise then
    raise notice 'RETORNO fc_iptu_calculavvt_ale_2009 -->>> VVT : % -- AREA CONTRUIDA % --  RETORNO % -- ERRO % ',nVvt, nAreac, tRetorno, bErro;
  end if;
  if bErro is true then

    select fc_iptu_geterro(99,tRetorno) into tRetorno;
    return tRetorno;
  end if;


  /* VERIFICA ISENCOES */
  if lRaise then
    raise notice 'PARAMETROS fc_iptu_verificaisencoes  MATRICULA % -- ANOUSU % -- DEMO % -- ERRO % ', iMatricula, iAnousu, bDemo, lSulRaise;
  end if;
  select ricodisen, ritipois, rnisenaliq, rbisentaxas, rnarealo
    into iCodisen, iTipois, nIsenaliq, bIsentaxas, nArealo
    from fc_iptu_verificaisencoes(iMatricula,iAnousu,bDemo,lSulRaise);
  if iTipois is not null then
    update tmpdadosiptu set tipoisen = iTipois;
  end if;
  if lRaise then
    raise notice 'RETORNO fc_iptu_verificaisencoes -->>> CODISEN : % -- TIPOISEN : % --  ALIQ INSEN : % -- INSENTAXAS: % -- AREALO : % ',iCodisen, iTipois, nIsenaliq, bIsentaxas, nArealo;
  end if;

  /* CALCULA VALOR DA CONSTRUCAO */
  if lRaise then
    raise notice 'PARAMETROS fc_iptu_calculavvc_ale_2009  MATRICULA % -- ANOUSU % -- DEMO % -- ERRO % ', iMatricula, iAnousu, bDemo, lSulRaise;
  end if;

  select rnvvc,
         rntotarea,
         rimesespredial,
         rnValorIsencao,
         rinumconstr,
         rtdemo,
         rtmsgerro,
         rberro
    into nVvc,
         nTotarea,
         iMesesPredial,
         nVVCIsencao,
         iNumconstr,
         tDemo,
         tRetorno,
         bErro
    from fc_iptu_calculavvc_ale_2009(iMatricula, iAnousu, bDemo, lSulRaise);

  if lRaise then
    raise notice 'RETORNO fc_iptu_calculavvc_ale_2009 -->>> VVC : % -- AREA TOTAL : % --  NUMERO DE CONTRUCOES : % -- RETORNO : % -- ERRO : % ', nVvc, nTotarea, iNumconstr, tRetorno, bErro;
  end if;

  if nVvc is null or nVvc = 0 and iNumconstr <> 0 then
    select fc_iptu_geterro( 29, tRetorno ) into tRetorno;
    return tRetorno;
  end if;

  -- BUSCA AS ALIQUOTAS
  select fc_iptu_getaliquota_ale_2009(iMatricula,iIdbql,iNumcgm,true,lSulRaise) into nAliquotaPredial;
  select fc_iptu_getaliquota_ale_2009(iMatricula,iIdbql,iNumcgm,false,lSulRaise) into nAliquotaTerritorial;

  if nAliquotaTerritorial = 0 or nAliquotaPredial = 0 then
    select fc_iptu_geterro(13, '') into tRetorno;
    return tRetorno;
  end if;

  -- nVVTIsencao := nVvt * ()

  perform *
     from db_plugin
    where db145_nome = 'calculo-de-iptu-proporcional'
      and db145_situacao is true;

  -- Verifica se esta instalado o plugin cálculo de IPTU proporcional
  if not found then

    nAliquota := nAliquotaTerritorial;

    if iNumconstr > 0 then
      nAliquota := nAliquotaPredial;
    end if;

    nVv    := nVvc + nVvt;
    nViptu := nVv * (nAliquota / 100);

  -- Caso o plugin de cálculo de IPTU proporcional esteja instalado e ativo
  -- Efetua o cálculo de forma proporcional de acordo com as mudanças nas construções
  -- Verifica se a mudanças de predial e territorial
  elseif found then

    perform fc_debug(' <iptu_proporcional> ---------------- I N I C I O ----------------', lRaise, false, false);

    if iMesesPredial <> 12 and iMesesPredial <> 0 then

      nProporcaoVVT := (nVvt / 12) * (12 - iMesesPredial);
      nVIptuVvt := (nProporcaoVVT * (nAliquotaTerritorial / 100)) + ((nVvt - nProporcaoVVT) * (nAliquotaPredial / 100));

      nAliquota := nAliquotaPredial;

    else

      nAliquota := nAliquotaTerritorial;

      if iNumconstr > 0 then
        nAliquota := nAliquotaPredial;
      end if;

      nVIptuVvt := nVvt * (nAliquota / 100);

    end if;

    nVIptuVvc := nVvc * (nAliquotaPredial / 100);

    nVvcIsencao := nVIptuVvc - (nVvcIsencao * (nAliquotaPredial / 100));
    nVvtIsencao := nVIptuVvt - (nVIptuVvt * (nIsenaliq / 100));

    nViptu := nVIptuVvc + nVIptuVvt;

    nVvcVvtIsencao := nViptu - (nVvcIsencao + nVvtIsencao);

    nIsenaliq := (nVvcVvtIsencao * 100) / nViptu;

    perform fc_debug(' <iptu_proporcional> nVvc .............: ' || nVvc,                  lRaise, false, false);
    perform fc_debug(' <iptu_proporcional> nVvt .............: ' || nVvt,                  lRaise, false, false);
    perform fc_debug(' <iptu_proporcional> nAliquotaPredial .: ' || nAliquotaPredial,      lRaise, false, false);
    perform fc_debug(' <iptu_proporcional> nVIptuVvc ........: ' || nVIptuVvc,             lRaise, false, false);
    perform fc_debug(' <iptu_proporcional> nVIptuVvt ........: ' || nVIptuVvt,             lRaise, false, false);
    perform fc_debug(' <iptu_proporcional> nVvcIsencao ......: ' || nVvcIsencao,           lRaise, false, false);
    perform fc_debug(' <iptu_proporcional> nVvtIsencao ......: ' || nVvtIsencao,           lRaise, false, false);
    perform fc_debug(' <iptu_proporcional> nVvcVvtIsencao ...: ' || nVvcVvtIsencao,        lRaise, false, false);
    perform fc_debug(' <iptu_proporcional> nIsenaliq ........: ' || nIsenaliq,             lRaise, false, false);
    perform fc_debug(' <iptu_proporcional> nViptu ...........: ' || nViptu,                lRaise, false, false);
    perform fc_debug(' <iptu_proporcional> ------------------- F I M -------------------', lRaise, false, false);

  end if;

  update tmpdadosiptu set aliq = nAliquota;

  perform fc_debug('nViptu : '||nViptu,lRaise,false,false);

  perform predial from tmpdadosiptu where predial is true;

  if found then
    insert into tmprecval values (rCfiptu.j18_rpredi, nViptu, 1, false);
  else
    insert into tmprecval values (rCfiptu.j18_rterri, nViptu, 1, false);
  end if;

  select count(*)
    into iParcelas
    from cadvencdesc
         inner join cadvenc on q92_codigo = q82_codigo
   where q92_codigo = rCfiptu.j18_vencim ;
  if not found or iParcelas = 0 then
     select fc_iptu_geterro(14, '') into tRetorno;
     return tRetorno;
  end if;

  update tmpdadosiptu set viptu = nViptu, codvenc = rCfiptu.j18_vencim;

  update tmpdadostaxa set anousu = iAnousu, matric = iMatricula, idbql = iIdbql, valiptu = nViptu, valref = rCfiptu.j18_vlrref, vvt = nVvt, nparc = iParcelas;

/* CALCULA AS TAXAS */
  select db21_codcli
    into iCodcli
    from db_config
    where prefeitura is true;


  if lRaise then
    raise notice 'PARAMETROS fc_iptu_calculataxas  ANOUSU % -- CODCLI % ',iAnousu, iCodcli;
  end if;

  select fc_iptu_calculataxas(iMatricula,iAnousu,iCodcli,lSulRaise)
    into bTaxasCalculadas;

  if lRaise then
    raise notice 'RETORNO fc_iptu_calculataxas --->>> TAXASCALCULADAS - %',bTaxasCalculadas;
  end if;

/* MONTA O DEMONSTRATIVO */
  select fc_iptu_demonstrativo(iMatricula,iAnousu,iIdbql,lSulRaise )
     into tDemo;

/* GERA FINANCEIRO */
  if bDemo is false then -- Se nao for demonstrativo gera o financeiro, caso contrario retorna o demonstrativo
    select fc_iptu_geradadosiptu(iMatricula,iIdbql,iAnousu,nIsenaliq,bDemo,lSulRaise)
      into bDadosIptu;
      if bGerafinanc then
        select fc_iptu_gerafinanceiro(iMatricula,iAnousu,iParcelaini,iParcelafim,bCalculogeral,bTempagamento,bNovonumpre,bDemo,lSulRaise)
          into bFinanceiro;
      end if;
  else
     return tDemo;
  end if;

  if bDemo is false then
     update iptucalc set j23_manual = tDemo where j23_matric = iMatricula and j23_anousu = iAnousu;
  end if;

  perform fc_debug('CALCULO CONCLUIDO COM SUCESSO',lRaise,false,true);

  select fc_iptu_geterro(1, '') into tRetorno;
  return tRetorno;

end;
$$  language 'plpgsql';drop function if exists fc_iptu_taxalimpeza_ale_2009(integer,numeric,integer,numeric,numeric,boolean);
create or replace function fc_iptu_taxalimpeza_ale_2009(integer,numeric,integer,numeric,numeric,boolean) returns boolean as
$$
declare

    iReceita  alias for $1;
    iAliquota alias for $2;
    iHistCalc alias for $3;
    iPercIsen alias for $4;
    nValpar   alias for $5;
    lRaise    alias for $6;

    nValTaxa   numeric default 0;
    nValorBase numeric default 0;
    nFator     numeric default 0;

    iCaract        integer default 0;
    iIdbql         integer default 0;
    iNparc         integer default 0;
    iAnousu        integer default 0;
    iZona          integer default 0;
    nLimpeza       numeric default 0;
    nTestada       numeric default 0;
    iCartaxa       integer default 0;
    nAreaTotConstr numeric default 0;

    bPredial boolean default false;
    tSql     text    default '';

    r_Carconstr record;
    nj72_valor  numeric;

    aTotalMeses     integer[];
    iMesesPredial   integer default 0;
    nTaxaTemporaria numeric;

    nLimpezaIsen        numeric default 0;
    nTaxaTeritorialIsen numeric default 0;

begin

  perform fc_debug('CALCULANDO TAXA DE COLETA DE LIXO ...',lRaise,false,false);
  perform fc_debug('receita - '||iReceita||' aliq - '||iAliquota||' historico - '||iHistCalc,lRaise,false,false);

  iPercIsen := coalesce(iPercIsen, 0);

  select predial
    into bPredial
    from tmpdadosiptu;

  select anousu,
         idbql
    into iAnousu,
         iIdbql
    from tmpdadostaxa;

  if not found then
    return false;
  end if;

  select j34_zona into iZona from lote where j34_idbql = iIdbql;

  perform *
     from db_plugin
    where db145_nome = 'calculo-de-iptu-proporcional'
      and db145_situacao is true;

  -- Caso o plugin de cálculo de IPTU proporcional esteja instalado e ativo
  -- efetua o cálculo de forma proporcional de acordo com as mudanças nas construções
  if found then

    perform fc_debug(' <calcula_taxa_limpeza> ---------------- I N I C I O ----------------', lRaise);
    perform fc_debug(' <calcula_taxa_limpeza> Plugin de calculo de IPTU proporcional ativo',  lRaise);

    for r_Carconstr in
      select j48_caract,
             area,
             j39_idcons,
             area_isencao,
             meses
        from (
            select array_accum(mes) as meses,
                   j39_idcons,
                   sum(coalesce((select area
                                   from plugins.iptuconstrareahistorico
                                  where matricula = j39_matric
                                    and id_constr = j39_idcons
                                    and data >= (iAnousu||'-'||mes||'-01')::date
                                  order by data
                                  limit 1), j39_area)::numeric / 12) as area,
                   sum(
                    coalesce(
                      (select
                        (
                          (
                            (coalesce(
                              (select area
                                 from plugins.iptuconstrareahistorico
                                where matricula = j39_matric
                                  and id_constr = j39_idcons
                                  and data >= (iAnousu||'-'||mes||'-01')::date
                                order by data
                                limit 1
                              ), j39_area)
                            ) / 100
                          ) * (coalesce((select fc_iptu_verifica_isencao_taxa_competencia(j39_matric, iAnousu, mes, iReceita, lRaise)), 0))
                        )
                      ), 0)
                  )::numeric / 12 as area_isencao,
                   j39_area as areafinal
              from iptuconstr, generate_series(1,12) as mes
             where iptuconstr.j39_matric in (select matric from tmpdadostaxa limit 1)
               and j39_dtlan < (iAnousu||'-'||mes||'-01')::date
               and (j39_dtdemo is null or j39_dtdemo >= (iAnousu||'-'||mes||'-01')::date)
             group by j39_idcons,
                      j39_area
             ) as x
             inner join carconstr on j48_matric in (select matric from tmpdadostaxa limit 1) and j48_idcons = j39_idcons
             inner join caracter on j48_caract = j31_codigo
       where j31_grupo = 4
    loop

      iCarTaxa = r_Carconstr.j48_caract;
      nAreaTotConstr = r_Carconstr.area;

      perform fc_debug(' <calcula_taxa_limpeza> j39_idcons ................: ' || r_Carconstr.j39_idcons,   lRaise);
      perform fc_debug(' <calcula_taxa_limpeza> area ......................: ' || r_Carconstr.area,         lRaise);
      perform fc_debug(' <calcula_taxa_limpeza> area_isencao ..............: ' || r_Carconstr.area_isencao, lRaise);
      perform fc_debug(' <calcula_taxa_limpeza> Caracteristica ............: ' || iCarTaxa,                 lRaise);

      if iCarTaxa is not null then

        select j72_valor
          into nj72_valor
          from carzonavalor
         where j72_anousu = iAnousu
           and j72_caract = iCartaxa
           and j72_zona = iZona
           and j72_tipo = 'P';

        if nj72_valor is null then
          nLimpeza := 0;
          nLimpezaIsen := 0;
        else
          nLimpeza := nLimpeza + (nj72_valor * nAreaTotConstr);
          nLimpezaIsen := nLimpezaIsen + ((nj72_valor * nAreaTotConstr) - (nj72_valor * r_Carconstr.area_isencao));
        end if;

        perform fc_debug(' <calcula_taxa_limpeza> Valor da Caracteristica ...: ' || nj72_valor, lRaise);
        perform fc_debug(' <calcula_taxa_limpeza> Taxa de Limpeza ...........: ' || nLimpeza,   lRaise);

      end if;

      aTotalMeses := array_cat(aTotalMeses, r_Carconstr.meses);

      perform fc_debug(' <calcula_taxa_limpeza> ', lRaise);

    end loop;

    select count(*)
      into iMesesPredial
      from (select distinct unnest(aTotalMeses)) as x;

    perform fc_debug(' <calcula_taxa_limpeza> Meses para calculo predial ....: ' || iMesesPredial, lRaise);

    if bPredial is false or (iMesesPredial <> 0 and iMesesPredial <> 12) then

      select j72_valor
        into nj72_valor
        from carzonavalor
       where j72_anousu = iAnousu
         and j72_caract = 124
         and j72_zona = iZona
         and j72_tipo = 'T';

      select case when j36_testle = 0 then j36_testad else j36_testle end as j36_testle
        into nTestada
        from iptuconstr
             inner join testada on j36_face = j39_codigo and j36_idbql = iidbql
             inner join face on j37_face = j36_face
             inner join facevalor on j81_face = j37_face and j81_anousu = ianousu
             inner join iptubase on j01_matric = j39_matric
       where j39_matric in (select matric from tmpdadostaxa limit 1)
         and j39_dtdemo is null
         and j01_baixa is null
       limit 1;

      if nTestada is null then

        select case when j36_testle = 0 then j36_testad else j36_testle end as j36_testle
          into nTestada
          from testpri
               inner join face on j49_face = j37_face
               inner join facevalor on j81_face = j37_face and j81_anousu = ianousu
               inner join testada on j49_face = j36_face and j49_idbql = j36_idbql
         where j49_idbql = iIdbql;

      end if;

      nTaxaTemporaria := nj72_valor * nTestada;

      perform fc_debug(' <calcula_taxa_limpeza> Valor da Caracteristica Territorial ....: ' || nj72_valor,      lRaise);
      perform fc_debug(' <calcula_taxa_limpeza> Area da Testada ........................: ' || nTestada,        lRaise);
      perform fc_debug(' <calcula_taxa_limpeza> Taxa Territorial .......................: ' || nTaxaTemporaria, lRaise);

      nTaxaTeritorialIsen := (nTaxaTemporaria / 100) * (100 - iPercIsen);

      if iMesesPredial <> 0 then
        nLimpeza := nLimpeza + ((nTaxaTemporaria / 12) * (12 - iMesesPredial));
        nLimpezaIsen := nLimpezaIsen + ((nTaxaTeritorialIsen / 12) * (12 - iMesesPredial));
      else
        nLimpeza := nTaxaTemporaria;
        nLimpezaIsen := nTaxaTeritorialIsen;
      end if;

    end if;

    nLimpezaIsen := nLimpeza - nLimpezaIsen;

    iPercIsen := (100 * nLimpezaIsen) / nLimpeza;

    perform fc_debug(' <calcula_taxa_limpeza> Meses para calculo predial ....: ' || iMesesPredial, lRaise);
    perform fc_debug(' <calcula_taxa_limpeza> iPercIsen .....................: ' || iPercIsen,     lRaise);
    perform fc_debug(' <calcula_taxa_limpeza> nLimpeza ......................: ' || nLimpeza,      lRaise);

  else

    if bPredial is false then

      select j72_valor
        into nj72_valor
        from carzonavalor
       where j72_anousu = iAnousu
         and j72_caract = 124
         and j72_zona = iZona
         and j72_tipo = 'T';

      select case when j36_testle = 0 then j36_testad else j36_testle end as j36_testle
        into nTestada
        from iptuconstr
             inner join testada on j36_face = j39_codigo and j36_idbql = iidbql
             inner join face on j37_face = j36_face
             inner join facevalor on j81_face = j37_face and j81_anousu = ianousu
             inner join iptubase on j01_matric = j39_matric
       where j39_matric in (select matric from tmpdadostaxa limit 1)
         and j39_dtdemo is null and j01_baixa is null
       limit 1;

      if nTestada is null then

        select case when j36_testle = 0 then j36_testad else j36_testle end as j36_testle
          into nTestada
          from testpri
               inner join face on j49_face = j37_face
               inner join facevalor on j81_face = j37_face and j81_anousu = ianousu
               inner join testada on j49_face = j36_face and j49_idbql = j36_idbql
         where j49_idbql = iIdbql;

      end if;

      nLimpeza := nj72_valor * nTestada;

      perform fc_debug(' <calcula_taxa_limpeza> Valor da Caracteristica Territorial ....: ' || nj72_valor, lRaise);
      perform fc_debug(' <calcula_taxa_limpeza> Área da Testada ........................: ' || nTestada,   lRaise);
      perform fc_debug(' <calcula_taxa_limpeza> Taxa Territorial .......................: ' || nLimpeza,   lRaise);

    else

      for r_Carconstr in
        select j48_caract, j39_area, j39_idcons
          from iptuconstr
               inner join carconstr on j48_matric = j39_matric and j48_idcons = j39_idcons
               inner join caracter on j48_caract = j31_codigo
         where j39_dtdemo is null
           and j48_matric in (select matric from tmpdadostaxa limit 1)
           and j31_grupo = 4
      loop

        iCarTaxa = r_Carconstr.j48_caract;
        nAreaTotConstr = r_Carconstr.j39_area;

        perform fc_debug(' <calcula_taxa_limpeza> Contrucao ........: ' || r_Carconstr.j39_idcons, lRaise);
        perform fc_debug(' <calcula_taxa_limpeza> Caracteristica ...: ' || iCarTaxa,               lRaise);
        perform fc_debug(' <calcula_taxa_limpeza> Area Total .......: ' || nAreaTotConstr,         lRaise);

        if iCarTaxa is not null then

          select j72_valor
            into nj72_valor
            from carzonavalor
           where j72_anousu = iAnousu
             and j72_caract = iCartaxa
             and j72_zona = iZona
             and j72_tipo = 'P';

          if nj72_valor is null then
            nLimpeza = 0;
          else
            nLimpeza = nLimpeza + ( nj72_valor * nAreaTotConstr );
          end if;

          perform fc_debug(' <calcula_taxa_limpeza> Valor da Característica ....: ' || nj72_valor, lRaise);
          perform fc_debug(' <calcula_taxa_limpeza> Taxa de Limpeza ............: ' || nLimpeza,   lRaise);

        end if;

      end loop;

    end if;
  end if;

  nLimpeza := coalesce(nLimpeza, 0);

  perform fc_debug(' <calcula_taxa_limpeza> Taxa de Limpeza Calculada .....: ' || nLimpeza, lRaise);

  insert into tmptaxapercisen values (iReceita, iPercIsen, 0, nLimpeza);

  if iPercIsen > 0 then

    perform fc_debug(' <calcula_taxa_limpeza> Percentual de Isencao ........: ' || iPercIsen, lRaise);
    nLimpeza := nLimpeza * (100 - iPercIsen) / 100;
    perform fc_debug(' <calcula_taxa_limpeza> Taxa de Limpeza Calculada ....: ' || nLimpeza,  lRaise);
  end if;

  perform fc_debug(' <calcula_taxa_limpeza> ------------------- F I M -------------------', lRaise);

  tSql := 'insert into tmprecval values ('||iReceita||','||nLimpeza||','||iHistCalc||',true)';
  execute tSql;

  return true;

end;
$$ language 'plpgsql';drop function if exists fc_iptu_calculavvc_ale_2009(integer,integer,boolean,boolean);

create or replace function fc_iptu_calculavvc_ale_2009(iMatricula integer,
                                                       iAnousu integer,
                                                       bMostrademo boolean,
                                                       lRaise boolean,
                                                       OUT rnVvc          numeric(15,2),
                                                       OUT rnTotarea      numeric,
                                                       OUT riNumconstr    integer,
                                                       OUT riMesesPredial integer,
                                                       OUT rtDemo         text,
                                                       OUT rtMsgerro      text,
                                                       OUT rbErro         boolean,
                                                       OUT riCodErro      integer,
                                                       OUT rnValorIsencao numeric,
                                                       OUT rtErro         text)
returns record as
$$
declare

  bAtualiza              boolean default true;

  iTotalConstrucoes integer default 0;
  iMesesPredial     integer default 0;

  iConstrucao       integer;
  rConstrucao       record;

  nValorConstrucao        numeric;
  nValorVenalPredial      numeric;
  nValorVenalPredialTotal numeric default 0;
  nAreaTotalEdificada     numeric default 0;
  aTotalMeses             integer[];

  nValorIsencao           numeric default 0;

begin

  perform fc_debug('INICIANDO CALCULO VVC ...', lRaise, false, false);

  rnVvc          := 0;
  rnTotarea      := 0;
  riNumconstr    := 0;
  riMesesPredial := 0;
  rnValorIsencao := 0;
  rtDemo         := '';
  rtMsgerro      := 'Retorno ok' ;
  rbErro         := 'f';
  riCodErro      := 0;
  rtErro         := '';

  perform *
     from db_plugin
    where db145_nome = 'calculo-de-iptu-proporcional'
      and db145_situacao is true;

  -- Caso o plugin de cálculo de IPTU proporcional esteja instalado e ativo
  -- efetua o cálculo de forma proporcional de acordo com as mudanças nas construções
  if found then

    perform fc_debug(' <calculo_vvc> - Plugin de Cálculo de IPTU proporcional instalado', lRaise, false, false);
    perform fc_debug(' <calculo_vvc> - Calculando o valor proporcional mes a mes', lRaise, false, false);

    for rConstrucao in

      select array_accum(mes) as meses,
             j39_idcons,
             j39_area,
             sum(coalesce((select area
                         from plugins.iptuconstrareahistorico
                        where matricula = j39_matric
                          and id_constr = j39_idcons
                          and data >= (iAnousu||'-'||mes||'-01')::date
                        order by data
                        limit 1), j39_area)::numeric / 12) as area,
             sum(coalesce((
              select ((
                       (coalesce((select area
                                    from plugins.iptuconstrareahistorico
                                   where matricula = j39_matric
                                     and id_constr = j39_idcons
                                     and data >= (iAnousu||'-'||mes||'-01')::date
                                   order by data
                                   limit 1), j39_area)
                       ) / 100) * (100 - coalesce((
                       select sum(case
                                      when     extract(year  from j46_dtini) <= iAnousu
                                           and extract(year  from j46_dtfim) >= iAnousu
                                           and extract(month from j46_dtini) < mes
                                           and extract(month from j46_dtfim) > mes
                                      then j46_perc

                                      when     extract(year  from j46_dtini) <= iAnousu
                                           and extract(year  from j46_dtfim) >= iAnousu
                                           and extract(month from j46_dtini) = mes
                                           and extract(month from j46_dtfim) > mes
                                      then (j46_perc /
                                             (
                                              (date_trunc('month', (iAnousu||'-'||mes||'-01')::date) + interval '1 month' - interval '1 day')::date -
                                              (iAnousu||'-'||mes||'-01')::date + 1
                                             ) * (
                                              (date_trunc('month', (iAnousu||'-'||mes||'-01')::date) + interval '1 month' - interval '1 day')::date -
                                              j46_dtini + 1
                                             )
                                           )

                                      when     extract(year  from j46_dtini) <= iAnousu
                                           and extract(year  from j46_dtfim) >= iAnousu
                                           and extract(month from j46_dtini) < mes
                                           and extract(month from j46_dtfim) = mes
                                      then (j46_perc /
                                             (
                                              (date_trunc('month', (iAnousu||'-'||mes||'-01')::date) + interval '1 month' - interval '1 day')::date -
                                              (iAnousu||'-'||mes||'-01')::date + 1
                                             ) * (
                                              j46_dtfim + 1 - (iAnousu||'-'||mes||'-01')::date
                                             )
                                           )

                                      when     extract(year  from j46_dtini) <= iAnousu
                                           and extract(year  from j46_dtfim) >= iAnousu
                                           and extract(month from j46_dtini) = mes
                                           and extract(month from j46_dtfim) = mes
                                      then (j46_perc /
                                             (
                                              (date_trunc('month', (iAnousu||'-'||mes||'-01')::date) + interval '1 month' - interval '1 day')::date -
                                              (iAnousu||'-'||mes||'-01')::date + 1
                                             ) * (
                                              j46_dtfim - j46_dtini + 1
                                             )
                                           )
                                 end)
                         from iptuisen
                        where j46_matric = j39_matric
                          and extract(year  from j46_dtini) <= iAnousu
                          and extract(month from j46_dtini) <= mes
                          and extract(year  from j46_dtfim) >= iAnousu
                          and extract(month from j46_dtfim) >= mes), 0))
             )), 0))::numeric / 12 as area_isencao
        from iptuconstr, generate_series(1,12) as mes
       where iptuconstr.j39_matric = iMatricula
         and j39_dtlan < (iAnousu||'-'||mes||'-01')::date
         and (j39_dtdemo is null or j39_dtdemo >= (iAnousu||'-'||mes||'-01')::date)
       group by j39_idcons,
                j39_area
    loop

      select fc_iptu_calculavvc_valor_m2_ale_2009(iMatricula, rConstrucao.j39_idcons, iAnousu, lRaise)
        into nValorConstrucao;

      nValorVenalPredial      := nValorConstrucao * rConstrucao.area;
      nValorVenalPredialTotal := nValorVenalPredialTotal + nValorVenalPredial;

      nValorIsencao := nValorIsencao + (nValorVenalPredial - (nValorConstrucao * rConstrucao.area_isencao));

      perform fc_debug(' <calculo_vvc> - IDConstr: '||rConstrucao.j39_idcons, lRaise, false, false);
      perform fc_debug(' <calculo_vvc> - Área da Construção: '||rConstrucao.area, lRaise, false, false);
      perform fc_debug(' <calculo_vvc> - Área com Isenção: '||rConstrucao.area_isencao, lRaise, false, false);
      perform fc_debug(' <calculo_vvc> - Valor da Construção: '||nValorConstrucao, lRaise, false, false);
      perform fc_debug(' <calculo_vvc> - Valor Venal: '||nValorVenalPredial, lRaise, false, false);

      if nValorConstrucao = 0 then
        rnVvc          := 0;
        rnTotarea      := 0;
        riNumconstr    := 0;
        riMesesPredial := 0;
        rtDemo         := 'Valor do m2 da construcao zerado';
        rbErro         := 't';
        return;
      end if;

      insert into tmpiptucale( anousu,
                               matric,
                               idcons,
                               areaed,
                               vm2,
                               pontos,
                               valor )
                       values ( iAnousu,
                                iMatricula,
                                rConstrucao.j39_idcons,
                                rConstrucao.j39_area,
                                nValorConstrucao,
                                0,
                                nValorVenalPredial );

      if bAtualiza then
         update tmpdadosiptu
            set predial = true;
         bAtualiza = false;
      end if;

      nAreaTotalEdificada := nAreaTotalEdificada + rConstrucao.j39_area;
      iTotalConstrucoes   := iTotalConstrucoes + 1;

      aTotalMeses := array_cat(aTotalMeses, rConstrucao.meses);
    end loop;

    select count(*)
      into iMesesPredial
      from (select distinct unnest(aTotalMeses)) as x;

    perform fc_debug(' <calculo_vvc> - Meses para cálculo predial: '||iMesesPredial, lRaise, false, false);

  else

    for rConstrucao in
      select distinct on (iptuconstr.j39_matric, j39_idcons)
                     iptuconstr.j39_matric,
                     j39_idcons,
                     j39_ano,
                     j39_area::numeric
        from iptuconstr
       where iptuconstr.j39_dtdemo is null
         and iptuconstr.j39_matric = iMatricula
    loop

      select fc_iptu_calculavvc_valor_m2_ale_2009(rConstrucao.j39_matric, rConstrucao.j39_idcons, iAnousu, lRaise)
        into nValorConstrucao;

      nValorVenalPredial      := nValorConstrucao * rConstrucao.j39_area;
      nValorVenalPredialTotal := nValorVenalPredialTotal + nValorVenalPredial;

      perform fc_debug(' <calculo_vvc> - IDConstr: '||rConstrucao.j39_idcons, lRaise, false, false);
      perform fc_debug(' <calculo_vvc> - Área da Construção: '||rConstrucao.j39_area, lRaise, false, false);
      perform fc_debug(' <calculo_vvc> - Valor da Construção: '||nValorConstrucao, lRaise, false, false);
      perform fc_debug(' <calculo_vvc> - Valor Venal: '||nValorVenalPredial, lRaise, false, false);

      if nValorConstrucao = 0 then
        rnVvc          := 0;
        rnTotarea      := 0;
        riNumconstr    := 0;
        riMesesPredial := 0;
        rtDemo         := 'Valor do m2 da construcao zerado';
        rbErro         := 't';
        return;
      end if;

      insert into tmpiptucale( anousu,
                               matric,
                               idcons,
                               areaed,
                               vm2,
                               pontos,
                               valor )
                       values ( iAnousu,
                                iMatricula,
                                rConstrucao.j39_idcons,
                                rConstrucao.j39_area,
                                nValorConstrucao,
                                0,
                                nValorVenalPredial );

      if bAtualiza then
         update tmpdadosiptu
            set predial = true;
         bAtualiza = false;
      end if;

      nAreaTotalEdificada := nAreaTotalEdificada + rConstrucao.j39_area;
      iTotalConstrucoes   := iTotalConstrucoes + 1;

    end loop;

  end if;

  perform fc_debug('Valor Venal Predial Total: '||nValorVenalPredialTotal, lRaise, false, false);
  perform fc_debug('Área Edificada Total: '||nAreaTotalEdificada, lRaise, false, false);
  perform fc_debug('Valor da Isenção: '||nValorIsencao, lRaise, false, false);

  rnVvc          := nValorVenalPredialTotal;
  rnTotarea      := nAreaTotalEdificada;
  riNumconstr    := iTotalConstrucoes;
  riMesesPredial := iMesesPredial;
  rnValorIsencao := nValorIsencao;
  rtDemo         := '';
  rbErro         := 'f';

  update tmpdadosiptu set vvc = rnVvc;
  return;

end;
$$  language 'plpgsql';create or replace function fc_iptu_calculavvc_valor_m2_ale_2009(iMatricula integer,
                                                                iConstrucao integer,
                                                                iAnousu integer,
                                                                lRaise boolean)
returns numeric as
$$
declare
  rCaracteristica record;
  nValor          numeric default 0;
begin

  for rCaracteristica in

    select j48_caract,
           j31_pontos::float8,
           j31_codigo,
           j31_grupo,
           j31_descr,
           j32_descr
      from carconstr
           inner join caracter on j48_caract = j31_codigo
           inner join cargrup  on j31_grupo = j32_grupo
    where j48_matric = iMatricula
      and j48_idcons = iConstrucao
  loop

    if rCaracteristica.j31_grupo = 1 then

      select j71_valor
        into nValor
        from carvalor
       where j71_anousu = iAnousu
         and j71_caract = rCaracteristica.j48_caract;
    end if;

  end loop;

  return nValor;
end;

$$ language 'plpgsql';create or replace function fc_iptu_calculataxas(integer,integer,integer,boolean) returns boolean as
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

    perform *
       from db_plugin
      where db145_nome = 'calculo-de-iptu-proporcional'
        and db145_situacao is true;

    if found then

      select round(sum(aliquota) / 12, 2) as aliquota
        into nPercIsen
        from fc_iptu_verifica_isencao_taxa_competencia(iMatric, iAnousu, rTaxas.j08_tabrec, lRaise);

    else

      select coalesce(j56_perc,0)::numeric
        into nPercIsen
        from isentaxa
             inner join iptuisen on j56_codigo = j46_codigo
             inner join isenexe  on j47_codigo = j46_codigo
       where j46_matric = iMatric
         and j56_receit = rTaxas.j08_tabrec
         and j47_anousu = iAnousu;

       if not found  or nPercIsen is null then
         nPercIsen := 0;
       end if;
    end if;

    perform fc_debug(' <iptu_calculataxas> nPercIsen: ' || coalesce( nPercIsen, 0), lRaise);


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
$$  language 'plpgsql';drop function if exists fc_iptu_complementar(integer,integer,numeric,boolean);
create or replace function fc_iptu_complementar(
    iMatricula integer,
    iAnousu integer,
    nValor numeric,
    iReceita integer,
    lRaise boolean )
returns boolean as
$$
declare

  dDataCorrente   date;
  dDataVencimento date;

  iTipoDebito     integer;
  iProcDiver      integer;
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

  select dv09_procdiver
    into iProcDiver
    from procdiver
         inner join arretipo on arretipo.k00_tipo = procdiver.dv09_tipo
   where arretipo.k00_tipo = iTipoDebito
     and dv09_receit = iReceita;

  if not found then
    raise exception '<erro>Nenhuma procedência cadastrada para a receita % e tipo de débito %.</erro>',iReceita, sDescricaoDebito;
  end if;

  perform fc_debug(' <iptu_complementar> Procedência de Diversos '||iProcDiver, true);

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
           nValorCorrigido,
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
$$  language 'plpgsql';drop function if exists fc_iptu_gerafinanceiro(integer,integer,integer,integer,boolean,boolean,boolean,boolean,boolean);
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
  nValorCreditoDebito             numeric default 0;

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

      -- Verifica se mudou alguma das receitas comparado com o cálculo anterior
      perform *
         from tmpipturecalculo
        where not exists(select *
                           from iptucalv
                          where j21_matric = matricula
                            and j21_anousu = anousu
                            and j21_receit = receita);

      -- Caso tenha ocorrido troca de receitas, acerta as mesmas
      if found then

        update tmpipturecalculo
           set receita = (select j21_receit
                            from iptucalv
                           where j21_matric = iMatricula
                             and j21_anousu = iAnousu
                             and not exists( select *
                                               from tmpipturecalculo
                                              where matricula = j21_matric
                                                and anousu = j21_anousu
                                                and j21_receit = receita) limit 1)
         where not exists(select *
                            from iptucalv
                           where j21_matric = matricula
                             and j21_anousu = anousu
                             and j21_receit = receita);
      end if;

      perform fc_iptu_complementar(iMatricula, iAnousu, (j21_valor-coalesce(valor, 0))::numeric, j21_receit, lRaise)
         from iptucalv
         left join tmpipturecalculo on j21_matric = matricula
                                   and j21_anousu = anousu
                                   and j21_receit = receita
        where j21_matric = iMatricula
          and j21_anousu = iAnousu
          and (j21_valor-coalesce(valor, 0))::numeric > 0;

      -- Verifica se alguma das receitas deve gerar crédito
      select sum((j21_valor-coalesce(valor, 0))::numeric)
        into nValorCreditoDebito
        from iptucalv
        left join tmpipturecalculo on j21_matric = matricula
                                  and j21_anousu = anousu
                                  and j21_receit = receita
       where j21_matric = iMatricula
         and j21_anousu = iAnousu
         and (j21_valor-coalesce(valor, 0))::numeric < 0;

      if nValorCreditoDebito <> 0 then
        lCreditoRecalculo := true;
        nTotalCalculoNovo := nTotalCalculoAnterior - abs(nValorCreditoDebito);
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
$$  language 'plpgsql';create or replace function fc_iptu_verifica_isencao_competencia(
  matricula integer,
  anousu    integer,
  raise     boolean,
  OUT mes            integer,
  OUT aliquota       numeric,
  OUT area_lote      numeric,
  OUT isenta_taxas   boolean
) returns setof record as
$$
declare
  iMes integer;
begin

  for iMes in 1..12 loop

    mes := iMes;

    select *
      into aliquota,
           area_lote,
           isenta_taxas
      from fc_iptu_verifica_isencao_competencia(matricula, anousu, mes, raise);

    return next;
  end loop;

  return;
end;
$$  language 'plpgsql';


create or replace function fc_iptu_verifica_isencao_competencia(
  matricula integer,
  anousu    integer,
  mes       integer,
  raise     boolean,
  OUT aliquota       numeric,
  OUT area_lote      numeric,
  OUT isenta_taxas   boolean
) returns record as
$$
declare

  data_inicial date;
  data_final   date;

  total_dias integer;
begin

  if mes = 12 then
    data_final := (anousu||'-'||mes||'-31')::date;
  else
    data_final := (anousu||'-'||(mes+1)||'-01')::date - 1;
  end if;

  data_inicial := (anousu||'-'||mes||'-01')::date;
  total_dias := (data_final - data_inicial);

  aliquota       := 0;
  area_lote      := 0;
  isenta_taxas   := false;

  select coalesce(
            sum(((j46_dtfim - j46_dtini) * (case when j45_tipis = 1 then 100 else j46_perc end) / total_dias))
         , 0) as percentual,
         coalesce(
            sum(j46_arealo)
         , 0) as area,
         (count(case when j45_taxas is true then 1 else null end) > 0) as taxas
    into aliquota,
         area_lote,
         isenta_taxas
    from (
      select j46_perc,
             j45_tipis,
             j46_arealo,
             j45_taxas,
             case
               when j46_dtini < data_inicial and coalesce(j46_dtfim, data_final) >= data_inicial then
                 data_inicial
               else j46_dtini
             end as j46_dtini,
             case
               when coalesce(j46_dtfim, data_final) > data_final and j46_dtini <= data_final then
                 data_final
               else j46_dtfim
             end as j46_dtfim
        from iptuisen
             inner join tipoisen on j46_tipo = j45_tipo
       where j46_matric = matricula
    ) as x
   where extract(year from j46_dtini) = anousu
     and extract(month from j46_dtini) = mes;

  if aliquota > 100 then
    aliquota := 100;
  end if;

  return;
end;
$$  language 'plpgsql';create or replace function fc_iptu_verifica_isencao_taxa_competencia(
  matricula integer,
  anousu    integer,
  receita   integer,
  raise     boolean,
  OUT mes      integer,
  OUT aliquota numeric
) returns setof record as
$$
declare
  iMes integer;
begin

  for iMes in 1..12 loop

    mes := iMes;

    select *
      into aliquota
      from fc_iptu_verifica_isencao_taxa_competencia(matricula, anousu, mes, receita, raise);

    return next;
  end loop;

  return;
end;
$$  language 'plpgsql';

create or replace function fc_iptu_verifica_isencao_taxa_competencia(
  matricula integer,
  anousu    integer,
  mes       integer,
  receita   integer,
  raise     boolean,
  OUT aliquota numeric
) returns numeric as
$$
declare

  data_inicial date;
  data_final   date;

  total_dias integer;

begin

  if mes = 12 then
    data_final := (anousu||'-'||mes||'-31')::date;
  else
    data_final := (anousu||'-'||(mes+1)||'-01')::date - 1;
  end if;

  data_inicial := (anousu||'-'||mes||'-01')::date;
  total_dias := (data_final - data_inicial);

  aliquota := 0;

  select coalesce(
            sum(((j46_dtfim - j46_dtini) * (case when j45_tipis = 1 then 100 else j56_perc end) / total_dias))
         , 0) as percentual
    into aliquota
    from (
      select j56_perc,
             j45_tipis,
             case
               when j46_dtini < data_inicial and coalesce(j46_dtfim, data_final) >= data_inicial then
                 data_inicial
               else j46_dtini
             end as j46_dtini,
             case
               when coalesce(j46_dtfim, data_final) > data_final and j46_dtini <= data_final then
                 data_final
               else j46_dtfim
             end as j46_dtfim
        from iptuisen
             inner join tipoisen on j46_tipo = j45_tipo
             inner join isentaxa on isentaxa.j56_codigo = iptuisen.j46_codigo
       where j46_matric = matricula
         and j56_receit = receita
         and j45_taxas is true
    ) as x
   where extract(year from j46_dtini) = anousu
     and extract(month from j46_dtini) = mes;

  if aliquota > 100 then
    aliquota := 100;
  end if;

  return;
end;
$$  language 'plpgsql';drop function if exists fc_iptu_verificaisencoes(integer, integer, boolean, boolean);

drop type if exists tp_iptu_verificaisencoes;

create or replace function fc_iptu_verificaisencoes(
  iMatricula integer,
  iAnousu integer,
  bMostrademo boolean,
  lRaise boolean,
  OUT riCodisen   integer,
  OUT riTipois    integer,
  OUT rnIsenaliq  numeric,
  OUT rnArealo    numeric,
  OUT rbIsentaxas boolean
) returns record as
$$
begin

    perform fc_debug(' <iptu_verificaisencoes> VERIFICANDO ISENCOES...', lRaise);

    riCodisen   := 0;
    riTipois    := 0;
    rnIsenaliq  := 0;
    rbIsentaxas := 'f';
    rnArealo    := 0;

    perform *
       from db_plugin
      where db145_nome = 'calculo-de-iptu-proporcional'
        and db145_situacao is true;

    if found then

      select round(sum(aliquota) / 12, 2) as aliquota,
             max(area_lote) as area,
             (count(case when isenta_taxas is true then 1 else null end) > 1)::boolean as isenta_taxas
        into rnIsenaliq,
             rnArealo,
             rbIsentaxas
        from fc_iptu_verifica_isencao_competencia(iMatricula, iAnousu, lRaise);

    else

      select j46_codigo,
             coalesce(j45_tipis,0),
             j46_perc::numeric,
             j45_taxas as j45_taxas,
             case
               when j46_arealo is null then 0::numeric
               else j46_arealo::numeric
             end as j46_arealo
        into riCodisen,
             riTipois,
             rnIsenaliq,
             rbIsentaxas,
             rnArealo
        from iptuisen
             inner join isenexe  on j46_codigo = j47_codigo
             inner join tipoisen on j46_tipo   = j45_tipo
      where j46_matric = iMatricula
        and j47_anousu = iAnousu;

      if rnIsenaliq is null then
        rnIsenaliq = 0;
      end if;

      if rbIsentaxas is null then
        rbIsentaxas = 'true'::boolean;
      else
        rbIsentaxas = 'false'::boolean;
      end if;

    end if;

    perform fc_debug(' <iptu_verificaisencoes> riCodisen:   ' || coalesce( riCodisen, 0 ),   lRaise);
    perform fc_debug(' <iptu_verificaisencoes> rbIsentaxas: ' || rbIsentaxas,                lRaise);
    perform fc_debug(' <iptu_verificaisencoes> rnIsenaliq:  ' || coalesce( rnIsenaliq, 0 ),  lRaise);

    return;
end;
$$  language 'plpgsql';insert into db_versaoant (db31_codver,db31_data) values (370, current_date);
select setval ('db_versaousu_db32_codusu_seq',(select max (db32_codusu) from db_versaousu));
select setval ('db_versaousutarefa_db28_sequencial_seq',(select max (db28_sequencial) from db_versaousutarefa));
select setval ('db_versaocpd_db33_codcpd_seq',(select max (db33_codcpd) from db_versaocpd));
select setval ('db_versaocpdarq_db34_codarq_seq',(select max (db34_codarq) from db_versaocpdarq));create table bkp_db_permissao_20160830_131345 as select * from db_permissao;
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
