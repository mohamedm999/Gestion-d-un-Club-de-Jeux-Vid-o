create database club ;
use club ;

CREATE TABLE MEMBRE (
    idM INT PRIMARY KEY AUTO_INCREMENT,
    pseudo VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    date_inscription DATE NOT NULL
);

CREATE TABLE ABONNEMENT (
    idA INT PRIMARY KEY AUTO_INCREMENT,
    type_abonnement VARCHAR(50) NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL ,
    idMember INT ,
	FOREIGN KEY (idMember) REFERENCES MEMBRE(idM) ON DELETE CASCADE
);

CREATE TABLE JEU (
    idJ INT PRIMARY KEY AUTO_INCREMENT,
    titre VARCHAR(100) NOT NULL,
    studio_developpement VARCHAR(100),
    annee_sortie YEAR NOT NULL,
    genre VARCHAR(50),
    multijoueur BOOLEAN NOT NULL
);

CREATE TABLE TOURNOI (
    idT INT PRIMARY KEY AUTO_INCREMENT,
    nom_tournoi VARCHAR(100) NOT NULL UNIQUE,
    date_tournoi DATE NOT NULL,
    recompenses VARCHAR(200)
);

-- drop table TOURNOI ;

CREATE TABLE Emprunter (
    id int primary key auto_increment ,
    membre_id INT NOT NULL ,
    jeu_id INT NOT NULL ,
    date_emprunt DATE NOT NULL,
    date_retour_prevue DATE NOT NULL,
    date_retour_reelle DATE,
    UNIQUE (membre_id, jeu_id), 
    FOREIGN KEY (membre_id) REFERENCES MEMBRE(idM) ON DELETE CASCADE,
    FOREIGN KEY (jeu_id) REFERENCES JEU(idJ) ON DELETE CASCADE
);
drop table Emprunter ;

CREATE TABLE Participer (
    membre_id INT NOT NULL,
    tournoi_id INT NOT NULL,
    score INT NOT NULL,
    rang_final INT,
    PRIMARY KEY (membre_id, tournoi_id),
    FOREIGN KEY (membre_id) REFERENCES MEMBRE(idM) ON DELETE CASCADE,
    FOREIGN KEY (tournoi_id) REFERENCES TOURNOI(idT) ON DELETE CASCADE
);

INSERT INTO MEMBRE (pseudo, email, date_inscription) VALUES
('john_doe', 'john.doe@example.com', '2024-01-15'),
('jane_smith', 'jane.smith@example.com', '2023-11-30'),
('mike_williams', 'mike.williams@example.com', '2024-03-01'),
('emily_jones', 'emily.jones@example.com', '2023-10-25'),
('lucas_brown', 'lucas.brown@example.com', '2023-08-17'),
('ava_green', 'ava.green@example.com', '2024-05-12'),
('liam_davis', 'liam.davis@example.com', '2023-11-05'),
('sophie_lee', 'sophie.lee@example.com', '2023-09-22');


INSERT INTO ABONNEMENT (type_abonnement, date_debut, date_fin, idMember) VALUES 
('annuel', '2023-01-01', '2023-12-31', 1),
('annuel', '2024-01-01', '2024-12-31', 2),
('mensuel', '2024-12-01', '2024-12-31', 3),
('mensuel', '2024-11-01', '2024-11-30', 4),
('mensuel', '2024-10-01', '2024-10-31', 5),
('hebdomadaire', '2024-12-01', '2024-12-07', 6),
('hebdomadaire', '2024-11-15', '2024-11-21', 7),
('hebdomadaire', '2024-11-22', '2024-11-28', 8);





INSERT INTO JEU (titre, studio_developpement, annee_sortie, genre, multijoueur) VALUES
('Game of Thrones: The Game', 'Telltale Games', 2014, 'Aventure', false),
('Fortnite', 'Epic Games', 2017, 'Action', true),
('Minecraft', 'Mojang Studios', 2011, 'Aventure', true),
('The Witcher 3: Wild Hunt', 'CD Projekt', 2015, 'RPG', false),
('Red Dead Redemption 2', 'Rockstar Games', 2018, 'Action', false),
('Call of Duty: Warzone', 'Infinity Ward', 2020, 'Shooter', true),
('FIFA 23', 'EA Sports', 2022, 'Sports', true),
('Animal Crossing: New Horizons', 'Nintendo', 2020, 'Simulation', true);


INSERT INTO TOURNOI (nom_tournoi, date_tournoi, recompenses) VALUES
('Fortnite Championship', '2024-06-10', 'Cash prize, Trophies'),
('Minecraft Build-Off', '2024-07-20', 'Gift cards, Exclusive skins'),
('The Witcher Tournament', '2024-08-15', 'Cash prize, Merchandise'),
('Game of Thrones Quiz', '2024-09-05', 'Gift cards, Trophies'),
('Red Dead Redemption 2 Showdown', '2024-10-15', 'Cash prize, Merchandise'),
('Call of Duty: Warzone Battle', '2024-11-10', 'Gift cards, Trophies'),
('FIFA 23 World Cup', '2024-12-20', 'Trophies, Exclusive skins'),
('Animal Crossing Villager Contest', '2024-08-30', 'Gift cards, Limited edition items');


INSERT INTO Emprunter (membre_id, jeu_id, date_emprunt, date_retour_prevue, date_retour_reelle) VALUES
(1, 2, '2024-02-01', '2024-02-15', '2024-02-14'),
(2, 1, '2024-02-20', '2024-03-05', '2024-03-04'),
(3, 3, '2024-03-10', '2024-03-24', NULL),
(3, 5, '2024-03-10', '2024-03-24', NULL),
(3, 2, '2024-03-10', '2024-03-24', NULL),
(4, 4, '2024-04-01', '2024-04-15', NULL),
(5, 5, '2024-06-05', '2024-06-19', NULL),
(6, 6, '2024-05-10', '2024-05-25', NULL),
(7, 7, '2024-06-15', '2024-06-30', '2024-06-28'),
(8, 8, '2024-07-01', '2024-07-15', '2024-07-13');



INSERT INTO Participer (membre_id, tournoi_id, score, rang_final) VALUES
(1, 1, 90, 2),
(2, 2, 85, 1),
(3, 3, 75, 3),
(4, 4, 95, 1),
(5, 5, 80, 4),
(6, 6, 92, 1),
(7, 7, 70, 5),
(8, 8, 85, 2);


select * from membre ;

select jeu.titre,jeu.genre,jeu.studio_developpement,jeu.genre from jeu ;

select * from membre where idM in (select abonnement.idMember from abonnement  where type_abonnement = "annuel" );

select * from tournoi where nom_tournoi like "Fortnite%" ;

select Emprunter.*,membre.pseudo as membre_pseudo,jeu.titre as jeu_titre from Emprunter 
left join membre on (Emprunter.membre_id = membre.idM) right join jeu on (Emprunter.jeu_id = jeu.idJ);

select * from jeu where jeu.annee_sortie > "2014" order by jeu.titre  asc;

select * from membre where idM in (select Emprunter.membre_id from Emprunter where Emprunter.date_retour_reelle is null );

select * from tournoi t where t.date_tournoi between '2024-06-10'and '2024-09-05';

select * from membre where idM in (select count(membre_id) from Emprunter group by membre_id  having count(membre_id ) > 1 ) ;

select genre,count(*) as total from  jeu group by genre ;

select * from tournoi t where t.idT in (select count(tournoi_id) from participer group by tournoi_id having count(tournoi_id) > 1 );

select membre_id,count(id) as nombre_emprunts from Emprunter e group by membre_id ;

select e.pseudo,t.nom_tournoi,p.rang_final from membre e inner join participer p on (e.idM = p.membre_id ) inner join tournoi t on (p.tournoi_id = t.idT);

select m.pseudo as membre_pseudo,jeu.titre as jeu_titre from Emprunter 
left join membre m on (Emprunter.membre_id = m.idM) right join jeu on (Emprunter.jeu_id = jeu.idJ)
where  m.pseudo = "john_doe";

select Emprunter.*,m.pseudo,j.titre,j.studio_developpement from Emprunter 
left join membre m on (Emprunter.membre_id = m.idM) right join jeu j on (Emprunter.jeu_id = j.idJ) ;

select m.*,a.type_abonnement from membre m inner join abonnement a on (m.idM = a.idMember);














