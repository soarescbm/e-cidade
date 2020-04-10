
 create 
     or 
replace function fc_integra_recibo_inc_alt() 
returns trigger 
     as
$$
declare
  iFaixaInicialNumbanco integer;
  iFaixaFinalNumbanco   integer;
  iFaicaInicialNumdoc   integer;
  iFaicaFinalNumdoc     integer;
  iTipoConvenio         integer;
  sNumbanco             varchar;
begin

  -- Consulta Configurações
  select faixa_inicial_numbanco,
         faixa_final_numbanco,
         faixa_inicial_numdoc,
         faixa_final_numdoc,
         tipo_convenio
    into iFaixaInicialNumbanco,
         iFaixaFinalNumbanco,
         iFaicaInicialNumdoc, 
         iFaicaFinalNumdoc,
         iTipoConvenio
    from integra_cad_config;

  sNumbanco := new.numbanco;
  if new.numbanco = '' or new.numbanco is null then
    sNumbanco := 0;
  end if;
  
  if (iTipoConvenio = 2 and (cast( sNumbanco as integer ) = 0 or cast( sNumbanco as varchar ) is null) ) then
    raise exception 'Quando Tipo de Convenio for Configurado como Tipo 2, campo numbanco n�o pode ser vazio!';
  end if;
  -- Verifica se o valor informado se enquadra dentro da faixa configurada
  if cast( sNumbanco as integer ) not between iFaixaInicialNumbanco and iFaixaFinalNumbanco then
    raise exception 'Valor informado para o campo numbanco fora da faixa configurada!';
  end if;

  -- Verifica se o valor informado se enquadra dentro da faixa configurada
  if cast( new.numdoc as integer )   not between iFaicaInicialNumdoc   and iFaicaFinalNumdoc   then
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

DROP   TRIGGER IF EXISTS "tg_integra_recibo_inc" on integra_recibo;
DROP   TRIGGER IF EXISTS "tg_integra_recibo_alt" on integra_recibo;
CREATE TRIGGER "tg_integra_recibo_inc" BEFORE INSERT ON "integra_recibo" FOR EACH ROW EXECUTE PROCEDURE "fc_integra_recibo_inc_alt" () ;
CREATE TRIGGER "tg_integra_recibo_alt" BEFORE UPDATE ON "integra_recibo" FOR EACH ROW EXECUTE PROCEDURE "fc_integra_recibo_inc_alt" () ;

