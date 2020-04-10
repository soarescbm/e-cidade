---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
drop table if exists upx_db_sysarquivo;
drop table if exists upx_db_sysarqmod;
drop table if exists upx_db_syscampo;
drop table if exists upx_db_sysarqcamp;
drop table if exists upx_db_sysprikey;
drop table if exists upx_db_sysindices;
drop table if exists upx_db_syscadind;
drop table if exists upx_db_syssequencia;
drop table if exists upx_db_itensmenu;
drop table if exists upx_db_menu;
drop table if exists upx_db_processa;
drop table if exists upx_db_arquivos;
drop table if exists upx_db_itensfilho;
drop table if exists t_db_layoutcampos;
drop table if exists w_agua_db_sysarquivo;
drop table if exists w_agua_db_sysarqmod;
drop table if exists w_agua_db_syscampo;
drop table if exists w_agua_db_sysarqcamp;
drop table if exists w_agua_db_sysprikey;
drop table if exists w_agua_db_syssequencia;
drop table if exists w_agua_db_sysforkey;
drop table if exists w_agua_db_itensmenu;
drop table if exists w_agua_db_menu;
drop table if exists w_up_5208_db_itensmenu;
drop table if exists w_up_5208_db_menu;
drop table if exists w_up_6896_db_syscampo;
drop table if exists w_up_6896_db_sysarqcamp;
drop table if exists w_up_6896_db_syscampodef;
drop table if exists w_up_6991_db_syscampo;
drop table if exists w_up_6991_db_sysarqcamp;


create temporary table upx_db_sysarquivo   as select * from db_sysarquivo limit 0;
       insert into upx_db_sysarquivo
       values (3960, 'tipoassunto', 'Cadastro para os tipos de assunto da biblioteca', 'bi30', '2016-08-31', 'Tipo de Assunto', 0, 'f', 'f', 'f', 'f'),
              (3961, 'transferencialote', 'Guarda os dados da transferência realizada em lote de matrículas concluídas.', 'ed137', '2016-09-01', 'Transferência em Lote', 0, 'f', 'f', 'f', 'f' ),
              (3962, 'transferencialotematricula', 'Guarda as matrículas que foram transferidas no lote.', 'ed138', '2016-09-01', 'Matrículas do Lote de Transferência', 0, 'f', 'f', 'f', 'f' );

insert into db_sysarquivo
select * from upx_db_sysarquivo
 where not exists ( select 1 from db_sysarquivo where db_sysarquivo.codarq = upx_db_sysarquivo.codarq);


create temporary table upx_db_sysarqmod as select * from db_sysarqmod limit 0;
       insert into upx_db_sysarqmod
       values (1008002, 3960),
              (1008004,3961),
              (1008004,3962);

insert into db_sysarqmod
select * from upx_db_sysarqmod
 where not exists ( select 1 from db_sysarqmod where db_sysarqmod.codarq = upx_db_sysarqmod.codarq);

create temporary table upx_db_syscampo as select * from db_syscampo limit 0;
       insert into upx_db_syscampo
       values (22011,'bi30_sequencial','int4','PK','0', 'Código',10,'f','f','f',1,'text','Código'),
              (22012,'bi30_descricao','text','Descrição do assunto.','', 'Descrição',1,'f','t','f',0,'text','Descrição'),
              (22013,'ed137_sequencial','int4','Código do lote de transferência.','0', 'Código',10,'f','f','f',1,'text','Código'),
              (22014,'ed137_escolaorigem','int4','Escola de origem na qual está realizando a transferência.','0', 'Escola de Origem',10,'f','f','f',1,'text','Escola de Origem'),
              (22015,'ed137_usuario','int4','Usuário que realizou a transferência.','0', 'Usuário',10,'f','f','f',1,'text','Usuário'),
              (22016,'ed137_escolarede','bool','Define se é uma escola da Rede ou de Fora.','true', 'Tipo de Escola',1,'f','f','f',5,'text','Tipo de Escola'),
              (22017,'ed137_escola','int4','Escola de destino da transferência do aluno. Pode tanto ser uma escola da Rede quanto uma escola de Fora.','0', 'Escola',10,'f','f','f',1,'text','Escola'),
              (22018,'ed137_data','varchar(20)','Data da realização da transferência.','', 'Data',20,'f','t','f',0,'text','Data'),
              (22019,'ed138_sequencial','int4','Código','0', 'Código',10,'f','f','f',1,'text','Código'),
              (22020,'ed138_transferencialote','int4','Vínculo com o lote de transferência.','0', 'Transferência em Lote',10,'f','f','f',1,'text','Transferência em Lote'),
              (22021,'ed138_matricula','int4','Vínculo com a matrícula do aluno.','0', 'Matrícula',10,'f','f','f',1,'text','Matrícula');


insert into db_syscampo
select * from upx_db_syscampo
 where not exists ( select 1 from db_syscampo where db_syscampo.codcam = upx_db_syscampo.codcam);

create temporary table upx_db_sysarqcamp as select * from db_sysarqcamp limit 0;
insert into upx_db_sysarqcamp
       values (3960,22011,1,0),
              (3960,22012,2,0),
              (3961,22013,1,0),
              (3961,22014,2,0),
              (3961,22015,3,0),
              (3961,22016,4,0),
              (3961,22017,5,0),
              (3961,22018,6,0),
              (3962,22019,1,0),
              (3962,22020,2,0),
              (3962,22021,3,0);

insert into db_sysarqcamp
  select * from upx_db_sysarqcamp
   where not exists ( select 1 from db_sysarqcamp where db_sysarqcamp.codcam = upx_db_sysarqcamp.codcam);

create temporary table upx_db_sysprikey as select * from db_sysprikey limit 0;
insert into upx_db_sysprikey
       values (3960,22011,1,22012),
              (3961,22013,1,22013),
              (3962,22019,1,22019);

insert into db_sysprikey
  select * from upx_db_sysprikey
   where not exists ( select 1 from db_sysprikey where db_sysprikey.codcam = upx_db_sysprikey.codcam);

create temporary table upx_db_sysindices as select * from db_sysindices limit 0;
insert into upx_db_sysindices
       values (4378,'tipoassunto_descricao_in',3960,'0'),
              (4379,'transferencialote_ed137_sequencial_seq',3961,'0'),
              (4380,'transferencialotematricula_ed138_sequencial_seq',3962,'0');

insert into db_sysindices
  select * from upx_db_sysindices
   where not exists ( select 1 from db_sysindices where db_sysindices.codarq = upx_db_sysindices.codarq);

create temporary table upx_db_syscadind as select * from db_syscadind limit 0;
insert into upx_db_syscadind
       values (4378,22012,1),
              (4379,22013,1),
              (4380,22019,1);

insert into db_syscadind
  select * from upx_db_syscadind
   where not exists ( select 1 from db_syscadind where db_syscadind.codcam = upx_db_syscadind.codcam);


create temporary table upx_db_syssequencia as select * from db_syssequencia limit 0;
insert into upx_db_syssequencia
       values (1000595, 'tipoassunto_bi30_sequencial_seq', 1, 1, 9223372036854775807, 1, 1),
              (1000596, 'transferencialote_ed137_sequencial_seq', 1, 1, 9223372036854775807, 1, 1),
              (1000597, 'transferencialotematricula_ed138_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);

insert into db_syssequencia
  select * from upx_db_syssequencia
   where not exists ( select 1 from db_syssequencia where db_syssequencia.codsequencia = upx_db_syssequencia.codsequencia);

update db_sysarqcamp set codsequencia = 1000595 where codarq = 3960 and codcam = 22011;
update db_sysarqcamp set codsequencia = 1000596 where codarq = 3961 and codcam = 22013;
update db_sysarqcamp set codsequencia = 1000597 where codarq = 3962 and codcam = 22019;

-- menu
create temporary table upx_db_itensmenu as select * from db_itensmenu limit 0;
insert into upx_db_itensmenu
       values (10282, 'Tipos de Assunto', 'Tipos de Assunto', '', '1', 1, 'Cadastro de Tipos de Assunto', 't'),
              (10283, 'Inclusão', 'Inclusão de Tipos de Assunto', 'bib1_tipoassunto001.php', '1', 1, 'Inclusão de Tipos de Assunto', 't'),
              (10284, 'Alteração', 'Alteração de Tipos de Assunto', 'bib1_tipoassunto002.php', '1', 1, 'Alteração de Tipos de Assunto', 't'),
              (10285, 'Exclusão', 'Exclusão de Tipos de Assunto', 'bib1_tipoassunto003.php', '1', 1, 'Exclusão de Tipos de Assunto', 't'),
              (10287, 'Transferência de Alunos Encerrados ' ,'Transferência de Alunos Encerrados ' ,'' ,'1' ,'1' ,'Transferência de Alunos Encerrados ' ,'true' ),
              (10288, 'Transferir' ,'Transferir aluno' ,'edu4_transferiralunoencerrado001.php' ,'1' ,'1' ,'Transferir alunos encerrados' ,'true' ),
              (10289, 'Cancelar' ,'Cancelar transferência' ,'edu4_anulartransferenciaalunoencerrado001.php' ,'1' ,'1' ,'Cancelar transferência de alunos encerrados' ,'true' ),
              (10290, 'Guia de Transferência - Alunos Encerrados' ,'Guia de Transferência - Alunos Encerrados' ,'edu2_guiatransferenciaencerrados001.php' ,'1' ,'1' ,'Guia de Transferência - Alunos Encerrados' ,'true' ),
              (10304 ,'Rotinas de Implantação' ,'Rotinas de Implantação' ,'Rotinas de Implantação' ,'1' ,'1' ,'Rotinas de implantação possui cadastros base para as escolas.' ,'true' );

insert into db_itensmenu
  select * from upx_db_itensmenu
   where not exists (select 1 from db_itensmenu where db_itensmenu.id_item = upx_db_itensmenu.id_item);

create temporary table upx_db_menu as select * from db_menu limit 0;
insert into upx_db_menu
       values (3470, 10282, 1, 1100625),
              (10282, 10283, 1, 1100625),
              (10282, 10284, 1, 1100625),
              (10282, 10285, 1, 1100625),
              (1101100, 10287, 5, 1100747 ),
              (10287, 10288, 1, 1100747 ),
              (10287, 10289, 2, 1100747 ),
              (1101189, 10290, 5, 1100747 ),
              (3470 ,10304 ,39 ,7159 ),
              (10304 ,1100849 ,1 ,7159 ),
              (1100849 ,1100850 ,4 ,7159 ),
              (1100849 ,1100851 ,5 ,7159 ),
              (1100849 ,1100852 ,6 ,7159 );

insert into db_menu
  select * from upx_db_menu
   where not exists( select 1 from db_menu
                      where db_menu.id_item       = upx_db_menu.id_item
                        and db_menu.id_item_filho = upx_db_menu.id_item_filho
                        and db_menu.modulo        = upx_db_menu.modulo);

create temporary table upx_db_processa as select * from db_processa limit 0;
insert into upx_db_processa
       values (3960, 10285),
              (3960, 10282),
              (3960, 10283),
              (3960, 10284);

insert into db_processa
  select * from upx_db_processa
   where not exists ( select 1 from db_processa where db_processa.id_item = upx_db_processa.id_item);

create temporary table upx_db_arquivos as select * from db_arquivos limit 0;
insert into upx_db_arquivos
       values (5858, 'bib1_tipoassunto001.php', 'Inclusão: Cadastro para os tipos de assunto da biblioteca'),
              (5860, 'bib1_tipoassunto003.php', 'Inclusão: Cadastro para os tipos de assunto da biblioteca'),
              (5861, 'db_func_tipoassunto.php', 'Arquivo com os campos para a função da tabela : Tipos de Assunto'),
              (5862, 'func_tipoassunto.php', 'Função de consulta aos dados da tabela : Tipos de Assunto'),
              (5863, 'db_frmtipoassunto.php', 'Formulario utilizado para a tabela : Tipos de Assunto'),
              (5859, 'bib1_tipoassunto002.php', 'Inclusão: Cadastro para os tipos de assunto da biblioteca');

insert into db_arquivos
  select * from upx_db_arquivos
  where not exists (select 1 from db_arquivos  where db_arquivos.codfilho = upx_db_arquivos.codfilho );

create temporary table upx_db_itensfilho as select * from db_itensfilho limit 0;
insert into upx_db_itensfilho
values (10285, 5860),
       (10283, 5858),
       (10284, 5859),
       (10283, 5861),
       (10284, 5861),
       (10285, 5861),
       (10283, 5862),
       (10284, 5862),
       (10285, 5862),
       (10283, 5863),
       (10284, 5863),
       (10285, 5863);

insert into db_itensfilho
  select * from upx_db_itensfilho
   where not exists (select 1 from db_itensfilho where db_itensfilho.id_item = upx_db_itensfilho.id_item );


---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------- INICIO FINANCEIRO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL FINANCEIRO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
--------------------------------------- INICIO TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

create temporary table t_db_layoutcampos as select * from db_layoutcampos limit 0;
insert into t_db_layoutcampos
values ( 14801 ,56 ,'cpfcnpj_proprietario' ,'CPF/CNPJ PROPRIETARIO' ,13 ,4616 ,'' ,14 ,'f' ,'t' ,'e' ,'' ,0 ),
       ( 14802 ,56 ,'nosso_numero' ,'NOSSO NUMERO' ,13 ,4630 ,'' ,20 ,'f' ,'t' ,'d' ,'' ,0 );
insert into db_layoutcampos
  select * from t_db_layoutcampos
    where not exists (select 1 from db_layoutcampos where db_layoutcampos.db52_codigo = t_db_layoutcampos.db52_codigo);

drop table if exists w_agua_db_sysarquivo;
create temporary table w_agua_db_sysarquivo   as select * from db_sysarquivo   limit 0;

drop table if exists w_agua_db_sysarqmod;
create temporary table w_agua_db_sysarqmod    as select * from db_sysarqmod    limit 0;

drop table if exists w_agua_db_syscampo;
create temporary table w_agua_db_syscampo     as select * from db_syscampo     limit 0;

drop table if exists w_agua_db_sysarqcamp;
create temporary table w_agua_db_sysarqcamp   as select * from db_sysarqcamp   limit 0;

drop table if exists w_agua_db_sysprikey;
create temporary table w_agua_db_sysprikey    as select * from db_sysprikey    limit 0;

drop table if exists w_agua_db_syssequencia;
create temporary table w_agua_db_syssequencia as select * from db_syssequencia limit 0;

drop table if exists w_agua_db_sysforkey;
create temporary table w_agua_db_sysforkey    as select * from db_sysforkey    limit 0;

drop table if exists w_agua_db_itensmenu;
create temporary table w_agua_db_itensmenu    as select * from db_itensmenu    limit 0;

drop table if exists w_agua_db_menu;
create temporary table w_agua_db_menu         as select * from db_menu         limit 0;

insert into w_agua_db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10306 ,'Cadastro de Contratos' ,'Cadastro de Contratos' ,'' ,'1' ,'1' ,'Cadastro de Contratos' ,'true' );
insert into w_agua_db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 3470 ,10306 ,41 ,4555 );

insert into w_agua_db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10307 ,'Inclusão' ,'Inclusão de contrato' ,'agu1_aguacontrato001.php?iOpcao=1' ,'1' ,'1' ,'Inclusão de contrato' ,'true' );
insert into w_agua_db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10306 ,10307 ,1 ,4555 );

insert into w_agua_db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10308 ,'Alteração' ,'Alteração de contrato' ,'agu1_aguacontrato001.php?iOpcao=2' ,'1' ,'1' ,'Alteração de contrato' ,'true' );
insert into w_agua_db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10306 ,10308 ,2 ,4555 );

insert into w_agua_db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10309 ,'Exclusão' ,'Exclusão de contrato' ,'agu1_aguacontrato001.php?iOpcao=3' ,'1' ,'1' ,'Exclusão de contrato' ,'true' );
insert into w_agua_db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10306 ,10309 ,3 ,4555 );

insert into w_agua_db_sysarquivo values (3966, 'aguacontrato', 'Contrato para fornecimento de água e esgoto.', 'x54', '2016-09-15', 'Contrato', 0, 'f', 'f', 'f', 'f' );
insert into w_agua_db_sysarqmod values (43,3966);

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22031 ,'x54_sequencial' ,'int4' ,'Código do Contrato' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3966 ,22031 ,1 ,0 );

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22032 ,'x54_aguabase' ,'int4' ,'Matrícula' ,'' ,'Matrícula' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Matrícula' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3966 ,22032 ,2 ,0 );

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22033 ,'x54_diavencimento' ,'int4' ,'Dia de vencimento das faturas.' ,'' ,'Dia de Vencimento' ,2 ,'true' ,'false' ,'false' ,1 ,'text' ,'Dia de Vencimento' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3966 ,22033 ,3 ,0 );

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22034 ,'x54_datavalidadecadastro' ,'date' ,'Data de validade do cadastro social, caso o contratante seja beneficiado por desconto da categoria Residencial Social.' ,'' ,'Validade do Cadastro Social' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Validade do Cadastro Social' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3966 ,22034 ,4 ,0 );

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22035 ,'x54_datainicial' ,'date' ,'Data de início do contrato.' ,'' ,'Data Inicial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Data Inicial' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3966 ,22035 ,5 ,0 );

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22036 ,'x54_datafinal' ,'date' ,'Data de encerramento do contrato.' ,'' ,'Data FInal' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Data FInal' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3966 ,22036 ,6 ,0 );

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22040 ,'x54_nis' ,'varchar(20)' ,'Número NIS' ,'' ,'NIS' ,20 ,'true' ,'false' ,'false' ,1 ,'text' ,'NIS' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3966 ,22040 ,7 ,0 );

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22041 ,'x54_cgm' ,'int4' ,'CGM' ,'' ,'CGM' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'CGM' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3966 ,22041 ,8 ,0 );

insert into w_agua_db_sysprikey (codarq,codcam,sequen,camiden) values(3966,22031,1,22031);

insert into w_agua_db_syssequencia values(1000600, 'aguacontrato_x54_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update w_agua_db_sysarqcamp set codsequencia = 1000600 where codarq = 3966 and codcam = 22031;

insert into w_agua_db_sysforkey values(3966,22032,1,1426,0);
insert into w_agua_db_sysforkey values(3966,22041,1,42,0);

-- Ligação
insert into w_agua_db_sysarquivo values (3968, 'aguacontratoligacao', 'Vincula hidrômetro com contrato.', 'x55', '2016-09-15', 'Ligação de Água', 0, 'f', 'f', 'f', 'f' );
insert into w_agua_db_sysarqmod values (43,3968);

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22037 ,'x55_sequencial' ,'int4' ,'Código sequencial.' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3968 ,22037 ,1 ,0 );

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22038 ,'x55_aguahidromatric' ,'int4' ,'Hidrômetro' ,'' ,'Hidrômetro' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Hidrômetro' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3968 ,22038 ,2 ,0 );

insert into w_agua_db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 22039 ,'x55_aguacontrato' ,'int4' ,'Contrato.' ,'' ,'Contrato' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Contrato' );
insert into w_agua_db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3968 ,22039 ,3 ,0 );

insert into w_agua_db_sysprikey (codarq,codcam,sequen,camiden) values(3968,22037,1,22037);

-- FK Hidrômetro
insert into w_agua_db_sysforkey values(3968,22038,1,1421,0);

-- FK Contato
insert into w_agua_db_sysforkey values(3968,22039,1,3966,0);

insert into w_agua_db_syssequencia values(1000601, 'aguacontratoligacao_x55_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update w_agua_db_sysarqcamp set codsequencia = 1000601 where codarq = 3968 and codcam = 22037;

-- Removida obrigatoriedade da Matrícula no Cadastro de Hidrômetro
update w_agua_db_syscampo set nulo = 'true' where codcam = 8432;

-- # Agua Categoria Consumo
insert into w_agua_db_sysarquivo
  values (3969, 'aguacategoriaconsumo', 'Categoria de Consumo', 'x13', '2016-09-22', 'Categoria de Consumo', 0, 'f', 'f', 'f', 'f' );

insert into w_agua_db_sysarqmod
  values (43, 3969);

insert into w_agua_db_syscampo
  values ( 22042 ,'x13_sequencial' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' ),
         ( 22043 ,'x13_exercicio' ,'int4' ,'Exercício' ,'' ,'Exercício' ,4 ,'false' ,'false' ,'false' ,1 ,'text' ,'Exercicio' ),
         ( 22044 ,'x13_descricao' ,'varchar(100)' ,'Descrição da Categoria' ,'' ,'Descrição' ,100 ,'false' ,'false' ,'false' ,0 ,'text' ,'Descrição' );

insert into w_agua_db_sysarqcamp
  values ( 3969 ,22042 ,1 ,0 ),
         ( 3969 ,22043 ,2 ,0 ),
         ( 3969 ,22044 ,3 ,0 );

insert into w_agua_db_syssequencia values (1000602, 'aguacategoriaconsumo_x13_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update w_agua_db_sysarqcamp set codsequencia = 1000602 where codarq = 3969 and codcam = 22042;
insert into w_agua_db_sysprikey values (3969,22042,1,22042);

-- # Agua Estrutura Tarifaria
insert into w_agua_db_sysarquivo
  values (3972, 'aguaestruturatarifaria', 'Estrutura Tarifária', 'x37', '2016-09-22', 'Estrutura Tarifária', 0, 'f', 'f', 'f', 'f' );

insert into w_agua_db_sysarqmod
  values (43, 3972);

insert into w_agua_db_syscampo
  values ( 22063 ,'x37_sequencial' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' ),
         ( 22064 ,'x37_aguaconsumotipo' ,'int4' ,'Código Tipo de Consumo' ,'' ,'Código Tipo de Consumo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código Tipo de Consumo' ),
         ( 22065 ,'x37_tipoestrutura' ,'int4' ,'Tipo de Estrutura' ,'' ,'Tipo de Estrutura' ,2 ,'false' ,'false' ,'false' ,1 ,'text' ,'Tipo de Estrutura' ),
         ( 22066 ,'x37_valorinicial' ,'int4' ,'Valor Inicial do Intervalo' ,'0' ,'Valor Inicial' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Valor Inicial' ),
         ( 22067 ,'x37_valorfinal' ,'int4' ,'Valor Final do Intervalo' ,'0' ,'Valor Final' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Valor Final' ),
         ( 22068 ,'x37_valor' ,'float4' ,'Valor' ,'0' ,'Valor' ,10 ,'true' ,'false' ,'false' ,4 ,'text' ,'Valor' ),
         ( 22069 ,'x37_percentual' ,'float4' ,'Percentual' ,'0' ,'Percentual' ,10 ,'true' ,'false' ,'false' ,4 ,'text' ,'Percentual' ),
         ( 22075 ,'x37_aguacategoriaconsumo' ,'int4' ,'Código da Categoria de Consumo' ,'' ,'Código da Categoria de Consumo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código da Categoria de Consumo' );

insert into w_agua_db_sysarqcamp
  values ( 3972 ,22063 ,1 ,0 ),
         ( 3972 ,22064 ,2 ,0 ),
         ( 3972 ,22065 ,3 ,0 ),
         ( 3972 ,22066 ,4 ,0 ),
         ( 3972 ,22067 ,5 ,0 ),
         ( 3972 ,22068 ,6 ,0 ),
         ( 3972 ,22069 ,7 ,0 ),
         ( 3972 ,22075 ,8 ,0 );

insert into w_agua_db_sysforkey
  values (3972, 22075, 1, 3969, 0);

-- # Agua Contrato < Agua Categoria Consumo
insert into w_agua_db_syscampo
  values ( 22074 ,'x54_aguacategoriaconsumo' ,'int4' ,'Código da Categoria de Consumo' ,'' ,'Código da Categoria de Consumo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código da Categoria de Consumo' );
insert into w_agua_db_sysarqcamp
  values ( 3966 ,22074 ,9 ,0 );
insert into w_agua_db_sysforkey
  values (3966, 22074, 1, 3969, 0);

insert into w_agua_db_syssequencia values (1000607, 'aguaestruturatarifaria_x37_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update w_agua_db_sysarqcamp set codsequencia = 1000607 where codarq = 3972 and codcam = 22063;

insert into w_agua_db_sysprikey values (3972, 22063, 1, 22063);
insert into w_agua_db_sysforkey values (3972, 22064, 1, 1445, 0);

-- # Menu Categorias de Consumo
insert into w_agua_db_itensmenu
  values ( 10316 ,'Categorias de Consumo' ,'Inclusão, Alteração e Exclusão de Categorias de Consumo' ,'' ,'1' ,'1' ,'Inclusão, Alteração e Exclusão de Categorias de Consumo Usadas Para o Calculo de Água e Esgoto.' ,'true' ),
         ( 10317 ,'Inclusão' ,'Inclusão de Categorias de Consumo' ,'agu4_aguacategoriaconsumo001.php?iOpcao=1' ,'1' ,'1' ,'Inclusão de Categorias de Consumo' ,'true' ),
         ( 10318 ,'Alteração' ,'Alteração de Categorias de Consumo' ,'agu4_aguacategoriaconsumo001.php?iOpcao=2' ,'1' ,'1' ,'Alteração de Categorias de Consumo' ,'true' ),
         ( 10319 ,'Exclusão' ,'Exclusão de Categorias de Consumo' ,'agu4_aguacategoriaconsumo001.php?iOpcao=3' ,'1' ,'1' ,'Exclusão de Categorias de Consumo' ,'true' );

insert into w_agua_db_menu
  values ( 4615 ,10316 ,6 ,4555 ),
         ( 10316 ,10317 ,1 ,4555 ),
         ( 10316 ,10318 ,2 ,4555 ),
         ( 10316 ,10319 ,3 ,4555 );

insert into db_itensmenu
  select * from w_agua_db_itensmenu    where not exists(select 1 from db_itensmenu where w_agua_db_itensmenu.id_item = db_itensmenu.id_item);

insert into db_menu
  select * from w_agua_db_menu         where not exists(select 1 from db_menu where w_agua_db_menu.id_item = db_menu.id_item and w_agua_db_menu.id_item_filho = db_menu.id_item_filho);

insert into db_sysarquivo
  select * from w_agua_db_sysarquivo   where not exists(select 1 from db_sysarquivo where w_agua_db_sysarquivo.codarq = db_sysarquivo.codarq);

insert into db_sysarqmod
  select * from w_agua_db_sysarqmod    where not exists(select 1 from db_sysarqmod where db_sysarqmod.codarq = w_agua_db_sysarqmod.codarq);

insert into db_syscampo
  select * from w_agua_db_syscampo     where not exists(select 1 from db_syscampo where db_syscampo.codcam = w_agua_db_syscampo.codcam);

insert into db_sysarqcamp
  select * from w_agua_db_sysarqcamp   where not exists(select 1 from db_sysarqcamp where db_sysarqcamp.codcam = w_agua_db_sysarqcamp.codcam);

insert into db_sysprikey
  select * from w_agua_db_sysprikey    where not exists(select 1 from db_sysprikey where db_sysprikey.codcam = w_agua_db_sysprikey.codcam);

insert into db_syssequencia
  select * from w_agua_db_syssequencia where not exists(select 1 from db_syssequencia where db_syssequencia.codsequencia = w_agua_db_syssequencia.codsequencia);

insert into db_sysforkey
  select * from w_agua_db_sysforkey    where not exists(select 1 from db_sysforkey where db_sysforkey.codcam = w_agua_db_sysforkey.codcam);

select fc_executa_ddl('
  insert into db_layouttxt values (261, \'IMPORTAÇÃO CNPJS TSE\', 0, \'\', 1 );
  insert into db_layoutlinha values (861, 261, \'HEADER\', 1, 0, 0, 0, \'\', \'\', false );
  insert into db_layoutlinha values (862, 261, \'DETALHE\', 3, 0, 0, 0, \'\', \'\', false );
  insert into db_layoutlinha values (863, 261, \'TRAILER\', 5, 0, 0, 0, \'\', \'\', false );
  insert into db_layoutcampos values (14806, 861, \'registro\', \'IDENTIFICADOR DO REGISTRO. FIXO 1\', 2, 1, \'1\', 1, true, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14807, 861, \'data_geracao\', \'DATA E HORA DA GERAÇÃO. \', 1, 2, \'\', 12, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14808, 861, \'versao_leiaute\', \'VERSÃO DO ARQUIVO DE CNPJS. FIXO 100\', 2, 14, \'100\', 3, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14809, 861, \'nome_leiaute\', \'NOME DO LEIAUTE. FIXO CNPJPREST\', 1, 17, \'CNPJPREST\', 10, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14810, 861, \'espacos_branco\', \'PREENCHIMENTO COM ESPAÇOS EM BRANCO\', 1, 27, \'\', 174, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14811, 862, \'registro\', \'IDENTIFICADOR DO REGISTRO. FIXO 2\', 2, 1, \'2\', 1, true, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14812, 862, \'tipo_prestador_contas\', \'01 – PARTIDO 02 - CANDIDATO\', 2, 2, \'\', 2, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14813, 862, \'cnpj\', \'CNPJ DO PRESTADOR DE CONTAS\', 2, 4, \'\', 14, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14814, 862, \'nome_prestador_contas\', \'NOME FISCAL DO PRESTADOR DE CONTAS\', 1, 18, \'\', 150, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14815, 862, \'natureza_juridica\', \'NATUREZA JURÍDICA DO CNPJ\', 1, 168, \'\', 4, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14816, 862, \'cnae_principal\', \'CÓDIGO NACIONAL DE ATIVIDADE ECONÔMICA\', 1, 172, \'\', 7, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14817, 862, \'espacos_branco\', \'PREENCHIDO COM ESPAÇOS EM BRANCO\', 1, 179, \'\', 10, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14818, 862, \'data_insercao_cnpj\', \'DATA E HORA DA INSERÇÃO DO CNPJ NO ARQUI\', 1, 189, \'\', 12, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14819, 863, \'registro\', \'IDENTIFICADOR DO REGISTRO. FIXO 9\', 2, 1, \'9\', 1, true, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14820, 863, \'total_cnpjs\', \'QUANTIDADE TOTAL DE CNPJ´S  DO ARQUIVO.\', 2, 2, \'\', 9, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14821, 863, \'espacos_branco\', \'PREENCHER COM ESPAÇOS EM BRANCO\', 1, 11, \'\', 190, false, true, \'d\', \'\', 0 );
');

select fc_executa_ddl('
  insert into db_layouttxt values (262, \'EXPORTAÇÃO NFES TSE\', 0, \'\', 1 );
  insert into db_layoutlinha values (864, 262, \'HEADER\', 1, 0, 0, 0, \'\', \'\', false );
  insert into db_layoutlinha values (865, 262, \'DETALHE\', 3, 0, 0, 0, \'\', \'\', false );
  insert into db_layoutlinha values (866, 262, \'TRAILER\', 5, 0, 0, 0, \'\', \'\', false );
  insert into db_layoutcampos values (14822, 864, \'registro\', \'IDENTIFICADOR DO REGISTRO HEADER. FIXO 1\', 2, 1, \'1\', 1, true, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14823, 864, \'uf\', \'UF DA PREFEITURA, GOVERNO OU SEFAZ\', 1, 2, \'\', 2, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14824, 864, \'cnpj\', \'CNPJ DA PREFEITURA, GOVERNO OU SEFAZ\', 1, 4, \'\', 14, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14825, 864, \'data_processamento\', \'DATA DO PROCESSAMENTO\', 1, 18, \'\', 8, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14826, 864, \'numero_notificacao\', \'NUMERO NOTIFICAÇÃO GERADA PELO TSE\', 1, 26, \'\', 10, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14827, 864, \'numero_remessa\', \'ANO E MÊS REFERENTE À GERAÇÃO DA REMESSA\', 1, 36, \'\', 6, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14828, 864, \'numero_lote_remessa\', \'NÚMERO IDENTIFICADOR DO LOTE DA REMESSA\', 1, 42, \'\', 4, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14829, 864, \'numero_remessa_correcao\', \'ANO E MÊS REFERENTE À REMESSA CORRIGIDA\', 1, 46, \'\', 6, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14830, 864, \'numero_lote_remessa_correcao\', \'NUM DO LOTE DA REMESSA A SER CORRIGIDA\', 1, 52, \'\', 4, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14831, 864, \'versao_leiaute\', \'VERSÃO DO ARQUIVO DE NFES. FIXO 110\', 2, 56, \'110\', 3, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14832, 864, \'nome_leiaute\', \'NOME DO LEIAUTE. FIXO ATSENFE\', 1, 59, \'ATSENFE\', 7, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14833, 864, \'espaco_branco\', \'PREENCHER COM ESPAÇOS EM BRANCO\', 1, 66, \'\', 331, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14834, 865, \'registro\', \'IDENTIFICADOR DO REGISTRO\', 2, 1, \'2\', 1, true, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14835, 865, \'uf\', \'UF DA NOTA FISCAL\', 1, 2, \'\', 2, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14836, 865, \'cnpj_destinatario\', \'CNPJ DO CANDIDATO/DIREÇÃO PARTIDÁRIA\', 1, 4, \'\', 14, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14837, 865, \'tipo_pessoa_emitente\', \'FÍSICA (F) OU JURÍDICA (J)\', 1, 18, \'\', 1, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14838, 865, \'cnpj_cpf_emitente\', \'NÚMERO DO CNPJ OU CPF DO EMITENTE\', 1, 19, \'\', 14, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14839, 865, \'natureza_operacao\', \'VENDA, SERVIÇO OU DOAÇÃO\', 1, 33, \'\', 4, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14840, 865, \'modelo_nota_fiscal\', \'CÓDIGO QUE IDENTIFICA O MODELO DA NF\', 1, 37, \'\', 2, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14841, 865, \'data_emissao\', \'DATA DE EMISSÃO DA NOTA FISCAL\', 1, 39, \'\', 8, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14842, 865, \'serie_nfe\', \'SÉRIE DA NOTA FISCAL\', 1, 47, \'\', 3, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14843, 865, \'numero_nfe\', \'NÚMERO DA NOTA FISCAL\', 1, 50, \'\', 15, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14844, 865, \'numero_nfe_substituida\', \'NÚMERO DA NF SUBSTITUÍDA OU CANCELADA\', 1, 65, \'\', 15, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14845, 865, \'valor_total_nfe\', \'VALOR TOTAL DA NOTA FISCAL\', 1, 80, \'\', 17, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14846, 865, \'chave_acesso_nfe\', \'CHAVE DE ACESSO DA NOTA FISCAL\', 1, 97, \'\', 50, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14847, 865, \'url_acesso_nfe\', \'ENDEREÇO ELETRÔNICO PARA ACESSO À NFE\', 1, 147, \'\', 250, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14848, 866, \'registro\', \'IDENTIFICADOR DO REGISTRO. FIXO 9\', 2, 1, \'9\', 1, true, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14849, 866, \'total_nfe\', \'TOTAL DE NFES PRESENTES NO LOTE\', 1, 2, \'\', 9, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14850, 866, \'checksum\', \'CÁLCULO DE TODAS AS LINHAS DO DETALHE\', 1, 11, \'\', 32, false, true, \'d\', \'\', 0 );
  insert into db_layoutcampos values (14851, 866, \'espaco_branco\', \'PREENCHER COM ESPAÇOS EM BRANCO\', 1, 43, \'\', 354, false, true, \'d\', \'\', 0 );
');

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO FOLHA ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL FOLHA ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO SAUDE ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
create temporary table w_up_5208_db_itensmenu as select * from db_itensmenu limit 0;
           insert into w_up_5208_db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente )
                values ( 10286 ,'Agenda Médica' ,'Agenda Médica' ,'sau2_agendamedica001.php' ,'1' ,'1' ,'Formulário para impressão da agenda médica de um profissional da saúde.' ,'true' );

insert into db_itensmenu
     select *
       from w_up_5208_db_itensmenu
      where not exists ( select 1
                           from db_itensmenu
                          where db_itensmenu.id_item = w_up_5208_db_itensmenu.id_item);

create temporary table w_up_5208_db_menu as select * from db_menu limit 0;
           insert into w_up_5208_db_menu ( id_item ,id_item_filho ,menusequencia ,modulo )
               values ( 30 ,10286 ,456 ,6952 );

insert into db_menu
     select *
       from w_up_5208_db_menu
      where not exists ( select 1
                           from db_menu
                          where db_menu.id_item       = w_up_5208_db_menu.id_item
                            and db_menu.id_item_filho = w_up_5208_db_menu.id_item_filho);

create temporary table w_up_6896_db_syscampo as select * from db_syscampo limit 0;
           insert into w_up_6896_db_syscampo
                 values(22005,'s152_perimetrocefalico','int4','Perímetro Cefálico','0', 'Perímetro Cefálico',10,'t','f','f',1,'text','Perímetro Cefálico'),
                       (22006,'s152_frequenciarespiratoria','int4','Frequência Respiratória','0', 'Frequência Respiratória',10,'t','f','f',1,'text','Frequência Respiratória'),
                       (22007,'s152_frequenciacardiaca','int4','Frequência Cardíaca','0', 'Frequência Cardíaca',10,'t','f','f',1,'text','Frequência Cardíaca'),
                       (22009,'s152_dum','date','DUM','null', 'DUM',10,'t','f','f',1,'text','DUM'),
                       (22010,'s152_saturacao','int4','Saturação de O2','0', 'Saturação de O2',10,'t','f','f',1,'text','Saturação de O2');

insert into db_syscampo
     select *
       from w_up_6896_db_syscampo
      where not exists ( select 1
                           from db_syscampo
                          where db_syscampo.codcam = w_up_6896_db_syscampo.codcam);

create temporary table w_up_6896_db_sysarqcamp as select * from db_sysarqcamp limit 0;
           insert into w_up_6896_db_sysarqcamp
                values(3043,22005,17,0),
                      (3043,22006,18,0),
                      (3043,22007,19,0),
                      (3043,22009,21,0),
                      (3043,22010,22,0);

insert into db_sysarqcamp
     select *
       from w_up_6896_db_sysarqcamp
      where not exists ( select 1
                           from db_sysarqcamp
                          where db_sysarqcamp.codcam = w_up_6896_db_sysarqcamp.codcam);

create temporary table w_up_6896_db_syscampodef as select * from db_syscampodef limit 0;
           insert into w_up_6896_db_syscampodef
                values(17222,'0','NÃO ESPECIFICADO'),
                      (17222,'1','JEJUM'),
                      (17222,'2','PÓS-PRANDIAL'),
                      (17222,'3','PRÉ-PRANDIAL');

update db_syscampo set nomecam = 's152_i_alimentacaoexameglicemia', conteudo = 'int4', descricao = 'Alimentação do paciente ao realizar o exame de glicemia. 0 - Não informado; 1 - Em jejum; 2 - Pós-prandial; 3 - Pré-prandial;', valorinicial = '0', rotulo = 'Momento da Coleta', nulo = 't', tamanho = 1, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Momento da Coleta' where codcam = 17222;

create temporary table w_up_6991_db_syscampo as select * from db_syscampo limit 0;
           insert into w_up_6991_db_syscampo
                values(22030,'s152_subjetivo','text','Campo que possibilita o registro da parte subjetiva da anamnese da consulta,ou seja,os dados dos sentimentos e percepções do cidadão em relação à sua saúde.','', 'Subjetivo',1,'t','t','f',0,'text','Subjetivo');

insert into db_syscampo
     select *
       from w_up_6991_db_syscampo
      where not exists ( select 1
                           from db_syscampo
                          where db_syscampo.codcam = w_up_6991_db_syscampo.codcam);

create temporary table w_up_6991_db_sysarqcamp as select * from db_sysarqcamp limit 0;
           insert into w_up_6991_db_sysarqcamp
               values (3043,22030,22,0);

insert into db_sysarqcamp
     select *
       from w_up_6991_db_sysarqcamp
      where not exists ( select 1
                           from db_sysarqcamp
                          where db_sysarqcamp.codarq = w_up_6991_db_sysarqcamp.codarq
                            and db_sysarqcamp.codcam = w_up_6991_db_sysarqcamp.codcam
                            and db_sysarqcamp.seqarq = w_up_6991_db_sysarqcamp.seqarq);

update db_syscampo set nomecam = 's152_evolucao', conteudo = 'text', descricao = 'Campo que possibilita o registro do exame físico, como, por exemplo, os sinais e sintomas detectados, além do registro de resultados de exames realizados.( antigo campo da Evolução )', valorinicial = '', rotulo = 'Objetivo', nulo = 't', tamanho = 1, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Objetivo' where codcam = 20973;
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL SAUDE ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
