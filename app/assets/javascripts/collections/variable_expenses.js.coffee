class Moneyger.Collections.VariableExpenses extends Backbone.Collection
  url: '/variable_expenses'
  model: Moneyger.Models.VariableExpense

  initialize: ->
    this.bind("add", Moneyger.recalculate_periods, this)