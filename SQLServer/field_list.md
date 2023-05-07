# 【SQLServer】フィールド情報の取得

テーブル情報の取得と同じように、SYS*** 関連のテーブルを結合することで取得できます.
少々長いですが、フィールドの方向やIDENTITYかどうかも取得できるようになっています.

このSQLでは、テーブル以外にもストアドの情報まで取れるようになっています.
PROCEDURE_NO が1以上のときは、ストアドで使用される項目となります.

```
SELECT 
    CAST(A.NAME AS VARCHAR(40)) AS FIELD_NAME, 
    CAST(C.NAME AS VARCHAR(20)) AS FIELD_TYPE, 
    CASE WHEN A.STATUS & 8 = 8 THEN 1 ELSE 0 END AS DIRECTION_INPUT,
    CASE WHEN A.STATUS & 64 = 64 THEN 1 ELSE 0 END AS DIRECTION_OUTPUT,
    CASE WHEN A.STATUS & 128 = 128 THEN 1 ELSE 0 END AS IS_IDENTITY,
    A.LENGTH AS FIELD_SIZE, 
    CASE WHEN E.COLID IS NULL THEN '0' ELSE '1' END AS PK_FLAG, 
    A.NUMBER AS PROCEDURE_NO 
FROM 
    SYSCOLUMNS AS A 
    INNER JOIN SYSOBJECTS AS B ON B.ID = A.ID 
    INNER JOIN SYSTYPES AS C ON C.XUSERTYPE = A.XTYPE 
    LEFT OUTER JOIN SYSINDEXES AS D ON D.ID = A.ID 
        AND D.STATUS & 2048 <> 0 
    LEFT OUTER JOIN SYSINDEXKEYS AS E ON E.ID = D.ID 
        AND E.INDID = D.INDID 
        AND E.COLID = A.COLID 
WHERE 
    B.NAME = '対象テーブル名' 
ORDER BY 
    A.NUMBER, 
    A.COLID
```

sys. 系のテーブルでも同様の情報が取得できますが、できることが若干違います.

```
SELECT 
    c.column_id AS FIELD_ID,
    c.name AS FIELD_NAME, 
    t.name AS FIELD_TYPE, 
    c.max_length AS FIELD_SIZE, 
    c.precision AS FIELD_NUM_SIZE, 
    c.is_identity AS IS_IDENTITY 
FROM 
    sys.objects o
    INNER JOIN sys.columns c ON c.object_id = o.object_id 
    INNER JOIN sys.types t ON t.system_type_id = c.system_type_id 
WHERE 
    o.type = 'U' 
    AND o.is_ms_shipped = 0 
    AND o.name = '対象テーブル名' 
ORDER BY 
    c.column_id
```
