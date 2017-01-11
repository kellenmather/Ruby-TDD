require 'rails_helper'
RSpec.describe 'displaying likes' do
  before do
    @user = create_user
    @idea = @user.ideas.create(text: 'Johnny Cash')
    Like.create(user: @user, idea: @idea)
  end
  it 'displays amount of likes next to each idea' do
    visit '/bright_ideas'
    expect(page).to have_text(@idea.text)
    expect(page).to have_text('1 people')
  end
  it 'displays idea and users info who have liked the idea' do
    visit "/ideas/#{@idea.id}"
    expect(page).to have_text(@idea.text)
    expect(page).to have_text(@idea.user_likes[0].alias)
  end
  it 'displays increases like count when user likes an idea' do
    visit "/users/#{@user.id}"
    expect(page).to have_text('Posts: 1')
  end
end
