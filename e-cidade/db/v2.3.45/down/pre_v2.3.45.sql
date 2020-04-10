---------------------------------------------------------------------------------------------------
----------------------------------- INICIO EDUCACAO/SAUDE -----------------------------------------
---------------------------------------------------------------------------------------------------

select fc_executa_ddl('delete from db_menu where id_item_filho = 10186 AND modulo = 1100747');
select fc_executa_ddl('delete from db_menu where id_item_filho = 10186 AND modulo = 7159');
select fc_executa_ddl('delete from db_menu where id_item_filho = 10185 AND modulo = 1100747');
select fc_executa_ddl('delete from db_menu where id_item_filho = 10185 AND modulo = 7159');
select fc_executa_ddl('delete from db_itensmenu where id_item in( 10185, 10186 )');

delete from db_sysarqcamp where codarq = 1008014 and codcam = 21639;
delete from db_syscampo where codcam = 21639;

--biblioteca
delete from db_sysarqcamp where codarq = 1010151 and codcam = 21640;
delete from db_syscampo   where codcam = 21640;

-- Exclusao do modulo  PSF
delete from db_menu         where modulo  = 10191;
delete from atendcadareamod where at26_id_item = 10191;
delete from db_modulos      where id_item = 10191;
delete from db_itensmenu    where id_item = 10191;

---------------------------------------------------------------------------------------------------
----------------------------------- FIM EDUCACAO/SAUDE --------------------------------------------
---------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------
-------------------------------- INCIO FINANCEIRO -------------------------------------------
---------------------------------------------------------------------------------------------

delete from db_menu where id_item_filho = 10187;
delete from db_itensfilho where id_item = 10187;
delete from db_itensmenu where id_item = 10187;

-- Anexo 9 RREO
delete from orcparamseqfiltropadrao where o132_orcparamrel = 159;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 159;
delete from orcparamseq where o69_codparamrel = 159;
delete from orcparamrelperiodos where o113_orcparamrel = 159;
delete from orcparamrel where o42_codparrel = 159;

-- Menu Anexo I-D
delete from db_itensmenu where id_item in (10188, 10189);
delete from db_menu where id_item_filho = 10188 AND modulo = 209;
delete from db_menu where id_item_filho = 10189 AND modulo = 209;

-- Menu Anexo I-F
delete from db_menu where id_item_filho = 10190 AND modulo = 209;
delete from db_itensmenu where id_item = 10190;

-- Anexo I-F
delete from orcparamseqfiltropadrao      where o132_orcparamrel = 157;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 157;
delete from orcparamseq                  where o69_codparamrel  = 157;
delete from orcparamrelperiodos          where o113_orcparamrel = 157;
delete from orcparamrel                  where o42_codparrel    = 157;

-- Anexo I-G
delete from orcparamseqfiltropadrao      where o132_orcparamrel = 158;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 158;
delete from orcparamseq                  where o69_codparamrel  = 158;
delete from orcparamrelperiodos          where o113_orcparamrel = 158;
delete from orcparamrel                  where o42_codparrel    = 158;

-- Colunas relatório SICONFI
delete from orcparamseqcoluna where o115_sequencial in(203, 204, 205, 206);

-- Menu Anexo I-G
delete from db_menu where id_item_filho = 10193 AND modulo = 209;
delete from db_itensmenu where id_item = 10193;

delete from orcparamseqfiltropadrao where o132_orcparamrel = 160;
delete from orcparamseqorcparamseqcoluna where o116_codparamrel = 160;
delete from orcparamseq where o69_codparamrel = 160;
delete from orcparamrelperiodos where o113_orcparamrel = 160;
delete from orcparamrel where o42_codparrel = 160;

---------------------------------------------------------------------------------------------
-------------------------------- FIM FINANCEIRO ---------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-------------------------------- INICIO TRIBUTARIO ------------------------------------------
---------------------------------------------------------------------------------------------

delete from db_sysarqcamp where codcam = 21641;
delete from db_syscampo   where codcam = 21641;

---------------------------------------------------------------------------------------------
-------------------------------- FIM TRIBUTARIO ---------------------------------------------
---------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
------------------------------- INICIO FOLHA ------------------------------------------------
---------------------------------------------------------------------------------------------

delete from db_sysarqcamp where codcam in(21642, 21643, 21644, 21645);
delete from db_syscampo where codcam in(21642, 21643, 21644, 21645);
delete from db_menu where id_item_filho = 10194 AND modulo = 952;
delete from db_itensmenu where id_item = 10194;

delete from rhdirftipovalor where rh97_sequencial in (17,18,19,20,21,22,23);

delete from db_layoutcampos where db52_layoutlinha in (756, 757, 758);
delete from db_layoutlinha where db51_codigo in (756, 757, 758);
---------------------------------------------------------------------------------------------
------------------------------- FIM FOLHA ---------------------------------------------------
---------------------------------------------------------------------------------------------
