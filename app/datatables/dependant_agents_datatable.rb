class DependantAgentsDatatable < Effective::Datatable

  datatable do
    order :full_name
    
    col :full_name
    col :associated_at
    col :departed_at
    col :roles

    actions_col partial: 'admin/agents/actions', partial_as: :agent
  end

  collection do
    scope = Agent.includes(:team, :user, supervised_by: [:user]).active

    attributes[:team_id].present? && attributes[:supervised_by_id].present? ? scope.where(team_id: attributes[:team_id], supervised_by_id: attributes[:supervised_by_id]) : scope
  end

end
