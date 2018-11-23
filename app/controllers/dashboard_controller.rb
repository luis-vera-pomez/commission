class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_action!

  def index
    @page_title = 'Dashboard'
  end

  private

  def authorize_action!
    authorize! action_name.to_sym, 'Dashboard'
  end

end
