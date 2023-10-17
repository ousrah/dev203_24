select q6(id_dep), current_date(), upper('bonjour') from departement;


select * from departement where id_dep=2;
select * from employe where id_dep=2;

drop procedure if exists p1;
delimiter $$
create procedure p1(i int)
begin
	select * from departement where id_dep=i;
	select * from employe where id_dep=i;
end $$
delimiter ;

call p1(2);



drop procedure if exists p1;
delimiter $$
create procedure p2(in i int)
begin
	select * from departement where id_dep=i;
	select * from employe where id_dep=i;
end $$
delimiter ;

call p1(2);



drop procedure if exists p3;
delimiter $$
create procedure p3(in a int, in b int)
begin
	select a+b;
end $$
delimiter ;

call p3(3,5);



drop procedure if exists p4;
delimiter $$
create procedure p4(in a int, in b int, out r int)
begin
	set r =  a+b;
end $$
delimiter ;

call p4(3,5,@somme);
select @somme;



drop procedure if exists p5;
delimiter $$
create procedure p5(in a int, in b int, out r int, out mult int)
begin
	set r =  a+b;
    set mult = a*b;
end $$
delimiter ;

call p5(3,5,@somme,@multiplication);

select @somme;
select @multiplication;




drop procedure if exists p6;
delimiter $$
create procedure p6(in a int, 
					in b int, 
                    out r int, 
                    out mult int, 
                    inout coef int)
begin
	set r =  (a+b)*coef;
    set mult = (a*b)*coef;
    set coef = 1;
end $$
delimiter ;

set @c = 2;
call p6(3,5,@somme,@multiplication,@c);
select @somme;
select @multiplication;
select @c;


