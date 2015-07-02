require 'rails_helper'

feature 'user registers', %{
  As a prospective user
  I want to create an account
  So that I can post items and review them
} do

  # Acceptance Criteria:
  # [x] I must specify a valid email address, username,
  #   password, and password confirmation
  # [x] If I don't specify the required information, I am presented with
  #   an error message

  scenario 'provide valid registration information' do
    visit new_user_registration_path

    fill_in 'Email', with: 'john@example.com'
    fill_in 'Username', with: "johnsmith"
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    attach_file('user[profile_photo]',
      File.absolute_path('./spec/support/upload/image_upload.jpg'))

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('Sign Out')
  end

  scenario 'provide invalid registration information' do
    visit new_user_registration_path

    click_button 'Sign up'
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content('Sign Out')
  end
end
