window.Moneyger =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Moneyger.Routers.Budgets
    Backbone.history.start()

  recalculate_periods: ->
    router = new Moneyger.Routers.Budgets
    router.recalculate_periods()

$(document).ready ->
  Moneyger.init()
