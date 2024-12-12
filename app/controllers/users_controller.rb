class UsersController < ApplicationController
  # #edit,updateをさせる前に、def logged_in_userを実行
  # before_action :logged_in_user, only: [:edit, :update]
  # before_action :correct_user, only: [:edit, :update]
  #before_action :authenticate_user!
  before_action :require_login, only: [:show]

  def index
    #UserはmodelのUser
    #@users = User.all
  end

  def show
    #active_recordから見つけてきている。== これはSQL文
    #paramsはurlから取得している
    #com/users/1->find("1")
    #⭐️だからこの↓書き方だと、/profileとかにしたら、paramsはidを見つけられない!!
    #↑だからcurrent_userメソッドでid以外に取得できる方法を使う！
    # @user = User.find(params[:id])
    #@user = current_user
    @user = User.friendly.find(params[:slug]) # routingが/user.nameなので、slug(user.name)を使って探す。
    @microposts = @user.microposts
    #@micropost = current_user.microposts.build if logged_in?

    # カレンダー表示用の日付を計算
    start_date = Date.today.beginning_of_month.beginning_of_week(:sunday)
    end_date = Date.today.end_of_month.end_of_week(:sunday)
    #end_date = start_date + 13 

    @today = Date.today
    @current_month = Date::MONTHNAMES[Time.now.month]
    # 日付の範囲を配列にする
    @calendar_days = (start_date..end_date).to_a
    
  end

  def new
    @user = User.new
  end

  #ここはUserをDBに登録のみ->loginへ(sessions#createcookieの実装を行う)
  def create 
    @user = User.new(user_params)

    if @user.save
      #log_in @user#signupした後に再度loginさせる手間を省く。(後に実装予定)
      redirect_to login_path
      flash[:success] = "Welcome #{@user.name}! please login"
    else
      puts @user.errors.full_messages
      flash.now[:danger] = "invalid ..."
      redirect_to root_path 
    end 
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    #update_attributes: 指定されたデータのmodelのデータを更新
    # user = User.find(1)
    # user.update_attributes(name: "John", age: 30)
    if @user.update(user_params)#.updateも全く同じ。
      #update succeess
      flash[:succeess] = 'profile updated!'
      redirect_to @user
    else
      render 'edit'
    end 
  end

  def destroy
    #postを消す。
    flash[:succeess] = 'deleted!'
  end

  # def current_user
  #   @current_user ||= User.find_by(id: session[:user_id])
  #   #@current_user ||= User.find(params[:id])
  #   #user == current_user
  # end

  private

  def authenticate_user!
    unless current_user
      signup_path
    end
  end

  #paramsの情報を外部から使用できないようにする。
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # def logged_in_user
  #   unless logged_in?
  #     flash[:danger] = "please log in."
  #     redirect_to login_url
  #   end
  # end

  def current_user#pathでは使えない。cookieで保存されているのはuser_idのみ。cookie.signedにuser.nameも保存すれば、current_userが便利に使えるようになる。
    @current_user ||= User.find_by(id: cookies.signed[:user_id])
    logger.debug "👷👷👷👷👷@current_user: #{@current_user.inspect}" 
  end
  
end 
