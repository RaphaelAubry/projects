class Task < ApplicationRecord
  belongs_to :project

  scope :available, ->() { where(user_id: nil) }
  scope :status, ->(value) { where(status: value) }
  scope :finished, ->() { where(status: "terminée") }

  STATUSES = [ "en cours", "terminée", "annulée", "stoppée", "aucun" ].freeze

  def user
    User.find(user_id) if user_id
  end
end
