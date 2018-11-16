#!/bin/sh

DIRECTORY=`dirname $0`

cd $DIRECTORY

# Screen colors using tput
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
RESET=`tput sgr0`

# Update "openstreetmap-carto-be" and "render_list_geo.pl"
echo "${YELLOW}Update repositories${RESET}"
sh update-repo.sh

# Render
if [ $# -eq 0 ]; then
    echo "${YELLOW}Launch render: \"osmbe\"${RESET}"
    sh "render-osmbe.sh"
elif [ -f "render-osmbe-$1.sh" ]; then
    echo "${YELLOW}Launch render: \"osmbe-$1\"${RESET}"
    sh "render-osmbe-$1.sh"
else
    echo "${RED}Version \"$1\" not available !${RESET}"
fi
