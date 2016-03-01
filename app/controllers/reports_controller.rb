class ReportsController < ApplicationController
  include ActionView::Helpers::TextHelper

  skip_before_filter :verify_authenticity_token
  before_filter :suspend_when_applicable
  before_filter :render_maintenance_when_enabled, except: [:index, :show]
  before_filter :redirect_when_games_ended, except: [:index, :show]

  def index
    @reports = Report.approved.order('id DESC')
    @teams = Team.with_approved_reports.alphabetical
    @awards = Award.with_approved_reports
    @body_class = "map"
  end

  def show
    @report = Report.approved.find params[:id]
  end

  def new
    @report = Report.new category: Report::CATEGORIES[0][1], date_time: Time.now
  end

  def create
    @report = Report.new report_attrs
    if @report.save
      redirect_to "/#{params[:locale]}#{thanks_path}"
    else
      render :new
    end
  end

  private

  def suspend_when_applicable
    if ENV['suspend_game_map'] == "1"
      @reports = []
      render :suspended
    end
  end

  def render_maintenance_when_enabled
    if ENV['enable_maintenance'].to_i == 1
      render text: I18n.t('cg.copy.reports.maintenance'), status: :service_unavailable
    end
  end

  def redirect_when_games_ended
    if view_context.games_ended?
      redirect_to "/#{params[:locale]}/games-ended"
    end
  end

  def report_attrs
    params.
      require(:report).
      permit(:category,
             :title,
             :date_time,
             :location,
             :latitude,
             :longitude,
             :image,
             :description,
             :team_id,
             :password,
             award_ids: [],
             pictures_attributes: [:id, :image, :_destroy],
             links_attributes: [:id, :url, :_destroy])
  end
end
