class Comment < ActiveRecord::Base
  belongs_to :recruitment_step
  belongs_to :author, class_name: 'User'

  after_save do |comment|
    unless comment.recruitment_step.recruitment.participants.where(id: comment.author.id).exists?
      comment.recruitment_step.recruitment.participants << comment.author
    end
  end
end
