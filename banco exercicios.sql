/*
	Banco Sakila exercicios Locadora / Sakila_db
	Exercicios contendo: SELECT, INNER JOIN, SUBCONSULTAS,  VIEW, FUNCTIONS.
	SELECT, INNER JOIN: EX 1-55.
	SUBCONSULTAS: EX 56-68.
	VIEW: EX 69-73.
	FUNCTIONS: EX 74-80.
 */
use sakila_db;

/*01- Listar todos os dados da tabela FILME*/
SELECT * FROM filme;

/*02-Listar os nome dos clientes que locaram filmes na data '2005-05-30 23:47:56';*/
SELECT c.primeiro_nome FROM cliente c
JOIN aluguel a ON c.cliente_id = a.cliente_id
WHERE a.data_de_aluguel = '2005-05-30 23:47:56';

/*03-Listar os nome dos funcionarios que locaram filmes na data '2005-05-30 23:47:56';*/
SELECT f.primeiro_nome FROM funcionario f
JOIN aluguel a ON f.funcionario_id = a.funcionario_id
WHERE a.data_de_aluguel = '2005-05-30 23:47:56';

/*04-Listar os nomes dos funcionários da loja 1;*/
SELECT f.primeiro_nome FROM funcionario f
JOIN loja l ON f.loja_id = l.loja_id
WHERE f.loja_id = 1;

/*05-Fazer uma média dos valores gastos pelo cliente 230 em locações;*/
SELECT AVG(valor) FROM pagamento 
WHERE cliente_id = 230;

/*06-Contar o número de filmes, que o funcionário 2 alugou;*/
SELECT count(aluguel_id) FROM aluguel
WHERE funcionario_id = 2;

/*07-Listar os nomes dos clientes que locaram filmes com o funcionário 1;*/
SELECT c.primeiro_nome, a.funcionario_id FROM cliente c
JOIN aluguel a ON c.cliente_id = a.cliente_id
WHERE a.funcionario_id = 1;

/*08-Listar os nome dos filmes da categoria 'Documentary', com preço de locação de 2.99;*/
SELECT f.titulo FROM filme f
JOIN filme_categoria fc ON f.filme_id = fc.filme_id
JOIN categoria c ON fc.categoria_id = c.categoria_id
WHERE c.nome = "Documentary" AND f.preco_da_locacao = 2.99;

/*09-Listar o nome do cliente, a data de aluguel e data de devolução das locações dos clientes de
id 330 e 300 e também mostrar qual a categoria do filmes;*/
SELECT Cli.primeiro_nome, A.data_de_aluguel, A.data_de_devolucao, C.nome FROM cliente AS Cli
JOIN aluguel AS A
JOIN categoria AS C ON Cli.cliente_id = A.cliente_id = C.nome
WHERE Cli.cliente_id = 330 OR Cli.cliente_id = 300;

/*10-Listar o idiomas dos filmes locados pelo cliente 330;*/
SELECT i.nome FROM idioma i
JOIN filme f ON i.idioma_id = f.idioma_id
JOIN inventario inv ON f.filme_id = inv.filme_id
JOIN aluguel a ON inv.inventario_id = a.inventario_id
WHERE a.cliente_id = 330;

/*11- Listar apenas o primeiro nome e  último nome dos registros da tabela CLIENTE*/
SELECT primeiro_nome, ultimo_nome 
FROM cliente;

/*12- Listar _as cidades cujo nome iniciam com a letra S.*/
SELECT * FROM cidade
WHERE cidade LIKE "S%";

/*13- Listar o titulo _do filmes com duração_do filme entre 60 e 80 minutos*/
SELECT titulo FROM filme
WHERE duracao_do_filme >= 60 AND
duracao_do_filme <= 80;
-- Podendo usar tambem: BETWEEN 60 AND 80;

/*14- listar os dados dos filmes com preço de locação Acima de 3 dólar, ordenar pelo título.*/
SELECT * FROM filme 
WHERE preco_da_locacao > 3
ORDER BY titulo;

/*15- Qual a média _do preço de locação?*/
SELECT AVG(preco_da_locacao) FROM filme;

/*16- Quantos filmes tem duração de 120 minutos ou mais?*/
SELECT COUNT(*) FROM filme
WHERE duracao_do_filme >= 120;

/*17- Qual a menor duracao da locacao?*/
SELECT MIN(duracao_da_locacao) as Duracao_filme
FROM filme;

/*18- Listar os filmes que possuem duração do filme maior que 100 e classificação igual a "G". */
SELECT titulo FROM filme 
WHERE duracao_do_filme > 100 
AND classificacao = 'G';

/*19- Listar a quantidade de filmes que estejam classificados como "PG-13" e preço da locação maior que 2.40.*/
SELECT count(*) FROM filme 
WHERE classificacao = 'pg-13' 
AND preco_da_locacao >2.40;

/*20- Listar a quantidade de filmes por classificação.*/
SELECT count(*), classificacao FROM filme 
GROUP BY classificacao; 

/*21- Listar, sem repetição, os preços de locação dos filmes cadastrados.*/
SELECT DISTINCT preco_da_locacao FROM filme;

/*22- Listar a quantidade de filmes por preço da locação.*/
SELECT count(titulo), preco_da_locacao from filme 
GROUP BY preco_da_locacao;

/*23- Listar os precos da locação que possuam mais de 340 filmes.*/
SELECT preco_da_locacao, count(titulo) FROM filme
GROUP BY preco_da_locacao
HAVING count(titulo) >340;

/*24- Listar os cliente_id ou primeiro_nome dos clientes com o valor total gastos em locações;*/
SELECT c.cliente_id, c.primeiro_nome, sum(p.valor) AS TotalValorAluguel FROM cliente c
JOIN pagamento p ON  c.cliente_id = p.cliente_id
GROUP BY c.cliente_id;

/*25- Listar os cliente_id ou primeiro_nome dos clientes com a média do valor gastos em locações;*/
SELECT c.cliente_id, c.primeiro_nome, AVG(p.valor) FROM pagamento p
JOIN cliente c ON p.cliente_id = c.cliente_id
GROUP BY c.cliente_id;

/*26- Listar o titulo dos filmes e número total de atores de cada filme;*/
SELECT f.titulo, count(a.ator_id) AS AtoresNoFilme FROM filme f
JOIN filme_ator fa ON f.filme_id  = fa.filme_id
JOIN ator a ON fa.ator_id = a.ator_id
GROUP BY f.titulo;

/*27- Listar o nome de todos os cliente e o número de filmes alugados por ele;*/
SELECT c.primeiro_nome, count(a.aluguel_id) AS FilmesAlugados FROM cliente c 
JOIN aluguel a ON c.cliente_id = a.cliente_id
GROUP BY c.primeiro_nome;

/*28- Listar o primeiro_nome dos clientes que alugaram mais que 10 filmes;*/
SELECT c.primeiro_nome, count(a.aluguel_id) AS FilmesAlugados FROM cliente c
JOIN aluguel a ON c.cliente_id = a.cliente_id
WHERE a.aluguel_id >10
GROUP BY c.primeiro_nome;

/*29- Listar primeiro_nome do cliente 50 e quantos filmes ele alugou;*/
SELECT c.primeiro_nome, count(a.aluguel_id) AS FilmesAlugados FROM cliente c
JOIN aluguel a ON  c.cliente_id = a.cliente_id 
WHERE c.cliente_id =50;

/*30- Listar o titulo dos filmes que possuem mais que 10 atores;*/
SELECT f.titulo, count(fa.ator_id) AS Atores FROM filme f 
JOIN filme_ator fa ON fa.ator_id = f.filme_id
GROUP BY f.titulo HAVING count(fa.ator_id) >10
ORDER BY count(fa.ator_id) DESC;

/*31- Listar os países que possuem mais que 15 cidades em seu cadastro.*/
SELECT p.pais, count(c.cidade_id) AS QuantidadePaises FROM pais p
JOIN cidade c ON p.pais_id = c.pais_id 
GROUP BY p.pais HAVING count(c.cidade_id) >15
ORDER BY count(c.cidade_id) DESC;

/*32- Primeiro fazer um média dos valores gastos por todos os clientes. Depois listar os nomes dos clientes que gastaram acima da média;*/
SELECT c.primeiro_nome, AVG(p.valor) AS media FROM cliente c
JOIN pagamento p ON c.cliente_id = p.cliente_id
GROUP BY c.cliente_id;

/*33- Listar as categorias que possuem mais de 60 filmes cadastrados.*/
SELECT c.nome, count(f.filme_id) AS Categotias_filme
FROM categoria c, filme f, filme_categoria fc
WHERE c.categoria_id = fc.categoria_id AND f.filme_id = fc.filme_id 
GROUP BY c.categoria_id
HAVING count(f.filme_id) >60;

/*34- Listar a quantidade de atores por filme ordenando por quantidade de atores crescente.*/
SELECT count(a.ator_id), f.titulo
FROM ator a, filme f, filme_ator fa
WHERE a.ator_id = fa.ator_id
AND f.filme_id = fa.filme_id
GROUP BY titulo
ORDER BY 2 ASC;

/*35- Listar a quantidade de atores para os filmes que possuem mais de 5 atores ordenando por quantidade de atores decrescente.*/
SELECT count(a.ator_id), f.titulo
FROM ator a, filme_ator fa, filme f
WHERE a.ator_id = fa.ator_id
AND f.filme_id = fa.filme_id
GROUP BY titulo 
HAVING count(a.ator_id) >5
ORDER BY 1 ASC;

/*36- Listar a quantidade de atores para os filmes que possuem mais de 5 atores ordenando por quantidade de atores decrescente.*/
SELECT count(a.ator_id), f.titulo
FROM ator a, filme_ator fa, filme f
WHERE a.ator_id = fa.ator_id
AND f.filme_id =  fa.filme_id
GROUP BY titulo
HAVING count(a.ator_id) > 5
ORDER BY 1 ASC;

/*37- Qual a quantidade de filmes por classificação e preço da locação?*/
SELECT count(titulo), classificacao, preco_da_locacao FROM filme
GROUP BY classificacao, preco_da_locacao;

/*38- Listar a quantidade de filmes por categoria.*/
SELECT count(f.titulo), c.nome
FROM filme f, filme_categoria fa, categoria c
WHERE f.filme_id= fa.filme_id
AND c.categoria_id = fa.categoria_id
GROUP BY c.categoria_id;

/*39- Listar a quantidade de filmes classificados como "G" por categoria.*/
SELECT count(f.titulo), c.nome
FROM filme f, filme_categoria fc, categoria c
WHERE f.filme_id = fc.filme_id
AND c.categoria_id = fc.categoria_id
AND f.classificacao ='G'
GROUP BY c.categoria_id;

/*40- Listar a quantidade de filmes classificados como "G" OU "PG" por categoria.*/
SELECT count(f.titulo), c.nome
FROM filme f, filme_categoria fc, categoria c
WHERE f.filme_id = fc.filme_id
AND c.categoria_id = fc.categoria_id
AND f.classificacao ='G' OR 'PG'
GROUP BY c.categoria_id;

/*41- Listar a quantidade de filmes por categoria e classificação.*/
SELECT count(f.titulo), c.nome, f.classificacao 
FROM filme f, filme_categoria fc, categoria c
WHERE f.filme_id = fc.filme_id
AND c.categoria_id = fc.categoria_id
GROUP BY c.categoria_id,  f.classificacao;

/*42- Qual a quantidade de filmes por Ator ordenando decrescente por quantidade?*/
SELECT count(f.titulo), a.primeiro_nome, a.ultimo_nome
FROM filme f, filme_ator fa, ator a
WHERE f.filme_id = fa.filme_id
AND a.ator_id = fa.ator_id
GROUP BY a.ator_id
ORDER BY 1 DESC;

/*43- Listar os anos de lançamento que possuem mais de 400 filmes?*/
SELECT ano_de_lancamento, count(f.titulo) as filmes FROM filme f
GROUP BY ano_de_lancamento
HAVING count(filme_id) >400;

/*44- Quais as cidades e seu pais correspondente que pertencem a um país que inicie com a Letra “E”?*/
SELECT c.cidade, p.pais FROM pais p, cidade c 
WHERE p.pais_id = c.pais_id
AND p.pais LIKE 'e%';

/*45- Qual a quantidade de filmes alugados por funcionario para cada categoria?*/
SELECT count(f.titulo), c.nome
FROM filme f, inventario i, aluguel a, funcionario fun, categoria c, filme_categoria fc
WHERE f.filme_id = i.filme_id
AND i.inventario_id = a.inventario_id
AND a.funcionario_id = fun.funcionario_id
AND c.categoria_id = fc.categoria_id
AND f.filme_id = fc.filme_id
GROUP BY c.categoria_id;

/*46. Qual a quantidade de filmes alugados por Clientes que moram na “Chile”?*/
SELECT c.primeiro_nome, count(f.titulo) as filmes, p.pais
FROM filme f, inventario i , aluguel a, cliente c , endereco e, cidade ci, pais p
WHERE f.filme_id = i.filme_id
AND i.inventario_id = a.inventario_id
AND a.cliente_id = c.cliente_id
AND c.endereco_id = ci.cidade_id
AND ci.pais_id = p.pais_id
AND p.pais='CHILE'
GROUP BY 1;

/*47- Quais os atores do filme “BLANKET BEVERLY”?*/
SELECT a.primeiro_nome , a.ultimo_nome FROM filme f, filme_ator fa, ator a
WHERE f.filme_id = fa.filme_id
AND a.ator_id = fa.ator_id AND f.titulo ='BLANKET BEVERLY';

/*48- Quais os clientes moram no país “United States”?*/
SELECT c.primeiro_nome FROM cliente c, pais p, cidade ci, endereco e
WHERE p.pais_id = ci.pais_id
AND ci.CIDADE_ID = e.CIDADE_ID
AND e.ENDERECO_ID = C.ENDERECO_ID
AND P.PAIS = 'UNITED STATES';

/*49- Qual a quantidade de clientes por pais?*/
SELECT COUNT(c.cliente_id), p.pais
FROM cliente c, pais p, cidade ci, endereco e
WHERE c.endereco_id = e.endereco_id
AND e.cidade_id = ci.cidade_id
AND ci.pais_id = p.pais_id
GROUP BY p.pais;

/*50- Qual o total pago por classificação de filmes alugados no ano de 2006?*/
SELECT sum(p.valor) as valor, f.classificacao
FROM filme f, inventario i, aluguel a, pagamento p
WHERE f.filme_id = i.filme_id
AND i.inventario_id = a.inventario_id
AND a.aluguel_id = p.aluguel_id
AND YEAR(A.data_de_aluguel)= '2006'
GROUP BY f.classificacao;

/*51- Quais cidades _do 'Brazil' estão
cadastradas _no sistema?*/
SELECT cidade.cidade FROM cidade, pais
WHERE cidade.pais_id = pais.pais_id
AND pais.pais = 'Brazil'

/*52- Liste o nome dos clientes,
a cidade e o pais onde moram.*/
SELECT primeiro_nome, ultimo_nome, cidade.cidade, pais.pais 
FROM cliente , endereco, cidade, pais
WHERE cidade.pais_id = pais.pais_id
AND cliente.endereco_id = 
endereco.endereco_id
AND endereco.cidade_id = 
cidade.cidade_id
AND cidade.pais_id = pais.pais_id;

/*53- Liste o titulo _do filme e sua(s) respectiva(s) categoria(s)*/
SELECT filme.titulo, categoria.nome
FROM filme, filme_categoria, categoria
WHERE filme.filme_id = 
filme_categoria.filme_id
AND categoria.categoria_id = 
filme_categoria.categoria_id
ORDER BY filme.titulo

/*54- Quais atores trabalharam _no filme 'ADAPTATION HOLES'?*/
SELECT ator.primeiro_nome, ator.ultimo_nome
FROM filme, filme_ator, ator
WHERE filme.filme_id = 
filme_ator.filme_id
AND ator.ator_id = 
filme_ator.ator_id
AND filme.titulo = 'ADAPTATION HOLES';

/*55- Quais filmes o ator 'ED CHASE' trabalhou?*/
SELECT filme.titulo
FROM filme, filme_ator, ator
WHERE filme.filme_id = 
filme_ator.filme_id
AND ator.ator_id = 
filme_ator.ator_id
AND ator.primeiro_nome = 'ED'
AND ator.ultimo_nome='CHASE';



/* SUBCONSULTAS///////////////////////////////////////////////////////////////////////////////////////////////////*/

/*56- Listar os nomes das cidades que não estão sendo utilizadas na tabela endereço;*/
SELECT c.cidade FROM cidade c 
WHERE c.cidade_id NOT IN
(SELECT e.cidade_id FROM endereco e);

/*57- Lista os nomes dos países que não estão sendo utilizados na tabela cidade;*/
SELECT p.pais FROM pais p 
WHERE p.pais_id NOT IN
(SELECT c.pais_id FROM cidade c);

/*58- Listar os nomes dos filmes que não foram alugados nenhuma vez;*/
SELECT f.titulo FROM filme f
JOIN inventario i ON f.filme_id = i.filme_id
WHERE i.inventario_id NOT IN 
(SELECT a.inventario_id FROM aluguel a);

/*59 Lista as categorias de filmes que não estão sendo usadas;*/
SELECT c.nome FROM categoria c
JOIN filme_categoria fc ON c.categoria_id = fc.categoria_id
WHERE  fc.filme_id NOT IN
(SELECT f.filme_id FROM filme f);

/*60- Lista o primeiro nome dos clientes que gastaram o mesmo valor ou mais que o cliente 350
 entre as datas 2005-05-01 e 2005-05-30;*/
SELECT c.primeiro_nome FROM cliente c
JOIN pagamento p ON c.cliente_id = p.cliente_id
GROUP BY c.cliente_id HAVING sum(p.valor)>=
(SELECT sum(p.valor)FROM cliente c
JOIN pagamento p ON c.cliente_id = p.cliente_id
WHERE data_de_pagamento BETWEEN('2005-05-01') AND ('2005-05-30')
AND c.cliente_id = 350);

/*61- Listar os idiomas dos filmes locados pelo cliente 330;*/
SELECT id.nome FROM idioma id
JOIN filme f ON id.idioma_id = f.idioma_id 
JOIN inventario i ON f.filme_id = i.filme_id
WHERE i.inventario_id IN
(SELECT a.inventario_id FROM aluguel a 
JOIN cliente c ON a.cliente_id = c.cliente_id
WHERE c.cliente_id = '330')
GROUP BY id.nome;

/*62- Listar os títulos do filmes quem tem o mesmo idioma do filme de filme_id = 150;*/
SELECT f.titulo FROM filme f
JOIN idioma i ON f.idioma_id = i.idioma_id
WHERE i.idioma_id IN
(SELECT i.idioma_id FROM idioma i 
JOIN filme f ON i.idioma_id = f.idioma_id
WHERE f.filme_id = 150);

/*63- Listar o primeiro_nome dos clientes que moram na mesma cidade que o cliente 450;*/
SELECT c.primeiro_nome FROM cliente c
JOIN endereco e ON c.endereco_id = e.endereco_id
WHERE e.endereco_id IN 
(SELECT e.endereco_id FROM endereco e
JOIN cliente c ON e.endereco_id = c.endereco_id
WHERE cliente_id = 450);

/*64- Listar o primeiro_nome dos clientes que gastaram mais que o cliente 300;*/
SELECT c.primeiro_nome FROM cliente c
JOIN pagamento p ON c.cliente_id = p.cliente_id
GROUP BY c.primeiro_nome HAVING sum(p.valor)>
(SELECT sum(p.valor) FROM cliente c
JOIN pagamento p ON c.cliente_id = p.cliente_id
WHERE c.cliente_id = 300);

/*65- Listar os anos de lançamento dos filmes que possuem mais de 100 filmes com preço da locação maior que a média do preço da locação dos filmes da categoria "Children"?*/
SELECT f.ano_de_lancamento, count(f.titulo) as filmes
FROM filme f, filme_categoria fc, categoria c
WHERE f.filme_id = fc.filme_id
AND c.categoria_id = fc.categoria_id
AND f.preco_da_locacao > (SELECT AVG(f.preco_da_locacao) FROM filme f, filme_categoria fc, categoria c 
WHERE f.filme_id = fc.filme_id AND c.categoria_id = fc.categoria_id AND c.nome ='CHILDREN')
GROUP BY f.ano_de_lancamento
HAVING count(f.filme_id) > 100;

/*66-Liste o titulo dos filmes com preco da locacao acima da média*/
SELECT titulo FROM filme
WHERE preco_da_locacao > 
(SELECT AVG(preco_da_locacao) 
FROM filme)

/*67- Liste o titulo dos filmes com
maior duracao da locacao*/
SELECT titulo FROM filme
WHERE duracao_do_filme = ( 
SELECT MAX(duracao_do_filme) FROM filme);

/*68- Liste o titulo dos filmes com
menor custo de substituicao*/
SELECT titulo FROM filme
WHERE custo_de_substituicao = 
(SELECT MIN(custo_de_substituicao)
FROM filme);


/* VIEW ///////////////////////////////////////////////////////////////////////////////////////////////////*/

/*69- Criar uma view com primeiro_nome Cliente e Cidade que mora;*/
create view cliente_cidade_vw as 
select cli.primeiro_nome as cliente,
c.cidade as cidade from cliente cli
join endereco e on cli.endereco_id = e.endereco_id
join cidade c on e.cidade_id = c.cidade_id;

select * from cliente_cidade_vw;

/*70- Criar uma view com titulo Filme e Categoria;*/
create view titulo_filme_categoria_vw as
select f.titulo as filme, c.nome as categoria from filme f
join filme_categoria fc on f.filme_id = fc.filme_id
join categoria c on fc.categoria_id = c.categoria_id;

select * from titulo_filme_categoria_vw;

/*71- Criar uma view primeiro_nome Cliente e média de filmes alugados por ele;*/
create view nomeC_Media_vw as 
select c.primeiro_nome, count(aluguel_id) from cliente c
join aluguel a on c.cliente_id = a.cliente_id
group by c.cliente_id;

select * from nomeC_Media_vw;

/*72- Criar uma view com dados do cliente primeiro_nome, cliente_id, endereco, endereco_id,
cidade e cidade_id, depois utilizar a view para consultar o primeiro_nome dos clientes que
moram na mesma cidade que o cliente 400;*/
create view dados_clientesCidades_vw as
select cli.primeiro_nome, cli.cliente_id, e.endereco_id, c.cidade, c.cidade_id from cliente cli
join endereco e on e.endereco_id = cli.endereco_id
join cidade c on c.cidade_id = e.cidade_id;

select primeiro_nome from dados_clientesCidades_vw 
where cidade_id in (select cidade_id from dados_clientesCidades_vw where cliente_id = 400);

/*73- Criar uma view com dados do filme, titulo, filme_id, ator e ator_id. Depois utilizar a view
para consultar o titulo dos filmes que tem pelo menos um ator do filme 'WYOMING STORM.*/
create view filme_ator_vw as
select a.primeiro_nome , a.ultimo_nome, a.ator_id, f.titulo from ator a
join filme_ator fa on fa.ator_id = a.ator_id
join filme f on f.filme_id = fa.filme_id;

select titulo from filme_ator_vw
where ator_id in (select ator_id from filme_ator_vw where titulo ='WYOMING STORM');


/* FUNÇOES BASICAS/////////////////////////////////////////////////////////////////////////////////////////////////*/
SET GLOBAL log_bin_trust_function_creators = 1;  /* Codigo se caso na rodar*/

/*74- Criar uma função que soma;*/
create function soma_fn(a int, b int)
returns int
return a+b;
select soma_fn(5,6);

/*75- Criar uma função que multiplica;*/
create function multiplicacao_fn(a int,b int)
returns int
return a*b;
select multiplicacao_fn(2,10);

/*76- Criar uma função que subtração;*/
create function subtracao_fn(a int,b int)
returns int
return a-b;
select subtracao_fn(20,8);

/*77- Utilizar a função soma para aumenta o valor do filme preco_da_locacao(select);*/
create function soma_fn(a int,b int)
returns int
return a+b;

select titulo, soma_fn(preco_da_locacao, 50) from filme;

/*78- Utilizar a função soma para aumenta o valor do filme preco_da_locacao filme_id 100(update);*/
create function soma_fn(a int,b int)
returns int
return a+b;

update filme f
set preco_da_locacao = soma_fn(preco_da_locacao, 4)
where f.filme_id = 100;

/*79- Criar uma função, que considera a entrada de um parâmetro inteiro N, utilizando esse
parâmetro N retornar o titulo do filme correspondente;*/
create function titulo(n int)
returns varchar(20)
return ( select f.titulo from filme f
where f.filme_id = n);
        
select titulo(10);

/*80- Criar uma função, que considera a entrada de um parâmetro inteiro N, utilizando esse
parâmetro N retornar o nome da categoria correspondente;*/
create function Categoria(n int)
returns varchar(20)
return ( select c.nome from categoria c
where c.categoria_id = n);
        
select Categoria(1);