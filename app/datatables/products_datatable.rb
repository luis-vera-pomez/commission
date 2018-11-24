class ProductsDatatable < Effective::Datatable

  datatable do
    order :title
    
    col :title
    col :price

    actions_col partial: 'admin/products/actions', partial_as: :product
  end

  collection do
    Product.all
  end

end
