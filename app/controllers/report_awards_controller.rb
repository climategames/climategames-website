class ReportAwardsController < ApplicationController
  def update
    @report = Report.approved.find params[:report_id]
    @report_award = @report.report_awards.find_by_award_id params[:id]
    @report_award.increment! :count
    head :ok
  end
end
