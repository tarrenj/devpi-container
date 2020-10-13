#!/usr/bin/env sh
set -ex

sleep 5 # Give aws time to conneect the volume, maybe?

echo "127.0.0.1 pypi.defensemsi.com" >> /etc/hosts

#if [ -z "$(ls -A /home/devpi/.devpi/server/)" ]; then
if [ -z "$(ls -A /data/)" ]; then
    # First start, init repo
    echo "New container detected! Initilizing (local only) server now..."
    # Start the server
    /usr/local/bin/devpi-init
    sleep 2
    usr/local/bin/devpi-server --outside-url http://pypi.tarrenj.com &
    sleep 10

    echo "Repo created, configuring users..." 
    # Configure the server
    /usr/local/bin/devpi use http://localhost:80
    /usr/local/bin/devpi login root --password=""
    /usr/local/bin/devpi user -m root password="${devpi_root_password}"
    /usr/local/bin/devpi user -c DevOps email=jake.tarren@gmail.com password="${devpi_user_password}"
    /usr/local/bin/devpi logout
    /usr/local/bin/devpi login DevOps --password="${devpi_user_password}"
    /usr/local/bin/devpi user -m DevOps description="Ruler of your world"
    /usr/local/bin/devpi index -y -c Dev volatile=False bases=/root/pypi

    /usr/local/bin/devpi logout
    # Let the entrypoint finish causing the entrypoint to stop, next container start it'll start
    # devpi in the forground - There's a weird bug in devpi-server (v5.5.0) that causes auth
    # faulures after process restart, this somehow gets past that...
else
    echo "Existing warehouse detected! Initilizing server now..."
    /usr/local/bin/devpi-server --outside-url https://pypi.tarrenj.com
fi
