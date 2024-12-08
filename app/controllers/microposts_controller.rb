class MicropostsController < ApplicationController
  #CSRFtokenを投稿時に無効化する。
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token, only: [:create]

    def index
      #単数: model, 複数: DBのテーブル名
      #@microposts = Micropost.all
      @microposts = Micropost.includes(:user).all#投稿と一緒にuser.nameも表示したいから。
    end

    def new
      @user = User.find_by(slug: params[:slug])
      @micropost = Micropost.new#空のインスタンスを作成(userとはつながっていない)
    end

    def create
      fixed_params = { micropost: { content: params[:content] } }
      params.merge!(fixed_params)
    
     
        @user = User.find_by(slug: params[:slug])
        @micropost = @user.microposts.build(micropost_params)
        puts "----- Debug: Params Start -----"
        Rails.logger.debug "Params content: #{params.inspect}"
        puts "----- Debug: Params End -----"
        #@user.microposts.build(content: "This is a new micropost")引数も渡すことができる。
        if @micropost.save
          flash[:success] = "nice. you did it!"
          redirect_to user_path(@user)
        else
          flash[:danger] = "⚠️heads up! English only!!⚠️"
          flash[:danger] = @micropost.errors.full_messages.join(", ")
          redirect_to user_path(@user)
        end
    end

    def destroy
      @user = User.friendly.find(params[:slug])
      @micropost = Micropost.find(params[:id])
      if @micropost.destroy
        redirect_to @user, notice: "Post was successfully deleted."
      else
        redirect_to current_user, alert: "something went wrong post still there"
    end
  end


    private



    def micropost_params
      params.require(:micropost).permit(:content)
      #{"authenticity_token"=>"[FILTERED]", "content"=>"hh", "commit"=>"Post", "slug"=>"a"}
    end

end
