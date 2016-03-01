class CreateGameStates < ActiveRecord::Migration
  def change
    create_table :game_states do |t|
      t.integer :teams
      t.integer :teams_with_reports
      t.integer :reports_all
      t.integer :reports_pending
      t.integer :reports_approved
      t.integer :reports_rejected
      t.integer :moderators
      t.integer :enabled_moderators
      t.integer :caped_moderators

      t.datetime :created_at, null: false
    end
  end
end
