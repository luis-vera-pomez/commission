class SalesDatatable < Effective::Datatable

  datatable do
    order :saled_at, :desc
    
    col :saled_at
    col :policy
    col :product
    col :agent
    col :quantity
    col :total
  end

  collection do
    scope = Sale.includes(:product, :agent)

    attributes[:team_id].present? ? scope.where(agents: { team_id: attributes[:team_id] } ) : scope
  end

end
