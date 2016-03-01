class Moderation::LocalesController < Moderation::ModerationController
  before_filter :set_locale

  def index
    redirect_to "/#{I18n.locale.to_s}/moderation/dashboard"
  end

  private
    def set_locale
      I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    end
end
