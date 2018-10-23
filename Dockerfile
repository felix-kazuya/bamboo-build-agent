FROM atlassian/bamboo-agent-base
USER root
ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install composer -y 
RUN apt-get update 
RUN apt-get install apt-utils -y
RUN apt-get install maven -y 
RUN apt-get install git -y
RUN apt-get install maven
RUN apt-get install build-essential -y
RUN apt-get install ant -y
RUN apt-get install ruby -y
RUN apt-get install ruby-dev -y
RUN apt-get install lib32z1 -y
RUN apt-get install lib32z1-dev -y
RUN apt-get install lib32z1 -y
RUN apt-get install lib32ncurses5 -y
RUN apt-get install libc6-i386 -y
RUN apt-get install lib32stdc++6 -y
RUN apt-get install lib32gcc1 -y
RUN apt-get install curl -y
RUN apt-get install libfontconfig1 -y
RUN apt-get install libfontconfig1-dev -y
RUN apt-get install libfreetype6 -y
RUN apt-get install libfreetype6-dev -y
RUN apt-get install python-dev -y
RUN apt-get install libxml2-dev -y
RUN apt-get install libxslt-dev -y
RUN apt-get install phpunit -y
RUN apt-get install sass -y
#RUN apt-get install ok -y
RUN apt-get install zip -y
RUN apt-get install unzip -y
RUN apt-get install software-properties-common -y
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer
RUN apt-get install python -y
#RUN apt-get install python-pip3 -y
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get install docker-ce -y

#RUN apt-get install docker-engine -y
#RUN pip install --upgrade pip
#RUN pip install --upgrade virtualenv
#RUN pip install --upgrade docker-py 

USER ${BAMBOO_USER}
RUN ${BAMBOO_USER_HOME}/bamboo-update-capability.sh "system.builder.mvn3.Maven 3.3" /usr/share/maven
RUN ${BAMBOO_USER_HOME}/bamboo-update-capability.sh "system.git.executable" /usr/bin/git
RUN usermod -a -G docker bamboo
