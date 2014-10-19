class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.first_or_create_from_github(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'GitHub') if is_navigational_format?
    else
      session['devise.github_data'] = request.env['omniauth.auth']
      redirect_to new_users_url
    end
  end
end
