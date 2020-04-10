/**
 * Arquivo pre que desfaz as alterações do pre (up)
 */

/*
 *
 * TIME Tributário
 *
 *
 */
delete from db_sysarqcamp  where codcam in (20555,20556,20557,20558);
delete from db_syscampodef where codcam in (20555,20556,20557,20558);
delete from db_syscampo    where codcam in (20555,20556,20557,20558);

update db_modulos set nome_modulo = 'Dívida Ativa',       descr_modulo = 'Divida Ativa'      where id_item = 81;
update db_modulos set nome_modulo = 'Orcamento',          descr_modulo = 'Orcamento'         where id_item = 116;
update db_modulos set nome_modulo = 'Licitacoes',         descr_modulo = 'Licitacoes'        where id_item = 381;
update db_modulos set nome_modulo = 'Site',               descr_modulo = 'site'              where id_item = 420;
update db_modulos set nome_modulo = 'Ipasem',             descr_modulo = 'ipasem'            where id_item = 576;
update db_modulos set nome_modulo = 'Veiculos',           descr_modulo = 'Veiculos'          where id_item = 633;
update db_modulos set nome_modulo = 'Agua',               descr_modulo = 'Agua'              where id_item = 4555;
update db_modulos set nome_modulo = 'Biblioteca',         descr_modulo = 'biblioteca'        where id_item = 1100625;
update db_modulos set nome_modulo = 'Prefeitura On-Line', descr_modulo = 'prefeitura'        where id_item = 394;
update db_modulos set nome_modulo = 'SAMU',               descr_modulo = 'Modulo SAMU'       where id_item = 9101;
update db_modulos set nome_modulo = 'Escola',             descr_modulo = 'escola'            where id_item = 1100747;
update db_modulos set nome_modulo = 'Matricula On-Line',  descr_modulo = 'Matricula On-line' where id_item = 2000112;
update db_modulos set nome_modulo = 'Patrimonio',         descr_modulo = 'Patrimonio'        where id_item = 439;

--Tarefa 93126 - Certidão Baixa
update db_itensmenu set id_item = 6996, descricao = 'Numeração certidão de baixa', help = 'Numeração certidão de baixa', funcao = 'iss4_certbaixanumero002.php', itemativo = '1', manutencao = '1', desctec = 'Controla numeração da certidão de baixa', libcliente = 'true'  where id_item = 6996;
insert into db_menu ( id_item, id_item_filho, menusequencia, modulo) values (32,2334, 20, 40);

delete from db_sysarqcamp where codcam = 20592;
delete from db_sysarqcamp where codcam = 20593;

delete from db_syscampo where codcam = 20592;
delete from db_syscampo where codcam = 20593;

delete from db_documentotemplatepadrao where db81_templatetipo = 46;
delete from db_documentotemplatetipo where db80_sequencial = 46;

/*
 *  Inicio Tarefa 93560
 */
-- Tolerância de Crédito

delete from db_sysarqcamp where codcam = 20614;  
delete from db_syscampo   where codcam = 20614;  

-- Geração pagamento taxa bancária

delete from db_sysprikey    where codarq = 3716;
delete from db_sysforkey where codarq = 3716 and referen = 116;  
delete from db_sysforkey where codarq = 3716 and referen = 79;
delete from db_sysarqcamp where codarq = 3716;
delete from db_syscampo     where codcam = 20630;
delete from db_syscampo     where codcam = 20631;
delete from db_syscampo     where codcam = 20632;
delete from db_sysarqmod    where codarq = 3716;
delete from db_sysarquivo   where codarq = 3716;  
delete from db_syscadind    where codind = 4083;
delete from db_sysindices   where codind = 4083;    
delete from db_syscadind    where codind = 4084;
delete from db_sysindices   where codind = 4084;  
delete from db_syssequencia where codsequencia = 1000376;


 
/*
 *  Fim Tarefa 93560
 */

/*
 *
 * FIM TIME Tributário
 *
 */

  /*
   *
   * TIME B
   *
   */

  update db_itensmenu set libcliente = true where id_item in (9533, 5262);


  -- desfaz menus mensageria
  delete from db_itensfilho where id_item = 9947;
  delete from db_menu where id_item in (9946,9947,9945);
  delete from db_itensmenu  where id_item in (9946,9947,9945);

  -- mensageriaacordo
  delete from db_sysarqmod where codmod = 69 and codarq = 3701;
  delete from db_sysarqcamp where codarq = 3701;
  delete from db_sysarquivo where codarq =  3701;
  delete from db_sysprikey where codarq = 3701;
  delete from db_syssequencia where codsequencia = 1000363;
  delete from db_syscampo where codcam = 20573;
  delete from db_syscampo where codcam = 20574;
  delete from db_syscampo where codcam = 20575;

  --mensageriaacordodb_usuario
  delete from db_syssequencia where codsequencia = 1000364;
	delete from db_sysforkey    where codarq = 3702;
	delete from db_sysprikey    where codarq = 3702;
	delete from db_sysarqcamp   where codarq = 3702;
	delete from db_syscampo     where codcam in (20577, 20579, 20580);
	delete from db_sysarqmod    where codarq = 3702;
	delete from db_sysarquivo   where codarq = 3702;

  -- mensageriaacordoprocessados
  delete from db_sysarqmod where codmod = 69 and codarq = 3705;
  delete from db_sysarqcamp where codarq = 3705;
  delete from db_sysprikey where codarq = 3705;
  delete from db_sysindices where codind = 4066;
  delete from db_syscadind where codind = 4066;
  delete from db_sysindices where codind = 4067;
  delete from db_syscadind where codind = 4067;
  delete from db_syssequencia where codsequencia = 1000367;
  delete from db_sysforkey where codarq = 3705;
  delete from db_syscampo where codcam = 20589;
  delete from db_syscampo where codcam = 20590;
  delete from db_syscampo where codcam = 20591;
  delete from db_sysarquivo where codarq = 3705;


  -- vinculos de processos
  
  delete from db_sysarqmod    where codarq in (3712, 3713, 3714);
	delete from db_sysarqcamp   where codarq in (3712, 3713, 3714);
	delete from db_sysprikey    where codarq in (3712, 3713, 3714);
	delete from db_sysforkey    where codarq in (3712, 3713, 3714);
	delete from db_sysindices   where codarq in (3712, 3713, 3714);
	delete from db_syscadind    where codind in (4079, 4080, 4081);
	delete from db_syssequencia where codsequencia in (1000372, 1000373, 1000374);
	delete from db_syscampo     where codcam in (20618, 20619, 20620, 20621, 20622, 20623, 20624, 20625, 20626);
	delete from db_sysarquivo   where codarq in (3712, 3713, 3714);
  
	delete from db_sysarqmod    where codarq in (3715);
	delete from db_sysarqcamp   where codarq in (3715);
	delete from db_sysprikey    where codarq in (3715);
	delete from db_sysforkey    where codarq in (3715);
	delete from db_sysindices   where codarq in (3715);
	delete from db_syscadind    where codind in (4082);
	delete from db_syssequencia where codsequencia in (1000375);
	delete from db_syscampo     where codcam in (20627, 20628, 20629);
	delete from db_sysarquivo   where codarq in (3715);


	  delete from db_sysarqmod    where codarq in (3717);
  delete from db_sysarqcamp   where codarq in (3717);
  delete from db_sysprikey    where codarq in (3717);
  delete from db_sysforkey    where codarq in (3717);
  delete from db_sysindices   where codarq in (3717);
  delete from db_syscadind    where codind in (4085);
  delete from db_syssequencia where codsequencia in (1000377);
  delete from db_syscampo     where codcam in (20636, 20637, 20638);
  delete from db_sysarquivo   where codarq in (3717);


	
  
  update db_itensmenu set libcliente = false where id_item in (9829, 9830, 9831, 9912, 9869, 9896, 9870, 9852);

  /*
   *
   * FIM TIME B
   *
   */



/*
 *
 * TIME C
 *
 *
 */
update db_syscampo set nomecam      = 'ed254_i_atolegal',
                       conteudo     = 'int8',
                       descricao    = 'Ato Legal',
                       valorinicial = '0',
                       rotulo       = 'Ato Legal',
                       nulo         = 'f',
                       tamanho      = 20,
                       maiusculo    = 'f',
                       autocompl    = 'f',
                       aceitatipo   = 1,
                       tipoobj      = 'text',
                       rotulorel    = 'Ato Legal'
  where codcam = 12551;

delete from db_sysarqcamp  where codarq = 2571 and codcam = 20559;
delete from db_syscampodef where codcam = 20559;
delete from db_syscampo    where codcam = 20559;


/**
 * T91754
 */
-- Tabela rechumanomovimentacao
delete from db_sysarqcamp   where codarq = 3699 and codcam = 20560;
delete from db_syssequencia where codsequencia = 1000360;
delete from db_syscadind    where codind in (4059, 4060, 4061);
delete from db_sysindices   where codind in (4059, 4060, 4061);
delete from db_sysforkey    where codarq = 3699 and codcam in (20561, 20562, 20563);
delete from db_sysprikey    where codarq = 3699 and codcam = 20560;
delete from db_sysarqcamp   where codarq = 3699 and codcam in (20560, 20561, 20562, 20563, 20564, 20565, 20566);
delete from db_syscampo     where codcam in (20560, 20561, 20562, 20563, 20564, 20565, 20566);
delete from db_sysarqmod    where codmod = 1008004 and codarq = 3699;
delete from db_sysarquivo   where codarq = 3699;
delete from db_syscampo     where codcam in (20560, 20561, 20562, 20563, 20564, 20565, 20566);

-- Tabela rechumanohoradisp

insert into db_sysforkey  values (1010091, 1008529, 1, 1010087, 0);
delete from db_sysforkey  where codarq = 1010091 and referen = 1010094;
delete from db_sysforkey  where codarq = 1010091 and codcam in (20568);
delete from db_sysarqcamp where codarq = 1010091;
insert into db_sysarqcamp values(1010091, 1008528, 1, 1000152);
insert into db_sysarqcamp values(1010091, 1008529, 2, 0);
insert into db_sysarqcamp values(1010091, 1008530, 3, 0);
insert into db_sysarqcamp values(1010091, 1008531, 4, 0);
delete from db_syscampo   where codcam in (20568, 20567);



delete from db_menu where id_item = 3470 and id_item_filho = 9054 and modulo = 6877;
delete from db_menu where id_item = 9054 and id_item_filho = 2467 and modulo = 6877;
delete from db_menu where id_item = 9054 and id_item_filho = 8012 and modulo = 6877;
delete from db_menu where id_item = 9054 and id_item_filho = 8013 and modulo = 6877;



/**
 * T 91754
 */
 update db_itensmenu set libcliente = false where id_item = 9941;

/**
 * T93234
 */
-- lab_requiitem
delete from db_sysarqcamp where codarq = 2771 and codcam = 20635;
delete from db_syscampo   where codcam = 20635;

 /*
  *
  * FIM TIME C
  *
  */
  
   /*
  *
  * INICIO TIME D
  * T 93849
  */

delete from db_sysarqcamp where codarq = 48;
delete from db_syscampo   where codcam = 20585;

 /*
  * 
  * FIM TIME D
  */
