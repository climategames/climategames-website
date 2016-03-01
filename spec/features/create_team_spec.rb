require 'rails_helper'

RSpec.feature "Create a team" do
  scenario "for the english language" do

    sign_up_team_with "Pooh bears", "ilovehoney"
    visit '/en/teams'
    expect(page).to have_content('Pooh bears')
  end

  def sign_up_team_with(name, secret)
    visit "/en/teams/new"
    fill_in 'Team name', with: name
    fill_in 'Shared team password', with: secret
    fill_in 'Confirm shared password', with: secret
    click_button 'Create Team'
  end
end
