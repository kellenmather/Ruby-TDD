class UsersController < ApplicationController
  before_action :require_login, except: [:main, :index, :create, :new]

  def index
    redirect_to '/main'
  end

  def main
  end

  def show
    @user = current_user
    @likes = @user.likes.length
    @posts = @user.ideas.length
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to '/bright_ideas'
    else
      flash[:errors] = user.errors.full_messages
      redirect_to :back
    end
  end

  private
    def user_params
      params.require(:user).permit(:fn, :ln, :alias, :email, :password, :password_confirmation)
    end
end
