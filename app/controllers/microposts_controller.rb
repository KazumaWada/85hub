class MicropostsController < ApplicationController
  #CSRFtokenを投稿時に無効化する。
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :require_login, only: [:zen_new]

  # calendar機能をつけて、ユーザーが投稿したら、印が付くような仕組みにする。
    def calendar
      @user = User.find_by(slug: params[:slug])   
    end

    def draft
    @user = User.find_by(slug: params[:slug])   
    @microposts = @user.microposts
    end
    def draft_create
      @user = User.find_by(slug: params[:slug]) 
      @micropost = @user.microposts.build(micropost_params)

      if @micropost.save
        flash[:success] = "draft saved"
        redirect_to user_path(@user)
      else
        flash[:danger] = "⚠️heads up! English only!!⚠️"
        flash[:danger] = @micropost.errors.full_messages.join(", ")
        redirect_to user_path(@user)
      end
    end

    def index
      #単数: model, 複数: DBのテーブル名
      #@microposts = Micropost.all
      #@microposts = Micropost.includes(:user).all#投稿と一緒にuser.nameも表示したいから。
      #Userを見せないともっと集中できていいかも。
      @microposts = Micropost.all
    end

    def new
      @user = User.find_by(slug: params[:slug])
      @micropost = Micropost.new#空のインスタンスを作成(userとはつながっていない)
    end
    def zen_new
      @user = User.find_by(slug: params[:slug])
      @micropost = Micropost.new#空のインスタンスを作成(userとはつながっていない)
    end

    def zen_create 
      # fixed_params = { micropost: { content: params[:content] } }
      # params.merge!(fixed_params)  
      Rails.logger.debug "🛠️🛠️🛠️🛠️🛠️🛠️🛠️🛠️🛠️🛠️🛠️🛠️🛠️🛠️🛠️🛠️Params: #{params.inspect}" # パラメータの中身をログに表示

      @user = User.find_by(slug: params[:slug])
      @micropost = @user.microposts.build(micropost_params)

      if @micropost.save
        flash[:success] = "posted from zen mode!"
        redirect_to user_path(@user)
      else
        flash[:danger] = "⚠️heads up! English only!!⚠️"
        flash[:danger] = @micropost.errors.full_messages.join(", ")
        redirect_to user_path(@user)
      end

    end

    def create 
      fixed_params = { micropost: { content: params[:content] } }
      params.merge!(fixed_params)
    
     
        @user = User.find_by(slug: params[:slug])
        @micropost = @user.microposts.build(micropost_params)
        #@microposts_by_date = @user.microposts.group_by { |post| post.created_at.to_date }

        puts "----- Debug: Params Start -----"
        Rails.logger.debug "Params content: #{params.inspect}"
        puts "----- Debug: Params End -----"
        #@user.microposts.build(content: "This is a new micropost")引数も渡すことができる。
        if params[:draft]
          @micropost.status = 'draft'
        else
          @micropost.status = 'published'
        end

        if @micropost.save && @micropost.status == "published"
          flash[:success] = "nice. you did it!"
          redirect_to user_path(@user)
        elsif@micropost.save && @micropost.status == "draft"
          flash[:success] = "draft saved. 戻る👈"
          redirect_to draft_path(@user)

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
