
USE projeto;

/********************
       QUERIES
*******************/

-- Query 1
-- Consultar os dados de um cliente dado o seu id
SELECT * FROM CLIENTE as C
WHERE c.idCliente = 1;

-- Query 2
-- Consultar os número de bilhetes comprados por cada cliente
SELECT c.nome, count(b.idFilme) as BilhetesComprados  FROM CLIENTE as C
JOIN BILHETE AS B where c.idCliente=b.idCliente
group by c.nome;

-- Query 3
-- Consultar os dados de um funcionário dado o seu id (Neste caso id=1)
SELECT * FROM FUNCIONARIO as F
WHERE f.idFuncionario = 1;

-- Query 4
-- Consultar quantos bilhetes foram vendidos por cada funcionário
SELECT F.NOME, count(B.idFilme) as BilhetesVendidos FROM FUNCIONARIO AS F
JOIN BILHETE AS B where f.idFuncionario=b.idFuncionario
group by f.nome;

-- Query 5
-- Consultar as informações de um filme dado o seu id (Neste caso id=1)
SELECT * FROM FILME as F
WHERE f.idFilme = 1;

-- query 6
-- Permitir a ver a capacidade de cada sala
SELECT s.numero, s.capacidade FROM SALA AS S;

-- query 7
-- Listar todos os funcionários que trabalham no cinema
SELECT * FROM Funcionario;

-- query 8
-- Listar quais os clientes que compraram o bilhete antes da hora do filme, qual o filme
-- e a sua hora de transmissão e de compra
select c.nome, f.nome, time(b.data_compra) as hora_compra, time(b.data_filme) as hora_filme from Cliente as c
join Bilhete as b on c.idCliente = b.idCliente
join Filme as f on b.idFilme = f.idFilme
where timediff(b.data_compra, b.data_filme) < 0;

-- query 9
-- Consultar a média das idades dos clientes que assistiram a cada filme
/*Function que cacula a idade dada a data de nascimento*/
DELIMITER //
CREATE FUNCTION `idade`(dta date) RETURNS int
BEGIN
RETURN timestampdiff(YEAR, dta, CURDATE());
END //
DELIMITER ;

SELECT f.nome, AVG (idade(c.data_nascimento)) as media_idades FROM Filme f
JOIN Bilhete as b on f.idFilme = b.idFilme
JOIN Cliente as c on c.idCliente= b.idCliente
GROUP BY f.nome;

-- query 10
-- Consultar o número de cientes que assistiram a um filme(id) por localidade
SELECT cp.localidade, count(distinct c.idcliente) as nrClientes, f.nome
FROM Cliente c
JOIN Codigo_Postal as cp on cp.codigo_Postal = c.cod_postal
JOIN Bilhete as b on c.idCliente = b.idCliente
JOIN Filme as f ON f.idFilme = b.idFilme
where f.idFilme = 2
GROUP BY cp.localidade;

-- query 11
-- Listar todos os clientes que assistiram a um determinado filme
DELIMITER //
CREATE PROCEDURE `listarClientesFilme`(IN filme varchar(45), INOUT result_list varchar(2000))
BEGIN

  DECLARE c_finished integer default 0;
    DECLARE c_nome_cliente varchar(45);

    DECLARE clientes_cursor CURSOR FOR
    SELECT c.nome
    FROM Cliente c, Bilhete b, Filme f WHERE c.idCliente= b.idCliente and b.idFilme = f.idFilme and f.nome = filme;


    DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

    OPEN clientes_cursor;
    FETCH NEXT FROM clientes_cursor into c_nome_cliente;

    get_cliente : LOOP
    FETCH clientes_cursor INTO c_nome_cliente;
        IF c_finished = 1 THEN
      LEAVE get_cliente;
    END IF;
        SET result_list = CONCAT(c_nome_cliente, '  \n', result_list);
  END LOOP;
  CLOSE clientes_cursor;
END //
DELIMITER ;

SET @res = '';
CALL listarClientesFilme('Maléfica',@res);
SELECT @res;

-- query 12
-- Consultar faturação de um determinado ano
DELIMITER //
CREATE PROCEDURE `faturacaoDeUmAno`(IN ano INT)
BEGIN
SELECT SUM(B.PRECO) FROM BILHETE AS B
WHERE YEAR(B.DATA_COMPRA) = ano AND DATEDIFF(CURDATE(), B.DATA_COMPRA) > 0;
END //
DELIMITER ;

    CALL faturacaoDeUmAno(2010);
