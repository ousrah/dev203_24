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
	declare stockActuel int;
	declare nouveau_stock int ;
	select stock into stockActuel from produit where nump=numProduit;
	if q> stockActuel then
		select "operation impossible";
	elseif stockActuel-q<10 then 
		update produit set stock = stock-q where numproduit = nump;
		select "Besoin de réapprovisionnement";
	else 
		set nouveau_stock=stockActuel-q;
        update produit set stock = nouveau_stock where numproduit = nump;
		select concat("Opération effectuée  avec succès le nouveau stock est :  ", nouveau_stock);
	end if;
end$$
delimiter ;

select * from produit;
call ex2(6,300);
call ex2(6,1);
call ex2(6,192);


/*Exercice 3 :
Ecrire une PS qui retourne le prix moyen des produits (utiliser un paramètre OUTPUT) ; Exécuter la PS ;
*/

Class Produit
{
	public id int;
    public name string;
	public function Produit(_id int, _name string)
	{
		$this.id = _id;
        $this.name = _name;
	}


}
drop procedure if exists ex3;
delimiter $$
create procedure ex3(out moy float)
begin
set moy=(select round(avg(pu),3) from produit );
end$$
delimiter ;
call ex3(@moy);
select @moy;

/*Exercice 4 :
Créer une procédure stockée qui accepte comme paramètre un entier et retourne le factoriel de ce nombre.
*/

set max_sp_recursion_depth = 100;
drop procedure if exists fac;
DELIMITER //
	create procedure fac(in num1 int,out res bigint) 
	begin 
			declare t bigint;
			if num1 <2  then
				set res = 1;
			else
				call fac(num1 - 1,t);
				set res = num1 * t; 
			end if;
    end;
    //
DELIMITER ;

call fac(4,@fac);
select @fac;

drop procedure if exists fact;
DELIMITER //
	create procedure fact(in num1 int,out f bigint) 
	begin 
            declare i bigint default 1;
            set f = 1	;
            while (i<=num1) do 
				set f = f*i;
                set i = i +1;
			end while;
    end;
    //
DELIMITER ;

call fact(5,@f);
select (@f);



/*Exercice 5 :
1.	Créer une procédure stockée qui accepte les paramètres suivants : 
a.	 2 paramètres de type entier  
b.	 1 paramètre de type caractère.
c.	1 paramètre output de type entier

La procédure doit enregistrer le résultat de calcul entre les deux nombres selon l’opérateur passé dans le troisième paramètre (+,-,%,/,*). 
*/

drop procedure if exists calc;
delimiter $$
	create procedure calc( a int,  b int,  c varchar(50), out d int)
		begin
			if c = '+' then
				set d = a+b;
			elseif c = '-' then 
				set d = a-b;
			elseif c = '*' then
				set d = a * b;
			elseif c = '/' and b!=0 then 
				set d = a/b;
			elseif c = '%' then 
				set d = a%b ;
			else 
				select 'Erreur';
			end if;
        end $$
delimiter ; 
call calc(2,3,'*',@d);
select @d;



/*Exercice 6 :
Soit la base de données suivante :
Recettes (NumRec, NomRec, MethodePreparation, TempsPreparation)
Ingrédients (NumIng, NomIng, PUIng, UniteMesureIng, NumFou)
Composition_Recette (NumRec, NumIng, QteUtilisee)
Fournisseur (NumFou, RSFou, AdrFou)*/


drop database if exists cuisine_203;
create database cuisine_203;
use cuisine_203;
create table Recettes (
NumRec int auto_increment primary key, 
NomRec varchar(50), 
MethodePreparation varchar(60), 
TempsPreparation int
);
create table Fournisseur (
NumFou int auto_increment primary key, 
RSFou varchar(50), 
AdrFou varchar(100)
);
create table Ingredients (
NumIng int auto_increment primary key,
NomIng varchar(50), 
PUIng float, 
UniteMesureIng varchar(20), 
NumFou int,
   constraint  fkIngredientsFournisseur foreign key (NumFou) references Fournisseur(NumFou)
);
create table Composition_Recette (
NumRec int not null,
constraint  fkCompo_RecetteRecette foreign key (NumRec) references Recettes(NumRec), 
NumIng int not null ,
  constraint  fkCompo_RecetteIngredients foreign key (NumIng) references Ingredients(NumIng),
QteUtilisee int,
constraint  pkRecetteIngredients primary key (NumIng,NumRec)
);

insert into Recettes  values(1,'gateau','melangeprotides' ,30),
							(2,'pizza ','melangeglucides' ,15),
							(3,'couscous','melangelipides' ,45);
insert into Fournisseur  values (1,'meditel','fes'),
								(2,'maroc telecom','casa'),
								(3,'inwi','taza');
insert into Ingredients values(1,'Tomate', 100,'cl',1),
								(2,'ail', 200,'gr',2),
								(3,'oignon', 300,'verre',3);
							
insert into Composition_Recette values (2,1,10);
insert into Composition_Recette values (2,2,1);


#Créer les procédures stockées suivantes :
#PS1 : Qui affiche la liste des ingrédients avec pour chaque ingrédient le numéro, 
#le nom et la raison sociale du fournisseur.

drop procedure if exists ps1;
DELIMITER //
create procedure ps1 ()
begin 
	SELECT i.NUMING , i.noming , f.rsfou 
	from Ingredients i 
	join fournisseur f on f.numfou = i.numfou ;
end //
delimiter ;
call ps1 ;




#PS2 : Qui affiche pour chaque recette le nombre d'ingrédients et le montant cette recette
drop procedure if exists ps2;
delimiter $$ 
create procedure ps2()
begin
	select nomrec, count(i.NumING) as nombre_ingrediants , sum(c.QteUtilisee*i.PUIng) as montant 
    from Composition_Recette as c
	RIGHT join Recettes   as r on r.NumRec = c.NumRec
    left join Ingredients  as i on i.NumIng = c.NumIng
    group by r.numrec;
    
end $$
delimiter ;

call ps2();




#PS3 : Qui affiche la liste des recettes qui se composent de plus de 10 ingrédients avec
# pour chaque recette le numéro et le nom

drop procedure if exists ps3;
delimiter $$ 
create procedure ps3()
begin
	select r.numrec,r.nomrec
    from Recettes r
    JOIN Composition_Recette c on r.numrec = c.numrec
    group by r.numrec,r.nomrec
    having count(c.NumIng) > 10;
    
end $$
delimiter ;

call ps3();



#PS4 : Qui reçoit un numéro de recette et qui retourne son nom
drop procedure if exists ps4;
DELIMITER $$
CREATE PROCEDURE ps4(IN numeroRecette INT, 
					OUT nomRecette VARCHAR(255))
BEGIN
    SELECT NomRec INTO nomRecette 
    FROM Recettes 
    WHERE NumRec = numeroRecette;
END $$
DELIMITER ;

call ps4(2,@n);
select @n;
#PS5 : Qui reçoit un numéro de recette. Si cette recette a au moins un ingrédient, 
#la procédure retourne son meilleur ingrédient (celui qui a le montant le plus bas)
# sinon elle ne retourne "Aucun ingrédient associé"

drop procedure if exists ps5;
delimiter $$ 
create procedure ps5(in num int, out res varchar(150))
begin
	declare nb int;
    select count(*) into nb from Composition_Recette where numrec = num;
	if nb=0 then
		set res = "Aucun ingrédient associé";
    else
		 select concat('le meilleur ingrédient est ',noming) into res from Composition_Recette cr
         join ingredients i on cr.numing = i.numing
         where numrec = num
         order by puing*qteutilisee
         limit 1;
    
    end if;

end $$
delimiter ;

select * from composition_recette;
call ps5(2,@res);
select @res;





#PS6 : Qui reçoit un numéro de recette et qui affiche la liste des ingrédients 
#correspondant à cette recette avec pour chaque ingrédient le nom, 
#la quantité utilisée et le montant
drop procedure if exists ps6;
delimiter $$
	create procedure ps6(n int)
    begin
		select  i.nomIng as nom ,cr.qteutilisee as qte, cr.qteutilisee*puing as montant
        from recettes r
        join composition_recette cr on cr.numrec = r.numrec
        join ingredients i on i.numing = cr.numing
        where r.numrec = n;
        
    end $$
delimiter ;
call ps6(2);
	
#PS7 : Qui reçoit un numéro de recette et qui affiche :
#Son nom (Procédure PS_4)
#La liste des ingrédients (procédure PS_6)
#Son meilleur ingrédient (PS_5)

drop procedure if exists ps7;
delimiter $$
	create procedure ps7(n int)
    begin
		call ps4(n,@n);
		select @n;
        call ps5(2,@res);
		select @res;
        call ps6(n);
	end $$
delimiter ;
call ps7(2);
        
#PS8 : Qui reçoit un numéro de fournisseur vérifie si ce fournisseur existe. Si ce 
#n'est pas le cas afficher le message 'Aucun fournisseur ne porte ce numéro' Sinon vérifier, 
#s'il existe des ingrédients fournis par ce fournisseur si c'est le cas afficher la liste 
#des ingrédients associés (numéro et nom) Sinon afficher un message 'Ce fournisseur n'a aucun 
#ingrédient associé. Il sera supprimé' et supprimer ce fournisseur


drop procedure if exists ps8;
delimiter $$
create procedure ps8(num int)
begin
	declare nb int;
    declare nbIng int;
    select count(*) into nb from fournisseur where numfou = num;
    if nb=0 then
		select 'Aucun fournisseur ne porte ce numéro';
	else
		select count(*) into nbIng from ingredients where numfou = num;
        if nbIng = 0 then
          select 'ce fournisseur n''a aucun ingrédient';
			delete from fournisseur where numfou = num;
        else
        select * from ingredients where numfou = num;
        end if;
	end if;

end $$
delimiter ;

select * from fournisseur;
call ps8(3);


#PS9 : Qui affiche pour chaque recette :
#Un message sous la forme : "Recette : (Nom de la recette), temps de préparation : (Temps)
#La liste des ingrédients avec pour chaque ingrédient le nom et la quantité
#Un message sous la forme : Sa méthode de préparation est : (Méthode)
#Si le prix de reviens pour la recette est inférieur à 50 DH afficher le message
#'Prix intéressant'
select * from recettes;
drop procedure if exists ps9;
delimiter $$
create procedure ps9()
begin
	  declare messageRecette varchar(250);
  declare methode varchar(250);

    
	declare flag1 boolean default false ;
    declare idrecette int;
    declare prix float;
    declare c1 cursor for select NumRec,methodePreparation, concat('Recette : (',NomRec,'), temps de préparation : (',TempsPreparation,')') from recettes;
    declare continue handler for not found set flag1 = true;
    open c1 ;
		b1 :loop 
			fetch c1 into idrecette,methode, messageRecette ;
            if flag1 then 
				leave b1;
			else
				select messageRecette;
				select i.NomIng,c.QteUtilisee
												from ingredients i
												join composition_recette c 
												on i.NumIng = c.NumIng
                                                where c.NumRec = idrecette;
				select methode;
                select sum(PUIng*QteUtilisee) into prix from  ingredients i
												join composition_recette c 
												on i.NumIng = c.NumIng
                                                where c.NumRec = idrecette;
				if prix <50 then
					select "Prix interessant" as prix;
				end if;
                
            end if ;
        end loop b1;
    close c1;
end$$
delimiter ;

call  ps9();

select * from ingredients;
update ingredients set PUIng = 1;