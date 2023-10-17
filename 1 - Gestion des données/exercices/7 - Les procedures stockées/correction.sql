/*Exercice 1 :
On considère la table suivante :
Produit (NumProduit, libelle, PU, stock)*/

drop database if exists produits_203;

create database produits_203 collate utf8mb4_general_ci;
use produits_203;

create table Produit(numProduit int auto_increment primary key,
libelle varchar(50) ,
PU float ,stock int);


insert into produit values (1,'table',350,100),
							(2,'chaise',100,10),
                            (3,'armoire',2350,10),
                            (4,'pc',3500,20),
                            (5,'clavier',150,200),
                            (6,'souris',50,200),
                            (7,'ecran',2350,70),
                            (8,'scanner',1350,5),
                            (9,'imprimante',950,5);
                            



select * from produit;

#1.	Ecrire une PS qui affiche tous les produits ;

drop procedure if exists p1;
delimiter $$
create procedure p1()
begin
	select * from produit ;
end $$
delimiter ;
call p1() ;



#2.	Ecrire une procédure stockée qui affiche les libellés des produits dont le stock est inférieur à 10 ;
drop procedure if exists p2;
delimiter $$
create procedure p2()
begin
	select libelle from produit where stock<10;
end $$
delimiter ;
call p2() ;
#3.	Ecrire une PS qui admet en paramètre un numéro de produit et affiche un message 
-- contenant le libellé, le prix et la quantité en stock équivalents, 
-- si l’utilisateur passe une valeur lors de l’exécution de la procédure ;
drop procedure if exists p3;
DELIMITER $$
CREATE PROCEDURE P3(IN numPrd INTEGER ) 
BEGIN
if numprd is null then
	select null;
else
	SELECT CONCAT("Produit: ", p.numProduit , ", ", p.libelle, ", ", p.PU , ", ", p.stock) as libelle
    from produit p  where numProduit = numPrd;
end if;
END;
$$
delimiter ; 
 call p3(null);
 
#4.	Ecrire une PS qui permet de supprimer un produit en passant son numéro comme paramètre ;
drop procedure if exists p4;
DELIMITER $$
CREATE PROCEDURE P4(IN numPrd INTEGER ) 
BEGIN
delete from produit where numProduit = numPrd;
END;
$$
delimiter ;

call p4(2);
call p1;

/*Exercice 2 :
Ecrire une PS qui permet de mettre à jour le stock après une opération de vente de produits, la PS admet en paramètre le numéro d’article à vendre et la quantité à vendre puis retourne un message suivant les cas :
*/
#a.	Opération impossible : si la quantité est supérieure au stock de l’article ;
#b.	Besoin de réapprovisionnement si stock-quantité < 10
#c.	Opération effectuée  avec succès, la nouvelle valeur du stock est (afficher la nouvelle valeur) ;

drop procedure if exists ex2;
delimiter $$
create procedure ex2( nump int , q int)
begin
	declare stockactuel int;
	declare nouvellestokc int ;
	select stock into stockactuel from produit where nump=numProduit;
	if q> stockactuel then
		select "operation impossible";
	elseif stockactuel-q<10 then 
		update produit set stock = stock-q where numproduit = nump;
		select "Besoin de réapprovisionnement";
	else 
		set nouvellestokc=stockactuel-q;
        update produit set stock = nouvellestokc where numproduit = nump;
		select concat("Opération effectuée  avec succès le nouveau stock est :  ", nouvellestokc);
	end if;
end$$
delimiter ;

select * from produit;
call ex2(1,200);
call ex2(1,1);
call ex2(1,92);


/*Exercice 3 :
Ecrire une PS qui retourne le prix moyen des produits (utiliser un paramètre OUTPUT) ; Exécuter la PS ;
*/

drop procedure if exists ex3;
delimiter $$
create procedure ex3(out moy float)
begin
set moy=(select round(avg(pu),2) from produit );
end$$
delimiter ;
call ex3(@moy);
select @moy;