#!/bin/bash -e

/usr/lib/postgresql/9.6/bin/pg_ctl -w start

psql -U postgres -c "CREATE ROLE renfe WITH LOGIN PASSWORD 'renfe';"
psql -U postgres -c "ALTER USER postgres PASSWORD 'renfe001';"

psql -U postgres -c "CREATE DATABASE renfe WITH OWNER = renfe ENCODING = 'UTF8' CONNECTION LIMIT = -1;";

psql -U renfe renfe < /data/schema.sql
psql -U renfe renfe < /data/basic_data.sql

psql -U postgres -c "CREATE SCHEMA pgtap;" renfe
psql -U postgres -c "CREATE EXTENSION pgtap SCHEMA pgtap;" renfe

psql -U postgres -c "alter role renfe set search_path TO public, postgis, pgtap;"
psql -U postgres -c "alter role postgres set search_path TO public, postgis, pgtap;"

/usr/lib/postgresql/9.6/bin/pg_ctl  stop
