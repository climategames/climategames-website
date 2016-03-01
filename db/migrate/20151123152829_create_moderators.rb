class CreateModerators < ActiveRecord::Migration
  def change
    create_table :moderators do |t|
      t.string :username
      t.string :password_digest
      t.boolean :enabled, default: false
      t.boolean :super_cape, default: false

      t.timestamps null: false
    end
  end
end
