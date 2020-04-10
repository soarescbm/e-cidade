<?
/*
 *     E-cidade Software Publico para Gestao Municipal                
 *  Copyright (C) 2013  DBselller Servicos de Informatica             
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

require("libs/db_stdlibwebseller.php");
require("libs/db_stdlib.php");
require("libs/db_conecta.php");
include("libs/db_sessoes.php");
include("libs/db_usuariosonline.php");
include("classes/db_docaluno_classe.php");
include("classes/db_escola_classe.php");
include("dbforms/db_funcoes.php");
db_postmemory($HTTP_POST_VARS);
$cldocaluno = new cl_docaluno;
$clescola = new cl_escola;
$db_opcao = 1;
$db_botao = true;
$result1 = $cldocaluno->sql_record($cldocaluno->sql_query_file("","ed49_i_documentacao as docjacad",""," ed49_i_aluno = $ed49_i_aluno"));
if($cldocaluno->numrows>0){
 $sep = "";
 $doc_cad = "";
 for($c=0;$c<$cldocaluno->numrows;$c++){
  db_fieldsmemory($result1,$c);
  $doc_cad .= $sep.$docjacad;
  $sep = ",";
 }
}else{
 $doc_cad = 0;
}
if(isset($incluir)){
 db_inicio_transacao();
 $cldocaluno->incluir($ed49_i_codigo);
 db_fim_transacao();
}
if(isset($alterar)){
  db_inicio_transacao();
  $db_opcao = 2;
  $cldocaluno->alterar($ed49_i_codigo);
  db_fim_transacao();
}
if(isset($excluir)){
  db_inicio_transacao();
  $db_opcao = 3;
  $cldocaluno->excluir($ed49_i_codigo);
  db_fim_transacao();
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
<body bgcolor="#CCCCCC" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="a=1" >
<table width="100%" border="0" cellspacing="0" cellpadding="0">
 <tr>
  <td height="430" align="left" valign="top" bgcolor="#CCCCCC">
   <center>
   <fieldset style="width:95%"><legend><b>Documentação Pendente</b></legend>
    <?include("forms/db_frmdocaluno.php");?>
   </fieldset>
   </center>
  </td>
 </tr>
</table>
</body>
</html>
<?
if(isset($incluir)){
 if($cldocaluno->erro_status=="0"){
  $cldocaluno->erro(true,false);
  $db_botao=true;
  echo "<script> document.form1.db_opcao.disabled=false;</script>  ";
  if($cldocaluno->erro_campo!=""){
   echo "<script> document.form1.".$cldocaluno->erro_campo.".style.backgroundColor='#99A9AE';</script>";
   echo "<script> document.form1.".$cldocaluno->erro_campo.".focus();</script>";
  };
 }else{
  $cldocaluno->erro(true,true);
 };
};
if(isset($alterar)){
  if($cldocaluno->erro_status=="0"){
    $cldocaluno->erro(true,false);
    $db_botao=true;
    echo "<script> document.form1.db_opcao.disabled=false;</script>  ";
    if($cldocaluno->erro_campo!=""){
      echo "<script> document.form1.".$cldocaluno->erro_campo.".style.backgroundColor='#99A9AE';</script>";
      echo "<script> document.form1.".$cldocaluno->erro_campo.".focus();</script>";
    };
  }else{
    $cldocaluno->erro(true,true);
  };
};
if(isset($excluir)){
  if($cldocaluno->erro_status=="0"){
    $cldocaluno->erro(true,false);
  }else{
    $cldocaluno->erro(true,true);
  };
};
if(isset($cancelar)){
 echo "<script>location.href='".$cldocaluno->pagina_retorno."'</script>";
}
?>