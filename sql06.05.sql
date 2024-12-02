create database pokemon;

create table pokemon (
	index int,
	name varchar (250),
	type1 varchar (250),
	type2 varchar (250),
	total int,
	HP int,
	attack int,
	defense int,
	sp_atk int,
	sp_def int,
	speed int,
	generation int,
	legandary varchar (6)
);
drop table pokemon

select * from pokemon

copy pokemon from 'C:/Program Files/PostgreSQL/15/data/Pokemon.csv' delimiter ',' csv header;

alter table pokemon drop column index;

--1. Hangi tipten kaç adet Pokemon olduğunu göster.

select "type1" , count(*) as tipe_göre_pokemon_sayısı from pokemon
group by "type1"
order by tipe_göre_pokemon_sayısı desc;

-- kodu çalıştırdığımızda ''type1'' e göre kaç farklı pokemon olduğunu göebiliriz.

--2.Tiplerin total güçlere göre sıralaması yap en güçlü tipi bul.

select name, type1, total from pokemon
order by total desc;

select "type", sum(total) as total_güç from (
		select "type1" as "type" , total from pokemon
		union all 
		select "type2" as "type" , total from pokemon where "type2" is not null
) as types
	group by "type"
	order by total_güç desc;
	
-- kodu çalıştırdğımızda ''water'' tip pokemonların diğerlerine göre en güçlü olduğunu görüyoruz.
		
select * from pokemon

SELECT generation, SUM(speed) AS total_speed 
FROM pokemon
group by generation
order by total_speed desc;


select "type" , sum ("hp") as total_hp from (
		select "type1" as "type", total from pokemon
		union all
		select "type2" as "type", total from pokemon where "type2" is not null
) as types 
	group by "type"  (((çalışmadı)))
	
	
SELECT "type1" AS "type", SUM("hp") AS total_hp
FROM pokemon
GROUP BY "type1"
UNION ALL
SELECT "type2" AS "type", SUM("hp") AS total_hp
FROM pokemon
WHERE "type2" IS NOT NULL
GROUP BY "type2";
	order by total_hp desc;
	
	SELECT "type", SUM("hp") AS total_hp
FROM (
    SELECT "type1" AS "type", "hp" FROM pokemon
    UNION ALL
    SELECT "type2" AS "type", "hp" FROM pokemon WHERE "type2" IS NOT NULL
) AS types
GROUP BY "type"
ORDER BY total_hp DESC;

select * from pokemon

-- 3. Generationa göre en hızlı ve en yavaş pokemonları bul.

SELECT
    Generation,
    MAX(Speed) AS Max_Speed,
    MIN(Speed) AS Min_Speed
FROM
    Pokemon
GROUP BY
    Generation;
	
WITH MAXSPEED AS (
SELECT GENERATION,
	MAX(SPEED) AS MAX_SPEED
FROM POKEMON
GROUP BY GENERATION
),
MinSpeed as (select generation,
			min(speed) as min_speed
	from pokemon
	group by generation
) 
select
p.generation,
p.name as fastest_pokemon,
m.max_speed as fastest_speed,
p2.name as slowest_pokemon,
m2.min_speed as slowest_speed
 from
pokemon p
join MaxSpeed m on p.generation = m.generation and p.speed=m.Max_speed
join pokemon p2 on p.generation = p2.generation
join minspeed m2 on p2.generation = m2.generation and p2.speed =m2.min_speed
order by 
p.generation;

--------------------------------------------------------------------------
SELECT column_name
FROM information_schema.columns
WHERE table_name = 'pokemon';

((sütun isimlerini gösteren kod))

--4. Legandary olan en güçlü en zayıf ve legandary olmayan en güçlü en zayıf pokemonları bul görselleştir
select * from pokemon
where legandary = 'True'
order by total desc
limit 1;

-- bu kodu çalıştırdığımızda legandary olan pokemonları en güçlü olandan en zayıf olana doğru sıralanmış bir şekilde görüyoruz
-- limit 1 komutu ile ise 1. sıradaki pokemonu getiriyoruz.

--şimdi bu sıralamanın tersini yaparak en zayıfı bulalaım.
select * from pokemon
where legandary = 'True'
order by total asc
limit 1;

-- buna göre ise en zayıf legandary pokemon "Azelf"

--5. Generationdan bağımsız en hızlı ve en yavaş pokemonları göster
-- en hızlı 
select * from pokemon
order by speed desc
limit 1;

-- en yavaş

select* from pokemon
order by speed asc
limit 1;

bitti :)😊