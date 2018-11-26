class TeamsDatatable < Effective::Datatable

  datatable do
    order :title
    
    col :title
    col :description
    col :location

    col(:supervisors) { |team| team.supervisors }
    col(:sellers) { |team| team.sellers }

    col :created_at, visible: false
    col :updated_at, visible: false

    actions_col partial: 'admin/teams/actions', partial_as: :team
  end

  collection do
    Team.all
  end

end
