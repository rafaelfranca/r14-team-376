class Users::RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    @user = User.new(user_params)

    if @user.save
      sign_in_and_redirect @user
      flash[:notice] = t('devise.registrations.signed_up') if is_navigational_format?
    else
      render 'new'
    end
  end
end
