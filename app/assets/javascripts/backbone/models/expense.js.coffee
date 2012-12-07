class Moneyger.Models.Expense extends Backbone.Model
	url: "/expenses"

	initialize: ->
		@formatAttributes()
		this.bind("change", @handleOnChange, this)
		this.bind("sync", @handleOnSync, this)

	handleOnChange: (model, event) ->
		formatAttributes()
		console.log("change event has been fired", model, event)

	handleOnSync: (model, event) ->
		console.log("sync event has been fired", model, event)

	formatAttributes: ->
		# Formats the amount to standard USD currency format
		this.set "amount", formatCurrency(this.get "amount")
		

class Moneyger.Collections.ExpenseCollection extends Backbone.Collection
	model: Moneyger.Models.Expense
	url: "/expenses"