class Moderation::ModerationController < ApplicationController
  before_filter :ensure_moderator_logged_in
  before_filter :ensure_moderator_enabled
  before_filter :set_moderation_nav_items

  layout "moderation"

  private

  def current_moderator
    @current_moderator ||= Moderator.where(id: session[:moderator_id]).first if session[:moderator_id]
  end

  helper_method :current_moderator

  def ensure_moderator_logged_in
    unless current_moderator
      redirect_to moderation_login_path(locale: locale.to_s), alert: I18n::t("moderation.need_logged_in")
    end
  end

  def ensure_moderator_enabled
    unless current_moderator && current_moderator.enabled
      redirect_to moderation_dashboard_path(locale: locale.to_s), alert: I18n::t("moderation.need_enabling")
    end
  end

  def ensure_moderator_has_super_cape
    unless current_moderator && current_moderator.enabled && current_moderator.super_cape
      redirect_to moderation_dashboard_path(locale: locale.to_s)
    end
  end

  def set_moderation_nav_items
    @moderation_nav_items = []
    if current_moderator && current_moderator.enabled
      @moderation_nav_items << {
          name: I18n.t('moderation.dashboard'),
          link: moderation_dashboard_path(locale: locale.to_s),
          active: request.params[:controller] == "moderation/dashboard"
      }
      @moderation_nav_items << {
          name: I18n.t('moderation.reports_all'),
          link: moderation_reports_path(locale: locale.to_s),
          active: request.params[:controller] == "moderation/reports" && request.params[:outcome].blank?
      }
      @moderation_nav_items << {
          name: I18n.t('moderation.reports_pending'),
          link: moderation_reports_path(locale: locale.to_s, outcome: "pending"),
          active: request.params[:controller] == "moderation/reports" && request.params[:outcome] == "pending"
      }
      @moderation_nav_items << {
          name: I18n.t('moderation.reports_approved'),
          link: moderation_reports_path(locale: locale.to_s, outcome: "approved"),
          active: request.params[:controller] == "moderation/reports" && request.params[:outcome] == "approved"
      }
      @moderation_nav_items << {
          name: I18n.t('moderation.reports_rejected'),
          link: moderation_reports_path(locale: locale.to_s, outcome: "rejected"),
          active: request.params[:controller] == "moderation/reports" && request.params[:outcome] == "rejected"
      }
      @moderation_nav_items << {
          name: I18n.t('moderation.report_awards'),
          link: moderation_report_awards_path(locale: locale.to_s),
          active: request.params[:controller] == "moderation/report_awards"
      }
    end

    if current_moderator && current_moderator.super_cape
      @moderation_nav_items << {
        name: I18n.t('moderation.moderators'),
        link: moderation_moderators_path(locale: locale.to_s),
        active: request.params[:controller] == "moderation/moderators"
      }
      @moderation_nav_items << {
          name: I18n.t('moderation.game_states'),
          link: moderation_game_states_path(locale: locale.to_s),
          active: request.params[:controller] == "moderation/game_states"
      }
    end
  end
end
