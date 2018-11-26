class UserTeamsDatatable < Effective::Datatable

  datatable do
    order :id, :desc
    
    col :title
    col :location
    col(:total_sales) { |t| t.sales_per_user(user_id: attributes[:user_id]) } 
  end

  collection do
    scope = Team.includes(agents: [:user]).joins(:agents)

    attributes[:user_id].present? ? scope.where(teams: { agents: { user_id: attributes[:user_id] }} ) : scope
  end

end
