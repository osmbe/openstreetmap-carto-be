#!/bin/sh

wget https://download.geofabrik.de/europe/germany/nordrhein-westfalen-latest.osm.pbf -O ~/data/nordrhein-westfalen-latest.osm.pbf
wget https://download.geofabrik.de/europe/germany/rheinland-pfalz-latest.osm.pbf -O ~/data/rheinland-pfalz-latest.osm.pbf
wget https://download.geofabrik.de/europe/germany/saarland-latest.osm.pbf -O ~/data/saarland-latest.osm.pbf

~/src/osmosis/bin/osmosis --rbf ~/data/nordrhein-westfalen-latest.osm.pbf \
    --rbf ~/data/rheinland-pfalz-latest.osm.pbf \
    --rbf ~/data/saarland-latest.osm.pbf \
    --merge --merge \
    --wb ~/data/germany-merged.osm.pbf
