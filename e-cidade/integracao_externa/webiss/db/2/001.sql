-- Deve permitir ao usuario "integraiss" realizar insert/delete na tabela "integra_cadastro"
SELECT fc_grant('integraiss', 'delete,insert', 'public', 'integra_cadastro');
