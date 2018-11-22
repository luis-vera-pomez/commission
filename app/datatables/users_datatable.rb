class UsersDatatable < Effective::Datatable

  datatable do
    order :first_name
    
    col :first_name
    col :last_name
    col :email
    col :archived
  end

  collection do
    User.all
  end

end
