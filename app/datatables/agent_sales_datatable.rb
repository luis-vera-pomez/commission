class AgentSalesDatatable < Effective::Datatable

  datatable do
    order :saled_at, :desc
    
    col :saled_at
    col :id
    col :product
    col :agent
    col :quantity
    col :total
  end

  collection do
    scope = Sale.includes(:product, :agent)

    attributes[:agent_id].present? ? scope.where(agent_id: attributes[:agent_id] ) : scope
  end

end
