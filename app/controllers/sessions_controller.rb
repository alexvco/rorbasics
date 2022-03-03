class SessionsController < ApplicationController
  def new; end

  def create
    visitor = Visitor.find_by(email: params[:email])
    if visitor&.authenticate(params[:password])
      visitor.generate_token(:auth_token)
      visitor.save
      # Sets a "signed" cookie, which prevents users from tampering with its value.
      # It can be read using the signed method `cookies.signed[:name]`
      # Sets a "permanent" cookie (which expires in 20 years from now).
      if params[:remember_me]
        cookies.signed.permanent[:auth_token] = visitor.auth_token
      else
        cookies.signed[:auth_token] = visitor.auth_token
      end

      # session[:visitor_id] = visitor.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    current_visitor&.update(auth_token: nil)
    cookies.delete(:auth_token)
    # session[:visitor_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
