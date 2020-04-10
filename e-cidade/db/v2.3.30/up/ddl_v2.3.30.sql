/**
 * Arquivo ddl up
 */

----------------------------------------------------
---- TIME FOLHA DE PAGAMENTO
----------------------------------------------------
---- Tarefa: 96909
----------------------------------------------------

-- Insert de valor para a tabela thtipofolha
INSERT INTO rhtipofolha VALUES(6, 'Suplementar');

----------------------------------------------------
---- Tarefa: Migração Folha Salário
----------------------------------------------------
/**
 * CRia os dados do ponto
 */
create table w_migracao_rhfolhapagamento_salario as
select distinct r14_anousu,
                r14_mesusu,
                r14_instit
  from gerfsal
     left join pontofs  on r14_regist = r10_regist
                        and r14_anousu = r10_anousu
                        and r14_mesusu = r10_mesusu
order by r14_anousu asc,
         r14_mesusu asc;
/**
 * Cria uma folha de pagamento para cada competencia e "semest" da tabela do ponto
 */
insert into rhfolhapagamento
select nextval('rhfolhapagamento_rh141_sequencial_seq'),
       0,
       r14_anousu,
       r14_mesusu,
       r14_anousu,
       r14_mesusu,
       r14_instit,
       1,
       false,
       'Folha Salário da competência: ' || r14_anousu || '/' || r14_mesusu || ' gerada automaticamente.'
  from w_migracao_rhfolhapagamento_salario
  order by r14_anousu asc,
           r14_mesusu asc;

/**
 * Resgata o sequencial da ultima folha de pagamento de cada competencia
 */
create table w_ultimafolhadecadacompetencia_salario as
select 0 as ultimafolha,
       rh141_anousu,
       rh141_mesusu,
       rh141_instit
  from rhfolhapagamento
where rh141_tipofolha = 1
group by rh141_anousu,rh141_mesusu, rh141_instit;

/**
 * Lança os registros do histórico do ponto
 */
insert into rhhistoricoponto
  (rh144_sequencial,rh144_regist,rh144_folhapagamento,rh144_rubrica,rh144_quantidade,rh144_valor)
select nextval('rhhistoricoponto_rh144_sequencial_seq'), * from (
select distinct
       r10_regist,
       rhfolhapagamento.rh141_sequencial,
       r10_rubric,
       r10_quant,
       r10_valor
  from pontofs
  inner join w_ultimafolhadecadacompetencia_salario on w_ultimafolhadecadacompetencia_salario.rh141_anousu = r10_anousu
                                                   and w_ultimafolhadecadacompetencia_salario.rh141_mesusu = r10_mesusu
                                                   and w_ultimafolhadecadacompetencia_salario.rh141_instit = r10_instit
  inner join rhfolhapagamento                       on w_ultimafolhadecadacompetencia_salario.rh141_mesusu = rhfolhapagamento.rh141_mesusu
                                                   and w_ultimafolhadecadacompetencia_salario.rh141_anousu = rhfolhapagamento.rh141_anousu
                                                   and w_ultimafolhadecadacompetencia_salario.rh141_instit = rhfolhapagamento.rh141_instit
                                                   and w_ultimafolhadecadacompetencia_salario.ultimafolha  = 0
                                                   and rhfolhapagamento.rh141_tipofolha                    = 1

order by rh141_sequencial) as x;

/**
 * Lança os registros do histórico do calculo
 */
insert into rhhistoricocalculo
select nextval('rhhistoricocalculo_rh143_sequencial_seq'),
       r14_regist,
       rhfolhapagamento.rh141_sequencial,
       r14_rubric,
       r14_quant,
       r14_valor,
       r14_pd
  from gerfsal
inner join rhfolhapagamento                 on  r14_anousu      = rh141_anousu
                                           and  r14_mesusu      = rh141_mesusu
                                           and  r14_instit      = rh141_instit
                                           and  rh141_tipofolha = 1
order by rh141_sequencial;

/**
 * TRIBUTÁRIO
 */

ALTER TABLE fiscalprocrec ADD y45_percentual  bool default 'f';

-- autolevanta
CREATE SEQUENCE autolevanta_y117_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE autolevanta(
y117_sequencial   int4 NOT NULL default 0,
y117_auto   int4 NOT NULL default 0,
y117_levanta    int4 default 0,
CONSTRAINT autolevanta_sequ_pk PRIMARY KEY (y117_sequencial));

ALTER TABLE autolevanta
ADD CONSTRAINT autolevanta_levanta_fk FOREIGN KEY (y117_levanta)
REFERENCES levanta;

ALTER TABLE autolevanta
ADD CONSTRAINT autolevanta_auto_fk FOREIGN KEY (y117_auto)
REFERENCES auto;

CREATE UNIQUE INDEX autolevanta_auto_levanta_in ON autolevanta(y117_auto,y117_levanta);
CREATE UNIQUE INDEX autolevanta_sequencial_in ON autolevanta(y117_sequencial);

alter table parfiscal add column y32_templateautoinfracao int4;

ALTER TABLE parfiscal
ADD CONSTRAINT parfiscal_templateautoinfracao_fk FOREIGN KEY (y32_templateautoinfracao)
REFERENCES db_documentotemplate;

--atualizada sequence da setorlocvalor
select setval('iptutabelas_j121_sequencial_seq', (select max(j121_sequencial)+1 from iptutabelas));
insert into iptutabelas values ( nextval('iptutabelas_j121_sequencial_seq'), 3747);

select fc_executa_ddl('
CREATE TABLE if not exists cadastro.setorlocvalor(
j05_sequencial  int4 NOT NULL default 0,
j05_setorloc    int4 NOT NULL default 0,
j05_anousu      int4 NOT NULL default 0,
j05_valor       float8 default 0 )');

/**
 * FIM TRIBUTÁRIO
 */

----------------------------------------------------
---- TIME C {
----------------------------------------------------

----------------------------------------------------
---- Tarefa: 95125
----------------------------------------------------

alter table periodoescola ADD COLUMN ed17_duracao varchar(5);
update periodoescola set ed17_h_fim    = replace(ed17_h_fim, ';', ':');
update periodoescola set ed17_h_inicio = replace(ed17_h_inicio, ';', ':');
update periodoescola set ed17_duracao  = replace(to_char( (ed17_h_fim::time - ed17_h_inicio::time), 'HH24:MI'), '-', '');

CREATE SEQUENCE horarioescola_ed123_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE horarioescola(
ed123_sequencial    int4 NOT NULL default 0,
ed123_turnoreferencia   int4 NOT NULL default 0,
ed123_escola    int8 NOT NULL default 0,
ed123_horainicio    varchar(5) NOT NULL ,
ed123_horafim   varchar(5) ,
CONSTRAINT horarioescola_sequ_pk PRIMARY KEY (ed123_sequencial));

ALTER TABLE horarioescola
ADD CONSTRAINT horarioescola_escola_fk FOREIGN KEY (ed123_escola)
REFERENCES escola;

CREATE UNIQUE INDEX horarioescola_escola_turnoreferencia_in ON horarioescola(ed123_escola,ed123_turnoreferencia);

drop index alunocensotipotransporte_aluno_in;
drop index alunocensotipotransporte_censotipotransporte_in;


update escolagestorcenso set ed325_email = upper(ed325_email);

----------------------------------------------------
--- Tarefa 92193
----------------------------------------------------
alter table historicomps alter COLUMN ed62_percentualfrequencia type float8;
alter table historicompsfora add column ed99_percentualfrequencia float8;

----------------------------------------------------
---- } FIM TIME C
----------------------------------------------------

----------------------------------------------------
---- TIME FINANCEIRO
----------------------------------------------------
---- Tarefa: 97055
----------------------------------------------------

CREATE SEQUENCE processocompralote_pc68_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


CREATE SEQUENCE processocompraloteitem_pc69_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE processocompralote(
pc68_sequencial		int4 NOT NULL default 0,
pc68_nome		varchar(100) NOT NULL ,
pc68_pcproc		int8 default 0,
CONSTRAINT processocompralote_sequ_pk PRIMARY KEY (pc68_sequencial));

CREATE TABLE processocompraloteitem(
pc69_sequencial		int4 NOT NULL default 0,
pc69_processocompralote		int4 NOT NULL ,
pc69_pcprocitem		int8 ,
CONSTRAINT processocompraloteitem_sequ_pk PRIMARY KEY (pc69_sequencial));

ALTER TABLE processocompralote
ADD CONSTRAINT processocompralote_pcproc_fk FOREIGN KEY (pc68_pcproc)
REFERENCES pcproc;

ALTER TABLE processocompraloteitem
ADD CONSTRAINT processocompraloteitem_processocompralote_fk FOREIGN KEY (pc69_processocompralote)
REFERENCES processocompralote;

ALTER TABLE processocompraloteitem
ADD CONSTRAINT processocompraloteitem_pcprocitem_fk FOREIGN KEY (pc69_pcprocitem)
REFERENCES pcprocitem;

ALTER TABLE pcproc
ADD COLUMN pc80_tipoprocesso int4 NOT NULL default 1;

CREATE  INDEX processocompralote_sequencial_in ON processocompralote(pc68_sequencial);
CREATE  INDEX processocompraloteitem_sequencial_in ON processocompraloteitem(pc69_sequencial);

----------------------------------------------------
---- Tarefa: 97148
----------------------------------------------------
drop index materialtipogrupovinculo_materialtipogrupo_in;
alter table materialtipogrupovinculo add column m04_materialestoquegrupo int4;

update materialtipogrupovinculo set m04_materialestoquegrupo = (select m65_sequencial from materialestoquegrupo where m65_db_estruturavalor = m04_db_estruturavalor);

alter table materialtipogrupovinculo
      drop column m04_db_estruturavalor,
      alter column m04_materialestoquegrupo set not null,
      add constraint materialtipogrupovinculo_materialestoquegrupo_fk foreign key (m04_materialestoquegrupo) references materialestoquegrupo;
create unique index materialtipogrupovinculo_materialtipogrupo_in on materialtipogrupovinculo (m04_materialtipogrupo, m04_materialestoquegrupo);


