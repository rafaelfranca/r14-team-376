class Position < ActiveRecord::Base
  belongs_to :organization

  validates_presence_of :title, :organization
end
