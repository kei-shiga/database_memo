-- PDBの新規作成(pdb$seedから作成)
CREATE PLUGGABLE DATABASE northwind ADMIN USER pdb01admin IDENTIFIED BY passw0rd
file_name_convert = ('/opt/oracle/oradata/XE/pdbseed/','/opt/oracle/oradata/XE/northwind/');

-- PDBの起動
ALTER PLUGGABLE DATABASE northwind OPEN;

-- PDBの自動起動設定
ALTER PLUGGABLE DATABASE northwind SAVE STATE;

-- PDB切り替え（これがないと、コンテナ再起動時に「ORA-01109: database not open」が発生）
ALTER SESSION SET CONTAINER=northwind;

-- ロール権限付与 
GRANT DBA TO PDB_DBA;

-- 表領域作成
CREATE TABLESPACE users
DATAFILE '/opt/oracle/oradata/XE/northwind/users01.dbf' SIZE 300M
AUTOEXTEND ON NEXT 500K MAXSIZE UNLIMITED;