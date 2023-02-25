
USE projeto;

/********************
       VISTAS
*******************/

-- Criação da vista "vwlistaFuncionarios"
CREATE VIEW vwlistaFuncionarios AS
SELECT IDFuncionario AS Nr, Nome  , Data_Nascimento AS 'Data de Nascimento',
 Contato, Morada, Cod_Postal AS 'Código Postal'
FROM Funcionario AS F;

SELECT * FROM vwlistaFuncionarios;

-- Criação da vista "vwClientesbyLocalidade"
CREATE VIEW vwlistaClientesbyLocalidade AS
SELECT c.idcliente AS Nr, c.nome, cp.Localidade FROM Cliente c
JOIN Codigo_Postal AS cp ON  cp.codigo_Postal = c.cod_postal
GROUP BY cp.localidade;

SELECT * FROM vwlistaClientesbyLocalidade;


-- Criação da vista "vwlistaClientes"
CREATE VIEW vwlistaClientes AS
SELECT IDCliente AS Nr, Nome , Data_Nascimento AS 'Data de Nascimento',
 Contato, Cod_Postal AS 'Código Postal'
 FROM Cliente AS C;

SELECT * FROM vwlistaClientes;

-- Criação da vista "vwFimesbyTipo"
CREATE VIEW vwFimesbyTipo AS
SELECT f.nome AS Nome, f.tipo AS Tipo FROM Filme f
order by f.tipo;

-- Criação da vista "vwlistaFilmes"
CREATE VIEW vwlistaFilmes AS
SELECT IDFilme AS Nr, Nome, tipo, duracao, classificacao
FROM Filme AS F;

-- Criação da vista "vwFuncionariosbyLocalidade"
CREATE VIEW vwFuncionariosbyLocalidade AS
SELECT f.idFuncionario AS Nr, f.Nome, morada, cp.Localidade, Data_Nascimento
AS 'Data de Nascimento' ,Contato FROM Funcionario f
JOIN Codigo_Postal As cp ON cp.codigo_Postal = f.cod_postal
order by cp.localidade desc;

-- Criação da vista "vwFilmesbyClassificação"
CREATE VIEW vwFilmesbyClassificação AS
SELECT f.nome AS Nome, f.classificacao AS Classificação FROM Filme f
order by f.classificacao desc;


-- Criação da vista "vwFilmesbyDuracao"
CREATE VIEW vwFilmesbyDuracao AS
SELECT f.nome AS Nome, f.duracao AS Duracao FROM Filme f
order by f.duracao asc;

-- Criação da vista "vwFilmesbySala"
CREATE VIEW  vwFilmesbySala AS
SELECT distinct(f.nome) AS 'Nome do filme', s.numero AS 'Nº Sala' FROM Filme f
JOIN Bilhete AS b ON b.IDFilme = f.IDFilme
JOIN Sala AS s ON s.numero = b.numSala
order by s.numero;

