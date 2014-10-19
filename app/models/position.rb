class Position < ActiveRecord::Base
  belongs_to :organization, required: true
  has_many :recruitments

  validates_presence_of :title
end
