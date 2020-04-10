create or replace function fc_integra_recibo_inc_alt() returns trigger as 
$$
declare 

  rRecordConfig record;
  sOperacao     varchar default lower(TG_OP);
  sNumbanco     varchar;
  
begin

  -- Consulta Configuracoes
  select *
    into rRecordConfig
    from integra_cad_config
    order by sequencial desc limit 1;
    
  sNumbanco := new.numbanco;
  if new.numbanco = '' or new.numbanco is null then
    sNumbanco := 0;
  end if;

  -- Verifica se o valor informado se enquadra dentro da faixa configurada
  if cast( sNumbanco as numeric ) not between rRecordConfig.faixa_inicial_numbanco and rRecordConfig.faixa_final_numbanco then
    raise exception 'Valor informado para o campo numbanco fora da faixa configurada!';
  end if;  

  -- Verifica se o valor informado se enquadra dentro da faixa configurada
  if cast( new.numdoc as numeric ) not between rRecordConfig.faixa_inicial_numdoc and rRecordConfig.faixa_final_numdoc then
    raise exception 'Valor informado para o campo numdoc fora da faixa configurada!';
  end if;  

  if cast(rRecordConfig.tipo_convenio as numeric) = 2 and cast(sNumbanco as numeric) = 0 then
    raise exception 'Tipo de convênio configurado como cobrança (2), não aceitando valores nulos na coluna numbanco';  
  end if;
  
  return new;
     
end;
$$ 
language 'plpgsql';

DROP   TRIGGER IF EXISTS "tg_integra_recibo_inc" on integra_recibo;
DROP   TRIGGER IF EXISTS "tg_integra_recibo_alt" on integra_recibo;
CREATE TRIGGER "tg_integra_recibo_inc" BEFORE INSERT ON "integra_recibo" FOR EACH ROW EXECUTE PROCEDURE "fc_integra_recibo_inc_alt" () ;
CREATE TRIGGER "tg_integra_recibo_alt" BEFORE UPDATE ON "integra_recibo" FOR EACH ROW EXECUTE PROCEDURE "fc_integra_recibo_inc_alt" () ;
