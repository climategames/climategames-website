require 'digest'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :authenticate

  before_action :set_locale

  def set_locale
    logger.debug "Locale: #{params[:locale]}"
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # def default_url_options(options = {})
  #   { locale: I18n.locale }.merge options
  # end

  protected

  def authenticate
    return if params[:controller] == "splash"
    return if (Rails.env.development? && !ENV["HTTP_AUTH_IN_DEVELOPMENT"]) || Rails.env.test?
    if defined?(page) && page.present? && !page.password_protected
      return
    end
    path = request.params[:path]
    if path =~ /^fonts\//
      return
    end
    authenticate_or_request_with_http_basic do |username, password|
      # uncomment and set your own password to allow protected pages to require
      # http login
      # username == "climategames" && Digest::SHA2.hexdigest(password) == "6dcc0d196ef96ff78cbaa6b32bdc56fbbf40b3d02f715415c02777e0d3cd1ea0"
    end
  end
end
