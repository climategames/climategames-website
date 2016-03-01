class Api::V1::ReportsController < Api::V1::ApplicationController
  def index
    @reports = Report.includes(:pictures).approved.order id: :desc

    if params[:category]
      allowed_categories = Report::CATEGORIES.map { |category| category[1] }
      head :bad_request and return unless allowed_categories.include? params[:category]
      @reports = @reports.where category: params[:category]
    end

    if params[:team_id]
      team = Team.find params[:team_id]
      @reports = @reports.with_team team.id
    end

    if params[:award_id]
      award = Award.find params[:award_id]
      @reports = @reports.with_award award.id
    end

    if @reports.any?
      @teams = Team.where id: @reports.map(&:team_id).uniq!
    else
      @teams = []
    end
  end
end
