class Moneyger.Collections.Expenses extends Backbone.Collection
  url: '/expenses'
  model: Moneyger.Models.Expense

  initialize: ->
    this.bind("add", Moneyger.recalculate_periods, this)
