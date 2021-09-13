FROM httpd:2.4.48-alpine3.14

RUN apk add --no-cache apache2 apache2-utils apache2-webdav mod_dav_svn subversion &&\
    mkdir /home/svn/ &&\
    mkdir /etc/subversion &&\
    touch /etc/subversion/passwd
    # &&\
    #chmod a+w /etc/subversion/* && chmod a+w /home/svn

ADD svn-dav.conf /usr/local/apache2/conf/extra/svn-dav.conf

RUN echo 'Include conf/extra/svn-dav.conf' >> /usr/local/apache2/conf/httpd.conf &&\
    sed -i.bak 's;#LoadModule dav_module modules/mod_dav.so;LoadModule dav_module modules/mod_dav.so;' /usr/local/apache2/conf/httpd.conf &&\
    sed -i.bak 's/^#ServerName.*$/ServerName 0.0.0.0/' /usr/local/apache2/conf/httpd.conf

# Expose ports for http and custom protocol access
EXPOSE 80 3690

#ENTRYPOINT /usr/local/apache2/bin/apachectl && /usr/bin/svnserve -d --foreground -r /home/svn --listen-port 3690