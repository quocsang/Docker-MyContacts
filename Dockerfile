FROM ubuntu:16.04

#ENV http_proxy "http://proxy.tma.com.vn:8080"
#ENV https_proxy "https://proxy.tma.com.vn:8080"
RUN apt-get update

# @Option
RUN apt-get install -y iputils-ping
RUN apt-get install -y mysql-client
# RUN apt-get install -y apt-utils //de sua cai thong bao khi cai
#Fix error add-repository
RUN apt-get install -y software-properties-common 

# Install Java.
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer
 
# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install Apache Karaf
ENV KARAF_VERSION 4.0.4

RUN cd /tmp \
	&& wget -q -O "apache-karaf-$KARAF_VERSION.tar.gz" "http://archive.apache.org/dist/karaf/"$KARAF_VERSION"/apache-karaf-"$KARAF_VERSION".tar.gz" \
	&& tar -zxvf apache-karaf-$KARAF_VERSION.tar.gz \
	&& mv /tmp/apache-karaf-$KARAF_VERSION /opt/karaf 
EXPOSE 1099 8101 44444

WORKDIR /opt/karaf/bin

COPY config/karaf_service.script /root/
COPY scripts/scripts.sh /home/

