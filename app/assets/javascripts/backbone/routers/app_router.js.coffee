class Moneyger.Routers.AppRouter extends Backbone.Router

	initialize: ->
		# Income Collection & Views
		@income_collection = new Moneyger.Collections.IncomeCollection
		@income_view = new Moneyger.Views.IncomeView model: @income_collection

		# Expense Collection & Views
		@expense_collection = new Moneyger.Collections.ExpenseCollection
		@expense_view = new Moneyger.Views.ExpenseView model: @expense_collection

	routes:
    	"": "index"
    	"incomes/:id/edit": "edit_income"
    	"expenses/:id/edit": "edit_expense"

	
  	index: ->
  		@income_collection.fetch()
  		@expense_collection.fetch()

  	edit_income: (id) ->
  		@income_view.renderEditIncome(id)

  	edit_expense: (id) ->
  		@expense_view.renderEditExpense(id)
  		
	    