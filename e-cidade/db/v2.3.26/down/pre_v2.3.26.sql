/**
 * Arquivo pre que desfaz as alteracoes do pre (up)
 */


/**
 * TIME B
 */

delete from db_itensfilho   where id_item = 9952;
delete from db_menu         where id_item = 9952;
delete from db_itensmenu    where id_item = 9952;
delete from  db_sysarqmod   where codarq = 3718;
delete from db_sysarqcamp   where codarq = 3718;
delete from db_sysprikey    where codarq = 3718;
delete from db_sysforkey    where codarq = 3718;
delete from db_sysindices   where codind in(4086, 4087);
delete from db_syscadind    where codind in(4086, 4087);
delete from db_syssequencia where codsequencia = 1000378;
delete from db_acount       where codarq = 3718;
delete from db_sysarquivo   where codarq = 3718;
delete from db_syscampo     where codcam in(20640, 20641, 20642);

/* 93465 { */

  update db_itensmenu
    set libcliente = w_menus_93465.libcliente
    from w_menus_93465
   where id_item = w_menus_93465.id_menu;

  insert into db_permissao select * from w_permissao_93465;

  delete from db_itensmenu where id_item = 9954;
  delete from db_menu where id_item_filho = 9954;

  update db_menu set id_item = 29 where id_item_filho in(select w_menus_93465.id_menu from w_menus_93465);

  drop table w_menus_93465;
  drop table w_permissao_93465;

  delete from conhistdoc where c53_coddoc in(212, 213);
  delete from vinculoeventoscontabeis where c115_sequencial = 108;
  delete from conhistdoc where c53_coddoc in(39, 40);
  delete from vinculoeventoscontabeis where c115_sequencial = 109;


/* } */

/**
 *  FIM TIME B
 */


 /**
 * Time C
 */

-- Tarefa 92375

delete from db_modeloimpressao where db66_sequencial in (2, 3);
delete from db_impressora where db64_sequencial in (14, 15);

-- Tarefa 94961
delete from db_menu where  id_item_filho = 1101027 and id_item != 1000004;

-- 94091
update db_itensmenu
   set funcao = 'lab4_entregaresult001.php'
where id_item = 8350;

update db_itensmenu set descricao = 'Emissão de Resultado', help = 'Emissão de Resultado', desctec = 'Emissão de Resultado' where id_item = 8349;

-- 94950
delete from db_menu
      where id_item_filho in( 8451, 8452, 8453, 8454 )
        and modulo <> 604;

--93766
update db_itensmenu
   set id_item = 1537148 ,
       descricao = 'Inclusão' ,
       help = 'Inclusão de Sau_procedimento' ,
       funcao = 'sau1_sau_procedimento001.php' ,
       itemativo = '1' ,
       manutencao = '1' ,
       desctec = 'Inclusão de Sau_procedimento' ,
       libcliente = 'true'
 where id_item = 1537148;
update db_itensmenu
   set id_item = 1548421 ,
       descricao = 'Exclusão' ,
       help = 'Exclusão de Procedimento' ,
       funcao = 'sau1_sau_procedimento003.php' ,
       itemativo = '1' ,
       manutencao = '1' ,
       desctec = 'Exclusão de Procedimento' ,
       libcliente = 'true'
 where id_item = 1548421;

-- 95325
update db_syscampo
   set nomecam = 'z01_v_mae',
       conteudo = 'varchar(40)',
       descricao = 'Mãe',
       valorinicial = '',
       rotulo = 'Mãe',
       nulo = 't',
       tamanho = 40,
       maiusculo = 't',
       autocompl = 'f',
       aceitatipo = 0,
       tipoobj = 'text',
       rotulorel = 'Mãe'
 where codcam = 11248;

update db_syscampo
   set nomecam = 'z01_d_nasc',
       conteudo = 'date',
       descricao = 'Nascimento',
       valorinicial = 'null',
       rotulo = 'Nascimento',
       nulo = 't',
       tamanho = 10,
       maiusculo = 'f',
       autocompl = 'f',
       aceitatipo = 1,
       tipoobj = 'text',
       rotulorel = 'Nascimento'
 where codcam = 1008859;

 -- 64998

 -- Aterar o valor default de: P = Horas - Aula
 update db_syscampo
  set nomecam      = 'ed31_c_medfreq',
      conteudo     = 'char(1)',
      descricao    = 'D = Freqûencia por Dias Letivos P = Frequência por Períodos',
      valorinicial = '',
      rotulo       = 'Frequência',
      nulo         = 'f',
      tamanho      = 1,
      maiusculo    = 't',
      autocompl    = 'f',
      aceitatipo   = 0,
      tipoobj      = 'select',
      rotulorel    = 'Frequência'
  where codcam     = 1008363;
delete from db_syscampodep where codcam = 1008363;
delete from db_syscampodef where codcam = 1008363;
insert into db_syscampodef values(1008363,'D','DIAS LETIVOS');
insert into db_syscampodef values(1008363,'P','PERÍODOS');

-- Adicionar campos na basemps
delete from db_sysarqcamp where codarq = 1010061;
delete from db_syscampo where codcam   = 20657;
delete from db_syscampo where codcam   = 20659;
delete from db_syscampo where codcam   = 20660;
update db_syscampo set nomecam = 'ed34_i_qtdperiodo', conteudo = 'int4', descricao = 'Quantidade de Períodos', valorinicial = '0', rotulo = 'Quantidade de Períodos', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Quantidade de Períodos' where codcam = 1008372;

-- Adicionar campos na regencia
delete from db_sysarqcamp where codarq = 1010084;
delete from db_syscampo where codcam   = 20661;
delete from db_syscampo where codcam   = 20662;
update db_syscampo set nomecam = 'ed59_i_qtdperiodo', conteudo = 'int4', descricao = 'Quantidade de Períodos', valorinicial = '0', rotulo = 'Períodos', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 1, tipoobj = 'text', rotulorel = 'Períodos' where codcam = 1008501;

-- Adicionar campo na histmpsdisc
delete from db_sysarqcamp where codarq = 1010133;
delete from db_syscampo where codcam   = 20663;

-- Adicionar campo na histmpsdiscfora
delete from db_sysarqcamp where codarq = 1010159;
delete from db_syscampo where codcam   = 20664;

-- 94022 - BPA MAGNÉTICO
delete from db_sysarqcamp where codarq = 3182;
delete from db_syscampo where codcam   = 20670;

delete from db_menu where id_item_filho = 9955 AND modulo = 8167;
delete from db_itensmenu where id_item= 9955;

update db_itensmenu
   set id_item = 8457 , descricao = 'Gerar Arquivo' , help = 'Gerar Arquivo' , funcao = 'lab4_bpamagnetico001.php' , itemativo = '1' , manutencao = '1' , desctec = 'bpa magnetico' , libcliente = 'true'
 where id_item = 8457;

update db_itensmenu set libcliente = true where id_item = 6976;
update db_itensmenu set descricao = 'Gerar Arquivo Layout 2013' where id_item = 9825;

 /**
 * FIM Time C
 */

/**
 *  Time Tributário
 */

-- Cadastro de Usuários
delete from db_sysarqcamp where codcam = 20639;
delete from db_syscampo where codcam   = 20639;
update db_syscampo set nomecam = 'usuarioativo', conteudo = 'char(1)', descricao = 'se usuario ativo ou nao', valorinicial = '', rotulo = 'se usuario ativo ou nao', nulo = 'f', tamanho = 10, maiusculo = 'f', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'se usuario ativo ou nao' where codcam = 573;

-- Skin Default

delete from db_itensfilho where id_item = 9953;
delete from db_menu where id_item_filho = 9953;
delete from db_itensmenu where id_item  = 9953;


--94091 - Entrega Resultado
delete from db_sysarqcamp where codarq = 2892 and codcam = 20643;
delete from db_syscampo   where codcam = 20643;
/**
 *  Fim Time Tributário
 */

/**
 *  Time Folha
 */
delete from db_sysarquivo where codarq in (3719,3721);
delete from db_sysarqmod where codarq in (3719,3721);
delete from db_syscampo where codcam in (20644,20645,20646,20647,20671,20672,20673,20675,20676,20677);
delete from db_sysarqcamp where codarq in (3719,3721);
delete from db_sysprikey where codarq in (3719,3721);
delete from db_sysforkey where codarq in (3719,3721);
delete from db_syssequencia where codsequencia = 1000379 and nomesequencia = 'rhpessoalmovcontabancaria_rh138_sequencial_seq';
delete from db_syssequencia where codsequencia = 1000381 and nomesequencia = 'pensaocontabancaria_rh139_sequencial_seq';
delete from db_sysindices where codind in (4088,4089,4090,4093,4094,4095,4096);
delete from db_syscadind where codind in (4088,4089,4090,4093,4094,4095,4096);

/**
 *  Fim Time Folha
 */

/**
 * Time Tributário
 */

/**
 * Inicio Tarefa 83872
 */
delete from db_sysarqcamp where codcam = 20656;
delete from db_syscampo where codcam = 20656;
delete from db_sysarqcamp where codcam = 20658;
delete from db_syscampo where codcam = 20658;
update db_syscampo set conteudo = 'float4' where codcam = 13541;
update db_syscampo set conteudo = 'float4' where codcam = 13542;

/**
 * Fim Tarefa 83872
 */

/**
 * Inicio Tarefa 52990
 */

delete from db_sysarqcamp where codcam = 20668;
delete from db_sysarqcamp where codcam = 20669;
delete from db_syscampo   where codcam = 20668;
delete from db_syscampo   where codcam = 20669;
delete from db_documentotemplatepadrao where db81_sequencial = 50;
delete from db_documentotemplatetipo where db80_sequencial = 47;
/**
 * Fim Tarefa 52990
 */

/**
 * Inicio Tarefa 92906
 */

delete from db_sysarqcamp where codcam = 20666;
delete from db_syscampo where codcam = 20666;
delete from db_sysforkey where codarq = 906 and referen = 109;
delete from db_syscadind where codind = 4091 and codcam = 20666;
delete from db_sysindices where codind = 4091;


/**
 * Fim Tarefa 92906
 */

/**
 * Fim Time Tributário
 */
