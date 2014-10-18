Rails.configuration.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, Rails.application.secrets.github_key, Rails.application.secrets.github_secret
end
