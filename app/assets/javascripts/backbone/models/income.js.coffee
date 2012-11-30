class Moneyger.Models.Income extends Backbone.Model

class Moneyger.Collections.IncomeCollection extends Backbone.Collection
	model: Moneyger.Models.Income
	url: "/incomes"