FROM nginx

RUN apt-get update && apt-get install wget unzip -y &&\
    wget http://pascalabc.net/downloads/PABCNETC.zip -O /tmp/PABCNETC.zip &&\
    mkdir /opt/pabcnetc &&\
    unzip /tmp/PABCNETC.zip -d /opt/pabcnetc &&\
    apt-get --purge remove wget unzip -y &&\
    rm -rf /var/lib/apt/lists/* /tmp/*
	
RUN apt-get update && apt-get -qq -y install curl gnupg2 ca-certificates lsb-release 
	#ubuntu-keyring 
	
    &&\ curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null 
	&&\ echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
    http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \ 
    | tee /etc/apt/sources.list.d/nginx.list 
	&&\ apt-get -qq -y install systemd 
	&&\ apt-get -qq -y install mc 
	&&\ apt-get update 
    &&\ apt-get -qq -y install nginx 
	#&&\ apt-get -qq -y install ufw

RUN mkdir -p /var/www/webcompiler/html && chown -R $USER:$USER /var/www/webcompiler/html && chmod -R 755 /var/www/webcompiler &&\
	mkdir -p /etc/nginx/sites-available/webcompiler
#COPY nginx.conf /etc/nginx/sites-available/webcompiler
#COPY index.html /var/www/webcompiler/html
COPY index.html /var/www/html
#COPY nginxconfig/nginx.conf /etc/nginx
RUN service nginx restart