---------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------- INICIO SAÚDE ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
CREATE SEQUENCE cgs_unddocumento_sd108_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


CREATE SEQUENCE cgs_undendereco_sd109_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE cgs_unddocumento(
sd108_sequencial    int4 NOT NULL,
sd108_cgs_und       int4 NOT NULL,
sd108_documento  int4 NOT NULL );

CREATE TABLE cgs_undendereco(
sd109_sequencial int4 NOT NULL,
sd109_endereco int4 NOT NULL ,
sd109_cgs_und int4 NOT NULL );

alter table cgs_und add column z01_orgaoemissoridentidade varchar(100);


-- CHAVE ESTRANGEIRA


ALTER TABLE cgs_unddocumento
ADD CONSTRAINT cgs_unddocumento_und_fk FOREIGN KEY (sd108_cgs_und)
REFERENCES cgs_und;

ALTER TABLE cgs_unddocumento
ADD CONSTRAINT cgs_unddocumento_documento_fk FOREIGN KEY (sd108_documento)
REFERENCES documento;

ALTER TABLE cgs_undendereco
ADD CONSTRAINT cgs_undendereco_und_fk FOREIGN KEY (sd109_cgs_und)
REFERENCES cgs_und;

ALTER TABLE cgs_undendereco
ADD CONSTRAINT cgs_undendereco_endereco_fk FOREIGN KEY (sd109_endereco)
REFERENCES endereco;




-- INDICES


CREATE  INDEX cgs_unddocumento_cgs_und_in ON cgs_unddocumento(sd108_cgs_und);

CREATE  INDEX cgs_unddocumento_documento_in ON cgs_unddocumento(sd108_documento);

CREATE  INDEX cgs_undendereco_cgs_und_in ON cgs_undendereco(sd109_cgs_und);

CREATE  INDEX cgs_undendereco_endereco_in ON cgs_undendereco(sd109_endereco);

alter table cgs_und alter COLUMN z01_v_cxpostal type varchar(50);
alter table cgs_undalt alter COLUMN z33_v_nome type varchar(255);

---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------- INICIO FINANCEIRO ----------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

DROP TABLE IF EXISTS classificacaocredoreselemento CASCADE;
DROP SEQUENCE IF EXISTS classificacaocredoreselemento_cc32_sequencial_seq;

CREATE SEQUENCE classificacaocredoreselemento_cc32_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE classificacaocredoreselemento(
cc32_sequencial int4 NOT NULL default 0,
cc32_classificacaocredores int4 NOT NULL default 0,
cc32_codcon int4 NOT NULL default 0,
cc32_anousu int4 NOT NULL default 0,
cc32_exclusao bool default false,
CONSTRAINT classificacaocredoreselemento_sequ_pk PRIMARY KEY (cc32_sequencial));

ALTER TABLE classificacaocredoreselemento
ADD CONSTRAINT classificacaocredoreselemento_classificacaocredores_fk FOREIGN KEY (cc32_classificacaocredores)
REFERENCES classificacaocredores;

ALTER TABLE classificacaocredoreselemento
ADD CONSTRAINT classificacaocredoreselemento_conplanoorcamento_fk FOREIGN KEY (cc32_codcon, cc32_anousu)
REFERENCES conplanoorcamento;


DROP TABLE IF EXISTS classificacaocredoresrecurso CASCADE;
DROP SEQUENCE IF EXISTS classificacaocredoresrecurso_cc33_sequencial_seq;

CREATE SEQUENCE classificacaocredoresrecurso_cc33_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE classificacaocredoresrecurso(
cc33_sequencial int4 NOT NULL default 0,
cc33_classificacaocredores int4 NOT NULL default 0,
cc33_orctiporec int4 default 0,
CONSTRAINT classificacaocredoresrecurso_sequ_pk PRIMARY KEY (cc33_sequencial));

ALTER TABLE classificacaocredoresrecurso
ADD CONSTRAINT classificacaocredoresrecurso_orctiporec_fk FOREIGN KEY (cc33_orctiporec)
REFERENCES orctiporec;

ALTER TABLE classificacaocredoresrecurso
ADD CONSTRAINT classificacaocredoresrecurso_classificacaocredores_fk FOREIGN KEY (cc33_classificacaocredores)
REFERENCES classificacaocredores;


DROP TABLE IF EXISTS classificacaocredorestipocompra CASCADE;
DROP SEQUENCE IF EXISTS classificacaocredorestipocompra_cc34_sequencial_seq;

CREATE SEQUENCE classificacaocredorestipocompra_cc34_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE classificacaocredorestipocompra(
cc34_sequencial	int4 NOT NULL default 0,
cc34_classificacaocredores int4 NOT NULL default 0,
cc34_pctipocompra	int4 default 0,
CONSTRAINT classificacaocredorestipocompra_sequ_pk PRIMARY KEY (cc34_sequencial));

ALTER TABLE classificacaocredorestipocompra
ADD CONSTRAINT classificacaocredorestipocompra_classificacaocredores_fk FOREIGN KEY (cc34_classificacaocredores)
REFERENCES classificacaocredores;

ALTER TABLE classificacaocredorestipocompra
ADD CONSTRAINT classificacaocredorestipocompra_pctipocompra_fk FOREIGN KEY (cc34_pctipocompra)
REFERENCES pctipocompra;

DROP TABLE IF EXISTS classificacaocredoresevento CASCADE;
DROP SEQUENCE IF EXISTS classificacaocredoresevento_cc35_sequencial_seq;

CREATE SEQUENCE classificacaocredoresevento_cc35_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE classificacaocredoresevento(
cc35_sequencial              int4 NOT NULL default 0,
cc35_classificacaocredores   int4 NOT NULL default 0,
cc35_empprestatip            int4 not null default 0,
CONSTRAINT classificacaocredoresevento_sequ_pk PRIMARY KEY (cc35_sequencial));

ALTER TABLE classificacaocredoresevento ADD CONSTRAINT classificacaocredoresevento_empprestatip_fk FOREIGN KEY (cc35_empprestatip) REFERENCES empprestatip;
ALTER TABLE classificacaocredoresevento ADD CONSTRAINT classificacaocredoresevento_classificacaocredores_fk FOREIGN KEY (cc35_classificacaocredores) REFERENCES classificacaocredores;

ALTER TABLE classificacaocredores ADD COLUMN cc30_diasvencimento int4 default null;
ALTER TABLE classificacaocredores ADD COLUMN cc30_contagemdias int4 default null;
ALTER TABLE classificacaocredores ADD COLUMN cc30_valorinicial numeric default null;
ALTER TABLE classificacaocredores ADD COLUMN cc30_valorfinal numeric default null;
ALTER TABLE classificacaocredores ADD COLUMN cc30_dispensa boolean default false;
ALTER TABLE classificacaocredores ADD COLUMN cc30_ordem int4 not null default 0;


update classificacaocredores set cc30_dispensa = true where cc30_codigo = 4;

/**
 * DML - 99810
 */
insert into acordoempempenho
     select nextval('acordoempempenho_ac54_sequencial_seq'),
            e100_acordo,
            e100_numemp,
            null,
            null
       from empempenhocontrato
            inner join acordo on ac16_sequencial = e100_acordo
      where ac16_origem = 6;
update acordo set ac16_origem = 3 where ac16_origem = 6;

/**
 * Acertos para cadastro de lista de classificação de credores padrão
 */
update classificacaocredores set cc30_descricao = upper(cc30_descricao);

update classificacaocredores
set cc30_diasvencimento = 30,
  cc30_contagemdias = 1,
  cc30_ordem = 2
where cc30_codigo = 1;

update classificacaocredores
set cc30_diasvencimento = 5,
  cc30_contagemdias = 1,
  cc30_valorinicial = 0,
  cc30_valorfinal = 8000.00,
  cc30_ordem = 3
where cc30_codigo = 2;

update classificacaocredores
set cc30_diasvencimento = 30,
  cc30_contagemdias = 1,
  cc30_ordem = 4
where cc30_codigo = 3;

update classificacaocredores
set cc30_diasvencimento = null,
  cc30_contagemdias = null,
  cc30_ordem = 1
where cc30_codigo = 4;

insert into classificacaocredoresevento
  select
    nextval('classificacaocredoresevento_cc35_sequencial_seq'),
    4,
    e44_tipo
  from empprestatip
  where e44_obriga <> 0;

insert into classificacaocredoreselemento
  select
    nextval('classificacaocredoreselemento_cc32_sequencial_seq'),
    4,
    c60_codcon,
    c60_anousu,
    false
  from conplanoorcamento
  where c60_anousu = 2016
        and substring(c60_estrut from 1 for 1) = '3'
        and (substring(c60_estrut from 6 for 2) in ('47', '16', '93') or substring(c60_estrut from 1 for 3) = '331');



insert into classificacaocredoresrecurso
  select
    nextval('classificacaocredoresrecurso_cc33_sequencial_seq'),
    1,
    o15_codigo
  from orctiporec
  where o15_tipo = 2;

select setval('classificacaocredores_cc30_codigo_seq', 100);


delete from empautpresta where not exists (select 1 from empautoriza where e58_autori = e54_autori);
delete from empautpresta where not exists (select 1 from empprestatip where e44_tipo = e58_tipo);
alter table empautpresta add constraint empautoriza_empautpresta_fk foreign key (e58_autori) references empautoriza;
alter table empautpresta add constraint empprestatip_empautpresta_fk foreign key (e58_tipo) references empprestatip;
create index empautpresta_autori_in on empautpresta (e58_autori);


---------------------------------------------------------------------------------------------------------------------------
------------------------------------------------ INICIO FOLHA -------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------

--
-- Ajustes da TAG 99760 adicionada ao path da release 50
select fc_executa_ddl('CREATE SEQUENCE esocial.avaliacaogruporespostarhpessoal_eso02_sequencial_seq
                         INCREMENT 1
                         MINVALUE 1
                         MAXVALUE 9223372036854775807
                         START 1
                         CACHE 1;');

select fc_executa_ddl('CREATE TABLE esocial.avaliacaogruporespostarhpessoal(
                         eso02_sequencial int4 NOT NULL default nextval(''avaliacaogruporespostarhpessoal_eso02_sequencial_seq''),
                         eso02_avaliacaogruporesposta int4 NOT NULL,
                         eso02_rhpessoal int4 NOT NULL);');

select fc_executa_ddl('CREATE UNIQUE INDEX avaliacaogruporespostarhpessoal_un_in on avaliacaogruporespostarhpessoal(eso02_avaliacaogruporesposta, eso02_rhpessoal);');

select fc_executa_ddl('ALTER TABLE avaliacaogruporespostarhpessoal
                                                 ADD CONSTRAINT eso02_sequencial_pk PRIMARY KEY (eso02_sequencial);');
select fc_executa_ddl('ALTER TABLE avaliacaogruporespostarhpessoal
                                                 ADD CONSTRAINT eso02_avaliacaogruporesposta_fk FOREIGN KEY (eso02_avaliacaogruporesposta) REFERENCES avaliacaogruporesposta;');
select fc_executa_ddl('ALTER TABLE avaliacaogruporespostarhpessoal
                                                 ADD CONSTRAINT eso02_rhpessoal_fk FOREIGN KEY (eso02_rhpessoal) REFERENCES rhpessoal;');

--Guarda dados ja prenchidos do eSocial
select fc_executa_ddl('CREATE TEMP TABLE w_avaliacaogruporespostacgm AS (    SELECT avaliacaogruporespostacgm.*, rh01_regist as matricula
                                                                               FROM avaliacaogruporespostacgm
                                                                         INNER JOIN rhpessoal ON rh01_numcgm = eso02_cgm);');

DROP TABLE IF EXISTS avaliacaogruporespostacgm;
DROP SEQUENCE IF EXISTS avaliacaogruporespostacgm_eso02_sequencial_seq;

--Retorna os valores já respondidos do eSocial
select fc_executa_ddl('INSERT INTO avaliacaogruporespostarhpessoal (SELECT eso02_sequencial, eso02_avaliacaogruporesposta, matricula FROM w_avaliacaogruporespostacgm);');

--Ajuste o valor da sequence
select fc_executa_ddl('select setval(''avaliacaogruporespostarhpessoal_eso02_sequencial_seq'', (select max(eso02_sequencial) from w_avaliacaogruporespostacgm));');

-------------------------------
-- Melhorias para release 52 --
-------------------------------
CREATE SEQUENCE avaliacaogruporespostacgm_eso03_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE avaliacaogruporespostacgm(
eso03_sequencial              int4 NOT NULL default nextval('avaliacaogruporespostacgm_eso03_sequencial_seq'),
eso03_avaliacaogruporesposta  int4 NOT NULL,
eso03_cgm                     int4 NOT NULL,
CONSTRAINT avaliacaogruporespostacgm_pk PRIMARY KEY (eso03_sequencial));

ALTER TABLE avaliacaogruporespostacgm ADD CONSTRAINT avaliacaogruporespostacgm_avaliacaogruporesposta_fk FOREIGN KEY (eso03_avaliacaogruporesposta) REFERENCES avaliacaogruporesposta;
ALTER TABLE avaliacaogruporespostacgm ADD CONSTRAINT avaliacaogruporespostacgm_cgm_fk FOREIGN KEY (eso03_cgm) REFERENCES cgm;


select fc_executa_ddl('
  CREATE SEQUENCE cgmestrangeiro_z09_sequencial_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
  CREATE TABLE protocolo.cgmestrangeiro(
  z09_sequencial  int4 NOT NULL default 0,
  z09_numcgm      int4 NOT NULL default 0,
  z09_documento   varchar(30) not null,
  CONSTRAINT cgmestrangeiro_sequ_pk PRIMARY KEY (z09_sequencial));
  ALTER TABLE cgmestrangeiro ADD CONSTRAINT cgmestrangeiro_numcgm_fk FOREIGN KEY (z09_numcgm) REFERENCES cgm;
  CREATE INDEX cgmestrangeiro_numcgm_in ON cgmestrangeiro(z09_numcgm);
');









---------------------------------------------------------------------------------------
--------------------------------INICIO CONFIGURACAO------------------------------------
---------------------------------------------------------------------------------------

SELECT fc_executa_ddl('
ALTER TABLE db_auditoria_migracao ADD datahora_ini TIMESTAMP WITH TIME ZONE, ADD datahora_fim TIMESTAMP WITH TIME ZONE, ADD instit INTEGER[];

');


CREATE OR REPLACE FUNCTION fc_auditoria_busca_datahora_e_instit(data_inicial DATE, id_acount_ini INTEGER, id_acount_fim INTEGER, OUT datahora_ini TIMESTAMPTZ, OUT datahora_fim TIMESTAMPTZ, OUT instit INTEGER[]) AS $$
SELECT min(datahora_ini) AS datahora_ini,
       max(datahora_fim) AS datahora_fim,
       array_agg(instit) AS instit
FROM (
        (SELECT to_timestamp(min(datahr)) AS datahora_ini,
                to_timestamp(max(datahr)) AS datahora_fim,
                instit
         FROM
           (SELECT datahr,
                   coalesce(
                              (SELECT min(i.id_instit)
                               FROM db_userinst i
                               WHERE i.id_usuario=a.id_usuario),
                              (SELECT codigo
                               FROM db_config
                               WHERE prefeitura IS TRUE LIMIT 1)) AS instit
            FROM db_acount a
            WHERE NOT EXISTS
                (SELECT 1
                 FROM db_acountacesso ac
                 WHERE ac.id_acount = a.id_acount)
              AND a.id_acount BETWEEN $2 AND $3
) AS y
         GROUP BY instit)
      UNION ALL
        (SELECT (min(DATA)||' '||min(hora))::timestamptz AS datahora_ini,
                (max(DATA)||' '||max(hora))::timestamptz AS datahora_fim,
                la.instit
         FROM db_acountacesso ac
         JOIN db_logsacessa la ON la.codsequen=ac.codsequen
         AND la.DATA >= $1

         AND la.instit IN
           (SELECT codigo
            FROM db_config)
         WHERE ac.id_acount BETWEEN $2 AND $3

         GROUP BY la.instit)) AS x $$ LANGUAGE SQL;

 -- Ajusta registros ainda nao migrados

UPDATE db_auditoria_migracao
SET datahora_ini = (dhi).datahora_ini,
                         datahora_fim = (dhi).datahora_fim,
                                              instit = (dhi).instit
FROM
  (SELECT sequencial,
          fc_auditoria_busca_datahora_e_instit((CURRENT_DATE - interval '1 year')::date, id_acount_ini, id_acount_fim) AS dhi
   FROM db_auditoria_migracao
   WHERE status <> 'FINALIZADO'
     AND datahora_ini IS NULL
     AND datahora_fim IS NULL
     AND instit IS NULL) AS x
WHERE db_auditoria_migracao.sequencial = x.sequencial;


CREATE OR REPLACE FUNCTION fc_auditoria_adiciona_acount_fila() RETURNS void LANGUAGE SQL AS $function$
SELECT NEXTVAL('configuracoes.db_auditoria_migracao_sequencial_seq');
INSERT INTO configuracoes.db_auditoria_migracao (sequencial, id_acount_ini, id_acount_fim, status)
SELECT CURRVAL('configuracoes.db_auditoria_migracao_sequencial_seq'),
       id_acount_ini,
       id_acount_fim,
       status
FROM
  (SELECT COALESCE(MIN(id_acount), 0) AS id_acount_ini,
          COALESCE(MAX(id_acount), 0) AS id_acount_fim,
          'NAO INICIADO'::text AS status
   FROM ONLY configuracoes.db_acount
   WHERE id_acount > COALESCE(
                                (SELECT id_acount_fim
                                 FROM configuracoes.db_auditoria_migracao
                                 ORDER BY id_acount_fim DESC LIMIT 1), 0)) AS lote
WHERE (id_acount_ini + id_acount_fim) > 0;
  UPDATE db_auditoria_migracao
  SET datahora_ini = (dhi).datahora_ini,
                           datahora_fim = (dhi).datahora_fim,
                                                instit = (dhi).instit
  FROM
    (SELECT sequencial,
            fc_auditoria_busca_datahora_e_instit((CURRENT_DATE - interval '6 months')::date, id_acount_ini, id_acount_fim) AS dhi
     FROM db_auditoria_migracao
     WHERE sequencial = CURRVAL('configuracoes.db_auditoria_migracao_sequencial_seq')) AS x WHERE db_auditoria_migracao.sequencial = x.sequencial; $function$;

---------------------------------------------------------------------------------------
---------------------------------- FIM CONFIGURACAO------------------------------------
---------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------
---------------------------------- INICIO EDUCAÇÃO ------------------------------------
---------------------------------------------------------------------------------------

insert into censoetapa
    (select ed266_i_codigo, ed266_c_descr, ed266_c_regular, ed266_c_especial, ed266_c_eja, 2016
       from censoetapa
      where ed266_ano = 2015
        and not exists (select 1 from censoetapa where ed266_ano = 2016)
    );

insert into censoetapamediacaodidaticopedagogica
    (select nextval('censoetapamediacaodidaticopedagogica_ed131_codigo_seq'), ed131_mediacaodidaticopedagogica, ed131_censoetapa, 2016, ed131_regular, ed131_especial, ed131_eja, ed131_profissional
       from censoetapamediacaodidaticopedagogica
      where ed131_ano = 2015
        and not exists (select 1 from censoetapamediacaodidaticopedagogica where ed131_ano = 2016 )
    );

insert into censoregradisc
    (select nextval('censoregradisc_ed272_i_codigo_seq'), ed272_i_censoetapa, ed272_i_censodisciplina, 2016
       from censoregradisc
      where ed272_ano = 2015
        and not exists (select 1 from censoregradisc where ed272_ano = 2016 )
    );

update censoinstsuperior set ed257_c_nome = 'UNIVERSIDADE DO CONTESTADO'                            , ed257_i_censomunic = '4210100', ed257_i_dependencia = 3, ed257_i_tipo = 1, ed257_c_situacao = 'ATIVA' where ed257_i_codigo = 441;
update censoinstsuperior set ed257_c_nome = 'UNIVERSIDADE DO SUL DE SANTA CATARINA'                 , ed257_i_censomunic = '4218707', ed257_i_dependencia = 3, ed257_i_tipo = 1, ed257_c_situacao = 'ATIVA' where ed257_i_codigo = 494;
update censoinstsuperior set ed257_c_nome = 'CENTRO UNIVERSITARIO DE MANDAGUARI UNIMAN'             , ed257_i_censomunic = '4114203', ed257_i_dependencia = 3, ed257_i_tipo = 1, ed257_c_situacao = 'ATIVA' where ed257_i_codigo = 535;
update censoinstsuperior set ed257_c_nome = 'FACULDADE DE FORMACAO DE PROFESSORES DE SERRA TALHADA' , ed257_i_censomunic = '2613909', ed257_i_dependencia = 3, ed257_i_tipo = 1, ed257_c_situacao = 'ATIVA' where ed257_i_codigo = 657;
update censoinstsuperior set ed257_c_nome = 'UNIVERSIDADE DE TAUBATE'                               , ed257_i_censomunic = '3554102', ed257_i_dependencia = 3, ed257_i_tipo = 1, ed257_c_situacao = 'ATIVA' where ed257_i_codigo = 665;
update censoinstsuperior set ed257_c_nome = 'UNIVERSIDADE DO PLANALTO CATARINENSE'                  , ed257_i_censomunic = '4209300', ed257_i_dependencia = 3, ed257_i_tipo = 1, ed257_c_situacao = 'ATIVA' where ed257_i_codigo = 1189;
update censoinstsuperior set ed257_c_nome = 'FACULDADES ADAMANTINENSES INTEGRADAS'                  , ed257_i_censomunic = '3500105', ed257_i_dependencia = 3, ed257_i_tipo = 1, ed257_c_situacao = 'ATIVA' where ed257_i_codigo = 1292;
update censoinstsuperior set ed257_c_nome = 'FACULDADES INTEGRADAS DE SANTA FE DO SUL'              , ed257_i_censomunic = '3546603', ed257_i_dependencia = 3, ed257_i_tipo = 1, ed257_c_situacao = 'ATIVA' where ed257_i_codigo = 1356;
update censoinstsuperior set ed257_c_nome = 'CENTRO UNIVERSITARIO FUNDACAO SANTO ANDRE'             , ed257_i_censomunic = '3547809', ed257_i_dependencia = 3, ed257_i_tipo = 1, ed257_c_situacao = 'ATIVA' where ed257_i_codigo = 2183;
update censoinstsuperior set ed257_c_nome = 'UNIVERSIDADE COMUNITARIA DA REGIAO DE CHAPECO'         , ed257_i_censomunic = '4204202', ed257_i_dependencia = 3, ed257_i_tipo = 1, ed257_c_situacao = 'ATIVA' where ed257_i_codigo = 3151;
update censoinstsuperior set ed257_c_nome = 'UNIVERSIDADE DE RIO VERDE'                             , ed257_i_censomunic = '5218805', ed257_i_dependencia = 3, ed257_i_tipo = 1, ed257_c_situacao = 'ATIVA' where ed257_i_codigo = 3974;
update censoinstsuperior set ed257_c_nome = 'CENTRO UNIVERSITARIO MUNICIPAL DE SAO JOSE'            , ed257_i_censomunic = '4216602', ed257_i_dependencia = 3, ed257_i_tipo = 1, ed257_c_situacao = 'ATIVA' where ed257_i_codigo = 4756;
update censoinstsuperior set ed257_c_nome = 'UNIVERSIDADE ALTO VALE DO RIO DO PEIXE'                , ed257_i_censomunic = '4203006', ed257_i_dependencia = 3, ed257_i_tipo = 1, ed257_c_situacao = 'ATIVA' where ed257_i_codigo = 15032;
update censoinstsuperior set ed257_c_nome = 'FACULDADE DE CIENCIAS DA SAUDE DE SERRA TALHADA'       , ed257_i_censomunic = '2613909', ed257_i_dependencia = 3, ed257_i_tipo = 1, ed257_c_situacao = 'ATIVA' where ed257_i_codigo = 17775;

select fc_executa_ddl('
insert into censoinstsuperior
values (12899, \'FACULDADE METROPOLITANA DO VALE DO AÇO\'                       , 4, 2, \'3131307\', \'INATIVA\'),
       (10251, \'FACULDADE ORTODOXA\'                                           , 4, 2, \'5104104\', \'ATIVA\'),
       (13728, \'FACULDADE DOS CARAJÁS\'                                        , 4, 2, \'1504208\', \'ATIVA\'),
       (13764, \'FACULDADE DE TECNOLOGIA DE AMPÉRE\'                            , 4, 2, \'4101002\', \'INATIVA\'),
       (14158, \'FACULDADE DE TECNOLOGIA DE NOVO CABRAIS\'                      , 4, 2, \'4313391\', \'ATIVA\'),
       (14718, \'FACULDADE PARANÁ\'                                             , 4, 2, \'4103701\', \'INATIVA\'),
       (15500, \'FACULDADE LUSOCAPIXABA\'                                       , 4, 2, \'3201308\', \'INATIVA\'),
       (15562, \'FACULDADE BATISTA DO CARIRI\'                                  , 4, 2, \'2304202\', \'ATIVA\'),
       (16602, \'FACULDADE DE EDUCAÇÃO ELIÂ\'                                   , 4, 2, \'1507953\', \'INATIVA\'),
       (16782, \'FACULDADE MÁRIO QUINTANA\'                                     , 4, 2, \'4314902\', \'ATIVA\'),
       (16849, \'FACULDADE MODAL\'                                              , 4, 2, \'3106200\', \'INATIVA\'),
       (16918, \'FACULDADE CATÓLICA DE FEIRA DE SANTANA\'                       , 4, 2, \'2910800\', \'INATIVA\'),
       (16948, \'FACULDADE 28 DE AGOSTO DE ENSINO E PESQUISA\'                  , 4, 2, \'3550308\', \'INATIVA\'),
       (17025, \'FACULDADE DE EDUCAÇÃO SUPERIOR DE PARAGOMINAS\'                , 4, 2, \'1505502\', \'INATIVA\'),
       (17091, \'FACULDADE DE NEGÓCIOS DO RECIFE\'                              , 4, 2, \'2611606\', \'INATIVA\'),
       (17115, \'FACULDADE DA UNIÃO DE ENSINO E PESQUISA INTEGRADA\'            , 4, 2, \'2507507\', \'INATIVA\'),
       (17118, \'FACULDADE DO NORTE DE MATO GROSSO\'                            , 4, 2, \'5104104\', \'ATIVA\'),
       (17289, \'FACULDADE DE TEOLOGIA DE CARATINGA URIEL DE ALMEIDA LEITÃO\'   , 4, 2, \'3113404\', \'INATIVA\'),
       (17348, \'FACULDADE DE TECNOLOGIA DOS INCONFIDENTES\'                    , 4, 2, \'3131901\', \'ATIVA\'),
       (17355, \'FACULDADE DE EDUCAÇÃO EM CIÊNCIAS DA SAÚDE\'                   , 4, 2, \'3550308\', \'ATIVA\'),
       (17382, \'FACULDADE IETEC\'                                              , 4, 2, \'3106200\', \'INATIVA\'),
       (17394, \'FACULDADE ALENCARINA DE SOBRAL\'                               , 4, 2, \'2312908\', \'INATIVA\'),
       (17400, \'FACULDADE MENINO DEUS\'                                        , 4, 2, \'4314902\', \'INATIVA\'),
       (17403, \'FACULDADE ARI DE SÁ\'                                          , 4, 2, \'2304400\', \'INATIVA\'),
       (17420, \'FACULDADE CESUMAR DE PONTA GROSSA\'                            , 4, 2, \'4119905\', \'INATIVA\'),
       (17460, \'FACULDADE PROFISSIONAL\'                                       , 4, 2, \'4106902\', \'ATIVA\'),
       (17558, \'FACULDADE SANTO ANDRÉ\'                                        , 4, 2, \'1100304\', \'INATIVA\'),
       (17563, \'FACULDADE COESP\'                                              , 4, 2, \'2507507\', \'INATIVA\'),
       (17565, \'FACULDADE DE CIÊNCIAS HUMANAS,EXATAS E DA SAÚDE DO PIAUÍ\'     , 4, 2, \'2207702\', \'INATIVA\'),
       (17590, \'FACULDADE ISAE BRASIL\'                                        , 4, 2, \'4106902\', \'INATIVA\'),
       (17593, \'FACULDADE DE BOTUCATU\'                                        , 4, 2, \'3507506\', \'INATIVA\'),
       (17598, \'FACULDADE PROF. WLADEMIR DOS SANTOS\'                          , 4, 2, \'3552205\', \'INATIVA\'),
       (17608, \'FACULDADE DE EDUCAÇÃO PAULISTANA\'                             , 4, 2, \'3550308\', \'INATIVA\'),
       (17622, \'FACULDADE TALLES DE MILETO - SEDE DRAGÃO DO MAR\'              , 4, 2, \'2304400\', \'INATIVA\'),
       (17628, \'FACULDADE DO MACIÇO DO BATURITÉ\'                              , 4, 2, \'2302107\', \'ATIVA\'),
       (17662, \'FACULDADE GALILEU\'                                            , 4, 2, \'3507506\', \'ATIVA\'),
       (17670, \'FACULDADE DE QUIXERAMOBIM\'                                    , 4, 2, \'2311405\', \'INATIVA\'),
       (17672, \'INSTITUTO DE DIREITO PÚBLICO DE SÃO PAULO\'                    , 4, 2, \'3550308\', \'INATIVA\'),
       (17674, \'FACULDADE DE EDUCAÇÃO DE SÃO MATEUS\'                          , 4, 2, \'2111508\', \'INATIVA\'),
       (17701, \'FAP-FACULDADE DE PINHEIROS\'                                   , 4, 2, \'3204104\', \'INATIVA\'),
       (17731, \'FACULDADE SESI-SP DE EDUCAÇÃO\'                                , 4, 2, \'3550308\', \'INATIVA\'),
       (17749, \'FACULDADE AMÉRICA\'                                            , 4, 2, \'3201209\', \'INATIVA\'),
       (17763, \'FACULDADE SENAI DE JOÃO PESSOA\'                               , 4, 2, \'2507507\', \'INATIVA\'),
       (17816, \'FACULDADE MAURÍCIO DE NASSAU DE FEIRA DE SANTANA\'             , 4, 2, \'2910800\', \'INATIVA\'),
       (17828, \'FACULDADE DO CENTRO LESTE - CARIACICA\'                        , 4, 2, \'3201308\', \'INATIVA\'),
       (17831, \'FACULDADE DE TECNOLOGIA E NEGÓCIOS DE CATALÃO\'                , 4, 2, \'5205109\', \'INATIVA\'),
       (17850, \'FACULDADE TECNOLÓGICA SANTANNA\'                               , 4, 2, \'3556701\', \'ATIVA\'),
       (17854, \'FACULDADE CAPITAL FEDERAL\'                                    , 4, 2, \'3552809\', \'ATIVA\'),
       (18010, \'FACULDADE ESTÁCIO DE CUIABÁ\'                                  , 4, 2, \'5103403\', \'INATIVA\'),
       (18019, \'FACULDADE DO EDUCADOR\'                                        , 4, 2, \'3550308\', \'INATIVA\'),
       (18023, \'FACULDADE MAURÍCIO DE NASSAU DE PETROLINA\'                    , 4, 2, \'2611101\', \'INATIVA\'),
       (18067, \'CISNE - FACULDADE TECNOLÓGICA DE QUIXADÁ\'                     , 4, 2, \'2311306\', \'INATIVA\'),
       (18075, \'FACULDADE MAURÍCIO DE NASSAU DE JABOATÃO DOS GUARARAPES\'      , 4, 2, \'2607901\', \'INATIVA\'),
       (18114, \'FACULDADE FASIPE MATO GROSSO\'                                 , 4, 2, \'5103403\', \'INATIVA\'),
       (18133, \'FACULDADE UNIDA DE CAMPINAS GOIÂNIA - FACUNICAMPS GOIÂNIA\'    , 4, 2, \'5208707\', \'INATIVA\'),
       (18165, \'FUNDAÇÃO UNIVERSIDADE VIRTUAL DO ESTADO DE SÃO PAULO\'         , 2, 1, \'3550308\', \'INATIVA\'),
       (18257, \'FACULDADE SÄO JOSÉ\'                                           , 4, 2, \'4217204\', \'INATIVA\'),
       (18288, \'FACULDADE LATINO-AMERICANA\'                                   , 4, 2, \'3503901\', \'ATIVA\'),
       (19500, \'FACULDADE DE TECNOLOGIA DE SÃO CARLOS\'                        , 2, 1, \'3548906\', \'ATIVA\'),
       (19501, \'FACULDADE DE TECNOLOGIA SEBRAE\'                               , 2, 1, \'3550308\', \'ATIVA\'),
       (19512, \'INSTITUTO MASTER DE ENSINO PRESIDENTE ANTÔNIO CARLOS\'         , 4, 2, \'3103504\', \'ATIVA\'),
       (19578, \'FACULDADE DE TECNOLOGIA DE COTIA\'                             , 2, 1, \'3513009\', \'ATIVA\'),
       (19588, \'FACULDADE DE EDUCAÇÃO TECNOLÓGICA DO ESTADO DO RIO DE JANEIRO\', 2, 1, \'3301702\', \'ATIVA\'),
       (19739, \'FACULDADE DE TECNOLOGIA DE CAMPINAS\'                          , 2, 1, \'3509502\', \'ATIVA\'),
       (19862, \'FACULDADE DE TECNOLOGIA DE BEBEDOURO\'                         , 2, 1, \'3506102\', \'ATIVA\'),
       (20478, \'FACULDADE DE TECNOLOGIA DE SANTANA DE PARNAÍBA\'               , 2, 1, \'3547304\', \'ATIVA\'),
       (21095, \'ACADEMIA MILITAR DAS AGULHAS NEGRAS\'                          , 3, 1, \'3304201\', \'ATIVA\'),
       (21206, \'ESCOLA DE EDUCAÇÃO FÍSICA DO EXÉRCITO\'                        , 3, 1, \'3304557\', \'ATIVA\');
');
---------------------------------------------------------------------------------------
------------------------------------ FIM EDUCAÇÃO -------------------------------------
---------------------------------------------------------------------------------------
