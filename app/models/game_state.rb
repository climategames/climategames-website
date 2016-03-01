class GameState < ActiveRecord::Base
  def self.current
    new(teams: Team.count,
        teams_with_reports: Report.where('team_id IS NOT NULL').pluck(:team_id).uniq.size,
        reports_all: Report.count,
        reports_pending: Report.pending.count,
        reports_approved: Report.approved.count,
        reports_rejected: Report.rejected.count,
        adventure_reports_approved: Report.adventure.approved.count,
        intel_reports_approved: Report.intel.approved.count,
        moderators: Moderator.count,
        enabled_moderators: Moderator.enabled.count,
        caped_moderators: Moderator.super_cape.count)
  end
end
