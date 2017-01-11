require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'like relationships' do
    before do
      @user = db_create_user
      @idea = @user.ideas.create(text: 'Pepe the Frog')
      @like = Like.create(user: @user, idea: @idea)
    end
    it 'belongs to a user' do
      expect(@like.user).to eq(@user)
    end
    it 'belongs to an idea' do
      expect(@like.idea).to eq(@idea)
    end
  end
end
