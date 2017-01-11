require 'rails_helper'
RSpec.describe 'when creating ' do
  before do
    @user = create_user
    @idea = @user.ideas.create(text: "Washing Pole")
  end
  it 'expects idea page to include an idea' do
    visit '/bright_ideas' #why do i have to visit first? shouldn't the create user have the user on this page?
    expect(page).to have_text(@idea.text)
  end
  it 'expects page to include new idea input fields' do
    visit '/bright_ideas'
    expect(page).to have_field('idea[text]')
  end
  it 'expects user page to increase count of user ideas' do
    visit "/users/#{@user.id}"
    expect(page).to have_text('Total Number of Posts: 1')
  end
end
