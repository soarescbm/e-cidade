insert into db_sysarquivo values (3961, 'transferencialote', 'Guarda os dados da transferência realizada em lote de matrículas concluídas.', 'ed137', '2016-09-01', 'Transferência em Lote', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (1008004,3961);
insert into db_syscampo values(22013,'ed137_sequencial','int4','Código do lote de transferência.','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(22014,'ed137_escolaorigem','int4','Escola de origem na qual está realizando a transferência.','0', 'Escola de Origem',10,'f','f','f',1,'text','Escola de Origem');
insert into db_syscampo values(22015,'ed137_usuario','int4','Usuário que realizou a transferência.','0', 'Usuário',10,'f','f','f',1,'text','Usuário');
insert into db_syscampo values(22016,'ed137_escolarede','bool','Define se é uma escola da Rede ou de Fora.','true', 'Tipo de Escola',1,'f','f','f',5,'text','Tipo de Escola');
insert into db_syscampo values(22017,'ed137_escola','int4','Escola de destino da transferência do aluno. Pode tanto ser uma escola da Rede quanto uma escola de Fora.','0', 'Escola',10,'f','f','f',1,'text','Escola');
insert into db_syscampo values(22018,'ed137_data','varchar(20)','Data da realização da transferência.','', 'Data',20,'f','t','f',0,'text','Data');
insert into db_sysarqcamp values(3961,22013,1,0);
insert into db_sysarqcamp values(3961,22014,2,0);
insert into db_sysarqcamp values(3961,22015,3,0);
insert into db_sysarqcamp values(3961,22016,4,0);
insert into db_sysarqcamp values(3961,22017,5,0);
insert into db_sysarqcamp values(3961,22018,6,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3961,22013,1,22013);
insert into db_sysforkey values(3961,22014,1,1010031,0);
insert into db_sysforkey values(3961,22015,1,109,0);
insert into db_sysindices values(4379,'transferencialote_ed137_sequencial_seq',3961,'0');
insert into db_syscadind values(4379,22013,1);
insert into db_syssequencia values(1000596, 'transferencialote_ed137_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000596 where codarq = 3961 and codcam = 22013;

insert into db_sysarquivo values (3962, 'transferencialotematricula', 'Guarda as matrículas que foram transferidas no lote.', 'ed138', '2016-09-01', 'Matrículas do Lote de Transferência', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (1008004,3962);
insert into db_syscampo values(22019,'ed138_sequencial','int4','Código','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(22020,'ed138_transferencialote','int4','Vínculo com o lote de transferência.','0', 'Transferência em Lote',10,'f','f','f',1,'text','Transferência em Lote');
insert into db_syscampo values(22021,'ed138_matricula','int4','Vínculo com a matrícula do aluno.','0', 'Matrícula',10,'f','f','f',1,'text','Matrícula');
insert into db_sysarqcamp values(3962,22019,1,0);
insert into db_sysarqcamp values(3962,22020,2,0);
insert into db_sysarqcamp values(3962,22021,3,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3962,22019,1,22019);
insert into db_sysforkey values(3962,22020,1,3961,0);
insert into db_sysforkey values(3962,22021,1,1010112,0);
insert into db_sysindices values(4380,'transferencialotematricula_ed138_sequencial_seq',3962,'0');
insert into db_syscadind values(4380,22019,1);
insert into db_syssequencia values(1000597, 'transferencialotematricula_ed138_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000597 where codarq = 3962 and codcam = 22019;

select fc_executa_ddl('
CREATE SEQUENCE transferencialote_ed137_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1');

CREATE TABLE IF NOT EXISTS transferencialote (
  ed137_sequencial   int4 NOT NULL,
  ed137_escolaorigem int4 NOT NULL,
  ed137_usuario      int4 NOT NULL,
  ed137_escolarede   bool NOT NULL default 'true',
  ed137_escola       int4 NOT NULL,
  ed137_data         timestamp default now(),
  CONSTRAINT transferencialote_sequ_pk PRIMARY KEY (ed137_sequencial),
  CONSTRAINT transferencialote_escolaorigem_fk FOREIGN KEY (ed137_escolaorigem) REFERENCES escola.escola(ed18_i_codigo),
  CONSTRAINT transferencialote_usuario_fk FOREIGN KEY (ed137_usuario) REFERENCES configuracoes.db_usuarios(id_usuario)
);

select fc_executa_ddl('CREATE SEQUENCE transferencialotematricula_ed138_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1');

CREATE TABLE IF NOT EXISTS transferencialotematricula(
  ed138_sequencial          int4 NOT NULL,
  ed138_transferencialote   int4 NOT NULL,
  ed138_matricula           int4 NOT NULL,
  CONSTRAINT transferencialotematricula_sequ_pk PRIMARY KEY (ed138_sequencial),
  CONSTRAINT transferencialotematricula_matricula_fk FOREIGN KEY (ed138_matricula) REFERENCES escola.matricula(ed60_i_codigo),
  CONSTRAINT transferencialotematricula_transferencialote_fk FOREIGN KEY (ed138_transferencialote) REFERENCES transferencialote(ed137_sequencial)
);


insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10287 ,'Transferência de Alunos Encerrados ' ,'Transferência de Alunos Encerrados ' ,'' ,'1' ,'1' ,'Transferência de Alunos Encerrados ' ,'true' );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10288 ,'Transferir' ,'Transferir aluno' ,'edu4_transferiralunoencerrado001.php' ,'1' ,'1' ,'Transferir alunos encerrados' ,'true' );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10289 ,'Cancelar' ,'Cancelar transferência' ,'edu4_anulartransferenciaalunoencerrado001.php' ,'1' ,'1' ,'Cancelar transferência de alunos encerrados' ,'true' );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10290 ,'Guia de Transferência - Alunos Encerrados' ,'Guia de Transferência - Alunos Encerrados' ,'edu2_guiatransferenciaencerrados001.php' ,'1' ,'1' ,'Guia de Transferência - Alunos Encerrados' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values (1101100, 10287, 5, 1100747);
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values (10287,   10288, 1, 1100747);
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values (10287,   10289, 2, 1100747);
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values (1101189, 10290, 5, 1100747);
