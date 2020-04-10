 /**
  * Indice removido e criado validcao na trigger
  */
DROP INDEX integra_recibo_numbanco_in, integra_recibo_numdoc_in;
 
 
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
begin

  -- Consulta Configurações
  select faixa_inicial_numbanco,
         faixa_final_numbanco,
         faixa_inicial_numdoc,
         faixa_final_numdoc
    into iFaixaInicialNumbanco,
         iFaixaFinalNumbanco,
         iFaicaInicialNumdoc, 
         iFaicaFinalNumdoc 
    from integra_cad_config;

  -- Verifica se o valor informado se enquadra dentro da faixa configurada
  if cast( new.numbanco as varchar ) not between iFaixaInicialNumbanco and iFaixaFinalNumbanco then
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
            integra_recibo.numbanco = new.numbanco)
       and integra_recibo.sequencial <> new.sequencial
       and integra_recibo.processado is false)  then 
    raise exception 'Nao pode existir mais de um Numero do Documento(numdoc):% ou Nosso Numero(numbanco):% nao processado.', new.numdoc, new.numbanco;
  end if;

  return new;

end;
$$
language 'plpgsql';

DROP   TRIGGER IF EXISTS "tg_integra_recibo_inc" on integra_recibo;
DROP   TRIGGER IF EXISTS "tg_integra_recibo_alt" on integra_recibo;
CREATE TRIGGER "tg_integra_recibo_inc" BEFORE INSERT ON "integra_recibo" FOR EACH ROW EXECUTE PROCEDURE "fc_integra_recibo_inc_alt" () ;
CREATE TRIGGER "tg_integra_recibo_alt" BEFORE UPDATE ON "integra_recibo" FOR EACH ROW EXECUTE PROCEDURE "fc_integra_recibo_inc_alt" () ;

