FROM httpd:2.4.57-alpine3.17

RUN apk add --no-cache mod_dav_svn subversion-libs subversion &&\
    mkdir /home/svn/ &&\
    mkdir /etc/subversion &&\
    touch /etc/subversion/passwd

ADD subversion-access-control /etc/subversion/subversion-access-control
ADD svn-dav.conf /usr/local/apache2/conf/extra/svn-dav.conf

RUN echo 'Include conf/extra/svn-dav.conf' >> /usr/local/apache2/conf/httpd.conf &&\
    sed -i.bak 's;#LoadModule dav_module modules/mod_dav.so;LoadModule dav_module modules/mod_dav.so;' /usr/local/apache2/conf/httpd.conf &&\
    sed -i.bak 's/^#ServerName.*$/ServerName 0.0.0.0/' /usr/local/apache2/conf/httpd.conf

# Expose ports for http and custom protocol access
EXPOSE 80

CMD /usr/local/apache2/bin/httpd -DFOREGROUND
