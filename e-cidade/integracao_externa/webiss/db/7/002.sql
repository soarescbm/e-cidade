create or replace function fc_integra_recibo_inc_alt() returns trigger as 
$$
declare 

  rRecordConfig record;

begin

  -- Consulta Configurações
  select *
    into rRecordConfig
    from integra_cad_config;

  -- Verifica se o valor informado se enquadra dentro da faixa configurada
  if cast( new.numbanco as varchar ) not between rRecordConfig.faixa_inicial_numbanco and rRecordConfig.faixa_final_numbanco then
    raise exception 'Valor informado para o campo numbanco fora da faixa configurada!';
  end if;  

  -- Verifica se o valor informado se enquadra dentro da faixa configurada
  if cast( new.numdoc as integer ) not between rRecordConfig.faixa_inicial_numdoc and rRecordConfig.faixa_final_numdoc then
    raise exception 'Valor informado para o campo numdoc fora da faixa configurada!';
  end if;  

  return new;
     
end;
$$ 
language 'plpgsql';

DROP   TRIGGER IF EXISTS "tg_integra_recibo_inc" on integra_recibo;
DROP   TRIGGER IF EXISTS "tg_integra_recibo_alt" on integra_recibo;
CREATE TRIGGER "tg_integra_recibo_inc" BEFORE INSERT ON "integra_recibo" FOR EACH ROW EXECUTE PROCEDURE "fc_integra_recibo_inc_alt" () ;
CREATE TRIGGER "tg_integra_recibo_alt" BEFORE UPDATE ON "integra_recibo" FOR EACH ROW EXECUTE PROCEDURE "fc_integra_recibo_inc_alt" () ;
