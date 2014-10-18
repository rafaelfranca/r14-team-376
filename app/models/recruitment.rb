class Recruitment < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :recruiter, class_name: 'User'
  has_and_belongs_to_many :participants,
                          class_name: 'User',
                          association_foreign_key: 'participant_id',
                          join_table: 'recruitments_participants'
  has_many :steps, class_name: 'RecruitmentStep'
end
