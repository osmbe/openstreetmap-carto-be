#!/bin/sh

cd ~/src/render_list_geo.pl && \
git fetch --all && \
git reset --hard origin/master && \
git pull origin master

cd ~/src/openstreetmap-carto-be && \
git fetch --all && \
git reset --hard origin/master && \
git pull origin master
