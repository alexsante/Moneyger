class Moneyger.Models.Expense extends Backbone.Model
	url: "/expenses"

	mutators:
		formattedAmount: () ->
			return formatCurrency(this.amount)
		

class Moneyger.Collections.ExpenseCollection extends Backbone.Collection
	model: Moneyger.Models.Expense
	url: "/expenses"