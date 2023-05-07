# 【Oracle】テーブル一覧の取得

## テーブル一覧
データベース内にどんなテーブルが存在するかは、以下のSQLを実行することで得られる.

```
SELECT 
    B.OWNER, 
    A.TABLE_NAME, 
    A.TABLE_TYPE 
FROM 
    USER_CATALOG A 
    INNER JOIN ALL_CATALOG B ON A.TABLE_NAME = B.TABLE_NAME
```
