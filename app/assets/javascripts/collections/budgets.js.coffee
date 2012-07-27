class Moneyger.Collections.Budgets extends Backbone.Collection
  url: '/budgets'
  model: Moneyger.Models.Budget

  initialize: =>
    @incomes = new Moneyger.Collections.Incomes
    @expenses = new Moneyger.Collections.Expenses
    this.fetch
      success: (collection, response) =>
        for income in response.incomes
          i = new Moneyger.Models.Income
          i.set(income)
          i.parse_incomeValues()
          @incomes.push(i, {silent: true})
        for expense in response.expenses
          e = new Moneyger.Models.Expense
          e.set(expense)
          e.parse_expenseValues()
          @expenses.push(e, {silent: true})

