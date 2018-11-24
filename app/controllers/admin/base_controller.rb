class Admin::BaseController < ApplicationController
  before_action :authenticate_user!   # This is devise, ensure we're logged in.
end
