drop database importation_203;

create database importation_203 collate utf8mb4_general_ci;
use importation_203;


#importation du tableau avec l'outil Table Data Import Wizard

#reparation des données (note, date de naissance)
update tableau set note = replace(note,',','.');
alter table tableau modify note float;

update tableau set `Date Naissance` = str_to_date(`Date Naissance`,'%d/%m/%Y');
alter table tableau modify `Date Naissance` date;

#exportation des villes
create table ville
	select distinct ville nom from tableau;
alter table ville add column id bigint auto_increment primary key;

#exportation des classes
create table classe
	select distinct classe nom from tableau;
alter table classe add column id bigint auto_increment primary key;

#exportation des matieres
create table matiere
	select distinct Matière nom from tableau;
alter table matiere add column id bigint auto_increment primary key;

#exportation des appreciations
create table appreciation
	select distinct appréciation nom from tableau;
alter table appreciation add column id bigint auto_increment primary key;

#exportation des stagiaires
create table stagiaire 
	select  distinct `Nom stagiaire` nom, `prénom Stagiaire` prenom, `Date Naissance` daten ,v.id ville_id, c.id classe_id
	from tableau t
	join ville v on t.ville = v.nom 
	join classe c on t.classe = c.nom ;
    
alter table stagiaire  add column id bigint auto_increment primary key;  
alter table stagiaire add constraint fk_stagiaire_ville foreign key (ville_id) references ville(id);
alter table stagiaire add constraint fk_stagiaire_classe foreign key (classe_id) references classe(id);

#exportation des notes
create table notes 
	select note, s.id stagiaire_id , m.id matiere_id, a.id appreciation_id 
	from tableau t
	join stagiaire s on t.`Nom stagiaire` = s.nom
					and t.`prénom Stagiaire` = s.prenom
	join matiere m on t.Matière = m.nom
	join appreciation a on t.Appréciation=a.nom;

alter table notes add constraint pk_notes primary key (stagiaire_id ,matiere_id, appreciation_id );
alter table notes add constraint fk_notes_stagiaire foreign key (stagiaire_id) references stagiaire(id);
alter table notes add constraint fk_notes_matiere foreign key (matiere_id) references matiere(id);
alter table notes add constraint fk_notes_appreciation foreign key (appreciation_id) references appreciation(id);
          
#suppresion des donnée originaux
drop table tableau; 
