class CreateReportAwards < ActiveRecord::Migration
  def change
    create_table :report_awards do |t|
      t.references :report
      t.references :award
      t.integer :count
      t.timestamps
    end
  end
end
