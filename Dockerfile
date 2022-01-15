FROM scratch

RUN apt-get update && apt-get install wget unzip -y &&\
    wget http://pascalabc.net/downloads/PABCNETC.zip -O /tmp/PABCNETC.zip &&\
    mkdir /opt/pabcnetc &&\
    unzip /tmp/PABCNETC.zip -d /opt/pabcnetc &&\
    rm -rf /var/lib/apt/lists/* /tmp/*
    apt-get install nginx
    ufw allow 'Nginx Full'
	mkdir -p /var/www/webcompiler/html