
-- =====================================================
-- 1. CRIAÇÃO DO BANCO E TABELAS
-- =====================================================
CREATE DATABASE IF NOT EXISTS Supermercado;
USE Supermercado;

-- Tabela Cliente
CREATE TABLE Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    CPF CHAR(11) UNIQUE NOT NULL,
    telefone VARCHAR(15),
    endereco VARCHAR(200),
    pontos INT DEFAULT 0
);

-- Tabela Categoria
CREATE TABLE Categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome_categoria VARCHAR(50) NOT NULL
);

-- Tabela Produto
CREATE TABLE Produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    estoque INT DEFAULT 0,
    preco_venda DECIMAL(10,2) NOT NULL,
    preco_compra DECIMAL(10,2) NOT NULL,
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria)
);

-- Tabela Fornecedor
CREATE TABLE Fornecedor (
    id_fornecedor INT PRIMARY KEY AUTO_INCREMENT,
    nome_empresa VARCHAR(100) NOT NULL,
    CNPJ CHAR(14) UNIQUE NOT NULL,
    telefone_representante VARCHAR(15),
    email VARCHAR(100)
);

-- Tabela Vendas
CREATE TABLE Vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE NOT NULL,
    id_cliente INT,
    forma_pagamento VARCHAR(50),
    valor_total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

-- Tabela Itens_venda
CREATE TABLE Itens_venda (
    id_venda INT,
    id_produto INT,
    quantidade INT,
    preco_venda_unitario DECIMAL(10,2),
    PRIMARY KEY (id_venda, id_produto),
    FOREIGN KEY (id_venda) REFERENCES Vendas(id_venda),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

-- Tabela Compras
CREATE TABLE Compras (
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    data_compra DATE NOT NULL,
    id_fornecedor INT,
    FOREIGN KEY (id_fornecedor) REFERENCES Fornecedor(id_fornecedor)
);

-- Tabela Itens_compra
CREATE TABLE Itens_compra (
    id_compra INT,
    id_produto INT,
    quantidade INT,
    preco_compra_unitario DECIMAL(10,2),
    PRIMARY KEY (id_compra, id_produto),
    FOREIGN KEY (id_compra) REFERENCES Compras(id_compra),
    FOREIGN KEY (id_produto) REFERENCES Produto(id_produto)
);

-- =====================================================
-- 2. ALTER TABLE – novas colunas e mudanças de tipos
-- =====================================================

-- 2.1 Novos campos
ALTER TABLE Cliente ADD email VARCHAR(100);
ALTER TABLE Produto ADD data_validade DATE;

-- 2.2 Mudança de tipo/tamanho
ALTER TABLE Cliente MODIFY telefone VARCHAR(20);
ALTER TABLE Fornecedor MODIFY email VARCHAR(150);

-- =====================================================
-- 3. INSERT – 5 registros por tabela
-- =====================================================

INSERT INTO Cliente (nome, CPF, telefone, endereco, pontos, email) VALUES
('Maria Silva', '12345678901', '11999990000', 'Rua A, 123', 100, 'maria@email.com'),
('João Souza', '23456789012', '11988887777', 'Rua B, 456', 200, 'joao@email.com'),
('Ana Lima', '34567890123', '21977776666', 'Rua C, 789', 150, 'ana@email.com'),
('Carlos Mendes', '45678901234', '31966665555', 'Rua D, 321', 300, 'carlos@email.com'),
('Beatriz Rocha', '56789012345', '41955554444', 'Rua E, 654', 50, 'beatriz@email.com');

INSERT INTO Categoria (nome_categoria) VALUES
('Eletrônicos'), ('Móveis'), ('Vestuário'), ('Alimentos'), ('Bebidas');

INSERT INTO Produto (nome_produto, estoque, preco_venda, preco_compra, id_categoria, data_validade) VALUES
('Notebook', 10, 3500.00, 3000.00, 1, NULL),
('Sofá', 5, 1500.00, 1000.00, 2, NULL),
('Camiseta', 50, 50.00, 25.00, 3, NULL),
('Arroz 5kg', 100, 25.00, 18.00, 4, '2025-12-31'),
('Refrigerante 2L', 80, 8.00, 5.00, 5, '2025-06-30');

INSERT INTO Fornecedor (nome_empresa, CNPJ, telefone_representante, email) VALUES
('Tech Ltda', '12345678000199', '11911112222', 'contato@tech.com'),
('Moveis SA', '23456789000188', '11922223333', 'contato@moveis.com'),
('Moda BR', '34567890000177', '11933334444', 'contato@moda.com'),
('Alimentos Ltda', '45678901000166', '11944445555', 'contato@alimentos.com'),
('Bebidas SA', '56789012000155', '11955556666', 'contato@bebidas.com');

INSERT INTO Vendas (data_venda, id_cliente, forma_pagamento, valor_total) VALUES
('2025-08-01', 1, 'Cartão', 3500.00),
('2025-08-02', 2, 'Dinheiro', 1525.00),
('2025-08-03', 3, 'PIX', 75.00),
('2025-08-04', 4, 'Cartão', 25.00),
('2025-08-05', 5, 'Cartão', 16.00);

INSERT INTO Itens_venda (id_venda, id_produto, quantidade, preco_venda_unitario) VALUES
(1, 1, 1, 3500.00),
(2, 2, 1, 1500.00),
(2, 4, 1, 25.00),
(3, 3, 1, 50.00),
(3, 5, 1, 8.00);

INSERT INTO Compras (data_compra, id_fornecedor) VALUES
('2025-07-20', 1),
('2025-07-21', 2),
('2025-07-22', 3),
('2025-07-23', 4),
('2025-07-24', 5);

INSERT INTO Itens_compra (id_compra, id_produto, quantidade, preco_compra_unitario) VALUES
(1, 1, 5, 3000.00),
(2, 2, 2, 1000.00),
(3, 3, 20, 25.00),
(4, 4, 50, 18.00),
(5, 5, 40, 5.00);

-- =====================================================
-- 4. UPDATE 
-- =====================================================

UPDATE Cliente SET pontos = pontos + 50 WHERE id_cliente = 1;
UPDATE Produto SET estoque = estoque - 1 WHERE id_produto = 1;
UPDATE Produto SET preco_venda = 55.00 WHERE id_produto = 3;
UPDATE Fornecedor SET telefone_representante = '11900001111' WHERE id_fornecedor = 2;
UPDATE Vendas SET forma_pagamento = 'PIX' WHERE id_venda = 5;

-- =====================================================
-- 5. SELECT – 
-- =====================================================

-- 5.1 LIKE
SELECT * FROM Cliente WHERE nome LIKE 'M%';

-- 5.2 BETWEEN
SELECT * FROM Produto WHERE preco_venda BETWEEN 20 AND 100;

-- 5.3 SUM
SELECT SUM(valor_total) AS total_vendas FROM Vendas;

-- 5.4 AVG
SELECT AVG(preco_venda) AS media_preco FROM Produto;

-- 5.5 GROUP BY
SELECT id_cliente, COUNT(*) AS qtd_vendas FROM Vendas GROUP BY id_cliente;

-- 5.6 ORDER BY
SELECT * FROM Produto ORDER BY preco_venda DESC;

-- 5.7 COUNT
SELECT COUNT(*) AS total_clientes FROM Cliente;

-- 5.8 MIN
SELECT MIN(preco_venda) AS menor_preco FROM Produto;

-- 5.9 MAX
SELECT MAX(pontos) AS max_pontos FROM Cliente;

-- 5.10 GROUP BY com SUM
SELECT id_categoria, SUM(estoque) AS total_estoque FROM Produto GROUP BY id_categoria;

-- =====================================================
-- 6. DELETE – 
-- =====================================================
DELETE FROM Itens_venda WHERE id_venda = 4 AND id_produto = 4;
DELETE FROM Cliente WHERE id_cliente = 5;


   -- JOINS -- 
-- 1. Clientes e suas vendas
SELECT c.nome, v.id_venda, v.data_venda, v.valor_total
FROM Cliente c
INNER JOIN Vendas v ON c.id_cliente = v.id_cliente;

-- 2. Produtos vendidos com categoria
SELECT p.nome_produto, cat.nome_categoria, iv.quantidade, iv.preco_venda_unitario
FROM Itens_venda iv
INNER JOIN Produto p ON iv.id_produto = p.id_produto
INNER JOIN Categoria cat ON p.id_categoria = cat.id_categoria;

-- 3. Compras e fornecedores
SELECT f.nome_empresa, c.id_compra, c.data_compra
FROM Compras c
INNER JOIN Fornecedor f ON c.id_fornecedor = f.id_fornecedor;

-- 4. Itens de compra com produto
SELECT ic.id_compra, p.nome_produto, ic.quantidade, ic.preco_compra_unitario
FROM Itens_compra ic
INNER JOIN Produto p ON ic.id_produto = p.id_produto;

-- 5. Relatório geral de vendas com cliente e produto
SELECT v.id_venda, c.nome AS cliente, p.nome_produto, iv.quantidade, iv.preco_venda_unitario
FROM Vendas v
INNER JOIN Cliente c ON v.id_cliente = c.id_cliente
INNER JOIN Itens_venda iv ON v.id_venda = iv.id_venda
INNER JOIN Produto p ON iv.id_produto = p.id_produto;

-- Relatórios (5) -- 

-- 1. Total de vendas por cliente
SELECT c.nome, SUM(v.valor_total) AS total_gasto
FROM Cliente c
JOIN Vendas v ON c.id_cliente = v.id_cliente
GROUP BY c.nome;

-- 2. Produtos mais vendidos
SELECT p.nome_produto, SUM(iv.quantidade) AS total_vendido
FROM Produto p
JOIN Itens_venda iv ON p.id_produto = iv.id_produto
GROUP BY p.nome_produto
ORDER BY total_vendido DESC;

-- 3. Estoque por categoria
SELECT cat.nome_categoria, SUM(p.estoque) AS estoque_total
FROM Categoria cat
JOIN Produto p ON cat.id_categoria = p.id_categoria
GROUP BY cat.nome_categoria;

-- 4. Compras por fornecedor
SELECT f.nome_empresa, COUNT(c.id_compra) AS qtd_compras
FROM Fornecedor f
JOIN Compras c ON f.id_fornecedor = c.id_fornecedor
GROUP BY f.nome_empresa;

-- 5. Média de valor das vendas por forma de pagamento
SELECT forma_pagamento, AVG(valor_total) AS media_valor
FROM Vendas
GROUP BY forma_pagamento;

-- Views e Controle de Acesso -- 

-- Criando Views
CREATE VIEW vw_clientes_vendas AS
SELECT c.nome, v.id_venda, v.valor_total
FROM Cliente c
JOIN Vendas v ON c.id_cliente = v.id_cliente;

CREATE VIEW vw_produtos_estoque AS
SELECT p.nome_produto, p.estoque, cat.nome_categoria
FROM Produto p
JOIN Categoria cat ON p.id_categoria = cat.id_categoria;

-- Criação de usuários
CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'senha123';
CREATE USER 'vendedor'@'localhost' IDENTIFIED BY 'senha123';
CREATE USER 'estoquista'@'localhost' IDENTIFIED BY 'senha123';
CREATE USER 'financeiro'@'localhost' IDENTIFIED BY 'senha123';

-- Criação de papéis
CREATE ROLE 'role_vendas';
CREATE ROLE 'role_estoque';

-- Atribuição de privilégios
GRANT SELECT ON Supermercado.vw_clientes_vendas TO 'role_vendas';
GRANT SELECT ON Supermercado.vw_produtos_estoque TO 'role_estoque';

-- Atribuição de papéis aos usuários
GRANT 'role_vendas' TO 'vendedor'@'localhost';
GRANT 'role_estoque' TO 'estoquista'@'localhost';

-- Stored Procedure -- 

DELIMITER //
CREATE PROCEDURE sp_atualiza_pontos(IN cliente_id INT, IN pontos_extra INT)
BEGIN
    UPDATE Cliente SET pontos = pontos + pontos_extra WHERE id_cliente = cliente_id;
END //
DELIMITER ;

-- Exemplo:
CALL sp_atualiza_pontos(1, 100);

-- Trigger -- 

DELIMITER //
CREATE TRIGGER trg_atualiza_estoque_venda
AFTER INSERT ON Itens_venda
FOR EACH ROW
BEGIN
    UPDATE Produto
    SET estoque = estoque - NEW.quantidade
    WHERE id_produto = NEW.id_produto;
END //
DELIMITER ;

-- Backup -- 
-- mysqldump -u root -p Supermercado > Supermercado_backup.sql

-- Modo com que as views e Store Procedures fiquem visiveis--

CREATE VIEW vw_clientes_vendas AS
SELECT c.nome, v.id_venda, v.valor_total
FROM Cliente c
JOIN Vendas v ON c.id_cliente = v.id_cliente;

CREATE VIEW vw_produtos_estoque AS
SELECT p.nome_produto, p.estoque, cat.nome_categoria
FROM Produto p
JOIN Categoria cat ON p.id_categoria = cat.id_categoria;

DELIMITER //
CREATE PROCEDURE sp_atualiza_pontos(IN cliente_id INT, IN pontos_extra INT)
BEGIN
    UPDATE Cliente SET pontos = pontos + pontos_extra WHERE id_cliente = cliente_id;
END //
DELIMITER ;

