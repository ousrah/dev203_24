use vols_203;

select * from vol;
alter table pilote 
add column nbhv time default '00:00:00';


alter table vol modify dated datetime;
alter table vol modify datea datetime;

drop trigger if exists q1;
delimiter $$
create trigger q1 after insert on vol for each row
begin
	
        update pilote set nbhv=nbhv+timediff(new.datea,new.dated) where  numpilote=new.numpil;

end

$$
delimiter ;
select * from vol;
insert into vol values(16,'tetouan','casa blanca','2023-11-20 11:00:00','2023-11-20 15:30:00',1,2);
select * from pilote;

drop trigger if exists q2;
delimiter $$
	create trigger q2 after delete on vol for each row
    begin
		update pilote set nbhv = nbhv - timediff(old.datea,old.dated) where  numpilote=old.numpil;
    end $$
delimiter ;

drop trigger if exists q3;
delimiter $$
	create trigger q3 after update on vol for each row
    begin
		if old.datea != new.datea or old.dated != new.dated then
			update pilote set nbhv = nbhv - timediff(old.datea,old.dated) + timediff(new.datea,new.dated) 
			where  numpilote=new.numpil;
		end if ;
    end $$
delimiter ;


delete from vol where numvol = 15;
select * from pilote;
select * from vol;
update Vol set datea = '2023-11-20 14:30:00' where numvol = 16;
