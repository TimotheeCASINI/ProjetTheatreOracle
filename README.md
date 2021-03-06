# Projet - Advanced Database - ST2ABD

## Timothée CASINI & Balthazar RAFFY


### Introduction

Ce projet à pour but de mettre en oeuvre les notions vu lors des TP et des CM tels que les Triggers, les User-Type, PL/SQL, l'Héritage, ...

Nous avons choisis d'utiliser le SGBD `Live Oracle` car il s'accorde avec les fonctionnalités que nous devons implémenter

Contenu des dossier :
- `infos`: 
    * `Rapport.pdf` = Le rapport du projet
    * `Projet.pdf` = Le sujet du projet
    * `images` = Dossier contenant les screenshots
    
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
* `infos` : contient le sujet, les screens et le rapport du projet
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

<br> 

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

<br>

On visualise l'ensembles des objets de notre base de données :


![E/R Diagramme](infos/images/ER.png)

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

<br>

On visualise l'ensembles des objets de notre base de données :


![Tables et Procédure du schéma](infos/images/img_objs.jpg)

<br>

### Triggers et Procédures

Les fonctionnalités sont disponibles depuis le script `triggers.sql` situé dans le dossier *scripts*.

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
   
<sub> On doit saisir les tickets avant d'inserer une rémunération puisque cette dernière est calculé en fonction d'une estimation des tickets. </sub>

<br>

* Trigger Shows et Troupes :
   - Trigger qui s'assurer qu'un show est uniquement liée à une et une seule troupe
   - Répond à la contrainte 'chaque cout de production est lié à un show car c'est un cout fixe'

<br>

* Trigger Superposition des Théâtres :
   - Trigger qui s'assure que pour 1 soir on a 1 théâtre = 1 ou 0 représentation
   - Répond à la contrainte 'un théâtre n'acceuille qu'une représentation par soir'

<br>

* Trigger Superposition des Troupes :
   - Trigger qui s'assure que our 1 soir on a 1 troupe = 1 ou 0 représentation
   - Répond à la contrainte 'une troupe ne joue qu'une représentation par soir'

<br>

* Trigger Salaires et Budget :
   - Trigger qui soustrait les salaires pour 1 journée de travail
   - Répond à la contrainte 'chaque jour de représentation les employés sont budget'
   
<sub> Calculé grâce au montant global défini dans les représentation. </sub>

<br>

* Trigger Budget et Rémunération :
   - Ce trigger permet d'ajouter au budget la rémunération pour 1 jour donné.
   - Répond à la contrainte 'le theatre doit payer la troupe qui a effectuer le show'
   
<sub> Ce trigger fonctionne de pair avec celui pour la Rémunération car à chaque fois que la table temps prend la valeur de la date de paiement, les troupes sont payées. </sub>

<br>

* Trigger Budget et Couts de Productions :

   - Ce trigger soustrait les couts de productions le premier soir d'une représentation
   - Répond à la contrainte 'les couts de productions sont réglés le premier soir de représentation'

<br>

* Trigger Budget et Couts de Déplacement:

   - Ce trigger soustrait les couts de déplacements seulement quand les troupes ne sont pas en locale
   - Répond à la contrainte 'les couts de déplacement sont réglés le premier soir de représentation'


<br>

* Trigger des Dons :

   - Permet d'ajouter les dons au budget en fonction de la fréquence
   - Répond à la contraintes des dons selon les fréquences et le type d'institution
   
<sub> Nous avons choisis de représenté l'entité dons comme un don unique et non comme un donnateur. </sub>

<br> 

* Procédure Ville par période :
   - Procédure qui affiche les villes d'une troupe pour une période donnée

* Procédure Prix selon le jour :
   - Cette procédure calcule le prix du billet selon le jour donné

* Procédure Distribution des Prix :
   - Procédure qui retourne la distribution des prix normal réduit selon la représentation donnée
 
<br>

### Insertion des données

Toute les insertions sont disponible depuis le dossier *scripts* dans `insertions.sql`.

On insère les données dans les différentes tables.

**Les tables doivent être remplies en respectant les contraintes verticales et horizontales**

On visualise l'insertion des données : 

- `SELECT * FROM Theatre`
- `SELECT * FROM Representation`

![Tables Théâtre et Représentation](infos/images/img1.jpg)

<br>

- `SELECT * FROM Piece_Theatre`
- `SELECT * FROM Troupe`

![Tables Pièce de Théâtre et Troupe](infos/images/img2.jpg)


<br>

- `SELECT * FROM Ticket`

![Table Ticket](infos/images/img3.jpg)

<br>

- `SELECT * FROM REMUNERER`

![Table de jonction REMUNERER](infos/images/img4.jpg)

<br>

- `SELECT * FROM Employe`

![Table Employé](infos/images/img5.jpg)

<br>

- `SELECT * FROM Spectateur`
- `SELECT * FROM Dons`

![Tables Spectateur et Dons](infos/images/img6.jpg)


<br>

### Test des fonctionnalités

Les tests sont disponible dans `tests.sql` dans le dossier *scripts*.

Maintenant que notre base de données est remplie et nos fonctionnalités operationnelles, nous allons tester les cas extrêmes et s'assurer que les différents traitements sont correctement effectués.

- Test du trigger Shows et Troupes :

   INSERT INTO Representation (ID_representation, duree, date_debut, ID_troupe, ID_show, ID_theatre) VALUES (0011, 1, '2021-04-18', 0004, 0001, 0007)
   => Le show 1 appartient à la troupe 1 donc cette insertion est interdite
   
- Test du trigger Rémunération :

   INSERT INTO Representation (ID_representation, duree, date_debut, ID_troupe, ID_show, ID_theatre) VALUES (0011, 1, '2021-04-18', 0001, 0001, 0007)
   => On ne peut ajouter des représentation que si les tickets existent (sinon la table RÉMUNÉRATION ne peut pas cacluler le prix de paiment à parti des billets)
   
- Test du trigger Superposition des théâtres :

   INSERT INTO Representation (ID_representation, duree, date_debut, ID_troupe, ID_show, ID_theatre) VALUES (0051, 1, '2021-02-22', 0002, 0002, 0002)
   => Le théâtre 2 acceuille déja une représentation ce soir là donc cette insertion est interdite
   
- Test du trigger Superposition des troupes :

   INSERT INTO Representation (ID_representation, duree, date_debut, ID_troupe, ID_show, ID_theatre) VALUES (0051, 1, '2021-01-01', 0001, 0001, 0001)
   => La troupe 1 joue déja une pièce de théatre ce soir là donc cette insetion est interdite
   
- Test du trigger Salaires et Représentation :

   SELECT salaires FROM Representation
   => Le montant des salaires globales c'est correctement icrémenté
   
- Test de la procédure des Villes par Troupe :

   EXECUTE ville_by_troupe(0001, '2021-01-01', '2021-02-01')
   => Procédure stockée permettant d'obtenir les villes d'une troupe pour une période donnée
   
- Test de la procédure du prix selon le jours

   EXECUTE price_by_day('2021-02-22')
   => On test la procédure et on obtient le prix du ticket au jour
   
- Test de la procédure de distribution des prix :

   EXECUTE price_by_show(0001)
   => Cette procédure retourne la distribution selon les 2 types de prix
   

On visualise désormais les modification des budgets selon gestion des coûts, la gestion des tickets, la gestion des dons par rapport à la simulation du temps.

<br>

- `SELECT * FROM Troupe`
- `SELECT * FROM Theatre`

![Table Troupe et Théâtre](infos/images/img11.jpg)

<br>

On incrémente la table Date afin de simuler le temps :

   - `INSERT date_theatre VALUES ('2021-01-08')`
   - `UPDATE date_theatre SET date_actuelle = '2021-01-07' WHERE date_actuelle = '2021-01-08'`

<br>

- `SELECT * FROM Troupe`
- `SELECT * FROM Theatre`

![Table Troupe et Théâtre](infos/images/img12.jpg)

<br>


### Conclusion

Nous avons utilisé différentes notions vues en cours au travers de ce projet.
Certaines difficultés on été rencontrées au niveau de la nuance netre Représentation et Théâtre.
En effet, nous avons eu du mal à définir la gestion du budget entre les différents couts selon un théâtre et une pièce de théâtre.

Certaines améliorations restent à faire, nottament en ce qui concernent les cas extrême des triggers/procédures et les cas d'update/delete.
