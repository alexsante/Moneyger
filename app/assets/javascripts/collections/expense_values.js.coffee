class Moneyger.Collections.ExpenseValues extends Backbone.Collection
  url: '/expense_values'
  model: Moneyger.Models.ExpenseValue

  initialize: ->
    this.bind("add", Moneyger.recalculate_periods, this)
