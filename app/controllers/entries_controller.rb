class EntriesController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @entries = current_user.entries.order(created_at: :desc)
    end

    def show
        @entries = current_user.entries#index
    end
  
    def new#form、つまり新しいデータの送信場所を作る
      @entry = current_user.entries.new
    end
    #フォームの送信結果を処理するためのアクション(viewは存在しない)
    #new.html.erbで作成されたフォームを通してcreateにデータが送信される、DBに保存する、リダイレクトする。
    def create  
      @entry = current_user.entries.new(entry_params)
      if @entry.save
        #redirect_to entries_path, notice: 'Entry was successfully created.'
        redirect_to user_path(current_user), notice: 'Entry was successfully created.'
      else
        render :new
      end
    end

    def button_click_action#router参照
      #ここにボタンをクリックした時のアクションを書く。
    end
  
    private
  
    def entry_params
      params.require(:entry).permit(:content)
    end
  end
  