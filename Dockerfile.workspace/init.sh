#!/bin/bash

CONFIG_PATH="${HOME}/.config"
CONTAINER_ALREADY_STARTED="${CONFIG_PATH}/CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e "${CONTAINER_ALREADY_STARTED}" ]; then
    echo "-- First container startup --"
    echo "# config git"

    if [ ! -e "${CONFIG_PATH}/git/config" ]; then
        git config --global user.name "${name}"
        git config --global user.email "${personal_mail}"
    else
        echo "# ${CONFIG_PATH}/git/config exist ignored config git"
    fi

    echo "# check profile"
    if [ -z "${name}" ]; then
        echo "\${name} is empty, please fill in it in env/profile"
    fi

    ssh_path=${CONFIG_PATH}/ssh
    if [ ! -e "${ssh_path}" ]; then
        echo "# gen ssh key"

        mkdir "${ssh_path}"

        chmod 700 "${ssh_path}"

        ssh-keygen -t rsa -C "${personal_mail}" -f "${ssh_path}/id_rsa" -q -N ""
        ssh-keygen -t rsa -C "${work_mail}" -f "${ssh_path}/id_rsa.company" -q -N ""
    else
        echo "# ${ssh_path} exist ignored config ssh"
    fi

    echo "# download oh-my-zsh"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-

    echo "# download go devel tools"
    go env -w GO111MODULE=on
    go get -x github.com/josharian/impl@latest
    go get -x github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest
    go get -x github.com/ramya-rao-a/go-outline@latest
    go get -x -d github.com/go-delve/delve/cmd/dlv@master
    go get -x github.com/haya14busa/goplay/cmd/goplay@latest
    go get -x honnef.co/go/tools/cmd/staticcheck@latest
    go get -x github.com/go-delve/delve/cmd/dlv@latest
    go get -x golang.org/x/tools/gopls@latest
    go get -x github.com/rogpeppe/godef@latest

    echo "-- First container startup end--"
    touch "${CONTAINER_ALREADY_STARTED}"
fi

while true; do
    sleep 1
done
