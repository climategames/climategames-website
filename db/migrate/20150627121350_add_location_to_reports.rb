class AddLocationToReports < ActiveRecord::Migration
  def change
    add_column :reports, :location, :string
  end
end
