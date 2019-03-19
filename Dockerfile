FROM atlassian/bamboo-agent-base
USER root
ENV TERM=xterm
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update 
RUN apt-get install composer -y 
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
RUN apt-get update
RUN apt-get install python-pip -y
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
RUN apt-get update
RUN apt-get install docker-ce -y

#RUN apt-get install docker-engine -y
RUN pip install --upgrade pip
RUN pip install --upgrade virtualenv
RUN pip install --upgrade docker-py 
RUN usermod -a -G docker bamboo

RUN export DEBIAN_FRONTEND=noninteractive yes
RUN apt-get update 
RUN apt-get install apache2 -y
RUN apt-get install libapache2-mod-auth-kerb -y
RUN apt-get install  libapache2-mod-php -y
RUN apt-get install  php -y
RUN apt-get install  php-mysql -y
RUN apt-get install  php-intl -y 
RUN apt-get install php-ldap -y 
RUN apt-get install php7.2-mysql -y 
RUN apt-get install libapache2-mod-php7.2 -y
# RUN apt-get install php7.0-mcrypt -y 
RUN apt-get install php7.2-curl -y
RUN apt-get install  php7.2-xml -y 
RUN apt-get install php7.2-mbstring -y 
RUN apt-get install php7.2-zip -y
RUN apt-get install  php7.2-ldap -y

RUN ln -sf /proc/self/fd/1 /var/log/apache2/access.log \
      && ln -sf /proc/self/fd/1 /var/log/apache2/error.log \
      && ln -sf /proc/self/fd/1 /var/log/apache2/ssl_access.log \
      && ln -sf /proc/self/fd/1 /var/log/apache2/other_vhosts_access.log \
      && a2dismod auth_kerb php7.2 \
      && phpdismod mysqli zip xml ldap mcrypt curl mbstring


RUN export DEBIAN_FRONTEND=noninteractive yes \
    && apt-get update \
    && apt-get install composer -y \
    && phpenmod mysqli zip xml ldap mcrypt curl mbstring

RUN echo '#!/bin/bash' >> /bin/ok
RUN echo 'echo ok' >> /bin/ok
RUN chmod +x /bin/ok


RUN echo '#!/bin/bash' >> /usr/local/bin/ok
RUN echo 'echo ok' >> /usr/local/bin/ok
RUN chmod +x /usr/local/bin/ok

RUN apt-get install ansible -y

RUN sh -c 'echo "deb https://packages.atlassian.com/atlassian-sdk-deb stable contrib" >>/etc/apt/sources.list'
RUN wget https://packages.atlassian.com/api/gpg/key/public  && apt-key add public   
RUN apt-get update && apt-get install atlassian-plugin-sdk


#USER ${BAMBOO_USER}
RUN ${BAMBOO_USER_HOME}/bamboo-update-capability.sh "system.builder.mvn3.Maven 3.3" /usr/share/maven
RUN ${BAMBOO_USER_HOME}/bamboo-update-capability.sh "system.git.executable" /usr/bin/git
