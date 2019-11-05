class ApplicationController < ActionController::Base
    def hello
        render html: "hello,world!"
    end

    private def current_member
        Member.find_by(id: session[:member_id]) if session[:member_id]
    end
    helper_method :current_member
end