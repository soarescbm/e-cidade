create temporary table w_up_6991_db_syscampo as select * from db_syscampo limit 0;
           insert into w_up_6991_db_syscampo
                values(22030,'s152_subjetivo','text','Campo que possibilita o registro da parte subjetiva da anamnese da consulta,ou seja,os dados dos sentimentos e percepções do cidadão em relação à sua saúde.','', 'Subjetivo',1,'t','t','f',0,'text','Subjetivo');

insert into db_syscampo
     select *
       from w_up_6991_db_syscampo
      where not exists ( select 1
                           from db_syscampo
                          where db_syscampo.codcam = w_up_6991_db_syscampo.codcam);

create temporary table w_up_6991_db_sysarqcamp as select * from db_sysarqcamp limit 0;
           insert into w_up_6991_db_sysarqcamp
               values (3043,22030,22,0);

insert into db_sysarqcamp
     select *
       from w_up_6991_db_sysarqcamp
      where not exists ( select 1
                           from db_sysarqcamp
                          where db_sysarqcamp.codarq = w_up_6991_db_sysarqcamp.codarq
                            and db_sysarqcamp.codcam = w_up_6991_db_sysarqcamp.codcam
                            and db_sysarqcamp.seqarq = w_up_6991_db_sysarqcamp.seqarq);

update db_syscampo set nomecam = 's152_evolucao', conteudo = 'text', descricao = 'Campo que possibilita o registro do exame físico, como, por exemplo, os sinais e sintomas detectados, além do registro de resultados de exames realizados.( antigo campo da Evolução )', valorinicial = '', rotulo = 'Objetivo', nulo = 't', tamanho = 1, maiusculo = 't', autocompl = 'f', aceitatipo = 0, tipoobj = 'text', rotulorel = 'Objetivo' where codcam = 20973;

alter table sau_triagemavulsa add column s152_subjetivo text null;

DROP TABLE IF EXISTS w_up_6991_db_syscampo;
DROP TABLE IF EXISTS w_up_6991_db_sysarqcamp;