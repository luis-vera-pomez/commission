module UsersHelper

  def available_users(team:)
    User.active.select { |user| user.is_any?(:supervisor, :agent) && !user.is_team_member?(team: team) }
  end

end
