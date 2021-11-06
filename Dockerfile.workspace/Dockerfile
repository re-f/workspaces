# docker file
FROM ubuntu:16.04

# prepare apt for `add-apt-repository` command
RUN apt-get update --fix-missing
RUN apt-get install -y sudo software-properties-common python-software-properties apt-transport-https vim gcc make

# zsh preparation
RUN apt-get install -y wget zsh git curl
RUN chsh -s `which zsh`
RUN curl -fsSL https://gitee.com/mirrors/oh-my-zsh/raw/master/tools/install.sh -o /tmp/install_ohmyzh.sh
RUN chmod +x /tmp/install_ohmyzh.sh
RUN REPO="mirrors/oh-my-zsh" REMOTE="https://gitee.com/${REPO}.git" sh -c /tmp/install_ohmyzh.sh
COPY .zshrc /root/.zshrc

# install zsh plugin: z.lua, zsh-autosuggestions
RUN apt-get install -y libreadline-dev
RUN curl -R -O http://www.lua.org/ftp/lua-5.3.5.tar.gz
RUN tar zxf lua-5.3.5.tar.gz
RUN cd lua-5.3.5 && make linux test && make install
RUN git clone https://gitee.com/mirrors/z.lua.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/z.lua
# RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions


# install golang
RUN apt-get install -y curl
RUN curl -fsSL https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz -o /tmp/go1.14.1.linux-amd64.tar.gz 
RUN tar xzC /opt -f /tmp/go1.14.1.linux-amd64.tar.gz
ENV PATH=$PATH:/opt/go/bin
ENV GOPATH=/shared/go-repo

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