# Dockerized ZNC v1.6.0

Using the tweard PPA https://launchpad.net/~teward/+archive/ubuntu/znc

## Usage for a single machine

```sh
# As root
sudo -i
# Create a znc user to hold the data on the machine:
useradd -m znc
# Init the ZNC config
# see https://github.com/znc/znc#setting-up-zncconf
docker run --rm --read-only -v /home/znc/.znc:/home/znc/.znc --user $(id -u znc):$(id -g znc) -ti zimbatm/znc --makeconf

# Then run it by hand to test:
docker run --rm --read-only -v /home/znc/.znc:/home/znc/.znc --user $(id -u znc):$(id -g znc) -p 6667:6667 -ti zimbatm/znc

# Finally install the upstart script:
cat <<UPSTART > /etc/init/znc.conf
description     "ZNC"
start on runlevel [2345]
stop on runlevel [!2345]

respawn
respawn limit 10 5
console log

pre-start exec /usr/bin/docker pull zimbatm/znc
exec /usr/bin/docker run --rm --read-only -v /home/znc/.znc:/home/znc/.znc --user $(id -u znc):$(id -g znc) -p 6667:6667 zimbatm/znc
UPSTART

start znc
```

Enjoy !


