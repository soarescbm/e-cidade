
----------------------------
--- Time C - INICIO
----------------------------

-- 82709
delete from db_syscadind    where codind = 4141 and codcam = 20894;
delete from db_syscadind    where codind = 4142 and codcam = 20895;
delete from db_sysindices   where codind in (4141, 4142);
delete from db_sysforkey    where codarq = 3759 and codcam in (20894, 20895);
delete from db_sysprikey    where codarq = 3759 and codcam = 20892;
delete from db_sysarqcamp   where codarq = 3759;
delete from db_syssequencia where codsequencia = 1000422;
delete from db_syscampo     where codcam in (20892,20893,20894,20895);
delete from db_sysarqmod    where codmod = 1008004 and codarq = 3759;
delete from db_sysarquivo   where codarq = 3759;

delete from db_sysprikey  where codarq = 3760 and codcam = 20890;
delete from db_sysarqcamp where codarq = 3760;
delete from db_syssequencia where codsequencia = 1000423;
delete from db_syscampo   where codcam in (20890, 20891);
delete from db_sysarqmod  where codmod = 1008004 and codarq = 3760;
delete from db_sysarquivo where codarq = 3760;


delete from db_docparagpadrao  where db62_coddoc   in (229, 230);
delete from db_paragrafopadrao where db61_codparag in (525, 524);
delete from db_documentopadrao where db60_coddoc   in (229, 230);
delete from db_tipodoc         where db08_codigo   in (5017, 5018);

delete from db_sysarqcamp where codarq = 1010078 and codcam = 20898;
delete from db_syscampo where codcam = 20898;
----------------------------
--- Time C - FIM
----------------------------

