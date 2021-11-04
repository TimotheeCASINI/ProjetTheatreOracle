REM   Script: creation.sql
REM   Création des instances de la base de données

-- Initialisation de la base de données
-- On défini le format de la date dans la session.
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

DROP TABLE Date_Theatre CASCADE CONSTRAINTS;

-- On supprime les tables si elles existent déjà afin de pouvoir les créer de nouveau. 
DROP TABLE Theatre CASCADE CONSTRAINTS;

DROP TABLE Troupe CASCADE CONSTRAINTS;

DROP TABLE Piece_Theatre CASCADE CONSTRAINTS;

DROP TABLE Representation CASCADE CONSTRAINTS;

DROP TABLE Employe CASCADE CONSTRAINTS;

DROP TABLE Spectateur CASCADE CONSTRAINTS;

DROP TABLE Ticket CASCADE CONSTRAINTS;

DROP TABLE Dons CASCADE CONSTRAINTS;

DROP TABLE REMUNERER CASCADE CONSTRAINTS;

-- Création de la table Théâtre
CREATE TABLE Theatre       
(      
    ID_theatre          INT,      
    nom_theatre         VARCHAR (50),      
    capacite            NUMBER (7,2) NOT NULL,      
    cout_deplacement    NUMBER (7,2) NOT NULL,      
    adresse             VARCHAR (50),    
        
    CONSTRAINT pk_theatre PRIMARY KEY (ID_theatre)    
);

-- Création de la table Troupe
CREATE TABLE Troupe      
(       
    ID_troupe   INT,    
    ID_theatre  INT,    
    nom_troupe  VARCHAR(50),       
    budget      NUMBER(8,2) NOT NULL,       
        
    CONSTRAINT pk_troupe PRIMARY KEY (ID_troupe),    
    CONSTRAINT fk_troupe FOREIGN KEY (ID_theatre) REFERENCES Theatre(ID_theatre),    
    CONSTRAINT check_budget CHECK (budget >= 0)    
);

-- Création de la table Pièce de Théâtre
CREATE TABLE Piece_Theatre       
(        
    ID_show             INT,        
    nom_show            VARCHAR(50),            
    couts_production    NUMBER(8,2) NOT NULL,        
       
    CONSTRAINT pk_piece_theatre PRIMARY KEY (ID_show),   
    CONSTRAINT check_piece_theatre_couts_production CHECK (couts_production >= 0)   
);

-- Création de la table Représentation
CREATE TABLE Representation       
(        
    ID_representation   INT,        
    ID_troupe           INT,      
    ID_show             INT,      
    ID_theatre          INT,    
    duree               INT,        
    date_debut          DATE NOT NULL,      
    salaires            NUMBER(8,2),      
       
    CONSTRAINT pk_representation PRIMARY KEY (ID_representation),      
    CONSTRAINT fk_representation_troupe FOREIGN KEY (ID_troupe) REFERENCES Troupe(ID_troupe),      
    CONSTRAINT fk_representation_show FOREIGN KEY (ID_show) REFERENCES Piece_theatre(ID_show),      
    CONSTRAINT fk_representation_theatre FOREIGN KEY (ID_theatre) REFERENCES Theatre(ID_theatre)      
);

-- Création de la table Employé
CREATE TABLE Employe     
(       
    ID_employe  INT,    
    ID_troupe   INT,    
    nom         VARCHAR(50),    
    type_emploi VARCHAR(50),  
    salaire     NUMBER(7,2) NOT NULL,       
      
    CONSTRAINT pk_employe PRIMARY KEY (ID_employe),     
    CONSTRAINT fk_employe_troupe FOREIGN KEY (ID_troupe) REFERENCES Troupe(ID_troupe),     
    CONSTRAINT check_employe_type CHECK (type_emploi IN ('acteur','staff')),  
    CONSTRAINT check_employe_salaire CHECK (salaire > 0)  
);

-- Création de la table Spectateur
CREATE TABLE Spectateur      
(        
    ID_spectateur   INT,     
    email           VARCHAR(50),     
    statut          VARCHAR(50) NOT NULL,  
      
    CONSTRAINT pk_spectateur PRIMARY KEY (ID_spectateur),    
    CONSTRAINT ck_statut CHECK (statut IN ('normal','reduit'))    
);

-- Création de la table Ticket
CREATE TABLE Ticket        
(          
    ID_ticket       INT,      
    ID_spectateur   INT,      
    ID_theatre      INT,       
    tarif_normal    NUMBER(5,2) NOT NULL,       
    tarif_reduit    NUMBER(5,2) NOT NULL,      
    date_achat      DATE NOT NULL,      
    date_accees     DATE NOT NULL,      
     
    CONSTRAINT pk_ticket PRIMARY KEY (ID_ticket),        
    CONSTRAINT fk_ticket_theatre FOREIGN KEY (ID_theatre) REFERENCES Theatre(ID_theatre),        
    CONSTRAINT fk_ticket_spectateur FOREIGN KEY (ID_spectateur) REFERENCES Spectateur(ID_spectateur),    
    CONSTRAINT check_ticket_tarif_normal CHECK (tarif_normal >= 0),    
    CONSTRAINT check_ticket_tarif_reduit CHECK (tarif_reduit >= 0 AND tarif_reduit < tarif_normal), 
    CONSTRAINT ck_date_achat_ticket CHECK (date_achat <= date_accees)  
);

-- Création de la table Dons
CREATE TABLE Dons       
(          
    ID_don          INT,       
    ID_troupe       INT,      
    nom_donateur    VARCHAR(50),      
    somme_donnee    NUMBER(7) NOT NULL,      
    frequence       INT,       
    date_debut      DATE NOT NULL,       
    date_fin        DATE NOT NULL,      
       
    CONSTRAINT pk_dons PRIMARY KEY (ID_don),          
    CONSTRAINT fk_dons_troupe FOREIGN KEY (ID_troupe) REFERENCES Troupe(ID_troupe)     
);

-- Création de la table RÉMUNÉRER
-- C'est une table de jointure incrémentée automatiquement grâce à un trigger. Elle permet la jonction des informations entre Troupe et Théâtre afin d'assurer la bonne gestion de la base de données lorsque une troupe effectue une représentation à l'exterieur.
CREATE TABLE REMUNERER      
(        
    ID_theatre INT,     
    ID_troupe INT,    
    total NUMBER(8,2) NOT NULL,    
    date_paiement DATE NOT NULL,    
       
    CONSTRAINT pk_remunerer  PRIMARY KEY (ID_theatre,ID_troupe),   
    CONSTRAINT fk_remunerer_theatre FOREIGN KEY (ID_theatre) REFERENCES Theatre(ID_theatre),      
    CONSTRAINT fk_remunerer_troupe FOREIGN KEY (ID_troupe) REFERENCES Troupe(ID_troupe),   
    CONSTRAINT check_remunerer_total CHECK (total >= 0)   
);

-- Création de la table DATE
-- Cette table permet de simuler l'avancé du temps
CREATE TABLE Date_Theatre       
(          
    date_actuelle  DATE 
);

-- Création de la table Temporaire
-- Cette table permet de stocker les troupes et l'argent généré pour un jour donné.
create table temp( 
Salaires int, 
ID_troupe int 
);

