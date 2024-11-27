class HomeController < ApplicationController
  def index
    #@user = User.find(params[:id])#これはuser/1から取得している。rootだと探せない。
    @user = current_user
    @micropost = current_user.microposts.build if logged_in?
    #this can handle to "theme99.webp"
    @random_image = "theme%02d.webp" % rand(1..26)
  end

  def show
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def about
  end
end
