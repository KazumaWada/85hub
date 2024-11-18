class User < ApplicationRecord
    
    #self: 現在のuser
    before_save { self.email = email.downcase }
    
    validates :name, presence: true, length: {maximum: 15}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: {maximum: 255}, 
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }#大小文字区別しない

    has_secure_password             
    validates :password, presence: true, length: { minimum: 6 }
    #↑
    #passwordをハッシュ化してDBに保存する。(has_secure_passwordによって)
    #DB内のpassword_digestというテーブルを作成しそこに保存するのが決まり(https://railstutorial.jp/chapters/modeling_users?version=4.2#sec-a_hashed_password)
    #password,password_cofirmationとauthenticateというメソッドが使えるようになる。
    #user.authenticate("password")でtrue,falseが実装できる
end

#User.create(name: "Michael Hartl", email: "mhartl@example.com", password: "foobar", password_confirmation: "foobar")