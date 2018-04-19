#!/bin/sh

sh update-repo.sh

sh import.sh

sudo mkdir -p /var/run/renderd && \
sudo chown $USER /var/run/renderd

if [ $# -eq 0 ]; then
    sh render-osmbe.sh
elif [ -f "render-osmbe-$1.sh" ]; then
    sh "render-osmbe-$1.sh"
else
    echo "Version \"$1\" not available !"
fi
