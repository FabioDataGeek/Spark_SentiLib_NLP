#!/bin/bash

bash Downloads/Anaconda3-2021.11-Linux-x86_64.sh
ssh-keygen -t rsa -P "" 
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod -R go= ~/.ssh
chown -R user:user ~/.ssh
echo 'exit' | ssh localhost
