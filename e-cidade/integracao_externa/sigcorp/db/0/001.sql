
-- ======================================================================

CREATE TABLE integra_tipocadastro
  (
    sequencial  int4,
    descricao   varchar(100)  not null,

    primary key(sequencial)
  );


-- ======================================================================

CREATE TABLE integra_cad_receita
  (
    sequencial  int4        unique not null,
    munic_ibge  int4        not null,
    codigo      int4        unique not null,
    descricao   varchar(50) not null,
    tipo        int4        	null,
    dataimp     date 	    not null,
    horaimp    	char(5)         null,
    processado  bool,

    primary key(sequencial)
  );

-- ======================================================================

CREATE TABLE integra_cad_inflat
  (
    sequencial     int4       	 unique not null,
    munic_ibge     int4       	 not null,
    sigla          varchar(5)    unique not null,
    descricao      varchar(60)   not null,
    tipo_calc      char(1)    	 not null,
    tipo_atualiza  int4    	 not null,
    tipo_lancam    varchar(1)    not null,
    dataimp        date 	 not null,
    horaimp    	   char(5)           null,
    processado     bool,
    

    primary key(sequencial)
  );

-- ======================================================================

CREATE TABLE integra_cad_inflat_detalhe
  (
    sequencial          int4           unique not null,
    munic_ibge          int4           not null,
    integra_cad_inflat  int4           not null,
    data                date           not null,
    valor               numeric(15,2)  default 0,
    dataimp        	date 	       not null,
    horaimp    	   	char(5)       	   null,
    processado     	bool,
    

    primary key(sequencial),

    foreign key(integra_cad_inflat) references integra_cad_inflat(sequencial)
  );

-- ======================================================================

CREATE TABLE integra_cad_jm
  (
    sequencial           int4           unique not null,
    munic_ibge           int4           not null,
    codigo_jm            int4           not null,
    integra_cad_inflat   int4           not null,
    juros                numeric(15,2)  default 0,
    jurdia               bool      	not null,
    multa_1              int4,
    multa_2              int4,
    multa_3              int4,
    multa_faixa_1        numeric(15,2)  default 0,
    multa_faixa_2        numeric(15,2)  default 0,
    multa_faixa_3        numeric(15,2)  default 0,
    multa_diaria         numeric(15,2)  default 0,
    limite_multa_diaria  numeric(15,2)  default 0,
    sabdom               bool           not null,
    corr_venc            bool           not null,
    dataimp        	 date   	not null,
    horaimp    	   	 char(5)       	    null,
    processado     	 bool,


    primary key(sequencial),

    foreign key(integra_cad_inflat) references integra_cad_inflat(sequencial)
  );

-- ======================================================================

CREATE TABLE integra_rec_jm
  (
    sequencial           int4      unique not null,
    munic_ibge           int4      not null,
    integra_cad_receita  int4      not null,
    integra_cad_jm       int4      not null,
    data_inicial         date      not null,
    data_final           date      not null,
    dataimp        	 date      not null,
    horaimp    	   	 char(5)       null,
    processado     	 bool,


    primary key(sequencial),

    foreign key(integra_cad_receita) references integra_cad_receita(sequencial),
    foreign key(integra_cad_jm) references integra_cad_jm(sequencial)
  );

-- ======================================================================

CREATE TABLE integra_cad_atividade 
  (
    sequencial      int4           unique not null,
    munic_ibge      int4           not null,
    atividade       int4           not null,
    descricao       varchar(100)   not null,
    codigo_cnae     varchar(50)        null,
    descricao_cnae  varchar(100)       null,
    codigo_116      int4,
    descricao_116   varchar(100),
    aliqiss         numeric        default 0,
    dataimp         date      	   not null,
    horaimp    	    char(5)            null,
    processado      bool,

    primary key(sequencial)
  );

-- ======================================================================

CREATE TABLE integra_cad_socio
  (
    sequencial       int4        unique not null,
    munic_ibge       int4       	not null,
    codigo_socio     int4       	not null,
    cpf_cnpj         varchar(14)        not null,
    nome_socio       varchar(100)   	not null,
    tipo_logradouro  varchar(5),
    logradouro       varchar(150),
    numero           varchar(10),
    complemento      varchar(30),
    bairro           varchar(60),
    cep              varchar(8),
    cidade           varchar(50),
    estado           varchar(2),
    ddd_fone         varchar(3),
    telefone         varchar(15),
    ramal            varchar(15),
    ddd_fax          varchar(3),
    fax              varchar(15),
    email            varchar(100),
    dataimp          date	      not null,
    horaimp    	     char(5)       null,
    processado       bool,


    primary key(sequencial)
  );

-- ======================================================================

CREATE TABLE integra_cad_grafica
  (
    sequencial          int4    unique not null,
    munic_ibge          int4           not null,
    codigo_grafica      int4           not null,
    inscricao           int4,
    cpf_cnpj            varchar(14),
    inscricao_estadual  varchar(50),
    nome_grafica        varchar(200)   not null,
    tipo_logradouro     varchar(5),
    logradouro          varchar(100),
    numero              varchar(5),
    complemento         varchar(30),
    bairro              varchar(60),
    cidade              varchar(100),
    estado              varchar(2),
    cep                 varchar(8),
    ddd_fone            varchar(3),
    telefone            varchar(15),
    ddd_fax             varchar(3),
    fax                 varchar(15),
    email               varchar(100),
    dataimp             date      not null,
    horaimp    	        char(5)       null,
    processado          bool,


    primary key(sequencial)
  );

-- ======================================================================

CREATE TABLE integra_cadastro
  (
    sequencial          int4    unique not null,
    munic_ibge          int4           not null,
    cpf_cnpj            varchar(14),
    tipocadastro        int4           not null,
    inscricao_estadual  varchar(50),
    nome                varchar(200),
    tipo_logradouro     varchar(5),
    logradouro          varchar(100),
    numero              varchar(5),
    complemento         varchar(30),
    bairro              varchar(60),
    cidade              varchar(100),
    estado              varchar(2),
    cep                 varchar(8),
    ddd_fone            varchar(3),
    telefone            varchar(15),
    ddd_fax             varchar(3),
    fax                 varchar(15),
    email               varchar(100),
    dataimp             date           not null,
    horaimp             char(5)        not null,
    processado          bool           not null,

    primary key(sequencial),

    foreign key(tipocadastro) references integra_tipocadastro(sequencial)

  );


-- ======================================================================

CREATE TABLE integra_cad_escritorio
  (
    sequencial         int4       unique not null,
    munic_ibge         int4,
    codigo_escritorio  int4       	 not null,
    inscricao          int4 		     null,
    cpf_cnpj           varchar(14)       not null,
    nome_escritorio    varchar(100),
    data_abertura      date,
    data_encerramento  date,
    status_empresa     varchar(1),
    tipo_logradouro    varchar(5),
    logradouro         varchar(150),
    numero             varchar(10),
    complemento        varchar(30),
    bairro             varchar(60),
    cep                varchar(8),
    cidade             varchar(50),
    estado             varchar(2),
    ddd_fone           varchar(3),
    telefone           varchar(15),
    ramal              varchar(15),
    fax                varchar(15),
    ddd_fax            varchar(3),
    email              varchar(100),
    dataimp            date      not null,
    horaimp    	       char(5)       null,
    processado         bool,

    primary key(sequencial)
  );

-- ======================================================================

CREATE TABLE integra_recibo_baixa
  (
    sequencial          int4        unique not null,
    munic_ibge          int4        not null,
    tipo_baixa          varchar(1)     not null,
    data_processamento  date        not null,
    cod_banco           varchar(3),
    nome_arquivo        varchar(150),
    dataimp             date      not null,
    horaimp    	   	char(5)       null,
    processado          bool,

    primary key(sequencial)
  );

-- ======================================================================

CREATE TABLE integra_cad_config
  (
    sequencial            int4       unique not null,
    munic_ibge            int4       not null,
    faixa_inicial_numdoc  varchar(20)   not null,
    faixa_final_numdoc    varchar(20)   not null,
    cod_rec_iss           int4       not null,
    cod_rec_jur           int4       not null,
    cod_rec_mult          int4       not null,
    num_convenio          int4       not null,
    tipo_convenio         int4       not null,
    dataimp               date       not null,
    horaimp    	    	  char(5)        null,
    processado            bool,

    primary key(sequencial),

    foreign key(cod_rec_iss) references integra_cad_receita(sequencial),
    foreign key(cod_rec_jur) references integra_cad_receita(sequencial),
    foreign key(cod_rec_mult) references integra_cad_receita(sequencial)
  );

-- ======================================================================

CREATE TABLE integra_cad_empresa 
  (
    sequencial              int4      unique not null,
    munic_ibge              int4           	 null,
    cpf_cnpj                varchar(14)      not null,
    inscricao               int4             not null,
    inscricao_estadual      varchar(50),
    nome_empresa            varchar(100)         null,
    nome_fantasia           varchar(100),
    num_processo            varchar(20),
    tipo_empresa            varchar(1)           null,
    tipo_inscricao          varchar(1),
    enquadramento_empresa   varchar(10),
    classificacao           varchar(1),
    regime_empresa          varchar(1),
    data_abertura           date                null,
    data_encerramento       date,
    tipo_logradouro         varchar(5),
    logradouro              varchar(150),
    numero                  varchar(10),
    complemento             varchar(30),
    bairro                  varchar(60),
    cep                     varchar(8),
    cidade                  varchar(50),
    estado                  varchar(2),
    ddd_fone                varchar(3),
    telefone                varchar(15),
    ramal                   varchar(4),
    ddd_fax                 varchar(3),
    fax                     varchar(15),
    email                   varchar(100),
    area_total              numeric default 0,
    area_ocupada            numeric default 0,
    status_empresa          varchar(1),
    logotipo                bytea,
    login                   varchar(30),
    senha                   varchar(100),
    dataimp                 date           not null,
    horaimp    	   	    char(5)   	       null,
    processado    	    bool,
    

    primary key(sequencial)


  );

-- ======================================================================

CREATE TABLE integra_empresa_corresp
  (
    sequencial           int4        unique not null,
    munic_ibge           int4,
    integra_cad_empresa  int4        not null,
    tipo_logradouro      varchar(5),
    logradouro           varchar(150),
    titulo_logradouro    varchar(5),
    num_imovel           varchar(10),
    complemento          varchar(30),
    bairro               varchar(60),
    cidade               int8,
    estado               varchar(2),
    cep                  varchar(8),
    ddd_fone             varchar(3),
    telefone             varchar(15),
    ramal                varchar(15),
    ddd_fax              varchar(3),
    fax                  varchar(15),
    email                varchar(100),
    dataimp              date      not null,
    horaimp    	   	 char(5)       null,
    processado           bool,

    primary key(sequencial),

    foreign key(integra_cad_empresa) references integra_cad_empresa (sequencial)
  );

-- ======================================================================

CREATE TABLE integra_empresa_atividade
  (
    sequencial             int4      unique not null,
    munic_ibge             int4      not null,
    integra_cad_empresa    int4      not null,
    integra_cad_atividade  int4      not null,
    atividade_principal    varchar(1),
    datainicio             date      	 null,
    datafim                date,
    exercicio              int4,
    dataimp                date      not null,
    horaimp    	   	   char(5)       null,
    processado             bool,


    primary key(sequencial),

    foreign key(integra_cad_empresa) references integra_cad_empresa (sequencial),
    foreign key(integra_cad_atividade) references integra_cad_atividade (sequencial)
  );

-- ======================================================================

CREATE TABLE integra_empresa_simples
  (
    sequencial           int4      unique not null,
    munic_ibge           int4,
    integra_cad_empresa  int4      not null,
    datainicial          date      not null,
    datafinal            date,
    tipo                 int4      not null,
    dataimp              date      not null,
    horaimp    	   	 char(5)       null,
    processado           bool,


    primary key(sequencial),

    CONSTRAINT FK_integra_inter_empresas_sequencia foreign key(integra_cad_empresa) references integra_cad_empresa (sequencial)
  );

-- ======================================================================

CREATE TABLE integra_empresa_escritorio
  (
    sequencial              int4      unique not null,
    munic_ibge              int4      not null,
    integra_cad_escritorio  int4      not null,
    integra_cad_empresa     int4      not null,
    datainicial             date          null,
    datafinal               date	  null,	  
    dataimp                 date      not null,
    horaimp    	   	    char(5)       null,
    processado              bool,


    primary key(sequencial),

    foreign key(integra_cad_escritorio) references integra_cad_escritorio(sequencial),
    foreign key(integra_cad_empresa) references integra_cad_empresa (sequencial)
  );

-- ======================================================================

CREATE TABLE integra_empresa_socio
  (
    sequencial           int4            unique not null,
    munic_ibge           int4            not null,
    integra_cad_empresa  int4            not null,
    integra_cad_socio    int4            not null,
    datainicial          date                null,
    datafinal            date                null,
    percentual           numeric 	 default 0,
    dataimp              date        	 not null,
    horaimp    	   	 char(5)             null,
    processado           bool,


    primary key(sequencial),

    foreign key(integra_cad_empresa) references integra_cad_empresa (sequencial),
    foreign key(integra_cad_socio) references integra_cad_socio(sequencial)
  );

-- ======================================================================

CREATE TABLE integra_empresa_aidof
  (
    sequencial           int4        unique not null,
    munic_ibge           int4        not null,
    aidof                int4        unique not null,
    integra_cad_empresa  int4        not null,
    integra_cad_grafica  int4        not null,
    tipo_docum           varchar(10),
    serie                varchar(10),
    num_inicial          int4        not null,
    num_final            int4        not null,
    qtd_solicitada       int4        not null,
    qtd_liberada         int4        not null,
    num_vias             int4		 null,
    data_liberacao       date        not null,
    validade             date,
    observacao           text,
    dataimp              date        not null,
    horaimp    	   	 char(5)         null,
    processado           bool,


    primary key(sequencial),

    foreign key(integra_cad_empresa) references integra_cad_empresa(sequencial),
    foreign key(integra_cad_grafica) references integra_cad_grafica(sequencial)
  );

-- ======================================================================

CREATE TABLE integra_empresa_estimativa
  (
    sequencial           int4        unique not null,
    munic_ibge           int4        not null,
    codigo_estimativa	 int4        not null,
    integra_cad_empresa  int4        not null,
    tiporegime           varchar(1)  not null,
    datainicial          date        	 null,
    datafinal            date,
    processo             varchar(15),
    observacao           varchar(200),
    dataimp            	 date        not null,
    horaimp  		 char(5)         null,
    processado           bool,

    primary key(sequencial),

    foreign key(integra_cad_empresa) references integra_cad_empresa (sequencial)
  );

-- ======================================================================

CREATE TABLE integra_estimativa_detalhe
  (
    sequencial                  int4     unique not null,
    munic_ibge                  int4     not null,
    integra_empresa_estimativa  int4     not null,
    integra_cad_empresa         int4     not null,
    ano_competencia             int4     not null,
    mes_competencia             int4     not null,
    parcela                     int4     not null,
    data_vencimento             date     not null,
    receita_presumida           int4,
    imposto_presumido           int4,
    dataimp            	 	date     not null,
    horaimp  			char(5)  null,
    processado                 	bool,
    

    primary key(sequencial),

    foreign key(integra_empresa_estimativa) references integra_empresa_estimativa(sequencial),
    foreign key(integra_cad_empresa) references integra_cad_empresa (sequencial)
  );

-- ======================================================================

CREATE TABLE integra_recibo
  (
    sequencial           int4            unique not null,
    munic_ibge           int4            not null,
    integra_cadastro     int4,
    integra_cad_empresa  int4,
    numdoc               varchar(20)     not null,
    ano_competencia      int4            not null,
    mes_competencia      int4            not null,
    cod_barras           varchar(60)     not null,
    data_emissao         date            not null,
    data_vencimento      date            not null,
    valor_imposto        numeric(15,2)   default 0,
    valor_juros          numeric(15,2)   default 0,
    valor_multa          numeric(15,2)   default 0,
    valor_desconto       numeric(15,2)   default 0,
    valor_total          numeric(15,2)   default 0,
    tipo_boleto          varchar(1)      not null,
    dataimp            	 date          	 not null,
    horaimp  		 char(5)             null,
    processado           bool,

    primary key(sequencial),

    foreign key(integra_cad_empresa) references integra_cad_empresa(sequencial),
    foreign key(integra_cadastro)    references integra_cadastro(sequencial)
  );

-- ======================================================================

CREATE TABLE integra_recibo_anulado
  (
    sequencial      int4         unique not null,
    munic_ibge      int4         not null,
    integra_recibo  int4         not null,
    descricao       varchar(2000),
    usuario         varchar(100),
    data_anulacao   date         not null,
    dataimp         date      	 not null,
    horaimp  	    char(5)      null,
    processado      bool,


    primary key(sequencial),

    foreign key(integra_recibo) references integra_recibo(sequencial)
  );

-- ======================================================================

CREATE TABLE integra_recibo_baixa_detalhe
  (
    sequencial             int4          not null,
    munic_ibge             int4          not null,
    integra_recibo         int4          not null,
    integra_recibo_numdoc  varchar(20)   not null,
    integra_recibo_baixa   int4          not null,
    data_baixa             date          not null,
    local_pagto            varchar(1),
    valor_imposto          numeric(15,2) default 0,
    valor_juros            numeric(15,2) default 0,
    valor_multa            numeric(15,2) default 0,
    valor_desconto         numeric(15,2) default 0,
    valor_pago             numeric(15,2) default 0,
    dataimp                date          not null,
    horaimp  	   	   char(5)           null,
    processado     	   bool,


    primary key(sequencial),

-- Gerado pelo Druid com erro pois numbco da tabela integra_recibo não é chave
-- foreign key(integra_recibo,integra_recibo_numdoc) references integra_recibo(sequencial,numdoc),
    foreign key(integra_recibo) references integra_recibo(sequencial),
    foreign key(integra_recibo_baixa) references integra_recibo_baixa(sequencial)
  );




