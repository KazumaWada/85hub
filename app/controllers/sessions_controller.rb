class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: session_params[:name])

    if user && user.authenticate(session_params[:password])
      #current_userメソッドを使えるようにするためにこうやって書いている。
      cookies.signed[:user_data] = {
                                    value: { user_id: user.id, slug: user.slug },
                                    httponly: true,
                                    secure: Rails.env.production?
      }

      #cookies.signed[:user_id] = { value: user.id, httponly: true, secure: Rails.env.production? }
      
      flash[:success] = "ようこそ🎉! #{current_user.name}さん。"
      redirect_to question_path
    else
      flash.now[:danger] = "invalid ..."
      redirect_to root_path 
    end
  end

  def destroy
    Rails.logger.info "Destroy action called"
    cookies.delete(:user_data)
    flash[:success] = "successfuly logged out"
    redirect_to root_path
  end
end


private

 def session_params
    params.require(:session).permit(:name, :password)
 end
