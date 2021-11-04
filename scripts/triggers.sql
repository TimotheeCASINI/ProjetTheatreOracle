REM   Script: triggers.sql
REM   Création des fonctionnalités pour la gestion de la base de données au travers de différents triggers, fonctions et procédures stockées

-- Trigger Représentation et Salaire
-- Trigger qui ajoute la somme des salaires des employés de la troupe de théâtre effectuant la pièce de théâtre associée à cette représentation. Cette somme ne varie d'une représentation à une autre que si le nombre d'employé augmente/diminue entre 2 représentations.
CREATE OR REPLACE TRIGGER Salaires_Representation  
BEFORE INSERT ON Representation FOR EACH ROW      
DECLARE    
    somme_salaire Employe.salaire%type;      
BEGIN      
    SELECT SUM(salaire) INTO somme_salaire FROM Employe WHERE ID_troupe = :NEW.ID_troupe;      
    :NEW.salaires := somme_salaire;      
EXCEPTION      
    WHEN NO_DATA_FOUND     
    THEN somme_salaire := 0;      
END;  
/

-- Trigger pour la Rémunération
-- Ce trigger insère insère les lignes de la table RÉMUNÉRATION à chaque insertion dans la table Représentation. Ainsi, à chaque fois que le temps est = a la date de paiement définie (1er jour de représentation) on ajoute le paiement au budget de la troupe.
CREATE OR REPLACE TRIGGER Remuneration        
After INSERT ON Representation FOR EACH ROW          
DECLARE        
    prix Ticket.tarif_normal%type;    
    taille Theatre.capacite%type;    
    prix_tot int;    
BEGIN          
    SELECT DISTINCT tarif_normal INTO prix FROM Ticket WHERE ID_theatre = :NEW.ID_theatre AND date_accees >=:New.date_debut AND date_accees <= (:New.date_debut + :New.duree);    
    SELECT capacite INTO taille FROM Theatre WHERE ID_theatre = :NEW.ID_theatre;    
    prix_tot := prix *0.5*taille;    
    INSERT INTO Remunerer VALUES (:New.ID_theatre,:New.ID_troupe, prix_tot, :New.date_debut);  
    EXCEPTION  
        WHEN NO_DATA_FOUND  
        THEN raise_application_error(-20002,'Veuillez saisir des tickets avant d''ajouter une représentation !' );  
END;
/

-- Trigger Shows et Troupes
-- Trigger qui test si un show est bien lié à une unique troupe.
CREATE OR REPLACE TRIGGER Shows_Troupes         
BEFORE INSERT ON Representation FOR EACH ROW            
DECLARE          
    troupe Representation.ID_troupe%type;      
    troupe_exception EXCEPTION;     
     
BEGIN            
    SELECT DISTINCT ID_troupe INTO troupe FROM Representation WHERE ID_troupe != :NEW.ID_troupe AND ID_show = :NEW.ID_show;     
         
    IF (troupe IS NOT NULL) THEN         
        RAISE troupe_exception;         
    END IF;         
    EXCEPTION         
        WHEN troupe_exception THEN raise_application_error(-20002,'Les shows sont liee a une seule troupe !' );      
        WHEN NO_DATA_FOUND THEN      
        :NEW.ID_show := :NEW.ID_show;      
END;   
/

-- Trigger Superposition des theatres
-- Ce trigger s'assure qu'un théâtre n'acceuille qu'une représentation par soir.
CREATE OR REPLACE TRIGGER Superposition_theatre  
BEFORE INSERT ON Representation FOR EACH ROW  
DECLARE  
    date_proche_moins representation.date_debut%type;  
    date_proche_plus representation.date_debut%type;  
    durr_moins representation.duree%type;  
    err1 EXCEPTION;  
BEGIN  
    SELECT date_debut, duree INTO date_proche_moins,durr_moins FROM representation WHERE date_debut <= :NEW.date_debut AND ID_theatre = :NEW.ID_theatre ORDER BY date_debut DESC FETCH FIRST 1 ROWS ONLY;  
     
    IF (:NEW.Date_debut <= date_proche_moins + durr_moins  ) THEN  
        RAISE err1;  
     
    END IF;  
    SELECT date_debut INTO date_proche_plus FROM representation WHERE date_debut >= :NEW.date_debut AND ID_theatre = :NEW.ID_theatre ORDER BY date_debut ASC FETCH FIRST 1 ROWS ONLY;  
     
    IF (:NEW.Date_debut + :New.duree >= date_proche_plus  )THEN  
        RAISE err1;  
    END IF;  
     
    EXCEPTION  
        WHEN err1 THEN  
        raise_application_error (-20000,'Un theatre ne peut acceullir qu une representation par soir !');  
        WHEN NO_DATA_FOUND THEN 
        :NEW.Date_debut := :NEW.date_debut;  
END;
/

-- Trigger Superposition des troupes
-- Ce trigger s'assure qu'une troupe ne joue qu'une représentation par soir.
CREATE OR REPLACE TRIGGER Superposition_troupe             
BEFORE INSERT ON Representation FOR EACH ROW               
DECLARE             
    date_proche_moins representation.date_debut%type;       
    date_proche_plus representation.date_debut%type;       
    durr_moins representation.duree%type;       
    err1 EXCEPTION;        
       
BEGIN             
    SELECT date_debut,duree INTO date_proche_moins,durr_moins FROM representation WHERE date_debut <= :NEW.date_debut AND ID_troupe = :NEW.ID_troupe ORDER BY date_debut DESC FETCH FIRST 1 ROWS ONLY;        
    IF (:NEW.Date_debut <= date_proche_moins + durr_moins)  
        THEN RAISE err1;       
    END IF; 
     
    SELECT date_debut INTO date_proche_plus FROM representation WHERE date_debut >= :NEW.date_debut AND ID_troupe = :NEW.ID_troupe ORDER BY date_debut ASC FETCH FIRST 1 ROWS ONLY;  
    IF (:NEW.Date_debut + :NEW.duree >= date_proche_plus) 
        THEN RAISE err1;       
    END IF;     
        
    EXCEPTION       
        WHEN err1 THEN      
        raise_application_error (-20000,'Une troupe ne peut jouer qu une representation par soir !');       
        WHEN NO_DATA_FOUND THEN     
        :NEW.Date_debut := :NEW.date_debut;      
END;
/

-- Procédure Villes par période
-- Procédure qui affiche les villes d'une troupe pour une période donnée.
CREATE OR REPLACE PROCEDURE ville_by_troupe(troupe INT, debut DATE, fin DATE) 
IS 
 
adresses Theatre.adresse%TYPE; 
BEGIN 
 
FOR c IN (SELECT adresse INTO adresses FROM Theatre T JOIN Representation R ON R.ID_theatre = T.ID_theatre JOIN Troupe ON Troupe.ID_troupe = R.ID_troupe WHERE Troupe.ID_troupe = troupe AND R.date_debut >= debut AND (R.date_debut + R.duree) <= fin) LOOP    
    adresses := c.adresse; 
    dbms_output.put_line(adresses); 
END LOOP; 
 
 
    EXCEPTION 
        WHEN OTHERS THEN 
        raise_application_error(-20001,'Une erreur est survenue - '||SQLCODE||' -ERROR- '||SQLERRM); 
END;
/

-- Procédure Prix selon le jour
-- Cette procédure calcule le prix du billet selon le jour donné.
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- Procédure Prix selon le jour
-- Cette procédure calcule le prix du billet selon le jour donné.
CREATE OR REPLACE PROCEDURE price_by_day (jour DATE) 
IS 
prix Ticket.tarif_normal%TYPE; 
BEGIN 
 
SELECT tarif_normal INTO prix FROM Ticket WHERE Ticket.date_accees = jour fetch first 1 rows only; 
dbms_output.put_line('Le prix du billet est de ' || prix || '€'); 
 
    EXCEPTION 
        WHEN OTHERS THEN 
        raise_application_error(-20001,'Une erreur est survenue - '||SQLCODE||' -ERROR- '||SQLERRM); 
END;
/

-- Procédure Distribution des prix
-- Procédure qui retourne la distribution des prix normal réduit selon la représentation donnée.
CREATE OR REPLACE PROCEDURE price_by_show (show INT) 
IS 
prix_normal Ticket.tarif_normal%TYPE; 
prix_reduit Ticket.tarif_reduit%TYPE; 
dt Representation.date_debut%TYPE; 
BEGIN 
 
SELECT date_debut INTO dt FROM Representation WHERE ID_Representation = show; 
 
FOR c IN (SELECT COUNT(nrml) as ct INTO prix_normal FROM (SELECT tarif_normal AS nrml FROM Ticket Tk JOIN Spectateur Sp ON Tk.ID_Spectateur = Sp.ID_Spectateur WHERE Sp.statut = 'normal' AND Tk.date_accees = dt)) LOOP    
    prix_normal := c.ct; 
    dbms_output.put_line('Le nombre de prix normal est de : ' || prix_normal); 
END LOOP; 
 
FOR c IN (SELECT COUNT(red) AS ct INTO prix_reduit FROM (SELECT tarif_reduit AS red FROM Ticket Tk JOIN Spectateur Sp ON Tk.ID_Spectateur = Sp.ID_Spectateur WHERE Sp.statut = 'reduit' AND Tk.date_accees = dt)) LOOP    
    prix_reduit := c.ct; 
    dbms_output.put_line('Le nombre de prix réduit est de : ' || prix_reduit); 
END LOOP; 
 
    EXCEPTION 
        WHEN OTHERS THEN 
        raise_application_error(-20001,'Une erreur est survenue - '||SQLCODE||' -ERROR- '||SQLERRM); 
END;
/

-- Trigger Salaire Budget
-- Trigger qui soustrait les salaires pour 1 journée de travail.
CREATE OR REPLACE TRIGGER budget_salaire 
AFTER update ON date_theatre for each row 
BEGIN 
Insert into TEMP(salaires,ID_troupe) 
SELECT Salaires, ID_troupe 
FROM Representation 
WHERE date_debut <= :New.date_actuelle and date_debut + duree >= :New.date_actuelle; 
UPDATE Troupe set budget = budget - ( SELECT salaires FROM Temp WHERE TEMP.ID_troupe = Troupe.ID_troupe) WHERE EXISTs (SELECT ID_troupe FROM Temp WHERE Troupe.ID_troupe = Temp.ID_troupe); 
Delete temp; 
END;
/

-- Trigger Budget et Rémunération
-- Ce trigger permet d'ajouter au budget la rémunération pour 1 jour donné.
CREATE OR REPLACE TRIGGER budget_remuneration 
AFTER update ON date_theatre for each row 
BEGIN 
Insert into TEMP(salaires,ID_troupe) 
SELECT Total, ID_troupe 
FROM Remunerer 
WHERE date_paiement= :New.date_actuelle ; 
UPDATE Troupe set budget = budget + ( SELECT salaires FROM Temp WHERE TEMP.ID_troupe = Troupe.ID_troupe) WHERE EXISTs (SELECT ID_troupe FROM Temp WHERE Troupe.ID_troupe = Temp.ID_troupe); 
Delete temp; 
END;
/

-- Trigger Budget et Couts de Production
-- Ce trigger soustrait les couts de productions le premier soir d'une représentation.
CREATE OR REPLACE TRIGGER budget_cout_prod 
AFTER update ON date_theatre for each row 
BEGIN 
Insert into TEMP(salaires,ID_troupe) 
SELECT couts_production, ID_troupe 
FROM Representation R inner join Piece_theatre pt on R.ID_show=pt.ID_show 
WHERE date_debut= :New.date_actuelle ; 
UPDATE Troupe set budget = budget - ( SELECT salaires FROM Temp WHERE TEMP.ID_troupe = Troupe.ID_troupe) WHERE EXISTs (SELECT ID_troupe FROM Temp WHERE Troupe.ID_troupe = Temp.ID_troupe); 
Delete temp; 
END;
/

-- Trigger Budget et Couts de déplacement
-- Ce trigger soustrait les couts de déplacements seulement quand les troupes ne sont pas en locale.
CREATE OR REPLACE TRIGGER budget__cout_deplacement 
AFTER update ON date_theatre for each row 
BEGIN 
Insert into TEMP(salaires,ID_troupe) 
SELECT cout_deplacement, ID_troupe 
FROM Representation R inner join theatre th on R.ID_theatre=th.ID_theatre 
WHERE date_debut= :New.date_actuelle ; 
UPDATE Troupe set budget = budget - ( SELECT salaires FROM Temp WHERE TEMP.ID_troupe = Troupe.ID_troupe) WHERE EXISTs (SELECT ID_troupe FROM Temp WHERE Troupe.ID_troupe = Temp.ID_troupe); 
Delete temp; 
END;
/

-- Trigger Budget et Couts de déplacement
-- Ce trigger soustrait les couts de déplacements seulement quand les troupes ne sont pas en locale.
CREATE OR REPLACE TRIGGER budget__cout_deplacement 
AFTER update ON date_theatre for each row 
BEGIN 
Insert into TEMP(salaires,ID_troupe) 
SELECT cout_deplacement, ID_troupe 
FROM Representation R inner join theatre th on R.ID_theatre=th.ID_theatre 
WHERE date_debut= :New.date_actuelle ; 
UPDATE Troupe set budget = budget - ( SELECT salaires FROM Temp WHERE TEMP.ID_troupe = Troupe.ID_troupe) WHERE EXISTs (SELECT ID_troupe FROM Temp WHERE Troupe.ID_troupe = Temp.ID_troupe); 
Delete temp; 
END;
/

-- Trigger des Dons
-- Permet d'ajouter les dons au budget en fonction de la fréquence.
CREATE OR REPLACE TRIGGER budget_dons 
AFTER update ON date_theatre for each row 
BEGIN 
Insert into TEMP(salaires,ID_troupe) 
SELECT Somme_donnee, ID_troupe 
FROM dons 
WHERE date_debut= :New.date_actuelle or ADD_months(date_debut,frequence)=:New.date_actuelle and date_fin >= :New.date_actuelle; 
UPDATE Troupe set budget = budget + ( SELECT salaires FROM Temp WHERE TEMP.ID_troupe = Troupe.ID_troupe) WHERE EXISTs (SELECT ID_troupe FROM Temp WHERE Troupe.ID_troupe = Temp.ID_troupe); 
Delete temp; 
END;
/

