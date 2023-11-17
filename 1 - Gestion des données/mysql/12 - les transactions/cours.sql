drop database if  exists bank_203;
create database if not exists bank_203 collate utf8mb4_general_ci;
use bank_203;


drop table if exists account;
create table account (
account_number varchar(50) primary key ,
funds decimal(8,2),
check (funds>=0),
check (funds<=50000));

insert into account values ('acc1',30000);
insert into account values ('acc2',40000);

select * from account;
update account set funds = funds - 10000 where account_number = 'acc1';
update account set funds = funds + 10000 where account_number = 'acc2';
select * from account;

update account set funds = funds - 10000 where account_number = 'acc1';
update account set funds = funds + 10000 where account_number = 'acc2';
select * from account;


drop procedure if exists virement;
delimiter $$
create procedure virement(ac1 varchar(50),ac2 varchar(50), amount float)
begin
	update account set funds = funds - amount where account_number = ac1;
	update account set funds = funds + amount where account_number = ac2;
end$$
delimiter ;


select * from account;
call virement('acc1','acc2',10000);
select * from account;
call virement('acc1','acc2',10000);
select * from account;



drop procedure if exists virement;
delimiter $$
create procedure virement(ac1 varchar(50),ac2 varchar(50), amount float)
begin

	declare EXIT handler for sqlexception 
		begin
			select "virement impossible" as msg;
		end;
	update account set funds = funds - amount where account_number = ac1;
	update account set funds = funds + amount where account_number = ac2;
    select "virement effectué avec succes" as msg;
    
end$$
delimiter ;


select * from account;
call virement('acc1','acc2',10000);
select * from account;
call virement('acc1','acc2',10000);
select * from account;



drop procedure if exists virement;
delimiter $$
create procedure virement(ac1 varchar(50),ac2 varchar(50), amount float)
begin

	declare EXIT handler for sqlexception 
		begin
			select "virement impossible" as msg;
            rollback;
		end;
    start transaction;
		update account set funds = funds - amount where account_number = ac1;
		update account set funds = funds + amount where account_number = ac2;
		select "virement effectué avec succes" as msg;
	commit;
end$$
delimiter ;


select * from account;
call virement('acc1','acc2',5000);
select * from account;
call virement('acc1','acc2',10000);
select * from account;
call virement('acc2','acc1',10000);
select * from account;




