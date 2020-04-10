---------------------------------------------------------------------------------------------------------------
--------------------------------------------- INICIO FINANCEIRO -----------------------------------------------
---------------------------------------------------------------------------------------------------------------
delete from db_layoutcampos where db52_codigo = 14991;
delete from db_layoutcampos where db52_codigo = 14992;
delete from db_layoutcampos where db52_codigo = 14993;
delete from db_layoutcampos where db52_codigo = 14994;
delete from db_layoutcampos where db52_codigo = 14995;
delete from db_layoutcampos where db52_codigo = 14996;
delete from db_layoutcampos where db52_codigo = 14997;
delete from db_layoutcampos where db52_codigo = 14998;
delete from db_layoutcampos where db52_codigo = 14999;
delete from db_layoutcampos where db52_codigo = 15000;
delete from db_layoutcampos where db52_codigo = 15001;
delete from db_layoutcampos where db52_codigo = 15002;
delete from db_layoutcampos where db52_codigo = 15003;
delete from db_layoutcampos where db52_codigo = 15004;
delete from db_layoutcampos where db52_codigo = 15005;
delete from db_layoutcampos where db52_codigo = 15006;
delete from db_layoutcampos where db52_codigo = 15007;
delete from db_layoutcampos where db52_codigo = 15008;
delete from db_layoutcampos where db52_codigo = 15009;
delete from db_layoutcampos where db52_codigo = 15010;
delete from db_layoutcampos where db52_codigo = 15011;
delete from db_layoutcampos where db52_codigo = 15012;
delete from db_layoutcampos where db52_codigo = 15013;
delete from db_layoutcampos where db52_codigo = 15014;
delete from db_layoutcampos where db52_codigo = 15015;
delete from db_layoutcampos where db52_codigo = 15016;
delete from db_layoutcampos where db52_codigo = 15017;
delete from db_layoutcampos where db52_codigo = 15018;
delete from db_layoutcampos where db52_codigo = 15019;
delete from db_layoutcampos where db52_codigo = 15020;
delete from db_layoutcampos where db52_codigo = 15021;
delete from db_layoutcampos where db52_codigo = 15022;
delete from db_layoutcampos where db52_codigo = 15023;
delete from db_layoutcampos where db52_codigo = 15024;
delete from db_layoutcampos where db52_codigo = 15025;
delete from db_layoutcampos where db52_codigo = 15026;
delete from db_layoutcampos where db52_codigo = 15027;
delete from db_layoutcampos where db52_codigo = 15028;
delete from db_layoutcampos where db52_codigo = 15029;
delete from db_layoutcampos where db52_codigo = 15030;
delete from db_layoutcampos where db52_codigo = 15031;
delete from db_layoutcampos where db52_codigo = 15032;
delete from db_layoutcampos where db52_codigo = 15033;
delete from db_layoutcampos where db52_codigo = 15034;
delete from db_layoutcampos where db52_codigo = 15035;
delete from db_layoutcampos where db52_codigo = 15036;
delete from db_layoutcampos where db52_codigo = 15037;
delete from db_layoutcampos where db52_codigo = 15038;
delete from db_layoutcampos where db52_codigo = 15039;
delete from db_layoutcampos where db52_codigo = 15040;
delete from db_layoutcampos where db52_codigo = 15041;
delete from db_layoutcampos where db52_codigo = 15042;
delete from db_layoutcampos where db52_codigo = 15043;
delete from db_layoutcampos where db52_codigo = 15044;
delete from db_layoutcampos where db52_codigo = 15045;
delete from db_layoutcampos where db52_codigo = 15046;
delete from db_layoutcampos where db52_codigo = 15047;
delete from db_layoutcampos where db52_codigo = 15048;
delete from db_layoutcampos where db52_codigo = 15049;
delete from db_layoutcampos where db52_codigo = 15050;
delete from db_layoutcampos where db52_codigo = 15051;
delete from db_layoutcampos where db52_codigo = 15052;
delete from db_layoutcampos where db52_codigo = 15053;
delete from db_layoutlinha where db51_codigo = 874;
delete from db_layoutlinha where db51_codigo = 875;
delete from db_layouttxt where db50_codigo = 264;


delete from db_layoutcampos where db52_layoutlinha in (881,882);
delete from db_layoutlinha where db51_layouttxt = 271;
delete from db_layouttxt where db50_codigo = 271;

delete from db_cadattdinamicoatributosopcoes where db18_cadattdinamicoatributos = (select db109_sequencial from db_cadattdinamicoatributos where db109_nome = 'codigofundamentacao') and db18_opcao = 'A24I';
delete from db_cadattdinamicoatributosopcoes where db18_cadattdinamicoatributos = (select db109_sequencial from db_cadattdinamicoatributos where db109_nome = 'codigofundamentacao') and db18_opcao = 'A24II';
delete from db_cadattdinamicoatributosopcoes where db18_cadattdinamicoatributos = (select db109_sequencial from db_cadattdinamicoatributos where db109_nome = 'tipobeneficiomicroepp') and db18_opcao = 'C';

-- Dicionário de dados
update db_syscampo set conteudo = 'varchar(100)', tamanho = 100 where codcam = 21705;
update db_syscampo set conteudo = 'varchar(100)', tamanho = 100 where codcam = 18492;

-- Cadastro do leiaute ITEM.TXT 1.3
delete from db_layoutcampos where db52_codigo = 15130;
delete from db_layoutcampos where db52_codigo = 15131;
delete from db_layoutcampos where db52_codigo = 15132;
delete from db_layoutcampos where db52_codigo = 15133;
delete from db_layoutcampos where db52_codigo = 15134;
delete from db_layoutcampos where db52_codigo = 15135;
delete from db_layoutcampos where db52_codigo = 15136;
delete from db_layoutcampos where db52_codigo = 15137;
delete from db_layoutcampos where db52_codigo = 15138;
delete from db_layoutcampos where db52_codigo = 15139;
delete from db_layoutcampos where db52_codigo = 15140;
delete from db_layoutcampos where db52_codigo = 15141;
delete from db_layoutcampos where db52_codigo = 15142;
delete from db_layoutcampos where db52_codigo = 15143;
delete from db_layoutcampos where db52_codigo = 15144;
delete from db_layoutcampos where db52_codigo = 15145;
delete from db_layoutcampos where db52_codigo = 15146;
delete from db_layoutcampos where db52_codigo = 15147;
delete from db_layoutcampos where db52_codigo = 15148;
delete from db_layoutcampos where db52_codigo = 15149;
delete from db_layoutcampos where db52_codigo = 15150;
delete from db_layoutcampos where db52_codigo = 15151;
delete from db_layoutcampos where db52_codigo = 15152;
delete from db_layoutcampos where db52_codigo = 15153;
delete from db_layoutcampos where db52_codigo = 15154;
delete from db_layoutcampos where db52_codigo = 15155;
delete from db_layoutcampos where db52_codigo = 15156;
delete from db_layoutcampos where db52_codigo = 15157;
delete from db_layoutcampos where db52_codigo = 15158;
delete from db_layoutcampos where db52_codigo = 15159;
delete from db_layoutcampos where db52_codigo = 15160;
delete from db_layoutcampos where db52_codigo = 15161;
delete from db_layoutcampos where db52_codigo = 15164;
delete from db_layoutcampos where db52_codigo = 15168;
delete from db_layoutlinha where db51_codigo = 884;
delete from db_layoutlinha where db51_codigo = 885;
delete from db_layouttxt where db50_codigo = 273;

-- Cadastro do leiaute CONTRATO.TXT 1.3
delete from db_layoutcampos where db52_codigo  = 15251;
delete from db_layoutcampos where db52_codigo  = 15252;
delete from db_layoutcampos where db52_codigo  = 15253;
delete from db_layoutcampos where db52_codigo  = 15254;
delete from db_layoutcampos where db52_codigo  = 15255;
delete from db_layoutcampos where db52_codigo  = 15256;
delete from db_layoutcampos where db52_codigo  = 15257;
delete from db_layoutcampos where db52_codigo  = 15258;
delete from db_layoutcampos where db52_codigo  = 15259;
delete from db_layoutcampos where db52_codigo  = 15260;
delete from db_layoutcampos where db52_codigo  = 15261;
delete from db_layoutcampos where db52_codigo  = 15262;
delete from db_layoutcampos where db52_codigo  = 15263;
delete from db_layoutcampos where db52_codigo  = 15264;
delete from db_layoutcampos where db52_codigo  = 15265;
delete from db_layoutcampos where db52_codigo  = 15266;
delete from db_layoutcampos where db52_codigo  = 15267;
delete from db_layoutcampos where db52_codigo  = 15268;
delete from db_layoutcampos where db52_codigo  = 15269;
delete from db_layoutcampos where db52_codigo  = 15270;
delete from db_layoutcampos where db52_codigo  = 15271;
delete from db_layoutcampos where db52_codigo  = 15272;
delete from db_layoutcampos where db52_codigo  = 15273;
delete from db_layoutcampos where db52_codigo  = 15274;
delete from db_layoutcampos where db52_codigo  = 15275;
delete from db_layoutcampos where db52_codigo  = 15276;
delete from db_layoutcampos where db52_codigo  = 15277;
delete from db_layoutcampos where db52_codigo  = 15278;
delete from db_layoutcampos where db52_codigo  = 15279;
delete from db_layoutcampos where db52_codigo  = 15280;
delete from db_layoutlinha where db51_codigo  = 887;
delete from db_layoutlinha where db51_codigo  = 886;
delete from db_layouttxt where db50_codigo  = 275;


delete from db_syscadind where codind in (4393, 4394, 4395);
delete from db_sysindices where codind in (4393, 4394, 4395);
delete from db_sysprikey where codarq in (3993,3994,3995);
delete from db_syssequencia where codsequencia in (1000622, 1000623, 1000624);
delete from db_sysarqcamp where codarq in (3993,3994,3995);
delete from db_sysforkey where codcam in (22181, 22182, 22183, 22184, 22185, 22186, 22187, 22188, 22189, 22190, 22191, 22192, 22193, 22194, 22195);
delete from db_syscampo where codcam in (22181, 22182, 22183, 22184, 22185, 22186, 22187, 22188, 22189, 22190, 22191, 22192, 22193, 22194, 22195);
delete from db_sysarqmod where codarq in (3993,3994,3995);
delete from db_sysarquivo where codarq in (3993,3994,3995);

delete from db_menu where id_item_filho in (10339, 10340);
delete from db_itensmenu where id_item in (10339, 10340);

---------------------------------------------------------------------------------------------------------------
--------------------------------------------- FIM FINANCEIRO --------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO TRIBUTARIO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

delete from db_layoutcampos where db52_layoutlinha in (876);
delete from db_layoutlinha where db51_layouttxt in (265);
delete from db_layouttxt where db50_codigo in (265);

delete from db_layoutcampos where db52_layoutlinha in (877);
delete from db_layoutlinha where db51_layouttxt in (266);
delete from db_layouttxt where db50_codigo in (266);

delete from db_layoutcampos where db52_layoutlinha in (878);
delete from db_layoutlinha where db51_layouttxt in (267);
delete from db_layouttxt where db50_codigo in (267);

delete from db_layoutcampos where db52_layoutlinha in (879);
delete from db_layoutlinha where db51_layouttxt in (268);
delete from db_layouttxt where db50_codigo in (268);

delete from db_layoutcampos where db52_layoutlinha in (880);
delete from db_layoutlinha where db51_layouttxt in (269);
delete from db_layouttxt where db50_codigo in (269);

delete from db_layoutcampos where db52_layoutlinha in (883);
delete from db_layoutlinha where db51_layouttxt in (272);
delete from db_layouttxt where db50_codigo in (272);

-- aguacoletorexportadadoscontrato
delete from db_syssequencia where codsequencia = 1000621;
delete from db_sysforkey    where codarq = 3992;
delete from db_sysprikey    where codarq = 3992;
delete from db_sysarqcamp   where codarq = 3992;
delete from db_syscampo     where codcam in(22171, 22211, 22212, 22173, 22174, 22175, 22176);
delete from db_sysarqmod    where codarq = 3992;
delete from db_sysarquivo   where codarq = 3992;

-- aguacoletorexporta
delete from db_sysforkey  where codcam = 22178;
delete from db_sysarqcamp where codcam = 22178;
delete from db_syscampo   where codcam = 22178;

-- Layout de importação
delete from db_layoutcampos where db52_layoutlinha in (888);
delete from db_layoutlinha where db51_layouttxt in (276);
delete from db_layouttxt where db50_codigo in (276);

-- Menu do relatório de taxas
delete from db_menu where id_item_filho = 10337 AND modulo = 277;
delete from db_itensmenu where id_item = 10337;

delete from db_layouttxtgrupo where db56_sequencial = 7;

delete from db_sysforkey where codarq          in ( 3986, 3987, 3988, 3989 );
delete from db_sysprikey where codarq          in ( 3986, 3987, 3988, 3989 );
delete from db_syssequencia where codsequencia in (1000615, 1000616, 1000617, 1000618);
delete from db_sysarqmod where codarq          in ( 3986, 3987, 3988, 3989 );
delete from db_sysarqcamp where codarq         in ( 3986, 3987, 3988, 3989 );
delete from db_syscampodef where codcam        in (22126,22127,22128,22129,22130,22131,22132,22133,22134,22135,22136,22138,22139,22140,22141,22142,22143,22144,22145,22146,22160);
delete from db_syscampodep where codcam        in (22126,22127,22128,22129,22130,22131,22132,22133,22134,22135,22136,22138,22139,22140,22141,22142,22143,22144,22145,22146,22160);
delete from db_syscampo where codcam           in (22126,22127,22128,22129,22130,22131,22132,22133,22134,22135,22136,22138,22139,22140,22141,22142,22143,22144,22145,22146,22160);
delete from db_sysarquivo where codarq         in ( 3986, 3987, 3988, 3989 );

delete from db_sysforkey where codarq  = 3991;
delete from db_sysarqcamp where codarq = 3991;
delete from db_sysprikey where codarq  = 3991;
delete from db_sysarqmod where codarq  = 3991;
delete from db_syssequencia where codsequencia = 3991;
delete from db_syscampo where codcam in (22155,22156,22157,22158,22159);
delete from db_sysarquivo where codarq = 3991;

delete from db_sysarqcamp where codcam = 22164;
delete from db_syscampo where codcam = 22164;

delete from db_menu where id_item_filho = 10336 AND modulo = 578;
delete from db_itensmenu where id_item = 10336;
update db_itensmenu set id_item = 1576 , descricao = 'Emissão Geral de IPTU' , help = 'Emissão Geral de IPTU' , funcao = 'cad4_emiteiptu.php' , itemativo = '1' , manutencao = '1' , desctec = 'Gera layout dos carnes de iptu.' , libcliente = 'true' where id_item = 1576;

delete from db_layoutcampos where db52_codigo in (15317,15318,15319,15320,15321,15322,15323,15324,15325,15326,15327,15328,15329,15330,15331,15332,15333,15334,15335,15336,15337,15338,15339,15340,15341,15342);
delete from db_layoutlinha where db51_codigo = 889;

delete from db_itensmenu where id_item = 10338;
delete from db_menu where id_item_filho = 10338;

delete from db_sysprikey where codarq in (3999,3997,3998, 4000);
delete from db_syssequencia where codsequencia in (1000627, 1000625, 1000626, 1000628);
delete from db_sysarqcamp where codarq in (3999,3997,3998, 4000);
delete from db_sysforkey where codarq in (3999,3997,3998, 4000);
delete from db_syscampo where codcam in (22204, 22205, 22206,22196,22197,22198,22199,22207, 22200, 22201,22208,22209,22210);
delete from db_sysarqmod where codarq in (3999,3997,3998,4000);
delete from db_sysarquivo where codarq in (3999,3997,3998,4000);

----
--Removendo NOT NULL do campo dv14_data_calculo da tabela
----
UPDATE db_syscampo SET nulo = true WHERE codcam = 22094;
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FINAL TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------------------------------------
------------------------------------------ INICIO EDUCACAO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

delete from db_sysarqcamp where codcam = 22147;
delete from db_syscampo   where codcam = 22147;

delete from db_menu where modulo = 1100747 and id_item_filho = 10331;
delete from db_menu where modulo = 7159    and id_item_filho in (1100857, 1100858, 1100859, 1100860, 1100865, 1100866, 1100867, 10332, 10333, 10334, 10335, 10331);
delete from db_itensmenu where id_item in (10331, 10332, 10333, 10334, 10335);

delete from db_syssequencia where codsequencia = 1000619;
delete from db_syscadind where codind IN (4390, 4391, 4392);
delete from db_sysindices where codind IN (4390, 4391, 4392);
delete from db_sysforkey where codarq = 3990;
delete from db_sysprikey where codarq = 3990;
delete from db_sysarqcamp where codarq = 3990;
delete from db_syscampo where codcam IN (22148, 22149, 22150, 22151, 22152, 22153, 22154);
delete from db_sysarqmod where codarq = 3990;
delete from db_sysarquivo where codarq = 3990;
update db_syscampo set nulo = 'f'  where codcam = 1009219;

delete from db_sysarqcamp where codcam = 22180;
delete from db_syscampo   where codcam = 22180;
---------------------------------------------------------------------------------------------------------------
-------------------------------------------- FIM EDUCACAO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
------------------------------------------ INICIO FOLHA ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
-- Atualização da tabela rhemitecontracheque
delete from db_sysarqcamp where codcam = 22161;
delete from db_sysarqcamp where codcam = 22162;
delete from db_sysarqcamp where codcam = 22163;

delete from db_syscampo where codcam = 22161;
delete from db_syscampo where codcam = 22162;
delete from db_syscampo where codcam = 22163;

-- Atualização da tabela rhferiasconfiguracao
update db_sysarquivo set nomearq = 'tipoassentamentoferias', descricao = 'Tabela com as configurações de assentamentos e período aquisitivo para as férias do RH', sigla = 'rh168', dataincl = '2016-11-24', rotulo = 'Tabela de configuração para Férias', tipotabela = 0, naolibclass = 'f', naolibfunc = 'f', naolibprog = 'f', naolibform = 'f' where codarq = 3872;
delete from db_sysarqcamp where codcam = 22179;
delete from db_syscampo where codcam = 22179;



---------------------------------------------------------------------------------------------------------------
-------------------------------------------- FIM FOLHA -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
