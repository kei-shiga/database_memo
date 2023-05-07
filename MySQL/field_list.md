# 【MySQL】フィールド情報の取得

テーブル情報の取得と同じように、information_schema スキーマのテーブルから取得できます.

## フィールド情報の取得

PRIMARY KEY となっているフィールドは COLUMN_KEY が `PRI` となり、auto_increment のフィールドは EXTRA が `auto_increment` となっています.

```
SELECT 
    ORDINAL_POSITION,
    COLUMN_NAME, 
    DATA_TYPE,
    CHARACTER_MAXIMUM_LENGTH,
    IS_NULLABLE,
    COLUMN_KEY,
    EXTRA
FROM 
    information_schema.COLUMNS
WHERE
    TABLE_SCHEMA = 'スキーマ名'
    AND TABLE_NAME = '対象テーブル名' 
ORDER BY 
    ORDINAL_POSITION
```

## インデックス情報の取得

インデックス情報も同様に `information_schema.KEY_COLUMN_USAGE` テーブルから取得できます.

```
SELECT
    CONSTRAINT_NAME,
    ORDINAL_POSITION,
    COLUMN_NAME
FROM
    information_schema.KEY_COLUMN_USAGE
WHERE
    TABLE_SCHEMA = 'スキーマ名'
    AND TABLE_NAME = '対象テーブル名' 
ORDER BY
    CONSTRAINT_NAME,
    ORDINAL_POSITION
```
