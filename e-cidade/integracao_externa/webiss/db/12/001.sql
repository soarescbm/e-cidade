begin;
	alter TABLE integra_recibo_detalhe 
	      DROP CONSTRAINT integra_recibo_detalhe_tipo_lancamento_chk; 
	ALTER TABLE integra_recibo_detalhe 
	       ADD CONSTRAINT integra_recibo_detalhe_tipo_lancamento_chk CHECK (tipo_lancamento IN ('I', 'J', 'M', 'C', 'E'));
commit;