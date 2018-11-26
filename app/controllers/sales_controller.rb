class SalesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_action!

  def index
    @page_title = 'Sales'

    @datatable = UserSalesDatatable.new(self, user_id: current_user.id)
  end

  private

    def authorize_action!
      authorize! action_name.to_sym, 'Dashboard'
    end

end
