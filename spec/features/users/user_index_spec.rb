require 'rails_helper'

include Warden::Test::Helpers
Warden.test_mode!

# Feature: User index page
#   As a user
#   I want to see a list of users
#   So I can see who has registered
feature 'User index page', :devise do

  after(:each) do
    Warden.test_reset!
  end

  # Scenario: User (with role Admin) listed on index page
  #   Given I am signed in
  #   When I visit the user index page
  #   Then I see my own email address
  scenario 'admin user sees own email address' do
    user = FactoryBot.create(:user, role: :admin)
    login_as(user, scope: :user)
    visit users_path
    expect(page).to have_content user.email
  end

  # Scenario: User (with role User) listed on index page
  #   Given I am signed in
  #   When I visit the user index page
  #   Then I see an Access Denied message
  scenario 'user sees access denied message' do
    user = FactoryBot.create(:user)
    login_as(user, scope: :user)
    visit users_path
    expect(page).to have_content 'Access denied.'
  end

end
