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

  # Public: The current state based on the overall steps states.
  #
  # The expected states are:
  #   * 'waiting'
  #   * 'reproved'
  #   * 'approved'
  #
  # Returns a String.
  def current_state
    if self.steps.where(state: 'reproved').exists?
      'reproved'
    elsif self.steps.pluck(:state).uniq == ['approved']
      'approved'
    else
      'waiting'
    end
  end

  # Public: The next step a candidate will be evaluated in.
  #
  # It's expected to always be the first waiting step, but there will not be
  # next step if the candidate reproves in at least one step.
  #
  # Returns a RecruitmentStep or nothing.
  def next_step
    if !self.steps.where(state: 'reproved').exists?
      self.steps.order(:order).find_by(state: 'waiting')
    end
  end
end
