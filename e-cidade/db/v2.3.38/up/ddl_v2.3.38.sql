------------------------------------------------------------------------------------
------------------------------ TRIBUTARIO ------------------------------------------
------------------------------------------------------------------------------------
-- Criando  sequences
CREATE SEQUENCE evolucaodividaativa_v30_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE evolucaodividaativa(
v30_sequencial                int4 NOT NULL default 0,
v30_receita                   int4 NOT NULL default 0,
v30_datageracao               date NOT NULL default null,
v30_valorhistorico            float8 default 0,
v30_valorcorrecao             float8 default 0,
v30_valorpagoparcial          float8 default 0,
v30_valorpagoparcialhistorico float8 default 0,
v30_valorpago                 float8 default 0,
v30_valorcancelado            float8 default 0,
v30_valordesconto             float8 default 0,
v30_valorpagohistorico        float8 default 0,
v30_valorcanceladohistorico   float8 default 0,
v30_instituicao               int4   default 0,
CONSTRAINT evolucaodividaativa_sequ_pk PRIMARY KEY (v30_sequencial));

ALTER TABLE evolucaodividaativa ADD CONSTRAINT evolucaodividaativa_instituicao_fk FOREIGN KEY (v30_instituicao) REFERENCES db_config;
ALTER TABLE evolucaodividaativa ADD CONSTRAINT evolucaodividaativa_receita_fk     FOREIGN KEY (v30_receita)     REFERENCES tabrec;

CREATE UNIQUE INDEX evolucaodividaativa_receita_instituicao_datageracao_in ON evolucaodividaativa(v30_receita,v30_instituicao,v30_datageracao);

----------------------------------------------------------------------------------------
------------------------------ FIM TRIBUTARIO ------------------------------------------
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
------------------------------- INÍCIO FOLHA -------------------------------------------
----------------------------------------------------------------------------------------
----Criando sequences
---------------------
CREATE SEQUENCE baserhcadregime_rh158_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE SEQUENCE naturezatipoassentamento_rh159_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE SEQUENCE assentaloteregistroponto_rh160_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE SEQUENCE loteregistropontorhfolhapagamento_rh162_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-----Criando tabelas
--------------------
CREATE TABLE baserhcadregime(
    rh158_sequencial      int4 NOT NULL default nextval('baserhcadregime_rh158_sequencial_seq'),
    rh158_regime          int4 NOT NULL,
    rh158_ano             int4 NOT NULL,
    rh158_mes             int4 NOT NULL,
    rh158_basesubstituto  varchar(4) NOT NULL,
    rh158_basesubstituido varchar(4) NOT NULL,
    rh158_instit          int4 NOT NULL,
  CONSTRAINT rh158_sequencial_pk PRIMARY KEY (rh158_sequencial)
);

CREATE TABLE naturezatipoassentamento (
    rh159_sequencial   int4 NOT NULL default nextval('naturezatipoassentamento_rh159_sequencial_seq'),
    rh159_descricao    varchar(30) NOT NULL,
  CONSTRAINT rh159_sequencial_pk PRIMARY KEY (rh159_sequencial)
);

CREATE TABLE assentaloteregistroponto (
    rh160_sequencial         int4 NOT NULL default nextval('assentaloteregistroponto_rh160_sequencial_seq'),
    rh160_assentamento       int4 NOT NULL,
    rh160_loteregistroponto  int4 NOT NULL,
  CONSTRAINT rh160_sequencial_pk PRIMARY KEY (rh160_sequencial)
);

CREATE TABLE assentamentosubstituicao (
    rh161_assentamento  int4 NOT NULL,
    rh161_regist        int4 NOT NULL,
  CONSTRAINT rh161_assentamento_pk PRIMARY KEY (rh161_assentamento)
);

CREATE TABLE loteregistropontorhfolhapagamento (
    rh162_sequencial          int4 NOT NULL default nextval('loteregistropontorhfolhapagamento_rh162_sequencial_seq'),
    rh162_loteregistroponto   int4 NOT NULL,
    rh162_rhfolhapagamento    int4 NOT NULL,
  CONSTRAINT rh162_sequencial_pk PRIMARY KEY (rh162_sequencial)
);

------Inserindo valores na tabela naturezatipoassentamento
----------------------------------------------------------
INSERT INTO naturezatipoassentamento (rh159_descricao) VALUES('Padrao');
INSERT INTO naturezatipoassentamento (rh159_descricao) VALUES('Substituicao');

------Adicionando coluna à tabela de tipos de assentamento
----------------------------------------------------------
ALTER TABLE tipoasse
        ADD COLUMN h12_natureza int4 NOT NULL default 1;

------Adicionando colunas à tabela cfpess para guardar rúbricas de desconto no exercício e exercício anterior
-------------------------------------------------------------------------------------------------------------
ALTER TABLE cfpess
        ADD COLUMN r11_rubricasubstituicaoatual varchar(4);
ALTER TABLE cfpess
        ADD COLUMN r11_rubricasubstituicaoanterior varchar(4);

------Criando chaves estrangeiras
---------------------------------
ALTER TABLE baserhcadregime
        ADD CONSTRAINT rh158_regime_fk FOREIGN KEY (rh158_regime) REFERENCES rhcadregime;
ALTER TABLE baserhcadregime
        ADD CONSTRAINT basesubstituto_fk FOREIGN KEY (rh158_ano, rh158_mes, rh158_basesubstituto, rh158_instit) REFERENCES bases;

ALTER TABLE baserhcadregime
        ADD CONSTRAINT basesubstituido_fk FOREIGN KEY (rh158_ano, rh158_mes, rh158_basesubstituido, rh158_instit) REFERENCES bases;

ALTER TABLE loteregistropontorhfolhapagamento
        ADD CONSTRAINT rh162_loteregistroponto_fk FOREIGN KEY (rh162_loteregistroponto) REFERENCES loteregistroponto;

ALTER TABLE loteregistropontorhfolhapagamento
        ADD CONSTRAINT rh162_rhfolhapagamento_fk FOREIGN KEY (rh162_rhfolhapagamento) REFERENCES rhfolhapagamento;


ALTER TABLE assentaloteregistroponto
        ADD CONSTRAINT rh160_assentamento_fk FOREIGN KEY (rh160_assentamento) REFERENCES assenta;
ALTER TABLE assentaloteregistroponto
        ADD CONSTRAINT rh160_loteregistroponto_fk FOREIGN KEY (rh160_loteregistroponto) REFERENCES loteregistroponto;

ALTER TABLE assentamentosubstituicao
        ADD CONSTRAINT rh161_assentamento_fk FOREIGN KEY (rh161_assentamento) REFERENCES assenta;
ALTER TABLE assentamentosubstituicao
        ADD CONSTRAINT rh161_regist_fk FOREIGN KEY (rh161_regist) REFERENCES rhpessoal;

ALTER TABLE tipoasse
        ADD CONSTRAINT h12_natureza_fk FOREIGN KEY (h12_natureza) REFERENCES naturezatipoassentamento;

------Criando indices
---------------------
CREATE UNIQUE INDEX baserhcadregime_in
                 on baserhcadregime(rh158_regime, rh158_ano, rh158_mes, rh158_basesubstituto, rh158_basesubstituido, rh158_instit);


CREATE INDEX naturezatipoassentamento_seq_in
          on naturezatipoassentamento(rh159_sequencial);

CREATE UNIQUE INDEX assentaloteregistroponto_un_in
          on assentaloteregistroponto(rh160_assentamento, rh160_loteregistroponto);

CREATE UNIQUE INDEX assentamentosubstituicao_un_in
          on assentamentosubstituicao(rh161_assentamento, rh161_regist);

CREATE UNIQUE INDEX loteregistropontorhfolhapagamento_un_in
          on loteregistropontorhfolhapagamento(rh162_loteregistroponto, rh162_rhfolhapagamento);

------------------------------------------------------------
------Criaçao das tabelas para contrato emergencial. -------
------------------------------------------------------------

-- Criando  sequences
select fc_executa_ddl('CREATE SEQUENCE rhcontratoemergencial_rh163_sequencial_seq
                       INCREMENT 1
                       MINVALUE 1
                       MAXVALUE 9223372036854775807
                       START 1
                       CACHE 1;');

select fc_executa_ddl('CREATE SEQUENCE rhcontratoemergencialrenovacao_rh164_sequencial_seq
                       INCREMENT 1
                       MINVALUE 1
                       MAXVALUE 9223372036854775807
                       START 1
                       CACHE 1;');

-- Módulo: pessoal
select fc_executa_ddl('CREATE TABLE rhcontratoemergencial(
                                                           rh163_sequencial int4 NOT NULL default 0,
                                                           rh163_matricula  int4 default 0,
                                                           CONSTRAINT rhcontratoemergencial_sequ_pk PRIMARY KEY (rh163_sequencial)
                                                         );');

-- Módulo: pessoal
select fc_executa_ddl('CREATE TABLE rhcontratoemergencialrenovacao(
                                                                   rh164_sequencial    int4 NOT NULL default 0,
                                                                   rh164_contratoemergencial   int4 NOT NULL default 0,
                                                                   rh164_descricao   varchar(255)  ,
                                                                   rh164_datainicio    date NOT NULL default null,
                                                                    rh164_datafim   date default null,
                                                                    CONSTRAINT rhcontratoemergencialrenovacao_sequ_pk PRIMARY KEY (rh164_sequencial)
                                                                  );');

-- CHAVE ESTRANGEIRA
select fc_executa_ddl('ALTER TABLE rhcontratoemergencialrenovacao
                       ADD CONSTRAINT rhcontratoemergencialrenovacao_contratoemergencial_fk FOREIGN KEY (rh164_contratoemergencial)
                       REFERENCES rhcontratoemergencial;');


----------------------------------------------------------------------------------------
---------------------------------- FIM FOLHA -------------------------------------------
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
------------------------------ FINANCEIRO ------------------------------------------
----------------------------------------------------------------------------------------

ALTER TABLE empprestaitem ALTER COLUMN e46_valor TYPE numeric;
select fc_executa_ddl('CREATE SEQUENCE empenhocotamensal_e05_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;');
select fc_executa_ddl('CREATE TABLE empenhocotamensal(
e05_sequencial		int4 NOT NULL default 0,
e05_numemp		int4 NOT NULL default 0,
e05_mes		int4 NOT NULL default 0,
e05_valor		float8 default 0,
CONSTRAINT empenhocotamensal_sequ_pk PRIMARY KEY (e05_sequencial));');
select fc_executa_ddl('ALTER TABLE empenhocotamensal
ADD CONSTRAINT empenhocotamensal_numemp_fk FOREIGN KEY (e05_numemp)
REFERENCES empempenho;');
select fc_executa_ddl('CREATE  INDEX empenhocotamensal_empenho_in ON empenhocotamensal(e05_numemp);');
select fc_executa_ddl('CREATE  INDEX empenhocotamensal_mes_in ON empenhocotamensal(e05_mes);');

select fc_executa_ddl('CREATE SEQUENCE cronogramaperspectivaacompanhamento_o151_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;');

select fc_executa_ddl('CREATE TABLE cronogramaperspectivaacompanhamento(
o151_sequencial		int4 NOT NULL default 0,
o151_cronogramaperspectivaorigem		int4 NOT NULL default 0,
o151_cronogramaperspectiva		int4 NOT NULL default 0,
o151_mes		int4 default 0,
CONSTRAINT cronogramaperspectivaacompanhamento_sequ_pk PRIMARY KEY (o151_sequencial));');







select fc_executa_ddl('ALTER TABLE cronogramaperspectivaacompanhamento
ADD CONSTRAINT cronogramaperspectivaacompanhamento_cronogramaperspectivaorigem_fk FOREIGN KEY (o151_cronogramaperspectivaorigem)
REFERENCES cronogramaperspectiva;');

select fc_executa_ddl('ALTER TABLE cronogramaperspectivaacompanhamento
ADD CONSTRAINT cronogramaperspectivaacompanhamento_cronogramaperspectiva_fk FOREIGN KEY (o151_cronogramaperspectiva)
REFERENCES cronogramaperspectiva;');

select fc_executa_ddl('CREATE  INDEX cronogramaperspectivaacompanhamento_persp_in ON cronogramaperspectivaacompanhamento(o151_cronogramaperspectiva);');

select fc_executa_ddl('CREATE  INDEX cronogramaperspectivaacompanhamento_orig_in ON cronogramaperspectivaacompanhamento(o151_cronogramaperspectivaorigem);');


select fc_executa_ddl('alter table cronogramaperspectiva add o124_tipo integer default 1;');

----------------------------------------------------------------------------------------
------------------------------ FIM FINANCEIRO ------------------------------------------
----------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------
----------------------------------- TIME C ---------------------------------------------
----------------------------------------------------------------------------------------

ALTER TABLE ensino
        ADD COLUMN ed10_ordem int4;
UPDATE ensino SET ed10_ordem = ed10_i_codigo;

ALTER TABLE far_matersaude
        ADD COLUMN fa01_codigobarras varchar(20);

-- Tarefa do censo
delete from db_layoutcampos where db52_codigo in (12162, 12387, 12031, 12056, 12070, 12161, 12243, 12343, 12345, 12346);

update censoativcompl
   set ed133_c_descr = upper('Serviço de Convivência e Fortalecimento de Vínculos (SCFV)')
 where ed133_i_codigo = 91003;

update censoativcompl
   set ed133_c_descr = upper('Canteiros Sustentáveis')
 where ed133_i_codigo = 16101;

update censoativcompl
   set ed133_c_descr = upper('Cuidados com Animais')
 where ed133_i_codigo = 16102;

update censoativcompl
   set ed133_c_descr = upper('COM-VIDA (Comissão de Meio Ambiente e Qualidade de Vida)')
 where ed133_i_codigo = 16103;

update turmaacativ
   set ed267_i_censoativcompl = 16101
  from turmaac, calendario
 where ed267_i_turmaac        = ed268_i_codigo
   and ed52_i_codigo          = ed268_i_calendario
   and ed52_i_ano             = 2015
   and ed267_i_censoativcompl = 13102;

update turmaacativ
   set ed267_i_censoativcompl = 16102
  from turmaac, calendario
 where ed267_i_turmaac        = ed268_i_codigo
   and ed52_i_codigo          = ed268_i_calendario
   and ed52_i_ano             = 2015
   and ed267_i_censoativcompl = 13103;

update turmaacativ
   set ed267_i_censoativcompl = 13108
  from turmaac, calendario
 where ed267_i_turmaac        = ed268_i_codigo
   and ed52_i_codigo          = ed268_i_calendario
   and ed52_i_ano             = 2015
   and ed267_i_censoativcompl = 13201;


----------------------------------------------------------------------------------------
--------------------------------- FIM TIME C -------------------------------------------
----------------------------------------------------------------------------------------