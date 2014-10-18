class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:github]
end
