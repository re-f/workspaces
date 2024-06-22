FROM ubuntu:20.04

# Prepare apt for `add-apt-repository` command and install initial packages
RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update --fix-missing && \
    apt-get install -y software-properties-common &&\
    add-apt-repository ppa:kelleyk/emacs && \ 
    apt-get update --fix-missing && \
    apt-get install -y sudo apt-transport-https vim gcc make wget zsh git curl libreadline-dev locales && \
    apt-get install -y emacs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# zsh preparation
RUN chsh -s `which zsh` && \
    curl -fsSL https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh -o /tmp/install_ohmyzh.sh && \
    chmod +x /tmp/install_ohmyzh.sh && \
    REPO="mirrors/oh-my-zsh" REMOTE="https://gitee.com/${REPO}.git" sh -c /tmp/install_ohmyzh.sh

COPY .zshrc /root/.zshrc

# install zsh plugin: z.lua
RUN curl -R -O https://www.lua.org/ftp/lua-5.3.6.tar.gz && \
    tar zxf lua-5.3.6.tar.gz && \
    cd lua-5.3.6 && \
    make linux test && \
    make install && \
    git clone https://gitee.com/mirrors/z.lua.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/z.lua 

# install golang
RUN curl -fsSL https://dl.google.com/go/go1.19.1.linux-amd64.tar.gz -o /tmp/go1.19.1.linux-amd64.tar.gz && \
    tar xzC /opt -f /tmp/go1.19.1.linux-amd64.tar.gz && \
    rm /tmp/go1.19.1.linux-amd64.tar.gz

ENV PATH=$PATH:/opt/go/bin
ENV GOPATH=/shared/go-repo

# config ssh
RUN mkdir /root/.ssh/ && chmod 700 /root/.ssh/
COPY ssh.config /root/.ssh/config 

# remove old version python and install new version
RUN add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
    apt-get install -y python3.10 python3.10-distutils && \
    curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10 && \
    update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 && \
    update-alternatives --config python3 

# install locales
RUN apt-get install -y locales && \
    locale-gen en_US.UTF-8 zh_CN.UTF-8 && \
    update-locale LANG=en_US.UTF-8

# verify installation
RUN python3 --version

# add the [inside container] file tag
RUN touch ${HOME}/.container

VOLUME [ "/sys/fs/cgroup"]
COPY *.service /etc/systemd/system/
COPY init.sh /init.sh
RUN chmod 744 /init.sh
COPY * /docker-build/

ENTRYPOINT ["/init.sh"]