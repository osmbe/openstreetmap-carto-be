#!/bin/sh

# Check https://gis.stackexchange.com/a/189705 for merging other countries BEFORE loading

~/src/openstreetmap-carto-be/scripts/get-shapefiles.py

sh ~/src/openstreetmap-carto-be/import-belgium.sh

psql -d gis -f ~/src/openstreetmap-carto-be/indexes.sql
