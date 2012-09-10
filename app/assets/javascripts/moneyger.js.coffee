window.Moneyger =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    @mainRouter = new Moneyger.Routers.Budgets
    Backbone.history.start()

  recalculate_periods: =>
    Moneyger.mainRouter.recalculate_periods()

  clear_popovers: ->
    $(".popover").each( -> $(this).remove() )
    
  keyDown_handler: (event) ->

    # Escape key pressed
    if event.keyCode == 27
      Moneyger.clear_popovers()

$(document).ready ->
  Moneyger.init()
