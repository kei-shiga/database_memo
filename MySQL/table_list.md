# 【MySQL】テーブル一覧の取得

## テーブル一覧
データベース内にどんなテーブルが存在するかは、以下のSQLを実行することで得られる.

```
SELECT
    TABLE_NAME,
    TABLE_TYPE 
FROM
    information_schemna.TABLES
WHERE
    TABLE_SCHEMA = 'スキーマ名'
ORDER BY
    TABLE_TYPE,
    TABLE_NAME
```
