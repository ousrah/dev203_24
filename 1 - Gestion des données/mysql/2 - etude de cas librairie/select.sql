select ceiling(rand()*23);
USE LIBRAIRIE_201;
# 1.	Liste des noms des éditeurs situés à Paris triés 
#par ordre alphabétique. 

select NOMED from editeur
where VILLEED ='Paris'
order by NOMED;

#2.	Liste des écrivains de (tous les champs)  langue française, 
#triés par ordre alphabétique sur le prénom et le nom  .
select * from ecrivain
where languecr = "francais"
order by  prenomecr ,nomecr asc; 

#3.	Liste des titres des ouvrages (NOMOUVR) ayant été
# édités entre (ANNEEPARU) 1986 et 1987.

select NOMOUVR, anneeparu
from ouvrage 
where ANNEEPARU between 1986 and 1987;

#where anneeparu >=1986 
#		and anneeparu <=1987; 

#4.	Liste des éditeurs dont le n° de téléphone est inconnu
select nomed, teled
from editeur
where teled is null ;


#5.	Liste des auteurs (nom + prénom) dont le nom contient un ‘C’.

select nomecr , prenomecr
from ecrivain 
where nomecr like '%c%' ;

#6.	Liste des titres d’ouvrages contenant  le mot "banque"
# (éditer une liste triée par n° d'ouvrage croissant). 
select NOMOUVR ,NUMOUVR 
FROM ouvrage where NOMOUVR like '%banque%'
order by NUMOUVR ASC;




#7.	Liste des dépôts (nom) situés à Grenoble ou à Lyon. 

SELECT NOMDEP, villedep
FROM depot
where villedep in  ("Grenoble" ,"Lyon");

#8.	Liste des écrivains (nom + prénom) américains
# ou de langue française. 

select *from ecrivain
where PAYSeCR="USA" or LANGUECR="Francais";


#9.	Liste des auteurs (nom + prénom) de langue française dont le nom ou 
#le prénom commence par un ‘H’. 
select nomecr nom,prenomecr prenom, languecr
from ecrivain
where (prenomecr like 'H%' or nomecr like "H%") and  LANGUECR="Francais";

select 5 * 3 + 2;
select 2 + 5 * 3 ;


#10.	Titres des ouvrages en stock au dépôt n°2. 

select NOMOUVR
from OUVRAGE O
join STOCKER S ON O.NUMOUVR = S.NUMOUVR
where NUMDEP = 2;

#11.	Liste des auteurs (nom + prénom) ayant écrit des livres 
#coûtant au moins 30 € au 1/10/2002. 
select distinct NOMECR,PRENOMECR from ecrivain e
join ecrire ec on 	e.NUMECR=ec.NUMECR
join tarifer t on ec.NUMOUVR=t.NUMOUVR
WHERE PRIXVENTE>= 30 AND DATEDEB='2002/10/01';

create view R11 as
select distinct NOMECR,PRENOMECR from ecrivain e
join ecrire ec on 	e.NUMECR=ec.NUMECR
join tarifer t on ec.NUMOUVR=t.NUMOUVR
WHERE PRIXVENTE>= 30 AND DATEDEB='2002/10/01';


#12.	Ecrivains (nom + prénom) ayant écrit des livres sur le thème 
#(LIBRUB) des « finances publiques ». 
#Méthode 1
select distinct nomecr,prenomecr
from ecrivain e 
join ecrire ec on e.numecr=ec.numecr
join ouvrage o on o.numouvr=ec.numouvr
join classification c on c.numrub=o.numrub
where c.librub="finances publiques";

#Creation de la vue
create view R12 as
	select distinct nomecr,prenomecr
	from ecrivain e 
	join ecrire ec on e.numecr=ec.numecr
	join ouvrage o on o.numouvr=ec.numouvr
	join classification c on c.numrub=o.numrub
	where c.librub="finances publiques";

#Methode2
select nomecr, prenomecr from ecrivain where numecr in( select numecr from ecrire where numouvr in(
											select numouvr from ouvrage where numrub in(
												select numrub from classification where librub="finances publiques")
                                                )
									);

#13.	Idem R12 mais on veut seulement les auteurs dont le nom contient un ‘A’. 
#Methode1
select distinct nomecr,prenomecr
from ecrivain e 
join ecrire ec on e.numecr=ec.numecr
join ouvrage o on o.numouvr=ec.numouvr
join classification c on c.numrub=o.numrub
where c.librub="finances publiques" AND e.NOMECR LIKE "%A%" ;

#Methode2
select * from R12 where NOMECR LIKE "%A%" ;

#14.	En supposant l’attribut PRIXVENTE dans TARIFER comme un prix 
#TTC et un taux de TVA égal à 15,5% sur les ouvrages, donner le prix 
#HT de chaque ouvrage. 
select ouvrage.numouvr , tarifer.prixvente ,round(tarifer.prixvente /1.155 ,2) as 'prix ht'
from ouvrage
join tarifer on tarifer.numouvr=ouvrage.numouvr;


#15.	Nombre d'écrivains dont la langue est l’anglais ou l’allemand. 
select count(*)
from ecrivain 
where LANGUECR in ("anglais","allemand");

#16.	Nombre total d'exemplaires d’ouvrages sur la « gestion de portefeuilles »
# (LIBRUB) stockés dans les dépôts Grenoblois. 

select sum(qtestock)
from ouvrage o
join classification c on c.numrub=o.numrub
join stocker s on s.numouvr=o.numouvr
join depot d on d.numdep=s.numdep
where c.librub='gestion de portefeuilles' and d.villedep='Grenoble';


#17.	Titre de l’ouvrage ayant le prix le plus élevé 
#- faire deux requêtes. (réponse: Le Contr ôle de gestion dans la banque.)
select nomouvr, prixvente from ouvrage o
join tarifer t on t.numouvr = o.numouvr
where prixvente in (select max(prixvente) from tarifer);

#cette réponse est fausse
select nomouvr, prixvente from ouvrage o
join tarifer t on t.numouvr = o.numouvr
order by prixvente desc limit 1;



#18.	Liste des écrivains avec pour chacun le nombre d’ouvrages qu’il a écrits. 
select ecr.nomecr as nom_auteur,ecr.prenomecr as prenom_auteur,count(*) as nb_ouvrage
from ecrivain ecr
join ecrire e on ecr.numecr=e.numecr
group by nom_auteur,prenom_auteur;
#having nb_ouvrage>=3

#19.	Liste des rubriques de classification avec, pour chacune, 
#le nombre d'exemplaires en stock dans les dépôts grenoblois. 

select librub , sum(s.qtestock) from classification c
join ouvrage o on o.numrub=c.numrub
join stocker s on o.numouvr=s.numouvr
join depot d on d.numdep= s.numdep
where villedep like 'grenoble'
group by c.librub;


alter view R19 as 
select librub , sum(s.qtestock) as TotalStock from classification c
join ouvrage o on o.numrub=c.numrub
join stocker s on o.numouvr=s.numouvr
join depot d on d.numdep= s.numdep
where villedep like 'grenoble'
group by c.librub;

select * from R19

#20.	Liste des rubriques de classification avec leur état de stock 
#dans les dépôts grenoblois: ‘élevé’ s’il y a plus de 1000 exemplaires
# dans cette rubrique, ‘faible’ sinon. (réutiliser la requête 19). 
SELECT LIBRUB as Rubrique , 
IF(TotalStock > 1000 , 'eleve' ,'faible') as NBr_Exemplaires
from R19 ;

SELECT LIBRUB as Rubrique , 
case 
	when TotalStock > 1000 then 'eleve'
	else 'faible'
end  as NBr_Exemplaires
from R19 ;

case
	when condition then 'result'
    when condition then 'result'
    when condition then 'result'
    when condition then 'result'
    when condition then 'result'
    when condition then 'result'
    else 'result'
end

case variable
	when 'value' then 'result'
    when 'value' then 'result'
    when 'value' then 'result'
    when 'value' then 'result'
    when 'value' then 'result'
    when 'value' then 'result'
    else 'result'
end;


#21.	Liste des auteurs (nom + prénom) ayant écrit des livres sur 
#le thème (LIBRUB) des « finances publiques » ou bien ayant écrit des
#livres coûtant au moins 30 € au 1/10/2002 - réutiliser les requêtes 11 et 12. 
(select * from R11)
union # union sans doublon   -  #union all   (avec doublons)
(select * from R12);

#22.	Liste des écrivains (nom et prénom) n’ayant écrit aucun des 
#ouvrages présents dans la base. 

select NOMECR,PRENOMECR 
from ecrivain 
where numecr not in (select numecr from ecrire );


select *
from ecrivain e left join ecrire ec on e.numecr = ec.numecr
where ec.numecr is null;


#23.	Mettre à 0 le stock de l’ouvrage n°6 dans le dépôt Lyon2. 
update stocker
set qtestock = 0
where numouvr = 6 and numdep in (select numdep from depot where villedep = 'lyon2');



#24.	Supprimer tous les ouvrages de chez Vuibert de la table OUVRAGE.
delete from ecrire where numouvr in (select numouvr from ouvrage where nomed = 'vuibert');
delete from tarifer where numouvr in (select numouvr from ouvrage where nomed = 'vuibert');
delete from stocker where numouvr in (select numouvr from ouvrage where nomed = 'vuibert');
delete from ouvrage where nomed = 'vuibert';



#25.	créer une table contenant les éditeurs situés à Paris et leur n° de tel. 


create table EditeursDeParis 
	select nomed, teled from editeur where villeed = 'paris';

select * from EditeursDeParis;

