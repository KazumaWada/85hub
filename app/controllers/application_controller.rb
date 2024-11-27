class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception 
    include SessionsHelper #rails7ではhelperに書いたら全てのviewに適応される仕様になっている。他のcontroller同士で使いまわしたい時はこうやって書く
    private

    def logged_in_user
        unless logged_in?
            store_location
            redirect_to login_url
        end
    end
end
