class Organization < ActiveRecord::Base
  AlreadyHasOwnerError = Class.new(StandardError)

  belongs_to :owner, class_name: 'User'
  has_many :positions

  validates_presence_of :name

  to_param :name

  def set_owner!(owner)
    if self.owner
      raise AlreadyHasOwnerError, 'Organization already has an owner'
    else
      transaction do
        update!(owner: owner)
        owner.update!(organization: self)
      end
    end
  end
end
