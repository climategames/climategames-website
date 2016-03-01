module ApplicationHelper
  def current_path_for_locale(locale)
    "/#{locale}" + request.path.gsub("/#{I18n.locale.to_s}", '')
  end

 # allowing html in translations is bad practice, but the alternative is too
  # cumbersome. At least by fencing off the areas where it is allowed we can
  # keep it in check better
  def allow_html_in_key(key)
    return true if key =~ /^cg\.copy\.home\.steps/
    return true if key =~ /^cg\.copy\.teams\.index\.a_team_is_a_group/
    false
  end

  def games_ended?
    ENV['enable_games_ended'].to_i == 1
  end

  def t(key, options = {})
    res = super

    if allow_html_in_key(key)
      res = res.html_safe
    end

    # setting this to true will highlight text that comes from translations,
    # facilitating debugging translation issues and keeping track of progress
    # translating content on a page.
    if ENV["DEBUG_I18N"]
      res = "&#9783;".html_safe + res + "&#9782;".html_safe
    end

    res
  end
end
