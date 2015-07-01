require 'rails_helper'

feature 'user signs in', %{
  As an unauthenticated user
  I want to sign in
  So that I can post items and review them
} do

  # Acceptance Criteria
  # [x] I must fill in an email and password that has a user linked to it
  # [x] If I fill in an email/ password that is not associated with a user I
  #  am given an error

  scenario 'specify valid credentials' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Sign Out')
  end

  scenario 'specify invalid credentials' do
    visit new_user_session_path

    click_button 'Log in'
    expect(page).to have_content('Invalid email or password')
    expect(page).to_not have_content('Sign Out')
  end
end
