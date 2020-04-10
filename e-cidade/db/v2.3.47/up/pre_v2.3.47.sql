--
-- Versão: $Id: pre_v2.3.47.sql,v 1.18 2016/02/03 11:18:46 dbrenan Exp $
--

/****************************************************************************************************************
 * =====================================  Folha de Pagamento (Pessoal/RH) ===================================== *
 ****************************************************************************************************************/
 ---------------------------
 --Cálculo de RRA pra DIRF--
 ---------------------------
 INSERT INTO db_syssequencia VALUES (1000535, 'tipoassefinanceirorra_rh172_sequencial_seq',          1, 1, 9223372036854775807, 1, 1);
 INSERT INTO db_syssequencia VALUES (1000537, 'lancamentorra_rh173_sequencial_seq',                  1, 1, 9223372036854775807, 1, 1);
 INSERT INTO db_syssequencia VALUES (1000538, 'lancamentorraloteregistroponto_rh174_sequencial_seq', 1, 1, 9223372036854775807, 1, 1);
 INSERT INTO db_syssequencia VALUES (1000539, 'db_tabelavalores_db149_sequencial_seq',               1, 1, 9223372036854775807, 1, 1);
 INSERT INTO db_syssequencia VALUES (1000540, 'db_faixavalores_db150_sequencial_seq',                1, 1, 9223372036854775807, 1, 1);
 INSERT INTO db_syssequencia VALUES (1000541, 'faixavaloresirrf_rh175_sequencial_seq',               1, 1, 9223372036854775807, 1, 1);
 INSERT INTO db_syssequencia VALUES (1000542, 'db_tabelavalorestipo_db151_sequencial_seq',           1, 1, 9223372036854775807, 1, 1);

 INSERT INTO db_sysarquivo VALUES (3889, 'tipoassefinanceirorra', 'Contém dados financeiros do RRA(Rendimento Recebidos acumuladamente)', 'rh172', '2015-12-28', 'Configurações do RRA para Assentamento', 0, false, false, false, false);
 INSERT INTO db_sysarquivo VALUES (3890, 'assentamentorra', 'Especialização dos Assentamentos do RRA.', 'h83', '2015-12-28', 'Assentamentos do RRA', 0, false, false, false, false);
 INSERT INTO db_sysarquivo VALUES (3891, 'lancamentorra', 'Armazena os lançamentos do RRA.', 'rh173', '2015-12-28', 'Lançamentos do RRA', 0, false, false, false, false);
 INSERT INTO db_sysarquivo VALUES (3892, 'lancamentorraloteregistroponto', 'Guarda a ligação entre os registros do ponto e os lançamentos do RRA, para que o cancelamento possa ser efetuado.', 'rh174', '2015-12-28', 'Lançamentos RRA do Registro do Ponto', 0, false, false, false, false);
 INSERT INTO db_sysarquivo VALUES (3893, 'db_tabelavalores', 'Representa uma tabela com valores tipo usado em Tabele de Impostos(IRRF), previdência.', 'db149', '2016-01-04', 'Tabela de Valores', 0, false, false, true, false);
 INSERT INTO db_sysarquivo VALUES (3894, 'db_faixavalores', 'Representa a faixa de valor de uma tabela de Valores de Impostos, cálculos, etc.', 'db150', '2016-01-04', 'Faixa de Valor', 0, false, true, true, true);
 INSERT INTO db_sysarquivo VALUES (3895, 'faixavaloresirrf', 'Representa a faixa de valor do IRRF.', 'rh175', '2016-01-04', 'Faixa de Valores do IRRF', 0, false, true, true, true);
 INSERT INTO db_sysarquivo VALUES (3896, 'db_tabelavalorestipo', 'Especializa a a tabela de valores.', 'db151', '2016-01-04', 'TIpo de Tabela de Valores', 0, false, false, false, false);

 INSERT INTO db_sysarqmod VALUES (7, 3893);
 INSERT INTO db_sysarqmod VALUES (7, 3894);
 INSERT INTO db_sysarqmod VALUES (7, 3896);
 INSERT INTO db_sysarqmod VALUES (28, 3889);
 INSERT INTO db_sysarqmod VALUES (28, 3891);
 INSERT INTO db_sysarqmod VALUES (28, 3892);
 INSERT INTO db_sysarqmod VALUES (28, 3895);
 INSERT INTO db_sysarqmod VALUES (29, 3890);


 INSERT INTO db_syscampo VALUES (21647, 'rh172_sequencial', 'int4', 'Identificador do Registro', '', 'Código', 10, false, false, false, 1, 'text', 'Código');
 INSERT INTO db_syscampo VALUES (21648, 'rh172_tipoasse', 'int4', 'Identificador do Tipo do Assentamento', '', 'Tipo de Assentamento', 10, false, false, false, 1, 'text', 'Tipo de Assentamento');
 INSERT INTO db_syscampo VALUES (21649, 'rh172_rubricaprevidencia', 'char(4)', 'Código da Rubrica de Valor descontado de Previdência do RRA', '', 'Rubrica de Previdência', 4, false, true, false, 0, 'text', 'Rubrica de Previdência');
 INSERT INTO db_syscampo VALUES (21650, 'rh172_rubricaprovento', 'char(4)', 'Rubrica de Proventos recebido via RRA', '', 'Rubrica de Provento', 4, false, true, false, 0, 'text', 'Rubrica de Provento');
 INSERT INTO db_syscampo VALUES (21651, 'rh172_rubricapensao', 'char(4)', 'Rubrica de Pensões Alimentícias pagas com reflexo do RRA', '', 'Rubrica de Pensão', 4, false, true, false, 0, 'text', 'Rubrica de Pensão');
 INSERT INTO db_syscampo VALUES (21652, 'rh172_rubricairrf', 'char(4)', 'Rubrica de Descontos retidos na fonte, referente ao Imposto de Renda sobre RRA', '', 'Rubrica de IRRF', 4, false, true, false, 0, 'text', 'Rubrica de IRRF');
 INSERT INTO db_syscampo VALUES (21653, 'rh172_instit', 'int4', 'Instituição das Configurações', '', 'Instituição', 10, false, false, false, 1, 'text', 'Instituição');
 INSERT INTO db_syscampo VALUES (21664, 'rh172_rubricaparceladeducao' ,'char(4)' ,'Rubrica de Encargos, referente ao encargos do processo de RRA' ,'' ,'Rubrica de Encargos' ,4 ,'false' ,'true' ,'false' ,0 ,'text' ,'Rubrica de Encargos' );
 INSERT INTO db_syscampo VALUES (21655, 'h83_assenta', 'int4', 'Código do Assentamento', '0', 'Código do Assentamento', 6, false, false, false, 1, 'text', 'Código do Assentamento');
 INSERT INTO db_syscampo VALUES (21656, 'h83_valor', 'float8', 'Valor bruto do RRA', '', 'Valor', 10, false, false, false, 4, 'text', 'Valor');
 INSERT INTO db_syscampo VALUES (21657, 'h83_meses', 'int4', 'Quantidade de Meses que se refere o valor bruto do RRA', '', 'Quantidade de Meses', 3, false, false, false, 1, 'text', 'Quantidade de Meses');
 INSERT INTO db_syscampo VALUES (21658, 'rh173_sequencial', 'int4', 'Identificador do Lançamento da parcela de pagamento do RRA', '', 'Código', 10, false, false, false, 1, 'text', 'Código');
 INSERT INTO db_syscampo VALUES (21659, 'rh173_assentamentorra', 'int4', 'Identificador do registro do Assentamento do RRA', '', 'Código do Assentamento do RRA', 10, false, false, false, 1, 'text', 'Código do Assentamento do RRA');
 INSERT INTO db_syscampo VALUES (21660, 'rh173_valorlancado', 'float8', 'Valor do Pagamento da Parcela do RRA', '', 'Valor da Parcela', 10, false, false, false, 4, 'text', 'Valor da Parcela');
 INSERT INTO db_syscampo VALUES (21661, 'rh174_sequencial', 'int4', 'Identificador do Registro', '', 'Código do Registro', 10, false, false, false, 1, 'text', 'Código do Registro');
 INSERT INTO db_syscampo VALUES (21662, 'rh174_lancamentorra', 'int4', 'Identificador do Lançamento da parcela de pagamento do RRA', '', 'Código', 10, false, false, false, 1, 'text', 'Código');
 INSERT INTO db_syscampo VALUES (21663, 'rh174_loteregistroponto', 'int4', 'Campo sequencial para guardar sequencia de lotes criados.', '', 'Código do Lote de Registros do Ponto', 19, false, false, false, 1, 'text', 'Código do Lote de Registros do Ponto');
 INSERT INTO db_syscampo VALUES (21665, 'h83_encargos', 'float8', 'Valores processuais do recebimento do RRA', '', 'Despesas Judiciais', 10, false, false, false, 4, 'text', 'Despesas Judiciais');
 INSERT INTO db_syscampo VALUES (21667, 'rh173_encargos', 'float8', 'Valor com custas processuais, como cartórioo, advogado.', '', 'Valor dos Encargos', 10, false, false, false, 4, 'text', 'Valor dos Encargos');
 INSERT INTO db_syscampo VALUES (21668, 'rh173_pensao', 'float8', 'Valor da Pensão Alimenticia, especifica do RRA', '', 'Valor da Pensão', 10, false, false, false, 4, 'text', 'Valor da Pensão');
 INSERT INTO db_syscampo VALUES (21669, 'rh173_baseprevidencia', 'float8', 'Valor utilizado com base para calcular o desconto de previdencia.', '', 'Base Previdencia', 10, false, false, false, 4, 'text', 'Base Previdencia');
 insert into db_syscampo values (21685, 'rh173_baseirrf','float8','\'Valor utilizado com base para calcular o desconto de IRRF.','0', 'Base IRRF',10,'f','f','f',4,'text','Base IRRF');
 INSERT INTO db_syscampo VALUES (21670, 'db149_sequencial', 'int4', 'Código que identifica a tabela de valores.', '', 'Código do Identificador', 10, false, false, false, 1, 'text', 'Código do Identificador');
 INSERT INTO db_syscampo VALUES (21671, 'db149_descricao', 'varchar(100)', 'Descição da Tabela de valores.', '', 'Descrição', 100, false, true, false, 0, 'text', 'Descrição');
 INSERT INTO db_syscampo VALUES (21673, 'db150_sequencial', 'int4', 'Identificador da Faixa.', '', 'Código Identificador', 10, false, false, false, 1, 'text', 'Código Identificador');
 INSERT INTO db_syscampo VALUES (21674, 'db150_db_tabelavalores', 'int4', 'Código que identifica a tabela de valores.', '', 'Código do Identificador', 10, false, false, false, 1, 'text', 'Código do Identificador');
 INSERT INTO db_syscampo VALUES (21675, 'db150_inicio', 'float8', 'Define o valor inicial da faixa', '', 'Inicio da Faixa', 10, false, false, false, 4, 'text', 'Inicio da Faixa');
 INSERT INTO db_syscampo VALUES (21676, 'db150_final', 'float8', 'Fim da faixa de valores.', '', 'Fim da Faixa', 10, false, false, false, 4, 'text', 'Fim da Faixa');
 INSERT INTO db_syscampo VALUES (21677, 'rh175_sequencial', 'int4', 'Identificador do Registro da Faixa do IRRF', '', 'Código do Identificador', 10, false, false, false, 1, 'text', 'Código do Identificador');
 INSERT INTO db_syscampo VALUES (21678, 'rh175_db_faixavalores', 'int4', 'Identificador da Faixa.', '', 'Código Identificador', 10, false, false, false, 1, 'text', 'Código Identificador');
 INSERT INTO db_syscampo VALUES (21679, 'rh175_percentual', 'float8', 'Percentual da Faixa', '', 'Percentual', 10, false, false, false, 4, 'text', 'Percentual');
 INSERT INTO db_syscampo VALUES (21680, 'rh175_deducao', 'float8', 'Valor da dedução do imposto', '', 'Valor da Dedução', 10, false, false, false, 4, 'text', 'Valor da Dedução');
 INSERT INTO db_syscampo VALUES (21681, 'db151_sequencial', 'int4', 'Identificador do Registro', '', 'Identificador do TIpo', 10, false, false, false, 1, 'text', 'Identificador do TIpo');
 INSERT INTO db_syscampo VALUES (21682, 'db151_descricao', 'varchar(100)', 'Descrição do tipo da Tabela', '', 'Descrição', 100, false, true, false, 0, 'text', 'Descrição');
 INSERT INTO db_syscampo VALUES (21698, 'r11_tabelavaloresrra','int4','Tabela de faixas de valores para cálculo de IRRF do RRA','0', 'Tabela de Faixas IRRF RRA',19,'t','f','f',1,'text','Tabela de Faixas IRRF RRA');
 INSERT INTO db_syscampo VALUES (21703, 'rh172_rubricamolestia','char(4)','Código da Rubrica','', 'Rubrica',4,'f','f','f',3,'text','Rubrica');

 UPDATE db_syscampo SET nomecam = 'rh172_rubricairrf', conteudo = 'char(4)', descricao = 'Rubrica de Descontos retidos na fonte, referente ao Imposto de Renda sobre RRA', valorinicial = '', rotulo = 'IRRF', nulo = 'f', tamanho = 4, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'IRRF' where codcam = 21652;
 UPDATE db_syscampo SET nomecam = 'rh172_rubricamolestia', conteudo = 'char(4)', descricao = 'Código da Rubrica', valorinicial = '', rotulo = 'Isenção por Moléstia', nulo = 'f', tamanho = 4, maiusculo = 'f', autocompl = 'f', aceitatipo = 3, tipoobj = 'text', rotulorel = 'Isenção por Moléstia' where codcam = 21703;
 UPDATE db_syscampo SET nomecam = 'rh172_rubricaparceladeducao', conteudo = 'char(4)', descricao = 'Código da Rubrica', valorinicial = '', rotulo = 'Parcela de Dedução', nulo = 'f', tamanho = 4, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Parcela de Dedução' where codcam = 21664;
 UPDATE db_syscampo SET nomecam = 'rh172_rubricapensao', conteudo = 'char(4)', descricao = 'Rubrica de Pensões Alimentícias pagas com reflexo do RRA', valorinicial = '', rotulo = 'Pensão Judicial', nulo = 'f', tamanho = 4, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Pensão Judicial' where codcam = 21651;
 UPDATE db_syscampo SET nomecam = 'rh172_rubricaprevidencia', conteudo = 'char(4)', descricao = 'Código da Rubrica de Valor descontado de Previdência do RRA', valorinicial = '', rotulo = 'Previdência', nulo = 'f', tamanho = 4, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Previdência' where codcam = 21649;
 UPDATE db_syscampo SET nomecam = 'rh172_rubricaprovento', conteudo = 'char(4)', descricao = 'Rubrica de Proventos recebido via RRA', valorinicial = '', rotulo = 'Provento', nulo = 'f', tamanho = 4, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Provento' where codcam = 21650;

 INSERT INTO db_sysforkey VALUES (3889, 21649, 1, 1177, 0);
 INSERT INTO db_sysforkey VALUES (3889, 21650, 2, 1177, 0);
 INSERT INTO db_sysforkey VALUES (3889, 21651, 3, 1177, 0);
 INSERT INTO db_sysforkey VALUES (3889, 21652, 4, 1177, 0);
 INSERT INTO db_sysforkey VALUES (3889, 21653, 5, 1177, 0);
 INSERT INTO db_sysforkey VALUES (3889, 21653, 1, 83, 0);
 INSERT INTO db_sysforkey VALUES (3890, 21655, 1, 528, 0);
 INSERT INTO db_sysforkey VALUES (3891, 21659, 1, 3890, 0);
 INSERT INTO db_sysforkey VALUES (3892, 21662, 1, 3891, 0);
 INSERT INTO db_sysforkey VALUES (3892, 21663, 1, 3798, 0);
 INSERT INTO db_sysforkey VALUES (3889, 21648, 1, 596, 0);
 INSERT INTO db_sysforkey VALUES (3894, 21674, 1, 3893, 0);
 INSERT INTO db_sysforkey VALUES (3895, 21678, 1, 3894, 0);
 INSERT INTO db_sysforkey values (536, 21698, 1, 3893, 0);

 INSERT INTO db_sysindices VALUES (4308, 'assentamentorra_assenta_in', 3890, '0');
 INSERT INTO db_sysindices VALUES (4309, 'lancamentorra_assentamentorra_in', 3891, '0');
 INSERT INTO db_sysindices VALUES (4310, 'lancamentorraloteregistroponto_lancamentorra_in', 3892, '0');
 INSERT INTO db_sysindices VALUES (4311, 'lancamentorraloteregistroponto_loteregistroponto_in', 3892, '0');
 INSERT INTO db_sysindices VALUES (4312, 'db_faixavalores_db_tabelavalores_in', 3894, '0');
 INSERT INTO db_sysindices VALUES (4314, 'faixavaloresirrf_db_faixavalores_in', 3895, '0');
 INSERT INTO db_sysindices VALUES (4319, 'tipoassefinanceirorra_tipoasse_un_in', 3889, '1');

 INSERT INTO db_syscadind VALUES (4308, 21655, 1);
 INSERT INTO db_syscadind VALUES (4309, 21659, 1);
 INSERT INTO db_syscadind VALUES (4310, 21662, 1);
 INSERT INTO db_syscadind VALUES (4311, 21663, 1);
 INSERT INTO db_syscadind VALUES (4312, 21674, 1);
 INSERT INTO db_syscadind VALUES (4314, 21678, 1);
 INSERT INTO db_syscadind VALUES (4319, 21648, 1);

 INSERT INTO db_sysarqcamp VALUES (3892, 21662, 2, 0);
 INSERT INTO db_sysarqcamp VALUES (3892, 21663, 3, 0);
 INSERT INTO db_sysarqcamp VALUES (3892, 21661, 1, 1000538);
 INSERT INTO db_sysarqcamp VALUES (3890, 21655, 2, 0);
 INSERT INTO db_sysarqcamp VALUES (3890, 21656, 3, 0);
 INSERT INTO db_sysarqcamp VALUES (3890, 21657, 4, 0);
 INSERT INTO db_sysarqcamp VALUES (3890, 21665, 5, 0);
 INSERT INTO db_sysarqcamp VALUES (3891, 21658, 1, 1000537);
 INSERT INTO db_sysarqcamp VALUES (3891, 21659, 2, 0);
 INSERT INTO db_sysarqcamp VALUES (3891, 21660, 3, 0);
 INSERT INTO db_sysarqcamp VALUES (3891, 21667, 4, 0);
 INSERT INTO db_sysarqcamp VALUES (3891, 21668, 5, 0);
 INSERT INTO db_sysarqcamp VALUES (3891, 21669, 6, 0);
 INSERT INTO db_sysarqcamp VALUES (3891, 21685, 6, 0);
 INSERT INTO db_sysarqcamp VALUES (3894, 21674, 2, 0);
 INSERT INTO db_sysarqcamp VALUES (3894, 21675, 3, 0);
 INSERT INTO db_sysarqcamp VALUES (3894, 21676, 4, 0);
 INSERT INTO db_sysarqcamp VALUES (3894, 21673, 1, 1000540);
 INSERT INTO db_sysarqcamp VALUES (3895, 21678, 2, 0);
 INSERT INTO db_sysarqcamp VALUES (3895, 21679, 3, 0);
 INSERT INTO db_sysarqcamp VALUES (3895, 21680, 4, 0);
 INSERT INTO db_sysarqcamp VALUES (3895, 21677, 1, 1000541);
 INSERT INTO db_sysarqcamp VALUES (3896, 21682, 2, 0);
 INSERT INTO db_sysarqcamp VALUES (3896, 21681, 1, 1000542);
 INSERT INTO db_sysarqcamp VALUES (3893, 21671, 2, 0);
 INSERT INTO db_sysarqcamp VALUES (3893, 21670, 1, 1000539);
 INSERT INTO db_sysarqcamp VALUES (3889, 21647, 1, 1000535);
 INSERT INTO db_sysarqcamp VALUES (3889, 21648, 2, 0);
 INSERT INTO db_sysarqcamp VALUES (3889, 21649, 3, 0);
 INSERT INTO db_sysarqcamp VALUES (3889, 21650, 5, 0);
 INSERT INTO db_sysarqcamp VALUES (3889, 21651, 6, 0);
 INSERT INTO db_sysarqcamp VALUES (3889, 21652, 7, 0);
 INSERT INTO db_sysarqcamp VALUES (3889, 21653, 9, 0);
 INSERT INTO db_sysarqcamp VALUES (3889, 21664, 9, 0);
 INSERT INTO db_sysarqcamp VALUES (3889, 21703, 9, 0);
 INSERT INTO db_sysarqcamp VALUES (536, 21698, 96, 0);

 INSERT INTO db_syscampodep VALUES (21662, 21658);
 INSERT INTO db_syscampodep VALUES (21663, 21089);
 INSERT INTO db_syscampodep VALUES (21655, 9551);
 INSERT INTO db_syscampodep VALUES (21674, 21670);
 INSERT INTO db_syscampodep VALUES (21678, 21673);

 INSERT INTO db_sysprikey VALUES (3889, 21647, 1, 0, 21647);
 INSERT INTO db_sysprikey VALUES (3890, 21655, 1, 0, 21655);
 INSERT INTO db_sysprikey VALUES (3891, 21658, 1, 0, 21658);
 INSERT INTO db_sysprikey VALUES (3892, 21661, 1, 0, 21662);
 INSERT INTO db_sysprikey VALUES (3893, 21670, 1, 0, 21671);
 INSERT INTO db_sysprikey VALUES (3896, 21681, 1, 0, 21682);
 INSERT INTO db_sysprikey VALUES (3894, 21673, 1, 0, 21675);
 INSERT INTO db_sysprikey VALUES (3895, 21677, 1, 0, 21679);

 -- INSERT INTO db_itensmenu VALUES (10200, 'Faixas de Valores do IRRF', 'Cria e agrupa faixas de valores do IRRF.', 'pes1_faixavaloresirrf001.php', 1, '1', 'Cria e agrupa faixas de valores do IRRF.', true);
 -- update db_itensmenu set funcao = ''where id_item = 10200;
 -- INSERT INTO db_menu VALUES (4374, 10200, 23, 952);
 -- update db_syscampo set rotulo = 'Total Rendimentos Tributáveis' where codcam = 21642;

 -- insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10201 ,'Incluir' ,'Incluir uma nova faixa de valores do IRRF.' ,'pes1_faixavaloresirrf001.php' ,'1' ,'1' ,'Incluir uma nova faixa de valores do IRRF.' ,'true' );
 -- insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10202 ,'Alterar' ,'Alterar uma faixa de valores do IRRF.' ,'pes1_faixavaloresirrf002.php' ,'1' ,'1' ,'Alterar uma faixa de valores do IRRF.' ,'true' );
 -- insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10203 ,'Excluir' ,'Excluir uma faixa de valores do IRRF.' ,'pes1_faixavaloresirrf003.php' ,'1' ,'1' ,'Excluir uma faixa de valores do IRRF.' ,'true' );

 -- insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10200 ,10201 ,1 ,952 );
 -- insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10200 ,10202 ,2 ,952 );
 -- insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10200 ,10203 ,3 ,952 );


---------------------------------------------------------------------------------------------
-------------------------------- INICIO TRIBUTARIO ------------------------------------------
---------------------------------------------------------------------------------------------

update db_itensmenu set id_item = 9065 , descricao = 'Única Individual' , help = 'Inclusão Unica Individual' , funcao = 'arr4_inclusaounica001.php?tipo=individual' , itemativo = '1' , manutencao = '1' , desctec = 'Inclusão Cota Unica Individual' , libcliente = 'true' where id_item = 9065;
update db_itensmenu set id_item = 9066 , descricao = 'Única Geral' ,      help = 'Incluir Unica Geral' ,       funcao = 'arr4_inclusaounica001.php?tipo=geral' , itemativo = '1' , manutencao = '1' , desctec = 'Incluir Unica Geral' , libcliente = 'true' where id_item = 9066;
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10195 ,'Inclusão' ,'Inclusão de parcelas únicas' ,'' ,'1' ,'1' ,'Inclusão de parcelas únicas' ,'true' );

delete from db_menu where id_item_filho = 10195 AND modulo = 1985522;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 9062 ,10195 ,4 ,1985522 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10196 ,'Exclusão' ,'Exclusão de parcelas únicas' ,'' ,'1' ,'1' ,'Exclusão de parcelas únicas' ,'true' );

delete from db_menu where id_item_filho = 10196 AND modulo = 1985522;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 9062 ,10196 ,5 ,1985522 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10197 ,'Única Individual' ,'Exclusão de cota única Individual' ,'arr4_exclusaounicaparcial001.php' ,'1' ,'1' ,'Exclusão de cota única Individual' ,'true' );

delete from db_menu where id_item_filho = 10197 AND modulo = 1985522;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10196 ,10197 ,1 ,1985522 );
insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10198 ,'Única Geral' ,'Exclusão de cota única geral' ,'arr4_exclusaounicageral001.php' ,'1' ,'1' ,'Exclusão de cota única geral' ,'true' );

delete from db_menu where id_item_filho = 10198 AND modulo = 1985522;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10196 ,10198 ,2 ,1985522 );

delete from db_menu where id_item_filho = 9065 AND modulo = 1985522;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 9062 ,9065 ,6 ,1985522 );

delete from db_menu where id_item_filho = 9065 AND modulo = 1985522;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10195 ,9065 ,1 ,1985522 );

delete from db_menu where id_item_filho = 9066 AND modulo = 1985522;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 9062 ,9066 ,6 ,1985522 );

delete from db_menu where id_item_filho = 9066 AND modulo = 1985522;
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10195 ,9066 ,2 ,1985522 );

update db_syscampo set rotulo    = 'Código da Geração'                   where codcam = 18230;
update db_syscampo set rotulo    = 'Data de Vencimento'                  where codcam = 18480;
update db_syscampo set rotulo    = 'Usuário'                             where codcam = 18473;
update db_syscampo set rotulo    = 'Tipo de Geração da Parcela Única'    where codcam = 18475;
update db_syscampo set rotulo    = 'Situação da Geração'                 where codcam = 18476;
update db_syscampo set rotulo    = 'Data de Operação'                    where codcam = 18474;
update db_syscampo set rotulo    = 'Descrição resumida do cancelamento',
                       descricao = 'Descrição resumida do cancelamento'  where codcam = 7763;

update db_sysarquivo set sigla = 'k00' where codarq = 522;

delete from vistretornocalc where y04_codmsg = 25;
insert into vistretornocalc values (25, '25-CONTRIBUINTE OPTANTE PELO SIMPLES NACIONAL NA CATEGORIA MEI');

select fc_executa_ddl('delete from db_sysforkey where codarq = 32 and referen = 3402');
select fc_executa_ddl('delete from db_sysarqcamp where codarq = 32 and codcam = 19156');
select fc_executa_ddl('delete from db_syscampodef where codcam = 19156');
select fc_executa_ddl('delete from db_syscampodep where codcam = 19156');
select fc_executa_ddl('delete from db_syscampo where codcam = 19156');

INSERT INTO iptucadlogcalc values(114, 'OPERAÇÃO CANCELADA, DÉBITOS COM PAGAMENTO PARCIAL!', true);

INSERT INTO db_syscampo (codcam, nomecam, conteudo, descricao, valorinicial, rotulo, tamanho, nulo, maiusculo, autocompl, aceitatipo, tipoobj, rotulorel) VALUES (21701, 'v04_cobrarjurosmultacda', 'bool', 'Cobrar juros e multa até o vencimento do recibo.', 'false', 'Juros e multa até o vencimento do recibo', 1, 'false', 'false', 'false', 5, 'text', 'Juros e multa até o vencimento do recibo');

INSERT INTO db_sysarqcamp (codarq, codcam, seqarq, codsequencia) VALUES (358, 21701, 26, 0);

---------------------------------------------------------------------------------------------
---------------------------------- FIM TRIBUTARIO -------------------------------------------
---------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------------------------
----------------------------------- INICIO EDUCACAO/SAUDE -----------------------------------------
---------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------
-- Inicio Cadastro Avaliação Ficha PSF - Ficha de Avaliação de Elegibilidade e Admissão --
------------------------------------------------------------------------------------------
select fc_executa_ddl('insert into avaliacao( db101_sequencial ,db101_avaliacaotipo ,db101_descricao ,db101_identificador ,db101_obs ,db101_ativo ) values ( 3000007 ,4 ,\'AVALIAÇÃO DE ELEGIBILIDADE E ADMISSÃO\' ,\'f9\' ,\'\' ,\'t\' );');
select fc_executa_ddl('insert into avaliacaogrupopergunta( db102_sequencial ,db102_avaliacao ,db102_descricao ,db102_identificador ) values ( 3000034 ,3000007 ,\'Avaliação de Elegibilidade e Admissão\' ,\'f9g1\' );');
select fc_executa_ddl('insert into avaliacaopergunta( db103_sequencial ,db103_avaliacaotiporesposta ,db103_avaliacaogrupopergunta ,db103_descricao ,db103_identificador ,db103_obrigatoria ,db103_ativo ,db103_ordem ) values ( 3000213 ,3 ,3000034 ,\'Condição(ões) Avaliada(s)\' ,\'f9g1condicoes\' ,\'f\' ,\'t\' ,1 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000768 ,3000213 ,\'Acamado\' ,\'f9g1condicoesAcamado\' ,\'f\' ,1 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000769 ,3000213 ,\'Domiciliado\' ,\'f9g1condicoesDomiciliado\' ,\'f\' ,2 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000770 ,3000213 ,\'Úlceras / Feridas (grau III ou IV)\' ,\'f9g1condicoesUlceras\' ,\'f\' ,3 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000771 ,3000213 ,\'Acompanhamento nutricional\' ,\'f9g1condicoesAcompanhamentoNutricional\' ,\'f\' ,4 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000772 ,3000213 ,\'Uso de sonda naso-gástrica - SNG\' ,\'f9g1condicoesSNG\' ,\'f\' ,5 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000773 ,3000213 ,\'Uso de sonda naso-enteral - SNE\' ,\'f9g1condicoesSNE\' ,\'f\' ,6 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000774 ,3000213 ,\'Uso de gastrostomia\' ,\'f9g1condicoesGastrostomia\' ,\'f\' ,7 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000775 ,3000213 ,\'Uso de colostomia\' ,\'f9g1condicoesColostomia\' ,\'f\' ,8 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000776 ,3000213 ,\'Uso de cistostomia\' ,\'f9g1condicoesCistostomia\' ,\'f\' ,9 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000777 ,3000213 ,\'Uso de sonda vesical de demora - SVD\' ,\'f9g1condicoesSVD\' ,\'f\' ,10 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000778 ,3000213 ,\'Acompanhamento pré-operatório\' ,\'f9g1condicoesPreOperatorio\' ,\'f\' ,11 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000779 ,3000213 ,\'Acompanhamento pós-operatório\' ,\'f9g1condicoesPosOperatorio\' ,\'f\' ,12 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000780 ,3000213 ,\'Adaptação ao uso de órtese / prótese\' ,\'f9g1condicoesOrteseProtese\' ,\'f\' ,13 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000781 ,3000213 ,\'Reabilitação domiciliar\' ,\'f9g1condicoesReabilitacaoDomiciliar\' ,\'f\' ,14 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000782 ,3000213 ,\'Cuidados paliativos oncológico\' ,\'f9g1condicoesPaliativosOncologico\' ,\'f\' ,15 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000783 ,3000213 ,\'Cuidados paliativos não-oncológico\' ,\'f9g1condicoesPaliativosNaoOncologico\' ,\'f\' ,16 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000784 ,3000213 ,\'Oxigenoterapia domiciliar\' ,\'f9g1condicoesOxigenoterapia\' ,\'f\' ,17 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000785 ,3000213 ,\'Uso de traqueostomia\' ,\'f9g1condicoesTraqueostomia\' ,\'f\' ,18 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000786 ,3000213 ,\'Uso de aspirador de vias aéreas para higiene brônquica\' ,\'f9g1condicoesAspiradorViasAereas\' ,\'f\' ,19 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000787 ,3000213 ,\'Suporte ventilatório não invasivo - CPAP\' ,\'f9g1condicoesCPAP\' ,\'f\' ,20 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000788 ,3000213 ,\'Suporte ventilatório não invasivo - BiPAP\' ,\'f9g1condicoesBiPAP\' ,\'f\' ,21 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000789 ,3000213 ,\'Diálise peritonial\' ,\'f9g1condicoesDialisePeritonial\' ,\'f\' ,22 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000790 ,3000213 ,\'Paracentese\' ,\'f9g1condicoesParacentese\' ,\'f\' ,23 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000791 ,3000213 ,\'Medicação parenteral\' ,\'f9g1condicoesMedicacaoParenteral\' ,\'f\' ,24 );');
select fc_executa_ddl('insert into avaliacaopergunta( db103_sequencial ,db103_avaliacaotiporesposta ,db103_avaliacaogrupopergunta ,db103_descricao ,db103_identificador ,db103_obrigatoria ,db103_ativo ,db103_ordem ) values ( 3000214 ,2 ,3000034 ,\'CID (principal)\' ,\'f9g1cid1\' ,\'t\' ,\'t\' ,2 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000792 ,3000214 ,\'\' ,\'f9g1cid1_2\' ,\'true\' ,0 );');
select fc_executa_ddl('insert into avaliacaopergunta( db103_sequencial ,db103_avaliacaotiporesposta ,db103_avaliacaogrupopergunta ,db103_descricao ,db103_identificador ,db103_obrigatoria ,db103_ativo ,db103_ordem ) values ( 3000215 ,2 ,3000034 ,\'CID (secundário) \' ,\'f9g1cid2\' ,\'f\' ,\'t\' ,3 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000793 ,3000215 ,\'\' ,\'f9g1cid2_2\' ,\'true\' ,0 );');
select fc_executa_ddl('insert into avaliacaopergunta( db103_sequencial ,db103_avaliacaotiporesposta ,db103_avaliacaogrupopergunta ,db103_descricao ,db103_identificador ,db103_obrigatoria ,db103_ativo ,db103_ordem ) values ( 3000216 ,2 ,3000034 ,\'CID (secundário)\' ,\'f9g1cid3\' ,\'f\' ,\'t\' ,4 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000794 ,3000216 ,\'\' ,\'f9g1cid3_2\' ,\'true\' ,0 );');
select fc_executa_ddl('insert into avaliacaopergunta( db103_sequencial ,db103_avaliacaotiporesposta ,db103_avaliacaogrupopergunta ,db103_descricao ,db103_identificador ,db103_obrigatoria ,db103_ativo ,db103_ordem ) values ( 3000217 ,1 ,3000034 ,\'Conclusão da Elegibilidade\' ,\'f9g1conclusaoElegibilidade\' ,\'t\' ,\'t\' ,5 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000795 ,3000217 ,\'Elegível - AD1\' ,\'f9g1conclusaoElegibilidadeAD1\' ,\'f\' ,1 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000796 ,3000217 ,\'Elegível - AD2\' ,\'f9g1conclusaoElegibilidadeAD2\' ,\'f\' ,2 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000797 ,3000217 ,\'Elegível - AD3\' ,\'f9g1conclusaoElegibilidadeAD3\' ,\'f\' ,3 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000798 ,3000217 ,\'Inelegível\' ,\'f9g1conclusaoElegibilidadeInelegivel\' ,\'f\' ,4 );');
select fc_executa_ddl('insert into avaliacaopergunta( db103_sequencial ,db103_avaliacaotiporesposta ,db103_avaliacaogrupopergunta ,db103_descricao ,db103_identificador ,db103_obrigatoria ,db103_ativo ,db103_ordem ) values ( 3000218 ,1 ,3000034 ,\'Se elegível, escolha o procedimento\' ,\'f9g1procedimento\' ,\'f\' ,\'t\' ,6 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000799 ,3000218 ,\'Admissão na própria EMAD\' ,\'f9g1procedimentoAdmissao\' ,\'f\' ,1 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000800 ,3000218 ,\'Encaminhado para outra EMAD\' ,\'f9g1procedimentoEncaminhadoEMAD\' ,\'f\' ,2 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000801 ,3000218 ,\'Encaminhado para Atenção Básica (AD1)\' ,\'f9g1procedimentoEncaminhadoBasica\' ,\'f\' ,3 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000802 ,3000218 ,\'Outro encaminhamento\' ,\'f9g1procedimentoEncaminhadoOutro\' ,\'f\' ,4 );');
select fc_executa_ddl('insert into avaliacaopergunta( db103_sequencial ,db103_avaliacaotiporesposta ,db103_avaliacaogrupopergunta ,db103_descricao ,db103_identificador ,db103_obrigatoria ,db103_ativo ,db103_ordem ) values ( 3000219 ,3 ,3000034 ,\'Se inelegível, assinale o(s) motivo(s)\' ,\'f9g1motivo\' ,\'f\' ,\'t\' ,7 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000803 ,3000219 ,\'Instabilidade clínica com necessidade de monitorização contínua\' ,\'f9g1motivoInstabilidadeClinica\' ,\'f\' ,1 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000804 ,3000219 ,\'Necessidade de propedêutica complementar, com demanda potencial para a realização de vários procedimentos diagnósticos, com urgência\' ,\'f9g1motivoNecessidadePropedeutica\' ,\'f\' ,2 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000805 ,3000219 ,\'Outro motivo clínico\' ,\'f9g1motivoOutroMotivoClinico\' ,\'f\' ,3 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000806 ,3000219 ,\'Ausência de cuidador (em caso de necessidade)\' ,\'f9g1motivoAusenciaCuidador\' ,\'f\' ,4 );');
select fc_executa_ddl('insert into avaliacaoperguntaopcao( db104_sequencial ,db104_avaliacaopergunta ,db104_descricao ,db104_identificador ,db104_aceitatexto ,db104_peso ) values ( 3000807 ,3000219 ,\'Outras condições sociais e/ou famil. impeditivas do cuidado domiciliar\' ,\'f9g1motivoOutrasCondicoes\' ,\'f\' ,5 );');
------------------------------------------------------------------------------------------
-- Fim Cadastro Avaliação Ficha PSF - Ficha de Avaliação de Elegibilidade e Admissão -----
------------------------------------------------------------------------------------------


select fc_executa_ddl('insert into db_sysarquivo values (3899, \'cadenderestadosistema\', \'Codigo do Estado em um sistema Externo\', \'db300\', \'2016-01-05\', \'Codigo do Estado Sistema Externo\', 0, \'f\', \'f\', \'f\', \'f\' );');
select fc_executa_ddl('insert into db_sysarqmod  values (7,3899);');
select fc_executa_ddl('insert into db_syscampo   values(21691,\'db300_sequencial\',\'int4\',\'Código pk\',\'0\', \'Código\',10,\'f\',\'f\',\'f\',1,\'text\',\'Código\');');
select fc_executa_ddl('insert into db_syscampo   values(21692,\'db300_db_sistemaexterno\',\'int4\',\'Código do sistema externo\',\'0\', \'Tipo Sistema\',10,\'f\',\'f\',\'f\',1,\'text\',\'Tipo Sistema\');');
select fc_executa_ddl('insert into db_syscampo   values(21693,\'db300_cadenderestado\',\'int4\',\'Estado\',\'0\', \'Estado\',10,\'f\',\'f\',\'f\',1,\'text\',\'Estado\');');
select fc_executa_ddl('insert into db_syscampo   values(21694,\'db300_codigo\',\'varchar(50)\',\'Código real no sistema externo\',\'\', \'Código no sistema externo\',50,\'f\',\'t\',\'f\',0,\'text\',\'Código no sistema externo\');');
select fc_executa_ddl('insert into db_sysarqcamp values(3899,21691,1,0);');
select fc_executa_ddl('insert into db_sysarqcamp values(3899,21692,2,0);');
select fc_executa_ddl('insert into db_sysarqcamp values(3899,21693,3,0);');
select fc_executa_ddl('insert into db_sysarqcamp values(3899,21694,4,0);');
select fc_executa_ddl('insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3899,21691,1,21691);');
select fc_executa_ddl('insert into db_sysforkey  values(3899,21692,1,3291,0);');
select fc_executa_ddl('insert into db_sysforkey  values(3899,21693,1,2780,0);');
select fc_executa_ddl('insert into db_sysindices values(4317,\'cadenderestadosistema_db_sistemaexterno_in\',3899,\'0\');');
select fc_executa_ddl('insert into db_syscadind  values(4317,21692,1);');
select fc_executa_ddl('insert into db_sysindices values(4318,\'cadenderestadosistema_cadenderestado_in\',3899,\'0\');');
select fc_executa_ddl('insert into db_syscadind  values(4318,21693,1);');
select fc_executa_ddl('insert into db_syssequencia values(1000544, \'cadenderestadosistema_db300_sequencial_seq\', 1, 1, 9223372036854775807, 1, 1);');

select fc_executa_ddl('insert into db_sistemaexterno values(8, \'DNE\');');

insert into db_tipodoc values (5024, 'ATESTADO MÉDICO');
insert into db_documentopadrao( db60_coddoc ,db60_descr ,db60_tipodoc ,db60_instit ) values ( 251 ,'ATESTADO MÉDICO' ,5024 ,1 );
insert into db_paragrafopadrao( db61_codparag ,db61_descr ,db61_texto ,db61_alinha ,db61_inicia ,db61_espaco ,db61_alinhamento ,db61_altura ,db61_largura ,db61_tipo ) values ( 546 ,'TÍTULO DO ATESTADO MÉDICO' ,'ATESTADO' ,0 ,0 ,1 ,'J' ,0 ,0 ,1 );
insert into db_docparagpadrao( db62_coddoc ,db62_codparag ,db62_ordem ) values ( 251 ,546 ,1 );
insert into db_paragrafopadrao( db61_codparag ,db61_descr ,db61_texto ,db61_alinha ,db61_inicia ,db61_espaco ,db61_alinhamento ,db61_altura ,db61_largura ,db61_tipo ) values ( 547 ,'CORPO DO ATESTADO MÉDICO' ,'Atesto, para os devidos fins, a pedido do interessado, que o(a) Sr(a). #$nome# #$documento# foi atendido na unidade #$ups# no dia #$data# às #$hora##$cid#. Em decorrência, deverá permanecer afastado de suas atividades laborativas por um período de #$dias# a partir desta data.' ,0 ,0 ,1 ,'J' ,0 ,0 ,1 );
insert into db_docparagpadrao( db62_coddoc ,db62_codparag ,db62_ordem ) values ( 251 ,547 ,2 );
insert into db_paragrafopadrao( db61_codparag ,db61_descr ,db61_texto ,db61_alinha ,db61_inicia ,db61_espaco ,db61_alinhamento ,db61_altura ,db61_largura ,db61_tipo ) values ( 548 ,'CID DO ATESTADO MÉDICO' ,'Eu, #$nome_paciente#, autorizo o(a) Dr(a). #$nome_profissional# a registrar o diagnóstico codificado CID neste atestado.' ,0 ,0 ,1 ,'J' ,0 ,0 ,1 );
insert into db_docparagpadrao( db62_coddoc ,db62_codparag ,db62_ordem ) values ( 251 ,548 ,3 );
---------------------------------------------------------------------------------------------------
----------------------------------- FIM EDUCACAO/SAUDE -----------------------------------------
---------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------
-------------------------------- INICIO CONFIGURACAO ----------------------------------------
---------------------------------------------------------------------------------------------

select fc_executa_ddl('
  insert into db_sysarquivo values (3898, \'db_pluginmodulos\', \'Plugin Módulos\', \'db152\', \'2016-01-05\', \'Plugin Módulos\', 0, \'f\', \'f\', \'f\', \'f\' );
  insert into db_sysarqmod values (7,3898);
  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21686 ,\'db152_sequencial\' ,\'int4\' ,\'Código sequencial da tabela\' ,\'\' ,\'Código\' ,10 ,\'false\' ,\'false\' ,\'false\' ,1 ,\'text\' ,\'Código\' );
  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3898 ,21686 ,1 ,0 );
  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21687 ,\'db152_db_plugin\' ,\'int4\' ,\'Código do Plugin\' ,\'\' ,\'Código do Plugin\' ,10 ,\'false\' ,\'false\' ,\'false\' ,1 ,\'text\' ,\'Código do Plugin\' );
  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3898 ,21687 ,2 ,0 );
  insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21688 ,\'db152_db_modulo\' ,\'int4\' ,\'Código do Módulo\' ,\'\' ,\'Código do Módulo\' ,10 ,\'false\' ,\'false\' ,\'false\' ,1 ,\'text\' ,\'Código do Módulo\' );
  insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3898 ,21688 ,3 ,0 );
  insert into db_syssequencia values(1000543, \'db_pluginmodulos_db152_sequencial_seq\', 1, 1, 9223372036854775807, 1, 1);
  update db_sysarqcamp set codsequencia = 1000543 where codarq = 3898 and codcam = 21686;
  insert into db_sysprikey (codarq,codcam,sequen,camiden) values(3898,21686,1,21686);
  insert into db_sysforkey values(3898,21687,1,3672,0);
  insert into db_sysforkey values(3898,21688,1,168,0);
  insert into db_sysindices values(4315,\'db_pluginmodulos_db152_db_plugin_in\',3898,\'0\');
  insert into db_syscadind values(4315,21687,1);
  insert into db_sysindices values(4316,\'db_pluginmodulos_db152_db_modulo_in\',3898,\'0\');
  insert into db_syscadind values(4316,21688,1);
');

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21696 ,'db146_uid' ,'varchar(255)' ,'Código Único' ,'' ,'Código Único' ,255 ,'true' ,'true' ,'false' ,0 ,'text' ,'Código Único' );
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3673 ,21696 ,4 ,0 );

insert into db_syscampo ( codcam ,nomecam ,conteudo ,descricao ,valorinicial ,rotulo ,tamanho ,nulo ,maiusculo ,autocompl ,aceitatipo ,tipoobj ,rotulorel ) values ( 21697, 'db152_uid', 'varchar(255)', 'Código Único' ,'' ,'Código Único' ,255 ,'true' ,'false','false' ,  0 ,  'text' ,  'Código Único');
insert into db_sysarqcamp ( codarq ,codcam ,seqarq ,codsequencia ) values ( 3898 ,21697 ,4 ,0 );

---------------------------------------------------------------------------------------------
---------------------------------- FIM CONFIGURACAO -----------------------------------------
---------------------------------------------------------------------------------------------