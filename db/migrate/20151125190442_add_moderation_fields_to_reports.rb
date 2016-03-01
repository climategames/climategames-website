class AddModerationFieldsToReports < ActiveRecord::Migration
  def set_outcome_to_approved_for_reports_that_are_approved
    Report.connection.update_sql("UPDATE reports SET moderation_outcome='approved' WHERE approved = true")
  end

  def set_boolean_to_approved_for_reports_that_are_approved
    Report.connection.update_sql("UPDATE reports SET approved=true WHERE moderation_outcome = 'approved'")
  end

  def up
    add_column :reports, :current_moderator_id, :integer
    add_column :reports, :checked_at, :datetime
    add_column :reports, :moderation_outcome, :string
    add_column :reports, :internal_memo, :text
    set_outcome_to_approved_for_reports_that_are_approved
    remove_column :reports, :approved
  end

  def down
    add_column :reports, :approved, :boolean
    set_boolean_to_approved_for_reports_that_are_approved
    remove_column :reports, :internal_memo
    remove_column :reports, :moderation_outcome
    remove_column :reports, :checked_at
    remove_column :reports, :current_moderator_id
  end
end
