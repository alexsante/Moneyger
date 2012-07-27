class Moneyger.Models.Expense extends Backbone.Model
  url: '/expenses'

  initialize: ->
    @expenseValues = new Moneyger.Collections.ExpenseValues

  parse_expenseValues: ->
    for ev in this.get("expense_values")
      @expenseValues.add(ev,{silent: true})