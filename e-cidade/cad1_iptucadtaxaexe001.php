<?php
/*
 *     E-cidade Software Publico para Gestao Municipal                
 *  Copyright (C) 2014  DBSeller Servicos de Informatica             
 *                            www.dbseller.com.br                     
 *                         e-cidade@dbseller.com.br                   
 *                                                                    
 *  Este programa e software livre; voce pode redistribui-lo e/ou     
 *  modifica-lo sob os termos da Licenca Publica Geral GNU, conforme  
 *  publicada pela Free Software Foundation; tanto a versao 2 da      
 *  Licenca como (a seu criterio) qualquer versao mais nova.          
 *                                                                    
 *  Este programa e distribuido na expectativa de ser util, mas SEM   
 *  QUALQUER GARANTIA; sem mesmo a garantia implicita de              
 *  COMERCIALIZACAO ou de ADEQUACAO A QUALQUER PROPOSITO EM           
 *  PARTICULAR. Consulte a Licenca Publica Geral GNU para obter mais  
 *  detalhes.                                                         
 *                                                                    
 *  Voce deve ter recebido uma copia da Licenca Publica Geral GNU     
 *  junto com este programa; se nao, escreva para a Free Software     
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA          
 *  02111-1307, USA.                                                  
 *  
 *  Copia da licenca no diretorio licenca/licenca_en.txt 
 *                                licenca/licenca_pt.txt 
 */

require_once(modification("libs/db_stdlib.php"));
require_once(modification("libs/db_conecta.php"));
require_once(modification("libs/db_sessoes.php"));
require_once(modification("libs/db_usuariosonline.php"));
require_once(modification("classes/db_iptucadtaxaexe_classe.php"));
require_once(modification("classes/db_iptucadtaxa_classe.php"));
require_once(modification("dbforms/db_funcoes.php"));

parse_str($_SERVER["QUERY_STRING"]);
db_postmemory($_POST);
$cliptucadtaxaexe = new cl_iptucadtaxaexe;
$cliptucadtaxa    = new cl_iptucadtaxa;
$db_opcao = 22;
$db_botao = false;

if (isset($alterar) || isset($excluir) || isset($incluir)) {
  $sqlerro = false;
}

if (isset($incluir)) {

  if ($sqlerro == false){

    db_inicio_transacao();
    $cliptucadtaxaexe->incluir($j08_iptucadtaxaexe);
    $erro_msg = $cliptucadtaxaexe->erro_msg;

    if ($cliptucadtaxaexe->erro_status == 0) {
      $sqlerro=true;
    }

    db_fim_transacao($sqlerro);
  }

} else if (isset($alterar)) {

  if ($sqlerro == false) {

    db_inicio_transacao();
    $cliptucadtaxaexe->alterar($j08_iptucadtaxaexe);
    $erro_msg = $cliptucadtaxaexe->erro_msg;
    
    if ($cliptucadtaxaexe->erro_status == 0) {
      $sqlerro=true;
    }

    db_fim_transacao($sqlerro);
  }

} else if (isset($excluir)) {
  
  if ($sqlerro == false) {
    
    db_inicio_transacao();
    $cliptucadtaxaexe->excluir($j08_iptucadtaxaexe);
    $erro_msg = $cliptucadtaxaexe->erro_msg;
    
    if ($cliptucadtaxaexe->erro_status == 0) {
      $sqlerro=true;
    }

    db_fim_transacao($sqlerro);
  }

} else if (isset($opcao)) {

    $result = $cliptucadtaxaexe->sql_record($cliptucadtaxaexe->sql_query($j08_iptucadtaxaexe));
    
    if ($result != false && $cliptucadtaxaexe->numrows > 0) {
      db_fieldsmemory($result,0);
    }
}
?>
<html>
<head>
<title>DBSeller Inform&aacute;tica Ltda - P&aacute;gina Inicial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Expires" CONTENT="0">
<script language="JavaScript" type="text/javascript" src="scripts/scripts.js"></script>
<link href="estilos.css" rel="stylesheet" type="text/css">
</head>
<body class="body-default" onLoad="a=1">
	<?php
    include(modification("forms/db_frmiptucadtaxaexe.php"));
	?>
</body>
</html>
<?php
if (isset($alterar) || isset($excluir) || isset($incluir)) {

  db_msgbox($erro_msg);
  
  if ($cliptucadtaxaexe->erro_campo != "") {
    echo "<script> document.form1.".$cliptucadtaxaexe->erro_campo.".style.backgroundColor='#99A9AE';</script>";
    echo "<script> document.form1.".$cliptucadtaxaexe->erro_campo.".focus();</script>";
  }
}
?>