class Recruitment < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :recruiter, class_name: 'User'
end
