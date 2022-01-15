FROM scratch

RUN apt update && apt install wget unzip -y &&\
    wget http://pascalabc.net/downloads/PABCNETC.zip -O /tmp/PABCNETC.zip &&\
    mkdir /opt/pabcnetc &&\
    unzip /tmp/PABCNETC.zip -d /opt/pabcnetc &&\
    apt --purge remove wget unzip -y &&\
    rm -rf /var/lib/apt/lists/* /tmp/*
    apt install nginx
    ufw allow 'Nginx Full'
	mkdir -p /var/www/webcompiler/html