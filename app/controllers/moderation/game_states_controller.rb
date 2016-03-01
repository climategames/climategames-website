class Moderation::GameStatesController < Moderation::ModerationController
  layout "data"

  def index
    @game_states = GameState.all.order(:created_at)
    @attributes = GameState.column_names - ["id", "created_at"]
  end
end
