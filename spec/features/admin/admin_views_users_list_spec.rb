require 'rails_helper'

feature 'admin views list of users', %{
  As an administrator of Date Bites
  I want to see a list of users via usernames and emails
  So that I can view who is using my website.
} do

  # Acceptance Criteria:
  # [X] I must be logged in as an admin
  # [X] I can visit /admin/users to see all users

  let!(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'admin views users' do
    sign_in_as(admin)
    visit admin_users_path

    expect(page).to have_content(user.username)
    expect(page).to have_content(user.email)
  end

  scenario 'unauthorized users are redirected' do
    sign_in_as(user)
    visit admin_users_path

    expect(page).to have_content('not authorized')
    expect(current_path).to eq(root_path)
  end
end
