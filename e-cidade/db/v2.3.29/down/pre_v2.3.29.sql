/**
 * Arquivo pre down
 */
delete from db_syssequencia where codsequencia = 1000395;
delete from db_sysindices   where codind = 4113;
delete from db_sysarqcamp   where codarq = 3733;
delete from db_sysprikey    where codarq = 3733;
delete from db_syscampodef  where codcam = 20755;
delete from db_syscampodep  where codcam = 20755;
delete from db_syscampo     where codcam in ( 20755, 20754 );
delete from db_sysarqmod    where codmod = 64 and codarq = 3733;
delete from db_sysarquivo   where codarq in ( 3733 );

delete from db_syssequencia where codsequencia = 1000396;
delete from db_sysindices   where codind = 4114;
delete from db_sysarqcamp   where codarq = 3734;
delete from db_sysprikey    where codarq = 3734;
delete from db_syscadind    where codind = 4114;
delete from db_syscampodef  where codcam in ( 20757, 20758 );
delete from db_syscampodep  where codcam in ( 20757, 20758 );
delete from db_syscampo     where codcam = 20757;
delete from db_syscampo     where codcam = 20758;
delete from db_sysarqmod    where codmod = 64 and codarq = 3734;
delete from db_sysarquivo   where codarq = 3734;

--porteatividadeimpacto
delete from db_syscadind    where codind = 4118;
delete from db_sysindices   where codind = 4118;
delete from db_syssequencia where codsequencia = 1000400;
delete from db_sysprikey    where codarq = 3737;
delete from db_sysforkey    where codarq = 3737;
delete from db_sysarqcamp   where codarq = 3737;
delete from db_syscampodef  where codcam in ( 20767, 20769, 20770, 20773, 20774 );
delete from db_syscampodep  where codcam in ( 20767, 20769, 20770, 20773, 20774 );
delete from db_syscampo     where codcam in ( 20767, 20769, 20770, 20773, 20774 );
delete from db_sysarqmod    where codmod = 64 and codarq = 3737;
delete from db_sysarquivo   where codarq = 3737;

--atividadeimpactoporte
delete from db_syscadind    where codind = 4121;
delete from db_sysindices   where codind = 4121;
delete from db_syscadind    where codind = 4125;
delete from db_sysindices   where codind = 4125;
delete from db_syssequencia where codsequencia = 1000402;
delete from db_sysprikey    where codarq = 3740;
delete from db_sysforkey    where codarq = 3740;
delete from db_sysarqcamp   where codarq = 3740;
delete from db_syscampodef  where codcam in ( 20778, 20779, 20780 );
delete from db_syscampodep  where codcam in ( 20778, 20779, 20780 );
delete from db_syscampo     where codcam in ( 20778, 20779, 20780);
delete from db_sysarqmod    where codmod = 64 and codarq = 3740;
delete from db_sysarquivo   where codarq = 3740;

--empreendimentos
delete from db_syscadind    where codind = 4122;
delete from db_sysindices   where codind = 4122;
delete from db_syssequencia where codsequencia = 1000403;
delete from db_sysprikey    where codarq = 3741;
delete from db_sysforkey    where codarq = 3741;
delete from db_sysarqcamp   where codarq = 3741;
delete from db_syscampodef  where codcam in ( 20785, 20786, 20787, 20788, 20789, 20790, 20791, 20792, 20797, 20803);
delete from db_syscampodep  where codcam in ( 20785, 20786, 20787, 20788, 20789, 20790, 20791, 20792, 20797, 20803);
delete from db_syscampo     where codcam in ( 20785, 20786, 20787, 20788, 20789, 20790, 20791, 20792, 20797, 20803);
delete from db_sysarqmod    where codmod = 64 and codarq = 3741;
delete from db_sysarquivo   where codarq = 3741;

--empreendimentosatividadeimpacto
delete from db_syscadind    where codind = 4123;
delete from db_sysindices   where codind = 4123;
delete from db_syssequencia where codsequencia = 1000404;
delete from db_sysprikey    where codarq = 3742;
delete from db_sysforkey    where codarq = 3742;
delete from db_sysarqcamp   where codarq = 3742;
delete from db_syscampodef  where codcam in ( 20793, 20794, 20795, 20796, 20804);
delete from db_syscampodep  where codcam in ( 20793, 20794, 20795, 20796, 20804);
delete from db_syscampo     where codcam in ( 20793, 20794, 20795, 20796, 20804);
delete from db_sysarqmod    where codmod = 64 and codarq = 3742;
delete from db_sysarquivo   where codarq = 3742;

--responsaveltecnico
delete from db_syscadind    where codind = 4124;
delete from db_sysindices   where codind = 4124;
delete from db_syssequencia where codsequencia = 1000405;
delete from db_sysprikey    where codarq = 3743;
delete from db_sysforkey    where codarq = 3743;
delete from db_sysarqcamp   where codarq = 3743;
delete from db_syscampodef  where codcam in ( 20798, 20799, 20800);
delete from db_syscampodep  where codcam in ( 20798, 20799, 20800);
delete from db_syscampo     where codcam in ( 20798, 20799, 20800);
delete from db_sysarqmod    where codmod = 64 and codarq = 3743;
delete from db_sysarquivo   where codarq = 3743;

--licencaempreendimento
delete from db_syscadind    where codind = 4126;
delete from db_sysindices   where codind = 4126;
delete from db_syssequencia where codsequencia = 1000406;
delete from db_sysprikey    where codarq = 3744;
delete from db_sysforkey    where codarq = 3744;
delete from db_sysarqcamp   where codarq = 3744;
delete from db_syscampodef  where codcam in ( 20805, 20806, 20807, 20808, 20809, 20810, 20811);
delete from db_syscampodep  where codcam in ( 20805, 20806, 20807, 20808, 20809, 20810, 20811);
delete from db_syscampo     where codcam in ( 20805, 20806, 20807, 20808, 20809, 20810, 20811);
delete from db_sysarqmod    where codmod = 64 and codarq = 3744;
delete from db_sysarquivo   where codarq = 3744;

--menus e modulo
delete from atendcadareamod where at26_sequencia = 74 and at26_codarea = 1 and at26_id_item =  7808;
delete from db_menu where id_item_filho = 29 AND modulo   = 7808;
delete from db_menu where id_item_filho = 31 AND modulo   = 7808;
delete from db_menu where id_item_filho = 30 AND modulo   = 7808;
delete from db_menu where id_item_filho = 32 AND modulo   = 7808;
delete from db_menu where id_item_filho = 9977 AND modulo = 7808;
delete from db_menu where id_item_filho = 9978 AND modulo = 7808;
delete from db_menu where id_item_filho = 9979 AND modulo = 7808;
delete from db_menu where id_item_filho = 9980 AND modulo = 7808;
delete from db_itensmenu where id_item in ( 9977, 9978, 9979, 9980, 9981 );
delete from db_itensmenu where id_item = 9980;
delete from db_menu where id_item_filho = 9981 AND modulo = 7808;
update db_itensmenu set libcliente = false where id_item  = 7808;

--Template tipo e padrão
delete from db_documentotemplatepadrao where db81_sequencial = 51;
delete from db_documentotemplatepadrao where db81_sequencial = 52;
delete from db_documentotemplatepadrao where db81_sequencial = 53;

delete from db_documentotemplatetipo where db80_sequencial = 48;
delete from db_documentotemplatetipo where db80_sequencial = 49;
delete from db_documentotemplatetipo where db80_sequencial = 50;