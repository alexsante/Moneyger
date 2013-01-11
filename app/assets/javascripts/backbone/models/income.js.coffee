class Moneyger.Models.Income extends Backbone.Model
	url: "/incomes"

	mutators:
		formattedAmount: () ->
			return formatCurrency(this.amount)

class Moneyger.Collections.IncomeCollection extends Backbone.Collection
	model: Moneyger.Models.Income
	url: "/incomes"