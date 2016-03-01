class Moderation::SessionsController < Moderation::ModerationController
  skip_before_filter :ensure_moderator_logged_in, only: [:new, :create, :destroy]
  skip_before_filter :ensure_moderator_enabled, only: [:new, :create, :destroy]

  def new
  end

  def create
    moderator = Moderator.where(username: params[:username]).first
    if moderator && moderator.authenticate(params[:password])
      session[:moderator_id] = moderator.id
      redirect_to moderation_dashboard_path(locale: locale.to_s), notice: I18n::t("moderation.session.logged_in")
    else
      flash[:alert] = I18n::t("moderation.session.login_fail")
      render "new"
    end
  end

  def destroy
    session[:moderator_id] = nil
    redirect_to moderation_login_path(locale: locale.to_s), notice: I18n::t("moderation.session.logged_out")
  end
end
