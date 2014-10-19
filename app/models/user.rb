class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: [:github]

  belongs_to :organization

  def self.create_from_github(auth)
    create(
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      password: Devise.friendly_token[0, 20],
      name: auth.info.name,
      avatar: auth.info.image
    )
  end
end
