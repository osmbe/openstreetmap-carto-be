#!/bin/sh

python -c 'import sys, yaml, json; json.dump(yaml.safe_load(sys.stdin), sys.stdout, indent=4, separators=(",", ": "))' \
    < ~/src/openstreetmap-carto-be/project.mml \
    > ~/src/openstreetmap-carto-be/project.json.mml && \
carto ~/src/openstreetmap-carto-be/project.json.mml > ~/src/openstreetmap-carto-be/mapnik.xml

rm -r /var/lib/mod_tile/osmbe/*

render_list -m osmbe -n 8 -a -z  0 -Z  7 -s /var/run/renderd/renderd.sock

render_list -m osmbe -n 8 -a -z  8 -Z  8 -x    129 -X    132 -y    84 -Y    87 -s /var/run/renderd/renderd.sock
render_list -m osmbe -n 8 -a -z  9 -Z  9 -x    258 -X    265 -y   169 -Y   175 -s /var/run/renderd/renderd.sock
render_list -m osmbe -n 8 -a -z 10 -Z 10 -x    517 -X    531 -y   338 -Y   350 -s /var/run/renderd/renderd.sock
render_list -m osmbe -n 8 -a -z 11 -Z 11 -x   1035 -X   1062 -y   676 -Y   701 -s /var/run/renderd/renderd.sock
render_list -m osmbe -n 8 -a -z 12 -Z 12 -x   2070 -X   2125 -y  1353 -Y  1403 -s /var/run/renderd/renderd.sock
render_list -m osmbe -n 8 -a -z 13 -Z 13 -x   4141 -X   4250 -y  2706 -Y  2807 -s /var/run/renderd/renderd.sock
render_list -m osmbe -n 8 -a -z 14 -Z 14 -x   8282 -X   8501 -y  5412 -Y  5614 -s /var/run/renderd/renderd.sock
render_list -m osmbe -n 8 -a -z 15 -Z 15 -x  16564 -X  17002 -y 10824 -Y 11228 -s /var/run/renderd/renderd.sock
render_list -m osmbe -n 8 -a -z 16 -Z 16 -x  33129 -X  34004 -y 21649 -Y 22457 -s /var/run/renderd/renderd.sock
render_list -m osmbe -n 8 -a -z 17 -Z 17 -x  66258 -X  68009 -y 43299 -Y 44915 -s /var/run/renderd/renderd.sock
render_list -m osmbe -n 8 -a -z 18 -Z 18 -x 132516 -X 136019 -y 86599 -Y 89831 -s /var/run/renderd/renderd.sock

rsync -avz --delete /var/lib/mod_tile/osmbe/ ubuntu@54.38.71.178:/mnt/osmbe/ --progress
