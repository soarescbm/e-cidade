---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO FOLHA ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

--
-- Ajustes da TAG 99760 adicionada ao path da release 50
update db_sysarquivo set nomearq = 'avaliacaogruporespostarhpessoal', descricao = 'Tabela que vincula uma resposta de uma pergunta do e-Social para o servidor.', sigla = 'eso02', dataincl = '2016-05-18', rotulo = 'Vincula uma resposta de avaliação a um servidor', tipotabela = 0, naolibclass = 'f', naolibfunc = 'f', naolibprog = 'f', naolibform = 'f' where codarq = 3924;
update db_syscampo set nomecam = 'eso02_rhpessoal', conteudo = 'int4', descricao = 'Ví­nculo com o cadastro de servidores', valorinicial = '0', rotulo = 'Matrícula', nulo = 'f', tamanho = 19, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Matrí­cula' where codcam = 21794;
delete from db_syscampodep where codcam = 21794;
delete from db_syscampodef where codcam = 21794;
delete from db_sysforkey where codarq = 3924 and codcam = 21794;
select fc_executa_ddl('insert into db_sysforkey values(3924,21794,1,1153,0);');
delete from db_syssequencia where codsequencia = 1000559;
select fc_executa_ddl('insert into db_syssequencia values(1000573, ''avaliacaogruporespostarhpessoal_eso02_sequencial_seq'', 1, 1, 9223372036854775807, 1, 1);');
select fc_executa_ddl('insert into db_sysindices values(4352,''avaliacaogruporespostarhpessoal_un_in'',3924,''1'');');
select fc_executa_ddl('insert into db_syscadind values(4352,21793,1);');
select fc_executa_ddl('insert into db_syscadind values(4352,21794,2);');
select fc_executa_ddl('insert into db_syscadind values(4351,21792,1);');
update db_sysarqcamp set codsequencia = 1000573 where codarq = 3924 and codcam = 21792;

update db_syscampo set nomecam = 'eso02_avaliacaogruporesposta', conteudo = 'int4', descricao = 'Vínculo com a resposta', valorinicial = '0', rotulo = 'Resposta', nulo = 'f', tamanho = 19, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Resposta' where codcam = 21793;
delete from db_syscampodep where codcam = 21793;
delete from db_syscampodef where codcam = 21793;
delete from db_sysforkey where codarq = 3924 and referen = 2986;
select fc_executa_ddl('insert into db_sysforkey values(3924,21793,1,2987,0);');


-------------------------------
-- Melhorias para release 52 --
-------------------------------
update db_itensmenu set descricao = 'Exportar' where id_item = 10235;
alter table db_formulas alter db148_nome type varchar(100);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
		 VALUES (nextval('db_formulas_db148_sequencial_seq'), 'CODIGO_CGM', 'Retorna o código do CGM', '', true);
INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
                 VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_INSTITUICAO', 'Retorna a instituição atual', '', true);
INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
                 VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_MATRICULA_SERVIDOR', 'Retorna a matrícula do servidor que está respondendo ao questionário do eSocial', '', true);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
                 VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_PORTADOR_DEFICIENCIA', 'Retorna a opção se o servidor tem ou não deficiencia', 'select case rh02_deficientefisico::int when 1 then 3001095 else 3001096 end as portador_deficiencia from rhpessoalmov where rh02_anousu = fc_anofolha([ESOCIAL_INSTITUICAO]) and rh02_mesusu = fc_mesfolha([ESOCIAL_INSTITUICAO]) and rh02_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000238);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_TIPO_DEFICIENCIA', 'Retorna a opção para o campo de tipo de deficiência que o servidor possui', 'select case rh02_tipodeficiencia when 1 then 3001108 when 3 then 3001109 when 2 then 3001111 when 4 then 3001114 else null end as tipo_deficiencia from rhpessoalmov where rh02_anousu = fc_anofolha([ESOCIAL_INSTITUICAO]) and rh02_mesusu = fc_mesfolha([ESOCIAL_INSTITUICAO]) and rh02_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000239);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_REGIME_PREVIDENCIARIO', 'Retorna a opção para o regime previdenciário, se inss ou próprio', 'select case rh02_tbprev when 0 then null when 1 then 3001073 else 3001074 end as regime_previdenciario from rhpessoalmov  where  rh02_anousu = fc_anofolha([ESOCIAL_INSTITUICAO])  and rh02_mesusu = fc_mesfolha([ESOCIAL_INSTITUICAO])  and rh02_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000245);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_CODIGO_REGIME_PREVIDENCIARIO', 'Retorna a opção para o regime previdenciário, se inss ou próprio', 'select case rh02_tbprev when 0 then null when 1 then 3001051 else 3001052 end as regime_previdenciario from rhpessoalmov  where  rh02_anousu = fc_anofolha([ESOCIAL_INSTITUICAO])  and rh02_mesusu = fc_mesfolha([ESOCIAL_INSTITUICAO])  and rh02_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000282);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_CARGO_SERVIDOR', 'Retorna o cargo do servidor', 'select rh37_descr as cargo from rhpessoalmov inner join rhfuncao on rh37_funcao = rh02_funcao and rh37_instit = rh02_instit where rh02_anousu = fc_anofolha([ESOCIAL_INSTITUICAO]) and rh02_mesusu = fc_mesfolha([ESOCIAL_INSTITUICAO]) and rh02_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000284);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_FUNCAO_SERVIDOR', 'Retorna a funcao do servidor', 'select rh04_descr as funcao from rhpessoalmov inner join rhpescargo on rh20_seqpes = rh02_seqpes and rh20_instit = rh02_instit inner join rhcargo on rh04_codigo = rh20_cargo and rh04_instit = rh20_instit where rh02_anousu = fc_anofolha([ESOCIAL_INSTITUICAO]) and rh02_mesusu = fc_mesfolha([ESOCIAL_INSTITUICAO]) and rh02_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000285);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_UNIDADE_PAGAMENTO', 'Retorna a opção da unidade de pagamento do servidor', 'select case rh02_tipsal when ''M'' then 3000956 when ''Q'' then 3000955 when ''D'' then 3000953 when ''H'' then 3000952 else null end as unidade_pagamento from rhpessoalmov where rh02_anousu = fc_anofolha([ESOCIAL_INSTITUICAO]) and rh02_mesusu = fc_mesfolha([ESOCIAL_INSTITUICAO]) and rh02_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000283);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_REMUNERACAO', 'Retorna a remuneração do servidor', 'select f010 as remuneracao from fc_variaveis_matricula([ESOCIAL_MATRICULA_SERVIDOR], fc_anofolha([ESOCIAL_INSTITUICAO]), fc_mesfolha([ESOCIAL_INSTITUICAO]), [ESOCIAL_INSTITUICAO])', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000271);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_QTDE_HORAS_SEMANA', 'Retorna a quantidade de horas semanais do servidor', 'select rh02_hrssem as qtde_horas_semana from rhpessoalmov where rh02_anousu = fc_anofolha([ESOCIAL_INSTITUICAO]) and rh02_mesusu = fc_mesfolha([ESOCIAL_INSTITUICAO]) and rh02_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000242);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_LOCAL_TRABALHO', 'Retorna onde o servidor está lotado (local de trabalho)', 'select rh55_descr as lotacao from rhpessoalmov inner join rhpeslocaltrab on rh56_seqpes = rh02_seqpes inner join rhlocaltrab on rh55_codigo = rh56_localtrab and rh55_instit = rh02_instit where rh02_anousu = fc_anofolha([ESOCIAL_INSTITUICAO]) and rh02_mesusu = fc_mesfolha([ESOCIAL_INSTITUICAO]) and rh02_regist = [ESOCIAL_MATRICULA_SERVIDOR] and rh56_princ is true', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000268);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NOME_DEPENDENTE_1', 'Retorna o nome dos dependentes do servidor', 'select rh31_nome as nome from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 0 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000240);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NOME_DEPENDENTE_2', 'Retorna o nome dos dependentes do servidor', 'select rh31_nome as nome from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 1 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000332);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NOME_DEPENDENTE_3', 'Retorna o nome dos dependentes do servidor', 'select rh31_nome as nome from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 2 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000337);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NOME_DEPENDENTE_4', 'Retorna o nome dos dependentes do servidor', 'select rh31_nome as nome from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 3 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000342);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NOME_DEPENDENTE_5', 'Retorna o nome dos dependentes do servidor', 'select rh31_nome as nome from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 4 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000347);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NOME_DEPENDENTE_6', 'Retorna o nome dos dependentes do servidor', 'select rh31_nome as nome from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 5 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000352);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NOME_DEPENDENTE_7', 'Retorna o nome dos dependentes do servidor', 'select rh31_nome as nome from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 6 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000357);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NOME_DEPENDENTE_8', 'Retorna o nome dos dependentes do servidor', 'select rh31_nome as nome from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 7 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000362);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NOME_DEPENDENTE_9', 'Retorna o nome dos dependentes do servidor', 'select rh31_nome as nome from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 8 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000367);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NOME_DEPENDENTE_10', 'Retorna o nome dos dependentes do servidor', 'select rh31_nome as nome from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 9 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000372);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_DATA_NASCIMENTO_DEPENDENTE_1', 'Retorna a data de nascimento dos dependentes do servidor', 'select rh31_dtnasc as data_nascimento from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 0 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000241);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_DATA_NASCIMENTO_DEPENDENTE_2', 'Retorna a data de nascimento dos dependentes do servidor', 'select rh31_dtnasc as data_nascimento from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 1 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000333);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_DATA_NASCIMENTO_DEPENDENTE_3', 'Retorna a data de nascimento dos dependentes do servidor', 'select rh31_dtnasc as data_nascimento from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 2 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000338);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_DATA_NASCIMENTO_DEPENDENTE_4', 'Retorna a data de nascimento dos dependentes do servidor', 'select rh31_dtnasc as data_nascimento from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 3 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000343);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_DATA_NASCIMENTO_DEPENDENTE_5', 'Retorna a data de nascimento dos dependentes do servidor', 'select rh31_dtnasc as data_nascimento from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 4 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000348);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_DATA_NASCIMENTO_DEPENDENTE_6', 'Retorna a data de nascimento dos dependentes do servidor', 'select rh31_dtnasc as data_nascimento from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 5 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000353);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_DATA_NASCIMENTO_DEPENDENTE_7', 'Retorna a data de nascimento dos dependentes do servidor', 'select rh31_dtnasc as data_nascimento from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 6 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000358);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_DATA_NASCIMENTO_DEPENDENTE_8', 'Retorna a data de nascimento dos dependentes do servidor', 'select rh31_dtnasc as data_nascimento from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 7 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000363);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_DATA_NASCIMENTO_DEPENDENTE_9', 'Retorna a data de nascimento dos dependentes do servidor', 'select rh31_dtnasc as data_nascimento from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 8 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000368);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_DATA_NASCIMENTO_DEPENDENTE_10', 'Retorna a data de nascimento dos dependentes do servidor', 'select rh31_dtnasc as data_nascimento from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 9 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000373);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_SALARIO_FAMILIA_IRRF_DEPENDENTE_1', 'Retorna se o dependente do servidor é considerado para o cálculo de IRRF e salário família', 'select * from (select unnest(regexp_split_to_array(rh31_depend_rh31_irf, '','')) as salario_familia_irrf_dependente from (select case when rh31_depend <> ''N'' then 3001079 else 0 end||'',''||case when rh31_irf <> ''0'' then 3001081 else 0 end as rh31_depend_rh31_irf from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 0 limit 1 ) as dados ) as salario_familia_irrf where salario_familia_irrf_dependente::int > 0', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000233);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_SALARIO_FAMILIA_IRRF_DEPENDENTE_2', 'Retorna se o dependente do servidor é considerado para o cálculo de IRRF e salário família', 'select * from (select unnest(regexp_split_to_array(rh31_depend_rh31_irf, '','')) as salario_familia_irrf_dependente from (select case when rh31_depend <> ''N'' then 3001121 else 0 end||'',''||case when rh31_irf <> ''0'' then 3001120 else 0 end as rh31_depend_rh31_irf from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 1 limit 1 ) as dados ) as salario_familia_irrf where salario_familia_irrf_dependente::int > 0', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000330);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_SALARIO_FAMILIA_IRRF_DEPENDENTE_3', 'Retorna se o dependente do servidor é considerado para o cálculo de IRRF e salário família', 'select * from (select unnest(regexp_split_to_array(rh31_depend_rh31_irf, '','')) as salario_familia_irrf_dependente from (select case when rh31_depend <> ''N'' then 3001138 else 0 end||'',''||case when rh31_irf <> ''0'' then 3001137 else 0 end as rh31_depend_rh31_irf from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 2 limit 1 ) as dados ) as salario_familia_irrf where salario_familia_irrf_dependente::int > 0', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000335);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_SALARIO_FAMILIA_IRRF_DEPENDENTE_4', 'Retorna se o dependente do servidor é considerado para o cálculo de IRRF e salário família', 'select * from (select unnest(regexp_split_to_array(rh31_depend_rh31_irf, '','')) as salario_familia_irrf_dependente from (select case when rh31_depend <> ''N'' then 3001155 else 0 end||'',''||case when rh31_irf <> ''0'' then 3001154 else 0 end as rh31_depend_rh31_irf from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 3 limit 1 ) as dados ) as salario_familia_irrf where salario_familia_irrf_dependente::int > 0', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000340);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_SALARIO_FAMILIA_IRRF_DEPENDENTE_5', 'Retorna se o dependente do servidor é considerado para o cálculo de IRRF e salário família', 'select * from (select unnest(regexp_split_to_array(rh31_depend_rh31_irf, '','')) as salario_familia_irrf_dependente from (select case when rh31_depend <> ''N'' then 3001172 else 0 end||'',''||case when rh31_irf <> ''0'' then 3001171 else 0 end as rh31_depend_rh31_irf from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 4 limit 1 ) as dados ) as salario_familia_irrf where salario_familia_irrf_dependente::int > 0', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000345);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_SALARIO_FAMILIA_IRRF_DEPENDENTE_6', 'Retorna se o dependente do servidor é considerado para o cálculo de IRRF e salário família', 'select * from (select unnest(regexp_split_to_array(rh31_depend_rh31_irf, '','')) as salario_familia_irrf_dependente from (select case when rh31_depend <> ''N'' then 3001189 else 0 end||'',''||case when rh31_irf <> ''0'' then 3001188 else 0 end as rh31_depend_rh31_irf from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 5 limit 1 ) as dados ) as salario_familia_irrf where salario_familia_irrf_dependente::int > 0', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000350);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_SALARIO_FAMILIA_IRRF_DEPENDENTE_7', 'Retorna se o dependente do servidor é considerado para o cálculo de IRRF e salário família', 'select * from (select unnest(regexp_split_to_array(rh31_depend_rh31_irf, '','')) as salario_familia_irrf_dependente from (select case when rh31_depend <> ''N'' then 3001206 else 0 end||'',''||case when rh31_irf <> ''0'' then 3001205 else 0 end as rh31_depend_rh31_irf from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 6 limit 1 ) as dados ) as salario_familia_irrf where salario_familia_irrf_dependente::int > 0', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000355);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_SALARIO_FAMILIA_IRRF_DEPENDENTE_8', 'Retorna se o dependente do servidor é considerado para o cálculo de IRRF e salário família', 'select * from (select unnest(regexp_split_to_array(rh31_depend_rh31_irf, '','')) as salario_familia_irrf_dependente from (select case when rh31_depend <> ''N'' then 3001223 else 0 end||'',''||case when rh31_irf <> ''0'' then 3001222 else 0 end as rh31_depend_rh31_irf from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 7 limit 1 ) as dados ) as salario_familia_irrf where salario_familia_irrf_dependente::int > 0', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000360);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_SALARIO_FAMILIA_IRRF_DEPENDENTE_9', 'Retorna se o dependente do servidor é considerado para o cálculo de IRRF e salário família', 'select * from (select unnest(regexp_split_to_array(rh31_depend_rh31_irf, '','')) as salario_familia_irrf_dependente from (select case when rh31_depend <> ''N'' then 3001240 else 0 end||'',''||case when rh31_irf <> ''0'' then 3001239 else 0 end as rh31_depend_rh31_irf from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 8 limit 1 ) as dados ) as salario_familia_irrf where salario_familia_irrf_dependente::int > 0', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000365);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_SALARIO_FAMILIA_IRRF_DEPENDENTE_10', 'Retorna se o dependente do servidor é considerado para o cálculo de IRRF e salário família', 'select * from (select unnest(regexp_split_to_array(rh31_depend_rh31_irf, '','')) as salario_familia_irrf_dependente from (select case when rh31_depend <> ''N'' then 3001257 else 0 end||'',''||case when rh31_irf <> ''0'' then 3001256 else 0 end as rh31_depend_rh31_irf from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 9 limit 1 ) as dados ) as salario_familia_irrf where salario_familia_irrf_dependente::int > 0', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000370);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_TIPO_DEPENDENTE_1', 'Retorna o tipo de dependente do servidor', 'select case rh31_irf when ''2'' then ''3001088'' when ''3'' then ''3001090'' when ''4'' then ''3001106'' when ''5'' then ''3001107'' when ''6'' then ''3001100'' when ''7'' then ''3001101'' when ''8'' then ''3001103'' else case when rh31_gparen = ''C'' then ''3001085'' when rh31_irf = ''1'' then ''3001086'' else null end end as tipo_dependente from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 0 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000235);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_TIPO_DEPENDENTE_2', 'Retorna o tipo de dependente do servidor', 'select case rh31_irf when ''2'' then ''3001131'' when ''3'' then ''3001130'' when ''4'' then ''3001123'' when ''5'' then ''3001122'' when ''6'' then ''3001127'' when ''7'' then ''3001126'' when ''8'' then ''3001125'' else case when rh31_gparen = ''C'' then ''3001133'' when rh31_irf = ''1'' then ''3001132'' else null end end as tipo_dependente from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 1 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000331);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_TIPO_DEPENDENTE_3', 'Retorna o tipo de dependente do servidor', 'select case rh31_irf when ''2'' then ''3001148'' when ''3'' then ''3001147'' when ''4'' then ''3001140'' when ''5'' then ''3001139'' when ''6'' then ''3001144'' when ''7'' then ''3001143'' when ''8'' then ''3001142'' else case when rh31_gparen = ''C'' then ''3001150'' when rh31_irf = ''1'' then ''3001149'' else null end end as tipo_dependente from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 2 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000336);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_TIPO_DEPENDENTE_4', 'Retorna o tipo de dependente do servidor', 'select case rh31_irf when ''2'' then ''3001165'' when ''3'' then ''3001164'' when ''4'' then ''3001157'' when ''5'' then ''3001156'' when ''6'' then ''3001161'' when ''7'' then ''3001160'' when ''8'' then ''3001159'' else case when rh31_gparen = ''C'' then ''3001167'' when rh31_irf = ''1'' then ''3001166'' else null end end as tipo_dependente from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 3 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000341);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_TIPO_DEPENDENTE_5', 'Retorna o tipo de dependente do servidor', 'select case rh31_irf when ''2'' then ''3001182'' when ''3'' then ''3001181'' when ''4'' then ''3001174'' when ''5'' then ''3001173'' when ''6'' then ''3001178'' when ''7'' then ''3001177'' when ''8'' then ''3001176'' else case when rh31_gparen = ''C'' then ''3001184'' when rh31_irf = ''1'' then ''3001183'' else null end end as tipo_dependente from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 4 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000346);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_TIPO_DEPENDENTE_6', 'Retorna o tipo de dependente do servidor', 'select case rh31_irf when ''2'' then ''3001199'' when ''3'' then ''3001198'' when ''4'' then ''3001191'' when ''5'' then ''3001190'' when ''6'' then ''3001195'' when ''7'' then ''3001194'' when ''8'' then ''3001193'' else case when rh31_gparen = ''C'' then ''3001201'' when rh31_irf = ''1'' then ''3001200'' else null end end as tipo_dependente from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 5 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000351);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_TIPO_DEPENDENTE_7', 'Retorna o tipo de dependente do servidor', 'select case rh31_irf when ''2'' then ''3001216'' when ''3'' then ''3001215'' when ''4'' then ''3001208'' when ''5'' then ''3001207'' when ''6'' then ''3001212'' when ''7'' then ''3001211'' when ''8'' then ''3001210'' else case when rh31_gparen = ''C'' then ''3001218'' when rh31_irf = ''1'' then ''3001217'' else null end end as tipo_dependente from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 6 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000356);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_TIPO_DEPENDENTE_8', 'Retorna o tipo de dependente do servidor', 'select case rh31_irf when ''2'' then ''3001233'' when ''3'' then ''3001232'' when ''4'' then ''3001225'' when ''5'' then ''3001224'' when ''6'' then ''3001229'' when ''7'' then ''3001228'' when ''8'' then ''3001227'' else case when rh31_gparen = ''C'' then ''3001235'' when rh31_irf = ''1'' then ''3001234'' else null end end as tipo_dependente from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 7 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000361);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_TIPO_DEPENDENTE_9', 'Retorna o tipo de dependente do servidor', 'select case rh31_irf when ''2'' then ''3001250'' when ''3'' then ''3001249'' when ''4'' then ''3001242'' when ''5'' then ''3001241'' when ''6'' then ''3001246'' when ''7'' then ''3001245'' when ''8'' then ''3001244'' else case when rh31_gparen = ''C'' then ''3001252'' when rh31_irf = ''1'' then ''3001251'' else null end end as tipo_dependente from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 8 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000366);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_TIPO_DEPENDENTE_10', 'Retorna o tipo de dependente do servidor', 'select case rh31_irf when ''2'' then ''3001267'' when ''3'' then ''3001266'' when ''4'' then ''3001259'' when ''5'' then ''3001258'' when ''6'' then ''3001263'' when ''7'' then ''3001262'' when ''8'' then ''3001261'' else case when rh31_gparen = ''C'' then ''3001269'' when rh31_irf = ''1'' then ''3001268'' else null end end as tipo_dependente from rhdepend where (rh31_depend <> ''N'' or rh31_irf <> ''0'') and rh31_regist in (select rh01_regist from rhpessoal where rh01_numcgm = [CODIGO_CGM]) order by rh31_codigo offset 9 limit 1', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000371);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_DATA_NOMEACAO', 'Data da nomeaçãao do servidor', 'select case (select fc_executa_ddl(''select fc_putsession(\\''plugins_dataassentamento_nomeacao\\'', (select nomeacao from plugins.dataassentamento where matricula = [ESOCIAL_MATRICULA_SERVIDOR])::varchar)'')) when true then (select fc_getsession(''plugins_dataassentamento_nomeacao'')) else null end datas_nomeacao_posse_exercicio', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000323);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_DATA_POSSE', 'Data da posse do servidor', 'select case (select fc_executa_ddl(''select fc_putsession(\\''plugins_dataassentamento_posse\\'', (select posse from plugins.dataassentamento where matricula = [ESOCIAL_MATRICULA_SERVIDOR])::varchar)'')) when true then (select fc_getsession(''plugins_dataassentamento_posse'')) else null end datas_nomeacao_posse_exercicio', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000328);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_DATA_EXERCICIO', 'Data da exercício do servidor', 'select case (select fc_executa_ddl(''select fc_putsession(\\''plugins_dataassentamento_exercicio\\'', (select exercicio from plugins.dataassentamento where matricula = [ESOCIAL_MATRICULA_SERVIDOR])::varchar)'')) when true then (select fc_getsession(''plugins_dataassentamento_exercicio'')) else null end datas_nomeacao_posse_exercicio', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000329);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NOME_SERVIDOR', 'Retorna o nome do servidor', 'select z01_nome from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_NOME_SERVIDOR'), 3000226);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_CPF_SERVIDOR', 'Retorna o CPF do servidor', 'select z01_cgccpf from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_CPF_SERVIDOR'), 3000227);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_PIS_PASEP_SERVIDOR', 'Retorna o PIS/PASEP do servidor', 'select z01_pis from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_PIS_PASEP_SERVIDOR'), 3000228);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_SEXO_SERVIDOR', 'Retorna o SEXO do servidor', 'select case when rh01_sexo=\'M\' then  3000923 else 3000922 end  as sexo from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_SEXO_SERVIDOR'), 3000229);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_RACA_COR_SERVIDOR', 'Retorna a raça/cor do servidor', 'select case rh01_raca when  1 then 3000928 when 2 then  3000924 when 4 then 3000925 when 6 then 3000927 when 8 then 3000926 else 3000929 end from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_RACA_COR_SERVIDOR'), 3000230);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_ESTADO_CIVIL_SERVIDOR', 'Retorna o estado civil do servidor', 'select case rh01_estciv when  1 then 3000933 when 2 then 3000934 when 3 then 3000938 when 4 then 3000937 when 5 then 3000936 end from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_ESTADO_CIVIL_SERVIDOR'), 3000253);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_GRAU_INSTRUCAO_SERVIDOR', 'Retorna o grau de instrucao do servidor',
        'select case rh01_instru when  1 then 3000948 when 2 then 3000959 when 3 then 3000960 when 4 then 3000961 when 5 then  3000962 when 6 then 3000965 when 7 then 3000967 when 8 then 3000971 when 9 then 3000973 when 10 then 3000976 when 11 then 3000977 end from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_GRAU_INSTRUCAO_SERVIDOR'), 3000259);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_DATA_NASCIMENTO_SERVIDOR', 'Retorna a data de nascimento do servidor',
        'select z01_nasc as data_nascimento from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_DATA_NASCIMENTO_SERVIDOR'), 3000287);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NATURALIDADE_SERVIDOR', 'Retorna a d do servidor',
        'select z01_naturalidade from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_NATURALIDADE_SERVIDOR'), 3000289);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NOME_PAI_SERVIDOR', 'Retorna o nome do pai do servidor',
        'select z01_pai from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_NOME_PAI_SERVIDOR'), 3000296);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NOME_MAE_SERVIDOR', 'Retorna o nome do pai do servidor',
        'select z01_mae from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_NOME_MAE_SERVIDOR'), 3000294);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_IDENTIDADE_SERVIDOR', 'Retorna  a identidade do servidor',
        'select z01_ident from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_IDENTIDADE_SERVIDOR'), 3000314);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_ORGAO_EMISSOR_IDENTIDADE_SERVIDOR', 'Retorna o orgao emissor da identidade do servidor',
        'select z01_identorgao from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_ORGAO_EMISSOR_IDENTIDADE_SERVIDOR'), 3000317);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_DATA_EXPEDICAO_IDENTIDADE_SERVIDOR', 'Retorna a data de nascimento do servidor',
        'select z01_identdtexp from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_DATA_EXPEDICAO_IDENTIDADE_SERVIDOR'), 3000320);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NUMERO_CTPS_SERVIDOR', 'Retorna o número da CTPS do servidor',
        'select rh16_ctps_n from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm inner join rhpesdoc on rh16_regist = rh01_regist where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_NUMERO_CTPS_SERVIDOR'), 3000299);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_SERIE_CTPS_SERVIDOR', 'Retorna a serie da CTPS do servidor',
        'select rh16_ctps_s from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm inner join rhpesdoc on rh16_regist = rh01_regist where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_SERIE_CTPS_SERVIDOR'), 3000300);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_UF_CTPS_SERVIDOR', 'Retorna a serie da CTPS do servidor',
        'select rh16_ctps_uf from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm inner join rhpesdoc on rh16_regist = rh01_regist where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_UF_CTPS_SERVIDOR'), 3000305);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_NUMERO_CNH_SERVIDOR', 'Retorna o numero da CNH do servidor',
        'select rh16_carth_n from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm inner join rhpesdoc on rh16_regist = rh01_regist where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_NUMERO_CNH_SERVIDOR'), 3000298);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_VALIDADE_CNH_SERVIDOR', 'Retorna a validade da CNH do servidor',
        'select rh16_carth_val as rh16_carth_val from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm inner join rhpesdoc on rh16_regist = rh01_regist where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_VALIDADE_CNH_SERVIDOR'), 3000281);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_CATEGORIA_CNH_SERVIDOR', 'Retorna a categoria da CNH do servidor',
        'select r16_carth_cat from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm inner join rhpesdoc on rh16_regist = rh01_regist where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_CATEGORIA_CNH_SERVIDOR'), 3000291);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_ENDERECO_LOGRADOURO_SERVIDOR', 'Retorna o logradouro do servidor',
        'select z01_ender from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_ENDERECO_LOGRADOURO_SERVIDOR'), 3000273);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_ENDERECO_NUMERO_SERVIDOR', 'Retorna o logradouro do servidor',
        'select z01_numero from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_ENDERECO_NUMERO_SERVIDOR'), 3000276);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_ENDERECO_COMPLEMENTO_SERVIDOR', 'Retorna o logradouro do servidor',
        'select z01_compl from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_ENDERECO_COMPLEMENTO_SERVIDOR'), 3000263);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_ENDERECO_BAIRRO_SERVIDOR', 'Retorna o bairro do servidor',
        'select z01_bairro from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_ENDERECO_BAIRRO_SERVIDOR'), 3000270);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_ENDERECO_MUNICIPIO_SERVIDOR', 'Retorna o municipio do servidor',
        'select z01_munic from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_ENDERECO_MUNICIPIO_SERVIDOR'), 3000249);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_ENDERECO_CEP_SERVIDOR', 'Retorna o CEP do endereco do servidor',
        'select z01_cep from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_ENDERECO_CEP_SERVIDOR'), 3000251);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_ENDERECO_UF_SERVIDOR', 'Retorna a UF do endereco do servidor',
        'select z01_uf from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_ENDERECO_UF_SERVIDOR'), 3000258);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_ENDERECO_PAIS_SERVIDOR', 'Retorna a UF do endereco do servidor',
        'select db70_descricao
           from cgm
                inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm
                inner join cgmendereco on z07_numcgm = z01_numcgm
                inner join endereco on z07_endereco = db76_sequencial
                inner join cadenderlocal on db76_cadenderlocal = db75_sequencial
                inner join cadenderbairrocadenderrua on db75_cadenderbairrocadenderrua = db87_sequencial
                inner join cadenderbairro            on db87_cadenderbairro = db73_sequencial
                inner join cadendermunicipio         on db73_cadendermunicipio = db72_sequencial
                inner join cadenderestado            on db72_cadenderestado    = db71_sequencial
                inner join cadenderpais              on db71_cadenderpais      = db70_sequencial
          where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_ENDERECO_PAIS_SERVIDOR'), 3000247);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_FILIACAO_SINDICAL_SERVIDOR', 'Retorna a cpnj do sindicato do servidor',
        'select rh116_cnpj from rhpessoal inner join rhsindicato on rh01_rhsindicato = rh116_sequencial where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_FILIACAO_SINDICAL_SERVIDOR'), 3000234);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_TELEFONE_RESIDENCIAL_SERVIDOR', 'Retorna o telefone residencial do servidor',
        'select z01_telef from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_TELEFONE_RESIDENCIAL_SERVIDOR'), 3000272);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_TELEFONE_CELULAR_SERVIDOR', 'Retorna o telefone celular do servidor',
        'select z01_telcel from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_TELEFONE_CELULAR_SERVIDOR'), 3000274);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_EMAIL_SERVIDOR', 'Retorna o telefone celular do servidor',
        'select z01_email from cgm inner join rhpessoal on rhpessoal.rh01_numcgm = cgm.z01_numcgm where rh01_regist = [ESOCIAL_MATRICULA_SERVIDOR]', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_EMAIL_SERVIDOR'), 3000261);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_MATRICULA_CGM_SERVIDOR', 'Retorna a matricula do sindicato do servidor',
        'select [ESOCIAL_MATRICULA_SERVIDOR] as matricula', false);

INSERT INTO avaliacaoperguntadb_formulas (eso01_sequencial, eso01_db_formulas, eso01_avaliacaopergunta)
VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), (select db148_sequencial from db_formulas where db148_nome = 'ESOCIAL_MATRICULA_CGM_SERVIDOR'), 3000277);

--Ajuste no tipo de dados da pergunta Qualidade do Depentende no grupo de dependentes
UPDATE avaliacaopergunta SET db103_avaliacaotiporesposta=3, db103_avaliacaogrupopergunta=3000047, db103_descricao='Qualidade do Dependente:', db103_obrigatoria=true, db103_ativo=true, db103_ordem=1, db103_identificador='qualidade_dependente_1', db103_tipo=6, db103_mascara='' where db103_sequencial=3000233;
UPDATE avaliacaopergunta SET db103_avaliacaotiporesposta=3, db103_avaliacaogrupopergunta=3000048, db103_descricao='Qualidade do Dependente:', db103_obrigatoria=true, db103_ativo=true, db103_ordem=1, db103_identificador='qualidade_dependente_2', db103_tipo=6, db103_mascara='' where db103_sequencial=3000330;
UPDATE avaliacaopergunta SET db103_avaliacaotiporesposta=3, db103_avaliacaogrupopergunta=3000049, db103_descricao='Qualidade do Dependente:', db103_obrigatoria=true, db103_ativo=true, db103_ordem=1, db103_identificador='qualidade_dependente_3', db103_tipo=6, db103_mascara='' where db103_sequencial=3000335;
UPDATE avaliacaopergunta SET db103_avaliacaotiporesposta=3, db103_avaliacaogrupopergunta=3000050, db103_descricao='Qualidade do Dependente:', db103_obrigatoria=true, db103_ativo=true, db103_ordem=1, db103_identificador='qualidade_dependente_4',  db103_tipo=6, db103_mascara='' where db103_sequencial=3000340;
UPDATE avaliacaopergunta SET db103_avaliacaotiporesposta=3, db103_avaliacaogrupopergunta=3000051, db103_descricao='Qualidade do Dependente:', db103_obrigatoria=true, db103_ativo=true, db103_ordem=1, db103_identificador='qualidade_dependente_5',  db103_tipo=6, db103_mascara='' where db103_sequencial=3000345;
UPDATE avaliacaopergunta SET db103_avaliacaotiporesposta=3, db103_avaliacaogrupopergunta=3000052, db103_descricao='Qualidade do Dependente:', db103_obrigatoria=true, db103_ativo=true, db103_ordem=1, db103_identificador='qualidade_dependente_6',  db103_tipo=6, db103_mascara='' where db103_sequencial=3000350;
UPDATE avaliacaopergunta SET db103_avaliacaotiporesposta=3, db103_avaliacaogrupopergunta=3000053, db103_descricao='Qualidade do Dependente:', db103_obrigatoria=true, db103_ativo=true, db103_ordem=1, db103_identificador='qualidade_dependente_7',  db103_tipo=6, db103_mascara='' where db103_sequencial=3000355;
UPDATE avaliacaopergunta SET db103_avaliacaotiporesposta=3, db103_avaliacaogrupopergunta=3000054, db103_descricao='Qualidade do Dependente:', db103_obrigatoria=true, db103_ativo=true, db103_ordem=1, db103_identificador='qualidade_dependente_8',  db103_tipo=6, db103_mascara='' where db103_sequencial=3000360;
UPDATE avaliacaopergunta SET db103_avaliacaotiporesposta=3, db103_avaliacaogrupopergunta=3000055, db103_descricao='Qualidade do Dependente:', db103_obrigatoria=true, db103_ativo=true, db103_ordem=1, db103_identificador='qualidade_dependente_9',  db103_tipo=6, db103_mascara='' where db103_sequencial=3000365;
UPDATE avaliacaopergunta SET db103_avaliacaotiporesposta=3, db103_avaliacaogrupopergunta=3000056, db103_descricao='Qualidade do Dependente:', db103_obrigatoria=true, db103_ativo=true, db103_ordem=1, db103_identificador='qualidade_dependente_10', db103_tipo=6, db103_mascara='' where db103_sequencial=3000370;

--Menus para formulário de preenchimento das informações do empregador
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10244 ,'Informações do Empregador' ,'Informações do Empregador para o eSocial' ,'eso01_preenchimentoempregador.php' ,'1' ,'1' ,'Formulário para preenchimento das informações que serão enviadas ao eSocial referente ao estabelecimento empregador.' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 29 ,10244 ,270 ,10216 );

--Tabela de vínculo entre formulário de preenchimento das informações do empregador e cgm
insert into db_sysarquivo values (3943, 'avaliacaogruporespostacgm', 'Vinculo entre uma resposta de um conjunto de respostas do eSocial com um cgm para informações do estabelecimento do empregador.', '', '2016-05-24', 'Vinculo entre eSocial e cgm', 0, 'f', 'f', 't', 't' );
insert into db_sysarqmod values (81,3943);
update db_sysarquivo set nomearq = 'avaliacaogruporespostacgm', descricao = 'Vinculo entre uma resposta de um conjunto de respostas do eSocial com um cgm para informações do estabelecimento do empregador.', sigla = 'eso03', dataincl = '2016-05-24', rotulo = 'Vinculo entre eSocial e cgm', tipotabela = 0, naolibclass = 'f', naolibfunc = 'f', naolibprog = 't', naolibform = 't' where codarq = 3943;
insert into db_sysarqarq values(0,3943);

insert into db_syscampo values(21904,'eso03_sequencial','int4','Código do vínculo entre cgm e um conjunto de respostas do formulário do eSocial.','0', 'Código',19,'f','f','f',1,'text','Código');
insert into db_syscampo values(21905,'eso03_avaliacaogruporesposta','int4','Grupo de resposta que será vinculado.','0', 'Grupo Resposta',19,'f','f','f',1,'text','Grupo Resposta');
insert into db_syscampo values(21906,'eso03_cgm','int4','Cgm que respondeu o formulário.','0', 'CGM',19,'f','f','f',1,'text','CGM');

insert into db_sysarqcamp values(3943,21904,1,0);
insert into db_sysarqcamp values(3943,21905,2,0);
insert into db_sysarqcamp values(3943,21906,3,0);

insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3943,21904,1,21904);
insert into db_sysforkey values(3943,21905,1,2987,0);
insert into db_sysforkey values(3943,21906,1,42,0);

insert into db_syssequencia values(1000578, 'avaliacaogruporespostacgm_eso03_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000578 where codarq = 3943 and codcam = 21904;

ALTER TABLE avaliacaogrupopergunta ALTER COLUMN db102_descricao TYPE varchar(100);

--INSERE perguntas do empregador para o eSocial
INSERT INTO avaliacao VALUES (3000009, 5, 'e-Social S1000', '', true, 'e-Social S1000');
insert into avaliacaogrupopergunta (db102_sequencial, db102_avaliacao, db102_descricao, db102_identificador) values  (3000075, 3000009, 'Informações do Empregador', 'infoCadastro');
insert into avaliacaogrupopergunta (db102_sequencial, db102_avaliacao, db102_descricao, db102_identificador) values  (3000076, 3000009, 'Informações Fator Acidentário de Prevenção - FAP', 'infoFap');
insert into avaliacaogrupopergunta (db102_sequencial, db102_avaliacao, db102_descricao, db102_identificador) values  (3000077, 3000009, 'Processo Adm/judicial FAP', 'procAdmJudFap');
insert into avaliacaogrupopergunta (db102_sequencial, db102_avaliacao, db102_descricao, db102_identificador) values  (3000078, 3000009, 'Informações Complementares - Empresas Isentas', 'dadosIsencao');
insert into avaliacaogrupopergunta (db102_sequencial, db102_avaliacao, db102_descricao, db102_identificador) values  (3000079, 3000009, 'Informações de Contato', 'contato');
insert into avaliacaogrupopergunta (db102_sequencial, db102_avaliacao, db102_descricao, db102_identificador) values  (3000080, 3000009, 'Informações Organismos Internacionais e Instituições Extraterritoriais', 'infoOrgInternacional');
insert into avaliacaogrupopergunta (db102_sequencial, db102_avaliacao, db102_descricao, db102_identificador) values  (3000081, 3000009, 'Informações da Empresa de Software', 'softwareHouse');
insert into avaliacaogrupopergunta (db102_sequencial, db102_avaliacao, db102_descricao, db102_identificador) values  (3000083, 3000009, 'Informações Complementares', 'situacaoPJ');
insert into avaliacaogrupopergunta (db102_sequencial, db102_avaliacao, db102_descricao, db102_identificador) values  (3000085, 3000009, 'Informações Relativa a Órgãos de Regime Próprio de Previdência Social - RPPS', 'infoRPPS');
insert into avaliacaogrupopergunta (db102_sequencial, db102_avaliacao, db102_descricao, db102_identificador) values  (3000086, 3000009, 'Informações das Alíquotas do Ente Federativo', 'aliqEnteFed');
insert into avaliacaogrupopergunta (db102_sequencial, db102_avaliacao, db102_descricao, db102_identificador) values  (3000088, 3000009, 'Informações dos Limites Remuneratórios do Ente Federativo', 'limitesRem');
insert into avaliacaogrupopergunta (db102_sequencial, db102_avaliacao, db102_descricao, db102_identificador) values  (3000090, 3000009, 'Informações dos Entes Federativos com Regime Próprio de Previdência Social - RPPS', 'infEnteFed');

insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000376, 1, 3000075, 'Natureza Jurídica', false, true, 2, 'nat_juridica_empregador', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000380, 1, 3000075, 'Indicativo de Opção de Registro Eletrônico de Empregados', true, true, 3, 'ind_reg_eletronico_empregador', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000381, 1, 3000075, 'Utiliza mais de uma Tabela de Rubricas', false, true, 4, 'multiplas_tab_rubricasempregador', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000382, 2, 3000075, 'Número do SIAFI', false, true, 6, 'nro_siafi_empregador', 6, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000383, 2, 3000076, 'Fator Acidentário de Prevenção', true, true, 1, 'fap', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000384, 1, 3000077, 'Tipo do Processo Administrativo', true, true, 2, 'tipo_processo_administrativo_fap', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000385, 2, 3000077, 'Número do Processo Administrativo', true, true, 3, 'numero_processo_administrativo_fap', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000386, 1, 3000078, 'Identificação do Ministério/Lei que Concedeu o Certificado', true, true, 1, 'dados_isensao_sigla_ministerio', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000387, 2, 3000078, 'Número do Certificado/Portaria/Lei', false, true, 2, 'numero_certificado_lei_isencao', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000388, 2, 3000078, 'Data de Emissão do Certificado', true, true, 3, 'data_emissao_certificado_isencao', 5, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000389, 2, 3000078, 'Data de Vencimento do Certificado', true, true, 4, 'data_vencimento_certificado_isencao', 5, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000390, 2, 3000078, 'Número do Protocolo do Pedido de Renovação', false, true, 5, 'numero_protocolo_pedido_renovacao', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000391, 2, 3000078, 'Data do Protocolo de Renovação', false, true, 6, 'data_pedido_protocolo_renovacao', 5, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000392, 2, 3000078, 'Data da Publicação no Diário Oficial', false, true, 7, 'data_publicacao_isencao_dou', 5, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000393, 2, 3000078, 'Número da Página no Diário Oficial da União', false, true, 8, 'paginas_dou', 6, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000394, 2, 3000079, 'Nome do Contato', true, true, 1, 'nome_contato_empresa', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000395, 2, 3000079, 'CPF do Contato', true, true, 2, 'cpf_contato_empresa', 4, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000396, 2, 3000079, 'Telefone', false, true, 3, 'esocial_empregador_telefone_fixo', 7, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000397, 2, 3000079, 'Celular', false, true, 4, 'esocial_empregador_telefone_celular', 7, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000398, 2, 3000079, 'Email', false, true, 5, 'esocial_empregador_email', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000399, 1, 3000080, 'Acordo Internacional', true, true, 1, 'esocial_empregador_acordo_internacional', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000400, 2, 3000081, 'CNPJ Empresa', true, true, 1, 'cnpj_software_house', 3, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000401, 1, 3000085, 'Possui RPPS', true, true, 1, 'possui_rpps', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000402, 2, 3000090, 'UF', true, true, 1, 'uf_unidade_federativa', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000403, 2, 3000090, 'Código Município', false, true, 2, 'codigo_municipio', 6, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000404, 1, 3000086, 'Público Alvo da Alíquota', true, true, 1, 'publico_aliquota_aplicada', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000405, 2, 3000086, 'Informações Referente a Lei', false, true, 2, 'informacoes_lei_rpps', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000406, 2, 3000086, 'Percentual Segurado ou Beneficiário', false, true, 3, 'percentual_segurado_beneficiario_rpps', 8, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000407, 2, 3000086, 'Percentual Normal do Ente Federativo do RPPS', false, true, 4, 'percentual_normal_ente_federativo', 8, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000408, 2, 3000086, 'Percentual Alíquota da Contribuição Suplementar', true, true, 5, 'percentual_suplementar_ente_federativo_rpps', 8, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000409, 1, 3000088, 'Poder Referente do Subteto', true, true, 1, 'poder_limite_remuneratorio_ente', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000410, 2, 3000088, 'Valor do Subteto do Ente', true, true, 2, 'valor_limite_remunetaratorio_subteto_ente', 8, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000411, 2, 3000088, 'Idade Correspondente a Maioridade', false, true, 5, 'maioridade_anos_dependente_ente', 6, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000412, 1, 3000083, 'Indicação da Situação da Pessoa Jurídica', false, true, 1, 'situacaoPJ_pergunta', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000413, 1, 3000083, 'Indicação da Situação da Pessoa Física', false, true, 2, 'situacaoPF_pergunta', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000414, 2, 3000081, 'Nome/Razão Social', true, true, 1, 'nome_software_house', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000415, 2, 3000081, 'Contato', true, true, 2, 'contato_software_house', 1, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000416, 2, 3000081, 'Telefone', true, true, 3, 'telefone_software_house', 7, '');
insert into avaliacaopergunta (db103_sequencial, db103_avaliacaotiporesposta, db103_avaliacaogrupopergunta, db103_descricao,db103_obrigatoria, db103_ativo,  db103_ordem, db103_identificador, db103_tipo, db103_mascara) values  (3000417, 2, 3000081, 'E-mail', true, true, 4, 'email_software_house', 1, '');

insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001275, 3000376, '101-5 - Órgão Público do Poder Executivo Federal', false, 'nat_juridica_empregador_101_5', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001276, 3000376, '102-3 - Órgão Público do Poder Executivo Estadual ou do Distrito Federal', false, 'nat_juridica_empregador_102_3', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001277, 3000376, '103-1 - Órgão Público do Poder Executivo Municipal', false, 'nat_juridica_empregador_103_1', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001278, 3000376, '104-0 - Órgão Público do Poder Legislativo Federal', false, 'nat_juridica_empregador_104_0', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001279, 3000376, '105-8 - Órgão Público do Poder Legislativo Estadual ou do Distrito Federal', false, 'nat_juridica_empregador_105_8', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001280, 3000376, '106-6 - Órgão Público do Poder Legislativo Municipal', false, 'nat_juridica_empregador_106_6', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001281, 3000376, '107-4 - Órgão Público do Poder Judiciário Federal', false, 'nat_juridica_empregador_107_4', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001282, 3000376, '108-2 - Órgão Público do Poder Judiciário Estadual', false, 'nat_juridica_empregador_108_2', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001283, 3000376, '110-4 - Autarquia Federal', false, 'nat_juridica_empregador_110_4', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001284, 3000376, '111-2 - Autarquia Estadual ou do Distrito Federal', false, 'nat_juridica_empregador_111_2', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001285, 3000376, '112-0 - Autarquia Municipal', false, 'nat_juridica_empregador_112_0', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001286, 3000376, '113-9 - Fundação Pública de Direito Público Federal', false, 'nat_juridica_empregador_113_9', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001287, 3000376, '114-7 - Fundação Pública de Direito Público Estadual ou do Distrito Federal', false, 'nat_juridica_empregador_114_7', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001288, 3000376, '115-5 - Fundação Pública de Direito Público Municipal', false, 'nat_juridica_empregador_115_5', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001289, 3000376, '116-3 - Órgão Público Autônomo Federal', false, 'nat_juridica_empregador_116_3', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001290, 3000376, '117-1 - Órgão Público Autônomo Estadual ou do Distrito Federal', false, 'nat_juridica_empregador_117_1', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001291, 3000376, '118-0 - Órgão Público Autônomo Municipal', false, 'nat_juridica_empregador_118_0', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001292, 3000376, '119-8 - Comissão Polinacional', false, 'nat_juridica_empregador_119_8', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001293, 3000376, '120-1 - Fundo Público', false, 'nat_juridica_empregador_120_1', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001294, 3000376, '121-0 - Consórcio Público de Direito Público (Associação Pública)', false, 'nat_juridica_empregador_121_0', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001295, 3000376, '122-8 - Consórcio Público de Direito Privado', false, 'nat_juridica_empregador_122_8', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001296, 3000376, '123-6 - Estado ou Distrito Federal', false, 'nat_juridica_empregador_123_6', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001297, 3000376, '124-4 - Município', false, 'nat_juridica_empregador_124_4', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001298, 3000376, '125-2 - Fundação Pública de Direito Privado Federal', false, 'nat_juridica_empregador_125_2', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001299, 3000376, '126-0 - Fundação Pública de Direito Privado Estadual ou do Distrito Federal', false, 'nat_juridica_empregador_126_0', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001300, 3000376, '127-9 - Fundação Pública de Direito Privado Municipal', false, 'nat_juridica_empregador_127_9', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001309, 3000380, 'Não optou pelo registro eletrônico de empregados.', false, 'ind_reg_eletronico_empregador_0', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001310, 3000380, 'Optou pelo registro eletrônico de empregados.', false, 'ind_reg_eletronico_empregador_1', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001311, 3000381, 'Sim', false, 'multiplas_tab_rubricasempregador_1', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001312, 3000381, 'Não', false, 'multiplas_tab_rubricasempregador_0', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001313, 3000382, 'null', false, 'nro_siafi_empregador_0', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001314, 3000383, 'null', false, 'fap_0', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001315, 3000384, 'Administrativo', false, 'tipo_pocesso_fap_administrativo', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001316, 3000384, 'Judicial', false, 'tipo_pocesso_fap_judicial', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001317, 3000385, null, true, 'numero_processo_administrativo_fap_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001318, 3000387, null, true, 'numero_certificado_lei_isencao_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001319, 3000388, null, true, 'data_emissao_certificado_isencao_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001320, 3000389, null, true, 'data_vencimento_certificado_isencao_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001321, 3000390, null, true, 'numero_protocolo_pedido_renovacao_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001322, 3000391, null, true, 'data_pedido_protocolo_renovacao_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001323, 3000392, null, true, 'data_publicacao_isencao_dou_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001324, 3000386, 'CNAS - Conselho Nacional de Assistência Social', false, 'identificacao_ministerio_certificado_cnas', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001325, 3000386, 'MEC - Ministério da Educação', false, 'identificacao_ministerio_certificado_mec', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001326, 3000386, 'MS - Ministério da Saúde', false, 'identificacao_ministerio_certificado_ms', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001327, 3000386, 'MDS - Ministério do Desenvolvimento Social e Combate à Fome', false, 'identificacao_ministerio_certificado_mds', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001328, 3000386, 'LEI - Lei Específica.', false, 'identificacao_ministerio_certificado_lei', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001329, 3000393, null, true, 'paginas_dou', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001330, 3000394, null, true, 'nome_contato_empresa', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001331, 3000395, null, true, 'cpf_contato_empresa', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001332, 3000396, null, true, 'telefone_fixo', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001333, 3000397, null, true, 'telefone_celular', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001334, 3000398, null, true, 'email', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001335, 3000399, 'Sem Acordo', false, 'acordo_internacional_0', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001336, 3000399, 'Com Acordo', false, 'acordo_internacional_1', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001337, 3000400, null, true, 'cnpj_software_house', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001338, 3000408, null, true, 'percentual_suplementar_ente_rpps_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001339, 3000409, 'Executivo', false, 'poder_limite_remuneratorio_executivo', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001340, 3000409, 'Legislativo', false, 'poder_limite_remuneratorio_legislativo', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001341, 3000409, 'Judiciário', false, 'poder_limite_remuneratorio_judiciario', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001342, 3000409, 'Todos os poderes', false, 'poder_limite_remuneratorio_todos', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001343, 3000410, null, true, 'valor_limite_remuneratorio_subteto_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001344, 3000411, null, true, 'maioridade_anos_dependente_ente_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001345, 3000402, null, true, 'uf_unidade_federativa_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001346, 3000403, null, true, 'codigo_municipio_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001347, 3000401, 'Sim', false, 'possui_rpps_1', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001348, 3000401, 'Não', false, 'possui_rpps_0', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001349, 3000404, 'Servidor ativo', false, 'publico_aliquota_aplicada_1', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001350, 3000404, 'Aposentado', false, 'publico_aliquota_aplicada_2', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001351, 3000404, 'Aposentado por invalidez', false, 'publico_aliquota_aplicada_3', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001352, 3000404, 'Pensionista', false, 'publico_aliquota_aplicada_4', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001353, 3000404, 'Militar ativo (e o reformado)', false, 'publico_aliquota_aplicada_5', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001354, 3000404, 'Segurado diferenciado', false, 'publico_aliquota_aplicada_6', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001355, 3000405, null, true, 'informacoes_lei_rpps_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001356, 3000406, null, true, 'percentual_segurado_beneficiario_rpps_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001357, 3000407, null, true, 'percentual_normal_ente_federativo_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001358, 3000413, 'Normal', false, 'indSitPF_0', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001359, 3000413, 'Encerramento de espólio', false, 'indSitPF_1', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001360, 3000414, null, false, 'nome_software_house_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001361, 3000415, null, false, 'contato_software_house_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001362, 3000416, null, false, 'telefone_software_house_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001363, 3000417, null, false, 'email_software_house_resposta', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001364, 3000413, 'Saída do país em caráter permanente', false, 'indSitPF_2', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001365, 3000412, 'Normal', false, 'indSitPJ_0', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001366, 3000412, 'Extinção', false, 'indSitPJ_1', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001367, 3000412, 'Fusão', false, 'indSitPJ_2', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001368, 3000412, 'Cisão', false, 'indSitPJ_3', 0);
insert into avaliacaoperguntaopcao (db104_sequencial, db104_avaliacaopergunta, db104_descricao, db104_aceitatexto,db104_identificador, db104_peso) values  (3001369, 3000412, 'Incorporação', false, 'indSitPJ_4', 0);

INSERT INTO db_formulas (db148_sequencial, db148_nome, db148_descricao, db148_formula, db148_ambiente)
     VALUES (nextval('db_formulas_db148_sequencial_seq'), 'ESOCIAL_EMPREGADOR_FAP', 'Fator Acidentário de Prevenção', 'select r11_peactr from cfpess where r11_anousu = (select max(r11_anousu) from cfpess where r11_instit = [CODIGO_CGM]) and r11_mesusu = (select max(r11_mesusu) from cfpess where r11_instit = [CODIGO_CGM] and r11_anousu = (select max(r11_anousu) from cfpess where r11_instit = [CODIGO_CGM]))', false);
INSERT INTO avaliacaoperguntadb_formulas VALUES (nextval('avaliacaoperguntadb_formulas_eso01_sequencial_seq'), currval('db_formulas_db148_sequencial_seq'), 3000383);
----------------------------------------------------- FIM FOLHA -----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO SAÚDE ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
insert into db_sysarquivo values (3937, 'cgs_unddocumento', 'Documentos do Cadastro de CGS', 'sd108', '2016-05-17', 'Documentos', 0, 'f', 't', 't', 't' );
insert into db_sysarquivo values (3938, 'cgs_undendereco', 'Dados dos endereços vinculados ao CGS', 'sd109', '2016-05-17', 'Endereços do CGS', 0, 'f', 't', 't', 't' );

insert into db_sysarqmod values (1000004,3937);
insert into db_sysarqmod values (1000004,3938);

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel )
  values
  ( 21871 ,'sd109_sequencial' ,'int4' ,'Identificador da ligação' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' ),
  ( 21872 ,'sd109_endereco' ,'int4' ,'Código do Endereço' ,'' ,'Código do Endereço' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código do Endereço' ),
  ( 21873 ,'sd109_cgs_und' ,'int4' ,'Cadastro Geral Saúde.' ,'' ,'CGS' ,7 ,'false' ,'false' ,'false' ,1 ,'text' ,'CGS' ),
  ( 21874 ,'sd108_sequencial' ,'int4' ,'Identificador da Relação do DOcumento com o CGS' ,'' ,'Sequencial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Sequencial' ),
  ( 21875 ,'sd108_cgs_und' ,'int4' ,'Cadastro Geral Saúde.' ,'' ,'CGS' ,7 ,'false' ,'false' ,'false' ,1 ,'text' ,'CGS' ),
  ( 21876 ,'sd108_documento'  ,'int4' ,'Sequencial.' ,'' ,'Código Documento' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código Documento' );

insert into db_sysprikey (codarq,codcam,sequen,camiden)
  values
  (3938,21871,1,21872),
  (3937,21874,1,21874);

insert into db_sysindices
  values
  (4354,'cgs_undendereco_endereco_in',3938,'0'),
  (4355,'cgs_undendereco_cgs_und_in',3938,'0'),
  (4356,'cgs_unddocumento_documento_in',3937,'0'),
  (4357,'cgs_unddocumento_cgs_und_in',3937,'0');

insert into db_sysforkey
  values
  (3938,21872,1,2786,0),
  (3938,21873,1,1010144,0),
  (3937,21876,1,2920,0),
  (3937,21875,1,1010144,0);

insert into db_syscadind
  values
  (4354,21872,1),
  (4355,21873,1),
  (4356,21876,1),
  (4357,21875,1);


insert into db_syscampodep ( codcam ,codcampai )
  values
  ( 21872 ,15869 ),
  ( 21873 ,1008844 ),
  ( 21875 ,1008844 ),
  ( 21876 ,15676 );

insert into db_syssequencia
  values
  (1000571, 'cgs_unddocumento_sd108_sequencial_seq', 1, 1, 9223372036854775807, 1, 1),
  (1000572, 'cgs_undendereco_sd109_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);

insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia )
  values
  ( 3938 ,21871 ,1 ,1000572),
  ( 3938 ,21872 ,2 ,0 ),
  ( 3938 ,21873 ,3 ,0 ),
  ( 3937 ,21874 ,1 ,1000571),
  ( 3937 ,21875 ,2 ,0 ),
  ( 3937 ,21876 ,3 ,0 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente )
  values
  ( 10239 ,'Manutenção do CGS' ,'Manutenção do CGS' ,'sau1_manutencaocgs001.php' ,'1' ,'1' ,'Efetua manutenção do Cadastro geral da Saude' ,true);


delete from db_menu where id_item_filho = 1045399;

insert into db_menu(id_item ,id_item_filho ,menusequencia ,modulo )
  values
  (3470 ,10239 ,36,    6952),
  (3470 ,10239 ,37, 1000004),
  (3470 ,10239 ,38,    6877),
  (9049 ,10239 , 3,    9053),
  (8170 ,10239 ,17,    8167),
  (8323 ,10239 ,13,    8322),
  (8482 ,10239 , 4,    8481);

insert into cadtipodocumento values( 3, 'CGS' );
insert into caddocumento( db44_sequencial ,db44_descricao ,db44_cadtipodocumento ) values ( 3000000 ,'GERAIS' ,3 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 4 ,3000000 ,NULL ,'PIS/PASEP' ,'' ,1 ,11 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 5 ,3000000 ,NULL ,'DATA ENTRADA' ,'' ,3 ,10 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 29 ,3000000 ,NULL ,'CPF' ,'' ,1 ,14 );
insert into caddocumento( db44_sequencial ,db44_descricao ,db44_cadtipodocumento ) values ( 3000001 ,'IDENTIDADE' ,3 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 7 ,3000001 ,NULL ,'NÚMERO' ,'' ,1 ,20 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 8 ,3000001 ,NULL ,'DATA DE EMISSÃO' ,'' ,3 ,10 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 9 ,3000001 ,NULL ,'ÓRGÃO EMISSOR' ,'' ,1 ,100 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 10 ,3000001 ,NULL ,'UF' ,'' ,1 ,10 );
insert into caddocumento( db44_sequencial ,db44_descricao ,db44_cadtipodocumento ) values ( 3000002 ,'CTPS' ,3 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 11 ,3000002 ,NULL ,'NÚMERO' ,'' ,1 ,5 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 12 ,3000002 ,NULL ,'SÉRIE' ,'' ,1 ,20 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 13 ,3000002 ,NULL ,'DATA DE EMISSÃO' ,'' ,3 ,10 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 14 ,3000002 ,NULL ,'UF' ,'' ,1 ,5 );
insert into caddocumento( db44_sequencial ,db44_descricao ,db44_cadtipodocumento ) values ( 3000003 ,'CERTIDÃO' ,3 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 15 ,3000003 ,NULL ,'TIPO DE CERTIDÃO' ,'' ,1 ,1 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 16 ,3000003 ,NULL ,'LIVRO' ,'' ,1 ,20 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 17 ,3000003 ,NULL ,'TERMO' ,'' ,1 ,40 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 18 ,3000003 ,NULL ,'CARTÓRIO' ,'' ,1 ,30 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 19 ,3000003 ,NULL ,'FOLHA' ,'' ,1 ,20 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 20 ,3000003 ,NULL ,'DATA DA EMISSÃO' ,'' ,3 ,10 );
insert into caddocumento( db44_sequencial ,db44_descricao ,db44_cadtipodocumento ) values ( 3000004 ,'CNH' ,3 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 21 ,3000004 ,NULL ,'NÚMERO' ,'' ,1 ,20 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 22 ,3000004 ,NULL ,'CATEGORIA' ,'' ,1 ,2 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 23 ,3000004 ,NULL ,'DATA DE EMISSÃO' ,'' ,3 ,10 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 24 ,3000004 ,NULL ,'DATA HABILITAÇÃO' ,'' ,3 ,10 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 25 ,3000004 ,NULL ,'DATA DE VENCIMENTO' ,'' ,3 ,10 );
insert into caddocumento( db44_sequencial ,db44_descricao ,db44_cadtipodocumento ) values ( 3000005 ,'DADOS BANCÁRIOS' ,3 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 26 ,3000005 ,NULL ,'BANCO' ,'' ,1 ,40 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 27 ,3000005 ,NULL ,'AGÊNCIA' ,'' ,1 ,10 );
insert into caddocumentoatributo( db45_sequencial ,db45_caddocumento ,db45_codcam ,db45_descricao ,db45_valordefault ,db45_tipo ,db45_tamanho ) values ( 28 ,3000005 ,NULL ,'CONTA' ,'' ,1 ,10 );

insert into db_syscampo values(21901,'z01_orgaoemissoridentidade','varchar(100)','Órgão Emissor da Identidade','', 'Órgão Emissor da Identidade',100,'t','t','f',0,'text','Órgão Emissor da Identidade');
insert into db_sysarqcamp values(1010144,21901,79,0);

update db_syscampo set nomecam = 'z01_v_cxpostal', conteudo = 'varchar(50)', descricao = 'Caixa Postal', valorinicial = '', rotulo = 'Caixa Postal', nulo = 't', tamanho = 50, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Caixa Postal' where codcam = 11209;
update db_syscampo set nomecam = 'z33_v_nome', conteudo = 'varchar(255)', descricao = 'Nome', valorinicial = '', rotulo = 'Nome', nulo = 'f', tamanho = 255, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Nome' where codcam = 1008966;
----------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------- INICIO FINANCEIRO ------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
insert into db_sysarquivo values (3939, 'classificacaocredoreselemento', 'Tabela de vínculo com o plano orçamentário.', 'cc32', '2016-05-18', 'classificacaocredoreselemento', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (38,3939);
insert into db_syscampo values(21877,'cc32_sequencial','int4','Código','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21878,'cc32_classificacaocredores','int4','Classificação de Credores','0', 'Classificação de Credores',10,'f','f','f',1,'text','Classificação de Credores');
insert into db_syscampo values(21879,'cc32_codcon','int4','Conta','0', 'Conta',10,'f','f','f',1,'text','Conta');
insert into db_syscampo values(21883,'cc32_anousu','int4','Conta','0', 'Conta',10,'f','f','f',1,'text','Conta');
insert into db_syscampo values(21885,'cc32_exclusao','bool','Exclusão','','Exclusão',1,'false','false','false',5,'text','Exclusão');
insert into db_sysarqcamp values(3939,21877,1,0);
insert into db_sysarqcamp values(3939,21878,2,0);
insert into db_sysarqcamp values(3939,21879,3,0);
insert into db_sysarqcamp values(3939,21883,4,0);
insert into db_sysarqcamp values(3939,21885,5,0);
insert into db_syssequencia values(1000574, 'classificacaocredoreselemento_cc32_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000574 where codarq = 3939 and codcam = 21877;
delete from db_sysprikey where codarq = 3939;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3939,21877,1,21878);
delete from db_sysforkey where codarq = 3939 and referen = 0;
insert into db_sysforkey values(3939,21878,1,3878,0);
insert into db_sysforkey values(3939,21879,1,3268,0);
insert into db_sysforkey values(3939,21883,2,3268,0);


insert into db_sysarquivo values (3940, 'classificacaocredoresrecurso', 'Tabela de vínculo com o recurso.', 'cc33', '2016-05-18', 'classificacaocredoresrecurso', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (38,3940);
insert into db_syscampo values(21886,'cc33_sequencial','int4','Código','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21887,'cc33_classificacaocredores','int4','Classificação de Credores','0', 'Classificação de Credores',10,'f','f','f',1,'text','Classificação de Credores');
insert into db_syscampo values(21888,'cc33_orctiporec','int4','Recurso','0', 'Recurso',10,'f','f','f',1,'text','Recurso');
insert into db_sysarqcamp values(3940,21886,1,0);
insert into db_sysarqcamp values(3940,21887,2,0);
insert into db_sysarqcamp values(3940,21888,3,0);
insert into db_syssequencia values(1000575, 'classificacaocredoresrecurso_cc33_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000575 where codarq = 3940 and codcam = 21886;
delete from db_sysprikey where codarq = 3940;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3940,21886,1,21888);
delete from db_sysforkey where codarq = 3940 and referen = 0;
insert into db_sysforkey values(3940,21887,1,3878,0);
insert into db_sysforkey values(3940,21888,1,749,0);

insert into db_sysarquivo values (3941, 'classificacaocredorestipocompra', 'Tabela de vínculo com o Tipo de Compra.', 'cc34', '2016-05-19', 'classificacaocredorestipocompra', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (38,3941);
insert into db_syscampo values(21889,'cc34_sequencial','int4','Código','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21890,'cc34_classificacaocredores','int4','Classificação de Credores','0', 'Classificação de Credores',10,'f','f','f',1,'text','Classificação de Credores');
insert into db_syscampo values(21891,'cc34_pctipocompra','int4','Tipo de Compra','0', 'Tipo de Compra',10,'f','f','f',1,'text','Tipo de Compra');
insert into db_sysarqcamp values(3941,21889,1,0);
insert into db_sysarqcamp values(3941,21890,2,0);
insert into db_sysarqcamp values(3941,21891,3,0);
insert into db_syssequencia values(1000576, 'classificacaocredorestipocompra_cc34_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000576 where codarq = 3941 and codcam = 21889;
delete from db_sysprikey where codarq = 3941;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3941,21889,1,21891);
delete from db_sysforkey where codarq = 3941 and referen = 0;
insert into db_sysforkey values(3941,21890,1,3878,0);
insert into db_sysforkey values(3941,21891,1,866,0);

insert into db_sysarquivo values (3942, 'classificacaocredoresevento', 'Vinculo da classificação de credor com o tipo de evento do empenho.', 'cc35', '2016-05-19', 'classificacaocredoresevento', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (38,3942);
insert into db_syscampo values(21892,'cc35_sequencial','int4','Código','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21893,'cc35_classificacaocredores','int4','Código da Classificação de Credores','0', 'Classificação de Credores',10,'f','f','f',1,'text','Classificação de Credores');
insert into db_syscampo values(21894,'cc35_empprestatip','int4','Tipo de Evento','0', 'Tipo de Evento',10,'f','f','f',1,'text','Tipo de Evento');
delete from db_sysarqcamp where codarq = 3942;
insert into db_sysarqcamp values(3942,21892,1,0);
insert into db_sysarqcamp values(3942,21893,2,0);
insert into db_sysarqcamp values(3942,21894,3,0);
delete from db_sysprikey where codarq = 3942;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3942,21892,1,21893);
delete from db_sysforkey where codarq = 3942 and referen = 0;
insert into db_sysforkey values(3942,21893,1,3878,0);
delete from db_sysforkey where codarq = 3942 and referen = 0;
insert into db_sysforkey values(3942,21894,1,1038,0);
insert into db_syssequencia values(1000577, 'classificacaocredoresevento_cc35_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000577 where codarq = 3942 and codcam = 21892;

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21895 ,'cc30_contagemdias' ,'int4' ,'Vencimento em Dias' ,'' ,'Vencimento em Dias' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Vencimento em Dias' );
delete from db_syscampodef where codcam = 21895;
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21895 ,'1' ,'Úteis' );
insert into db_syscampodef ( codcam ,defcampo ,defdescr ) values ( 21895 ,'2' ,'Corridos' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3878 ,21895 ,3 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21896 ,'cc30_diasvencimento' ,'int4' ,'Quantidade de Dias para o Vencimento' ,'' ,'Quantidade de Dias para o Vencimento' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Quantidade de Dias para o Vencimento' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3878 ,21896 ,4 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21897 ,'cc30_valorinicial' ,'float4' ,'Valor Inicial' ,'' ,'Valor Inicial' ,50 ,'true' ,'false' ,'false' ,4 ,'text' ,'Valor Inicial' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3878 ,21897 ,5 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21898 ,'cc30_valorfinal' ,'float4' ,'Valor Final' ,'' ,'Valor Final' ,50 ,'true' ,'false' ,'false' ,4 ,'text' ,'Valor Final' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3878 ,21898 ,6 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21899 ,'cc30_dispensa' ,'bool' ,'Lista do Tipo Dispensa' ,'false' ,'Lista do Tipo Dispensa' ,1 ,'false' ,'false' ,'false' ,5 ,'text' ,'Lista do Tipo Dispensa' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3878 ,21899 ,7 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21900 ,'cc30_ordem' ,'int4' ,'Ordem' ,'' ,'Ordem' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Ordem' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3878 ,21900 ,8 ,0 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10240 ,'Lista de Classificação de Credores' ,'Cadastro de Lista de Classificação de Credores' ,'' ,'1' ,'1' ,'Cadastro de Lista de Classificação de Credores' ,'true' );
delete from db_menu where id_item_filho = 10240 AND modulo = 398;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 29 ,10240 ,269 ,398 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10241 ,'Inclusão' ,'Inclusão de Lista de Classificação de Credores' ,'emp1_classificacaocredores001.php?opcao=1' ,'1' ,'1' ,'Inclusão de Lista de Classificação de Credores' ,'true' );
delete from db_menu where id_item_filho = 10241 AND modulo = 398;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10240 ,10241 ,1 ,398 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10242 ,'Alteração' ,'Alteração de Lista de Classificação de Credores' ,'emp1_classificacaocredores001.php?opcao=2' ,'1' ,'1' ,'Alteração de Lista de Classificação de Credores' ,'true' );
delete from db_menu where id_item_filho = 10242 AND modulo = 398;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10240 ,10242 ,2 ,398 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10243 ,'Exclusão' ,'Exclusão de Lista de Classificação de Credores' ,'emp1_classificacaocredores001.php?opcao=3' ,'1' ,'1' ,'Exclusão de Lista de Classificação de Credores' ,'true' );
delete from db_menu where id_item_filho = 10243 AND modulo = 398;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10240 ,10243 ,3 ,398 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10245 ,'Ordenar' ,'Ordenar' ,'emp1_classificacaocredoresordenacao001.php' ,'1' ,'1' ,'Ordenar Classificação de Credores' ,'true' );
delete from db_menu where id_item_filho = 10245 AND modulo = 398;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10240 ,10245 ,4 ,398 );

update db_syscampo set codcam = 3347 , nomecam = 'o15_codigo' , conteudo = 'int4' , descricao = 'Codigo do Tipo de Recurso' , valorinicial = '0' , rotulo = 'Recurso' , tamanho = 10 , nulo = 'false' , maiusculo = 'false' , autocompl = 'false' , aceitatipo = 1 , tipoobj = 'text' , rotulorel = 'Recurso' where codcam = 3347;
update db_syscampo set codcam = 3348 , nomecam = 'o15_descr' , conteudo = 'varchar(60)' , descricao = 'Descrição do Recurso' , rotulo = 'Descrição do Recurso' , tamanho = 60 , nulo = 'false' , maiusculo = 'true' , autocompl = 'false' , aceitatipo = 0 , tipoobj = 'text' , rotulorel = 'Tipo de Recurso' where codcam = 3348;
update db_syscampo set codcam = 5526 , nomecam = 'pc50_codcom' , conteudo = 'int4' , descricao = 'Código do Tipo de Compra.' , valorinicial = '0' , rotulo = 'Tipo de Compra' , tamanho = 4 , nulo = 'false' , maiusculo = 'false' , autocompl = 'false' , aceitatipo = 1 , tipoobj = 'text' , rotulorel = 'Código' where codcam = 5526;
update db_syscampo set codcam = 5527 , nomecam = 'pc50_descr' , conteudo = 'varchar(50)' , descricao = 'Descrição do Tipo de Compra.' , rotulo = 'Descrição do Tipo de Compra' , tamanho = 50 , nulo = 'false' , maiusculo = 'true' , autocompl = 'false' , aceitatipo = 0 , tipoobj = 'text' , rotulorel = 'Descrição' where codcam = 5527;
update db_syscampo set codcam = 6356 , nomecam = 'e44_descr' , conteudo = 'varchar(40)' , descricao = 'Descrição do Evento' , rotulo = 'Descrição do Evento' , tamanho = 40 , nulo = 'false' , maiusculo = 'true' , autocompl = 'false' , aceitatipo = 0 , tipoobj = 'text' , rotulorel = 'Descrição do Evento' where codcam = 6356;


select fc_executa_ddl('
  insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10246 ,\'Manutenção de Licitações Enviadas\' ,\'Manutenção de Licitações Enviadas\' ,\'lic4_manutencaolicitacoesenviadas001.php\',1 ,1 ,\'Manutenção de Licitações Enviadas\' ,\'true\' );
  delete from db_menu where id_item_filho = 10246 AND modulo = 381;
  insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10212 ,10246 ,3 ,381 );
');

select fc_executa_ddl('
  insert into db_sysarquivo values (3944, \'cgmestrangeiro\', \'Informações para um CGM estrangeiro\', \'z09\', \'2016-06-10\', \'CGM Estrangeiro\', 0, \'f\', \'f\', \'f\', \'f\' );
  insert into db_sysarqmod values (4,3944);
  insert into db_syscampo values(21907,\'z09_sequencial\',\'int4\',\'Código\',\'0\', \'Código\',10,\'f\',\'f\',\'f\',1,\'text\',\'Código\');
  insert into db_syscampo values(21908,\'z09_numcgm\',\'int4\',\'Código do CGM\',\'0\', \'Código do CGM\',10,\'f\',\'f\',\'f\',1,\'text\',\'Código do CGM\');
  insert into db_syscampo values(21909,\'z09_documento\',\'varchar(30)\',\'Documento\',\'\', \'Documento\',30,\'f\',\'t\',\'f\',0,\'text\',\'Documento\');
  delete from db_sysarqcamp where codarq = 3944;
  insert into db_sysarqcamp values(3944,21907,1,0);
  insert into db_sysarqcamp values(3944,21908,2,0);
  insert into db_sysarqcamp values(3944,21909,3,0);
  delete from db_sysforkey where codarq = 3944 and referen = 0;
  insert into db_sysforkey values(3944,21908,1,42,0);
  delete from db_sysprikey where codarq = 3944;
  insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3944,21907,1,21908);
  insert into db_sysindices values(4358,\'cgmestrangeiro_numcgm_in\',3944,\'0\');
  insert into db_syscadind values(4358,21908,1);
  insert into db_syssequencia values(1000579, \'cgmestrangeiro_z09_sequencial_seq\', 1, 1, 9223372036854775807, 1, 1);
  update db_sysarqcamp set codsequencia = 1000579 where codarq = 3944 and codcam = 21907;
');


