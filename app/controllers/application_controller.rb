class ApplicationController < ActionController::Base

  def check_password_params
    return unless params[:user].present? && params[:user][:password].blank? && params[:user][:password_confirmation].blank?

    params[:user].delete(:password)
    params[:user].delete(:password_confirmation)
  end

end
