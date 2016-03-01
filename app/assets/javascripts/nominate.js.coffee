jQuery ->
  $('body').on 'click', '.nominate', (e) ->
    e.preventDefault()
    url = $(@).attr 'href'
    $(@).addClass 'btn-semi-transparent disabled'
    $.ajax
      url: url,
      type: 'PUT'
