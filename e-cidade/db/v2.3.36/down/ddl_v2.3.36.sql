/**
 * Tributario
 */
DROP TABLE IF EXISTS zonassetorvalor CASCADE;
DROP SEQUENCE IF EXISTS zonassetorvalor_j141_sequencial_seq;

DELETE FROM db_sysfuncoesparam WHERE db42_funcao IN (172, 173);
DELETE FROM db_sysfuncoes      WHERE codfuncao   IN (172, 173);

update iptucadlogcalc SET j62_descr = 'VERIFIQUE A TESTADA CADASTRADA PARA ESTA MATRÍCULA' where j62_codigo = 111;
update iptucadlogcalc SET j62_descr = 'NÃO HÁ VALOR DO METRO QUADRADO PARA O EXERCÍCIO' where j62_codigo = 110;
update iptucadlogcalc SET j62_descr = 'NÃO HÁ FATOR DE DEPRECIAÇÃO PARA O EXERCÍCIO' where j62_codigo = 109;
delete from iptucadlogcalc where j62_codigo = 113;

select fc_executa_ddl('drop index issconfiguracaogruposervico_issgruposervico_exercicio_in;');
/**
 * Fim Tributario
 */

-------------------------------
------ INÍCIO TIME FOLHA ------
-------------------------------
ALTER TABLE rhpessoalmov drop column if exists rh02_abonopermanencia;

ALTER TABLE cfpess drop column if exists r11_suplementar;

DROP TABLE IF EXISTS rhconsignadomovimentoservidorrubrica CASCADE;
DROP TABLE IF EXISTS rhconsignadomovimentoservidor CASCADE;
DROP TABLE IF EXISTS rhconsignadomovimento CASCADE;
DROP TABLE IF EXISTS rhconsignadomotivo CASCADE;

DROP SEQUENCE IF EXISTS rhconsignadomovimentoservidorrubrica_rh153_sequencial_seq;
DROP SEQUENCE IF EXISTS rhconsignadomovimentoservidor_rh152_sequencial_seq;
DROP SEQUENCE IF EXISTS rhconsignadomovimento_rh151_sequencial_seq;
DROP SEQUENCE IF EXISTS rhconsignadomotivo_rh154_sequencial_seq;
-------------------------------
------- FIM TIME FOLHA --------
-------------------------------

------------------------------------------
------------------- TIME C ---------------
------------------------------------------

ALTER TABLE tipoausencia drop column if exists ed320_licenca;
ALTER TABLE sau_config drop column if exists s103_obrigarcns;

-------------------------------------------------------
------------- TAREFA TIPO HORA INICIO -----------------
-------------------------------------------------------
alter table rechumanoativ     drop column if exists ed22_ativo;
alter table rechumanohoradisp drop column if exists ed33_tipohoratrabalho;
alter table relacaotrabalho   drop column if exists ed23_tipohoratrabalho;
alter table relacaotrabalho   drop column if exists ed23_ativo;

DROP TABLE IF EXISTS agendaatividade CASCADE;
DROP TABLE IF EXISTS tipohoratrabalho CASCADE;
DROP SEQUENCE IF EXISTS agendaatividade_ed129_codigo_seq;
DROP SEQUENCE IF EXISTS tipohoratrabalho_ed128_codigo_seq;

delete from horarioescola where ed123_escola in ( select ed123_escola from w_horariosfuncionamento );
-------------------------------------------------------
-------------- TAREFA TIPO HORA FIM -------------------
-------------------------------------------------------


------------------------------------------
--------------- FIM TIME C ---------------
------------------------------------------