window.frontendLocale = ->
  if locale.firstChild.textContent == "en "
    "en"
  else
    "fr"
