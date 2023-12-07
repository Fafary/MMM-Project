# Biodivercity

Ce projet consiste à créer une application mobile et son back-end pour simplifier la collecte d'informations sur la faune et la flore par des citoyens, contribuant ainsi à la réalisation d'Atlas de la Biodiversité.

## Auteurs

- Ebor Tilio (alias Tilio)
- Chaplais Alexandre (également 18000328 ou Natyuu)
- Descharraux Julian
- Godin Tilio

### Vidéo de présentation

- [Lien de la vidéo de présentation](https://uniren1-my.sharepoint.com/personal/julian_descharreaux_etudiant_univ-rennes1_fr/_layouts/15/stream.aspx?id=%2Fpersonal%2Fjulian%5Fdescharreaux%5Fetudiant%5Funiv%2Drennes1%5Ffr%2FDocuments%2FEnregistrements%2FAppel%20avec%20Alexandre%20et%202%20autres%2D20231205%5F172330%2DEnregistrement%20de%20la%20r%C3%A9union%2Emp4&ga=1&referrer=StreamWebApp%2EWeb&referrerScenario=AddressBarCopied%2Eview)

### Vidéo de démonstration

- [Lien de la vidéo de démonstration](https://uniren1-my.sharepoint.com/personal/julian_descharreaux_etudiant_univ-rennes1_fr/_layouts/15/stream.aspx?id=%2Fpersonal%2Fjulian%5Fdescharreaux%5Fetudiant%5Funiv%2Drennes1%5Ffr%2FDocuments%2FEnregistrements%2FAppel%20avec%20Alexandre%20et%201%20autre%2D20231206%5F165000%2DEnregistrement%20de%20la%20r%C3%A9union%2Emp4&referrer=StreamWebApp%2EWeb&referrerScenario=AddressBarCopied%2Eview&ga=1)

## Architecture

Le projet est ordonné de façon à avoir un dossier par sujets comme la connexion, la campagne, les fiches et le modèle qui correspond à la partie back.

## Fonctionnalités

### Front-end
1. Authentification utilisateur : Les utilisateurs peuvent se connecter à l'application ou créer un compte.
2. Affichage d'une liste des campagnes d'inventaires avec l'option de recherche d'une campagne.
3. Saisie d'une fiche dans une campagne comprenant les coordonnées GPS, la date, le lieu, l'ajout de photos et une observation.
4. Gestion des fiches : Accès à la liste de toutes les fiches ou bien les fiches personnelles créées dans la campagne.
5. Affichage d'une fiche avec ses données.

### Back-end
1. Stockage de données : Mise en place d'une structure de données pour stocker les campagnes, les fiches (et les photos).
2. Structure des campagnes : Chaque campagne comprend ses données ainsi qu'une liste de documents pour les fiches.
3. Authentification avec Firebase.

### Problèmes rencontrés

1. Mise en place d'une cartographie : la solution logique était d'utiliser Google Map, cependant il fallait rentrer ses coordonnées bancaires.
2. Notifications : Il faut "updgrade" Firebase pour profiter pleinement des notifications, car nous avions seulement la possibilité de recevoir des notifications et non d'en envoyer depuis l'application.
3. Les photos : Pas de problème particulier, cependant prendre le temps de comprendre son fonctionnement pour pouvoir l'implémenter correctement.

## Technologies utilisées

- Flutter
- Dart
- Firebase

## Utilisation

Importez le projet et réaliser les commandes suivantes pour lancer le projet.

```
$ flutter pub get
```
```
$ flutter run
```
