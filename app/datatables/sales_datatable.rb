class SalesDatatable < Effective::Datatable

  datatable do
    order :id, :desc
    
    col :id
    col :product
    col :agent
    col :quantity
    col :total
    col :saled_at
  end

  collection do
    scope = Sale.includes(:product, :agent)

    attributes[:team_id].present? ? scope.where(agents: { team_id: attributes[:team_id] } ) : scope
  end

end
