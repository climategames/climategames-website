namespace :game_state do
  desc 'Store a snapshot of the current game state'
  task snapshot: :environment do
    GameState.current.save!
  end
end
