require 'rails_helper'

feature 'admin deletes user', %{
  As an administrator of Date Bites
  I want to delete a registered user
  So that I can remove trolls from the site.
} do

  # Acceptance Criteria:
  # [X] I must be logged in as an admin; if I am not, I receive an error and then
  # redirected to the home page
  # [X] I can delete a user by visiting admin/users and clicking on a delete
  # link next to the entry associated to the user
  # [X] I receive a confirmation when a user has been deleted
  # [X] After deleting a user, I am redirected to the admin/users page

  let!(:admin) { FactoryGirl.create(:user, role: 'admin') }
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'admin deletes users' do
    sign_in_as(admin)
    visit admin_users_path

    page.click_link("Delete", href: "/admin/users/#{user.id}")

    expect(page).to have_content("Successfully deleted #{user.username}!")
    expect(page).to_not have_content(user.email)
  end

  scenario 'unauthorized users are redirected' do
    sign_in_as(user)
    visit admin_users_path

    expect(page).to have_content('not authorized')
    expect(current_path).to eq(root_path)
  end
end
