class Recruitment < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :recruiter, class_name: 'User'
  has_and_belongs_to_many :participants,
                          class_name: 'User',
                          association_foreign_key: 'participant_id',
                          join_table: 'recruitments_participants'
  has_many :steps, class_name: 'RecruitmentStep'

  # Public: The current progress based on approved steps.
  #
  # Examples
  #
  #   recruitment.progress
  #   # => 33.33
  #
  # Returns a Decimal.
  def progress
    total_steps_count = self.steps.count
    approved_steps_count = self.steps.where(state: 'approved').count
    (approved_steps_count * 100.0 / total_steps_count).round(2)
  end
end
