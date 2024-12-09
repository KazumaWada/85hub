class HomeController < ApplicationController
  def index
    #@user = User.find(params[:id])#これはuser/1から取得している。rootだと探せない。
    @user = current_user
    @micropost = current_user.microposts.build if logged_in?
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
  end
  def question
  end
  def blog
  end
end
