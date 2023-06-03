class PasswordResetsController < ApplicationController
  before_action :get_user_from_token, only: [:update]

  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      # Send Email
      PasswordMailer.with(user: @user).reset.deliver_now
    end
    redirect_to root_path, notice: "If an account was found with that email, we have sent a link to reset your password."
  end
  def edit
    @user = User.find_signed(params[:token], purpose: "password_reset")
    @token = params[:token]
  end
  def update
    if @user
      if params[:password].present?
        @user.update(password: params[:password])
        redirect_to root_path, notice: "Your password has been reset."
      else
        redirect_to request.referer, alert: "Password can't be blank."
      end
    else
      redirect_to root_path, alert: "Invalid password reset token."
    end
  end

  private

  def get_user_from_token
    @user = User.find_signed(params[:token], purpose: "password_reset")
  end
end

