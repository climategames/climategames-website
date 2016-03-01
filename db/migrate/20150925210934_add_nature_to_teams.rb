class AddNatureToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :nature, :text
  end
end
