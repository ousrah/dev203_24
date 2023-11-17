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
*/
/*Exercice 1 
pour chaque pilote on souhaite ajouter un vol de sa ville de résidence à une 
ville passée en paramètre sur un avion passé en paramètre dans la date du jour.
*/

drop procedure if exists ex1 ;
delimiter $$
create procedure ex1( va varchar(50), av int )
begin 
	declare flag boolean default false ;
    declare vres varchar(50);
    declare np int ;
    declare c2 cursor for select numpilote , villepilote from pilote;
    declare continue handler for not found set flag = true;
    open c2 ;
		b2 :loop 
			fetch c2 into np , vred ;
            if flag then 
				leave b2;
			else 
				insert into vol values (null,vres, va, current_date(),current_date(), np , av);
			end if ;
        end loop b2;
    close c2;
end $$
delimiter ;
call ex1('tetouan' , 2);



/*Exercice 2
pour chaque pilote on souhaite ajouter un vol de sa ville de résidence à une 
ville passée en paramètre sur chaqune des  avions de la base de données.

*/


drop procedure if exists ex2 ;
delimiter $$
create procedure ex2( vd varchar(50))
begin 
	declare flag boolean default false ;
    declare vp varchar(50);
    declare np int ;
    declare na int;
    
    declare c2 cursor for select p.numpilote , p.villepilote, a.numav from pilote p join avion a ;
    
    declare continue handler for not found set flag = true;
    open c2 ;
		b2 :loop 
			fetch c2 into np , vp,na ;
            if flag then 
				leave b2;
			else 
				insert into vol values (null,vp, vd, current_date(),current_date(), np , na);
			end if ;
        end loop b2;
    close c2;
end $$
delimiter ;
call ex2('merrakech');
select * from vol;


drop procedure if exists ex2 ;
delimiter $$
create procedure ex2( vd varchar(50))
begin 
    declare vp varchar(50);
    declare np int ;
    
	declare flag1 boolean default false ;
    declare c1 cursor for select numpilote, villepilote from pilote;
    declare continue handler for not found set flag1 = true;
    open c1 ;
		b1 :loop 
			fetch c1 into np, vp ;
            if flag1 then 
				leave b1;
			else
				begin
					declare na int;
					declare flag2 boolean default false ;
					declare c2 cursor  for select numav from avion;
                    declare continue handler for not found set flag2=true;
                    open c2;
                        b2:loop
							fetch c2 into na;
							if flag2 then 
								leave b2;
                            else
								insert into vol values (null,vp, vd, current_date(),current_date(), np , na);
                            end if;
                        end loop b2;
                    close c2;
				end;
			end if ;
        end loop b1;
    close c1;
end $$
delimiter ;
call ex2('merrakech');
select * from vol;
delete from vol;