ALTER TABLE integra_recibo ALTER COLUMN numbanco TYPE varchar(17);

ALTER TABLE integra_cad_config ALTER COLUMN faixa_inicial_numbanco TYPE varchar(17);
ALTER TABLE integra_cad_config ALTER COLUMN faixa_final_numbanco TYPE varchar(17);

ALTER TABLE integra_cad_config ADD COLUMN faixa_inicial_numdoc_novo integer;
ALTER TABLE integra_cad_config ADD COLUMN faixa_final_numdoc_novo integer;

UPDATE integra_cad_config SET faixa_inicial_numdoc_novo = cast(faixa_inicial_numdoc as integer);
UPDATE integra_cad_config SET faixa_final_numdoc_novo = cast(faixa_final_numdoc as integer);

ALTER TABLE integra_cad_config DROP COLUMN faixa_inicial_numdoc;
ALTER TABLE integra_cad_config DROP COLUMN faixa_final_numdoc;

ALTER TABLE integra_cad_config RENAME faixa_inicial_numdoc_novo TO faixa_inicial_numdoc;
ALTER TABLE integra_cad_config RENAME faixa_final_numdoc_novo TO faixa_final_numdoc;
