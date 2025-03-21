require 'rtesseract'
class UsersController < ApplicationController
  before_action :require_login, only: [:index, :analyze, :edit, :update]


  def index
    @users = User.all
  end

  def analyze
    uploaded_file = params[:image]
  
    if uploaded_file.nil?
      flash[:alert] = "画像をアップロードしてください。"
      redirect_to current_user
      return
    end

    #app/tmpにユーザー画像を保存
    saved_tmp_path = Rails.root.join('tmp', uploaded_file.original_filename).to_s
    File.open(saved_tmp_path, 'wb') do |file|
      file.write(uploaded_file.read)
    end

    #処理するファイルのpathを定義 app/tmp
    tmp_path = Rails.root.join('tmp', "processed_#{SecureRandom.hex(8)}.png").to_s
    processed_image_path = TextImageProcessor.preprocess_image(saved_tmp_path, tmp_path)
    
    #lib/handwriting_recognizer.rbでpre処理(RTesseractで画像を処理しやすくする)
    image = RTesseract.new(processed_image_path, lang: 'eng')
    ocr_result = image.to_s
    #render json: { text: ocr_result } 
    #render html: "<p>#{ocr_result}</p>".html.safe
    redirect_to camera_path(slug: current_user.slug, ocr_result: ocr_result)
  end

  def camera
    @user = User.find_by(slug: params[:slug])  
    @ocr_result = params[:ocr_result]
  end

  def show
    @user = User.find_by(slug: params[:slug])   
    @microposts = @user.microposts
    #showにわざわざcountを定義する必要はない。なぜなら結局user.microposts側でloopさせるから。
    #必要なのは、Micropostのshowアクション内で各idのcountに対してcount++させていく必要がある。
    #countを定義するために、micropost.countを定義する必要がある。
    #@microposts = @user.micropost[index].countみたいな
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
      flash[:success] = "Hi #{@user.name}! next step, please login"
    else
      puts @user.errors.full_messages
      flash[:danger] = "#{@user.errors.full_messages}"
      redirect_to signup_path 
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

  def flashcards
    @user = User.find_by(slug: params[:slug])
    @microposts = @user.microposts
    puts "📚📚📚📚📚" , @microposts.published.sample(5).count
  end

  def quiz_correct_num_edit #router quiz_path
    @user = User.find_by(slug: params[:slug])
    @microposts = @user.microposts
  end

  def quiz_correct_num_update#SQL文と考えたほうがスッと入る
    @user = User.find_by(slug: params[:slug]) 
    puts "🔧 params: #{params[:correct_num]}"
    micropost = @user.microposts.find(params[:id])
      
    if micropost.update(correct_num: params[:correct_num]) 
      puts "UPDATEしました！"
    else
      puts "NNNNNNNNNNNNN?!"
    end
    #saveでpatchリクエストが更新される if saveできたら、 else カードの正解数の集計ができませんでした。
    
    redirect_to quiz_path
  end

  def done_quiz
    @user = User.find_by(slug: params[:slug]) 
    flash[:succeess] = 'ナイス🎉'
    redirect_to root_path
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

  # def current_user#pathでは使えない。cookieで保存されているのはuser_idのみ。cookie.signedにuser.nameも保存すれば、current_userが便利に使えるようになる。
  #   @current_user ||= User.find_by(id: cookies.signed[:user_id])
  #   logger.debug "👷👷👷👷👷@current_user: #{@current_user.inspect}" 
  # end
  
end 
