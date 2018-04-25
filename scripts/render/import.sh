#!/bin/sh

~/src/openstreetmap-carto-be/scripts/get-shapefiles.py

mkdir -p ~/data && rm -r ~/data/*

sh import-benelux.sh
sh import-france.sh
sh import-germany

~/src/osmosis/bin/osmosis --rbf ~/data/france-merged.osm.pbf \
    --rbf ~/data/germany-merged.osm.pbf \
    --rbf ~/data/benelux-merged.osm.pbf \
    --merge --merge \
    --wb ~/data/merged.osm.pbf

osm2pgsql --database gis --slim --cache 23040 --number-processes 8 --multi-geometry --hstore \
    --style ~/src/openstreetmap-carto-be/openstreetmap-carto.style \
    --tag-transform-script ~/src/openstreetmap-carto-be/openstreetmap-carto.lua \
    --create ~/data/merged.osm.pbf

psql -d gis -f ~/src/openstreetmap-carto-be/indexes.sql
