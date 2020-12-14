class SessionsController < ApplicationController
    def new
    end

    def create
        user = User.find_by(username:params[:session][:username.downcase])
        if user && user.authenticate(params[:session][:password])
            session[:user_id] = user.id
            flash[:notice] = "You Are Logged In"
            redirect_to root_path
        else
            flash.now[:alert] = "Invalid Credentials"
            render 'new'
        end
    end

end
