class AddReportCategoryGameState < ActiveRecord::Migration
  def change
    add_column :game_states, :adventure_reports_approved, :integer
    add_column :game_states, :intel_reports_approved, :integer
  end
end
