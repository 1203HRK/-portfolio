![logo](https://user-images.githubusercontent.com/75369026/112708963-ce5a7380-8ef8-11eb-91b1-774ee0d0f2b9.png)
# BeoPLE
ビープル
be(autiful)・(pe)ople

## サイト概要
ファッション・メイクに特化した評価SNSです。
洋服・化粧品の使用感や色のノリ方、似合わせなど、様々な目線から商品の評価を投稿していきます。
共有することにより、興味のある商品を買う前に自身に似合うのか確かめられる様になっています。
- TOP画面

<img width="1417" alt="fv" src="https://user-images.githubusercontent.com/75369026/112709056-6d7f6b00-8ef9-11eb-9de0-2c03d6fc0688.png">

- 投稿一覧画面

<img width="1419" alt="スクリーンショット 2021-03-27 12 41 14" src="https://user-images.githubusercontent.com/75369026/112709115-db2b9700-8ef9-11eb-8b60-03958298f256.png">

### サイトテーマ
ファッション・メイクに特化したSNS

### テーマを選んだ理由
パーソナルカラーや骨格診断等、流行りよりも自身に似合うものにニーズが移行してきています。
そんな中、コロナ禍によりタッチアップや試着に手が出ないご時世となってしまいました。
買い物のしにくさから、既存のSNSでは様々なジャンルが混在し目当ての投稿を見つけにくいことから
ファッション・メイク用品に特化したSNSを作成し、手軽に商品の評価を確認できればと思い作成しました。

### ターゲットユーザ
ファッション・メイクに興味のある10代〜20代・30代

### 主な利用シーン
- 気になった商品の品定め
- 自身の商品利用履歴、使用感の記録

## 設計書
-　機能一覧：　https://docs.google.com/spreadsheets/d/1hQVdC3yqmxP7b5IVzCFjf1x2Mc-ZxvYwGgQiu5GOyJg/edit?usp=sharing

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 機能一覧
- ユーザー登録、ログイン機能(devise)
- 投稿機能
  - 画像投稿(refile)
  - 評価(Raty)
- いいね機能(Ajax)
  - ランキング機能
- コメント機能(Ajax)
- フォロー機能(Ajax)
- 環境変数化(dotenv-rails)
- レイアウト(Bootstrap)

## CircleCi CI/CD
mainブランチへのpushでは、EC2への自動デプロイが実行されます。

## 使用素材
- フリー素材：
- https://o-dan.net/ja/
- https://girlydrop.com/
- https://www.silhouette-ac.com/