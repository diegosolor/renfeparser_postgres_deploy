Utility to deploy a postgres schema with fabric2

deploy:
 fab -H mi_host startDataBase

Connect: psql -h localhost -U postgres -d renfe
