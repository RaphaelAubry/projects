module TasksHelper
  def selection
    User.all.map { |user| [ user.name, user.id ] }
  end
end
