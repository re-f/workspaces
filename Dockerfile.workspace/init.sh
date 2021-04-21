#!/bin/bash

CONFIG_PATH="${HOME}/.config"
CONTAINER_ALREADY_STARTED="${CONFIG_PATH}/CONTAINER_ALREADY_STARTED_PLACEHOLDER"
if [ ! -e "${CONTAINER_ALREADY_STARTED}" ]; then
    touch "${CONTAINER_ALREADY_STARTED}"
    echo "-- First container startup --"
    # config git
    git config --global user.name "Ref"
    git config --global user.email "z.reg@outlook.com"
    
    # gen ssh key
    ssh_path=${CONFIG_PATH}/.ssh
    mkdir "${ssh_path}"

    chmod 700 "${ssh_path}"
    ssh-keygen -t rsa -C "z.reg@outlook.com" -f "${ssh_path}/id_rsa" -q -N ""

    work_mail=$(cat "${HOME}"/.config/profile/WORK_MAIL)
    ssh-keygen -t rsa -C "${work_mail}" -f "${ssh_path}/id_rsa.company" -q -N ""

    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-
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
fi


while true;
do
    sleep 1;
done

