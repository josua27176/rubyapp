class MainController < ApplicationController

  def index
    flash.now[:notice]
    flash.now[:alert]
    if session[:user_id]
      @user = User.find(session[:user_id])
    end
  end
end
