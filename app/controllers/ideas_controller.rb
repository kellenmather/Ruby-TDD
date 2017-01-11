class IdeasController < ApplicationController
  before_action :require_login, only: [:index, :create, :destroy, :show]

  def index
    @ideas = Idea.all.includes(:likes).includes(:user_likes).sort{|a,b| b.likes.count <=> a.likes.count}
  end

  def show
    @idea = Idea.includes(:user_likes, :user, :likes).find(params[:id])
    # why does using the .includes result in one extra query?
  end

  def create
    idea = current_user.ideas.new(idea_params)
    if idea.save
      redirect_to :back
    else
      flash[:errors] = ['Please enter an Idea']
      redirect_to :back
    end
  end

  def add_like
    idea = Idea.find(params[:id])
    Like.create(user: current_user, idea: idea)
    redirect_to :back
  end

  def destroy
    idea = Idea.find(params[:id])
    idea.destroy if idea.user == current_user
    redirect_to :back
  end

  private
    def idea_params
      params.require(:idea).permit(:text)
    end
end
