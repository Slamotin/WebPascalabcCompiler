FROM ubuntu:20.04 

RUN apt-get update && apt-get install wget unzip -y &&\
    wget http://pascalabc.net/downloads/PABCNETC.zip -O /tmp/PABCNETC.zip &&\
    mkdir /opt/pabcnetc &&\
    unzip /tmp/PABCNETC.zip -d /opt/pabcnetc &&\
    apt-get --purge remove wget unzip -y &&\
    rm -rf /var/lib/apt/lists/* /tmp/*
	
RUN apt-get update && apt-get -qq -y install curl gnupg2 ca-certificates lsb-release ubuntu-keyring &&\
    curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null &&\
	echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
    http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \ 
    | tee /etc/apt/sources.list.d/nginx.list &&\
	apt-get update &&\
    apt-get -qq -y install nginx &&\
    ufw allow 'Nginx Full' &&\
	mkdir -p /var/www/webcompiler/html