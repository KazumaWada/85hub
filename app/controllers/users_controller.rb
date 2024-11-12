class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show] #allow only logined users(devise method)
  def show
    @user = current_user #user操作時にdeviseが生成する変数
  end
end
