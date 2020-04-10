<?
require(modification("libs/db_stdlib.php"));
require(modification("libs/db_conecta.php"));
include(modification("libs/db_sessoes.php"));
include(modification("libs/db_usuariosonline.php"));
include(modification("dbforms/db_funcoes.php"));
include(modification("classes/db_avaliacaoquestionariointerno_classe.php"));
db_postmemory($HTTP_POST_VARS);
parse_str($HTTP_SERVER_VARS["QUERY_STRING"]);
$clavaliacaoquestionariointerno = new cl_avaliacaoquestionariointerno;
$clavaliacaoquestionariointerno->rotulo->label("db170_sequencial");
$clavaliacaoquestionariointerno->rotulo->label("db170_sequencial");
?>
<html>
<head>
  <meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>
  <link href='estilos.css' rel='stylesheet' type='text/css'>
  <script language='JavaScript' type='text/javascript' src='scripts/scripts.js'></script>
</head>
<body>
  <form name="form2" method="post" action="" class="container">
    <fieldset>
      <legend>Dados para Pesquisa</legend>
      <table width="35%" border="0" align="center" cellspacing="3" class="form-container">
        <tr>
          <td><label><?=$Ldb170_sequencial?></label></td>
          <td><? db_input("db170_sequencial",10,$Idb170_sequencial,true,"text",4,"","chave_db170_sequencial"); ?></td>
        </tr>
        <tr>
          <td><label><?=$Ldb170_sequencial?></label></td>
          <td><? db_input("db170_sequencial",10,$Idb170_sequencial,true,"text",4,"","chave_db170_sequencial");?></td>
        </tr>
      </table>
    </fieldset>
    <input name="pesquisar" type="submit" id="pesquisar2" value="Pesquisar">
    <input name="limpar" type="reset" id="limpar" value="Limpar" >
    <input name="Fechar" type="button" id="fechar" value="Fechar" onClick="parent.db_iframe_avaliacaoquestionariointerno.hide();">
  </form>
      <?
      if(!isset($pesquisa_chave)){
        if(isset($campos)==false){
           if(file_exists("funcoes/db_func_avaliacaoquestionariointerno.php")==true){
             include(modification("funcoes/db_func_avaliacaoquestionariointerno.php"));
           }else{
           $campos = "avaliacaoquestionariointerno.*";
           }
        }
        if(isset($chave_db170_sequencial) && (trim($chave_db170_sequencial)!="") ){
	         $sql = $clavaliacaoquestionariointerno->sql_query($chave_db170_sequencial,$campos,"db170_sequencial");
        }else if(isset($chave_db170_sequencial) && (trim($chave_db170_sequencial)!="") ){
	         $sql = $clavaliacaoquestionariointerno->sql_query("",$campos,"db170_sequencial"," db170_sequencial like '$chave_db170_sequencial%' ");
        }else{
           $sql = $clavaliacaoquestionariointerno->sql_query("",$campos,"db170_sequencial","");
        }
        $repassa = array();
        if(isset($chave_db170_sequencial)){
          $repassa = array("chave_db170_sequencial"=>$chave_db170_sequencial,"chave_db170_sequencial"=>$chave_db170_sequencial);
        }
        echo '<div class="container">';
        echo '  <fieldset>';
        echo '    <legend>Resultado da Pesquisa</legend>';
          db_lovrot($sql,15,"()","",$funcao_js,"","NoMe",$repassa);
        echo '  </fieldset>';
        echo '</div>';
      }else{
        if($pesquisa_chave!=null && $pesquisa_chave!=""){
         
          $result = $clavaliacaoquestionariointerno->sql_record($clavaliacaoquestionariointerno->sql_query($pesquisa_chave));
          
          if(!$result){

            echo "<script>".$funcao_js."('Chave(".$pesquisa_chave.") n�o Encontrado',true);</script>";
          } else {
           
            if($clavaliacaoquestionariointerno->numrows!=0){
           
              db_fieldsmemory($result,0);
              echo "<script>".$funcao_js."('$db170_sequencial',false);</script>";
            }else{
           
              echo "<script>".$funcao_js."('Chave(".$pesquisa_chave.") n�o Encontrado',true);</script>";
            }
          }
        }else{
	       echo "<script>".$funcao_js."('',false);</script>";
        }
      }
      ?>
</body>
</html>
<?
if(!isset($pesquisa_chave)){
  ?>
  <script>
  </script>
  <?
}
?>
<script>
js_tabulacaoforms("form2","chave_db170_sequencial",true,1,"chave_db170_sequencial",true);
</script>
