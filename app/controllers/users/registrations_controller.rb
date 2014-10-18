class Users::RegistrationsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :fetch_organization

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:name, :email, :password, :password_confirmation)
    @user = User.new(user_params)

    if @user.save
      @organization.set_owner!(@user)

      sign_in_and_redirect @user
      flash[:notice] = t('devise.registrations.signed_up')
    else
      render 'new'
    end
  end

  private

  def fetch_organization
    @organization = Organization.find_by(id: session['devise.organization_id'])

    unless @organization
      redirect_to new_organizations_url, alert: 'Create a new organization'
    end
  end
end