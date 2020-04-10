update db_sysarquivo set nomearq = 'rhferiasconfiguracao', descricao = 'Tabela com as configurações de assentamentos e período aquisitivo para as férias do RH', sigla = 'rh168', dataincl = '2016-11-24', rotulo = 'Tabela de configuração para Férias', tipotabela = 0, naolibclass = 'f', naolibfunc = 'f', naolibprog = 'f', naolibform = 'f' where codarq = 3872;
insert into db_syscampo select 22179,'rh168_ultimoperiodoaquisitivo','bool','Informa se no cadastro de férias será exibido apenas o último período aquisitivo ou os períodos ainda com algum saldo a ser pago.','f', 'Múltiplos períodos aquisitivos',1,'f','f','f',5,'text','Múltiplos períodos aquisitivos' where not exists (select 1 from db_syscampo where codcam = 22179);
insert into db_sysarqcamp select 3872,22179,4,0 where not exists (select 1 from db_sysarqcamp where codcam = 22179);

select fc_executa_ddl('alter table recursoshumanos.tipoassentamentoferias rename to rhferiasconfiguracao');
select fc_executa_ddl('alter table recursoshumanos.rhferiasconfiguracao add column rh168_ultimoperiodoaquisitivo boolean default \'f\'');

-- Atualização do nome do menu.
update db_itensmenu set descricao = 'Configurações de Férias' where id_item = '10156';
