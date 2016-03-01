#######
#
# This file will be run on every deploy, so make sure the changes here are non-destructive
#
#######

module GameRoundSeeds
  def self.seed_all
    cop21 = GameRound.where(name: "COP21").first
    unless cop21
      cop21 = GameRound.create(name: "COP21", starts_at: Date.new(2015,11,30), ends_at: Date.new(2015,12,13))
    end

    # To ensure all reports belong to a game round, those who aren't assigned
    # one are set to belong to COP21
    Report.where(game_round_id: nil).each do |report|
      report.update_attributes!(game_round: cop21)
    end
  end
end

GameRoundSeeds.seed_all
