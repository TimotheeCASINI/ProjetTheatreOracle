REM   Script: insertions.sql
REM   Insertion des données dans les différentes instances de la base de données

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

INSERT INTO Theatre (ID_theatre, nom_theatre, capacite, adresse, cout_deplacement) VALUES (0001, 'Le Canard qui Boite', 50, '1 Rue des Moulins, Lyon', 350);

INSERT INTO Theatre (ID_theatre, nom_theatre, capacite, adresse, cout_deplacement) VALUES (0002, 'Le Nain Jaune', 350, '42 bd des chataignes, Le Mans', 325.99);

INSERT INTO Theatre (ID_theatre, nom_theatre, capacite, adresse, cout_deplacement) VALUES (0003, 'Le Supremator', 2500, '3 place de la Victoire, Beauvais', 400);

INSERT INTO Theatre (ID_theatre, nom_theatre, capacite, adresse, cout_deplacement) VALUES (0004, 'Mogador',1600, '25 rue Mogador, Paris', 600);

INSERT INTO Theatre (ID_theatre, nom_theatre, capacite, adresse, cout_deplacement) VALUES (0005, 'Le théâtre des Nymphes', 600, '12 rue Medicis, Montpellier', 350);

INSERT INTO Theatre (ID_theatre, nom_theatre, capacite, adresse, cout_deplacement) VALUES (0006, 'Le Moutardier',550, '5 Place Platon, Dijon', 270);

INSERT INTO Theatre (ID_theatre, nom_theatre, capacite, adresse, cout_deplacement) VALUES (0007, 'Théâtre la menthe',1150, '14 rue de guignol, Poitier', 170);

INSERT INTO Troupe (ID_troupe, nom_troupe, budget, ID_theatre) VALUES (0001, 'Les Farfadets de Limoges', 30000, 0003);

INSERT INTO Troupe (ID_troupe, nom_troupe, budget, ID_theatre) VALUES (0002, 'Les Empereurs du Rire', 65000, 0001);

INSERT INTO Troupe (ID_troupe, nom_troupe, budget, ID_theatre) VALUES (0003, 'Les Dramaturges de l''Espace', 100000, 0004);

INSERT INTO Troupe (ID_troupe, nom_troupe, budget, ID_theatre) VALUES (0004, 'Les Troubadours de l''Hilarité', 25000, 0007);

INSERT INTO Troupe (ID_troupe, nom_troupe, budget, ID_theatre) VALUES (0005, 'Les Incroyables Illuminés', 45000, 0006);

INSERT INTO Troupe (ID_troupe, nom_troupe, budget, ID_theatre) VALUES (0006, 'A vos marques, prêt, jouez', 62000, 0002);

INSERT INTO Troupe (ID_troupe, nom_troupe, budget, ID_theatre) VALUES (0007, 'La moqueurs champètres', 62000, 0002);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0001, 'Castex', 'staff', 60, 0001);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0002, 'Bobby', 'acteur', 120, 0001);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0003, 'Fernandes', 'acteur', 110, 0001);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0004, 'Alberto', 'acteur', 110, 0001);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0005, 'Bernard', 'staff', 70.95, 0001);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0006, 'Didier', 'staff', 79.95, 0002);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0007, 'Robert', 'staff', 69.95, 0002);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0008, 'Jeanne', 'acteur', 147, 0002);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0009, 'Bastien', 'acteur', 110, 0002);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0010, 'Loucas', 'acteur', 119, 0002);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0011, 'Ferdinant', 'staff', 55.87, 0003);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0012, 'Gaston', 'staff', 58.15, 0003);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0013, 'Olivier', 'acteur', 75, 0003);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0014, 'Olive', 'acteur', 87, 0003);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0015, 'Popeye', 'acteur', 65, 0004);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0016, 'Steve', 'acteur', 60, 0004);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0017, 'Esteban', 'acteur', 65, 0004);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0018, 'Violette', 'staff', 110, 0004);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0019, 'Alexandre', 'staff', 10, 0005);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0020, 'Alex', 'staff', 9, 0005);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0021, 'Axel', 'staff', 7, 0005);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0022, 'Constantin', 'acteur', 77.86, 0005);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0023, 'Constantine', 'acteur', 77.85, 0005);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0024, 'Valentin', 'acteur', 75, 0005);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0025, 'Valentine', 'acteur', 79, 0005);

INSERT INTO Employe (ID_employe, nom, type_emploi, salaire, ID_troupe)  VALUES (0026, 'Eric', 'acteur', 1, 0006);

INSERT INTO Piece_Theatre (ID_show, nom_show, couts_production) VALUES (0001, 'La flûte enchantée', 500);

INSERT INTO Piece_Theatre (ID_show, nom_show, couts_production) VALUES (0002, 'Le fantome de l''opéra', 550.50);

INSERT INTO Piece_Theatre (ID_show, nom_show, couts_production) VALUES (0003, 'Le jeu de l''amour et du hasard', 760);

INSERT INTO Piece_Theatre (ID_show, nom_show, couts_production) VALUES (0004, 'Cyrano de Bergerac', 449);

INSERT INTO Piece_Theatre (ID_show, nom_show, couts_production) VALUES (0005, 'Don Juan', 275);

INSERT INTO Piece_Theatre (ID_show, nom_show, couts_production) VALUES (0006, 'Début de Partie', 444);

INSERT INTO Piece_Theatre (ID_show, nom_show, couts_production) VALUES (0007, 'La cantatrice chauve', 620);

INSERT INTO Dons (ID_don, nom_donateur, somme_donnee, frequence, date_debut, date_fin, ID_troupe) VALUES (0001, 'Fondation Louis Vuitton', 50000, null, '2021-01-01', '2021-01-01', 0001);

INSERT INTO Dons (ID_don, nom_donateur, somme_donnee, frequence, date_debut, date_fin, ID_troupe) VALUES (0002, 'Mairie du Mans', 10000, 2, '2021-01-01', '2021-12-01', 0006);

INSERT INTO Dons (ID_don, nom_donateur, somme_donnee, frequence, date_debut, date_fin, ID_troupe) VALUES (0003, 'Ministère de la culture', 100000, 12, '2021-01-01', '2024-01-01', 0002);

INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0001, 'jean.louis@hotmail.fr', 'normal');

INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0002, 'fr444@hotmail.fr', 'reduit');

INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0003, null, 'normal');

INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0004, null, 'normal');

INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0005, null, 'normal');

INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0006, null, 'normal');

INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0007, null, 'reduit');

INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0008, null, 'reduit');

INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0009, 'david@efrei.net', 'reduit');

INSERT INTO Spectateur (ID_spectateur, email, statut) VALUES (0010, 'salome@wanadoo.com', 'normal');

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0001, 10, 7.50, '2020-12-18', '2021-01-01', 0001, 0001);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0002, 10, 7.50, '2020-12-12', '2021-01-01', 0002, 0001);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0003, 10, 7.50, '2020-12-25', '2021-01-01', 0003, 0001);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0004, 10, 7.50, '2020-12-10', '2021-01-01', 0004, 0001);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0005, 10, 7.50, '2020-12-19', '2021-01-01', 0005, 0001);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0006, 10, 7.50, '2020-12-22', '2021-01-02', 0006, 0001);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0007, 10, 7.50, '2020-12-23', '2021-01-02', 0007, 0001);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0008, 10, 7.50, '2020-12-20', '2021-01-02', 0008, 0001);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0009, 10, 7.50, '2020-12-29', '2021-01-03', 0009, 0001);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0010, 10, 7.50, '2020-12-22', '2021-01-03', 0010, 0001);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0011, 12, 8.50, '2020-12-22', '2021-01-07', 0001, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0012, 12, 8.50, '2020-12-21', '2021-01-07', 0002, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0013, 12, 8.50, '2020-12-15', '2021-01-07', 0003, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0014, 12, 8.50, '2020-12-19', '2021-01-07', 0004, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0015, 12, 8.50, '2020-12-18', '2021-01-08', 0005, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0016, 12, 8.50, '2020-12-19', '2021-01-08', 0006, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0017, 12, 8.50, '2020-12-11', '2021-01-08', 0007, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0018, 9, 7, '2021-01-19', '2021-02-13', 0008, 0007);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0019, 9, 7, '2021-01-19', '2021-02-13', 0009, 0007);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0020, 9, 7, '2021-01-19', '2021-02-13', 0001, 0007);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0021, 9, 7, '2021-01-19', '2021-02-13', 0002, 0007);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0022, 9, 7, '2021-01-19', '2021-02-13', 0003, 0007);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0023, 9, 7, '2021-01-18', '2021-02-13', 0004, 0007);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0024, 9, 7, '2021-01-10', '2021-02-13', 0005, 0007);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0025, 7, 5.99, '2021-01-19', '2021-02-09', 0006, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0026, 7, 5.99, '2021-01-19', '2021-02-09', 0007, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0027, 7, 5.99, '2021-01-19', '2021-02-09', 0010, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0028, 7, 5.99, '2021-01-15', '2021-02-10', 0001, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0029, 7, 5.99, '2021-01-09', '2021-02-10', 0002, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0030, 7, 5.99, '2021-02-04', '2021-02-10', 0003, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0031, 7, 5.99, '2021-01-19', '2021-02-10', 0004, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0032, 7, 5.99, '2021-01-19', '2021-02-10', 0005, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0033, 8, 5.99, '2021-01-19', '2021-02-22', 0001, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0034, 8, 5.99, '2021-01-11', '2021-02-22', 0002, 0002);

INSERT INTO Ticket (ID_ticket, tarif_normal, tarif_reduit, date_achat, date_accees, ID_spectateur, ID_theatre) VALUES (0035, 8, 5.99, '2021-01-12', '2021-02-22', 0003, 0002);

INSERT INTO Representation (ID_representation, duree, date_debut, ID_troupe, ID_show, ID_theatre) VALUES (0001, 3, '2021-01-01', 0001, 0001, 0001);

INSERT INTO Representation (ID_representation, duree, date_debut, ID_troupe, ID_show, ID_theatre) VALUES (0002, 2, '2021-01-07', 0002, 0002, 0002);

INSERT INTO Representation (ID_representation, duree, date_debut, ID_troupe, ID_show, ID_theatre) VALUES (0004, 1, '2021-02-13', 0004, 0004, 0007);

INSERT INTO Representation (ID_representation, duree, date_debut, ID_troupe, ID_show, ID_theatre) VALUES (0006, 2, '2021-02-09', 0006, 0006, 0002);

INSERT INTO Representation (ID_representation, duree, date_debut, ID_troupe, ID_show, ID_theatre) VALUES (0007, 1, '2021-02-22', 0001, 0001, 0002);

SELECT * FROM Theatre;

-- Vérification de la table Représentation
SELECT * FROM Representation;

SELECT * FROM Piece_Theatre;

SELECT * FROM Troupe;

SELECT * FROM Ticket;

SELECT * FROM REMUNERER;

