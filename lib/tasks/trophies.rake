require 'securerandom'

class Cop21Trophies
  def self.with_award(name)
    award = Award.all.select { |a| a.name == name }.first
    raise "Award with name #{name} not found" unless award
    yield(award)
  end

  def self.team_with_name(name)
    puts name
    Team.where(name: name).first || raise("Could not find Team with name \"#{name}\"")
  end

  def self.create_team(name)
    password = ENV['password'] || SecureRandom.hex(16)
    Team.create!(name: name, password: password, password_confirmation: password)
  end

  def self.create_teams
    tfa = create_team("Tools for Action")
    tfa.reports << Report.find(376)

    create_team("Assigné-e-s à résistance")

    tas = create_team("L'état d'urgence pour faire oublier les tas d'urgence")
    tas.reports << Report.find(246)

    zad = create_team("ZAD convergence")
    zad.reports << Report.find(146)

    create_team("#RedLines")
    create_team("EVERYBODY who is NOT going to stop resisting until we have climate justice")
  end

  def self.import
    game_round = GameRound.where(name: "COP21").first!
    GameRound.transaction do
      with_award("The Best Team Name Medal") do |award|
        Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name("Team Dikke Tammo"))
        Trophy.create!(award: award, game_round: game_round, rank: "runner_up", team: team_with_name("We Can Can"))
      end

      with_award("The Hive Mind Award") do |award|
        Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name("Fred False"))
        Trophy.create!(award: award, game_round: game_round, rank: "mention", team: team_with_name("Collectif de Lutte Impliqué dans les Mouvements et les Actions pour la Terre (C.L.I.M.A.T)"))
      end

      with_award("The Award for Ultimate Unexpectedness") do |award|
        Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name("cultural hijack"))
        Trophy.create!(award: award, game_round: game_round, rank: "runner_up", team: team_with_name("Green Crashers"))
        Trophy.create!(award: award, game_round: game_round, rank: "mention", team: team_with_name("Cooperide"))
      end

      with_award("The Courage Is Contagious Cup") do |award|
        Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name("Christian Climate Action"))
        Trophy.create!(award: award, game_round: game_round, rank: "runner_up", team: team_with_name("Family Activist Network"))
      end

      with_award("The Pissed Myself Cup") do |award|
        Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name("E.Z.L.N - Ensemble Zoologique de Libération de la Nature"))
        Trophy.create!(award: award, game_round: game_round, rank: "runner_up", team: team_with_name("Toilet interventionists"))
      end

      with_award("The Most Effective Action Award") do |award|
        Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name("Upton Community Protection Camp"))
        Trophy.create!(award: award, game_round: game_round, rank: "runner_up", team: team_with_name("Irgendwas mit Eisbären (Ende Gelände)"))
        Trophy.create!(award: award, game_round: game_round, rank: "runner_up", team: team_with_name("Coal Games (Ende Gelände!)"))
        Trophy.create!(award: award, game_round: game_round, rank: "runner_up", team: team_with_name("ausgeCO2hlt"))
        Trophy.create!(award: award, game_round: game_round, rank: "mention", team: team_with_name("Plane Stupid"))
      end

      with_award("The Future Now Prize") do |award|
        Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name("T'es rien sans permis ! (Licenseless Earthlings)"))
        Trophy.create!(award: award, game_round: game_round, rank: "runner_up", team: team_with_name("Boquila trifoliolata"))
        # Trophy.create!(award: award, game_round: game_round, rank: "runner_up", team: team_with_name("CycloClimatique"))
      end

      with_award("The Solidarity and Symbiosis Award") do |award|
        Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name("Undercooking The Establishment"))
        Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name("Ourcq-Blanche : The Melting Shelters"))
        Trophy.create!(award: award, game_round: game_round, rank: "mention", team: team_with_name("Rhythms of Resistance"))
      end

      with_award("The Invisibility Cloak") do |award|
        Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name("Assigné-e-s à résistance"))
        Trophy.create!(award: award, game_round: game_round, rank: "runner_up", team: team_with_name("L'état d'urgence pour faire oublier les tas d'urgence"))
      end

      with_award("The Big Splash Cup") do |award|
        Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name("Brandalism"))
        Trophy.create!(award: award, game_round: game_round, rank: "runner_up", team: team_with_name("Fossil Free Culture"))
      end

      with_award("The Insurrectionary Innovation Badge") do |award|
        Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name("Tools for Action"))
        Trophy.create!(award: award, game_round: game_round, rank: "runner_up", team: team_with_name("Software Malfunction"))
      end

      with_award("The Cup for Best Crowd Choreography") do |award|
        Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name("ZAD convergence"))
        Trophy.create!(award: award, game_round: game_round, rank: "runner_up", team: team_with_name("Clown Of the Parties : COP 21st century...and more (CIRCA)"))
      end

      with_award("The Electronic Disobedience Medal") do |award|
        # report?? team?? @AnonyPress for hacking UNFCCC
        # ??? Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name(""))
        Trophy.create!(award: award, game_round: game_round, rank: "runner_up", team: team_with_name("Les Lobbyvores"))
      end

      with_award("The Plan B Badge for Spontaneity") do |award|
        Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name("#RedLines"))
      end

      with_award("The Carry On Resisting Trophy") do |award|
        Trophy.create!(award: award, game_round: game_round, rank: "winner", team: team_with_name("EVERYBODY who is NOT going to stop resisting until we have climate justice"))
      end

      Award.find(8).report_awards.destroy_all
    end
  end
end

namespace :trophies do
  desc 'Setup teams with trophies for COP21'
  task setup_teams_cop21: :environment do
    Cop21Trophies.create_teams
  end

  desc 'Create trophies for COP21'
  task create_cop21: :environment do
    Cop21Trophies.import
  end

  desc 'Delete trophies for COP21'
  task delete_cop21: :environment do
    Trophy.where(game_round: GameRound.where(name: "COP21").first!).destroy_all
  end
end
