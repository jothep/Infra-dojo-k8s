/*
GRANT CONNECT ON DATABASE postgres, srs_data_archival_db TO srs_svc_user;
GRANT ALL PRIVILEGES ON DATABASE postgres TO srs_svc_user;

ALTER ROLE srs_svc_user LOGIN;
GRANT ALL ON ALL TABLES IN SCHEMA PUBLIC to srs_svc_user;
*/

DROP USER srs_svc_user1;
CREATE ROLE srs_svc_user1 WITH LOGIN PASSWORD 'hZ6L.e!bda2aT_Wr_vZ4';
GRANT psqladmin TO srs_svc_user1;

