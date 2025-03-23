module TasksHelper
  def selection_for_users
    User.all.map { |user| [ user.name, user.id ] }.sort
  end
end
