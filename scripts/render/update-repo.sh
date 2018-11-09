#!/bin/sh

# Update "render_list_geo.pl"
cd ~/src/render_list_geo.pl && \
git fetch --all && \
git reset --hard origin/master && \
git pull origin master

# Update "openstreetmap-carto-be"
cd ~/src/openstreetmap-carto-be && \
git fetch --all && \
git reset --hard origin/master && \
git pull origin master
