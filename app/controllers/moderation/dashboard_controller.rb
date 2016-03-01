class Moderation::DashboardController < Moderation::ModerationController
  skip_before_filter :ensure_moderator_enabled, only: [:show]

  def show
    unless current_moderator.enabled
      render :not_enabled
    end

    @game_state = GameState.current

    @rows = []
    @rows << [I18n.t('moderation.teams'), @game_state.teams]
    @rows << ["- " + I18n.t('moderation.teams_with_reports'), @game_state.teams_with_reports]
    @rows << [I18n.t('moderation.reports_all'), @game_state.reports_all]
    @rows << ["- " + I18n.t('moderation.reports_pending'), @game_state.reports_pending]
    @rows << ["- " + I18n.t('moderation.reports_approved'), @game_state.reports_approved]
    @rows << ["- - " + I18n.t('moderation.intel_reports_approved'), @game_state.intel_reports_approved]
    @rows << ["- - " + I18n.t('moderation.adventure_reports_approved'), @game_state.adventure_reports_approved]

    @rows << ["- " + I18n.t('moderation.reports_rejected'), @game_state.reports_rejected]

    if current_moderator.super_cape
      @rows << [I18n.t('moderation.moderators'), @game_state.moderators]
      @rows << ["- " + I18n.t('moderation.moderators_enabled'), @game_state.enabled_moderators]
      @rows << ["- " + I18n.t('moderation.moderators_super_cape'), @game_state.caped_moderators]
    else
      @rows << [I18n.t('moderation.moderators'), @game_state.enabled_moderators]
    end
  end
end
