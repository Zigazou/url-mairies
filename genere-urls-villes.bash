#!/bin/bash

URLBASE='http://lecomarquage.service-public.fr'
CHEMIN='donnees_locales_v2/all_latest.tar.bz2'
SOURCE='donnees.tar.bz2'

function genere_xml() {
    # Recrée la structure d'un document XML
    echo '<?xml version="1.0" encoding="UTF-8"?>'
    echo '<Organismes>'

    # Concatène tous les fichiers XML des mairies en un seul fichier XML
    tar xjf "$SOURCE" --wildcards --no-anchored --to-stdout 'mairie*.xml' \
        | sed 's/<?xml[^>]*>//g'

    echo '</Organismes>'
}

function besoin_de_telecharger() {
    local diff

    [ ! -f "$SOURCE" ] && return 0

    let "diff = ($(date +%s) - $(date -r $SOURCE +%s)) / ( 3600 * 24 )"
    
    [ $diff -gt 0 ] && return 0

    return 1
}

function telecharger_donnees() {
    wget "$URLBASE/$CHEMINFICHIER" \
        --max-redirect=0 \
        --output-document="$SOURCE" \
        || exit 1
}

# Récupère les données les plus à jour
besoin_de_telecharger && telecharger_donnees

# Extrait les URLs des mairies
genere_xml | xslsproc extrait-urls-vers-csv.xsls - > url-mairies.csv

