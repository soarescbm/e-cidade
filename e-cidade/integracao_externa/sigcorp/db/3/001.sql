

 ALTER TABLE integra_recibo ADD COLUMN numbanco   varchar(50) default null;
 ALTER TABLE integra_recibo ADD COLUMN numdoc_new integer;

 UPDATE integra_recibo     
    SET numdoc_new = numdoc::integer;
 
 
 ALTER TABLE integra_recibo DROP    COLUMN numdoc; 
 ALTER TABLE integra_recibo RENAME  COLUMN numdoc_new TO numdoc;
 
 
 ALTER TABLE integra_cad_config ADD COLUMN faixa_inicial_numbanco integer;
 ALTER TABLE integra_cad_config ADD COLUMN faixa_final_numbanco   integer;

 CREATE UNIQUE INDEX integra_recibo_cod_barras_in ON integra_recibo(cod_barras);
 CREATE UNIQUE INDEX integra_recibo_numdoc_in     ON integra_recibo(numdoc);
 CREATE UNIQUE INDEX integra_recibo_numbanco_in   ON integra_recibo(numbanco);
 
 