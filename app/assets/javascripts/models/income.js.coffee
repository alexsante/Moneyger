class Moneyger.Models.Income extends Backbone.Model
  url: '/incomes'

  initialize: ->
    @incomeValues = new Moneyger.Collections.IncomeValues

  parse_incomeValues: ->
    for iv in this.get("income_values")
      @incomeValues.add(iv,{silent: true})