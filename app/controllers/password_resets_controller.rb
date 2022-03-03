class PasswordResetsController < ApplicationController
  def new; end

  def create
    visitor = Visitor.find_by(email: params[:email])
    visitor&.send_password_reset
    redirect_to root_url, notice: "If email was found, a password reset email with instructions was sent"
  end

  def edit
    # using find_by! so that a 404 is raised if token is not found (ActiveRecord::RecordNotFound)
    @visitor = Visitor.find_by!(password_reset_token: params[:id]) # NOTE: that the id is the token here
  end

  def update
    @visitor = Visitor.find_by!(password_reset_token: params[:id])
    if @visitor.password_reset_sent_at < (Time.now.utc - 2.hours) # aka less than 2.hours.ago but in utc cause thats how it is saved in db
      redirect_to new_password_reset_path, alert: "Password reset has expired."
    elsif @visitor.update(visitor_params)
      redirect_to root_url, notice: "Password reset successful"
    else
      render :edit
    end
  end

  private

  def visitor_params
    params.require(:visitor).permit(:password, :password_confirmation)
  end
end
