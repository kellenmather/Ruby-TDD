require 'rails_helper'
RSpec.describe 'logging in and registration' do
  before do
    @user = create_user
  end
  it 'expects user to be logged in' do
    expect(current_path).to eq('/bright_ideas')
    expect(page).to have_text(@user.fn)
  end
  it 'expects the user to be able to log out' do
    log_out
    expect(current_path).to eq('/main')
  end
  it 'expects errors to flash when user registers with incomplete details' do
    visit '/main'
    click_button 'Register'
    expect(current_path).to eq('/main')
    expect(page).to have_text('invalid')
    expect(page).to have_text("can't be blank")
  end
  it 'expects main page to have login and registration input' do
    visit '/main'
    expect(page).to have_field('session[email]')
    expect(page).to have_field('session[password]')
    expect(page).to have_field('user[fn]')
    expect(page).to have_field('user[ln]')
    expect(page).to have_field('user[alias]')
    expect(page).to have_field('user[email]')
    expect(page).to have_field('user[password]')
    expect(page).to have_field('user[password_confirmation]')
  end
  it 'logs in user if email/password combination is valid' do
    log_in @user
    expect(current_path).to eq('/bright_ideas')
    expect(page).to have_text(@user.fn)
  end
  it 'does not sign in user if email/password combination is invalid' do
    log_in @user, 'wrong password'
    expect(page).to have_text('Invalid')
  end
end
