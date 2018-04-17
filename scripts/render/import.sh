#!/bin/sh

# Check https://gis.stackexchange.com/a/189705 for merging other countries BEFORE loading

~/src/openstreetmap-carto-be/scripts/get-shapefiles.py

mkdir -p ~/data && rm -r ~/data/*

sh import-belgium.sh

psql -d gis -f ~/src/openstreetmap-carto-be/indexes.sql
