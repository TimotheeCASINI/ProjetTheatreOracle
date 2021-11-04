REM   Script: tests.sql
REM   Script détaillant les test des fonctionnalités de la BDD.
Tests des triggers, fonctions et procédures.

-- Initialisation des fonctionnalités
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- Test du trigger Shows et Troupes
-- On test le trigger : on observe que l'on ne peut pas ajouter un show pour plusieurs troupes
INSERT INTO Representation (ID_representation, duree, date_debut, ID_troupe, ID_show, ID_theatre) VALUES (0011, 1, '2021-04-18', 0004, 0001, 0007);

-- Test du trigger Rémunération
-- On observe que l'ont ne peut ajouter une représentation que si les tickets existent déjà afin de permettre la mise en place de la rémunération de la troupe.
INSERT INTO Representation (ID_representation, duree, date_debut, ID_troupe, ID_show, ID_theatre) VALUES (0011, 1, '2021-04-18', 0001, 0001, 0007);

-- Test du trigger Superposition des théâtres
-- Ce trigger s'assure qu'un théâtre accueil une représentation par soir.
INSERT INTO Representation (ID_representation, duree, date_debut, ID_troupe, ID_show, ID_theatre) VALUES (0051, 1, '2021-02-22', 0002, 0002, 0002);

-- Test du trigger Superposition des troupes
-- Ce trigger s'assure qu'une troupe ne joue qu'une représentation par soir.
INSERT INTO Representation (ID_representation, duree, date_debut, ID_troupe, ID_show, ID_theatre) VALUES (0051, 1, '2021-01-01', 0001, 0001, 0001);

-- Test du trigger Salaires et Représentation
-- On obsèrve que le trigger Salaires_Shows fonctionne correctement.
SELECT salaires FROM Representation;

-- Test de la procédure des Villes par Troupe
-- Procédure stockée permettant d'obtenir les villes d'une troupe pour une période donnée.
EXECUTE ville_by_troupe(0001, '2021-01-01', '2021-02-01')


EXECUTE ville_by_troupe(0001, '2021-01-01', '2021-03-01')


-- Test de la procédure du prix selon le jours
-- On test la procédure et on obtient le prix du ticket au jour.
EXECUTE price_by_day('2021-02-22')


-- Test de la procédure de distribution des prix
-- Cette procédure retourne la distribution selon les 2 types de prix.
EXECUTE price_by_show(0001)


-- Visualisation avant Insertion
-- On Visualise les données avant l'insertion dans la table date.
SELECT * FROM Troupe;

SELECT * FROM Theatre;

SELECT * FROM Representation;

SELECT * FROM REMUNERER;

insert into date_theatre values ('2021-01-08');

update date_theatre set date_actuelle = '2021-01-07' where date_actuelle = '2021-01-08';

-- Visualisation après Insertion
-- On obsèrve que les données ont été modifiés, les triggers fonctionnent correctement
SELECT * FROM Troupe;

SELECT * FROM Theatre;

SELECT * FROM Representation;

SELECT * FROM REMUNERER;

