class Moderation::ModeratorsController < Moderation::ModerationController
  skip_before_filter :ensure_moderator_logged_in, only: [:new, :create]
  skip_before_filter :ensure_moderator_enabled, only: [:new, :create]
  before_filter :ensure_moderator_has_super_cape, except: [:new, :create]

  def new
    @moderator = Moderator.new
  end

  def create
    @moderator = Moderator.new(moderator_attrs)
    if @moderator.save
      session[:moderator_id] = @moderator.id
      redirect_to moderation_dashboard_path(locale: locale.to_s), notice: I18n::t("moderation.signed_up_success")
    else
      flash[:alert] = I18n::t('moderation.form_invalid')
      render :new
    end
  end

  def index
    @moderators = Moderator.all.order(:username)
  end

  def edit
    @moderator = Moderator.find(params[:id])
  end

  def update
    @moderator = Moderator.find(params[:id])
    @moderator.update_attributes(moderator_super_cape_attrs)
    redirect_to moderation_moderators_path(locale: locale.to_s), notice: I18n::t("moderation.successfully_updated_moderator", username: @moderator.username)
  end

  private

  def moderator_attrs
    params.require(:moderator).permit(:username, :password, :password_confirmation)
  end

  def moderator_super_cape_attrs
    params.require(:moderator).permit(:password, :password_confirmation, :enabled, :super_cape)
  end
end
