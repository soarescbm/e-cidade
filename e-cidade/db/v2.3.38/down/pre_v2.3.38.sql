------------------------------------------------------------------------------------
------------------------------ INICIO TIME C ---------------------------------------
------------------------------------------------------------------------------------

DELETE FROM db_relatorio where db63_db_gruporelatorio = 4 and db63_db_tiporelatorio = 1 and db63_nomerelatorio = 'Cubo Alunos Matriculados';
delete from db_gruporelatorio where db13_sequencial = 4;

delete from db_menu      where id_item = 32 and id_item_filho = 10065;
delete from db_itensmenu where id_item = 10065;

delete from db_menu      where id_item = 1818 and id_item_filho = 10076;
delete from db_itensmenu where id_item = 10076;

update db_itensmenu set libcliente = bkp_menus_bloquear_modulo_vacina.libcliente
  from bkp_menus_bloquear_modulo_vacina
 where db_itensmenu.id_item = bkp_menus_bloquear_modulo_vacina.id_item;

delete from db_sysarqcamp where codcam = 21191;
delete from db_syscampo where codcam = 21191;

delete from db_menu where id_item_filho = 10080 AND modulo = 7159;
delete from db_itensmenu where id_item = 10080;

delete from db_menu where id_item_filho = 10081 AND modulo = 7159;
delete from db_itensmenu where id_item = 10081;

delete from db_sysarqcamp where codcam = 21203;
delete from db_syscampo where codcam = 21203;

delete from censolinguaindig where ed264_i_codigo = 389;

delete from db_layoutcampos where db52_codigo = 12057;

-- layout - codigo inep aluno - 2015
delete from db_layoutcampos where db52_layoutlinha = 747;
delete from db_layoutlinha  where db51_codigo      = 747;
delete from db_layouttxt    where db50_codigo      = 228;

------------------------------------------------------------------------------------
------------------------------ FIM TIME C ------------------------------------------
------------------------------------------------------------------------------------

------------------------------------------------------------------------------------
------------------------------ TRIBUTARIO ------------------------------------------
------------------------------------------------------------------------------------

delete from db_syssequencia where codsequencia = 1000465;
delete from db_syscadind where codind = 4211;
delete from db_sysindices where codind = 4211;
delete from db_sysforkey where codarq = 3808;
delete from db_sysprikey where codarq = 3808;
delete from db_sysarqcamp where codarq = 3808;
delete from db_syscampo where codcam in (21147, 21148, 21149, 21150, 21151, 21152, 21153, 21172, 21184, 21185, 21186, 21187, 21188);
delete from db_sysarqmod where codarq = 3808;
delete from db_sysarquivo where codarq = 3808;

delete from db_menu where id_item_filho = 10067 AND modulo = 81;
delete from db_menu where id_item_filho = 10067 AND modulo = 209;
delete from db_itensmenu where id_item  = 10067;

----------------------------------------------------------------------------------------
------------------------------ FIM TRIBUTARIO ------------------------------------------
----------------------------------------------------------------------------------------



----------------------------------------------------------------------------------------
------------------------------- INÍCIO FOLHA -------------------------------------------
----------------------------------------------------------------------------------------
------Excluindo menu
--------------------
delete from db_menu where id_item_filho = 10066 AND modulo = 952;
delete from db_itensmenu where id_item = 10066;

----Excluindo colunas da tabela cfpess que guardam rubricas de substituicao
---------------------------------------------------------------------------
delete from db_sysarqcamp where codarq = 536 and codcam = 21171;
delete from db_sysarqcamp where codarq = 536 and codcam = 21170;
delete from db_syscampo where codcam = 21171;
delete from db_syscampo where codcam = 21170;

----Desvinculando FK a tabela tipoasse à tabela naturezatipoassentamento
------------------------------------------------------------------------
delete from db_sysforkey where codarq = 596 and codcam = 21167 and sequen = 1 and referen = 3810;
delete from db_sysarqcamp where codarq = 596 and codcam = 21167 and seqarq = 16;
delete from db_syscampodef where codcam = 21167;
delete from db_syscampo where codcam = 21167;

----Excluindo sequences
-----------------------
delete from db_sysarqcamp where codsequencia = 1000470 and codarq = 3811 and codcam = 21162;
delete from db_sysarqcamp where codsequencia = 1000467 and codarq = 3810 and codcam = 21160;
delete from db_sysarqcamp where codsequencia = 1000466 and codarq = 3809 and codcam = 21154;
delete from db_syssequencia where codsequencia = 1000472;
delete from db_syssequencia where codsequencia = 1000470;
delete from db_syssequencia where codsequencia = 1000467;
delete from db_syssequencia where codsequencia = 1000466;


----Excluindo chaves primárias
------------------------------
delete from db_sysprikey where codarq = 3815;
delete from db_sysprikey where codarq = 3812 and codcam = 21165;
delete from db_sysprikey where codarq = 3811 and codcam = 21162;
delete from db_sysprikey where codarq = 3810 and codcam = 21160;
delete from db_sysprikey where codarq = 3809 and codcam = 21154;

----Excluindo chaves estrangeiras
---------------------------------
delete from db_sysforkey where codarq = 3815;
delete from db_sysforkey where codarq = 3812;
delete from db_sysforkey where codarq = 3811;
delete from db_sysforkey where codarq = 3809;

----Excluindo indices
---------------------
delete from db_syscadind where codind = 4219;
delete from db_syscadind where codind = 4215 and codcam = 21166;
delete from db_syscadind where codind = 4215 and codcam = 21165;
delete from db_syscadind where codind = 4214 and codcam = 21164;
delete from db_syscadind where codind = 4214 and codcam = 21163;
delete from db_syscadind where codind = 4213 and codcam = 21160;
delete from db_syscadind where codind = 4212;
delete from db_sysindices where codind = 4219;
delete from db_sysindices where codind = 4215;
delete from db_sysindices where codind = 4214;
delete from db_sysindices where codind = 4213;
delete from db_sysindices where codind = 4212;

-----Desvinculando campos
delete from db_sysarqcamp where codarq = 3815;
delete from db_sysarqcamp where codarq = 3812;
delete from db_sysarqcamp where codarq = 3811;
delete from db_sysarqcamp where codarq = 3810;
delete from db_sysarqcamp where codarq = 3809;
-----Excluindo campos
delete from db_syscampo where codcam = 21183;
delete from db_syscampo where codcam = 21182;
delete from db_syscampo where codcam = 21181;
delete from db_syscampo where codcam = 21166;
delete from db_syscampo where codcam = 21165;
delete from db_syscampo where codcam = 21164;
delete from db_syscampo where codcam = 21163;
delete from db_syscampo where codcam = 21162;
delete from db_syscampo where codcam = 21161;
delete from db_syscampo where codcam = 21160;
delete from db_syscampo where codcam = 21174;
delete from db_syscampo where codcam = 21173;
delete from db_syscampo where codcam = 21159;
delete from db_syscampo where codcam = 21157;
delete from db_syscampo where codcam = 21156;
delete from db_syscampo where codcam = 21155;
delete from db_syscampo where codcam = 21154;
-----Desvinculando tabela do módulo
delete from db_sysarqmod where codmod = 28 and codarq = 3815;
delete from db_sysarqmod where codmod = 28 and codarq = 3812;
delete from db_sysarqmod where codmod = 28 and codarq = 3811;
delete from db_sysarqmod where codmod = 28 and codarq = 3810;
delete from db_sysarqmod where codmod = 28 and codarq = 3809;
-----Excluindo tabelas
delete from db_sysarquivo where codarq = 3815;
delete from db_sysarquivo where codarq = 3812;
delete from db_sysarquivo where codarq = 3811;
delete from db_sysarquivo where codarq = 3810;
delete from db_sysarquivo where codarq = 3809;

------removendo dados das tabelas para contrato emergencial.
------------------------------------------------------------
delete from db_sysarqcamp   where codarq in (3816, 3817);
delete from db_syssequencia where codsequencia in (1000473, 1000474);
delete from db_sysprikey    where codarq in (3816,3817);
delete from db_sysforkey    where codarq = 3817;
delete from db_syscampo     where codcam in (21194, 21195, 21196, 21197, 21198, 21199, 21200);
delete from db_sysarqmod    where codarq in (3816, 3817);
delete from db_sysarquivo   where codarq in (3816, 3817);

--Excluindo Menu
delete from db_itensmenu where id_item = 10082;
delete from db_menu where id_item_filho = 10082 AND modulo = 952;
delete from db_itensmenu where id_item = 10083;
delete from db_menu where id_item_filho = 10083 AND modulo = 952;

-- Exclu o relatorio de contratos emergenciais
delete from db_relatorio where db63_sequencial = 29;

----------------------------------------------------------------------------------------
---------------------------------- FIM FOLHA -------------------------------------------
----------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------
---------------------------------- INICIO FINANCEIRO -----------------------------------
----------------------------------------------------------------------------------------

select fc_executa_ddl('
  delete from db_menu where id_item_filho in (10068, 10069, 10070, 10071, 10072, 10073, 10074, 10075);
  delete from db_itensfilho where id_item in (10069, 10070, 10071, 10073, 10074, 10075);
  delete from db_itensmenu where id_item in (10068, 10069, 10070, 10071, 10072, 10073, 10074, 10075);
');


update orcparamseq set o69_descr = 'AMPARADAS PELO ART. 9-N DA RESOLUÇÃO Nº 2.827/01, DO CMNv',
                       o69_labelrel = 'Amparadas pelo art. 9-N da Resolução nº 2.827/01, do CMN'
             where o69_codparamrel = 92 and o69_ordem = 17;

update db_syscampo set aceitatipo = 0 where codcam = 5453;

update db_syscampo set rotulo = 'Data' where nomecam = 'm40_data';
update db_syscampo set rotulo = 'Hora' where nomecam = 'm40_hora';

----------------------------------------------------------------------------------------
---------------------------------- FIM FINANCEIRO --------------------------------------
----------------------------------------------------------------------------------------