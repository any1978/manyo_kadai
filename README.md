## デプロイ手順


##### ●ワーキング・ツリーの中で変更されたコンテンツ(新規、編集、削除したファイル)を見つけてインデックス(Git管理の対象)に追加
$ git add -A

##### ●開発環境でコンテンツの修正・追加・削除等を行い、ローカルリポジトリに変更履歴を記録
$ git commit -m "任意のコメント"

##### ●ローカルでマスターブランチに移動
$ git checkout master

##### ●マスターブランチで開発中ブランチをマージする
$ git merge 開発ブランチ名

##### ●データベースをmigrateする
$ rails db:migrate

##### ●Herokuにログインする
$ heroku login

##### ●Herokuアプリ作成
$ heroku create

##### ●app/assetsディレクトリの中のファイルのうち、.jsと.cssファイル以外の全てのファイルをプリコンパイル
$ rails assets:precompile RAILS_ENV=production

##### ●Herokuのアプリにローカルリポジトリにある変更履歴をアップロード
$ git push heroku master

##### ●Herokuのサーバ上にアプリケーションのテーブルを作成、マイグレーション実行
$ heroku run rails db:migrate

##### ●Herokuでアプリ確認
$ heroku open



## データベース

##### ●ユーザーテーブル
| 	カラム名  |  	データ型    |  
| :------------: | :------------: | 
|    ユーザーID    |    string      |  
|   ユーザー名 	|     string      |
|   メールアドレス  |     string      |
|   パスワード     |     string      |


##### ●タスクテーブル
|    カラム名    |      データ型    |      null     |  
| :------------: | :------------: |  :------------: |
|    タスクID     |    string      |    false      |  
|    name（タイトル）    |    string      |    false      |  
|   description（タスク詳細 ）	|     text      |    false      |  
|   created_at(登録日時) 	|     datetime     |     false      |  
|   updated_at(更新日時) 	|     datetime     |     false      |  
|   end_date(終了期限) 	|     datetime     |          |  
|   ステータス 	|     string     |    false      |  
|   ユーザーID（FK） |     string   |    false      |  
|   ラベルID（FK）  |     string   |    false      |  


##### ●ラベルテーブル
|    カラム名    |  	データ型    |  
| :------------: | :------------: | 
|    ラベルID    |    string      |  
|    ラベル名	|    string      |
|   タスクID（FK） |     string   |


##### ●タスク&ユーザー中間テーブル
|    カラム名    |  	データ型    |  
| :------------: | :------------: | 
|    ラベルID    |    string      |  
|   タスクID（FK）|    string      |