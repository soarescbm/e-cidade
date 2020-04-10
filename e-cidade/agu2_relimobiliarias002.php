<?php
/*
 *     E-cidade Software Publico para Gestao Municipal                
 *  Copyright (C) 2014  DBselller Servicos de Informatica             
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

require_once(modification("fpdf151/pdf.php"));
require_once(modification("libs/db_sql.php"));
require_once(modification("libs/db_stdlib.php"));
require_once(modification("libs/db_conecta.php"));
require_once(modification("libs/db_sessoes.php"));
require_once(modification("libs/db_usuariosonline.php"));
require_once(modification("libs/db_utils.php"));

$oGet = db_utils::postMemory($_GET);

$oPdf = new PDF();

if(isset($oGet->zona) and $oGet->zona != '') {
  $iZona = $oGet->zona;
}

if(isset($oGet->ano) and $oGet->ano != '') {
  $iAno = $oGet->ano;
}

if(isset($oGet->mes) and $oGet->mes != '') {
  $iMes = $oGet->mes;
}

$sSql = "
         select x01_matric as matricula, 
                x54_sequencial as contrato, 
                z01_nome as nome, 
                z01_ender as endereco, 
                k00_dtvenc as vencto, 
                k00_numpar as parcela, 
                to_char(valor_serv_agua, '999,990.00') as valor_serv_agua,
                to_char(valor_serv_esgoto, '999,990.00') as valor_serv_esgoto, 
                to_char(valor_cons_agua, '999,990.00') as valor_cons_agua, 
                to_char(valor_cole_esgoto, '999,990.00') as valor_cole_esgoto,
                to_char(valor_extras, '999,990.00') as valor_extras,
                to_char(valor_serv_agua+valor_serv_esgoto+valor_cons_agua+valor_cole_esgoto+valor_extras, '999,990.00') as valor_total
           from 
                fc_agua_relatorio_imobiliaria(139, $iAno, $iMes, '$iZona') 
          order by nome";

$rSql = db_query($sSql);

$head2 = "FILTROS UTILIZADOS";
$head4 = "EXERC�CIO: $iAno";
$head6 = "M�S: ".db_mes($iMes, 1);
$head8 = "ZONA(S): $iZona";

$oPdf->Open();
$oPdf->AliasNBPages();
$oPdf->setfillcolor(235);
$oPdf->setfont('arial','b',8);
$oPdf->DefOrientation = "L";

$troca = 1;
$alt   = 4;
$total = 0;

for($i = 0; $i < pg_num_rows($rSql); $i++) {
  
  $oRelatorio = db_utils::fieldsMemory($rSql, $i, true);
  
  if ($oPdf->gety() > $oPdf->h - 30 || $troca != 0 ){
    $oPdf->addpage();
    $oPdf->setfont('arial','b',7);
    $oPdf->cell(13, $alt, 'Contrato'   , 1, 0, "C", 1);
    $oPdf->cell(13, $alt, 'Matricula'  , 1, 0, "C", 1);
    $oPdf->cell(64, $alt, 'Nome'       , 1, 0, "C", 1); 
    $oPdf->cell(64, $alt, 'Logradouro' , 1, 0, "C", 1);
    $oPdf->cell(18, $alt, 'Vencimento' , 1, 0, "C", 1);
    $oPdf->cell(12, $alt, 'Parcela'    , 1, 0, "C", 1);
    $oPdf->cell(15, $alt, '�gua'       , 1, 0, "C", 1);
    $oPdf->cell(15, $alt, 'Esgoto'     , 1, 0, "C", 1);
    $oPdf->cell(15, $alt, 'Consumo'    , 1, 0, "C", 1);
    $oPdf->cell(15, $alt, 'Coleta'     , 1, 0, "C", 1);
    $oPdf->cell(15, $alt, 'Extras'     , 1, 0, "C", 1);    
    $oPdf->cell(18, $alt, 'Total'      , 1, 1, "C", 1); 
    $troca = 0;
    $p=0;
  }
  
  $oPdf->setfont('arial','',7);
   
  $oPdf->cell(13, $alt, $oRelatorio->contrato         , 0, 0, "C", $p);
  $oPdf->cell(13, $alt, $oRelatorio->matricula        , 0, 0, "C", $p);
  $oPdf->cell(64, $alt, $oRelatorio->nome             , 0, 0, "L", $p);
  $oPdf->cell(64, $alt, $oRelatorio->endereco         , 0, 0, "L", $p);
  $oPdf->cell(18, $alt, $oRelatorio->vencto           , 0, 0, "C", $p);
  $oPdf->cell(12, $alt, $oRelatorio->parcela          , 0, 0, "C", $p);
  $oPdf->cell(15, $alt, $oRelatorio->valor_serv_agua  , 0, 0, "C", $p);
  $oPdf->cell(15, $alt, $oRelatorio->valor_serv_esgoto, 0, 0, "C", $p);
  $oPdf->cell(15, $alt, $oRelatorio->valor_cons_agua  , 0, 0, "C", $p);
  $oPdf->cell(15, $alt, $oRelatorio->valor_cole_esgoto, 0, 0, "C", $p);
  $oPdf->cell(15, $alt, $oRelatorio->valor_extras     , 0, 0, "C", $p);
  $oPdf->cell(18, $alt, $oRelatorio->valor_total      , 0, 1, "C", $p);
   
  if($p == 0) 
    $p = 1;
  else 
    $p = 0;
   
  $total++;
  
}

$oPdf->setfont('arial','b',8);
$oPdf->cell(0,$alt,'TOTAL DE REGISTROS  :  '.$total,"T",0,"L",0);
$oPdf->Output();