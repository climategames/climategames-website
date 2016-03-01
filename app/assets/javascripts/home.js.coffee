jQuery ->
  onTrailerPage = ->
    $('#trailer-modal').length > 0

  onWrapupPage = ->
    $('#wrapup-modal').length > 0

  # If on the home page
  if onTrailerPage()
    $('#launch-trailer').on 'click', (e) ->
      e.preventDefault()

      # Open modal
      $('#trailer-modal').modal()

      # Automatically play player on modal open
      tplayer.play()

    $('#trailer-modal').on 'hide.bs.modal', ->
      # Stop player on manual modal close
      tplayer.stop()

    # Init player
    jwplayer.key = '4gVHb6YLGPN+fAQv2lAlnYkV8junOc194OCFsA=='
    tplayer = jwplayer 'player'

    # Get locale from body
    locale = $('body').attr 'data-locale'

    # Setup player
    tplayer.setup
      aspectratio: '16:9'
      cookies: false
      file: '/videos/trailer-' + locale + '.mp4'
      width: '100%'

    # Close modal on video completion
    tplayer.on 'complete', (e) ->
      $('#trailer-modal').modal 'hide'

  # If on the home page
  if onWrapupPage()
    $('#launch-wrapup-video').on 'click', (e) ->
      e.preventDefault()

      # Open modal
      $('#wrapup-modal').modal()

      # Automatically play player on modal open
      wplayer.play()

    $('#wrapup-modal').on 'hide.bs.modal', ->
      # Stop player on manual modal close
      wplayer.stop()

    # Init player
    jwplayer.key = '4gVHb6YLGPN+fAQv2lAlnYkV8junOc194OCFsA=='
    wplayer = jwplayer 'wrapup-player'

    # Get locale from body
    locale = $('body').attr 'data-locale'

    # Setup player
    wplayer.setup
      aspectratio: '16:9'
      cookies: false
      file: '/system/wrapup-' + locale + '.mp4'
      width: '100%'

    # Close modal on video completion
    wplayer.on 'complete', (e) ->
      $('#wrapup-modal').modal 'hide'
