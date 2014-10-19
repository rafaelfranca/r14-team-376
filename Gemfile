source 'https://rubygems.org'

ruby '2.1.3'

gem 'rails', github: "rails/rails"

# Use postgresql as the database for Active Record
gem 'pg'
# Use edge version of sprockets-rails
gem 'sprockets-rails', github: "rails/sprockets-rails"

# Use SCSS for stylesheets
gem 'sass-rails', github: "rails/sass-rails"

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jQuery as the JavaScript library
gem 'jquery-rails', '~> 4.0.0.beta2'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'devise', '~> 3.4'
gem 'omniauth-github', '~> 1.1'

# Use Unicorn as the app server
# gem 'unicorn'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'

  gem 'rspec-rails', '~> 3.1'
end

group :production do
  gem 'rails_stdout_logging'
  gem 'puma'
end
