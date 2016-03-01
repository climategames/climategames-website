class TeamsController < ApplicationController
  before_filter :render_maintenance_when_enabled, except: [:index, :show]
  before_filter :redirect_when_games_ended, except: [:index, :show]

  def index
    # Ordering:
    # 1) teams with avatar and nature
    # 2) teams with avatar (nature null or empty)
    # 3) teams without avatar, with nature
    # 4) teams without avatar or nature
    # After these criteria teams are sorted by creation date, earliest first
    @teams = Team.order('(image_file_name is NULL) ASC, (CASE WHEN nature = "" THEN 2 WHEN nature is NULL THEN 2 ELSE 1 END) ASC, created_at').paginate(page: params[:page], per_page: 10)
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new team_attrs

    if @team.save
      redirect_to "/#{params[:locale]}#{teams_path}/#{@team.id}"
    else
      render action: 'new'
    end
  end

  def show
    @team = Team.find params[:id]
  end

  def edit
    @team = Team.find params[:id]
  end

  def update
    @team = Team.find params[:id]

    if @team.authenticate(team_attrs[:password]) && @team.update(team_attrs)
      redirect_to "/#{params[:locale]}#{teams_path}/#{@team.id}"
    else
      @team.errors.add :password, I18n.t('cg.teams.secret_word_incorrect')
      render action: 'edit'
    end
  end

  private

  def render_maintenance_when_enabled
    if ENV['enable_maintenance'].to_i == 1
      render text: I18n.t('cg.copy.teams.maintenance'), status: :service_unavailable
    end
  end

  def redirect_when_games_ended
    if view_context.games_ended?
      redirect_to "/#{params[:locale]}/games-ended"
    end
  end

  def team_attrs
    params.require(:team).permit(:name, :nature, :image, :password, :password_confirmation)
  end
end
