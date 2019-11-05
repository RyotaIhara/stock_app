class ApplicationController < ActionController::Base
    def hello
        render html: "hello,world!"
    end

    private def current_user
        User.find_by(id: session[:user_id]) if session[:user_id]
    end
    helper_method :current_user
end