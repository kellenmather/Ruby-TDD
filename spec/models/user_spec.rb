require 'rails_helper'

RSpec.describe User, type: :model do

  # New User Validation Testing

  it 'requires a first name' do
    user = User.new(fn: '')
    user.valid?
    expect(user.errors[:fn].any?).to eq(true)
  end
  it 'requires a last name' do
    user = User.new(ln: '')
    user.valid?
    expect(user.errors[:ln].any?).to eq(true)
  end
  it 'requires an alias' do
    user = User.new(alias: '')
    user.valid?
    expect(user.errors[:alias].any?).to eq(true)
  end
  it 'requires an email' do
    user = User.new(email: '')
    user.valid?
    expect(user.errors[:email].any?).to eq(true)
  end
  it 'rejects improper email formats' do
    emails = %w[@ user@ john@example @example.com]
    emails.each do |email|
      user = User.new(email: email)
      user.valid?
      expect(user.errors[:email].any?).to eq(true)
    end
  end
  it 'requires a unique case insensitive email' do
    user1 = User.create(fn: 'John', ln: 'Doe', alias: 'JD', email: 'john@doe.com', password: 'password', password_confirmation: 'password')
    user2 = User.new(email: user1.email.upcase)
    user2.valid?
    expect(user2.errors[:email].any?).to eq(true) # or [:email].first).to eq("has already been taken")
  end
  it 'requires a password' do
    user = User.new(password: '')
    user.valid?
    expect(user.errors[:password].any?).to eq(true)
  end
  it 'requires password and password_confirmation to match' do
    user = User.new(password: 'password', password_confirmation: 'not_matching')
    user.valid?
    expect(user.errors[:password_confirmation].first).to eq("doesn't match Password")
  end
  it 'automatically encrypts the password into the password_digest attribute' do
    user = User.create(fn: 'John', ln: 'Doe', alias: 'JD', email: 'john@doe.com', password: 'password', password_confirmation: 'password')
    expect(user.password_digest.present?).to eq(true)
  end
  # BELOW WE CHECK REGARDING USER RELATIONSHIP TO IDEAS AND LIKES
  describe 'user relationships' do
    before do
      @user = db_create_user
      @idea1 = @user.ideas.create(text: 'Lil Timmy')
      @idea2 = @user.ideas.create(text: 'Timmy the Cruel')
      @like1 = Like.create(user: @user, idea: @idea1)
      @like2 = Like.create(user: @user, idea: @idea2)
    end
    it 'has many ideas' do
      expect(@user.ideas).to include(@idea1)
      expect(@user.ideas).to include(@idea2)
    end
    it 'has many likes' do
      expect(@user.likes).to include(@like1)
      expect(@user.likes).to include(@like2)
    end
  end
end
