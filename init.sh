#!/bin/bash

apt-get install -y openssh-server
service ssh start
su user user.sh
