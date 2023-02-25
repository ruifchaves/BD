/* query 1*/
/* Consultar quantos bilhetes foram vendidos por cada funcionário */
SELECT F.NOME, count(distinct B.idFilme) as BilhetesVendidos FROM FUNCIONARIO AS F
JOIN BILHETE AS B where f.idFuncionario=b.idFuncionario
group by f.nome;

/*query 2*/
/*Consultar os dados de um cliente dado o seu id*/
SELECT * FROM CLIENTE as C 
WHERE c.idCliente = 1;

/*query 2.1*/
/*Consultar os número de bilhetes comprados por cada cliente */
SELECT c.nome, count(b.idFilme) as BilhetesComprados  FROM CLIENTE as C 
JOIN BILHETE AS B where c.idCliente=b.idCliente
group by c.nome;

/*query 3*/
/*Consultar os dados de um funcionário dado o seu id*/
SELECT * FROM FUNCIONARIO as F
WHERE f.idFuncionario = 1;


/*query 4*/
/*Consultar as informações de um filme dado o seu id*/
SELECT * FROM FILME as F
WHERE f.idFilme = 1;


/*query 5*/
/*Permitir a ver a capacidade de cada sala*/
SELECT s.numero, s.capacidade FROM SALA AS S;

/*query 5*/
/*Listar todos os clientes que assistiram a um determinado filme*/
DELIMITER //
CREATE PROCEDURE listarClientesFilme(IN filme varchar(45), INOUT result_list varchar(2000))
BEGIN 

	DECLARE c_finished integer default 0;
    DECLARE c_nome_cliente varchar(45);
    
    DECLARE clientes_cursor CURSOR FOR 
    SELECT c.nome
		FROM Cliente c, Bihete b, Filme f WHERE c.idCliente= b.Cliente and b.idFilme = f.idFilme and f.nome = nome;
    
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET c_finished = 1;

    OPEN clientes_cursor;
    FETCH NEXT FROM clientes_cursor into c_nome_cliente;
 
    get_cliente : LOOP
		FETCH clientes_cursor INTO c_nome_cliente;
        IF c_finished = 1 THEN 
			LEAVE get_cliente;
		END IF;
        SET result_list = CONCAT(c_nome_cliente, "\n", result_list);
	END LOOP;
	CLOSE clientes_cursor;
END//
DELIMITER ;


SET @res = "";
CALL listarClientesFilme('Rei Leão', @res);
SELECT @res;


