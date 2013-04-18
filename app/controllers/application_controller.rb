class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :check_for_login

  def check_for_login
    redirect_to new_player_path unless session[:player]
  end
end
