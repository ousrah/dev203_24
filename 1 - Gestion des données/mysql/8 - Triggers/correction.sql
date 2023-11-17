
/*EX 1 - Soit la base de données suivante :  (Utilisez celle de la série des fonctions):
Pilote(numpilote,nom,titre,villepilote,daten,datedebut)
Vol(numvol,villed,villea,dated,datea, #numpil,#numav)
Avion(numav,typeav ,capav)*/

#1 – Ajouter la table pilote le champ nb d’heures de vols ‘NBHV’ sous la forme  « 00:00:00 ».
use vols_203;
select * from vol;
alter table pilote 
add column nbhv time default '00:00:00';
alter table vol modify dated datetime;
alter table vol modify datea datetime;

#2 – Ajouter un déclencheur qui calcule le nombre heures lorsqu’on ajoute un nouveau vol et qui augmente automatiquement le nb d’heures de vols du pilote qui a effectué le vol.

drop trigger if exists q2;
delimiter $$
create trigger q2 after insert on vol for each row
begin
	
        update pilote set nbhv=nbhv+timediff(new.datea,new.dated) where  numpilote=new.numpil;

end

$$
delimiter ;
select * from vol;
insert into vol values(16,'tetouan','casa blanca','2023-11-20 11:00:00','2023-11-20 15:30:00',1,2);
select * from pilote;
#3 – Si on supprime un vol le nombre d’heures de vols du pilote qui a effectué ce vol doit être recalculé. Proposez une solution.


drop trigger if exists q3;
delimiter $$
	create trigger q3 after delete on vol for each row
    begin
		update pilote set nbhv = nbhv - timediff(old.datea,old.dated) where  numpilote=old.numpil;
    end $$
delimiter ;

#4 – Si on modifie la date de départ ou d’arrivée d’un vol le nombre d’heures de vols du pilote qui a effectué ce vol doit être recalculé. Proposez une solution.

drop trigger if exists q4;
delimiter $$
	create trigger q4 after update on vol for each row
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



#EX 2 - Soit la base de données suivante :  (Utilisez celle de la série des PS):
#DEPARTEMENT (ID_DEP, NOM_DEP, Ville)
#EMPLOYE (ID_EMP, NOM_EMP, PRENOM_EMP, DATE_NAIS_EMP, SALAIRE, #ID_DEP)

#1 – Ajouter le champs salaire moyen dans la table département.
use employes_203;
select * from departement;
select * from employe;
alter table departement add salaire_moyen float default 0;


#2 – On souhaite que le salaire moyen soit recalculé automatiquement si on ajoute un nouvel employé, 
#on supprime ou on modifie le salaire d’un ou plusieurs employés. Proposez une solution.
drop trigger if exists t1;
delimiter $$
	create trigger t1 after insert on employe for each row
		begin 
			update departement set salaire_moyen = (select avg(salaire) 
													from employe
                                                    where id_dep = new.id_dep)
			where id_dep=new.id_dep;
        end $$
delimiter ;

insert into employe values (10,'souad','souad','2000-01-01',2000,1);

select * from departement;
select * from employe;

# supprier 
drop trigger if exists t2;
delimiter $$
	create trigger t2 after delete on employe for each row
		begin 
			update departement set salaire_moyen = (select avg(salaire) 
													from employe
                                                    where id_dep = old.id_dep)
			where id_dep=old.id_dep;
        end $$
delimiter ;

insert into employe values (10,'souad','souad','2000-01-01',2000,1);
delete from employe where id_dep = 1 ;
select * from departement;
select * from employe;

#Update : 
drop trigger if exists t3;
delimiter $$
	create trigger t3 after update on employe for each row
		begin 
			if old.salaire <> new.salaire then
				update departement set salaire_moyen = (select avg(salaire) 
													from employe
                                                    where id_dep = new.id_dep)
				where id_dep=new.id_dep;
			end if;
            if old.id_dep <> new.id_dep then
				update departement set salaire_moyen = (select avg(salaire) 
													from employe
                                                    where id_dep = new.id_dep)
				where id_dep=new.id_dep;
                update departement set salaire_moyen = (select avg(salaire) 
													from employe
                                                    where id_dep = old.id_dep)
				where id_dep=old.id_dep;
			end if;
        end $$
delimiter ;
select * from departement;
select * from employe;
update employe set salaire = 5000 where id_emp = 3;

insert into employe values (null,'souad','souad','2000-01-01',2000,3);
update employe set salaire = 8000 where id_emp = 12;
update employe set id_dep = 3 where id_emp = 3;





#EX 2 - Soit la base de données suivante : (Utilisez celle de la série des PS):
#Recettes (NumRec, NomRec, MethodePreparation, TempsPreparation)
#Ingrédients (NumIng, NomIng, PUIng, UniteMesureIng, NumFou)
#Composition_Recette (NumRec, NumIng, QteUtilisee)
#Fournisseur (NumFou, RSFou, AdrFou)

use cuisine_203;
#1 – Ajoutez le champ prix à la table recettes.
alter table recettes add prix float ;


#2 – On souhaite que le prix de la recette soit calculé automatiquement 
#si on ajoute un nouvel ingrédient, on supprime un ingrédient 
#ou on modifie la quantité ou le prix d’un ou plusieurs ingrédients. Proposez une solution. 

drop trigger if exists ex3q2t1;
DELIMITER $$
CREATE trigger ex3q2t1 AFTER INSERT ON composition_recette 
FOR each row 
BEGIN 
    UPDATE recettes rec SET prix = prix +  (SELECT new.QteUtilisee * (select PUIng from ingredients where numing = new.numing))
    WHERE NumRec = NEW.NumRec;
END $$
delimiter ;
select * from recettes;
select * from composition_recette;
insert into composition_recette values (2,3,1);

select * from ingredients;
insert into ingredients values (null,'test',10,'test',1);
insert into composition_recette values (1,4,1);



insert into composition_recette values (1,3,1);
insert into composition_recette values (1,4,2);
insert into composition_recette values (1,1,1);


drop trigger if exists ex3q2t2;
DELIMITER $$
CREATE trigger ex3q2t2 AFTER DELETE ON composition_recette 
FOR each row 
BEGIN 
    UPDATE recettes rec SET prix = prix -  (SELECT OLD.QteUtilisee * (select PUIng from ingredients where numing = OLD.numing))
    WHERE NumRec = OLD.NumRec;
END $$
delimiter ;


drop trigger if exists ex3q2t3;
DELIMITER $$
CREATE trigger ex3q2t3 AFTER UPDATE ON composition_recette 
FOR each row 
BEGIN 
    UPDATE recettes rec SET prix = prix -  (SELECT OLD.QteUtilisee * (select PUIng from ingredients where numing = OLD.numing)) +  (SELECT NEW.QteUtilisee * (select PUIng from ingredients where numing = NEW.numing))
    
    WHERE NumRec = OLD.NumRec;
END $$
delimiter ;


UPDATE COMPOSITION_recette set qteutilisee = 3 where numrec = 1 and numing=4;
delete from COMPOSITION_recette  where numrec = 1 and numing=4;
select * from recettes;

DELIMITER //
	create trigger ex3q2t4
    AFTER UPDATE ON ingredients
    FOR EACH ROW 
    BEGIN
		UPDATE recettes SET prix = (SELECT SUM(i.PUIng * c.QteUtilisee) 
									FROM ingredients i
                                    JOIN composition_recette c ON c.NumIng = i.NumIng
                                    WHERE c.NumRec = new.numrec) #on a besoin d'un curseur qu'on va voir dans un futur cours
		WHERE NumRec = NEW
    END;
    //
DELIMITER ;

SELECT SUM(i.PUIng * c.QteUtilisee) 
FROM ingredients i
JOIN composition_recette c ON c.NumIng = i.NumIng
where c.NumRec = 1;
select * from composition_recette;
drop trigger if exists changePrice;
delimiter $$
create trigger changePrice after update on ingredients for each row
begin
	declare nr int;
    declare p float;
    declare flag boolean default false;
    declare c1 cursor for select distinct numRec from composition_recette where numIng = new.numIng;
    declare continue handler for not found set flag = true;
    open c1;
		b1:loop
			fetch c1 into nr;
            if flag then
				leave b1;
			end if;
            select sum(PuIng*qteutilisee) into p from composition_recette cr join ingredients i on cr.numing=i.numing where numrec = nr;
            update recettes set prix = p where numrec = nr;
        end loop b1;
    close c1;
end $$
delimiter ;


select * from recettes;

select * from ingredients;
update ingredients set PUIng = 10 where numing=1;

