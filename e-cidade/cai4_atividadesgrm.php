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
require_once(modification("libs/db_utils.php"));
require_once(modification("libs/db_app.utils.php"));
require_once(modification("dbforms/db_funcoes.php"));
require_once(modification("dbforms/db_classesgenericas.php"));
require_once(modification("classes/db_db_usuarios_classe.php"));
require_once(modification("classes/db_db_depart_classe.php"));
?>
<html>
  <head>
    <title>DBSeller Inform&aacute;tica Ltda - P&aacute;gina Inicial</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
    <meta http-equiv="Expires" CONTENT="0">
    <script language="JavaScript" type="text/javascript" src="scripts/prototype.js"></script>
    <script language="JavaScript" type="text/javascript" src="scripts/scripts.js"></script>
    <script language="JavaScript" type="text/javascript" src="scripts/AjaxRequest.js"></script>
    <script language="JavaScript" type="text/javascript" src="scripts/widgets/DBAbas.widget.js"></script>
    <script language="JavaScript" type="text/javascript" src="scripts/strings.js"></script>
    <script language="JavaScript" type="text/javascript" src="scripts/widgets/Input/DBInput.widget.js"></script>
    <script language="JavaScript" type="text/javascript" src="scripts/widgets/Input/DBInputDate.widget.js"></script>
    <script language="JavaScript" type="text/javascript" src="scripts/widgets/DBLookUp.widget.js"></script>    
    <script language="JavaScript" type="text/javascript" src="scripts/datagrid.widget.js"></script>
    <script language="JavaScript" type="text/javascript" src="scripts/widgets/Collection.widget.js"></script>
    <script language="JavaScript" type="text/javascript" src="scripts/widgets/DatagridCollection.widget.js"></script>
    <script language="JavaScript" type="text/javascript" src="scripts/widgets/windowAux.widget.js"></script>
    <script language="JavaScript" type="text/javascript" src="scripts/widgets/dbmessageBoard.widget.js"></script>
    <script language="JavaScript" type="text/javascript" src="scripts/classes/DBViewLancamentoAtributoDinamico.js"></script>
    <link href="estilos.css" rel="stylesheet" type="text/css">
  <style>
    fieldset.separator table tr td:FIRST-CHILD {
      width:110px;
      white-space: nowrap;
    }
  </style>
  </head>
  <body>
  <div class="container" style="width: 1000px;">
    <fieldset>
      <legend>
        <b>Guias de Recolhimento Pagas</b>
      </legend>
      <table>
        <tr>
          <td>
            <label id='lblUnidadeGestora' for="codigo_unidade">Unidade Gestora:</label>
          </td>
          <td>
            <input type="text" id="codigo_unidade" data='k171_sequencial' onkeyup="js_ValidaCampos(this, 1, 'Unidade Gestora', 0, 1)" class="field-size2">
            <input type="text" id="nome_unidade" data='k171_nome' class="field-size8 readonly" readonly>
          </td>
        </tr>
        <tr>
          <td>
            <label for="tipo_recolhimento" id="lblTipoRecolhimento"><b>Tipo de Recolhimento:</b></label>
          </td>
          <td>
            <input type="text" id="tipo_recolhimento" data='k172_sequencial' onkeyup="js_ValidaCampos(this, 1, 'Tipo de Recolhimento', 0, 1)" class="field-size2">
            <input type="text" id="nome_recolhimento" data='k172_nome' class="field-size8 readonly" readonly maxlength="100">
          </td>
        </tr>
        <tr>
          <td>
            <label for="especie_ingresso">
              <b>Esp�cie de Ingresso:</b>
            </label>
          </td>
          <td>
            <select style="width: 100%;" id="especie_ingresso">
              <option value="">Selecione</option>
              <option value="1">Receita</option>
              <option value="2">DDO</option>
              <option value="3">Estorno de Despesa</option>
            </select>
          </td>
        </tr>
        <tr>
          <td colspan="5">
            <fieldset class="separator">
              <legend>
                Data de Pagamento
              </legend>
              <table>
                <tr>
                  <td>
                    <label for="data_pagamento_inicial"  class="bold">
                      De:
                    </label>
                  </td>
                  <td>
                    <input type="text" id="data_pagamento_inicial">
                  </td>
                  <td>
                    <label for="data_pagamento_final" class="bold">
                      At�:
                    </label>
                  </td>
                  <td>
                    <input type="text" id="data_pagamento_final">
                  </td>
                </tr>
              </table>
            </fieldset>
          </td>
        </tr>
      </table>
    </fieldset>
    <input type="button" id="btnPesquisar" value="Pesquisar">
    <fieldset>
      <legend>
        Guias
      </legend>
      <div id="ctnGrid">
        
      </div>
    </fieldset>
  </div>
  <?php
  db_menu(db_getsession("DB_id_usuario"), db_getsession("DB_modulo"), db_getsession("DB_anousu"), db_getsession("DB_instit"));
  ?>
  </body>  
</html>
<script>
  const URL_RPC = 'cai4_atividadesgrm.RPC.php'; 
  var oUnidadeGestora     = $('codigo_unidade');
  var oNomeUnidadeGestora = $('nome_unidade');
  var oTipoRecolhimento   = $('tipo_recolhimento');
  var oEspecieIngresso    = $('especie_ingresso');
  var oNomeRecolhimento   = $('nome_recolhimento');
  
  var oInputDataInicial = new DBInputDate($('data_pagamento_inicial'));
  var oInputDataFinal   = new DBInputDate($('data_pagamento_final'));
  
  var oLookupTipoRecolhimento = new DBLookUp($('lblTipoRecolhimento'), oTipoRecolhimento, oNomeRecolhimento, {
    "sArquivo"      : "func_tiporecolhimento.php",
    "sObjetoLookUp" : "db_iframe_receita",
    "sLabel"        : "Pesquisar Tipo de Recolhimento"
  });
  
  var oLookupUnidadeGestora = new DBLookUp($('lblUnidadeGestora'), oUnidadeGestora, oNomeUnidadeGestora, {
    "sArquivo"      : "func_unidadegestora.php",
    "sObjetoLookUp" : "db_iframe_unidade_gestora",
    "sLabel"        : "Pesquisar Unidade Gestora"
  });

  var oCollectionGuias = new Collection().setId('guia');
  var oDataGridGuias   = new DatagridCollection(oCollectionGuias).configure({
    'order'  : false,
    'height' : 200
  
  });
  oDataGridGuias.addColumn("guia", {
    'label' : "C�digo",
    'width' : "10%",
    'align' : "center"
  });
  oDataGridGuias.addColumn("cgm", {
    'label' : "Cgm",
    'align' : "left",
    'width' : "30%"
  });  
  oDataGridGuias.addColumn("recolhimento", {
    'label' : "Recolhimento",
    'align' : "left",
    'width' : "30%"
  });
  oDataGridGuias.addColumn("processo", {
    'label' : "Processo",
    'align' : "left",
    'width' : "10%"
  });
  oDataGridGuias.addColumn("valor_total", {
    'label' : "Valor Total",
    'align' : "left",
    'width' : "10%"
  });
  oDataGridGuias.addColumn("atividade", {
    'label' : "Atividade",
    'align' : "left",
    'width' : "30%"
  });
  oDataGridGuias.show($('ctnGrid'));

  /**
   * Pesquisa as guias do departamento
   */
  function pesquisarGuias() { 
    
    if (empty(oUnidadeGestora.value)) {
      
      alert('Unidade Gestora deve ser informada!');
      return;
    }
    
    var oParametro = {
      exec              : 'getGuias',
      data_inicial      : oInputDataInicial.inputElement.value,
      data_final        : oInputDataFinal.inputElement.value,    
      unidade_gestora   : oUnidadeGestora.value,
      tipo_recolhimento : oTipoRecolhimento.value,
      especie_ingresso  : oEspecieIngresso.value
    }
  
    new AjaxRequest(URL_RPC, oParametro, function (oResponse, lErro) {
  
      oCollectionGuias.clear();    
      for (guia of oResponse.guias) {
        
        guia.nome_atividade = guia.atividade;
        guia.atividade = '<a href="#" onclick="atividades(\''+guia.guia+'\', '+guia.ordem_atividade+');return false">'+guia.atividade+'</a>';
        guia.processo  = '<a href="#" onclick="processo(\''+guia.processo+'\');return false">'+guia.processo+'</a>';
        oCollectionGuias.add(guia);
      } 
      
      oDataGridGuias.reload();
      if (oResponse.guias.length == 0) {
        
         alert('N�o foram encontradas guias com atividades para executar no departamento atual!');
         return;
      }
    }).setMessage('Aguarde, pesquisando guias...').execute();
  }
  $('btnPesquisar').onclick = pesquisarGuias;
  
  
  function atividades(guia, ordemAtividade) {
  
    guia      = oCollectionGuias.get(guia);    
    var sData     = '<?php echo date('d/m/Y',db_getsession('DB_datausu'))?>';
         
    var sContent  = "<div>";    
    sContent += "    <fieldset>";
    sContent += "      <legend>";
    sContent += "        <b>Dados Gerais :<b>";
    sContent += "      </legend>";
    sContent += "      <table style='width:100%'>";   
    sContent += "        <tr>";
    sContent += "          <td style='width: 15%;'><b>Data :</b></td> ";
    sContent += "          <td> ";
    sContent +=             sData;
    sContent += "          </td> ";
    sContent += "        </tr>";    
    sContent += "        <tr>  ";
    sContent += "          <td style='width: 15%;'><b> Conclu�do : </b></td> ";
    sContent += "          <td>";
    sContent +=  "           <select id='atividade_concluida'>";            
    sContent +=  "             <option value='2'>N�o</option>";            
    sContent +=  "             <option value='1'>Sim</option>";            
    sContent +=  "           </select>";            
    sContent += "          </td> ";
    sContent += "        </tr> ";
    sContent += "        <tr>";
    sContent += "          <td colspan='2'>  ";
    sContent += "            <fieldset class='separator'><legend>Observa��es</legend>";
    sContent += "             <textarea style='width:100%;resize: none' rows='2' id='observacoes_atividade'></textarea> ";
    sContent += "           </fieldset> ";
    sContent += "         </td>";
    sContent += "        </tr> ";
    sContent += "      </table> ";
    sContent += "    </fieldset> ";
    sContent += "    <div id='atributos'></div>";
    sContent += "    <div class='container'>";
    sContent += "     <input type='button' value='Executar' id='btnExecutaAtividade' \> ";    
    sContent += "  </div>";     
    sContent += "</div>";
    
  
    windowAtividades = new windowAux('atividades', '&nbsp; Lan�amento de Atividades', 600, 400);
    windowAtividades.setContent(sContent);
  
    var oMessage = new DBMessageBoard('msgboard1',
      'Lan�amento de Atividades',
      'Lan�amento  '+ guia.nome_atividade,
      $("windowatividades_content"));
    oMessage.show();
  
    windowAtividades.show(60, 400);
    windowAtividades.setShutDownFunction(function (){
      windowAtividades.destroy();
      windowAtividades = '';
    });  
   
    if (guia.atributos != '' ) {
    
      $('btnExecutaAtividade').observe('click',function(event) {
        oAtributoDinamico.save();
      })
    
      oAtributoDinamico = new DBViewLancamentoAtributoDinamico();
      oAtributoDinamico.setSaveCallBackFunction( executarAtividades );
      oAtributoDinamico.setAlignForm('left');
      oAtributoDinamico.setParentNode($('atributos'));
      oAtributoDinamico.newAttribute(guia.atributos);
    
    } else {
     
      $('btnExecutaAtividade').observe('click',function(event) {
        executarAtividades(null)
      });
    }
}

function executarAtividades(codigoAtributo) {
    
  var oParametro = {
    
    exec            : 'salvarAtividade',
    observacao      : $F('observacoes_atividade'),
    guia            : guia.guia,
    concluido       : $F('atividade_concluida') == 1,
    ordem_atividade : guia.ordem_atividade,
    processo        : guia.processo,  
    atributos       : codigoAtributo
  }  
  
  new AjaxRequest(URL_RPC, oParametro, function (oResponse, lErro) {   
    
    alert(oResponse.sMessage);
    if (lErro) {
      return;
    }
    windowAtividades.destroy();
    pesquisarGuias();
  }).setMessage('Aguarde, Salvando Atividade...').execute();
}
function processo(iProcesso) {
  js_OpenJanelaIframe('CurrentWindow.corpo', 'db_iframe', 'pro3_consultaprocesso002.php?codproc='+iProcesso, 'Consulta de Processos', true);
}
  
</script>
