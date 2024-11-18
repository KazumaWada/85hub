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
################################################################################################
# "controller"=>"devise/registrations", "action"=>"new"のinit
<h2>Sign up</h2>

<%= form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
  <%= render "devise/shared/error_messages", resource: resource %>

  <div class="field">
    <%= f.label :email %><br />
    <%= f.email_field :email, autofocus: true, autocomplete: "email" %>
  </div>

  <div class="field">
    <%= f.label :password %>
    <% if @minimum_password_length %>
    <em>(<%= @minimum_password_length %> characters minimum)</em>
    <% end %><br />
    <%= f.password_field :password, autocomplete: "new-password" %>
  </div>

  <div class="field">
    <%= f.label :password_confirmation %><br />
    <%= f.password_field :password_confirmation, autocomplete: "new-password" %>
  </div>

  <div class="actions">
    <%= f.submit "Sign up" %>
  </div>
<% end %>

<%= render "devise/shared/links" %>
################################################################################################

# デプロイ
https://railstutorial.jp/chapters/sign_up?version=4.2#sec-professional_grade_deployment