#!/bin/sh

wget https://download.geofabrik.de/europe/france/champagne-ardenne-latest.osm.pbf -O ~/data/champagne-ardenne-latest.osm.pbf
wget https://download.geofabrik.de/europe/france/lorraine-latest.osm.pbf -O ~/data/lorraine-latest.osm.pbf
wget https://download.geofabrik.de/europe/france/nord-pas-de-calais-latest.osm.pbf -O ~/data/nord-pas-de-calais-latest.osm.pbf
wget https://download.geofabrik.de/europe/france/picardie-latest.osm.pbf -O ~/data/picardie-latest.osm.pbf

~/src/osmosis/bin/osmosis --rbf ~/data/champagne-ardenne-latest.osm.pbf \
    --rbf ~/data/lorraine-latest.osm.pbf \
    --rbf ~/data/nord-pas-de-calais-latest.osm.pbf \
    --rbf ~/data/picardie-latest.osm.pbf \
    --merge --merge --merge \
    --wb ~/data/france-merged.osm.pbf
