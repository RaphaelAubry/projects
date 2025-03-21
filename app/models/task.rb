class Task < ApplicationRecord
  belongs_to :project

  scope :available, ->() { where(user_id: nil) }

  def user
    User.find(user_id) if user_id
  end
end
