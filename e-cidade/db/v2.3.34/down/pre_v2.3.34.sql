------
-- [FINANCEIRO - INICIO]
------

-- 97342
delete from db_menu where id_item_filho in (10024, 10025, 10026);
delete from db_itensmenu where id_item in (10024, 10025, 10026);

delete from db_sysarqcamp where codarq = 1038 and codcam = 20881;
delete from db_syscampodef where codcam = 20881;
delete from db_syscampo where codcam = 20881;

delete from db_sysarqcamp where codarq = 1036 and codcam = 20884;
delete from db_sysarqcamp where codarq = 1036 and codcam = 20889;
delete from db_syscampo where codcam in (20884, 20889);

-- Assinatura
drop table if exists db_paragrafopadrao_97342;
create temp table db_paragrafopadrao_97342 as
     select db62_codparag as paragrafo from db_docparagpadrao where db62_coddoc in (select db60_coddoc from db_documentopadrao where db60_tipodoc = 5016);

delete from db_docparagpadrao where db62_coddoc in (select db60_coddoc from db_documentopadrao where db60_tipodoc = 5016);
delete from db_paragrafopadrao where db61_codparag in (select paragrafo from db_paragrafopadrao_97342);
delete from db_documentopadrao where db60_tipodoc = 5016;
delete from db_tipodoc where db08_codigo = 5016;

------
-- [FINANCEIRO - FIM]
------

------
-- [FOLHA - INICIO]
------

update db_syscampo set nomecam = 'rh01_reajusteparidade', conteudo = 'bool', descricao = 'Tipo de reajuste do servidor. False = Real, True = c/ Paridade (reajuste)', valorinicial = 'f', rotulo = 'Tipo de Reajuste', nulo = 'f', tamanho = 20, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Tipo de Reajuste' where codcam = 20685;
delete from db_sysarqcamp where codarq = 3757;
delete from db_sysarqcamp where codarq = 1159 and codcam = 20897;
delete from db_syscampo where codcam in (20882,20883,20897);
delete from db_sysarqmod where codmod = 28 and codarq = 3757;
delete from db_sysprikey where codarq = 3757;
delete from db_sysforkey where codarq = 1153;
delete from db_sysarquivo where codarq = 3757;

-- Relatório por Tipo de Reajuste
update db_relatorio
set db63_xmlestruturarel = '<?xml version="1.0" encoding="ISO-8859-1"?>
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
where db63_sequencial = 28;

-- Comparativo de Férias
delete from db_syscampodef where codcam = 20899;
delete from db_sysarqcamp  where codcam in (20899, 20900, 20901) and codarq = 536;
delete from db_syscampo    where codcam in (20899, 20900, 20901);

-- Campo para vinculação de instituição à fundamentação legal
delete from db_sysforkey where codcam = 20902;
delete from db_sysarqcamp  where codcam = 20902;
delete from db_syscampo where codcam = 20902;

-- Layout Integração Bancária TCE-RO
DELETE FROM db_layoutcampos WHERE db52_layoutlinha IN (724, 725, 726);
DELETE FROM db_layoutlinha  WHERE db51_layouttxt = 221;
DELETE FROM db_layouttxt    WHERE db50_codigo    = 221;

-- Menu para processamento dos dados no Ponto.
delete from db_itensmenu where id_item = 10032;
delete from db_menu where id_item_filho = 10032 AND modulo = 952;

/**
 * Criação da Tabela rhpreponto
 */
delete from db_sysarqcamp where codarq = 3766;
delete from db_sysforkey  where codarq = 3766;
delete from db_sysforkey  where codarq = 3766;
delete from db_syscampo where codcam = 20923;
delete from db_syscampo where codcam = 20924;
delete from db_syscampo where codcam = 20925;
delete from db_syscampo where codcam = 20926;
delete from db_syscampo where codcam = 20927;
delete from db_syscampo where codcam = 20928;


delete from db_sysarqmod where codarq = 3766;
delete from db_sysarquivo where codarq in(3765, 3766);
------
-- [FOLHA - FIM]
------

------
-- [TRIBUTARIO - INICIO]
------
update db_syscampo
   set conteudo = 'varchar(20)', tamanho = 20
 where codcam = 5110;

update db_syscampo
   set conteudo = 'varchar(20)', tamanho = 20
 where codcam = 5106;

delete from db_menu where id_item = 3331 and id_item_filho = 10029 and modulo = 4555;
delete from db_itensfilho where id_item = 10029 and codfilho = 1918;
delete from db_itensmenu where id_item = 10029;

delete from db_itensmenu where id_item = 10030;
delete from db_menu where id_item_filho = 10030 AND modulo = 7808;

delete from db_menu where id_item_filho = 9227 AND modulo = 7808;

delete from db_sysarqcamp where codcam = 20922;
delete from db_syscampo   where codcam = 20922;

------
-- [TRIBUTARIO - FIM]
------

------
-- [TIME C - INICIO]
------

update db_syscampo set nomecam = 's152_i_pressaosistolica', conteudo = 'int4', descricao = 'Pressão arterial sistólica medida no paciente.', valorinicial = '0', rotulo = 'Sistólica', nulo = 'f', tamanho = 3, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Sistólica' where codcam = 17216;
update db_syscampo set nomecam = 's152_i_pressaodiastolica', conteudo = 'int4', descricao = 'Pressão arterial diastólica medida no paciente.', valorinicial = '0', rotulo = 'Diastólica', nulo = 'f', tamanho = 3, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Diastólica' where codcam = 17217;
update db_syscampo set nomecam = 's152_i_cintura', conteudo = 'int4', descricao = 'Cintura do paciente em centímetros.', valorinicial = '0', rotulo = 'Cintura', nulo = 'f', tamanho = 3, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Cintura' where codcam = 17218;
update db_syscampo set nomecam = 's152_n_peso', conteudo = 'float4', descricao = 'Peso do paciente.', valorinicial = '0', rotulo = 'Peso', nulo = 'f', tamanho = 7, maiusculo = 'f', autocompl = 'f', aceitatipo = 4, tipoobj = 'text', rotulorel = 'Peso' where codcam = 17219;
update db_syscampo set nomecam = 's152_i_altura', conteudo = 'int4', descricao = 'Altura do paciente medida em centímetros.', valorinicial = '0', rotulo = 'Altura', nulo = 'f', tamanho = 3, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Altura' where codcam = 17220;


-- TAREFA 104640

delete from db_sysarqmod where codmod = 1000004 and codarq = 3761;
delete from db_sysarqcamp where codarq = 3761;
delete from db_sysprikey where codarq = 3761;
delete from db_sysarqcamp where codarq = 3761;
delete from db_syssequencia where codsequencia = 1000424;
delete from db_syscampo where codcam in (20903,20904,20905,20906);
delete from db_sysarqmod where codmod = 1000004 and codarq = 3762;
delete from db_sysprikey where codarq = 3762;
delete from db_sysforkey where codarq = 3762;
delete from db_syscadind where codind = 4143 and codcam = 20908;
delete from db_syscadind where codind = 4144 and codcam = 20909;
delete from db_syscadind where codind = 4145 and codcam = 20913;
delete from db_sysarqcamp where codarq = 3762;
delete from db_syssequencia where codsequencia = 1000425;
delete from db_sysindices where codind IN (4143,4144,4145);
delete from db_sysarquivo where codarq IN (3761,3762);
delete from db_syscampo where codcam in (20907,20908,20909,20910,20912,20913);

delete from db_sysprikey where codarq in (3764,3763);
delete from db_sysforkey where codarq = 3764;
delete from db_syscadind  where codind = 4147 and  codcam in (20921,20920);
delete from db_sysindices where codind = 4147;
delete from db_sysarqcamp where codarq in (3764,3763);
delete from db_syscampo where codcam in (20919,20920,20921,20914,20915,20916,20917,20918);
delete from db_syssequencia where codsequencia in (1000427,1000426);
delete from db_sysarqmod where codmod = 1000004 and codarq in (3764,3763);
delete from db_sysarquivo where codarq in (3764,3763);

------
-- [TIME C - FIM]
------