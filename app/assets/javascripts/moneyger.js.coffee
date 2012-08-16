window.Moneyger =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    @mainRouter = new Moneyger.Routers.Budgets
    Backbone.history.start()

  recalculate_periods: =>
    this.mainRouter.recalculate_periods()

$(document).ready ->
  Moneyger.init()
