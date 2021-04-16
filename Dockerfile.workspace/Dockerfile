# docker file
FROM ubuntu:16.04

# prepare apt for `add-apt-repository` command
RUN apt-get update --fix-missing
RUN apt-get install -y sudo software-properties-common python-software-properties apt-transport-https vim gcc make

# zsh preparation
RUN apt-get install -y wget zsh git curl
COPY zsh_install.sh install.sh 
RUN chmod 777 ./install.sh
RUN sh -c ./install.sh; echo $?
RUN chsh -s `which zsh`
COPY .zshrc /root/.zshrc
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


# install golang
RUN apt-get install -y curl
RUN wget https://dl.google.com/go/go1.10.linux-amd64.tar.gz -O /tmp/go1.7.3.linux-amd64.tar.gz 
RUN tar xzC /opt -f /tmp/go1.7.3.linux-amd64.tar.gz
ENV PATH=$PATH:/opt/go/bin

# config git
RUN git config --global user.name "Ref" 
RUN git config --global user.email "z.reg@outlook.com"

# config ssh
RUN mkdir /root/.ssh/
RUN chmod 700 /root/.ssh/
COPY ssh.config /root/.ssh/config 

VOLUME [ "/sys/fs/cgroup"]
COPY *.service  /etc/systemd/system/
COPY init.sh /init.sh
RUN chmod 744 /init.sh
COPY * /docker-build/



ENTRYPOINT ["/init.sh"]
