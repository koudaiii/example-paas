FROM ubuntu:13.10

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y vim 
RUN apt-get clean

RUN mkdir -p /root/.ssh; chmod 700 /root/.ssh
RUN echo "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
ADD ./id_rsa.docker-paas /root/.ssh/id_rsa
RUN chmod 700 /root/.ssh/id_rsa

RUN apt-get -y install build-essential
RUN apt-get install -y ruby
RUN apt-get install -y curl
RUN apt-get install -y libssl-dev
RUN apt-get install -y libssl0.9.8
 
 ## install buildpacks
RUN mkdir /var/lib/buildpacks
RUN cd /var/lib/buildpacks && git clone https://github.com/heroku/heroku-buildpack-ruby

ADD ./exec-release.rb /var/lib/buildpacks/exec-release.rb
RUN chmod 755 /var/lib/buildpacks/exec-release.rb

EXPOSE 8080

#FROM koudaiii/example-paas
#
#MAINTAINER koudaiiii "cs006061@gmail.com"
#
#
#RUN apt-get update
#RUN apt-get install -y git
#RUN apt-get clean
#
#RUN mkdir -p /root/.ssh; chmod 700 /root/.ssh
#RUN echo "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config
#ADD ./authorized_keys /root/.ssh/id_rsa
#RUN chmod 700 /root/.ssh/id_rsa
#
##RUN ssh-keygen -t rsa
##RUN cat /root/.ssh/id_rsa.pub >> /home/koud/.ssh/authorized_keys
#
### install buildpacks
#RUN mkdir /var/lib/buildpacks
#RUN cd /var/lib/buildpacks && git clone https://github.com/heroku/heroku-buildpack-ruby
#
#ADD ./exec-release.rb /var/lib/buildpacks/exec-release.rb
#RUN chmod 755 /var/lib/buildpacks/exec-release.rb
