---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------- INICIO TRIBUTARIO ---------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

CREATE SEQUENCE itbiintermediador_it35_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE itbiintermediador(
  it35_sequencial int4         NOT NULL default nextval('itbiintermediador_it35_sequencial_seq'),
  it35_itbi       int4         NOT NULL,
  it35_cgm        varchar(20)  default null,
  it35_nome       varchar(100) default null,
  it35_cnpj_cpf   varchar(14)  default null,
  it35_creci      varchar(20)  default null,
  it35_principal  bool         default 'f',
  CONSTRAINT itbiintermediador_sequ_pk PRIMARY KEY (it35_sequencial)
);

ALTER TABLE itbiintermediador ADD CONSTRAINT itbiintermediador_itbi_fk FOREIGN KEY (it35_itbi) REFERENCES itbi(it01_guia);

---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO FOLHA ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
alter table rhrubricas add column rh27_valorlimite      float8   default 0;
alter table rhrubricas add column rh27_quantidadelimite float8   default 0;
alter table rhrubricas add column rh27_tipobloqueio     char(1)  default 'N';

CREATE SEQUENCE avaliacaogruporespostacgm_eso02_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE SEQUENCE avaliacaoperguntadb_formulas_eso01_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE avaliacaogruporespostacgm(
eso02_sequencial		int4 NOT NULL default 0,
eso02_avaliacaogruporesposta		int4 NOT NULL default 0,
eso02_cgm		int4 default 0,
CONSTRAINT avaliacaogruporespostacgm_sequ_pk PRIMARY KEY (eso02_sequencial));

CREATE TABLE avaliacaoperguntadb_formulas(
eso01_sequencial		int4 NOT NULL default 0,
eso01_db_formulas		int4 NOT NULL default 0,
eso01_avaliacaopergunta		int4 default 0,
CONSTRAINT avaliacaoperguntadb_formulas_sequ_pk PRIMARY KEY (eso01_sequencial));

-- CHAVE ESTRANGEIRA
ALTER TABLE avaliacaogruporespostacgm
ADD CONSTRAINT avaliacaogruporespostacgm_avaliacaogruporesposta_fk FOREIGN KEY (eso02_avaliacaogruporesposta)
REFERENCES avaliacaogruporesposta;

ALTER TABLE avaliacaogruporespostacgm
ADD CONSTRAINT avaliacaogruporespostacgm_cgm_fk FOREIGN KEY (eso02_cgm)
REFERENCES cgm;

-- INDICES
CREATE UNIQUE INDEX avaliacaogruporespostacgm_un_in    ON avaliacaogruporespostacgm(eso02_avaliacaogruporesposta,eso02_cgm);
CREATE UNIQUE INDEX avaliacaoperguntadb_formulas_un_in ON avaliacaoperguntadb_formulas(eso01_db_formulas,eso01_avaliacaopergunta);

---------------------------------------------------------------------------------------------------------------------------
----------------------------------------------- INICIO EDUCACAO/SAUDE  ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
ALTER TABLE sec_parametros ADD COLUMN ed290_diasmanutencaohistorico int4 not null default 0;




--------------------------------------------------
-------------- GT ENTREGA CONTINUA ---------------
--------------------------------------------------

-- fc_executa_ddl

select fc_executa_ddl('

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21801 ,''h82_formulafim'' ,''int4'' ,''Fórmula que informa a data de fim do assentamento que será lançado.'' ,''0'' ,''Fórmula de Fim'' ,19 ,''false'' ,''false'' ,''false'' ,1 ,''text'' ,''Fórmula de Fim'' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3835 ,21801 ,7 ,0 );
insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21802 ,''h82_formulafaltasperiodo'' ,''int4'' ,''Fórmula que informa a as faltas por período do assentamento que será lançado.'' ,''0'' ,''Fórmula de Faltas por Período'' ,19 ,''false'' ,''false'' ,''false'' ,1 ,''text'' ,''Fórmula de Faltas por Período'' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3835 ,21802 ,8 ,0 );

delete from db_syscadind where codind = 4229;
insert into db_syscadind values(4229,21280,1);
insert into db_syscadind values(4229,21283,4);
insert into db_syscadind values(4229,21284,5);


alter table agendaassentamento add column h82_formulafim integer;
alter table agendaassentamento add column h82_formulafaltasperiodo integer;

update agendaassentamento set h82_formulafim = (select db148_sequencial from db_formulas where db148_nome = ''FINAL_GTS''), h82_formulafaltasperiodo = (select db148_sequencial from db_formulas where db148_nome = ''FALTAS_PERIODO'');

alter table agendaassentamento alter column h82_formulafim set not null;
alter table agendaassentamento alter column h82_formulafaltasperiodo set not null;


ALTER TABLE agendaassentamento
ADD CONSTRAINT agendaassentamento_formulafim_fk FOREIGN KEY (h82_formulafim)
REFERENCES db_formulas;

ALTER TABLE agendaassentamento
ADD CONSTRAINT agendaassentamento_formulafaltasperiodo_fk FOREIGN KEY (h82_formulafaltasperiodo)
REFERENCES db_formulas;

DROP INDEX agendaassentamento_un_in;
CREATE UNIQUE INDEX agendaassentamento_un_in ON agendaassentamento(h82_tipoassentamento, h82_selecao, h82_instit);

');