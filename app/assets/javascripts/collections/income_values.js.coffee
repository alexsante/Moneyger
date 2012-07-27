class Moneyger.Collections.IncomeValues extends Backbone.Collection
  url: '/income_values'
  model: Moneyger.Models.IncomeValue

  initialize: ->
    this.bind("add", Moneyger.recalculate_periods, this)

