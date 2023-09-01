create database ECOMMERCE;
use ecommerce;

-- Tabela de produtos

create TABLE produtos (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(255) NOT NULL,
  descricao VARCHAR(255) NOT NULL,
  preco DECIMAL(3,2) NOT NULL,
  estoque INT NOT NULL,
  PRIMARY KEY (id)
);

-- Tabela de clientes
CREATE TABLE clientes (
  id INT NOT NULL AUTO_INCREMENT,
  nome VARCHAR(30) NOT NULL,
  email VARCHAR(50) NOT NULL,
  senha VARCHAR(50) NOT NULL,
  endereco VARCHAR(50) NOT NULL,
  cidade VARCHAR(20) NOT NULL,
  estado VARCHAR(20) NOT NULL,
  cep VARCHAR(10) NOT NULL,
  tipo_cliente ENUM('PJ', 'PF') NOT NULL,
  PRIMARY KEY (id)
);
-- Tabela de pedidos
CREATE TABLE pedidos (
  id INT NOT NULL AUTO_INCREMENT,
  cliente_id INT NOT NULL,
  data_pedido DATETIME NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  status VARCHAR(30) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (cliente_id) REFERENCES clientes (id)
);

-- Tabela de pagamentos
CREATE TABLE pagamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente VARCHAR(20),
    valor DECIMAL(10, 2),
    data_pagamento DATE
);
-- Recuperações simples com SELECT Statement:
-- Recupera todos os produtos da tabela de produtos
SELECT *
FROM produtos;

-- Recupera o nome e o preço dos produtos da tabela de produtos
SELECT nome, preco
FROM produtos;

-- Recupera o nome e o preço dos produtos que custam mais de R$ 100,00
SELECT nome, preco
FROM produtos
WHERE preco > 100;

-- Filtros com WHERE Statement:
-- Recupera todos os produtos que têm estoque disponível
SELECT *
FROM produtos
WHERE estoque > 0;

-- Recupera todos os clientes que moram na cidade de São Paulo
SELECT *
FROM clientes
WHERE cidade = 'São Paulo';

-- Recupera todos os pedidos que foram feitos em 2023
SELECT *
FROM pedidos
WHERE YEAR(data_pedido) = 2023;


--  atributos derivados:
-- Recupera o nome do produto e o seu preço por unidade
SELECT nome, preco / estoque AS preco_unitario
FROM produtos;

-- Recupera o nome do cliente e o seu total gasto em pedidos
SELECT nome, SUM(total) AS total_gasto
FROM pedidos
GROUP BY cliente_id;

-- ORDER BY:
-- Ordena os produtos por preço, do mais caro para o mais barato
SELECT *
FROM produtos
ORDER BY preco DESC;

-- Ordena os clientes por nome, em ordem alfabética
SELECT *
FROM clientes
ORDER BY nome;

-- Ordena os pedidos por data, do mais recente para o mais antigo
SELECT *
FROM pedidos
ORDER BY data_pedido DESC;

--  HAVING Statement:
-- Recupera os clientes que gastaram mais de R$ 1.000,00
SELECT nome, SUM(total) AS total_gasto
FROM pedidos
GROUP BY cliente_id
HAVING SUM(total) > 1000;

-- Recupera os produtos que têm o estoque abaixo de 10 unidades
SELECT nome, estoque
FROM produtos
GROUP BY nome
HAVING estoque < 10;

-- junções entre tabelas para fornecer uma perspectiva mais complexa dos dados:
-- Recupera o nome do produto, o nome do cliente e o total do pedido
SELECT produtos.nome, clientes.nome, pedidos.total
FROM produtos
INNER JOIN pedidos ON produtos.id = pedidos.produto_id
INNER JOIN clientes ON pedidos.cliente_id = clientes.id;

-- Recupera o nome do produto, o nome do cliente e a forma de pagamento
SELECT produtos.nome, clientes.nome, pagamentos.forma_pagamento
FROM produtos
INNER JOIN pedidos ON produtos.id = pedidos.produto_id
INNER JOIN pagamentos ON pedidos.id = pagamentos.pedido_id;


