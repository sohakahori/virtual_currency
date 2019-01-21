# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## 認証
* devise token auth
`http://clc.gonna.jp/2017/01/post-1306/`
`https://qiita.com/DaichiSaito/items/b6239d70ab10b2070bc4`

## デザインパターン導入
* serviceクラス
`https://qiita.com/chrischris0801/items/58a12d17a440b842db02`

    ※随時適応
    
    ↓↓ 導入検討
`https://qiita.com/QUANON/items/5ef803988c0ad6930e4b`  
    

## 自作rakeコマンド
* coinsマスターデータをインサート

`rake db:coins_create`

* coinsマスターデータをアップデート
(時価総額、時価ランキング等)

`rake db:coins_create`

