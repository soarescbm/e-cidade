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
require_once ("libs/db_stdlibwebseller.php");
require_once ("libs/db_stdlib.php");
require_once ("libs/db_conecta.php");
require_once ("libs/db_sessoes.php");
require_once ("libs/db_usuariosonline.php");
require_once ("dbforms/db_funcoes.php");

parse_str( $_SERVER["QUERY_STRING"] );
db_postmemory( $_POST );

$clserie             = new cl_serie;
$clserieregimemat    = new cl_serieregimemat;
$oDaoSerieCensoEtapa = new cl_seriecensoetapa();

$db_botao = false;
$db_opcao = 33;

if( isset( $excluir ) ) {

  $db_opcao = 3;

  db_inicio_transacao();


  $oDaoSerieCensoEtapa->excluir( "", " ed133_serie = {$ed11_i_codigo} ");
  $clserieregimemat->excluir( "", " ed223_i_serie = {$ed11_i_codigo}" );
  $clserie->excluir($ed11_i_codigo);
  db_fim_transacao();
} else if( isset( $chavepesquisa ) ) {

  $db_opcao = 3;
  $result   = $clserie->sql_record( $clserie->sql_query( $chavepesquisa ) );

  db_fieldsmemory( $result, 0 );
  $db_botao = true;
}
?>
<html>
<head>
  <title>DBSeller Inform&aacute;tica Ltda - P&aacute;gina Inicial</title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <meta http-equiv="Expires" CONTENT="0">
  <script language="JavaScript" type="text/javascript" src="scripts/scripts.js"></script>
  <script language="JavaScript" type="text/javascript" src="scripts/prototype.js"></script>
  <link href="estilos.css" rel="stylesheet" type="text/css">
</head>
<body class="body-default">
<?php
include("forms/db_frmserie.php");
?>
</body>
</html>
<script>
 js_tabulacaoforms("form1","excluir",true,1,"excluir",true);
</script>
<?php
if( isset( $excluir ) ) {

  if( $clserie->erro_status == "0" ) {
    $clserie->erro( true, false );
  } else {
    $clserie->erro( true, true );
  }
}

if( $db_opcao == 33 ) {
  echo "<script>document.form1.pesquisar.click();</script>";
}