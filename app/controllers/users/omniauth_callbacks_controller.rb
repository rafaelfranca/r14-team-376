class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    auth = request.env['omniauth.auth']

    @user = User.find_by(provider: auth.provider, uid: auth.uid)

    if @user
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'GitHub')
    else
      @organization = Organization.find_by(id: session['devise.organization_id'])

      if @organization
        @user = User.create_from_github(auth)

        if @user.persisted?
          if @organization.owner
            @user.update(organization: @organization)
          else
            @organization.set_owner!(@user)
          end

          sign_in_and_redirect @user
          set_flash_message(:notice, :success, kind: 'GitHub')
        else
          session['devise.github_data'] = auth
          redirect_to new_users_url
        end
      else
        redirect_to new_organization_url, alert: 'Create a new organization'
      end
    end
  end
end
