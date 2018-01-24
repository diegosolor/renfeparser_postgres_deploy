-- pg_dump -h db.gregal.prod.meteologica.com --dbname eolica -U postgres --data-only -t tipos_pred -t variables -t tipos_clientes_eolica -t mercados -t tipos_cliente -t traders.visibilidad -t unidades_medida -t metodos_prediccion -t traders.tipos_datos_prediccion -t modelos_numericos > data.sql
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: mercados; Type: TABLE DATA; Schema: public; Owner: eolica_superusuario
--


