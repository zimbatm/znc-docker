# Dockerized ZNC v1.6.0

Using the tweard PPA https://launchpad.net/~teward/+archive/ubuntu/znc

This container has some state and only works well on a single machine.

## Setup

First we need to create a data volume to contain the persistent data.

### Create the config from scatch

Init the [ZNC config](https://github.com/znc/znc#setting-up-zncconf).

Select "no" when it asks if you want to start ZNC.

```sh
docker run --name znc-data -ti zimbatm/znc --makeconf
```

### Import existing config from the host

If you have existing config, here is a way to import it into the container:

```sh
# Start data volume
docker run --name znc-data -d --entrypoint bash zimbatm/znc
cd /home/youruser
# Import data
tar cf - .znc | docker exec znc-data tar xf -
# Stop data volume
docker stop znc-data
```

### Then test the main container

```sh
docker run --rm --read-only --volumes-from znc-data -p 6667:6667 -ti zimbatm/znc
```

### Finally install the upstart script
cat <<UPSTART > /etc/init/znc.conf
description     "ZNC"
start on runlevel [2345]
stop on runlevel [!2345]

respawn
respawn limit 10 5
console log

pre-start exec /usr/bin/docker pull zimbatm/znc
exec /usr/bin/docker run --rm --read-only --volumes-from znc-data -p 6667:6667 zimbatm/znc
UPSTART

start znc
```

Enjoy !


