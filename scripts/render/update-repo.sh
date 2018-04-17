#!/bin/sh

cd ~/src/openstreetmap-carto-be && \
git fetch --all && \
git reset --hard origin/master && \
git pull origin master
