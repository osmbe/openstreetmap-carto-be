#!/bin/sh

# Generate "mapnik.xml"
python -c 'import sys, yaml, json; json.dump(yaml.safe_load(sys.stdin), sys.stdout, indent=4, separators=(",", ": "))' \
    < ~/src/openstreetmap-carto-be/project.mml \
    > ~/src/openstreetmap-carto-be/project.json.mml && \
carto ~/src/openstreetmap-carto-be/project.json.mml > ~/src/openstreetmap-carto-be/mapnik.xml

# Start "renderd"
renderd -c /usr/local/etc/renderd.conf

# Delete existing tiles (if any)
rm -r /var/lib/mod_tile/osmbe/*

# Render levels 0-8 (no bounding box)
render_list -m osmbe -n 8 -z 0 -Z 7 --all

# Render levels 9-18 (bounding box)
~/src/render_list_geo.pl/render_list_geo.pl -m osmbe -n 8 -z 8 -Z 18 -x 2.5 -X 6.5 -y 49.4 -Y 51.6

# Copy the new tiles on tile server
rsync -avz --delete /var/lib/mod_tile/osmbe/ ubuntu@54.38.71.178:/mnt/osmbe/ --progress
