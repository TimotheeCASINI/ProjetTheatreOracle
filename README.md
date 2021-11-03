# Projet - Advanced Database - ST2ABD
## Timothée CASINI & Balthazar RAFFY

### Introduction

Ce projet à pour but de mettre en oeuvre les notions vu lors des TP et des CM tels que les Triggers, les User-Type, PL/SQL, l'Héritage, ...

Nous avons choisis d'utiliser le SGBD `Live Oracle` car il s'accorde avec les fonctionnalités que nous devons implémenter


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

### Création des données 
