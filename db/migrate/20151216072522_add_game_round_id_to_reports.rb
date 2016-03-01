class AddGameRoundIdToReports < ActiveRecord::Migration
  def change
    add_reference :reports, :game_round, index: true
    add_foreign_key :reports, :game_rounds
  end
end
