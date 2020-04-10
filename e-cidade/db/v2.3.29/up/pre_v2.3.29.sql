/**
 * Arquivo pre up
 */
 --criterioatividadeimpacto
insert into db_sysarquivo values (3733, 'criterioatividadeimpacto', 'Tabela que conterá os critérios de medição das atividades de impacto local.', 'am', '2014-09-24', 'Cadastro de Critérios de medição', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (64,3733);
insert into db_syscampo values(20754,'am01_sequencial','int4','Sequencial do critério de medição de atividade de impacto local','0', 'Código Critério Medição',10,'f','f','f',1,'text','Código Critério Medição');
insert into db_syscampo values(20755,'am01_descricao','text','Critérios de medição de atividade de impacto local','', 'Critério de Medição',1,'f','f','f',3,'text','Critério de Medição');
update db_syscampo set nomecam = 'am01_descricao', conteudo = 'text', descricao = 'Critérios de medição de atividade de impacto local', valorinicial = '', rotulo = 'Critério de Medição', nulo = 'f', tamanho = 1, maiusculo = 'f', autocompl = 'f', aceitatipo = 3, tipoobj = 'text', rotulorel = 'Critério de Medição' where codcam = 20755;
delete from db_syscampodep where codcam = 20755;
delete from db_syscampodef where codcam = 20755;
delete from db_sysarqcamp where codarq = 3733;
delete from db_sysprikey where codarq = 3733;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3733,20754,1,20755);
insert into db_sysindices values(4113,'criterioatividadeimpacto_sequencial_in',3733,'1');
insert into db_syssequencia values(1000395, 'criterioatividadeimpacto_am01_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000395 where codarq = 3733 and codcam = 20754;
update db_syssequencia set nomesequencia = 'criterioatividadeimpacto_am01_sequencial_seq', incrseq = 1, minvalueseq = 1, maxvalueseq = 9223372036854775807, startseq = 1, cacheseq = 1 where codsequencia = 1000395;
update db_sysarqcamp set codsequencia = 1000395 where codarq = 3733 and codcam = 20754;
update db_syscampo set nomecam = 'am01_descricao', conteudo = 'varchar(50)', descricao = 'Critérios de medição de atividade de impacto local', valorinicial = '', rotulo = 'Critérios de Medição', nulo = 'f', tamanho = 50, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Critérios de Medição' where codcam = 20755;
delete from db_syscampodep where codcam = 20755;
delete from db_syscampodef where codcam = 20755;

--porteatividadeimpacto
insert into db_sysarquivo values (3734, 'porteatividadeimpacto', 'Tabela que conterá as descrições de porte para cada atividade de impacto local.', 'am02', '2014-09-24', 'Cadastro de porte de atividade impacto', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (64,3734);
insert into db_syscampo values(20757,'am02_sequencial','int4','Código do porte de atividade de impacto local.','0', 'Código do Porte de Atividade',10,'f','f','f',1,'text','Código do Porte de Atividade');
insert into db_syscampo values(20758,'am02_descricao','varchar(50)','Descrição do porte da atividade do impacto local.','', 'Descrição do Porte',50,'f','f','f',2,'text','Descrição do Porte');
delete from db_sysarqcamp where codarq = 3734;
insert into db_sysarqcamp values(3734,20757,1,0);
insert into db_sysarqcamp values(3734,20758,2,0);
delete from db_sysprikey where codarq = 3734;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3734,20757,1,20758);
insert into db_sysindices values(4114,'porteatividadeimpacto_sequencial_in',3734,'1');
insert into db_syscadind values(4114,20757,1);
insert into db_syssequencia values(1000396, 'porteatividadeimpacto_am02_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000396 where codarq = 3734 and codcam = 20757;

--atividadeimpacto
insert into db_sysarquivo values (3737, 'atividadeimpacto', 'Tabela que conterá as atividades de impacto local', 'am03', '2014-09-24', 'Cadastro de atividade de impacto local', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (64,3737);
insert into db_syscampo values(20767,'am03_sequencial','int4','Tabela que armazerá as atividades de Impacto Local','0', 'Atividade',10,'f','f','f',1,'text','Atividade');
insert into db_syscampo values(20769,'am03_ramo','varchar(10)','Ramo da Atividade de Impacto Local','', 'Ramo da Atividade',10,'f','f','f',0,'text','Ramo da Atividade');
insert into db_syscampo values(20770,'am03_descricao','varchar(255)','Campo da descrição da atividade de impacto local','', 'Descrição',255,'f','f','f',0,'text','Descrição da Atividade');
insert into db_syscampo values(20773,'am03_potencialpoluidor','varchar(20)','Potencial poluidor da atividade de impacto local','', 'Potencial Poluidor',20,'f','f','f',2,'text','Potencial Poluidor');
insert into db_syscampo values(20774,'am03_criterioatividadeimpacto','int4','Critério da atividade de impacto local','0', 'Critério de Medição',10,'f','f','f',1,'text','Atividade');
delete from db_sysarqcamp where codarq = 3737;
insert into db_sysarqcamp values(3737,20767,1,0);
insert into db_sysarqcamp values(3737,20774,2,0);
insert into db_sysarqcamp values(3737,20769,3,0);
insert into db_sysarqcamp values(3737,20770,4,0);
insert into db_sysarqcamp values(3737,20773,5,0);
delete from db_sysprikey where codarq = 3737;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3737,20767,1,20770);
insert into db_sysindices values(4118,'atividadeimpacto_sequencial_in',3737,'0');
insert into db_syscadind values(4118,20767,1);
delete from db_sysforkey where codarq = 3737 and referen = 0;
insert into db_sysforkey values(3737,20774,1,3733,0);
insert into db_syssequencia values(1000400, 'atividadeimpacto_am03_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000400 where codarq = 3737 and codcam = 20767;

--atividadeimpactoporte
insert into db_sysarquivo values (3740, 'atividadeimpactoporte', 'Relação entre Atividade de impacto local e Porte', 'am04', '2014-09-25', 'Relação Atividade e Porte', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (64,3740);
insert into db_syscampo values(20778,'am04_sequencial','int4','Código da Atividade e Porte','0', 'Porte',10,'f','f','f',1,'text','Código da Atividade e Porte');
insert into db_syscampo values(20779,'am04_atividadeimpacto','int4','Código da Atividade de impacto local','0', 'Atividade',10,'f','f','f',1,'text','Código da Atividade');
insert into db_syscampo values(20780,'am04_porteatividadeimpacto','int4','Código do Porte da atividade de impacto local','0', 'Porte',10,'f','f','f',1,'text','Código do Porte');
delete from db_sysarqcamp where codarq = 3740;
insert into db_sysarqcamp values(3740,20778,1,0);
insert into db_sysarqcamp values(3740,20779,2,0);
insert into db_sysarqcamp values(3740,20780,3,0);
delete from db_sysprikey where codarq = 3740;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3740,20778,1,20779);
insert into db_sysindices values(4121,'atividadeimpactoporte_sequencial_in',3740,'0');
insert into db_syscadind values(4121,20778,1);
insert into db_sysindices values(4125,'atividadeimpactoporte_atividadeimpacto_porteatividadeimpacto_in',3740,'1');
insert into db_syscadind values(4125,20779,1);
insert into db_syscadind values(4125,20780,2);
delete from db_sysforkey where codarq = 3740 and referen = 0;
insert into db_sysforkey values(3740,20779,1,3737,0);
delete from db_sysforkey where codarq = 3740 and referen = 0;
insert into db_sysforkey values(3740,20780,1,3734,0);
insert into db_syssequencia values(1000402, 'atividadeimpactoporte_am04_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000402 where codarq = 3740 and codcam = 20778;

--empreendimentos
insert into db_sysarquivo values (3741, 'empreendimento', 'Cadastros dos empreendimentos do modulo de meio ambiente', 'am05', '2014-09-25', 'Cadastro dos empreendimentos', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (64,3741);
insert into db_syscampo values(20785,'am05_sequencial','int4','Código do Empreendimento','0', 'Código do Empreendimento',10,'f','f','f',1,'text','Código do Empreendimento');
insert into db_syscampo values(20786,'am05_nome','varchar(40)','Nome do Empreendimento','', 'Nome',40,'t','f','f',0,'text','Nome do Empreendimento');
insert into db_syscampo values(20787,'am05_nomefanta','varchar(100)','Nome Fantasia do empreendimento','', 'Nome Fantasia',100,'t','f','f',0,'text','Nome Fantasia');
insert into db_syscampo values(20788,'am05_numero','int4','Número do Empreendimento','0', 'Número',10,'f','f','f',1,'text','Número do Empreendimento');
insert into db_syscampo values(20789,'am05_complemento','varchar(100)','Complemento do empreendimento','', 'Complemento',10,'t','f','f',1,'text','Complemento');
insert into db_syscampo values(20790,'am05_cep','varchar(8)','CEP do empreendimento','', 'CEP',8,'f','f','f',0,'text','CEP');
insert into db_syscampo values(20791,'am05_bairro','int4','Código Bairro do empreendimento','0', 'Código Bairro',10,'f','f','f',1,'text','Código Bairro');
insert into db_syscampo values(20792,'am05_ruas','int4','Código Logradouro do empreedimento','0', 'Código Logradouro',10,'f','f','f',1,'text','Código Logradouro');
insert into db_syscampo values(20797,'am05_cnpj','varchar(14)','CNPJ do Empreendimento','', 'CNPJ',14,'t','f','f',0,'text','CNPJ do Empreendimento');
insert into db_syscampo values(20803,'am05_cgm','int4','Código do CGM','', 'CGM',10,'f','f','f',1,'text','CGM');
delete from db_sysarqcamp where codarq = 3741;
insert into db_sysarqcamp values(3741,20785,1,0);
insert into db_sysarqcamp values(3741,20786,2,0);
insert into db_sysarqcamp values(3741,20787,3,0);
insert into db_sysarqcamp values(3741,20788,4,0);
insert into db_sysarqcamp values(3741,20789,5,0);
insert into db_sysarqcamp values(3741,20790,6,0);
insert into db_sysarqcamp values(3741,20791,7,0);
insert into db_sysarqcamp values(3741,20792,8,0);
insert into db_sysarqcamp values(3741,20797,9,0);
insert into db_sysarqcamp values(3741,20803,10,0);
delete from db_sysprikey where codarq = 3741;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3741,20785,1,20786);
delete from db_sysforkey where codarq = 3741 and referen = 0;
insert into db_sysforkey values(3741,20791,1,11,0);
delete from db_sysforkey where codarq = 3741 and referen = 0;
insert into db_sysforkey values(3741,20792,1,12,0);
delete from db_sysforkey where codarq = 3741 and referen = 0;
insert into db_sysforkey values(3741,20803,1,42,0);
insert into db_sysindices values(4122,'empreendimento_sequencial_in',3741,'1');
insert into db_syscadind values(4122,20785,1);
insert into db_syssequencia values(1000403, 'empreendimento_am05_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000403 where codarq = 3741 and codcam = 20785;

--empreendimentoatividadeimpacto
insert into db_sysarquivo values (3742, 'empreendimentoatividadeimpacto', 'Cadastro Empreendimento e Ativdade', 'am06', '2014-09-25', 'Cadastro Empreendimento e Ativdade', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (64,3742);
insert into db_syscampo values(20793,'am06_sequencial','int4','Código Empreendimento Atividade','0', 'Código Empreendimento Atividade',10,'f','f','f',1,'text','Código Empreendimento Atividade');
insert into db_syscampo values(20794,'am06_atividadeimpacto','int4','Código da Atividade de impacto local','0', 'Código da Atividade',10,'f','f','f',1,'text','Código da Atividade');
insert into db_syscampo values(20795,'am06_empreendimento','int4','Código do Empreendimento','0', 'Código do Empreendimento',10,'f','f','f',1,'text','Código do Empreendimento');
insert into db_syscampo values(20796,'am06_principal','bool','Atividade Principal ','f', 'Principal',1,'f','f','f',5,'text','Atividade Principal');
insert into db_syscampo values(20804,'am06_atividadeimpactoporte','int4','Atividade Impacto Porte','0', 'Porte',10,'f','f','f',1,'text','Porte');
delete from db_sysarqcamp where codarq = 3742;
insert into db_sysarqcamp values(3742,20793,1,0);
insert into db_sysarqcamp values(3742,20794,2,0);
insert into db_sysarqcamp values(3742,20795,3,0);
insert into db_sysarqcamp values(3742,20796,4,0);
insert into db_sysarqcamp values(3742,20804,5,0);
delete from db_sysprikey where codarq = 3742;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3742,20793,1,20794);
insert into db_sysindices values(4123,'empreendimentoatividadeimpacto_sequencial_in',3742,'1');
insert into db_syscadind values(4123,20793,1);
delete from db_sysforkey where codarq = 3742 and referen = 0;
insert into db_sysforkey values(3742,20794,1,3737,0);
insert into db_sysforkey values(3742,20795,1,3741,0);
insert into db_sysforkey values(3742,20804,1,3740,0);
insert into db_syssequencia values(1000404, 'empreendimentoatividadeimpacto_am06_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000404 where codarq = 3742 and codcam = 20793;

--responsaveltecnico
insert into db_sysarquivo values (3743, 'responsaveltecnico', 'Cadastro de Responsável Técnico', 'am07', '2014-09-25', 'Cadastro de Responsável Técnico', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (64,3743);
insert into db_syscampo values(20798,'am07_sequencial','int4','Código do Reponsável Técnico','0', 'Código do Reponsável Técnico',10,'f','f','f',1,'text','Código do Reponsável Técnico');
insert into db_syscampo values(20799,'am07_empreendimento','int4','Código do Empreendimento','0', 'Código do Empreendimento',10,'f','f','f',1,'text','Código do Empreendimento');
insert into db_syscampo values(20800,'am07_cgm','int4','Código do CGM','0', 'Código do CGM',10,'f','f','f',1,'text','Código do CGM');
delete from db_sysarqcamp where codarq = 3743;
insert into db_sysarqcamp values(3743,20798,1,0);
insert into db_sysarqcamp values(3743,20799,2,0);
insert into db_sysarqcamp values(3743,20800,3,0);
delete from db_sysprikey where codarq = 3743;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3743,20798,1,20800);
delete from db_sysforkey where codarq = 3743 and referen = 0;
insert into db_sysforkey values(3743,20799,1,3741,0);
delete from db_sysforkey where codarq = 3743 and referen = 0;
insert into db_sysforkey values(3743,20800,1,42,0);
insert into db_sysindices values(4124,'responsaveltecnico_sequencial_in',3743,'1');
insert into db_syscadind values(4124,20798,1);
insert into db_syssequencia values(1000405, 'responsaveltecnico_am07_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000405 where codarq = 3743 and codcam = 20798;

--licencaempreendimento
insert into db_sysarquivo values (3744, 'licencaempreendimento', 'Cadastro de Emissao de Licenças', 'am08', '2014-10-02', 'Cadastro de Emissao de Licenças', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (64,3744);
insert into db_syscampo values(20805,'am08_sequencial','int4','Código da Licença','0', 'Cod. Licença',10,'f','f','f',1,'text','Cod. Licença');
insert into db_syscampo values(20806,'am08_empreendimento','int4','Código do Empreendimento','0', 'Empreendimento',10,'f','f','f',1,'text','Empreendimento');
insert into db_syscampo values(20807,'am08_protprocesso','int4','Código do Protocolo','0', 'Protocolo',10,'f','f','f',1,'text','Protocolo');
insert into db_syscampo values(20808,'am08_licencaanterior','int4','Código da Licença Anterior a ser prorrogada ou renovada','0', 'Licença Anterior',10,'t','f','f',1,'text','Licença Anterior');
insert into db_syscampo values(20809,'am08_dataemissao','date','Data de Emissão Licença','null', 'Data de Emissão',10,'f','f','f',0,'text','Data de Emissão');
insert into db_syscampo values(20810,'am08_datavencimento','date','Data de Vencimento da Licença','null', 'Data de Vencimento',10,'f','f','f',0,'text','Data de Vencimento');
insert into db_syscampo values(20811,'am08_tipolicenca','int4','Tipo de Licença','0', 'Tipo de Licença',10,'f','f','f',1,'text','Tipo de Licença');
delete from db_sysarqcamp where codarq = 3744;
insert into db_sysarqcamp values(3744,20805,1,0);
insert into db_sysarqcamp values(3744,20806,2,0);
insert into db_sysarqcamp values(3744,20807,3,0);
insert into db_sysarqcamp values(3744,20808,4,0);
insert into db_sysarqcamp values(3744,20809,5,0);
insert into db_sysarqcamp values(3744,20810,6,0);
insert into db_sysarqcamp values(3744,20811,7,0);
delete from db_sysprikey where codarq = 3744;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3744,20805,1,20810);
delete from db_sysforkey where codarq = 3744 and referen = 0;
insert into db_sysforkey values(3744,20806,1,3741,0);
delete from db_sysforkey where codarq = 3744 and referen = 0;
insert into db_sysforkey values(3744,20807,1,403,0);
insert into db_sysindices values(4126,'licencaempreendimento_sequencial_in',3744,'1');
insert into db_syscadind values(4126,20805,1);
insert into db_syssequencia values(1000406, 'licencaempreendimento_am08_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000406 where codarq = 3744 and codcam = 20805;

--menus e módulo
insert into atendcadareamod values ( 74, 1 , 7808);
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 7808 ,29 ,1 ,7808 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 7808 ,31 ,2 ,7808 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 7808 ,30 ,3 ,7808 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 7808 ,32 ,4 ,7808 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9977 ,'Empreendimentos' ,'Cadastro de Empreendimentos' ,'' ,'1' ,'1' ,'Cadastro de Empreendimentos' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 29 ,9977 ,257 ,7808 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9978 ,'Inclusão' ,'Inclusão de Empreendimentos' ,'amb1_empreendimento001.php' ,'1' ,'1' ,'Inclusão de Empreendimentos' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 9977 ,9978 ,1 ,7808 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9979 ,'Alteração' ,'Alteração de Empreendimentos' ,'amb1_empreendimento001.php?acao=2' ,'1' ,'1' ,'Alteração de Empreendimentos' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 9977 ,9979 ,2 ,7808 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9981 ,'Emissão de Licenças' ,'Emite licenciamento' ,'amb4_emissaodelicenca001.php' ,'1' ,'1' ,'Menu responsável por emitir licenças de meio ambiente' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 32 ,9981 ,451 ,7808 );
update db_itensmenu set libcliente = true where id_item = 7808;

--Template tipo e padrão
insert into db_documentotemplatetipo(db80_sequencial, db80_descricao) values(48, 'LICENÇA DE INSTALAÇÃO');
insert into db_documentotemplatetipo(db80_sequencial, db80_descricao) values(49, 'LICENÇA DE OPERAÇÃO');
insert into db_documentotemplatetipo(db80_sequencial, db80_descricao) values(50, 'LICENÇA PRÉVIA');

insert into db_documentotemplatepadrao( db81_sequencial ,db81_templatetipo ,db81_nomearquivo ,db81_descricao ) values ( 51 , 48, 'documentos/templates/meioambiente/licenca_instalacao.sxw', 'LICENÇA DE INSTALAÇÃO' );
insert into db_documentotemplatepadrao( db81_sequencial ,db81_templatetipo ,db81_nomearquivo ,db81_descricao ) values ( 52 , 49, 'documentos/templates/meioambiente/licenca_operacao.sxw',   'LICENÇA DE OPERAÇÃO' );
insert into db_documentotemplatepadrao( db81_sequencial ,db81_templatetipo ,db81_nomearquivo ,db81_descricao ) values ( 53 , 50, 'documentos/templates/meioambiente/licenca_previa.sxw',     'LICENÇA PRÉVIA' );