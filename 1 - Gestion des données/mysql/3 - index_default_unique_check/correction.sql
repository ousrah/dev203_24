#Série 1 : Les Contraintes d’intégrités

#Exercice 1 :

#Soit le modèle relationnel suivant relatif à la gestion des notes annuelles d'une promotion d’étudiants :
#ETUDIANT (NEtudiant, Nom, Prénom)
#MATIERE (CodeMat, LibelleMat, CoeffMat)
#EVALUER (NEtudiant, CodeMat, DateExamen, Note)

#Questions :

#1.	Créer la base de données avec le nom « Ecole »;

create database ecole_203 collate utf8mb3_general_ci;
use ecole_203;

#2.	Créer les tables avec les clés primaires sans spécifier les clés étrangères ;

create table Etudiant(
	NEtudiant int primary key,
    nom varchar(50),
    prenom varchar(50)
);

create table matiere(
	codeMat int primary key,
    libelleMat varchar(100),
    coeffMat int
);

create table Evaluer(
	nEtudiant int,
    codeMat int,
    dateExamen date,
	note float,
     primary key (nEtudiant, CodeMat)
);

#3.	Ajouter les clés étrangères à la table EVALUER ; 
alter table Evaluer add constraint fk_eva_netu foreign key (nEtudiant) references Etudiant(nEtudiant);
alter table Evaluer add constraint fk_mat_cod foreign key (CodeMat) references matiere(CodeMat);

#4.	Ajouter la colonne Groupe dans la table ETUDIANT: Groupe NOT NULL ; 
alter table Etudiant 
add column Groupe varchar(45) not null ;
#5.	Ajouter la contrainte unique pour l’attribut (LibelleMat) ; 
alter table matiere add constraint unique_libelle unique (LibelleMat);
#6.	Ajouter une colonne Age à la table ETUDIANT, avec la contrainte (age >16) ; 
alter table etudiant
add column age int check (age>16);
#7.	Ajouter une contrainte sur la note pour qu’elle soit dans l’intervalle (0-20) ; 
Alter table  EVALUER
ADD constraint note_chk CHECK (Note>=0 AND Note <=20);
#8.	Remplir les tables par les données ;




#Exercice 2 :

#Soit le schéma relationnel suivant :

#  AVION ( NumAv, TypeAv, CapAv, VilleAv)
#  PILOTE (NumPil, NomPil,titre, VillePil) 
#  VOL (NumVol, VilleD, VilleA, DateD, DateA, NumPil#,NumAv#)

#Travail à réaliser :

#  À l'aide de script SQL: 

#1.	Créer la base de données sans préciser les contraintes de clés.
drop database vols_203;
create database vols_203 collate utf8mb3_general_ci;
use vols_203;

 create table AVION ( 
 NumAv bigint ,
 TypeAv varchar(100), 
 CapAv int, 
 VilleAv varchar(100)
 );
 create table PILOTE (
 NumPil bigint ,
 NomPil varchar(100),
 titre varchar(100),
 VillePil varchar(100)
 ) ;
 drop table vol;
  create table  VOL (
  NumVol bigint ,
  VilleD varchar(100),
   VilleA varchar(100),
   DateD datetime, 
   DateA datetime, 
   NumPil bigint not null,
   NumAv bigint not null
   );
#2.	Ajouter les contraintes de clés aux tables de la base.
alter table avion 
add constraint pk_avion
primary key (Numav);


alter table pilote 
add constraint pk_pilote
primary key (Numpil);

alter table vol 
add constraint pk_vole primary key (NumVol);

alter table pilote modify numpil bigint auto_increment;
alter table AVION modify numav bigint auto_increment;
alter table vol modify numvol bigint auto_increment;



alter table vol 
add constraint fk_vol_avion foreign key (NumAv) references avion(NumAv),
add constraint fk_vol_pilote foreign key (Numpil) references pilote(Numpil);

#3.	Ajouter des contraintes qui correspondent aux règles de gestion suivantes

#	Le titre de courtoisie doit appartenir à la liste de constantes suivantes :
#M, Melle, Mme.
alter table pilote add constraint ck_titre check(titre in ("m","melle","Mme"));
#	Les valeurs noms, ville doivent être renseignées.
alter table pilote
	modify nompil varchar(50) not null,
	modify villepil varchar(50) not null;


#	La capacité d’un avion doit être entre 50 et 100.
ALTER TABLE AVION ADD CONSTRAINT CH_Cap check(CapAv between 50 and 100);
#4.	Ajouter la  colonne ‘date de naissance’ du pilote : DateN 
alter table pilote  
add dateN date ;
#5.	Ajouter une contrainte qui vérifie que la date de départ d’un vol est toujours 
#inférieure ou égale à sa date d’arrivée.
ALTER TABLE vol ADD CONSTRAINT chk_dates check(dateA > dateD);
#6.	Supprimer la colonne VilleAv
alter table avion drop column villeAv;
#7.	Supprimer la table PILOTE
alter table vol drop constraint fk_vol_pilote;
drop table pilote;
#8.	Remplir la base de données pour vérifier les contraintes appliquées.



 
