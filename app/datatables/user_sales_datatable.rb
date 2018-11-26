class UserSalesDatatable < Effective::Datatable

  datatable do
    order :saled_at, :desc
    
    col :saled_at
    col :policy

    col(:team) { |sale| sale.agent.team.title }
    col(:location) { |sale| sale.agent.team.location }

    col :product
    col :quantity
    col :total
  end

  collection do
    scope = Sale.includes(:product, agent: [:user, :team])

    attributes[:user_id].present? ? scope.where(agents: { user_id: attributes[:user_id] } ) : scope
  end

end
