------------------------------------------------------------------------------------
------------------------------ TRIBUTARIO ------------------------------------------
------------------------------------------------------------------------------------

DROP TABLE IF EXISTS evolucaodividaativa CASCADE;
DROP SEQUENCE IF EXISTS evolucaodividaativa_v30_sequencial_seq;

----------------------------------------------------------------------------------------
------------------------------ FIM TRIBUTARIO ------------------------------------------
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
------------------------------- INÍCIO FOLHA -------------------------------------------
----------------------------------------------------------------------------------------
------Removendo coluna da tabela de tipo de assentamentos
---------------------------------------------------------
ALTER TABLE tipoasse DROP CONSTRAINT h12_natureza_fk;
ALTER TABLE tipoasse DROP COLUMN h12_natureza;
------Removendo colunas à tabela cfpess para guardar rúbricas de desconto no exercício e exercício anterior
-----------------------------------------------------------------------------------------------------------
ALTER TABLE cfpess DROP COLUMN r11_rubricasubstituicaoatual;
ALTER TABLE cfpess DROP COLUMN r11_rubricasubstituicaoanterior;

------Removendo tabelas
-----------------------
DROP TABLE IF EXISTS loteregistropontorhfolhapagamento;
DROP TABLE IF EXISTS assentamentosubstituicao;
DROP TABLE IF EXISTS assentaloteregistroponto;
DROP TABLE IF EXISTS baserhcadregime;
DROP TABLE IF EXISTS naturezatipoassentamento;

------Removendo sequencias
--------------------------
DROP SEQUENCE IF EXISTS loteregistropontorhfolhapagamento_rh162_sequencial_seq;
DROP SEQUENCE IF EXISTS assentaloteregistroponto_rh160_sequencial_seq;
DROP SEQUENCE IF EXISTS baserhcadregime_rh158_sequencial_seq;
DROP SEQUENCE IF EXISTS naturezatipoassentamento_rh159_sequencial_seq;


------removendo dados das tabelas para contrato emergencial.
------------------------------------------------------------
DROP TABLE IF EXISTS rhcontratoemergencialrenovacao;
DROP TABLE IF EXISTS rhcontratoemergencial;
DROP SEQUENCE IF EXISTS rhcontratoemergencial_rh163_sequencial_seq;
DROP SEQUENCE IF EXISTS rhcontratoemergencialrenovacao_rh164_sequencial_seq;


----------------------------------------------------------------------------------------
---------------------------------- FIM FOLHA -------------------------------------------
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
------------------------------ FINANCEIRO ------------------------------------------
----------------------------------------------------------------------------------------

ALTER TABLE empprestaitem ALTER COLUMN e46_valor TYPE real;

----------------------------------------------------------------------------------------
------------------------------ FIM FINANCEIRO ------------------------------------------
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
----------------------------------- TIME C ---------------------------------------------
----------------------------------------------------------------------------------------

ALTER TABLE ensino
        DROP COLUMN ed10_ordem;

ALTER TABLE far_matersaude
        DROP COLUMN fa01_codigobarras;

-- Tarefa do censo
insert into db_layoutcampos( db52_codigo ,db52_layoutlinha ,db52_nome ,db52_descr ,db52_layoutformat ,db52_posicao ,db52_default ,db52_tamanho ,db52_ident ,db52_imprimir ,db52_alinha ,db52_obs ,db52_quebraapos )
     values ( 12162 ,734 ,'pipe' ,'FINALIZADOR DE LINHA' ,14 ,685 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12387 ,735 ,'pipe' ,'FINALIZADOR DE LINHA' ,14 ,216 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12031 ,736 ,'pipe' ,'FINALIZADOR DE LINHA' ,14 ,218 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12056 ,737 ,'pipe' ,'PIPE' ,14 ,388 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12070 ,738 ,'pipe' ,'PIPE' ,14 ,252 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12161 ,739 ,'pipe' ,'PIPE' ,14 ,136 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12243 ,740 ,'pipe' ,'PIPE' ,14 ,101 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12343 ,741 ,'pipe' ,'PIPE' ,14 ,393 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12345 ,742 ,'pipe' ,'PIPE' ,14 ,396 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 ),
            ( 12346 ,743 ,'pipe' ,'PIPE' ,14 ,104 ,'' ,1 ,'f' ,'t' ,'d' ,'' ,0 );


update censoativcompl
   set ed133_c_descr = upper('PROGRAMA MAIS EDUCACAO')
 where ed133_i_codigo = 91003;

update censoativcompl
   set ed133_c_descr = upper('CONSERVAÇÃO DO SOLO E COMPOSTEIRA')
 where ed133_i_codigo = 16101;

update censoativcompl
   set ed133_c_descr = upper('CANTEIROS SUSTENTÁVEIS')
 where ed133_i_codigo = 16102;

update censoativcompl
   set ed133_c_descr = upper('CUIDADOS COM ANIMAIS')
 where ed133_i_codigo = 16103;

update turmaacativ
   set ed267_i_censoativcompl = 13102
  from turmaac, calendario
 where ed267_i_turmaac        = ed268_i_codigo
   and ed52_i_codigo          = ed268_i_calendario
   and ed52_i_ano             = 2015
   and ed267_i_censoativcompl = 16101;

update turmaacativ
   set ed267_i_censoativcompl = 13103
  from turmaac, calendario
 where ed267_i_turmaac        = ed268_i_codigo
   and ed52_i_codigo          = ed268_i_calendario
   and ed52_i_ano             = 2015
   and ed267_i_censoativcompl = 16102;

update turmaacativ
   set ed267_i_censoativcompl = 13201
  from turmaac, calendario
 where ed267_i_turmaac        = ed268_i_codigo
   and ed52_i_codigo          = ed268_i_calendario
   and ed52_i_ano             = 2015
   and ed267_i_censoativcompl = 13108 ;
----------------------------------------------------------------------------------------
--------------------------------- FIM TIME C -------------------------------------------
----------------------------------------------------------------------------------------