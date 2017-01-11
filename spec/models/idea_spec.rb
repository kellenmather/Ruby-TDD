require 'rails_helper'

RSpec.describe Idea, type: :model do

  # New Idea Validation Testing

  it 'requires an idea to have text' do
    idea = Idea.new(text: '')
    idea.valid?
    expect(idea.errors[:text].any?).to eq(true)
  end
  it 'requires an idea to be at least 9 characters' do
    idea = Idea.new(text: '12345678')
    idea.valid?
    expect(idea.errors[:text].any?).to eq(true)
  end
  # BELOW WE CHECK REGARDING IDEAS RELATIONSHIP TO LIKES AND USER_LIKES

  describe 'idea relationships' do
    before do
      @user = db_create_user
      @idea = @user.ideas.create(text: 'Malcolm Reynolds')
      @like = Like.create(user: @user, idea: @idea)
    end
    it 'has many likes' do
      expect(@idea.likes).to include(@like)
    end
    it 'has many users through likes via user_likes' do
      expect(@idea.user_likes).to include(@user)
    end
    it 'belongs to a user' do
      expect(@user.ideas).to include(@idea)
    end
  end
  # BELOW CHECKS THAT DEPENDENT DESTROY RELATIONSHIP WITH IDEAS AND LIKES WORKS

  describe 'idea dependent destroy' do
    before do
      @user2 = db_create_user
      @idea2 = @user2.ideas.create(text: 'Malcolm Reynolds')
      @like2 = Like.create(user: @user2, idea: @idea2)
      @idea2.destroy
    end
    it 'expect likes to be destroyed when the idea is destroyed' do
    expect(@user2.likes.count).to eq(0)
    end
  end

end
