moderationUI =
  moderation_outcome_radio_buttons: []
  color_container: []

  reset_moderation_outcome_color: ->
    moderationUI.color_container.removeClass('red')
    moderationUI.color_container.removeClass('green')
    moderationUI.color_container.removeClass('yellow')

  update_moderation_outcome_color: ->
    moderation_outcome =
      $('input[name="report[moderation_outcome]"]:checked').val()
    moderationUI.reset_moderation_outcome_color()
    if moderation_outcome == 'pending'
      moderationUI.color_container.addClass('yellow')
    else if moderation_outcome == 'approved'
      moderationUI.color_container.addClass('green')
    else if moderation_outcome == 'rejected'
      moderationUI.color_container.addClass('red')

  setup_datatable: ->
    $('.data-table').DataTable( {
      "paging": false
      "info": false
      "searching": false
      "order": []
    })

  init: ->
    moderationUI.moderation_outcome_radio_buttons =
      $('.report_moderation_outcome.radio_buttons')
    moderationUI.color_container =
      $('.moderation-panel')
    moderationUI.update_moderation_outcome_color()
    moderationUI.moderation_outcome_radio_buttons.
      click(moderationUI.update_moderation_outcome_color)
    moderationUI.setup_datatable()

$().ready(moderationUI.init)
window.moderationUI = moderationUI
