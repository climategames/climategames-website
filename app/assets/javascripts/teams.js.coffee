jQuery ->
  # Lock the fields of a form that require a password
  $('#locked').attr 'disabled', 'disabled'

  # Unlock the form if a password is entered
  $('#team_password').on 'keyup', (e) ->
    if $(e.currentTarget).val().length > 0
      $('#locked').attr 'disabled', null
    else
      $('#locked').attr 'disabled', 'disabled'
