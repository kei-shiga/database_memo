# 【SQLServer】フィールド情報の取得

テーブル情報の取得と同じように、SYS***関連のテーブルを結合することで取得できます。
得たい情報によって結合するSYS***が変わりますが、大体こんな感じになるんじゃないかなと思います。
少々長いですが、フィールドの方向やIDENTITYかどうかも取得できるようになっています。

このSQLでは、テーブル以外にもストアドの情報まで取れるようになっています。
PROCEDURE_NO が1以上のときは、ストアドで使用される項目となります。

```
SELECT 
	c.column_id AS ColumnID,
    c.name AS ColumnName, 
    t.name AS ColumnType, 
    c.max_length AS ColumnSize, 
    c.precision AS ColumnNumSize, 
    c.is_identity AS IsIdentity 
FROM 
    sys.objects o
    INNER JOIN sys.columns c ON c.object_id = o.object_id 
    INNER JOIN sys.types t ON t.system_type_id = c.system_type_id 
WHERE 
    o.type = 'U' 
    AND o.is_ms_shipped = 0 
    AND o.name = '対象テーブル名' 
ORDER BY 
    1
```

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
    LEFT JOIN SYSINDEXES AS D ON D.ID = A.ID 
        AND D.STATUS & 2048 <> 0 
    LEFT JOIN SYSINDEXKEYS AS E ON E.ID = D.ID 
        AND E.INDID = D.INDID 
        AND E.COLID = A.COLID 
WHERE 
    B.NAME = '対象テーブル名' 
ORDER BY 
    A.NUMBER, 
    A.COLID
```