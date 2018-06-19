FROM ubuntu:16.04

ENV http_proxy "http://proxy.tma.com.vn:8080"
ENV https_proxy "https://proxy.tma.com.vn:8080"
RUN apt-get update

# @Option
# RUN apt-get install -y git
# RUN apt-get install -y apt-utils //de sua cai thong bao khi cai
#Fix loi add-repository
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

# COPY config/karaf_service.script /root/ 

RUN cd /tmp \
	&& wget -q -O "apache-karaf-$KARAF_VERSION.tar.gz" "http://archive.apache.org/dist/karaf/"$KARAF_VERSION"/apache-karaf-"$KARAF_VERSION".tar.gz" \
	&& tar -zxvf apache-karaf-$KARAF_VERSION.tar.gz \
	&& mv /tmp/apache-karaf-$KARAF_VERSION /opt \
	&& ln -s "/opt/apache-karaf-$KARAF_VERSION" /opt/karaf

	
	
	
# Install MySQL.
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server \
 && sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mysql.conf.d/mysqld.cnf \
 && mkdir /var/run/mysqld \
 && chown -R mysql:mysql /var/run/mysqld
 
VOLUME ["/var/lib/mysql"]
 
EXPOSE 3306
 
CMD ["mysqld_safe"]