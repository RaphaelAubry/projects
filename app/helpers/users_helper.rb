module UsersHelper
  def available_selection
    Task.available.map { |task| [ task.name, task.id ] }
  end
end
