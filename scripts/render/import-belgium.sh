#!/bin/sh

mkdir -p ~/data && \
cd ~/data && \
rm ~/data/* && \
wget https://download.geofabrik.de/europe/belgium-latest.osm.pbf && \
osm2pgsql --database gis --slim --cache 23040 --number-processes 8 --multi-geometry --hstore \
  --style ~/src/openstreetmap-carto-be/openstreetmap-carto.style \
  --tag-transform-script ~/src/openstreetmap-carto-be/openstreetmap-carto.lua \
  --create ~/data/belgium-latest.osm.pbf
