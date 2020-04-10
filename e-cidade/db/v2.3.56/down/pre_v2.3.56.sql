---------------------------------------------------------------------------------------------------------------
---------------------------------------- INICIO TRIBUTARIO ----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
--Exclusões da tabela grupotaxadiversos
delete from db_syssequencia where codsequencia = 1000603;
delete from db_syscadind where codind IN (4381,4382);
delete from db_sysindices where codind IN (4381,4382);
delete from db_sysforkey where codarq = 3971;
delete from db_sysprikey where codarq = 3971;
delete from db_sysarqcamp where codarq = 3971;
delete from db_syscampo where codcam IN (22046,22047,22048,22050);
delete from db_sysarqmod where codarq = 3971;
delete from db_sysarquivo where codarq = 3971;

--Exclusões da tabela taxadiversos
delete from db_syssequencia where codsequencia = 1000604;
delete from db_syscadind where codind IN (4383, 4384);
delete from db_sysindices where codind IN (4383,4384);
delete from db_sysforkey where codarq = 3973;
delete from db_sysprikey where codarq = 3973;
delete from db_sysarqcamp where codarq = 3973;
delete from db_syscampo where codcam IN (22051,22052,22053,22054,22055,22056,22125);
delete from db_sysarqmod where codarq = 3973;
delete from db_sysarquivo where codarq = 3973;

--Exclusões da tabela lancamentotaxadiversos
delete from db_syssequencia where codsequencia = 1000605;
delete from db_syscadind where codind IN (4385,4386,4389);
delete from db_sysindices where codind IN (4385,4386,4389);
delete from db_sysforkey where codarq = 3974;
delete from db_sysprikey where codarq = 3974;
delete from db_sysarqcamp where codarq = 3974;
delete from db_syscampo where codcam IN (22057,22058,22059,22060,22079,22061,22062,22124);
delete from db_sysarqmod where codarq = 3974;
delete from db_sysarquivo where codarq = 3974;

--Inserções da tabela taxavaloresreferencia
delete from db_syssequencia  where codsequencia = 1000606;
delete from db_sysprikey     where codarq = 3975;
delete from db_sysarqcamp    where codarq = 3975;
delete from db_syscampo      where codcam IN (22070,22071,22072,22073,22091);
delete from db_sysarqmod     where codarq = 3975;
delete from db_sysarquivo    where codarq = 3975;
delete from db_syscadind     where codcam = 22071;
delete from db_sysindices    where codarq = 3975;

--Exclusão dos menus
delete from db_menu        where id_item_filho IN (10310, 10311, 10312) AND modulo = 277;
delete from db_itensmenu   where id_item IN (10310, 10311, 10312);
delete from db_menu        where id_item_filho IN (10313, 10314, 10315) AND modulo = 277;
delete from db_itensmenu   where id_item IN (10313, 10314, 10315);

--- Tabela diversostaxalancamento
delete from db_sysprikey where codarq = 3978;
delete from db_sysforkey where codarq = 3978;
delete from db_sysarqcamp where codarq = 3978;
delete from db_syssequencia where codsequencia = 1000609;
delete from db_syscampodef where codcam in (22087, 22088, 22089, 22094);
delete from db_syscampodep where codcam in (22087, 22088, 22089, 22094);
delete from db_sysarqcamp where codarq = 3978;
delete from db_syscampo where codcam in (22087, 22088, 22089, 22094);
delete from db_sysarqmod where codarq = 3978;
delete from db_sysarquivo where codarq = 3978;




-- Início módulo Água
delete from db_syssequencia where nomesequencia = 'aguaisencaocgm_x56_sequencial_seq';
delete from db_sysforkey    where codarq = 3977;
delete from db_sysarqcamp   where codarq = 3977;
delete from db_syscampo     where nomecam in(
  'x56_sequencial',
  'x56_aguaisencaotipo',
  'x56_cgm',
  'x56_datainicial',
  'x56_datafinal',
  'x56_processo',
  'x56_observacoes'
);
delete from db_sysarqmod    where codarq = 3977;
delete from db_sysarquivo   where codarq = 3977;
delete from db_sysprikey    where codarq = 3977;

delete from db_menu where id_item = 10320;
delete from db_menu where id_item_filho = 10320;
delete from db_itensmenu where id_item in(10320, 10321, 10322, 10323);

-- Água: Cadastro de Economias
delete from db_syssequencia where nomesequencia = 'aguacontratoeconomia_x38_sequencial_seq';
delete from db_sysforkey    where codarq = 3983;
delete from db_sysarqcamp   where codarq = 3983;
delete from db_syscampo     where nomecam in(
  'x38_sequencial',
  'x38_aguacontrato',
  'x38_cgm',
  'x38_aguacategoriaconsumo',
  'x38_datavalidadecadastro',
  'x38_nis'
);
delete from db_sysarqmod    where codarq = 3983;
delete from db_sysarquivo   where codarq = 3983;
delete from db_sysprikey    where codarq = 3983;

-- Água: Tipos de Contrato
delete from db_syssequencia where nomesequencia = 'aguatipocontrato_x39_sequencial_seq';
delete from db_sysarqcamp   where codarq = 3985;
delete from db_syscampo     where nomecam in(
  'x39_sequencial',
  'x39_descricao'
);
delete from db_sysarqmod    where codarq = 3985;
delete from db_sysarquivo   where codarq = 3985;
delete from db_sysprikey    where codarq = 3985;

delete from db_menu where id_item = 10326;
delete from db_menu where id_item_filho = 10326;
delete from db_itensmenu where id_item in(10326, 10327, 10328, 10329);

-- Água: Contrato
delete from db_sysforkey    where codcam = 22123;
delete from db_sysarqcamp   where codcam in (22122, 22123);
delete from db_syscampo     where nomecam in(
  'x54_condominio',
  'x54_aguatipocontrato'
);
update db_syscampo set nulo = 'false' where codcam = 22074;
-- Fim módulo Água

-- Cobrança Registrada
delete from db_layoutcampos where db52_layoutlinha in (868,867,869,872,873,870,871);
delete from db_layoutlinha where db51_layouttxt in (263);
delete from db_layouttxt where db50_codigo in (263);

delete from db_syscadind where codind = 4387 and codcam = 22092;
delete from db_sysindices where codind = 4387;
delete from db_sysforkey where codarq = 3979 and codcam = 22093;
delete from db_sysarqcamp where codarq = 3979;
delete from db_syscampo where codcam in (22092, 22093);
delete from db_sysarqmod where codmod = 5 and codarq = 3979;
delete from db_sysarquivo where codarq = 3979;

delete from db_sysforkey where codarq = 3981 and codcam = 22102;
delete from db_sysprikey where codarq = 3981 and codcam = 22100;
delete from db_sysarqcamp where codarq = 3981;
delete from db_syssequencia where codsequencia = 1000610;
delete from db_syscampo where codcam in (22100, 22101, 22102, 22103, 22104, 22105);
delete from db_sysarqmod where codmod = 5 and codarq = 3981;
delete from db_sysarquivo where codarq = 3981;

delete from db_sysforkey where codarq = 3982 and codcam = 22108;
delete from db_sysprikey where codarq = 3982 and codcam = 22107;
delete from db_sysarqcamp where codarq = 3982;
delete from db_syssequencia where codsequencia = 1000611;
delete from db_syscampo where codcam in (22107, 22108, 22109);
delete from db_sysarqmod where codmod = 5 and codarq = 3982;
delete from db_sysarquivo where codarq = 3982;

delete from db_menu where id_item_filho = 10324 AND modulo = 1985522;
delete from db_menu where id_item_filho = 10325 AND modulo = 1985522;
delete from db_itensmenu where id_item in (10324, 10325);

delete from db_sysforkey where codarq = 2186 and codcam = 22121;
delete from db_sysarqcamp where codarq = 2186 and codcam = 22121;
delete from db_syscampo where codcam = 22121;
---------------------------------------------------------------------------------------------------------------
---------------------------------------- FIM TRIBUTARIO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------




---------------------------------------------------------------------------------------------------------------
----------------------------------------- INICIO EDUCACAO -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

delete from db_sysarqcamp where codcam = 22090;
delete from db_syscampo   where codcam = 22090;

update db_syscampo set descricao = 'Pai', rotulo = 'Pai', rotulorel = 'Pai' where codcam = 1008899;
update db_syscampo set descricao = 'Mãe', rotulo = 'Mãe', rotulorel = 'Mãe' where codcam = 1008900;

delete from db_menu      where id_item_filho = 10330 AND modulo = 7147;
delete from db_itensmenu where id_item = 10330;


---------------------------------------------------------------------------------------------------------------
------------------------------------------- FIM EDUCACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
----------------------------------------- INICIO FOLHA -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------
delete from db_sysarqcamp where codcam = 22106;
delete from db_syscampo   where codcam in (22106);
  delete from db_sysforkey  where codarq = 3980;
delete from db_sysarqcamp where codarq = 3980;
delete from db_syssequencia where codsequencia = 1000612;
delete from db_syscampo   where codcam in (22112,22095,22096,22097,22098,22110,22111,22099);
delete from db_sysarqmod  where codmod = 28 and codarq = 3980;
delete from db_sysarquivo where  codarq = 3980;
---------------------------------------------------------------------------------------------------------------
----------------------------------------- FIM FOLHA -----------------------------------------------------
---------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
------------------------------------------- INICIO CONFIGURACAO ------------------------------------------------------
---------------------------------------------------------------------------------------------------------------

  -- avaliacaoquestionariointerno

    delete from db_sysarqcamp where codcam = 22024;
    delete from db_sysarqcamp where codcam = 22025;
    delete from db_sysarqcamp where codcam = 22023;
    delete from db_sysarqcamp where codcam = 22022;
    delete from db_sysarqcamp where codcam = 22045;

    delete from db_sysforkey where codcam = 22025;
    delete from db_sysprikey where codarq = 3964;

    delete from db_syscampo where codcam = 22024;
    delete from db_syscampo where codcam = 22025;
    delete from db_syscampo where codcam = 22023;
    delete from db_syscampo where codcam = 22022;
    delete from db_syscampo where codcam = 22045;

    delete from db_syssequencia where codsequencia = 1000598;


    delete from db_sysarqmod where codarq = 3964;
    delete from db_sysarquivo where codarq = 3964;
  --

  -- avaliacaoquestionariointernomenu

    delete from db_sysarqcamp where codcam = 22027;
    delete from db_sysarqcamp where codcam = 22028;
    delete from db_sysarqcamp where codcam = 22026;
    delete from db_sysarqcamp where codcam = 22029;

    delete from db_sysforkey where codcam = 22028;
    delete from db_sysprikey where codarq = 3965;

    delete from db_syscampo where codcam = 22027;
    delete from db_syscampo where codcam = 22028;
    delete from db_syscampo where codcam = 22026;
    delete from db_syscampo where codcam = 22029;

    delete from db_syssequencia where codsequencia = 1000599;
    delete from db_sysarqmod where codarq = 3965;
    delete from db_sysarquivo where codarq = 3965;
  --

  -- itens de menu

    delete from db_itensmenu where id_item = 10267;
    delete from db_menu where id_item_filho = 10267 AND modulo = 1;
    delete from db_itensmenu where id_item = 10268;
    delete from db_menu where id_item_filho = 10268 AND modulo = 1;
    delete from db_itensmenu where id_item = 10269;
    delete from db_menu where id_item_filho = 10269 AND modulo = 1;
  --

  --registros da avaliacao

    -- db_formulas
      delete from
        db_formulas
      where
        db148_sequencial in (
          select distinct
            db148_sequencial
          from
            db_formulas
            inner join avaliacaoperguntadb_formulas on
              eso01_db_formulas = db148_sequencial
            inner join avaliacaopergunta on
              db103_sequencial = eso01_avaliacaopergunta
            inner join avaliacaogrupopergunta on
              db102_sequencial = db103_avaliacaogrupopergunta
            inner join avaliacao on
              db101_sequencial = db102_avaliacao
            where
              db101_avaliacaotipo = 6
        );
    --

    -- avaliacaoperguntadb_formulas
      delete  from
        avaliacaoperguntadb_formulas
      where
        eso01_sequencial in (
          select distinct
            eso01_sequencial
          from
            avaliacaoperguntadb_formulas
            inner join avaliacaopergunta on
              db103_sequencial = eso01_avaliacaopergunta
            inner join avaliacaogrupopergunta on
              db102_sequencial = db103_avaliacaogrupopergunta
            inner join avaliacao on
              db101_sequencial = db102_avaliacao
            where
              db101_avaliacaotipo = 6
        );
    --

    -- avaliacaogrupoperguntaresposta
      delete  from
        avaliacaogrupoperguntaresposta
      where
        db108_sequencial in (
          select
            db108_sequencial
          from
            avaliacaogrupoperguntaresposta
            inner join avaliacaoresposta on
              db106_sequencial = db108_avaliacaoresposta
            inner join avaliacaoperguntaopcao on
              db104_sequencial = db106_avaliacaoperguntaopcao
            inner join avaliacaopergunta on
              db103_sequencial = db104_avaliacaopergunta
            inner join avaliacaogrupopergunta on
              db102_sequencial = db103_avaliacaogrupopergunta
            inner join avaliacao on
              db101_sequencial = db102_avaliacao
          where
            db101_avaliacaotipo = 6
        );
    --

    -- avaliacaoresposta
      delete  from
        avaliacaoresposta
      where
        db106_sequencial in (
          select
            db106_sequencial
          from
            avaliacaoresposta
            inner join avaliacaoperguntaopcao on
              db104_sequencial = db106_avaliacaoperguntaopcao
            inner join avaliacaopergunta on
              db103_sequencial = db104_avaliacaopergunta
            inner join avaliacaogrupopergunta on
              db102_sequencial = db103_avaliacaogrupopergunta
            inner join avaliacao on
              db101_sequencial = db102_avaliacao
          where
            db101_avaliacaotipo = 6
        );
    --

    -- avaliacaoperguntaopcao
      delete  from
        avaliacaoperguntaopcao
      where
        db104_sequencial in (
          select
            db104_sequencial
          from
            avaliacaoperguntaopcao
            inner join avaliacaopergunta on
              db103_sequencial = db104_avaliacaopergunta
            inner join avaliacaogrupopergunta on
              db102_sequencial = db103_avaliacaogrupopergunta
            inner join avaliacao on
              db101_sequencial = db102_avaliacao
          where
            db101_avaliacaotipo = 6
        );
    --

    -- avaliacaopergunta
      delete  from
        avaliacaopergunta
      where
        db103_sequencial in (
          select
            db103_sequencial
          from
            avaliacaopergunta
            inner join avaliacaogrupopergunta on
              db102_sequencial = db103_avaliacaogrupopergunta
            inner join avaliacao on
              db101_sequencial = db102_avaliacao
          where
            db101_avaliacaotipo = 6
        );
    --

    -- avaliacaogrupopergunta
      delete  from
        avaliacaogrupopergunta
      where
        db102_sequencial in (
          select
            db102_sequencial
          from
            avaliacaogrupopergunta
            inner join avaliacao on
              db101_sequencial = db102_avaliacao
          where
            db101_avaliacaotipo = 6
        );
    --

    -- avaliacao
      delete from
        avaliacao
      where
        db101_avaliacaotipo = 6;
    --

    -- avaliacaotipo
      delete from avaliacaotipo where db100_sequencial = 6;
    --
  --
---------------------------------------------------------------------------------------------------------------
--------------------------------------------- FIM CONFIGURACAO -------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
