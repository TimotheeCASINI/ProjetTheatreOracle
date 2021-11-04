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
Les diagrammes correspondants sont dans disponbile le dossier *graphs* qui contient les 3 fichiers des modèles et les diagrammes en PDF.

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


### Création des tables

Le sript de création des tables est disponible dans le dossier *scripts* sous le nom `creation.sql`.

On créer les 9 tables ci-dessus en veilant à respecter les contraintes de clés primaires/étrangères. À celà s'ajoute des tables spécifiques et différentes contraintes `CHECK` qui permettent d'appliquer des contraintes horizontales :

- Les tables sont en 3ème forme normale
- Contraintes de clés primaires et clés étrangères
- Tout montant, budget, salaire est supérieur ou égale à 0
- La date d'achat d'un ticket est nécéssairement inférieur ou égale à la date d'acces
- Création d'une table de jointure pour la rémunération des troupes
- Création d'une table de temps pour la simulation du temps
- Création d'une table temporelle afin de stocker les troupes et l'argent généré pour un jour donné


### Triggers et Procédures

Afin de d'obtenir une bonne gestion de la BDD, on créer différents triggers et procédures afin d'appliquer plusieurs contraintes verticales.
Cela va permettre de mettre en oeuvre plusieurs traitements sur nos tables mais également assurer le respect des contraintes indiquées par le sujet.

<br>

* Trigger Représentation et Salaires :
   - Trigger qui ajoute la somme des salaires des employés de la troupe de théâtre effectuant la pièce de théâtre associée à cette représentation
   - Répond à la contrainte du montant global des salaires pour la gestion des paiement des employés
   
<sub> Le montant total est indiqué à chaque représentation et non selon le show. </sub>
<sub> Cette somme ne varie d'une représentation à une autre que si le nombre d'employé augmente/diminue entre 2 représentations. </sub>

<br>

* Trigger pour la Rémunération :
   - Ce trigger insère insère les lignes de la table de jointure RÉMUNÉRATION à chaque insertion dans la table Représentation
   - Répond à la contrainte 'à chaque fois que le temps est = a la date de paiement définie (1er jour de représentation) on ajoute le paiement au budget de la troupe'
   
<sub> On doit saisir les tickets avant d'inserer une rémunération puisque cette dernière est calculé en fonction d'une estimation des tickets </sub>

<br>

* Trigger Shows et Troupes :
   - Trigger qui s'assurer qu'un show est uniquement liée à une et une seule troupe
   - Répond à la contrainte 'chaque cout de production est lié à un show'

<br>

* Trigger Superposition des Théâtres :
   - Trigger qui s'assure que pour 1 soir on a 1 théâtre = 1 ou 0 représentation
   - Répond à la contrainte 'un théâtre n'acceuille qu'une représentation par soir'

<br>

* Trigger Superposition des Troupes :
   - Trigger qui s'assure que our 1 soir on a 1 troupe = 1 ou 0 représentation.
   - Répond à la contrainte 'une troupe ne joue qu'une représentation par soir'

<br>

* Trigger Salaires et Budget :
   - Trigger qui soustrait les salaires pour 1 journée de travail
   - Répond à la contrainte 'chaque jour de représentation les employés sont budget'
   
<sub> Calculé grâce au montant global défini dans les représentation </sub>

<br>

* Trigger Budget et Rémunération :
   - Ce trigger permet d'ajouter au budget la rémunération pour 1 jour donné.
   - Répond à la contrainte 'le theatre doit payer la troupe qui a effectuer le show'
   
<sub> Ce trigger fonctionne de pair avec celui pour la Rémunération car à chaque fois que la table temps prend la valeur de la date de paiement, les troupes sont payées. </sub>

<br>

* Trigger Budget et Couts de Productions :




