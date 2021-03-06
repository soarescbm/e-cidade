<?
/*
 *     E-cidade Software Publico para Gestao Municipal                
 *  Copyright (C) 2009  DBselller Servicos de Informatica             
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

require("libs/db_stdlib.php");
require("libs/db_conecta.php");
include("libs/db_sessoes.php");
include("libs/db_usuariosonline.php");
include("classes/db_marcaloc_classe.php");
include("dbforms/db_funcoes.php");
parse_str($HTTP_SERVER_VARS["QUERY_STRING"]);
db_postmemory($HTTP_POST_VARS);
$clmarcaloc = new cl_marcaloc;
$db_opcao = 1;
$db_botao = true;
if(isset($incluir)){
  db_inicio_transacao();
  $db_opcao = 1;
  $clmarcaloc->incluir($ma05_i_codigo);
  db_fim_transacao();
  if($clmarcaloc->erro_status=="0"){
   $clmarcaloc->erro(true,false);
   echo "<script> document.form1.db_opcao.disabled=false;</script>";
   if($clmarcaloc->erro_campo!=""){
    echo "<script> document.form1.".$clmarcaloc->erro_campo.".style.backgroundColor='#99A9AE';</script>";
    echo "<script> document.form1.".$clmarcaloc->erro_campo.".focus();</script>";
   }
  }else{
   $clmarcaloc->erro(true,false);
   $pagina = basename($GLOBALS["HTTP_SERVER_VARS"]["PHP_SELF"])."?ma05_i_marca=$ma05_i_marca&z01_nome=$z01_nome";?>
   <script>location.href ="<?=$pagina?>";</script><?
  }
}
if(isset($alterar)){
  db_inicio_transacao();
  $db_opcao = 2;
  $db_botao1 = true;
  $clmarcaloc->alterar($ma05_i_codigo);
  db_fim_transacao();
  if($clmarcaloc->erro_status=="0"){
   $clmarcaloc->erro(true,false);
   echo "<script> document.form1.db_opcao.disabled=false;</script>";
   if($clmarcaloc->erro_campo!=""){
    echo "<script> document.form1.".$clmarcaloc->erro_campo.".style.backgroundColor='#99A9AE';</script>";
    echo "<script> document.form1.".$clmarcaloc->erro_campo.".focus();</script>";
   }
  }else{
   $clmarcaloc->erro(true,false);
   $pagina = basename($GLOBALS["HTTP_SERVER_VARS"]["PHP_SELF"])."?ma05_i_marca=$ma05_i_marca&z01_nome=$z01_nome";?>
   <script>location.href ="<?=$pagina?>";</script><?
  }
}
if(isset($excluir)){
 db_inicio_transacao();
 $db_opcao = 3;
 $clmarcaloc->excluir($ma05_i_codigo);
 db_fim_transacao();
 if($clmarcaloc->erro_status=="0"){
  $clmarcaloc->erro(true,false);
 }else{
  $clmarcaloc->erro(true,false);
  $pagina = basename($GLOBALS["HTTP_SERVER_VARS"]["PHP_SELF"])."?ma05_i_marca=$ma05_i_marca&z01_nome=$z01_nome";?>
  <script>location.href ="<?=$pagina?>";</script><?
 }
}
if(isset($cancelar)){
 $pagina = basename($GLOBALS["HTTP_SERVER_VARS"]["PHP_SELF"])."?ma05_i_marca=$ma05_i_marca&z01_nome=$z01_nome";?>
 <script>location.href ="<?=$pagina?>";</script><?
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
<body bgcolor=#CCCCCC leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="a=1" >
<table width="790" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td height="430" align="left" valign="top" bgcolor="#CCCCCC"> 
    <center>
        <?
        include("forms/db_frmmarcaloc.php");
        ?>
    </center>
        </td>
  </tr>
</table>
</body>
</html>