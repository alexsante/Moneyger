class Moneyger.Models.ExpenseValue extends Backbone.Model
  url: '/expense_values'

  initialize: ->
    @variable_expenses = new Moneyger.Collections.VariableExpenses

  parse_variableExpenses: =>
    for ve in this.get("variable_expenses")
      @variable_expenses.add(ve, {silent: true})

  variable_expense_total: =>
    total = 0
    @variable_expenses.each (ve) ->
      total += Number(ve.get("amount"))
    total

