class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }

  def check_password_params
    return unless params[:user].present? && params[:user][:password].blank? && params[:user][:password_confirmation].blank?

    params[:user].delete(:password)
    params[:user].delete(:password_confirmation)
  end

end
