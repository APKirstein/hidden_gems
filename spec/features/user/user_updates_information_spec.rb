require 'rails_helper'

feature 'user edits their login information', %{
  As an authenticated user
  I want to update my information
  So that I can keep my profile up to date
} do

  # Acceptance Criteria
  # [X] If I'm signed in, I see a link to edit my profile as a drop down
  # [X] When I click the link, I can edit my information via form
  # [X] The form is populated w/ my current info with the password as stars
  # [X] When I submit the form, my information is updated
  # [X] I will see a confirmation on my profile page when form is submitted

  scenario 'authenticated user edits profile information' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_css('.dropdown_edit')

    #  Dropdown menu uses Javascript that is untestable using this Capybara gem
    #  Instead, we have tested for inclusion of link as well as actions once
    #  the link has been clicked

    visit edit_user_registration_path

    fill_in 'user[username]', with: 'newusername'
    fill_in 'user[current_password]', with: user.password
    attach_file('user[profile_photo]',
      File.absolute_path('./spec/support/upload/image_upload.jpg'))

    click_button 'Update'

    page.should have_selector("img[src$='image_upload.jpg']")

    expect(page).to have_content('newusername')
    expect(page).to have_content("Your account has been updated successfully")
  end
end
