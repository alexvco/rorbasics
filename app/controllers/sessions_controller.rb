class SessionsController < ApplicationController
  def new
  end

  def create
    visitor = Visitor.find_by(email: params[:email])
    if visitor && visitor.authenticate(params[:password])
      session[:visitor_id] = visitor.id
      redirect_to root_url, notice: 'Logged in!'
    else
      flash.now.alert = 'Email or password is invalid'
      render 'new'
    end
  end

  def destroy
    session[:visitor_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
