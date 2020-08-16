class VisitorsController < ApplicationController
  def new
    @visitor = Visitor.new
  end

  def create
    @visitor = Visitor.new(visitor_params)

    if @visitor.save
      cookies.signed[:auth_token] = @visitor.auth_token
      redirect_to blogs_path, notice: 'Thank you for signing up'
    else
      render 'new'
    end
  end

  private

  def visitor_params
    params.require(:visitor).permit(:email, :password, :password_confirmation)
  end
end
