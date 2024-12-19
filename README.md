# eigopencil.com 🎉
![alt text](image.png)
# 概要
<a href="https://eigopencil.com" tag_blank>eigopencil.com</a>とは、英語学習者の皆さんが英語を文章でアウトプットできる場を提供するサービスです。 誰かのために、自分のために英語日記や新しく覚えたフレーズを文章にして共有しましょう。

# 開発背景
自分の英語力を上げるためにアウトプットの場を作ろうと思った。

# 開発に使用した技術

フロントエンド: HTML/CSS/Bootstrap<br>
バックエンド: Ruby on Rails<br>
データベース: PostgreSQL<br>
インフラ: Docker<br>
デプロイに使用したソフトウェア: Render

# 関連記事
# 機能一覧
- CRUD機能

- 下書き保存、edit、update機能
enumを使用して、Postテーブルにstatusの枠をDBに追加し、enumを使って数値で0:draft,1:publishedとし、"下書き保存"のformが送信されたらpost.draftとし、"投稿"のformが送信されたらpost.publishedとし、/draftでpost.draftをループし、userの投稿ページでpost.publishedをループしました。

* zen mode(集中執筆モード)

* 投稿日をカレンダーで確認
１ヶ月の日付を定義し、ループさせて表示させました。投稿日に✅が付きます。
* xシェア機能

# これから実装する機能
- 手書き認識機能
- AI添削
- stripe

# こだわったところ
- デフォルトではrouterがeigopencil.com/user.name/:idだが、見栄えを良くするためにgemのfriendly_idを使ってeigopencil.com/user.nameと表示されるようにした。

- ユーザーが投稿に集中できるように文字ではなく、それを表す絵文字を使って文字数を少なくしてみた。(navbarやuserページ)


