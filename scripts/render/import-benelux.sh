#!/bin/sh

wget https://download.geofabrik.de/europe/belgium-latest.osm.pbf -O ~/data/belgium-latest.osm.pbf
wget https://download.geofabrik.de/europe/luxembourg-latest.osm.pbf -O ~/data/luxembourg-latest.osm.pbf
wget https://download.geofabrik.de/europe/netherlands-latest.osm.pbf -O ~/data/netherlands-latest.osm.pbf

~/src/osmosis/bin/osmosis --rbf ~/data/luxembourg-latest.osm.pbf \
    --rbf ~/data/netherlands-latest.osm.pbf \
    --rbf ~/data/belgium-latest.osm.pbf \
    --merge --merge \
    --wb ~/data/benelux-merged.osm.pbf
