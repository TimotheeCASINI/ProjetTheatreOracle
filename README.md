# Projet - Advanced Database - ST2ABD

## Timothée CASINI & Balthazar RAFFY


### Introduction

Ce projet à pour but de mettre en oeuvre les notions vu lors des TP et des CM tels que les Triggers, les User-Type, PL/SQL, l'Héritage, ...

Nous avons choisis d'utiliser le SGBD `Live Oracle` car il s'accorde avec les fonctionnalités que nous devons implémenter

Contenu des dossier :
- `infos`: 
    * `Rapport.pdf` = Le rapport du projet
    * `Projet.pdf` = Le sujet du projet
    
- `graphs`:
    * `Projet.mdj` = E/R Diagramme (StartUML)
    * `MCD.mcd` = MCD (Jmerise)
    * `MLD.mcd` = MLD (Jmerise)
    * `Diagrammes.pdf` = Les diagrammes liées au projet
    
- `scripts`:
    * `creation.sql` = Création de la base de donnée
    * `triggers.sql` = Ensembles des triggers, fonction et procédures pour les fonctionnalités de la BDD
    * `insertions.sql` = Insertion des instances de la base de données
    * `test.sql` = Réalisation de divers test pour vérifier les fonctionnalités
     
#### Objectifs

L'objectif de ce projet est de simuler une base de données de gestion de troupes de théâtres.

Nous allons créer la base de données, insérer les données et la peupler, puis créer les fonctionnalités nécéssaires à travers différents triggers, fonctions et séléctions.

Le dossier se décompose en 3 dossier :
* `infos` : contient le sujet et le rapport du projet
* `graphs`: contient les différents graphiques (MCD, MLD, E/R)
* `scripts` : contient les scripts nécessaire à la réalisation du projet

#### Contraintes

Plusieurs contraintes orientent notre conception de la BDD mais certaines notions comme la gestion des dons, les calculs budgétaire, la gestion des tickets ainsi que la mise en place des contraintes de temps sont des choix libres.

Les contraintes sont les suivantes :
- Gestion des coûts (salaires, productions, déplacement)
- Gestion des tickets (réductions, rémunération)
- Gestion des dons (fréquences, durée)
- Gestion du temps (paiements, tickets, dons)
- Gestion des troupes et des représentations (1 troupe ne peut pas assurer 2 représentation à la fois)
- Gestion des pièce de théâtre et du théâtre(1 théâtre ne peut pas acceuilir + d'une pièce de théâtre à la fois)

### Création du modèle relationnel

Afin d'élaborder correctement notre BDD, nous allons construire le MCD et le E/R Diagramme puis en déduire le MLD.
Les diagrammes correspondants sont dans le dossier `graphs` qui contient les 3 fichiers des modèles et les diagrammes en PDF.

On trouve ainsi le modèle relationnel suivant :

- Troupe(**id_troupe**, nom_troupe, budget, *id_theatre*)

- Theatre(**id_theatre**, nom_theatre, capacite, adresse, couts_deplacement)

- PieceTheatre(**id_show**, nom_show, couts_production)

- Representation(**id_representation**, duree, date_debut, *id_troupe*, *id_theatre*, *id_show*)

- Spectateur(**id_spectateur**, email, reduction)

- Ticket(**id_ticket**, tarif_normal, tarif_reduit, date_achat, date_acces, *id_spectateur*, *id_theatre*)

- Dons(**id_don**, nom_donnateur, somme, frequence, date_debut, date_fin, *id_troupe*)

- Employe(**id_employe**, nom, type, salaire, *id_troupe*)

- REMUNERER(***id_theatre***, ***id_troupe***, date_paiement, total)
