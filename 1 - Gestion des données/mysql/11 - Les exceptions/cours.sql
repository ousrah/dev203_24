drop database if exists test_203;
create database test_203 collate utf8mb4_general_ci;
drop table if exists test;

create table test (
	id int auto_increment primary key, 
	nom varchar(50) not null unique);

insert into test(nom) values ('iam');
insert into test(nom) values (null);
insert into test(nom) values ('orange');
insert into test(nom) values ('orange');

drop procedure if exists test_insert;
delimiter $$
create procedure test_insert(n varchar(50))
begin
	declare exit handler for 1062 select 'ce nom existe deja' as msg;
	declare exit handler for 1048 select 'le nom ne peut pas être null' as msg;
	insert into test(nom) values (n);
end $$
delimiter ;

call test_insert('test');

drop procedure if exists test_insert;
delimiter $$
create procedure test_insert(n varchar(50))
begin
	declare flag boolean default false;
    begin
		declare exit handler for 1062 set flag = true;
        declare exit handler for 1048 set flag = true;
		insert into test(nom) values (n);       
	end;
    if flag then
		select("erreur d'insertion");
    end if;
end $$
delimiter ;

call test_insert(null);




drop procedure if exists test_insert;
delimiter $$
create procedure test_insert(n varchar(50))
begin
	declare msg varchar(150) default "";
    begin
		declare exit handler for 1062 set msg ="le nom doit être unique";
        declare exit handler for 1048 set msg ="le nom ne peut pas être null";
		insert into test(nom) values (n);       
        select 'insertion effectuée avec succes' as msg;
	end;
    if msg!="" then
		select msg as msg;
    end if;
end $$
delimiter ;

call test_insert('iam5566');






drop procedure if exists test_insert;
delimiter $$
create procedure test_insert(n varchar(50))
begin
	declare flag  boolean default false;
    declare v_errno int;
    declare v_msg varchar(200);
    declare v_sqlstate varchar(5);
    begin
		declare exit handler for sqlexception
			begin
				get diagnostics condition 1 
					v_sqlstate = returned_sqlstate,
                    v_errno = mysql_errno,
                    v_msg = message_text;
				set flag = true;
            end;
		insert into test(nom) values (n);       
        select 'insertion effectuée avec succes' as msg;
	end;
    if  flag then
		case v_errno
			when 1062 then select "ce nom existe deja" as msg;
			#when 1048 then select "le nom ne peut pas être null" as msg;
			else select concat(v_errno , ' ', v_sqlstate, ' ' , v_msg);
        end case;
    end if;
end $$
delimiter ;


call test_insert(null);

select * from test;

drop procedure if exists get_name_by_id;
delimiter $$
create procedure get_name_by_id( i int, out n varchar(50))
begin
	declare flag boolean default false;
    declare v_errno int;
    declare v_sqlstate varchar(20);
    declare v_msg varchar(200);
     begin
		declare exit handler for not found
			begin
				get diagnostics condition 1 
					v_sqlstate = returned_sqlstate,
                    v_errno = mysql_errno,
                    v_msg = message_text;
				set flag = true;
            end;
		select nom into n from test where id = i;       
	end;
	if flag then
		select "introuvable" as msg;
	end if;
end$$
delimiter ;


drop procedure if exists set_text_to_number;
delimiter $$
create procedure set_text_to_number(a varchar(20))
begin
	declare flag boolean default false;
    declare x boolean;
    begin
		declare exit handler for 1048, sqlstate 'HY000' ,sqlstate '01000' set flag = true;
		set x = a;
        select concat('x=',x);
    end;
    if flag then
		select 'erreur de conversion' as msg;
    end if;
end $$
delimiter ;
call set_text_to_number("true");



drop procedure if exists divi;
delimiter $$
	create procedure divi(a int, b int)
		begin
			declare x float;
            declare flag boolean default false;
			declare v_errno int;
			declare v_sqlstate varchar(20);
			declare v_msg varchar(200);
            begin
				declare exit handler for sqlexception
				begin
					get diagnostics condition 1 
						v_sqlstate = returned_sqlstate,
						v_errno = mysql_errno,
						v_msg = message_text;
					set flag = true;
				end;
				if b=0 then
					signal sqlstate '23000' set mysql_errno = 1000 , message_text = 'division par zero impossible';
				end if;
				set x = a / b ;
				select x;
            end;
            if flag then
				select concat(v_errno, ' ', v_sqlstate,' ', v_msg) as msg;
            end if;
        end $$
delimiter ;
call divi(3,0);



drop procedure if exists divi2 ;
delimiter $$
create procedure divi2 (a int, b int, out r float)
begin
	declare division_par_zero condition for sqlstate '22012';
	declare continue handler for division_par_zero
    resignal set message_text = "il faut pas diviser par zero";
	if b=0 then
		signal division_par_zero;
    else
		set r = a/b;
    end if;
end $$
delimiter ;

call divi2(6,0,@r);
select @r;


