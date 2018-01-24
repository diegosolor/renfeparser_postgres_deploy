FROM centos:centos7

RUN yum install -y  epel-release
RUN yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
RUN yum install -y postgresql96-server postgresql96-contrib postgresql96-plperl postgis2_96 pgtap96
RUN yum install -y subversion

ENV PGDATA /var/lib/pgsql/9.6/data 


USER postgres

RUN /usr/pgsql-9.6/bin/initdb -E UTF8

COPY scripts scripts
COPY data /data
COPY config ${PGDATA}

EXPOSE 5432
ENV BD_REVISION=104782
ENV BD_HOST=db
RUN sh scripts/dbsetup.sh

CMD ["/usr/pgsql-9.6/bin/postgres"]
