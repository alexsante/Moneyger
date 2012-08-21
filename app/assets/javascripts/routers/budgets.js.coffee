class Moneyger.Routers.Budgets extends Backbone.Router

    initialize: ->
      # Budget collection (includes income and expenses plus their associations)
      @budget = new Moneyger.Collections.Budgets
      @income_collection = @budget.incomes
      @expense_collection = @budget.expenses

      # Period Collection
      @periods_collection = new Moneyger.Collections.Periods()
      @periods_collection.fetch()

    ##############################################
    # ROUTE DEFINITION                           #
    ##############################################
    routes:
      "new_income": "new_income"
      "new_expense": "new_expense"
      "edit_income/:id": "edit_income"
      "edit_expense/:id": "edit_expense"
      "delete_income/:id": "delete_income"
      "delete_expense/:id": "delete_expense"

    ##############################################
    # INCOME CRUD                                #
    ##############################################
    #TODO: Refactor code and make it DRY
    new_income: ->
      incomeView = new Moneyger.Views.IncomesIndex collection: @income_collection
      incomeView.render_newForm()
      @recalculate_periods()

    edit_income: (id) ->
      incomeView = new Moneyger.Views.IncomesIndex collection: @income_collection
      incomeView.render_editForm(id)

    delete_income: (id) ->
      # TODO: DELETE() method in the income view needs to be implemented
      incomeView = new Moneyger.Views.IncomesIndex collection: @income_collection
      incomeView.delete(id)

    save_income: (event) ->
      incomeView = new Moneyger.Views.IncomesIndex collection: @income_collection
      if $(event).attr("id") is "btn_save_income"
        incomeView.create()
      else
        incomeView.update($(event).attr("income_id"))

    ##############################################
    # INCOME VALUE CRUD                          #
    ##############################################
    edit_incomevalue: (id) ->
      incomeValueView = new Moneyger.Views.IncomeValuesIndex
      incomeValueView.render_editForm(id)

    ##############################################
    # EXPENSE CRUD                               #
    ##############################################
    #TODO: Refactor code and make it DRY
    new_expense: (type) ->
      expenseView = new Moneyger.Views.ExpenseIndex collection: @expense_collection
      expenseView.render_newForm(type)

    edit_expense: (id) ->
      expenseView = new Moneyger.Views.ExpenseIndex collection: @expense_collection
      expenseView.render_editForm(id)

    delete_expense: (id) ->
      expenseView = new Moneyger.Views.ExpenseIndex collection: @expense_collection
      expenseView.delete(id)

    save_expense: (event) ->
      expenseView = new Moneyger.Views.ExpenseIndex collection: @expense_collection
      if $(event).attr("id") is "btn_save_expense"
        expenseView.create()
      else
        expenseView.update($(event).attr("expense_id"))

    ##############################################
    # HELPER METHODS                             #
    ##############################################
    recalculate_periods: =>
      @periods_collection.fetch
        success: (model, response) ->
          for period in response
            $("td#balance_#{period.id}").html(formatCurrency(period.beginning_balance))
            if period.beginning_balance > 0
              $("td#balance_#{period.id}").removeClass("negative-balance")
            else
              $("td#balance_#{period.id}").addClass("negative-balance")

            $("td#remaining_balance_#{period.id}").html(formatCurrency(period.ending_balance))
            $("td#income_total_#{period.id}").html(formatCurrency(period.income_total))
            $("td#fixed_expense_total_cell_#{period.id}").html(formatCurrency(period.fixed_expense_total))
            $("td#fixed_expense_aw_total_cell_#{period.id}").html(formatCurrency(period.fixed_aw_expense_total))