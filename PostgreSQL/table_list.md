# 【PosrgreSQL】テーブル一覧の取得

## テーブル一覧
データベース内にどんなテーブルが存在するかは、以下のSQLを実行することで得られる.

```
SELECT 
    SCHEMANAME, 
    TABLENAME 
FROM 
    PG_TABLES 
WHERE 
    NOT TABLENAME LIKE 'pg%' 
    AND NOT SCHEMANAME = 'information_schema' 
ORDER BY 
    SCHEMANAME, 
    TABLENAME
```
