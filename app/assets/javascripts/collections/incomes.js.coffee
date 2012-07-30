class Moneyger.Collections.Incomes extends Backbone.Collection
  url: '/incomes'
  model: Moneyger.Models.Income

  initialize: ->
    this.bind("add", Moneyger.recalculate_periods, this)
    this.bind("destroy", Moneyger.recalculate_periods, this)