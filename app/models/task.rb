class Task < ApplicationRecord
  belongs_to :project

  scope :available, ->() { where(user_id: nil) }
  scope :status, ->(value) { where(status: value) }

  STATUSES = [ "en cours", "terminée", "annulée", "stoppée", "aucun" ]

  def user
    User.find(user_id) if user_id
  end
end
