class HomeController < ApplicationController
  def index
    #@user = User.find(params[:id])#これはuser/1から取得している。rootだと探せない。
    @user = current_user
    @micropost = current_user.microposts.build if logged_in?
    @microposts = Micropost.all
    #this can handle to "theme99.webp"
    @random_image = "theme%02d.webp" % rand(1..26)

    locations_path = Rails.root.join('config', 'locations.json')
    @locations = JSON.parse(File.read(locations_path))
    #@location = @locations[@random_image] if nill->"Unknow"という書き方になっている。
    @location = @locations.fetch(@random_image, "Unknown")
    
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
  def app
    @user = current_user#navbarのuser_path(@user)が/appで探せなくなるから。
  end
  def question
    @user = current_user#navbarのuser_path(@user)が/questionで探せなくなるから。
  end
  def blog
    @user = current_user#navbarのuser_path(@user)が/blogで探せなくなるから。
  end
  def how_i_use
    @user = current_user#navbarのuser_path(@user)が/blogで探せなくなるから。
  end
end
