---------------------------------------------------------------------------------------------
-------------------------------- INCIO FINANCEIRO -------------------------------------------
---------------------------------------------------------------------------------------------

delete from vinculoeventoscontabeis where c115_conhistdocinclusao = 214;
delete from conhistdoc where c53_coddoc in (214, 215);

delete from orcparamseqorcparamseqcolunavalor where o117_orcparamseqorcparamseqcoluna in (select o116_sequencial from orcparamseqorcparamseqcoluna where o116_codparamrel = 155);
delete from orcparamrelnotaperiodo where o118_orcparamrelnota in (select o42_sequencial from orcparamrelnota where o42_codparrel = 155);
delete from orcparamrelnota where o42_codparrel = 155;
delete from orcparamseqfiltroorcamento where o133_orcparamrel= 155;
delete from orcparamseqfiltropadrao where o132_orcparamrel = 155;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 155;
delete from orcparamseqcoluna where o115_sequencial in (200,201,202);
delete from orcparamseq where o69_codparamrel = 155;
delete from orcparamrelperiodos where o113_orcparamrel = 155;
delete from orcparamrel where o42_codparrel = 155;

delete from orcparamseqorcparamseqcolunavalor where o117_orcparamseqorcparamseqcoluna in (select o116_sequencial from orcparamseqorcparamseqcoluna where o116_codparamrel = 156);
delete from orcparamrelnotaperiodo where o118_orcparamrelnota in (select o42_sequencial from orcparamrelnota where o42_codparrel = 156);
delete from orcparamrelnota where o42_codparrel = 156;
delete from orcparamseqfiltroorcamento where o133_orcparamrel= 156;
delete from orcparamseqfiltropadrao where o132_orcparamrel = 156;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 156;
delete from orcparamseq where o69_codparamrel = 156;
delete from orcparamrelperiodos where o113_orcparamrel = 156;
delete from orcparamrel where o42_codparrel = 156;

---------------------------------------------------------------------------------------------
-------------------------------- FIM FINANCEIRO ---------------------------------------------
---------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------
--------------------------------- INICIO FOLHA ----------------------------------------------
---------------------------------------------------------------------------------------------

update db_relatorio
   set db63_xmlestruturarel = ' <?xml version="1.0" encoding="ISO-8859-1"?>
 <Relatorio>
  <Versao>1.0</Versao>
  <Propriedades versao="1.0" nome="LÃ­quidos da folha por Recurso - Analitico - PDF" layout="dbseller" formato="A4" orientacao="portrait" margemsup="0" margeminf="0" margemesq="20" margemdir="20" tiposaida="pdf"/>
  <Cabecalho></Cabecalho>
  <Rodape></Rodape>
  <Variaveis>
   <Variavel nome="$sRecursos" label="" tipodado="varchar" valor=""/>
  </Variaveis>
  <Campos>
   <Campo id="3905" nome="r38_regist" alias="Matrícula" largura="18" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
   <Campo id="3906" nome="r38_nome" alias="Nome" largura="150" alinhamento="l" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
   <Campo id="3919" nome="r38_liq" alias="Salário Líquido" largura="30" alinhamento="r" alinhamentocab="c" mascara="m" totalizar="n" quebra=""/>
   <Campo id="3348" nome="o15_descr" alias="Tipo de Recurso" largura="120" alinhamento="l" alinhamentocab="c" mascara="t" totalizar="n" quebra="true"/>
  </Campos>
  <Consultas>
   <Consulta tipo="Principal">
    <Select>
     <Campo id="3905"/>
     <Campo id="3906"/>
     <Campo id="3919"/>
     <Campo id="3348"/>
    </Select>
    <From>select * from folha inner join rhlota on r38_lotac::integer = r70_codigo inner join rhlotavinc on r70_codigo = rh25_codigo inner join orctiporec on o15_codigo = rh25_recurso where rh25_anousu = fc_anofolha(fc_getsession(''DB_instit'')::integer) and rh25_recurso in (  $sRecursos ) order by o15_codigo, r38_nome</From>
    <Where/>
    <Group></Group>
    <Order></Order>
   </Consulta>
  </Consultas>
 </Relatorio>'
where db63_sequencial = 17;

update db_relatorio
   set db63_xmlestruturarel = ' <?xml version="1.0" encoding="ISO-8859-1"?>
 <Relatorio>
  <Versao>1.0</Versao>
  <Propriedades versao="1.0" nome="LÃ­quidos da folha por Recurso - Analitico - CSV" layout="dbseller" formato="A4" orientacao="portrait" margemsup="0" margeminf="0" margemesq="20" margemdir="20" tiposaida="csv"/>
  <Cabecalho></Cabecalho>
  <Rodape></Rodape>
  <Variaveis>
   <Variavel nome="$sRecursos" label="" tipodado="varchar" valor=""/>
  </Variaveis>
  <Campos>
   <Campo id="3905" nome="r38_regist" alias="Matrícula" largura="18" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
   <Campo id="3906" nome="r38_nome" alias="Nome" largura="150" alinhamento="l" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
   <Campo id="3919" nome="r38_liq" alias="Salário Líquido" largura="30" alinhamento="r" alinhamentocab="c" mascara="m" totalizar="n" quebra=""/>
   <Campo id="3348" nome="o15_descr" alias="Tipo de Recurso" largura="120" alinhamento="l" alinhamentocab="c" mascara="t" totalizar="n" quebra="true"/>
  </Campos>
  <Consultas>
   <Consulta tipo="Principal">
    <Select>
     <Campo id="3905"/>
     <Campo id="3906"/>
     <Campo id="3919"/>
     <Campo id="3348"/>
    </Select>
    <From>select * from folha inner join rhlota on r38_lotac::integer = r70_codigo inner join rhlotavinc on r70_codigo = rh25_codigo inner join orctiporec on o15_codigo = rh25_recurso where rh25_anousu = fc_anofolha(fc_getsession(''DB_instit'')::integer) and rh25_recurso in (  $sRecursos ) order by o15_codigo, r38_nome</From>
    <Where/>
    <Group></Group>
    <Order></Order>
   </Consulta>
  </Consultas>
 </Relatorio>'
where db63_sequencial = 18;

update db_relatorio
   set db63_xmlestruturarel = ' <?xml version="1.0" encoding="ISO-8859-1"?>
 <Relatorio>
  <Versao>1.0</Versao>
  <Propriedades versao="1.0" nome="Lí­quidos da folha por Recurso - Sintetico - PDF" layout="dbseller" formato="A4" orientacao="portrait" margemsup="0" margeminf="0" margemesq="20" margemdir="20" tiposaida="pdf"/>
  <Cabecalho></Cabecalho>
  <Rodape></Rodape>
  <Variaveis>
   <Variavel nome="$sRecursos" label="" tipodado="varchar" valor=""/>
  </Variaveis>
  <Campos>
   <Campo id="3349" nome="total_recurso" alias="Total" largura="25" alinhamento="c" alinhamentocab="c" mascara="m" totalizar="n" quebra=""/>
   <Campo id="3348" nome="o15_descr" alias="Tipo de Recurso" largura="120" alinhamento="l" alinhamentocab="c" mascara="t" totalizar="n" quebra="true"/>
  </Campos>
  <Consultas>
   <Consulta tipo="Principal">
    <Select>
     <Campo id="3349"/>
     <Campo id="3348"/>
    </Select>
    <From>select sum(r38_liq) as total_recurso, o15_descr from folha inner join rhlota on r38_lotac::integer = r70_codigo inner join rhlotavinc on r70_codigo = rh25_codigo inner join orctiporec on o15_codigo = rh25_recurso where rh25_anousu = fc_anofolha(fc_getsession(''DB_instit'')::integer) and rh25_recurso in ( $sRecursos ) group by o15_codigo</From>
    <Where/>
    <Group></Group>
    <Order>
     <Ordem id="3348" nome="o15_descr" ascdesc="asc" alias="Tipo de Recurso"/>
    </Order>
   </Consulta>
  </Consultas>
 </Relatorio>'
where db63_sequencial = 19;

update db_relatorio
   set db63_xmlestruturarel = ' <?xml version="1.0" encoding="ISO-8859-1"?>
 <Relatorio>
  <Versao>1.0</Versao>
  <Propriedades versao="1.0" nome="LÃ­quidos da folha por Recurso - Sintetico - CSV" layout="dbseller" formato="A4" orientacao="portrait" margemsup="0" margeminf="0" margemesq="20" margemdir="20" tiposaida="csv"/>
  <Cabecalho></Cabecalho>
  <Rodape></Rodape>
  <Variaveis>
   <Variavel nome="$sRecursos" label="" tipodado="varchar" valor=""/>
  </Variaveis>
  <Campos>
   <Campo id="3349" nome="total_recurso" alias="Total" largura="25" alinhamento="c" alinhamentocab="c" mascara="m" totalizar="n" quebra=""/>
   <Campo id="3348" nome="o15_descr" alias="Tipo de Recurso" largura="120" alinhamento="l" alinhamentocab="c" mascara="t" totalizar="n" quebra="true"/>
  </Campos>
  <Consultas>
   <Consulta tipo="Principal">
    <Select>
     <Campo id="3349"/>
     <Campo id="3348"/>
    </Select>
    <From>select sum(r38_liq) as total_recurso, o15_descr from folha inner join rhlota on r38_lotac::integer = r70_codigo inner join rhlotavinc on r70_codigo = rh25_codigo inner join orctiporec on o15_codigo = rh25_recurso where rh25_anousu = fc_anofolha(fc_getsession(''DB_instit'')::integer) and rh25_recurso in ( $sRecursos ) group by o15_codigo</From>
    <Where/>
    <Group></Group>
    <Order>
     <Ordem id="3348" nome="o15_descr" ascdesc="asc" alias="Tipo de Recurso"/>
    </Order>
   </Consulta>
  </Consultas>
 </Relatorio>'
where db63_sequencial = 20;

update db_relatorio
   set db63_xmlestruturarel = ' <?xml version="1.0" encoding="ISO-8859-1"?>
 <Relatorio>
  <Versao>1.0</Versao>
  <Propriedades versao="1.0" nome="Lí­quidos da folha por Recurso/Banco - PDF" layout="dbseller" formato="A4" orientacao="portrait" margemsup="0" margeminf="0" margemesq="20" margemdir="20" tiposaida="pdf"/>
  <Cabecalho></Cabecalho>
  <Rodape></Rodape>
  <Variaveis>
   <Variavel nome="$sRecursos" label="" tipodado="varchar" valor=""/>
  </Variaveis>
  <Campos>
   <Campo id="3905" nome="r38_regist" alias="Matrícula" largura="18" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
   <Campo id="3906" nome="r38_nome" alias="Nome" largura="120" alinhamento="l" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
   <Campo id="3919" nome="r38_liq" alias="Salário" largura="30" alinhamento="r" alinhamentocab="c" mascara="m" totalizar="n" quebra=""/>
   <Campo id="3921" nome="recurso" alias="Recurso" largura="120" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra="true"/>
   <Campo id="3920" nome="banco" alias="Banco" largura="120" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra="true"/>
  </Campos>
  <Consultas>
   <Consulta tipo="Principal">
    <Select>
     <Campo id="3905"/>
     <Campo id="3906"/>
     <Campo id="3919"/>
     <Campo id="3921"/>
     <Campo id="3920"/>
    </Select>
    <From>select r38_banco    || '' - '' || db90_descr as Banco,
        rh25_recurso || '' - '' || o15_descr as Recurso,
        r38_regist,
        r38_nome,
        r38_liq
 from folha
 inner join rhlota on r38_lotac::integer = r70_codigo
 inner join rhlotavinc on r70_codigo     = rh25_codigo
 inner join orctiporec on o15_codigo     = rh25_recurso
 inner join db_bancos  on db90_codban    = r38_banco
 where rh25_anousu = fc_anofolha(fc_getsession(''db_instit'')::integer)
 and rh25_recurso in ( $sRecursos )
 order by rh25_recurso,
          r38_banco,
          r38_nome</From>
    <Where/>
    <Group></Group>
    <Order></Order>
   </Consulta>
  </Consultas>
 </Relatorio>'
where db63_sequencial = 25;

update db_relatorio
   set db63_xmlestruturarel = ' <?xml version="1.0" encoding="ISO-8859-1"?>
 <Relatorio>
  <Versao>1.0</Versao>
  <Propriedades versao="1.0" nome="LÃ­quidos da folha por Recurso/Banco - CSV" layout="dbseller" formato="A4" orientacao="portrait" margemsup="0" margeminf="0" margemesq="20" margemdir="20" tiposaida="csv"/>
  <Cabecalho></Cabecalho>
  <Rodape></Rodape>
  <Variaveis>
   <Variavel nome="$sRecursos" label="" tipodado="varchar" valor=""/>
  </Variaveis>
  <Campos>
   <Campo id="3905" nome="r38_regist" alias="Matrícula" largura="18" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
   <Campo id="3906" nome="r38_nome" alias="Nome" largura="120" alinhamento="l" alinhamentocab="c" mascara="t" totalizar="n" quebra=""/>
   <Campo id="3919" nome="r38_liq" alias="Salário" largura="30" alinhamento="r" alinhamentocab="c" mascara="m" totalizar="n" quebra=""/>
   <Campo id="3921" nome="recurso" alias="Recurso" largura="120" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra="true"/>
   <Campo id="3920" nome="banco" alias="Banco" largura="120" alinhamento="c" alinhamentocab="c" mascara="t" totalizar="n" quebra="true"/>
  </Campos>
  <Consultas>
   <Consulta tipo="Principal">
    <Select>
     <Campo id="3905"/>
     <Campo id="3906"/>
     <Campo id="3919"/>
     <Campo id="3921"/>
     <Campo id="3920"/>
    </Select>
    <From>select r38_banco    || '' - '' || db90_descr as Banco,
        rh25_recurso || '' - '' || o15_descr as Recurso,
        r38_regist,
        r38_nome,
        r38_liq
 from folha
 inner join rhlota on r38_lotac::integer = r70_codigo
 inner join rhlotavinc on r70_codigo     = rh25_codigo
 inner join orctiporec on o15_codigo     = rh25_recurso
 inner join db_bancos  on db90_codban    = r38_banco
 where rh25_anousu = fc_anofolha(fc_getsession(''db_instit'')::integer)
 and rh25_recurso in ( $sRecursos )
 order by rh25_recurso,
          r38_banco,
          r38_nome</From>
    <Where/>
    <Group></Group>
    <Order></Order>
   </Consulta>
  </Consultas>
 </Relatorio>'
where db63_sequencial = 26;
---------------------------------------------------------------------------------------------
------------------------------------ FIM FOLHA ----------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
------------------------------- INICIO EDUCAÇÃO E SAÚDE -------------------------------------
---------------------------------------------------------------------------------------------

delete from db_viradacaditem where c33_sequencial in (34, 35);
--biblioteca
alter table exemplar drop COLUMN bi23_exemplar ;
alter table acervo drop column bi06_cutter;

---------------------------------------------------------------------------------------------
--------------------------------- FIM EDUCAÇÃO E SAÚDE --------------------------------------
---------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------
------------------------------- INICIO TRIBUTÁRIO -------------------------------------------
---------------------------------------------------------------------------------------------

delete from db_sysfuncoesparam where db42_funcao in (select codfuncao from db_sysfuncoes where nomefuncao ilike 'fc_calculoiptu_taquari_2016' );
delete from db_sysfuncoes      where nomefuncao ilike 'fc_calculoiptu_taquari_2016';

delete from db_sysfuncoesparam where db42_funcao in (select codfuncao from db_sysfuncoes where nomefuncao ilike 'fc_iptu_taxacoletalixo_taquari_2016' );
delete from db_sysfuncoes      where nomefuncao ilike 'fc_iptu_taxacoletalixo_taquari_2016';

delete from db_sysfuncoesparam where db42_funcao in (select codfuncao from db_sysfuncoes where nomefuncao ilike 'fc_iptu_taxacoletalixo_itaqui_2016' );
delete from db_sysfuncoes      where nomefuncao ilike 'fc_iptu_taxacoletalixo_itaqui_2016';

alter table parfiscal drop column y32_calculavistoriamei;

---------------------------------------------------------------------------------------------
------------------------------- FIM TRIBUTÁRIO ----------------------------------------------
---------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------
------------------------------- INICIO FOLHA ------------------------------------------------
---------------------------------------------------------------------------------------------

alter table cfpess drop column r11_baserrarendimentostributaveis;
alter table cfpess drop column r11_baserraprevidenciasocial;
alter table cfpess drop column r11_baserrapensaoalimenticia;
alter table cfpess drop column r11_baserrairrf;

---------------------------------------------------------------------------------------------
------------------------------- FIM FOLHA ---------------------------------------------------
---------------------------------------------------------------------------------------------