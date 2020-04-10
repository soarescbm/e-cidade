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


include("fpdf151/pdf.php");
db_postmemory($HTTP_SERVER_VARS);

$sql = "
select * 
from diversos a 
     inner join arrepaga b on a.k00_numpre = b.k00_numpre 
where procdiver = 221 
  and b.k00_dtpaga between '" . db_getsession("DB_anousu") . "-01-01' and '" . db_getsession("DB_anousu") . "-03-31' 
  and exerc = " . db_getsession("DB_anousu") . ";
       ";
$seleciona_conta = '';
$descr_conta = 'TODAS AS CONTAS';
if($conta != 0) {
  $seleciona_conta = ' and corrente.k12_instit = '. db_getsession('DB_instit'). ' and corrente.k12_conta = '.$conta;
  $sql = 'select * from saltes 
               inner join conplanoexe   on k13_reduz = c61_reduz and c61_anousu ='. db_getsession('DB_anousu').'
               inner join conplanoreduz on c61_reduz = c62_reduz and c61_instit = '. db_getsession('DB_instit') . ' and c61_anousu=c62_anousu

  where k13_conta = '.$conta;
  $result = pg_exec($sql);
  db_fieldsmemory($result,0);
  $descr_conta = "CONTA : ".$conta.' - '.$k13_descr;
}

$head5 = "BOLETIM DE CAIXA E DE BANCOS";
$pdf = new PDF();
$pdf->Open();
$pdf->AliasNbPages();
$pdf->AddPage();
$pdf->SetFont('Arial','B',12);
$pdf->SetTextColor(0,100,255);
$pdf->Cell(190,15,"RECEITAS ORÇAMENTÁRIAS",1,1,"C",0);

$pdf->SetFont('Arial','B',8);
$pdf->SetTextColor(0,100,255);
$CoL1 = 30;
$CoL2 = 70;
$CoL3 = 30;
$CoL4 = 30;
$CoL5 = 30;
$StrPad1 = 20;
$StrPad2 = 26;
$pdf->Cell($CoL1,5,"ESTRUTURAL",1,0,"C",0);
$pdf->Cell($CoL2,5,"DESCRICAO",1,0,"C",0);
$pdf->Cell($CoL3,5,"COD.RECEITA",1,0,"C",0);
$pdf->Cell($CoL4,5,"ARRECADACAO",1,0,"C",0);
$pdf->Cell($CoL5,5,"ESTORNO",1,1,"C",0);

parse_str($HTTP_SERVER_VARS["QUERY_STRING"]);

/*
$result = pg_exec("
select k02_estorc,upper(o02_descr) as o02_descr,k12_receit,arrec, estorno 
from orcam 
  left outer join 
(
select k02_estorc,k12_receit,sum(k12_arrec) as arrec, sum(k12_estorno) as estorno
from 
(select k02_estorc,corrente.k12_conta,cornump.k12_receit,case when cornump.k12_valor > 0 then cornump.k12_valor else 0 end as k12_arrec, case when cornump.k12_valor < 0 then cornump.k12_valor else 0 end as k12_estorno
 from corrente
      left join cornump   
           on corrente.k12_id     = cornump.k12_id 
           and corrente.k12_data   = cornump.k12_data 
           and corrente.k12_autent = cornump.k12_autent
     left join tabrec 
           on cornump.k12_receit = k02_codigo 
     left join taborc
	       on tabrec.k02_codigo = taborc.k02_codigo and taborc.k02_anousu = ".$GLOBALS["DB_anousu"]."
 where corrente.k12_data between '$datai' and '$dataf'
 order by taborc.k02_estorc
) as x
group by k02_estorc, k12_receit
order by k02_estorc
) as receitas 
on k02_estorc::char(13) = o02_codigo and o02_anousu =  ".$GLOBALS["DB_anousu"]."
where arrec <> 0 or estorno <> 0 
");
*/

$result = pg_exec("
select k02_estorc,upper(o02_descr) as o02_descr,k12_receit,arrec, estorno 
from orcam 
  left outer join 
  (select k02_estorc,k12_receit,sum(k12_arrec) as arrec, sum(k12_estorno) as estorno
   from 
       (select k02_estorc,corrente.k12_conta,cornump.k12_receit,case when cornump.k12_valor > 0 then cornump.k12_valor else 0 end as k12_arrec, case when cornump.k12_valor < 0 then cornump.k12_valor else 0 end as k12_estorno
        from corrente
		left join cornump	on corrente.k12_id	= cornump.k12_id 
           				and corrente.k12_data	= cornump.k12_data 
           				and corrente.k12_autent	= cornump.k12_autent
		left join tabrec	on cornump.k12_receit	= k02_codigo 
     		left join taborc	on tabrec.k02_codigo	= taborc.k02_codigo 
					and taborc.k02_anousu	= ".$GLOBALS["DB_anousu"]."
 	where 	corrente.k12_instit = " . db_getsession('DB_instit') . "
		corrente.k12_data between '".$datai."' and '".$dataf."' ".$seleciona."".$seleciona_conta."
	order by taborc.k02_estorc
	) as x
   group by k02_estorc, k12_receit
   order by k02_estorc
   ) as receitas 			on k02_estorc::char(13) = o02_codigo 
					and o02_anousu =  ".$GLOBALS["DB_anousu"]."
where arrec <> 0 or estorno <> 0 order by k02_estorc

");

$numrows = pg_numrows($result);
$QuebraPagina = 10;
$Total1 = 0;
$Total2 = 0;
$SubTotal1 = 0;
$SubTotal2 = 0;
$pdf->SetFont('Courier','',8);
for($i = 0;$i < $numrows;$i++) {
  db_fieldsmemory($result,$i);
//  if ( ($arrec) != 0 || ($estorno) != 0 ) {
     if($QuebraPagina++ == 46) {
   	    $pdf->SetFont('Arial','B',8);
        $pdf->SetTextColor(255,0,0);
        $pdf->Cell($CoL1,5,"SUB-TOTAL",1,0,"C",0);
        $pdf->Cell($CoL2,5," ",1,0,"R",0);
        $pdf->Cell($CoL3,5," ",1,0,"R",0);
        $pdf->Cell($CoL4,5,number_format($SubTotal1,2,",","."),1,0,"R",0);
        $pdf->Cell($CoL5,5,number_format($SubTotal2,2,",","."),1,1,"R",0);
        $pdf->SetTextColor(0,0,0);
        $pdf->AddPage();
        $pdf->SetFont('Arial','B',8);
        $pdf->SetTextColor(0,100,255);
        $pdf->Cell($CoL1,5,"ESTRUTURAL",1,0,"C",0);
        $pdf->Cell($CoL2,5,"DESCRICAO",1,0,"C",0);
        $pdf->Cell($CoL3,5,"COD.RECEITA",1,0,"C",0);
        $pdf->Cell($CoL4,5,"ARRECADACAO",1,0,"C",0);
        $pdf->Cell($CoL5,5,"ESTORNO",1,1,"C",0);
	    $pdf->SetTextColor(0,0,0);
	    $pdf->SetFont('Courier','',8);
	    $QuebraPagina = 0;
	    $SubTotal1 = 0;
        $SubTotal2 = 0;
     } else {
      if ( $QuebraPagina % 2  == 0 ) {
	  $pdf->SetFillColor(255,255,255); 
      } else {
	  $pdf->SetFillColor(202,242,249);
      }
     }
      $pdf->SetTextColor(0,0,0);
      $pdf->Cell($CoL1,5,$k02_estorc,1,0,"L",1);
      $pdf->Cell($CoL2,5,$o02_descr,1,0,"L",1);
      $pdf->Cell($CoL3,5,$k12_receit,1,0,"C",1);
      $pdf->Cell($CoL4,5,"R$".str_pad(number_format($arrec,2,",","."),14," ",STR_PAD_LEFT),1,0,"R",1);
      $pdf->Cell($CoL5,5,"R$".str_pad(number_format($estorno,2,",","."),14," ",STR_PAD_LEFT),1,1,"R",1);

      $SubTotal1 += $arrec;
      $SubTotal2 += $estorno;
      $Total1 += $arrec;
      $Total2 += $estorno;
  //  }	
//  }
}
if ( ($SubTotal1 + $SubTotal2 + $Total1 + $Total2 ) != 0 ) {
	$pdf->SetFont('Arial','B',8);
    $pdf->SetTextColor(255,0,0);
    $pdf->Cell($CoL1,5,"SUB-TOTAL",1,0,"C",0);
    $pdf->Cell($CoL2,5," ",1,0,"R",0);
    $pdf->Cell($CoL3,5," ",1,0,"R",0);
    $pdf->Cell($CoL4,5,number_format($SubTotal1,2,",","."),1,0,"R",0);
    $pdf->Cell($CoL5,5,number_format($SubTotal2,2,",","."),1,1,"R",0);

    $pdf->SetFont('Arial','B',8);
    $pdf->SetTextColor(255,0,0);
    $pdf->Cell($CoL1,5,"TOTAL",1,0,"C",0);
    $pdf->Cell($CoL2,5," ",1,0,"R",0);
    $pdf->Cell($CoL3,5," ",1,0,"R",0);
    $pdf->Cell($CoL4,5,number_format($Total1,2,",","."),1,0,"R",0);
    $pdf->Cell($CoL5,5,number_format($Total2,2,",","."),1,1,"R",0);
    $pdf->SetTextColor(0,0,0);

    $pdf->SetFont('Arial','B',8);
    $pdf->SetTextColor(255,0,0);
    $pdf->Cell($CoL1,5,"TOTAL GERAL",1,0,"C",0);
    $pdf->Cell($CoL2,5," ",1,0,"R",0);
    $pdf->Cell($CoL3,5," ",1,0,"R",0);
    $pdf->Cell($CoL4,5,number_format(($Total1+$Total2),2,",","."),1,0,"R",0);
    $pdf->Cell($CoL5,5,'',1,"R",0);
    $pdf->SetTextColor(0,0,0);
}
$Totalreceitaorcamentaria = $Total1+$Total2;
//////  FIM RECEITA ORÇAMENTÁRIA ///////////





//////  RECEITA EXTRA-ORÇAMENTÁRIA


$result = pg_exec("
select k02_estpla, c01_descr ,k12_conta,k12_receit,sum(k12_arrec) as arrec, sum(k12_estorno) as estorno
from plano
	inner join 
(select k02_estpla,corrente.k12_conta,cornump.k12_receit,case when corrente.k12_valor > 0 then corrente.k12_valor else 0 end as k12_arrec, case when corrente.k12_valor < 0 then corrente.k12_valor else 0 end as k12_estorno
 from corrente
      inner join cornump   on corrente.k12_id     = cornump.k12_id and
            corrente.k12_data   = cornump.k12_data and
            corrente.k12_autent = cornump.k12_autent
      inner join tabrec on cornump.k12_receit = k02_codigo 
      inner join tabplan
	         on tabrec.k02_codigo = tabplan.k02_codigo and tabplan.k02_anousu = ".$GLOBALS["DB_anousu"]." 
 where corrente.k12_instit = " . db_getsession('DB_instit') . " and corrente.k12_data  between '".$datai."' and '".$dataf."' ".$seleciona."
) as x
  on k02_estpla = c01_estrut and c01_anousu = ".$GLOBALS["DB_anousu"]."
group by k02_estpla,c01_descr,k12_conta,k12_receit;");
$numrows = pg_numrows($result);

if($numrows>0){


$Y = ($pdf->GetY() + 5);
$pdf->SetY($Y);

$pdf->AddPage();
$pdf->SetFont('Arial','B',12);
$pdf->SetTextColor(0,100,255);
$pdf->Cell(190,15,"RECEITAS EXTRA-ORÇAMENTÁRIAS",1,1,"C",0);

$pdf->SetFont('Arial','B',8);
$pdf->SetTextColor(0,100,255);
$CoL1 = 30;
$CoL2 = 70;
$CoL3 = 30;
$CoL4 = 30;
$CoL5 = 30;
$StrPad1 = 20;
$StrPad2 = 26;
$pdf->Cell($CoL1,5,"ESTRUTURAL",1,0,"C",0);
$pdf->Cell($CoL2,5,"DESCRICAO",1,0,"C",0);
$pdf->Cell($CoL3,5,"COD.RECEITA",1,0,"C",0);
$pdf->Cell($CoL4,5,"ARRECADACAO",1,0,"C",0);
$pdf->Cell($CoL5,5,"ESTORNO",1,1,"C",0);
$QuebraPagina = 10;
$Total1 = 0;
$Total2 = 0;
$SubTotal1 = 0;
$SubTotal2 = 0;
$pdf->SetFont('Courier','',8);
for($i = 0;$i < $numrows;$i++) {
   
  db_fieldsmemory($result,$i);
  
  if($QuebraPagina++ == 46) {
	$pdf->SetFont('Arial','B',8);
    $pdf->SetTextColor(255,0,0);
    $pdf->Cell($CoL1,5,"SUB-TOTAL",1,0,"C",0);
    $pdf->Cell($CoL2,5," ",1,0,"R",0);
    $pdf->Cell($CoL3,5," ",1,0,"R",0);
    $pdf->Cell($CoL4,5,number_format($SubTotal1,2,",","."),1,0,"R",0);
    $pdf->Cell($CoL5,5,number_format($SubTotal2,2,",","."),1,1,"R",0);
    $pdf->SetTextColor(0,0,0);
    $pdf->AddPage();
	$pdf->SetFont('Arial','B',8);
    $pdf->SetTextColor(0,100,255);
    $pdf->Cell($CoL1,5,"ESTRUTURAL",1,0,"C",0);
    $pdf->Cell($CoL2,5,"DESCRICAO",1,0,"C",0);
    $pdf->Cell($CoL3,5,"COD.RECEITA",1,0,"C",0);
    $pdf->Cell($CoL4,5,"ARRECADACAO",1,0,"C",0);
    $pdf->Cell($CoL5,5,"ESTORNO",1,1,"C",0);
	$pdf->SetTextColor(0,0,0);
	$pdf->SetFont('Courier','',8);
	$QuebraPagina = 0;
	$SubTotal1 = 0;
        $SubTotal2 = 0;
  } else {
      if ( $QuebraPagina % 2  == 0 ) {
	  $pdf->SetFillColor(255,255,255); 
	  
      } else {
	  $pdf->SetFillColor(202,242,249);
      }

    $pdf->SetTextColor(0,0,0);
    $pdf->Cell($CoL1,5,$k02_estpla,1,0,"L",1);
    $pdf->Cell($CoL2,5,$c01_descr,1,0,"L",1);
    $pdf->Cell($CoL3,5,$k12_receit,1,0,"L",1);
    $pdf->Cell($CoL4,5,"R$".str_pad(number_format($arrec,2,",","."),14," ",STR_PAD_LEFT),1,0,"R",1);
    $pdf->Cell($CoL5,5,"R$".str_pad(number_format($estorno,2,",","."),14," ",STR_PAD_LEFT),1,1,"R",1);

    $SubTotal1 += $arrec;
    $SubTotal2 += $estorno;
    $Total1 += $arrec;
    $Total2 += $estorno;
  }	
}

	$pdf->SetFont('Arial','B',8);
    $pdf->SetTextColor(255,0,0);
    $pdf->Cell($CoL1,5,"SUB-TOTAL",1,0,"C",0);
    $pdf->Cell($CoL2,5," ",1,0,"R",0);
    $pdf->Cell($CoL3,5," ",1,0,"R",0);
    $pdf->Cell($CoL4,5,number_format($SubTotal1,2,",","."),1,0,"R",0);
    $pdf->Cell($CoL5,5,number_format($SubTotal2,2,",","."),1,1,"R",0);

    $pdf->SetFont('Arial','B',8);
    $pdf->SetTextColor(255,0,0);
    $pdf->Cell($CoL1,5,"TOTAL",1,0,"C",0);
    $pdf->Cell($CoL2,5," ",1,0,"R",0);
    $pdf->Cell($CoL3,5," ",1,0,"R",0);
    $pdf->Cell($CoL4,5,number_format($Total1,2,",","."),1,0,"R",0);
    $pdf->Cell($CoL5,5,number_format($Total2,2,",","."),1,1,"R",0);
    $pdf->SetTextColor(0,0,0);

}
//////  FIM RECEITA EXTRA-ORÇAMENTÁRIA ///////////


/*
$pdf->SetFont('Arial','B',12);
$pdf->SetTextColor(0,100,255);
$pdf->Cell(190,15,"BOLETIM DE CAIXA",1,1,"C",0);


//Total receita orcamentario e extra-orcamentaria
$result = pg_exec("select k12_conta,k02_tipo,sum(cornump.k12_valor) 
                   from corrente
                   inner join cornump 
				   on corrente.k12_id      = cornump.k12_id     
				   and corrente.k12_data   = cornump.k12_data   
				   and corrente.k12_autent = cornump.k12_autent 
                   left outer join tabrec 
				   on k12_receit = k02_codigo 
                   where corrente.k12_data   between '".$datai."' and '".$dataf."' ".$seleciona."
                   group by k12_conta,k02_tipo
				   order by k02_tipo");
$RecExtOrc = 0;
$RecOrc    = 0;
if(pg_numrows($result) > 0) {
   for($i=0;$i<pg_numrows($result);$i++){
     db_fieldsmemory($result,$i);
	 if($k02_tipo=="E")
	   $RecExtOrc = pg_result($result,$i,"sum");
     else
	   $RecOrc    = pg_result($result,$i,"sum");
   }
}
pg_freeresult($result);


///Deposito na Conta(Retiradas de banco em relacao a conta)
$result = pg_exec("select corrente.k12_conta,sum(corrente.k12_valor)
                   from corrente
                   inner join corlanc 
				   on corrente.k12_id     = corlanc.k12_id     
				   and corrente.k12_data   = corlanc.k12_data   
				   and corrente.k12_autent = corlanc.k12_autent 
                   inner join saltes  
				   on corlanc.k12_conta = saltes.k13_conta
                   where corrente.k12_data  between '".$datai."' and '".$dataf."' ".$seleciona."
                   group by corrente.k12_conta");
if(pg_numrows($result) > 0) {
  $RetiradaBanco = pg_result($result,0,"sum");
} else {
  $RetiradaBanco = 0;
}
pg_freeresult($result);


/////Saldo Anterior
$result = pg_exec("select fc_saltessaldo(1,'$datai','$dataf',null)");
if(pg_numrows($result) > 0) {
  $aux = pg_result($result,0,0);
  $aux = preg_split("/\s+/",$aux);
  $SaldoAnterior = str_replace(",","",$aux[1]);
  unset($aux);
} else {
  $SaldoAnterior = 0;
}
pg_freeresult($result);


//////Despesa Orcamentaria
$result = pg_exec("select corrente.k12_conta,sum(corrente.k12_valor)
                   from corrente
                   inner join coremp 
				   on corrente.k12_id     = coremp.k12_id     
				   and corrente.k12_data   = coremp.k12_data   
				   and corrente.k12_autent = coremp.k12_autent 
                   where corrente.k12_data between '".$datai."' and '".$dataf."' ".$seleciona."
				   and substr(coremp.k12_empen,7,2) = '".substr($GLOBALS["DB_anousu"],2)."'
                   group by corrente.k12_conta");
if(pg_numrows($result) > 0) {
  $DespOrc = pg_result($result,0,"sum");
} else {
  $DespOrc = 0;
}
pg_freeresult($result);
//////////////Despesa Extra-Orcamentaria
$result = pg_exec("select corrente.k12_conta,sum(corrente.k12_valor)
                   from corrente
                   inner join coremp on corrente.k12_id     = coremp.k12_id     
				   and corrente.k12_data   = coremp.k12_data   
				   and corrente.k12_autent = coremp.k12_autent 
                   where corrente.k12_data  between '".$datai."' and '".$dataf."' ".$seleciona."
				   and substr(coremp.k12_empen,7,2) < '".substr($GLOBALS["DB_anousu"],2)."'
                   group by corrente.k12_conta");
if(pg_numrows($result) > 0) {
  $DespExtOrc = pg_result($result,0,"sum");
} else {
  $DespExtOrc = 0;
}
pg_freeresult($result);
/////Retirada da Conta(Depositos no banco em relacao a conta)
$result = pg_exec("select corlanc.k12_conta,sum(corrente.k12_valor)
                   from corrente
                   inner join corlanc on corrente.k12_id     = corlanc.k12_id     
				   and corrente.k12_data   = corlanc.k12_data   
				   and corrente.k12_autent = corlanc.k12_autent 
                   inner join saltes  
				   on corrente.k12_conta = saltes.k13_conta
                   where corrente.k12_data  between '".$datai."' and '".$dataf."' ".$seleciona."
                   group by corlanc.k12_conta");
if(pg_numrows($result) > 0) {
  $DepositoBanco = pg_result($result,0,"sum");
} else {
  $DepositoBanco = 0;
}
pg_freeresult($result);
$SaldoSeguinte = (($Totalreceitaorcamentaria + $RecExtOrc + $RetiradaBanco) + ($SaldoAnterior - $DespOrc - $DespExtOrc - $DepositoBanco));

//////////////// INICIO DA TABELA /////////////////////
$pdf->AddPage();
$pdf->SetFillColor(255,255,255);
$pdf->SetFont('Arial','B',8);
$pdf->SetTextColor(0,100,255);
$CoL1 = 50;
$CoL2 = 40;
$CoL3 = 50;
$CoL4 = 50;
$StrPad1 = 20;
$StrPad2 = 26;
$pdf->Cell($CoL1,5,"ENTRADAS (Débitos)",1,0,"C",1);
$pdf->Cell($CoL2,5,"VALORES",1,0,"C",1);
$pdf->Cell($CoL3,5,"SAÍDAS (Crédito)",1,0,"C",1);
$pdf->Cell($CoL4,5,"VALORES",1,1,"C",1);

$pdf->SetFillColor(202,223,255);
$pdf->SetFont('Courier','',8);
$pdf->SetTextColor(0,0,0);
$pdf->Cell($CoL1,5,"Rec. Orçamentária",1,0,"L",1);
$pdf->Cell($CoL2,5,"R$".str_pad(number_format($Totalreceitaorcamentaria,2,",","."),$StrPad1," ",STR_PAD_LEFT),1,0,"R",1);
$pdf->Cell($CoL3,5,"Desp. Orçamentária",1,0,"L",1);
$pdf->Cell($CoL4,5,"R$".str_pad(number_format($DespOrc,2,",","."),$StrPad2," ",STR_PAD_LEFT),1,1,"R",1);

$pdf->SetFillColor(255,255,255);
$pdf->Cell($CoL1,5,"Rec. Extraorçamentária",1,0,"L",1);
$pdf->Cell($CoL2,5,"R$".str_pad(number_format($RecExtOrc,2,",","."),$StrPad1," ",STR_PAD_LEFT),1,0,"R",1);
$pdf->Cell($CoL3,5,"Desp. Extraorçamentária",1,0,"L",1);
$pdf->Cell($CoL4,5,"R$".str_pad(number_format($DespExtOrc,2,",","."),$StrPad2," ",STR_PAD_LEFT),1,1,"R",1);

$pdf->SetFillColor(202,223,255);
$pdf->Cell($CoL1,5,"Retirada Bancos",1,0,"L",1);
$pdf->Cell($CoL2,5,"R$".str_pad(number_format($RetiradaBanco,2,",","."),$StrPad1," ",STR_PAD_LEFT),1,0,"R",1);
$pdf->Cell($CoL3,5,"Depósitos em Bancos",1,0,"L",1);
$pdf->Cell($CoL4,5,"R$".str_pad(number_format($DepositoBanco,2,",","."),$StrPad2," ",STR_PAD_LEFT),1,1,"R",1);

$pdf->SetFillColor(255,255,255);
$pdf->SetFont('Courier','B',8);
$pdf->SetTextColor(255,0,0);
$pdf->Cell($CoL1,5,"TOTAL",1,0,"L",1);
$pdf->Cell($CoL2,5,"R$".str_pad(number_format(($SomaEntradas = ($Totalreceitaorcamentaria + $RecExtOrc + $RetiradaBanco)),2,",","."),$StrPad1," ",STR_PAD_LEFT),1,0,"R",1);
$pdf->Cell($CoL3,5,"TOTAL",1,0,"L",1);
$pdf->Cell($CoL4,5,"R$".str_pad(number_format(($SomaSaidas = ($DespOrc + $DespExtOrc + $DepositoBanco)),2,",","."),$StrPad2," ",STR_PAD_LEFT),1,1,"R",1);

$pdf->SetFillColor(202,223,255);
$pdf->SetFont('Courier','',8);
$pdf->SetTextColor(0,0,0);
$pdf->Cell($CoL1,5,"Saldo Anterior",1,0,"L",1);
$pdf->Cell($CoL2,5,"R$".str_pad(number_format($SaldoAnterior,2,",","."),$StrPad1," ",STR_PAD_LEFT),1,0,"R",1);
$pdf->Cell($CoL3,5,"Saldo Seguinte",1,0,"L",1);
$pdf->Cell($CoL4,5,"R$".str_pad(number_format($SaldoSeguinte,2,",","."),$StrPad2," ",STR_PAD_LEFT),1,1,"R",1);

$pdf->SetFillColor(255,255,255);
$pdf->SetFont('Courier','B',8);
$pdf->SetTextColor(255,0,0);
$pdf->Cell($CoL1,5,"SOMA",1,0,"L",1);
$pdf->Cell($CoL2,5,"R$".str_pad(number_format(($SomaEntradas + $SaldoAnterior),2,",","."),$StrPad1," ",STR_PAD_LEFT),1,0,"R",1);
$pdf->Cell($CoL3,5,"SOMA",1,0,"L",1);
$pdf->Cell($CoL4,5,"R$".str_pad(number_format(($SomaSaidas + $SaldoSeguinte),2,",","."),$StrPad2," ",STR_PAD_LEFT),1,1,"R",1);
$pdf->SetTextColor(0,0,0);


*/

$pdf->Output();
?>