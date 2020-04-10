----------------------------------------------------------------------------------------------
----------------------------------------- TIME FOLHA -----------------------------------------
----------------------------------------------------------------------------------------------

CREATE SEQUENCE agendaassentamento_h82_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE agendaassentamento (
  h82_sequencial       int4 not null default nextval('agendaassentamento_h82_sequencial_seq'),
  h82_tipoassentamento int4 not null,
  h82_formulainicio    int4 not null,
  h82_formulacondicao  int4 not null,
  h82_selecao          int4 not null,
  h82_instit           int4 not null,
  CONSTRAINT agendaassentamento_seq_pk PRIMARY KEY (h82_sequencial)
);

ALTER TABLE agendaassentamento
  ADD CONSTRAINT agendaassentamento_tipoasse_fk FOREIGN KEY (h82_tipoassentamento)
  REFERENCES tipoasse;

ALTER TABLE agendaassentamento
  ADD CONSTRAINT agendaassentamento_formulainicio_fk FOREIGN KEY (h82_formulainicio)
  REFERENCES db_formulas;

ALTER TABLE agendaassentamento
  ADD CONSTRAINT agendaassentamento_formulacondicao_fk FOREIGN KEY (h82_formulacondicao)
  REFERENCES db_formulas;

ALTER TABLE agendaassentamento
  ADD CONSTRAINT agendaassentamento_selecao_fk FOREIGN KEY (h82_selecao, h82_instit)
  REFERENCES selecao;

CREATE UNIQUE INDEX agendaassentamento_un_in on agendaassentamento (h82_tipoassentamento, h82_formulainicio, h82_formulacondicao, h82_selecao, h82_instit);

--Adiciona coluna na tabela de configuração financeira de tipos de assentamentos
ALTER TABLE tipoassefinanceiro ADD column rh165_datainicio date default null;

----------------------------------------------------------------------------------------------
--------------------------------------- FIM TIME FOLHA ---------------------------------------
----------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-------------------------------- INICIO TIME EDUCAÇÃO / SAÚDE -------------------------------
---------------------------------------------------------------------------------------------

CREATE SEQUENCE integracaohorus_fa59_codigo_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE medicamentos_fa58_codigo_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE integracaohorus(
fa59_codigo int4 NOT NULL default 0,
fa59_usuario  int4 NOT NULL default 0,
fa59_data date NOT NULL default null,
fa59_mesreferente int4 NOT NULL default 0,
fa59_anoreferente int4 NOT NULL default 0,
fa59_tipoarquivo  int4 NOT NULL default 0,
fa59_protocolo  text ,
CONSTRAINT integracaohorus_codi_pk PRIMARY KEY (fa59_codigo));

CREATE TABLE medicamentos(
fa58_codigo int4 NOT NULL default 0,
fa58_catmat varchar(20) NOT NULL ,
fa58_descricao  text NOT NULL ,
fa58_concentracao varchar(40)  ,
fa58_formafarmaceutica  varchar(40)  ,
fa58_volume varchar(40)  ,
fa58_unidadefornecimento  varchar(40) ,
CONSTRAINT medicamentos_codi_pk PRIMARY KEY (fa58_codigo));

alter table far_matersaude add column fa01_medicamentos int4 default null;
alter table far_matersaude add constraint far_matersaude_medicamentos_fk foreign key (fa01_medicamentos) references medicamentos;
alter table integracaohorus add constraint integracaohorus_usuario_fk foreign key (fa59_usuario) references db_usuarios;

 insert into medicamentos (fa58_codigo, fa58_catmat, fa58_descricao, fa58_concentracao, fa58_formafarmaceutica, fa58_volume, fa58_unidadefornecimento)
      values (1, 'BR0278283', 'ACETAZOLAMIDA', '250 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (2, 'BR0268375-1', 'ACICLOVIR', '5%', 'CREME', '5 G', 'BISNAGA') ,
             (3, 'BR0268375-2', 'ACICLOVIR', '5%', 'CREME', '10 G', 'BISNAGA') ,
             (4, 'BR0268370', 'ACICLOVIR', '200 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (5, 'BR0268374', 'ACICLOVIR', '250 MG', 'PÓ PARA SOLUÇÃO INJETÁVEL', null, 'FRASCO-AMPOLA') ,
             (6, 'BR0267501', 'ÁCIDO ACETILSALICÍLICO', '500 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (7, 'BR0267502', 'ÁCIDO ACETILSALICÍLICO', '100 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (8, 'BR0278489', 'ÁCIDO FÓLICO', '0,2 MG/ML', 'SOLUÇÃO ORAL', '30 ML', 'FRASCO') ,
             (9, 'BR0267503', 'ÁCIDO FÓLICO', '5 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (10, 'BR0268292', 'ÁCIDO FOLÍNICO (FOLINATO DE CÁLCIO)', '15 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (11, 'BR0395558', 'ÁCIDO SALICÍLICO', '5%', 'POMADA', null, 'BISNAGA') ,
             (12, 'BR0267504-2', 'ÁCIDO VALPRÓICO (VALPROATO DE SÓDIO)', '250 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (13, 'BR0267504-1', 'ÁCIDO VALPRÓICO (VALPROATO DE SÓDIO)', '250 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (14, 'BR0308732', 'ÁCIDO VALPRÓICO (VALPROATO DE SÓDIO)', '50 MG/ML', 'XAROPE', '100 ML', 'FRASCO') ,
             (15, 'BR0267505', 'ÁCIDO VALPRÓICO (VALPROATO DE SÓDIO)', '500 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (16, 'BR0276839-1', 'ÁGUA DESTILADA', null, 'SOLUÇÃO INJETÁVEL', '5 ML', 'AMPOLA') ,
             (17, 'BR0276839-8', 'ÁGUA DESTILADA', null, 'SOLUÇÃO INJETÁVEL', '100 ML', 'FRASCO') ,
             (18, 'BR0276839-3', 'ÁGUA DESTILADA', null, 'SOLUÇÃO INJETÁVEL', '500 ML', 'FRASCO') ,
             (19, 'BR0276839-4', 'ÁGUA DESTILADA', null, 'SOLUÇÃO INJETÁVEL', '10 ML', 'FRASCO') ,
             (20, 'BR0267507-2', 'ALBENDAZOL', '40 MG/ML', 'SUSPENSÃO ORAL', '20 ML', 'FRASCO') ,
             (21, 'BR0267507-1', 'ALBENDAZOL', '40 MG/ML', 'SUSPENSÃO ORAL', '10 ML', 'FRASCO') ,
             (22, 'BR0267506', 'ALBENDAZOL', '400 MG', 'COMPRIMIDO MASTIGÁVEL', null, 'COMPRIMIDO') ,
             (23, 'BR0395837', 'ALCATRÃO MINERAL', '1%', 'POMADA', null, 'BISNAGA') ,
             (24, 'BR0269943-4', 'ÁLCOOL ETÍLICO', '70%', 'GEL', '5000 ML', 'FRASCO') ,
             (25, 'BR0269943-3', 'ÁLCOOL ETÍLICO', '70%', 'GEL', '1000 ML', 'FRASCO') ,
             (26, 'BR0269943-1', 'ÁLCOOL ETÍLICO', '70%', 'GEL', '500 ML', 'FRASCO') ,
             (27, 'BR0269941', 'ÁLCOOL ETÍLICO', '70%', 'SOLUÇÃO', '1 L', 'FRASCO') ,
             (28, 'BR0269943-2', 'ÁLCOOL ETÍLICO', '70%', 'GEL', '800 ML', 'FRASCO') ,
             (29, 'BR0308721', 'ALENDRONATO DE SÓDIO', '10 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (30, 'BR0269462', 'ALENDRONATO DE SÓDIO', '70 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (31, 'BR0267508', 'ALOPURINOL', '100 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (32, 'BR0267509', 'ALOPURINOL', '300 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (33, 'BR0271710', 'AMIODARONA, CLORIDRATO', '50 MG/ML', 'SOLUÇÃO INJETÁVEL', '3 ML', 'AMPOLA') ,
             (34, 'BR0267510', 'AMIODARONA, CLORIDRATO', '200 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (35, 'BR0276333', 'AMITRIPTILINA, CLORIDRATO', '75 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (36, 'BR0267512', 'AMITRIPTILINA, CLORIDRATO', '25 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (37, 'BR0271111-3', 'AMOXICILINA', '50 MG/ML', 'PÓ PARA SUSPENSÃO ORAL', '150 ML', 'FRASCO') ,
             (38, 'BR0271111-1', 'AMOXICILINA', '50 MG/ML', 'PÓ PARA SUSPENSÃO ORAL', '60 ML', 'FRASCO') ,
             (39, 'BR0271089-2', 'AMOXICILINA', '500 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (40, 'BR0271089-1', 'AMOXICILINA', '500 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (41, 'BR0271111-2', 'AMOXICILINA', '50 MG/ML', 'PÓ PARA SUSPENSÃO ORAL', '80 ML', 'FRASCO') ,
             (42, 'BR0271217', 'AMOXICILINA + CLAVULANATO DE POTÁSSIO', '500 + 125 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (43, 'BR0281135-1', 'AMOXICILINA + CLAVULANATO DE POTÁSSIO', '50 + 12,5 MG/ML', 'SUSPENSÃO ORAL', '75 ML', 'FRASCO') ,
             (44, 'BR0281135-2', 'AMOXICILINA + CLAVULANATO DE POTÁSSIO', '50 + 12,5 MG/ML', 'SUSPENSÃO ORAL', '100 ML', 'FRASCO') ,
             (45, 'BR0268896', 'ANLODIPINO, BESILATO', '10 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (46, 'BR0272434', 'ANLODIPINO, BESILATO', '5 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (47, 'BR0267517', 'ATENOLOL', '50 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (48, 'BR0267518', 'ATENOLOL', '100 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (49, 'BR0268214', 'ATROPINA, SULFATO', '0,25 MG/ML', 'SOLUÇÃO INJETÁVEL', '1 ML', 'AMPOLA') ,
             (50, 'BR0267140', 'AZITROMICINA', '500 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (51, 'BR0314517-3', 'AZITROMICINA', '40 MG/ML', 'PÓ PARA SUSPENSÃO ORAL', '1200 MG', 'FRASCO') ,
             (52, 'BR0314517-2', 'AZITROMICINA', '40 MG/ML', 'PÓ PARA SUSPENSÃO ORAL', '900 MG', 'FRASCO') ,
             (53, 'BR0314517-1', 'AZITROMICINA', '40 MG/ML', 'PÓ PARA SUSPENSÃO ORAL', '600 MG', 'FRASCO') ,
             (54, 'BR0314517-4', 'AZITROMICINA', '40 MG/ML', 'PÓ PARA SUSPENSÃO ORAL', '1500 MG', 'FRASCO') ,
             (55, 'BR0267586', 'BECLOMETASONA, DIPROPIONATO', '200 MCG', 'CÁPSULA', '60 DOSES', 'CAPSULA') ,
             (56, 'BR0267581', 'BECLOMETASONA, DIPROPIONATO', '250 MCG/DOSE', 'AEROSSOL ORAL', '200 DOSES', 'FRASCO') ,
             (57, 'BR0267587', 'BECLOMETASONA, DIPROPIONATO', '200 MCG/DOSE', 'PÓ PARA INALAÇÃO ORAL', '100 DOSES', 'FRASCO') ,
             (58, 'BR0346586-2', 'BECLOMETASONA, DIPROPIONATO', '50 MCG/DOSE', 'AEROSSOL ORAL', '200 DOSES', 'FRASCO') ,
             (59, 'BR0346586-1', 'BECLOMETASONA, DIPROPIONATO', '50 MCG/DOSE', 'AEROSSOL ORAL', '130 DOSES', 'FRASCO') ,
             (60, 'BR0267582-1', 'BECLOMETASONA, DIPROPIONATO', '50 MCG/DOSE', 'AEROSSOL NASAL', '200 DOSES', 'FRASCO') ,
             (61, 'BR0267582-3', 'BECLOMETASONA, DIPROPIONATO', '50 MCG/DOSE', 'AEROSSOL NASAL', '130 DOSES', 'FRASCO') ,
             (62, 'BR0267590', 'BECLOMETASONA, DIPROPIONATO', '250 MCG/DOSE', 'AEROSSOL NASAL', '200 DOSES', 'FRASCO') ,
             (63, 'BR0270613', 'BENZILPENICILINA BENZATINA', '600.000 UI', 'PÓ PARA SUSPENSÃO INJETÁVEL', null, 'FRASCO-AMPOLA') ,
             (64, 'BR0270612', 'BENZILPENICILINA BENZATINA', '1.200.000 UI', 'PÓ PARA SUSPENSÃO INJETÁVEL', null, 'FRASCO-AMPOLA') ,
             (65, 'BR0270616', 'BENZILPENICILINA POTÁSSICA', '5.000.000 UI', 'PÓ PARA SOLUÇÃO INJETÁVEL', null, 'FRASCO') ,
             (66, 'BR0270614', 'BENZILPENICILINA PROCAÍNA + BENZILPENICILINA POTÁSSICA', '400.000 UI', 'PÓ PARA SUSPENSÃO INJETÁVEL', null, 'FRASCO-AMPOLA') ,
             (67, 'BR0270597', 'BETAMETASONA, ACETATO + BETAMETASONA, FOSFATO DISSÓDICO', '3 + 3 MG/ML', 'SUSPENSÃO INJETÁVEL', '1 ML', 'AMPOLA') ,
             (68, 'BR0270140', 'BIPERIDENO, CLORIDRATO', '2 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (69, 'BR0270141', 'BIPERIDENO, CLORIDRATO', '4 MG', 'COMPRIMIDO DE LIBERAÇÃO CONTROLADA', null, 'COMPRIMIDO') ,
             (70, 'BR0270138', 'BIPERIDENO, LACTATO', '5 MG/ML', 'SOLUÇÃO INJETÁVEL', '1 ML', 'AMPOLA') ,
             (71, 'BR0266706', 'BUDESONIDA', '32 MCG/DOSE', 'SUSPENSÃO NASAL', '120 DOSES', 'FRASCO') ,
             (72, 'BR0266707', 'BUDESONIDA', '64 MCG/DOSE', 'SUSPENSÃO NASAL', '120 DOSES', 'FRASCO') ,
             (73, 'BR0266701', 'BUDESONIDA', '50 MCG', 'SUSPENSÃO NASAL', '200 DOSES', 'FRASCO') ,
             (74, 'BR0266701-1', 'BUDESONIDA', '50 MCG', 'SUSPENSÃO NASAL', '120 DOSES', 'FRASCO') ,
             (75, 'BR0266701', 'BUDESONIDA', '50 MCG/DOSE', 'SUSPENSÃO NASAL', '200 DOSES', 'FRASCO') ,
             (76, 'BR0266701-3', 'BUDESONIDA', '50 MCG/DOSE', 'SOLUÇÃO NASAL', '60 DOSES', 'FRASCO') ,
             (77, 'BR0266701-4', 'BUDESONIDA', '50 MCG/DOSE', 'SOLUÇÃO NASAL', '100 DOSES', 'FRASCO') ,
             (78, 'BR0266706-1', 'BUDESONIDA', '32 MCG/DOSE', 'SOLUÇÃO NASAL', '60 DOSES', 'FRASCO') ,
             (79, 'BR0266707-1', 'BUDESONIDA', '64 MCG/DOSE', 'SOLUÇÃO NASAL', '60 DOSES', 'FRASCO') ,
             (80, 'BR0269574', 'BUPIVACAÍNA, CLORIDRATO', '0,50%', 'SOLUÇÃO INJETÁVEL', '20 ML', 'FRASCO-AMPOLA') ,
             (81, 'BR0269574-1', 'BUPIVACAÍNA, CLORIDRATO', '0,50%', 'SOLUÇÃO INJETÁVEL', '4 ML', 'AMPOLA') ,
             (82, 'BR0269573', 'BUPIVACAÍNA, CLORIDRATO', '0,25%', 'SOLUÇÃO INJETÁVEL', '20 ML', 'FRASCO-AMPOLA') ,
             (83, 'BR0268084', 'CABERGOLINA', '0,5 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (84, 'BR0267613', 'CAPTOPRIL', '25 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (85, 'BR0272454-1', 'CARBAMAZEPINA', '20 MG/ML', 'SUSPENSÃO ORAL', '100 ML', 'FRASCO') ,
             (86, 'BR0272454-2', 'CARBAMAZEPINA', '20 MG/ML', 'SUSPENSÃO ORAL', '120 ML', 'FRASCO') ,
             (87, 'BR0267617', 'CARBAMAZEPINA', '400 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (88, 'BR0267618', 'CARBAMAZEPINA', '200 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (89, 'BR0270895-1', 'CARBONATO DE CÁLCIO (CÁLCIO ELEMENTAR)', '500 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (90, 'BR0296876', 'CARBONATO DE CÁLCIO + COLECALCIFEROL', '500 MG + 400 UI', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (91, 'BR0270893', 'CARBONATO DE CÁLCIO + COLECALCIFEROL', '500 MG + 200 UI', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (92, 'BR0267621', 'CARBONATO DE LÍTIO', '300 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (93, 'BR0395721-4', 'CARVÃO VEGETAL ATIVADO', null, 'PÓ', '25 G', 'SACHE') ,
             (94, 'BR0395721-3', 'CARVÃO VEGETAL ATIVADO', null, 'PÓ', '1000 G', 'FRASCO') ,
             (95, 'BR0395721-2', 'CARVÃO VEGETAL ATIVADO', null, 'PÓ', '250 G', 'POTE') ,
             (96, 'BR0395721-1', 'CARVÃO VEGETAL ATIVADO', null, 'PÓ', '50 G', 'ENVELOPE') ,
             (97, 'BR0395721-5', 'CARVÃO VEGETAL ATIVADO', null, 'PÓ', '500 G', 'POTE') ,
             (98, 'BR0267564', 'CARVEDILOL', '12,5 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (99, 'BR0267565', 'CARVEDILOL', '6,25 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (100, 'BR0267566', 'CARVEDILOL', '3,125 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (101, 'BR0267567', 'CARVEDILOL', '25 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (102, 'BR0331555-2', 'CEFALEXINA', '50 MG/ML', 'SUSPENSÃO ORAL', '100 ML', 'FRASCO') ,
             (103, 'BR0331555-1', 'CEFALEXINA', '50 MG/ML', 'SUSPENSÃO ORAL', '60 ML', 'FRASCO') ,
             (104, 'BR0267625-1', 'CEFALEXINA', '500 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (105, 'BR0267625-2', 'CEFALEXINA', '500 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (106, 'BR0268410', 'CEFOTAXIMA', '500 MG', 'PÓ LIOFILIZADO', null, 'FRASCO-AMPOLA') ,
             (107, 'BR0294096', 'CEFTRIAXONA SÓDICA', '250 MG', 'PÓ PARA SOLUÇÃO INJETÁVEL INTRAVENOSO', null, 'FRASCO-AMPOLA') ,
             (108, 'BR0268415', 'CEFTRIAXONA SÓDICA', '1 G', 'PÓ PARA SOLUÇÃO INJETÁVEL INTRAMUSCULA R', null, 'FRASCO-AMPOLA') ,
             (109, 'BR0268414', 'CEFTRIAXONA SÓDICA', '1 G', 'PÓ PARA SOLUÇÃO INJETÁVEL INTRAVENOSO', null, 'FRASCO-AMPOLA') ,
             (110, 'BR0294097', 'CEFTRIAXONA SÓDICA', '250 MG', 'PÓ PARA SOLUÇÃO INJETÁVEL INTRAMUSCULAR', null, 'FRASCO-AMPOLA') ,
             (111, 'BR0271103-1', 'CETOCONAZOL', '2%', 'XAMPU', '100 ML', 'FRASCO') ,
             (112, 'BR0271103-2', 'CETOCONAZOL', '2%', 'XAMPU', '120 ML', 'FRASCO') ,
             (113, 'BR0341882', 'CIANOCOBALAMINA', '500 MCG/ML', 'SOLUÇÃO INJETÁVEL', '2 ML', 'AMPOLA') ,
             (114, 'BR0267632', 'CIPROFLOXACINO, CLORIDRATO', '500 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (115, 'BR0267631', 'CIPROFLOXACINO, CLORIDRATO', '250 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (116, 'BR0269988-2', 'CLARITROMICINA', '50 MG/ML', 'SUSPENSÃO ORAL', '60 ML', 'FRASCO') ,
             (117, 'BR0268439-1', 'CLARITROMICINA', '500 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (118, 'BR0269986-2', 'CLARITROMICINA', '250 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (119, 'BR0268439-2', 'CLARITROMICINA', '500 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (120, 'BR0269988-1', 'CLARITROMICINA', '50 MG/ML', 'SUSPENSÃO ORAL', '100 ML', 'FRASCO') ,
             (121, 'BR0268436', 'CLINDAMICINA, CLORIDRATO', '300 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (122, 'BR0268955', 'CLINDAMICINA, CLORIDRATO', '150 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (123, 'BR0267523', 'CLOMIPRAMINA, CLORIDRATO', '10 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (124, 'BR0267522', 'CLOMIPRAMINA, CLORIDRATO', '25 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (125, 'BR0270120', 'CLONAZEPAM', '2,5 MG/ML', 'SOLUÇÃO ORAL', '20 ML', 'FRASCO') ,
             (126, 'BR0335097-1', 'CLORANFENICOL', '250 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (127, 'BR0335097-2', 'CLORANFENICOL', '250 MG', 'CÁPSULA', null, 'FICHA') ,
             (128, 'BR0335103', 'CLORANFENICOL, PALMITATO', '25 MG/ML', 'SUSPENSÃO ORAL', '60 ML', 'FRASCO') ,
             (129, 'BR0375474-3', 'CLORETO DE SÓDIO', '0,90%', 'SOLUÇÃO NASAL', '50 ML', 'FRASCO') ,
             (130, 'BR0375474-2', 'CLORETO DE SÓDIO', '0,90%', 'SOLUÇÃO NASAL', '30 ML', 'FRASCO') ,
             (131, 'BR0267574', 'CLORETO DE SÓDIO', '20%', 'SOLUÇÃO INJETÁVEL', '10 ML', 'AMPOLA') ,
             (132, 'BR0375474-1', 'CLORETO DE SÓDIO', '0,90%', 'SOLUÇÃO NASAL', '10 ML', 'FRASCO') ,
             (133, 'BR0341174-3', 'CLOREXIDINA, DIGLICONATO 0,12% COLUTÓRIO 1 L', null, null, null, 'FRASCO') ,
             (134, 'BR0341174-1', 'CLOREXIDINA, DIGLICONATO 0,12% COLUTÓRIO 250 ML', null, null, null, 'FRASCO') ,
             (135, 'BR0341174-2', 'CLOREXIDINA, DIGLICONATO 0,12% COLUTÓRIO 500 ML', null, null, null, 'FRASCO') ,
             (136, 'BR0269876-1', 'CLOREXIDINA, DIGLICONATO 2 % SOLUÇÃO DEGERMANTE 100 ML', null, null, null, 'FRASCO') ,
             (137, 'BR0269876-2', 'CLOREXIDINA, DIGLICONATO 2% SOLUÇÃO DEGERMANTE 1 L', null, null, null, 'FRASCO') ,
             (138, 'BR0269877', 'CLOREXIDINA, DIGLICONATO 4 % SOLUÇÃO DEGERMANTE 1 L', null, null, null, 'FRASCO') ,
             (139, 'BR0340207', 'CLORPROMAZINA, CLORIDRATO', '40 MG/ML', 'SOLUÇÃO ORAL', '20 ML', 'FRASCO') ,
             (140, 'BR0267638', 'CLORPROMAZINA, CLORIDRATO', '100 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (141, 'BR0267635', 'CLORPROMAZINA, CLORIDRATO', '25 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (142, 'BR0268069', 'CLORPROMAZINA, CLORIDRATO', '5 MG/ML', 'SOLUÇÃO INJETÁVEL', '5 ML', 'FRASCO-AMPOLA') ,
             (143, 'BR0395618', 'CYNARA SCOLYMUS (ALCACHOFRA)', '300 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (144, 'BR0399066', 'CYNARA SCOLYMUS (ALCACHOFRA)', '500 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (145, 'BR0429325', 'CYNARA SCOLYMUS (ALCACHOFRA)', '250 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (146, 'BR0367515', 'CYNARA SCOLYMUS (ALCACHOFRA)', '200 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (147, 'BR0429303', 'CYNARA SCOLYMUS (ALCACHOFRA)', '1,5 MG/ ML', 'TINTURA', '100 ML', 'FRASCO') ,
             (148, 'BR0267187', 'DEXAMETASONA', '1 MG/ML', 'SOLUÇÃO OFTÁLMICA', '5 ML', 'FRASCO') ,
             (149, 'BR0268243-1', 'DEXAMETASONA', '0,1 MG/ML', 'ELIXIR', '100 ML', 'FRASCO') ,
             (150, 'BR0269388', 'DEXAMETASONA', '4 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (151, 'BR0268243-2', 'DEXAMETASONA', '0,1 MG/ML', 'ELIXIR', '120 ML', 'FRASCO') ,
             (152, 'BR0267643', 'DEXAMETASONA', '0,10%', 'CREME', '10 G', 'BISNAGA') ,
             (153, 'BR0292427', 'DEXAMETASONA, FOSFATO DISSÓDICO', '4 MG/ML', 'SOLUÇÃO INJETÁVEL', '2,5 ML', 'FRASCO-AMPOLA') ,
             (154, 'BR0267646-2', 'DEXCLORFENIRAMINA, MALEATO', '0,4 MG/ML', 'SOLUÇÃO ORAL', '120 ML', 'FRASCO') ,
             (155, 'BR0267645', 'DEXCLORFENIRAMINA, MALEATO', '2 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (156, 'BR0267646-1', 'DEXCLORFENIRAMINA, MALEATO', '0,4 MG/ML', 'SOLUÇÃO ORAL', '100 ML', 'FRASCO') ,
             (157, 'BR0298454-2', 'DEXCLORFENIRAMINA, MALEATO', '0,4 MG/ML', 'XAROPE', '120 ML', 'FRASCO') ,
             (158, 'BR0267646-3', 'DEXCLORFENIRAMINA, MALEATO', '0,4 MG/ML', 'SOLUÇÃO ORAL', '150 ML', 'FRASCO') ,
             (159, 'BR0298454-1', 'DEXCLORFENIRAMINA, MALEATO', '0,4 MG/ML', 'XAROPE', '100 ML', 'FRASCO') ,
             (160, 'BR0287595', 'DIAFRAGMA, SILICONE, 65 MM, USO GINECOLÓGICO, COM ARO ESPIRAL EM METAL TRATADO, EMBALADO INDIVIDUALMENTE', null, null, null, 'UM') ,
             (161, 'BR0287593', 'DIAFRAGMA, SILICONE, 70 MM, USO GINECOLÓGICO, COM ARO ESPIRAL EM METAL TRATADO, EMBALADO INDIVIDUALMENTE', null, null, null, 'UM') ,
             (162, 'BR0287594', 'DIAFRAGMA, SILICONE, 75 MM, USO GINECOLÓGICO, COM ARO ESPIRAL EM METAL TRATADO, EMBALADO INDIVIDUALMENTE', null, null, null, 'UM') ,
             (163, 'BR0287592', 'DIAFRAGMA, SILICONE, 80 MM, USO GINECOLÓGICO, COM ARO ESPIRAL EM METAL TRATADO, EMBALADO INDIVIDUALMENTE', null, null, null, 'UM') ,
             (164, 'BR0267195', 'DIAZEPAM', '5 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (165, 'BR0267197', 'DIAZEPAM', '10 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (166, 'BR0267194', 'DIAZEPAM', '5 MG/ML', 'SOLUÇÃO INJETÁVEL', '2 ML', 'AMPOLA') ,
             (167, 'BR0267647', 'DIGOXINA', '0,25 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (168, 'BR0267648', 'DIGOXINA', '0,05 MG/ML', 'ELIXIR', '60 ML', 'FRASCO') ,
             (169, 'BR0267205-3', 'DIPIRONA SÓDICA', '500 MG/ML', 'SOLUÇÃO ORAL', '20 ML', 'FRASCO') ,
             (170, 'BR0267205-1', 'DIPIRONA SÓDICA', '500 MG/ML', 'SOLUÇÃO ORAL', '10 ML', 'FRASCO') ,
             (171, 'BR0267205-2', 'DIPIRONA SÓDICA', '500 MG/ML', 'SOLUÇÃO ORAL', '15 ML', 'FRASCO') ,
             (172, 'BR0268252', 'DIPIRONA SÓDICA', '500 MG/ML', 'SOLUÇÃO INJETÁVEL', '2 ML', 'AMPOLA') ,
             (173, 'BR0267203', 'DIPIRONA SÓDICA', '500 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (174, 'BR0297746', '"DISPOSITIVO INTRA-UTERINO (DIU), EM ""T"", FLEXÍVEL, POLETILENO, FIO COBRE ENROLADO HASTE,CONE COBRE NOS BRAÇOS ""T"", 2 FIOS POLIETILENO BRANCO 2 A 3CM"', null, null, null, 'UM') ,
             (175, 'BR0268446', 'DOBUTAMINA, CLORIDRATO', '12,5 MG/ML', 'SOLUÇÃO INJETÁVEL', '20 ML', 'AMPOLA') ,
             (176, 'BR0268960', 'DOPAMINA, CLORIDRATO', '5 MG/ML', 'SOLUÇÃO INJETÁVEL', '10 ML', 'AMPOLA') ,
             (177, 'BR0268495', 'DOXAZOSINA, MESILATO', '4 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (178, 'BR0268493', 'DOXAZOSINA, MESILATO', '2 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (179, 'BR0267651', 'ENALAPRIL, MALEATO', '10 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (180, 'BR0267650', 'ENALAPRIL, MALEATO', '5 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (181, 'BR0267652', 'ENALAPRIL, MALEATO', '20 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (182, 'BR0270846', 'ENANTATO DE NORETISTERONA + VALERATO DE ESTRADIO', '50 + 5 MG/ML', 'SOLUÇÃO INJETÁVEL', '1 ML', 'AMPOLA') ,
             (183, 'BR0268255', 'EPINEFRINA', '1 MG/ML', 'SOLUÇÃO INJETÁVEL', '1 ML', 'AMPOLA') ,
             (184, 'BR0269998', 'ERITROMICINA, ESTOLATO', '50 MG/ML', 'SUSPENSÃO ORAL', '60 ML', 'FRASCO') ,
             (185, 'BR0269997-2', 'ERITROMICINA, ESTOLATO', '25 MG/ML', 'SUSPENSÃO ORAL', '60 ML', 'FRASCO') ,
             (186, 'BR0269996', 'ERITROMICINA, ESTOLATO', '500 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (187, 'BR0343494', 'ESPIRAMICINA', '(1,5 MUI) 500 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (188, 'BR0267653', 'ESPIRONOLACTONA', '25 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (189, 'BR0267654', 'ESPIRONOLACTONA', '100 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (190, 'BR0267208', 'ESTRIOL', '1 MG/G', 'CREME VAGINAL', '50 G', 'BISNAGA') ,
             (191, 'BR0356602', 'ESTROGÊNIOS CONJUGADOS', '0,3 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (192, 'BR0271435', 'ESTROGÊNIOS CONJUGADOS', '0,625 MG/G', 'CREME VAGINAL', '25 G', 'BISNAGA') ,
             (193, 'BR0269391', 'FENITOÍNA SÓDICA', '20 MG/ML', 'SUSPENSÃO ORAL', '120 ML', 'FRASCO') ,
             (194, 'BR0267657', 'FENITOÍNA SÓDICA', '100 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (195, 'BR0267107', 'FENITOÍNA SÓDICA', '50 MG/ML', 'SOLUÇÃO INJETÁVEL', '5 ML', 'AMPOLA') ,
             (196, 'BR0300723', 'FENOBARBITAL', '40 MG/ML', 'SOLUÇÃO ORAL', '20 ML', 'FRASCO') ,
             (197, 'BR0300725', 'FENOBARBITAL', '100 MG/ML', 'SOLUÇÃO INJETÁVEL', '2 ML', 'AMPOLA') ,
             (198, 'BR0267660', 'FENOBARBITAL', '100 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (199, 'BR0275963', 'FINASTERIDA', '5 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (200, 'BR0267662', 'FLUCONAZOL', '150 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (201, 'BR0267661', 'FLUCONAZOL', '100 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (202, 'BR0268510', 'FLUMAZENIL', '0,1 MG/ML', 'SOLUÇÃO INJETÁVEL', '5 ML', 'AMPOLA') ,
             (203, 'BR0273009-1', 'FLUOXETINA, CLORIDRATO', '20 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (204, 'BR0273009-2', 'FLUOXETINA, CLORIDRATO', '20 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (205, 'BR0386482', 'FOSFATO DE CÁLCIO TRIBÁSICO + COLECALCIFEROL', '600 MG + 400 UI', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (206, 'BR0267663', 'FUROSEMIDA', '40 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (207, 'BR0267666', 'FUROSEMIDA', '10 MG/ML', 'SOLUÇÃO INJETÁVEL', '2 ML', 'AMPOLA') ,
             (208, 'BR0325424-2', 'GEL LUBRIFICANTE, ÍNTIMO, INCOLOR, INODORO, SOLÚVEL EM ÁGUA, TRANSPARENTE E NÃO GORDUROSO, SACHÊ 10 G', null, null, null, 'UM') ,
             (209, 'BR0325424-1', 'GEL LUBRIFICANTE, ÍNTIMO, INCOLOR, INODORO, SOLÚVEL EM ÁGUA, TRANSPARENTE E NÃO GORDUROSO, SACHÊ 5 G', null, null, null, 'UM') ,
             (210, 'BR0291174', 'GENTAMICINA, SULFATO', '5 MG/G', 'POMADA OFTÁLMICA', '3,5 G', 'BISNAGA') ,
             (211, 'BR0372372', 'GENTAMICINA, SULFATO', '5 MG/ML', 'POMADA OFTÁLMICA', '5 ML', 'FRASCO') ,
             (212, 'BR0267671', 'GLIBENCLAMIDA', '5 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (213, 'BR0268185', 'GLICEROL', null, 'SUPOSITÓRIO INFANTIL', null, 'SUPOSITORIO') ,
             (214, 'BR0269622-3', 'GLICEROL', '120 MG/ML', 'ENEMA', '1 L', 'FRASCO') ,
             (215, 'BR0268186', 'GLICEROL', null, 'SUPOSITÓRIO ADULTO', null, 'UM') ,
             (216, 'BR0269622-1', 'GLICEROL', '120 MG/ML', 'ENEMA', '250 ML', 'FRASCO') ,
             (217, 'BR0269622-2', 'GLICEROL', '120 MG/ML', 'ENEMA', '500 ML', 'FRASCO') ,
             (218, 'BR0273115', 'GLICLAZIDA', '80 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (219, 'BR0273116', 'GLICLAZIDA', '30 MG', 'COMPRIMIDO DE LIBERAÇÃO CONTROLADA', null, 'COMPRIMIDO') ,
             (220, 'BR0417713', 'GLICLAZIDA', '60 MG', 'COMPRIMIDO DE LIBERAÇÃO CONTROLADA', null, 'COMPRIMIDO') ,
             (221, 'BR0267540', 'GLICOSE', '25%', 'SOLUÇÃO INJETÁVEL', '10 ML', 'AMPOLA') ,
             (222, 'BR0267541', 'GLICOSE', '50%', 'SOLUÇÃO INJETÁVEL', '10 ML', 'AMPOLA') ,
             (223, 'BR0267544-1', 'GLICOSE', '10%', 'SOLUÇÃO INJETÁVEL', '100 ML SISTEMA FECHADO', 'UM') ,
             (224, 'BR0267544-2', 'GLICOSE', '10%', 'SOLUÇÃO INJETÁVEL', '250 ML SISTEMA FECHADO', 'UM') ,
             (225, 'BR0267544-3', 'GLICOSE', '10%', 'SOLUÇÃO INJETÁVEL', '500 ML SISTEMA FECHADO', 'UM') ,
             (226, 'BR0267544-4', 'GLICOSE', '10%', 'SOLUÇÃO INJETÁVEL', '1000 ML SISTEMA FECHADO', 'UM') ,
             (227, 'BR0270092', 'GLICOSE', '5%', 'SOLUÇÃO INJETÁVEL', '100 ML SISTEMA FECHADO', 'UM') ,
             (228, 'BR0270092-1', 'GLICOSE', '5%', 'SOLUÇÃO INJETÁVEL', '250 ML SISTEMA FECHADO', 'UM') ,
             (229, 'BR0270092-2', 'GLICOSE', '5%', 'SOLUÇÃO INJETÁVEL', '500 SISTEMA FECHADO', 'UM') ,
             (230, 'BR0270092-3', 'GLICOSE', '5%', 'SOLUÇÃO INJETÁVEL', '1000 ML SISTEMA FECHADO', 'UM') ,
             (231, 'BR0353564', 'GLICOSE', '50%', 'SOLUÇÃO INJETÁVEL', '500 ML SISTEMA FECHADO', 'UM') ,
             (232, 'BR0269882-1', 'GLUTARAL SOLUÇÃO 2% COM PÓ ATIVADOR PARA 14 DIAS 1 L', null, null, null, 'FRASCO') ,
             (233, 'BR0269882-2', 'GLUTARAL SOLUÇÃO 2% COM PÓ ATIVADOR PARA 14 DIAS 5L', null, null, null, 'FRASCO') ,
             (234, 'BR0269883-2', 'GLUTARAL, SOLUÇÃO A 2%, COM PÓ ATIVADOR PARA 28 DIAS, GALÃO 1 L', null, null, null, 'FRASCO') ,
             (235, 'BR0269883-1', 'GLUTARAL, SOLUÇÃO A 2%, COM PÓ ATIVADOR PARA 28 DIAS, GALÃO 5 L', null, null, null, 'UM') ,
             (236, 'BR0395620', 'GLYCINE MAX (ISOFLAVONA DE SOJA)', '150 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (237, 'BR0404690', 'GLYCINE MAX (ISOFLAVONA DE SOJA)', '75 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (238, 'BR0267669', 'HALOPERIDOL', '5 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (239, 'BR0292195-1', 'HALOPERIDOL', '2 MG/ML', 'SOLUÇÃO ORAL', '10 ML', 'FRASCO') ,
             (240, 'BR0292195-2', 'HALOPERIDOL', '2 MG/ML', 'SOLUÇÃO ORAL', '20 ML', 'FRASCO') ,
             (241, 'BR0267670', 'HALOPERIDOL', '1 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (242, 'BR0292196', 'HALOPERIDOL', '5 MG/ML', 'SOLUÇÃO INJETÁVEL', '1 ML', 'AMPOLA') ,
             (243, 'BR0292195-3', 'HALOPERIDOL', '2 MG/ML', 'SOLUÇÃO ORAL', '30 ML', 'FRASCO') ,
             (244, 'BR0292194', 'HALOPERIDOL, DECANOATO', '(70,52 MG) 50 MG/ML', 'SOLUÇÃO INJETÁVEL', '1 ML', 'AMPOLA') ,
             (245, 'BR0399410', 'HARPAGOPHYTUM PROCUBENS (GARRA DO DIABO)', '500 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (246, 'BR0417285', 'HARPAGOPHYTUM PROCUBENS (GARRA DO DIABO)', '200 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (247, 'BR0393339', 'HARPAGOPHYTUM PROCUBENS (GARRA DO DIABO)', '400 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (248, 'BR0268463', 'HEPARINA SÓDICA', '5000/0,25 UI/ML', 'SOLUÇÃO INJETÁVEL', '0,25 ML', 'AMPOLA') ,
             (249, 'BR0268112', 'HIDRALAZINA, CLORIDRATO', '50 MG', 'DRÁGEA', null, 'DRAGEA') ,
             (250, 'BR0268111', 'HIDRALAZINA, CLORIDRATO', '25 MG', 'DRÁGEA', null, 'DRAGEA') ,
             (251, 'BR0267674', 'HIDROCLOROTIAZIDA', '25 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (252, 'BR0364324', 'HIDROCLOROTIAZIDA', '12,5 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (253, 'BR0345240-3', 'HIDROCORTISONA, ACETATO', '10 MG/G', 'CREME', '20 G', 'BISNAGA') ,
             (254, 'BR0345240-2', 'HIDROCORTISONA, ACETATO', '10 MG/G', 'CREME', '30 G', 'BISNAGA') ,
             (255, 'BR0345240-1', 'HIDROCORTISONA, ACETATO', '10 MG/G', 'CREME', '15 G', 'BISNAGA') ,
             (256, 'BR0270220', 'HIDROCORTISONA, SUCCINATO SÓDICO', '100 MG', 'PÓ PARA SOLUÇÃO INJETÁVEL', null, 'FRASCO-AMPOLA') ,
             (257, 'BR0342134', 'HIDROCORTISONA, SUCCINATO SÓDICO', '500 MG', 'PÓ PARA SOLUÇÃO INJETÁVEL', null, 'FRASCO-AMPOLA') ,
             (258, 'BR0340783-3', 'HIDRÓXIDO DE ALUMÍNIO', '61,5 MG/ML', 'SUSPENSÃO ORAL', '150 ML', 'FRASCO') ,
             (259, 'BR0340783-2', 'HIDRÓXIDO DE ALUMÍNIO', '61,5 MG/ML', 'SUSPENSÃO ORAL', '100 ML', 'FRASCO') ,
             (260, 'BR0267271', 'HIDRÓXIDO DE ALUMÍNIO', '300 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (261, 'BR0340783-4', 'HIDRÓXIDO DE ALUMÍNIO', '61,5 MG/ML', 'SUSPENSÃO ORAL', '240 ML', 'FRASCO') ,
             (262, 'BR0367514', 'HIDRÓXIDO DE ALUMÍNIO', '230 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (263, 'BR0343303-1', 'HIPOCLORITO DE SÓDIO', '1%', 'SOLUÇÃO', '1000 ML', 'FRASCO') ,
             (264, 'BR0343303-2', 'HIPOCLORITO DE SÓDIO 1% SOLUÇÃO 5 L', null, null, null, 'FRASCO') ,
             (265, 'BR0373909-1', 'HIPROMELOSE', '3 MG/ML', 'SOLUÇÃO OFTÁLMICA', '5 ML', 'FRASCO') ,
             (266, 'BR0373909-2', 'HIPROMELOSE', '3 MG/ML', 'SOLUÇÃO OFTÁLMICA', '10 ML', 'FRASCO') ,
             (267, 'BR0373909-3', 'HIPROMELOSE', '3 MG/ML', 'SOLUÇÃO OFTÁLMICA', '15 ML', 'FRASCO') ,
             (268, 'BR0270042', 'HIPROMELOSE', '5 MG/ML', 'SOLUÇÃO OFTÁLMICA', '10 ML', 'FRASCO') ,
             (269, 'BR0267677', 'IBUPROFENO', '300 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (270, 'BR0267676', 'IBUPROFENO', '600 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (271, 'BR0332754', 'IBUPROFENO', '50 MG/ML', 'SUSPENSÃO ORAL', '30 ML', 'FRASCO') ,
             (272, 'BR0294648', 'IBUPROFENO', '200 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (273, 'BR0271157-1', 'INSULINA HUMANA NPH', '100 UI/ML', 'SUSPENSÃO INJETÁVEL', '3 ML', 'CARPULE') ,
             (274, 'BR0271157-2', 'INSULINA HUMANA NPH', '100 UI/ML', 'SUSPENSÃO INJETÁVEL', '10 ML', 'FRASCO-AMPOLA') ,
             (275, 'BR0271154-1', 'INSULINA HUMANA REGULAR', '100 UI/ML', 'SUSPENSÃO INJETÁVEL', '10 ML', 'FRASCO-AMPOLA') ,
             (276, 'BR0271154-2', 'INSULINA HUMANA REGULAR', '100 UI/ML', 'SUSPENSÃO INJETÁVEL', '3 ML', 'CARPULE') ,
             (277, 'BR0327215', 'IODO + IODETO DE POTÁSSIO 20 + 40MG/ML (LUGOL 2 %) SOLUÇÃO 1 L', null, null, null, 'FRASCO') ,
             (278, 'BR0268331-2', 'IPRATRÓPIO, BROMETO', '0,25 MG/ML', 'SOLUÇÃO PARA INALAÇÃO', '20 ML', 'FRASCO') ,
             (279, 'BR0268331-1', 'IPRATRÓPIO, BROMETO', '0,25 MG/ML', 'SOLUÇÃO PARA INALAÇÃO', '15 ML', 'FRASCO') ,
             (280, 'BR0268332', 'IPRATRÓPIO, BROMETO', '0,02 MG/DOSE', 'PÓ PARA INALAÇÃO ORAL', '200 DOSES', 'FRASCO') ,
             (281, 'BR0273395', 'ISOSSORBIDA, DINITRATO', '5 MG', 'COMPRIMIDO SUBLINGUAL', null, 'COMPRIMIDO') ,
             (282, 'BR0273401', 'ISOSSORBIDA, MONONITRATO', '40 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (283, 'BR0273400', 'ISOSSORBIDA, MONONITRATO', '20 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (284, 'BR0268861', 'ITRACONAZOL', '100 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (285, 'BR0273328', 'IVERMECTINA', '6 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (286, 'BR0305247-2', 'LACTULOSE', '667 MG/ML', 'XAROPE', '120 ML', 'FRASCO') ,
             (287, 'BR0389338', 'LANCETA, AÇO INOXIDÁVEL,TRIFACETADA, ULTRA FINA, DESCARTÁVEL, ESTÉRIL', null, null, null, 'UM') ,
             (288, 'BR0303151', 'LANCETA, AÇO INOXIDÁVEL,PONTA AFIADA,TRIFACETADA, DESCARTÁVEL, ESTÉRIL, EMBALAGEM INDIVIDUAL', null, null, null, 'UM') ,
             (289, 'BR0270127-2', 'LEVODOPA + BENSERAZIDA', '100 + 25 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (290, 'BR0270127-1', 'LEVODOPA + BENSERAZIDA', '100 + 25 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (291, 'BR0270126', 'LEVODOPA + BENSERAZIDA', '200 + 50 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (292, 'BR0270129', 'LEVODOPA + CARBIDOPA', '200 + 50 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (293, 'BR0270130', 'LEVODOPA + CARBIDOPA', '250 + 25 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (294, 'BR0295853', 'LEVONORGESTREL', '1,5 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (295, 'BR0268956', 'LEVONORGESTREL', '0,75 MG', 'COMPRIMIDO', null, 'CARTELA') ,
             (296, 'BR0272789', 'LEVONORGESTREL + ETINILESTRADIOL', '0,15 + 0,03 MG', 'COMPRIMIDO', null, 'CARTELA') ,
             (297, 'BR0268125', 'LEVOTIROXINA SÓDICA', '100 MCG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (298, 'BR0268123', 'LEVOTIROXINA SÓDICA', '50 MCG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (299, 'BR0268124', 'LEVOTIROXINA SÓDICA', '25 MCG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (300, 'BR0269842-2', 'LIDOCAÍNA, CLORIDRATO', '10 MG/ML', 'SOLUÇÃO INJETÁVEL', '20 ML', 'FRASCO') ,
             (301, 'BR0269843-1', 'LIDOCAÍNA, CLORIDRATO', '20 MG/ML', 'SOLUÇÃO INJETÁVEL', '5 ML', 'AMPOLA') ,
             (302, 'BR0269843-3', 'LIDOCAÍNA, CLORIDRATO', '20 MG/ML', 'SOLUÇÃO INJETÁVEL', '1,8 ML', 'TUBETE') ,
             (303, 'BR0269842-3', 'LIDOCAÍNA, CLORIDRATO', '10 MG/ML', 'SOLUÇÃO INJETÁVEL', '50 ML', 'FRASCO') ,
             (304, 'BR0269842-1', 'LIDOCAÍNA, CLORIDRATO', '10 MG/ML', 'SOLUÇÃO INJETÁVEL', '5 ML', 'AMPOLA') ,
             (305, 'BR0269845-2', 'LIDOCAÍNA, CLORIDRATO', '100 MG/ML', 'SOLUÇÃO TÓPICA', '70 ML', 'FRASCO') ,
             (306, 'BR0269846-1', 'LIDOCAÍNA, CLORIDRATO', '20 MG/G', 'GELÉIA', '10 G', 'BISNAGA') ,
             (307, 'BR0269843-2', 'LIDOCAÍNA, CLORIDRATO', '20 MG/ML', 'SOLUÇÃO INJETÁVEL', '20 ML', 'AMPOLA') ,
             (308, 'BR0269845-1', 'LIDOCAÍNA, CLORIDRATO', '100 MG/ML', 'SOLUÇÃO TÓPICA', '50 ML', 'FRASCO') ,
             (309, 'BR0269846-2', 'LIDOCAÍNA, CLORIDRATO', '20 MG/G', 'GELÉIA', '30 G', 'BISNAGA') ,
             (310, 'BR0275402', 'LIDOCAÍNA, CLORIDRATO + EPINEFRINA', '10 MG/ML + 1.200.000 UI', 'FRASCO', '20 ML', 'FRASCO') ,
             (311, 'BR0269852-1', 'LIDOCAÍNA, CLORIDRATO + EPINEFRINA', '20 MG/ML + 1:200.000 UI', 'SOLUÇÃO INJETÁVEL', '5 ML', 'AMPOLA') ,
             (312, 'BR0269852-2', 'LIDOCAÍNA, CLORIDRATO + EPINEFRINA', '20 MG/ML + 1:200.000 UI', 'SOLUÇÃO INJETÁVEL', '20 ML', 'AMPOLA') ,
             (313, 'BR0397428-1', 'LIDOCAÍNA, CLORIDRATO + EPINEFRINA', '2% + 1:80.000', 'SOLUÇÃO INJETÁVEL', '1,8 ML', 'TUBETE') ,
             (314, 'BR0397428-2', 'LIDOCAÍNA, CLORIDRATO + EPINEFRINA', '2% + 1:80.000', 'SOLUÇÃO INJETÁVEL', '20 ML', 'Fr-amp') ,
             (315, 'BR0269848', 'LIDOCAÍNA, CLORIDRATO + GLICOSE', '50 + 75 MG/ML', 'SOLUÇÃO INJETÁVEL', '2 ML', 'AMPOLA') ,
             (316, 'BR0273466', 'LORATADINA', '10 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (317, 'BR0273467-1', 'LORATADINA', '1 MG/ML', 'XAROPE', '60 ML', 'FRASCO') ,
             (318, 'BR0273467-2', 'LORATADINA', '1 MG/ML', 'XAROPE', '100 ML', 'FRASCO') ,
             (319, 'BR0273467', 'LORATADINA', '1 MG/ML', 'XAROPE', '120 ML', 'FRASCO') ,
             (320, 'BR0268856', 'LOSARTANA POTÁSSICA', '50 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (321, 'BR0407030-2', 'MAGNÉSIO, SULFATO', '990 MG/G', 'PÓ PARA SOLUÇÃO ORAL', '30 G', 'ENVELOPE') ,
             (322, 'BR0268075', 'MAGNÉSIO, SULFATO', '50%', 'SOLUÇÃO INJETÁVEL', '10 ML', 'AMPOLA') ,
             (323, 'BR0407030-1', 'MAGNÉSIO, SULFATO', '990 MG/G', 'PÓ PARA SOLUÇÃO ORAL', '15 G', 'SACHE') ,
             (324, 'BR0268076', 'MAGNÉSIO, SULFATO', '10%', 'SOLUÇÃO INJETÁVEL', '10 ML', 'AMPOLA') ,
             (325, 'BR0396450', 'MAYTENUS ILICIFOLIA (ESPINHEIRA SANTA)', '380 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (326, 'BR0399411', 'MAYTENUS ILICIFOLIA (ESPINHEIRA SANTA)', '12 MG/ML', 'TINTURA', '100 ML', 'FRASCO') ,
             (327, 'BR0399412', 'MAYTENUS ILICIFOLIA (ESPINHEIRA SANTA)', '500 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (328, 'BR0292227', 'MEDROXIPROGESTERONA, ACETATO', '50 MG/ML', 'SOLUÇÃO INJETÁVEL', '1 ML', 'FRASCO-AMPOLA') ,
             (329, 'BR0271445', 'MEDROXIPROGESTERONA, ACETATO', '10 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (330, 'BR0292228', 'MEDROXIPROGESTERONA, ACETATO', '150 MG/ML', 'SOLUÇÃO INJETÁVEL', '1 ML', 'AMPOLA') ,
             (331, 'BR0429853', 'MENTHA X PIPERITA L. (HORTELÃ)', '300 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (332, 'BR0267690', 'METFORMINA, CLORIDRATO', '500 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (333, 'BR0267691', 'METFORMINA, CLORIDRATO', '850 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (334, 'BR0267689', 'METILDOPA', '250 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (335, 'BR0267312', 'METOCLOPRAMIDA, CLORIDRATO', '10 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (336, 'BR0267310-1', 'METOCLOPRAMIDA, CLORIDRATO', '5 MG/ML', 'SOLUÇÃO INJETÁVEL', '1 ML', 'AMPOLA') ,
             (337, 'BR0267310-2', 'METOCLOPRAMIDA, CLORIDRATO', '5 MG/ML', 'SOLUÇÃO INJETÁVEL', '2 ML', 'AMPOLA') ,
             (338, 'BR0267311', 'METOCLOPRAMIDA, CLORIDRATO', '4 MG/ML', 'SOLUÇÃO ORAL', '10 ML', 'FRASCO') ,
             (339, 'BR0276656', 'METOPROLOL, SUCCINATO', '25 MG', 'COMPRIMIDO DE LIBERAÇÃO CONTROLADA', null, 'COMPRIMIDO') ,
             (340, 'BR0276657', 'METOPROLOL, SUCCINATO', '50 MG', 'COMPRIMIDO DE LIBERAÇÃO CONTROLADA', null, 'COMPRIMIDO') ,
             (341, 'BR0276658', 'METOPROLOL, SUCCINATO', '100 MG', 'COMPRIMIDO DE LIBERAÇÃO CONTROLADA', null, 'COMPRIMIDO') ,
             (342, 'BR0394650', 'METOPROLOL, TARTARATO', '100 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (343, 'BR0372335', 'METRONIDAZOL', '100 MG/G', 'GEL VAGINAL', '50 G', 'BISNAGA') ,
             (344, 'BR0267717', 'METRONIDAZOL', '250 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (345, 'BR0268499', 'METRONIDAZOL', '400 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (346, 'BR0266863-2', 'METRONIDAZOL (BENZOILMETRONIDAZOL)', '40 MG/ML', 'SUSPENSÃO ORAL', '100 ML', 'FRASCO') ,
             (347, 'BR0266863-3', 'METRONIDAZOL (BENZOILMETRONIDAZOL)', '40 MG/ML', 'SUSPENSÃO ORAL', '120 ML', 'FRASCO') ,
             (348, 'BR0266863-1', 'METRONIDAZOL (BENZOILMETRONIDAZOL)', '40 MG/ML', 'SUSPENSÃO ORAL', '80 ML', 'FRASCO') ,
             (349, 'BR0268162-2', 'MICONAZOL, NITRATO', '2%', 'CREME VAGINAL', '80 G', 'BISNAGA') ,
             (350, 'BR0268286-2', 'MICONAZOL, NITRATO', '2%', 'CREME', '80 G', 'BISNAGA') ,
             (351, 'BR0268267', 'MICONAZOL, NITRATO', '2%', 'LOÇÃO', '30 ML', 'FRASCO') ,
             (352, 'BR0268269', 'MICONAZOL, NITRATO', '2%', 'GEL ORAL', '40 G', 'BISNAGA') ,
             (353, 'BR0268268', 'MICONAZOL, NITRATO', '2%', 'PÓ', '30 G', 'FRASCO') ,
             (354, 'BR0268286-1', 'MICONAZOL, NITRATO', '2%', 'CREME', '28 G', 'BISNAGA') ,
             (355, 'BR0268162-1', 'MICONAZOL, NITRATO', '2%', 'CREME VAGINAL', '60 G', 'BISNAGA') ,
             (356, 'BR0271556', 'MIDAZOLAM, CLORIDRATO', '2 MG/ML', 'SOLUÇÃO ORAL', '10 ML', 'FRASCO') ,
             (357, 'BR0395631-1', 'MIKANIA GLOMERATA (GUACO)', '0,05 ML/ML', 'XAROPE', '100 ML', 'FRASCO') ,
             (358, 'BR0395631-2', 'MIKANIA GLOMERATA (GUACO)', '0,05 ML/ML', 'XAROPE', '150 ML', 'FRASCO') ,
             (359, 'BR0395728-1', 'MIKANIA GLOMERATA (GUACO)', '0,25 ML/ML', 'XAROPE', '100 ML', 'FRASCO') ,
             (360, 'BR0397280', 'MIKANIA GLOMERATA (GUACO)', '0,1 ML/ML', 'XAROPE', '120 ML', 'FRASCO') ,
             (361, 'BR0395728-2', 'MIKANIA GLOMERATA (GUACO)', '0,25 ML/ML', 'XAROPE', '120 ML', 'FRASCO') ,
             (362, 'BR0413681-1', 'MIKANIA GLOMERATA (GUACO)', '81,5 MG/ML', 'SOLUÇÃO ORAL', '120 ML', 'FRASCO') ,
             (363, 'BR0368779-1', 'MIKANIA GLOMERATA (GUACO)', '117,6 MG/ML', 'XAROPE', '120 ML', 'FRASCO') ,
             (364, 'BR0368779-2', 'MIKANIA GLOMERATA (GUACO)', '117,6 MG/ML', 'XAROPE', '150 ML', 'FRASCO') ,
             (365, 'BR0430336', 'MIKANIA GLOMERATA (GUACO)', '35 MG/ML', 'XAROPE', '150 ML', 'FRASCO') ,
             (366, 'BR0413681-2', 'MIKANIA GLOMERATA (GUACO', '60 MG/ ML', 'SOLUÇÃO ORAL', '120 ML', 'FRASCO') ,
             (367, 'BR0273481', 'MISOPROSTOL', '25 MCG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (368, 'BR0273482', 'MISOPROSTOL', '200 MCG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (369, 'BR0272326', 'NALOXONA, CLORIDRATO', '0,4 MG/ML', 'SOLUÇÃO INJETÁVEL', '1 ML', 'AMPOLA') ,
             (370, 'BR0267728-1', 'NIFEDIPINO', '10 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (371, 'BR0267728-2', 'NIFEDIPINO', '10 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (372, 'BR0267378-5', 'NISTATINA', '100.000 UI/ML', 'SUSPENSÃO ORAL', '120 ML', 'FRASCO') ,
             (373, 'BR0267378-2', 'NISTATINA', '100.000 UI/ML', 'SUSPENSÃO ORAL', '40 ML', 'FRASCO') ,
             (374, 'BR0267378-3', 'NISTATINA', '100.000 UI/ML', 'SUSPENSÃO ORAL', '50 ML', 'FRASCO') ,
             (375, 'BR0267378-1', 'NISTATINA', '100.000 UI/ML', 'SUSPENSÃO ORAL', '30 ML', 'FRASCO') ,
             (376, 'BR0267378-4', 'NISTATINA', '100.000 UI/ML', 'SUSPENSÃO ORAL', '60 ML', 'FRASCO') ,
             (377, 'BR0305714', 'NITROFURANTOÍNA', '5 MG/ML', 'SUSPENSÃO ORAL', '120 ML', 'FRASCO') ,
             (378, 'BR0268273-1', 'NITROFURANTOÍNA', '100 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (379, 'BR0305718', 'NOREPINEFRINA', '2 MG/ML', 'SOLUÇÃO INJETÁVEL', '4 ML', 'AMPOLA') ,
             (380, 'BR0267733', 'NORETISTERONA', '0,35 MG', 'COMPRIMIDO', null, 'CARTELA') ,
             (381, 'BR0271609-1', 'NORTRIPTILINA, CLORIDRATO', '10 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (382, 'BR0271606', 'NORTRIPTILINA, CLORIDRATO', '25 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (383, 'BR0271610', 'NORTRIPTILINA, CLORIDRATO', '50 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (384, 'BR0271607', 'NORTRIPTILINA, CLORIDRATO', '75 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (385, 'BR0233632-1', 'ÓLEO MINERAL (VASELINA LÍQUIDA / PETROLATO)', null, 'FRASCO', '100 ML', 'FRASCO') ,
             (386, 'BR0233632-4', 'ÓLEO MINERAL (VASELINA LÍQUIDA / PETROLATO)', null, 'FRASCO', '500 ML', 'FRASCO') ,
             (387, 'BR0233632-3', 'ÓLEO MINERAL (VASELINA LÍQUIDA / PETROLATO)', null, 'FRASCO', '200 ML', 'FRASCO') ,
             (388, 'BR0233632-2', 'ÓLEO MINERAL (VASELINA LÍQUIDA / PETROLATO)', null, 'FRASCO', '120 ML', 'FRASCO') ,
             (389, 'BR0267711', 'OMEPRAZOL', '10 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (390, 'BR0267712', 'OMEPRAZOL', '20 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (391, 'BR0268506', 'ONDANSETRONA, CLORIDRATO', '4 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (392, 'BR0268505', 'ONDANSETRONA, CLORIDRATO', '8 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (393, 'BR0290891', 'OXAMNIQUINA', '50 MG/ML', 'SUSPENSÃO ORAL', '12 ML', 'FRASCO') ,
             (394, 'BR0267778', 'PARACETAMOL', '500 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (395, 'BR0267777-1', 'PARACETAMOL', '200 MG/ML', 'SOLUÇÃO ORAL', '10 ML', 'FRASCO') ,
             (396, 'BR0267777-2', 'PARACETAMOL', '200 MG/ML', 'SOLUÇÃO ORAL', '15 ML', 'FRASCO') ,
             (397, 'BR0267777-3', 'PARACETAMOL', '200 MG/ML', 'SOLUÇÃO ORAL', '20 ML', 'FRASCO') ,
             (398, 'BR0274648-1', 'PASTA D?ÁGUA', null, 'PASTA', '30 G', 'POTE') ,
             (399, 'BR0274648-2', 'PASTA D?ÁGUA', null, 'PASTA', '40 G', 'POTE') ,
             (400, 'BR0274648-4', 'PASTA D?ÁGUA', null, 'PASTA', '90 G', 'POTE') ,
             (401, 'BR0274648-5', 'PASTA D?ÁGUA', null, 'PASTA', '80 G', 'POTE') ,
             (402, 'BR0274648-3', 'PASTA D?ÁGUA', null, 'PASTA', '100 G', 'POTE') ,
             (403, 'BR0327699-1', 'PERMANGANATO DE POTÁSSIO', '100 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (404, 'BR0327699-2', 'PERMANGANATO DE POTÁSSIO', '100 MG', 'PÓ', null, 'SACHE') ,
             (405, 'BR0363597-2', 'PERMETRINA', '50 MG/ML', 'LOÇÃO', '100 ML', 'FRASCO') ,
             (406, 'BR0267773-1', 'PERMETRINA', '10 MG/ML', 'LOÇÃO', '60 ML', 'FRASCO') ,
             (407, 'BR0267773-2', 'PERMETRINA', '10 MG/ML', 'LOÇÃO', '100 ML', 'FRASCO') ,
             (408, 'BR0363597-1', 'PERMETRINA', '50 MG/ML', 'LOÇÃO', '60 ML', 'FRASCO') ,
             (409, 'BR0366861 -2', 'PERÓXIDO DE BENZOÍLA', '5%', 'GEL', '20 G', 'BISNAGA') ,
             (410, 'BR0366861', 'PERÓXIDO DE BENZOÍLA', '5%', 'GEL', '60 G', 'BISNAGA') ,
             (411, 'BR0384537-2', 'PERÓXIDO DE BENZOÍLA', '2,50%', 'GEL', '20 G', 'BISNAGA') ,
             (412, 'BR0366861-3', 'PERÓXIDO DE BENZOÍLA', '5%', 'GEL', '45 G', 'BISNAGA') ,
             (413, 'BR0384537', 'PERÓXIDO DE BENZOÍLA', '2,50%', 'GEL', '60 G', 'BISNAGA') ,
             (414, 'BR0271353-1', 'PILOCARPINA, CLORIDRATO', '2%', 'SOLUÇÃO OFTÁLMICA', '10 ML', 'FRASCO') ,
             (415, 'BR0271353', 'PILOCARPINA, CLORIDRATO', '2%', 'SOLUÇÃO OFTÁLMICA', '5 ML', 'FRASCO') ,
             (416, 'BR0267774', 'PIRIDOXINA, CLORIDRATO', '40 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (417, 'BR0268158', 'PIRIMETAMINA', '25 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (418, 'BR0396414-1', 'PLANTAGO OVATA (PSYLLIUM)', null, 'PÓ PARA DISPERSÃO ORAL', '3,5 G', 'SACHE') ,
             (419, 'BR0396414-2', 'PLANTAGO OVATA (PSYLLIUM)', null, 'PÓ PARA DISPERSÃO ORAL', '5,00 G', 'SACHE') ,
             (420, 'BR0396414-3', 'PLANTAGO OVATA (PSYLLIUM)', null, 'PÓ PARA DISPERSÃO ORAL', '5,40 G', 'SACHE') ,
             (421, 'BR0396414-4', 'PLANTAGO OVATA (PSYLLIUM)', null, 'PÓ PARA DISPERSÃO ORAL', '5,85 G', 'SACHE') ,
             (422, 'BR0396414-5', 'PLANTAGO OVATA (PSYLLIUM)', null, 'PÓ PARA DISPERSÃO ORAL', '174 G', 'POTE') ,
             (423, 'BR0415027', 'PODOFILINA', '25%', 'SUSPENSÃO TÓPICA', '20 ML', 'FRASCO') ,
             (424, 'BR0273668', 'PRALIDOXIMA, MESILATO', '200 MG', 'PÓ LIOFILIZADO', null, 'FRASCO-AMPOLA') ,
             (425, 'BR0268151-3', 'PREDNISOLONA', '1 MG/ML', 'SOLUÇÃO ORAL', '120 ML', 'FRASCO') ,
             (426, 'BR0268150-1', 'PREDNISOLONA', '3 MG/ML', 'SOLUÇÃO ORAL', '60 ML', 'FRASCO') ,
             (427, 'BR0268151-1', 'PREDNISOLONA', '1 MG/ML', 'SOLUÇÃO ORAL', '60 ML', 'FRASCO') ,
             (428, 'BR0268150-2', 'PREDNISOLONA', '3 MG/ML', 'SOLUÇÃO ORAL', '100 ML', 'FRASCO') ,
             (429, 'BR0268151-2', 'PREDNISOLONA', '1 MG/ML', 'SOLUÇÃO ORAL', '100 ML', 'FRASCO') ,
             (430, 'BR0268150-3', 'PREDNISOLONA', '3 MG/ML', 'SOLUÇÃO ORAL', '120 ML', 'FRASCO') ,
             (431, 'BR0267743', 'PREDNISONA', '20 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (432, 'BR0267741', 'PREDNISONA', '5 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (433, 'BR0269833', 'PRILOCAÍNA + FELIPRESSINA', '3 % + 0,03 UI/ML', 'SOLUÇÃO INJETÁVEL', '1,8 ML', 'TUBETE') ,
             (434, 'BR0267768', 'PROMETAZINA, CLORIDRATO', '25 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (435, 'BR0267769', 'PROMETAZINA, CLORIDRATO', '25 MG/ML', 'SOLUÇÃO INJETÁVEL', '2 ML', 'AMPOLA') ,
             (436, 'BR0384894', 'PROPAFENONA, CLORIDRATO', '150 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (437, 'BR0272412', 'PROPAFENONA, CLORIDRATO', '300 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (438, 'BR0273589', 'PROPILTIOURACILA', '100 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (439, 'BR0267772', 'PROPRANOLOL, CLORIDRATO', '40 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (440, 'BR0267771', 'PROPRANOLOL, CLORIDRATO', '10 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (441, 'BR0272362', 'PROTAMINA, CLORIDRATO', '10 MG/ML', 'SOLUÇÃO INJETÁVEL', '5 ML', 'AMPOLA') ,
             (442, 'BR0267735', 'RANITIDINA, CLORIDRATO', '25 MG/ML', 'SOLUÇÃO INJETÁVEL', '2 ML', 'AMPOLA') ,
             (443, 'BR0267736', 'RANITIDINA, CLORIDRATO', '150 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (444, 'BR0267734', 'RANITIDINA, CLORIDRATO', '15 MG/ML', 'XAROPE', '120 ML', 'FRASCO') ,
             (445, 'BR0272565', 'RETINOL, PALMITATO', '150.000 UI/ML', 'SOLUÇÃO ORAL', '20 ML', 'FRASCO') ,
             (446, 'BR0399409', 'RHAMNUS PURSHIANA (CÁSCARA SAGRADA)', '150 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (447, 'BR0399636', 'RHAMNUS PURSHIANA (CÁSCARA SAGRADA)', '75 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (448, 'BR0399413', 'RHAMNUS PURSHIANA (CÁSCARA SAGRADA)', '500 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (449, 'BR0426292', 'RHAMNUS PURSHIANA (CÁSCARA SAGRADA)', '380 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (450, 'BR0281453', 'RHAMNUS PURSHIANA (CÁSCARA SAGRADA)', '10MG/ML', 'TINTURA', null, 'FRASCO') ,
             (451, 'BR0303292-2', 'RINGER LACTATO SÓDICO', null, 'SOLUÇÃO INJETÁVEL', '500 ML SISTEMA FECHADO', 'FRASCO') ,
             (452, 'BR0303292-1', 'RINGER LACTATO SÓDICO', null, 'SOLUÇÃO INJETÁVEL', '250 ML SISTEMA FECHADO', 'FRASCO') ,
             (453, 'BR0271877', 'RINGER LACTATO SÓDICO', null, 'SOLUÇÃO INJETÁVEL', '500 ML', 'FRASCO') ,
             (454, 'BR0293839', 'SAIS PARA REIDRATAÇÃO ORAL (NaCl 3,5G + Glicose 20G + Citrato Na 2,9G + KCl 1,5G)', null, 'PÓ PARA SOLUÇÃO ORAL', '8,5 G', 'ENVELOPE') ,
             (455, 'BR0268390', 'SAIS PARA REIDRATAÇÃO ORAL (NaCl 3,5G + Glicose 20G + Citrato Na 2,9G + KCl 1,5G)', null, 'PÓ PARA SOLUÇÃO ORAL', '27,9 G', 'ENVELOPE') ,
             (456, 'BR0268303-1', 'SALBUTAMOL, SULFATO', '5 MG/ML', 'SOLUÇÃO PARA NEBULIZAÇÃO', '10 ML', 'FRASCO') ,
             (457, 'BR0294887', 'SALBUTAMOL, SULFATO', '100 MCG/DOSE', 'AEROSSOL ORAL', '200 DOSES', 'FRASCO') ,
             (458, 'BR0268303', 'SALBUTAMOL, SULFATO', '5 MG/ML', 'SOLUÇÃO PARA NEBULIZAÇÃO', '5 ML', 'FRASCO') ,
             (459, 'BR0268523', 'SALBUTAMOL, SULFATO', '0,5 MG/ML', 'SOLUÇÃO INJETÁVEL', '1 ML', 'AMPOLA') ,
             (460, 'BR0395716', 'SCHINUS TEREBENTHIFOLIUS (AROEIRA)', '0,67ML/G', 'GEL VAGINAL', '60 G', 'BISNAGA') ,
             (461, 'BR0395716-1', 'SCHINUS TEREBINTHIFOLIUS (AROEIRA)', '0,67 ML/G', 'GEL VAGINAL', '10 G', 'BISNAGA') ,
             (462, 'BR0395716-2', 'SCHINUS TEREBINTHIFOLIUS (AROEIRA)', '0,67 ML/G', 'GEL VAGINAL', '30 G', 'BISNAGA') ,
             (463, 'BR0341549', 'SERINGA 100 UI POLIPROPILENO + AGULHA 12,7 MM X 0,33 MM', null, null, null, 'UM') ,
             (464, 'BR0417059', 'SERINGA DESCARTÁVEL GRADUADA EM UNIDADES (ESCALA DE 1 EM 1 UNIDADES), AGULHA FIXA (INTEGRADA) DE 6,0MM DE COMPRIMENTO POR 0,25MM DE DIÂMETRO (31G), SEM ESPAÇO MORTO E COM CAPACIDADE PARA ATÉ 50 UNIDADES DE INSULINA', null, null, null, 'UM') ,
             (465, 'BR0285040', 'SERINGA PARA INSULINA, 1 ML, APIROGÊNICA E ATÓXICA, 100 UI COM BOA VISUALIZAÇÃO, DESCARTÁVEL, ESTÉRIL, AGULHA 13 X 3,8', null, null, null, 'UM') ,
             (466, 'BR0406825', 'SERINGA, POLIPROPILENO TRANSPARENTE, 1 ML (ESCALA EM UI), BICO CENTRAL SIMPLES OU LUER LOCK, ÊMBOLO C/ROLHA BORRACHA, IMPRESSÃO LEGÍVEL E PERMANENTE, GRADUAÇÃO MÁXIMA 0,2 EM 0,2 ML, NUMERADA, C/ AGULHA 13 X 0,38 MM, BISEL TRIFACETADO, PROTETOR PLÁSTI', null, null, null, 'UM') ,
             (467, 'BR0406819', 'SERINGA, POLIPROPILENO TRANSPARENTE, 1 ML (ESCALA EM UI), COM SISTEMA SEGURANÇA SEGUNDO NR/32, IMPRESSÃO LEGÍVEL E PERMANENTE, GRADUAÇÃO MÁXIMA 0,2 EM 0,2 ML, NUMERADA, C/ AGULHA 12,7 X 0,33 MM, BISEL TRIFACETADO, PROTETOR PLÁSTICO, DESCARTÁVEL', null, null, null, 'UM') ,
             (468, 'BR0406821', 'SERINGA, POLIPROPILENO TRANSPARENTE, 1 ML (ESCALA EM UI), ÊMBOLO C/ROLHA BORRACHA, GRADUAÇÃO MÁXIMA 0,2 EM 0,2 UI, NUMERADA, C/ AGULHA FIXA 8 X 0,3 MM, BISEL TRIFACETADO, PROTETOR PLÁSTICO, DESCARTÁVEL, ESTÉRIL', null, null, null, 'UM') ,
             (469, 'BR0267746', 'SINVASTATINA', '10 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (470, 'BR0267747', 'SINVASTATINA', '20 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (471, 'BR0267745', 'SINVASTATINA', '40 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (472, 'BR0267765', 'SULFADIAZINA', '500MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (473, 'BR0272089', 'SULFADIAZINA DE PRATA', '1%', 'CREME', '500 G', 'POTE') ,
             (474, 'BR0272089-6', 'SULFADIAZINA DE PRATA', '1%', 'CREME', '50 G', 'BISNAGA') ,
             (475, 'BR0272089-1', 'SULFADIAZINA DE PRATA', '1%', 'CREME', '30 G', 'BISNAGA') ,
             (476, 'BR0308884-4', 'SULFAMETOXAZOL + TRIMETOPRIMA', '40 + 8 MG/ML', 'SUSPENSÃO ORAL', '120 ML', 'FRASCO') ,
             (477, 'BR0308882', 'SULFAMETOXAZOL + TRIMETOPRIMA', '400 + 80 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (478, 'BR0308884-2', 'SULFAMETOXAZOL + TRIMETOPRIMA', '40 + 8 MG/ML', 'SUSPENSÃO ORAL', '60 ML', 'FRASCO') ,
             (479, 'BR0308885', 'SULFAMETOXAZOL + TRIMETOPRIMA', '80 + 16 MG/ML', 'SOLUÇÃO INJETÁVEL', '5 ML', 'AMPOLA') ,
             (480, 'BR0308884-1', 'SULFAMETOXAZOL + TRIMETOPRIMA', '40 + 8 MG/ML', 'SUSPENSÃO ORAL', '50 ML', 'FRASCO') ,
             (481, 'BR0308884-3', 'SULFAMETOXAZOL + TRIMETOPRIMA', '40 + 8 MG/ML', 'SUSPENSÃO ORAL', '100 ML', 'FRASCO') ,
             (482, 'BR0292345', 'SULFATO FERROSO (25MG/ML DE FERRO ELEMENTAR)', '125 MG/ML', 'SOLUÇÃO ORAL', '30 ML', 'FRASCO') ,
             (483, 'BR0292344', 'SULFATO FERROSO (40MG DE FERRO ELEMENTAR)', '109 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (484, 'BR0332468-2', 'SULFATO FERROSO (5MG/ML DE FERRO ELEMENTAR)', '25 MG/ML', 'XAROPE', '100 ML', 'FRASCO') ,
             (485, 'BR0332468-1', 'SULFATO FERROSO (5MG/ML DE FERRO ELEMENTAR)', '25 MG/ML', 'XAROPE', '60 ML', 'FRASCO') ,
             (486, 'BR0273618', 'TECLOZANA', '10 MG/ML', 'SUSPENSÃO ORAL', '90 ML', 'FRASCO') ,
             (487, 'BR0273619', 'TECLOZANA', '500 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (488, 'BR0272341', 'TIAMINA, CLORIDRATO', '300 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (489, 'BR0272581', 'TIMOLOL, MALEATO', '0,50%', 'SOLUÇÃO OFTÁLMICA', '5 ML', 'FRASCO') ,
             (490, 'BR0272582', 'TIMOLOL, MALEATO', '0,25%', 'SOLUÇÃO OFTÁLMICA', '5 ML', 'FRASCO') ,
             (491, 'BR0339565', 'TIRA REAGENTE PARA MEDIR GLICEMIA CAPILAR', null, null, null, 'UM') ,
             (492, 'BR0399441', 'UNCARIA TOMENTOSA (UNHA DE GATO)', '50 MG/G', 'GEL', '5 G', 'BISNAGA') ,
             (493, 'BR0399442', 'UNCARIA TOMENTOSA (UNHA DE GATO)', '100 MG', 'CÁPSULA', null, 'CAPSULA') ,
             (494, 'BR0279269', 'VARFARINA SÓDICA', '5 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (495, 'BR0279271', 'VARFARINA SÓDICA', '1 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (496, 'BR0267424', 'VERAPAMIL, CLORIDRATO', '2,5 MG/ML', 'SOLUÇÃO INJETÁVEL', '2 ML', 'AMPOLA') ,
             (497, 'BR0267425', 'VERAPAMIL, CLORIDRATO', '80 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ,
             (498, 'BR0267573', 'VERAPAMIL, CLORIDRATO', '120 MG', 'COMPRIMIDO', null, 'COMPRIMIDO') ;

alter table prontprofatend alter s104_i_profissional drop not null;
alter table prontprofatend add s104_rhcbo int4;
alter table prontprofatend ADD CONSTRAINT prontprofatend_rhcbo_fk FOREIGN KEY (s104_rhcbo) REFERENCES rhcbo;
CREATE  INDEX prontprofatend_rhcbo_in ON prontprofatend(s104_rhcbo);

CREATE SEQUENCE matmaterconteudomaterial_m08_codigo_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE administracaomedicamento_sd105_codigo_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;
CREATE SEQUENCE prontuarioadministracaomedicamento_sd106_codigo_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1;

CREATE TABLE matmaterconteudomaterial(
m08_codigo     int4 NOT NULL default 0,
m08_matmater   int4 NOT NULL default 0,
m08_unidade    int4 NOT NULL default 0,
m08_quantidade numeric not null,
CONSTRAINT matmaterconteudomaterial_codi_pk PRIMARY KEY (m08_codigo));

CREATE TABLE administracaomedicamento(
sd105_codigo          int4 NOT NULL default 0,
sd105_usuario         int4 NOT NULL default 0,
sd105_unidadesaida      int4 NOT NULL default 0,
sd105_quantidade          numeric NOT NULL default 0,
sd105_quantidadetotal   numeric NOT NULL default 0,
sd105_data            date NOT NULL default null,
sd105_hora            time NOT NULL,
sd105_medicamento       int4 default 0,
CONSTRAINT administracaomedicamento_codi_pk PRIMARY KEY (sd105_codigo));

CREATE TABLE prontuarioadministracaomedicamento(
sd106_codigo                   int4 NOT NULL default 0,
sd106_prontuario               int4 NOT NULL default 0,
sd106_administracaomedicamento int4 default 0,
CONSTRAINT prontuarioadministracaomedicamento_codi_pk PRIMARY KEY (sd106_codigo));

ALTER TABLE administracaomedicamento ADD CONSTRAINT administracaomedicamento_medicamento_fk FOREIGN KEY (sd105_medicamento) REFERENCES far_matersaude;
ALTER TABLE matmaterconteudomaterial ADD CONSTRAINT matmaterconteudomaterial_matmater_fk FOREIGN KEY (m08_matmater) REFERENCES matmater;
ALTER TABLE matmaterconteudomaterial ADD CONSTRAINT matmaterconteudomaterial_unidade_fk FOREIGN KEY (m08_unidade) REFERENCES matunid;
ALTER TABLE administracaomedicamento ADD CONSTRAINT administracaomedicamento_usuario_fk FOREIGN KEY (sd105_usuario) REFERENCES db_usuarios;
ALTER TABLE administracaomedicamento ADD CONSTRAINT administracaomedicamento_unidadesaida_fk FOREIGN KEY (sd105_unidadesaida) REFERENCES matunid;
ALTER TABLE prontuarioadministracaomedicamento ADD CONSTRAINT prontuarioadministracaomedicamento_administracaomedicamento_fk FOREIGN KEY (sd106_administracaomedicamento) REFERENCES administracaomedicamento;
ALTER TABLE prontuarioadministracaomedicamento ADD CONSTRAINT prontuarioadministracaomedicamento_prontuario_fk FOREIGN KEY (sd106_prontuario) REFERENCES prontuarios;

CREATE  INDEX administracaomedicamento_medicamento_in ON administracaomedicamento(sd105_medicamento);
CREATE  INDEX administracaomedicamento_unidadesaida_in ON administracaomedicamento(sd105_unidadesaida);
CREATE  INDEX administracaomedicamento_usuario_in ON administracaomedicamento(sd105_usuario);
CREATE  INDEX prontuarioadministracaomedicamento_administracaomedicamento_in ON prontuarioadministracaomedicamento(sd106_administracaomedicamento);
CREATE  INDEX prontuarioadministracaomedicamento_prontuario_in ON prontuarioadministracaomedicamento(sd106_prontuario);
CREATE INDEX matmaterconteudomaterial_unidade_in ON matmaterconteudomaterial(m08_unidade);
CREATE UNIQUE INDEX matmaterconteudomaterial_matmater_in ON matmaterconteudomaterial(m08_matmater);


CREATE SEQUENCE descartemedicamento_sd107_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE descartemedicamento(
sd107_sequencial   int4 NOT NULL default 0,
sd107_medicamento  int4 NOT NULL default 0,
sd107_quantidade   numeric NOT NULL default 0,
sd107_motivo       text NOT NULL ,
sd107_data         date NOT NULL default null,
sd107_hora         time NOT NULL ,
sd107_usuario      int4 NOT NULL default 0,
sd107_db_depart    int4 NOT NULL default 0,
sd107_quantidadetotal numeric NOT NULL default 0,
sd107_unidadesaida    int4  NOT NULL default 0,
CONSTRAINT descartemedicamento_sequ_pk PRIMARY KEY (sd107_sequencial));


ALTER TABLE descartemedicamento ADD CONSTRAINT descartemedicamento_unidadesaida_fk FOREIGN KEY (sd107_unidadesaida) REFERENCES matunid;
ALTER TABLE descartemedicamento ADD CONSTRAINT descartemedicamento_usuario_fk FOREIGN KEY (sd107_usuario) REFERENCES db_usuarios;
ALTER TABLE descartemedicamento ADD CONSTRAINT descartemedicamento_medicamento_fk FOREIGN KEY (sd107_medicamento) REFERENCES far_matersaude;
ALTER TABLE descartemedicamento ADD CONSTRAINT descartemedicamento_depart_fk FOREIGN KEY (sd107_db_depart) REFERENCES db_depart;

CREATE INDEX descartemedicamento_usuario_in ON descartemedicamento(sd107_usuario);
CREATE INDEX descartemedicamento_db_depart_in ON descartemedicamento(sd107_db_depart);
CREATE INDEX descartemedicamento_medicamento_in ON descartemedicamento(sd107_medicamento);
CREATE INDEX descartemedicamento_unidadesaida_in ON descartemedicamento(sd107_unidadesaida);
---------------------------------------------------------------------------------------------
-------------------------------- FIM TIME EDUCAÇÃO / SAÚDE ----------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-------------------------------- INICIO TRIBUTÁRIO ------------------------------------------
---------------------------------------------------------------------------------------------

CREATE SEQUENCE condicionantetipolicenca_am17_sequencial_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

CREATE TABLE condicionantetipolicenca(
am17_sequencial     int4 NOT NULL default 0,
am17_condicionante      int4 NOT NULL default 0,
am17_tipolicenca        int4 default 0,
CONSTRAINT condicionantetipolicenca_sequ_pk PRIMARY KEY (am17_sequencial));

ALTER TABLE condicionantetipolicenca
ADD CONSTRAINT condicionantetipolicenca_tipolicenca_fk FOREIGN KEY (am17_tipolicenca)
REFERENCES tipolicenca;

ALTER TABLE condicionantetipolicenca
ADD CONSTRAINT condicionantetipolicenca_condicionante_fk FOREIGN KEY (am17_condicionante)
REFERENCES condicionante;

select fc_executa_ddl('delete from condicionanteatividadeimpacto;');
select fc_executa_ddl('delete from condicionante;');

alter table condicionante drop COLUMN IF EXISTS am10_tipolicenca;

alter table condicionante add am10_vinculatodasatividades bool default 'false';

CREATE SEQUENCE zonas_j50_zona_seq
INCREMENT 1
MINVALUE 1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

select fc_executa_ddl('select setval(\'zonas_j50_zona_seq\', (select max(j50_zona) from zonas));');

/**
 * SisObra
 */
update obrastiporesp set ob02_descr = 'PROPRIETÁRIO (TITULAR DO IMÓVEL E DA OBRA)'      where ob02_cod = 51;
update obrastiporesp set ob02_descr = 'DONO (NÃO TITULAR DO IMÓVEL)'                    where ob02_cod = 52;
update obrastiporesp set ob02_descr = 'CONSTRUTORA (COM REGISTRO NO CREA)'              where ob02_cod = 53;
update obrastiporesp set ob02_descr = 'INCORPORADORA (ABRANGIDOS PELA LEI Nº 4.591/64)' where ob02_cod = 55;

insert into obrastiporesp (ob02_cod, ob02_descr)
     select 51, 'PROPRIETÁRIO (TITULAR DO IMÓVEL E DA OBRA)'
      where not exists (select 1
                          from obrastiporesp
                         where ob02_cod = 51);

insert into obrastiporesp (ob02_cod, ob02_descr)
     select 52, 'DONO (NÃO TITULAR DO IMÓVEL)'
      where not exists (select 1
                          from obrastiporesp
                         where ob02_cod = 52);

insert into obrastiporesp (ob02_cod, ob02_descr)
     select 53, 'CONSTRUTORA (COM REGISTRO NO CREA)'
      where not exists (select 1
                          from obrastiporesp
                         where ob02_cod = 53);

insert into obrastiporesp (ob02_cod, ob02_descr)
     select 55, 'INCORPORADORA (ABRANGIDOS PELA LEI Nº 4.591/64)'
      where not exists (select 1
                          from obrastiporesp
                         where ob02_cod = 55);

select setval('obrastiporesp_ob02_cod_seq', (select max(ob02_cod) from obrastiporesp));

update db_layoutlinha  set db51_descr = 'IDENTIFICAÇÃO DO PROPRIETARÍO' where db51_codigo = 481;
update db_layoutcampos set db52_descr = upper(db52_descr)               where db52_layoutlinha in (480,481,482,483);
update db_layoutcampos set db52_descr = 'CÓDIGO SINPAS DO MUNICIPIO'    where db52_codigo = 7416;
update db_layoutcampos set db52_descr = 'DATA/HORA DE ENVIO DO ARQUIVO' where db52_codigo = 7421;
update db_layoutcampos set db52_descr = 'FAX'                           where db52_codigo = 7476;

/**
 * SINPAS
 */
 update cadendermunicipiosistema set db125_codigosistema = '190934' where substr('190934',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190934' where substr('190934',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020010' where substr('020010',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020028' where substr('020028',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020036' where substr('020036',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020044' where substr('020044',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020052' where substr('020052',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020060' where substr('020060',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020079' where substr('020079',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020087' where substr('020087',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020095' where substr('020095',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020109' where substr('020109',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020117' where substr('020117',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020125' where substr('020125',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020133' where substr('020133',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020141' where substr('020141',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020150' where substr('020150',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020168' where substr('020168',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020176' where substr('020176',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020184' where substr('020184',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020192' where substr('020192',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020206' where substr('020206',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020214' where substr('020214',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020222' where substr('020222',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020230' where substr('020230',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020249' where substr('020249',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020257' where substr('020257',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020265' where substr('020265',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020273' where substr('020273',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020281' where substr('020281',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020290' where substr('020290',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020303' where substr('020303',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020311' where substr('020311',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020320' where substr('020320',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020338' where substr('020338',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020346' where substr('020346',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020354' where substr('020354',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020362' where substr('020362',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020370' where substr('020370',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020389' where substr('020389',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020397' where substr('020397',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020400' where substr('020400',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020419' where substr('020419',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020427' where substr('020427',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020435' where substr('020435',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020443' where substr('020443',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020451' where substr('020451',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020460' where substr('020460',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020478' where substr('020478',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020486' where substr('020486',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020494' where substr('020494',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020508' where substr('020508',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020516' where substr('020516',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020524' where substr('020524',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020532' where substr('020532',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020540' where substr('020540',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020559' where substr('020559',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020567' where substr('020567',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020575' where substr('020575',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020583' where substr('020583',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020591' where substr('020591',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020605' where substr('020605',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020613' where substr('020613',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020621' where substr('020621',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020630' where substr('020630',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020648' where substr('020648',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020656' where substr('020656',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020664' where substr('020664',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020672' where substr('020672',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020680' where substr('020680',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020699' where substr('020699',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020702' where substr('020702',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020710' where substr('020710',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020729' where substr('020729',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020737' where substr('020737',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020745' where substr('020745',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020753' where substr('020753',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020761' where substr('020761',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020770' where substr('020770',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020788' where substr('020788',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020796' where substr('020796',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020800' where substr('020800',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020818' where substr('020818',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020826' where substr('020826',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020834' where substr('020834',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020842' where substr('020842',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020850' where substr('020850',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020869' where substr('020869',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020877' where substr('020877',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020885' where substr('020885',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020893' where substr('020893',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020907' where substr('020907',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020915' where substr('020915',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020923' where substr('020923',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020931' where substr('020931',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020940' where substr('020940',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020958' where substr('020958',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020966' where substr('020966',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020974' where substr('020974',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020982' where substr('020982',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '020990' where substr('020990',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '021008' where substr('021008',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '021016' where substr('021016',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '021024' where substr('021024',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030015' where substr('030015',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030023' where substr('030023',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030031' where substr('030031',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030040' where substr('030040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030058' where substr('030058',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030066' where substr('030066',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030074' where substr('030074',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030082' where substr('030082',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030090' where substr('030090',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030104' where substr('030104',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030112' where substr('030112',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030120' where substr('030120',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030139' where substr('030139',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030147' where substr('030147',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030155' where substr('030155',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030163' where substr('030163',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030171' where substr('030171',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030180' where substr('030180',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030198' where substr('030198',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030201' where substr('030201',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030210' where substr('030210',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030228' where substr('030228',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030236' where substr('030236',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030244' where substr('030244',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030252' where substr('030252',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030260' where substr('030260',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030279' where substr('030279',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030287' where substr('030287',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030295' where substr('030295',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030309' where substr('030309',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030317' where substr('030317',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030325' where substr('030325',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030333' where substr('030333',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030341' where substr('030341',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030350' where substr('030350',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030368' where substr('030368',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030376' where substr('030376',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030384' where substr('030384',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030392' where substr('030392',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030406' where substr('030406',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030414' where substr('030414',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030422' where substr('030422',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030430' where substr('030430',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030449' where substr('030449',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030457' where substr('030457',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030465' where substr('030465',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030481' where substr('030481',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030490' where substr('030490',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030503' where substr('030503',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030538' where substr('030538',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030554' where substr('030554',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030562' where substr('030562',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030619' where substr('030619',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030627' where substr('030627',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030635' where substr('030635',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030651' where substr('030651',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030660' where substr('030660',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030686' where substr('030686',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030708' where substr('030708',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030716' where substr('030716',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030724' where substr('030724',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '030732' where substr('030732',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040010' where substr('040010',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040010' where substr('040010',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040029' where substr('040029',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040037' where substr('040037',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040045' where substr('040045',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040053' where substr('040053',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040061' where substr('040061',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040070' where substr('040070',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040088' where substr('040088',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040096' where substr('040096',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040100' where substr('040100',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040118' where substr('040118',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040126' where substr('040126',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040134' where substr('040134',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040142' where substr('040142',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040150' where substr('040150',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040169' where substr('040169',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040177' where substr('040177',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040185' where substr('040185',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040193' where substr('040193',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040207' where substr('040207',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040215' where substr('040215',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040223' where substr('040223',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040231' where substr('040231',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040240' where substr('040240',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040258' where substr('040258',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040266' where substr('040266',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040274' where substr('040274',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040282' where substr('040282',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040290' where substr('040290',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040304' where substr('040304',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040312' where substr('040312',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040320' where substr('040320',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040339' where substr('040339',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040347' where substr('040347',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040363' where substr('040363',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040371' where substr('040371',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040380' where substr('040380',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040398' where substr('040398',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040401' where substr('040401',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040410' where substr('040410',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040428' where substr('040428',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040436' where substr('040436',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040444' where substr('040444',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040452' where substr('040452',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040460' where substr('040460',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040479' where substr('040479',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040487' where substr('040487',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040495' where substr('040495',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040509' where substr('040509',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040517' where substr('040517',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040525' where substr('040525',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040533' where substr('040533',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040541' where substr('040541',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040550' where substr('040550',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040568' where substr('040568',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040576' where substr('040576',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040584' where substr('040584',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040592' where substr('040592',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040606' where substr('040606',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040614' where substr('040614',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040622' where substr('040622',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040630' where substr('040630',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040649' where substr('040649',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040657' where substr('040657',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040665' where substr('040665',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040673' where substr('040673',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040681' where substr('040681',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040690' where substr('040690',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040703' where substr('040703',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040711' where substr('040711',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040720' where substr('040720',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040738' where substr('040738',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040746' where substr('040746',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040754' where substr('040754',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040762' where substr('040762',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040770' where substr('040770',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040789' where substr('040789',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040797' where substr('040797',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040800' where substr('040800',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040819' where substr('040819',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040827' where substr('040827',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040835' where substr('040835',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040843' where substr('040843',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040851' where substr('040851',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040860' where substr('040860',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040878' where substr('040878',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040886' where substr('040886',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040894' where substr('040894',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040908' where substr('040908',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040916' where substr('040916',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040924' where substr('040924',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040932' where substr('040932',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040940' where substr('040940',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040959' where substr('040959',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040967' where substr('040967',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040975' where substr('040975',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040983' where substr('040983',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '040991' where substr('040991',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041009' where substr('041009',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041017' where substr('041017',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041025' where substr('041025',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041033' where substr('041033',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041041' where substr('041041',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041050' where substr('041050',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041068' where substr('041068',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041076' where substr('041076',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041084' where substr('041084',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041092' where substr('041092',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041106' where substr('041106',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041114' where substr('041114',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041122' where substr('041122',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041130' where substr('041130',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041149' where substr('041149',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041157' where substr('041157',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041165' where substr('041165',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041173' where substr('041173',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041181' where substr('041181',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041190' where substr('041190',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041203' where substr('041203',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041211' where substr('041211',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041220' where substr('041220',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041238' where substr('041238',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041246' where substr('041246',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041254' where substr('041254',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041262' where substr('041262',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041270' where substr('041270',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041289' where substr('041289',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041297' where substr('041297',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041300' where substr('041300',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041319' where substr('041319',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041327' where substr('041327',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041335' where substr('041335',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041343' where substr('041343',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041351' where substr('041351',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041360' where substr('041360',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041378' where substr('041378',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041378' where substr('041378',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041386' where substr('041386',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041394' where substr('041394',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041408' where substr('041408',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041416' where substr('041416',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041424' where substr('041424',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041432' where substr('041432',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041440' where substr('041440',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041459' where substr('041459',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041467' where substr('041467',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041475' where substr('041475',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041483' where substr('041483',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041491' where substr('041491',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041505' where substr('041505',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041513' where substr('041513',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041521' where substr('041521',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041530' where substr('041530',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041548' where substr('041548',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041556' where substr('041556',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041564' where substr('041564',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041572' where substr('041572',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041580' where substr('041580',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041599' where substr('041599',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041602' where substr('041602',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041610' where substr('041610',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041629' where substr('041629',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041637' where substr('041637',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041645' where substr('041645',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041653' where substr('041653',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041661' where substr('041661',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041670' where substr('041670',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041688' where substr('041688',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041696' where substr('041696',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041700' where substr('041700',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041718' where substr('041718',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041726' where substr('041726',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041734' where substr('041734',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041742' where substr('041742',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041750' where substr('041750',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041769' where substr('041769',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041777' where substr('041777',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041785' where substr('041785',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041793' where substr('041793',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041807' where substr('041807',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041815' where substr('041815',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041823' where substr('041823',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041831' where substr('041831',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041840' where substr('041840',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041858' where substr('041858',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041866' where substr('041866',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041874' where substr('041874',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041882' where substr('041882',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041890' where substr('041890',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041904' where substr('041904',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041912' where substr('041912',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041920' where substr('041920',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041939' where substr('041939',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041947' where substr('041947',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041955' where substr('041955',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041963' where substr('041963',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041971' where substr('041971',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041980' where substr('041980',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '041998' where substr('041998',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042005' where substr('042005',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042013' where substr('042013',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042021' where substr('042021',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042030' where substr('042030',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042048' where substr('042048',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042056' where substr('042056',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042064' where substr('042064',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042072' where substr('042072',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042080' where substr('042080',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042099' where substr('042099',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042102' where substr('042102',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042110' where substr('042110',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042129' where substr('042129',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042137' where substr('042137',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042145' where substr('042145',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042153' where substr('042153',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042161' where substr('042161',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042170' where substr('042170',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042188' where substr('042188',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042196' where substr('042196',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042200' where substr('042200',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042218' where substr('042218',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042226' where substr('042226',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042234' where substr('042234',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042242' where substr('042242',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042250' where substr('042250',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042269' where substr('042269',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042277' where substr('042277',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042285' where substr('042285',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042293' where substr('042293',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042307' where substr('042307',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042315' where substr('042315',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042323' where substr('042323',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042331' where substr('042331',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042340' where substr('042340',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042358' where substr('042358',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042366' where substr('042366',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042374' where substr('042374',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042382' where substr('042382',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042390' where substr('042390',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042404' where substr('042404',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042412' where substr('042412',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042420' where substr('042420',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042439' where substr('042439',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042447' where substr('042447',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042455' where substr('042455',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042463' where substr('042463',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042471' where substr('042471',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042480' where substr('042480',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042498' where substr('042498',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042501' where substr('042501',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042510' where substr('042510',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042528' where substr('042528',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042536' where substr('042536',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042544' where substr('042544',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042552' where substr('042552',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042560' where substr('042560',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042579' where substr('042579',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042587' where substr('042587',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042595' where substr('042595',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042609' where substr('042609',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042617' where substr('042617',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042625' where substr('042625',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042633' where substr('042633',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042641' where substr('042641',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042650' where substr('042650',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042668' where substr('042668',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042676' where substr('042676',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042684' where substr('042684',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042692' where substr('042692',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042706' where substr('042706',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042714' where substr('042714',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042722' where substr('042722',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042730' where substr('042730',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042749' where substr('042749',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042757' where substr('042757',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042765' where substr('042765',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042773' where substr('042773',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042781' where substr('042781',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042790' where substr('042790',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042803' where substr('042803',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042811' where substr('042811',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042820' where substr('042820',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042838' where substr('042838',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042846' where substr('042846',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042854' where substr('042854',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042862' where substr('042862',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042870' where substr('042870',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042889' where substr('042889',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042897' where substr('042897',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042900' where substr('042900',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042919' where substr('042919',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042927' where substr('042927',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042935' where substr('042935',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042943' where substr('042943',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042951' where substr('042951',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042960' where substr('042960',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042978' where substr('042978',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042986' where substr('042986',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '042994' where substr('042994',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043001' where substr('043001',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043010' where substr('043010',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043028' where substr('043028',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043036' where substr('043036',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043044' where substr('043044',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043052' where substr('043052',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043060' where substr('043060',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043079' where substr('043079',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043087' where substr('043087',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043095' where substr('043095',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043109' where substr('043109',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043117' where substr('043117',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043125' where substr('043125',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043133' where substr('043133',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043141' where substr('043141',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043150' where substr('043150',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043168' where substr('043168',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043176' where substr('043176',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043184' where substr('043184',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043192' where substr('043192',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043206' where substr('043206',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043214' where substr('043214',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043222' where substr('043222',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043230' where substr('043230',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043249' where substr('043249',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043257' where substr('043257',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043265' where substr('043265',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043273' where substr('043273',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043281' where substr('043281',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043290' where substr('043290',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043303' where substr('043303',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043311' where substr('043311',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043320' where substr('043320',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043338' where substr('043338',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043346' where substr('043346',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043354' where substr('043354',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043362' where substr('043362',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043370' where substr('043370',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043389' where substr('043389',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043397' where substr('043397',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043400' where substr('043400',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043419' where substr('043419',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043419' where substr('043419',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043427' where substr('043427',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043443' where substr('043443',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043451' where substr('043451',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043460' where substr('043460',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043478' where substr('043478',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043486' where substr('043486',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043494' where substr('043494',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043508' where substr('043508',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043516' where substr('043516',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043524' where substr('043524',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043532' where substr('043532',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043540' where substr('043540',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043559' where substr('043559',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043567' where substr('043567',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043575' where substr('043575',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043583' where substr('043583',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043591' where substr('043591',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043605' where substr('043605',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043613' where substr('043613',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043621' where substr('043621',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043630' where substr('043630',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043648' where substr('043648',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043656' where substr('043656',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043664' where substr('043664',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043672' where substr('043672',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043680' where substr('043680',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043699' where substr('043699',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043702' where substr('043702',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043710' where substr('043710',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043729' where substr('043729',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043737' where substr('043737',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043745' where substr('043745',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043753' where substr('043753',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043761' where substr('043761',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043770' where substr('043770',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043788' where substr('043788',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043796' where substr('043796',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043800' where substr('043800',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043818' where substr('043818',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043826' where substr('043826',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043834' where substr('043834',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043842' where substr('043842',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043850' where substr('043850',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043869' where substr('043869',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043877' where substr('043877',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043885' where substr('043885',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043893' where substr('043893',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043907' where substr('043907',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043915' where substr('043915',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043923' where substr('043923',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043931' where substr('043931',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043940' where substr('043940',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043958' where substr('043958',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043966' where substr('043966',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043974' where substr('043974',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043982' where substr('043982',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '043990' where substr('043990',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044008' where substr('044008',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044016' where substr('044016',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044024' where substr('044024',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044032' where substr('044032',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044040' where substr('044040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044059' where substr('044059',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044067' where substr('044067',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044075' where substr('044075',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044083' where substr('044083',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044091' where substr('044091',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044105' where substr('044105',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044113' where substr('044113',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044121' where substr('044121',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044130' where substr('044130',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044148' where substr('044148',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044156' where substr('044156',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044164' where substr('044164',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044172' where substr('044172',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '044180' where substr('044180',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050016' where substr('050016',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050024' where substr('050024',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050032' where substr('050032',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050040' where substr('050040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050059' where substr('050059',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050067' where substr('050067',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050075' where substr('050075',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050083' where substr('050083',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050091' where substr('050091',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050105' where substr('050105',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050113' where substr('050113',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050121' where substr('050121',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050130' where substr('050130',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050148' where substr('050148',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050156' where substr('050156',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050164' where substr('050164',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050172' where substr('050172',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050180' where substr('050180',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050199' where substr('050199',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050202' where substr('050202',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050210' where substr('050210',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050229' where substr('050229',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050237' where substr('050237',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050245' where substr('050245',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050253' where substr('050253',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050261' where substr('050261',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050270' where substr('050270',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050288' where substr('050288',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050296' where substr('050296',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050300' where substr('050300',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050318' where substr('050318',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050326' where substr('050326',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050334' where substr('050334',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050342' where substr('050342',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050350' where substr('050350',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050369' where substr('050369',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050377' where substr('050377',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050385' where substr('050385',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050393' where substr('050393',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050415' where substr('050415',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050423' where substr('050423',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050431' where substr('050431',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050440' where substr('050440',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050458' where substr('050458',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050466' where substr('050466',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050474' where substr('050474',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050482' where substr('050482',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050490' where substr('050490',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050504' where substr('050504',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050512' where substr('050512',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050520' where substr('050520',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050539' where substr('050539',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050547' where substr('050547',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050555' where substr('050555',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050563' where substr('050563',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050571' where substr('050571',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050580' where substr('050580',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050598' where substr('050598',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050601' where substr('050601',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050610' where substr('050610',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050628' where substr('050628',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050636' where substr('050636',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050644' where substr('050644',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050652' where substr('050652',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050660' where substr('050660',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050679' where substr('050679',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050687' where substr('050687',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050695' where substr('050695',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050709' where substr('050709',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050717' where substr('050717',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050725' where substr('050725',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050733' where substr('050733',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050741' where substr('050741',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050750' where substr('050750',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050768' where substr('050768',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050776' where substr('050776',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050784' where substr('050784',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050792' where substr('050792',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050806' where substr('050806',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050814' where substr('050814',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050822' where substr('050822',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050830' where substr('050830',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050849' where substr('050849',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050857' where substr('050857',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050865' where substr('050865',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050873' where substr('050873',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050881' where substr('050881',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050890' where substr('050890',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050903' where substr('050903',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050911' where substr('050911',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050920' where substr('050920',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050938' where substr('050938',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050946' where substr('050946',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050954' where substr('050954',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050962' where substr('050962',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050970' where substr('050970',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050989' where substr('050989',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '050997' where substr('050997',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051004' where substr('051004',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051012' where substr('051012',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051020' where substr('051020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051039' where substr('051039',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051047' where substr('051047',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051055' where substr('051055',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051063' where substr('051063',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051071' where substr('051071',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051080' where substr('051080',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051098' where substr('051098',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051101' where substr('051101',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051110' where substr('051110',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051128' where substr('051128',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051136' where substr('051136',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051144' where substr('051144',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051152' where substr('051152',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051160' where substr('051160',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051179' where substr('051179',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051187' where substr('051187',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051195' where substr('051195',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051209' where substr('051209',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051217' where substr('051217',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051225' where substr('051225',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051233' where substr('051233',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051241' where substr('051241',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051250' where substr('051250',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051268' where substr('051268',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051276' where substr('051276',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051284' where substr('051284',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051292' where substr('051292',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051306' where substr('051306',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051314' where substr('051314',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051322' where substr('051322',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051330' where substr('051330',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051349' where substr('051349',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051357' where substr('051357',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051365' where substr('051365',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051373' where substr('051373',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051381' where substr('051381',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051390' where substr('051390',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051403' where substr('051403',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051411' where substr('051411',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051420' where substr('051420',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051454' where substr('051454',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051462' where substr('051462',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051470' where substr('051470',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051489' where substr('051489',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051497' where substr('051497',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051500' where substr('051500',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051519' where substr('051519',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051527' where substr('051527',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051535' where substr('051535',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051543' where substr('051543',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051551' where substr('051551',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051560' where substr('051560',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051578' where substr('051578',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051586' where substr('051586',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051594' where substr('051594',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051608' where substr('051608',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051616' where substr('051616',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051624' where substr('051624',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051632' where substr('051632',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051640' where substr('051640',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051659' where substr('051659',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051667' where substr('051667',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051675' where substr('051675',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051683' where substr('051683',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051691' where substr('051691',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051705' where substr('051705',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051713' where substr('051713',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051721' where substr('051721',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051730' where substr('051730',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051748' where substr('051748',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051756' where substr('051756',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051764' where substr('051764',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051772' where substr('051772',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051780' where substr('051780',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051799' where substr('051799',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051802' where substr('051802',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051810' where substr('051810',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051829' where substr('051829',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051837' where substr('051837',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051845' where substr('051845',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051853' where substr('051853',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051861' where substr('051861',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '051870' where substr('051870',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060020' where substr('060020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060062' where substr('060062',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060070' where substr('060070',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060089' where substr('060089',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060097' where substr('060097',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060100' where substr('060100',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060119' where substr('060119',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060151' where substr('060151',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060194' where substr('060194',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060216' where substr('060216',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060224' where substr('060224',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060232' where substr('060232',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060259' where substr('060259',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060267' where substr('060267',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060275' where substr('060275',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060283' where substr('060283',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060291' where substr('060291',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060313' where substr('060313',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060321' where substr('060321',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060330' where substr('060330',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060372' where substr('060372',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060380' where substr('060380',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060402' where substr('060402',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060410' where substr('060410',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060437' where substr('060437',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060445' where substr('060445',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060453' where substr('060453',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060470' where substr('060470',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060496' where substr('060496',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060500' where substr('060500',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060518' where substr('060518',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060526' where substr('060526',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060542' where substr('060542',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060569' where substr('060569',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060577' where substr('060577',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060585' where substr('060585',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060623' where substr('060623',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060631' where substr('060631',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060640' where substr('060640',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060666' where substr('060666',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060690' where substr('060690',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060712' where substr('060712',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060720' where substr('060720',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060739' where substr('060739',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060747' where substr('060747',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060755' where substr('060755',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060798' where substr('060798',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060801' where substr('060801',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060836' where substr('060836',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060836' where substr('060836',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060852' where substr('060852',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060860' where substr('060860',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060879' where substr('060879',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060887' where substr('060887',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '060909' where substr('060909',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061123' where substr('061123',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061131' where substr('061131',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061140' where substr('061140',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061158' where substr('061158',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061166' where substr('061166',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061174' where substr('061174',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061182' where substr('061182',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061190' where substr('061190',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061204' where substr('061204',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061212' where substr('061212',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061220' where substr('061220',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061239' where substr('061239',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061247' where substr('061247',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061255' where substr('061255',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061263' where substr('061263',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061271' where substr('061271',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061280' where substr('061280',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061298' where substr('061298',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061301' where substr('061301',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061310' where substr('061310',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061328' where substr('061328',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061336' where substr('061336',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '061344' where substr('061344',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070017' where substr('070017',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070025' where substr('070025',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070033' where substr('070033',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070041' where substr('070041',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070050' where substr('070050',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070068' where substr('070068',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070076' where substr('070076',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070084' where substr('070084',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070092' where substr('070092',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070106' where substr('070106',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070114' where substr('070114',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070122' where substr('070122',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070130' where substr('070130',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070149' where substr('070149',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070157' where substr('070157',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070165' where substr('070165',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070173' where substr('070173',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070181' where substr('070181',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070190' where substr('070190',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070203' where substr('070203',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070211' where substr('070211',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070220' where substr('070220',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070238' where substr('070238',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070246' where substr('070246',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070254' where substr('070254',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070262' where substr('070262',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070270' where substr('070270',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070289' where substr('070289',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070297' where substr('070297',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070300' where substr('070300',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070319' where substr('070319',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070327' where substr('070327',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070335' where substr('070335',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070343' where substr('070343',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070351' where substr('070351',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070360' where substr('070360',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070378' where substr('070378',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070386' where substr('070386',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070394' where substr('070394',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070408' where substr('070408',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070416' where substr('070416',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070424' where substr('070424',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070432' where substr('070432',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070440' where substr('070440',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070459' where substr('070459',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070467' where substr('070467',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070475' where substr('070475',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070483' where substr('070483',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070491' where substr('070491',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070505' where substr('070505',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070513' where substr('070513',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070521' where substr('070521',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070530' where substr('070530',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070530' where substr('070530',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070548' where substr('070548',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070556' where substr('070556',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070564' where substr('070564',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070572' where substr('070572',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070580' where substr('070580',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070599' where substr('070599',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070602' where substr('070602',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070610' where substr('070610',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070629' where substr('070629',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070637' where substr('070637',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070645' where substr('070645',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070653' where substr('070653',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070661' where substr('070661',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070670' where substr('070670',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070688' where substr('070688',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070696' where substr('070696',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070700' where substr('070700',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070718' where substr('070718',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070726' where substr('070726',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070734' where substr('070734',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070742' where substr('070742',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070750' where substr('070750',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070769' where substr('070769',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070777' where substr('070777',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '070785' where substr('070785',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080012' where substr('080012',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080020' where substr('080020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080039' where substr('080039',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080055' where substr('080055',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080063' where substr('080063',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080080' where substr('080080',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080098' where substr('080098',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080110' where substr('080110',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080110' where substr('080110',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080128' where substr('080128',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080136' where substr('080136',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080144' where substr('080144',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080144' where substr('080144',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080152' where substr('080152',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080160' where substr('080160',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080179' where substr('080179',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080187' where substr('080187',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080250' where substr('080250',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080268' where substr('080268',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080284' where substr('080284',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080314' where substr('080314',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080322' where substr('080322',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080330' where substr('080330',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080349' where substr('080349',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080357' where substr('080357',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080365' where substr('080365',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080381' where substr('080381',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080390' where substr('080390',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080403' where substr('080403',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080411' where substr('080411',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080420' where substr('080420',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080438' where substr('080438',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080446' where substr('080446',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080454' where substr('080454',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080462' where substr('080462',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080470' where substr('080470',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080489' where substr('080489',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080497' where substr('080497',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080500' where substr('080500',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080519' where substr('080519',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080519' where substr('080519',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080527' where substr('080527',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080535' where substr('080535',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080543' where substr('080543',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080551' where substr('080551',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080586' where substr('080586',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080594' where substr('080594',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080608' where substr('080608',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080632' where substr('080632',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080640' where substr('080640',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080659' where substr('080659',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080667' where substr('080667',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080675' where substr('080675',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080683' where substr('080683',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080691' where substr('080691',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080705' where substr('080705',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080721' where substr('080721',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080756' where substr('080756',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080764' where substr('080764',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080772' where substr('080772',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080799' where substr('080799',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080802' where substr('080802',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080810' where substr('080810',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080829' where substr('080829',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080845' where substr('080845',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080853' where substr('080853',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080861' where substr('080861',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080870' where substr('080870',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080870' where substr('080870',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080888' where substr('080888',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080896' where substr('080896',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080900' where substr('080900',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080918' where substr('080918',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080926' where substr('080926',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080942' where substr('080942',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080950' where substr('080950',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080969' where substr('080969',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080977' where substr('080977',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080985' where substr('080985',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '080993' where substr('080993',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081000' where substr('081000',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081019' where substr('081019',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081027' where substr('081027',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081043' where substr('081043',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081060' where substr('081060',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081078' where substr('081078',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081086' where substr('081086',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081108' where substr('081108',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081116' where substr('081116',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081124' where substr('081124',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081132' where substr('081132',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081140' where substr('081140',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081159' where substr('081159',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081167' where substr('081167',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081175' where substr('081175',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081183' where substr('081183',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081191' where substr('081191',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081205' where substr('081205',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081221' where substr('081221',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081230' where substr('081230',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081248' where substr('081248',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081256' where substr('081256',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081264' where substr('081264',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081272' where substr('081272',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081280' where substr('081280',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081299' where substr('081299',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081302' where substr('081302',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081337' where substr('081337',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081345' where substr('081345',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081361' where substr('081361',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081370' where substr('081370',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081388' where substr('081388',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081396' where substr('081396',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081400' where substr('081400',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081434' where substr('081434',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081442' where substr('081442',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081450' where substr('081450',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081469' where substr('081469',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081477' where substr('081477',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081485' where substr('081485',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081493' where substr('081493',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081515' where substr('081515',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081523' where substr('081523',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081531' where substr('081531',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081540' where substr('081540',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081558' where substr('081558',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081566' where substr('081566',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081574' where substr('081574',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081582' where substr('081582',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081590' where substr('081590',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081620' where substr('081620',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081663' where substr('081663',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081680' where substr('081680',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081701' where substr('081701',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081710' where substr('081710',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081728' where substr('081728',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081736' where substr('081736',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081752' where substr('081752',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081787' where substr('081787',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081795' where substr('081795',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081817' where substr('081817',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081825' where substr('081825',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081833' where substr('081833',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081841' where substr('081841',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081868' where substr('081868',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081876' where substr('081876',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081884' where substr('081884',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081892' where substr('081892',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081906' where substr('081906',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081914' where substr('081914',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081922' where substr('081922',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081930' where substr('081930',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081949' where substr('081949',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081957' where substr('081957',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081965' where substr('081965',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081973' where substr('081973',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081981' where substr('081981',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '081990' where substr('081990',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082007' where substr('082007',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082015' where substr('082015',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082031' where substr('082031',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082040' where substr('082040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082058' where substr('082058',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082066' where substr('082066',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082090' where substr('082090',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082120' where substr('082120',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082139' where substr('082139',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082163' where substr('082163',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082171' where substr('082171',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082180' where substr('082180',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082198' where substr('082198',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082201' where substr('082201',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082210' where substr('082210',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082236' where substr('082236',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082244' where substr('082244',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082252' where substr('082252',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082279' where substr('082279',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082287' where substr('082287',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082295' where substr('082295',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082333' where substr('082333',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082350' where substr('082350',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082368' where substr('082368',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082376' where substr('082376',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082392' where substr('082392',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082406' where substr('082406',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082422' where substr('082422',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082449' where substr('082449',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082457' where substr('082457',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082465' where substr('082465',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082473' where substr('082473',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082520' where substr('082520',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082546' where substr('082546',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082562' where substr('082562',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082570' where substr('082570',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082600' where substr('082600',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082619' where substr('082619',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082635' where substr('082635',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082643' where substr('082643',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082660' where substr('082660',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082678' where substr('082678',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082686' where substr('082686',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082694' where substr('082694',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082708' where substr('082708',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082732' where substr('082732',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082740' where substr('082740',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082791' where substr('082791',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082821' where substr('082821',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082830' where substr('082830',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082848' where substr('082848',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082864' where substr('082864',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082872' where substr('082872',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082899' where substr('082899',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082902' where substr('082902',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082910' where substr('082910',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082929' where substr('082929',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082937' where substr('082937',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082945' where substr('082945',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082953' where substr('082953',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082961' where substr('082961',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082970' where substr('082970',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082988' where substr('082988',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '082996' where substr('082996',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083003' where substr('083003',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083011' where substr('083011',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083020' where substr('083020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083038' where substr('083038',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083046' where substr('083046',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083054' where substr('083054',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083062' where substr('083062',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083070' where substr('083070',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083089' where substr('083089',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083097' where substr('083097',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083100' where substr('083100',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083119' where substr('083119',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083127' where substr('083127',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083135' where substr('083135',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083143' where substr('083143',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083151' where substr('083151',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083160' where substr('083160',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083178' where substr('083178',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083186' where substr('083186',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083194' where substr('083194',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083208' where substr('083208',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083216' where substr('083216',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083224' where substr('083224',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083232' where substr('083232',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083240' where substr('083240',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083259' where substr('083259',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083267' where substr('083267',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '083275' where substr('083275',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090018' where substr('090018',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090026' where substr('090026',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090034' where substr('090034',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090042' where substr('090042',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090050' where substr('090050',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090069' where substr('090069',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090077' where substr('090077',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090085' where substr('090085',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090093' where substr('090093',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090107' where substr('090107',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090115' where substr('090115',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090123' where substr('090123',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090131' where substr('090131',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090140' where substr('090140',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090158' where substr('090158',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090166' where substr('090166',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090174' where substr('090174',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090182' where substr('090182',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090190' where substr('090190',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090204' where substr('090204',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090212' where substr('090212',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090220' where substr('090220',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090239' where substr('090239',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090247' where substr('090247',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090255' where substr('090255',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090263' where substr('090263',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090271' where substr('090271',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090280' where substr('090280',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090298' where substr('090298',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090301' where substr('090301',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090310' where substr('090310',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090328' where substr('090328',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090336' where substr('090336',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090344' where substr('090344',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090352' where substr('090352',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090360' where substr('090360',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090379' where substr('090379',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090387' where substr('090387',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090395' where substr('090395',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090409' where substr('090409',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090417' where substr('090417',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090425' where substr('090425',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090433' where substr('090433',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090441' where substr('090441',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090450' where substr('090450',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090468' where substr('090468',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090476' where substr('090476',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090484' where substr('090484',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090492' where substr('090492',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090506' where substr('090506',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090514' where substr('090514',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090522' where substr('090522',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090530' where substr('090530',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090549' where substr('090549',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090557' where substr('090557',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090565' where substr('090565',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090573' where substr('090573',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090581' where substr('090581',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090590' where substr('090590',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090603' where substr('090603',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090611' where substr('090611',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090620' where substr('090620',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090638' where substr('090638',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090646' where substr('090646',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090654' where substr('090654',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090662' where substr('090662',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090670' where substr('090670',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090689' where substr('090689',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090697' where substr('090697',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090700' where substr('090700',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090719' where substr('090719',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090727' where substr('090727',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090735' where substr('090735',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090743' where substr('090743',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090751' where substr('090751',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090760' where substr('090760',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090778' where substr('090778',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090786' where substr('090786',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090794' where substr('090794',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090808' where substr('090808',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090816' where substr('090816',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090824' where substr('090824',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090832' where substr('090832',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090840' where substr('090840',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090859' where substr('090859',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090867' where substr('090867',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090875' where substr('090875',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090883' where substr('090883',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090891' where substr('090891',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090905' where substr('090905',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090913' where substr('090913',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090921' where substr('090921',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090930' where substr('090930',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090948' where substr('090948',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090956' where substr('090956',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090964' where substr('090964',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090972' where substr('090972',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090980' where substr('090980',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '090999' where substr('090999',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091006' where substr('091006',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091014' where substr('091014',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091022' where substr('091022',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091030' where substr('091030',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091049' where substr('091049',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091057' where substr('091057',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091065' where substr('091065',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091073' where substr('091073',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091081' where substr('091081',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091090' where substr('091090',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091103' where substr('091103',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091111' where substr('091111',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091120' where substr('091120',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091138' where substr('091138',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091146' where substr('091146',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091154' where substr('091154',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091162' where substr('091162',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091170' where substr('091170',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091189' where substr('091189',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091197' where substr('091197',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091200' where substr('091200',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091219' where substr('091219',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091227' where substr('091227',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091235' where substr('091235',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091243' where substr('091243',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091251' where substr('091251',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091260' where substr('091260',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091278' where substr('091278',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091286' where substr('091286',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091294' where substr('091294',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091308' where substr('091308',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091316' where substr('091316',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091324' where substr('091324',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091332' where substr('091332',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091340' where substr('091340',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091359' where substr('091359',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091367' where substr('091367',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091375' where substr('091375',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091383' where substr('091383',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091391' where substr('091391',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091413' where substr('091413',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091421' where substr('091421',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091430' where substr('091430',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091456' where substr('091456',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091464' where substr('091464',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091480' where substr('091480',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091499' where substr('091499',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091502' where substr('091502',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091510' where substr('091510',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091529' where substr('091529',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091537' where substr('091537',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091553' where substr('091553',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091561' where substr('091561',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091570' where substr('091570',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091588' where substr('091588',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091596' where substr('091596',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091600' where substr('091600',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091618' where substr('091618',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091634' where substr('091634',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091669' where substr('091669',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091685' where substr('091685',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091693' where substr('091693',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091707' where substr('091707',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091715' where substr('091715',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091723' where substr('091723',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091740' where substr('091740',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091758' where substr('091758',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091766' where substr('091766',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091774' where substr('091774',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091782' where substr('091782',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091790' where substr('091790',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091804' where substr('091804',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091820' where substr('091820',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091839' where substr('091839',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091847' where substr('091847',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091863' where substr('091863',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091871' where substr('091871',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091880' where substr('091880',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091898' where substr('091898',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091901' where substr('091901',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091910' where substr('091910',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091936' where substr('091936',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091944' where substr('091944',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091952' where substr('091952',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091979' where substr('091979',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091987' where substr('091987',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '091995' where substr('091995',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '092002' where substr('092002',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '092029' where substr('092029',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '092037' where substr('092037',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '092053' where substr('092053',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '092061' where substr('092061',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '092088' where substr('092088',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '092096' where substr('092096',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '092100' where substr('092100',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '092118' where substr('092118',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '092126' where substr('092126',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '092134' where substr('092134',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '092142' where substr('092142',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '092150' where substr('092150',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '092169' where substr('092169',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '092177' where substr('092177',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100013' where substr('100013',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100030' where substr('100030',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100048' where substr('100048',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100056' where substr('100056',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100129' where substr('100129',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100137' where substr('100137',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100145' where substr('100145',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100161' where substr('100161',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100170' where substr('100170',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100188' where substr('100188',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100242' where substr('100242',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100307' where substr('100307',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100340' where substr('100340',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100340' where substr('100340',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100358' where substr('100358',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100366' where substr('100366',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100390' where substr('100390',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100420' where substr('100420',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100463' where substr('100463',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100480' where substr('100480',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100536' where substr('100536',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100552' where substr('100552',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100595' where substr('100595',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100609' where substr('100609',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100617' where substr('100617',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100650' where substr('100650',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100676' where substr('100676',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100684' where substr('100684',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100765' where substr('100765',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100773' where substr('100773',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100781' where substr('100781',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100811' where substr('100811',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100820' where substr('100820',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100846' where substr('100846',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100897' where substr('100897',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100919' where substr('100919',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100927' where substr('100927',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100935' where substr('100935',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100951' where substr('100951',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100960' where substr('100960',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100978' where substr('100978',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100986' where substr('100986',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '100994' where substr('100994',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101001' where substr('101001',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101010' where substr('101010',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101028' where substr('101028',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101036' where substr('101036',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101044' where substr('101044',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101052' where substr('101052',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101060' where substr('101060',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101079' where substr('101079',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101087' where substr('101087',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101095' where substr('101095',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101109' where substr('101109',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101117' where substr('101117',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101214' where substr('101214',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101222' where substr('101222',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101230' where substr('101230',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101249' where substr('101249',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101257' where substr('101257',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101265' where substr('101265',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101273' where substr('101273',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101281' where substr('101281',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101290' where substr('101290',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101303' where substr('101303',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101311' where substr('101311',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101320' where substr('101320',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101338' where substr('101338',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101346' where substr('101346',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101354' where substr('101354',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101362' where substr('101362',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101370' where substr('101370',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101389' where substr('101389',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101397' where substr('101397',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101400' where substr('101400',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101419' where substr('101419',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101427' where substr('101427',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101435' where substr('101435',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101443' where substr('101443',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101451' where substr('101451',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101460' where substr('101460',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101478' where substr('101478',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101486' where substr('101486',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101494' where substr('101494',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101508' where substr('101508',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101516' where substr('101516',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101524' where substr('101524',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101532' where substr('101532',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101540' where substr('101540',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101559' where substr('101559',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101567' where substr('101567',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101575' where substr('101575',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101583' where substr('101583',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101591' where substr('101591',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101605' where substr('101605',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101613' where substr('101613',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101621' where substr('101621',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101630' where substr('101630',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101648' where substr('101648',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101656' where substr('101656',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101664' where substr('101664',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101672' where substr('101672',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101680' where substr('101680',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101699' where substr('101699',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101702' where substr('101702',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101710' where substr('101710',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101729' where substr('101729',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101737' where substr('101737',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101745' where substr('101745',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101753' where substr('101753',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101761' where substr('101761',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101770' where substr('101770',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101788' where substr('101788',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101796' where substr('101796',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101800' where substr('101800',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101818' where substr('101818',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101826' where substr('101826',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101834' where substr('101834',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101842' where substr('101842',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101850' where substr('101850',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101869' where substr('101869',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101877' where substr('101877',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101885' where substr('101885',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101893' where substr('101893',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101907' where substr('101907',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101915' where substr('101915',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101923' where substr('101923',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101931' where substr('101931',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101940' where substr('101940',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101958' where substr('101958',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101966' where substr('101966',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101974' where substr('101974',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101982' where substr('101982',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '101990' where substr('101990',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '102008' where substr('102008',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '102016' where substr('102016',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '102024' where substr('102024',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '102032' where substr('102032',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '102040' where substr('102040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '102059' where substr('102059',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '102067' where substr('102067',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110019' where substr('110019',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110027' where substr('110027',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110035' where substr('110035',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110043' where substr('110043',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110051' where substr('110051',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110060' where substr('110060',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110078' where substr('110078',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110086' where substr('110086',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110094' where substr('110094',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110108' where substr('110108',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110116' where substr('110116',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110124' where substr('110124',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110132' where substr('110132',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110140' where substr('110140',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110159' where substr('110159',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110167' where substr('110167',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110175' where substr('110175',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110183' where substr('110183',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110191' where substr('110191',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110205' where substr('110205',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110213' where substr('110213',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110221' where substr('110221',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110230' where substr('110230',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110248' where substr('110248',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110256' where substr('110256',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110264' where substr('110264',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110272' where substr('110272',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110280' where substr('110280',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110299' where substr('110299',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110302' where substr('110302',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110310' where substr('110310',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110329' where substr('110329',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110337' where substr('110337',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110345' where substr('110345',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110353' where substr('110353',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110361' where substr('110361',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110370' where substr('110370',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110388' where substr('110388',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110396' where substr('110396',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110400' where substr('110400',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110418' where substr('110418',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110426' where substr('110426',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110434' where substr('110434',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110442' where substr('110442',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110450' where substr('110450',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110469' where substr('110469',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110477' where substr('110477',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110485' where substr('110485',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110493' where substr('110493',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110507' where substr('110507',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110515' where substr('110515',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110523' where substr('110523',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110531' where substr('110531',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110540' where substr('110540',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110558' where substr('110558',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110566' where substr('110566',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110574' where substr('110574',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110582' where substr('110582',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110590' where substr('110590',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110604' where substr('110604',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110612' where substr('110612',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110620' where substr('110620',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110639' where substr('110639',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110647' where substr('110647',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110655' where substr('110655',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110663' where substr('110663',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110671' where substr('110671',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110680' where substr('110680',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110698' where substr('110698',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110701' where substr('110701',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110710' where substr('110710',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110728' where substr('110728',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110736' where substr('110736',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110744' where substr('110744',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110752' where substr('110752',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110760' where substr('110760',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110779' where substr('110779',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110787' where substr('110787',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110795' where substr('110795',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110809' where substr('110809',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110817' where substr('110817',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110825' where substr('110825',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110833' where substr('110833',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110841' where substr('110841',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110850' where substr('110850',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110868' where substr('110868',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110876' where substr('110876',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110884' where substr('110884',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110892' where substr('110892',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110906' where substr('110906',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110914' where substr('110914',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110922' where substr('110922',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110930' where substr('110930',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110949' where substr('110949',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110957' where substr('110957',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110965' where substr('110965',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110973' where substr('110973',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110981' where substr('110981',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '110990' where substr('110990',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111007' where substr('111007',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111015' where substr('111015',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111023' where substr('111023',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111031' where substr('111031',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111040' where substr('111040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111058' where substr('111058',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111066' where substr('111066',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111074' where substr('111074',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111082' where substr('111082',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111090' where substr('111090',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111104' where substr('111104',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111112' where substr('111112',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111120' where substr('111120',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111139' where substr('111139',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111147' where substr('111147',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111155' where substr('111155',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111163' where substr('111163',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111171' where substr('111171',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111180' where substr('111180',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111198' where substr('111198',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111201' where substr('111201',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111210' where substr('111210',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111228' where substr('111228',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111236' where substr('111236',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111244' where substr('111244',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111252' where substr('111252',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111260' where substr('111260',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111279' where substr('111279',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111287' where substr('111287',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111295' where substr('111295',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111309' where substr('111309',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111317' where substr('111317',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111325' where substr('111325',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111333' where substr('111333',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111341' where substr('111341',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111350' where substr('111350',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111368' where substr('111368',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111376' where substr('111376',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111384' where substr('111384',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111392' where substr('111392',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111406' where substr('111406',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111414' where substr('111414',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111422' where substr('111422',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111430' where substr('111430',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111449' where substr('111449',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111457' where substr('111457',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111465' where substr('111465',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111473' where substr('111473',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111481' where substr('111481',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111490' where substr('111490',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111503' where substr('111503',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111511' where substr('111511',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111520' where substr('111520',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111538' where substr('111538',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111546' where substr('111546',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111554' where substr('111554',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111562' where substr('111562',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111570' where substr('111570',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111589' where substr('111589',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111597' where substr('111597',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111600' where substr('111600',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111619' where substr('111619',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111627' where substr('111627',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111635' where substr('111635',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111643' where substr('111643',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111651' where substr('111651',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111660' where substr('111660',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111678' where substr('111678',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111686' where substr('111686',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111694' where substr('111694',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111708' where substr('111708',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111716' where substr('111716',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111724' where substr('111724',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111732' where substr('111732',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111740' where substr('111740',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111759' where substr('111759',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111767' where substr('111767',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111775' where substr('111775',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111783' where substr('111783',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111791' where substr('111791',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111805' where substr('111805',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111813' where substr('111813',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111821' where substr('111821',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111830' where substr('111830',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111848' where substr('111848',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111856' where substr('111856',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111864' where substr('111864',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111872' where substr('111872',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111880' where substr('111880',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111899' where substr('111899',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111902' where substr('111902',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111910' where substr('111910',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111929' where substr('111929',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111937' where substr('111937',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111945' where substr('111945',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111953' where substr('111953',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111961' where substr('111961',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111970' where substr('111970',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111988' where substr('111988',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '111996' where substr('111996',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112003' where substr('112003',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112011' where substr('112011',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112020' where substr('112020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112038' where substr('112038',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112046' where substr('112046',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112054' where substr('112054',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112062' where substr('112062',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112070' where substr('112070',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112089' where substr('112089',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112097' where substr('112097',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112100' where substr('112100',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112119' where substr('112119',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112127' where substr('112127',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112135' where substr('112135',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112143' where substr('112143',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112151' where substr('112151',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112160' where substr('112160',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112178' where substr('112178',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112186' where substr('112186',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112194' where substr('112194',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112208' where substr('112208',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112216' where substr('112216',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112224' where substr('112224',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112232' where substr('112232',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112240' where substr('112240',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112259' where substr('112259',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112267' where substr('112267',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112275' where substr('112275',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112283' where substr('112283',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112291' where substr('112291',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112305' where substr('112305',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112313' where substr('112313',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112321' where substr('112321',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112330' where substr('112330',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112348' where substr('112348',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112356' where substr('112356',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112364' where substr('112364',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112372' where substr('112372',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112380' where substr('112380',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112399' where substr('112399',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112402' where substr('112402',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112410' where substr('112410',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112429' where substr('112429',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112437' where substr('112437',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112445' where substr('112445',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112453' where substr('112453',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112461' where substr('112461',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112470' where substr('112470',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112488' where substr('112488',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112496' where substr('112496',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112500' where substr('112500',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112518' where substr('112518',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112526' where substr('112526',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112534' where substr('112534',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112542' where substr('112542',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112550' where substr('112550',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112569' where substr('112569',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112577' where substr('112577',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112585' where substr('112585',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112593' where substr('112593',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112607' where substr('112607',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112615' where substr('112615',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112623' where substr('112623',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112631' where substr('112631',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112640' where substr('112640',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112658' where substr('112658',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112666' where substr('112666',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112674' where substr('112674',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112682' where substr('112682',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112690' where substr('112690',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112704' where substr('112704',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112712' where substr('112712',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112720' where substr('112720',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112739' where substr('112739',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112747' where substr('112747',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112755' where substr('112755',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112763' where substr('112763',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112771' where substr('112771',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112780' where substr('112780',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112798' where substr('112798',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112801' where substr('112801',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112810' where substr('112810',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112828' where substr('112828',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112836' where substr('112836',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112844' where substr('112844',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112852' where substr('112852',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112860' where substr('112860',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112879' where substr('112879',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112887' where substr('112887',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112895' where substr('112895',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112909' where substr('112909',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112917' where substr('112917',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112925' where substr('112925',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112933' where substr('112933',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112941' where substr('112941',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112950' where substr('112950',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112968' where substr('112968',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112976' where substr('112976',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112984' where substr('112984',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112984' where substr('112984',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '112992' where substr('112992',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113000' where substr('113000',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113018' where substr('113018',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113026' where substr('113026',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113034' where substr('113034',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113042' where substr('113042',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113050' where substr('113050',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113069' where substr('113069',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113077' where substr('113077',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113085' where substr('113085',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113093' where substr('113093',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113107' where substr('113107',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113115' where substr('113115',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113123' where substr('113123',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113131' where substr('113131',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113140' where substr('113140',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113158' where substr('113158',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113166' where substr('113166',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113174' where substr('113174',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113182' where substr('113182',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113190' where substr('113190',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113204' where substr('113204',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113212' where substr('113212',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113220' where substr('113220',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113239' where substr('113239',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113247' where substr('113247',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113255' where substr('113255',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113263' where substr('113263',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113271' where substr('113271',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113280' where substr('113280',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113298' where substr('113298',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113301' where substr('113301',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113310' where substr('113310',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113328' where substr('113328',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113336' where substr('113336',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113344' where substr('113344',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113352' where substr('113352',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113360' where substr('113360',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113379' where substr('113379',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113387' where substr('113387',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113395' where substr('113395',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113409' where substr('113409',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113417' where substr('113417',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113425' where substr('113425',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113433' where substr('113433',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113441' where substr('113441',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113450' where substr('113450',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113468' where substr('113468',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113476' where substr('113476',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113484' where substr('113484',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113492' where substr('113492',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113506' where substr('113506',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113514' where substr('113514',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113522' where substr('113522',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113530' where substr('113530',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113549' where substr('113549',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113557' where substr('113557',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113565' where substr('113565',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113573' where substr('113573',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113581' where substr('113581',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113590' where substr('113590',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113603' where substr('113603',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113611' where substr('113611',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113620' where substr('113620',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113638' where substr('113638',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113646' where substr('113646',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113654' where substr('113654',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113662' where substr('113662',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113670' where substr('113670',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113689' where substr('113689',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113697' where substr('113697',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113700' where substr('113700',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113719' where substr('113719',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113727' where substr('113727',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113735' where substr('113735',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113743' where substr('113743',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113751' where substr('113751',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113760' where substr('113760',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113778' where substr('113778',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113786' where substr('113786',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113794' where substr('113794',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113808' where substr('113808',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113816' where substr('113816',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113824' where substr('113824',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113832' where substr('113832',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113840' where substr('113840',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113859' where substr('113859',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113867' where substr('113867',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113875' where substr('113875',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113883' where substr('113883',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113891' where substr('113891',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113905' where substr('113905',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113913' where substr('113913',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113921' where substr('113921',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113930' where substr('113930',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113948' where substr('113948',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113956' where substr('113956',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113964' where substr('113964',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113972' where substr('113972',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113980' where substr('113980',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '113999' where substr('113999',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114006' where substr('114006',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114014' where substr('114014',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114022' where substr('114022',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114030' where substr('114030',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114049' where substr('114049',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114057' where substr('114057',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114065' where substr('114065',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114073' where substr('114073',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114081' where substr('114081',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114090' where substr('114090',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114103' where substr('114103',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114111' where substr('114111',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114120' where substr('114120',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114138' where substr('114138',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114146' where substr('114146',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114154' where substr('114154',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114162' where substr('114162',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114170' where substr('114170',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114189' where substr('114189',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114197' where substr('114197',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114200' where substr('114200',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114219' where substr('114219',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114227' where substr('114227',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114235' where substr('114235',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114243' where substr('114243',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114251' where substr('114251',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114260' where substr('114260',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114278' where substr('114278',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114286' where substr('114286',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114294' where substr('114294',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114308' where substr('114308',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114316' where substr('114316',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114324' where substr('114324',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114332' where substr('114332',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114340' where substr('114340',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114359' where substr('114359',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114367' where substr('114367',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114375' where substr('114375',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114383' where substr('114383',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114391' where substr('114391',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114405' where substr('114405',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114413' where substr('114413',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114421' where substr('114421',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114430' where substr('114430',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114448' where substr('114448',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114456' where substr('114456',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114464' where substr('114464',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114472' where substr('114472',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114480' where substr('114480',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114499' where substr('114499',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114502' where substr('114502',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114510' where substr('114510',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114529' where substr('114529',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114537' where substr('114537',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114545' where substr('114545',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114553' where substr('114553',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114561' where substr('114561',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114570' where substr('114570',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114588' where substr('114588',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114596' where substr('114596',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114600' where substr('114600',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114618' where substr('114618',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114626' where substr('114626',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114634' where substr('114634',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114642' where substr('114642',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114650' where substr('114650',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114669' where substr('114669',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114677' where substr('114677',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114685' where substr('114685',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114693' where substr('114693',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114707' where substr('114707',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114715' where substr('114715',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114723' where substr('114723',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114731' where substr('114731',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114740' where substr('114740',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114758' where substr('114758',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114766' where substr('114766',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114774' where substr('114774',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114782' where substr('114782',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114790' where substr('114790',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114804' where substr('114804',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114812' where substr('114812',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114820' where substr('114820',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114839' where substr('114839',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114847' where substr('114847',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114855' where substr('114855',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114863' where substr('114863',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114871' where substr('114871',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114880' where substr('114880',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114898' where substr('114898',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114901' where substr('114901',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114910' where substr('114910',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114928' where substr('114928',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114936' where substr('114936',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114944' where substr('114944',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114952' where substr('114952',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114960' where substr('114960',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114979' where substr('114979',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114987' where substr('114987',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '114995' where substr('114995',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115002' where substr('115002',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115010' where substr('115010',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115029' where substr('115029',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115037' where substr('115037',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115045' where substr('115045',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115053' where substr('115053',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115061' where substr('115061',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115070' where substr('115070',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115088' where substr('115088',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115096' where substr('115096',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115100' where substr('115100',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115118' where substr('115118',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115126' where substr('115126',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115134' where substr('115134',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115142' where substr('115142',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115150' where substr('115150',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115169' where substr('115169',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115177' where substr('115177',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115185' where substr('115185',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115185' where substr('115185',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115193' where substr('115193',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115207' where substr('115207',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115215' where substr('115215',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115223' where substr('115223',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115231' where substr('115231',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115240' where substr('115240',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115258' where substr('115258',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115266' where substr('115266',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115274' where substr('115274',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115282' where substr('115282',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115290' where substr('115290',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115304' where substr('115304',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115312' where substr('115312',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115320' where substr('115320',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115339' where substr('115339',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115347' where substr('115347',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115355' where substr('115355',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115363' where substr('115363',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115371' where substr('115371',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115380' where substr('115380',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115398' where substr('115398',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115401' where substr('115401',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115410' where substr('115410',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115428' where substr('115428',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115436' where substr('115436',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115444' where substr('115444',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115452' where substr('115452',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115460' where substr('115460',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115479' where substr('115479',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115487' where substr('115487',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115495' where substr('115495',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115509' where substr('115509',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115517' where substr('115517',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115525' where substr('115525',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115533' where substr('115533',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115541' where substr('115541',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115550' where substr('115550',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115568' where substr('115568',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115576' where substr('115576',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115584' where substr('115584',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115592' where substr('115592',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115606' where substr('115606',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115614' where substr('115614',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115622' where substr('115622',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115630' where substr('115630',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115649' where substr('115649',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115657' where substr('115657',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115665' where substr('115665',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115673' where substr('115673',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115681' where substr('115681',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115690' where substr('115690',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115703' where substr('115703',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115711' where substr('115711',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115720' where substr('115720',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115738' where substr('115738',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115746' where substr('115746',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115754' where substr('115754',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115762' where substr('115762',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115770' where substr('115770',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115789' where substr('115789',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115797' where substr('115797',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115800' where substr('115800',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115819' where substr('115819',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115827' where substr('115827',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115835' where substr('115835',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115843' where substr('115843',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115851' where substr('115851',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115860' where substr('115860',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115878' where substr('115878',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115886' where substr('115886',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115894' where substr('115894',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115908' where substr('115908',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115916' where substr('115916',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115924' where substr('115924',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115932' where substr('115932',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115940' where substr('115940',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115959' where substr('115959',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115967' where substr('115967',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115967' where substr('115967',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115975' where substr('115975',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115983' where substr('115983',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '115991' where substr('115991',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116009' where substr('116009',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116017' where substr('116017',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116025' where substr('116025',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116033' where substr('116033',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116041' where substr('116041',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116050' where substr('116050',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116068' where substr('116068',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116076' where substr('116076',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116084' where substr('116084',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116092' where substr('116092',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116106' where substr('116106',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116114' where substr('116114',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116122' where substr('116122',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116130' where substr('116130',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116149' where substr('116149',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116157' where substr('116157',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116165' where substr('116165',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116173' where substr('116173',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116181' where substr('116181',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116190' where substr('116190',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116203' where substr('116203',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116211' where substr('116211',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116220' where substr('116220',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116238' where substr('116238',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116246' where substr('116246',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116254' where substr('116254',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116262' where substr('116262',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116270' where substr('116270',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116289' where substr('116289',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116297' where substr('116297',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116300' where substr('116300',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116319' where substr('116319',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116327' where substr('116327',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116335' where substr('116335',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116343' where substr('116343',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116351' where substr('116351',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116360' where substr('116360',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116378' where substr('116378',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116386' where substr('116386',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116394' where substr('116394',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116408' where substr('116408',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116416' where substr('116416',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116424' where substr('116424',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116432' where substr('116432',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116440' where substr('116440',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116459' where substr('116459',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116467' where substr('116467',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116475' where substr('116475',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116483' where substr('116483',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116491' where substr('116491',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116505' where substr('116505',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116513' where substr('116513',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116521' where substr('116521',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116530' where substr('116530',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116548' where substr('116548',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116556' where substr('116556',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116564' where substr('116564',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116572' where substr('116572',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116580' where substr('116580',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116599' where substr('116599',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116602' where substr('116602',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116610' where substr('116610',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116629' where substr('116629',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116637' where substr('116637',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116645' where substr('116645',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116653' where substr('116653',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116661' where substr('116661',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116670' where substr('116670',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116688' where substr('116688',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116696' where substr('116696',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116700' where substr('116700',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116718' where substr('116718',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116726' where substr('116726',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116734' where substr('116734',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116742' where substr('116742',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116750' where substr('116750',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116769' where substr('116769',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116777' where substr('116777',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116785' where substr('116785',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116793' where substr('116793',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116807' where substr('116807',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116815' where substr('116815',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116823' where substr('116823',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116831' where substr('116831',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116840' where substr('116840',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116858' where substr('116858',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116866' where substr('116866',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116866' where substr('116866',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116874' where substr('116874',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116882' where substr('116882',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116890' where substr('116890',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116904' where substr('116904',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116912' where substr('116912',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116920' where substr('116920',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116939' where substr('116939',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116939' where substr('116939',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116947' where substr('116947',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116955' where substr('116955',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116963' where substr('116963',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116971' where substr('116971',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116980' where substr('116980',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '116998' where substr('116998',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117005' where substr('117005',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117013' where substr('117013',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117021' where substr('117021',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117030' where substr('117030',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117048' where substr('117048',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117056' where substr('117056',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117064' where substr('117064',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117072' where substr('117072',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117080' where substr('117080',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117099' where substr('117099',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117102' where substr('117102',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117110' where substr('117110',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117129' where substr('117129',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117137' where substr('117137',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117145' where substr('117145',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117153' where substr('117153',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117161' where substr('117161',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117170' where substr('117170',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117188' where substr('117188',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117196' where substr('117196',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117200' where substr('117200',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117218' where substr('117218',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117226' where substr('117226',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117234' where substr('117234',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117242' where substr('117242',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117250' where substr('117250',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117269' where substr('117269',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117277' where substr('117277',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117285' where substr('117285',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117293' where substr('117293',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117307' where substr('117307',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117315' where substr('117315',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117323' where substr('117323',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117331' where substr('117331',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117340' where substr('117340',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117366' where substr('117366',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117374' where substr('117374',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117382' where substr('117382',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117390' where substr('117390',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117404' where substr('117404',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117412' where substr('117412',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117420' where substr('117420',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117439' where substr('117439',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117447' where substr('117447',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117455' where substr('117455',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117463' where substr('117463',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117471' where substr('117471',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117480' where substr('117480',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117498' where substr('117498',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117501' where substr('117501',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117510' where substr('117510',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117528' where substr('117528',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117536' where substr('117536',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117544' where substr('117544',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117552' where substr('117552',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117560' where substr('117560',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117579' where substr('117579',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117587' where substr('117587',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117595' where substr('117595',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117609' where substr('117609',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117617' where substr('117617',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117625' where substr('117625',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117633' where substr('117633',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117641' where substr('117641',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117650' where substr('117650',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117668' where substr('117668',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117676' where substr('117676',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117684' where substr('117684',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117692' where substr('117692',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117706' where substr('117706',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117714' where substr('117714',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117722' where substr('117722',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117730' where substr('117730',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117749' where substr('117749',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117757' where substr('117757',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117765' where substr('117765',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117773' where substr('117773',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117781' where substr('117781',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117790' where substr('117790',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117803' where substr('117803',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117811' where substr('117811',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117820' where substr('117820',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117838' where substr('117838',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117846' where substr('117846',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117854' where substr('117854',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117854' where substr('117854',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117862' where substr('117862',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117870' where substr('117870',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117889' where substr('117889',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117897' where substr('117897',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117900' where substr('117900',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117919' where substr('117919',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117927' where substr('117927',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117935' where substr('117935',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117943' where substr('117943',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117951' where substr('117951',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117960' where substr('117960',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117978' where substr('117978',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117986' where substr('117986',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '117994' where substr('117994',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118001' where substr('118001',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118010' where substr('118010',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118028' where substr('118028',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118036' where substr('118036',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118044' where substr('118044',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118052' where substr('118052',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118060' where substr('118060',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118079' where substr('118079',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118087' where substr('118087',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118095' where substr('118095',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118109' where substr('118109',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118117' where substr('118117',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118125' where substr('118125',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118133' where substr('118133',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118141' where substr('118141',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118150' where substr('118150',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118168' where substr('118168',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118176' where substr('118176',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118184' where substr('118184',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118192' where substr('118192',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118206' where substr('118206',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118214' where substr('118214',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118222' where substr('118222',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118230' where substr('118230',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118249' where substr('118249',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118257' where substr('118257',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118265' where substr('118265',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118273' where substr('118273',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118281' where substr('118281',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118290' where substr('118290',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118303' where substr('118303',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118311' where substr('118311',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118320' where substr('118320',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118338' where substr('118338',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118346' where substr('118346',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118354' where substr('118354',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118362' where substr('118362',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118370' where substr('118370',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118389' where substr('118389',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118397' where substr('118397',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118400' where substr('118400',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118419' where substr('118419',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118435' where substr('118435',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118443' where substr('118443',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118451' where substr('118451',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118460' where substr('118460',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118478' where substr('118478',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118486' where substr('118486',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118494' where substr('118494',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118508' where substr('118508',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118516' where substr('118516',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118524' where substr('118524',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118532' where substr('118532',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118540' where substr('118540',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '118559' where substr('118559',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120014' where substr('120014',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120022' where substr('120022',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120030' where substr('120030',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120049' where substr('120049',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120057' where substr('120057',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120065' where substr('120065',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120073' where substr('120073',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120081' where substr('120081',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120090' where substr('120090',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120103' where substr('120103',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120111' where substr('120111',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120120' where substr('120120',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120138' where substr('120138',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120146' where substr('120146',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120154' where substr('120154',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120162' where substr('120162',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120170' where substr('120170',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120189' where substr('120189',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120197' where substr('120197',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120200' where substr('120200',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120219' where substr('120219',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120227' where substr('120227',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120235' where substr('120235',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120243' where substr('120243',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120251' where substr('120251',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120260' where substr('120260',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120278' where substr('120278',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120286' where substr('120286',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120294' where substr('120294',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120308' where substr('120308',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120316' where substr('120316',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120324' where substr('120324',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120332' where substr('120332',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120340' where substr('120340',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120359' where substr('120359',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120367' where substr('120367',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120375' where substr('120375',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120383' where substr('120383',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120391' where substr('120391',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120405' where substr('120405',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120413' where substr('120413',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120421' where substr('120421',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120430' where substr('120430',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120448' where substr('120448',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120456' where substr('120456',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120464' where substr('120464',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120472' where substr('120472',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120480' where substr('120480',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120499' where substr('120499',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120502' where substr('120502',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120510' where substr('120510',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120529' where substr('120529',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120537' where substr('120537',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120545' where substr('120545',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120553' where substr('120553',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120561' where substr('120561',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120570' where substr('120570',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120588' where substr('120588',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120596' where substr('120596',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120600' where substr('120600',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120618' where substr('120618',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120626' where substr('120626',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120634' where substr('120634',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120642' where substr('120642',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120650' where substr('120650',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120669' where substr('120669',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120677' where substr('120677',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120685' where substr('120685',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120693' where substr('120693',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120707' where substr('120707',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120715' where substr('120715',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120723' where substr('120723',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120731' where substr('120731',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120740' where substr('120740',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120758' where substr('120758',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120766' where substr('120766',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120774' where substr('120774',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120782' where substr('120782',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120790' where substr('120790',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120804' where substr('120804',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120812' where substr('120812',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120820' where substr('120820',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120839' where substr('120839',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120847' where substr('120847',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120855' where substr('120855',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120863' where substr('120863',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120871' where substr('120871',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120880' where substr('120880',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120898' where substr('120898',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120901' where substr('120901',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120910' where substr('120910',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120928' where substr('120928',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120936' where substr('120936',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120944' where substr('120944',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120952' where substr('120952',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120960' where substr('120960',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120979' where substr('120979',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120987' where substr('120987',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '120995' where substr('120995',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121002' where substr('121002',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121010' where substr('121010',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121029' where substr('121029',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121037' where substr('121037',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121045' where substr('121045',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121053' where substr('121053',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121061' where substr('121061',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121070' where substr('121070',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121088' where substr('121088',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121096' where substr('121096',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121100' where substr('121100',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121118' where substr('121118',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121126' where substr('121126',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121134' where substr('121134',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121142' where substr('121142',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121150' where substr('121150',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121169' where substr('121169',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121177' where substr('121177',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121185' where substr('121185',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121193' where substr('121193',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121207' where substr('121207',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121215' where substr('121215',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121223' where substr('121223',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121231' where substr('121231',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121240' where substr('121240',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121258' where substr('121258',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121266' where substr('121266',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121274' where substr('121274',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121282' where substr('121282',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121290' where substr('121290',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121304' where substr('121304',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121312' where substr('121312',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121320' where substr('121320',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121339' where substr('121339',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121347' where substr('121347',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121355' where substr('121355',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121363' where substr('121363',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121371' where substr('121371',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121380' where substr('121380',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121398' where substr('121398',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121401' where substr('121401',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121410' where substr('121410',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121428' where substr('121428',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '121436' where substr('121436',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130010' where substr('130010',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130028' where substr('130028',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130036' where substr('130036',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130044' where substr('130044',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130052' where substr('130052',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130060' where substr('130060',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130079' where substr('130079',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130087' where substr('130087',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130095' where substr('130095',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130109' where substr('130109',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130117' where substr('130117',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130125' where substr('130125',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130133' where substr('130133',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130150' where substr('130150',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130168' where substr('130168',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130176' where substr('130176',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130184' where substr('130184',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130192' where substr('130192',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130206' where substr('130206',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130214' where substr('130214',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130222' where substr('130222',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130230' where substr('130230',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130249' where substr('130249',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130257' where substr('130257',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130265' where substr('130265',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130273' where substr('130273',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130281' where substr('130281',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130290' where substr('130290',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130303' where substr('130303',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130311' where substr('130311',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130320' where substr('130320',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130338' where substr('130338',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130346' where substr('130346',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130354' where substr('130354',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130362' where substr('130362',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130370' where substr('130370',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130389' where substr('130389',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130397' where substr('130397',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130400' where substr('130400',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130419' where substr('130419',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130427' where substr('130427',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130435' where substr('130435',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130443' where substr('130443',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130451' where substr('130451',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130460' where substr('130460',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130478' where substr('130478',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130486' where substr('130486',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130494' where substr('130494',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130508' where substr('130508',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130516' where substr('130516',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130524' where substr('130524',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130532' where substr('130532',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130540' where substr('130540',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130559' where substr('130559',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130567' where substr('130567',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130575' where substr('130575',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130583' where substr('130583',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130591' where substr('130591',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130605' where substr('130605',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130613' where substr('130613',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130621' where substr('130621',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130630' where substr('130630',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130648' where substr('130648',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130656' where substr('130656',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130664' where substr('130664',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130672' where substr('130672',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130680' where substr('130680',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130699' where substr('130699',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130702' where substr('130702',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130710' where substr('130710',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130729' where substr('130729',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130737' where substr('130737',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130745' where substr('130745',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130753' where substr('130753',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130761' where substr('130761',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130770' where substr('130770',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130788' where substr('130788',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130796' where substr('130796',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130800' where substr('130800',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130818' where substr('130818',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130826' where substr('130826',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130834' where substr('130834',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130842' where substr('130842',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130850' where substr('130850',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130869' where substr('130869',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130877' where substr('130877',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130885' where substr('130885',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130893' where substr('130893',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130907' where substr('130907',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130915' where substr('130915',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130923' where substr('130923',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130931' where substr('130931',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130940' where substr('130940',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130958' where substr('130958',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130966' where substr('130966',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130974' where substr('130974',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130982' where substr('130982',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '130990' where substr('130990',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131008' where substr('131008',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131016' where substr('131016',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131024' where substr('131024',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131032' where substr('131032',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131040' where substr('131040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131059' where substr('131059',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131067' where substr('131067',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131075' where substr('131075',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131083' where substr('131083',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131091' where substr('131091',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131105' where substr('131105',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131113' where substr('131113',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131121' where substr('131121',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131130' where substr('131130',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131148' where substr('131148',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131156' where substr('131156',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131164' where substr('131164',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131172' where substr('131172',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131180' where substr('131180',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131199' where substr('131199',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131202' where substr('131202',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131210' where substr('131210',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131229' where substr('131229',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131237' where substr('131237',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131245' where substr('131245',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131253' where substr('131253',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131261' where substr('131261',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131270' where substr('131270',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131288' where substr('131288',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131296' where substr('131296',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131300' where substr('131300',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131318' where substr('131318',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131326' where substr('131326',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131334' where substr('131334',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131342' where substr('131342',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131350' where substr('131350',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131369' where substr('131369',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131377' where substr('131377',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131385' where substr('131385',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131393' where substr('131393',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131407' where substr('131407',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131415' where substr('131415',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131423' where substr('131423',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131431' where substr('131431',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131440' where substr('131440',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131458' where substr('131458',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131466' where substr('131466',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131474' where substr('131474',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131482' where substr('131482',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131490' where substr('131490',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131504' where substr('131504',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131512' where substr('131512',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131520' where substr('131520',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131539' where substr('131539',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131547' where substr('131547',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131555' where substr('131555',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131563' where substr('131563',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131571' where substr('131571',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131580' where substr('131580',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131598' where substr('131598',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131601' where substr('131601',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131610' where substr('131610',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131628' where substr('131628',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131636' where substr('131636',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131644' where substr('131644',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131652' where substr('131652',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131660' where substr('131660',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131679' where substr('131679',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131687' where substr('131687',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131695' where substr('131695',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131709' where substr('131709',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131717' where substr('131717',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131725' where substr('131725',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131733' where substr('131733',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131741' where substr('131741',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131750' where substr('131750',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131768' where substr('131768',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131776' where substr('131776',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131784' where substr('131784',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131792' where substr('131792',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131806' where substr('131806',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131814' where substr('131814',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131822' where substr('131822',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131830' where substr('131830',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131849' where substr('131849',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131857' where substr('131857',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131865' where substr('131865',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131873' where substr('131873',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131881' where substr('131881',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131890' where substr('131890',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131903' where substr('131903',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131911' where substr('131911',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131920' where substr('131920',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131938' where substr('131938',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131946' where substr('131946',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131954' where substr('131954',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131962' where substr('131962',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131970' where substr('131970',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131989' where substr('131989',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '131997' where substr('131997',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132004' where substr('132004',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132012' where substr('132012',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132020' where substr('132020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132039' where substr('132039',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132047' where substr('132047',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132055' where substr('132055',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132063' where substr('132063',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132071' where substr('132071',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132080' where substr('132080',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132098' where substr('132098',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132101' where substr('132101',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132110' where substr('132110',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132128' where substr('132128',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132136' where substr('132136',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132144' where substr('132144',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132152' where substr('132152',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132160' where substr('132160',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132179' where substr('132179',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132187' where substr('132187',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132195' where substr('132195',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132209' where substr('132209',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132217' where substr('132217',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132225' where substr('132225',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132233' where substr('132233',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '132241' where substr('132241',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140015' where substr('140015',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140023' where substr('140023',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140031' where substr('140031',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140040' where substr('140040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140040' where substr('140040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140058' where substr('140058',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140066' where substr('140066',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140074' where substr('140074',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140082' where substr('140082',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140090' where substr('140090',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140104' where substr('140104',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140112' where substr('140112',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140120' where substr('140120',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140139' where substr('140139',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140147' where substr('140147',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140155' where substr('140155',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140163' where substr('140163',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140171' where substr('140171',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140180' where substr('140180',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140180' where substr('140180',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140198' where substr('140198',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140201' where substr('140201',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140210' where substr('140210',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140228' where substr('140228',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140236' where substr('140236',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140244' where substr('140244',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140252' where substr('140252',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140260' where substr('140260',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140279' where substr('140279',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140287' where substr('140287',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140295' where substr('140295',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140309' where substr('140309',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140317' where substr('140317',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140325' where substr('140325',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140333' where substr('140333',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140341' where substr('140341',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140350' where substr('140350',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140368' where substr('140368',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140368' where substr('140368',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140376' where substr('140376',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140384' where substr('140384',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140392' where substr('140392',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140406' where substr('140406',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140414' where substr('140414',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140422' where substr('140422',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140430' where substr('140430',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140449' where substr('140449',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140457' where substr('140457',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140465' where substr('140465',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140473' where substr('140473',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140481' where substr('140481',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140490' where substr('140490',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140503' where substr('140503',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140511' where substr('140511',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140520' where substr('140520',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140538' where substr('140538',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140546' where substr('140546',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140554' where substr('140554',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140562' where substr('140562',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140570' where substr('140570',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140589' where substr('140589',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140597' where substr('140597',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140600' where substr('140600',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140619' where substr('140619',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140627' where substr('140627',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140635' where substr('140635',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140643' where substr('140643',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140651' where substr('140651',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140660' where substr('140660',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140678' where substr('140678',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140686' where substr('140686',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140694' where substr('140694',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140708' where substr('140708',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140716' where substr('140716',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140724' where substr('140724',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140732' where substr('140732',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140740' where substr('140740',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140759' where substr('140759',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140767' where substr('140767',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140775' where substr('140775',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140783' where substr('140783',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140791' where substr('140791',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140805' where substr('140805',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140813' where substr('140813',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140821' where substr('140821',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140821' where substr('140821',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140830' where substr('140830',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140830' where substr('140830',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140848' where substr('140848',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140856' where substr('140856',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140864' where substr('140864',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140872' where substr('140872',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140880' where substr('140880',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140899' where substr('140899',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140902' where substr('140902',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140910' where substr('140910',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140929' where substr('140929',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140937' where substr('140937',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140945' where substr('140945',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140953' where substr('140953',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140961' where substr('140961',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140961' where substr('140961',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140970' where substr('140970',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140988' where substr('140988',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '140996' where substr('140996',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141003' where substr('141003',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141011' where substr('141011',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141020' where substr('141020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141038' where substr('141038',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141046' where substr('141046',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141054' where substr('141054',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141062' where substr('141062',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141070' where substr('141070',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141089' where substr('141089',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141097' where substr('141097',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141100' where substr('141100',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141119' where substr('141119',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141127' where substr('141127',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141135' where substr('141135',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141143' where substr('141143',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141151' where substr('141151',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141160' where substr('141160',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141178' where substr('141178',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141186' where substr('141186',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141194' where substr('141194',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141208' where substr('141208',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141216' where substr('141216',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141224' where substr('141224',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141232' where substr('141232',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141240' where substr('141240',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141259' where substr('141259',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141267' where substr('141267',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141275' where substr('141275',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141283' where substr('141283',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141291' where substr('141291',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141305' where substr('141305',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141313' where substr('141313',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141321' where substr('141321',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141330' where substr('141330',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141348' where substr('141348',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141356' where substr('141356',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141364' where substr('141364',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141372' where substr('141372',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141380' where substr('141380',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141399' where substr('141399',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141402' where substr('141402',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141410' where substr('141410',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141429' where substr('141429',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141437' where substr('141437',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141445' where substr('141445',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141453' where substr('141453',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141461' where substr('141461',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141461' where substr('141461',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141470' where substr('141470',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141488' where substr('141488',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141496' where substr('141496',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141500' where substr('141500',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141518' where substr('141518',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141526' where substr('141526',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141534' where substr('141534',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141542' where substr('141542',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141550' where substr('141550',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141569' where substr('141569',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141577' where substr('141577',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141585' where substr('141585',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141593' where substr('141593',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141607' where substr('141607',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141615' where substr('141615',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141623' where substr('141623',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141631' where substr('141631',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141640' where substr('141640',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141658' where substr('141658',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141666' where substr('141666',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141674' where substr('141674',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141682' where substr('141682',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141690' where substr('141690',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141704' where substr('141704',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141712' where substr('141712',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141720' where substr('141720',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141739' where substr('141739',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141747' where substr('141747',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141755' where substr('141755',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141755' where substr('141755',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141763' where substr('141763',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141771' where substr('141771',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141780' where substr('141780',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141798' where substr('141798',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141801' where substr('141801',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141810' where substr('141810',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141828' where substr('141828',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141836' where substr('141836',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141844' where substr('141844',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141852' where substr('141852',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141860' where substr('141860',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141879' where substr('141879',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141887' where substr('141887',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141895' where substr('141895',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141909' where substr('141909',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141917' where substr('141917',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141925' where substr('141925',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141933' where substr('141933',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141941' where substr('141941',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141950' where substr('141950',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141968' where substr('141968',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141976' where substr('141976',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141984' where substr('141984',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '141992' where substr('141992',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142000' where substr('142000',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142018' where substr('142018',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142026' where substr('142026',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142034' where substr('142034',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142042' where substr('142042',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142050' where substr('142050',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142069' where substr('142069',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142077' where substr('142077',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142085' where substr('142085',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142093' where substr('142093',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142107' where substr('142107',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142115' where substr('142115',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142123' where substr('142123',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142131' where substr('142131',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142140' where substr('142140',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142158' where substr('142158',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142166' where substr('142166',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142174' where substr('142174',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142182' where substr('142182',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142190' where substr('142190',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142204' where substr('142204',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142212' where substr('142212',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142220' where substr('142220',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142239' where substr('142239',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142247' where substr('142247',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142255' where substr('142255',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142263' where substr('142263',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142271' where substr('142271',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142280' where substr('142280',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142298' where substr('142298',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142301' where substr('142301',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142310' where substr('142310',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142328' where substr('142328',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142336' where substr('142336',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142344' where substr('142344',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142352' where substr('142352',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142360' where substr('142360',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142379' where substr('142379',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142387' where substr('142387',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142395' where substr('142395',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142409' where substr('142409',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142417' where substr('142417',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142425' where substr('142425',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142433' where substr('142433',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142433' where substr('142433',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142441' where substr('142441',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142450' where substr('142450',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142468' where substr('142468',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142476' where substr('142476',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142484' where substr('142484',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142492' where substr('142492',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142506' where substr('142506',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142514' where substr('142514',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142522' where substr('142522',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142530' where substr('142530',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142549' where substr('142549',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142557' where substr('142557',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142565' where substr('142565',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142573' where substr('142573',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142581' where substr('142581',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142581' where substr('142581',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142590' where substr('142590',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142603' where substr('142603',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142611' where substr('142611',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142620' where substr('142620',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142638' where substr('142638',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142646' where substr('142646',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142654' where substr('142654',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142662' where substr('142662',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142670' where substr('142670',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142689' where substr('142689',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142697' where substr('142697',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142700' where substr('142700',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142719' where substr('142719',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142727' where substr('142727',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142735' where substr('142735',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142743' where substr('142743',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142751' where substr('142751',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142760' where substr('142760',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142778' where substr('142778',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142786' where substr('142786',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142794' where substr('142794',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142808' where substr('142808',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142816' where substr('142816',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142824' where substr('142824',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142832' where substr('142832',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142840' where substr('142840',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142859' where substr('142859',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142867' where substr('142867',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142875' where substr('142875',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142883' where substr('142883',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142891' where substr('142891',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142905' where substr('142905',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142913' where substr('142913',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142921' where substr('142921',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142930' where substr('142930',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142948' where substr('142948',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142956' where substr('142956',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142964' where substr('142964',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142972' where substr('142972',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142980' where substr('142980',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '142999' where substr('142999',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143006' where substr('143006',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143014' where substr('143014',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143022' where substr('143022',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143030' where substr('143030',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143049' where substr('143049',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143057' where substr('143057',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143065' where substr('143065',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143073' where substr('143073',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143081' where substr('143081',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143090' where substr('143090',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143103' where substr('143103',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143111' where substr('143111',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143120' where substr('143120',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143138' where substr('143138',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143146' where substr('143146',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143154' where substr('143154',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143162' where substr('143162',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143170' where substr('143170',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143189' where substr('143189',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143197' where substr('143197',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143200' where substr('143200',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143219' where substr('143219',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143227' where substr('143227',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143235' where substr('143235',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143243' where substr('143243',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143251' where substr('143251',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143260' where substr('143260',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143278' where substr('143278',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143294' where substr('143294',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143308' where substr('143308',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143316' where substr('143316',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143340' where substr('143340',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143359' where substr('143359',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143367' where substr('143367',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143375' where substr('143375',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143391' where substr('143391',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143405' where substr('143405',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143413' where substr('143413',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143413' where substr('143413',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143421' where substr('143421',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143430' where substr('143430',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143448' where substr('143448',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143456' where substr('143456',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143464' where substr('143464',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143472' where substr('143472',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143480' where substr('143480',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143499' where substr('143499',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143502' where substr('143502',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143510' where substr('143510',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143537' where substr('143537',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143545' where substr('143545',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143553' where substr('143553',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143570' where substr('143570',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143588' where substr('143588',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143596' where substr('143596',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143618' where substr('143618',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143626' where substr('143626',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143634' where substr('143634',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143650' where substr('143650',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143669' where substr('143669',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143677' where substr('143677',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143693' where substr('143693',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143715' where substr('143715',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143723' where substr('143723',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143740' where substr('143740',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143758' where substr('143758',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143774' where substr('143774',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143782' where substr('143782',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143790' where substr('143790',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143804' where substr('143804',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143812' where substr('143812',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143820' where substr('143820',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143839' where substr('143839',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143847' where substr('143847',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143855' where substr('143855',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143871' where substr('143871',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143880' where substr('143880',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143898' where substr('143898',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143901' where substr('143901',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143910' where substr('143910',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143928' where substr('143928',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143936' where substr('143936',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143952' where substr('143952',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143960' where substr('143960',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143979' where substr('143979',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143987' where substr('143987',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '143995' where substr('143995',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '144002' where substr('144002',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '144010' where substr('144010',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '144029' where substr('144029',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '144037' where substr('144037',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '144045' where substr('144045',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '144053' where substr('144053',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '144061' where substr('144061',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '144070' where substr('144070',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '144088' where substr('144088',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '144096' where substr('144096',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '144118' where substr('144118',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '144126' where substr('144126',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150010' where substr('150010',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150029' where substr('150029',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150037' where substr('150037',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150045' where substr('150045',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150053' where substr('150053',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150061' where substr('150061',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150070' where substr('150070',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150088' where substr('150088',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150096' where substr('150096',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150100' where substr('150100',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150118' where substr('150118',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150126' where substr('150126',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150134' where substr('150134',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150142' where substr('150142',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150150' where substr('150150',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150177' where substr('150177',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150185' where substr('150185',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150193' where substr('150193',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150207' where substr('150207',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150215' where substr('150215',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150223' where substr('150223',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150231' where substr('150231',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150240' where substr('150240',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150258' where substr('150258',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150266' where substr('150266',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150274' where substr('150274',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150282' where substr('150282',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150290' where substr('150290',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150304' where substr('150304',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150312' where substr('150312',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150320' where substr('150320',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150339' where substr('150339',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150347' where substr('150347',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150355' where substr('150355',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150363' where substr('150363',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150371' where substr('150371',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150380' where substr('150380',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150398' where substr('150398',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150401' where substr('150401',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150410' where substr('150410',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150428' where substr('150428',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150436' where substr('150436',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150444' where substr('150444',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150452' where substr('150452',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150460' where substr('150460',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150479' where substr('150479',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150487' where substr('150487',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150495' where substr('150495',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150509' where substr('150509',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150517' where substr('150517',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150525' where substr('150525',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150533' where substr('150533',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150541' where substr('150541',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150550' where substr('150550',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150568' where substr('150568',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150576' where substr('150576',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150584' where substr('150584',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150592' where substr('150592',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150606' where substr('150606',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150614' where substr('150614',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150622' where substr('150622',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150630' where substr('150630',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150649' where substr('150649',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150649' where substr('150649',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150657' where substr('150657',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150665' where substr('150665',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150673' where substr('150673',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150681' where substr('150681',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150690' where substr('150690',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150703' where substr('150703',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150711' where substr('150711',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150720' where substr('150720',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150738' where substr('150738',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150746' where substr('150746',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150754' where substr('150754',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150762' where substr('150762',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150770' where substr('150770',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150789' where substr('150789',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150797' where substr('150797',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150800' where substr('150800',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150819' where substr('150819',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150827' where substr('150827',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150835' where substr('150835',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150843' where substr('150843',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150851' where substr('150851',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150860' where substr('150860',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150878' where substr('150878',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150886' where substr('150886',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150894' where substr('150894',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150908' where substr('150908',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150916' where substr('150916',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150924' where substr('150924',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150932' where substr('150932',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150940' where substr('150940',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150959' where substr('150959',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150967' where substr('150967',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150975' where substr('150975',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150983' where substr('150983',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '150991' where substr('150991',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151009' where substr('151009',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151017' where substr('151017',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151025' where substr('151025',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151033' where substr('151033',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151041' where substr('151041',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151050' where substr('151050',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151068' where substr('151068',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151076' where substr('151076',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151084' where substr('151084',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151092' where substr('151092',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151106' where substr('151106',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151114' where substr('151114',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151122' where substr('151122',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151130' where substr('151130',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151149' where substr('151149',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151157' where substr('151157',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151165' where substr('151165',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151173' where substr('151173',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151181' where substr('151181',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151190' where substr('151190',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151203' where substr('151203',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151211' where substr('151211',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151220' where substr('151220',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151238' where substr('151238',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151246' where substr('151246',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151254' where substr('151254',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151262' where substr('151262',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151270' where substr('151270',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151289' where substr('151289',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151297' where substr('151297',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151300' where substr('151300',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151319' where substr('151319',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151327' where substr('151327',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151335' where substr('151335',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151343' where substr('151343',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151351' where substr('151351',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151360' where substr('151360',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151378' where substr('151378',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151386' where substr('151386',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151394' where substr('151394',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151408' where substr('151408',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151416' where substr('151416',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151424' where substr('151424',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151432' where substr('151432',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151440' where substr('151440',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151459' where substr('151459',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151467' where substr('151467',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151475' where substr('151475',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151483' where substr('151483',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151491' where substr('151491',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151505' where substr('151505',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151513' where substr('151513',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151521' where substr('151521',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151530' where substr('151530',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151548' where substr('151548',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151556' where substr('151556',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151564' where substr('151564',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151572' where substr('151572',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151580' where substr('151580',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151599' where substr('151599',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151602' where substr('151602',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151610' where substr('151610',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151629' where substr('151629',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151637' where substr('151637',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151645' where substr('151645',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151670' where substr('151670',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151688' where substr('151688',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151696' where substr('151696',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151700' where substr('151700',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151718' where substr('151718',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151726' where substr('151726',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151734' where substr('151734',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151742' where substr('151742',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151750' where substr('151750',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151769' where substr('151769',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151777' where substr('151777',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151785' where substr('151785',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151793' where substr('151793',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151807' where substr('151807',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151815' where substr('151815',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151823' where substr('151823',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151831' where substr('151831',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151840' where substr('151840',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151858' where substr('151858',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151866' where substr('151866',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '151874' where substr('151874',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160016' where substr('160016',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160024' where substr('160024',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160032' where substr('160032',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160040' where substr('160040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160059' where substr('160059',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160067' where substr('160067',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160075' where substr('160075',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160083' where substr('160083',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160091' where substr('160091',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160105' where substr('160105',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160113' where substr('160113',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160121' where substr('160121',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160130' where substr('160130',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160148' where substr('160148',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160156' where substr('160156',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160164' where substr('160164',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160172' where substr('160172',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160180' where substr('160180',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160199' where substr('160199',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160202' where substr('160202',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160210' where substr('160210',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160229' where substr('160229',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160237' where substr('160237',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160245' where substr('160245',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160253' where substr('160253',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160261' where substr('160261',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160270' where substr('160270',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160288' where substr('160288',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160296' where substr('160296',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160300' where substr('160300',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160318' where substr('160318',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160326' where substr('160326',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160334' where substr('160334',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160342' where substr('160342',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160350' where substr('160350',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160369' where substr('160369',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160377' where substr('160377',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160385' where substr('160385',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160393' where substr('160393',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160407' where substr('160407',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160415' where substr('160415',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160423' where substr('160423',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160431' where substr('160431',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160440' where substr('160440',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160458' where substr('160458',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160466' where substr('160466',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160474' where substr('160474',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160482' where substr('160482',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160490' where substr('160490',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160504' where substr('160504',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160512' where substr('160512',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160520' where substr('160520',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160539' where substr('160539',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160547' where substr('160547',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160555' where substr('160555',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160563' where substr('160563',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160571' where substr('160571',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160580' where substr('160580',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160598' where substr('160598',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160601' where substr('160601',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160610' where substr('160610',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160628' where substr('160628',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160636' where substr('160636',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160644' where substr('160644',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160652' where substr('160652',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160660' where substr('160660',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160679' where substr('160679',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160687' where substr('160687',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160695' where substr('160695',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160709' where substr('160709',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160717' where substr('160717',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160725' where substr('160725',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160733' where substr('160733',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160741' where substr('160741',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160750' where substr('160750',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160768' where substr('160768',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160776' where substr('160776',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160784' where substr('160784',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160792' where substr('160792',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160806' where substr('160806',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160814' where substr('160814',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160822' where substr('160822',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160830' where substr('160830',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160849' where substr('160849',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160857' where substr('160857',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160865' where substr('160865',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160873' where substr('160873',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160881' where substr('160881',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160890' where substr('160890',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160903' where substr('160903',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160911' where substr('160911',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160920' where substr('160920',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160938' where substr('160938',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160946' where substr('160946',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160954' where substr('160954',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160962' where substr('160962',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160970' where substr('160970',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160989' where substr('160989',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '160997' where substr('160997',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161004' where substr('161004',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161012' where substr('161012',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161020' where substr('161020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161039' where substr('161039',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161047' where substr('161047',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161055' where substr('161055',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161063' where substr('161063',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161071' where substr('161071',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161080' where substr('161080',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161098' where substr('161098',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161101' where substr('161101',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161110' where substr('161110',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161128' where substr('161128',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161136' where substr('161136',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161144' where substr('161144',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161160' where substr('161160',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161187' where substr('161187',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161195' where substr('161195',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161209' where substr('161209',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161217' where substr('161217',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161225' where substr('161225',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161233' where substr('161233',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161241' where substr('161241',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161250' where substr('161250',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161268' where substr('161268',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161276' where substr('161276',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161284' where substr('161284',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161292' where substr('161292',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161306' where substr('161306',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161314' where substr('161314',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161322' where substr('161322',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161330' where substr('161330',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161349' where substr('161349',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161357' where substr('161357',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161365' where substr('161365',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161373' where substr('161373',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161381' where substr('161381',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161390' where substr('161390',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161403' where substr('161403',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161411' where substr('161411',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161420' where substr('161420',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161438' where substr('161438',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161446' where substr('161446',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161454' where substr('161454',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161462' where substr('161462',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161470' where substr('161470',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161489' where substr('161489',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161497' where substr('161497',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161500' where substr('161500',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161519' where substr('161519',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161527' where substr('161527',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161535' where substr('161535',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161543' where substr('161543',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161551' where substr('161551',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161560' where substr('161560',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161578' where substr('161578',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161586' where substr('161586',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161594' where substr('161594',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161608' where substr('161608',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161616' where substr('161616',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161624' where substr('161624',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161632' where substr('161632',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161640' where substr('161640',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161640' where substr('161640',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161659' where substr('161659',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161667' where substr('161667',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161675' where substr('161675',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161683' where substr('161683',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161691' where substr('161691',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161705' where substr('161705',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161713' where substr('161713',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161721' where substr('161721',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161730' where substr('161730',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161748' where substr('161748',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161756' where substr('161756',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161764' where substr('161764',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161772' where substr('161772',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161780' where substr('161780',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161799' where substr('161799',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161802' where substr('161802',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161810' where substr('161810',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161829' where substr('161829',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161837' where substr('161837',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161845' where substr('161845',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161853' where substr('161853',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161861' where substr('161861',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161870' where substr('161870',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161888' where substr('161888',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161896' where substr('161896',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161900' where substr('161900',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161918' where substr('161918',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161926' where substr('161926',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161934' where substr('161934',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161942' where substr('161942',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161950' where substr('161950',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161969' where substr('161969',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161977' where substr('161977',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161985' where substr('161985',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '161993' where substr('161993',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162000' where substr('162000',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162019' where substr('162019',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162027' where substr('162027',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162035' where substr('162035',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162043' where substr('162043',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162051' where substr('162051',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162060' where substr('162060',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162078' where substr('162078',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162086' where substr('162086',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162094' where substr('162094',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162108' where substr('162108',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162116' where substr('162116',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162124' where substr('162124',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162132' where substr('162132',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162140' where substr('162140',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162159' where substr('162159',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162167' where substr('162167',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162175' where substr('162175',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162183' where substr('162183',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162191' where substr('162191',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162205' where substr('162205',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162213' where substr('162213',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162221' where substr('162221',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162230' where substr('162230',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162248' where substr('162248',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '162256' where substr('162256',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170011' where substr('170011',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170020' where substr('170020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170038' where substr('170038',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170046' where substr('170046',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170054' where substr('170054',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170062' where substr('170062',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170070' where substr('170070',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170089' where substr('170089',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170097' where substr('170097',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170100' where substr('170100',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170119' where substr('170119',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170127' where substr('170127',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170135' where substr('170135',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170143' where substr('170143',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170151' where substr('170151',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170160' where substr('170160',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170178' where substr('170178',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170186' where substr('170186',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170194' where substr('170194',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170208' where substr('170208',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170216' where substr('170216',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170224' where substr('170224',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170232' where substr('170232',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170240' where substr('170240',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170259' where substr('170259',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170267' where substr('170267',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170275' where substr('170275',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170283' where substr('170283',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170291' where substr('170291',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170305' where substr('170305',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170313' where substr('170313',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170321' where substr('170321',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170330' where substr('170330',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170330' where substr('170330',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170348' where substr('170348',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170356' where substr('170356',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170356' where substr('170356',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170364' where substr('170364',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170372' where substr('170372',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170380' where substr('170380',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170399' where substr('170399',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170402' where substr('170402',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170410' where substr('170410',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170429' where substr('170429',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170437' where substr('170437',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170445' where substr('170445',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170453' where substr('170453',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170461' where substr('170461',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170470' where substr('170470',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170488' where substr('170488',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170496' where substr('170496',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170500' where substr('170500',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170518' where substr('170518',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170518' where substr('170518',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170526' where substr('170526',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170534' where substr('170534',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170542' where substr('170542',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170550' where substr('170550',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170569' where substr('170569',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170577' where substr('170577',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170585' where substr('170585',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170593' where substr('170593',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170607' where substr('170607',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170615' where substr('170615',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170623' where substr('170623',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170631' where substr('170631',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170640' where substr('170640',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170640' where substr('170640',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170640' where substr('170640',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170658' where substr('170658',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170666' where substr('170666',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170674' where substr('170674',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170682' where substr('170682',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170690' where substr('170690',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170704' where substr('170704',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170712' where substr('170712',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170720' where substr('170720',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170739' where substr('170739',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170747' where substr('170747',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170755' where substr('170755',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170763' where substr('170763',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170771' where substr('170771',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170780' where substr('170780',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170798' where substr('170798',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170801' where substr('170801',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170810' where substr('170810',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170828' where substr('170828',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170836' where substr('170836',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170844' where substr('170844',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170852' where substr('170852',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170860' where substr('170860',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170879' where substr('170879',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170887' where substr('170887',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170895' where substr('170895',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170909' where substr('170909',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170917' where substr('170917',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '170925' where substr('170925',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180017' where substr('180017',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180025' where substr('180025',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180033' where substr('180033',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180041' where substr('180041',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180050' where substr('180050',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180068' where substr('180068',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180076' where substr('180076',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180084' where substr('180084',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180092' where substr('180092',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180106' where substr('180106',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180114' where substr('180114',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180122' where substr('180122',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180130' where substr('180130',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180149' where substr('180149',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180157' where substr('180157',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180165' where substr('180165',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180173' where substr('180173',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180181' where substr('180181',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180190' where substr('180190',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180203' where substr('180203',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180211' where substr('180211',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180220' where substr('180220',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180238' where substr('180238',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180246' where substr('180246',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180254' where substr('180254',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180262' where substr('180262',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180270' where substr('180270',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180289' where substr('180289',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180297' where substr('180297',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180300' where substr('180300',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180319' where substr('180319',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180327' where substr('180327',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180335' where substr('180335',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180343' where substr('180343',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180351' where substr('180351',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180360' where substr('180360',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180378' where substr('180378',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180386' where substr('180386',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180394' where substr('180394',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180408' where substr('180408',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180416' where substr('180416',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180424' where substr('180424',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180432' where substr('180432',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180440' where substr('180440',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180459' where substr('180459',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180467' where substr('180467',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180475' where substr('180475',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180483' where substr('180483',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180491' where substr('180491',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180505' where substr('180505',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180513' where substr('180513',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180521' where substr('180521',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180530' where substr('180530',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180548' where substr('180548',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180556' where substr('180556',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180564' where substr('180564',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180572' where substr('180572',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180580' where substr('180580',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180599' where substr('180599',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180602' where substr('180602',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180610' where substr('180610',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180629' where substr('180629',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180637' where substr('180637',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180645' where substr('180645',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180653' where substr('180653',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180661' where substr('180661',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180670' where substr('180670',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180688' where substr('180688',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180696' where substr('180696',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180700' where substr('180700',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180718' where substr('180718',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180726' where substr('180726',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180734' where substr('180734',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180742' where substr('180742',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180750' where substr('180750',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180769' where substr('180769',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180777' where substr('180777',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180785' where substr('180785',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180793' where substr('180793',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180807' where substr('180807',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180815' where substr('180815',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180823' where substr('180823',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180831' where substr('180831',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180840' where substr('180840',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180858' where substr('180858',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180866' where substr('180866',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180882' where substr('180882',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180890' where substr('180890',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180904' where substr('180904',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180912' where substr('180912',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180920' where substr('180920',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180939' where substr('180939',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180947' where substr('180947',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180955' where substr('180955',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180963' where substr('180963',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180971' where substr('180971',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180980' where substr('180980',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '180998' where substr('180998',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181005' where substr('181005',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181013' where substr('181013',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181021' where substr('181021',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181030' where substr('181030',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181048' where substr('181048',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181056' where substr('181056',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181064' where substr('181064',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181072' where substr('181072',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181080' where substr('181080',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181099' where substr('181099',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181102' where substr('181102',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181110' where substr('181110',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181129' where substr('181129',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181137' where substr('181137',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181145' where substr('181145',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181153' where substr('181153',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181161' where substr('181161',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181170' where substr('181170',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181188' where substr('181188',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181196' where substr('181196',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181200' where substr('181200',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181218' where substr('181218',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181226' where substr('181226',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181234' where substr('181234',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181242' where substr('181242',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181250' where substr('181250',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181269' where substr('181269',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181277' where substr('181277',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181285' where substr('181285',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181293' where substr('181293',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181307' where substr('181307',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181315' where substr('181315',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181323' where substr('181323',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181331' where substr('181331',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181340' where substr('181340',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181358' where substr('181358',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181366' where substr('181366',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181374' where substr('181374',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181382' where substr('181382',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181390' where substr('181390',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181404' where substr('181404',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181412' where substr('181412',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181420' where substr('181420',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181439' where substr('181439',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181447' where substr('181447',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181455' where substr('181455',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181463' where substr('181463',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181471' where substr('181471',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181480' where substr('181480',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181498' where substr('181498',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181501' where substr('181501',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181510' where substr('181510',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181528' where substr('181528',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181536' where substr('181536',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181544' where substr('181544',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181560' where substr('181560',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181579' where substr('181579',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181587' where substr('181587',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181595' where substr('181595',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181609' where substr('181609',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181617' where substr('181617',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181625' where substr('181625',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181633' where substr('181633',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181641' where substr('181641',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181650' where substr('181650',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181668' where substr('181668',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181676' where substr('181676',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '181684' where substr('181684',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190012' where substr('190012',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190020' where substr('190020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190039' where substr('190039',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190047' where substr('190047',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190055' where substr('190055',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190063' where substr('190063',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190071' where substr('190071',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190080' where substr('190080',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190098' where substr('190098',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190101' where substr('190101',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190110' where substr('190110',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190128' where substr('190128',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190136' where substr('190136',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190144' where substr('190144',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190152' where substr('190152',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190160' where substr('190160',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190160' where substr('190160',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190179' where substr('190179',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190179' where substr('190179',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190187' where substr('190187',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190195' where substr('190195',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190209' where substr('190209',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190217' where substr('190217',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190217' where substr('190217',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190225' where substr('190225',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190225' where substr('190225',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190233' where substr('190233',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190241' where substr('190241',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190250' where substr('190250',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190268' where substr('190268',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190276' where substr('190276',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190276' where substr('190276',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190284' where substr('190284',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190284' where substr('190284',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190292' where substr('190292',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190306' where substr('190306',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190314' where substr('190314',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190322' where substr('190322',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190330' where substr('190330',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190349' where substr('190349',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190357' where substr('190357',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190357' where substr('190357',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190365' where substr('190365',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190373' where substr('190373',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190381' where substr('190381',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190390' where substr('190390',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190403' where substr('190403',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190411' where substr('190411',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190411' where substr('190411',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190420' where substr('190420',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190438' where substr('190438',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190446' where substr('190446',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190446' where substr('190446',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190454' where substr('190454',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190462' where substr('190462',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190470' where substr('190470',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190489' where substr('190489',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190497' where substr('190497',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190497' where substr('190497',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190500' where substr('190500',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190519' where substr('190519',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190527' where substr('190527',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190535' where substr('190535',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190543' where substr('190543',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190543' where substr('190543',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190551' where substr('190551',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190560' where substr('190560',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190578' where substr('190578',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190586' where substr('190586',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190594' where substr('190594',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190608' where substr('190608',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190616' where substr('190616',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190624' where substr('190624',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190632' where substr('190632',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190632' where substr('190632',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190640' where substr('190640',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190659' where substr('190659',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190667' where substr('190667',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190675' where substr('190675',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190683' where substr('190683',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190691' where substr('190691',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190705' where substr('190705',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190713' where substr('190713',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190721' where substr('190721',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190730' where substr('190730',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190748' where substr('190748',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190756' where substr('190756',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190756' where substr('190756',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190756' where substr('190756',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190764' where substr('190764',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190772' where substr('190772',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190780' where substr('190780',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190799' where substr('190799',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190802' where substr('190802',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190810' where substr('190810',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190829' where substr('190829',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190837' where substr('190837',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190845' where substr('190845',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190853' where substr('190853',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190861' where substr('190861',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190870' where substr('190870',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190870' where substr('190870',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190888' where substr('190888',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190888' where substr('190888',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190896' where substr('190896',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190896' where substr('190896',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190900' where substr('190900',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190900' where substr('190900',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190918' where substr('190918',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190926' where substr('190926',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190926' where substr('190926',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190934' where substr('190934',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190934' where substr('190934',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190942' where substr('190942',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190942' where substr('190942',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190950' where substr('190950',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190950' where substr('190950',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190969' where substr('190969',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190977' where substr('190977',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190977' where substr('190977',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190985' where substr('190985',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '190993' where substr('190993',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191000' where substr('191000',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191019' where substr('191019',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191027' where substr('191027',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191027' where substr('191027',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191035' where substr('191035',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191043' where substr('191043',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191051' where substr('191051',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191060' where substr('191060',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191078' where substr('191078',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191086' where substr('191086',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191094' where substr('191094',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191108' where substr('191108',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191116' where substr('191116',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191124' where substr('191124',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191124' where substr('191124',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191132' where substr('191132',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191140' where substr('191140',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191159' where substr('191159',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191167' where substr('191167',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191175' where substr('191175',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191183' where substr('191183',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191191' where substr('191191',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191205' where substr('191205',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191213' where substr('191213',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191221' where substr('191221',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191230' where substr('191230',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191248' where substr('191248',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191256' where substr('191256',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191264' where substr('191264',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191264' where substr('191264',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191272' where substr('191272',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191272' where substr('191272',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191280' where substr('191280',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191299' where substr('191299',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191302' where substr('191302',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191310' where substr('191310',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191329' where substr('191329',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191337' where substr('191337',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191337' where substr('191337',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191345' where substr('191345',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191353' where substr('191353',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191361' where substr('191361',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191361' where substr('191361',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191370' where substr('191370',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191388' where substr('191388',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191388' where substr('191388',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191396' where substr('191396',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191400' where substr('191400',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191418' where substr('191418',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191418' where substr('191418',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191426' where substr('191426',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191434' where substr('191434',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191434' where substr('191434',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191442' where substr('191442',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191450' where substr('191450',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191469' where substr('191469',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191477' where substr('191477',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191485' where substr('191485',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191493' where substr('191493',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191493' where substr('191493',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191507' where substr('191507',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191515' where substr('191515',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191523' where substr('191523',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191531' where substr('191531',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191540' where substr('191540',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191558' where substr('191558',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191566' where substr('191566',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191574' where substr('191574',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191582' where substr('191582',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191590' where substr('191590',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191604' where substr('191604',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191612' where substr('191612',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191620' where substr('191620',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191639' where substr('191639',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191647' where substr('191647',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191655' where substr('191655',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191655' where substr('191655',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191663' where substr('191663',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191671' where substr('191671',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191680' where substr('191680',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191698' where substr('191698',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191701' where substr('191701',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191710' where substr('191710',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191728' where substr('191728',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191736' where substr('191736',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191744' where substr('191744',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191744' where substr('191744',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191752' where substr('191752',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191760' where substr('191760',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191760' where substr('191760',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191779' where substr('191779',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191779' where substr('191779',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191787' where substr('191787',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191795' where substr('191795',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191809' where substr('191809',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191817' where substr('191817',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191825' where substr('191825',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191833' where substr('191833',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191833' where substr('191833',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191841' where substr('191841',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191841' where substr('191841',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191850' where substr('191850',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191850' where substr('191850',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191868' where substr('191868',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191876' where substr('191876',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191876' where substr('191876',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191884' where substr('191884',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191884' where substr('191884',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191892' where substr('191892',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191892' where substr('191892',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191906' where substr('191906',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191914' where substr('191914',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191922' where substr('191922',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191930' where substr('191930',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191949' where substr('191949',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191957' where substr('191957',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191965' where substr('191965',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191965' where substr('191965',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191973' where substr('191973',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191973' where substr('191973',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191981' where substr('191981',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '191990' where substr('191990',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192007' where substr('192007',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192015' where substr('192015',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192023' where substr('192023',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192031' where substr('192031',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192040' where substr('192040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192040' where substr('192040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192058' where substr('192058',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192066' where substr('192066',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192082' where substr('192082',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192090' where substr('192090',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192104' where substr('192104',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192112' where substr('192112',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192120' where substr('192120',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192139' where substr('192139',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192147' where substr('192147',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192155' where substr('192155',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192163' where substr('192163',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192171' where substr('192171',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192171' where substr('192171',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192180' where substr('192180',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192198' where substr('192198',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192198' where substr('192198',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192201' where substr('192201',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192201' where substr('192201',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192210' where substr('192210',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192228' where substr('192228',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192236' where substr('192236',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192236' where substr('192236',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192244' where substr('192244',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192252' where substr('192252',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192260' where substr('192260',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192279' where substr('192279',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192279' where substr('192279',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192287' where substr('192287',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192295' where substr('192295',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192295' where substr('192295',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192309' where substr('192309',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192317' where substr('192317',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192317' where substr('192317',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192325' where substr('192325',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192333' where substr('192333',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192350' where substr('192350',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192350' where substr('192350',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192368' where substr('192368',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192376' where substr('192376',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192376' where substr('192376',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192384' where substr('192384',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192392' where substr('192392',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192406' where substr('192406',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192406' where substr('192406',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192414' where substr('192414',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192422' where substr('192422',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192430' where substr('192430',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192430' where substr('192430',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192449' where substr('192449',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192449' where substr('192449',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192457' where substr('192457',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192465' where substr('192465',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192465' where substr('192465',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192473' where substr('192473',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192481' where substr('192481',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192490' where substr('192490',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192503' where substr('192503',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192511' where substr('192511',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192520' where substr('192520',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192538' where substr('192538',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192546' where substr('192546',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192546' where substr('192546',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192554' where substr('192554',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192562' where substr('192562',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192570' where substr('192570',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192589' where substr('192589',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192597' where substr('192597',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192600' where substr('192600',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192619' where substr('192619',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192627' where substr('192627',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192635' where substr('192635',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192643' where substr('192643',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192651' where substr('192651',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192660' where substr('192660',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192678' where substr('192678',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192686' where substr('192686',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192694' where substr('192694',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192708' where substr('192708',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192716' where substr('192716',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192724' where substr('192724',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192732' where substr('192732',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192740' where substr('192740',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192759' where substr('192759',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192767' where substr('192767',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192775' where substr('192775',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192783' where substr('192783',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192791' where substr('192791',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192805' where substr('192805',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192813' where substr('192813',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192821' where substr('192821',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192830' where substr('192830',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192830' where substr('192830',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192848' where substr('192848',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192856' where substr('192856',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192864' where substr('192864',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192872' where substr('192872',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192880' where substr('192880',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192899' where substr('192899',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192902' where substr('192902',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192910' where substr('192910',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192929' where substr('192929',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192937' where substr('192937',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192945' where substr('192945',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192953' where substr('192953',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192961' where substr('192961',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192970' where substr('192970',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192988' where substr('192988',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192988' where substr('192988',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '192996' where substr('192996',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193003' where substr('193003',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193011' where substr('193011',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193020' where substr('193020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193038' where substr('193038',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193046' where substr('193046',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193054' where substr('193054',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193062' where substr('193062',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193070' where substr('193070',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193089' where substr('193089',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193097' where substr('193097',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193100' where substr('193100',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193119' where substr('193119',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193127' where substr('193127',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193135' where substr('193135',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193143' where substr('193143',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193151' where substr('193151',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193160' where substr('193160',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193178' where substr('193178',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193186' where substr('193186',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193194' where substr('193194',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193208' where substr('193208',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193216' where substr('193216',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193224' where substr('193224',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193232' where substr('193232',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193240' where substr('193240',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193259' where substr('193259',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193267' where substr('193267',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193275' where substr('193275',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193283' where substr('193283',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193291' where substr('193291',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193305' where substr('193305',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193313' where substr('193313',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193321' where substr('193321',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193330' where substr('193330',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193348' where substr('193348',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193356' where substr('193356',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193372' where substr('193372',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193380' where substr('193380',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193399' where substr('193399',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193399' where substr('193399',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193402' where substr('193402',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193402' where substr('193402',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193410' where substr('193410',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193429' where substr('193429',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193437' where substr('193437',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193445' where substr('193445',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193453' where substr('193453',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193461' where substr('193461',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193470' where substr('193470',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193488' where substr('193488',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193496' where substr('193496',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193500' where substr('193500',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193518' where substr('193518',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193526' where substr('193526',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193534' where substr('193534',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193542' where substr('193542',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193550' where substr('193550',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193569' where substr('193569',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193577' where substr('193577',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193585' where substr('193585',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193593' where substr('193593',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193607' where substr('193607',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193615' where substr('193615',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193623' where substr('193623',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193631' where substr('193631',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193640' where substr('193640',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193658' where substr('193658',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193666' where substr('193666',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193674' where substr('193674',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193682' where substr('193682',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193690' where substr('193690',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193704' where substr('193704',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193712' where substr('193712',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193720' where substr('193720',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193739' where substr('193739',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193747' where substr('193747',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193755' where substr('193755',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193755' where substr('193755',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193763' where substr('193763',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193763' where substr('193763',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193771' where substr('193771',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193780' where substr('193780',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193798' where substr('193798',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193801' where substr('193801',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193810' where substr('193810',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193828' where substr('193828',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193836' where substr('193836',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193844' where substr('193844',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193852' where substr('193852',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193860' where substr('193860',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193879' where substr('193879',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193887' where substr('193887',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193895' where substr('193895',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193909' where substr('193909',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193909' where substr('193909',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193917' where substr('193917',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193925' where substr('193925',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193933' where substr('193933',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193941' where substr('193941',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193950' where substr('193950',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193968' where substr('193968',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193976' where substr('193976',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193984' where substr('193984',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '193992' where substr('193992',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194000' where substr('194000',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194018' where substr('194018',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194026' where substr('194026',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194034' where substr('194034',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194042' where substr('194042',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194050' where substr('194050',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194069' where substr('194069',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194077' where substr('194077',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194085' where substr('194085',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194093' where substr('194093',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194107' where substr('194107',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194115' where substr('194115',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194123' where substr('194123',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194131' where substr('194131',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194140' where substr('194140',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194158' where substr('194158',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194166' where substr('194166',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194174' where substr('194174',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194182' where substr('194182',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194182' where substr('194182',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194190' where substr('194190',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194204' where substr('194204',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194212' where substr('194212',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194220' where substr('194220',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194239' where substr('194239',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194247' where substr('194247',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194255' where substr('194255',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194263' where substr('194263',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194271' where substr('194271',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194280' where substr('194280',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194298' where substr('194298',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194298' where substr('194298',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194301' where substr('194301',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194310' where substr('194310',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194310' where substr('194310',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194328' where substr('194328',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194328' where substr('194328',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194336' where substr('194336',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194344' where substr('194344',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194352' where substr('194352',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194360' where substr('194360',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194379' where substr('194379',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194387' where substr('194387',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194395' where substr('194395',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194409' where substr('194409',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194417' where substr('194417',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194425' where substr('194425',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194433' where substr('194433',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194433' where substr('194433',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194441' where substr('194441',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194450' where substr('194450',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194468' where substr('194468',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194476' where substr('194476',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194484' where substr('194484',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194492' where substr('194492',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194506' where substr('194506',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194514' where substr('194514',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194522' where substr('194522',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194530' where substr('194530',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194549' where substr('194549',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194557' where substr('194557',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194565' where substr('194565',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194573' where substr('194573',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194581' where substr('194581',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194590' where substr('194590',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194603' where substr('194603',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194611' where substr('194611',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194620' where substr('194620',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194638' where substr('194638',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194646' where substr('194646',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194654' where substr('194654',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194662' where substr('194662',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194670' where substr('194670',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194689' where substr('194689',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194697' where substr('194697',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194700' where substr('194700',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194743' where substr('194743',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194751' where substr('194751',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194760' where substr('194760',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194778' where substr('194778',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194786' where substr('194786',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194794' where substr('194794',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194808' where substr('194808',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194816' where substr('194816',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194824' where substr('194824',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194832' where substr('194832',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194840' where substr('194840',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194859' where substr('194859',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194867' where substr('194867',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194875' where substr('194875',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194883' where substr('194883',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194891' where substr('194891',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194905' where substr('194905',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194913' where substr('194913',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194921' where substr('194921',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194930' where substr('194930',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194948' where substr('194948',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194956' where substr('194956',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194964' where substr('194964',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194972' where substr('194972',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194980' where substr('194980',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '194999' where substr('194999',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '195006' where substr('195006',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '195006' where substr('195006',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '195014' where substr('195014',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '195022' where substr('195022',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '195030' where substr('195030',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200018' where substr('200018',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200026' where substr('200026',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200034' where substr('200034',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200042' where substr('200042',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200050' where substr('200050',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200069' where substr('200069',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200077' where substr('200077',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200085' where substr('200085',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200093' where substr('200093',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200107' where substr('200107',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200115' where substr('200115',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200123' where substr('200123',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200131' where substr('200131',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200140' where substr('200140',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200140' where substr('200140',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200158' where substr('200158',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200166' where substr('200166',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200174' where substr('200174',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200182' where substr('200182',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200190' where substr('200190',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200204' where substr('200204',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200204' where substr('200204',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200212' where substr('200212',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200220' where substr('200220',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200239' where substr('200239',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200239' where substr('200239',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200247' where substr('200247',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200255' where substr('200255',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200263' where substr('200263',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200271' where substr('200271',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200280' where substr('200280',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200298' where substr('200298',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200301' where substr('200301',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200310' where substr('200310',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200310' where substr('200310',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200328' where substr('200328',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200336' where substr('200336',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200344' where substr('200344',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200352' where substr('200352',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200360' where substr('200360',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200379' where substr('200379',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200387' where substr('200387',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200395' where substr('200395',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200409' where substr('200409',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200417' where substr('200417',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200417' where substr('200417',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200425' where substr('200425',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200425' where substr('200425',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200433' where substr('200433',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200441' where substr('200441',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200450' where substr('200450',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200450' where substr('200450',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200468' where substr('200468',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200476' where substr('200476',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200484' where substr('200484',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200492' where substr('200492',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200506' where substr('200506',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200514' where substr('200514',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200522' where substr('200522',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200530' where substr('200530',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200530' where substr('200530',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200549' where substr('200549',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200557' where substr('200557',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200565' where substr('200565',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200573' where substr('200573',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200581' where substr('200581',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200590' where substr('200590',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200603' where substr('200603',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200611' where substr('200611',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200620' where substr('200620',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200638' where substr('200638',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200646' where substr('200646',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200654' where substr('200654',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200662' where substr('200662',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200670' where substr('200670',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200689' where substr('200689',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200697' where substr('200697',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200700' where substr('200700',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200719' where substr('200719',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200727' where substr('200727',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200735' where substr('200735',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200743' where substr('200743',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200751' where substr('200751',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200760' where substr('200760',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200778' where substr('200778',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200786' where substr('200786',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200794' where substr('200794',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200808' where substr('200808',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200816' where substr('200816',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200816' where substr('200816',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200824' where substr('200824',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200832' where substr('200832',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200840' where substr('200840',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200859' where substr('200859',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200867' where substr('200867',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200875' where substr('200875',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200883' where substr('200883',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200883' where substr('200883',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200891' where substr('200891',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200891' where substr('200891',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200905' where substr('200905',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200913' where substr('200913',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200921' where substr('200921',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200930' where substr('200930',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200948' where substr('200948',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200956' where substr('200956',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200964' where substr('200964',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200972' where substr('200972',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200980' where substr('200980',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '200999' where substr('200999',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201006' where substr('201006',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201014' where substr('201014',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201022' where substr('201022',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201030' where substr('201030',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201049' where substr('201049',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201057' where substr('201057',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201065' where substr('201065',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201073' where substr('201073',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201081' where substr('201081',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201090' where substr('201090',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201103' where substr('201103',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201111' where substr('201111',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201120' where substr('201120',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201138' where substr('201138',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201146' where substr('201146',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201154' where substr('201154',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201162' where substr('201162',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201170' where substr('201170',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201170' where substr('201170',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201189' where substr('201189',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201197' where substr('201197',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201200' where substr('201200',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201219' where substr('201219',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201227' where substr('201227',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201235' where substr('201235',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201243' where substr('201243',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201251' where substr('201251',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201260' where substr('201260',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201278' where substr('201278',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201286' where substr('201286',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201294' where substr('201294',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201308' where substr('201308',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201316' where substr('201316',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201324' where substr('201324',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201332' where substr('201332',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201340' where substr('201340',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201359' where substr('201359',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201367' where substr('201367',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201375' where substr('201375',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201383' where substr('201383',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201391' where substr('201391',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201405' where substr('201405',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201413' where substr('201413',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201421' where substr('201421',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201430' where substr('201430',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201448' where substr('201448',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201456' where substr('201456',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201464' where substr('201464',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201472' where substr('201472',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201480' where substr('201480',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201499' where substr('201499',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201502' where substr('201502',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201510' where substr('201510',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201529' where substr('201529',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201537' where substr('201537',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201545' where substr('201545',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201553' where substr('201553',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201561' where substr('201561',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201570' where substr('201570',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201588' where substr('201588',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201588' where substr('201588',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201596' where substr('201596',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201600' where substr('201600',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201618' where substr('201618',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201626' where substr('201626',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201634' where substr('201634',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201642' where substr('201642',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201642' where substr('201642',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201650' where substr('201650',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201669' where substr('201669',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201677' where substr('201677',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201685' where substr('201685',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201693' where substr('201693',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201707' where substr('201707',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201707' where substr('201707',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201715' where substr('201715',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201723' where substr('201723',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201731' where substr('201731',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201740' where substr('201740',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201758' where substr('201758',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201766' where substr('201766',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201774' where substr('201774',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201774' where substr('201774',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201782' where substr('201782',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201790' where substr('201790',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201804' where substr('201804',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201812' where substr('201812',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201820' where substr('201820',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201839' where substr('201839',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201847' where substr('201847',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201847' where substr('201847',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201855' where substr('201855',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201863' where substr('201863',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201871' where substr('201871',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201880' where substr('201880',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201898' where substr('201898',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201901' where substr('201901',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201910' where substr('201910',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201928' where substr('201928',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201936' where substr('201936',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201944' where substr('201944',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201952' where substr('201952',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201960' where substr('201960',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201979' where substr('201979',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201987' where substr('201987',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '201995' where substr('201995',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202002' where substr('202002',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202010' where substr('202010',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202029' where substr('202029',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202037' where substr('202037',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202045' where substr('202045',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202053' where substr('202053',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202061' where substr('202061',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202070' where substr('202070',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202088' where substr('202088',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202096' where substr('202096',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202100' where substr('202100',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202118' where substr('202118',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202126' where substr('202126',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202134' where substr('202134',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202142' where substr('202142',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202150' where substr('202150',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202169' where substr('202169',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202177' where substr('202177',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202185' where substr('202185',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202193' where substr('202193',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202207' where substr('202207',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202215' where substr('202215',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202223' where substr('202223',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202231' where substr('202231',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202240' where substr('202240',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202258' where substr('202258',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202266' where substr('202266',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202274' where substr('202274',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202282' where substr('202282',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202290' where substr('202290',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202304' where substr('202304',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202312' where substr('202312',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202320' where substr('202320',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202339' where substr('202339',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202347' where substr('202347',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202355' where substr('202355',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202363' where substr('202363',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202371' where substr('202371',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202380' where substr('202380',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202398' where substr('202398',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202401' where substr('202401',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202428' where substr('202428',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202436' where substr('202436',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202444' where substr('202444',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202452' where substr('202452',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202460' where substr('202460',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202479' where substr('202479',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202487' where substr('202487',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202495' where substr('202495',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202509' where substr('202509',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202517' where substr('202517',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202525' where substr('202525',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202533' where substr('202533',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202541' where substr('202541',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202550' where substr('202550',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202568' where substr('202568',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202576' where substr('202576',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202584' where substr('202584',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202592' where substr('202592',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202606' where substr('202606',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202614' where substr('202614',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202622' where substr('202622',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202630' where substr('202630',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202649' where substr('202649',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202657' where substr('202657',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202665' where substr('202665',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202673' where substr('202673',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202681' where substr('202681',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202690' where substr('202690',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202703' where substr('202703',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202711' where substr('202711',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202720' where substr('202720',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202738' where substr('202738',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202746' where substr('202746',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202754' where substr('202754',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202762' where substr('202762',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202770' where substr('202770',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202789' where substr('202789',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202797' where substr('202797',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202800' where substr('202800',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202819' where substr('202819',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202827' where substr('202827',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202835' where substr('202835',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202843' where substr('202843',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202851' where substr('202851',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202860' where substr('202860',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202878' where substr('202878',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202886' where substr('202886',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202894' where substr('202894',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202908' where substr('202908',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202916' where substr('202916',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202916' where substr('202916',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202924' where substr('202924',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202932' where substr('202932',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '202940' where substr('202940',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210013' where substr('210013',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210021' where substr('210021',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210030' where substr('210030',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210048' where substr('210048',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210056' where substr('210056',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210064' where substr('210064',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210072' where substr('210072',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210080' where substr('210080',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210099' where substr('210099',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210102' where substr('210102',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210110' where substr('210110',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210129' where substr('210129',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210137' where substr('210137',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210145' where substr('210145',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210153' where substr('210153',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210161' where substr('210161',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210170' where substr('210170',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210188' where substr('210188',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210196' where substr('210196',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210200' where substr('210200',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210218' where substr('210218',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210226' where substr('210226',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210234' where substr('210234',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210242' where substr('210242',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210250' where substr('210250',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210269' where substr('210269',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210277' where substr('210277',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210285' where substr('210285',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210285' where substr('210285',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210293' where substr('210293',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210307' where substr('210307',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210315' where substr('210315',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210323' where substr('210323',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210331' where substr('210331',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210340' where substr('210340',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210358' where substr('210358',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210366' where substr('210366',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210374' where substr('210374',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210382' where substr('210382',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210390' where substr('210390',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210404' where substr('210404',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210412' where substr('210412',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210420' where substr('210420',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210439' where substr('210439',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210447' where substr('210447',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210455' where substr('210455',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210463' where substr('210463',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210471' where substr('210471',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210480' where substr('210480',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210498' where substr('210498',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210501' where substr('210501',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210510' where substr('210510',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210528' where substr('210528',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210536' where substr('210536',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210544' where substr('210544',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210552' where substr('210552',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210560' where substr('210560',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210579' where substr('210579',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210587' where substr('210587',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210595' where substr('210595',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210609' where substr('210609',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210617' where substr('210617',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210625' where substr('210625',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210633' where substr('210633',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210641' where substr('210641',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210650' where substr('210650',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210650' where substr('210650',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210668' where substr('210668',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210676' where substr('210676',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210684' where substr('210684',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210692' where substr('210692',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210706' where substr('210706',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210714' where substr('210714',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210722' where substr('210722',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210730' where substr('210730',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210749' where substr('210749',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210757' where substr('210757',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210765' where substr('210765',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210781' where substr('210781',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210790' where substr('210790',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210803' where substr('210803',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210811' where substr('210811',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210820' where substr('210820',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210838' where substr('210838',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210846' where substr('210846',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210854' where substr('210854',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210862' where substr('210862',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210870' where substr('210870',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210889' where substr('210889',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210897' where substr('210897',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210900' where substr('210900',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210919' where substr('210919',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210927' where substr('210927',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210935' where substr('210935',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210943' where substr('210943',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210951' where substr('210951',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210960' where substr('210960',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210978' where substr('210978',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210986' where substr('210986',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '210994' where substr('210994',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211001' where substr('211001',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211010' where substr('211010',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211028' where substr('211028',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211036' where substr('211036',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211044' where substr('211044',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211052' where substr('211052',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211060' where substr('211060',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211079' where substr('211079',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211079' where substr('211079',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211087' where substr('211087',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211095' where substr('211095',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211109' where substr('211109',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211117' where substr('211117',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211125' where substr('211125',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211133' where substr('211133',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211141' where substr('211141',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211150' where substr('211150',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211168' where substr('211168',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211176' where substr('211176',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211184' where substr('211184',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211192' where substr('211192',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211206' where substr('211206',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211214' where substr('211214',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211222' where substr('211222',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211230' where substr('211230',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211249' where substr('211249',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211257' where substr('211257',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211265' where substr('211265',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211273' where substr('211273',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211281' where substr('211281',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211290' where substr('211290',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211303' where substr('211303',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211311' where substr('211311',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211320' where substr('211320',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211338' where substr('211338',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211346' where substr('211346',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211354' where substr('211354',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211362' where substr('211362',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211370' where substr('211370',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211389' where substr('211389',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211397' where substr('211397',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211400' where substr('211400',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211419' where substr('211419',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211427' where substr('211427',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211435' where substr('211435',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211443' where substr('211443',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211451' where substr('211451',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211460' where substr('211460',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211478' where substr('211478',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211486' where substr('211486',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211494' where substr('211494',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211508' where substr('211508',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211516' where substr('211516',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211524' where substr('211524',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211532' where substr('211532',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211540' where substr('211540',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211559' where substr('211559',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211567' where substr('211567',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211575' where substr('211575',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211583' where substr('211583',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211591' where substr('211591',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211605' where substr('211605',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211613' where substr('211613',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211621' where substr('211621',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211630' where substr('211630',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211648' where substr('211648',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211656' where substr('211656',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211664' where substr('211664',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211672' where substr('211672',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211680' where substr('211680',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211699' where substr('211699',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211702' where substr('211702',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211710' where substr('211710',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211729' where substr('211729',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211737' where substr('211737',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211745' where substr('211745',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211753' where substr('211753',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211761' where substr('211761',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211770' where substr('211770',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211788' where substr('211788',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211796' where substr('211796',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211800' where substr('211800',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211818' where substr('211818',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211826' where substr('211826',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211834' where substr('211834',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211842' where substr('211842',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211850' where substr('211850',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211850' where substr('211850',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211869' where substr('211869',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211877' where substr('211877',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211885' where substr('211885',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211893' where substr('211893',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211907' where substr('211907',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211915' where substr('211915',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211923' where substr('211923',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211931' where substr('211931',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211940' where substr('211940',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211958' where substr('211958',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211966' where substr('211966',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211974' where substr('211974',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211982' where substr('211982',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '211990' where substr('211990',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212008' where substr('212008',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212016' where substr('212016',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212024' where substr('212024',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212032' where substr('212032',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212040' where substr('212040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212059' where substr('212059',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212067' where substr('212067',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212075' where substr('212075',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212083' where substr('212083',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212091' where substr('212091',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212105' where substr('212105',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212113' where substr('212113',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212121' where substr('212121',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212130' where substr('212130',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212148' where substr('212148',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212156' where substr('212156',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212164' where substr('212164',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212172' where substr('212172',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212180' where substr('212180',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212199' where substr('212199',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212202' where substr('212202',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212210' where substr('212210',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212229' where substr('212229',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212237' where substr('212237',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212245' where substr('212245',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212253' where substr('212253',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212261' where substr('212261',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212270' where substr('212270',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212288' where substr('212288',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212296' where substr('212296',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212300' where substr('212300',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212318' where substr('212318',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212326' where substr('212326',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212334' where substr('212334',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212342' where substr('212342',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212350' where substr('212350',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212369' where substr('212369',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212377' where substr('212377',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212385' where substr('212385',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212393' where substr('212393',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212407' where substr('212407',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212415' where substr('212415',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212423' where substr('212423',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212431' where substr('212431',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212440' where substr('212440',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212458' where substr('212458',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212458' where substr('212458',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212466' where substr('212466',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212474' where substr('212474',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212482' where substr('212482',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212490' where substr('212490',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212504' where substr('212504',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212512' where substr('212512',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212520' where substr('212520',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212539' where substr('212539',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212547' where substr('212547',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212555' where substr('212555',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212563' where substr('212563',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212571' where substr('212571',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212580' where substr('212580',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212598' where substr('212598',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212601' where substr('212601',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212601' where substr('212601',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212610' where substr('212610',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212628' where substr('212628',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212636' where substr('212636',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212644' where substr('212644',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212652' where substr('212652',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212660' where substr('212660',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212679' where substr('212679',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212687' where substr('212687',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212695' where substr('212695',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212709' where substr('212709',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212717' where substr('212717',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212725' where substr('212725',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212733' where substr('212733',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212741' where substr('212741',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212750' where substr('212750',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212768' where substr('212768',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212776' where substr('212776',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212784' where substr('212784',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212792' where substr('212792',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212806' where substr('212806',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212814' where substr('212814',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212822' where substr('212822',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212830' where substr('212830',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212849' where substr('212849',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212857' where substr('212857',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212865' where substr('212865',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212873' where substr('212873',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212881' where substr('212881',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212890' where substr('212890',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212903' where substr('212903',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212911' where substr('212911',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212920' where substr('212920',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212938' where substr('212938',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212946' where substr('212946',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212954' where substr('212954',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212954' where substr('212954',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212962' where substr('212962',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212970' where substr('212970',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212989' where substr('212989',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '212997' where substr('212997',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213004' where substr('213004',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213012' where substr('213012',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213020' where substr('213020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213039' where substr('213039',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213047' where substr('213047',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213055' where substr('213055',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213063' where substr('213063',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213071' where substr('213071',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213080' where substr('213080',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213098' where substr('213098',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213101' where substr('213101',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213110' where substr('213110',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213128' where substr('213128',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213136' where substr('213136',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213144' where substr('213144',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213152' where substr('213152',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213160' where substr('213160',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213179' where substr('213179',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213187' where substr('213187',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213195' where substr('213195',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213209' where substr('213209',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213217' where substr('213217',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213225' where substr('213225',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213233' where substr('213233',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213241' where substr('213241',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213250' where substr('213250',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213268' where substr('213268',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213276' where substr('213276',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213284' where substr('213284',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213292' where substr('213292',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213306' where substr('213306',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213314' where substr('213314',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213322' where substr('213322',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213330' where substr('213330',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213349' where substr('213349',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213357' where substr('213357',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213365' where substr('213365',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213373' where substr('213373',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213381' where substr('213381',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213390' where substr('213390',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213403' where substr('213403',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213411' where substr('213411',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213420' where substr('213420',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213438' where substr('213438',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213446' where substr('213446',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213454' where substr('213454',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213462' where substr('213462',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213470' where substr('213470',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213489' where substr('213489',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213497' where substr('213497',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213500' where substr('213500',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213519' where substr('213519',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213527' where substr('213527',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213535' where substr('213535',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213543' where substr('213543',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213551' where substr('213551',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213560' where substr('213560',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213578' where substr('213578',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213586' where substr('213586',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213594' where substr('213594',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213608' where substr('213608',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213616' where substr('213616',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213624' where substr('213624',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213632' where substr('213632',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213640' where substr('213640',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213659' where substr('213659',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213667' where substr('213667',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213675' where substr('213675',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213683' where substr('213683',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213691' where substr('213691',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213705' where substr('213705',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213713' where substr('213713',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213721' where substr('213721',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213730' where substr('213730',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213748' where substr('213748',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213756' where substr('213756',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213764' where substr('213764',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213772' where substr('213772',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213780' where substr('213780',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213799' where substr('213799',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213802' where substr('213802',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213810' where substr('213810',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213829' where substr('213829',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213837' where substr('213837',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213845' where substr('213845',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213853' where substr('213853',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213861' where substr('213861',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213870' where substr('213870',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213888' where substr('213888',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213896' where substr('213896',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213900' where substr('213900',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213918' where substr('213918',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213926' where substr('213926',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213934' where substr('213934',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213942' where substr('213942',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213950' where substr('213950',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213969' where substr('213969',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213977' where substr('213977',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213985' where substr('213985',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213993' where substr('213993',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '213993' where substr('213993',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214000' where substr('214000',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214019' where substr('214019',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214027' where substr('214027',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214035' where substr('214035',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214043' where substr('214043',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214051' where substr('214051',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214060' where substr('214060',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214078' where substr('214078',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214086' where substr('214086',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214094' where substr('214094',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214108' where substr('214108',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214116' where substr('214116',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214124' where substr('214124',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214132' where substr('214132',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214140' where substr('214140',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214159' where substr('214159',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214167' where substr('214167',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214175' where substr('214175',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214183' where substr('214183',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214191' where substr('214191',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214205' where substr('214205',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214213' where substr('214213',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214221' where substr('214221',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214230' where substr('214230',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214248' where substr('214248',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214256' where substr('214256',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214264' where substr('214264',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214272' where substr('214272',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214280' where substr('214280',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214299' where substr('214299',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214302' where substr('214302',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214310' where substr('214310',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214329' where substr('214329',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214337' where substr('214337',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214345' where substr('214345',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214353' where substr('214353',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214353' where substr('214353',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214361' where substr('214361',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214370' where substr('214370',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214388' where substr('214388',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214396' where substr('214396',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214400' where substr('214400',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214418' where substr('214418',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214426' where substr('214426',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214434' where substr('214434',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214442' where substr('214442',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214450' where substr('214450',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214469' where substr('214469',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214477' where substr('214477',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214485' where substr('214485',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214493' where substr('214493',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214507' where substr('214507',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214515' where substr('214515',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214523' where substr('214523',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214531' where substr('214531',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214540' where substr('214540',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214558' where substr('214558',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214566' where substr('214566',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214574' where substr('214574',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214582' where substr('214582',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214590' where substr('214590',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214590' where substr('214590',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214604' where substr('214604',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214612' where substr('214612',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214620' where substr('214620',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214639' where substr('214639',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214647' where substr('214647',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214655' where substr('214655',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214663' where substr('214663',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214671' where substr('214671',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214680' where substr('214680',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214698' where substr('214698',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214701' where substr('214701',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214710' where substr('214710',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214728' where substr('214728',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214736' where substr('214736',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214744' where substr('214744',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214752' where substr('214752',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214760' where substr('214760',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214779' where substr('214779',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214787' where substr('214787',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214795' where substr('214795',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214795' where substr('214795',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214809' where substr('214809',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214817' where substr('214817',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214825' where substr('214825',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214833' where substr('214833',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214841' where substr('214841',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214850' where substr('214850',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214868' where substr('214868',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214876' where substr('214876',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214884' where substr('214884',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214884' where substr('214884',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214892' where substr('214892',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214892' where substr('214892',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214906' where substr('214906',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214914' where substr('214914',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214922' where substr('214922',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214930' where substr('214930',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214949' where substr('214949',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214957' where substr('214957',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214965' where substr('214965',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214973' where substr('214973',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214981' where substr('214981',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214990' where substr('214990',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '214990' where substr('214990',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215007' where substr('215007',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215007' where substr('215007',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215015' where substr('215015',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215023' where substr('215023',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215031' where substr('215031',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215040' where substr('215040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215040' where substr('215040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215040' where substr('215040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215040' where substr('215040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215040' where substr('215040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215040' where substr('215040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215040' where substr('215040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215040' where substr('215040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215058' where substr('215058',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215066' where substr('215066',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215074' where substr('215074',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215082' where substr('215082',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215090' where substr('215090',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215104' where substr('215104',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215112' where substr('215112',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215120' where substr('215120',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215139' where substr('215139',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215147' where substr('215147',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215155' where substr('215155',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215163' where substr('215163',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215171' where substr('215171',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215180' where substr('215180',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215198' where substr('215198',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215201' where substr('215201',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215210' where substr('215210',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215228' where substr('215228',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215236' where substr('215236',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215244' where substr('215244',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215252' where substr('215252',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215252' where substr('215252',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215260' where substr('215260',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215279' where substr('215279',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215287' where substr('215287',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215295' where substr('215295',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215295' where substr('215295',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215309' where substr('215309',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215317' where substr('215317',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215325' where substr('215325',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215333' where substr('215333',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215341' where substr('215341',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215350' where substr('215350',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215368' where substr('215368',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215376' where substr('215376',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215384' where substr('215384',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215392' where substr('215392',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215406' where substr('215406',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215414' where substr('215414',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215422' where substr('215422',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215422' where substr('215422',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215430' where substr('215430',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215449' where substr('215449',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215457' where substr('215457',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215465' where substr('215465',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215473' where substr('215473',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215481' where substr('215481',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215490' where substr('215490',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215503' where substr('215503',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215511' where substr('215511',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215511' where substr('215511',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215520' where substr('215520',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215538' where substr('215538',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215546' where substr('215546',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215554' where substr('215554',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215562' where substr('215562',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215570' where substr('215570',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215589' where substr('215589',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215597' where substr('215597',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215600' where substr('215600',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215619' where substr('215619',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215627' where substr('215627',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215635' where substr('215635',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215643' where substr('215643',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215651' where substr('215651',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215660' where substr('215660',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215678' where substr('215678',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215678' where substr('215678',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215686' where substr('215686',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215694' where substr('215694',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215708' where substr('215708',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215716' where substr('215716',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215724' where substr('215724',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215732' where substr('215732',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215740' where substr('215740',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215759' where substr('215759',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215767' where substr('215767',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215775' where substr('215775',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215783' where substr('215783',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215791' where substr('215791',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215805' where substr('215805',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215813' where substr('215813',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215830' where substr('215830',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215848' where substr('215848',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215856' where substr('215856',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215864' where substr('215864',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215872' where substr('215872',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215880' where substr('215880',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215899' where substr('215899',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215902' where substr('215902',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215910' where substr('215910',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215929' where substr('215929',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215937' where substr('215937',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215945' where substr('215945',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215953' where substr('215953',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215961' where substr('215961',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215970' where substr('215970',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215988' where substr('215988',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '215996' where substr('215996',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216003' where substr('216003',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216011' where substr('216011',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216020' where substr('216020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216020' where substr('216020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216020' where substr('216020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216038' where substr('216038',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216046' where substr('216046',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216054' where substr('216054',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216062' where substr('216062',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216070' where substr('216070',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216089' where substr('216089',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216097' where substr('216097',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216100' where substr('216100',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216119' where substr('216119',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216127' where substr('216127',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216135' where substr('216135',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216143' where substr('216143',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216151' where substr('216151',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216160' where substr('216160',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216178' where substr('216178',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216186' where substr('216186',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216194' where substr('216194',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216208' where substr('216208',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216216' where substr('216216',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216224' where substr('216224',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216232' where substr('216232',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216240' where substr('216240',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216259' where substr('216259',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216267' where substr('216267',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216275' where substr('216275',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216283' where substr('216283',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216291' where substr('216291',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216305' where substr('216305',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216313' where substr('216313',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216321' where substr('216321',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216330' where substr('216330',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216348' where substr('216348',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216356' where substr('216356',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216364' where substr('216364',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216372' where substr('216372',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216380' where substr('216380',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216399' where substr('216399',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216402' where substr('216402',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216410' where substr('216410',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216429' where substr('216429',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216437' where substr('216437',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216445' where substr('216445',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216453' where substr('216453',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216461' where substr('216461',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '216470' where substr('216470',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220019' where substr('220019',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220027' where substr('220027',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220035' where substr('220035',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220043' where substr('220043',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220051' where substr('220051',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220060' where substr('220060',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220078' where substr('220078',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220086' where substr('220086',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220108' where substr('220108',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220116' where substr('220116',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220124' where substr('220124',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220132' where substr('220132',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220140' where substr('220140',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220159' where substr('220159',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220167' where substr('220167',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220175' where substr('220175',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220183' where substr('220183',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220191' where substr('220191',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220205' where substr('220205',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220213' where substr('220213',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220221' where substr('220221',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220230' where substr('220230',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220248' where substr('220248',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220256' where substr('220256',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220264' where substr('220264',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220272' where substr('220272',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220280' where substr('220280',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220299' where substr('220299',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220302' where substr('220302',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220310' where substr('220310',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220329' where substr('220329',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220337' where substr('220337',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220345' where substr('220345',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220353' where substr('220353',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220361' where substr('220361',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220370' where substr('220370',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220388' where substr('220388',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220396' where substr('220396',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220400' where substr('220400',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220418' where substr('220418',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220426' where substr('220426',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220434' where substr('220434',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220442' where substr('220442',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220450' where substr('220450',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220469' where substr('220469',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220477' where substr('220477',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220485' where substr('220485',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220493' where substr('220493',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220507' where substr('220507',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220515' where substr('220515',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220523' where substr('220523',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220531' where substr('220531',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220540' where substr('220540',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220558' where substr('220558',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220566' where substr('220566',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220574' where substr('220574',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220582' where substr('220582',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220590' where substr('220590',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220604' where substr('220604',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220612' where substr('220612',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220620' where substr('220620',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220639' where substr('220639',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220647' where substr('220647',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220655' where substr('220655',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220663' where substr('220663',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220671' where substr('220671',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220680' where substr('220680',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220698' where substr('220698',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220701' where substr('220701',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220710' where substr('220710',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220728' where substr('220728',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220736' where substr('220736',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220744' where substr('220744',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220752' where substr('220752',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '220760' where substr('220760',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '230014' where substr('230014',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '230014' where substr('230014',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240010' where substr('240010',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240036' where substr('240036',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240044' where substr('240044',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240060' where substr('240060',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240079' where substr('240079',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240125' where substr('240125',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240141' where substr('240141',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240150' where substr('240150',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240168' where substr('240168',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240184' where substr('240184',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240192' where substr('240192',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240206' where substr('240206',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240214' where substr('240214',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240230' where substr('240230',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240249' where substr('240249',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240257' where substr('240257',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240273' where substr('240273',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240281' where substr('240281',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240290' where substr('240290',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240303' where substr('240303',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '240311' where substr('240311',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250015' where substr('250015',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250023' where substr('250023',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250031' where substr('250031',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250040' where substr('250040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250058' where substr('250058',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250066' where substr('250066',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250074' where substr('250074',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250082' where substr('250082',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250090' where substr('250090',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250104' where substr('250104',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250112' where substr('250112',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250120' where substr('250120',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250139' where substr('250139',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250147' where substr('250147',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250155' where substr('250155',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '250163' where substr('250163',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260010' where substr('260010',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260029' where substr('260029',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260037' where substr('260037',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260045' where substr('260045',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260053' where substr('260053',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260061' where substr('260061',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260070' where substr('260070',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260088' where substr('260088',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260096' where substr('260096',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260118' where substr('260118',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260126' where substr('260126',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260134' where substr('260134',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260142' where substr('260142',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260150' where substr('260150',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260177' where substr('260177',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260185' where substr('260185',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260193' where substr('260193',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260207' where substr('260207',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260215' where substr('260215',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260223' where substr('260223',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260231' where substr('260231',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260240' where substr('260240',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260258' where substr('260258',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260266' where substr('260266',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260274' where substr('260274',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260282' where substr('260282',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260290' where substr('260290',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260304' where substr('260304',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260312' where substr('260312',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260320' where substr('260320',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260339' where substr('260339',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260347' where substr('260347',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260355' where substr('260355',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260363' where substr('260363',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260371' where substr('260371',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260380' where substr('260380',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260398' where substr('260398',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260401' where substr('260401',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260410' where substr('260410',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260428' where substr('260428',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260436' where substr('260436',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260444' where substr('260444',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260452' where substr('260452',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260460' where substr('260460',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260479' where substr('260479',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260487' where substr('260487',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260495' where substr('260495',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260509' where substr('260509',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260517' where substr('260517',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '260525' where substr('260525',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '270016' where substr('270016',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '270024' where substr('270024',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '270032' where substr('270032',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '270040' where substr('270040',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '270059' where substr('270059',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '270067' where substr('270067',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '270075' where substr('270075',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '270083' where substr('270083',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '270091' where substr('270091',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '270105' where substr('270105',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '270113' where substr('270113',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '270121' where substr('270121',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '270130' where substr('270130',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '270148' where substr('270148',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '270156' where substr('270156',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280011' where substr('280011',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280020' where substr('280020',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280038' where substr('280038',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280046' where substr('280046',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280054' where substr('280054',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280062' where substr('280062',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280070' where substr('280070',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280089' where substr('280089',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280097' where substr('280097',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280100' where substr('280100',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280119' where substr('280119',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280127' where substr('280127',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280135' where substr('280135',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280143' where substr('280143',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280151' where substr('280151',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280160' where substr('280160',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280178' where substr('280178',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280186' where substr('280186',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280194' where substr('280194',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280208' where substr('280208',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280216' where substr('280216',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280224' where substr('280224',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280232' where substr('280232',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280240' where substr('280240',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280259' where substr('280259',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280267' where substr('280267',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280275' where substr('280275',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280283' where substr('280283',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280291' where substr('280291',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280305' where substr('280305',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280313' where substr('280313',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280321' where substr('280321',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280330' where substr('280330',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280348' where substr('280348',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280356' where substr('280356',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280364' where substr('280364',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280372' where substr('280372',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280380' where substr('280380',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280399' where substr('280399',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280402' where substr('280402',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280410' where substr('280410',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280429' where substr('280429',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280437' where substr('280437',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280445' where substr('280445',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280453' where substr('280453',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280461' where substr('280461',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280470' where substr('280470',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280488' where substr('280488',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280496' where substr('280496',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280500' where substr('280500',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280518' where substr('280518',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280526' where substr('280526',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280534' where substr('280534',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280542' where substr('280542',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280550' where substr('280550',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280569' where substr('280569',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280577' where substr('280577',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280585' where substr('280585',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280593' where substr('280593',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280607' where substr('280607',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280615' where substr('280615',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280623' where substr('280623',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280631' where substr('280631',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280640' where substr('280640',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280658' where substr('280658',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280666' where substr('280666',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280674' where substr('280674',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280682' where substr('280682',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280690' where substr('280690',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280704' where substr('280704',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280712' where substr('280712',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280720' where substr('280720',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280739' where substr('280739',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280747' where substr('280747',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280755' where substr('280755',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280763' where substr('280763',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280771' where substr('280771',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280780' where substr('280780',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280798' where substr('280798',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280801' where substr('280801',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280810' where substr('280810',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280828' where substr('280828',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280836' where substr('280836',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280844' where substr('280844',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280852' where substr('280852',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280860' where substr('280860',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280879' where substr('280879',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280887' where substr('280887',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280895' where substr('280895',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280909' where substr('280909',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280917' where substr('280917',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280925' where substr('280925',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280933' where substr('280933',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280941' where substr('280941',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280950' where substr('280950',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280968' where substr('280968',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280976' where substr('280976',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280984' where substr('280984',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '280992' where substr('280992',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281000' where substr('281000',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281018' where substr('281018',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281026' where substr('281026',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281034' where substr('281034',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281042' where substr('281042',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281050' where substr('281050',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281069' where substr('281069',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281077' where substr('281077',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281085' where substr('281085',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281093' where substr('281093',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281107' where substr('281107',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281115' where substr('281115',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281123' where substr('281123',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281131' where substr('281131',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281140' where substr('281140',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281158' where substr('281158',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281166' where substr('281166',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281174' where substr('281174',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281182' where substr('281182',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281190' where substr('281190',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281204' where substr('281204',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281212' where substr('281212',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281247' where substr('281247',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281255' where substr('281255',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281263' where substr('281263',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281271' where substr('281271',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281280' where substr('281280',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281298' where substr('281298',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281301' where substr('281301',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281310' where substr('281310',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281328' where substr('281328',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281336' where substr('281336',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281344' where substr('281344',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281352' where substr('281352',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281360' where substr('281360',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281379' where substr('281379',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281387' where substr('281387',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281395' where substr('281395',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281409' where substr('281409',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;
 update cadendermunicipiosistema set db125_codigosistema = '281417' where substr('281417',1,5) = substr(db125_codigosistema,1,5) and db125_db_sistemaexterno = 1;

---------------------------------------------------------------------------------------------
-------------------------------- FIM TRIBUTÁRIO  --------------------------------------------
---------------------------------------------------------------------------------------------

ALTER TABLE db_relatorio ALTER COLUMN db63_nomerelatorio TYPE VARCHAR(100);

---------------------------------------------------------------------------------------------
-------------------------------- INICIO TIME NOTA -------------------------------------------
---------------------------------------------------------------------------------------------

-- Adiciona gráfica padrão para requisições AIDOF no nota
INSERT INTO graficas (y20_grafica, y20_id_usuario, y20_data)
     SELECT numcgm,
            1 AS usuario_dbseller,
            CURRENT_DATE AS DATA
       FROM db_config
      WHERE NOT EXISTS
            (SELECT *
               FROM graficas
              WHERE y20_grafica IN
                   (SELECT numcgm
                      FROM db_config
                     WHERE prefeitura IS TRUE))
        AND prefeitura IS TRUE;

---------------------------------------------------------------------------------------------
-------------------------------- FIM TIME NOTA ----------------------------------------------
---------------------------------------------------------------------------------------------

alter table veicretirada add column ve60_passageiro text default null,
                         alter column ve60_destino type text;