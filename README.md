# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* CRUD機能

* 下書き保存機能
enumを使用して、Postテーブルにstatusの枠をDBに追加し、enumを使って数値で0:draft,1:publishedとし、"下書き保存"のformが送信されたらpost.draftとし、"投稿"のformが送信されたらpost.publishedとし、/draftでpost.draftをループし、userの投稿ページでpost.publishedをループしました。
* zen mode(集中執筆モード)
新しいファイルにinputのみのページを作成しました。
* 手書き英文認識機能

* 投稿日をカレンダーで確認
１ヶ月の日付を定義し、ループさせて表示させました。投稿したらそのループ内で✅が付きます。
* xシェア機能
apiを使用せずにURLで実装しました。



こだわったところ
デフォルトでは.com/user/:idだが、friendly_idを使って.com/kazumaと表示されるようにした。
* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
