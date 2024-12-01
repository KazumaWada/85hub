ユーザーを登録する(gem deviseを使用する)
↓
文字をpostして、
DBに格納して、
それをDBから出して
viewに表示してみる。


- 一日一回投稿したら、次は投稿できなくなる。
- 間違えたら?(まあいっか。あとで)


- deviseでmailログインではなく、名前やxでログインできるようにしてみる。
- x専用でログインさせる
- 投稿できるようにする(now!)
- submitをクリックしたら、というアクションを書く。
よくGPTを読んでから書き始める。
投稿して、submitして、表示するのはいくつかのアクションが重なる。railsではアクションごとに分ける必要があるため、いちいちページをロードする必要がある。その後にajaxとかをやればいい。まずはrailsのルールに則ってやってみる。まずは紙に書いてみる。

submitボタンを押したら投稿されたい。
'entries/new'のページをレンダリングするのではなく、entries/newの中で'form'というファイルをレンダリングして、users/createでも同じようにレンダリングする。

- entries/newの送信フォームボタンをusers/showに表示したい
entries/newでレンダリングして置いておいた_form.html.erbをusers/showにもレンダリングして表示する。


分かりやすくするためにusers/newという風にレンダリングしていく。そしてusers/showでデータを送信すると、ちゃんとレンダリング先のentries/createへ移動するから大丈夫。

- show.html.erbをそのままレンダリングするとエラーになる。だから_showとしてshowにレンダリングして、_showをusersにもレンダリングした。二段階にする理由はentriesの効果を聞かせるためにはentries/showに存在させておく必要があるから。

- 次は、この送信ボタンをレンダリングしてくる必要がある。
entries/newとentries/_newを作る
_newをnewにレンダリングする
users/showに_newをレンダリングする。
↓
デザインをよくする。

#　今
- ✅投稿したやつをXにシェアする機能をつける。
- aboutページを作って日記でもフレーズでもいいよ。youtubeを見つけてあ、このフレーズをいい言葉だなーと思ったらメモしておくとか(実際にdeamon dominiqueの動画のフレーズを動画を貼って説明してみる。歌詞のワンフレーズでも言い方かっこいいなとか思ったら書いていく。自由度高く。
)
- ✅cssが被っているから統一する。show/indexとhome/index。しかもちょっとスタイルが違う。
- 名前でログイン
- ユーザーアイコンを設定する。
- 投稿するvalidationを追加する。(140字以内)





# 収益化
みんなの投稿が見れる。
分からない時とかは、投稿した人のリンクを見れる。
データを分析できる。どれくらい英語が成長したとか。
ユーザーの日記を集めたリストを売る。
英語教材を売る。

# コア
コアがないから、デザインの段階で微妙になる。だからまず何をしたいのか。デザインの前にそこからやってみる。

xでシェアするときにカッコイイデザインにしておくのがポイントかも

# v0
ユーザーログイン機能
投稿できる。
xに投稿できる
# v1以降
文章をメモしておくことができる->有料
広告を省くことができる->有料
みんなの投稿を見ることができる->有料



# deviseでname追加
https://github.com/heartcombo/devise?tab=readme-ov-file#strong-parameters

- Rails 4 moved the parameter sanitization from the model to the controller, causing Devise to handle this concern at the controller as well.

この3つのみがmodelにデータを渡していく。(これにnameを追加すれば良いってことかな??)
sign_in (Devise::SessionsController#create) - Permits only the authentication keys (like email)
sign_up (Devise::RegistrationsController#create) - Permits authentication keys plus password and password_confirmation
account_update (Devise::RegistrationsController#update) - Permits authentication keys plus password, password_confirmation and current_password

でも、めんどくさかったらこうやって書くことができる

#

```ruby
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  #単純な例(他にも2つあるけど、まあこれでやってみる。)
  devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
　end

end
```


これのemailをnameに変える。その色々な手続きをやる。
# githubに書いてあるやつを、もう一度全部訳してから理解してみる。
# HTTP/cookie(session)
- http: 前にやったことは忘れている。だから安全
- cookie: 覚えるように設定して、無駄な繰り返しを防ぐ。(railsではsessionメソッドがある。)
sessionがあるから、自分がすでにログインしたアカウントに次回もログインせずに使用することができるようになる。
そしてログアウトすると、sessionがdestroyされるような仕組みにする。

#　続き
logout errorになっているからそこを直す。
javascriptをrails7.0.8.6に導入していく。
doc: https://guides.rubyonrails.org/v7.0/
import mapを使って実装していく。(yarnとかwebpack必要ないから。)
↓
どうにもならんから、最初からにして、今まで書いたコードをコピーしてもう一回やっていくことにする。
↓

# 移行する必要があるもの
モデル:

app/models配下のファイル（例: user.rb, post.rbなど）。
コントローラー:

app/controllers配下のファイル（例: users_controller.rb, posts_controller.rbなど）。
APIを使っている場合はapp/controllers/api配下も忘れずに。
ビュー:

app/views配下のテンプレートファイル（例: users/index.html.erb, posts/show.html.erbなど）。
マイグレーションファイル:

db/migrate配下のマイグレーションファイルを新しいプロジェクトにコピー。
設定ファイル:

必要に応じてconfig配下のファイル（例: routes.rb, environmentsフォルダ内の設定ファイルなど）。
アセット（必要な場合）:

app/javascriptやapp/assets配下のJavaScript、CSS、画像ファイル。
Gemfile:

依存するGemを新しいGemfileに移行し、bundle installを実行。

# 移行する手順
dockerfile,ymlを新たなファイルで作る。
そこでrailsアプリを実行する。
↓
全てコピーして移行する。
↓
全てをonedayonelineにすり替えて、ちゃんと起動するか確かめる。


# デプロイ
https://railstutorial.jp/chapters/sign_up?version=4.2#sec-professional_grade_deployment



sessionは必要ないよね?
https://railstutorial.jp/chapters/updating_and_deleting_users?version=4.2#sec-friendly_forwarding
↑
ここから先は飛ばしている。
10/24
# 続き
write->
userpic->userページ->日記、ブクマ
初めての方はこちら->
ブログ->

zennみたいに、右上にlogin&ユーザーアイコンを書いてみる。

#　今
英語"日記"っていう言い方をもっと浸し見やすいもの、かっこいいものに変えればユーザーはもっと食いつくと思う。

英語ジャーナル
デイリースパーク (Daily Spark)
1日の始まりや気づきを英語で表現するイメージ。
Spark Daily
シンプルに「Spark」を前にしてリズミカルな響きに。
Daily Glow
「光」や「輝き」を連想させ、ポジティブな印象。
Word Spark
1日のひらめきを「言葉」にフォーカス。
Little Spark
1日の小さなひらめきを書き留める。
Daily Growth
日々の成長を表現。
Scribble Spark
気軽に落書きのように書く感覚。
Micro Spark
小さなひらめきが毎日積み重なるイメージ。
Spark Journey
小さなひらめきの旅が始まる。
Daily Seed
成長の種を毎日植えるイメージ。
Quick Glow
すぐに取り組める明るい記録。

「小さな言葉が、大きな成長を生む。」
「あなたの成長は、1行から始まる。」
「今日の1行が、明日の自信に。」
「気づけば英語が、あなたの日常に。」
「書くたびに、英語がもっと身近に。」
「英語力は、明日ではなく今日の1行から始まる。」
「未来の自分が感謝する習慣を、今始めよう。」
🔥「言葉にするたび、英語があなたのものになる。」
「1行の種が、大きな木に育つ。」

# どうやってユーザーを毎日自分のアプリに訪れさせるのか。
毎日毎日英語ジャーナルを続けさせるにはどうすればいいのか。
->自分が見本になる。
->ビジュアルで憧れさせる。
->🔥ユーザーを日記を書くことでどうよくなるのか何かで納得させる。(これやろ!自分がそうだから)
->🔥書いたジャーナルの進化を見せる：
AIがユーザーの投稿を読み取って成長を可視化する「あなたの英語力の進化レポート」を定期的に送る。

例：「今週のあなたの英語は、こんなに上達しました！」
英単語のカウント、語彙の広がりなどを可視化。
ビジュアルでのモチベーション：
ユーザーが英語で話している風景の生成に加え、ジャーナル内容をベースにした未来のシーン（例：英語でプレゼンする姿、旅行先で英語を話す自分）をイメージさせる。

# データベースDB無効化有効化
- gemfile
pgコメントアウト
- config/application.rb 
22-26 line
- config/database.yml
1-22 linesコメントアウト


```md
はい、Railsアプリケーションをデータベースを使用せずにデプロイすることは可能です。Railsはデフォルトでデータベースを必要としますが、アプリがデータベースを使用しない場合、以下の手順で設定を変更して対応できます。

Railsアプリをデータベースなしで動作させる方法
1. Gemfile の調整
データベース関連のGemを除去します。

以下のようなデータベース関連のGem（例: pg, sqlite3）をコメントアウトまたは削除します。

ruby
Copy code
# gem 'pg'         # PostgreSQL
# gem 'sqlite3'    # SQLite
Gemfileを更新したら、以下を実行します：

bash
Copy code
bundle install
2. データベースなしでRailsを初期化
Railsのアプリケーション設定でデータベースを無効化します。

config/application.rb の設定を編集：

ruby
Copy code
module YourAppName
  class Application < Rails::Application
    config.load_defaults 7.0
    config.api_only = false  # 必要に応じてAPIモードならtrue
    # データベースを無効化
    config.active_record.migration_error = :app_start # Rails 6以降
    config.active_record.database_selector = false
    config.active_record.legacy_connection_handling = false
  end
end
データベースモジュールを完全に無効化する場合は、以下を追加：

ruby
Copy code
config.generators do |g|
  g.orm :null
end
3. データベース設定を無効化
config/database.yml を削除するか無効化します。Herokuは DATABASE_URL を必要とする場合があるため、削除せず以下のように空の設定にしておくと安全です：

yaml
Copy code
default: &default
  adapter: null

development:
  <<: *default

test:
  <<: *default

production:
  <<: *default
4. Herokuへのデプロイ
Procfileを作成
アプリがデータベースなしで動作するように、Procfile を作成します。

text
Copy code
web: bundle exec rails server -b 0.0.0.0 -p $PORT
デプロイ手順
データベースなしでHerokuにデプロイします：

bash
Copy code
git add .
git commit -m "Deploy Rails app without database"
git push heroku main
Herokuの環境変数確認
DATABASE_URL が設定されている場合は、以下のコマンドで削除します：

bash
Copy code
heroku config:unset DATABASE_URL --app <アプリ名>
5. Railsが正しく動作するか確認
ブラウザでHerokuのURL（例: https://<アプリ名>.herokuapp.com）を開き、Railsアプリが動作していることを確認します。

注意点
データベースが不要な場合でも、一部のGemや機能（例: ActiveRecord）はデータベースに依存しています。それらを使用しないように設計する必要があります。
データベースを完全に無効化するのは基本的に推奨されませんが、静的なアプリや単純なAPIを提供する場合に適しています。
これでRailsアプリをデータベースなしでHerokuにデプロイできます！


I prefer this response
```

# render deploy
- javascriptが使えない問題
RAILS_SERVE_STATIC_FILESこのkeyを設定する必要がある??