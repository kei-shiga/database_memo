# 【SQLServer】テーブル一覧の取得

## テーブル一覧
データベース内にどんなテーブルが存在するかは、以下のSQLを実行することで得られる.

```
SELECT
    NAME,
    TYPE 
FROM
    sysobjects 
ORDER BY
    TYPE,
    NAME
```

## テーブル＋所有権一覧
所有者もほしいときは、sysusersを結合させて、UID同士を結合させる.

```
SELECT
    B.NAME AS OWNER,
    A.NAME,
    A.TYPE 
FROM
    sysobjects A 
    INNER JOIN sysusers B ON A.UID = B.UID 
ORDER BY
    A.TYPE,
    A.NAME
```

## ユーザーテーブル＋所有権一覧
条件で絞り込みます.
以下の例だとユーザーテーブル、関数、ビュー、ストアドが対象になっているので、必要に応じて条件を変える.

```
SELECT
    B.NAME AS OWNER,
    A.NAME,
    A.TYPE 
FROM
    sysobjects A
    INNER JOIN sysusers B ON A.UID = B.UID 
WHERE
    A.TYPE IN('U', 'IF', 'TF', 'V', 'P')
    AND A.STATUS >= 0 
ORDER BY
    A.TYPE,
    A.NAME
```
