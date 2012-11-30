class Moneyger.Models.Expense extends Backbone.Model

class Moneyger.Collections.ExpenseCollection extends Backbone.Collection
	model: Moneyger.Models.Expense
	url: "/expenses"