class Moneyger.Routers.Budgets extends Backbone.Router

    initialize: ->
      @periods_collection = new Moneyger.Collections.Periods()
      @view = new Moneyger.Views.BudgetsIndex()

    routes:
      "new_income": "new_income"

    new_income: ->
      @view.render_newIncome()
      @recalculate_periods()

    save_income: ->
      @view.create_income()

    recalculate_periods: ->
      @periods_collection.fetch
        success: (model, response) ->
          for period in response
            $("td#balance_#{period.id}").html(formatCurrency(period.beginning_balance))
            $("td#remaining_balance_#{period.id}").html(formatCurrency(period.remaining_balance))
            $("td#income_total_#{period.id}").html(formatCurrency(period.income_total))
            $("td#fixed_expense_total_cell_#{period.id}").html(formatCurrency(period.fixed_expense_total))
            $("td#fixed_expense_aw_total_cell_#{period.id}").html(formatCurrency(period.fixed_aw_expense_total))
