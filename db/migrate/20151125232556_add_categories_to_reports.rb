class AddCategoriesToReports < ActiveRecord::Migration
  def change
    add_column :reports, :category, :string
    Report.reset_column_information
    Report.all.each { |report| report.update_attribute :category, Report::CATEGORIES[1][1] }
  end
end
