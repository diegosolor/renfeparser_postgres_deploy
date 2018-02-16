FROM arm32v7/debian

RUN apt-get update
RUN apt-get install -y postgresql-9.6 postgresql-9.6-pgtap

ENV PGDATA /var/pgsql/data 

RUN mkdir -p /var/pgsql/data
RUN chown postgres -R /var/pgsql

USER postgres

RUN /usr/lib/postgresql/9.6/bin/initdb -E UTF8

COPY scripts scripts
COPY data /data
COPY config ${PGDATA}

EXPOSE 5432
ENV BD_REVISION=104782
ENV BD_HOST=db
RUN sh scripts/dbsetup.sh

CMD ["/usr/lib/postgresql/9.6/bin/postgres"]
