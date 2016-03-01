class Team < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :password_digest, null: false

      t.timestamps null: false
    end

    add_index(:teams, :name, unique: true)
  end
end
