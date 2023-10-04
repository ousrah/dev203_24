create database instruction_203 collate 'utf8mb4_general_ci';
use instruction_203;
#Langage Mysql pour la programmation coté serveur
#La présentation des blocs d'instructions

#cette instruction se termine par ; qu'on appel délimiteur
select * from client;

#pour créer un bloc (fonction ou procédure) il faut le supprimer s'il existe
#puis changer le délimiteur à $$ ou //
drop function if exists hello;
delimiter $$
    #indique qu'on souhaite créer une fonction hello
	create function hello()
    #cette fonction return une chaine de caratère
	returns varchar(50)
    #cette fonction retourn toujours la meme sortie pour les meme entrées
    DETERMINISTIC
	begin
        #traitement
        #.....
        #retour du resultat
		return "hello";
    #fin du bloc avec le délimiteur $$ ou //    
	end $$
    
#retour au délimiteur standard    
delimiter ;
#appel d'une fonction system mysql
select current_date();

#appel d'une fonction utilisateur
select hello();




#La déclaration
declare var type [ default value];
# on ne peut pas faire une declaration en dehors d'un bloc;



drop function if exists addition;
delimiter $$
	create function addition(a int, b int)
	returns int
    DETERMINISTIC
	begin
		declare c int default 0;
      
		return c;
	end $$
delimiter ;

select addition(3,5);


#L'affectation
#sytaxe
set var = value;
select value into var;




drop function if exists addition;
delimiter $$
	create function addition(a int, b int)
	returns int
    DETERMINISTIC
	begin
		declare c int default 0;
		#set c = a+b;
        select (a+b) into c;
		return c;
	end $$
delimiter ;

#pour déclarer une variable globale en dehors des blocs
set @c=5;
select @c;




#L'affichage
select addition(3,2)


#Les conditions
#Syntaxe
	if condition then
		Instructions
	else
		Instructions
	end if

drop function if exists comparaison;
delimiter $$
create function comparaison(a int, b int)
	returns varchar(50)
	deterministic
	begin
		declare result varchar(50) default '';
		if a<b then
			set result = "a est plus petite que b";
        else
			set result = "a est plus grande ou égale à b";
        end if;
		return result;
	end $$
delimiter ;

select comparaison(13,13);

Ax+B=0
x= -B/A

si A = 0 et B = 0
  X = R
Si A = 0 et B != 0 
 Ensemble vide
 
 Si a!=0
  X = -B/A
  
  
  
Ax²+Bx+C = 0

A=0 et B=0 et C=0
   X=R
A=0 B=0 et C!=0
   Ensemble vide
A=0  B!=0
		X = -C/B
A!=0
 Delta = (B*B) - (4*A*C)

si delta = 0
   x1 = x2 = -B/2A
si delta > 0
   x1 = (-b+ racine(delta)) / (2*A)
   x2 = (-b-racine(delta))/(2*A)
si delta <0
  impossible dans R
  
        




#Les boucles

#Les fonctions

#Les procedures stockées

#Les triggers (Les declencheurs)

#Les exception

#Les transactions

#Les views et Les tables temporaires 

#Les curseurs

#Les utilisateurs

#Les droits au utilisateurs

#Le backup et le restore (sauvegarde et récupération des données)