class Moneyger.Routers.Budgets extends Backbone.Router

    initialize: ->
      @budgetModal = new Moneyger.Models.Budget
      @budgetModal.fetch()
      @periods_collection = new Moneyger.Collections.Periods()
      @periods_collection.fetch()
      @view = new Moneyger.Views.BudgetsIndex()
      @incomeView = new Moneyger.Views.IncomesIndex()
      console.log(@budgetModal)
    routes:
      "new_income": "new_income"

    new_income: ->
      @incomeView.render_newIncome()
      @recalculate_periods()

    save_income: ->
      @incomeView.create_income()

    recalculate_periods: ->
      @periods_collection.fetch
        success: (model, response) ->
          for period in response
            $("td#balance_#{period.id}").html(formatCurrency(period.beginning_balance))
            $("td#remaining_balance_#{period.id}").html(formatCurrency(period.remaining_balance))
            $("td#income_total_#{period.id}").html(formatCurrency(period.income_total))
            $("td#fixed_expense_total_cell_#{period.id}").html(formatCurrency(period.fixed_expense_total))
            $("td#fixed_expense_aw_total_cell_#{period.id}").html(formatCurrency(period.fixed_aw_expense_total))
