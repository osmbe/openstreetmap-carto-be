#!/bin/sh

# Screen colors using tput
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
RESET=`tput sgr0`

# Download latest Shapefiles
echo "${GREEN}Download latest Shapefiles${RESET}"
~/src/openstreetmap-carto-be/scripts/get-shapefiles.py

# Generate "mapnik.xml"
echo "${GREEN}Generate \"mapnik-fr.xml\"${RESET}"
carto ~/src/openstreetmap-carto-be/project-fr.mml > ~/src/openstreetmap-carto-be/mapnik-fr.xml

# Start "renderd"
echo "${GREEN}Start renderd${RESET}"
sudo mkdir /var/run/renderd
sudo chown $USER /var/run/renderd
renderd -c /usr/local/etc/renderd.conf

# Delete existing tiles (if any)
echo "${GREEN}Delete existing tiles (if any)${RESET}"
rm -r /var/lib/mod_tile/osmbe-fr/*

# Render levels 0-8 (no bounding box)
echo "${GREEN}Render levels 0-8 (no bounding box)${RESET}"
render_list -m osmbe-fr -n 8 -z 0 -Z 7 --all

# Render levels 9-18 (bounding box)
echo "${GREEN}Render levels 9-18 (bounding box)${RESET}"
~/src/render_list_geo.pl/render_list_geo.pl -m osmbe-fr -n 8 -z 8 -Z 18 -x 2.5 -X 6.5 -y 49.4 -Y 51.6

# Copy the new tiles on tile server
echo "${GREEN}Copy the new tiles on tile server${RESET}"
rsync -avz --delete /var/lib/mod_tile/osmbe-fr/ ubuntu@54.38.71.178:/mnt/osmbe-fr/ --progress
