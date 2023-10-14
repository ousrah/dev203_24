use librairie_201;
drop function if exists dateff;
delimiter &&
create function dateff( dateP varchar(50))
returns varchar(50)
deterministic
begin
    return date_format(str_to_date(dateP,"%d/%m/%Y"),"%d %M %Y");
end &&
delimiter ;


drop function if exists dateff;
delimiter &&
create function dateff( dateP varchar(50))
returns varchar(50)
deterministic
begin
 declare day int default day(str_to_date(dateP,"%d/%m/%Y"));
 declare year int default year(str_to_date(dateP,"%d/%m/%Y"));
 declare month int default month(str_to_date(dateP,"%d/%m/%Y"));
 declare name varchar(50) default case month
 when 1 then ' Janvier '
 when 2 then ' Favrier '
 when 3 then ' Mars '
 when 4 then ' Avril '
 when 5 then ' Mai '
 when 6 then ' Juin '
 when 7 then ' Juillet '
 when 8 then ' Aout '
 when 9 then ' Septembre '
 when 10 then ' Octobre '
 when 11 then ' Novembre '
 when 12 then ' Decembre '
  
 end;
    return concat (day, name, year);
end &&
delimiter ;


select dateff("12/01/2011 ") as date;

#exercice2

drop function if exists CalculerEcartEntreDates;
DELIMITER $$

CREATE FUNCTION CalculerEcartEntreDates(date1 DATETIME, date2 DATETIME, unite VARCHAR(10))
RETURNS varchar(50)
deterministic
BEGIN
    DECLARE ecart varchar(50);
    IF unite = 'jour' THEN
        SET ecart = TIMESTAMPDIFF(day, date1, date2);
    ELSEIF unite = 'mois' THEN
        SET ecart = TIMESTAMPDIFF(month, date1, date2);
    ELSEIF unite = 'annee' THEN
        SET ecart = TIMESTAMPDIFF(year, date1, date2);
    ELSEIF unite = 'heure' THEN
        SET ecart = TIMESTAMPDIFF(HOUR, date1, date2);
    ELSEIF unite = 'minute' THEN
        SET ecart = TIMESTAMPDIFF(MINUTE, date1, date2);
    ELSEIF unite = 'seconde' THEN
        SET ecart = TIMESTAMPDIFF(SECOND, date1, date2);
    ELSE
        SET ecart = "erreur"; 
    END IF;

    RETURN ecart;
END $$

DELIMITER ;

select CalculerEcartEntreDates("1999-8-7","1999-9-10","mois");

select if(1=0,"egale",if(2=3,"deux","trois"));


/*
Pilote(numpilote,nom,titre,villepilote,daten,datedebut)
Vol(numvol,villed,villea,dated,datea, #numpil,#numav)
Avion(numav,typeav ,capav)
*/
drop database if exists vols_203;

create database vols_203 collate utf8mb4_general_ci;
use vols_203;

create table Pilote(numpilote int auto_increment primary key,
nom varchar(50) ,
titre varchar(50) ,
villepilote varchar(50) ,
daten date,
datedebut date);

create table Vol(numvol int auto_increment primary key,
villed varchar(50) ,
villea varchar(50) ,
dated date ,
datea date , 
numpil int not null,
numav int not null);

create table Avion(numav int auto_increment primary key,
typeav  varchar(50) ,
capav int);

alter table vol add constraint fk_vol_pilote foreign key(numpil) references pilote(numpilote);
alter table vol add constraint fk_vol_avion foreign key(numav) references avion(numav);


insert into avion values (1,'boeing',350),
						(2,'caravel',50),
                        (3,'airbus',500);


insert into avion values (4,'test',350);
insert into pilote values (1,'hassan','M.','tetouan','2000-01-01','2022-01-01'),
						(2,'saida','Mme.','casablanca','1980-01-01','2005-01-01'),
						(3,'youssef','M.','tanger','1983-01-01','2002-01-01');



update pilote set datedebut = '2002-01-01' where numpilote = 2;
insert into vol values (1,'tetouan','casablanca','2023-09-10','2023-09-10',1,1),
						(2,'casablanca','tetouan','2023-09-10','2023-09-10',1,1),
						(3,'tanger','casablanca','2023-09-11','2023-09-11',2,2),
						(4,'casablanca','tanger','2023-09-11','2023-09-11',2,2),
						(5,'agadir','casablanca','2023-09-11','2023-09-11',3,3),
						(6,'casablanca','agadir','2023-09-11','2023-09-11',3,3);


insert into vol values (7,'tetouan','casablanca','2023-09-10','2023-09-12',1,1),
						(8,'casablanca','tetouan','2023-09-10','2023-09-12',1,1),
						(9,'tanger','casablanca','2023-09-11','2023-09-13',1,2),
						(10,'casablanca','tanger','2023-09-11','2023-09-13',1,2),
						(11,'agadir','casablanca','2023-09-11','2023-09-13',3,3),
						(12,'casablanca','agadir','2023-09-11','2023-09-13',3,3);
                        
                        
  insert into vol values (13,'tetouan','casablanca','2023-09-10','2023-09-15',2,1),
						(14,'casablanca','tetouan','2023-09-10','2023-09-15',3,1);                      

delete from vol where numvol = 13;
#1.	Ecrire une fonction qui retourne le nombre de pilotes 
#ayant effectué un nombre de vols supérieur à un nombre donné comme paramètre ;

drop function if exists e1;
delimiter $$
create function e1(n int)
	returns int
    reads sql data
begin
	declare r int;
    set r = (select count(*) from 
		(select count(numvol) nbvols, numpil 
		from vol
		group by numpil
		having count(numvol)>1) f);
    return r;
end $$
delimiter ;

select e1(5);






#2.	Ecrire une fonction qui retourne la durée de travail d’un pilote 
#dont l’identifiant est passé comme paramètre ;
drop function if exists e2;
delimiter $$
 create	function e2(pilote_id INT)
 returns int
 reads sql data
 begin
 declare duree int;
	SELECT timestampdiff(year,current_date, datedebut) INTO duree
		FROM Pilote
		WHERE numpilote = pilote_id;
    RETURN abs(duree);
 end $$
 delimiter ;

select e2(1);



2022/12/10


2023/01/10

380

select floor(380/365) = 1
select floor((380%365)/30)
select ((380%365)%30)



DROP FUNCTION IF EXISTS e2;
DELIMITER $$
CREATE FUNCTION e2(pilote_id INT)
RETURNS VARCHAR(255)
READS SQL DATA
begin
    declare duree,years,months,days int;
    declare result varchar(50);
    
    set duree = (select abs(timestampdiff(day, current_date, datedebut)) from pilote where numpilote =  pilote_id);

    set years =  floor(duree/365);
	set months =  floor((duree%365)/30);
	set days =  ((duree%365)%30);

    set result = concat(years, ' year(s) ', months, ' month(s) ',days, ' day(s)'); 
    return result;
end $$

DELIMITER ;

select e2(3);

#3.	Ecrire une fonction qui renvoie le nombre des avions qui ne sont pas affectés à des vols ;


drop function if exists e3;
delimiter $$
create function e3( )
returns int 
reads sql data
begin 
   # return (select count(*) from avion where numav not in(select numav from vol));
	return(select count(*) 
			from avion a 
            left join vol v on a.numav = v.numav 
            where v.numvol is null);
end ;
$$
delimiter ;





select e3();

#4.	Ecrire une fonction qui retourne le numero du plus ancien 
#pilote qui a piloté l’avion dont le numero est passé en paramètre ;





drop function if exists e4;
delimiter $$
create function e4( avion_id int)
returns int 
reads sql data
begin  #ne marche pas si la requete retourn plusieurs lignes
 return (select numpilote  from pilote p
			join vol v on p.numpilote = v.numpil
			where v.numav = avion_id
 and  datedebut in (
			select distinct min(datedebut)
			from pilote p
			join vol v on p.numpilote = v.numpil
			where v.numav = avion_id));
end ;
$$
delimiter ;



select e4(1);



#5.	Ecrire une fonction table qui retourne le nombre des pilotes dont le salaire est inférieur à une valeur passée comme paramètre ;



