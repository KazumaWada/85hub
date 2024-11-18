class UsersController < ApplicationController
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

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)# so that you can use only permitted user

    puts "ERROR MESSAGE#{@user.errors.full_messages}"
    Rails.logger.debug "Params: #{params.inspect}"
    if @user.save
      flash[:success] = "Welcome #{@user.name}!"
      redirect_to @user
    else
      puts "ERROR MESSAGE#{@user.errors.full_messages}"
      puts @user.errors.full_messages
      render 'new' # if signup fails, go back to /users/new
    end # <-- Correct placement for create action's end
  end

  private

  #paramsの情報を外部から使用できないようにする。
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end # <-- Correct placement for UsersController's end
