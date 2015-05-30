#!/bin/sh
set -e
set -x
apt-get update -q
apt-get install -y software-properties-common
add-apt-repository -y ppa:teward/znc
apt-get update -q
apt-get install -qy znc
