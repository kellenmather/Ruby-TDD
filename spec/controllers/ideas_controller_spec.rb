require 'rails_helper'

RSpec.describe IdeasController, type: :controller do
  before do
    @user = db_create_user
    @idea = @user.ideas.create(text: "idea example")
  end
  describe "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access index" do
      get :index
      expect(response).to redirect_to('/main')
    end
    it "cannot access create" do
      post :create
      expect(response).to redirect_to('/main')
    end
    it "cannot access destroy" do
      delete :destroy, id: @idea
      expect(response).to redirect_to('/main')
    end
  end
end
