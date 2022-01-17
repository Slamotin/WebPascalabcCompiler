FROM nginx

RUN apt-get update && apt-get install wget unzip -y &&\
    wget http://pascalabc.net/downloads/PABCNETC.zip -O /tmp/PABCNETC.zip &&\
    mkdir /opt/pabcnetc &&\
    unzip /tmp/PABCNETC.zip -d /opt/pabcnetc &&\
    apt-get --purge remove wget unzip -y &&\
    rm -rf /var/lib/apt/lists/* /tmp/*
	
RUN apt-get update && apt-get -qq -y install curl gnupg2 ca-certificates lsb-release debian-archive-keyring &&\
    curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null &&\
	echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
    http://nginx.org/packages/debian `lsb_release -cs` nginx" \ 
    | tee /etc/apt/sources.list.d/nginx.list &&\
	apt-get -qq -y install systemd &&\
	apt-get -qq -y install mc
   

RUN mkdir -p /var/www/webcompiler/html &&\
	chown -R $USER:$USER /var/www/webcompiler/html &&\
	chmod -R 777 /var/www/webcompiler/html &&\
	mkdir -p /etc/nginx/sites-available/webcompiler &&\
	chown -R www-data:www-data /var/log/nginx &&\
	chmod -R 777 /var/log/nginx
	
COPY index.html /var/www/webcompiler/html/index.html
COPY nginxconfig/default.conf.template /etc/nginx/conf.d/default.conf.template
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /var/www/html/index.html
RUN envport_script.sh

