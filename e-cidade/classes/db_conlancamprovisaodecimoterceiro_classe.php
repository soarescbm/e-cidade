<?
/*
 *     E-cidade Software Publico para Gestao Municipal                
 *  Copyright (C) 2012  DBselller Servicos de Informatica             
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

//MODULO: contabilidade
//CLASSE DA ENTIDADE conlancamprovisaodecimoterceiro
class cl_conlancamprovisaodecimoterceiro { 
   // cria variaveis de erro 
   var $rotulo     = null; 
   var $query_sql  = null; 
   var $numrows    = 0; 
   var $numrows_incluir = 0; 
   var $numrows_alterar = 0; 
   var $numrows_excluir = 0; 
   var $erro_status= null; 
   var $erro_sql   = null; 
   var $erro_banco = null;  
   var $erro_msg   = null;  
   var $erro_campo = null;  
   var $pagina_retorno = null; 
   // cria variaveis do arquivo 
   var $c100_sequencial = 0; 
   var $c100_codlan = 0; 
   var $c100_instit = 0; 
   var $c100_mes = 0; 
   var $c100_ano = 0; 
   var $c100_escrituraprovisao = 0; 
   // cria propriedade com as variaveis do arquivo 
   var $campos = "
                 c100_sequencial = int4 = Sequencial 
                 c100_codlan = int4 = C�digo Lan�amento 
                 c100_instit = int4 = Cod. Institui��o 
                 c100_mes = int4 = M�s 
                 c100_ano = int4 = Ano 
                 c100_escrituraprovisao = int4 = Escritura Provisao 
                 ";
   //funcao construtor da classe 
   function cl_conlancamprovisaodecimoterceiro() { 
     //classes dos rotulos dos campos
     $this->rotulo = new rotulo("conlancamprovisaodecimoterceiro"); 
     $this->pagina_retorno =  basename($GLOBALS["HTTP_SERVER_VARS"]["PHP_SELF"]);
   }
   //funcao erro 
   function erro($mostra,$retorna) { 
     if(($this->erro_status == "0") || ($mostra == true && $this->erro_status != null )){
        echo "<script>alert(\"".$this->erro_msg."\");</script>";
        if($retorna==true){
           echo "<script>location.href='".$this->pagina_retorno."'</script>";
        }
     }
   }
   // funcao para atualizar campos
   function atualizacampos($exclusao=false) {
     if($exclusao==false){
       $this->c100_sequencial = ($this->c100_sequencial == ""?@$GLOBALS["HTTP_POST_VARS"]["c100_sequencial"]:$this->c100_sequencial);
       $this->c100_codlan = ($this->c100_codlan == ""?@$GLOBALS["HTTP_POST_VARS"]["c100_codlan"]:$this->c100_codlan);
       $this->c100_instit = ($this->c100_instit == ""?@$GLOBALS["HTTP_POST_VARS"]["c100_instit"]:$this->c100_instit);
       $this->c100_mes = ($this->c100_mes == ""?@$GLOBALS["HTTP_POST_VARS"]["c100_mes"]:$this->c100_mes);
       $this->c100_ano = ($this->c100_ano == ""?@$GLOBALS["HTTP_POST_VARS"]["c100_ano"]:$this->c100_ano);
       $this->c100_escrituraprovisao = ($this->c100_escrituraprovisao == ""?@$GLOBALS["HTTP_POST_VARS"]["c100_escrituraprovisao"]:$this->c100_escrituraprovisao);
     }else{
       $this->c100_sequencial = ($this->c100_sequencial == ""?@$GLOBALS["HTTP_POST_VARS"]["c100_sequencial"]:$this->c100_sequencial);
     }
   }
   // funcao para inclusao
   function incluir ($c100_sequencial){ 
      $this->atualizacampos();
     if($this->c100_codlan == null ){ 
       $this->erro_sql = " Campo C�digo Lan�amento nao Informado.";
       $this->erro_campo = "c100_codlan";
       $this->erro_banco = "";
       $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
       $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
       $this->erro_status = "0";
       return false;
     }
     if($this->c100_instit == null ){ 
       $this->erro_sql = " Campo Cod. Institui��o nao Informado.";
       $this->erro_campo = "c100_instit";
       $this->erro_banco = "";
       $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
       $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
       $this->erro_status = "0";
       return false;
     }
     if($this->c100_mes == null ){ 
       $this->erro_sql = " Campo M�s nao Informado.";
       $this->erro_campo = "c100_mes";
       $this->erro_banco = "";
       $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
       $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
       $this->erro_status = "0";
       return false;
     }
     if($this->c100_ano == null ){ 
       $this->erro_sql = " Campo Ano nao Informado.";
       $this->erro_campo = "c100_ano";
       $this->erro_banco = "";
       $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
       $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
       $this->erro_status = "0";
       return false;
     }
     if($this->c100_escrituraprovisao == null ){ 
       $this->erro_sql = " Campo Escritura Provisao nao Informado.";
       $this->erro_campo = "c100_escrituraprovisao";
       $this->erro_banco = "";
       $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
       $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
       $this->erro_status = "0";
       return false;
     }
     if($c100_sequencial == "" || $c100_sequencial == null ){
       $result = db_query("select nextval('conlancamprovisaodecimoterceiro_c100_sequencial_seq')"); 
       if($result==false){
         $this->erro_banco = str_replace("\n","",@pg_last_error());
         $this->erro_sql   = "Verifique o cadastro da sequencia: conlancamprovisaodecimoterceiro_c100_sequencial_seq do campo: c100_sequencial"; 
         $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
         $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
         $this->erro_status = "0";
         return false; 
       }
       $this->c100_sequencial = pg_result($result,0,0); 
     }else{
       $result = db_query("select last_value from conlancamprovisaodecimoterceiro_c100_sequencial_seq");
       if(($result != false) && (pg_result($result,0,0) < $c100_sequencial)){
         $this->erro_sql = " Campo c100_sequencial maior que �ltimo n�mero da sequencia.";
         $this->erro_banco = "Sequencia menor que este n�mero.";
         $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
         $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
         $this->erro_status = "0";
         return false;
       }else{
         $this->c100_sequencial = $c100_sequencial; 
       }
     }
     if(($this->c100_sequencial == null) || ($this->c100_sequencial == "") ){ 
       $this->erro_sql = " Campo c100_sequencial nao declarado.";
       $this->erro_banco = "Chave Primaria zerada.";
       $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
       $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
       $this->erro_status = "0";
       return false;
     }
     $sql = "insert into conlancamprovisaodecimoterceiro(
                                       c100_sequencial 
                                      ,c100_codlan 
                                      ,c100_instit 
                                      ,c100_mes 
                                      ,c100_ano 
                                      ,c100_escrituraprovisao 
                       )
                values (
                                $this->c100_sequencial 
                               ,$this->c100_codlan 
                               ,$this->c100_instit 
                               ,$this->c100_mes 
                               ,$this->c100_ano 
                               ,$this->c100_escrituraprovisao 
                      )";
     $result = db_query($sql); 
     if($result==false){ 
       $this->erro_banco = str_replace("\n","",@pg_last_error());
       if( strpos(strtolower($this->erro_banco),"duplicate key") != 0 ){
         $this->erro_sql   = "Lan�amento cont�bil de provis�o de 13� sal�rio ($this->c100_sequencial) nao Inclu�do. Inclusao Abortada.";
         $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
         $this->erro_banco = "Lan�amento cont�bil de provis�o de 13� sal�rio j� Cadastrado";
         $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
       }else{
         $this->erro_sql   = "Lan�amento cont�bil de provis�o de 13� sal�rio ($this->c100_sequencial) nao Inclu�do. Inclusao Abortada.";
         $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
         $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
       }
       $this->erro_status = "0";
       $this->numrows_incluir= 0;
       return false;
     }
     $this->erro_banco = "";
     $this->erro_sql = "Inclusao efetuada com Sucesso\\n";
         $this->erro_sql .= "Valores : ".$this->c100_sequencial;
     $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
     $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
     $this->erro_status = "1";
     $this->numrows_incluir= pg_affected_rows($result);
     $resaco = $this->sql_record($this->sql_query_file($this->c100_sequencial));
     if(($resaco!=false)||($this->numrows!=0)){
       $resac = db_query("select nextval('db_acount_id_acount_seq') as acount");
       $acount = pg_result($resac,0,0);
       $resac = db_query("insert into db_acountacesso values($acount,".db_getsession("DB_acessado").")");
       $resac = db_query("insert into db_acountkey values($acount,19453,'$this->c100_sequencial','I')");
       $resac = db_query("insert into db_acount values($acount,3453,19453,'','".AddSlashes(pg_result($resaco,0,'c100_sequencial'))."',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
       $resac = db_query("insert into db_acount values($acount,3453,19456,'','".AddSlashes(pg_result($resaco,0,'c100_codlan'))."',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
       $resac = db_query("insert into db_acount values($acount,3453,19457,'','".AddSlashes(pg_result($resaco,0,'c100_instit'))."',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
       $resac = db_query("insert into db_acount values($acount,3453,19454,'','".AddSlashes(pg_result($resaco,0,'c100_mes'))."',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
       $resac = db_query("insert into db_acount values($acount,3453,19455,'','".AddSlashes(pg_result($resaco,0,'c100_ano'))."',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
       $resac = db_query("insert into db_acount values($acount,3453,19514,'','".AddSlashes(pg_result($resaco,0,'c100_escrituraprovisao'))."',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
     }
     return true;
   } 
   // funcao para alteracao
   function alterar ($c100_sequencial=null) { 
      $this->atualizacampos();
     $sql = " update conlancamprovisaodecimoterceiro set ";
     $virgula = "";
     if(trim($this->c100_sequencial)!="" || isset($GLOBALS["HTTP_POST_VARS"]["c100_sequencial"])){ 
       $sql  .= $virgula." c100_sequencial = $this->c100_sequencial ";
       $virgula = ",";
       if(trim($this->c100_sequencial) == null ){ 
         $this->erro_sql = " Campo Sequencial nao Informado.";
         $this->erro_campo = "c100_sequencial";
         $this->erro_banco = "";
         $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
         $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
         $this->erro_status = "0";
         return false;
       }
     }
     if(trim($this->c100_codlan)!="" || isset($GLOBALS["HTTP_POST_VARS"]["c100_codlan"])){ 
       $sql  .= $virgula." c100_codlan = $this->c100_codlan ";
       $virgula = ",";
       if(trim($this->c100_codlan) == null ){ 
         $this->erro_sql = " Campo C�digo Lan�amento nao Informado.";
         $this->erro_campo = "c100_codlan";
         $this->erro_banco = "";
         $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
         $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
         $this->erro_status = "0";
         return false;
       }
     }
     if(trim($this->c100_instit)!="" || isset($GLOBALS["HTTP_POST_VARS"]["c100_instit"])){ 
       $sql  .= $virgula." c100_instit = $this->c100_instit ";
       $virgula = ",";
       if(trim($this->c100_instit) == null ){ 
         $this->erro_sql = " Campo Cod. Institui��o nao Informado.";
         $this->erro_campo = "c100_instit";
         $this->erro_banco = "";
         $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
         $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
         $this->erro_status = "0";
         return false;
       }
     }
     if(trim($this->c100_mes)!="" || isset($GLOBALS["HTTP_POST_VARS"]["c100_mes"])){ 
       $sql  .= $virgula." c100_mes = $this->c100_mes ";
       $virgula = ",";
       if(trim($this->c100_mes) == null ){ 
         $this->erro_sql = " Campo M�s nao Informado.";
         $this->erro_campo = "c100_mes";
         $this->erro_banco = "";
         $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
         $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
         $this->erro_status = "0";
         return false;
       }
     }
     if(trim($this->c100_ano)!="" || isset($GLOBALS["HTTP_POST_VARS"]["c100_ano"])){ 
       $sql  .= $virgula." c100_ano = $this->c100_ano ";
       $virgula = ",";
       if(trim($this->c100_ano) == null ){ 
         $this->erro_sql = " Campo Ano nao Informado.";
         $this->erro_campo = "c100_ano";
         $this->erro_banco = "";
         $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
         $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
         $this->erro_status = "0";
         return false;
       }
     }
     if(trim($this->c100_escrituraprovisao)!="" || isset($GLOBALS["HTTP_POST_VARS"]["c100_escrituraprovisao"])){ 
       $sql  .= $virgula." c100_escrituraprovisao = $this->c100_escrituraprovisao ";
       $virgula = ",";
       if(trim($this->c100_escrituraprovisao) == null ){ 
         $this->erro_sql = " Campo Escritura Provisao nao Informado.";
         $this->erro_campo = "c100_escrituraprovisao";
         $this->erro_banco = "";
         $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
         $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
         $this->erro_status = "0";
         return false;
       }
     }
     $sql .= " where ";
     if($c100_sequencial!=null){
       $sql .= " c100_sequencial = $this->c100_sequencial";
     }
     $resaco = $this->sql_record($this->sql_query_file($this->c100_sequencial));
     if($this->numrows>0){
       for($conresaco=0;$conresaco<$this->numrows;$conresaco++){
         $resac = db_query("select nextval('db_acount_id_acount_seq') as acount");
         $acount = pg_result($resac,0,0);
         $resac = db_query("insert into db_acountacesso values($acount,".db_getsession("DB_acessado").")");
         $resac = db_query("insert into db_acountkey values($acount,19453,'$this->c100_sequencial','A')");
         if(isset($GLOBALS["HTTP_POST_VARS"]["c100_sequencial"]) || $this->c100_sequencial != "")
           $resac = db_query("insert into db_acount values($acount,3453,19453,'".AddSlashes(pg_result($resaco,$conresaco,'c100_sequencial'))."','$this->c100_sequencial',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
         if(isset($GLOBALS["HTTP_POST_VARS"]["c100_codlan"]) || $this->c100_codlan != "")
           $resac = db_query("insert into db_acount values($acount,3453,19456,'".AddSlashes(pg_result($resaco,$conresaco,'c100_codlan'))."','$this->c100_codlan',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
         if(isset($GLOBALS["HTTP_POST_VARS"]["c100_instit"]) || $this->c100_instit != "")
           $resac = db_query("insert into db_acount values($acount,3453,19457,'".AddSlashes(pg_result($resaco,$conresaco,'c100_instit'))."','$this->c100_instit',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
         if(isset($GLOBALS["HTTP_POST_VARS"]["c100_mes"]) || $this->c100_mes != "")
           $resac = db_query("insert into db_acount values($acount,3453,19454,'".AddSlashes(pg_result($resaco,$conresaco,'c100_mes'))."','$this->c100_mes',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
         if(isset($GLOBALS["HTTP_POST_VARS"]["c100_ano"]) || $this->c100_ano != "")
           $resac = db_query("insert into db_acount values($acount,3453,19455,'".AddSlashes(pg_result($resaco,$conresaco,'c100_ano'))."','$this->c100_ano',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
         if(isset($GLOBALS["HTTP_POST_VARS"]["c100_escrituraprovisao"]) || $this->c100_escrituraprovisao != "")
           $resac = db_query("insert into db_acount values($acount,3453,19514,'".AddSlashes(pg_result($resaco,$conresaco,'c100_escrituraprovisao'))."','$this->c100_escrituraprovisao',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
       }
     }
     $result = db_query($sql);
     if($result==false){ 
       $this->erro_banco = str_replace("\n","",@pg_last_error());
       $this->erro_sql   = "Lan�amento cont�bil de provis�o de 13� sal�rio nao Alterado. Alteracao Abortada.\\n";
         $this->erro_sql .= "Valores : ".$this->c100_sequencial;
       $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
       $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
       $this->erro_status = "0";
       $this->numrows_alterar = 0;
       return false;
     }else{
       if(pg_affected_rows($result)==0){
         $this->erro_banco = "";
         $this->erro_sql = "Lan�amento cont�bil de provis�o de 13� sal�rio nao foi Alterado. Alteracao Executada.\\n";
         $this->erro_sql .= "Valores : ".$this->c100_sequencial;
         $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
         $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
         $this->erro_status = "1";
         $this->numrows_alterar = 0;
         return true;
       }else{
         $this->erro_banco = "";
         $this->erro_sql = "Altera��o efetuada com Sucesso\\n";
         $this->erro_sql .= "Valores : ".$this->c100_sequencial;
         $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
         $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
         $this->erro_status = "1";
         $this->numrows_alterar = pg_affected_rows($result);
         return true;
       } 
     } 
   } 
   // funcao para exclusao 
   function excluir ($c100_sequencial=null,$dbwhere=null) { 
     if($dbwhere==null || $dbwhere==""){
       $resaco = $this->sql_record($this->sql_query_file($c100_sequencial));
     }else{ 
       $resaco = $this->sql_record($this->sql_query_file(null,"*",null,$dbwhere));
     }
     if(($resaco!=false)||($this->numrows!=0)){
       for($iresaco=0;$iresaco<$this->numrows;$iresaco++){
         $resac = db_query("select nextval('db_acount_id_acount_seq') as acount");
         $acount = pg_result($resac,0,0);
         $resac = db_query("insert into db_acountacesso values($acount,".db_getsession("DB_acessado").")");
         $resac = db_query("insert into db_acountkey values($acount,19453,'$c100_sequencial','E')");
         $resac = db_query("insert into db_acount values($acount,3453,19453,'','".AddSlashes(pg_result($resaco,$iresaco,'c100_sequencial'))."',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
         $resac = db_query("insert into db_acount values($acount,3453,19456,'','".AddSlashes(pg_result($resaco,$iresaco,'c100_codlan'))."',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
         $resac = db_query("insert into db_acount values($acount,3453,19457,'','".AddSlashes(pg_result($resaco,$iresaco,'c100_instit'))."',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
         $resac = db_query("insert into db_acount values($acount,3453,19454,'','".AddSlashes(pg_result($resaco,$iresaco,'c100_mes'))."',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
         $resac = db_query("insert into db_acount values($acount,3453,19455,'','".AddSlashes(pg_result($resaco,$iresaco,'c100_ano'))."',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
         $resac = db_query("insert into db_acount values($acount,3453,19514,'','".AddSlashes(pg_result($resaco,$iresaco,'c100_escrituraprovisao'))."',".db_getsession('DB_datausu').",".db_getsession('DB_id_usuario').")");
       }
     }
     $sql = " delete from conlancamprovisaodecimoterceiro
                    where ";
     $sql2 = "";
     if($dbwhere==null || $dbwhere ==""){
        if($c100_sequencial != ""){
          if($sql2!=""){
            $sql2 .= " and ";
          }
          $sql2 .= " c100_sequencial = $c100_sequencial ";
        }
     }else{
       $sql2 = $dbwhere;
     }
     $result = db_query($sql.$sql2);
     if($result==false){ 
       $this->erro_banco = str_replace("\n","",@pg_last_error());
       $this->erro_sql   = "Lan�amento cont�bil de provis�o de 13� sal�rio nao Exclu�do. Exclus�o Abortada.\\n";
       $this->erro_sql .= "Valores : ".$c100_sequencial;
       $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
       $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
       $this->erro_status = "0";
       $this->numrows_excluir = 0;
       return false;
     }else{
       if(pg_affected_rows($result)==0){
         $this->erro_banco = "";
         $this->erro_sql = "Lan�amento cont�bil de provis�o de 13� sal�rio nao Encontrado. Exclus�o n�o Efetuada.\\n";
         $this->erro_sql .= "Valores : ".$c100_sequencial;
         $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
         $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
         $this->erro_status = "1";
         $this->numrows_excluir = 0;
         return true;
       }else{
         $this->erro_banco = "";
         $this->erro_sql = "Exclus�o efetuada com Sucesso\\n";
         $this->erro_sql .= "Valores : ".$c100_sequencial;
         $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
         $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
         $this->erro_status = "1";
         $this->numrows_excluir = pg_affected_rows($result);
         return true;
       } 
     } 
   } 
   // funcao do recordset 
   function sql_record($sql) { 
     $result = db_query($sql);
     if($result==false){
       $this->numrows    = 0;
       $this->erro_banco = str_replace("\n","",@pg_last_error());
       $this->erro_sql   = "Erro ao selecionar os registros.";
       $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
       $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
       $this->erro_status = "0";
       return false;
     }
     $this->numrows = pg_numrows($result);
      if($this->numrows==0){
        $this->erro_banco = "";
        $this->erro_sql   = "Record Vazio na Tabela:conlancamprovisaodecimoterceiro";
        $this->erro_msg   = "Usu�rio: \\n\\n ".$this->erro_sql." \\n\\n";
        $this->erro_msg   .=  str_replace('"',"",str_replace("'","",  "Administrador: \\n\\n ".$this->erro_banco." \\n"));
        $this->erro_status = "0";
        return false;
      }
     return $result;
   }
   // funcao do sql 
   function sql_query ( $c100_sequencial=null,$campos="*",$ordem=null,$dbwhere=""){ 
     $sql = "select ";
     if($campos != "*" ){
       $campos_sql = split("#",$campos);
       $virgula = "";
       for($i=0;$i<sizeof($campos_sql);$i++){
         $sql .= $virgula.$campos_sql[$i];
         $virgula = ",";
       }
     }else{
       $sql .= $campos;
     }
     $sql .= " from conlancamprovisaodecimoterceiro ";
     $sql .= "      inner join conlancam         on conlancam.c70_codlan = conlancamprovisaodecimoterceiro.c100_codlan";
     $sql .= "      inner join escrituraprovisao on escrituraprovisao.c102_sequencial = conlancamprovisaodecimoterceiro.c100_escrituraprovisao";
     $sql .= "      inner join db_config         on db_config.codigo = escrituraprovisao.c102_instit";
     $sql .= "      inner join cgm               on cgm.z01_numcgm = db_config.numcgm";
     $sql .= "      inner join db_tipoinstit     on db_tipoinstit.db21_codtipo = db_config.db21_tipoinstit";
     $sql .= "      inner join db_usuarios       on db_usuarios.id_usuario = escrituraprovisao.c102_usuario";
     $sql2 = "";
     if($dbwhere==""){
       if($c100_sequencial!=null ){
         $sql2 .= " where conlancamprovisaodecimoterceiro.c100_sequencial = $c100_sequencial "; 
       } 
     }else if($dbwhere != ""){
       $sql2 = " where $dbwhere";
     }
     $sql .= $sql2;
     if($ordem != null ){
       $sql .= " order by ";
       $campos_sql = split("#",$ordem);
       $virgula = "";
       for($i=0;$i<sizeof($campos_sql);$i++){
         $sql .= $virgula.$campos_sql[$i];
         $virgula = ",";
       }
     }
     return $sql;
  }
   // funcao do sql 
   function sql_query_file ( $c100_sequencial=null,$campos="*",$ordem=null,$dbwhere=""){ 
     $sql = "select ";
     if($campos != "*" ){
       $campos_sql = split("#",$campos);
       $virgula = "";
       for($i=0;$i<sizeof($campos_sql);$i++){
         $sql .= $virgula.$campos_sql[$i];
         $virgula = ",";
       }
     }else{
       $sql .= $campos;
     }
     $sql .= " from conlancamprovisaodecimoterceiro ";
     $sql2 = "";
     if($dbwhere==""){
       if($c100_sequencial!=null ){
         $sql2 .= " where conlancamprovisaodecimoterceiro.c100_sequencial = $c100_sequencial "; 
       } 
     }else if($dbwhere != ""){
       $sql2 = " where $dbwhere";
     }
     $sql .= $sql2;
     if($ordem != null ){
       $sql .= " order by ";
       $campos_sql = split("#",$ordem);
       $virgula = "";
       for($i=0;$i<sizeof($campos_sql);$i++){
         $sql .= $virgula.$campos_sql[$i];
         $virgula = ",";
       }
     }
     return $sql;
  }
}
?>