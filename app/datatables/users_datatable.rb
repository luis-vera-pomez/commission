class UsersDatatable < Effective::Datatable

  datatable do
    order :first_name
    
    col :first_name
    col :last_name
    col :email
    col :archived, visible: false

    actions_col partial: 'admin/users/actions', partial_as: :user
  end

  collection do
    User.all
  end

end
