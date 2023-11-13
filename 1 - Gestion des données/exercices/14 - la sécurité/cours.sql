#La gestion des utilisateurs
create user 'khalid'@'localhost' identified by '123456789';
drop user if exists 'khalid'@'localhost';
set password for 'khalid'@'localhost' = 'abcdefg';

#attribution des droits
grant all privileges on cuisine_203.* to 'khalid'@'localhost';
revoke all privileges on cuisine_203.* from 'khalid'@'localhost';
grant all privileges on cuisine_203.recettes to 'khalid'@'localhost';
revoke all privileges on cuisine_203.recettes from 'khalid'@'localhost';

#affichage de la liste des droits
show grants for 'khalid'@'localhost';
grant select on cuisine_203.recettes to 'khalid'@'localhost';
grant insert on cuisine_203.recettes to 'khalid'@'localhost';
grant select,insert on cuisine_203.ingredients to 'khalid'@'localhost';
grant select,insert,delete, update on cuisine_203.ingredients to 'khalid'@'localhost';

#attribution des droits sur des champs spécifiques
grant select(numfou, rsfou) on cuisine_203.fournisseur to 'khalid'@'localhost';

#pour donner à un utilisateur le droit de travailler sur une base de données toute entière
#il faut la créer, il ne peut pas la créer lui meme s'il n'a pas tous les droits sur le serveur
create database baseKhalide;
grant all privileges on baseKhalide.* to 'khalid'@'localhost';

#pour rafraichir la list des droits de l'utilisateur connecté
flush privileges;


#Gestion des roles
drop user if exists u1@localhost;
drop user if exists u2@localhost;
drop user if exists u3@localhost;
create user u1@localhost identified by '1234567';
create user u2@localhost identified by '1234567';
create user u3@localhost identified by '1234567';

drop role if exists lecture@localhost;
drop role if exists edition@localhost;

create role lecture@localhost;
create role edition@localhost;

grant select on cuisine_203.* to lecture@localhost;
grant select, update, delete, insert on cuisine_203.* to edition@localhost;



grant lecture@localhost to u1@localhost;
grant edition@localhost to u1@localhost;

grant lecture@localhost to u2@localhost;

grant edition@localhost to u3@localhost;


set default role all to u1@localhost;
set default role all to u2@localhost;
set default role all to u3@localhost;


grant select on vols_203.* to lecture@localhost;

show grants for 'u1'@'localhost';
show grants for lecture@localhost;

show grants for 'u1'@'localhost' using lecture@localhost;

