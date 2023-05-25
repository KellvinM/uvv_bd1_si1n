  --Deletando banco de dados caso exista;
DROP DATABASE IF EXISTS uvv;

--Deletando Usuario caso exista;
DROP USER IF EXISTS kellvin;

--Criando usuario;
CREATE USER kellvin 
WITH PASSWORD 'keko1234' 
CREATEDB CREATEROLE;

--Usando o usuario kellvin;
SET ROLE kellvin;


--Criando o Banco De Dados uvv;
CREATE DATABASE uvv
OWNER kellvin
template template0
encoding UTF8
lc_collate "pt_BR.UTF-8"
lc_ctype "pt_BR.UTF-8"
allow_connections TRUE
;

--Usando o banco de dados uvv;
\c uvv;

--Usando o usuario kellvin;
SET ROLE kellvin;
SELECT current_user;

--Criando o schema lojas e dando autorização ao usuario;
CREATE SCHEMA IF NOT EXISTS lojas AUTHORIZATION kellvin;

--Olhando o atual esquema;
SELECT CURRENT_SCHEMA;

--Olhando a ordem dos esquemas;
SHOW SEARCH_PATH;

--Ajustando o esquema padrão e conferindo se foi colocado de modo correto;
SET SEARCH_PATH         TO    lojas, kellvin, public;
SHOW SEARCH_PATH;
ALTER USER kellvin
SET SEARCH_PATH         TO    lojas, kellvin, public;


--Criação do conteudo do banco de dados;

--Criação da tabela produtos e suas colunas;

CREATE TABLE lojas.produtos (
                produto_id                 NUMERIC  (38)   NOT NULL,
                nome                       VARCHAR  (255)  NOT NULL,
                preco_unitario             NUMERIC  (10,2),
                detalhes                   BYTEA,  
                imagem                     BYTEA, 
                imagem_mime_type           VARCHAR  (512),
                imagem_arquivo             VARCHAR  (512),
                imagem_charset             VARCHAR  (512),
                imagem_ultima_atualizacao  DATE,
                --Criação da chave primaria da tabela produtos;
                CONSTRAINT pk_produto_id   PRIMARY KEY (produto_id)
);
--Restrições das colunas da tabela produtos;
ALTER TABLE produtos
ADD CONSTRAINT check_preco_unitario_positivo    CHECK    (preco_unitario >= 0),
ADD CONSTRAINT check_produto_positivo           CHECK    (produto_id >= 0);


--Comentarios da tabela produtos e de suas respectivas colunas;

COMMENT ON TABLE  lojas.produtos                           IS   'tabela para mostrar as características dos produtos
';
COMMENT ON COLUMN lojas.produtos.produto_id                IS   'coluna com numero identificador do produto';
COMMENT ON COLUMN lojas.produtos.nome                      IS   'coluna para mostrar o nome do produto';
COMMENT ON COLUMN lojas.produtos.preco_unitario            IS   'coluna que mostra o preço unitario de cada produto';
COMMENT ON COLUMN lojas.produtos.detalhes                  IS   'Coluna que Mostra os detalhes de cada produto';
COMMENT ON COLUMN lojas.produtos.imagem                    IS   'essa coluna demonstra um conjunto de dados armazenados que é equivalente a imagem de cada produto';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type          IS   'coluna para se referir o tipo de imagem dos produtos
';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo            IS   'coluna para mostrar o arquivo da imagem
';
COMMENT ON COLUMN lojas.produtos.imagem_charset            IS   'coluna que mostra um conjunto de caracteres que descrevem a imagem
';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS   'coluna para mostrar a  data da ultima atualizacao que a imagem do produto teve';
 
--Criação da tabela lojas e suas colunas;

CREATE TABLE lojas.lojas (
                loja_id                 NUMERIC  (38)   NOT NULL,
                nome                    VARCHAR  (255)  NOT NULL,
                endereco_web            VARCHAR  (100),
                endereco_fisico         VARCHAR  (512),
                latitude                NUMERIC,
                longitude               NUMERIC,
                logo                    BYTEA,
                logo_mime_type          VARCHAR  (512),
                logo_arquivo            VARCHAR  (512),
                logo_charset            VARCHAR  (512),
                logo_ultima_atualizacao DATE,
                --Criação da chave primaria da tabela lojas;
                CONSTRAINT pk_loja_id   PRIMARY KEY (loja_id)
);

--Restrições das colunas da tabela lojas;
ALTER TABLE lojas
ADD CONSTRAINT check_endereco_lojas       CHECK        ((endereco_web IS NOT NULL) OR (endereco_fisico IS NOT NULL)),
ADD CONSTRAINT check_loja_positivo        CHECK        (loja_id >= 0);


--Comentarios da tabela lojas e de suas respectivas colunas; 

COMMENT ON TABLE  lojas.lojas                         IS   'tabela que mostra as características das lojas
';
COMMENT ON COLUMN lojas.lojas.loja_id                 IS   'coluna com um numero responsavel pela  identificação da loja';
COMMENT ON COLUMN lojas.lojas.nome                    IS   'coluna que mostra o nome das lojas';
COMMENT ON COLUMN lojas.lojas.endereco_web            IS   'coluna que mostra o endereço web das lojas
';
COMMENT ON COLUMN lojas.lojas.endereco_fisico         IS   'coluna que mostra o endereço fisico das lojas
';
COMMENT ON COLUMN lojas.lojas.latitude                IS   'coluna que mostra a latitude que a loja esta localizada';
COMMENT ON COLUMN lojas.lojas.longitude               IS   'coluna que mostra a longitude que a loja esta localizada';
COMMENT ON COLUMN lojas.lojas.logo                    IS   'coluna que representa a logo com um conjunto de dados armazenados';
COMMENT ON COLUMN lojas.lojas.logo_mime_type          IS   'coluna para se referir ao tipo de logo que esta sendo usada';
COMMENT ON COLUMN lojas.lojas.logo_arquivo            IS   'coluna que mostra o arquivo da logo ';
COMMENT ON COLUMN lojas.lojas.logo_charset            IS   'coluna que mostra um conjunto de caracteres que descrevem a logo
';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS   'coluna que mostra a data da ultima atualização que a logo teve';

--Criação da tabela estoques e suas colunas;

CREATE TABLE lojas.estoques (
                estoque_id               NUMERIC  (38)   NOT NULL,
                loja_id                  NUMERIC  (38)   NOT NULL,
                produto_id               NUMERIC  (38)   NOT NULL,
                quantidade               NUMERIC  (38)   NOT NULL,
                --Criação da chave primaria da tabela estoques;
                CONSTRAINT pk_estoque_id PRIMARY KEY (estoque_id)
);
--Restrições das colunas da tabela estoques;
ALTER TABLE estoques
ADD CONSTRAINT check_quantidade_positivo  CHECK        (quantidade >= 0),
ADD CONSTRAINT check_loja_positivo        CHECK        (loja_id >= 0),
ADD CONSTRAINT check_produto_positivo     CHECK        (produto_id >= 0),
ADD CONSTRAINT check_estoque_positivo     CHECK        (estoque_id >= 0);

--Comentarios da tabela estoques e de suas respectivas colunas;
COMMENT ON TABLE  lojas.estoques                IS   'tabela para mostrar as caracteristicas dos estoques';
COMMENT ON COLUMN lojas.estoques.estoque_id     IS   'coluna com numero para identificar cada estoque';
COMMENT ON COLUMN lojas.estoques.loja_id        IS   'coluna de identificação da loja';
COMMENT ON COLUMN lojas.estoques.produto_id     IS   'coluna com numero identificador do produto';
COMMENT ON COLUMN lojas.estoques.quantidade     IS   'coluna para mostrar a quantidade de cada produto que tem no estoque';

--Criação da tabela clientes e suas colunas;

CREATE TABLE lojas.clientes (
                cliente_id               NUMERIC   (38)    NOT NULL,
                email                    VARCHAR   (255)   NOT NULL,
                nome                     VARCHAR   (255)   NOT NULL,
                telefone1                VARCHAR   (20),
                telefone2                VARCHAR   (20),
                telefone3                VARCHAR   (20),
                --Criaçãp da chave primaria da tabela clientes;
                CONSTRAINT pk_cliente_id PRIMARY KEY (cliente_id)
);
--Restrições das colunas da tabela clientes;
ALTER TABLE lojas.clientes
ADD CONSTRAINT check_cliente_positivo  CHECK   (cliente_id >= 0);

--Comentarios da tabela clientes e de suas respectivas colunas;
COMMENT ON TABLE  lojas.clientes             IS  'Tabela com características dos clientes ';
COMMENT ON COLUMN lojas.clientes.cliente_id  IS  'Coluna que contem o numero de identificação do cliente ';
COMMENT ON COLUMN lojas.clientes.email       IS  'Coluna que informa o email do cliente';
COMMENT ON COLUMN lojas.clientes.nome        IS  'coluna que indica o nome do cliente';
COMMENT ON COLUMN lojas.clientes.telefone1   IS  'coluna que mostra o primeiro telefone do cliente		';
COMMENT ON COLUMN lojas.clientes.telefone2   IS  'coluna que mostra o segundo numero de telefone do cliente
';
COMMENT ON COLUMN lojas.clientes.telefone3   IS  'coluna que mostra o terceiro numero de telefone do cliente
';

--Criação da tabela envios e suas colunas;

CREATE TABLE lojas.envios (
                envio_id               NUMERIC  (38)  NOT NULL,
                loja_id                NUMERIC  (38)  NOT NULL,
                cliente_id             NUMERIC  (38)  NOT NULL,
                endereco_entrega       VARCHAR  (512) NOT NULL,
                status                 VARCHAR  (15)  NOT NULL,
                --Criação da chave primaria da tabela envios;
                CONSTRAINT pk_envio_id PRIMARY KEY (envio_id)
);
--Restrições das colunas da tabela envios;
ALTER TABLE lojas.envios
ADD CONSTRAINT check_status_envios      CHECK        (status IN ('CRIADO','ENVIADO','TRANSITO','ENTREGUE')),
ADD CONSTRAINT check_envio_positivo     CHECK        (envio_id >= 0),
ADD CONSTRAINT check_cliente_positivo   CHECK        (cliente_id >= 0),
ADD CONSTRAINT check_loja_positivo      CHECK        (loja_id >= 0);

--Comentarios da tabela envios e de suas respectivas colunas;
COMMENT ON TABLE  lojas.envios                   IS  'tabela para mostrar informações sobre os envios';
COMMENT ON COLUMN lojas.envios.envio_id          IS  'coluna com numero identificador para cada envio';
COMMENT ON COLUMN lojas.envios.loja_id           IS  'coluna de identificação da loja';
COMMENT ON COLUMN lojas.envios.cliente_id        IS  'Coluna que contem o numero de identificação do cliente ';
COMMENT ON COLUMN lojas.envios.endereco_entrega  IS  'coluna responsavel por mostrar o endereço de entrega';
COMMENT ON COLUMN lojas.envios.status            IS  'coluna responsavel por mostrar o status da entrega';
 
--Criação da tabela pedidos e suas colunas;

CREATE TABLE lojas.pedidos (
                pedido_id               NUMERIC   (38)  NOT NULL,
                data_hora               TIMESTAMP       NOT NULL,
                cliente_id              NUMERIC   (38)  NOT NULL,
                status                  VARCHAR   (15)  NOT NULL,
                loja_id                 NUMERIC   (38)  NOT NULL,
                --Criação da chave primaria da tabela pedidos;
                CONSTRAINT pk_pedido_id PRIMARY KEY (pedido_id)
);
--Restrições das colunas da tabela pedidos;
ALTER TABLE lojas.pedidos
ADD CONSTRAINT check_status_pedidos      CHECK    (status IN ('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO')),
ADD CONSTRAINT check_pedido_positivo     CHECK    (pedido_id >= 0),
ADD CONSTRAINT check_cliente_positivo    CHECK    (cliente_id >= 0),
ADD CONSTRAINT check_loja_positivo       CHECK    (loja_id >= 0);


--Comentarios da tabela pedidos e de suas respectivas colunas;
COMMENT ON TABLE  lojas.pedidos             IS   'tabela responsavel por mostrar informações dos pedidos';
COMMENT ON COLUMN lojas.pedidos.pedido_id   IS   'coluna com numero identificador do pedido';
COMMENT ON COLUMN lojas.pedidos.data_hora   IS   'coluna para mostrar a data e a hora que foi realizado o pedido';
COMMENT ON COLUMN lojas.pedidos.cliente_id  IS   'Coluna que contem o numero de identificação do cliente ';
COMMENT ON COLUMN lojas.pedidos.status      IS   'coluna que mostra o status do pedido ';
COMMENT ON COLUMN lojas.pedidos.loja_id     IS   'coluna com um numero responsavel pela identificação da loja';

--Criação da tabela pedidos_itens e suas colunas;

CREATE TABLE lojas.pedidos_itens (
                pedido_id                       NUMERIC  (38)   NOT NULL,
                produto_id                      NUMERIC  (38)   NOT NULL,
                numero_da_linha                 NUMERIC  (38)   NOT NULL,
                preco_unitario                  NUMERIC  (10,2) NOT NULL,
                quantidade                      NUMERIC  (38)   NOT NULL,
                envio_id                        NUMERIC  (38),
                --Criação da chave primaria da tabela pedidos_itens;
                CONSTRAINT pk_pedido_produto_id PRIMARY KEY (pedido_id, produto_id)
);
--Restrições das colunas da tabela pedidos_itens;
ALTER TABLE pedidos_itens
ADD CONSTRAINT check_preco_unitario_positivo   CHECK   (preco_unitario >= 0),
ADD CONSTRAINT check_quantidade_positiva       CHECK   (quantidade >= 0),
ADD CONSTRAINT check_pedido_positivo           CHECK   (pedido_id >= 0),
ADD CONSTRAINT check_produto_positivo          CHECK   (produto_id >= 0),
ADD CONSTRAINT check_numero_positivo           CHECK   (numero_da_linha >= 0),
ADD CONSTRAINT check_envio_positivo            CHECK   (envio_id >= 0);


--Comentarios da tabela pedidos_itens e de suas respectivas colunas;
COMMENT ON TABLE  lojas.pedidos_itens                 IS  'tabela para mostrar as informações sobre os pedidos e produtos ';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id       IS  'coluna com numero identificador do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id      IS  'coluna com numero identificador do produto';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS  'coluna para mostrar o numero da linha telefônica';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario  IS  'coluna para mostrar o preço unitario de cada pedido';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade      IS  'coluna para mostrar a quantidade de pedidos';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id        IS  'coluna com numero identificador para cada envio';


--Criação de um Relacionamento entre a tabela estoques e a tabela produtos, atraves da chave estrangeira produto_id;
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um Relacionamento entre a tabela pedido_itens e a tabela produtos, atraves da chave entrangeira produto_id;
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um Relacionamento entre a tabela pedidos e a tabelas lojas, atraves da chave estrangeira loja_id;
ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um Relacionamento entre a tabela estoques e a tabela lojas, atraves da chave estrangeira loja_id;
ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um Relacionamento entre a tabela envios e a tabela lojas, atraves da chave estrangeira loja_id;
ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um Relacionamento entre a tabela pedidos e a tabela clientes, atraves da chave estrangeira cliente_id;
ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um Relacionamento entre a tabela envios e a tabela clientes, atraves da chave estrangeira cliente_id;
ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um Relacionamento entre a tabela pedidos_itens e a tabela envios, atraves da chave estrangeira envio_id;
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Criação de um Relacionamento entre a tabela pedidos_itens e a tabela pedidos, atraves da chave estrangeira pedido_id;
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;