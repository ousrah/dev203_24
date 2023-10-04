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

Rappel mathématique equation premier degrès
Ax+B=0
x= -B/A

si A = 0 et B = 0
  X = R
Si A = 0 et B != 0 
 Ensemble vide
 
 Si a!=0
  X = -B/A
  
  
drop function if exists equ1;
delimiter $$
create function equ1(a int, b int)
	returns varchar(50)
	deterministic
	begin
		declare result varchar(50) default '';
		if  a = 0 then
			if b= 0 then
				set result = "Ensemble R";
			else 
				set result = "Ensemble vide";
			end if;
		else
			set result = round(-b/a,2);
        end if;
		return result;
	end $$
delimiter ;
select equ1(0,0); #2  2
select equ1(0,1); #4 2
select equ1(1,1); #4 1
  
  
  
  
  Rappel mathématique equation deuxième degrès
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
  
        
     
drop function if exists equation_2degree;
delimiter $$
	create function equation_2degree(a int , b int, c int)
    returns varchar(100)
    deterministic
    begin
		declare result varchar(100) default '';
        declare delta int default 0;
		if a=0  then
			if b = 0 then
				if c = 0 then 
					set result ="l enssemble R";
				else
					set result ="impossible";
				end if;
			else
				set result = equ1(b,c);
			end if;
		else 
			set delta = b*b-4*a*c;
            if (delta=0) then 
				set result=concat("resultat est: ",-b/(2*a));
			elseif (delta>0) then 
				set result =concat("x1= ",round((-b+sqrt(delta))/(2*a),2), " x2= ",round((-b-sqrt(delta))/(2*a)),2);
            else 
				set result ="impossible dans R";
			end if;
		end if;
        return result;
	end $$
delimiter ;

select equation_2degree(0,0,0);   
select equation_2degree(0,0,1);   
select equation_2degree(0,2,2);   
select equation_2degree(1,2,1);
select equation_2degree(2,5,1);
select equation_2degree(8,2,1);

 
drop function if exists jourDeLaSemaine;
delimiter $$
	create function jourDeLaSemaine(j int)
    returns varchar(10)
    Deterministic
    begin
		declare jour varchar(10);
        set jour = case j
        when 1 then 'Dimanche'
        when 2 then 'Lundi'
        when 3 then 'Mardi'
        when 4 then 'Mercredi'
        when 5 then 'Jeudi'
        when 6 then 'Vendredi'
        when 7 then 'Samedi'
        else
        'Erreur'
        end;
		return jour;
    end;
    $$
delimiter ;

select jourDeLaSemaine(8);



drop function if exists jourDeLaSemaine;
delimiter $$
	create function jourDeLaSemaine(j int)
    returns varchar(10)
    Deterministic
    begin
		declare jour varchar(10);
        set jour = case 
        when j=1 then 'Dimanche'
        when j=2 then 'Lundi'
        when j=3 then 'Mardi'
        when j=4 then 'Mercredi'
        when j=5 then 'Jeudi'
        when j=6 then 'Vendredi'
        when j=7 then 'Samedi'
        else
        'Erreur'
        end;
		return jour;
    end;
    $$
delimiter ;

select jourDeLaSemaine(2);
#Les boucles

drop function if exists somme;
delimiter $$
create function somme(n int)
returns bigint
deterministic
begin
	declare s bigint default 0;
    declare i int default 1;
    while i<=n do
		set s = s + i;
        set i = i+1;
    end while;
	return s;
end;
$$
delimiter ;



drop function if exists somme;
delimiter $$
create function somme(n int)
returns bigint
deterministic
begin
	declare s bigint default 0;
    declare i int default 0;
    repeat
		set s = s + i;
        set i = i+1;
    until i>n end repeat;
	return s;
end;
$$
delimiter ;


select somme(5);
select somme(0);





drop function if exists somme;
delimiter $$
create function somme(n int)
returns bigint
deterministic
begin
	declare s bigint default 0;
    declare i int default 0;
    boucle1 : loop
		set s = s + i;
        set i = i+1;
        if i>n then
			leave boucle1;
		end if;
    end loop boucle1;
	return s;
end;
$$
delimiter ;


select somme(5);
select somme(0);

ecrire une fonction qui permet de faire la somme des n premier entier paires (utiliser une incremetation par 1 et le modulo)

loop
while
repeat

for(i=1;i<10;i++)
{


}








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