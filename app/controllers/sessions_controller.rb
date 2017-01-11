class SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to '/bright_ideas'
    else
      flash[:errors] = ['Invalid Credentials']
      redirect_to :back
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/main'
  end
  
  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
