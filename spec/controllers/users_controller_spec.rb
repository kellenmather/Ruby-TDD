require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = db_create_user
  end
  describe "when not logged in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access show" do
      get :show, id: @user
      expect(response).to redirect_to('/main')
    end
  end
end
