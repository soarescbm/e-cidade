UPDATE db_relatorio
SET db63_xmlestruturarel = '<?xml version="1.0" encoding="ISO-8859-1"?>
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
                else ''Paridade'' 
                end as rh01_descricaoreajusteparidade
  from rhpessoal
      inner join cgm          on rhpessoal.rh01_numcgm = cgm.z01_numcgm
      inner join rhpessoalmov on rhpessoal.rh01_regist = rhpessoalmov.rh02_regist
      inner join rhtipoapos   on rhpessoalmov.rh02_rhtipoapos = rhtipoapos.rh88_sequencial

where rh01_reajusteparidade = $sTipoReajuste
    and rh01_instit = fc_getsession(''DB_instit'')::integer</From>
   <Where/>
   <Group></Group>
   <Order>
    <Ordem id="217" nome="z01_nome" ascdesc="asc" alias="Nome"/>
   </Order>
  </Consulta>
 </Consultas>
</Relatorio>
'
WHERE db63_sequencial = 28;

/**
 * Alterações na tabela pensao.
 */
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 20827 ,'r52_sequencial' ,'int4' ,'Campo sequencial da tabela Pensão' ,'' ,'Sequencial' ,20 ,'false' ,'false' ,'true' ,1 ,'text' ,'Sequencial' );
delete from db_syscampodef where codcam = 20827;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 570 ,20827 ,26 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 20828 ,'r52_pagasuplementar' ,'bool' ,'Campo informando se a pensão deve ser paga na suplementar' ,'false' ,'Suplementar' ,1 ,'false' ,'false' ,'false' ,5 ,'text' ,'Suplementar' );
delete from db_syscampodef where codcam = 20828;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 570 ,20828 ,27 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 20829 ,'r52_valorsuplementar' ,'float4' ,'Valor da suplementar' ,'0' ,'Valor da Suplementar' ,10 ,'false' ,'false' ,'false' ,4 ,'text' ,'Valor da Suplementar' );
delete from db_syscampodef where codcam = 20829;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 570 ,20829 ,28 ,0 );
insert into db_syssequencia 
      values (1000409, 'pensao_r52_sequencial_seq', 1, 1, 9223372036854775807, 1, 1),
             (1000411, 'folhapagamentogeracao_rh146_sequencial_seq', 1,1,9223372036854775807, 1,1);
update db_sysarqcamp set codsequencia = 1000409 where codarq = 570 and codcam = 20827;
update db_sysarqcamp set codsequencia = 1000411 where codarq = 570 and codcam = 20830;

/**
 * Criação da tabela rhhistoricopensao.
 */
insert into db_sysarquivo values (3748, 'rhhistoricopensao', 'Tabela responsável por gravar dados do histórico da pensão.', 'rh145', '2014-10-30', 'rhhistoricopensao', 0, 'f', 'f', 't', 't' );
insert into db_sysarqmod values (28,3748);

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 20830 ,'rh145_sequencial' ,'int4' ,'Sequencial da tabela rhhistoricopensao' ,'' ,'Sequencial' ,20 ,'false' ,'false' ,'true' ,1 ,'text' ,'Sequencial' );
delete from db_syscampodef where codcam = 20830;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3748 ,20830 ,1 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 20838 ,'rh145_rhfolhapagamento' ,'int4' ,'Sequencial da tabela rhfolhapagamento' ,'' ,'Folha de Pagamento' ,20 ,'false' ,'false' ,'false' ,1 ,'text' ,'Folha de Pagamento' );
delete from db_syscampodef where codcam = 20838;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3748 ,20838 ,4 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 20832 ,'rh145_pensao' ,'int4' ,'Código sequencial da tabela pensão' ,'' ,'Pensão' ,20 ,'false' ,'false' ,'false' ,1 ,'text' ,'Pensão' );
delete from db_syscampodef where codcam = 20832;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3748 ,20832 ,3 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 20833 ,'rh145_valor' ,'float4' ,'Valor da pensão' ,'' ,'Valor' ,20 ,'false' ,'false' ,'false' ,4 ,'text' ,'Valor' );
delete from db_syscampodef where codcam = 20833;
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3748 ,20833 ,4 ,0 );

delete from db_sysprikey where codarq = 3748;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3748,20830,1,20830);
delete from db_sysforkey where codarq = 3748 and referen = 0;
insert into db_sysforkey values(3748,20830,1,570,0);
delete from db_sysforkey where codarq = 3748 and referen = 0;
insert into db_sysforkey values(3748,20838,1,3727,0);
delete from db_sysprikey where codarq = 570;
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(570,20827,1,4118);
insert into db_sysindices values(4132,'pensao_anousu_mesusu_regist_numcgm_in',570,'1');
insert into db_syscadind values(4132,4113,1);
insert into db_syscadind values(4132,4114,2);
insert into db_syscadind values(4132,4115,3);
insert into db_syscadind values(4132,4118,4);
insert into db_sysindices values(4133,'rhhistoricocalculo_rhfolhapagamento_in',3748,'0');
insert into db_syscadind values(4133,20838,1);
update db_sysindices set nomeind = 'rhhistoricopensao_rhfolhapagamento_in',campounico = '0' where codind = 4133;
delete from db_syscadind where codind = 4133;
insert into db_syscadind values(4133,20838,1);
insert into db_sysindices values(4134,'rhhistoricopensao_pensao_in',3748,'0');
insert into db_syscadind values(4134,20832,1);

insert into db_syssequencia values(1000410, 'rhhistoricopensao_rh145_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000410 where codarq = 3748 and codcam = 20830;
/**
 * Criação da tabela folhapensao
 */

-- Cria a tabela
INSERT INTO db_sysarquivo VALUES 
(
  3749,
  'folhapagamentogeracao',
  'Tabela server para armazenar a folha pagamento, utilizada na geração de disco.',
  'rh146',
  '2014-11-03',
  'Pensões Geradas', 
  0, 'f', 'f', 'f', 'f'
);

-- Víncula a tabela com o módulo
INSERT INTO db_sysarqmod VALUES (28, 3749);

-- Cria os campos
INSERT INTO db_syscampo VALUES 
(20842, 'rh146_sequencial',     'int4', 'Identificador único.',                          '', 'Sequencial',      10, 'false', 'false', 'false', 1, 'text', 'Sequencial'),
(20843, 'rh146_folhapagamento', 'int4', 'Chave estrangeira da tabela rhfolhapagamento.', '', 'Folha Pagamento', 10, 'false', 'false', 'false', 1, 'text', 'Folha Pagamento');

-- Víncula os campos criados com o código sequencial com a tabela
INSERT INTO db_sysarqcamp VALUES
(3749, 20842, 1, 1000411),
(3749, 20843, 2, 0);

-- Víncula a tabela com a tabela pai, neste caso não existe
INSERT INTO db_sysarqarq VALUES
(0, 3749);

-- Cria a primary key vínculando com a tabela
INSERT INTO db_sysprikey VALUES
(3749, 20842, 1, 20842);

-- Cria a foreigh key vínculando com a tabela
INSERT INTO db_sysforkey VALUES
(3749, 20843, 1, 3727, 0);

-- Cria os índices
INSERT INTO db_sysindices VALUES
(4135, 'folhapagamentogeracao_sequencial_in',       3749, '0'),
(4136, 'folhapagamentogeracao_rhfolhapagamento_in', 3749, '0');

-- Víncula os índices com a tabela
INSERT INTO db_syscadind VALUES
(4135, 20842, 1),
(4136, 20843, 1);

-- Removendo a visualização dos menus
UPDATE db_itensmenu
SET libcliente = 'false'
WHERE id_item IN (9958,
                  9959,
                  9960,
                  9961,
                  9962,
                  9963,
                  9964,
                  9965,
                  9972,
                  9973,
                  9974,
                  9975,
                  9976);