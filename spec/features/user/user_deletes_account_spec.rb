require 'rails_helper'

feature 'user deletes their account', %{
  As an authenticated user
  I want to delete my account
  So that my information is no longer retained by the app
} do

  # Acceptance Criteria
  # [] When I'm signed in, I have the option to go to my "Edit Profile" page
  # and select a button to delete my account
  # [] I receive a confirmation that my account has been cancelled
  # [] And therefore, I am no longer signed into my account

  scenario 'user deletes account from the edit page' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    visit edit_user_registration_path

    click_button 'Cancel my account'

    expect(page).to have_content('Bye! Your account has been
    successfully cancelled.')
    expect(page).to have_content('Sign Up')
  end
end
