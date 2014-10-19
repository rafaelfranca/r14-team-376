class RecruitmentStep < ActiveRecord::Base
  belongs_to :recruitment
  has_many :comments
end
