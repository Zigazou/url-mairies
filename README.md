url-mairies
===========

Script d’extraction des URLs de sites web de mairie à partir des données du
site service-public.fr et plus précisément du fichier 
http://lecomarquage.service-public.fr/donnees_locales_v2/all_latest.tar.bz2

Pré-requis
----------

Le script requiert wget et xslsproc.

xslsproc est disponible sur https://github.com/Zigazou/xslclearer

Le fichier généré
-----------------

Le script génère un fichier url-mairies.csv, utilisant le point-virgule (;)
comme séparateur et ayant 3 colonnes :

- **id**, l’identifiant utilisé dans le fichier source
- **mairie**, l’intitulé complet de la mairie
- **url**, l’adresse du site web de la mairie, si le site existe.

Notes techniques
----------------

Le script tente de créer le moins possible de fichiers temporaires.

Il évite de télécharger plusieurs fois le fichier de données car le site
limite de toute façon les téléchargements à répétition. Le fichier de données
n’est téléchargé à nouveau que si le fichier en local a plus d’une journée.
