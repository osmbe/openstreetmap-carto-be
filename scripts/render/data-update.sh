#!/bin/sh

# Screen colors using tput
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
RESET=`tput sgr0`

# Update "openstreetmap-carto-be"
echo "${GREEN}Update \"openstreetmap-carto-be\"${RESET}"
cd /home/debian/openstreetmap/openstreetmap-carto-be && \
    git fetch --all && \
    git reset --hard origin/master && \
    git pull origin master

#
cd /home/debian/openstreetmap/

# Clean data
echo "${GREEN}Clean data${RESET}"
rm *.osm.pbf

# Get last version of Europe
echo "${GREEN}Get last version of Europe${RESET}"
wget https://download.geofabrik.de/europe-latest.osm.pbf

# Create Belgium extract
echo "${GREEN}Create Belgium extract${RESET}"
osmosis/bin/osmosis \
    --read-pbf "europe-latest.osm.pbf" \
    --bounding-box top=51.6775 left=2.0112 bottom=49.2299 right=6.9825 \
    --write-pbf file="belgium-bbox.osm.pbf"

# Import data in PostgreSQL
echo "${GREEN}Import data in PostgreSQL${RESET}"
osm2pgsql \
    --cache 5000 --number-processes 2 \
    --slim  --multi-geometry --hstore \
    --host 127.0.0.1 --database openstreetmap --username openstreetmap \
    --style "openstreetmap-carto-be/openstreetmap-carto.style" \
    --tag-transform-script "openstreetmap-carto-be/openstreetmap-carto.lua" \
    --create "belgium-bbox.osm.pbf"

psql \
    --host=127.0.0.1 --username=openstreetmap \
    --dbname=openstreetmap \
    --file="openstreetmap-carto-be/indexes.sql"

psql \
    --host=127.0.0.1 --username=openstreetmap \
    --dbname=openstreetmap \
    --command="ANALYZE; REINDEX DATABASE \"openstreetmap\";"
