# Dockerized ZNC v1.6.0

Using the tweard PPA https://launchpad.net/~teward/+archive/ubuntu/znc

## Usage

Init (see https://github.com/znc/znc#setting-up-zncconf ):

```
docker run -ti zimbatm/znc -v $HOME/.znc:/home/znc/.znc --makeconf
```

Then:

```
docker run -d -P zimbatm/znc -v $HOME/.znc:/home/znc/.znc
```


