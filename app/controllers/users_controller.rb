class UsersController < ApplicationController
  #edit,updateをさせる前に、def logged_in_userを実行
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  #>> User.find(1)
  #<User id: 1, name: "Michael Hartl", email: "mhartl@example.com",
  
  #>> User.find_by(email: "mhartl@example.com")
  #User.first
  #User.all

  #paramsはこのhash内のデータがviewから渡される。
  # "user" => { "name" => "Foo Bar",
  #             "email" => "foo@invalid",
  #             "password" => "[FILTERED]",
  #             "password_confirmation" => "[FILTERED]"
  #           }

  #つまり、
  # @user = User.new(params[:user])
  # 以下とほぼ等価
  # @user = User.new(name: "Foo Bar", email: "foo@invalid",
  #                  password: "foo", password_confirmation: "bar")

  def index
    #UserはmodelのUser
    @users = User.all
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
    @micropost = current_user.microposts.build if logged_in?
  end

  def new
    @user = User.new
  end

  def create #ユーザーのあらゆる情報をparamsから取得することができる。
    @user = User.new(user_params)# so that you can use only permitted user

    puts "ERROR MESSAGE#{@user.errors.full_messages}"
    Rails.logger.debug "Params: #{params.inspect}"
    if @user.save
      log_in @user#signupした後に再度loginさせる手間を省く。
      flash[:success] = "Welcome #{@user.name}!"
      redirect_to user_path(@user)
    else
      puts "ERROR MESSAGE#{@user.errors.full_messages}"
      puts @user.errors.full_messages
      render 'new' # if signup fails, go back to /users/new
    end # <-- Correct placement for create action's end
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

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    #@current_user ||= User.find(params[:id])
    #user == current_user
  end

  private

  #paramsの情報を外部から使用できないようにする。
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end
  
end 
