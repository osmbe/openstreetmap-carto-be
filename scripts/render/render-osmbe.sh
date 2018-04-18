#!/bin/sh

python -c 'import sys, yaml, json; json.dump(yaml.safe_load(sys.stdin), sys.stdout, indent=4, separators=(",", ": "))' \
    < ~/src/openstreetmap-carto-be/project.mml \
    > ~/src/openstreetmap-carto-be/project.json.mml && \
carto ~/src/openstreetmap-carto-be/project.json.mml > ~/src/openstreetmap-carto-be/mapnik.xml

rm -r /var/lib/mod_tile/osmbe/*

render_list -m osmbe -n 8 -z 0 -Z 7 --all

~/src/render_list_geo.pl/render_list_geo.pl -m osmbe -n 8 -z 8 -Z 18 -x 2.5 -X 6.5 -y 49.4 -Y 51.6

rsync -avz --delete /var/lib/mod_tile/osmbe/ ubuntu@54.38.71.178:/mnt/osmbe/ --progress
