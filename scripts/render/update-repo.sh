#!/bin/sh

wget https://github.com/alx77/render_list_geo.pl/blob/master/render_list_geo.pl -O ~/src/render_list_geo.pl

cd ~/src/openstreetmap-carto-be && \
git fetch --all && \
git reset --hard origin/master && \
git pull origin master
