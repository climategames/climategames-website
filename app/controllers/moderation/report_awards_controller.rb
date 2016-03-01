class Moderation::ReportAwardsController < Moderation::ModerationController
  def index
    @report_awards = ReportAward.includes(:report, :award)
    @awards = Award.all
    @reports = Report.approved.all.order('id DESC')

    @counts_for = {}
    @awards.each { |a| @counts_for[a] = {} }

    @report_awards.each do |ra|
      @counts_for[ra.award][ra.report] = ra.count
    end
  end
end
