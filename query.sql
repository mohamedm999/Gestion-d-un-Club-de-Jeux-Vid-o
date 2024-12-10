
-- Requêtes de Base

-- Lister les informations de tous les membres (pseudo, e-mail, date d'inscription).
select * from membre ;

-- Afficher la liste des jeux disponibles, avec leur titre, genre, et studio de développement.
select jeu.titre,jeu.genre,jeu.studio_developpement,jeu.genre from jeu ;

-- Afficher les détails d'un tournoi spécifique à partir de son nom.
select * from tournoi where nom_tournoi like "Fortnite%" ;

-- Lister les emprunts en cours, incluant le pseudo du membre et le titre du jeu.
select Emprunter.*,membre.pseudo as membre_pseudo,jeu.titre as jeu_titre from Emprunter 
left join membre on (Emprunter.membre_id = membre.idM) right join jeu on (Emprunter.jeu_id = jeu.idJ);

-- Requêtes avec Jointures

-- Lister les membres ayant participé à un tournoi, avec leur pseudo, le nom du tournoi, et leur rang final.
select e.pseudo,t.nom_tournoi,p.rang_final from membre e inner join participer p on (e.idM = p.membre_id ) inner join tournoi t on (p.tournoi_id = t.idT);

-- Trouver les membres qui ont souscrit à un abonnement annuel.
select * from membre where idM in (select abonnement.idMember from abonnement  where type_abonnement = "annuel" );

-- Trouver les jeux empruntés par un membre spécifique (via son pseudo).
select m.pseudo as membre_pseudo,jeu.titre as jeu_titre from Emprunter 
left join membre m on (Emprunter.membre_id = m.idM) right join jeu on (Emprunter.jeu_id = jeu.idJ)
where  m.pseudo = "john_doe";

-- Lister tous les emprunts, en incluant le pseudo du membre et les informations sur le jeu (titre et studio de développement).
select Emprunter.*,m.pseudo,j.titre,j.studio_developpement from Emprunter 
left join membre m on (Emprunter.membre_id = m.idM) right join jeu j on (Emprunter.jeu_id = j.idJ) ;

-- Afficher la liste des membres et le type d'abonnement auquel ils sont associés.
select m.*,a.type_abonnement from membre m inner join abonnement a on (m.idM = a.idMember);

-- Requêtes avec Agrégation

-- Calculer le nombre total de jeux disponibles par genre.
select genre,count(*) as total from  jeu group by genre ;

-- Trouver le tournoi avec le plus grand nombre de participants.
select * from tournoi t where t.idT in (select count(tournoi_id) from participer group by tournoi_id having count(tournoi_id) > 1 );

-- Afficher le nombre d'emprunts réalisés par chaque membre.
select membre_id,count(id) as nombre_emprunts from Emprunter e group by membre_id ;

-- Requêtes avec Filtres et Tri.

select * from jeu where jeu.annee_sortie > "2014" order by jeu.titre  asc;

select * from membre where idM in (select Emprunter.membre_id from Emprunter where Emprunter.date_retour_reelle is null );

select * from tournoi t where t.date_tournoi between '2024-06-10'and '2024-09-05';

select * from membre where idM in (select count(membre_id) from Emprunter group by membre_id  having count(membre_id ) > 1 ) ;
