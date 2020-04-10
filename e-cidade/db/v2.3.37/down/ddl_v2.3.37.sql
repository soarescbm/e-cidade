-------------------------------
------ INÍCIO TIME FOLHA ------
-------------------------------
select fc_executa_ddl('ALTER TABLE rhprepontoloteregistroponto DROP CONSTRAINT rh156_rhpreponto_fk;');
select fc_executa_ddl('ALTER TABLE rhpreponto DROP CONSTRAINT rh149_sequencial_pk;');
select fc_executa_ddl('ALTER TABLE rhpreponto DROP COLUMN rh149_sequencial;');
select fc_executa_ddl('ALTER TABLE rhpreponto DROP COLUMN rh149_competencia;');

DROP TABLE IF EXISTS loteregistroponto CASCADE;
DROP TABLE IF EXISTS rhprepontoloteregistroponto;
DROP TABLE IF EXISTS db_usuariosrhlota;

DROP SEQUENCE IF EXISTS loteregistroponto_rh155_sequencial_seq;
DROP SEQUENCE IF EXISTS rhprepontoloteregistroponto_rh156_sequencial_seq;
DROP SEQUENCE IF EXISTS rhpreponto_rh149_sequencial_seq;
DROP SEQUENCE IF EXISTS db_usuariosrhlota_rh157_sequencial_seq;

-------------------------------
------- FIM TIME FOLHA --------
-------------------------------

------------------------------------------------------------------------------------
---------------------------------- TIME C ------------------------------------------
------------------------------------------------------------------------------------

update turma
   set ed57_i_censoetapa = de
  from turmacensoetapa
 inner join de_para_etapa_censo on ed132_censoetapa = para
 where ed132_turma = ed57_i_codigo;

update censoetapa
   set ed266_c_regular = ed131_regular, ed266_c_especial = ed131_especial, ed266_c_eja = ed131_eja
  from censoetapamediacaodidaticopedagogica
 where ed131_censoetapa = ed266_i_codigo;

DROP TABLE IF EXISTS censoetapamediacaodidaticopedagogica CASCADE;
DROP TABLE IF EXISTS censoetapaturmacenso CASCADE;
DROP TABLE IF EXISTS mediacaodidaticopedagogica CASCADE;
DROP TABLE IF EXISTS seriecensoetapa CASCADE;
DROP TABLE IF EXISTS turmacensoetapa CASCADE;
DROP TABLE IF EXISTS de_para_etapa_censo;

DROP SEQUENCE IF EXISTS censoetapamediacaodidaticopedagogica_ed131_codigo_seq;
DROP SEQUENCE IF EXISTS censoetapaturmacenso_ed134_codigo_seq;
DROP SEQUENCE IF EXISTS mediacaodidaticopedagogica_ed130_codigo_seq;
DROP SEQUENCE IF EXISTS seriecensoetapa_ed133_codigo_seq;
DROP SEQUENCE IF EXISTS turmacensoetapa_ed132_codigo_seq;


delete from censoregradisc where ed272_ano = 2015;
delete from censoetapa     where ed266_ano = 2015;
alter table censoregradisc drop constraint if exists censoregradisc_censoetapa_ano_fk;
alter table censoetapa drop constraint censoetapa_codi_ano_pk;
alter table censoetapa add  constraint censoetapa_pkey primary key (ed266_i_codigo);

alter table serie          add constraint serie_censoetapa_fk foreign key (ed11_i_codcenso)   references censoetapa (ed266_i_codigo);
alter table turma          add constraint turma_censoetapa_fk foreign key (ed57_i_censoetapa) references censoetapa (ed266_i_codigo);
alter table turmacenso     add constraint turmacenso_censoetapa_fk foreign key (ed342_censoetapa) references censoetapa (ed266_i_codigo);
alter table censoregradisc add constraint censoregradisc_censoetapa_fk foreign key (ed272_i_censoetapa) references censoetapa;

alter table ensino         drop column ed10_mediacaodidaticopedagogica;
alter table censoetapa     drop column ed266_ano;
alter table censoregradisc drop column ed272_ano;

-- Tabela de Dependencias Existentes na Escola
update avaliacaoperguntaopcao set db104_descricao = 'Sanitário para alunos com deficiência'
  where db104_sequencial = 3000015;

update avaliacaoperguntaopcao set db104_descricao = 'Sanitário adequadro à Educação Infantil'
  where db104_sequencial = 3000014;

update avaliacaoperguntaopcao set db104_descricao = 'Sanitário dentro do Prédio'
  where db104_sequencial = 3000013;

update avaliacaoperguntaopcao set db104_descricao = 'Sanitário fora do Prédio'
  where db104_sequencial = 3000012;

update avaliacaoperguntaopcao set db104_descricao = 'Banheiro adequad a alunos com defici ou mobil redu'
  where db104_sequencial = 3000126;

update avaliacaoperguntaopcao set db104_descricao = 'Laboratório de Ciências'
  where db104_sequencial = 3000003;

update avaliacaoperguntaopcao set db104_descricao = 'Laboratório de Informática'
  where db104_sequencial = 3000002;

update avaliacaoperguntaopcao set db104_descricao = 'Parque Infantil'
  where db104_sequencial = 3000010;

update avaliacaoperguntaopcao set db104_descricao = 'Pátio Coberto'
  where db104_sequencial = 3000023;

update avaliacaoperguntaopcao set db104_descricao = 'Pátio Descoberto'
  where db104_sequencial = 3000024;

update avaliacaoperguntaopcao set db104_descricao = 'Quadra de Esportes Coberta'
  where db104_sequencial = 3000005;

update avaliacaoperguntaopcao set db104_descricao = 'Quadra de Esportes Descoberta'
  where db104_sequencial = 3000006;

update avaliacaoperguntaopcao set db104_descricao = 'Diretoria'
  where db104_sequencial = 3000000;

update avaliacaoperguntaopcao set db104_descricao = 'Sala de Leitura'
  where db104_sequencial = 3000009;

update avaliacaoperguntaopcao set db104_descricao = 'Sala dos Professores'
  where db104_sequencial = 3000001;

update avaliacaoperguntaopcao set db104_descricao = 'Sala de recursos multifuncionais para AEE'
  where db104_sequencial = 3000004;

update avaliacaoperguntaopcao set db104_descricao = 'Sala de Secretária'
  where db104_sequencial = 3000017;

update avaliacaoperguntaopcao set db104_descricao = ' Nenhuma das dependências relacionadas'
  where db104_sequencial = 3000016;

-- retorno das descrições, códigos e tipo referentes ao ano anterior dos cursos profissionais do censo
update censocursoprofiss set ed247_c_descr = 'BIBLIOTECA' where ed247_i_codigo = 2030;
update censocursoprofiss set ed247_c_descr = 'TREINAMENTO DE CAES-GUIA' where ed247_i_codigo = 2038;
update censocursoprofiss set ed247_c_descr = 'MAQUINAS NAVAIS' where ed247_i_codigo = 3042;
update censocursoprofiss set ed247_c_descr = 'MANUTENCAO METROFERROVIARIA' where ed247_i_codigo = 3054;
update censocursoprofiss set ed247_c_descr = 'SERVICOS DE CONDOMINIO' where ed247_i_codigo = 4062;
update censocursoprofiss set ed247_c_descr = 'SERVICOS DE RESTAURANTE E BAR' where ed247_i_codigo = 5072;
update censocursoprofiss set ed247_c_descr = 'ARTE CIRCENSE' where ed247_i_codigo = 10128;
update censocursoprofiss set ed247_c_descr = 'ARTE DRAMATICA' where ed247_i_codigo = 10129;

delete from censocursoprofiss where ed247_i_codigo in( 2039, 3060, 6082, 8133, 10157, 12186, 12187 );

update censocursoprofiss set ed247_i_codigo = 1003, ed247_i_tipo = 1 where ed247_i_codigo = 11173;
update censocursoprofiss set ed247_i_codigo = 3035, ed247_i_tipo = 2 where ed247_i_codigo = 11172;
update censocursoprofiss set ed247_i_codigo = 3046, ed247_i_tipo = 2 where ed247_i_codigo = 11174;
update censocursoprofiss set ed247_i_codigo = 3047, ed247_i_tipo = 2 where ed247_i_codigo = 11175;

delete from censoativcompl
      where ed133_i_codigo in( 15006, 17003, 31015, 13106, 13107, 13108, 15101, 15999, 16101, 16102, 16103, 16104, 16105, 16999 );

update censoativcompl
   set ed133_c_descr = 'ORIENTACAO DE ESTUDOS E LEITURA'
 where ed133_i_codigo = 31014;
update censoativcompl
   set ed133_c_descr = 'COM-VIDA (ORGANIZACAO DE COLETIVOS PRO-MEIO AMBIENTE)'
 where ed133_i_codigo = 13101;
update censoativcompl
   set ed133_c_descr = 'OUTRA CATEGORIA DE EDUCACAO AMBIENTAL, DESENVOLVIMENTO SUSTENTAVEL E ECONOMIA SOLIDARIA E CRIATIVA/EDUCACAO ECONOMICA/AGROECOLOGIA'
 where ed133_i_codigo = 13999;
update censoativcompl
   set ed133_c_descr = 'ESPORTE NA ESCOLA/ATLETISMO E MULTIPLAS VIVENCIAS ESPORTIVAS'
 where ed133_i_codigo = 22017;

update turmaacativ
   set ed267_i_censoativcompl = 91002
  from turmaac, calendario
 where ed267_i_turmaac        = ed268_i_codigo
   and ed52_i_codigo          = ed268_i_calendario
   and ed52_i_ano             = 2015
   and ed267_i_censoativcompl = 22017;

ALTER TABLE    tipohoratrabalho add column ed128_escola int4;
update tipohoratrabalho set ed128_descricao = (select ed128_descricao
                                                     from w_migracao_tipohoratrabalho
                                                     where tipohoratrabalho.ed128_codigo = w_migracao_tipohoratrabalho.ed128_codigo),
                            ed128_escola    = (select ed128_escola
                                                     from w_migracao_tipohoratrabalho
                                                     where tipohoratrabalho.ed128_codigo = w_migracao_tipohoratrabalho.ed128_codigo);
INSERT INTO tipohoratrabalho
SELECT * FROM w_migracao_tipohoratrabalho
WHERE
    NOT EXISTS (
        SELECT ed128_codigo FROM tipohoratrabalho WHERE tipohoratrabalho.ed128_codigo = w_migracao_tipohoratrabalho.ed128_codigo
    );
update agendaatividade set ed129_tipohoratrabalho = (select ed129_tipohoratrabalho
                                                     from w_migracao_agendaatividade
                                                     where agendaatividade.ed129_codigo = w_migracao_agendaatividade.ed129_codigo);
update rechumanohoradisp set ed33_tipohoratrabalho = (select ed33_tipohoratrabalho
                                                     from w_migracao_rechumanohoradisp
                                                     where rechumanohoradisp.ed33_i_codigo = w_migracao_rechumanohoradisp.ed33_i_codigo);
update relacaotrabalho set ed23_tipohoratrabalho = (select ed23_tipohoratrabalho
                                                     from w_migracao_relacaotrabalho
                                                     where relacaotrabalho.ed23_i_codigo = w_migracao_relacaotrabalho.ed23_i_codigo);


alter table ambulatorial.cgs_und alter COLUMN z01_v_nome type  varchar(40);
alter table ambulatorial.cgs_und alter COLUMN z01_v_mae type   varchar(40);
alter table ambulatorial.cgs_und alter COLUMN z01_c_pis type   varchar(10);
alter table ambulatorial.cgs_und alter COLUMN z01_v_email type varchar(40);
alter table ambulatorial.sau_cgserrado alter COLUMN s128_v_nome type  varchar(40);

-- campo cnpj na unidade
alter table ambulatorial.unidades drop column sd02_cnpjcpf;


-- consulta tfd
alter table tfd_situacaopedidotfd DISABLE TRIGGER tg_atualizasituacaopedidotfd;
insert into tfd_situacaotfd values (3, 'VIAJOU');

update tfd_situacaopedidotfd set tf28_c_obs = obs
  from bkp_tfd_situacaopedidotfd
 where tf28_i_codigo = codigo;

update tfd_situacaopedidotfd set tf28_i_situacao = situacao
  from bkp_tfd_situacaopedidotfd
 where tf28_i_codigo = codigo;

alter table tfd_situacaopedidotfd enable trigger tg_atualizasituacaopedidotfd;
drop table bkp_tfd_situacaopedidotfd;
alter table tfd_situacaopedidotfd enable trigger tg_atualizasituacaopedidotfd;

ALTER TABLE rechumanohoradisp DROP COLUMN ed33_horaatividade;
------------------------------------------------------------------------------------
------------------------------ FIM TIME C ------------------------------------------
------------------------------------------------------------------------------------


------------------------------------------------------------------------------------
------------------------------ TRIBUTARIO ------------------------------------------
------------------------------------------------------------------------------------
DROP TABLE IF EXISTS issarquivoretencao CASCADE;
DROP TABLE IF EXISTS issarquivoretencaoregistro CASCADE;
DROP TABLE IF EXISTS issarquivoretencaoregistrodisbanco CASCADE;
DROP TABLE IF EXISTS issarquivoretencaoregistroissbase CASCADE;
DROP TABLE IF EXISTS issarquivoretencaoregistroissplan CASCADE;
DROP SEQUENCE IF EXISTS issarquivoretencao_q90_sequencial_seq;
DROP SEQUENCE IF EXISTS issarquivoretencaoregistro_q91_sequencial_seq;
DROP SEQUENCE IF EXISTS issarquivoretencaoregistrodisbanco_q94_sequencial_seq;
DROP SEQUENCE IF EXISTS issarquivoretencaoregistroissbase_q128_sequencial_seq;
DROP SEQUENCE IF EXISTS issarquivoretencaoregistroissplan_q137_sequencial_seq;

DROP TABLE IF EXISTS issarquivoretencaodisarq CASCADE;
DROP SEQUENCE IF EXISTS issarquivoretencaodisarq_q145_sequencial_seq;

DROP TABLE    IF EXISTS issarquivoretencaoregistroissvar CASCADE;
DROP SEQUENCE IF EXISTS issarquivoretencaoregistroissvar_q146_sequencial_seq;

update criterioatividadeimpacto set am01_descricao = substr(am01_descricao,0,50) where length(am01_descricao) > 50;
alter table criterioatividadeimpacto alter column am01_descricao type varchar(50);

alter table empreendimento drop column am05_protprocesso;

TRUNCATE criterioatividadeimpacto cascade;

delete from db_sysfuncoesparam where db42_funcao in (174, 175, 176, 177);
delete from db_sysfuncoes      where codfuncao   in (174, 175, 176, 177);
----------------------------------------------------------------------------------------
------------------------------ FIM TRIBUTARIO ------------------------------------------
----------------------------------------------------------------------------------------