---------------------------------------------------------------------------------------------
-------------------------------- INCIO FINANCEIRO -------------------------------------------
---------------------------------------------------------------------------------------------

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21351 ,'ve62_situacao' ,'int4' ,'Situação da manutenção.' ,'2' ,'Situação' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Situação' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 1603 ,21351 ,14 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21352 ,'ve62_numero' ,'int4' ,'Número da manutenção no ano.' ,'' ,'Número' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Número' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 1603 ,21352 ,15 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21353 ,'ve62_anousu' ,'int4' ,'Ano da manutenção' ,'' ,'Ano' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Ano' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 1603 ,21353 ,16 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21376 ,'ve62_veicmotoristas' ,'int4' ,'Motorista' ,'' ,'Motorista' ,10 ,'true' ,'false' ,'false' ,1 ,'text' ,'Motorista' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 1603 ,21376 ,17 ,0 );
insert into db_sysforkey values(1603,21376,1,1593,0);

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21354 ,'ve63_valortotalcomdesconto' ,'float8' ,'Valor total do item com o desconto aplicado.' ,'0' ,'Valor total com desconto' ,15 ,'false' ,'false' ,'false' ,4 ,'text' ,'Valor total com desconto' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 1604 ,21354 ,6 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21355 ,'ve63_unidade' ,'int4' ,'Unidade de medida.' ,'1' ,'Unidade' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Unidade' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 1604 ,21355 ,7 ,0 );
insert into db_sysforkey values(1604,21355,1,1017,0);

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21356 ,'ve63_tipoitem' ,'int4' ,'Tipo de item. 1 - Peça, 2 - Mão de obra, 3 - Lavagem.' ,'1' ,'Tipo de Item' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Tipo de Item' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 1604 ,21356 ,8 ,0 );

insert into db_syscampo values(21495,'ve63_proximatroca','float8','Hodômetro para a próxima troca do item.','0', 'Próxima Troca',15,'t','f','f',4,'text','Próxima Troca');
insert into db_sysarqcamp values(1604,21495,9,0);

insert into db_syscampo values(21496,'ve63_datanota','date','Data da nota do item.','null', 'Data da Nota',10,'t','f','f',1,'text','Data da Nota');
insert into db_sysarqcamp values(1604,21496,10,0);

insert into db_syscampo values(21497,'ve63_numeronota','varchar(10)','Número da nota do item.','', 'Número da Nota',10,'t','t','f',0,'text','Número da Nota');
insert into db_sysarqcamp values(1604,21497,11,0);
update db_syscampo set nulo = 'true' where nomecam = 've62_notafisc';


insert into db_sysarquivo values (3845, 'autorizacaocirculacaoveiculo', 'Autorização para circulação de veículo', 've13', '2015-08-10', 'Autorização Circulação de Veículo', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (45,3845);

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21365 ,'ve13_sequencial' ,'int4' ,'Código da autorização' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3845 ,21365 ,1 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21366 ,'ve13_instituicao' ,'int4' ,'Instituição da autorização' ,'' ,'Instituição' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Instituição' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3845 ,21366 ,2 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21367 ,'ve13_veiculo' ,'int4' ,'Veículo da autorização' ,'' ,'Veículo' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Veículo' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3845 ,21367 ,3 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21368 ,'ve13_motorista' ,'int4' ,'Motorista da autorização' ,'' ,'Motorista' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Motorista' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3845 ,21368 ,4 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21369 ,'ve13_datainicial' ,'date' ,'Data inicial da autorização' ,'' ,'Data Inicial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Data Inicial' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3845 ,21369 ,5 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21370 ,'ve13_datafinal' ,'date' ,'Data final da autorização' ,'' ,'Data Final' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Data Final' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3845 ,21370 ,6 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21371 ,'ve13_dataemissao' ,'date' ,'Data de emissão da autorização' ,'' ,'Data de Emissão' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Data de Emissão' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3845 ,21371 ,7 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21372 ,'ve13_observacao' ,'text' ,'Observação da autorização' ,'' ,'Observação' ,1 ,'true' ,'false' ,'false' ,0 ,'text' ,'Observação' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3845 ,21372 ,8 ,0 );

insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3845,21365,1,21365);

insert into db_sysforkey values(3845,21366,1,83,0);
insert into db_sysforkey values(3845,21367,1,1590,0);
insert into db_sysforkey values(3845,21368,1,1593,0);

insert into db_sysindices values(4244,'autorizacaocirculacaoveiculo_instituicao_in',3845,'0');
insert into db_syscadind values(4244,21366,1);
insert into db_sysindices values(4245,'autorizacaocirculacaoveiculo_motorista_in',3845,'0');
insert into db_syscadind values(4245,21368,1);
insert into db_sysindices values(4246,'autorizacaocirculacaoveiculo_veiculo_in',3845,'0');
insert into db_syscadind values(4246,21367,1);

insert into db_syssequencia values(1000496, 'autorizacaocirculacaoveiculo_ve13_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000496 where codarq = 3845 and codcam = 21365;

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21377 ,'ve13_departamento' ,'int4' ,'Departamento na sessão do usuário no momento da emissão da autorização.' ,'' ,'Departamento' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Departamento' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3845 ,21377 ,9 ,0 );
insert into db_sysforkey values(3845,21377,1,154,0);
insert into db_sysindices values(4248,'autorizacaocirculacaoveiculo_departamento_in',3845,'0');
insert into db_syscadind values(4248,21377,1);

insert into db_tipodoc( db08_codigo ,db08_descr )
  values ( 5020 ,'VEICULOS - ORDEM DE SERVIÇO' );

insert into db_documentopadrao( db60_coddoc ,db60_descr ,db60_tipodoc ,db60_instit )
  select nextval('db_documentopadrao_db60_coddoc_seq'), 'VEICULOS - ORDEM DE SERVIÇO', 5020 , codigo from db_config;

drop table if exists db_paragrafopadrao_98551;
create temp table db_paragrafopadrao_98551 as select nextval('db_paragrafopadrao_db61_codparag_seq') as sequencial, codigo from db_config;

insert into db_paragrafopadrao( db61_codparag ,db61_descr ,db61_texto ,db61_alinha ,db61_inicia ,db61_espaco ,db61_alinhamento ,db61_altura ,db61_largura ,db61_tipo )
  select sequencial ,'ASSINATURA' ,
  ' $sDivisaoTransporte = "_________________________________\n[NOME]\nMatrícula: [MATRICULA]\nDivisão de Transportes";
    $sServicoGerais     = "_________________________________\n[NOME]\nMatrícula: [MATRICULA]\nDepartamento de Serviços Gerais";
    $sSecretarioGeral   = "_________________________________\n[NOME]\nMatrícula: [MATRICULA]\nSecretário Geral da Administração e Planejamento";

    $this->oPdf->setAutoNewLineMulticell(false);
    $this->oPdf->SetY(250);
    $this->oPdf->multicell(63, 4, $sDivisaoTransporte, 0, PDFDocument::ALIGN_CENTER);
    $this->oPdf->multicell(63, 4, $sServicoGerais, 0, PDFDocument::ALIGN_CENTER);
    $this->oPdf->multicell(63, 4, $sSecretarioGeral, 0, PDFDocument::ALIGN_CENTER);
    $this->oPdf->setAutoNewLineMulticell(true);' ,
  0 ,0 ,1 ,'J' ,0 ,0 ,3
    from db_paragrafopadrao_98551;

insert into db_docparagpadrao( db62_coddoc ,db62_codparag ,db62_ordem )
  select db60_coddoc, db_paragrafopadrao_98551.sequencial, db60_instit
    from db_documentopadrao inner join db_paragrafopadrao_98551 on db_paragrafopadrao_98551.codigo = db60_instit where db60_tipodoc = 5020;

insert into db_tipodoc( db08_codigo ,db08_descr )
  values ( 5021 ,'VEICULOS - RELATÓRIO DE MANUTENÇÃO' );

insert into db_documentopadrao( db60_coddoc ,db60_descr ,db60_tipodoc ,db60_instit )
  select nextval('db_documentopadrao_db60_coddoc_seq'), 'VEICULOS - RELATÓRIO DE MANUTENÇÃO', 5021 , codigo from db_config;

drop table if exists db_paragrafopadrao_98599;
create temp table db_paragrafopadrao_98599 as select nextval('db_paragrafopadrao_db61_codparag_seq') as sequencial, codigo from db_config;

insert into db_paragrafopadrao( db61_codparag ,db61_descr ,db61_texto ,db61_alinha ,db61_inicia ,db61_espaco ,db61_alinhamento ,db61_altura ,db61_largura ,db61_tipo )
  select sequencial ,'ASSINATURA' ,
  ' $sDivisaoTransporte = "_________________________________\n[NOME]\nDivisão de Transportes\nMatrícula: [MATRICULA]";

    $this->oPdf->setAutoNewLineMulticell(false);
    $this->oPdf->multicell($this->iLargura, $this->iAltura, $sDivisaoTransporte, 0, PDFDocument::ALIGN_CENTER);
    $this->oPdf->setAutoNewLineMulticell(true);' ,
  0 ,0 ,1 ,'J' ,0 ,0 ,3
    from db_paragrafopadrao_98599;

insert into db_docparagpadrao( db62_coddoc ,db62_codparag ,db62_ordem )
  select db60_coddoc, db_paragrafopadrao_98599.sequencial, db60_instit
    from db_documentopadrao inner join db_paragrafopadrao_98599 on db_paragrafopadrao_98599.codigo = db60_instit where db60_tipodoc = 5021;

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10132 ,'Movimentações' ,'Movimentações' ,'' ,'1' ,'1' ,'Movimentações' ,'true' );
delete from db_menu where id_item_filho = 10132 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 5336 ,10132 ,19 ,633 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10133 ,'Cadastrais' ,'Cadastrais' ,'' ,'1' ,'1' ,'Cadastrais' ,'true' );
delete from db_menu where id_item_filho = 10133 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 5336 ,10133 ,20 ,633 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10134 ,'Documentos' ,'Documentos' ,'' ,'1' ,'1' ,'Documentos' ,'true' );
delete from db_menu where id_item_filho = 10134 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 5336 ,10134 ,21 ,633 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10135 ,'Ordem de Serviço' ,'Emissão de Ordem de Serviço' ,'vei2_reemissaoordemservico.php' ,'1' ,'1' ,'Emissão de Ordem de Serviço de manutenção de veículos.' ,'true' );
delete from db_menu where id_item_filho = 10135 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10134 ,10135 ,1 ,633 );

delete from db_menu where id_item_filho = 608583 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10132 ,608583 ,1 ,633 );
delete from db_menu where id_item_filho = 5437 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5437 ,1 ,633 );
delete from db_menu where id_item_filho = 5438 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5438 ,2 ,633 );
delete from db_menu where id_item_filho = 5445 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5445 ,3 ,633 );
delete from db_menu where id_item_filho = 5444 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5444 ,4 ,633 );
delete from db_menu where id_item_filho = 5447 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5447 ,5 ,633 );
delete from db_menu where id_item_filho = 5448 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5448 ,6 ,633 );
delete from db_menu where id_item_filho = 5452 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5452 ,7 ,633 );
delete from db_menu where id_item_filho = 5451 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5451 ,8 ,633 );
delete from db_menu where id_item_filho = 5450 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5450 ,9 ,633 );
delete from db_menu where id_item_filho = 5440 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5440 ,10 ,633 );
delete from db_menu where id_item_filho = 5439 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5439 ,11 ,633 );
delete from db_menu where id_item_filho = 5441 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5441 ,12 ,633 );
delete from db_menu where id_item_filho = 5442 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5442 ,13 ,633 );
delete from db_menu where id_item_filho = 5449 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5449 ,14 ,633 );
delete from db_menu where id_item_filho = 5443 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5443 ,15 ,633 );
delete from db_menu where id_item_filho = 5446 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,5446 ,16 ,633 );
delete from db_menu where id_item_filho = 6977 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10133 ,6977 ,17 ,633 );

update db_syscampo set rotulo = 'Descrição' where codcam = 9340;
update db_syscampo set rotulo = 'Data' where codcam = 9328;

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10136 ,'Autorização de Circulação' ,'Autorização de Circulação de Veículos' ,'' ,'1' ,'1' ,'Autorização de Circulação de Veículos' ,'true' );
delete from db_menu where id_item_filho = 10136 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 5338 ,10136 ,8 ,633 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10137 ,'Inclusão' ,'Inclusão de Autorização de Circulação' ,'vei4_autorizacaocirculacaoveiculo.php?opcao=1' ,'1' ,'1' ,'Inclusão de Autorização de Circulação de Veículo' ,'true' );
delete from db_menu where id_item_filho = 10137 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10136 ,10137 ,1 ,633 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10138 ,'Alteração' ,'Alteração de Autorização de Circulação' ,'vei4_autorizacaocirculacaoveiculo.php?opcao=2' ,'1' ,'1' ,'Alteração de Autorização de Circulação de Veículos' ,'true' );
delete from db_menu where id_item_filho = 10138 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10136 ,10138 ,2 ,633 );

update db_syscampo set rotulo = 'Veículo', descricao = 'Código do Veículo' where codcam = 9352;


insert into db_tipodoc( db08_codigo, db08_descr )
  values ( 5022, 'VEICULOS - AUTORIZAÇÃO CIRCULAÇÃO' );

insert into db_documentopadrao( db60_coddoc, db60_descr, db60_tipodoc, db60_instit )
  select nextval('db_documentopadrao_db60_coddoc_seq'), 'VEICULOS - AUTORIZAÇÃO CIRCULAÇÃO', 5022, codigo from db_config;

drop table if exists db_paragrafopadrao_98552;
create temp table db_paragrafopadrao_98552 as select nextval('db_paragrafopadrao_db61_codparag_seq') as sequencial, codigo from db_config;

insert into db_paragrafopadrao( db61_codparag, db61_descr, db61_texto, db61_alinha, db61_inicia, db61_espaco, db61_alinhamento, db61_altura, db61_largura, db61_tipo )
  select sequencial, 'ASSINATURA',
'
    $sDivisaoTransporte = "_________________________________\n[NOME]\nMatrícula: [MATRICULA]\nDivisão de Transportes";
    $sServicoGerais     = "_________________________________\n[NOME]\nMatrícula: [MATRICULA]\nDepartamento de Serviços Gerais";

    $this->oPdf->Ln(8);
    $this->oPdf->setAutoNewLineMulticell(false);
    $this->oPdf->multicell(95, 4, $sDivisaoTransporte, 0, PDFDocument::ALIGN_CENTER);
    $this->oPdf->setAutoNewLineMulticell(true);
    $this->oPdf->multicell(95, 4, $sServicoGerais, 0, PDFDocument::ALIGN_CENTER);
', 0, 0, 1, 'J', 0, 0, 3
from db_paragrafopadrao_98552;

insert into db_docparagpadrao( db62_coddoc, db62_codparag, db62_ordem )
  select db60_coddoc, db_paragrafopadrao_98552.sequencial, db60_instit
    from db_documentopadrao inner join db_paragrafopadrao_98552 on db_paragrafopadrao_98552.codigo = db60_instit where db60_tipodoc = 5022;

SELECT fc_executa_ddl('
  insert into db_layoutcampos values (12439, 729, ''sequencial'', ''SEQUENCIAL'', 1, 2, null, 3, false, true, ''d'', '''', 0);
  update db_layoutcampos set db52_posicao = db52_posicao + 3 where db52_layoutlinha = 729 and db52_nome not in (''tipo_registro'',''sequencial'');
  update db_layoutcampos set db52_tamanho = 25 where db52_codigo = 11933;
  update db_layoutcampos set db52_tamanho = 8 where db52_codigo = 11884;
  update db_layoutcampos set db52_posicao = db52_posicao-1 where db52_layoutlinha = 728 and db52_nome not in (''tipo_registro'', ''data_emissao'');' );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10144 ,'Manutenção' ,'Relatório da Manutenção de Veículos' ,'vei2_manutencaoveiculos001.php' ,'1' ,'1' ,'Relatório da Manutenção de Veículos' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10132 ,10144 ,2 ,633 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10149 ,'Ficha de Controle de Manutenção' ,'Ficha de Controle de Manutenção' ,'vei2_fichacontrolemanutencao001.php' ,'1' ,'1' ,'Emitir ficha de controle de manutenção por veículo.' ,'true' );
delete from db_menu where id_item_filho = 10149 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10132 ,10149 ,3 ,633 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10152 ,'Controle de Hodômetro' ,'Controle de Hodômetro de Veículos' ,'vei2_controlehodometro001.php' ,'1' ,'1' ,'Emissão de relatório de controle de hodômetro de veículo. ' ,'true' );
delete from db_menu where id_item_filho = 10152 AND modulo = 633;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10132 ,10152 ,4 ,633 );


insert into db_tipodoc( db08_codigo, db08_descr )
  values ( 5023, 'VEICULOS - FICHA DE CONTROLE' );

insert into db_documentopadrao( db60_coddoc, db60_descr, db60_tipodoc, db60_instit )
  select nextval('db_documentopadrao_db60_coddoc_seq'), 'VEICULOS - FICHA DE CONTROLE', 5023, codigo from db_config;

drop table if exists db_paragrafopadrao_98638;
create temp table db_paragrafopadrao_98638 as select nextval('db_paragrafopadrao_db61_codparag_seq') as sequencial, codigo from db_config;

insert into db_paragrafopadrao( db61_codparag, db61_descr, db61_texto, db61_alinha, db61_inicia, db61_espaco, db61_alinhamento, db61_altura, db61_largura, db61_tipo )
  select sequencial, 'ASSINATURA',
'
    $sDivisaoTransporte = "_________________________________\n[NOME]\nMatrícula: [MATRICULA]\nDivisão de Transportes";
    $this->oPdf->MultiCell($this->iLargura, 4, $sDivisaoTransporte, 0, PDFDocument::ALIGN_CENTER);
', 0, 0, 1, 'J', 0, 0, 3
from db_paragrafopadrao_98638;

insert into db_docparagpadrao( db62_coddoc, db62_codparag, db62_ordem )
  select db60_coddoc, db_paragrafopadrao_98638.sequencial, db60_instit
    from db_documentopadrao inner join db_paragrafopadrao_98638 on db_paragrafopadrao_98638.codigo = db60_instit where db60_tipodoc = 5023;

-- Levantamento Patrimonial

---- tabela levantamentopatrimonial
insert into db_sysarquivo values (3862, 'levantamentopatrimonial', 'Levantamento dos bens.', 'p13', '2015-08-26', 'Levantamento Patrimonial', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (18,3862);

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21508 ,'p13_sequencial' ,'int4' ,'Código' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3862 ,21508 ,1 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21509 ,'p13_departamento' ,'int4' ,'Departamento' ,'' ,'Departamento' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Departamento' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3862 ,21509 ,2 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21510 ,'p13_data' ,'date' ,'Data do levantamento' ,'' ,'Data' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Data' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3862 ,21510 ,3 ,0 );

insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3862,21508,1,21508);

insert into db_sysforkey values(3862,21509,1,154,0);

insert into db_sysindices values(4270,'levantamentopatrimonial_departamento_in',3862,'0');
insert into db_syscadind values(4270,21509,1);

insert into db_syssequencia values(1000511, 'levantamentopatrimonial_p13_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000511 where codarq = 3862 and codcam = 21508;

---- tabela levantamentopatrimonialbens
insert into db_sysarquivo values (3864, 'levantamentopatrimonialbens', 'Bens do Levantamento Patrimonial', 'p14', '2015-08-26', 'Levantamento Patrimonial Bens', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (18,3864);
insert into db_sysarqarq values (3862,3864);

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21511 ,'p14_sequencial' ,'int4' ,'Código sequencial' ,'' ,'Código' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Código' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3864 ,21511 ,1 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21512 ,'p14_levantamentopatrimonial' ,'int4' ,'Levantamento Patrimonial' ,'' ,'Levantamento Patrimonial' ,10 ,'false' ,'false' ,'false' ,1 ,'text' ,'Levantamento Patrimonial' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3864 ,21512 ,2 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21513 ,'p14_placa' ,'varchar(50)' ,'Placa do Bem' ,'' ,'Placa' ,50 ,'false' ,'false' ,'false' ,1 ,'text' ,'Placa' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3864 ,21513 ,3 ,0 );

insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3864,21511,1,21511);

insert into db_sysforkey values(3864,21512,1,3862,0);

insert into db_sysindices values(4271,'levantamentopatrimonialbens_levantamentopatrimonial_in',3864,'0');
insert into db_syscadind values(4271,21512,1);

insert into db_syssequencia values(1000512, 'levantamentopatrimonialbens_p14_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000512 where codarq = 3864 and codcam = 21511;


insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10153 ,'Levantamento Patrimonial' ,'Levantamento Patrimonial' ,'pat4_importacaolevantamentopatrimonial001.php' ,'1' ,'1' ,'Importação do Arquivo de Levantamento Patrimonial' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 32 ,10153 ,460 ,439 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10154 ,'Levantamento Patrimonial' ,'Levantamento Patrimonial' ,'pat2_relatoriolevantamentopatrimonial001.php' ,'1' ,'1' ,'Relatório Levantamento Patrimonial' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 9150 ,10154 ,6 ,439 );

-- Liquidação com Desconto
insert into db_sysarquivo values (3865, 'pagordemdescontoempanulado', 'Vínculo entre tabelas pagordemdesconto e empanulado, identificando a anulação aplicada devido a um desconto.', 'e06', '2015-08-28', 'pagordemdescontoempanulado', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (38,3865);
insert into db_syscampo values(21514,'e06_sequencial','int4','Sequencial da tabela.','0', 'Sequencial',10,'f','f','f',1,'text','Sequencial');
insert into db_syscampo values(21515,'e06_pagordemdesconto','int4','Desconto da Ordem de Pagamento','0', 'Desconto da Ordem de Pagamento',10,'f','f','f',1,'text','Desconto da Ordem de Pagamento');
insert into db_syscampo values(21516,'e06_empanulado','int4','Anulação de Empenho','0', 'Anulação de Empenho',10,'f','f','f',1,'text','Anulação de Empenho');
delete from db_sysarqcamp where codarq = 3865;
insert into db_sysarqcamp values(3865,21514,1,0);
insert into db_sysarqcamp values(3865,21516,2,0);
insert into db_sysarqcamp values(3865,21515,3,0);
insert into db_syssequencia values(1000513, 'pagordemdescontoempanulado_e06_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000513 where codarq = 3865 and codcam = 21514;
delete from db_sysprikey where codarq = 3865;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3865,21516,1,21514);
delete from db_sysforkey where codarq = 3865 and referen = 0;
insert into db_sysforkey values(3865,21516,1,1030,0);
delete from db_sysforkey where codarq = 3865 and referen = 0;
insert into db_sysforkey values(3865,21515,1,2026,0);
insert into db_sysindices values(4272,'pagordemdescontoempanulado_sequencial_in',3865,'0');
insert into db_syscadind values(4272,21514,1);
insert into db_sysindices values(4273,'pagordemdescontoempanulado_empanulado_in',3865,'0');
insert into db_syscadind values(4273,21516,1);
insert into db_sysindices values(4274,'pagordemdescontoempanulado_pagordemdesconto_in',3865,'0');
insert into db_syscadind values(4274,21515,1);
---------------------------------------------------------------------------------------------
-------------------------------- FIM FINANCEIRO---------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
------------------------------ INÍCIO EDUCAÇÃO/SAÚDE ----------------------------------------
---------------------------------------------------------------------------------------------
update db_syscampo set nomecam = 'tre04_tipo', conteudo = 'int4', descricao = 'Tipo do ponto de parada.', valorinicial = '0', rotulo = 'Tipo', nulo = 'f', tamanho = 3, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Tipo' where codcam = 20089;
insert into db_syscampodef values(20089,'3','Escola de Procedência');
insert into db_sysarquivo values (3846, 'pontoparadaescolaproc', 'Guarda os vínculos existentes quando um ponto de parada trata-se de uma escola de procedência', 'tre13', '2015-08-11', 'Vínculo do Ponto de Parada e Escola de Procedência', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (60,3846);
insert into db_syscampo values(21373,'tre13_sequencial','int4','Código sequencial da tabela','0', 'Código Sequencial',10,'f','f','f',1,'text','Código Sequencial');
insert into db_syscampo values(21374,'tre13_pontoparada','int4','Código sequencial referente ao ponto de parada.','0', 'Ponto de Parada',10,'f','f','f',1,'text','Ponto de Parada');
insert into db_syscampo values(21375,'tre13_escolaproc','int4','Código sequencial da tabela escolaproc','0', 'Escola de Procedência',10,'f','f','f',1,'text','Escola de Procedência');
insert into db_sysarqcamp values(3846,21373,1,0);
insert into db_sysarqcamp values(3846,21374,2,0);
insert into db_sysarqcamp values(3846,21375,3,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3846,21373,1,21374);
insert into db_sysforkey values(3846,21374,1,3601,0);
insert into db_sysforkey values(3846,21375,1,1010140,0);
insert into db_sysindices values(4247,'pontoparadaescolaproc_pontoparada_escolaproc_in',3846,'1');
insert into db_syscadind values(4247,21374,1);
insert into db_syscadind values(4247,21375,2);
insert into db_syssequencia values(1000497, 'pontoparadaescolaproc_tre13_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000497 where codarq = 3846 and codcam = 21373;

-- Matricula Online
delete from db_sysarqcamp   where codcam in ( 3009245, 3009246, 3009247, 3009248, 3009250, 3009251, 3009252, 3009253, 3009254, 3009255, 3009256, 3009257, 3009258, 3009259, 3009260, 3009261, 3009262, 3009263, 3009264, 3009265, 3009266, 3009267, 3009268, 3009269, 3009270, 3009271, 3009272, 3009273, 3009274, 3009275, 3009276, 3009277, 3009278, 3009279, 3009280, 3009281, 3009282, 3009283, 3009284, 3009285, 3009286, 3009287, 3009288, 3009289, 3009290, 3009291, 3009292, 3009293, 3009294, 3009295, 3009296, 3009297, 3009298, 3009299, 3009300, 3009301, 3009302, 3009303, 3009304, 3009305, 3009306, 3009307, 3009308, 3009309, 3009310, 3009311, 3009312, 3009313, 3009314, 3009315, 3009316, 3009317, 3009318, 3009319, 3009320, 3009321, 3009322, 3009323, 3009324, 3009325, 3009327, 3009328, 3009329, 3009330, 3009331, 3009332, 3009333, 3009334, 3009335 );
delete from db_sysforkey    where codcam in ( 3009245, 3009246, 3009247, 3009248, 3009250, 3009251, 3009252, 3009253, 3009254, 3009255, 3009256, 3009257, 3009258, 3009259, 3009260, 3009261, 3009262, 3009263, 3009264, 3009265, 3009266, 3009267, 3009268, 3009269, 3009270, 3009271, 3009272, 3009273, 3009274, 3009275, 3009276, 3009277, 3009278, 3009279, 3009280, 3009281, 3009282, 3009283, 3009284, 3009285, 3009286, 3009287, 3009288, 3009289, 3009290, 3009291, 3009292, 3009293, 3009294, 3009295, 3009296, 3009297, 3009298, 3009299, 3009300, 3009301, 3009302, 3009303, 3009304, 3009305, 3009306, 3009307, 3009308, 3009309, 3009310, 3009311, 3009312, 3009313, 3009314, 3009315, 3009316, 3009317, 3009318, 3009319, 3009320, 3009321, 3009322, 3009323, 3009324, 3009325, 3009327, 3009328, 3009329, 3009330, 3009331, 3009332, 3009333, 3009334, 3009335 );
delete from db_syscampo     where codcam in ( 3009245, 3009246, 3009247, 3009248, 3009250, 3009251, 3009252, 3009253, 3009254, 3009255, 3009256, 3009257, 3009258, 3009259, 3009260, 3009261, 3009262, 3009263, 3009264, 3009265, 3009266, 3009267, 3009268, 3009269, 3009270, 3009271, 3009272, 3009273, 3009274, 3009275, 3009276, 3009277, 3009278, 3009279, 3009280, 3009281, 3009282, 3009283, 3009284, 3009285, 3009286, 3009287, 3009288, 3009289, 3009290, 3009291, 3009292, 3009293, 3009294, 3009295, 3009296, 3009297, 3009298, 3009299, 3009300, 3009301, 3009302, 3009303, 3009304, 3009305, 3009306, 3009307, 3009308, 3009309, 3009310, 3009311, 3009312, 3009313, 3009314, 3009315, 3009316, 3009317, 3009318, 3009319, 3009320, 3009321, 3009322, 3009323, 3009324, 3009325, 3009327, 3009328, 3009329, 3009330, 3009331, 3009332, 3009333, 3009334, 3009335 );

delete from db_sysarqmod    where codmod = 3008005;
delete from db_sysforkey    where codarq in (3010192 ,3010193 ,3010194 ,3010195 ,3010196 ,3010197 ,3010198 ,3010199 ,3010200 ,3010201 ,3010202 ,3010203);
delete from db_sysarquivo   where codarq in (3010192 ,3010193 ,3010194 ,3010195 ,3010196 ,3010197 ,3010198 ,3010199 ,3010200 ,3010201 ,3010202 ,3010203);
delete from db_sysmodulo    where codmod = 3008005;
delete from db_syssequencia where codsequencia in ( 3000264, 3000265, 3000266, 3000268, 3000269, 3000271, 3000272, 3000273, 3000267, 3000274, 3000275 );

delete from db_menu where modulo in ( select id_item from db_modulos where nome_modulo = 'Matricula On-Line' and id_item = 3000112 );
delete from atendcadareamod where at26_id_item in ( select id_item from db_modulos where nome_modulo = 'Matricula On-Line' and id_item = 3000112 );
delete from db_modulos where nome_modulo = 'Matricula On-Line' and id_item = 3000112;

-- Módulo Matrícula On-line
insert into db_itensmenu values( 10094, 'Matrícula On-line', 'Matrícula On-line', '', '2', '1', 'Matrícula On-line', '1'  );
insert into db_modulos values( 10094, 'Matrícula On-line', 'Matrícula On-line', '', 'f');
insert into atendcadareamod ( at26_sequencia ,at26_codarea ,at26_id_item ) values ( 75 ,8 ,10094 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10094 ,29 ,1 ,10094 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10094 ,30 ,2 ,10094 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10094 ,31 ,3 ,10094 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10094 ,32 ,4 ,10094 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10095 ,'Vagas' ,'Vagas' ,'mol1_vagas001.php' ,'1' ,'1' ,'Cadastro de vagas que existem para as etapas de uma determinada fase.' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 29 ,10095 ,260 ,10094 );
insert into db_sysmodulo values ( 80,'matriculaonline','Módulo de matrícula on-line','2015-06-11','t');

-- Tabela ciclos
insert into db_sysarquivo values (3823, 'ciclos', 'Tabela de ciclos de matrículas on-line', 'mo09', '2015-06-11', 'ciclos', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod  select codmod, 3823 from db_sysmodulo where nomemod = 'matriculaonline';
insert into db_syscampo values(21223,'mo09_codigo','int8','Código','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21224,'mo09_status','bool','Status','\'f\'', 'Status',1,'f','f','f',5,'text','Status');
insert into db_syscampo values(21225,'mo09_dtcad','date','Data de Cadastro','null', 'Data de Cadastro',10,'f','f','f',1,'text','Data de Cadastro');
insert into db_syscampo values(21226,'mo09_descricao','varchar(100)','Descrição','', 'Descrição',100,'f','t','f',0,'text','Descrição');
insert into db_syscampo values(21227,'mo09_sigla','varchar(10)','Sigla','', 'Sigla',10,'t','t','f',0,'text','Sigla');
insert into db_syscampo values(21236,'mo09_eja','bool','Controla se o ciclo da matrícula online é referente a EJA.','f', 'Eja',1,'f','f','f',5,'text','Eja?');
insert into db_sysarqcamp values(3823,21223,1,1000477);
insert into db_sysarqcamp values(3823,21224,2,0);
insert into db_sysarqcamp values(3823,21225,3,0);
insert into db_sysarqcamp values(3823,21226,4,0);
insert into db_sysarqcamp values(3823,21227,5,0);
insert into db_sysarqcamp values(3823,21236,7,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3823,21223,1,21226);
insert into db_syssequencia values(1000477, 'ciclos_mo09_codigo_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000477 where codarq = 3823 and codcam = 21223;

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10100 ,'Ciclos' ,'Ciclos' ,'' ,'1' ,'1' ,'Menu para manutenção dos ciclos da matrícula online.' ,'true' );

insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 29 ,10100 ,261 ,10094 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10101 ,'Inclusão' ,'Inclusão' ,'mol1_ciclos001.php' ,'1' ,'1' ,'Inclusão de novos ciclos.' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10100 ,10101 ,1 ,10094 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10102 ,'Alteração' ,'Alteração' ,'mol1_ciclos002.php' ,'1' ,'1' ,'Alteração das informações de um ciclo.' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10100 ,10102 ,2 ,10094 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10103 ,'Exclusão' ,'Exclusão' ,'mol1_ciclos003.php' ,'1' ,'1' ,'Exclusão de ciclos referentes a matrícula online.' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10100 ,10103 ,3 ,10094 );

-- Menu Fase
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10104 ,'Fases' ,'Fases' ,'' ,'1' ,'1' ,'Fases' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 29 ,10104 ,262 ,10094 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10105 ,'Inclusão' ,'Inclusão' ,'mol1_fase001.php' ,'1' ,'1' ,'Inclusão de uma Fase.' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10104 ,10105 ,1 ,10094 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10106 ,'Alteração' ,'Alteração' ,'mol1_fase002.php' ,'1' ,'1' ,'Alteração de uma Fase.' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10104 ,10106 ,2 ,10094 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10107 ,'Exclusão' ,'Exclusão' ,'mol1_fase003.php' ,'1' ,'1' ,'Exclusão de uma Fase.' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10104 ,10107 ,3 ,10094 );



--Menu Idade por Etapa

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10143 ,'Idade por Etapa' ,'Idade por Etapa' ,'mol1_idadeetapa001.php' ,'1' ,'1' ,' Idade por Etapa' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 29 ,10143 ,265 ,10094 );

-- Menu Escola Por Bairro
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10145 ,'Escola por Bairro' ,'Escola por Bairro' ,'mol1_escolaporbairro001.php' ,'1' ,'1' ,'Manutenção dos vínculos de escolas com bairros' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 29 ,10145 ,266 ,10094 );

-- Tabela Fase
insert into db_sysarquivo values (3827, 'fase', 'Cadastro de Fases do Matrícula On-line', 'mo04', '2015-06-12', 'Fase', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (80, 3827);
insert into db_syscampo values(21238,'mo04_codigo','int8','Código da tabela Fase','0', 'Código',8,'f','f','f',1,'text','Código');
insert into db_syscampo values(21239,'mo04_desc','varchar(100)','Descrição da Fase','', 'Descrição',100,'f','t','f',0,'text','Descrição');
insert into db_syscampo values(21240,'mo04_anousu','int4','Ano da Fase','0', 'Ano',4,'f','f','f',1,'text','Ano');
insert into db_syscampo values(21241,'mo04_dtfim','date','Data Final da Fase','null', 'Data Fim',10,'f','f','f',1,'text','Data Fim');
insert into db_syscampo values(21242,'mo04_dtini','date','Data de Início da Fase','null', 'Data Início',10,'f','f','f',1,'text','Data Início');
insert into db_syscampo values(21243,'mo04_ciclo','int8','Ciclo da fase - referencia a tabela cilcos','0', 'Ciclo',8,'f','f','f',1,'text','Ciclo');
insert into db_syscampo (codcam, nomecam, conteudo, descricao, valorinicial, rotulo, tamanho, nulo, maiusculo, autocompl, aceitatipo, tipoobj, rotulorel)
  values ( 21432, 'mo04_datacorte', 'date', 'Data de corte para matricula dos alunos', null, 'Data de Corte', 10, 'f', 'f', 'f', 1, 'text', 'Data de Corte');
insert into db_syscampo values(21498,'mo04_processada','bool','Fase é considerada processada após ser realizada a rotina de designação.','f', 'Processada',1,'f','f','f',5,'text','Processada');

insert into db_sysarqcamp values(3827,21238,1,0);
insert into db_sysarqcamp values(3827,21239,2,0);
insert into db_sysarqcamp values(3827,21240,3,0);
insert into db_sysarqcamp values(3827,21241,4,0);
insert into db_sysarqcamp values(3827,21242,5,0);
insert into db_sysarqcamp values(3827,21243,6,0);
insert into db_sysarqcamp values(3827,21432,7,0);
insert into db_sysarqcamp values(3827,21498,8,0);

insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3827,21238,1,21239);
insert into db_sysforkey values(3827,21243,1,3823,0);

insert into db_syssequencia values(1000480, 'fase_mo04_codigo_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000480 where codarq = 3827 and codcam = 21238;

-- Tabela ciclosensino
insert into db_sysarquivo values (3829, 'ciclosensino', 'Guarda os ensinos que estão vinculados a um ciclo.', 'mo14', '2015-06-12', 'Ensinos de um Ciclo', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (80, 3829);
insert into db_syscampo values(21246,'mo14_sequencial','int4','Código do vínculo de um ensino ao ciclo','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21247,'mo14_ciclo','int4','Código do ciclo.','0', 'Ciclo',10,'f','f','f',1,'text','Ciclo');
insert into db_syscampo values(21249,'mo14_ensino','int4','Código do ensino vinculado ao ciclo.','0', 'Ensino',10,'f','f','f',1,'text','Ensino');

insert into db_sysarqcamp values(3829,21246,1,0);
insert into db_sysarqcamp values(3829,21247,2,0);
insert into db_sysarqcamp values(3829,21249,3,0);

insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3829,21246,1,21247);
insert into db_sysforkey values(3829,21247,1,3823,0);

insert into db_sysforkey values(3829,21249,1,1010045,0);
insert into db_sysindices values(4224,'ciclosensino_ciclo_ensino_in',3829,'1');
insert into db_syscadind values(4224,21247,1);
insert into db_syscadind values(4224,21249,2);
insert into db_syssequencia values(1000482, 'ciclosensino_mo14_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000482 where codarq = 3829 and codcam = 21246;

-- Tabela vagas

insert into db_sysarquivo values (3831, 'vagas', 'Vagas', 'mo10', '2015-06-12', 'Vagas', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (80, 3831);
insert into db_syscampo values(21250,'mo10_codigo','int8','Código da Vaga','0', 'Código Vaga',10,'t','f','f',1,'text','Código Vaga');
insert into db_syscampo values(21251,'mo10_fase','int8','Fase','0', 'Fase',10,'t','f','f',1,'text','Fase');
insert into db_syscampo values(21252,'mo10_escola','int8','Escola','0', 'Escola',10,'t','f','f',1,'text','Escola');
insert into db_syscampo values(21253,'mo10_ensino','int8','Ensino','0', 'Ensino',10,'t','f','f',1,'text','Ensino');
insert into db_syscampo values(21254,'mo10_serie','int8','Serie','0', 'Serie',10,'t','f','f',1,'text','Serie');
insert into db_syscampo values(21255,'mo10_turno','int8','Turno','0', 'Turno',10,'t','f','f',1,'text','Turno');
insert into db_syscampo values(21256,'mo10_numvagas','int4','Número de Vagas','0', 'Número de Vagas',10,'t','f','f',1,'text','Número de Vagas');
insert into db_syscampo values(21257,'mo10_saldovagas','int4','Saldo de Vagas','0', 'Saldo de Vagas',10,'t','f','f',1,'text','Saldo de Vagas');
insert into db_sysarqcamp values(3831,21250,1,0);
insert into db_sysarqcamp values(3831,21251,2,0);
insert into db_sysarqcamp values(3831,21252,3,0);
insert into db_sysarqcamp values(3831,21253,4,0);
insert into db_sysarqcamp values(3831,21254,5,0);
insert into db_sysarqcamp values(3831,21255,6,0);
insert into db_sysarqcamp values(3831,21256,7,0);
insert into db_sysarqcamp values(3831,21257,8,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3831,21250,1,21250);
insert into db_sysforkey values(3831,21253,1,1010045,0);
insert into db_sysforkey values(3831,21252,1,1010031,0);
insert into db_sysforkey values(3831,21254,1,1010047,0);
insert into db_sysforkey values(3831,21255,1,1010038,0);
insert into db_sysforkey values(3831,21251,1,3827,0);
insert into db_syssequencia values(1000483, 'vagas_mo10_codigo_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000483 where codarq = 3831 and codcam = 21250;


-- tabela mobase
insert into db_sysarquivo values (3847, 'mobase', 'Cadastro base da matrícula online', 'mo01', '2015-08-17', 'Cadastro base da matrícula online', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (80,3847);
insert into db_syscampo values(21378,'mo01_codigo','int4','Cadastro base da matricula online','0', 'Código da Matricula',10,'f','f','f',1,'text','Código da Matricula');
insert into db_syscampo values(21379,'mo01_nome','varchar(70)','Nome do Aluno','', 'Nome do Aluno',70,'f','t','f',0,'text','Nome do Aluno');
insert into db_syscampo values(21380,'mo01_tipoender','varchar(10)','Tipo do Logradouro','', 'Tipo do Logradouro',10,'t','t','f',0,'text','Tipo do Logradouro');
insert into db_syscampo values(21381,'mo01_ender','varchar(100)','Endereço','', 'Endereço',100,'f','t','f',0,'text','Endereço');
insert into db_syscampo values(21382,'mo01_numero','varchar(10)','Número','', 'Número',10,'t','t','f',0,'text','Número');
insert into db_syscampo values(21383,' mo01_compl','varchar(20)','Complemento','', 'Complemento',20,'f','t','f',0,'text','Complemento');
insert into db_syscampo values(21384,'mo01_bairro','int4','Bairro','0', 'Bairro',10,'f','f','f',1,'text','Bairro');
insert into db_syscampo values(21385,'mo01_cep','varchar(20)','CEP','', 'CEP',20,'f','t','f',0,'text','CEP');
insert into db_syscampo values(21386,'mo01_uf','varchar(5)','UF','', 'UF',5,'t','t','f',0,'text','UF');
insert into db_syscampo values(21387,'mo01_municip','varchar(100)','Municipio','', 'Municipio',100,'f','t','f',0,'text','Municipio');
insert into db_syscampo values(21388,'mo01_nacion','varchar(40)','Nacionalidade','', 'Nacionalidade',40,'f','t','f',0,'text','Nacionalidade');
insert into db_syscampo values(21389,'mo01_telef','varchar(12)','Telefone de contato','', 'Telefone de contato',12,'t','t','f',0,'text','Telefone de contato');
insert into db_syscampo values(21390,'mo01_ident','varchar(20)','Documento de Identidade','', 'Documento de Identidade',20,'t','t','f',0,'text','Documento de Identidade');
insert into db_syscampo values(21391,'mo01_orgident','varchar(20)','Orgão Emissor','', 'Orgão Emissor',20,'t','t','f',0,'text','Orgão Emissor');
insert into db_syscampo values(21392,'mo01_tiporesp','int4','Tipo do Responsável Legal','0', 'Tipo do Responsável Legal',10,'f','f','f',1,'text','Tipo do Responsável Legal');
insert into db_syscampo values(21393,'mo01_nomeresp','varchar(70)','Responsavel Legal','', 'Responsável Legal',70,'t','t','f',0,'text','Responsável Legal');
insert into db_syscampo values(21394,'mo01_telresp','varchar(12)','Telefone do Responsável Legal','', 'Telefone do Responsável Legal',12,'t','t','f',0,'text','Telefone do Responsável Legal');
insert into db_syscampo values(21395,'mo01_identresp','varchar(20)','Documento de Identidade Resp. Legal','', 'Documento de Identidade Resp. Legal',20,'t','t','f',0,'text','Documento de Identidade Resp. Legal');
insert into db_syscampo values(21396,'mo01_orgidresp','varchar(20)','Orgão Emissor do documento de Identidade do Responsável Legal','', 'Orgão Emissor Resp Legal',20,'t','t','f',0,'text','Orgão Emissor Resp Legal');
insert into db_syscampo values(21397,'mo01_cpfresp','varchar(11)','CPF Responsável Legal','', 'CPF Responsável Legal',11,'t','t','f',0,'text','CPF Responsável Legal');
insert into db_syscampo values(21398,'mo01_emailresp','varchar(50)','Email Responsável Legal','', 'Email Responsável Legal',50,'t','t','f',0,'text','Email Responsável Legal');
insert into db_syscampo values(21399,'mo01_certidaotipo','int4','Tipo da Certidao','0', 'Tipo da Certidao',1,'t','f','f',1,'text','Tipo da Certidao');
insert into db_syscampo values(21400,'mo01_certidaonum','varchar(8)','Número da Certidão','', 'Número da Certidão',8,'t','t','f',0,'text','Número da Certidão');
insert into db_syscampo values(21401,'mo01_certidaolivro','varchar(8)','Livro da Certidão','', 'Livro da Certidão',8,'t','t','f',0,'text','Livro da Certidão');
insert into db_syscampo values(21402,'mo01_certidaofolha','varchar(4)','Folha da Certidão','', 'Folha da Certidão',4,'t','t','f',0,'text','Folha da Certidão');
insert into db_syscampo values(21403,'mo01_certidaocart','varchar(150)','Cartório da Certidão','', 'Cartório da Certidão',150,'t','t','f',0,'text','Cartório da Certidão');
insert into db_syscampo values(21404,'mo01_ufcartcert','int4','UF do cartório','0', 'UF do cartório',10,'t','f','f',1,'text','UF do cartório');
insert into db_syscampo values(21405,'mo01_muncartcert','int4','Município do Cartório','0', 'Município do Cartório',10,'t','f','f',1,'text','Município do Cartório');
insert into db_syscampo values(21406,'mo01_certidaodata','date','Data de Emissão da Certidão','null', 'Data de Emissão da Certidão',10,'t','f','f',1,'text','Data de Emissão da Certidão');
insert into db_syscampo values(21407,'mo01_nis','varchar(11)','NIS do Aluno','', 'NIS do Aluno',11,'t','t','f',0,'text','NIS do Aluno');
insert into db_syscampo values(21408,'mo01_dtnasc','date','Data de Nascimento','null', 'Data de Nascimento',10,'f','f','f',1,'text','Data de Nascimento');
insert into db_syscampo values(21409,'mo01_ufnasc','int4','UF de Nascimento','0', 'UF de Nascimento',10,'t','f','f',1,'text','UF de Nascimento');
insert into db_syscampo values(21410,'mo01_munnasc','int4','Município de Nascimento','0', 'Município de Nascimento',10,'t','f','f',1,'text','Município de Nascimento');
insert into db_syscampo values(21411,'mo01_estciv','int4','Estado Civil','0', 'Estado Civil',10,'t','f','f',1,'text','Estado Civil');
insert into db_syscampo values(21412,'mo01_cpf','varchar(11)','CPF','', 'CPF',11,'t','t','f',0,'text','CPF');
insert into db_syscampo values(21413,'mo01_email','varchar(100)','Email do Aluno','', 'Email do Aluno',100,'t','t','f',0,'text','Email do Aluno');
insert into db_syscampo values(21414,'mo01_mae','varchar(70)','Nome da Mãe','', 'Nome da Mãe',70,'t','t','f',0,'text','Nome da Mãe');
insert into db_syscampo values(21415,'mo01_pai','varchar(70)','Nome do Pai','', 'Nome do Pai',70,'t','t','f',0,'text','Nome do Pai');
insert into db_syscampo values(21416,'mo01_sexo','char(1)','Sexo do Aluno','', 'Sexo do Aluno',1,'f','t','f',0,'text','Sexo do Aluno');
insert into db_syscampo values(21417,'mo01_telcel','varchar(12)','Telefone Celular do Aluno','', 'Telefone Celular do Aluno',12,'t','t','f',0,'text','Telefone Celular do Aluno');
insert into db_syscampo values(21418,'mo01_serie','int4','Etapa selecionada','0', 'Etapa selecionada',10,'f','f','f',1,'text','Etapa selecionada');
insert into db_syscampo values(21419,'mo01_redeorigem','int4','Rede de Origem ','0', 'Rede de Origem ',10,'f','f','f',1,'text','Rede de Origem ');
insert into db_syscampo values(21420,'mo01_datacad','date','Data de Cadastro','null', 'Data de Cadastro',10,'f','f','f',1,'text','Data de Cadastro');
insert into db_syscampo values(21421,'mo01_necess','int4','Necessidades Especiais','0', 'Necessidades Especiais',10,'t','f','f',1,'text','Necessidades Especiais');
insert into db_syscampo values(21422,'mo01_certidaomatricula','varchar(32)','Matricula da Certidão ','', 'Matricula da Certidão ',32,'t','t','f',0,'text','Matricula da Certidão ');
insert into db_syscampo values(21499,'mo01_bolsafamilia','bool','Bolsa Família','false', 'Bolsa Família',1,'t','f','f',5,'text','Bolsa Família');
insert into db_syscampo values(21500,'mo01_responsaveltrabalhador','bool','Responsável pelo aluno possui trabalho','false', 'Responsável Trabalhador ',1,'t','f','f',5,'text','Responsável Trabalhador ');

delete from db_sysarqcamp where codarq = 3847;
insert into db_sysarqcamp values(3847,21378,1,0);
insert into db_sysarqcamp values(3847,21379,2,0);
insert into db_sysarqcamp values(3847,21380,3,0);
insert into db_sysarqcamp values(3847,21381,4,0);
insert into db_sysarqcamp values(3847,21382,5,0);
insert into db_sysarqcamp values(3847,21383,6,0);
insert into db_sysarqcamp values(3847,21384,7,0);
insert into db_sysarqcamp values(3847,21385,8,0);
insert into db_sysarqcamp values(3847,21386,9,0);
insert into db_sysarqcamp values(3847,21387,10,0);
insert into db_sysarqcamp values(3847,21388,11,0);
insert into db_sysarqcamp values(3847,21389,12,0);
insert into db_sysarqcamp values(3847,21390,13,0);
insert into db_sysarqcamp values(3847,21391,14,0);
insert into db_sysarqcamp values(3847,21392,15,0);
insert into db_sysarqcamp values(3847,21393,16,0);
insert into db_sysarqcamp values(3847,21394,17,0);
insert into db_sysarqcamp values(3847,21395,18,0);
insert into db_sysarqcamp values(3847,21396,19,0);
insert into db_sysarqcamp values(3847,21397,20,0);
insert into db_sysarqcamp values(3847,21398,21,0);
insert into db_sysarqcamp values(3847,21399,22,0);
insert into db_sysarqcamp values(3847,21400,23,0);
insert into db_sysarqcamp values(3847,21401,24,0);
insert into db_sysarqcamp values(3847,21402,25,0);
insert into db_sysarqcamp values(3847,21403,26,0);
insert into db_sysarqcamp values(3847,21404,27,0);
insert into db_sysarqcamp values(3847,21405,28,0);
insert into db_sysarqcamp values(3847,21406,29,0);
insert into db_sysarqcamp values(3847,21407,30,0);
insert into db_sysarqcamp values(3847,21408,31,0);
insert into db_sysarqcamp values(3847,21409,32,0);
insert into db_sysarqcamp values(3847,21410,33,0);
insert into db_sysarqcamp values(3847,21411,34,0);
insert into db_sysarqcamp values(3847,21412,35,0);
insert into db_sysarqcamp values(3847,21413,36,0);
insert into db_sysarqcamp values(3847,21414,37,0);
insert into db_sysarqcamp values(3847,21415,38,0);
insert into db_sysarqcamp values(3847,21416,39,0);
insert into db_sysarqcamp values(3847,21417,40,0);
insert into db_sysarqcamp values(3847,21418,41,0);
insert into db_sysarqcamp values(3847,21419,42,0);
insert into db_sysarqcamp values(3847,21420,43,0);
insert into db_sysarqcamp values(3847,21421,44,0);
insert into db_sysarqcamp values(3847,21422,45,0);
insert into db_sysarqcamp values(3847,21499,46,0);
insert into db_sysarqcamp values(3847,21500,47,0);

delete from db_sysprikey where codarq = 3847;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3847,21378,1,21379);
insert into db_sysindices values(4249,'mobase_serie_in',3847,'0');
insert into db_syscadind values(4249,21418,1);
insert into db_sysindices values(4250,'mobase_redeorigem_in',3847,'0');
insert into db_syscadind values(4250,21419,1);
insert into db_sysindices values(4251,'mobase_nome_in',3847,'0');
insert into db_syscadind values(4251,21379,1);
insert into db_sysindices values(4252,'mobase_cpfresp_in',3847,'0');
insert into db_syscadind values(4252,21397,1);
insert into db_sysforkey values(3847,21418,1,1010047,0);
insert into db_sysforkey values(3847,21384,1,11,0);
insert into db_sysindices values(4253,'mobase_bairro_in',3847,'0');
insert into db_syscadind values(4253,21384,1);
insert into db_sysforkey values(3847,21411,1,3852,0);
insert into db_sysforkey values(3847,21419,1,3850,0);
insert into db_sysforkey values(3847,21392,1,3848,0);
insert into db_syssequencia values(1000498, 'mobase_mo01_codigo_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000498 where codarq = 3847 and codcam = 21378;


--tabela tiporesp

insert into db_sysarquivo values (3848, 'tiporesp', 'Tipos de Responsáveis Legais', 'mo06', '2015-08-17', 'Tipos de Responsáveis Legais', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (80,3848);
insert into db_syscampo values(21423,'mo06_codigo','int4','Código','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21424,'mo06_descr','varchar(100)','Descrição','', 'Descrição',100,'f','t','f',0,'text','Descrição');
delete from db_sysarqcamp where codarq = 3848;
insert into db_sysarqcamp values(3848,21423,1,0);
insert into db_sysarqcamp values(3848,21424,2,0);
delete from db_sysprikey where codarq = 3848;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3848,21423,1,21424);
insert into db_syssequencia values(1000499, 'tiporesp_mo06_codigo_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000499 where codarq = 3848 and codcam = 21423;

--tabela redeorigem
insert into db_sysarquivo values (3850, 'redeorigem', 'Rede de Origem', 'mo05', '2015-08-17', 'Rede de Origem', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (80,3850);
insert into db_syscampo values(21425,'mo05_codigo','int4','Codigo','0', 'Codigo',10,'f','f','f',1,'text','Codigo');
insert into db_syscampo values(21426,'mo05_descr','varchar(100)','Descrição','', 'Descrição',100,'f','t','f',0,'text','Descrição');
delete from db_sysarqcamp where codarq = 3850;
insert into db_sysarqcamp values(3850,21425,1,0);
insert into db_sysarqcamp values(3850,21426,2,0);
delete from db_sysprikey where codarq = 3850;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3850,21425,1,21426);
insert into db_syssequencia values(1000500, 'redeorigem_mo05_codigo_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000500 where codarq = 3850 and codcam = 21425;

--tabela idadeetapa
insert into db_sysarquivo values (3851, 'idadeetapa', 'Lista de etapas e suas idades', 'mo15', '2015-08-17', 'Idade de Etapas', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (80,3851);
insert into db_syscampo values(21428,'mo15_sequencial','int4','Código Sequencial','0', 'Código Sequencial',10,'f','f','f',1,'text','Código Sequencial');
insert into db_syscampo values(21429,'mo15_etapa','int4','Código Sequencial','0', 'Etapa',10,'f','f','f',1,'text','Etapa');
insert into db_syscampo values(21430,'mo15_idadeinicial','varchar(100)','Idade Inicial','', 'Idade Inicial',100,'t','t','f',0,'text','Idade Inicial');
insert into db_syscampo values(21431,'mo15_idadefinal','varchar(100)','Idade Final','', 'Idade Final',100,'t','t','f',0,'text','Idade Final');
delete from db_sysarqcamp where codarq = 3851;
insert into db_sysarqcamp values(3851,21428,1,0);
insert into db_sysarqcamp values(3851,21429,2,0);
insert into db_sysarqcamp values(3851,21430,3,0);
insert into db_sysarqcamp values(3851,21431,4,0);
delete from db_sysprikey where codarq = 3851;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3851,21428,1,21429);
delete from db_sysforkey where codarq = 3851 and referen = 0;
insert into db_sysforkey values(3851,21429,1,1010047,0);
insert into db_sysindices values(4254,'idadeetapa_etapa_in',3851,'0');
insert into db_syscadind values(4254,21429,1);
insert into db_syssequencia values(1000501, 'idadeetapa_mo15_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000501 where codarq = 3851 and codcam = 21428;

-- tabela estcivil
insert into db_sysarquivo values (3852, 'estcivil', 'Cadastro de estado civil.', 'mo07', '2015-08-17', 'Estado Civil', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (80,3852);
insert into db_syscampo values(21433,'mo07_codigo','int4','Código do Estado Civil','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21434,'mo07_descr','varchar(50)','Descrição do Estado Civil','', 'Descrição',50,'f','t','f',0,'text','Descrição');
insert into db_sysarqcamp values(3852,21433,1,0);
insert into db_sysarqcamp values(3852,21434,2,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3852,21433,1,21434);
insert into db_syssequencia values(1000502, 'estcivil_mo07_codigo_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000502 where codarq = 3852 and codcam = 21433;

insert into db_sysarquivo values (3853, 'escbairro', 'Bairro onde escola atende', 'mo08', '2015-08-17', 'Escola Bairro', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod  values (80,3853);
insert into db_syscampo   values(21435,'mo08_codigo','int4','Código sequencial','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo   values(21436,'mo08_escola','int4','Escola ','0', 'Escola',10,'f','f','f',1,'text','Escola');
insert into db_syscampo   values(21437,'mo08_bairro','int4','Bairro da escola','0', 'Bairro ',10,'f','f','f',1,'text','Bairro ');
insert into db_sysarqcamp values(3853,21435,1,0);
insert into db_sysarqcamp values(3853,21436,2,0);
insert into db_sysarqcamp values(3853,21437,3,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3853,21435,1,21435);
insert into db_sysforkey  values(3853,21436,1,1010031,0);
insert into db_sysforkey  values(3853,21437,1,11,0);
insert into db_sysindices values(4255,'escbairro_escola_in',3853,'0');
insert into db_syscadind  values(4255,21436,1);
insert into db_sysindices values(4256,'escbairro_bairro_in',3853,'0');
insert into db_syscadind  values(4256,21437,1);
insert into db_syssequencia values(1000503, 'escbairro_mo08_codigo_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000503 where codarq = 3853 and codcam = 21435;

-- tabela basefase
insert into db_sysarquivo values (3854, 'basefase', 'Tabela de vínculo entra a Base (mobase = matricula do aluno) e a Fase (período de matrícula)', 'mo12', '2015-08-17', 'Base da Fase', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (80,3854);
insert into db_syscampo values(21438,'mo12_codigo','int4','Sequencial da tabela','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21439,'mo12_base','int4','Base que a fase está vinculada.','0', 'Base',10,'f','f','f',1,'text','Base');
insert into db_syscampo values(21440,'mo12_fase','int4','Fase na qual a base está vinculada.','0', 'Fase',10,'f','f','f',1,'text','Fase');
insert into db_syscampo values(21441,'mo12_status','bool','Status do vínculo entra a Base e a Fase.','false', 'Status',1,'f','f','f',5,'text','Status');
insert into db_sysarqcamp values(3854,21438,1,0);
insert into db_sysarqcamp values(3854,21439,2,0);
insert into db_sysarqcamp values(3854,21440,3,0);
insert into db_sysarqcamp values(3854,21441,4,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3854,21438,1,21438);
insert into db_sysforkey values(3854,21439,1,3847,0);
insert into db_sysforkey values(3854,21440,1,3827,0);
insert into db_sysindices values(4257,'basefase_base_in',3854,'0');
insert into db_syscadind values(4257,21439,1);
insert into db_sysindices values(4258,'basefase_fase_in',3854,'0');
insert into db_syscadind values(4258,21440,1);
insert into db_syssequencia values(1000504, 'basefase_mo12_codigo_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000504 where codarq = 3854 and codcam = 21438;

insert into db_sysarquivo values (3855, 'basenecess', 'Necessidade especial que o candidato a aluno possui.', 'mo11', '2015-08-17', 'Necessidade Candidato', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (80,3855);
insert into db_syscampo values(21442,'mo11_codigo','int4','Código sequencia.','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21443,'mo11_base','int4','Necessidade especial de um \"Candidato\" (quem solicitou matricula) possui. ','0', 'Candidato',10,'f','f','f',1,'text','Candidato');
insert into db_syscampo values(21444,'mo11_necess','int4','Necessidade especial','0', 'Necessidade',10,'f','f','f',1,'text','Necessidade');
insert into db_syscampo values(21445,'mo11_status','bool','Status','f', 'Status',1,'f','f','f',5,'text','Status');
insert into db_sysarqcamp values(3855,21442,1,0);
insert into db_sysarqcamp values(3855,21443,2,0);
insert into db_sysarqcamp values(3855,21444,3,0);
insert into db_sysarqcamp values(3855,21445,4,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3855,21442,1,21442);
insert into db_sysforkey values(3855,21443,1,3847,0);
insert into db_sysforkey values(3855,21444,1,1010050,0);
insert into db_sysindices values(4259,'basenecess_base_in',3855,'0');
insert into db_syscadind values(4259,21443,1);
insert into db_sysindices values(4260,'basenecess_necess_in',3855,'0');
insert into db_syscadind values(4260,21444,1);
insert into db_syssequencia values(1000505, 'basenecess_mo11_codigo_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000505 where codarq = 3855 and codcam = 21442;

-- tabela baseescola
insert into db_sysarquivo values (3856, 'baseescola', 'Vínculo da Base(mobase - Matrícula do Aluno) com a Escola', 'mo02', '2015-08-17', 'Base Escola', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (80,3856);
insert into db_syscampo values(21446,'mo02_codigo','int4','Sequencial da tabela.','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21447,'mo02_base','int4','Vínculo com a Base.','0', 'Base',10,'f','f','f',1,'text','Base');
insert into db_syscampo values(21448,' mo02_escola','int4','Vínculo com a Escola.','0', 'Escola',10,'f','f','f',1,'text','Escola');
insert into db_syscampo values(21449,'mo02_dtcad','date','Data em que foi realizado o vínculo da Base com a Escola.','null', 'Data de Cadastro',10,'f','f','f',1,'text','Data de Cadastro');
insert into db_syscampo values(21450,'mo02_status','bool','Status do vínculo entre a Escola e a Base.','false', 'Status',1,'f','f','f',5,'text','Status');
insert into db_syscampo values(21451,'mo02_escola','int4','Vínculo da Escola com a Base.','0', 'Escola',10,'f','f','f',1,'text','Escola');
insert into db_sysarqcamp values(3856,21446,1,0);
insert into db_sysarqcamp values(3856,21447,2,0);
insert into db_sysarqcamp values(3856,21451,3,0);
insert into db_sysarqcamp values(3856,21449,4,0);
insert into db_sysarqcamp values(3856,21450,5,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3856,21446,1,21446);
insert into db_sysforkey values(3856,21447,1,3847,0);
insert into db_sysforkey values(3856,21451,1,1010031,0);
insert into db_sysindices values(4261,'baseescola_base_in',3856,'0');
insert into db_syscadind values(4261,21447,1);
insert into db_sysindices values(4262,'baseescola_escola_in',3856,'0');
insert into db_syscadind values(4262,21451,1);
insert into db_syssequencia values(1000506, 'baseescola_mo02_codigo_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000506 where codarq = 3856 and codcam = 21446;

-- tabela baseescturno
insert into db_sysarquivo values (3857, 'baseescturno', 'Vínculo entra a baseescola e o turno.', 'mo03', '2015-08-17', 'Base Escola Turno', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (80,3857);
insert into db_syscampo values(21452,'mo03_codigo','int4','Sequencial da tabela.','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21453,'mo03_baseescola','int4','Vínculo com a Base Escola.','0', 'Base Escola',10,'f','f','f',1,'text','Base Escola');
insert into db_syscampo values(21454,'mo03_turno','int4','Vínculo com o Turno.','0', 'Turno',10,'f','f','f',1,'text','Turno');
insert into db_syscampo values(21455,'mo03_dtcad','date','Data que foi efetuado o vínculo entre as escolas e os turnos.','null', 'Data de Cadastro',10,'f','f','f',1,'text','Data de Cadastro');
insert into db_syscampo values(21456,'mo03_status','bool','Status do vínculo entre a inscrição do aluno com o turno da escola.','false', 'Status',1,'f','f','f',5,'text','Status');
insert into db_syscampo values(21457,'mo03_opcao','int4','Opção escolhida pelo aluno da escola em qual cursar.','0', 'Opção',10,'f','f','f',1,'text','Opção');
insert into db_sysarqcamp values(3857,21452,1,0);
insert into db_sysarqcamp values(3857,21453,2,0);
insert into db_sysarqcamp values(3857,21454,3,0);
insert into db_sysarqcamp values(3857,21455,4,0);
insert into db_sysarqcamp values(3857,21456,5,0);
insert into db_sysarqcamp values(3857,21457,6,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3857,21452,1,21452);
insert into db_sysforkey values(3857,21453,1,3856,0);
insert into db_sysforkey values(3857,21454,1,1010038,0);
insert into db_sysindices values(4263,'baseescturno_baseescola_in',3857,'0');
insert into db_syscadind values(4263,21453,1);
insert into db_sysindices values(4264,'baseescturno_turno_in',3857,'0');
insert into db_syscadind values(4264,21454,1);
insert into db_syssequencia values(1000507, 'baseescturno_mo03_codigo_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000507 where codarq = 3857 and codcam = 21452;

-- tabela alocados
insert into db_sysarquivo values (3858, 'alocados', 'Alunos que foram alocados para as escolas escolhidas.', 'mo13', '2015-08-17', 'Alocados', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (80,3858);
insert into db_syscampo values(21458,'mo13_codigo','int4','Sequencial da tabela.','0', 'Código',10,'f','f','f',1,'text','Código');
insert into db_syscampo values(21459,'mo13_base','int4','Vínculo da base (Matrícula do Aluno)','0', 'Base',10,'f','f','f',1,'text','Base');
insert into db_syscampo values(21460,'mo13_fase','int4','Vínculo com a Fase.','0', 'Fase',10,'f','f','f',1,'text','Fase');
insert into db_syscampo values(21461,'mo13_baseescturno','int4','Vínculo da base com o a escola e seu turno.','0', 'Base Escola Turno',10,'f','f','f',1,'text','Base Escola Turno');
insert into db_sysarqcamp values(3858,21458,1,0);
insert into db_sysarqcamp values(3858,21459,2,0);
insert into db_sysarqcamp values(3858,21460,3,0);
insert into db_sysarqcamp values(3858,21461,4,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3858,21458,1,21458);
insert into db_sysforkey values(3858,21459,1,3847,0);
insert into db_sysforkey values(3858,21460,1,3827,0);
insert into db_sysforkey values(3858,21461,1,3857,0);
insert into db_sysindices values(4265,'alocados_base_in',3858,'0');
insert into db_syscadind values(4265,21459,1);
insert into db_sysindices values(4266,'alocados_fase_in',3858,'0');
insert into db_syscadind values(4266,21460,1);
insert into db_sysindices values(4267,'alocados_baseescturno_in',3858,'0');
insert into db_syscadind values(4267,21461,1);
insert into db_syssequencia values(1000508, 'alocados_mo13_codigo_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000508 where codarq = 3858 and codcam = 21458;

insert into db_sysarquivo
     values (3860, 'criteriosdesignacao', 'Critérios utilizado para dar prioridades para Designação de alunos', 'mo16', '2015-08-25', 'Critérios de Designação', 0, 'f', 'f', 'f', 'f' ),
            (3861, 'criteriosdesignacaoensino', 'Critérios para Designação dos alunos no ensino', 'mo17', '2015-08-25', 'Criterios de Designacao para Ensino', 0, 'f', 'f', 'f', 'f' );

insert into db_sysarqmod
     values (80,3860),
            (80,3861);

insert into db_syscampo
     values (21502,'mo16_sequencial','int4','Código pk','0', 'Código',10,'f','f','f',1,'text','Código'),
            (21503,'mo16_descricao','varchar(30)','Descrição do critério','', 'Descrição',30,'f','t','f',0,'text','Descrição'),
            (21504,'mo17_sequencial','int4','Código sequencial','0', 'Código',10,'f','f','f',1,'text','Código'),
            (21505,'mo17_ensino','int4','Código do Ensino','0', 'Ensino',10,'f','f','f',1,'text','Ensino'),
            (21506,'mo17_criteriosdesignacao','int4','Critérios de Designação ','0', 'Critérios de Designação',10,'f','f','f',1,'text','Critérios de Designação'),
            (21507,'mo17_ordem','int4','Ordem de prioridade do critério','0', 'Ordem',10,'f','f','f',1,'text','Ordem');

insert into db_sysarqcamp
     values (3860,21502,1,0),
            (3860,21503,2,0),
            (3861,21504,1,0),
            (3861,21506,2,0),
            (3861,21505,3,0),
            (3861,21507,4,0);

insert into db_sysprikey (codarq,codcam,sequen,camiden)
     values (3860,21502,1,21503),
            (3861,21504,1,21504);

insert into db_syssequencia values(1000509, 'criteriosdesignacao_mo16_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000509 where codarq = 3860 and codcam = 21502;

insert into db_sysforkey
     values (3861,21506,1,3860,0),
            (3861,21505,1,1010045,0);

insert into db_sysindices
     values (4268,'criteriosdesignacaoensino_criteriosdesignacao_in',3861,'0'),
            (4269,'criteriosdesignacaoensino_ensino_in',3861,'0');

insert into db_syscadind
     values (4268, 21506, 1),
            (4269, 21505, 1);

insert into db_syssequencia values(1000510, 'criteriosdesignacaoensino_mo17_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000510 where codarq = 3861 and codcam = 21504;



insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10150 ,'Ordenar Critérios de Designação' ,'Ordenar Critérios de Designação' ,'mol3_ordenarcriteriosdesignacao001.php' ,'1' ,'1' ,'Ordenar Critérios de Designação no ensino selecionado' ,'true' );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10151 ,'Processar Designação' ,'Processar Designação' ,'mol3_processardesignacao001.php' ,'1' ,'1' ,'Processa a designação dos alunos de uma fase' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo )
     values ( 32 ,10150 ,458 ,10094 ),
            ( 32 ,10151 ,459 ,10094 );

insert into db_sysarquivo
    values (3866,'situacaohorus', 'Tabela de situação para os arquivos de integração do horus' , 'fa60', '2015-08-31', 'Situação Horus',0, 'f', 'f', 'f', 'f'),
           (3867,'dadoscompetenciadispensacao', 'Dados de Dispensação na competência', 'fa61', '2015-08-31', 'Dados Dispensação',0, 'f', 'f', 'f', 'f'),
           (3868,'dadoscompetenciaentrada', 'Dados de entrada da competência', 'fa62', '2015-08-31', 'Dados Entrada',0, 'f', 'f', 'f', 'f'),
           (3869,'dadoscompetenciasaida', 'Dados de saída da competência do horus', 'fa63', '2015-08-31', 'Dados Saída',0, 'f', 'f', 'f', 'f'),
           (3870, 'integracaohorusenvio', 'Envio do arquivo na competencia', 'fa64', '2015-08-31', 'Integração Horus Envio', 0, 'f', 'f', 'f', 'f' ),
           (3871, 'integracaohorusenviodadoscompetencia', 'Dados enviados de um arquivo por envio', 'fa65', '2015-08-31', 'Dados enviados por protocolo', 0, 'f', 'f', 'f', 'f' );

insert into db_sysarqmod
     values (52,3866),
            (52,3867),
            (52,3868),
            (52,3869),
            (52,3870),
            (52,3871);

-- deleta campos fa59_data e fa59_protocolo da tabela integracaohorus
delete from db_sysarqcamp where codarq = 3837 and codcam in (21295, 21298);
delete from db_syscampo where codcam in (21295, 21298);

insert into db_syscampo
     values (21517,'fa60_sequencial','int4','Código pk','0', 'Código',10,'f','f','f',1,'text','Código'),
            (21518,'fa60_descricao','varchar(30)','Descrição da situação','', 'Descrição',30,'f','t','f',0,'text','Descrição'),
            (21519,'fa59_situacaohorus','int4','Situação da integração para o arquivo na competência ','0', 'Situação Hórus',10,'f','f','f',1,'text','Situação Hórus'),
            (21520,'fa61_sequencial','int4','Código PK','0', 'Código',10,'f','f','f',1,'text','Código'),
            (21521,'fa61_far_retiradaitens','int4','Código Retirada do medicamento','0', 'Código Retirada',10,'f','f','f',1,'text','Código Retirada'),
            (21522,'fa61_integracaohorus','int4','Código Integração Hórus','0', 'Integração Hórus',10,'f','f','f',1,'text','Integração Hórus'),
            (21523,'fa61_enviar','bool','Validação realizada pelo e-cidade para validar se pode ser enviado para o webservice de integração hórus.','f', 'Enviar',1,'f','f','f',5,'text','Enviar'),
            (21524,'fa61_validadohorus','bool','Validação realizada pelo Hórus.','f', 'Validado Hórus',1,'f','f','f',5,'text','Validado Hórus'),
            (21525,'fa61_unidade','int4','UPS ','0', 'UPS',10,'f','f','f',1,'text','UPS'),
            (21526,'fa61_cnes','varchar(10)','CNES da instituição','', 'CNES',10,'f','t','f',0,'text','CNES'),
            (21527,'fa61_catmat','varchar(20)','Código do medicamento da tabela do governo','', 'CATMAT',20,'f','t','f',0,'text','CATMAT'),
            (21528,'fa61_tipo','char(1)','Tipo do produto: B - Básico; E - Especializado e S - Estratégico','B', 'Tipo',1,'f','t','f',0,'text','tipo'),
            (21529,'fa61_valor','float4','Valor do medicamento','0', 'Valor',10,'f','f','f',4,'text','Valor'),
            (21530,'fa61_validade','date','Data de Validade','null', 'Validade',10,'t','f','f',1,'text','Validade'),
            (21531,'fa61_lote','varchar(50)','Lote do medicamento','', 'Lote',50,'t','t','f',0,'text','Lote'),
            (21532,'fa61_quantidade','int4','Quantidade dispensada','0', 'Quantidade',10,'f','f','f',1,'text','Quantidade'),
            (21533,'fa61_dispensacao','date','data da Dispensação','null', 'Dispensação',10,'f','f','f',1,'text','Dispensação'),
            (21534,'fa61_cns','varchar(15)','CNS do paciente','', 'CNS',15,'t','t','f',0,'text','CNS'),
            (21535,'fa62_sequencial','int4','Código pk','0', 'Código',10,'f','f','f',1,'text','Código'),
            (21536,'fa62_integracaohorus','int4','Integração Hórus','0', 'Integração Hórus',10,'f','f','f',1,'text','Integração Hórus'),
            (21537,'fa62_matestoqueinimei','int4','Movimentação Estoque','0', 'Movimentação Estoque',10,'f','f','f',1,'text','Movimentação Estoque'),
            (21538,'fa62_unidade','int4','UPS','0', 'UPS',10,'f','f','f',1,'text','UPS'),
            (21539,'fa62_enviar','bool','Validação realizada pelo e-cidade para validar se pode ser enviado para o webservice de integração hórus.','f', 'Enviar',1,'f','f','f',5,'text','Enviar'),
            (21540,'fa62_validadohorus','bool','Validação realizada pelo Hórus.','f', 'Validado Hórus',1,'f','f','f',5,'text','Validado Hórus'),
            (21541,'fa62_cnes','varchar(10)','CNES da UPS','', 'CNES',10,'f','t','f',0,'text','CNES'),
            (21542,'fa62_catmat','varchar(20)','Código do medicamento da tabela do governo','', 'CATMAT',20,'f','t','f',0,'text','CATMAT'),
            (21543,'fa62_tipo','char(1)','Tipo do produto: B - Básico; E - Especializado e S - Estratégico','B', 'Tipo do produto',1,'f','t','f',0,'text','Tipo do produto'),
            (21544,'fa62_valor','float4','Valor medicamento','0', 'Valor',10,'f','f','f',4,'text','Valor'),
            (21545,'fa62_validade','date','Validade do medicamento','null', 'Validade',10,'t','f','f',1,'text','Validade'),
            (21546,'fa62_lote','varchar(50)','Lote medicamento','', 'Lote',50,'t','t','f',0,'text','Lote'),
            (21547,'fa62_quantidade','int4','Quantidade','0', 'Quantidade',10,'f','f','f',1,'text','Quantidade'),
            (21548,'fa62_recebimento','date','Date de recebimento/entrada','null', 'Recebimento',10,'f','f','f',1,'text','Recebimento'),
            (21549,'fa62_movimentacao','varchar(15)','Tipos de movimentação (Sigla Hórus)','', 'Tipo Movimentação',15,'f','t','f',0,'text','Tipo Movimentação'),
            (21550,'fa63_sequencial','int4','Código pk','0', 'Código',10,'f','f','f',1,'text','Código'),
            (21551,'fa63_integracaohorus','int4','Integração Hórus','0', 'Integração Hórus',10,'f','f','f',1,'text','Integração Hórus'),
            (21552,'fa63_matestoqueinimei','int4','Movimentação Estoque','0', 'Movimentação Estoque',10,'f','f','f',1,'text','Movimentação Estoque'),
            (21553,'fa63_unidade','int4','UPS','0', 'UPS',10,'f','f','f',1,'text','UPS'),
            (21554,'fa63_enviar','bool','Enviar','f', 'Enviar',1,'f','f','f',5,'text','Enviar'),
            (21555,'fa63_validadohorus','bool','Validação realizada pelo Hórus.','f', 'Validado Hórus',1,'f','f','f',5,'text','Validado Hórus'),
            (21556,'fa63_cnes','varchar(10)','CNES da Unidade','', 'CNES',10,'f','t','f',0,'text','CNES'),
            (21557,'fa63_catmat','varchar(20)','Código do medicamento da tabela do governo','', 'CATMAT',20,'f','t','f',0,'text','CATMAT'),
            (21558,'fa63_tipo','char(1)','Tipo do produto: B - Básico; E - Especializado e S - Estratégico','B', 'Tipo do produto',1,'f','t','f',0,'text','Tipo do produto'),
            (21559,'fa63_valor','float4','Valor do medicamento','0', 'Valor',10,'f','f','f',4,'text','Valor'),
            (21560,'fa63_validade','date','Data de validade do medicamento.','null', 'Validade',10,'t','f','f',1,'text','Validade'),
            (21561,'fa63_lote','varchar(50)','Lote medicamento','', 'Lote',50,'t','t','f',0,'text','Lote'),
            (21562,'fa63_quantidade','int4','Quantidade do medicamento que teve saida','0', 'Quantidade',10,'f','f','f',1,'text','Quantidade'),
            (21563,'fa63_data','date','Data de Saída','null', 'Data Saída',10,'f','f','f',1,'text','Data Saída'),
            (21564,'fa63_movimentacao','varchar(15)','Tipos de movimentação: SAÍDA POR PERDA : S-PE SAÍDA POR VALIDADE VENCIDA : S-VV','', 'Tipos de movimentação',15,'f','t','f',0,'text','Tipos de movimentação'),
            (21565,'fa64_sequencial','int4','Código PK','0', 'Código',10,'f','f','f',1,'text','Código'),
            (21566,'fa64_integracaohorus','int4','Integração Hórus','0', 'Integração Hórus',10,'f','f','f',1,'text','Integração Hórus'),
            (21567,'fa64_data','date','Data envio','null', 'Data',10,'f','f','f',1,'text','Data'),
            (21568,'fa64_hora','varchar(5)','Hora de envio','', 'Hora',5,'f','t','f',0,'text','Hora'),
            (21569,'fa64_protocolo','text','Protocolo de retorno','', 'Protocolo',1,'f','t','f',0,'text','Protocolo'),
            (21570,'fa65_sequencial','int4','Código PK','0', 'Código',10,'f','f','f',1,'text','Código'),
            (21571,'fa65_integracaohorusenvio','int4','Envio Arquivo','0', 'Envio Arquivo',10,'f','f','f',1,'text','Envio Arquivo'),
            (21572,'fa65_dadoscompetencia','int4','Dados enviados no arquivo para a competência','0', 'Dados enviados',10,'f','f','f',1,'text','Dados enviados'),
            (21579,'fa59_db_depart','int4','Departamento', '0', 'Departamento',10,'f','f','f',1,'text','Departamento');

insert into db_sysarqcamp
     values (3866,21517,1,0),
            (3866,21518,2,0),
            (3837,21519,6,0),
            (3870,21565,1,0),
            (3870,21569,2,0),
            (3870,21568,3,0),
            (3870,21567,4,0),
            (3870,21566,5,0),
            (3867,21520,1,0),
            (3867,21521,2,0),
            (3867,21522,3,0),
            (3867,21523,4,0),
            (3867,21524,5,0),
            (3867,21525,6,0),
            (3867,21526,7,0),
            (3867,21527,8,0),
            (3867,21528,9,0),
            (3867,21529,10,0),
            (3867,21530,11,0),
            (3867,21531,12,0),
            (3867,21532,13,0),
            (3867,21533,14,0),
            (3867,21534,15,0),
            (3868,21535,1,0),
            (3868,21536,2,0),
            (3868,21537,3,0),
            (3868,21538,4,0),
            (3868,21539,5,0),
            (3868,21540,6,0),
            (3868,21541,7,0),
            (3868,21542,8,0),
            (3868,21543,9,0),
            (3868,21544,10,0),
            (3868,21545,11,0),
            (3868,21546,12,0),
            (3868,21547,13,0),
            (3868,21548,14,0),
            (3868,21549,15,0),
            (3869,21550,1,0),
            (3869,21551,2,0),
            (3869,21552,3,0),
            (3869,21553,4,0),
            (3869,21554,5,0),
            (3869,21555,6,0),
            (3869,21557,7,0),
            (3869,21556,8,0),
            (3869,21558,9,0),
            (3869,21559,10,0),
            (3869,21561,11,0),
            (3869,21560,12,0),
            (3869,21562,13,0),
            (3869,21563,14,0),
            (3869,21564,15,0),
            (3871,21570,1,0),
            (3871,21571,2,0),
            (3871,21572,3,0),
            (3837,21579,7,0);

insert into db_sysprikey
     values (3866,21517,1,21518),
            (3867,21520,1,21520),
            (3868,21535,1,21535),
            (3869,21550,1,21550),
            (3870,21565,1,21565),
            (3871,21570,1,21570);

insert into db_sysforkey
     values (3837,21519,1,3866,0),
            (3870,21566,1,3837,0),
            (3867,21522,1,3837,0),
            (3867,21521,1,2109,0),
            (3867,21525,1,100011,0),
            (3868,21536,1,3837,0),
            (3868,21537,1,1135,0),
            (3868,21538,1,100011,0),
            (3869,21551,1,3837,0),
            (3869,21552,1,1135,0),
            (3869,21553,1,100011,0),
            (3871,21571,1,3870,0),
            (3837,21579,1,154,0);

insert into db_sysindices
     values (4275,'integracaohorusenvio_integracaohorus_in',3870,'0'),
            (4276,'dadoscompetenciadispensacao_far_retiradaitens_in',3867,'0'),
            (4277,'dadoscompetenciadispensacao_integracaohorus_in',3867,'0'),
            (4278,'dadoscompetenciadispensacao_unidade_in',3867,'0'),
            (4279,'dadoscompetenciaentrada_integracaohorus_in',3868,'0'),
            (4280,'dadoscompetenciaentrada_matestoqueinimei_in',3868,'0'),
            (4281,'dadoscompetenciaentrada_unidade_in',3868,'0'),
            (4282,'dadoscompetenciasaida_integracaohorus_in',3869,'0'),
            (4283,'dadoscompetenciasaida_matestoqueinimei_in',3869,'0'),
            (4284,'dadoscompetenciasaida_unidade_in',3869,'0'),
            (4285,'integracaohorusenviodadoscompetencia_integracaohorusenvio_in',3871,'0'),
            (4286,'integracaohorusenviodadoscompetencia_dadoscompetencia_in',3871,'0');

insert into db_syscadind
     values (4275,21566,1),
            (4276,21521,1),
            (4277,21522,1),
            (4278,21525,1),
            (4279,21536,1),
            (4280,21537,1),
            (4281,21538,1),
            (4282,21551,1),
            (4283,21552,1),
            (4284,21553,1),
            (4285,21571,1),
            (4286,21572,1);

insert into db_syssequencia
     values (1000515, 'dadoscompetenciadispensacao_fa61_sequencial_seq', 1, 1, 9223372036854775807, 1, 1),
            (1000514, 'situacaohorus_fa60_sequencial_seq', 1, 1, 9223372036854775807, 1, 1),
            (1000516, 'dadoscompetenciaentrada_fa62_sequencial_seq', 1, 1, 9223372036854775807, 1, 1),
            (1000517, 'dadoscompetenciasaida_fa63_sequencial_seq', 1, 1, 9223372036854775807, 1, 1),
            (1000518, 'integracaohorusenvio_fa64_sequencial_seq', 1, 1, 9223372036854775807, 1, 1),
            (1000519, 'integracaohorusenviodadoscompetencia_fa65_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);

update db_sysarqcamp set codsequencia = 1000515 where codarq = 3867 and codcam = 21520;
update db_sysarqcamp set codsequencia = 1000514 where codarq = 3866 and codcam = 21517;
update db_sysarqcamp set codsequencia = 1000516 where codarq = 3868 and codcam = 21535;
update db_sysarqcamp set codsequencia = 1000517 where codarq = 3869 and codcam = 21550;
update db_sysarqcamp set codsequencia = 1000518 where codarq = 3870 and codcam = 21565;
update db_sysarqcamp set codsequencia = 1000519 where codarq = 3871 and codcam = 21570;

update db_menu set menusequencia = 1 where id_item = 29 and modulo = 10094 and id_item_filho = 10100;
update db_menu set menusequencia = 2 where id_item = 29 and modulo = 10094 and id_item_filho = 10104;
update db_menu set menusequencia = 3 where id_item = 29 and modulo = 10094 and id_item_filho = 10095;
update db_menu set menusequencia = 4 where id_item = 29 and modulo = 10094 and id_item_filho = 10143;
update db_menu set menusequencia = 5 where id_item = 29 and modulo = 10094 and id_item_filho = 10145;

update db_itensmenu set libcliente = 'true' where id_item = 10115;
select fc_set_pg_search_path();

---------------------------------------------------------------------------------------------
-------------------------------- FIM EDUCAÇÃO/SAÚDE -----------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
---------------------------------- INÍCIO PESSOAL -------------------------------------------
---------------------------------------------------------------------------------------------
--Exclui vínculo do menu de consulta ao cadastro do servidor do módulo pessoal com módulo RH
delete from db_menu where id_item_filho = 2464 AND modulo = 2323;

--Insere novo menu de consulta ao cadastro do servidor no módulo RH
select fc_executa_ddl('insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10155 ,''Cadastro de Servidores'' ,''Cadastro de Servidores'' ,''pes3_conspessoal001.php?modulo=rh'' ,''1'' ,''1'' ,''Novo menu para o RH que pesquisa informações cadastradas no departamento pessoal.'' ,''true'' );');
select fc_executa_ddl('insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 31 ,10155 ,1 ,2323 );');

/**
 * Criando layout para o cnab240 para o banrisul
 */
select fc_executa_ddl('insert into db_layouttxt values (229, ''CNAB240 BANCO DO ESTADO DO RS'', 0, ''Arquivo bancário cnab 240'', 5)');

/**
 * Criando as linhas para o arquivo
 */
select fc_executa_ddl('insert into db_layoutlinha values (751, 229, ''REGISTRO HEADER ARQUIVO'', 1, 240, 0, 0, NULL, NULL, false)');
select fc_executa_ddl('insert into db_layoutlinha values (752, 229, ''REGISTRO HEADER LOTE'', 2, 240, 0, 0, NULL, NULL, false)');
select fc_executa_ddl('insert into db_layoutlinha values (753, 229, ''REGISTRO DETALHE  TIPO 3- SEGMENTO A'', 3, 240, 0, 0, NULL, NULL, false)');
select fc_executa_ddl('insert into db_layoutlinha values (754, 229, ''REGISTRO TRAILER LOTE/ REG 5'', 4, 240, 0, 0, '''', '''', false)');
select fc_executa_ddl('insert into db_layoutlinha values (755, 229, ''REGISTRO TRAILER DE ARQUIVO / REG 5'', 5, 240, 0, 0, NULL, NULL, false)');

/**
 * Inserindo os campos para cada linha.
 */
select fc_executa_ddl('insert into db_layoutcampos values (12543, 753, ''cod_compensacao'', ''CÓDIGO DA CÂMARA COMPENSAÇÃO'', 1, 18, '''', 3, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12544, 753, ''codigo_banco_fav'', ''CÓDIGO DO BANCO DO FAVORECIDO'', 1, 21, '''', 3, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12545, 753, ''agenc_conta'', ''AGÊNCIA MANTENEDORA DA CONTA FAV'', 1, 24, '''', 5, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12546, 753, ''digito_verificador_conta'', ''DÍGITO VERIFICADOR DA CONTA'', 1, 29, '''', 1, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12547, 753, ''num_conta_corrente'', ''NÚMERO DA CONTA CORRENTE'', 1, 30, '''', 13, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12548, 753, ''digito_conta'', ''ZERO OU BRANCOS'', 1, 43, '''', 1, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12549, 753, ''vlr_real_efetivado'', ''VALOR DO CRÉDITO EFETUADO'', 1, 163, '''', 15, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12550, 753, ''brancos_2'', ''BRANCOS'', 1, 178, '''', 5, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12551, 753, ''nome_favorecido'', ''NOME DO FAVORECIDO'', 1, 44, '''', 30, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12552, 753, ''num_documento'', ''NÚMERO DO DOCUMENTO DE COBRANÇA'', 1, 74, '''', 15, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12553, 753, ''finalidade_cliente'', ''FINALIDADE DO CLIENTE TED OU DOC'', 1, 89, '''', 5, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12554, 753, ''data_credito'', ''DATA DO CREDITO'', 1, 94, '''', 8, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12555, 753, ''tipo_moeda'', ''TIPO DE MOEDA'', 1, 102, '''', 3, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12556, 753, ''zeros_1'', ''ZEROS'', 1, 105, '''', 15, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12557, 753, ''valor_creditado'', ''VALOR A SER CREDITADO'', 1, 120, '''', 15, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12558, 753, ''num_documento_atribuido'', ''NÚMERO DO DOCUMENTO ATRIBUIDO PELO BANCO'', 1, 135, '''', 20, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12559, 753, ''data_efetiva_cred'', ''DATA DA EFETIVAÇÃO DO CRÉDITO'', 1, 155, '''', 8, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12560, 753, ''exclusivo_febraban'', ''USO EXCLUSIVO FEBRABAN/CNAB'', 1, 218, '''', 12, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12561, 753, ''brancos_3'', ''0 NÃO EMITE AVISO AO FAVORECIDO'', 1, 230, '''', 1, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12562, 753, ''cod_identifcador_transf'', ''CÓDIGO IDENTIFICARDOR DE TRANSFERENCIA'', 1, 183, '''', 20, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12563, 753, ''tipo_inscricao'', ''TIPO DE INSCRIÇÃO'', 1, 203, '''', 1, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12564, 753, ''num_inscricao'', ''NÚMERO DA INSCRIÇÃO'', 1, 204, '''', 14, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12565, 753, ''ocorrencias'', ''CÓDIGOS DAS OCORRÊNCIAS DE RETONO'', 1, 231, '''', 10, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12566, 753, ''codigo_banco'', ''CÓDIGO DO BANCO NA COMPENSAÇÃO'', 1, 1, '''', 3, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12567, 753, ''codigo_registro'', ''REGISTRO DETALHE'', 1, 8, ''3'', 1, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12568, 753, ''num_registro_lote'', ''Nº SEQÜENCIAL DO REGISTRO NO LOTE'', 1, 9, '''', 5, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12569, 753, ''lote_servico'', ''LOTE DE SERVIÇO'', 1, 4, '''', 4, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12570, 753, ''codigo_segmento'', ''CÓD. SEGMENTO DO REGISTRO DETALHE'', 1, 14, ''A'', 1, true, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12571, 753, ''tipo_movimento'', ''TIPO DE MOVIMENTO'', 1, 15, '''', 1, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12572, 753, ''codigo_mov'', ''CÓDIGO DE MOVIMENTO'', 1, 16, '''', 2, false, true, ''e'', '''', 0)');

select fc_executa_ddl('insert into db_layoutcampos values (12573, 754, ''cnab_2'', ''USO EXCLUSIVO FEBRABAN/CNAB'', 1, 60, '''', 171, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12574, 754, ''cod_ocorrencias_retorno'', ''CÓDIGOS DE OCORRÊNCIA PARA RETOENO'', 1, 231, '''', 10, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12575, 754, ''soma_valores'', ''SOMATÓRIO DOS VALORES'', 1, 24, '''', 18, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12576, 754, ''somatorio_quant_moedas'', ''SOMATÓRIO DE QUANTIDADES DE MOEDAS'', 1, 42, '''', 18, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12577, 754, ''codigo_registro'', ''REGISTRO TRAILER DO LOTE'', 1, 8, ''5'', 1, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12578, 754, ''cnab_1'', ''USO EXCLUSIVO FEBRABAN/CNAB'', 1, 9, '''', 9, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12579, 754, ''quantid_registros_lote'', ''QUANTIDADE DE REGISTROS DO LOTE'', 1, 18, '''', 6, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12580, 754, ''codigo_compens'', ''CÓDIGO DO BANCO NA COMPENSAÇÃO'', 1, 1, '''', 3, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12581, 754, ''lote_servico'', ''LOTE DE SERVIÇO'', 1, 4, '''', 4, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12582, 755, ''cnab_2'', ''USO EXCLUSIVO FEBRABAN/CNAB'', 1, 36, '''', 205, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12583, 755, ''codigo_registro'', ''REGISTRO TRAILER DE ARQUIVO'', 1, 8, ''9'', 1, true, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12584, 755, ''codigo_compens'', ''CÓDIGO DO BANCO NA COMPENSAÇÃO'', 1, 1, '''', 3, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12585, 755, ''lote_servico'', ''LOTE DE SERVIÇO'', 1, 4, '''', 4, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12586, 755, ''cnab_1'', ''USO EXCLUSIVO FEBRABAN/CNAB'', 1, 9, '''', 9, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12587, 755, ''quantid_lotes'', ''QUANTID. DE LOTES DO ARQUIVO'', 1, 18, '''', 6, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12588, 755, ''quantid_registros'', ''QUANTID. DE REGISTROS DO ARQUIVO'', 1, 24, '''', 6, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12589, 755, ''zeros_1'', ''ZEROS'', 1, 30, '''', 6, false, true, ''e'', '''', 0)');

select fc_executa_ddl('insert into db_layoutcampos values (12590, 752, ''endereco'', ''ENDEREÇO'', 1, 143, '''', 30, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12591, 752, ''brancos_2'', ''BRANCO'', 1, 103, '''', 40, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12592, 752, ''nome_cidade'', ''NOME DA CIDADE'', 1, 193, '''', 20, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12593, 752, ''cep'', ''CEP'', 1, 213, '''', 8, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12594, 752, ''sigla_estado'', ''SIGLA DO ESTADO'', 1, 221, '''', 2, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12595, 752, ''classif_ordem'', ''CLASSIFICAÇÃO DA ORDEM DOS REG NO LOTE'', 1, 223, '''', 2, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12596, 752, ''cnab_2'', ''USO EXCLUSIVO FEBRABAN/CNAB'', 1, 225, '''', 6, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12597, 752, ''ocorrencias'', ''CÓDIGO DE OCORENCIAS P/RETORNO'', 1, 231, '''', 10, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12598, 752, ''codigo_compens'', ''CÓDIGO DO BANCO NA COMPENSAÇÃO'', 1, 1, '''', 3, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12599, 752, ''lote_serv'', ''LOTE DE SERVIÇO'', 1, 4, '''', 4, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12600, 752, ''codigo_registro'', ''REGISTRO HEADER DO LOTE'', 1, 8, ''1'', 1, true, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12601, 752, ''num_insc_emp'', ''Nº DE INSCRIÇÃO DA EMPRESA'', 1, 19, '''', 14, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12602, 752, ''codigo_conv_banco'', ''CÓDIGO DO CONVÊNIO NO BANCO'', 1, 33, '''', 5, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12603, 752, ''tipo_operac'', ''TIPO DE OPERAÇÃO'', 1, 9, '''', 1, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12604, 752, ''tipo_serv'', ''TIPO DE SERVIÇO'', 1, 10, '''', 2, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12605, 752, ''num_layout_lote'', ''Nº DA VERSÃO DO LAYOUT DO LOTE'', 1, 14, '''', 3, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12606, 752, ''cnab_1'', ''USO EXCLUSIVO FEBRABAN/CNAB'', 1, 17, '''', 1, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12607, 752, ''forma_lanca'', ''FORMA DE LANÇAMENTO'', 1, 12, '''', 2, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12608, 752, ''tipo_insc_empresa'', ''TIPO DE INSCRIÇÃO DA EMPRESA'', 1, 18, '''', 1, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12609, 752, ''branco_1'', ''BRANCOS'', 1, 38, '''', 15, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12610, 752, ''agenc_mantenad_conta'', ''Agência Mantenedora da Conta no Banrisul'', 1, 53, '''', 5, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12611, 752, ''zeros_1'', ''ZEROS CONSTANTES'', 1, 58, '''', 4, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12612, 752, ''num_conta_corrente'', ''NÚMERO DA CONTA CORRENTE'', 1, 62, '''', 10, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12613, 752, ''digito_verific_agenc'', ''DÍGITO VERIFICADOR DA AG/CONTA'', 1, 72, '''', 1, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12614, 752, ''nome_empresa'', ''NOME DA EMPRESA'', 1, 73, '''', 30, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12615, 752, ''numero_local'', ''NÚMERO LOCAL'', 1, 173, '''', 5, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12616, 752, ''complemento_1'', ''COMPLEMENTO, CASA, APTO'', 1, 178, '''', 15, false, true, ''e'', '''', 0)');

select fc_executa_ddl('insert into db_layoutcampos values (12490, 751, ''codigo_banco'', ''CÓDIGO DO BANCO NA COMPENSAÇÃO'', 1, 1, ''041'', 3, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12491, 751, ''lote_servico'', ''LOTE DE SERVIÇO'', 1, 4, '''', 4, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12492, 751, ''codigo_registro'', ''REGISTRO HEADER DE ARQUIVO'', 1, 8, ''0'', 1, true, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12493, 751, ''cnab'', ''USO EXCLUSIVO FEBRABAN/CNAB'', 1, 9, '''', 9, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12494, 751, ''cod_conv_banco'', ''CÓDIGO DO CONVÊNIO NO BANCO'', 1, 33, '''', 5, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12495, 751, ''agenc_conta'', ''AGÊNCIA MANTENEDORA DA CONTA'', 1, 53, '''', 5, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12496, 751, ''tipo_insc_emp'', ''TIPO DE INSCRIÇÃO DA EMPRESA'', 1, 18, '''', 1, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12497, 751, ''brancos_1'', ''BRANCOS'', 1, 38, '''', 15, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12498, 751, ''num_insc_emp'', ''Nº DE INSCRIÇÃO DA EMPRESA'', 1, 19, '''', 14, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12499, 751, ''dig_verific_agenc'', ''DÍGITO VERIFICADOR DA AGÊNCIA'', 1, 58, '''', 1, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12500, 751, ''zeros_constantes'', ''NIMERICO OBRIGATORIO'', 1, 59, '''', 3, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12501, 751, ''num_conta_corrente'', ''NÚMERO DA CONTA CORRENTE.'', 1, 62, '''', 10, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12502, 751, ''dig_verificador_ag'', ''DÍGITO VERIFICADOR DA AG/CONTA'', 1, 72, '''', 1, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12503, 751, ''nome_empresa'', ''NOME DA EMPRESA'', 1, 73, '''', 30, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12504, 751, ''nome_banco'', ''NOME DO BANCO'', 1, 103, '''', 30, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12505, 751, ''cnab_2'', ''USO EXCLUSIVO FEBRABAN/CNAB'', 1, 133, '''', 10, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12506, 751, ''exclusivo_febraban'', ''USO EXCLUSIVO FEBRABAN/CNAB'', 1, 212, '''', 29, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12507, 751, ''cod_remessa'', ''CÓDIGO REMESSA / RETORNO'', 1, 143, '''', 1, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12508, 751, ''data_gera_arq'', ''DATA DE GERAÇÃO DO ARQUIVO'', 1, 144, '''', 8, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12509, 751, ''hora_gera_arq'', ''HORA DE GERAÇÃO DO ARQUIVO'', 1, 152, '''', 6, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12510, 751, ''seq_arquivo'', ''Nº SEQÜENCIAL DO ARQUIVO'', 1, 158, '''', 6, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12511, 751, ''num_layout_arquivo'', ''Nº DA VERSÃO DO LAYOUT DO ARQUIVO'', 1, 164, '''', 3, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12512, 751, ''densidade_gravac'', ''DENSIDADE DE GRAVAÇÃO DO ARQUIVO'', 1, 167, '''', 5, false, true, ''e'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12513, 751, ''uso_banco'', ''USO RESERVADO DO BANCO'', 1, 172, '''', 20, false, true, ''d'', '''', 0)');
select fc_executa_ddl('insert into db_layoutcampos values (12514, 751, ''reserv_banc_remessa'', ''USO RESERVADO DO BANCO - REMESSA'', 1, 192, '''', 20, false, true, ''d'', '''', 0)');
---------------------------------------------------------------------------------------------
-------------------------------------FIM PESSOAL---------------------------------------------
---------------------------------------------------------------------------------------------