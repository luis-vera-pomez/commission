class AgentsDatatable < Effective::Datatable

  datatable do
    order :title
    
    col(:first_name) { |a| a.user.first_name }
    col(:last_name) { |a| a.user.last_name }
    col(:email) { |a| a.user.email }
    col :associated_at
    col :departed_at
  end

  collection do
    scope = Agent.includes(:user).all

    attributes[:team_id].present? ? scope.where(team_id: attributes[:team_id] ) : scope
  end

end
