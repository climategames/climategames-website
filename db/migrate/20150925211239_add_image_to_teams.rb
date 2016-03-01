class AddImageToTeams < ActiveRecord::Migration
  def change
    add_attachment :teams, :image
  end
end
