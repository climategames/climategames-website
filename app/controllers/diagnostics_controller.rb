class DiagnosticsController < ApplicationController
  def authenticate
    return
  end

  def git_sha
    filename = Rails.root.join("REVISION")
    if File.exist?(filename)
      render :text => File.open(filename).read.strip.to_s
    else
      render :text => "[none]"
    end
  end

  def env
    keys = ["enable_cookies", "disable_game_map", "enable_maintenance", "enable_games_ended"]
    render :text => keys.map { |k| "%s=%s<br/>" % [k, ENV[k]] }.join
  end
end
