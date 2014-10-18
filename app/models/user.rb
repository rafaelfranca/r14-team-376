class User < ActiveRecord::Base
  devise :database_authenticatable, :omniauthable, :recoverable, :rememberable, :validatable
end
