class Moneyger.Models.Expense extends Backbone.Model
  url: '/expenses'

  methodUrl: {
    "delete": "/expenses/:id"
  }

  initialize: ->
    @expenseValues = new Moneyger.Collections.ExpenseValues

  parse_expenseValues: ->
    for ev in this.get("expense_values")
      # Create a new model in the collection
      @expenseValues.add(ev,{silent: true})

      # Extract it so variable expenses can be parsed
      evModel = @expenseValues.get(ev.id);
      evModel.parse_variableExpenses()
