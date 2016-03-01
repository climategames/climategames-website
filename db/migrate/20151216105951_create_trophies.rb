class CreateTrophies < ActiveRecord::Migration
  def change
    create_table :trophies do |t|
      t.references :team, index: true
      t.references :game_round, index: true
      t.references :award, index: true
      t.string :rank

      t.timestamps null: false
    end
    add_foreign_key :trophies, :teams
    add_foreign_key :trophies, :game_rounds
    add_foreign_key :trophies, :awards
  end
end
