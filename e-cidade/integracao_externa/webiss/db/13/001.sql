create 
     or 
replace function fc_integra_recibo_inc_alt() 
returns trigger 
     as
$$
declare
  iFaixaInicialNumbanco varchar;
  iFaixaFinalNumbanco   varchar;
  iFaixaInicialNumdoc   integer;
  iFaixaFinalNumdoc     integer;
  iTipoConvenio         integer;
  sNumbanco             varchar;
begin

  -- Consulta Configuracoes
  select faixa_inicial_numbanco,
         faixa_final_numbanco,
         faixa_inicial_numdoc,
         faixa_final_numdoc,
         tipo_convenio
    into iFaixaInicialNumbanco,
         iFaixaFinalNumbanco,
         iFaixaInicialNumdoc, 
         iFaixaFinalNumdoc,
         iTipoConvenio
    from integra_cad_config;

  sNumbanco := new.numbanco;
  if new.numbanco = '' or new.numbanco is null then
    sNumbanco := 0;
  end if;
  
  if (iTipoConvenio = 2 and (cast( sNumbanco as bigint ) = 0 or cast( sNumbanco as varchar ) is null) ) then
    raise exception 'Quando Tipo de Convenio for Configurado como Tipo 2, campo numbanco não pode ser vazio!';
  end if;
  -- Verifica se o valor informado se enquadra dentro da faixa configurada
  if cast( sNumbanco as bigint ) not between cast( iFaixaInicialNumbanco as bigint ) and cast( iFaixaFinalNumbanco as bigint ) then
    raise exception 'Valor informado para o campo numbanco fora da faixa configurada!';
  end if;

  -- Verifica se o valor informado se enquadra dentro da faixa configurada
  if new.numdoc not between iFaixaInicialNumdoc and iFaixaFinalNumdoc then
    raise exception 'Valor informado para o campo numdoc fora da faixa configurada!';
  end if;
  

  -- Valida se existe mais de um numpre e numdoc nao processados
  if exists (
    select 1
      from integra_recibo 
     where (integra_recibo.numdoc   = new.numdoc 
            or 
            integra_recibo.numbanco = sNumbanco)
       and integra_recibo.sequencial <> new.sequencial
       and integra_recibo.processado is false)  then 
    raise exception 'Nao pode existir mais de um Numero do Documento(numdoc):% ou Nosso Numero(numbanco):% nao processado.', new.numdoc, sNumbanco;
  end if;

  return new;

end;
$$
language 'plpgsql';
