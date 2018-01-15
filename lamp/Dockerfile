FROM centos:7
MAINTAINER The CentOS Project <cloud-ops@centos.org>
LABEL Vendor="CentOS" \
      License=GPLv2 \
      Version=2.4.6-40
RUN yum -y install curl wget unzip git vim \
    yum clean all

#RUN wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
#&& rpm -Uvh remi-release-7.rpm \
#&& yum-config-manager --enable remi-php71 \
#&& yum -y install php php-fpm
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
RUN ls -lh /etc/pki/rpm-gpg/
RUN rpm -qa gpg-pubkey*
#RUN rpm -qi gpg-pubkey-c105b9de-4e0fd3a3

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
RUN yum install -y mod_php71w php71w-cli php71w-common php71w-mbstring php71w-xml

RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install httpd && \
    yum clean all

RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN cd /var/www/html


#RUN rm -rf *
RUN git clone -bdev http://${USERNAME}:${PASSWORD}@nst-tfs2015:8080/tfs/NST_IAP_IPAN/NST_IAP_IPAN/_git/NST_IAP_IPAN_Web_Portal ./src


EXPOSE 80
COPY ./welcome.conf /etc/httpd/conf.d/
#COPY ./index.html /var/www/html/
#COPY ./src/ /var/www/html/
# Simple startup script to avoid some issues observed with container restart

ADD run-httpd.sh /run-httpd.sh
RUN chmod -v +x /run-httpd.sh
#RUN chmod -R 755 /var/www/html/ipan-web
#RUN chown -R apache:apache /var/www/html/


CMD ["/run-httpd.sh"]




