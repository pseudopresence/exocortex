$ ->
  window.leave: ->
    confirm "This will take you to another site.\nAre you sure you want to go?"
  $(".bar").toggle(
    ->
      $(".foo").show()
    ,
    ->
      $(".foo").hide()
  )
