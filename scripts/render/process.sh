#!/bin/sh

sh update-repo.sh

sh import.sh

sudo mkdir -p /var/run/renderd && \
sudo chown $USER /var/run/renderd

renderd -c /usr/local/etc/renderd.conf

sh render-osmbe.sh
sh render-osmbe-fr.sh
sh render-osmbe-nl.sh
