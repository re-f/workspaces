#!/bin/bash

CONFIG_PATH="/shared/workspaces.config"
CONTAINER_ALREADY_STARTED="${CONFIG_PATH}/CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e $CONTAINER_ALREADY_STARTED ]; then
    touch $CONTAINER_ALREADY_STARTED
    echo "-- First container startup --"
    # YOUR_JUST_ONCE_LOGIC_HERE
    # config git
    git config --global user.name "Ref"
    git config --global user.email "z.reg@outlook.com"
    
    # gen ssh key
    ssh_path=${CONFIG_PATH}/.ssh
    mkdir ${ssh_path}

    chmod 700 ${ssh_path}
    ssh-keygen -t rsa -C "z.reg@outlook.com" -f "${ssh_path}/id_rsa" -q -N ""
fi


while true;
do
    sleep 1;
done

