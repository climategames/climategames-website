class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.integer :team_id
      t.string :title
      t.datetime :date_time
      t.text :description
    end
  end
end
