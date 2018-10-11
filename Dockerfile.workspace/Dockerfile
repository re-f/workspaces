# docker file
FROM ubuntu:16.04

# prepare apt for `add-apt-repository` command
RUN apt-get update --fix-missing
RUN apt-get install -y sudo software-properties-common python-software-properties apt-transport-https vim gcc make

# zsh preparation
RUN apt-get install -y wget zsh git
RUN wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
RUN chmod 777 ./install.sh
RUN sh -c ./install.sh; echo $?
RUN chsh -s `which zsh`

# install golang
RUN apt-get install -y curl
RUN wget https://dl.google.com/go/go1.10.linux-amd64.tar.gz -O /tmp/go1.7.3.linux-amd64.tar.gz 
RUN tar xzC /opt -f /tmp/go1.7.3.linux-amd64.tar.gz
ENV PATH=$PATH:/opt/go/bin

VOLUME [ "/sys/fs/cgroup"]
COPY *.service  /etc/systemd/system/
COPY * /docker-build/

CMD ["/usr/bin/zsh"]
