class MicropostsController < ApplicationController

    def index
      #単数: model, 複数: DBのテーブル名
      #@microposts = Micropost.all
      @microposts = Micropost.includes(:user).all#投稿と一緒にuser.nameも表示したいから。
    end

    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
          flash[:success] = "nice. you did it!"
          redirect_to current_user
        else
          render root_url
          flash[:success] = "something went wrong/"
        end
    end

    def destroy
    end

    private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

end
