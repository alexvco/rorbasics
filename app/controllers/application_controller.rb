class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find_by_id(cookies[:user_id])
  end

  def current_visitor
    @current_visitor ||= Visitor.find_by_id(session[:visitor_id])
  end

  # this will make current_visitor method be accessible from the view
  helper_method :current_visitor

  # before_action :authenticate!, only: [:edit, :update]
  def authenticate!
    redirect_to new_session_path, notice: 'You need to login before performing this action' unless current_visitor
  end
end
