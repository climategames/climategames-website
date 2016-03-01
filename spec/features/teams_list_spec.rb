require 'rails_helper'

RSpec.feature "Ordering of the list of teams" do
  class SpecTeam
    attr_reader :name, :secret, :avatar, :description
    def initialize(name, secret, avatar, description)
      @name = name
      @secret = secret
      @avatar = avatar
      @description = description
    end
  end

  scenario "for the english language" do
    team_no_avatar_no_description_1   = SpecTeam.new("Giraffes_0_0",  "ilovenature", false, false)
    team_no_avatar_yes_description_1  = SpecTeam.new("Elephants_0_1", "ilovenature", false, true)
    team_yes_avatar_no_description_1  = SpecTeam.new("Dingos_1_0",    "ilovenature", true,  false)
    team_yes_avatar_yes_description_1 = SpecTeam.new("Aardvarks_1_1", "ilovenature", true,  true)
    team_yes_avatar_yes_description_2 = SpecTeam.new("Badgers_1_1",   "ilovenature", true,  true)
    team_yes_avatar_no_description_2  = SpecTeam.new("Caribous_1_0",  "ilovenature", true,  false)
    team_no_avatar_yes_description_2  = SpecTeam.new("Flamingos_0_1", "ilovenature", false, true)
    team_no_avatar_no_description_2   = SpecTeam.new("Hyenas_0_0",    "ilovenature", false, false)

    [ team_no_avatar_no_description_1,
      team_no_avatar_yes_description_1,
      team_yes_avatar_no_description_1,
      team_yes_avatar_yes_description_1,
      team_yes_avatar_yes_description_2,
      team_yes_avatar_no_description_2,
      team_no_avatar_yes_description_2,
      team_no_avatar_no_description_2].each { |t| sign_up_team(t) }

    visit '/en/teams'
    teams = names_of_teams_on_page

    expect(teams).to eq ["Aardvarks_1_1", "Badgers_1_1", "Dingos_1_0", "Caribous_1_0", "Elephants_0_1", "Flamingos_0_1", "Giraffes_0_0", "Hyenas_0_0"]

  end

  def sign_up_team(team)
    visit "/en/teams/new"
    fill_in 'Team name', with: team.name
    fill_in 'Shared team password', with: team.secret
    fill_in 'Confirm shared password', with: team.secret
    click_button 'Create Team'
    if team.avatar || team.description
      click_link("Edit team profile")
      fill_in 'Shared team password', with: team.secret
      if team.description
        fill_in 'Team nature', with: team.name + " nature"
      end
      if team.avatar
        attach_file('Avatar', Rails.root.join('app', 'assets', 'images', 'bloodcell-backdrop.jpeg'))
      end
      click_button 'Update Team'
    end
  end

  def names_of_teams_on_page
    page.document.find_all(".team h1 a").map { |e| e.text }
  end
end
