drop database if exists cc2_203;
create database cc2_203;
use cc2_203;

create table centre_sante(
	code_centre int auto_increment primary key
	);
    
create table medecin(code_medecin int auto_increment primary key, 
	nom_medecin varchar(50), 
    code_centre int , 
    constraint fk_medecin_centre foreign key(code_centre) references centre_sante(code_centre)
	);
    
create table ecole(
	code_ecole int auto_increment primary key, 
    nom_ecole varchar(50)
    );
    
create table enfant(
	matricule int auto_increment primary key, 
	nom_enfant varchar(50),
	code_medecin int , 
    code_ecole int , 
    constraint fk_enfant_medecin foreign key(code_medecin) references medecin(code_medecin),
    constraint fk_enfant_ecole foreign key(code_ecole) references ecole(code_ecole)
	);
 
create table vaccin(
	code_vaccin int auto_increment primary key 
		);
        
create table vacciner( 
	matricule int , 
	code_vaccin int,  
	constraint fk_vacciner_enfant foreign key(matricule) references enfant(matricule), 
    constraint fk_vacciner_vaccin foreign key(code_vaccin) references vaccin(code_vaccin)
    );
    


insert into centre_sante values (1),(2),(3);
insert into medecin values (1,'med1',1),(2,'med2',2),(3,'med3',3);
insert into ecole values (1,'ecole1'),(2,'ecole2'),(3,'ecole3');
insert into vaccin values (1),(2),(3);
insert into enfant values (1,'enf1',1,1),(2,'enf2',2,2),(3,'enf3',3,3);
insert into vacciner values (1,1),(1,2),(2,2),(2,3),(3,1),(3,3);


