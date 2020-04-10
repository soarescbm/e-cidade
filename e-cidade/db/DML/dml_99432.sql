insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10201 ,'Incluir' ,'Incluir uma nova faixa de valores do IRRF.' ,'pes1_faixavaloresirrf001.php' ,'1' ,'1' ,'Incluir uma nova faixa de valores do IRRF.' ,'true' );
  insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10202 ,'Alterar' ,'Alterar uma faixa de valores do IRRF.' ,'pes1_faixavaloresirrf002.php' ,'1' ,'1' ,'Alterar uma faixa de valores do IRRF.' ,'true' );
  insert into db_itensmenu ( id_item ,descricao ,help ,funcao ,itemativo ,manutencao ,desctec ,libcliente ) values ( 10203 ,'Excluir' ,'Excluir uma faixa de valores do IRRF.' ,'pes1_faixavaloresirrf003.php' ,'1' ,'1' ,'Excluir uma faixa de valores do IRRF.' ,'true' );

insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10200 ,10201 ,1 ,952 );
insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10200 ,10202 ,2 ,952 );
 insert into db_menu ( id_item ,id_item_filho ,menusequencia ,modulo ) values ( 10200 ,10203 ,3 ,952 );
 update naturezatipoassentamento set rh159_descricao = 'Padrão' where rh159_sequencial = 1;
 update naturezatipoassentamento set rh159_descricao = 'Substituição' where rh159_sequencial = 2;
 insert into naturezatipoassentamento values(3, 'RRA');
 insert into db_tabelavalorestipo (db151_descricao) values ('Default');
 insert into db_tabelavalorestipo (db151_descricao) values ('IRRF RRA');



