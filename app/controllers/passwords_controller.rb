class PasswordsController < ApplicationController
  before_action :require_user_logged_in!

  def edit
  end

  def update
    if Current.user.update(password_params)
      redirect_to root_path, notice: "Password updated!"
    else
      @errors = []
      Current.user.errors.full_messages.each do |message|
        @errors.push(message)
      end
      redirect_to edit_password_path, flash: { warning: @errors }
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
