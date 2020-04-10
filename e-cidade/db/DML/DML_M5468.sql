delete from db_sysarqcamp where codcam = 22180;
delete from db_syscampo   where codcam = 22180;
insert into db_syscampo values(22180,'ed47_municipioestrangeiro','varchar(255)','Município de um aluno estrangeiro.','', 'Localidade',255,'t','t','f',0,'text','Localidade');
insert into db_sysarqcamp values(1010051,22180,72,0);
select fc_executa_ddl('ALTER TABLE escola.aluno ADD COLUMN ed47_municipioestrangeiro varchar(255);');
