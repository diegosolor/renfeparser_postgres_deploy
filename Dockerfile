FROM arm32v7/debian

RUN apt-get update
RUN apt-get install -y postgresql-9.6 postgresql-9.6-pgtap

ENV PGDATA /var/lib/pgsql/9.6/data 


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
