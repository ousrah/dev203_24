drop database if exists gestionCommerciale_203;
create database gestionCommerciale_203;
use gestionCommerciale_203;

create table produit(ref int auto_increment primary key, designation varchar(50),qteStock int);

create table commande (id_commande int auto_increment primary key, date_commande datetime);

create table ligne (ref int, id_commande int, qte int, prix_vente float,
constraint fk_ligne_produit foreign key (ref) references produit(ref),
constraint fk_ligne_commande foreign key (id_commande) references commande(id_commande),
constraint pk_ligne primary key (ref,id_commande));


insert into produit values (1,'table',100),(2,'chaise',400),(3,'armoire',50);
insert into commande value (1,'2023-10-24');

insert into ligne values (1,1,10,500),(1,2,5,100);
update produit set qteStock = qteStock - 10 where ref = 1;

delete from ligne;

select * from produit;
update produit set qteStock = qteStock + 10 where ref = 1;


drop trigger if exists t1;
delimiter $$
create trigger t1 after insert on ligne for each row
begin
	update produit set qteStock = qteStock-new.qte where ref = new.ref;
end $$
delimiter ;



select * from ligne;
select * from produit;

insert into ligne values (1,1,10,500);

insert into ligne values (2,1,5,100);


drop trigger if exists t2;
delimiter $$
create trigger t2 after delete on ligne for each row
begin
	update produit set qteStock = qteStock+old.qte where ref = old.ref;
end $$
delimiter ;



delete from ligne ;
select * from produit;


alter table produit add constraint chk_qtestock check(qteStock>=0);

update produit set qteStock = -300;

insert into ligne values (2,1,50,100);
select * from ligne;
select * from produit;



drop trigger if exists t3;
delimiter $$
create trigger t3 after update on ligne for each row
begin
	if (old.qte!=new.qte) then
		update produit 
		set qteStock = qteStock + old.qte - new.qte
		where ref = old.ref;
    end if;
end $$
delimiter ;

select * from ligne;
select * from produit;
update ligne set qte = 60;
update ligne set qte = 20;
update ligne set prix_vente = 120;









