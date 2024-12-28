class Micropost < ApplicationRecord
  belongs_to :user #->user.micropost.create
  enum status: { draft:0, published:1 }#@post.draftで取得可
  has_rich_text :rich_content#trixが自らrich_contentテーブルを作る。
  default_scope -> {order(created_at: :desc)}#新しい順にmicropostを表示
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 1000} #140以上は有料

  #inputは英語のみ
  #validates :content, presence: true, format: {with: /\A[a-zA-Z\s]+\z/, message: "English please 😗"}
end
