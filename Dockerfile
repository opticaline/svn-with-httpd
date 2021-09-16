FROM httpd:2.4.48-alpine3.14

ARG SVN_REPO_VER=v3.7
ARG SVN_VER=1.9.12-r0

RUN echo "https://dl-cdn.alpinelinux.org/alpine/$SVN_REPO_VER/main" >> /etc/apk/repositories &&\
    apk add --no-cache mod_dav_svn=$SVN_VER subversion-libs=$SVN_VER subversion=$SVN_VER &&\
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