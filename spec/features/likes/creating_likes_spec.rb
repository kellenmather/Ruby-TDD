require 'rails_helper'
RSpec.describe 'creating likes' do
  before do
    @user = create_user
    @idea = @user.ideas.create(text: 'Eye of the Tiger')
  end
  it 'creates like and displays it both on home page and user idea page' do
    visit '/bright_ideas'
    expect(page).to have_text('0 people')
    click_link 'Like'
    expect(page).to have_text('1 people')
    visit "/ideas/#{@idea.id}"
    expect(page).to have_text(@user.fn)
    expect(page).to have_text(@user.ln)
  end
end
