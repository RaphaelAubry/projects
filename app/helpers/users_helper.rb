module UsersHelper
  def selection_for_available_tasks
    Task.available.map { |task| [ task.name, task.id ] }.sort
  end
end
