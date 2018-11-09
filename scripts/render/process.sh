#!/bin/sh

# Update "openstreetmap-carto-be" and "render_list_geo.pl"
sh update-repo.sh

#
sudo mkdir -p /var/run/renderd && \
sudo chown $USER /var/run/renderd

# Render
if [ $# -eq 0 ]; then
    sh render-osmbe.sh
elif [ -f "render-osmbe-$1.sh" ]; then
    sh "render-osmbe-$1.sh"
else
    echo "Version \"$1\" not available !"
fi
