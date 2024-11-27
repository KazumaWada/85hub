class SessionsController < ApplicationController

  def new
  end

  #ログインに成功したら。sessiomを作成すすためのかんす。
  def create#params[:session][:email],[:password]という形になっている。
    #@user: このファイル以外でも使い回す
    #user: このファイル内のみで使用
    #user = User.find_by(email: params[:session][:email])
    #多分pathを/loginにしているからだと思う。paramsで見つけられない。
    logger.debug "🛠️🛠️🛠️🛠️🛠️🛠️🛠️🛠️🛠️Params: #{params.inspect}"
    user = User.find_by(name: params[:session][:name])
    logger.debug "👷👷👷👷👷User: #{user.inspect}" if user
    logger.debug "🎫🎫🎫🎫🎫Password: #{params[:password]}"

    #if user && user.authenticate(params[:session][:password])#authenticate: has_secure_passwordが提供する。
    if user && user.authenticate(params[:session][:password])#authenticate: has_secure_passwordが提供する。
      # ユーザーログイン後にユーザー情報のページにリダイレクトする
      log_in user #user.rb
      # user.rb←これにしているつもりだけど、session_helperに行っている
      #remember user　←とりあえず後にしよう。
      #redirect_to @user
      flash.now[:success] = "welcome back👍"
      redirect_to current_user
    else
      flash.now[:danger] = "invalid ..."#now:page refresh it its gone.
      #render 'new'
      render 'home/index'
    end
  end

  def destroy
    Rails.logger.info "Destroy action called"
    log_out 
    flash[:success] = "logged out👍"
    redirect_to root_path
    
  end
end

