# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$(".income_cell").editInPlace
		url: '/incomes/quick_update.js'
		success: (response) -> 
			response = $.parseJSON(response)
			$(this).html(formatCurrency(response.amount))
			Budget.fetch_periods response.income.budget_id