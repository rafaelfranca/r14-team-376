class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include OrganizationFetcher

  before_action :fetch_organization

  def github
    @user = User.first_or_create_from_github(request.env['omniauth.auth'])

    if @user.persisted?
      if @organization.owner
        @user.update(organization: @organization)
      else
        @organization.set_owner!(@user)
      end

      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'GitHub')
    else
      session['devise.github_data'] = request.env['omniauth.auth']
      redirect_to new_users_url
    end
  end
end
