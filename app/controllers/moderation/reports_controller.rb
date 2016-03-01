class Moderation::ReportsController < Moderation::ModerationController
  def index
    @reports = Report.includes(:team).order("id DESC").all
    if @outcome = params[:outcome]
      available_outcomes = %w{approved rejected pending}
      if available_outcomes.include? @outcome
        @reports = @reports.send(@outcome)
      else
        flash[:alert] = I18n::t("moderation.invalid_outcome", outcome: @outcome)
      end
    end
  end

  def edit
    @report = Report.find(params[:id])
    if @report.current_moderator && @report.current_moderator != current_moderator
      if current_moderator.super_cape?
        flash[:alert] = I18n::t("moderation.current_moderator_alert", username: @report.current_moderator.username)
      else
        redirect_to moderation_reports_path(locale: locale.to_s), alert: I18n::t("moderation.current_moderator_alert", username: @report.current_moderator.username)
        return
      end
    else
      @report.update_attributes(current_moderator: current_moderator)
    end
    @report.moderation_outcome = "pending" if @report.pending?
    @teams = Team.all.order('lower(name)')
  end

  def update
    @report = Report.find(params[:id])
    @report.update_from_moderation!(report_attrs)
    @report.destroy_pictures_with_id params[:image_ids_to_delete]
    redirect_to moderation_reports_path(outcome: "pending", locale: locale.to_s), notice: I18n::t("moderation.successfully_updated_report")
  end

  private

  def report_attrs
    params.
      require(:report).
      permit(:title,
             :team_id,
             :moderation_outcome,
             :internal_memo,
             :description,
             :date_time,
             :awards,
             :image,
             :category,
             :latitude,
             :longitude,
             :location,
             :delete_image,
             award_ids: [],
             links_attributes: [:id, :url, :_destroy],
             pictures_attributes: [:id, :image, :_destroy],
             )
  end
end
