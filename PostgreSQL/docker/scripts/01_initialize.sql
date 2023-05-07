-- DB作成
CREATE DATABASE northwind; 

-- 作成したDBへ切り替え
\c northwind

-- スキーマ作成
CREATE SCHEMA northwind;

-- ロールの作成
CREATE ROLE nwuser WITH LOGIN PASSWORD 'nwpassword';

-- 権限追加
GRANT ALL PRIVILEGES ON SCHEMA northwind TO nwuser;
