# Be sure to restart your server when you modify this file.

if ENV['enable_cookies'] == "1"
  Rails.application.config.session_store :cookie_store, key: '_climate_games_session'
else
  Rails.application.config.session_store :disabled
end
