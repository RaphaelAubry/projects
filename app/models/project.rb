class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy

  def progression
    begin
      tasks.present? ? tasks.finished.length / tasks.length.to_f : 0
    rescue Exception => e
      Rails.logger.debug "Exception class : #{e.class}"
      Rails.logger.debug "Exception message : #{e.message}"
      Rails.logger.debug "Exception backtrace : \n#{e.backtrace.join("\n")}"
    ensure
      return 0
    end
  end
end
