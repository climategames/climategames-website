class CreateGameRounds < ActiveRecord::Migration
  def up
    create_table :game_rounds do |t|
      t.string :name, null: false
      t.datetime :starts_at, null: false
      t.datetime :ends_at, null: false

      t.timestamps null: false
    end
  end

  def down
    drop_table :game_rounds
  end
end
