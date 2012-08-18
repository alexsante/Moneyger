window.Moneyger =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    @mainRouter = new Moneyger.Routers.Budgets
    Backbone.history.start()

$(document).ready ->
  Moneyger.init()
