delete from db_layoutcampos where db52_layoutlinha in (808,809);
delete from db_layoutlinha where db51_layouttxt in (240);
delete from db_layouttxt where db50_codigo in (240);

-- ITEM
delete from db_sysarqcamp where codarq = 1017 and codcam = 21766;
delete from db_syscampo   where codcam = 21766;

delete from db_sysarqcamp where codarq = 863 and codcam = 21769;
delete from db_syscampo   where codcam = 21769;

delete from db_sysarqcamp where codarq = 863 and codcam = 21770;
delete from db_syscampo   where codcam = 21770;

delete from db_sysarqcamp where codarq = 863 and codcam = 21784;
delete from db_syscampo where codcam = 21784;

-- Licitacon - ITEM
delete from db_layoutcampos where db52_layoutlinha in (810,811);
delete from db_layoutlinha where db51_layouttxt in (241);
delete from db_layouttxt where db50_codigo in (241);

delete from db_layoutcampos where db52_layoutlinha in (813,814);
delete from db_layoutlinha where db51_layouttxt in (242);
delete from db_layouttxt where db50_codigo in (242);

delete from db_layoutcampos where db52_layoutlinha in (815,816);
delete from db_layoutlinha where db51_layouttxt in (243);
delete from db_layouttxt where db50_codigo in (243);

delete from db_sysarqcamp where codarq = 863 and codcam = 21785;
delete from db_syscampo   where codcam = 21785;

/* Itens de Menu - Reserva de Cotas / Tratamento Diferenciado */
delete from db_menu where id_item_filho = 10215 and modulo = 381;
delete from db_itensmenu where id_item = 10215;

/* Tabela Reserva de Cotas da Licitação */
delete from db_sysindices where codind = 4332 and codarq = 3922;
delete from db_syscadind where codind = 4332 and codcam = 21787;
delete from db_sysindices where codind = 4333 and codarq = 3922;
delete from db_syscadind where codind = 4333 and codcam = 21788;
delete from db_sysforkey where codcam = 21787;
delete from db_sysforkey where codcam = 21788;
delete from db_syssequencia where codsequencia = 1000557;
delete from db_sysprikey where codarq = 3922;
delete from db_sysarqcamp where codarq = 3922 and codcam = 21788;
delete from db_syscampo where codcam = 21788;
delete from db_sysarqcamp where codarq = 3922 and codcam = 21787;
delete from db_syscampo where codcam = 21787;
delete from db_sysarqcamp where codarq = 3922 and codcam = 21786;
delete from db_syscampo where codcam = 21786;
delete from db_sysarqmod where codarq = 3922;
delete from db_sysarquivo where codarq = 3922;

-- Licitacom - ITEM PROPOSTAS
delete from db_layoutcampos where db52_layoutlinha in (817,819);
delete from db_layoutlinha where db51_layouttxt in (244);
delete from db_layouttxt where db50_codigo in (244);

-- Layout alteração contratos
delete from db_layoutcampos where db52_layoutlinha in (820,821);
delete from db_layoutlinha where db51_layouttxt in (245);
delete from db_layouttxt where db50_codigo in (245);

-- Layout item contratos
delete from db_layoutcampos where db52_layoutlinha in (822,823);
delete from db_layoutlinha where db51_layouttxt in (246);
delete from db_layouttxt where db50_codigo in (246);

-- Layout lotecontratos
delete from db_layoutcampos where db52_layoutlinha in (824,825);
delete from db_layoutlinha where db51_layouttxt in (247);
delete from db_layouttxt where db50_codigo in (247);

-- Layout responsavel contrato
delete from db_layoutcampos where db52_layoutlinha in (826,827);
delete from db_layoutlinha where db51_layouttxt in (249);
delete from db_layouttxt where db50_codigo in (249);

-- Layout documentos de contratos
delete from db_layoutcampos where db52_layoutlinha in (828,829);
delete from db_layoutlinha where db51_layouttxt in (250);
delete from db_layouttxt where db50_codigo in (250);

-- Layout eventos de contratos
delete from db_layoutcampos where db52_layoutlinha in (830,831);
delete from db_layoutlinha where db51_layouttxt in (251);
delete from db_layouttxt where db50_codigo in (251);

-- Layout dotacao orcamentaria de contratos
delete from db_layoutcampos where db52_layoutlinha in (832,833);
delete from db_layoutlinha where db51_layouttxt in (252);
delete from db_layouttxt where db50_codigo in (252);

-- Layout contratos LICITACON
delete from db_layoutcampos where db52_layoutlinha in (834,835);
delete from db_layoutlinha where db51_layouttxt in (253);
delete from db_layouttxt where db50_codigo in (253);

/** LicitaCon - Contratos */

/** Acordo  - Novos Campos */
delete from db_sysarqcamp where codcam = 21795 and codarq = 2828;
delete from db_sysarqcamp where codcam = 21796 and codarq = 2828;

delete from db_syscampodef where codcam = 21795;
delete from db_syscampodef where codcam = 21796;

delete from db_syscampo where codcam = 21795;
delete from db_syscampo where codcam = 21796;

delete from db_sysprikey where codarq = 3926;
delete from db_sysforkey where codarq = 3926;
delete from db_sysarqarq where codarq = 3926;
delete from db_syscadind where codcam in(21797, 21798, 21799, 21800);
delete from db_sysindices where codarq = 3926;
delete from db_sysarqcamp where codarq = 3926;
delete from db_syssequencia where codsequencia = 1000560;
delete from db_syscampo where codcam in(21797, 21798, 21799, 21800);
delete from db_sysarqmod where codarq = 3926;
delete from db_sysarquivo where codarq = 3926;

delete from db_menu where id_item_filho = 10221 AND modulo = 8251;
delete from db_Itensmenu where id_item = 10221;


delete from db_sysprikey where codarq = 3927;
delete from db_sysforkey where codarq = 3927;
delete from db_syscadind where codcam in(21821, 21822, 21823, 21824, 21825, 21826, 21827, 21828);
delete from db_syscampodef where codcam in(21821, 21822, 21823, 21824, 21825, 21826, 21827, 21828);
delete from db_sysarqcamp  where codarq = 3927;
delete from db_sysindices where codarq = 3927;
delete from db_syssequencia where codsequencia = 1000561;
delete from db_syscampo where codcam in(21821, 21822, 21823, 21824, 21825, 21826, 21827, 21828);
delete from db_sysarqmod where codarq = 3927;
delete from db_sysarquivo where codarq = 3927;

delete from db_sysprikey where codarq = 3928;
delete from db_sysforkey where codarq = 3928;
delete from db_syscadind where codcam in(21829, 21830, 21831);
delete from db_syscampodef where codcam in(21829, 21830, 21831);
delete from db_sysarqcamp  where codarq = 3928;
delete from db_sysindices where codarq = 3928;
delete from db_syssequencia where codsequencia = 1000562;
delete from db_syscampo     where codcam in(21829, 21830, 21831);
delete from db_sysarqmod    where codarq = 3928;
delete from db_sysarquivo   where codarq = 3928;

delete from db_sysprikey where codarq = 3929;
delete from db_sysforkey where codarq = 3929;
delete from db_syscadind where codcam in(21832, 21833, 21834, 21835);
delete from db_syscampodef where codcam in(21832, 21833, 21834, 21835);
delete from db_sysarqcamp  where codarq = 3929;
delete from db_sysindices where codarq = 3929;
delete from db_syssequencia where codsequencia = 1000563;
delete from db_syscampo     where codcam in(21832, 21833, 21834, 21835);
delete from db_sysarqmod    where codarq = 3929;
delete from db_sysarquivo   where codarq = 3929;

delete from db_menu where id_item_filho = 10225 AND modulo = 8251;
delete from db_itensmenu where id_item = 10225;
