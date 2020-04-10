---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------- INICIO TRIBUTARIO ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
delete from db_sysarqmod where codarq in (3921);
delete from db_sysarqcamp where codarq = 3921;
delete from db_sysforkey where codarq = 3921;
delete from db_syscampo where codcam in (21761, 21762, 21763, 21764, 21765, 21767, 21768);
delete from db_sysarquivo where codarq in (3921);
delete from db_syssequencia where codsequencia = 1000556;
delete from db_sysprikey where codarq = 3921;

---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO FOLHA ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
delete from db_sysarqcamp  where codcam in (21780, 21781, 21783);
delete from db_syscampodef where codcam in (21780, 21781, 21783);
delete from db_syscampo    where codcam in (21780, 21781, 21783);

update db_itensmenu set descricao = 'Por Registro', help = 'Por Registro', desctec = 'Por Registro' where id_item = 4505;
update db_itensmenu set descricao = 'Por Código', help = 'Por Código', desctec = 'Por Código' where id_item = 4513;

-- e-Social - Tabelas
delete from db_syssequencia where codsequencia = 1000559;
delete from db_syscadind where codind = 4335;
delete from db_sysindices where codind = 4335;
delete from db_sysforkey where codarq = 3924;
delete from db_sysprikey where codarq = 3924;
delete from db_sysarqcamp where codarq = 3924;
delete from db_syscampo where codcam in (21792, 21793, 21794);
delete from db_sysarqmod where codarq = 3924;
delete from db_sysarquivo where codarq = 3924;

delete from db_syssequencia where codsequencia = 1000558;
delete from db_syscadind where codind = 4334;
delete from db_sysindices where codind = 4334;
delete from db_sysprikey where codarq = 3923;
delete from db_sysforkey where codarq = 3923;
delete from db_sysarqcamp where codarq = 3923;
delete from db_syscampo where codcam in (21789, 21790, 21791);
delete from db_sysarqmod where codmod = 81;
delete from db_sysarquivo where codarq = 3923;
delete from db_sysmodulo where nomemod = 'esocial';

-- e-social
delete from atendcadareamod  where at26_id_item in (10216);
delete from db_menu          where modulo       in (10216);
delete from db_modulos       where id_item      in (10216);
delete from db_itensmenu     where id_item      in (10216,10217,10218,10219,10220,10222,10223,10224);

---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------- INICIO EDUCACAO/SAUDE  ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
delete from db_sysarqcamp where codcam = 21782;
delete from db_syscampo where codcam = 21782;


  --------------------------------------------------
-------------- GT ENTREGA CONTINUA ---------------
--------------------------------------------------

select fc_executa_ddl('

delete from db_sysarqcamp where codcam in (21801, 21802);
delete from db_syscampo where codcam in (21801, 21802);

ALTER TABLE agendaassentamento
DROP CONSTRAINT agendaassentamento_formulafim_fk;

ALTER TABLE agendaassentamento
DROP CONSTRAINT agendaassentamento_formulafaltasperiodo_fk;

alter table agendaassentamento drop column h82_formulafim;
alter table agendaassentamento drop column h82_formulafaltasperiodo;

');