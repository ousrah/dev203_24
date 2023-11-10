use vols_203;

select * from pilote;
select * from vol;
delete from vol;

drop procedure if exists create_vols;
delimiter $$
create procedure create_vols(vd varchar(50), va varchar(50), av int)
begin
	declare flag boolean default false;
    declare np int;
	declare c1 cursor for select numpilote from pilote;
    declare continue handler for not found set flag = true;
    open c1;
		b1: loop
				fetch c1 into np;
                if flag then
					leave b1;
				else
					insert into vol value (null,vd, va, current_date(),current_date(),np,av);
                end if;
		end loop b1;
    close c1;

end$$
delimiter ;

select * from vol;
call create_vols ('tetouan','casa',1);
/*
Exercice 0
refaire l'exemple du cours.

Exercice 1 
pour chaque pilote on souhaite ajouter un vol de sa ville de résidence à une 
ville passée en paramètre sur un avion passé en paramètre dans la date du jour.

Exercice 2
pour chaque pilote on souhaite ajouter un vol de sa ville de résidence à une 
ville passée en paramètre sur chaqune des  avions de la base de données.

*/

