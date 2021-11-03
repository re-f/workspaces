#!/bin/bash

CONFIG_PATH="${HOME}/.config"
CONTAINER_ALREADY_STARTED="${CONFIG_PATH}/CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e "${CONTAINER_ALREADY_STARTED}" ]; then
    echo "-- First container startup --"
    echo "# config git"
    git config --global user.name "${name}"
    git config --global user.email "${personal_mail}"

    echo "# check profile"
    if [ -z "${name}" ]; then
        echo "\${name} is empty, please fill in it in env/profile"
    fi

    if [ ! -e "${ssh_path}" ]; then
        echo "# gen ssh key"
        ssh_path=${CONFIG_PATH}/ssh

        mkdir "${ssh_path}"

        chmod 700 "${ssh_path}"

        ssh-keygen -t rsa -C "${personal_mail}" -f "${ssh_path}/id_rsa" -q -N ""
        ssh-keygen -t rsa -C "${work_mail}" -f "${ssh_path}/id_rsa.company" -q -N ""

    fi

    echo "# download oh-my-zsh"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-

    echo "# download go devel tools"
    go env -w GO111MODULE=on
    go get github.com/uudashr/gopkgs/v2/cmd/gopkgs
    go get github.com/ramya-rao-a/go-outline
    go get github.com/cweill/gotests/gotests
    go get github.com/fatih/gomodifytags
    go get github.com/josharian/impl
    go get github.com/haya14busa/goplay/cmd/goplay
    go get github.com/go-delve/delve/cmd/dlv
    go get github.com/go-delve/delve/cmd/dlv@master
    go get honnef.co/go/tools/cmd/staticcheck
    go get golang.org/x/tools/gopls

    echo "-- First container startup end--"
    touch "${CONTAINER_ALREADY_STARTED}"
fi

while true; do
    sleep 1
done
