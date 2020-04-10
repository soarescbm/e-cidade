/*
 * TIME FOLHA
 */
--
-- Tarefa 91675 - Parametrização do arquivo bancário
--
--HEADER ARQUIVO
update db_layoutcampos set db52_default = '000' where db52_codigo = 521;
update db_layoutcampos set db52_default = '01600' where db52_codigo = 516;
update db_layoutcampos set db52_default = 'CAIXA' where db52_codigo = 509;
update db_layoutcampos set db52_default = '0000' where db52_codigo = 621;
update db_layoutcampos set db52_default = '1' where db52_codigo = 619;
update db_layoutcampos set db52_default = '0000' where db52_codigo = 495;
update db_layoutcampos set db52_default = '104' where db52_codigo = 494;

--Detalhe B
update db_layoutcampos set db52_default = '000000000000000' where db52_codigo = 599;
update db_layoutcampos set db52_default = '000000000000000' where db52_codigo = 598;
update db_layoutcampos set db52_default = '000000000000000' where db52_codigo = 597;
update db_layoutcampos set db52_default = '000000000000000' where db52_codigo = 596;
update db_layoutcampos set db52_default = '000000000000000' where db52_codigo = 595;
update db_layoutcampos set db52_default = '104' where db52_codigo = 579;

--Header Lote
update db_layoutcampos set db52_default = '104' where db52_codigo = 524;

--Detalhe A
update db_layoutcampos set db52_default = '00'  where db52_codigo = 558;
update db_layoutcampos set db52_default = '104' where db52_codigo = 552;

--Trailer Lote
update db_layoutcampos set db52_default = '104'    where db52_codigo = 602;
update db_layoutcampos set db52_default = '000000' where db52_codigo = 633;

--Trailer Arquivo
update db_layoutcampos set db52_default = '000000' where db52_codigo = 617;
update db_layoutcampos set db52_default = '104'    where db52_codigo = 611;


--Tabela Afasta
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 525 ,14489 ,11 ,0 );
delete from db_sysarqcamp where codcam in (3639);
delete from db_syscampo where codcam in (3639);
delete from db_sysforkey where codarq = 525 and referen = 0;
insert into db_sysforkey values(525,3635,1,1153,0);

update db_syscampo set descricao = 'Salário Líquido', rotulo = 'Salário Líquido', rotulorel = 'Salário Líquido' where codcam = 3919;
update db_syscampo set rotulo = 'Sub Causa de Rescisão' where codcam = 7046;

--73953
insert into db_syscampo values(20685,'rh01_reajusteparidade','bool','Tipo de reajuste do servidor. False = Real, True = c/ Paridade (reajuste)','f', 'Tipo de Reajuste',1,'f','f','f',5,'text','Tipo de Reajuste');
delete from db_sysarqcamp where codarq = 1153;
insert into db_sysarqcamp values(1153,6964,1,0);
insert into db_sysarqcamp values(1153,6965,2,0);
insert into db_sysarqcamp values(1153,6979,3,0);
insert into db_sysarqcamp values(1153,6980,4,0);
insert into db_sysarqcamp values(1153,6966,5,0);
insert into db_sysarqcamp values(1153,6967,6,0);
insert into db_sysarqcamp values(1153,6968,7,0);
insert into db_sysarqcamp values(1153,6969,8,0);
insert into db_sysarqcamp values(1153,6970,9,0);
insert into db_sysarqcamp values(1153,6971,10,0);
insert into db_sysarqcamp values(1153,6972,11,0);
insert into db_sysarqcamp values(1153,6973,12,0);
insert into db_sysarqcamp values(1153,6974,13,0);
insert into db_sysarqcamp values(1153,6976,14,0);
insert into db_sysarqcamp values(1153,6977,15,0);
insert into db_sysarqcamp values(1153,6978,16,0);
insert into db_sysarqcamp values(1153,7635,17,0);
insert into db_sysarqcamp values(1153,7636,18,0);
insert into db_sysarqcamp values(1153,7471,19,0);
insert into db_sysarqcamp values(1153,7825,20,0);
insert into db_sysarqcamp values(1153,7848,21,0);
insert into db_sysarqcamp values(1153,10036,22,0);
insert into db_sysarqcamp values(1153,10035,23,0);
insert into db_sysarqcamp values(1153,17368,24,0);
insert into db_sysarqcamp values(1153,19596,25,0);
insert into db_sysarqcamp values(1153,20685,26,0);

--Relatorio Reajuste Paridade

INSERT INTO db_relatorio VALUES (28, 1, 1, 'Relatório de Servidores por Tipo de Reajuste', '1.0', '2014-07-10', '<?xml version="1.0" encoding="ISO-8859-1"?>
<Relatorio>
 <Versao>1.0</Versao>
 <Propriedades versao="1.0" nome="Relatório de Servidores por Tipo de Reajuste" layout="dbseller" formato="A4" orientacao="portrait" margemsup="0" margeminf="0" margemesq="20" margemdir="20" tiposaida="pdf"/>
 <Cabecalho></Cabecalho>
 <Rodape></Rodape>
 <Variaveis>
  <Variavel nome="$sTipoReajuste" label="Tipo de Reajuste" tipodado="varchar" valor="f"/>
 </Variaveis>
 <Campos>
  <Campo id="6964" nome="rh01_regist" alias="Matrícula" largura="18" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="217" nome="z01_nome" alias="Nome" largura="90" alinhamento="l" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="15613" nome="rh88_descricao" alias="Tipo Aposentadoria" largura="55" alinhamento="l" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="15614" nome="rh01_descricaoreajusteparidade" alias="Tipo de Reajuste" largura="30" alinhamento="l" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
 </Campos>
 <Consultas>
  <Consulta tipo="Principal">
   <Select>
    <Campo id="6964"/>
    <Campo id="217"/>
    <Campo id="15613"/>
    <Campo id="15614"/>
   </Select>
   <From>select distinct rh01_regist,
                z01_nome,
                rh88_descricao,
                case when rh01_reajusteparidade = ''f'' then ''Real''
                else ''Paridade'' end as rh01_descricaoreajusteparidade
  from rhpessoal
      inner join cgm          on rhpessoal.rh01_numcgm = cgm.z01_numcgm
      inner join rhpessoalmov on rhpessoal.rh01_regist = rhpessoalmov.rh02_regist
      inner join rhtipoapos   on rhpessoalmov.rh02_rhtipoapos = rhtipoapos.rh88_sequencial

where rh01_reajusteparidade = $sTipoReajuste</From>
   <Where/>
   <Group></Group>
   <Order>
    <Ordem id="217" nome="z01_nome" ascdesc="asc" alias="Nome"/>
   </Order>
  </Consulta>
 </Consultas>
</Relatorio>', 1);

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9957 ,'Servidores por Tipo de Reajuste' ,'Servidores por Tipo de Reajuste' ,'pes2_relatoriotiporeajuste001.php' ,'1' ,'1' ,'Relatório de Reajuste de Paridade' ,'true' );
delete from db_menu where id_item_filho = 9957 AND modulo = 952;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 2456 ,9957 ,35 ,952 );


/**
 * TIME B
 */

/* { 73195 - INICIO} */
/* { 73195 - FIM} */

/**
 * TIME C - INICIO
 */
/* { 95317 - INICIO} */

insert into db_sysarquivo values (3722, 'sau_triagemavulsaagravo', 'Vínculo entre triagem avulsa e agravos cadastrados no CID', 's167', '2014-07-02', 'Triagem Avulsa com Agravo', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (1000004,3722);

insert into db_syscampo values(20678,'s167_sequencial','int4','Código do vínculo entre triagem avulsa e agravo','0', 'Sequencial da tabela',10,'f','f','f',1,'text','Sequencial da tabela');
insert into db_syscampo values(20679,'s167_sau_triagemavulsa','int4','Vínculo com triagem avulsa','0', 'Triagem Avulsa',10,'f','f','f',1,'text','Triagem Avulsa');
insert into db_syscampo values(20680,'s167_sau_cid','int4','Vínculo com o CID. Serão vinculados somente os que possuem os agravos (sd70_i_agravo) 1 e 2','0', 'Agravo',10,'f','f','f',1,'text','Agravo');
insert into db_syscampo values(20681,'s167_datasintoma','date','Data do primeiro sintoma.','null', 'Data do primeiro sintoma',10,'f','f','f',1,'text','Data do primeiro sintoma');
insert into db_syscampo values(20682,'s167_gestante','bool','Paciente gestante','false', 'Gestante',1,'f','f','f',5,'text','Gestante');

delete from db_sysarqcamp where codarq = 3722;
insert into db_sysarqcamp values(3722,20678,1,0);
insert into db_sysarqcamp values(3722,20679,2,0);
insert into db_sysarqcamp values(3722,20680,3,0);
insert into db_sysarqcamp values(3722,20681,4,0);
insert into db_sysarqcamp values(3722,20682,5,0);

delete from db_sysprikey where codarq = 3722;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3722,20678,1,20679);
delete from db_sysforkey where codarq = 3722 and referen = 0;
insert into db_sysforkey values(3722,20679,1,3043,0);
delete from db_sysforkey where codarq = 3722 and referen = 0;
insert into db_sysforkey values(3722,20680,1,1992,0);

insert into db_syssequencia values(1000382, 'sau_triagemavulsaagravo_s167_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000382 where codarq = 3722 and codcam = 20678;

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 9956 ,'Agravo' ,'Agravo' ,'sau2_suspeitaagravo001.php' ,'1' ,'1' ,'Emite relatório de agravos' ,'true' );
delete from db_menu where id_item_filho = 9956 AND modulo = 1000004;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 30 ,9956 ,438 ,1000004 );


/* { 95317 - FIM} */

/* {94085} */
insert into db_tipodoc values (5013, 'OBSERVAÇÃO APROVAÇÃO POR CONSELHO');
insert into db_documentopadrao( db60_coddoc ,db60_descr ,db60_tipodoc ,db60_instit ) values ( 225 ,'OBSERVAÇÃO APROVAÇÃO POR CONSELHO' ,5013 ,1 );
insert into db_paragrafopadrao( db61_codparag ,db61_descr ,db61_texto ,db61_alinha ,db61_inicia ,db61_espaco ,db61_alinhamento ,db61_altura ,db61_largura ,db61_tipo ) values ( 520 ,'OBSERVAÇÃO APROVAÇÃO POR CONSELHO' ,'Aluno aprovado através do conselho de classe na disciplina #$disciplina# do #$etapa#, conforme justificativa: #$justificativa#. #$nota# #$anomatricula#' ,0 ,0 ,1 ,'J' ,0 ,0 ,1 );
insert into db_docparagpadrao( db62_coddoc ,db62_codparag ,db62_ordem ) values ( 225 ,520 ,1 );
/* {94085} fim */

/* { 94085B - INICIO} */
insert into db_syscampo values(20683,'ed253_alterarnotafinal','int4','Alternar nota final: 1 - Não Informar 2 - Informar e substituir 3 - Informar e NÃO substituir','0', 'Alternar nota final',1,'t','f','f',1,'text','Alternar nota final');
insert into db_syscampodef values(20683,'1','Não Informar');
insert into db_syscampodef values(20683,'2','Informar e substituir');
insert into db_syscampodef values(20683,'3','Informar e NÃO substituir');

insert into db_syscampo values(20684,'ed253_avaliacaoconselho','varchar(10)','Guarda a Avaliação dada pelo conselho ao aluno','', 'Avaliação do Conselho',10,'t','t','f',0,'text','Avaliação do Conselho');

delete from db_sysarqcamp where codarq = 2175;
insert into db_sysarqcamp values(2175,12464,1,1081);
insert into db_sysarqcamp values(2175,12465,2,0);
insert into db_sysarqcamp values(2175,12466,3,0);
insert into db_sysarqcamp values(2175,12467,4,0);
insert into db_sysarqcamp values(2175,12469,5,0);
insert into db_sysarqcamp values(2175,12468,6,0);
insert into db_sysarqcamp values(2175,19621,7,0);
insert into db_sysarqcamp values(2175,20683,8,0);
insert into db_sysarqcamp values(2175,20684,9,0);
/* { 94085B - FIM} */

/* {96026 - INICIO}*/
insert into db_syscampo values(20689,'ed18_codigoreferencia','int4','Código referência da Escola.','0', 'Código Referência',10,'t','f','f',1,'text','Código Referência');
delete from db_sysarqcamp where codarq = 1010031;
insert into db_sysarqcamp values(1010031,1008196,1,0);
insert into db_sysarqcamp values(1010031,1008197,2,0);
insert into db_sysarqcamp values(1010031,1008198,3,0);
insert into db_sysarqcamp values(1010031,1008199,4,0);
insert into db_sysarqcamp values(1010031,1008200,5,0);
insert into db_sysarqcamp values(1010031,1008201,6,0);
insert into db_sysarqcamp values(1010031,1008202,7,0);
insert into db_sysarqcamp values(1010031,1008204,8,0);
insert into db_sysarqcamp values(1010031,1008205,9,0);
insert into db_sysarqcamp values(1010031,1008206,10,0);
insert into db_sysarqcamp values(1010031,1008207,11,0);
insert into db_sysarqcamp values(1010031,1008208,12,0);
insert into db_sysarqcamp values(1010031,1008955,13,0);
insert into db_sysarqcamp values(1010031,1008956,14,0);
insert into db_sysarqcamp values(1010031,1008962,15,0);
insert into db_sysarqcamp values(1010031,1009068,16,0);
insert into db_sysarqcamp values(1010031,12619,17,0);
insert into db_sysarqcamp values(1010031,12622,18,0);
insert into db_sysarqcamp values(1010031,12623,19,0);
insert into db_sysarqcamp values(1010031,12624,20,0);
insert into db_sysarqcamp values(1010031,13399,21,0);
insert into db_sysarqcamp values(1010031,13373,22,0);
insert into db_sysarqcamp values(1010031,12621,23,0);
insert into db_sysarqcamp values(1010031,13344,24,0);
insert into db_sysarqcamp values(1010031,13361,25,0);
insert into db_sysarqcamp values(1010031,13362,26,0);
insert into db_sysarqcamp values(1010031,13363,27,0);
insert into db_sysarqcamp values(1010031,13364,28,0);
insert into db_sysarqcamp values(1010031,13450,29,0);
insert into db_sysarqcamp values(1010031,13451,30,0);
insert into db_sysarqcamp values(1010031,13452,31,0);
insert into db_sysarqcamp values(1010031,13453,32,0);
insert into db_sysarqcamp values(1010031,13454,33,0);
insert into db_sysarqcamp values(1010031,13455,34,0);
insert into db_sysarqcamp values(1010031,17985,35,0);
insert into db_sysarqcamp values(1010031,18917,36,0);
insert into db_sysarqcamp values(1010031,18918,37,0);
insert into db_sysarqcamp values(1010031,20689,38,0);
/* {96026 - FIM}*/

/* {95315} - INICIO*/
update db_itensmenu set id_item = 8635 , descricao = 'Triagem Avulsa' , help = 'Triagem Avulsa' , funcao = 'sau4_triagemavulsanovo001.php' , itemativo = '1' , manutencao = '1' , desctec = 'Triagem avulsa.' , libcliente = 'true' where id_item = 8635;
/* {95315} - FIM */

/**
 * TIME C - FIM
 */


update db_itensmenu set libcliente = false where id_item = 4109;


select fc_executa_ddl('insert into db_sysarquivo values( 3723, ''bancoagenciaendereco'',''Endereço da agencia bancaria. Tabela de ligação entre a bancoagencia e endereco'', ''db92'', ''2014-07-14'', ''Endereço da Agencia'', 0, false, false, false, false)');
select fc_executa_ddl('insert into db_sysarqmod values (7,3723)');
select fc_executa_ddl('insert into db_syscampo values(20686,\'db92_sequencial\',\'int4\',\'Código Sequencial\',\'0\', \'Código Sequencial\',10,\'f\',\'f\',\'f\',1,\'text\',\'Código Sequencial\'); ');
select fc_executa_ddl('insert into db_syscampo values(20687,\'db92_bancoagencia\',\'int4\',\'Agência\', \'0\', \'Agência\',10, \'f\',\'f\',\'f\',1,\'text\',\'Agência\');');
select fc_executa_ddl('insert into db_syscampo values(20688,\'db92_endereco\',\'int4\', \'Endereço da Agencia\',\'0\', \'Endereço da Agencia\',10,\'f\',\'f\',\'f\',1,\'text\',\'Endereço da Agencia\');');
select fc_executa_ddl('insert into db_sysarqcamp values(3723,20686,1,0);');
select fc_executa_ddl('insert into db_sysarqcamp values(3723,20687,2,0);');
select fc_executa_ddl('insert into db_sysarqcamp values(3723,20688,3,0);');
select fc_executa_ddl('insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3723,20686,1,20687);');
select fc_executa_ddl('insert into db_sysforkey values(3723,20687,1,2187,0);');
select fc_executa_ddl('insert into db_sysforkey values(3723,20688,1,2786,0);');
select fc_executa_ddl('insert into db_sysindices values(4097,\'bancoagenciaendereco_agencia_in\',3723,\'1\');');
select fc_executa_ddl('insert into db_syscadind values(4097,20687,1);');
select fc_executa_ddl('insert into db_sysindices values(4098,\'bancoagenciaendereco_endereco_in\',3723,\'0\');');
select fc_executa_ddl('insert into db_syscadind values(4098,20688,1);');
select fc_executa_ddl('insert into db_syssequencia values(1000383, \'bancoagenciaendereco_db92_sequencial_seq\', 1, 1, 9223372036854775807, 1, 1);');
select fc_executa_ddl('update db_sysarqcamp set codsequencia = 1000383 where codarq = 3723 and codcam = 20686;');


select fc_executa_ddl('CREATE SEQUENCE bancoagenciaendereco_db92_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;');

select fc_executa_ddl('CREATE TABLE bancoagenciaendereco(
db92_sequencial		int4 NOT NULL default 0,
db92_bancoagencia		int4 NOT NULL default 0,
db92_endereco		int4 default 0,
CONSTRAINT bancoagenciaendereco_sequ_pk PRIMARY KEY (db92_sequencial));');

select fc_executa_ddl('ALTER TABLE bancoagenciaendereco
ADD CONSTRAINT bancoagenciaendereco_bancoagencia_fk FOREIGN KEY (db92_bancoagencia)
REFERENCES bancoagencia;');

select fc_executa_ddl('ALTER TABLE bancoagenciaendereco
ADD CONSTRAINT bancoagenciaendereco_endereco_fk FOREIGN KEY (db92_endereco)
REFERENCES endereco;');


select fc_executa_ddl('CREATE  INDEX bancoagenciaendereco_endereco_in ON bancoagenciaendereco(db92_endereco);');
select fc_executa_ddl('CREATE UNIQUE INDEX bancoagenciaendereco_agencia_in ON bancoagenciaendereco(db92_bancoagencia);');

-- Nome do campo pesquisa #73953
update db_syscampo set rotulo = 'Código da Instituição', rotulorel = 'Código da Instituição' where codcam = 9906;

/* Menus Desativados devido a solicitacao da ISSUE #829 no redmine */
update db_itensmenu set libcliente = false where id_item in(268994, 4070, 5735, 94, 4398, 3973, 3999, 3843, 4204, 3506, 3772);

/**
 * Time Financeiro - OBN
 */

update db_itensmenu set libcliente = false where id_item in (9755, 9786, 9787);

update db_itensmenu set descricao = 'Cancelar Arquivo de Remessa - OBN', help = 'Cancelar arquivo de remessa OBN' where id_item = 9787;
update db_itensmenu set descricao = 'Regerar Arquivo de Remessa - OBN', help = 'Regerar arquivo de remessa OBN' where id_item = 9786;

insert into db_syscampo values(20690,'e92_empagetipotransmissao','int4','Tipo de Transmissão','0', 'Tipo de Transmissão',10,'f','f','f',1,'text','Tipo de Transmissão');
insert into db_sysarqcamp values(1014,20690,5,0);
insert into db_sysforkey values(1014,20690,1,3593,0);

update db_layoutcampos set db52_nome = 'tipo_linha' where db52_codigo in (10753, 10848);
update db_layoutcampos set db52_default = '00000000000000000000000000000000000' where db52_codigo = 10753;
update db_layoutcampos set db52_default = '99999999999999999999999999999999999' where db52_codigo = 10848;

/**
 * Tabela FUNDEB
 */
drop table if exists finalidadepagamentofundeb;
drop sequence if exists finalidadepagamentofundeb_e151_sequencial_seq;

CREATE SEQUENCE finalidadepagamentofundeb_e151_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE finalidadepagamentofundeb(
e151_sequencial  int4 NOT NULL default 0,
e151_codigo      varchar(5) NOT NULL ,
e151_descricao   varchar(200) NOT NULL,
CONSTRAINT finalidadepagamentofundeb_sequ_pk PRIMARY KEY (e151_sequencial));

CREATE  INDEX finalidadepagamentofundeb_codigo_in ON finalidadepagamentofundeb(e151_codigo);
CREATE  INDEX finalidadepagamentofundeb_sequencial_in ON finalidadepagamentofundeb(e151_sequencial);

insert into finalidadepagamentofundeb values
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '01', 'Remuneração de profissionais do magistério da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '02', 'Obrigações patronais sobre pagamento de profissionais do magistério da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '03', 'Remuneração de pessoal técnico administrativo da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '04', 'Obrigações patronais sobre pagamento de pessoal técnico administrativo da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '05', 'Capacitação de professores da educação básica, em nível médio (formação inicial)'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '06', 'Capacitação de professores da educação básica, em nível superior (formação inicial)'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '07', 'Capacitação de professores da educação básica (formação continuada)'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '08', 'Capacitação de pessoal técnico-administrativo da educação básica(formação continuada)'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '09', 'Aquisição de equipamentos e mobiliário para educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '10', 'Aquisição de veículos para transporte escolar da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '11', 'Manutenção de transporte escolar - educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '12', 'Aquisição de veículos para serviços gerais da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '13', 'Manutenção de veículos e equipamentos utilizados na educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '14', 'Aquisição de material didático escolar da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '15', 'Aquisição de material de consumo para escolas da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '16', 'Serviços de limpeza e vigilância das escolas da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '17', 'Outros serviços de manutenção das escolas da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '18', 'Construção, ampliação, conclusão ou aquisição de instalações para escolas da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '19', 'Reforma de escolas da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '20', 'Construção, ampliação, conclusão ou aquisição de unidades físicas administrativas da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '21', 'Reforma de instalações físicas utilizadas na educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '22', 'Manutenção de instalações físicas utilizadas da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '23', 'Aquisição de material de consumo para unidades administrativas da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '24', 'Serviços de manutenção de unidades administrativas da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '25', 'Levantamento, estudos e pesquisas vinculadas ao ensino e de interesse da educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '26', 'Amortização e custeio de operações de crédito destinadas a investimentos na educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '27', 'Locomoção e estadia de pessoal de apoio e/ou técnico-administrativo em exercício na educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '28', 'Locomoção e estadia de profissionais do magistério em exercício na educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '29', 'Locação de instalações e equipamentos de uso na educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '30', 'Locação/aquisição de software e aplicativos tecnológicos de uso na educação básica'),
(nextval('finalidadepagamentofundeb_e151_sequencial_seq'), '31', 'Aquisição/desapropriação de terrenos para edificação de instalações da educação básica');


drop table if exists empagetipotransmissao;
drop sequence if exists empagetipotransmissao_e57_sequencial_seq;

CREATE SEQUENCE empagetipotransmissao_e57_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE empagetipotransmissao(
e57_sequencial  int4 NOT NULL default 0,
e57_descricao   varchar(100) ,
CONSTRAINT empagetipotransmissao_sequ_pk PRIMARY KEY (e57_sequencial));

insert into empagetipotransmissao values
(1, 'CNAB240'),
(2, 'OBN');

alter table errobanco add column e92_empagetipotransmissao int4;
update errobanco set e92_empagetipotransmissao = 1;

ALTER TABLE errobanco ADD CONSTRAINT errobanco_empagetipotransmissao_fk FOREIGN KEY (e92_empagetipotransmissao) REFERENCES empagetipotransmissao;

update db_layoutcampos set db52_nome = 'brancos_2' where db52_codigo = 11093;
update db_layoutcampos set db52_nome = 'brancos_1' where db52_codigo = 10836;
update db_layoutcampos set db52_default = '00000000000000000000000000000000000' where db52_codigo = 10680;
update db_layoutcampos set db52_default = '99999999999999999999999999999999999' where db52_codigo = 10749;
/**
 * Time Financeiro - FIM
 */