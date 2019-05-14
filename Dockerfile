FROM ubuntu:latest

MAINTAINER MEEEEE

RUN apt-get update && apt-get upgrade -y && apt-get install apt-utils -y

RUN apt-get install openssh-server nginx -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install php7.2 php7.2-fpm python3 python3-pip -y

RUN mkdir /var/run/sshd
RUN echo 'root:immortal1' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && sed -i 's/#Port 22/Port 72/' /etc/ssh/sshd_config && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile && service ssh reload && service ssh restart
CMD ["/usr/sbin/sshd", "-D"]
