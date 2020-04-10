------------------------------------------------------------------------------------
------------------------------ INICIO TIME C ---------------------------------------
------------------------------------------------------------------------------------

insert into db_gruporelatorio values ( 4, 'Cubo BI');
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10065 ,'Agenda Geração de Cubo BI' ,'Agenda Geração de Cubo BI' ,'con3_geracaocubobi001.php' ,'1' ,'1' ,'Agenda Geração de Cubo BI' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 32 ,10065 ,455 ,1 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10076 ,'Importação SCNES' ,'Importação SCNES' ,'sau4_importacaocnes001.php' ,'1' ,'1' ,'Formulário para importação dos dados SCNES' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1818 ,10076 ,108 ,1000004 );

INSERT INTO db_relatorio VALUES (nextval('db_relatorio_db63_sequencial_seq'), 4, 1, 'Cubo Alunos Matriculados', '1.0', now()::date,
 '<?xml version="1.0" encoding="ISO-8859-1"?>
<Relatorio>
 <Versao>1.0</Versao>
 <Propriedades versao="1.0" nome="Cubo Alunos Matriculados" layout="dbseller" formato="A4" orientacao="portrait" margemsup="0" margeminf="0" margemesq="20" margemdir="20" tiposaida="csv"/>
 <Cabecalho></Cabecalho>
 <Rodape></Rodape>
 <Campos>
  <Campo id="483" nome="codigo_aluno" alias="codigo_aluno" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="471" nome="cep" alias="cep" largura="16" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="477" nome="uf_endereco" alias="uf_endereco" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="487" nome="logradouro_endereco" alias="logradouro_endereco" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="488" nome="bairro_endereco" alias="bairro_endereco" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="489" nome="cidade_endereco" alias="cidade_endereco" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="484" nome="escola_matricula" alias="escola_matricula" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="472" nome="sexo" alias="sexo" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="473" nome="idade" alias="idade" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="474" nome="tipagem_sanguinea" alias="tipagem_sanguinea" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="486" nome="pai" alias="pai" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="475" nome="mae" alias="mae" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="476" nome="responsavel" alias="responsavel" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="490" nome="nacionalidade" alias="nacionalidade" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="491" nome="municipio_nascimento" alias="municipio_nascimento" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="478" nome="uf_nascimento" alias="uf_nascimento" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="479" nome="transporte_escolar" alias="transporte_escolar" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="480" nome="tipo_transporte_utilizado" alias="tipo_transporte_utilizado" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="481" nome="bolsa_familia" alias="bolsa_familia" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="482" nome="necessidades_especiais" alias="necessidades_especiais" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="485" nome="data_nascimento" alias="data_nascimento" largura="20" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
 </Campos>
 <Consultas>
  <Consulta tipo="Principal">
   <Select>
    <Campo id="483"/>
    <Campo id="471"/>
    <Campo id="477"/>
    <Campo id="487"/>
    <Campo id="488"/>
    <Campo id="489"/>
    <Campo id="484"/>
    <Campo id="472"/>
    <Campo id="473"/>
    <Campo id="474"/>
    <Campo id="486"/>
    <Campo id="475"/>
    <Campo id="476"/>
    <Campo id="490"/>
    <Campo id="491"/>
    <Campo id="478"/>
    <Campo id="479"/>
    <Campo id="480"/>
    <Campo id="481"/>
    <Campo id="482"/>
    <Campo id="485"/>
   </Select>
   <From>select
    ed47_i_codigo                                      as codigo_aluno,
    tiracaracteres(trim(ed18_c_nome))                  as escola_matricula,
    tiracaracteres(ed47_v_sexo)                        as sexo,
    ed47_d_nasc                                        as data_nascimento,
    fc_idade_anomesdia(ed47_d_nasc, now()::date)       as idade,
    sd100_tipo                                         as tipagem_sanguinea,
    tiracaracteres(trim(ed47_v_pai))                   as pai,
    tiracaracteres(trim(ed47_v_mae))                   as mae,
    tiracaracteres(trim(ed47_c_nomeresp))              as responsavel,
    tiracaracteres(trim(ed47_v_ender))                 as logradouro_endereco,
    tiracaracteres(trim(ed47_v_bairro))                as bairro_endereco,
    tiracaracteres(trim(municend.ed261_c_nome))        as cidade_endereco,
    ufend.ed260_c_sigla                                as uf_endereco,
    ed47_v_cep                                         as cep,
    case
      when ed47_i_nacion = 1 then \'BRASILEIRA\'
      when ed47_i_nacion = 2 then \'BRASILEIRA NO EXTERIOR OU NATURALIZADO\'
      when ed47_i_nacion = 3 then \'ESTRANGEIRA\'
      else null
    end as nacionalidade,
    tiracaracteres(trim(municnac.ed261_c_nome))        as municipio_nascimento,
    ufnac.ed260_c_sigla                                as uf_nascimento,
    case
      when ed47_i_transpublico = 0 then \'NAO\'
      when ed47_i_transpublico = 1 then \'SIM\'
    end as transporte_escolar,
    ed312_descricao                              as tipo_transporte_utilizado,
    case
      when ed47_c_bolsafamilia = \'N\' then \'NAO\'
      when ed47_c_bolsafamilia = \'S\' then \'SIM\'
      else null
    end as bolsa_familia,
    tiracaracteres(ed48_c_descr)                                 as necessidades_especiais
    from aluno
    inner join matricula                on matricula.ed60_i_aluno               = aluno.ed47_i_codigo
    inner join turma                    on turma.ed57_i_codigo                  = matricula.ed60_i_turma
    inner join calendario               on calendario.ed52_i_codigo             = turma.ed57_i_calendario
    inner join escola                   on escola.ed18_i_codigo                 = turma.ed57_i_escola
    left  join alunocensotipotransporte on alunocensotipotransporte.ed311_aluno = aluno.ed47_i_codigo
    left  join censotipotransporte      on censotipotransporte.ed312_sequencial = alunocensotipotransporte.ed311_censotipotransporte
    left  join alunonecessidade         on alunonecessidade.ed214_i_aluno       = aluno.ed47_i_codigo
    left  join necessidade              on necessidade.ed48_i_codigo            = alunonecessidade.ed214_i_necessidade
    left  join censomunic as municend   on municend.ed261_i_codigo              = ed47_i_censomunicend
    left  join censouf as ufend         on ufend.ed260_i_codigo                 = ed47_i_censoufend
    left  join censomunic as municnac   on municnac.ed261_i_codigo              = ed47_i_censomunicnat
    left  join censouf as ufnac         on ufnac.ed260_i_codigo                 = ed47_i_censoufnat
    left  join tiposanguineo            on sd100_sequencial                     = ed47_tiposanguineo
  where ed60_c_situacao       = \'MATRICULADO\'
    and ed60_d_datamatricula &lt;= now()::date
    and ed52_i_ano            = extract (year from now()::date)
    and case
          when  ed60_d_datasaida is not null and ed60_d_datasaida &lt;= now()::date
            then false
          else true
        end</From>
   <Where/>
   <Group></Group>
   <Order></Order>
  </Consulta>
 </Consultas>
</Relatorio>', 1);

update db_syscampo
   set nomecam = 'sd48_i_atendprestado',
       conteudo = 'int4',
       descricao = 'Atendimento Prestado',
       valorinicial = '0',
       rotulo = 'Atendimento Prestado',
       nulo = 'f',
       tamanho = 10,
       maiusculo = 'f',
       autocompl = 'f',
       aceitatipo = 1,
       tipoobj = 'text',
       rotulorel = 'Atendimento Prestado'
 where codcam = 11432;


drop table if exists bkp_menus_bloquear_modulo_vacina;
create table bkp_menus_bloquear_modulo_vacina as
select db_itensmenu.*
  from db_itensmenu
  inner join db_menu on db_menu.id_item_filho = db_itensmenu.id_item
  where modulo = 8481
    and db_itensmenu.id_item not in ( 8482, 8483, 8325,8485, 8486, 8451, 8452, 8453, 8454, 1045399, 1045410, 1045411, 1045412, 1101027 );

update db_itensmenu set libcliente = false where db_itensmenu.id_item in (select id_item from bkp_menus_bloquear_modulo_vacina);

delete from db_sysforkey where codarq = 154 and referen = 1685;
delete from db_sysarqcamp where codarq = 154 and codcam = 18025;

insert into db_syscampo values(21191,'ed10_ordem','int4','Ordenação de ensinos','0', 'Ordem',10,'t','f','f',1,'text','Ordem');
insert into db_sysarqcamp values(1010045,21191,7,0);

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10080 ,'Mapa Estatístico' ,'Mapa Estatístico' ,'edu2_mapaestatistico001.php' ,'1' ,'1' ,'Mapa Estatístico' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1101112 ,10080 ,14 ,7159 );

insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10081 ,'Ordenar Níveis de Ensino' ,'Ordenar Níveis de Ensino' ,'edu2_ordenarniveisensino001.php' ,'1' ,'1' ,'Ordenar Níveis de Ensino' ,'true' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1100800 ,10081 ,4 ,7159 );

update db_syscampo
   set nomecam = 'z01_v_telef', conteudo = 'varchar(12)', descricao = 'Telefone', valorinicial = '', rotulo = 'Telefone', nulo = 't', tamanho = 12, maiusculo = 'f', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Telefone'
 where codcam = 1008854;

update db_syscampo
   set nomecam = 'z01_v_telcel', conteudo = 'varchar(12)', descricao = 'Celular', valorinicial = '', rotulo = 'Celular', nulo = 't', tamanho = 12, maiusculo = 'f', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Celular'
 where codcam = 1008857;

insert into db_syscampo values(21203,'fa01_codigobarras','varchar(20)','Código de barras','', 'Código de barras',20,'t','t','f',0,'text','Código de barras');
insert into db_sysarqcamp values(2104,21203,15,0);

insert into censolinguaindig values ('389', 'Maya');

insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
     values ( 12057 ,738 ,'tipo_registro' ,'TIPO DE REGISTRO' ,14 ,1 ,'40' ,2 ,'t' ,'t' ,'d' ,'' ,0 );

-- layout - codigo inep aluno - 2015
insert into db_layouttxt( db50_codigo ,db50_layouttxtgrupo ,db50_descr ,db50_quantlinhas ,db50_obs ) values ( 228 ,1 ,'CÓDIGO INEP ALUNO - 2015' ,0 ,'' );
insert into db_layoutlinha( db51_codigo ,db51_layouttxt ,db51_descr ,db51_tipolinha ,db51_tamlinha ,db51_linhasantes ,db51_linhasdepois ,db51_obs ,db51_separador ,db51_compacta ) values ( 747 ,228 ,'CABEÇALHO CODIGO INEP ALUNO' ,3 ,0 ,0 ,0 ,'' ,'|' ,'0' );
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
     values ( 12430 ,747 ,'codigoalunoinep' ,'CODIGO DO ALUNO INEP' ,    14, 1   ,'' ,20  ,'f' ,'t' ,'e' ,'' ,0 ),
            ( 12431 ,747 ,'nomealuno' ,'NOME DO ALUNO' ,                 14, 21  ,'' ,100 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12432 ,747 ,'datanascimento' ,'DATA DE NASCIMENTO' ,       14, 121 ,'' ,10  ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12433 ,747 ,'nomemaealuno' ,'NOME DA MÃE' ,                14, 131 ,'' ,100 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12434 ,747 ,'nomepaialuno' ,'NOME DO PAI' ,                14, 231 ,'' ,100 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12435 ,747 ,'ufnascimento' ,'UF NASCIMENTO' ,              14, 331 ,'' ,2   ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12436 ,747 ,'municipionascimento' ,'MUNICIPIO NASCIMENTO', 14, 333 ,'' ,7   ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12437 ,747 ,'idalunoinep' ,'ID DO ALUNO NO INEP ' ,        14, 340 ,'' ,12  ,'f' ,'t' ,'d' ,'' ,0 );

------------------------------------------------------------------------------------
------------------------------ FIM TIME C ------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
------------------------------ TRIBUTARIO ------------------------------------------
------------------------------------------------------------------------------------

insert into db_sysarquivo values (3808, 'evolucaodividaativa', 'Tabela que salva as alterações dos valores de débitos em aberto, agrupados por suas receitas, por um período de tempo(inicialmente, diariamente)', 'v30', '2015-04-28', 'Evolução Dívida Ativa', 0, 'f', 'f', 'f', 'f' );
insert into db_sysarqmod values (8,3808);
insert into db_syscampo values(21147,'v30_receita','int4','Receita Tributária do Débito','0', 'Receita do Débito',10,'f','f','f',1,'text','Receita do Débito');
insert into db_syscampo values(21172,'v30_valorhistorico','float8','Somatório do valor histório dos débitos agrupados por receita','0', 'Valor Histório',15,'f','f','f',4,'text','Valor Histório');
update db_syscampo set nomecam = 'v30_valorhistorico', conteudo = 'float8', descricao = 'Somatório do valor histório dos débitos agrupados por receita', valorinicial = '0', rotulo = 'Valor Histório', nulo = 't', tamanho = 15, maiusculo = 'f', autocompl = 'f', aceitatipo = 4, tipoobj = 'text', rotulorel = 'Valor Histório' where codcam = 21172;
insert into db_syscampo values(21148,'v30_valorcorrigido','float8','Somatório dos valores corrigidos dos débitos agrupados por receita','0', 'Valor Corrigido',15,'f','f','f',4,'text','Valor Corrigido');
update db_syscampo set nomecam = 'v30_valorcorrecao', conteudo = 'float8', descricao = 'Somatório dos valores de correção dos débitos agrupados por receita', valorinicial = '0', rotulo = 'Valor Corrigido', nulo = 't', tamanho = 15, maiusculo = 'f', autocompl = 'f', aceitatipo = 4, tipoobj = 'text', rotulorel = 'Valor Corrigido' where codcam = 21148;
insert into db_syscampo values(21149,'v30_valormulta','float8','Somatório dos valores de multa dos débitos em aberto, agrupados por receita','0', 'Valor da Multa',15,'f','f','f',4,'text','Valor da Multa');
update db_syscampo set nomecam = 'v30_valorjuros', conteudo = 'float8', descricao = 'Somatório dos Valores de Juros dos débitos em aberto, agrupados por receita', valorinicial = '0', rotulo = 'Valor dos Juros', nulo = 't', tamanho = 15, maiusculo = 'f', autocompl = 'f', aceitatipo = 4, tipoobj = 'text', rotulorel = 'Valor dos Juros' where codcam = 21150;
insert into db_syscampo values(21150,'v30_valorjuros','float8','Somatório dos Valores de Juros dos débitos em aberto, agrupados por receita','0', 'Valor dos Juros',15,'f','f','f',4,'text','Valor dos Juros');
update db_syscampo set nomecam = 'v30_valormulta', conteudo = 'float8', descricao = 'Somatório dos valores de multa dos débitos em aberto, agrupados por receita', valorinicial = '0', rotulo = 'Valor da Multa', nulo = 't', tamanho = 15, maiusculo = 'f', autocompl = 'f', aceitatipo = 4, tipoobj = 'text', rotulorel = 'Valor da Multa' where codcam = 21149;
update db_syscampo set nomecam = 'v30_valorpagoparcial', conteudo = 'float8', descricao = 'Somatório dos valores de pagamentos parciais, agrupados por receita', valorinicial = '0', rotulo = 'Pagamento Parcial', nulo = 't', tamanho = 15, maiusculo = 'f', autocompl = 'f', aceitatipo = 4, tipoobj = 'text', rotulorel = 'Pagamento Parcial' where codcam = 21150;
update db_syscampo set nomecam = 'v30_valorpagoparcialhistorico', conteudo = 'float8', descricao = 'Somatório dos valores histórico de pagamentos parciais, agrupados por receita', valorinicial = '0', rotulo = 'Pagamento Parcial Histórico', nulo = 't', tamanho = 15, maiusculo = 'f', autocompl = 'f', aceitatipo = 4, tipoobj = 'text', rotulorel = 'Pagamento Parcial Histórico' where codcam = 21149;
insert into db_syscampo values(21151,'v30_sequencial','int4','Código sequencial da Evolução da Dívida Ativa','0', 'Código da Evolução da Dívida',10,'f','f','f',1,'text','Código da Evolução da Dívida');
insert into db_syscampo values(21152,'v30_datageracao','date','Data dos valores da Receita no momento da geração da incorporação.','null', 'Data Geração',10,'f','f','f',1,'text','Data Geração');
insert into db_syscampo values(21153,'v30_instituicao','int4','Instituição','0', 'Instituição',10,'f','f','f',1,'text','Instituição');
insert into db_syscampo values(21184,'v30_valorpago','float8','Somatório dos valores pagos agrupados por receita','0', 'Valor Pago',15,'t','f','f',4,'text','Valor Pago');
insert into db_syscampo values(21185,'v30_valorcancelado','float8','Somatório dos valores cancelados agrupados por receita','0', 'Valor Cancelado',15,'t','f','f',4,'text','Valor Cancelado');
insert into db_syscampo values(21186,'v30_valordesconto','float8','Somatório dos valores de desconto agrupados por receita','0', 'Valor Desconto',15,'t','f','f',4,'text','Valor Desconto');
insert into db_syscampo values(21187,'v30_valorpagohistorico','float8','Somatório dos valores históricos pagos agrupados por receita','0', 'Valor Pago Histórico',15,'t','f','f',4,'text','Valor Pago Histórico');
insert into db_syscampo values(21188,'v30_valorcanceladohistorico','float8','Somatório dos valores históricos cancelados agrupados por receita','0', 'Valor Cancelado Histórico',15,'t','f','f',4,'text','Valor Cancelado Histórico');
insert into db_sysarqcamp values(3808,21151,1,0);
insert into db_sysarqcamp values(3808,21147,2,0);
insert into db_sysarqcamp values(3808,21152,3,0);
insert into db_sysarqcamp values(3808,21172,4,0);
insert into db_sysarqcamp values(3808,21148,5,0);
insert into db_sysarqcamp values(3808,21149,6,0);
insert into db_sysarqcamp values(3808,21150,7,0);
insert into db_sysarqcamp values(3808,21184,8,0);
insert into db_sysarqcamp values(3808,21185,9,0);
insert into db_sysarqcamp values(3808,21186,10,0);
insert into db_sysarqcamp values(3808,21187,11,0);
insert into db_sysarqcamp values(3808,21188,12,0);
insert into db_sysarqcamp values(3808,21153,13,0);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3808,21151,1,21147);
insert into db_sysforkey values(3808,21147,1,75,0);
insert into db_sysindices values(4211,'evolucaodividaativa_receita_instituicao_datageracao_in',3808,'0');
insert into db_syscadind values(4211,21147,1);
insert into db_syscadind values(4211,21153,2);
insert into db_syscadind values(4211,21152,3);
insert into db_syssequencia values(1000465, 'evolucaodividaativa_v30_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000465 where codarq = 3808 and codcam = 21151;

/**
 * Item de menu divida
 */
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10067 ,'Evolução da dívida ativa' ,'Relatório de evolução da dívida ativa' ,'div2_evolucaodividaativa001.php' ,'1' ,'1' ,'Relatório de evolução da dívida ativa.' ,'false' );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 30 ,10067 ,444 ,81 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 3331 ,10067 ,47 ,209 );

----------------------------------------------------------------------------------------
------------------------------ FIM TRIBUTARIO ------------------------------------------
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
------------------------------- INÍCIO FOLHA -------------------------------------------
----------------------------------------------------------------------------------------
-----Criando tabelas
--------------------
insert into db_sysarquivo values (3809, 'baseregime', 'Tabela que vincula uma base a um regime.', 'rh158', '2015-04-29', '', 0, 'f', 't', 'f', 't' );
update db_sysarquivo set nomearq = 'baserhcadregime', descricao = 'Tabela que vincula uma base a um regime.', sigla = 'rh158', dataincl = '2015-04-29', rotulo = '', tipotabela = 0, naolibclass = 'f', naolibfunc = 't', naolibprog = 'f', naolibform = 't' where codarq = 3809;
insert into db_sysarquivo values (3810, 'naturezatipoassentamento', 'Tabela que guarda a natureza do tipo de assentamento.', 'rh159', '2015-04-29', '', 0, 'f', 't', 't', 't' );
insert into db_sysarquivo values (3811, 'assentamentoloteregistroponto', 'Tabela que vincula um ou mais assentamentos a um lote de registros do ponto para incluir pagamentos de substituição de servidores.','rh160','2015-04-29','',0,'f','t','t','t');
insert into db_sysarquivo values (3812, 'assentamentosubstituicao', 'Tabela é uma especialização da tabela assentamento, guardará substituição de servidores, para fim de pagamentos.', 'rh161', '2015-04-29', '', 0, 'f', 'f', 't', 't' );
insert into db_sysarquivo values (3815, 'loteregistropontorhfolhapagamento', 'Tabela que vincula o lote à uma folha de pagamento.', 'rh162', '2015-05-06', 'Vinculo entre lote e folha de pagamento', 0, 'f', 't', 't', 't' );
insert into db_sysarqmod values (28,3809);
insert into db_sysarqmod values (28,3810);
insert into db_sysarqmod values (28,3811);
insert into db_sysarqmod values (28,3812);
insert into db_sysarqmod values (28,3815);

-----Criando campos
insert into db_syscampo values(21154,'rh158_sequencial','int4','Sequencial da tabela, para facilitar manutenção.','0', 'Sequencial da tabela',19,'f','f','f',1,'text','Sequencial da tabela');
insert into db_syscampo values(21155,'rh158_regime','int4','Regime à que a base pertence.','0', 'Regime da Base',19,'f','f','f',1,'text','Regime da Base');
insert into db_syscampo values(21156,'rh158_ano','int4','Ano da competência do vínculo entre a base e o regime.','0', 'Ano da Competência',4,'f','f','f',1,'text','Ano da Competência');
insert into db_syscampo values(21157,'rh158_mes','int4','Mês da Competência do vínculo entre base e regime.','0', 'Mês da Competência',2,'f','f','f',1,'text','Mês da Competência');
insert into db_syscampo values(21159,'rh158_instit','int4','Instituição onde uma base foi vinculada a um regime.','0', 'Instituição',19,'f','f','f',1,'text','Instituição');
insert into db_syscampo values(21173,'rh158_basesubstituto','varchar(4)','Base para o servidor substituto','', 'Substituto',4,'f','t','f',0,'text','Substituto');
insert into db_syscampo values(21174,'rh158_basesubstituido','varchar(4)','Base para o servidor substituído.','', 'Substituído',4,'f','t','f',0,'text','Substituído');
insert into db_syscampo values(21160,'rh159_sequencial','int4','Sequencial da tabela que guarda a natureza do tipo de assentamento.','0', 'Código',19,'f','f','f',1,'text','Código');
insert into db_syscampo values(21161,'rh159_descricao','varchar(30)','Descrição da natureza do tipo de assentamento.','', 'Descrição',30,'f','t','f',0,'text','Descrição');
insert into db_syscampo values(21162,'rh160_sequencial','int4','Campo sequencial para facilitar manutenção na tabela.', 0,'Sequencial da tabela',19,'f','f','f',1,'text','Sequencial da tabela');
insert into db_syscampo values(21163,'rh160_loteregistroponto','int4','Vinculação com a tabela de lote de registros do ponto.',0,'Lote',19,'f','f','f',1,'text','Lote');
insert into db_syscampo values(21164,'rh160_assentamento','int4','Vinculação com a tabela de assentamentos.',0,'Assentamento',19,'f','f','f',1,'text','Assentamento');
insert into db_syscampo values(21165,'rh161_assentamento','int4','Vínculo com a tabela de assentamento, onde estará todos os outros dados.','0', 'Assentamento',19,'f','f','f',1,'text','Assentamento');
insert into db_syscampo values(21166,'rh161_regist','int4','Matrícula do servidor que está sendo substituído.','0', 'Matrícula',19,'f','f','f',1,'text','Matrícula');
insert into db_syscampo values(21181,'rh162_sequencial','int4','Sequencial da tabela para facilitar manutenção e servir de PK.','0', 'Sequencial da tabela',19,'f','f','f',1,'text','Sequencial da tabela');
insert into db_syscampo values(21182,'rh162_loteregistroponto','int4','Lote que irá ligar com a folha de pagamento.','0', 'Lote',19,'f','f','f',1,'text','Lote');
insert into db_syscampo values(21183,'rh162_rhfolhapagamento','int4','Folha de pagamento à que se está vinculando um lote.','0', 'Folha de Pagamento',19,'f','f','f',1,'text','Folha de Pagamento');
-----Vinculando campos
insert into db_sysarqcamp values(3809,21154,1,0);
insert into db_sysarqcamp values(3809,21155,2,0);
insert into db_sysarqcamp values(3809,21156,3,0);
insert into db_sysarqcamp values(3809,21157,4,0);
insert into db_sysarqcamp values(3809,21159,6,0);
insert into db_sysarqcamp values(3809,21173,6,0);
insert into db_sysarqcamp values(3809,21174,7,0);
insert into db_sysarqcamp values(3810,21160,1,0);
insert into db_sysarqcamp values(3810,21161,2,0);
insert into db_sysarqcamp values(3811,21162,1,0);
insert into db_sysarqcamp values(3811,21163,2,0);
insert into db_sysarqcamp values(3811,21164,3,0);
insert into db_sysarqcamp values(3812,21165,1,0);
insert into db_sysarqcamp values(3812,21166,2,0);
insert into db_sysarqcamp values(3815,21181,1,0);
insert into db_sysarqcamp values(3815,21182,2,0);
insert into db_sysarqcamp values(3815,21183,3,0);

----Criando indices
-------------------
insert into db_sysindices values(4212,'baserhcadregime_in',3809,'1');
insert into db_syscadind values(4212,21155,1);
insert into db_syscadind values(4212,21156,2);
insert into db_syscadind values(4212,21157,3);
insert into db_syscadind values(4212,21159,4);
insert into db_syscadind values(4212,21173,5);
insert into db_syscadind values(4212,21174,6);
insert into db_sysindices values(4213,'naturezatipoassentamento_seq_in',3810,'1');
insert into db_syscadind values(4213,21160,1);
insert into db_sysindices values(4214,'assentaloteregistroponto_un_in',3811,'1');
insert into db_syscadind values(4214,21163,1);
insert into db_syscadind values(4214,21164,2);
insert into db_sysindices values(4215,'assentamentosubstituicao_un_in',3812,'1');
insert into db_syscadind values(4215,21165,1);
insert into db_syscadind values(4215,21166,2);
insert into db_sysindices values(4219,'loteregistropontorhfolhapagamento_un_in',3815,'1');
insert into db_syscadind values(4219,21182,1);
insert into db_syscadind values(4219,21183,2);

----Criando chaves estrangeiras
-------------------------------
insert into db_sysforkey values(3809,21155,1,1520,0);
insert into db_sysforkey values(3809,21156,1,530,0);
insert into db_sysforkey values(3809,21157,2,530,0);
insert into db_sysforkey values(3809,21159,3,530,0);
insert into db_sysforkey values(3809,21173,4,530,0);
insert into db_sysforkey values(3811,21163,1,3798,0);
insert into db_sysforkey values(3811,21164,1,528,0);
insert into db_sysforkey values(3812,21165,1,528,0);
insert into db_sysforkey values(3812,21166,1,1153,0);
insert into db_sysforkey values(3815,21182,1,3798,0);
insert into db_sysforkey values(3815,21183,1,3727,0);

----Criando chaves primárias
----------------------------
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3809,21154,1,21154);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3810,21160,1,21160);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3811,21162,1,21162);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3812,21165,1,21165);
insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3815,21181,1,21181);

----Criando sequences
---------------------
insert into db_syssequencia values(1000466, 'baserhcadregime_rh158_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000466 where codarq = 3809 and codcam = 21154;
insert into db_syssequencia values(1000467, 'naturezatipoassentamento_rh159_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000467 where codarq = 3810 and codcam = 21160;
insert into db_syssequencia values(1000470, 'assentaloteregistroponto_rh160_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000470 where codarq = 3811 and codcam = 21162;
insert into db_syssequencia values(1000472, 'loteregistropontorhfolhapagamento_rh162_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
update db_sysarqcamp set codsequencia = 1000472 where codarq = 3815 and codcam = 21181;

----Vinculando FK a tabela tipoasse à tabela naturezatipoassentamento
---------------------------------------------------------------------
insert into db_syscampo values(21167,'h12_natureza','int4','Natureza do assentamento.','0', 'Natureza',19,'f','f','f',1,'text','Natureza');
insert into db_syscampodef values(21167,'1','');
insert into db_sysarqcamp values(596,21167,16,0);
insert into db_sysforkey values(596,21167,1,3810,0);


----Adicionado colunas a tabela cfpess para guardar rubricas de substituicao
----------------------------------------------------------------------------
insert into db_syscampo values(21170,'r11_rubricasubstituicaoatual','varchar(4)','Rubrica de substituição para o exercício atual.','', 'Exercício atual',4,'t','t','f',0,'text','Exercício atual');
insert into db_syscampo values(21171,'r11_rubricasubstituicaoanterior','varchar(4)','Rubrica de substituição para o exercício anterior.','', 'Exercício anterior',4,'t','t','f',0,'text','Exercício anterior');
insert into db_sysarqcamp values(536,21170,88,0);
insert into db_sysarqcamp values(536,21171,89,0);

-----------------------------
------Cadastro do menu-------
-----------------------------
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10066 ,'Lançamento de Substituição no Ponto' ,'Lançamento de Substituição no Ponto' ,'pes4_assentaloteregistroponto001.php' ,'1' ,'1' ,'Menu utilizado para selecionar os assentamentos de substituição que serão pagos.' ,'true' );
delete from db_menu where id_item_filho = 10066 AND modulo = 952;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1818 ,10066 ,107 ,952 );



------------------------------------------------------------
------Criaçao das tabelas para contrato emergencial. -------
------------------------------------------------------------
select fc_executa_ddl('insert into db_sysarquivo values (3816, ''rhcontratoemergencial'', ''Tabela criada para gerenciar as renovações de contratos emergenciais'', ''rh163'', ''2015-05-15'', ''Contrato Emergencial'', 0, ''f'', ''f'', ''f'', ''f'' )');
select fc_executa_ddl('insert into db_sysarquivo values (3817, ''rhcontratoemergencialrenovacao'', ''Renovações efetuadas para um contrato emergencial'', ''rh164'', ''2015-05-15'', ''Renovações Contrato Emergencial'', 0, ''f'', ''f'', ''f'', ''f'' )');
select fc_executa_ddl('insert into db_sysarqmod values (28,3816)');
select fc_executa_ddl('insert into db_sysarqmod values (28,3817)');
select fc_executa_ddl('insert into db_syscampo values(21194,''rh163_sequencial'',''int4'',''Sequencial da tabela rhcontratoemergencial'',''0'', ''Código'',10,''f'',''f'',''t'',1,''text'',''Código'')');
select fc_executa_ddl('insert into db_syscampo values(21195,''rh163_matricula'',''int4'',''Matricula do servidor que possui contrato emergencial'',''0'', ''Matricula'',20,''f'',''f'',''f'',1,''text'',''Matricula'')');
select fc_executa_ddl('insert into db_syscampo values(21196,''rh164_sequencial'',''int4'',''Código da Renovação'',''0'', ''Código'',10,''f'',''f'',''f'',1,''text'',''Código'')');
select fc_executa_ddl('insert into db_syscampo values(21197,''rh164_contratoemergencial'',''int4'',''Relação com a tabela rhcontratoemergencial'',''0'', ''Contrato Emergencial'',10,''f'',''f'',''f'',1,''text'',''Contrato Emergencial'')');
select fc_executa_ddl('insert into db_syscampo values(21198,''rh164_descricao'',''varchar(255)'',''Descrição da renovação do contrato'','''', ''Descrição'',255,''t'',''t'',''f'',0,''text'',''Descrição'')');
select fc_executa_ddl('insert into db_syscampo values(21199,''rh164_datainicio'',''date'',''Data de início do contrato emergencial ou da renovação do mesmo'',''null'', ''Data início'',10,''f'',''f'',''f'',1,''text'',''Data início'')');
select fc_executa_ddl('insert into db_syscampo values(21200,''rh164_datafim'',''date'',''Data de Término do contrato emergencial'',''null'', ''Data término'',10,''f'',''f'',''f'',1,''text'',''Data término'')');
select fc_executa_ddl('insert into db_sysarqcamp values(3816,21194,1,0)');
select fc_executa_ddl('insert into db_sysarqcamp values(3816,21195,2,0)');
select fc_executa_ddl('insert into db_sysarqcamp values(3817,21196,1,0)');
select fc_executa_ddl('insert into db_sysarqcamp values(3817,21197,2,0)');
select fc_executa_ddl('insert into db_sysarqcamp values(3817,21198,3,0)');
select fc_executa_ddl('insert into db_sysarqcamp values(3817,21199,4,0)');
select fc_executa_ddl('insert into db_sysarqcamp values(3817,21200,5,0)');
select fc_executa_ddl('update db_sysarqcamp set codsequencia = 1000473 where codarq = 3816 and codcam = 21194');
select fc_executa_ddl('update db_sysarqcamp set codsequencia = 1000474 where codarq = 3817 and codcam = 21196');
select fc_executa_ddl('insert into db_syssequencia values(1000473, ''rhcontratoemergencial_rh163_sequencial_seq'', 1, 1, 9223372036854775807, 1, 1)');
select fc_executa_ddl('insert into db_syssequencia values(1000474, ''rhcontratoemergencialrenovacao_rh164_sequencial_seq'', 1, 1, 9223372036854775807, 1, 1)');
select fc_executa_ddl('insert into db_sysforkey values(3817,21197,1,3816,0)');
select fc_executa_ddl('insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3816,21194,1,21194)');
select fc_executa_ddl('insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3817,21196,1,21196)');
--_Cadastro de Menu
--Menu Manutenção contratos emergenciais
select fc_executa_ddl('insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10082 ,''Manutenção de Contratos Emergenciais'' ,''Manutenção de Contratos Emergenciais'' ,''pes4_contratosemergenciais001.php'' ,''1'' ,''1'' ,''Rotina criada para efetuar a renovação e cancelamento de contratos emergenciais'' ,''true'' )');
select fc_executa_ddl('delete from db_menu where id_item_filho = 10082 AND modulo = 952');
select fc_executa_ddl('insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1818 ,10082 ,109 ,952 )');
--Menu Relatorio contratos emergenciais
select fc_executa_ddl('insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10083 ,''Contratos Emergenciais'' ,''Contratos Emergenciais'' ,''pes2_contratosemergenciais001.php'' ,''1'' ,''1'' ,''Consulta dos contratos emergenciais'' ,''true'' )');
select fc_executa_ddl('delete from db_menu where id_item_filho = 10083 AND modulo = 952');
select fc_executa_ddl('insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 1797 ,10083 ,57 ,952 )');
select fc_executa_ddl('insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 2456 ,10083 ,36 ,952 )');

--Cria o relatorio de contratos emergenciais
select fc_executa_ddl('INSERT INTO db_relatorio VALUES (29, 1, 1, \'Contratos Emergenciais\', \'1.0\', \'2015-05-21\', \'<?xml version="1.0" encoding="ISO-8859-1"?>
<Relatorio>
 <Versao>1.0</Versao>
 <Propriedades versao="1.0" nome="Contratos Emergenciais" layout="dbseller" formato="A4" orientacao="portrait" margemsup="0" margeminf="0" margemesq="20" margemdir="20" tiposaida="pdf"/>
 <Cabecalho></Cabecalho>
 <Rodape></Rodape>
 <Variaveis>
  <Variavel nome="$sRegist" label="" tipodado="int4" valor=""/>
  <Variavel nome="$sDatainicio" label="" tipodado="date" valor=""/>
  <Variavel nome="$sDatafim" label="" tipodado="date" valor=""/>
 </Variaveis>
 <Campos>
  <Campo id="21201" nome="servidor" alias="Servidor" largura="510" alinhamento="l" alinhamentocab="l" mascara="t" totalizar="n" quebra="true"/>
  <Campo id="21202" nome="quebra" alias="      " largura="5" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
  <Campo id="21198" nome="rh164_descricao" alias="Descrição" largura="130" alinhamento="l" alinhamentocab="l" mascara="t" totalizar="n" quebra=""/>
  <Campo id="21199" nome="rh164_datainicio" alias="Data início" largura="30" alinhamento="c" alinhamentocab="c" mascara="d" totalizar="n" quebra=""/>
  <Campo id="21200" nome="rh164_datafim" alias="Data término" largura="30" alinhamento="c" alinhamentocab="c" mascara="d" totalizar="n" quebra=""/>
 </Campos>
 <Consultas>
  <Consulta tipo="Principal">
   <Select>
    <Campo id="21201"/>
    <Campo id="21202"/>
    <Campo id="21198"/>
    <Campo id="21199"/>
    <Campo id="21200"/>
   </Select>
   <From>select rh163_matricula || \'\' - \'\' || z01_nome as Servidor,
             null as quebra,
             rh164_descricao,
             rh164_datainicio,
             rh164_datafim
       from rhcontratoemergencial
 inner join rhcontratoemergencialrenovacao
         on rh163_sequencial = rh164_contratoemergencial
 inner join rhpessoal
         on rh163_matricula = rh01_regist
 inner join cgm
         on rh01_numcgm = z01_numcgm
      where case when $sRegist != 0
               then
                 rh163_matricula = $sRegist
               else
                 true
               end
        and exists (select 1
                      from rhcontratoemergencialrenovacao as datainicio
                     where rh164_datafim &gt;= $sDatainicio
                       and datainicio.rh164_contratoemergencial = rh163_sequencial
                    )
        and exists (select 1
                      from rhcontratoemergencialrenovacao as datafim
                     where rh164_datainicio &lt;= $sDatafim
                       and datafim.rh164_contratoemergencial = rh163_sequencial
                   )
 order by rh163_matricula</From>
   <Where/>
   <Group></Group>
   <Order>
    <Ordem id="21201" nome="servidor" ascdesc="asc" alias="Servidor"/>
    <Ordem id="21199" nome="rh164_datainicio" ascdesc="asc" alias="data inÃ­cio"/>
   </Order>
  </Consulta>
 </Consultas>
</Relatorio>\', 1)');

----------------------------------------------------------------------------------------
---------------------------------- FIM FOLHA -------------------------------------------
----------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------
--- Financeiro ----
----------------------------------------------------------------------------------------
select fc_executa_ddl('
insert into db_sysarquivo select 3807, \'empenhocotamensal\', \'Cotas Mensais dos empenhos\', \'e05\', \'2015-04-27\', \'Cotas Mensais dos Empenhos\', 0, \'f\', \'f\', \'f\', \'f\' where not exists(select 1 from db_sysarquivo where codarq = 3807);
insert into db_sysarqmod select 38,3807 where not exists(select 1 from db_sysarqmod where codarq = 3807);

insert into db_syscampo select 21143,\'e05_sequencial\',\'int4\',\'Código Sequencial\',\'0\', \'Código Sequencial\',10,\'f\',\'f\',\'f\',1,\'text\',\'Código Sequencial\' where not exists (select 1 from db_syscampo where codcam = 21143);

insert into db_syscampo select 21144,\'e05_numemp\',\'int4\',\'Empenho\',\'0\', \'Empenho\',10,\'f\',\'f\',\'f\',1,\'text\',\'Empenho\' where not exists (select 1 from db_syscampo where codcam = 21144);
insert into db_syscampo select 21145,\'e05_mes\',\'int4\',\'Mês\',\'0\', \'Mês\',2,\'f\',\'f\',\'f\',1,\'text\',\'Mês\' where not exists (select 1 from db_syscampo where codcam = 21145);
insert into db_syscampo select 21146,\'e05_valor\',\'float8\',\'Valor\',\'0\', \'Valor da Cota\',10,\'f\',\'f\',\'f\',4,\'text\',\'Valor da Cota\' where not exists (select 1 from db_syscampo where codcam = 21146);

insert into db_sysarqcamp select 3807, 21143, 1, 0 where not exists (select 1 from db_sysarqcamp where codcam = 21143);
insert into db_sysarqcamp select 3807, 21144, 2, 0 where not exists (select 1 from db_sysarqcamp where codcam = 21144);
insert into db_sysarqcamp select 3807, 21145, 3, 0 where not exists (select 1 from db_sysarqcamp where codcam = 21145);
insert into db_sysarqcamp select 3807, 21146, 4, 0 where not exists (select 1 from db_sysarqcamp where codcam = 21146);


insert into db_sysprikey (codarq,codcam,sequen,camiden) select 3807,21143,1,21144 where not exists(select 1 from db_sysprikey where codcam = 21143);

insert into db_sysforkey select 3807,21144,1,889,0 where not exists (select 1 from db_sysforkey where codcam = 21144);
insert into db_sysindices select 4209, \'empenhocotamensal_empenho_in\',3807,\'0\' where not exists (select  1 from db_sysindices where codind = 4209);
insert into db_syscadind select 4209,21144,1 where not exists (select  1 from db_sysindices where codind = 4209);
insert into db_sysindices select 4210, \'empenhocotamensal_mes_in\',3807,\'0\' where not exists (select  1 from db_sysindices where codind = 4210);
insert into db_syscadind select 4210,21145,1 where not exists (select  1 from db_sysindices where codind = 4210);

insert into db_syssequencia select 1000464, \'empenhocotamensal_e05_sequencial_seq\', 1, 1, 9223372036854775807, 1, 1 where not exists (select 1 from db_syssequencia where codsequencia = 1000464);
update db_sysarqcamp set codsequencia = 1000464 where codarq = 3807 and codcam = 21143;
');

--- Acompanhamento

insert into db_sysarquivo select  3814, 'cronogramaperspectivaacompanhamento', 'Acompanhamento do Cronograma', 'o36', '2015-05-04', 'Acompanhamento do Cronograma', 0, 'f', 'f', 'f', 'f'  where not exists(select 1 from db_sysarquivo where codarq = 3814);
insert into db_sysarqmod select 35,3814 from db_sysarqmod where codarq = 3814;
insert into db_syscampo select 21176, 'o151_sequencial','int4','Código Sequencial','0', 'Código Sequencial',10,'f','f','f',1,'text','Código Sequencial'  where not exists(select 1 from db_syscampo where codcam = 21176);
insert into db_syscampo select 21177,  'o151_cronogramaperspectivaorigem','int4','Perspesctiva Origem','0', 'Perspesctiva Origem',1,'f','f','f',1,'text','Perspesctiva Origem' where not exists(select 1 from db_syscampo where codcam = 21177);
insert into db_syscampo select 21178,  'o151_cronogramaperspectiva','int4','Perspesctiva','0', 'Perspesctiva',1,'f','f','f',1,'text','Perspesctiva' where not exists(select 1 from db_syscampo where codcam = 21178);

insert into db_syscampo select 21179,  'o151_mes', 'int4','Mês','0', 'Mês',1,'f','f','f',1,'text','Mês' where not exists(select 1 from db_syscampo where codcam = 21179);

insert into db_syscampo select 21180, 'o124_tipo', 'int4','Tipo da Perspectiva','1', 'Tipo da Perspectiva',1,'f','f','f',1,'text','Tipo da Perspectiva' where not exists(select 1 from db_syscampo where codcam = 21180);

insert into db_sysarqcamp select 2618, 21180,8,0 where not exists (select 1 from db_sysarqcamp where codcam = 21180);
insert into db_sysarqcamp select 3814, 21176,1,0 where not exists (select 1 from db_sysarqcamp where codcam = 21176);
insert into db_sysarqcamp select 3814, 21177,2,0 where not exists (select 1 from db_sysarqcamp where codcam = 21177);
insert into db_sysarqcamp select 3814, 21178,3,0 where not exists (select 1 from db_sysarqcamp where codcam = 21178);
insert into db_sysarqcamp select 3814, 21179,4,0 where not exists (select 1 from db_sysarqcamp where codcam = 21179);


insert into db_sysprikey select 3814, 21176,1,21178 where not exists(select 1 from db_sysprikey where codcam = 21176);

insert into db_sysforkey select 3814,21177,1,2618,0 where not exists (select 1 from db_sysforkey where codcam = 21177);
insert into db_sysindices select 4217,'cronogramaperspectivaacompanhamento_orig_in',3814,'0'  where not exists (select  1 from db_sysindices where codind = 4217);
insert into db_syscadind select 4217,21177,1 where not exists (select  1 from db_syscadind where codind = 4217);
insert into db_sysindices select 4218,'cronogramaperspectivaacompanhamento_persp_in',3814,'0' where not exists (select  1 from db_sysindices where codind = 4218);
insert into db_syscadind select 4218,21178,1 where not exists (select  1 from db_syscadind where codind = 4218);
insert into db_syssequencia select 1000471, 'cronogramaperspectivaacompanhamento_o151_sequencial_seq', 1, 1, 9223372036854775807, 1, 1 where not exists (select 1 from db_syssequencia where codsequencia = 1000471);

update db_sysarqcamp set codsequencia = 1000471 where codarq = 3814 and codcam = 21176;


----------------------------------------------------------------------------------------
---------------------------------- INICIO FINANCEIRO -----------------------------------
----------------------------------------------------------------------------------------

select fc_executa_ddl('
  insert into db_itensmenu values( 10068, \'Acompanhamento\', \'Acompanhamento do Cronograma de Desembolso\', \'\', \'1\', \'1\', \'Acompanhamento do Cronograma de Desembolso\', \'1\' );
  insert into db_itensmenu values( 10069, \'Abertura\', \'Abertura de Acompanhamento\', \'orc4_aberturaacompanhamento001.php\', \'1\', \'1\', \'\', \'1\' );
  insert into db_itensfilho (id_item, codfilho) values(10069,1);
  insert into db_itensmenu values( 10070, \'Receita\', \'Acompanhamento da Receita do Cronogama de Desembolso\', \'orc4_acompanhamentocronogramareceita001.php\', \'1\', \'1\', \'\', \'1\'  );
  insert into db_itensfilho (id_item, codfilho) values(10070,1);
  insert into db_itensmenu values( 10071, \'Despesa\', \'Acompanhamento da Despesa do Cronograma de Desembolso\', \'orc4_acompanhamentocronogramadespesa001.php\', \'1\', \'1\', \'\', \'1\' );
  insert into db_itensfilho (id_item, codfilho) values(10071,1);
  insert into db_menu values(7881,10068,4,116);
  insert into db_menu values(10068,10069,1,116);
  insert into db_menu values(10068,10070,2,116);
  insert into db_menu values(10068,10071,3,116);
  insert into db_itensmenu values(10072, \'Homologação da Perspectiva\', \'Homologação da Perspectiva\', \'orc4_homologacaocronogramadesembolso.php\', \'1\', \'1\', \'Homologação da Perspectiva\', \'1\');
  insert into db_menu values(7881, 10072, 5, 116);
  update db_menu set menusequencia = 4 where id_item = 7881 and id_item_filho = 10072;
  update db_menu set menusequencia = 5 where id_item = 7881 and id_item_filho = 10068;
  insert into db_itensmenu values( 10073, \'Acompanhamento\', \'Acompanhamento da Perspectiva de Desembolso\', \'\', \'1\', \'1\', \'\', \'1\'	);
  insert into db_itensmenu values( 10074, \'Receita\', \'Acompanhamento da Receita\', \'orc2_acompanhamentocronograma001.php?tipo=1\', \'1\', \'1\', \'\', \'1\'	);
  insert into db_itensfilho (id_item, codfilho) values(10074,1);
  insert into db_itensmenu values( 10075, \'Despesa\', \'Acompanhamento da Despesa\', \'orc2_acompanhamentocronograma001.php?tipo=2\', \'1\', \'1\', \'\', \'1\'	);
  insert into db_itensfilho (id_item, codfilho) values(10075,1);
  insert into db_menu values(7916,10073,4,116);
  insert into db_menu values(10073,10074,1,116);
  insert into db_menu values(10073,10075,2,116);
');

update orcparamseq set o69_descr = 'Outras Operações de Crédito Não Sujeitas ao Limite',
                       o69_labelrel = 'Outras Operações de Crédito Não Sujeitas ao Limite'
             where o69_codparamrel = 92 and o69_ordem = 17;

select fc_executa_ddl('insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10077 ,\'Anexo 6 - Dem. Simplificado do RGF - 2015\' ,\'Anexo 6 - Dem. Simplificado do RGF - 2015\' ,\'con2_lrflimites001.php\' ,\'1\' ,\'1\' ,\'Anexo 6 - Dem. Simplificado do RGF - 2015\' ,true );
                       insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 8113 ,10077 ,8 ,209 ); ');


update db_syscampo set aceitatipo = 1 where codcam = 5453;
update db_syscampo set rotulo = 'Código' where nomecam = 'o124_sequencial';
update db_syscampo set rotulo = 'Descrição' where nomecam = 'o124_descricao';

update db_syscampo set rotulo = 'Data da Requisição' where nomecam = 'm40_data';
update db_syscampo set rotulo = 'Hora da Requisição' where nomecam = 'm40_hora';

----------------------------------------------------------------------------------------
---------------------------------- FIM FINANCEIRO --------------------------------------
----------------------------------------------------------------------------------------