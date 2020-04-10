
---------------------------------------------------------------------------------------------
---------------------------------- INICIO FINANCEIRO -----------------------------------------
---------------------------------------------------------------------------------------------

alter table liccomissao add column l30_nomearquivo varchar(100) default null;
alter table liccomissao add column l30_arquivo oid default null;

CREATE SEQUENCE db_cadattdinamicosysarquivo_db17_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

create table db_cadattdinamicosysarquivo (
  db17_sequencial int4 not null primary key default nextval('db_cadattdinamicosysarquivo_db17_sequencial_seq'),
  db17_sysarquivo integer not null,
  db17_cadattdinamico integer not null,
  constraint db_cadattdinamicosysarquivo_cadattdinamico_fk foreign key (db17_cadattdinamico) references db_cadattdinamico,
  constraint db_cadattdinamicosysarquivo_sysarquivo_fk foreign key (db17_sysarquivo) references db_sysarquivo
);

create unique index db_cadattdinamicosysarquivo_sysarquivo_un on db_cadattdinamicosysarquivo(db17_sysarquivo);

CREATE SEQUENCE liccomissaocgmcadattdinamicovalorgrupo_l15_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

create table liccomissaocgmcadattdinamicovalorgrupo(
  l15_sequencial int4 not null primary key default nextval('liccomissaocgmcadattdinamicovalorgrupo_l15_sequencial_seq'),
  l15_liccomissaocgm integer not null,
  l15_cadattdinamicovalorgrupo integer not null,
  constraint liccomissaocgmcadattdinamicovalorgrupo_liccomissaocgm_fk foreign key (l15_liccomissaocgm) references liccomissaocgm,
  constraint liccomissaocgmcadattdinamicovalorgrupo_cadattdinamicovalorgrupo_fk foreign key (l15_cadattdinamicovalorgrupo) references db_cadattdinamicovalorgrupo
);

alter table db_cadattdinamicoatributos add column db109_nome character varying(100);
alter table db_cadattdinamicoatributosvalor alter column db110_valor type text;

CREATE SEQUENCE db_cadattdinamicoatributosopcoes_db18_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

create table db_cadattdinamicoatributosopcoes (
  db18_sequencial int4 not null primary key default nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'),
  db18_cadattdinamicoatributos integer not null,
  db18_opcao character varying(50),
  db18_valor character varying(200),
  constraint db_cadattdinamicoatributosopcoes_cadattdinamicoatributos_fk foreign key (db18_cadattdinamicoatributos) references db_cadattdinamicoatributos
);

insert into db_cadattdinamico values (nextval('db_cadattdinamico_db118_sequencial_seq'), 'Atributos dos membros da comissão');
insert into db_cadattdinamicosysarquivo values (nextval('db_cadattdinamicosysarquivo_db17_sequencial_seq'), 1325, currval('db_cadattdinamico_db118_sequencial_seq'));
insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Cargo', '', 1, 'cargo');

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Tipo de Cargo', '', 1, 'tipocargo');

insert into db_cadattdinamicoatributosopcoes values
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A', 'Agente Político'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'C', 'Comissionado'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'E', 'Efetivo'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'O', 'Outros'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'P', 'Empregado Público'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'T', 'Empregado Temporário');

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Número do Ato de Designação', '', 2, 'numeroatodesignacao'),
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Ano do Ato de Designação', '', 2, 'anoatodesignacao'),
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Data de Designação', '', 3, 'datadesignacao');


-- tipo compra tribunal
alter table pctipocompratribunal add column l44_sigla character varying(3);

select fc_executa_ddl('
insert into pctipocompratribunal (l44_sequencial, l44_codigotribunal, l44_descricao, l44_uf) values
  (48, \'09\', \'Concurso\', \'RS\'),
  (49, \'10\', \'RDC\', \'RS\'),
  (50, \'11\', \'Registro de Preço de Outro Orgão\', \'RS\'),
  (51, \'12\', \'Processo de Dispensa por Pequeno Valor\', \'RS\'),
  (52, \'13\', \'Processo de Dispensa (exceto pequeno valor)\', \'RS\'),
  (53, \'14\', \'Chamamento Público\', \'RS\');
');

select fc_executa_ddl('
insert into pctipocompratribunal values
  (54, \'14\', \'Chamamento Público/Credenciamento\', \'RS\', \'CPC\'),
  (55, \'99\', \'Leilão\', \'RS\', \'LEI\'),
  (56, \'99\', \'Manifestação de Interesse\', \'RS\', \'MAI\');
');

update pctipocompratribunal
   set l44_sigla = case l44_codigotribunal
                        when '14' then 'CHP'
                        when '05' then 'CNC'
                        when '09' then 'CNS'
                        when '03' then 'CNV'
                        when '01' then 'PRD'
                        when '12' then 'PRD'
                        when '13' then 'PRD'
                        when '07' then 'PRE'
                        when '02' then 'PRI'
                        when '06' then 'PRP'
                        when '10' then 'RDC'
                        when '08' then 'RIN'
                        when '11' then 'RPO'
                        when '04' then 'TMP'
                        else l44_sigla
                   end
 where l44_uf = 'RS';

insert into db_cadattdinamico values (nextval('db_cadattdinamico_db118_sequencial_seq'), 'Atributos da licitação');

insert into db_cadattdinamicosysarquivo values (nextval('db_cadattdinamicosysarquivo_db17_sequencial_seq'), 1260, currval('db_cadattdinamico_db118_sequencial_seq'));

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Tipo de Objeto', '', 1, 'tipoobjeto');

insert into db_cadattdinamicoatributosopcoes values
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'ALB', 'Alienação de Bens'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'COM', 'Compras'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'CON', 'Concessão'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'CSE', 'Compras e Outros Serviços'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'LOC', 'Locações'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'NSA', 'Não se Aplica'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'OSE', 'Obras e Serviçoes de Engenharia'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'OUS', 'Outros Serviços'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'PER', 'Permissão');

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Tipo de Licitação', '', 1, 'tipolicitacao');

insert into db_cadattdinamicoatributosopcoes values
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'MCA', 'Melhor Conteúdo Artístico'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'MDE', 'Maior Desconto'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'MLO', 'Maior Lance ou Oferta'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'MOO', 'Maior Oferta de Outorga'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'MOP', 'Maior Oferta de Preço'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'MOQ', 'Maior Oferta de Outorga após Qualificação das Propostas Técnicas'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'MOT', 'Maior Oferta de Outorga e Melhor Técnica'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'MPP', 'Melhor Proposta Técnica com Preço fixado no Edital'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'MPR', 'Menor Preço'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'MRE', 'Maior Retorno Econômico'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'MTC', 'Melhor Técnica'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'MTO', 'Menor Valor da Tarifa e Maior Oferta de Outorga'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'MTT', 'Menor Valor da Tarifa e Melhor Técnica'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'MVT', 'Menor Valor da Tarifa'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'NSA', 'Não se aplica'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'TPR', 'Técnica e Preço');

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Característica do Objeto', '', 1, 'caracteristicaobjeto');

insert into db_cadattdinamicoatributosopcoes values
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'IT', 'Itens'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'IU', 'Item Único'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'LT', 'Lotes'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'LU', 'Lote Único');

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Regime de Execução', '', 1, 'regimeexecucao');

insert into db_cadattdinamicoatributosopcoes values
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'C', 'Contratação Integrada'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'G', 'Empreitada por Preço Global'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'I', 'Empreitada Integral'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'T', 'Tarefa'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'U', 'Empreitada por Preço Unitário');

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Permite Subcontratação', '', 5, 'permitesubcontratacao');

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Tipo de Beneficio à Microempresa e Empresa de Pequeno Porte', '', 1, 'tipobeneficiomicroepp');

insert into db_cadattdinamicoatributosopcoes values
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'L', 'Licitação exclusiva'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'N', 'Não se aplica'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'T', 'Tratamento diferenciado/simplificado');

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Tipo de Fornecimento', '', 1, 'tipofornecimento');

insert into db_cadattdinamicoatributosopcoes values
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'I', 'Integral'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'P', 'Parcelado');

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Percentual de Taxa de Risco', '', 4, 'pctaxarisco');

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Tipo de Execução', '', 1, 'tipoexecucao');

insert into db_cadattdinamicoatributosopcoes values
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'E', 'Eletrônica'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'P', 'Presencial');

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Tipo de Disputa', '', 1, 'tipodisputa');

insert into db_cadattdinamicoatributosopcoes values
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A', 'Aberto'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'C', 'Combinado'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'F', 'Fechado');

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Pré-Qualificação', '', 1, 'prequalificacao');

insert into db_cadattdinamicoatributosopcoes values
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'E', 'Específica'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'G', 'Geral'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'N', 'Não Realizada');

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Inversão de fases', '', 5, 'inversaofases');

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Fundamentação', '', 1, 'codigofundamentacao');

insert into db_cadattdinamicoatributosopcoes values
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A24IV', 'Art. 24, inc. IV, da Lei no 8.666/93'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A24V', 'Art. 24, inc. V, da Lei no 8.666/93'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A24VII', 'Art. 24, inc. VII, da Lei no 8.666/93'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A24VIII', 'Art. 24, inc. VIII, da Lei no 8.666/93'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A24X', 'Art. 24, inc. X, da Lei no 8.666/93'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A24XI', 'Art. 24, inc. XI, da Lei no 8.666/93'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A24XII', 'Art. 24, inc. XII, da Lei no 8.666/93'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A24XIII', 'Art. 24, inc. XIII, da Lei no 8.666/93'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A24XVI', 'Art. 24, inc. XVI, da Lei no 8.666/93'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A24XX', 'Art. 24, inc. XX, da Lei no 8.666/93'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A24XXII', 'Art. 24, inc. XXII, da Lei no 8.666/93'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A25CAPT', 'Art. 25, "caput", da Lei no 8.666/93'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A25I', 'Art. 25, "inc. I", da Lei no 8.666/93'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A25II', 'Art. 25, "inc. II", da Lei no 8.666/93'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'A25III', 'Art. 25, "inc. III", da Lei no 8.666/93'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'OUTD', 'Outra(Processo de Dispensa)'),
  (nextval('db_cadattdinamicoatributosopcoes_db18_sequencial_seq'), currval('db_cadattdinamicoatributos_db109_sequencial_seq'), 'OUTI', 'Outra(Processo de Inexigibilidade)');

insert into db_cadattdinamicoatributos values
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Número do Artigo', '', 2, 'numeroartigo'),
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Inciso', '', 1, 'inciso'),
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Lei', '', 1, 'lei'),
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Data de Início de Inscrição', '', 3, 'datainicioinscricaocredenciamento'),
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Data de Fim de Inscrição', '', 3, 'datafiminscricaocredenciamento'),
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Data de Início da Vigência', '', 3, 'datainiciovigenciacredenciamento'),
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Data de Fim da Vigência', '', 3, 'datafimvigenciacredenciamento'),
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Recebe Inscrição no Período de Vigência', '', 5, 'recebeinscricaoperiodovigencia'),
  (nextval('db_cadattdinamicoatributos_db109_sequencial_seq'), currval('db_cadattdinamico_db118_sequencial_seq'), null, 'Permite a Participação de Consórcio', '', 5, 'permiteconsorcio');

CREATE SEQUENCE liclicitacadattdinamicovalorgrupo_l16_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

create table liclicitacadattdinamicovalorgrupo(
  l16_sequencial int4 primary key default nextval('liclicitacadattdinamicovalorgrupo_l16_sequencial_seq'),
  l16_cadattdinamicovalorgrupo integer not null,
  l16_liclicita integer not null,
  constraint liclicitacadattdinamicovalorgrupo_cadattdinamicovalorgrupo_fk foreign key (l16_cadattdinamicovalorgrupo) references db_cadattdinamicovalorgrupo,
  constraint liclicitacadattdinamicovalorgrupo_liclicita_fk foreign key (l16_liclicita) references liclicita
);

-- Estrutura Tabela Habilitação de Fornecedores
CREATE SEQUENCE pcorcamfornelichabilitacao_l17_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE pcorcamfornelichabilitacao(
  l17_sequencial    int4 NOT NULL  default nextval('pcorcamfornelichabilitacao_l17_sequencial_seq'),
  l17_pcorcamfornelic    int4 NOT NULL ,
  l17_situacao    int4 ,
CONSTRAINT pcorcamfornelichabilitacao_sequ_pk PRIMARY KEY (l17_sequencial));

ALTER TABLE pcorcamfornelichabilitacao
ADD CONSTRAINT pcorcamfornelichabilitacao_pcorcamfornelic_fk FOREIGN KEY (l17_pcorcamfornelic)
REFERENCES pcorcamfornelic;

-- Campo Tipo de Condição - Tabela de Fornecedores da Liquidação
alter table pcorcamfornelic add column pc31_tipocondicao integer default null;


CREATE SEQUENCE liclicitatipoevento_l45_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE liclicitatipoevento(
l45_sequencial  int4 NOT NULL default nextval('liclicitatipoevento_l45_sequencial_seq'),
l45_descricao   varchar(200) ,
CONSTRAINT liclicitatipoevento_sequ_pk PRIMARY KEY (l45_sequencial));
CREATE  INDEX liclicitatipoevento_sequencial_in ON liclicitatipoevento(l45_sequencial);

insert into liclicitatipoevento
     values (1, upper('Alteração do edital')),
            (2, upper('Anulação por determinação judicial')),
            (3, upper('Anulação de ofício')),
            (4, upper('Encerramento por falta de propostas classificadas')),
            (5, upper('Encerramento por falta de licitantes habilitados')),
            (6, upper('Encerramento por falta de interessados')),
            (7, upper('Encerramento')),
            (8, upper('Esclarecimento')),
            (9, upper('Impugnação do edital')),
            (10, upper('Publicação')),
            (11, upper('Publicação do edital')),
            (12, upper('Recurso de credenciamento/lances')),
            (13, upper('Republicação do edital')),
            (14, upper('Reinício')),
            (15, upper('Revogação de ofício')),
            (16, upper('Recurso da habilitação')),
            (17, upper('Recurso de habilitação/proposta')),
            (18, upper('Recurso da proposta/projeto')),
            (19, upper('Recurso da proposta')),
            (20, upper('Suspensão por determinação judicial')),
            (21, upper('Suspensão por medida cautelar')),
            (22, upper('Suspensão de ofício')),
            (23, upper('Não informado'));
select setval('liclicitatipoevento_l45_sequencial_seq', 23);


CREATE SEQUENCE liclicitaevento_l46_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE liclicitaevento(
l46_sequencial     int4 NOT NULL default nextval('liclicitaevento_l46_sequencial_seq'),
l46_liclicita             int4 NOT NULL default 0,
l46_fase                  int4 NOT NULL default 0,
l46_liclicitatipoevento   int4 NOT NULL default 0,
l46_dataevento            date default null,
l46_datajulgamento        date  default null,
l46_cgm             int4  default null,
l46_tipopublicacao  int4  default null,
l46_descricaopublicacao text  ,
l46_tiporesultado  int4 default 0,
CONSTRAINT liclicitaevento_sequencial_pk PRIMARY KEY (l46_sequencial));

ALTER TABLE liclicitaevento
ADD CONSTRAINT liclicitaevento_liclicita_fk FOREIGN KEY (l46_liclicita)
REFERENCES liclicita;

ALTER TABLE liclicitaevento
ADD CONSTRAINT liclicitaevento_cgm_fk FOREIGN KEY (l46_cgm)
REFERENCES cgm;

ALTER TABLE liclicitaevento
ADD CONSTRAINT liclicitaevento_liclicitatipoevento_fk FOREIGN KEY (l46_liclicitatipoevento)
REFERENCES liclicitatipoevento;

CREATE  INDEX liclicitaevento_liclicita_in ON liclicitaevento(l46_liclicita);

insert into liclicitaevento select nextval('liclicitaevento_l46_sequencial_seq'), l20_codigo, 1, 7, '2016-01-01', null, null, null, '', 1 from liclicita;


CREATE SEQUENCE liclicitaeventodocumento_l47_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE liclicitaeventodocumento(
l47_sequencial       int4 NOT NULL default nextval('liclicitaeventodocumento_l47_sequencial_seq'),
l47_liclicitaevento  int4 NOT NULL default 0,
l47_nomearquivo      varchar(200) NOT NULL ,
l47_arquivo          oid NOT NULL ,
l47_tipodocumento    varchar(3) NOT NULL,
CONSTRAINT liclicitaeventodocumento_sequ_pk PRIMARY KEY (l47_sequencial));

ALTER TABLE liclicitaeventodocumento ADD CONSTRAINT liclicitaeventodocumento_liclicitaevento_fk FOREIGN KEY (l47_liclicitaevento) REFERENCES liclicitaevento;
CREATE  INDEX liclicitaeventodocumento_liclicitaevento_in ON liclicitaeventodocumento(l47_liclicitaevento);

create sequence liclicitaencerramentolicitacon_l18_sequencial_seq
increment 1
minvalue 1
maxvalue 9223372036854775807
start 1
cache 1;

create table liclicitaencerramentolicitacon(
l18_sequencial    int4 not null  default nextval('liclicitaencerramentolicitacon_l18_sequencial_seq'),
l18_liclicita   int4 not null ,
l18_data    date ,
constraint liclicitaencerramentolicitacon_sequ_pk primary key (l18_sequencial));

alter table liclicitaencerramentolicitacon
add constraint liclicitaencerramentolicitacon_liclicita_fk foreign key (l18_liclicita)
references liclicita;

create  index liclicitaencerramentolicitacon_sequencial_in on liclicitaencerramentolicitacon(l18_sequencial);

---------------------------------------------------------------------------------------------
---------------------------------- FIM FINANCEIRO -----------------------------------------
---------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------
---------------------------------- INICIO CONFIGURACAO --------------------------------------
---------------------------------------------------------------------------------------------

select fc_executa_ddl('DROP INDEX IF EXISTS '||oid::regclass::text||';')
  from pg_class
 where relkind = 'i'
   and relname ~ '^db_logsacessa_'
   and (relname ~ 'data_in$' or relname ~ 'instit_in$');

select fc_executa_ddl('CREATE INDEX '||relname::text||'_instit_data_in ON '||oid::regclass::text||' USING btree (instit, data);')
  from pg_class
 where relkind = 'r'
   and (relname ~ '^db_logsacessa_[0-9]' or relname = 'db_logsacessa')
 order by relname desc;

---------------------------------------------------------------------------------------------
---------------------------------- FIM CONFIGURACAO -----------------------------------------
---------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------
---------------------------------- INICIO FOLHA ---------------------------------------------
---------------------------------------------------------------------------------------------

CREATE SEQUENCE cargorhrubricas_rh176_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;


CREATE SEQUENCE funcaorhrubricas_rh177_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE cargorhrubricas(
  rh176_sequencial		int4 NOT NULL  default nextval('cargorhrubricas_rh176_sequencial_seq'),
  rh176_cargo		int4 NOT NULL ,
  rh176_rubrica		char(4) NOT NULL ,
  rh176_instit		int4 ,
  rh176_quantidade		float8 NOT NULL default 0,
  rh176_valor		float8 default 0,
  CONSTRAINT cargorhrubricas_sequ_pk PRIMARY KEY (rh176_sequencial)
);


CREATE TABLE funcaorhrubricas(
  rh177_sequencial		int4 NOT NULL  default nextval('funcaorhrubricas_rh177_sequencial_seq'),
  rh177_funcao		int4 NOT NULL ,
  rh177_rubrica		char(4) NOT NULL ,
  rh177_instit		int4 ,
  rh177_quantidade		float8 NOT NULL default 0,
  rh177_valor		float8 default 0,
  CONSTRAINT funcaorhrubricas_sequ_pk PRIMARY KEY (rh177_sequencial)
);

ALTER TABLE cargorhrubricas
ADD CONSTRAINT cargorhrubricas_instit_fk FOREIGN KEY (rh176_instit)
REFERENCES db_config;

ALTER TABLE cargorhrubricas
ADD CONSTRAINT cargorhrubricas_rubrica_instit_fk FOREIGN KEY (rh176_rubrica,rh176_instit)
REFERENCES rhrubricas;

ALTER TABLE cargorhrubricas
ADD CONSTRAINT cargorhrubricas_cargo_instit_fk FOREIGN KEY (rh176_cargo,rh176_instit)
REFERENCES rhcargo;

ALTER TABLE funcaorhrubricas
ADD CONSTRAINT funcaorhrubricas_instit_fk FOREIGN KEY (rh177_instit)
REFERENCES db_config;

ALTER TABLE funcaorhrubricas
ADD CONSTRAINT funcaorhrubricas_rubrica_instit_fk FOREIGN KEY (rh177_rubrica,rh177_instit)
REFERENCES rhrubricas;

ALTER TABLE funcaorhrubricas
ADD CONSTRAINT funcaorhrubricas_funcao_instit_fk FOREIGN KEY (rh177_funcao,rh177_instit)
REFERENCES rhfuncao;

CREATE  INDEX cargorhrubricas_instit_in ON cargorhrubricas(rh176_instit);
CREATE  INDEX cargorhrubricas_cargo_instit_in ON cargorhrubricas(rh176_cargo,rh176_instit);
CREATE  INDEX cargorhrubricas_rubrica_instit_in ON cargorhrubricas(rh176_rubrica,rh176_instit);

CREATE  INDEX funcaorhrubricas_instit_in ON funcaorhrubricas(rh177_instit);
CREATE  INDEX funcaorhrubricas_rubrica_instit_in ON funcaorhrubricas(rh177_rubrica,rh177_instit);
CREATE  INDEX funcaorhrubricas_funcao_instit_in ON funcaorhrubricas(rh177_funcao,rh177_instit);

---------------------------------------------------------------------------------------------
---------------------------------- FIM FOLHA ------------------------------------------------
---------------------------------------------------------------------------------------------

